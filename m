Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E13D8606A331
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 09:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KQkzUIdR
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRnYF-0000Vr-D0; Fri, 13 Nov 2026 04:26:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1xRnYD-0000VU-7l
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 04:26:29 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1xRnYB-0005ys-Ca
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 04:26:29 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2e9eb579c0eso4082185ad.3
 for <qemu-devel@nongnu.org>; Fri, 13 Nov 2026 01:26:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794561985; x=1795166785; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=IycPlZ3Ttc8mV7dCFlhKv4uo+pTbXwid21oVPEkow3s=;
 b=KQkzUIdRnrz0NER2G9EWKhx3mCJKcfDj1ShCyLcHm4muuJpAm9V849hJbthPVjOCTc
 k5fH3z1WiUB54Oqguzemdnu/aj8S8rjHNqePa7BRgPxFcKBQHznPe7lavsZ/mvgeqIYr
 1otJ8Q3D9rI3mdXar4Xec9rU8Y2qYrV7Tu8Lzz1XChyk9mBMWi2dB7hVNVFI4WVM1h7d
 tgeii2K+A0KI+M6YkTgvRH4KaK3AX9vnU6aiu/pBYDfWxzuHkDWqF/BbnxTF3itldGvp
 404jMZI0JurA+KtJUkkvm+Mu4TSIiWSFk1HzbmY1VF2C9fLnQbqabtbrAaKaD5caLX3n
 Yn8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794561985; x=1795166785;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IycPlZ3Ttc8mV7dCFlhKv4uo+pTbXwid21oVPEkow3s=;
 b=qXlOXhXTqw4Pd5FzywsqxNyg7FKW5eRyR3Du6ZMZ9tY1xqX61Kacdz2AkTPtqEolIr
 SIPh7IbesB4QYh+IjlIghskYJgwoEnHMQvqyzw39A/2S0CcqCppeaUclJ1YnMYDRFJIX
 bCp3/avzPVAK3glc/cizpbmQgqspfdw3vhL02yPTa109nRqzkQ3JDsLq8LQwlfLo9Sr+
 0M5qyoMJyUkNMQIdFomIKgvNlPvLA5EGCNEAXX0IpzQGkvwfjAS7O6sjuWqi9ELzIvV+
 0oeKBln+dDFEEUPtBe6EKQTO/jQtmFuBjEtjUqLtJGotrpoZAh5/O4q2lV6eLTXxk8xv
 cssA==
X-Gm-Message-State: APuU4Z8Hj6dMQ9RwD+plFm791SLnojqUNpAk+FJRPYQHY6SPkkOfa0X4
 wOQTfx/jfYPLuW6ogiy70Dg8mhF7id+zaSqfN9lCUWpSzh1Nl1Lz+hHi5UIIZQ==
X-Gm-Gg: AYBFou1PNOXC2Kxx3gflKJ/TRG6Otie9gpua3rEQDVZEADQlHoeyRbWeUc56UbCRzRD
 XCC9VlalmRYoljyOYBQzx2gwYD8VxN3Rv+8LhaPzlAlk1x/TZrFRNt4zvaZllG7hs5oQgVtccsn
 viyY9Fkf+vMbIh+WhFF8jkMD3otv795Dt2uS0CiCdng/uc6ojODmE0AgdqBZWRw+atTsdAfa0zd
 kyk8wsKWcS/VJHoJOEiwHBCydMOY2E0uDnm1FtQtYtspFwrkBF6CZVHRFA7b+uOdUD9l+u5ShX8
 S2LE4qdV52DpLQXmvbHhAQ4EMnBFLyHR5Qnyx05jU/pqLi3Gi00CR1wWMsbhWYanYOAaRvgseYs
 e37ZquPHm5aPgwDNMu9aw7k9Q3NuUMdHSTtb//VuOSaFt6nLzyCNY2g6GPkIjkZi/68zbVJ5RXn
 gjUVun0RCTNniWP5Ff3T9RZM1pPZu0pclqFiCfBuc2SHllMfijIaoSHtzGQ7ul2ii6MH9rgwOEI
 6OOzrXK0Kt5XZ4WaVKAe+ZH42em4OOss2rTNBEWqU5fGb2bg9hMQi11/1vesFqBw6BLe8akFk4O
 9RLjI9AVbhGlHHIMeALZ9izzl4BIaEXLMZ4gBatUfUyKDtLyaVHq3VNzkZmi4vsIP9DTqla6qlu
 r72BE
X-Received: by 2002:a17:903:3888:b0:2e2:d834:a40f with SMTP id
 d9443c01a7336-2ee0d6654b4mr19571835ad.9.1794561985421; 
 Fri, 13 Nov 2026 01:26:25 -0800 (PST)
Received: from hades-NUC8i7HVK.taila0cd24.ts.net ([222.72.128.122])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ee0f7d0887sm7428605ad.32.2026.11.13.01.26.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2026 01:26:23 -0800 (PST)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "'Michael S . Tsirkin'" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?=27Daniel=20P=20=2E=20Berrang=C3=A9=27?= <berrange@redhat.com>,
 Jason Wang <jasowangio@gmail.com>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH V20 00/14] iothread: Support tracking and querying IOThread
 holder
Date: Fri, 13 Nov 2026 17:25:51 +0800
Message-ID: <20261113092605.942292-1-zhangckid@gmail.com>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=zhangckid@gmail.com; helo=mail-pl1-x62b.google.com
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


=====================================================================

### V20 -> V19 Changelog
  - Rebased onto upstream v11.2.0-rc0 (29760efaf96b).
  - Add the RB in the patch 14/14.
  - Adapted patches 1 and 5 to the updated QOM property registration
    context, and resolved patch 9's conflicts with vfio-user region
    FD cleanup. No functional changes to the series.

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


