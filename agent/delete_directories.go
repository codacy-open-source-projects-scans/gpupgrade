// Copyright (c) 2017-2023 VMware, Inc. or its affiliates
// SPDX-License-Identifier: Apache-2.0

package agent

import (
	"context"
	"log"

	"github.com/greenplum-db/gpupgrade/idl"
	"github.com/greenplum-db/gpupgrade/step"
	"github.com/greenplum-db/gpupgrade/upgrade"
	"github.com/greenplum-db/gpupgrade/utils"
)

var DeleteDirectoriesFunc = upgrade.DeleteDirectories

func (s *Server) DeleteStateDirectory(ctx context.Context, in *idl.DeleteStateDirectoryRequest) (*idl.DeleteStateDirectoryReply, error) {
	log.Printf("starting %s", idl.Substep_delete_segment_statedirs)

	// pass an empty []string to avoid check for any pre-existing files,
	// this call might come in before any stateDir files are created
	err := DeleteDirectoriesFunc([]string{utils.GetStateDir()}, []string{}, step.DevNullStream)
	return &idl.DeleteStateDirectoryReply{}, err
}

func (s *Server) DeleteBackupDirectory(ctx context.Context, req *idl.DeleteBackupDirectoryRequest) (*idl.DeleteBackupDirectoryReply, error) {
	log.Printf("starting %s", idl.Substep_delete_backupdir)

	// pass an empty []string to avoid check for any pre-existing files,
	// this call might come in before any backup files are created
	err := DeleteDirectoriesFunc([]string{req.GetBackupDir()}, []string{}, step.DevNullStream)
	return &idl.DeleteBackupDirectoryReply{}, err
}

func (s *Server) DeleteDataDirectories(ctx context.Context, in *idl.DeleteDataDirectoriesRequest) (*idl.DeleteDataDirectoriesReply, error) {
	log.Printf("starting %s", idl.Substep_delete_target_cluster_datadirs)

	err := DeleteDirectoriesFunc(in.Datadirs, upgrade.PostgresFiles, step.DevNullStream)
	return &idl.DeleteDataDirectoriesReply{}, err
}

func (s *Server) DeleteTablespaceDirectories(ctx context.Context, in *idl.DeleteTablespaceRequest) (*idl.DeleteTablespaceReply, error) {
	log.Printf("starting %s", idl.Substep_delete_tablespaces)

	err := upgrade.DeleteTablespaceDirectories(step.DevNullStream, in.GetDirs())
	return &idl.DeleteTablespaceReply{}, err
}
