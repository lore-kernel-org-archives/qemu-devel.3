Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 803E6C5AC67
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2026 20:27:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ws4fm-0003pK-58; Thu, 06 Aug 2026 16:26:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1ws4fi-0003nP-V1
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 16:26:35 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1ws4fg-0004xS-3a
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 16:26:34 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-caf45fc5202so2374647a12.1
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2026 13:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786047990; x=1786652790; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=lzt7knpSW3b8SlHPUDfkbZil2zz9fEOzo8g7wKSrz58=;
 b=S2Rln6fhKH5rtjUDjh7CT9y4BM+22QsU1SH2pjFqHt9Ij3Y0JNLkdTViOMq+4Qz3va
 DTBeEZjFayrzM3bziS5iJUxtWoywSfWupwA9B9TQtRTD/urTvMkaknBkgIEIOTGL3da5
 h0o9++LSvWD+mpzi2ZJ42cFe2ipVh2zPO0/tX7yYsFFFV1YJez3bh8kbBdZqNM1ZQQ1+
 RklGtO1TjHKfZ9PaCQgguSmEQUNRZKGLNLM6FdUclTBTtf6Wx3jFy63rAUiqRmrIjUPM
 C+HS88zaO4SspkcVMGIWT1aEXjK7HjIsqbTyQ6JYUf5leN5A9gs0wfTjc3P1dRNwp442
 CaRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786047990; x=1786652790;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=lzt7knpSW3b8SlHPUDfkbZil2zz9fEOzo8g7wKSrz58=;
 b=jcq0Ehs+/iNx2lRmKc6ZLV6GivT2KK1BedOmwGQgqh5P7bD2rz9dmrUT1nU130k/yP
 SQ1tSobfARDUz7amkOVLkt/EQ2b0V9UKh/MCDK3sCJEzSEn36yivaSLK/NP1mRMScMXe
 4zXKB8LMHm3zKrwI7BgmiGt7iDz0xKxQXgrBSNq0JbvqKXCFjWcOrIvncyU6HA+iyHs5
 lwWqU+hjK3UrvutJB55DZO+MxZjzBQJ71JHWdpED6EIiF2gqLR3iq/90jBADLirQW6Uj
 qBXE1Eby8q6wzyb7sD5f5gVv8p5EhKWu7Lrm7yjvmV+GjxNJ8NPKco6hJMHilbJWMX5X
 gp7w==
X-Gm-Message-State: AOJu0Yx7DYxmENG2HEUQPCQ6pXY5URkDC2frXLmgYLmLbhl0Y/gDN9tm
 secHEUqQYOJF44lGtPq/U4GpP+n5QY7QriXjQRKAa9QgIw4wLQD/qZ+2qJzOO3NT/HXuFep5
X-Gm-Gg: AR+sD10LRO2qtJ0BndbcHmRLaZhMAJC/peb2IEzRLywH+YcGhJ3gvmGw8kR8PXvQm1Z
 77edqbY09qTVznF7TjUNPS7YTA2V69ojxNHg4XoVBZ3Q6Rn91WVRQlK4hkowhwr0z4OzpMfRE+7
 K5atSQ3F42oBd2J3iCyCJzMGMW4qcJtR/1ovJxM5pOtuIp5uncvYc9eKb9OdNOdoE5ftUgvdrjl
 r12Qvi4AcWaLpD+anR2s6o774zS5SdW9beV9Rlstmoz1dIu3UzBOB1Y42BVIl1ZXfM895iAYKss
 5DaUs/JFgqlcI8dZvLVUpLrGg5aiiwveGtIKgyB+BjyajKg1iYIAIRNgFf3uxnNCdq6grBYQyjs
 R7S2Tr8gv/ENd6vJo1+xvQSYqHZFOTA0Owndoe/QrCHukv2bAsYwWg3ADb8FbBbf+3P4plaeCq+
 CGTULesbOY36w0BmIosHy9oUB0ff9V4EwBFZRRxoQuTM8o8HB3y817oEydfthf8o+FwX1TW5deo
 /qXXTx5pQC9Ra6L
X-Received: by 2002:a05:6a20:da1b:b0:3b4:9171:2573 with SMTP id
 adf61e73a8af0-3cb85ffd847mr22772770637.37.1786047990256; 
 Thu, 06 Aug 2026 13:26:30 -0700 (PDT)
Received: from t-kidd-X299-AORUS-Gaming-3-Pro.lan ([104.28.201.73])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-315863fd2b3sm33140471eec.7.2026.08.06.13.26.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2026 13:26:29 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?=27Daniel=20P=20=2E=20Berrang=C3=A9=27?= <berrange@redhat.com>,
 Jason Wang <jasowang@redhat.com>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH V11 00/15] iothread: Support tracking and querying IOThread
 holders
Date: Fri,  7 Aug 2026 04:25:09 +0800
Message-ID: <20260806202531.243806-1-zhangckid@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=zhangckid@gmail.com; helo=mail-pg1-x533.google.com
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

  Add a QAPI holder list to each IOThread.  A holder identifies either
  a QOM object by its canonical path or a block export by its unique
  BlockExportOptions ID.

* Explicit reference lifecycle

  Add iothread_ref_and_get_aio_context() and the matching
  iothread_put_aio_context().  Acquiring an AioContext registers a
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
  query-iothreads.  Display the same information with info iothreads,
  while omitting the holders line when the list is empty.


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

 block/export/export.c                   | 79 +++++++++++++++++++---
 blockdev.c                              |  2 +-
 hw/block/dataplane/xen-block.c          | 19 +++++-
 hw/block/virtio-blk.c                   | 21 ++++--
 hw/scsi/virtio-scsi-dataplane.c         | 22 +++++--
 hw/vfio-user/proxy.c                    | 16 ++++-
 hw/virtio/iothread-vq-mapping.c         | 20 ++++--
 hw/virtio/virtio-balloon.c              | 22 +++++--
 include/block/export.h                  |  6 ++
 include/hw/virtio/iothread-vq-mapping.h |  6 +-
 include/system/iothread.h               | 37 ++++++++++-
 iothread.c                              | 88 ++++++++++++++++++++++++-
 monitor/hmp-cmds.c                      | 22 +++++++
 monitor/monitor-internal.h              |  3 +
 monitor/monitor.c                       | 26 ++++++--
 monitor/qmp.c                           | 16 ++++-
 net/colo-compare.c                      | 29 +++++---
 qapi/misc.json                          | 86 ++++++++++++++++++++++--
 tests/unit/iothread.c                   | 17 +++--
 tests/unit/iothread.h                   |  6 +-
 tests/unit/test-aio-multithread.c       |  5 +-
 tests/unit/test-bdrv-drain.c            | 18 +++--
 tests/unit/test-block-iothread.c        | 21 ++++--
 23 files changed, 505 insertions(+), 82 deletions(-)

-- 
2.53.0


