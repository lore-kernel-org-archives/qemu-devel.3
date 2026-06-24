Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A48FACDB470
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 07:09:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcHjS-0004xs-D7; Wed, 24 Jun 2026 03:09:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wcHjQ-0004xe-DZ
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 03:09:08 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wcHjN-0002v0-VW
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 03:09:07 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-c88d1d4543fso963552a12.0
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 00:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782284944; x=1782889744; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=zMYL0k1qmLjPkPRlSzdoqv1X2KnIQnPpe0cFv+jH4Eg=;
 b=peZs1ox72jlsy0IEcp3Ms5cKSBiIKZM0uff+35UFIcEhBBo0+fvPXrqewuefJy6HPu
 9qPL2Gq20HyHP1G7JIwkNz10CZa7zlJGGoKfkJRHfzLsdiGtFEgdrrZyjBO6MHseEcEc
 fnM7l/A8npv1w1O12j4IU8t0UUSEtc9XO/IbUA/i/hhPz9BBH9lADEMREzAXCw1l5d7R
 NRH/rIjHmEi0OXcoqO1GHddrgJu+B+kBKQnkQPe262d1FWxHcLlC9051o+1fRsjprWGW
 8rUPKRH8rZHRqTmTrJUBpJtZS/G2LVJ3uCgYTPcpnnp3Ik0jLdLTiFllmfWfvaIS6c/H
 XSlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782284944; x=1782889744;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zMYL0k1qmLjPkPRlSzdoqv1X2KnIQnPpe0cFv+jH4Eg=;
 b=qe58ngd4Y+xrPJ2iYnGrTkvE37tRTRhT4hKQezwfDjVpd9lOfsmtpMQOhspUz+liHQ
 ADCidTORPpxX1VBlE8AHfD48kbgGmPOz8zBE5AjAX4e2//tmMHIRvxNhkj4XsansHPcE
 2yKW4bVK5nUE8PlcLWo4jObfOWbDp5qAuUgyAFsAgAqjEPUboig3IZALkroj5M4LhukH
 M1/pzK02cp58oxqUNPdB9B7tpb7aN3NreS0fqU8ayyHmHHolSNupZdAhmBzftHTi7IGO
 TtlS61UnwqGYZYqre73JFU1XBuTEUJGJD9/S+beBpcXzWEFjTKL9cvygO2W42I2AGrbv
 s/LA==
X-Gm-Message-State: AOJu0YzEQXvc8EdimjN5cYRQTw8soG3mCN+9OEVKiS8qmeE1IgvyhZhD
 nXX4g6THrSrnT0JCT9JbxCxekx/OSVPfdBJc+IXLljV5oO1XzqKm+OXaY5uWbUFvA48=
X-Gm-Gg: AfdE7clvlyvRJLmq8T/Ovt4bY+6vEX2QaEOnua+DX/1TffrgG3lE+lxiaK0ohyEwNoY
 7s/Gz+uTjDu8Cv5rMVXqYrI++OPyf/9+rshn9EHL4YV3MmpUTOvfT53w0sVtIXOWztWg9By+FXX
 gAfediybrQdMhDZ2ac7xN147ukECLekKwQz6CIzvIMziZUXNgonnoe62//tMUpV4WzV7EVXrlkr
 Uwpb0iO0NG1KLPQKWd2mP2Ak5aHc3ng4sSSShFtg5yOHrNDBvYpVoDyJ+4ULDlzVKZGSTBc7wR9
 2xSO1mCvioVOL6HBU2YUlNkVl4LhBATaohQyPXGojBqT5+kYDqxMIGGjNa0s7HoC/f13E8eKozv
 /nd/BVhKRaut61lYefkLx+UYAB7km6mDLH/0+dyrLscjhUx3MP9n1UFft9fIM3+VQROv/iJB6j5
 4lVP0rKh6WRUP6YeSX/srGBfkCFAguxNsBnDMepvsTU20uO9oxBxsL
X-Received: by 2002:a05:6a21:4592:b0:39c:41b2:5d4b with SMTP id
 adf61e73a8af0-3bd109d77b4mr6904675637.2.1782284943796; 
 Wed, 24 Jun 2026 00:09:03 -0700 (PDT)
Received: from ZBMac-LWN10QXKQ0.taila0cd24.ts.net
 ([2408:80e0:41fc:0:fe49::1277]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c8bc2c8e92asm10736569a12.2.2026.06.24.00.09.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 Jun 2026 00:09:03 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Fam Zheng <fam@euphon.net>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH V9 00/17] iothread: Support tracking and querying IOThread
 holders
Date: Wed, 24 Jun 2026 15:08:34 +0800
Message-ID: <20260624070851.13342-1-zhangckid@gmail.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=zhangckid@gmail.com; helo=mail-pg1-x534.google.com
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

This series introduces a "holder" tracking mechanism based on QOM paths,
block nodes or monitor to significantly improve IOThread observability.
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
  'holders' array (list of QOM paths), accessible via both 
  query-iothreads (QMP) and info iothreads (HMP).


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


Zhang Chen (17):
  qapi/misc: Fix missed query-iothreads items
  iothread: introduce iothread_ref/unref to track attached devices
  iothread: tracking iothread users with holder name
  iothread: introduce iothread_unsafe_get_aio_context()
  block/export: track IOThread reference in BlockExport
  monitor: refactor monitor_data_init() to pass ID
  monitor: support iothread ref/unref for anonymous monitors
  monitor: switch to iothread_unsafe_get_aio_context()
  virtio-vq-mapping: track iothread-vq-mapping references using device
    path
  virtio: use iothread_get/put_aio_context for thread pinning
  net/colo: track IOThread references using path-based holder
  virtio-balloon: Update tracking iothread users with holder
  vfio-user/proxy: Update tracking iothread users with holder name
  xen-block: Update tracking iothread users with holder name
  qapi: examine IOThread attachment status via query-iothreads
  iothread: simplify API by merging iothread_get_aio_context variants
  tests/unit/iothread: Update the iothread_get_aio_context

 block/export/export.c                   |  62 +++++++++--
 blockdev.c                              |   2 +-
 chardev/char.c                          |   2 +-
 gdbstub/system.c                        |   3 +-
 hw/block/dataplane/xen-block.c          |  19 +++-
 hw/block/virtio-blk.c                   |  22 ++--
 hw/scsi/virtio-scsi-dataplane.c         |  22 ++--
 hw/vfio-user/proxy.c                    |  15 ++-
 hw/virtio/iothread-vq-mapping.c         |  19 +++-
 hw/virtio/virtio-balloon.c              |  22 +++-
 include/block/export.h                  |   6 ++
 include/hw/virtio/iothread-vq-mapping.h |   6 +-
 include/monitor/monitor.h               |   5 +-
 include/system/iothread.h               |  17 ++-
 iothread.c                              | 136 +++++++++++++++++++++++-
 monitor/hmp-cmds.c                      |  26 +++++
 monitor/hmp.c                           |   5 +-
 monitor/monitor-internal.h              |   4 +-
 monitor/monitor.c                       |  37 +++++--
 monitor/qmp-cmds.c                      |   2 +-
 monitor/qmp.c                           |   7 +-
 net/colo-compare.c                      |  29 +++--
 qapi/misc.json                          |  82 +++++++++++++-
 stubs/monitor-internal.c                |   3 +-
 tests/unit/iothread.c                   |  16 +--
 tests/unit/iothread.h                   |   6 +-
 tests/unit/test-aio-multithread.c       |   5 +-
 tests/unit/test-bdrv-drain.c            |  18 +++-
 tests/unit/test-block-iothread.c        |  21 ++--
 29 files changed, 526 insertions(+), 93 deletions(-)

-- 
2.49.0


