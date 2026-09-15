Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38663C88E75
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 10:18:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6QEO-0003JG-R5; Tue, 15 Sep 2026 06:17:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1x6QEA-0003IG-Ta
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 06:17:32 -0400
Received: from mail-pj2-x11.google.com ([2607:f8b0:4864:39::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1x6QE0-0002gm-Mc
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 06:17:25 -0400
Received: by mail-pj2-x11.google.com with SMTP id
 98e67ed59e1d1-396ccb1a98fso2319723a91.1
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 03:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789467425; x=1790072225; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=JWYlYmRK3LEgK9lJxmfX974U9RrOZy0xieTAkX4KMS4=;
 b=NX7vg0ZGn8hliEOeV7DmP/ayydkLJuRvBYz24P7f55xCGPCkvTqMvihx0ho9STsY8Q
 FLpA49lgHp6JM5lRpNDoOsg95f9vHEeUU06zbOSuJod7LcDQbVVCWJ5wYOfmb05++ayc
 +qrXEtXwTQS0k1zy1Amg50gKId/i/0gjlJzTaF1BFyJUcSPIx+rbFhCUSVDXBb2OJr+p
 i7pfQcRAyHHPD9tqdT7foqsZ0tKDRZRRwG23bf2Y7uExUo1kdCNH/tFlHbYeBTGc2wdh
 jAzOozobFej39Un/+WAESoCZFjbavhJIwZPBVzPCLvnVyF1lsy/Si+oYhZGyPKH2Gtg0
 6cMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789467425; x=1790072225;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JWYlYmRK3LEgK9lJxmfX974U9RrOZy0xieTAkX4KMS4=;
 b=NWzCzIW+pJUV1zq2q/PsQ8ePw/naJztqgcboC1HDVa1HlW+GFvGY48xG+hdN5r6SEI
 C3RdPYsjib9t0HludgOI6mNxsMVfy6h9cYQvkX6jll7apbVvtPYBNrXN/PxzvTPr1Jqa
 Br+5CnSOBJTwKxpwdcXBp64GfYAcf57csfR5sGUHP7a/b21oD6xkwSnUQXajtiWxPCTC
 UuvePIJ1q3IJUsYuGcHFmP8p48D8sEYCi3xbkyYASAa0m1ADWXACwBrvk1pjMSiqlPGQ
 OiFp3lrCj2w/zO4q3M7ogqH2vLF8EvjIvfKJPKAHYE7oeclsgqosxpqRMSYLhekoKIzy
 TBxQ==
X-Gm-Message-State: AFuF++mBJfDWO0uSsos1u2BZvK1mT5TCXh73xevIYhX2/7W25eruzewQ
 YwnyFWIvwUmde6ZZTr3nGbD87bcDB/Z7X2Ll1HEzaZVW93vTpnSjE5+zUermlmOf9/M=
X-Gm-Gg: AYBFou0iMJrLVaHUST1GoYsvUHb2ddzOIIMQc67QdhZrfPj3pB/DHac+6AArtaj1ZbD
 0C5u0UB+siM10UPrbdS1NZwjnhRN4BpUz1S0cZxMIkj6vlJKXnsJJ/Nyyrhqr05Lr1/N5l+EfCa
 7lsOhtevDdjKyViZzIbbDlsfFHBrf7vRLBDh/ouJstaAJtjkGdCkkD6BVGu6AuL9x5HO0GpoOc0
 P31DIEQ3sFrsLRKgizgk2zlXX2FvLQOn/INAr2nVbo78piRvtv4W3CjJPcN2gPJ8coZZLo2HJhj
 zGIvcwpQ+obGbaim11UZLh+1PccskBVv7iAaU7iIQsLgpB7J++/KieoGXaSIHBTJ8LMiHF6ylES
 w5I/cfL+Z9O+z93z/g8sbbw367yP/vBPIQgLePAfGE2L1VLhBN3PoV1KzihGr2wxxpPfkg3i8Zs
 ac+5gemTV66GrtLmLxOjqxpTH3zIJViG/DPSkytu49Ty+WhPdH8ObK/K9eeL4g5bhNhk82TrNag
 gCDdwuYXG/zQ1/6kvBqEMwMXgurhMD2JAd0fg==
X-Received: by 2002:a17:90b:4988:b0:38e:bfe:81e9 with SMTP id
 98e67ed59e1d1-39debf5f291mr13755430a91.1.1789467424880; 
 Tue, 15 Sep 2026 03:17:04 -0700 (PDT)
Received: from hades-NUC8i7HVK.taila0cd24.ts.net ([222.72.128.122])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39dfdacba6bsm4416868a91.14.2026.09.15.03.17.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 03:17:04 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "'Michael S . Tsirkin'" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?=27Daniel=20P=20=2E=20Berrang=C3=A9=27?= <berrange@redhat.com>,
 Jason Wang <jasowangio@gmail.com>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH V17 00/13] iothread: Support tracking and querying IOThread
 holder
Date: Tue, 15 Sep 2026 18:16:42 +0800
Message-ID: <20260915101655.3216101-1-zhangckid@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::11;
 envelope-from=zhangckid@gmail.com; helo=mail-pj2-x11.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

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

### V13 -> V12 Changelog
  - Refactored block export IOThread reference handling with shared
    init/cleanup helpers and preserved the existing single-IOThread
    driver arguments.
  - Moved monitor IOThread cleanup to the QOM unparent callback,
    where the canonical path is still available.
  - Kept internal IOThreads hidden from query-iothreads.
  - Made virtio queue-mapping holder arguments const.
  - Improved some detail comments.

### V12 -> V11 Changelog
  - Change the function name from the "iothread_put_aio_context()"
    to "iothread_unref_and_put_aio_context()" match the
    "iothread_unref_and_put_aio_context".
  - Fix unnecessary char * cast since the holder variable is
    declared const.
  - Add detailed commit msg in patch 06/15.
  - Optimize the HMP print in patch 13/15.
  - Rebase code on upstream.



Zhang Chen (13):
  iothread: introduce holder tracking
  iothread: add holder-aware AioContext accessors
  block/export: track IOThread references
  monitor: track IOThread users with QOM paths
  virtio-vq-mapping: track iothread-vq-mapping references using device
    path
  virtio: track IOThread references for thread pinning
  net/colo: track IOThread references using path-based holder
  virtio-balloon: Update tracking iothread users with holder
  vfio-user/proxy: Update tracking iothread users with holder name
  xen-block: Update tracking iothread users with holder name
  monitor/hmp: display IOThread holders
  iothread: make legacy AioContext getter explicitly unsafe
  tests/unit/iothread: update AioContext ref/put helpers

 block/export/export.c                   | 62 +++++++++++++---
 blockdev.c                              |  9 ++-
 hw/block/dataplane/xen-block.c          | 19 ++++-
 hw/block/virtio-blk.c                   | 21 ++++--
 hw/scsi/virtio-scsi-dataplane.c         | 22 ++++--
 hw/vfio-user/proxy.c                    | 16 ++++-
 hw/virtio/iothread-vq-mapping.c         | 20 ++++--
 hw/virtio/virtio-balloon.c              | 21 ++++--
 include/block/export.h                  |  5 ++
 include/hw/virtio/iothread-vq-mapping.h |  6 +-
 include/hw/virtio/virtio-balloon.h      |  1 +
 include/system/iothread.h               | 38 +++++++++-
 iothread.c                              | 89 ++++++++++++++++++++++-
 monitor/hmp-cmds.c                      | 20 ++++++
 monitor/monitor-internal.h              |  7 +-
 monitor/monitor.c                       | 36 +++++++---
 monitor/qmp.c                           | 14 ++--
 net/colo-compare.c                      | 29 +++++---
 qapi/misc.json                          | 94 +++++++++++++++++++++----
 tests/unit/iothread.c                   | 18 +++--
 tests/unit/iothread.h                   |  7 +-
 tests/unit/test-aio-multithread.c       |  5 +-
 tests/unit/test-bdrv-drain.c            | 18 +++--
 tests/unit/test-block-iothread.c        | 21 ++++--
 24 files changed, 496 insertions(+), 102 deletions(-)

-- 
2.43.0


