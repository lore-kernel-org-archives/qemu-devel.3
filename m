Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2923FE6B27C
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2024 13:47:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6rz6-0002nf-KY; Fri, 01 Nov 2024 09:46:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t6rz5-0002nW-9z
 for qemu-devel@nongnu.org; Fri, 01 Nov 2024 09:46:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t6ryy-0001zA-VY
 for qemu-devel@nongnu.org; Fri, 01 Nov 2024 09:46:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730468791;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=+s8o9sMp+7kEXj8MErH9ngspxgY8A47CYDNHKRbs3Vo=;
 b=gd6QY2Aa/A1uf5KL1N+j6QjcPXShJFVLUiZ/EdN29fmkmnMIV/zAkyBurgNmoZ8xfLX7Er
 sfofdd+mntJ79ZrrMoMtabdqaqEbmVK87723ekgTGFXFd+VDvOwpAskAdmHOCKY7bQUhl8
 iC9zFQO1f7PxT/eAuhMEFWbHq1rq+Ec=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-115-i-df8JZzNgecxm8sFIqgPw-1; Fri, 01 Nov 2024 09:46:29 -0400
X-MC-Unique: i-df8JZzNgecxm8sFIqgPw-1
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-7b155e23851so337038085a.2
 for <qemu-devel@nongnu.org>; Fri, 01 Nov 2024 06:46:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730468788; x=1731073588;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+s8o9sMp+7kEXj8MErH9ngspxgY8A47CYDNHKRbs3Vo=;
 b=d2bVGx+Ru1Q8uZhhaSJNjqpdL1uURNTFvhBVMkJMY/Z6x0Bdoz1pcY69xSrack9KVT
 lDLicOVv2OaPo3F9AP8DgfSk+MKrpCFQaHhTZhCzMHV0VLlxqmIOCNERglDnIMARUft8
 tn3BMvBLeVIEDNA6MsaYTWkBNQud2GLLLBZQ5pCl6Jx1G73+K1fzOdD4uq73nIDuZO7j
 2avAouRylz4dL6orxn2mi02uJT99Z3NjxydviNQuV1EMgTD7bKMnpW5mumRDBSsmd2hb
 arMj4yMgBf36+mHZYRNWrI51AwJYv60Hw41HtU59JC6XYKvlUsdE9u3Rw0WQsyncYO1h
 /R8g==
X-Gm-Message-State: AOJu0YxoneZyVsonrlgpK/JwzBggu5mqh+QR4xWWPz15lhOCEwBkppol
 Cng/U1GjODJrZKoEhK7uStwz66x3w4ElLbX0oYD9TMEh80rXWV4p9/RjEKc3c9YichSns8+By55
 k8DFWRkXffE2WQiPE7BuNDWlT0cdUxPJ4WpZNJs3Vm0dk2G8vcS2pLRcda8Mh8gu/v50T2R3VTK
 yRYU9KeL+9JATtz0YnrAvjOBFhjAI1Dy8XkA==
X-Received: by 2002:a05:620a:1723:b0:7b1:113f:2e55 with SMTP id
 af79cd13be357-7b2f2555e3fmr933100785a.58.1730468787707; 
 Fri, 01 Nov 2024 06:46:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFLYA7Pt5nOF4Sk9PApXmXAbWJmnRbuRi67E98zr6sqIkWpj2RuYMiPq0a1BxyZnzZi2WZoRQ==
X-Received: by 2002:a05:620a:1723:b0:7b1:113f:2e55 with SMTP id
 af79cd13be357-7b2f2555e3fmr933097885a.58.1730468787250; 
 Fri, 01 Nov 2024 06:46:27 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b2f39f7b18sm172065585a.28.2024.11.01.06.46.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Nov 2024 06:46:26 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Fabiano Rosas <farosas@suse.de>,
 peterx@redhat.com
Subject: [PULL v2 00/18] Migration 20241030 patches
Date: Fri,  1 Nov 2024 09:46:24 -0400
Message-ID: <20241101134625.2240813-1-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The following changes since commit ea8ae47bdd2024dc2596f16b27f27fd4dcc08776:

  Merge tag 'pull-target-arm-20241029' of https://git.linaro.org/people/pmaydell/qemu-arm into staging (2024-10-31 13:28:57 +0000)

are available in the Git repository at:

  https://gitlab.com/peterx/qemu.git tags/migration-20241030-pull-request

for you to fetch changes up to 00b4b216534d84ace7b0583cec70a3aaf256cb25:

  migration/multifd: Zero p->flags before starting filling a packet (2024-10-31 15:48:18 -0400)

----------------------------------------------------------------
Migration pull request for softfreeze

v2:
- Patch "migration: Move cpu-throttle.c from system to migration",
  fix build on MacOS, and subject spelling

NOTE: checkpatch.pl could report a false positive on this branch:

  WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
  #21:
   {include/sysemu => migration}/cpu-throttle.h | 0

That's covered by "F: migration/" entry.

Changelog:

- Peter's cleanup patch on migrate_fd_cleanup()
- Peter's cleanup patch to introduce thread name macros
- Hanna's error path fix for vmstate subsection save()s
- Hyman's auto converge enhancement on background dirty sync
- Peter's additional tracepoints for save state entries
- Thomas's build fix for OpenBSD in dirtyrate.c
- Peter's deprecation of query-migrationthreads command
- Peter's cleanup/fixes from the "export misc.h" series
- Maciej's two small patches from multifd+vfio series

----------------------------------------------------------------

Hanna Czenczek (1):
  migration: Ensure vmstate_save() sets errp

Hyman Huang (6):
  accel/tcg/icount-common: Remove the reference to the unused header
    file
  migration: Stop CPU throttling conditionally
  migration: Move cpu-throttle.c from system to migration
  migration: Remove "rs" parameter in migration_bitmap_sync_precopy
  migration: Support periodic RAMBlock dirty bitmap sync
  tests/migration: Add case for periodic ramblock dirty sync

Maciej S. Szmigiero (2):
  migration/ram: Add load start trace event
  migration/multifd: Zero p->flags before starting filling a packet

Peter Xu (8):
  migration: Cleanup migrate_fd_cleanup() on accessing to_dst_file
  migration: Put thread names together with macros
  migration: Deprecate query-migrationthreads command
  migration: Take migration object refcount earlier for threads
  migration: Unexport dirty_bitmap_mig_init()
  migration: Unexport ram_mig_init()
  migration: Drop migration_is_setup_or_active()
  migration: Drop migration_is_idle()

Thomas Huth (1):
  migration/dirtyrate: Silence warning about strcpy() on OpenBSD

 docs/about/deprecated.rst            |   8 ++
 qapi/migration.json                  |   7 +-
 include/migration/misc.h             |   9 +-
 include/sysemu/cpu-throttle.h        |  14 +++
 migration/migration.h                |  19 ++++
 migration/ram.h                      |   1 +
 accel/tcg/icount-common.c            |   1 -
 hw/vfio/common.c                     |   2 +-
 hw/virtio/virtio-mem.c               |   2 +-
 migration/colo.c                     |   3 +-
 {system => migration}/cpu-throttle.c |  70 ++++++++++++++-
 migration/dirtyrate.c                |  11 ++-
 migration/migration.c                | 128 +++++++++++----------------
 migration/multifd.c                  |   8 +-
 migration/postcopy-ram.c             |   6 +-
 migration/ram.c                      |  19 ++--
 migration/savevm.c                   |   3 +-
 migration/vmstate.c                  |  13 +--
 net/vhost-vdpa.c                     |   3 +-
 system/cpu-timers.c                  |   3 -
 system/qdev-monitor.c                |   4 +-
 tests/qtest/migration-test.c         |  32 +++++++
 migration/meson.build                |   1 +
 migration/trace-events               |   5 ++
 system/meson.build                   |   1 -
 system/trace-events                  |   3 -
 26 files changed, 254 insertions(+), 122 deletions(-)
 rename {system => migration}/cpu-throttle.c (65%)

-- 
2.45.0


