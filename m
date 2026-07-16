Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FC5DC44512
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 17:21:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkPm1-0005ne-Q0; Thu, 16 Jul 2026 13:21:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wkPm0-0005nR-Kt
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 13:21:24 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wkPly-0000OS-ND
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 13:21:24 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-385ea3ce80dso6869664a91.2
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 10:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784222481; x=1784827281; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=fyCweveiMcF5+9aMC7UjhUodRU/B4uG1N/Id96U7mcQ=;
 b=ecStCwUWT0iRqdl7pZlwvW5eav31mfIZpPZpuCNzE1RhuyV5Dx9/NciG5Py+h9z5ge
 AVFCLb8ne+ajJQM6rcSJNQ+aohjYtIPxPeOj/reDzS9jR+WPWfVdqdiYfrxsQRZv4/LT
 QLOOQNI/bWgns0sQKyq2+UdR2M/AK5rQsbIvQFAOuzOJXvY2CN5yY4xEfE29lRDGMtp1
 fGivhQLFV/QXesVXBfGicRpEFkH9u0E5UL57ZfP0+McJu+ak+ytW18AaIepp52R8B8S9
 Di/hBqcowf6tQYSgPRHbA47HuNub9RJxGPcM2gq2YR8ESn4RRExewW5nOug+UAZNDABI
 9EIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784222481; x=1784827281;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=fyCweveiMcF5+9aMC7UjhUodRU/B4uG1N/Id96U7mcQ=;
 b=RxRafbBf6lsux0hwj4cKTN0g2UbJHdF1ZVk1DOMamBPMRMOQHm+eLHNbWGcDZT4pPc
 abD2/RImUWMWOSUaJ0V3Ej5pTD3r/vPTjiuHlOJ9w9NNuTg8It4Wg1bOljnPJYZXJdiR
 pQ5aVMdanrWyiqsrcZlMWicU+333JEv7R2bYOXaaaLEJrcUu1d6oMAvPeEaYz8v/9eBu
 xJ11sEhD4goUP8afx2Oxdg46a/IJV9VkqXhb70OZdBuiR9Bf0tNYamnwiomGmJS6fiiG
 PLMezg0G6Tly3fAzI+mkVfUuSqeqIbw3Ih3T4jOJIrjCT4tgNHn+hozaubBAO1waXgnh
 +SVg==
X-Gm-Message-State: AOJu0YwWb/5rMfwDowQywoyDqvIUvMQHR5+dUeKYyumOxqZAG//7JHdb
 QdZloP4THCLiFeviXsM24HFLKa1e8ghMmTnSrNqoY46zjdXKt/LDFhPes+gpo3XfhVI=
X-Gm-Gg: AfdE7cn9T5gz5hIcpp9VxC5oQud4goRPPILGf1y6e6qVklZriV9F9c8R0j+Yl14TEe3
 HhANZ8tIqKebpPcsTmNNTczOSTesBMr79sQAr2OyWIavKP8cf++g0DtWhhxzvH54K5vHy49L32W
 VfpX32mTL7O6bnNF6SS+0iV7jDI56AlXGPs+FlQ1O/xM8zbSQhj/179UWXUrfqI7gkCgYc8J+EP
 x4XIsLPKEMYTbl1qSlBXojK10TDd5N4WLF41Ms1rBfTWcwO+i/X9PkegPkCHjZB4BhNfufvRVuu
 JgmeBmn73upOFOwreP30A0JDrPA66en450+/prg7WwD7JWCw+QdyrTkw2Cd2vyHWSAPfwr71R59
 rauogw5WIJmPAjUqWJVcQQyuzazzlzDEmrOPDX7tCEH4L7kjmmzJ4Y5oxM7Igj9/NxIclsTXE0W
 DTKHheHheRObVid7l/p5Pi1bLwQWhF2Q==
X-Received: by 2002:a17:90b:3dc4:b0:37f:9cdf:f0ab with SMTP id
 98e67ed59e1d1-38e17e440edmr10955703a91.26.1784222480970; 
 Thu, 16 Jul 2026 10:21:20 -0700 (PDT)
Received: from ZBMac-LWN10QXKQ0.taila0cd24.ts.net ([104.28.233.73])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3140e5326c0sm16800417eec.11.2026.07.16.10.21.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 16 Jul 2026 10:21:20 -0700 (PDT)
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
Subject: [RESEND PATCH V10 00/15] iothread: Support tracking and querying
 IOThread holders
Date: Fri, 17 Jul 2026 01:20:41 +0800
Message-ID: <20260716172108.87700-1-zhangckid@gmail.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=zhangckid@gmail.com; helo=mail-pj1-x102b.google.com
X-Spam_score_int: 26
X-Spam_score: 2.6
X-Spam_bar: ++
X-Spam_report: (2.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
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
 monitor/monitor.c                       | 26 +++++--
 monitor/qmp.c                           |  5 +-
 net/colo-compare.c                      | 29 +++++---
 qapi/misc.json                          | 71 +++++++++++++++++-
 tests/unit/iothread.c                   | 16 +++--
 tests/unit/iothread.h                   |  6 +-
 tests/unit/test-aio-multithread.c       |  5 +-
 tests/unit/test-bdrv-drain.c            | 18 +++--
 tests/unit/test-block-iothread.c        | 21 ++++--
 23 files changed, 478 insertions(+), 81 deletions(-)

-- 
2.49.0


