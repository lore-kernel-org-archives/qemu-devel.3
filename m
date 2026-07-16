Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6907FC44512
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 14:47:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkNJK-0006xv-TG; Thu, 16 Jul 2026 10:43:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wkNHG-0005o9-55
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 10:41:38 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wkNHD-000746-Db
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 10:41:29 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2cc891373e0so79519755ad.2
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 07:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784212886; x=1784817686; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=vtnYKUejnqwjmqgQru+kWk91dsXNXkaUhLTZ0X1IwRc=;
 b=E8dCLTCQ1fuvrM7VuZEmX0rp0pyInP+DS+DoVdirjxhVK4qalFtWH9KqgO1foGOqnH
 XNXPnmrqMTrFwObH0AdeY/jA9kNuG3pU7C12FmyPJPEyFXBKYyUbaIdVPI4RWFdGCukp
 s/cpsYVNKY7dT9hzfI+NaV4aPRMaKhlLcMPV4Bq3esoE4BO01GnEecPXzqjrwPkwTc4z
 gD0PCWpA+Q2V97toKgP8Gtlp1JnhWg2iIsJsEMHt/exdrD+pj28EVvAlM7KlAOYo7rf3
 nVFbcIH6GnQMYzK2B4LpV/LsNBlyqMmDY2ODUQyNYYDjlCmKlTocuh62TB3va3jL4oE/
 ds1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784212886; x=1784817686;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=vtnYKUejnqwjmqgQru+kWk91dsXNXkaUhLTZ0X1IwRc=;
 b=iYUZltkqLVjAjHi4Yv7Qw3fsMyGAzqGQyWFoZqIMfAwZlqhhT1oD4/kc9UeWMbjwpK
 gyAtYVDYvZisv1Y67cgdZnrW+uqwDHgpE+O5jDXvYi4W2UrSW66cZsaGpRDSHCYb04k5
 LteJx3wP1qrR9Z0eRI/UOvNAX0h8QL7oOirbyXrfNh80PSa6dcmA6AUKk+91qK3Aa77h
 XC/RbTfpLpLzD79++DKdXCKtM12keYfp6v5XA7Obngi58qpbigNkYgTGOUJx3OUzfOlr
 SpMdAqUj2XhldvEDmI/1zIqRiflis7fe/IDuyBVpE4Os4qjluy1CkFRiS/srSIzsjPYC
 6AQg==
X-Gm-Message-State: AOJu0Yx8VBemsr5UeCdtHNT4vp8Tc4oOKsZ0qK7LrKkJx1fW9G1eahVA
 Fh2WB0f50dYHshhWrs3/tigczCNTrBhXinz1X6sITsU7FZHat3t1FJVJ5gdZkmC9jis=
X-Gm-Gg: AfdE7ckxAbO9QVchEaDT6+H1iwJ8scFwnXR6sMXDpGGOr468XgNwotfveYhEGPT3wz/
 aGKhPUXs8A38nZCs4BzfqoheSHimJZbVdXS6Tgj9yC/a86QIFIO2JSEe5QzHlklzLNkPXHQacwU
 QnQxsF6+lSHSqCHM711ln7n04CLg7oseey3Q8CPCoe8OVXrhkh+JH8zvHl3rs9hFXkkXdQEdWs4
 ua2jRrxS7slW1RDb7wd21Fs8R/YtxyixzaM49M4ZbK0MJnzwyeQTCITfKoM5HPJU050dgpnQbek
 LYz6IN89M8y6zMjAGsxr9l8Vd10TbvuPZIQdNX8/Ex2xBAzjkFovS91PbIaJjEO3opjAI+iYdlc
 Z8YubaRVc9akCW2GhNMzhseRF8XjyJcu+h/FGfEEC4eZZ1g6RGm5Q4djrt3o6sqXKbOr2rxatkV
 mULjNIC9saKwQyxezk73r3eh18OXVOHotGb2VsKqZFA0XD1hxbtTE=
X-Received: by 2002:a17:902:e805:b0:2ca:c68:c554 with SMTP id
 d9443c01a7336-2cf03dc9ec6mr69142625ad.38.1784212885607; 
 Thu, 16 Jul 2026 07:41:25 -0700 (PDT)
Received: from ZBMac-LWN10QXKQ0.taila0cd24.ts.net
 ([2408:80e0:41fc:0:fe49::677]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2cf100e42a1sm20991165ad.15.2026.07.16.07.41.20
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 16 Jul 2026 07:41:25 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH V10 00/15] iothread: Support tracking and querying IOThread
 holders
Date: Thu, 16 Jul 2026 22:40:25 +0800
Message-ID: <20260716144043.76414-1-zhangckid@gmail.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=zhangckid@gmail.com; helo=mail-pl1-x634.google.com
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
* Atomic API Design: Merged iothread_get_aio_context and 
  iothread_ref_and_get_aio_context into a single unified function. The new 
  API enforces a 'holder' parameter, making "retrieval" and "tracking" an  
  atomic operation to prevent reference tracking leaks.
* Subsystem Integration: Fully migrated and adapted core modules including 
  Virtio (blk, vq-mapping, balloon, scsi), Block Layer (export, xen), 
  Network (COLO), VFIO, and the Monitor subsystem.
* Introspection: Expanded the IOThreadInfo QAPI structure to include a 
  'holders' array (list of QOM paths or block exports), accessible via both 
  query-iothreads (QMP) and info iothreads (HMP).

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

### V9 -> V8 Changelog
  - Drop to assign unique default ID for monitor, and keep the NULL ID. 
  - Rewrite and split the monitor patch 7 and 8.
  - Add the [PATCH 17/17]tests/unit/iothread: Update the iothread_get_aio_context
    to keep the API same in the unit tests.
  - Refactorcode according comments.
  - Update the example.
  - Fix other comments issues.

### V7 -> V8 Changelog
  - Drop the assumption of the Monitor QOM, add the new type
    IO_THREAD_HOLDER_KIND_MONITOR_NAME.
  - Drop the assumption of the string '/' as QOM path.
  - Introduce new patch for Monitor:
    [PATCH 06/15] assign unique default ID to anonymous monitors
  - Fixed Monitor ID for the IOThread.
  - Refactorcode according comments.
  - Update QMP example.
  - Rebased patches on upstream code.
  - Fixed comments issues.
  - Removed redundant code.

### V6 -> V7 Changelog
  - Fixed comments issues in patch 02/14 (Thanks Markus).
  - Removed redundant code.
  - Rebased patches on upstream code.
  - Fixed code conflict with latest patches.
  - Added detailed description in git log and code.
  - Added comments for patch 06/14 assuming the monitor is a QOM object,
    Depends on Daniel Berrange's RFC patch:
    [PATCH RFC 00/17] monitor: turn QMP and HMP into QOM objects

### V5 -> V6 Changelog
* API Refactoring (Breaking Change):
  - Implement the 'union': 'IoThreadHolder' for combine the QOM objects
    and the block-node.
  - Completely merged iothread_get_aio_context variants.
  - The iothread_get_aio_context function now strictly requires a 'holder'
    argument to ensure every context retrieval is accounted for.
* Expanded Module Coverage:
  - Added holder tracking for the monitor subsystem (tracking threads used
    by QMP/HMP).
  - Added support for the virtio-scsi dataplane.
* Code Cleanup:
  - Removed redundant and obsolete API declarations.
  - Standardized the use of object_get_canonical_path() across all callers
    to provide consistent and unique holder names.
* Bug Fixes:
  - Updated qapi/misc.json documentation to fix missing descriptions in
    query-iothreads items.
* Build System:
  - Improved header inclusion logic to avoid redundant declaration errors
    in unit tests.
* QAPI part:
  - Sorry to drop the "Acked-by: Markus Armbruster <armbru@redhat.com>",
    because this version have lots of changes in the:
    [PATCH V6 13/14]qapi: examine IOThread attachment status via query-iothreads




Zhang Chen (15):
  qapi/misc: Fix missed query-iothreads items
  iothread: introduce iothread_ref/unref to track attached devices
  iothread: tracking iothread users with holder name
  iothread: introduce iothread_unsafe_get_aio_context()
  block/export: track IOThread reference in BlockExport
  monitor: Update tracking iothread users with holder
  virtio-vq-mapping: track iothread-vq-mapping references using device
    path
  virtio: use iothread_get/put_aio_context for thread pinning
  net/colo: track IOThread references using path-based holder
  virtio-balloon: Update tracking iothread users with holder
  vfio-user/proxy: Update tracking iothread users with holder name
  xen-block: Update tracking iothread users with holder name
  monitor/hmp: Add holders support for hmp_info_iothreads
  iothread: simplify API by merging iothread_get_aio_context variants
  tests/unit/iothread: Update the iothread_get_aio_context

 block/export/export.c                   | 78 +++++++++++++++++---
 blockdev.c                              |  2 +-
 hw/block/dataplane/xen-block.c          | 19 ++++-
 hw/block/virtio-blk.c                   | 22 ++++--
 hw/scsi/virtio-scsi-dataplane.c         | 22 ++++--
 hw/vfio-user/proxy.c                    | 15 +++-
 hw/virtio/iothread-vq-mapping.c         | 19 +++--
 hw/virtio/virtio-balloon.c              | 22 ++++--
 include/block/export.h                  |  6 ++
 include/hw/virtio/iothread-vq-mapping.h |  6 +-
 include/system/iothread.h               | 30 +++++++-
 iothread.c                              | 96 ++++++++++++++++++++++++-
 monitor/hmp-cmds.c                      | 22 ++++++
 monitor/monitor-internal.h              |  3 +
 monitor/monitor.c                       | 22 +++++-
 monitor/qmp.c                           |  5 +-
 net/colo-compare.c                      | 29 +++++---
 qapi/misc.json                          | 71 +++++++++++++++++-
 tests/unit/iothread.c                   | 16 +++--
 tests/unit/iothread.h                   |  6 +-
 tests/unit/test-aio-multithread.c       |  5 +-
 tests/unit/test-bdrv-drain.c            | 18 +++--
 tests/unit/test-block-iothread.c        | 21 ++++--
 23 files changed, 477 insertions(+), 78 deletions(-)

-- 
2.49.0


