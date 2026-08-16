Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0055EC5B572
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Aug 2026 17:47:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvews-0007kw-Vx; Sun, 16 Aug 2026 13:47:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aadeshveer07@gmail.com>)
 id 1wvewn-0007gZ-LW
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 13:47:04 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aadeshveer07@gmail.com>)
 id 1wvewl-00032m-QK
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 13:47:01 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2ceaf8a1265so40224275ad.2
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 10:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786902417; x=1787507217; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Go5VZEFr0u73mQnlfIXokkVl33nf7PSPOK3E7rBckhQ=;
 b=OvsNuR0aCcsptLUiOeniyW+aeGS+lSqr7LJEt/rDHQAtfO7V+dlVJlYWl2jq3bnjyM
 1vW1ZrlN2ZNdXgcelQfnCExch363QU9P3FpP446yE9tAGqfBAExwRble3CY0+bHBe5Fd
 IJQ2ippYc1guA5s0WFBzqTAhvgTa1tH2vkxu+q2rLtW4RcwFkVmLYV5sM/gHIctDB5IO
 +Ypvtw5HExfv3TyIo7+EUgXmG6Uagh2RJhLPn2tVslTqvlG4J+7hjn765xfwnkd+0uY0
 JZdPw8g2B1HF8DrrZnUVpGdvx0f6FgNi+dLnFWNeFfHJLrXojzGVmGkSB4CsuG2UHyTR
 Ym/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786902417; x=1787507217;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Go5VZEFr0u73mQnlfIXokkVl33nf7PSPOK3E7rBckhQ=;
 b=AzHaiH8nz1PzP9jHjlImAhXJUCjouApjPLPJ+r8xj3Oa+Ci8lQU6P2ierwg6bMxJo1
 YFilho7c+eD8Ojnu+FfImempkbYUe52/BR9yYxps6TXo1hM5w9UbUX/3UfPvfICVmYxS
 TxHQhaP51M6YlxR0p7XxHt6YEow11JE1Y8ZLB10uL6xzRp+h4WKY+C5yBu9F0yO3jr53
 GnthFcS7yskDzd5ps0fqib6oSV4JWxgnEFDSyaFkfWNeyqA4/nEjsSqpj/0vOGy5JBPd
 u+kRQDu5Vy+uu2mnsBwxkkU03d3wlrK+QBI+hqvlc1BZxrMWHcPW3XWintc2iMElZWvh
 rxMA==
X-Gm-Message-State: AOJu0YwXZXufz8SEghAg8uPJSMp8k95Aq7VqJ2S4pFU1HPBE+SKNwptU
 JPNcaUw9rzyCXMtcjFkmMFKQ701DGVtvIppntv+wJdbzKsRg/wyUoW30gxa3Jg==
X-Gm-Gg: AR+sD10z9MfcTIl8qFgY6lqQaoDbP5TZ7hXSU7xixhKsd+pGJUbNxzmSzR0WKNYxo8p
 XvU+JOrx69GNIkf21raQr23zTo1flZfa9tsrGXZezbcGWanes+2k1TD2sLCFv6vgE3ocDSCj7Qh
 3e394fgCuNsGKlaNgNrxG36Akj2/+843YjWbHIGz5inHkjpVk+J12Sd7i3BHFWw7o1NeiETCUFM
 EzAw615XL5C1LcFg/HQFN9n3XZrQtmVlKhCRVlsNDeoC5cA6PV5vDMUhZMytLd3Uc1C82RhmZKU
 ZZB82X7ZommwdNSnf8swh+pV7Mvw5NgEdJqGE/cniL+fAeEfObaVCk1KIsV3QkUiRkNJpRWBD9u
 5UVpCgZHYmc5HK9sdrmOBy09Af6Xf6oM+vgnAm/Z2f8k823yl0uwJ5+9I76NdX3Sl3X2pc9sFKg
 cJYkTHe/TWeuL33unyoB+u//ZovE5Zk3BrLalRhH8MeTL8NBcfnqGYLUlAFxxWWjTWQWErTX4Wx
 XHghb1FSL2wnhs=
X-Received: by 2002:a05:6a20:b40b:b0:3bf:9aa9:b2a4 with SMTP id
 adf61e73a8af0-3cc71d71cdcmr22274271637.20.1786902416890; 
 Sun, 16 Aug 2026 10:46:56 -0700 (PDT)
Received: from setun ([223.228.54.80]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-320ead105a9sm28343674eec.31.2026.08.16.10.46.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Aug 2026 10:46:56 -0700 (PDT)
From: Aadeshveer Singh <aadeshveer07@gmail.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, farosas@suse.de, pbonzini@redhat.com, philmd@mailo.com,
 lvivier@redhat.com, ayoub@saferwall.com, pierrick.bouvier@oss.qualcomm.com,
 Aadeshveer Singh <aadeshveer07@gmail.com>
Subject: [PATCH v5 00/11] migration: fast snapshot load
Date: Sun, 16 Aug 2026 23:16:20 +0530
Message-ID: <20260816174631.1547811-1-aadeshveer07@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=aadeshveer07@gmail.com; helo=mail-pl1-x633.google.com
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
- host using 2MB hugepages
  guest OS  : Debian 13
  guest RAM : 16GB(16KB pagesize)
  guest CPU : 4 cores(x86_64)

Future direction:
- Add support for multifd
- Add support for vhost-user

---
v4 -> v5
- Modify pending_bmap(Patch 6) to use variable size for better
  efficient atomic state management
- Added a comment(Patch 7) explaining postcopy_mapped_ram_load_page
  explaining why cases where guest page is larger than host page are
  disabled following what remote postcopy follows
- Add a new check(Patch 9) in migrate_prepare to bail out if migrate
  was used with fast snapshot load enabled, as suggested by Peter


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
 migration/migration.c                       |  66 ++--
 migration/migration.h                       |   5 +
 migration/options.c                         |  20 +-
 migration/postcopy-ram.c                    | 333 +++++++++++++++++---
 migration/postcopy-ram.h                    |   8 +-
 migration/qemu-file.c                       |  11 +-
 migration/qemu-file.h                       |   4 +-
 migration/ram.c                             | 101 +++++-
 migration/savevm.c                          |  16 +
 migration/savevm.h                          |   2 +
 migration/trace-events                      |   2 +
 tests/qtest/migration/file-tests.c          |  24 ++
 tests/qtest/migration/misc-tests.c          |  52 ---
 util/notify.c                               |   5 +
 18 files changed, 597 insertions(+), 143 deletions(-)
 create mode 100644 docs/devel/migration/fast-snapshot-load.rst

-- 
2.55.0


