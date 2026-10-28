Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB51606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 09:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aQgCPowC
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLzva-0006sB-9L; Wed, 28 Oct 2026 05:26:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1xLzvW-0006rV-13
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 05:26:34 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1xLzvR-0006eh-Ks
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 05:26:33 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2e977109392so3942915ad.0
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 02:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793179588; x=1793784388; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=CkMbYpBli2SS8jt1QFY+f+uboqwvGK3ZAB9Oc/+IqV0=;
 b=aQgCPowCydo9RhkXyJCpALY9pHv1GOWjdCVXUTujJDvWax9sQhcLH/gH+YzVqKcnz5
 +7O16Q/+hZ6/iktTlJnQFbhtV28hATjF5O+xOc+ZO/WzPkEJACuPiy/JbNOudcgBK5UD
 jqQY82Q7PuYEZCpem9/ewt3RF7FaerLvKCxCgLWIkSWWPQli38kXh38FvP10FTQo2bxY
 CFv4T+5tJsz1eh942T+ILA0EaqGXqvfVoc8wUGIZ0+qmnzuffc2bsYmhgWKuCQLvpFCV
 0hkAKudOaTIliv9HgUk3pCbkYvgAuw7lPuXDd15hZLqupg7amcXtw+0njpcKF+Jo91Sr
 Mkyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793179588; x=1793784388;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CkMbYpBli2SS8jt1QFY+f+uboqwvGK3ZAB9Oc/+IqV0=;
 b=rqIhapvTevg1MkrjjHm+Kr6f8LUw5eHDxJ61fe755y07ZqyMgQh1AP2/brVmsdimc7
 3Ane3N5VYnR9i52rRtcRprSoFO74vJMooykIKER8BaV0HqDDPjf+tBVXFDlx5hBoQg11
 A0hADbc41jwB5QstV+aKTT1De1unfx5U3FMnmwMxQx1vWJx7O/TLBXyH1VT3qXN7/isC
 eOSyUQS54qj+0Fc4hQxNbHBUSuYPMzO3YVvWUtnVFkkb7L50hA5JKBn+KRXX+qA1ZYcB
 6tYRNM3b9OLHBYbEjg2X92/X842wIzyVGR6UGhdgIKSsWcc/stev1M7tf6/dIndfMqf/
 JHtA==
X-Gm-Message-State: AFq9FYIRFr5dx+pPe6J7acX6zLT4K5OSwUvrvC5C7wYqS9s67ONY+CfE
 8ZQbyntmhlUr7+2yOM57UR/EchGE6/uypQBo4arKmhL1atJHymVHH0tybeNHfBMM
X-Gm-Gg: AYBFou0ob2HM/XOM0k+EmEcxvChW4HkbVsMl87SgVyCppeKNqkqEVJVe8kzI/r9eB3W
 2CxN70lDqkfX5X42Vf8aQVlFOm1zz9TWfn+p/SE3dT572k/VR8rpLxxWIc9GLQRJIp3dGfJ8V3g
 t+LdY6ApLBellRnEHbfjOhOqDK5HaiBo2/sadMpS8sNFOTQl35coltyF6Gv7J3qHtipPJ8hMrC6
 HigRu7W8fhefSfHGb+yFVgHjc35S5zwE+HM6SBRHOQMrfPrh9gbX3whOcKtBFDx7pTHb43W8f61
 I45Wi1hjFAxuWNgskB3FZioESnkQrHoBdWsARlYA3XSypcn552SHBYxAF4dNZBInCb5RSawgq5e
 0lUnjE9d0Y0oWKRF/tsqxa8ecsIERhur6WL+0MA8h23dv4BXt158W71vTfkvx6tNNvej3+p7owJ
 VRyiRJSeuqcK8/ZYna5dXpLpXyopRZECqcHCrUfTWfW8MG8IX01D8NMs/YVA10MPS5lUB/WXaD2
 yxA3RJdTWmy+nsPu3TZpNVe+kNLWmdZQOIMYVZA47hAP44dvvG/+LhdVCLiXpml40WZG6/eajBe
 IWDL0t/FnZ/3MViDJA1+I6IerlUg/ONp6AFzXcU/zt2qDW+Y4QIhZarSC2m6
X-Received: by 2002:a17:902:ce81:b0:2e9:5714:6079 with SMTP id
 d9443c01a7336-2eb0049e2dbmr17960115ad.31.1793179587899; 
 Wed, 28 Oct 2026 02:26:27 -0700 (PDT)
Received: from hades-NUC8i7HVK.taila0cd24.ts.net ([222.72.128.122])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2eae6b7a691sm19481635ad.26.2026.10.28.02.26.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 02:26:26 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "'Michael S . Tsirkin'" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?=27Daniel=20P=20=2E=20Berrang=C3=A9=27?= <berrange@redhat.com>,
 Jason Wang <jasowangio@gmail.com>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH V19 00/14] iothread: Support tracking and querying IOThread
 holder
Date: Wed, 28 Oct 2026 17:26:05 +0800
Message-ID: <20261028092619.1654474-1-zhangckid@gmail.com>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=zhangckid@gmail.com; helo=mail-pl1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

### Motivation
Currently, the relationship between IOThreads and the resources using them is
opaque. From a management perspective, it is difficult to determine which
devices or block exports are currently associated with a specific IOThread
via QMP or HMP.

This series introduces a "holder" tracking mechanism based on QOM paths or
block exports to significantly improve IOThread observability.
In high-performance virtualization environments, users often pre-allocate
a set of IOThreads to serve as a persistent thread pool. During device
hotplug/unplug cycles, while IOThread objects remain persistent,
their attachment state changes dynamically.

By tracking these "holders," administrators can use `query-iothreads` to
monitor the real-time load distribution of the thread pool and identify which
specific devices (e.g., virtio-blk, BlockExport) are attached to which thread.

### Technical Overview
* Holder tracking

  Add a QAPI holder list to each IOThread.  A holder identifies either
  a QOM object by its canonical path or a block export by its unique
  BlockExportOptions ID.

* Explicit reference lifecycle

  Add iothread_ref_and_get_aio_context() and the matching
  iothread_unref_and_put_aio_context().  Acquiring an AioContext registers a
  holder and keeps the IOThread alive until the matching put.

  Legacy callers without a matching lifecycle use the explicitly named
  iothread_unsafe_get_aio_context().  The ambiguous legacy
  iothread_get_aio_context() is removed after all production callers
  are migrated.

* Subsystem integration

  Track holders for block exports, monitors, virtio-blk, virtio-scsi,
  virtio queue mappings, virtio balloon thread pinning, COLO compare,
  vfio-user proxy, and xen-block.

* Introspection

  Extend IOThreadInfo with a holders array returned by
  query-iothreads.  Display the same information with info iothreads.


### V19 -> V18 Changelog
  - Added new patch in the last:
    docs/devel: document holder-aware IOThread AioContext APIs
  - Rebased on upstream code.
  - Added IOThread prepare_delete() to reject deletion while holders
    remain, preventing NULL IOThread lookups during virtqueue mapping
    cleanup.

### V18 -> V17 Changelog
  - Saved the COLO object's QOM path for finalization and guarded
    holder cleanup against incomplete initialization.
  - Used the owning PCI device's QOM path for vfio-user holders
    and saved it for disconnect().
  - Simplified the monitor QOM path field name and clarified
    PATCH 12's commit message.
  - Rebased on upstream and collected Reviewed-by tags.

### V17 -> V16 Changelog
  - Rebase code to resolve code conflicts for patch 8:
    "virtio-balloon: Update tracking iothread users with holder".
    This issue caused by latest merged patch "fdc3f9a83d".

### V16 -> V15 Changelog
  - Unified per-monitor IOThread checks and accesses through
    mon->iothread after initialization.
  - Simplified PATCH 13's commit message and clarified why blockdev
    cannot use the holder-aware get/put APIs.
  - Dropped the v15 Patch 1 in this series, It will be taken away
    independently by trivial-patches tree.

### V15 -> V14 Changelog
  - Moved monitor IOThread cleanup from unparent() to monitor_finalize(),
    pairing complete() with instance finalization.
  - Squashed V14 PATCH 04 and PATCH 14 into PATCH 13 and clarified the
    blockdev lifetime assumption. Since the additional changes are minimal,
    PATCH 13 retains Stefan's Reviewed-by from V14 PATCH 04.
  - Rebased and adapted info iothreads to the MonitorHMP interface.

### V14 -> V13 Changelog
  - Renamed patch 3 and clarified that it introduces holder-tracking
    infrastructure, with users converted in subsequent patches.
  - Documented that monitor holders are not visible to management
    applications, while retaining the tracking for a consistent holder
    and IOThread reference lifecycle.
  - Rebased on the latest upstream.


Zhang Chen (14):
  iothread: introduce holder tracking
  iothread: add holder-aware AioContext accessors
  block/export: track IOThread references
  monitor: track IOThread users with QOM paths
  virtio-vq-mapping: track iothread-vq-mapping references using device
    path
  virtio: track IOThread references for thread pinning
  net/colo: track IOThread references using path-based holder
  virtio-balloon: Update tracking iothread users with holder
  vfio-user/proxy: Update tracking iothread users with device QOM paths
  xen-block: Update tracking iothread users with holder name
  monitor/hmp: display IOThread holders
  iothread: make legacy AioContext getter explicitly unsafe
  tests/unit/iothread: update AioContext ref/put helpers
  docs/devel: document holder-aware IOThread AioContext APIs

 block/export/export.c                   |  62 +++++++++++---
 blockdev.c                              |   9 ++-
 docs/devel/multiple-iothreads.rst       |  19 +++--
 hw/block/dataplane/xen-block.c          |  19 ++++-
 hw/block/virtio-blk.c                   |  21 +++--
 hw/scsi/virtio-scsi-dataplane.c         |  22 +++--
 hw/vfio-user/pci.c                      |   2 +-
 hw/vfio-user/proxy.c                    |  20 ++++-
 hw/vfio-user/proxy.h                    |   4 +-
 hw/virtio/iothread-vq-mapping.c         |  20 +++--
 hw/virtio/virtio-balloon.c              |  21 +++--
 include/block/export.h                  |   5 ++
 include/hw/virtio/iothread-vq-mapping.h |   6 +-
 include/hw/virtio/virtio-balloon.h      |   1 +
 include/system/iothread.h               |  38 ++++++++-
 iothread.c                              | 102 +++++++++++++++++++++++-
 monitor/hmp-cmds.c                      |  20 +++++
 monitor/monitor-internal.h              |   7 +-
 monitor/monitor.c                       |  36 ++++++---
 monitor/qmp.c                           |  14 ++--
 net/colo-compare.c                      |  36 ++++++---
 qapi/misc.json                          |  94 +++++++++++++++++++---
 tests/unit/iothread.c                   |  18 +++--
 tests/unit/iothread.h                   |   7 +-
 tests/unit/test-aio-multithread.c       |   5 +-
 tests/unit/test-bdrv-drain.c            |  18 +++--
 tests/unit/test-block-iothread.c        |  21 +++--
 27 files changed, 535 insertions(+), 112 deletions(-)

-- 
2.53.0


