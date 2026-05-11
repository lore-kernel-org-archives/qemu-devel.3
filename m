Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CA29CD484C
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 14:07:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMRFZ-0007kB-SO; Mon, 11 May 2026 10:04:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wMRFW-0007Sm-93
 for qemu-devel@nongnu.org; Mon, 11 May 2026 10:04:47 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wMRFU-0006z6-6l
 for qemu-devel@nongnu.org; Mon, 11 May 2026 10:04:45 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-c827313dac0so793432a12.1
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 07:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778508282; x=1779113082; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=WoXb1qHiFjG88rozyUXPqjRhmxRLpmhaX1BhDPn+Cu4=;
 b=mmw7BGl27xGWdnFxyGmb5uoE+4fzITuWQX9LlpVjOE55LhYaDLdInGHr35iARLevXK
 0HKFDY7y+GziA9RDFuft8xbQbByf4kNM8OJ12ACB6kjGDoGEMK//lBSP5LDWn4HTBKkO
 1gYilxjlV/I39jf3YfU9oFNh/5S6dyOU7CsL/0zsp4vZWukZo3WUmrAzzq8oPjbmwa/I
 z3CON7O9KNfEB2fneFGfhccHT5+p1bopFGaLR5beCoKyFfHV5DG1PEY8G/hOYF1i9sLC
 sQX+qSs5bBPlf4KJ8cSv0YMrDjxQssd9RZQh0O0iBqks+PrhelynjWyyNRXowldYEtYM
 tCpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778508282; x=1779113082;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WoXb1qHiFjG88rozyUXPqjRhmxRLpmhaX1BhDPn+Cu4=;
 b=rqvUzHa/reoAnqv4dhTHhh+B17ytDHvTIKWiYGVD3mYENfy8dWiUDY95628mNTo2ex
 imGwx8y9pFEVhSM65llMpQuuFm2YWZq/8HQHPTwsEitJb5n7/+vRQp4Kx8HKhGyO6ooi
 jODEd4ror3oEgf9pgJ2Pddkq4Y9PCcpGE9ANRW2k8QKiTGPRvUmyEg6rk/BcTsM+/R5U
 RoWy2u9LYodwT1GkqEqGDJ9XQqfU3AOKBgadV3sMTJ5iXhj9vXTErnC/9kg5uvX/N7Dt
 ikkwUx0v0ZbuTt1OmLEnvGp7TgvEhexLVwoGV8QGvCGZy+lOhUMTSA1+fS0TxozzhCVC
 h0jg==
X-Gm-Message-State: AOJu0YxsjsSD0hjtk++TNrMYXlt6Fk8An7NjZKEVYU7b2YTihSYZPXM2
 ArvJx809AKKJABfwzka9PinmcNPJ/QiuI/NN48HExfr36z8sTihiTCEHZHtLsqbOfH4=
X-Gm-Gg: Acq92OHjDkRpHPSS4wZKoyL/3trKGYVdvnN4chCKPzTc7WJt53DMUPJRPTR1dbuChjN
 hG7/OlIrbHOlJbriZj1GYxA78iXnGOSHbzqHmzPcIIfaPJJHrvThJWjIfqbpv2BBDwWHWDbyBry
 89B+gU68anS5jaWX3poHJiDfoVzNtBXlUhiPCkP2IMjSgcqC2nGpcCrfbd+5Fqv0nhIEiMP3tVY
 mZS6kaGBMvlD3P4eKPY/JtzUqXZMtboKVmdmyJJX9Mx1lfW8ctpK7vY+Rpfp8giu5bK87+89d+5
 3apq2L7ypvmry1XrzEkEYuL1CvM8HWzMhLS1Xhw6YhYqX9U/PUrdulehV2MkAYA0Ed2kmd8Ieez
 FpOOM1LL+a9JpnEqVYbjqJD+BJocUA5HI14pkfgcLYl+iS67iUdC+UYH+5z+LSl+J36abkpfmI3
 XDrApOk9Sg/x/ra2nQ1yNNL0d5Ql00NM+FLuP+A1m2oL0hJQ==
X-Received: by 2002:a17:903:1d2:b0:2ae:5ab4:f4c0 with SMTP id
 d9443c01a7336-2babcbab873mr176016465ad.13.1778508281518; 
 Mon, 11 May 2026 07:04:41 -0700 (PDT)
Received: from ZBMac-LWN10QXKQ0.taila0cd24.ts.net ([115.108.63.147])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2baf1e90854sm105113435ad.66.2026.05.11.07.04.37
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 11 May 2026 07:04:40 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH V7 00/14] iothread: Support tracking and querying IOThread
 holders
Date: Mon, 11 May 2026 22:04:02 +0800
Message-ID: <20260511140416.28271-1-zhangckid@gmail.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=zhangckid@gmail.com; helo=mail-pg1-x536.google.com
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

This series introduces a "holder" tracking mechanism based on QOM paths to  
significantly improve IOThread observability. In high-performance 
virtualization environments, users often pre-allocate a set of IOThreads to  
serve as a persistent thread pool. During device hotplug/unplug cycles, while 
IOThread objects remain persistent, their attachment state changes dynamically.

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



### V6 -> V7 Changelog
  - Fixed comments issues in patch 02/14 (Thanks Markus).
  - Removed redundant code.
  - Rebased patches on upstream code.
  - Fixed code conflict with latest patches.
  - Added detailed description in git log and code.
  - Added comments for patch 06/14 assuming the monitor is a QOM object,
    Depends on Daniel Berrangé's RFC patch:
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



Zhang Chen (14):
  qapi/misc: Fix missed query-iothreads items
  iothread: introduce iothread_ref/unref to track attached devices
  iothread: tracking iothread users with holder name
  blockdev: Update tracking iothread users with holder name
  block/export: track IOThread reference in BlockExport
  monitor: Update tracking iothread users with holder name
  virtio-vq-mapping: track iothread-vq-mapping references using device
    path
  virtio: use iothread_get/put_aio_context for thread pinning
  net/colo: track IOThread references using path-based holder
  virtio-balloon: Update tracking iothread users with holder name
  vfio-user/proxy: Update tracking iothread users with holder name
  xen-block: Update tracking iothread users with holder name
  qapi: examine IOThread attachment status via query-iothreads
  iothread: simplify API by merging iothread_get_aio_context variants

 block/export/export.c                   |  44 +++++++--
 blockdev.c                              |   6 +-
 hw/block/dataplane/xen-block.c          |  10 ++-
 hw/block/virtio-blk.c                   |  13 ++-
 hw/scsi/virtio-scsi-dataplane.c         |  13 ++-
 hw/vfio-user/proxy.c                    |   7 +-
 hw/virtio/iothread-vq-mapping.c         |  11 ++-
 hw/virtio/virtio-balloon.c              |  14 +--
 include/block/block_int-common.h        |   5 ++
 include/block/export.h                  |   6 ++
 include/hw/virtio/iothread-vq-mapping.h |   6 +-
 include/system/iothread.h               |   9 +-
 iothread.c                              | 113 +++++++++++++++++++++++-
 monitor/hmp-cmds.c                      |  22 +++++
 monitor/monitor-internal.h              |   3 +
 monitor/monitor.c                       |  24 ++++-
 monitor/qmp.c                           |   3 +-
 net/colo-compare.c                      |  18 ++--
 qapi/misc.json                          |  71 ++++++++++++++-
 19 files changed, 342 insertions(+), 56 deletions(-)

-- 
2.49.0


