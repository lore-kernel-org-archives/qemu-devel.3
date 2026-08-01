Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62045C5516F
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Aug 2026 02:37:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpzan-0000zi-JC; Fri, 31 Jul 2026 22:36:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aadeshveer07@gmail.com>)
 id 1wpzal-0000zU-Q9
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 22:36:51 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aadeshveer07@gmail.com>)
 id 1wpzak-0002TY-1t
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 22:36:51 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-383cb94f742so1619845a91.3
 for <qemu-devel@nongnu.org>; Fri, 31 Jul 2026 19:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785551808; x=1786156608; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Uhmcq3yottUrqtH1+lqIIyV++HT1uJb3VqGZ8iCAfUA=;
 b=hdAp0SH3Gvrsyfzmmhn3XLG4NwNCypfm9p8rEadjJcS0Z5YjZ4G5c2AstRlWO+dicX
 WePGqMQ7upBAm63TuIF9bt+TfFa/EmcV5Z+QOC3V7dtEMkK6L54y+KkxFRF2XZgmxr1G
 u4fJiE4CIjoifIypnfV8dOI3QUXnUaWm0i0NrTkhJpYoYf/F4HZk1NlVSsH0FoOKbcfT
 O1XUAvntW0YP429+383WqDgrHIpSECUtIPwG3VbTYGsB5/f35sGpIcClx1UzfQlYPo/F
 uG5NjD+ux4KGjo+tBtnqYlHHOQfQ0gAUFuiqjAc184DbofKEesKfFHWVqlcHvIDeWbOl
 6Gtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785551808; x=1786156608;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Uhmcq3yottUrqtH1+lqIIyV++HT1uJb3VqGZ8iCAfUA=;
 b=Hs81u5lWA+e6gLu8uira0Xfp7m94wOPkk1yJ33mc+pmPzZp4ilWVYvJdK+B2fXaG4M
 lgGK1Uwa/lUWaYb3V+1rGQTufpYZCduSqKaG/+vVHvma8JKg+is/w9o9iQdN1GmPlcVH
 Llsvxljlz5qscpah3w14nOMk8FKvO9otym6D+DKhg2Bd68TqF19CYalvD4ofjugAnvFg
 M0AoxYmXqkyLzrv36kayre2VgCBF5n6hl2fwfy2Z3jnvyC+QMwSdk4mAF22gBE/ExVQv
 AIYmGbIR+4jgtMkUJGSnLivS/OkPH3CT0tEN3oDKXoLh++vuulV1nO08VrQBKMNSjCPv
 g7og==
X-Gm-Message-State: AOJu0YxS5RN2775pI+aFRbuB3sFaKx28TSaWcHeu1HuFCCaYsEFTkmJT
 FY+DVsGHQh6S5GH5Beys3D2wpvuSp/KqOcZI2X3WJeqrrUb/HPsC0Wbogb0PNUDY
X-Gm-Gg: AR+sD12LfywlUBH+FwwRjjJKS/9Y2qIfgmcoF5YdSTLDfLdZnwfQHnJ4+xfPQhuRhrV
 0FVQTxDetNaRAv2efQnzvNdp42Kj5zz7Wgqies80B5OsXNYXGlrJKU4nOPgm+1bZL6TYYIVIkSc
 Z6uxZ3SHNGKajr0KtDnYYvFHPhJsqCFBUMn7JsBCU8R0J9L0kiW0SIeNECdN9g3Xjr5QE0E3bUS
 pBRpp2eML3YnlBghA8bWd4cwiOWjD5XPwo8WY53MGKndPkc9S4bJdlAfLhCbsN1U8CPPbJ6Na21
 xf+dsw+RZ/Yonk0aN1DOxFunYSRpDlwjT4KqV8cA6ewa2cE54uBNa74qcK/4TjOMd4f/GdtNGxX
 S12st+yfzM5gOWFt23/93WVVC2YVIZsnPktbKSwUob9oBhjDRASYX/feRr//BXupncM/i5+qTrO
 1BHYHEsEThfNUTfAL+ks3iluYTpHxK1laCaYTKk9w2TSaDaMRnL3I7dGNmXwF4CzkQzz/2m8PVI
 ozx1Ud9yCrMBPsbbMBqhzv6H017
X-Received: by 2002:a17:90a:dfcb:b0:38f:5828:857e with SMTP id
 98e67ed59e1d1-38fbc493a09mr1835021a91.16.1785551807980; 
 Fri, 31 Jul 2026 19:36:47 -0700 (PDT)
Received: from setun ([223.228.61.127]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3153dd4e47dsm15678889eec.3.2026.07.31.19.36.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jul 2026 19:36:46 -0700 (PDT)
From: Aadeshveer Singh <aadeshveer07@gmail.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, farosas@suse.de, pbonzini@redhat.com, philmd@mailo.com,
 lvivier@redhat.com, ayoub@saferwall.com, pierrick.bouvier@oss.qualcomm.com,
 Aadeshveer Singh <aadeshveer07@gmail.com>
Subject: [PATCH v4 00/11] migration: fast snapshot load
Date: Sat,  1 Aug 2026 08:06:17 +0530
Message-ID: <20260801023628.22665-1-aadeshveer07@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=aadeshveer07@gmail.com; helo=mail-pj1-x102b.google.com
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

This patch series was tested on a single machine:
host OS   : Fedora 44
host RAM  : 32GB DDR5(4KB pagesize)
host CPU  : Intel Ultra9 185H(22 cores, x86_64)

Guests tested:
- KVM enabled
  guest OS  : Fedora 44
  guest RAM : 16GB(4KB pagesize)
  guest CPU : 4 cores(x86_64)
- emulated power PC
  guest OS  : Debian 10
  guest RAM : 2GB(64KB pagesize)
  guest CPU : 2 cores(ppc)
- host using 2MB hugepages
  guest OS  : Debian 13
  guest RAM : 16GB(16KB pagesize)
  guest CPU : 4 cores(x86_64)

Future direction:
- Add support for multifd
- Add support for vhost-user

---
v3 -> v4

- Set errp in qemu_get_buffer_at on failing if file is in failure
  state to ensure errp is set if a function returns failure
- Update logic for postcopy_mapped_ram_load_page in patch 7 to support
  all possibilities of guest and host pagesizes as pointed by Peter
- This also improves on correctness by not relying on mapped ram
  filling zeropages with zero values as pointed by Peter
- Simplified postcopy_ram_eager_load_thread logic in patch 8 for exit
  as suggested by Peter
- Use a more generalized language in documentation overview as
  suggested by Peter
- Added a check against vhost user in case of fast snapshot load in
  options.c(Patch 9) as suggested by Peter

Aadeshveer Singh (11):
  migration: Propagate error in postcopy setup functions
  migration: Extract blocktime marking helper
  migration: Rename postcopy_listen_thread_bh
  migration: Use file_bmap for RAMBlock during incoming file load
  migration: Make qemu_get_buffer_at() thread-safe
  migration: add RAMBlock field and helper for fast snapshot load
  migration: add support for fault thread to load pages from disk
  migration: add eager load thread and setup for fast snapshot load
  migration: update capability conflict test for postcopy-ram+mapped-ram
  migration/tests: Add test for fast snapshot load
  docs/migration: Add documentation for fast snapshot load feature

 docs/devel/migration/fast-snapshot-load.rst |  82 +++++
 docs/devel/migration/features.rst           |   1 +
 include/qemu/notify.h                       |   2 +
 include/system/ramblock.h                   |   6 +
 migration/migration.c                       |  60 ++--
 migration/migration.h                       |   5 +
 migration/options.c                         |  20 +-
 migration/postcopy-ram.c                    | 324 +++++++++++++++++---
 migration/postcopy-ram.h                    |   8 +-
 migration/qemu-file.c                       |  11 +-
 migration/qemu-file.h                       |   4 +-
 migration/ram.c                             |  94 +++++-
 migration/savevm.c                          |  16 +
 migration/savevm.h                          |   2 +
 migration/trace-events                      |   2 +
 tests/qtest/migration/file-tests.c          |  24 ++
 tests/qtest/migration/misc-tests.c          |  52 ----
 util/notify.c                               |   5 +
 18 files changed, 575 insertions(+), 143 deletions(-)
 create mode 100644 docs/devel/migration/fast-snapshot-load.rst

-- 
2.55.0


