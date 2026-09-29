Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A63ECA5FA5
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 08:44:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBTRt-0005it-Rp; Tue, 29 Sep 2026 04:44:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1xBTRs-0005ig-CB
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 04:44:28 -0400
Received: from mail-pz2-x2a.google.com ([2607:f8b0:4864:3b::2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1xBTRq-0003kv-HO
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 04:44:28 -0400
Received: by mail-pz2-x2a.google.com with SMTP id
 d2e1a72fcca58-883a16b758dso390805b3a.1
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 01:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790671464; x=1791276264; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=A0uj42/wSTIWr2NemDhINusmzk5NDnjcXMgaM622cSg=;
 b=hwkCBtd0OyIJB3qPlrhYvu4ufbl66j+ms2WprioZIx8abMOOpOyoIkPyWTccReA7Jv
 BrUXTPAf6me6z3RpT5E3R07jRvQtv2Jd+ALjg3qE21BxUpLbHSwEg73TLec0J10oMG5e
 ohd0yVzx/PgAqPIGYBKqShCuc1zPE/ImlFOQ1pSkmDI5QmmkMBEMA8s9xOeH1PWhWyT8
 SpA69RLCt/GjQIbDWV5qwR2HCgIryJY6wVxvlyIPPGL1k+F1gnLpOE8rktsdApSz71iq
 HF4G3lo1hwLF+QNee093s6sgvlpIDn5AgjORZG3FLnGYtIJwAuIFCx0rGyA0ny6ciuBs
 sy7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790671464; x=1791276264;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=A0uj42/wSTIWr2NemDhINusmzk5NDnjcXMgaM622cSg=;
 b=PWmdaluMh3Zy0eCs4MDP9nbk6AAWSHOwdiv+AatMWlCR9spO3UxTB0zN0W6ce0vgXj
 x3miIdNH86DBdH4rPfBM/7GZTQoUql3hT9KFXcmC0/wAlK6DFu6+Aj1W5wItyDPyAzOw
 N9hFiN3TGCIRbqqACIJE6rWvIC6f8h5pBiqN1/YxY+9Opo4fq1OoHwWS//igfYm/87Gl
 Pz7Ql54uwIvT8rVd2KRPn/Q4NF7U6bNC8K/Jwdkz3k5y2jzMbO9OGRMfz5dBzLBk9CRh
 roNQEd1QtA2Ehdu9uAZj3Nzj28dMdKlz/IzPQyM78uezn24tPS2gcyk5541tJojZ3Oyu
 5tQQ==
X-Gm-Message-State: AFq9FYLt7YtEDo0Q5b2eUCCi8pklE45eaWZD+bSOT7m878W8ksVlCcqm
 xZX2y0myaS7sWd6o/zFrrs3XpNPV8YjGqgyusz9neTTDU6UlAyR+JK97aemRDeTZ
X-Gm-Gg: AYBFou0IUOlTAMbLwmUsBBPT2fiyXfIRgSohQLQwbtuSfY5Yuu+aegYO4bwvmcGXT7l
 H6BztqRL1/3pu6tVQmjjgtBGoDgGg75ojTrkEE5WaAx2e1eCuQwh7jKhaIuxDvSSIscrPA66Gn5
 Faw6OpFA3JRQ5FUR1ayRyNEb1JVf2bCYywXficndCT/FQ/NDwaVeXA+3xNXaxEcZlyk/nvINTkM
 NZKVie4bfukkj9zCgGgnXhObIdnCbp1ACS2b9F4+TPAeSzuzZFMGlGAYtBZlesDuVt4mzMyweeY
 1mG2gEVoKYcggRNMlygt+hHCknh6lr77/XAgnVfw0OyIEYusSr2yre7tN8jkwea0mefQto6QKkU
 RLNKvNjd/JQCkZUXDfOMlPzb7mMHwFzEUbYaWZaUxm22uVvV5oAzaD6W7rw+TzCa1YBzrVQ2kr9
 i8DDcNMEIu7TYDeGXyubh3bf48ThlJ1pHJ8xGIGBSbKBAhVkIH2Cq5ASQCsUxzI2sq8qRbFCnoT
 L90l6F6oHorTt7T3Bo5Ag+m9uU=
X-Received: by 2002:a17:90b:28c6:b0:3a0:b7b4:b65e with SMTP id
 98e67ed59e1d1-3a49c0b0f9dmr907423a91.2.1790671464063; 
 Tue, 29 Sep 2026 01:44:24 -0700 (PDT)
Received: from hades-NUC8i7HVK.taila0cd24.ts.net ([222.72.128.122])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a497e942eesm5163120a91.4.2026.09.29.01.44.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 01:44:23 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "'Michael S . Tsirkin'" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?=27Daniel=20P=20=2E=20Berrang=C3=A9=27?= <berrange@redhat.com>,
 Jason Wang <jasowangio@gmail.com>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH V18 00/13] iothread: Support tracking and querying IOThread
 holder
Date: Tue, 29 Sep 2026 16:44:03 +0800
Message-ID: <20260929084416.1600199-1-zhangckid@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::2a;
 envelope-from=zhangckid@gmail.com; helo=mail-pz2-x2a.google.com
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
  vfio-user/proxy: Update tracking iothread users with device QOM paths
  xen-block: Update tracking iothread users with holder name
  monitor/hmp: display IOThread holders
  iothread: make legacy AioContext getter explicitly unsafe
  tests/unit/iothread: update AioContext ref/put helpers

 block/export/export.c                   | 62 +++++++++++++---
 blockdev.c                              |  9 ++-
 hw/block/dataplane/xen-block.c          | 19 ++++-
 hw/block/virtio-blk.c                   | 21 ++++--
 hw/scsi/virtio-scsi-dataplane.c         | 22 ++++--
 hw/vfio-user/pci.c                      |  2 +-
 hw/vfio-user/proxy.c                    | 20 +++++-
 hw/vfio-user/proxy.h                    |  4 +-
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
 net/colo-compare.c                      | 36 ++++++----
 qapi/misc.json                          | 94 +++++++++++++++++++++----
 tests/unit/iothread.c                   | 18 +++--
 tests/unit/iothread.h                   |  7 +-
 tests/unit/test-aio-multithread.c       |  5 +-
 tests/unit/test-bdrv-drain.c            | 18 +++--
 tests/unit/test-block-iothread.c        | 21 ++++--
 26 files changed, 508 insertions(+), 107 deletions(-)

-- 
2.43.0


