Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE07CCD98E4
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 03:21:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wa3JH-00082S-LJ; Wed, 17 Jun 2026 23:20:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aadeshveer07@gmail.com>)
 id 1wa3JF-00082K-4s
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 23:20:53 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aadeshveer07@gmail.com>)
 id 1wa3JC-0002AY-4I
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 23:20:52 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-c8584e80d59so194951a12.2
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 20:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781752846; x=1782357646; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=8PVACd2NJYYaipN9t07swcHm/mNe7Hk4LaX5UyIuo6Y=;
 b=GI9rbZo3Uxeg5rm4Rd415mIBHnbW8UGjhgwVcNZuCNEXvyoIn5sorFa+o2BXE5UhbG
 TNlXU5KHWP0pROxQrWmW+2OlqYNVladoDDgQGR5OcyGYk1rA5hiAppOScY5OXNeIUskZ
 OumTkNRYhNnoPr1e+d3g9T8+VGS7mGYEHFkeGtQEeEvYyPIu3PeahtOd3eH5JKXfEMb3
 JyhsAzppTLPf3hqC112FYiOuACMoZgWqqjMStZz6MGmj7gbhgniypLZVDjM5RFkpBh1d
 ZUHDDtSeYC4ldey89uGrgcycj4cJyBAGJuRuq5wg2j2Bx2tkxmVVs7N958Gbi+RvLEzd
 cXTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781752846; x=1782357646;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8PVACd2NJYYaipN9t07swcHm/mNe7Hk4LaX5UyIuo6Y=;
 b=ZRXKW2NsVJ7aHGtktuseRTnBI1RjCJNXE0s5i/WOvTC1G1flTTMtTWWf5rXzm4E8s4
 y8wVCA3es44nCps+jSG9PE8l30P8PMUfIFQB7dxg/A8R4v0nSg2hCijhINwxE7AUydaj
 itDDPJfhYXVvbRApus1Ype+4bmq7vLZg09XHq69GS/63xOYu1LzvRb+qauMo5ciH50y7
 vLFQv0Kliinbve+tyY7Bic27ovk5xQBzax6+sFw631gNBJ40iCIsA56B5OKmEC88y8DL
 /wCwGnmeOwNZNVKVxWmtFkYs2ipKByamb5Y+mm3YorSpaGgSA4I68EKpjWGBm/TCSBbj
 bszA==
X-Gm-Message-State: AOJu0YxtwbZnMlkmAsPybHpXwl1Uic4JUtjjm7TTpvw0CO88n+L4Eaac
 OQJFbcCQJCjcecxTchfYzBpfUlWisxpVa+sgHBD6Q+w8A8b7YdPCQI0mghOQdNJU
X-Gm-Gg: Acq92OGkJz/qmaxyyTaxhIpqO+7qzyA32kHlDob8qCHnB4remF6kkCeEBe3rn7H8z8E
 3SvC3G7t/v4K1yNvtsbqH/wf/iIQ7TTxXKCyNNgmmXNJ0TTGrKeKtKlZjImkRcog/ztgD33p8Yr
 6dxwzG012ZSw8BhfpVHyUbouNUIZkZfeXxnYLYb+Hp7+pymQBud6aOvq4EbWbUn+6sRc0DTjuRb
 CMl7EUXZxZejhC2UwdGO5BeYpRiogBw+7uFMB+qfl7OywpROEhSj5V536SRf6dCvMUrffVr59ay
 V/3G0wQvtUggOGKQG5VCDsI08BVrMxOcI0IcI29ZE3wkOa6A/f2hCAPP4cjfYjB/RIQftuTiXEj
 ssUGcNJ762vuW95cKNE6RIDj1c+6fG8qubvjuME4xooArKQB+KM2oANRTdjG5yMnIIV29vKdGV3
 Np6PGOwE7ERaTFcC2L9po1QfFdzBEdsL6JXsQFn6VxyA==
X-Received: by 2002:a05:6a20:ce4c:b0:3b2:86c9:baa5 with SMTP id
 adf61e73a8af0-3b8bf0ba4cfmr7528128637.38.1781752845903; 
 Wed, 17 Jun 2026 20:20:45 -0700 (PDT)
Received: from setun ([2405:201:502b:3014:cc0c:536:1b1e:6def])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c88c6c2b2easm1534623a12.27.2026.06.17.20.20.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2026 20:20:45 -0700 (PDT)
From: Aadeshveer Singh <aadeshveer07@gmail.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, farosas@suse.de, pbonzini@redhat.com, philmd@mailo.com,
 lvivier@redhat.com, ayoub@saferwall.com,
 Aadeshveer Singh <aadeshveer07@gmail.com>
Subject: [RFC PATCH 0/5] migration: fast snapshot load
Date: Thu, 18 Jun 2026 08:50:05 +0530
Message-ID: <20260618032010.88755-1-aadeshveer07@gmail.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=aadeshveer07@gmail.com; helo=mail-pg1-x532.google.com
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
source for a page it loads the page directly by reading form file. In
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
- Add support for postcopy-blocktime
- Update documentation

Future direction:
- Add support for hugepages
- Add support for multifd
- Add support for vhost-user

Aadeshveer Singh (5):
  migration: add RAM Block fields and helpers for fast snapshot load
  migration: add support for fault thread to load pages from disk
  migration: add eager load thread for fast snapshot load
  migration: write up code to run fast snapshot load in
    qemu_loadvm_state
  migration/tests: remove capability conflict test
    postcopy-ram+mapped-ram

 include/system/ramblock.h          |   8 ++
 migration/migration.c              |  10 +-
 migration/migration.h              |   5 +
 migration/options.c                |  11 +-
 migration/options.h                |   1 +
 migration/postcopy-ram.c           | 167 ++++++++++++++++++++++++++---
 migration/postcopy-ram.h           |   2 +
 migration/qemu-file.c              |  10 +-
 migration/ram.c                    |  61 +++++++++--
 migration/savevm.c                 |  52 ++++++++-
 migration/savevm.h                 |   2 +
 migration/trace-events             |   2 +
 tests/qtest/migration/misc-tests.c |  52 ---------
 13 files changed, 283 insertions(+), 100 deletions(-)

-- 
2.54.0


