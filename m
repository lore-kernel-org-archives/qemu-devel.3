Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19A31C44501
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 14:17:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjdvu-00063t-3W; Tue, 14 Jul 2026 10:16:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aadeshveer07@gmail.com>)
 id 1wjdvr-00063P-8s
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 10:16:23 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aadeshveer07@gmail.com>)
 id 1wjdvp-0002Rq-1j
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 10:16:22 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-c88a4d79ba5so2826384a12.2
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 07:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784038579; x=1784643379; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=iByIrf6cnf6RLgCJmPhq33X61HE16g3FSxQImtPh8Ok=;
 b=esiwnoSdFpVxaGflG5j5a7m3qHYdRfxA4hU+5YAGQmcDpkVZualRBjHj6M1WxeQlod
 WqKGwMisOlHzCL6nifuooA0CKtlhLWmoEpKhn6bYumW59As/33VU1uNPWvFWosiDvQlk
 pnxNRhlPGuUo4h2FjmLkyZSZ2mpS/dXHKL4t0ZAHiKTuRqvp5DKBqyM1IHE8jgqloE8Y
 zrJnDi2vmG6VLnIx2tiuhSfKSSarmU3TU9N6+wihoWWrtZrmDa2UqMRlFHa/7Hgl/E5G
 3vqcOoyWwgv1TnlEZooOwE0b0+tl+l1x0LwK+VzmV7iAShkpUz9TsgVZdDTJR2NFQUMz
 akkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784038579; x=1784643379;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=iByIrf6cnf6RLgCJmPhq33X61HE16g3FSxQImtPh8Ok=;
 b=tQAk1ALDHXZHHpMtHAQIyD83F9DNZzSB+EU/OuBtyZKx6fzyaoPjpkiOA9c9fILBvV
 iFuifAPSCiSePdplfHx7dn8pf9tqRCQzg84iwKlY3d0lW6qtKH7SleBqNVy8rlTf2Cuw
 rV1TAa+2IHLibr8gO0pQT76i3R02aTYs+4qFVOV3EdIzsUd/Tly6sbp4er5X/KgeNvrI
 jd3ePyOS32sLskIap+9TxaTv4MqWXGcmHW52q0rqISrHEhd9IXAX/XueGlN15uAvmvRV
 3Is55gOjTSbrWU4bszK4FvPJ5U6hzsH8Wf1DFTCAWtKc39hpzoLoLRPnthGxy+WqFVB3
 Njog==
X-Gm-Message-State: AOJu0Yw8MLOJ7Tp+OGoePdwMwXOCB3JZsmaQS1jj0XrG86iJCqYR5gZw
 6t7KeuCOdr/KDYIK7iGuCUEZPET/fTQU4DdCs+2GF00z786SdIVf4Zfa2DkH1i0l
X-Gm-Gg: AfdE7ckNrt8g5c1n5e+VUbLZE00w5DqDgVhru4XCidZi8lqLRxjwWhhrjlS6ETVqJRK
 870xbIOoEZBrEHZ89nK6R7cBbbPaMhKAMkVQCX/iuLcij2vUaA538FtZT3TesRcQCJZE2Kn4Y75
 Bwo7FqB0pHnE/IpN2wpdWDFUNcuVsyo3Awy3kskF6siiPgeZbg+HpYN1Km3raDsIPzm/OuzhEz5
 JUyrXR7MXcpVHQBOb5eT+YmuxZbaUa4lv1FiYqwaxTm4fYboTb7R2EYYi2Fq+kAH9ubQBlLeYP6
 pV1S4LNAHi0ZWn1oleJzmdmhIfbxqPfpLCZtnmpeZR213tlbRV+gfZLeZTU87g4LgNc0EI1WXbA
 JWku5FjwJVlunjpILPMg64fX0e/IPMTaNCXEoobhICT0iTtIliQD5myH3kUDUPDoM3ISmbsqJHk
 RtoOUAr2SvNdPvnMdxS6Ni9wyW+s2/cPsgMSE7dxDdaA==
X-Received: by 2002:a05:6a20:e293:b0:3c0:9c19:6588 with SMTP id
 adf61e73a8af0-3c357650950mr3031611637.66.1784038578500; 
 Tue, 14 Jul 2026 07:16:18 -0700 (PDT)
Received: from setun ([2405:201:502b:3014:cc0c:536:1b1e:6def])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3118ee6091dsm97329733eec.14.2026.07.14.07.16.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2026 07:16:17 -0700 (PDT)
From: Aadeshveer Singh <aadeshveer07@gmail.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, farosas@suse.de, pbonzini@redhat.com, philmd@mailo.com,
 lvivier@redhat.com, ayoub@saferwall.com, pierrick.bouvier@oss.qualcomm.com,
 Aadeshveer Singh <aadeshveer07@gmail.com>
Subject: [PATCH v3 00/11] migration: fast snapshot load
Date: Tue, 14 Jul 2026 19:45:36 +0530
Message-ID: <20260714141547.1268000-1-aadeshveer07@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=aadeshveer07@gmail.com; helo=mail-pg1-x530.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

This series implements a "fast snapshot load" mechanism to
significantly reduce the perceived resume time of a VM from a snapshot
file.

Currently, resuming a VM from a snapshot file requires loading all RAM
pages into the QEMU instance before execution begins. This extension
allows the user to run the VM nearly instantly by loading only the
required device states up front and loading RAM pages lazily, by
trapping access to pages that have not yet been loaded.

Using the Linux userfaultfd syscall, a fault thread catches all page
faults caused by the guest and loads in the pages required to keep
the VM running. Concurrently, an eager background thread iteratively
loads all remaining pages into RAM so the guest does not have to
depend on the fault thread indefinitely.

Much of code is reused from postcopy for fault handling and precopy
for reading mapped ram file. Implementation revolves around two
threads named the fault thread and eager load thread. Fault thread as
name suggests catches page faults by the guest and serves them using
userfaultfd. Postcopy fault thread is reused but instead of requesting
source for a page it loads the page directly by reading from file. In
order to remove the dependency of guest on fault thread indefinitely
the eager load thread loads in the entire RAM sequentially, and after
iterating through the entire RAM signals fault thread to exit and
calls cleanup.

In order to prevent the case of a page being loaded twice(in the
case when eager load thread is loading it and fault thread also
tries to serve fault on same page) a bitmap called pending_bmap is
used to track pages which are pending and not being loaded by any
thread. Atomic operations on this bitmap allows coordination between
threads to prevent any unwanted behaviours

Future direction:
- Add support for multifd
- Add support for vhost-user

---
v1 -> v2

- Structure Change: Expanded from 7 to 11 patches
- Move test removal patch from first to post implementation as
  suggested by Peter
- Patch 1 to 5 are meant to be non functional changes meant to
  modernize parts of code and prepare for feature Implementation
- Patch 10 performs a smoke test for implemented feature
- Patch 11 adds a documentation page for fast snapshot load
- Added explicit fails for features not supported/incompatible with
  fast snapshot load in compatibility check in options.c as suggested
  by Peter
- Passed errp object to qemu_get_buffer_at() to improve on error
  reporting as suggested by Peter
- Size of pending_bmap is updated to have a bit for every guest page
  according to guest page size and not host page size as pointed
  by Peter
- New function(ramblock_file_bitmap_page_is_nonzero()) has been
  introduced to test for zero pages while loading essentially enableing
  support for hugepages
- Updated the documentation comment over postcopy_mapped_ram_load_page()
  to add errp as pointed by Peter
- Added a new function try_mark_postcopy_blocktime_begin() to call
  mark_postcopy_blocktime_begin() taking care of assumptions like
  skipping if page is already received to improve on the readability
  as pointed by Peter
- Fixed bug, that sent non page alined addresses to
  mark_postcopy_blocktime_begin() as pointed by Peter
- Separate the postcopy_listen_thread_bh() rename patch as suggested
  by Peter
- Add comment explaining changes in process_incoming_migration_co()
  as suggested by Peter
- Make qemu_loadvm_run_fast_snapshot_load() and
  postcopy_ram_eager_load_setup() return void as these functions
  never fail as pointed by Peter

Aadeshveer Singh (11):
  migration: Propagate error in postcopy setup functions
  migration: Extract blocktime marking helper
  migration: Rename postcopy_listen_thread_bh
  migration: Use file_bmap for RAMBlock during incoming file load
  migration: Make qemu_get_buffer_at() thread-safe
  migration: add RAMBlock field and helper for fast snapshot load
  migration: add support for fault thread to load pages from disk
  migration: add eager load thread and setup for fast snapshot load
  migration/tests: remove capability conflict test
    postcopy-ram+mapped-ram
  migration/tests: Add test for fast snapshot load
  docs/migration: Add documentation for fast snapshot load feature

 docs/devel/migration/fast-snapshot-load.rst |  81 ++++++
 docs/devel/migration/features.rst           |   1 +
 include/system/ramblock.h                   |   6 +
 migration/migration.c                       |  60 +++--
 migration/migration.h                       |   5 +
 migration/options.c                         |  14 +-
 migration/postcopy-ram.c                    | 266 ++++++++++++++++----
 migration/postcopy-ram.h                    |   7 +-
 migration/qemu-file.c                       |   9 +-
 migration/qemu-file.h                       |   4 +-
 migration/ram.c                             | 103 +++++++-
 migration/ram.h                             |   2 +
 migration/savevm.c                          |  16 ++
 migration/savevm.h                          |   2 +
 migration/trace-events                      |   2 +
 tests/qtest/migration/file-tests.c          |  24 ++
 tests/qtest/migration/misc-tests.c          |  52 ----
 17 files changed, 511 insertions(+), 143 deletions(-)
 create mode 100644 docs/devel/migration/fast-snapshot-load.rst

-- 
2.55.0


