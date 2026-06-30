Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47558C43327
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 08:20:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weThX-0004uo-Si; Tue, 30 Jun 2026 04:20:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aadeshveer07@gmail.com>)
 id 1weThX-0004ug-8N
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 04:20:15 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aadeshveer07@gmail.com>)
 id 1weThV-0003JQ-IA
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 04:20:15 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2c82538b6b0so29119925ad.1
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 01:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782807612; x=1783412412; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=GJ2ssKQ9H5RnMd8orRpE+ODF24UM27/8/6P6NeYIp5E=;
 b=jv5uxKU2ERHJaNJTBnabCmxUhmpKhWavQL77E+ni/hl25MdjH+LSw6Jszk/XQp72+1
 X8VpjCSJmXWzaVquUTeitoilE7Wh4W7kFUbaz8xpqDmBkwz2D2BkNc1EwREEQ2aJ4O+s
 OZ6LoV1ggky8+XmEB2S5/PPew7Gvvtok0+m54lBVzpk/2QSxvbQ6jeCSZZjKdTys4Qap
 UT+YoYQByfTlf+GtW2fdjCxZcPSP839QV65AFklC7+J/r/sXZImLKwbPVImWGBMndo1a
 S3FFzcXjZAFqzoNl6182z/u4aaDDK9mhX7vbGvExqAGvU8dCvJ6AJoNoYW2CILgj9Hlg
 kmVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782807612; x=1783412412;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GJ2ssKQ9H5RnMd8orRpE+ODF24UM27/8/6P6NeYIp5E=;
 b=KO5nTQUmA6vBrgjY6Pm+2g36dDdWzsH6wSIYAS/sLXjkJ+cN4X/Fqvlde/6FdBTdga
 C8/0c2yvx/2jW7a5RjTQ8Cdzx/gjaX74iPYBk0mR62vZ4XDm4yLit82xqKUj9a18rXyF
 YSGTb+xJXrJbyTfUHK/2710Fa91TwuQ17SZlAmSNzLtafLMgjFS4VUbXf6lM8t1bIZcW
 zpzWRuIwNkKIO1kYM2J2cRHEVLbeEj9zOjHUhH9pTNSeL9mip4e4b+LJO+iejgM25vFw
 Ftq+IQCThcq65lk72Ohj8cd3ZDHuSpqxz6wrJZjS309TGIyQ5dA3oYLsMLczz5PoNepT
 cOdw==
X-Gm-Message-State: AOJu0YwwscBV5TWotWbXI/xz6itxlIJiEcqbGwhc3VtHCW0F7sSH6kNC
 FbiKjfd5pmqaGrZH62fpTNtOMVrOi0oIDMGYX94H4ysn1xSL3dgCBJ4wni7hHrNx
X-Gm-Gg: AfdE7cknznk74ZI+WuBSbuTC4DvyofOIGLhrgrP/MTt/vCrsZWShFX81h6T3NFXWkXk
 dG5Nk5QkLGzTdjdqwgh5z1XyNj3c8JP59sA+7Pk0Ce45IbiA/Tg9dhw18eUXIlaB/SJysCddtzA
 CLi6A5tN0LiGxkjfIyXIvt1iIifOOZG8DC8CmgY8csr09VPrhuicfHUSuT0ffEmO2xearnonHTz
 QG5A8rF9C6qHfNkGhSbmtQVHLWamhAE6zgCzqw9g99jvoWbMIGifKDrHanMlDHOFdwv3l4Jb/M3
 HAReRacfoqJYht+N33KqGGvru+fStSl5sE1Z6kCfd0wBkzSnc0g2kG61JnOcb5JcuhGTe2PMFX+
 4pf3NHNvuvtLe82hPseDdV1jyMmOVfgMUPeocMlQZWvCmXdV8IrSk/zqEA9M8pvWuK5IukVK9O+
 WNP3BUwkePfhLtoJt5yGOwyUHOjb3GbDNMJgUux6pM/K0=
X-Received: by 2002:a17:902:e5ce:b0:2c9:97a7:b1ef with SMTP id
 d9443c01a7336-2ca2ec2aa2fmr20496395ad.46.1782807611533; 
 Tue, 30 Jun 2026 01:20:11 -0700 (PDT)
Received: from setun ([2401:4900:a344:dc6e:573c:3e9:c03e:731a])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ca4f2a71dbsm1284615ad.50.2026.06.30.01.20.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2026 01:20:10 -0700 (PDT)
From: Aadeshveer Singh <aadeshveer07@gmail.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, farosas@suse.de, pbonzini@redhat.com, philmd@mailo.com,
 lvivier@redhat.com, ayoub@saferwall.com,
 Aadeshveer Singh <aadeshveer07@gmail.com>
Subject: [RFC PATCH v2 0/7] migration: fast snapshot load
Date: Tue, 30 Jun 2026 13:49:33 +0530
Message-ID: <20260630081940.611092-1-aadeshveer07@gmail.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=aadeshveer07@gmail.com; helo=mail-pl1-x62a.google.com
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

This RFC implements a "fast snapshot load" mechanism to significantly
reduce the perceived resume time of a VM from a snapshot file.

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

This patch was tested using a Debian 13 bare minimum system and Fedora
44 KDE, snapshots for both are loaded successfully with no error.

Next Steps:
- Add testing framework, in qtest and unit tests
- Update documentation

Future direction:
- Add support for hugepages
- Add support for multifd
- Add support for vhost-user

---
v1 -> v2

- Structure Change: Expanded from 5 to 7 patches
- Move test removal patch from last to first as suggested by Peter
- Patch 2 to 4 are meant to be non functional changes meant to prepare
  for actual feature Implementation
- Patch 3 and 4 from last series were squashed together into the
  final patch
- Improve error handling in postcopy_ram_incoming_setup() and
  postcopy_temp_pages_setup() for easier error handling
- Use pending_bmap for loading eliminating need of nonzeropages map
  as suggested by Peter
- Keep exit from qemu_get_buffer_at() in case the file has error as
  pointed by Peter
- Eliminate migrate_fast_snapshot_load() to prevent complication of
  capability matrix as pointed by Fabiano
- Add function ram_should_load_postcopy_pages() to improve readability
  as suggested by Peter
- Fixed comment for postcopy_mapped_ram_load_page() to align with
  auto documentation as pointed by peter
- Modify postcopy_mapped_ram_load_page() to return boolean for success
  and use errp for modular error handling
- Replaced use of TARGET_PAGE_SIZE with qemu_ram_pagesize(rb) for
  modularity and ease of adding hugepages support
- Add blocktime support directly and fixed a race condition on
  received map
- Add migration_incoming_has_postcopy_thread() to improve readability
  as suggested by Peter
- Moved the setup and run logic for fast snapshot from
  qemu_loadvm_state() to process_incoming_migration_co() for cleanliness
  as suggested by Peter
- Rename eager load thread to snapshot_load as suggested by Peter
- Use RAM_CHANNEL_PRECOPY/RAM_CHANNEL_POSTCOPY instead of hardcoded
  values for eager thread and fault thread load channels as suggested
  by Peter
- Reused postcopy_listen_thread_bh(and rename it to
  postcopy_incoming_complete_bh) as suggested by Peter
- Removed the bypass on process_incoming_migration_bh scheduling as
  pointed by Peter and Fabiano

Aadeshveer Singh (7):
  migration/tests: remove capability conflict test
    postcopy-ram+mapped-ram
  migration: Propagate error in postcopy setup functions
  migration: Use file_bmap for RAMBlock during incoming file load
  migration: Make qemu_get_buffer_at() thread-safe
  migration: add RAMBlock field and helper for fast snapshot load
  migration: add support for fault thread to load pages from disk
  migration: add eager load thread and setup for fast snapshot load

 include/system/ramblock.h          |   6 +
 migration/migration.c              |  33 +++-
 migration/migration.h              |   5 +
 migration/options.c                |   6 -
 migration/postcopy-ram.c           | 236 +++++++++++++++++++++++------
 migration/postcopy-ram.h           |   4 +-
 migration/qemu-file.c              |   5 +-
 migration/ram.c                    |  88 +++++++++--
 migration/savevm.c                 |  26 ++++
 migration/savevm.h                 |   2 +
 migration/trace-events             |   2 +
 tests/qtest/migration/misc-tests.c |  52 -------
 12 files changed, 347 insertions(+), 118 deletions(-)

-- 
2.54.0


