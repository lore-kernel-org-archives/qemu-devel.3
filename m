Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77C41C79F9E
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 06:38:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3SzF-0005eO-1u; Mon, 07 Sep 2026 02:37:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1x3SzD-0005eE-8m
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 02:37:47 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1x3SzB-00064R-CI
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 02:37:47 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2d7200b2e15so32949345ad.3
 for <qemu-devel@nongnu.org>; Sun, 06 Sep 2026 23:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788763063; x=1789367863; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=PDuTglcPxRRGPonYckGUhZtcYytbsFv7dI2IuMlCkYU=;
 b=O4yE3g8gHGD8K+Rhs/oaYDH+fJHEH0ZrD/TZqlYZX6oe07cBMxDAyT2TYoCOYvp68y
 h5R9tYCOgPMSJ8tyb9CwNLqVsRHluTmcQLgKVPVeEhhAvSKFYko6nBAxxsmaafcZDuaz
 kiw1ysrgD5qhheNpyuG4jc3S5/RW1ZJitwbzlO9w+WpoBxl1SlxpXsmrmNvQx8HtqO/f
 qwvLEZ7w56+wf8KfiAsI+7MBo98NNqbv9pTYMlorQZwf18T7CdK0Q9IGZYoz+nA+0vdl
 9x9SFyALZF1PSbb/ETmlPwSt3HSzxd9EUWEQuJv7Z9URvYOjxAMLMnddgUoJCsU69Pgc
 CH+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788763063; x=1789367863;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PDuTglcPxRRGPonYckGUhZtcYytbsFv7dI2IuMlCkYU=;
 b=Di1wgpC9fdnwG1KdwewyYmG5Xraaj5xVP5DDk2tfTsnzdwUC1D4aUkGmQ0gUc0wDul
 c4UfWjaHf5vFE3sCXeTCJYig3+/fvcPsOH6wkdwfjt2UVNt5kSeLgYERxI69NzozMotv
 be8PqsddShHP8L5o7GeDo+lD7iUiUEIbAC6/2377IYqDVlJ430x5JyuFwXPXtK5endZA
 TYlipOJeWEJfuJnc9VkLcJa7YRoNQDlStlvgqlGOQNHx3y6Hat1LBm+dKNLdqpCMY9em
 uuHAW102g8KnlbruGH0kin8pH/TxUJZQJW2kvHJTxDTVAEsla3Q1IArcxiP7gXntklks
 tL5g==
X-Gm-Message-State: AFuF++kXw3P/s7LBCMMs58SuPvYV5uVo5SW8pHNOiH1v28uB6khFRfNg
 Bae8bmupCuXtX7f3dvlv3e2WYxgH66fqP/WVENX/y4cMZyeAVrlKNLm8c+yPr/DPwiaJ/w==
X-Gm-Gg: AYBFou3aQcKHW8ldjvD3uILr3akVhBLzQw8YgdlEq/iin4VQB/7kOs3+VIeqWMDe+y+
 QxSmCRfCs1pcyEYhMCKSQAO1Ab5LFVvASEBqHaRuVQGlaNwejYMgRvwJ3inAdWZEpMusL+51FJZ
 ULpDNsWRMmxPURPqHMXBuPcEyV6qw0rR9b0DsIRKGu2zcMeEZGuLhwiShco2EaTpyfBijNIQKeD
 UGel52wyZbj2wSLXNFRlSQh3TPMrw0QlRrV6PqNr66ckq6zocsqsFsZTGAcIxOZvDcSs2R06w8S
 +qIQ549nTs4SDO4IiADmuFBlAY4deGpJ2D42EcJeOhpOwKqjUDY81EKfMcIboV5wDjiWPWI/sPi
 9kh9TqCb+7MwiO3h1mKVO5Jz9icUHlWj/6/osmPfmw0Xpw2tyACakLxnWWv1Z7TrKhfMZvGZnDX
 xHbctarGsVrvymlCWa2Jht0nvEgRnXxa4yLOuUch46iTQXkL0bvwQw/DdZtBRal/09KK7u8TCZA
 RXfBQRwdAUQPhYo
X-Received: by 2002:a17:903:22c6:b0:2d9:520c:38e7 with SMTP id
 d9443c01a7336-2db125a5540mr293055565ad.1.1788763063138; 
 Sun, 06 Sep 2026 23:37:43 -0700 (PDT)
Received: from hades-NUC8i7HVK.taila0cd24.ts.net ([222.72.128.122])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2db1499f06fsm38502555ad.54.2026.09.06.23.37.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 06 Sep 2026 23:37:42 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "'Michael S . Tsirkin'" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?=27Daniel=20P=20=2E=20Berrang=C3=A9=27?= <berrange@redhat.com>,
 Jason Wang <jasowangio@gmail.com>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH V15 00/14] iothread: Support tracking and querying IOThread
 holder
Date: Mon,  7 Sep 2026 14:37:11 +0800
Message-ID: <20260907063725.626685-1-zhangckid@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=zhangckid@gmail.com; helo=mail-pl1-x62c.google.com
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

### V11 -> V10 Changelog
  - Keep iothread_ref_and_get_aio_context() as an explicit acquiring API
    instead of merging it into iothread_get_aio_context().
  - Retain iothread_get_aio_context() during the caller migration so
    every intermediate patch builds, then remove it in patch 14.
  - Update patch 15 to use the holder-aware get/put API in unit-test
    stubs and callers.
  - Rework patch 2 documentation to describe holders as QOM objects or
    block exports, simplify the ref/unref descriptions, and use
    imperative function comments.
  - Identify block export holders with BlockExportOptions member id and
    rename the QAPI field to export-id.
  - Fix monitor cleanup so it only releases an AioContext acquired by
    that monitor, preventing an iothread_unref() assertion at shutdown.
  - Rebase the series onto the current upstream tree.



Zhang Chen (14):
  qapi/misc: Fix missed query-iothreads items
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

 block/export/export.c                   | 62 ++++++++++++++---
 blockdev.c                              |  7 +-
 hw/block/dataplane/xen-block.c          | 19 +++++-
 hw/block/virtio-blk.c                   | 21 ++++--
 hw/scsi/virtio-scsi-dataplane.c         | 22 ++++--
 hw/vfio-user/proxy.c                    | 16 ++++-
 hw/virtio/iothread-vq-mapping.c         | 20 ++++--
 hw/virtio/virtio-balloon.c              | 22 ++++--
 include/block/export.h                  |  5 ++
 include/hw/virtio/iothread-vq-mapping.h |  6 +-
 include/system/iothread.h               | 38 ++++++++++-
 iothread.c                              | 89 ++++++++++++++++++++++++-
 monitor/hmp-cmds.c                      | 20 ++++++
 monitor/monitor-internal.h              |  5 ++
 monitor/monitor.c                       | 26 ++++++--
 monitor/qmp.c                           |  5 +-
 net/colo-compare.c                      | 29 +++++---
 qapi/misc.json                          | 86 ++++++++++++++++++++++--
 tests/unit/iothread.c                   | 18 +++--
 tests/unit/iothread.h                   |  7 +-
 tests/unit/test-aio-multithread.c       |  5 +-
 tests/unit/test-bdrv-drain.c            | 18 +++--
 tests/unit/test-block-iothread.c        | 21 ++++--
 23 files changed, 485 insertions(+), 82 deletions(-)

-- 
2.43.0


