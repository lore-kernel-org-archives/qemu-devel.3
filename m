Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56DF5C5DF9A
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Aug 2026 21:34:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxtLu-0003c2-J3; Sat, 22 Aug 2026 17:34:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wxtLs-0003bd-Fm
 for qemu-devel@nongnu.org; Sat, 22 Aug 2026 17:34:08 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wxtLq-0000eZ-Gi
 for qemu-devel@nongnu.org; Sat, 22 Aug 2026 17:34:08 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-38fdeaed181so2887196a91.1
 for <qemu-devel@nongnu.org>; Sat, 22 Aug 2026 14:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787434445; x=1788039245; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=flEFxd1ayCVR7qDuo4SxKpST5dXU2fM4LcRrer8zyNE=;
 b=C6ut8x29Ye2IEcjEW6EuBTGKeDd2Nk9jISEAO2Edwb9JjQ8DbHKbIY/rzn329LhC+D
 EmQvvkEzN5jb/qrzPq3rHDw1lNMdUz/eri9PCTQvqBI9wpb7oLukfz15HuMVKsUuR9OJ
 7qobSrIG2mhwm1iqn8hI2kPOiU2SsBJr7G51h4kZ9rwbqVNKcOYQRozMu8/VuTLXkV26
 0HK8mTh0CnaNiHwCNKq4p8lX1VImq2Ej2Jwnlc3AF32MF2a5/BALJUPQYMrTLeRC//Jn
 lzMxreiHU4QnWNwi0RJNU4veJgFkIeE+LBu3s4mPUbsmomfQdjVP0V+8AaJQFMNJUtPf
 6OsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787434445; x=1788039245;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=flEFxd1ayCVR7qDuo4SxKpST5dXU2fM4LcRrer8zyNE=;
 b=gd51kDXmpgY/eYSrK1YWHiyvNCwgsDxWYBsKn3/7g0ZtPSzT+1bopLA6PWrQF7wWv9
 dI92VTkMB33E9ysSwq6RW9CfB7x2yrm4bhPX7JKuuHr/iIv5xQrawV75GZWXKboLea0b
 4hxJEGcygZ1WJT+1B/dgtLHpNWCVoh25xkpIhQkUjkbwxZgiciWGY7R22c9hnv1hjOHe
 JEk9aP9bS4wg5uuQmLYCLXLQhsOipRa3PKnzPYysdoFX4KBBv3dsfwVNe5Q+YwrX+pDN
 +tI1iJlNVAo2j/udOU/z0cR6Elr62bQdE0lLTzuA6dDZlbiJSjVEaFBRDc8SoLeTrPJQ
 WTGA==
X-Gm-Message-State: AFuF++mTzPaHfyGOyn5h+KwzjXjsHtufdauRr6Cf8IzUTqakP6zAFDAz
 vhhtAtQb1NtlF+rUR/QqytsSbNZ4PWTIRM/PhvDWpH9wM0BM4ZyfK6BTmvo5t5d866WiX9r2
X-Gm-Gg: AR+sD13OR0mQaSyC0nQH/i/BOuNi/nYK1/pyw8OJjmbaxuqKZ7c3Y0ynW73nPMA3TgX
 rLbeTtfiktkrg0FwWlmie/5uP8Y3ISND4QA/bgDJlCsW1yrl2xU6w3BIBhmlbUgsRo9D1dDYvgL
 qlQcwE6A2pVt3XADJftNwXg4QgqWDohpSjE4nit1i3UEEXXI2q1ugeQlzFJE2nivyeWzRuvM5vd
 ZEMi3fLAsGa7AdmeDGwbZ0m3ktx1TVgLl/Gym7LR5HMskv96bXeQPx7Dplzn6JLNTqUWp56lVZb
 OC2H9pFTgyqc3Vns8rNcmCFYJktf3N9l14vj8w7E7fNiRn2QxjBMlF4G5VLTtBbQBFM/6EVUdm3
 Kij5qVZzGUAdKSyGFAhB1RbkxbmZwP61e7k7Hg6d6SfIQRTyVhMkJS85rY8s4y6r8UnLXsZhi7G
 ZZVrYDqIP0/B7GUJId7GLKvkJDA+4lW4Ep0MDyGM4R6WtMukMCTen0PZsDjk3A+R1XxJ/bfn2gg
 unLI4Fp
X-Received: by 2002:a05:6a21:600c:b0:3b4:61f:1fec with SMTP id
 adf61e73a8af0-3cd2fd8e339mr32065419637.2.1787434444757; 
 Sat, 22 Aug 2026 14:34:04 -0700 (PDT)
Received: from catgo-fnos.taila0cd24.ts.net ([104.28.201.73])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-327f909c6c9sm11633181eec.6.2026.08.22.14.34.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 22 Aug 2026 14:34:04 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "'Michael S . Tsirkin'" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?=27Daniel=20P=20=2E=20Berrang=C3=A9=27?= <berrange@redhat.com>,
 Jason Wang <jasowangio@gmail.com>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH V13 00/15] iothread: Support tracking and querying IOThread
 holders
Date: Sun, 23 Aug 2026 05:33:23 +0800
Message-ID: <20260822213343.661939-1-zhangckid@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=zhangckid@gmail.com; helo=mail-pj1-x1035.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

  Add a QAPI holder list to each IOThread.  A holder identifies either
  a QOM object by its canonical path or a block export by its unique
  BlockExportOptions ID.

* Explicit reference lifecycle

  Add iothread_ref_and_get_aio_context() and the matching
  iothread_unref_and_put_aio_context().  Acquiring an AioContext registers a
  holder and keeps the IOThread alive until the matching put.

  Legacy callers without a matching lifecycle use the explicitly named
  iothread_unsafe_get_aio_context().  The ambiguous legacy
  iothread_get_aio_context() is removed after all production callers
  are migrated.

* Subsystem integration

  Track holders for block exports, monitors, virtio-blk, virtio-scsi,
  virtio queue mappings, virtio balloon thread pinning, COLO compare,
  vfio-user proxy, and xen-block.

* Introspection

  Extend IOThreadInfo with a holders array returned by
  query-iothreads.  Display the same information with info iothreads,
  while omitting the holders line when the list is empty.


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

### V10 -> V9 Changelog
  - Rebase this series on the Daniel P. Berrangé's series:
    [PATCH v7 00/35] monitor: turn QMP and HMP into QOM objects
    https://lore.kernel.org/qemu-devel/20260706135824.2623960-1-berrange@redhat.com/
  - Remove the monitor type of IOThreadHolder, make the monitor as a QOM object.
  - Remove GList related code and stays within QAPI instead of mixing GList and QAPI.
  - Fix missed comments in the patch 2.
  - Rewrite parts of commit log generated by AI.
  - Keep Stefan's reviewed-by in patch 2 and addressed Markus's comments.
  - Rewrite parts of code comments.
  - Drop original patch 6/7/8 for monitor parts.




Zhang Chen (15):
  qapi/misc: Fix missed query-iothreads items
  iothread: introduce holder tracking
  iothread: track users with holder name
  iothread: introduce iothread_unsafe_get_aio_context()
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
  iothread: remove legacy iothread_get_aio_context()
  tests/unit/iothread: update AioContext ref/put helpers

 block/export/export.c                   | 62 ++++++++++++++---
 blockdev.c                              |  2 +-
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
 monitor/monitor-internal.h              |  3 +
 monitor/monitor.c                       | 33 +++++++--
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
2.55.0


