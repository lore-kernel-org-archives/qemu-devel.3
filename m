Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CF44C5478C
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 19:58:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reh6u-00010O-08; Mon, 26 Feb 2024 14:58:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1reh6n-0000ym-9A
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 14:57:53 -0500
Received: from mail-vk1-xa2e.google.com ([2607:f8b0:4864:20::a2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1reh6i-0004tD-9P
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 14:57:53 -0500
Received: by mail-vk1-xa2e.google.com with SMTP id
 71dfb90a1353d-4c7c5ea58acso371463e0c.2
 for <qemu-devel@nongnu.org>; Mon, 26 Feb 2024 11:57:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1708977467; x=1709582267; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=WqqXYo7+ux+g/Q4lCKmYBL6aMHSLc/dGIU3qQlOuOzw=;
 b=Yc0r5GFGa0p9Z70MRsEDa/+g367ra9sb5IKGWveLODn8mlAvh5ngEniFciI45RiJtx
 P1j7SaaF3pAS1WeH4JV1kSUSDnrggM7fh4015tOwkeLzweuTT3d8JNmz0XPWnf2QhTpY
 vMChbmihlhCcdyaKeoOAMDGoKDDMRp4nnuMPGylAy2A4j4iZX2YWwpwQOUwXpiZiKmYz
 HQk7tnaFyJ5q70cFMtX5TfHBHyy+iwHhcAztboQPt1Kn6aHq9zaISfo1v3zgZa0tRbNR
 THg+upx3rDrwYFh/xZJq9d376T2lEc7okid0Y0fR0Nq3Ho13y+RAcJQ2UNvG9Sp1ZjQp
 iYqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708977467; x=1709582267;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WqqXYo7+ux+g/Q4lCKmYBL6aMHSLc/dGIU3qQlOuOzw=;
 b=hAoKtju6FrYdYf4VfrmWe8lQJ8yjEVG9LG/AJMQxiBh3rVHRw2s4bhW/Z7+yykcGim
 wkIaf1cifP9ZHHfI8MgkQJPDuTWPXK6bjOq4uR9Qsp4de0injsd9tbNgmiwhqbgAlwW3
 oss8/WqshzKL8jJK6wWK1jflfhvEuMTuC/3KHbg+Z47G1k35Za7WnHSsaVwAy2r4hoz8
 ouU+Pmhwf6T5BmO4ZcH2jPaDEsSB1tbzZfkZ50bfUxj8rSGGMBi98ukYs+Ju2RkN1bxB
 NGUYzO+mCx9JIfJzdTAjd7ohnkNJ7edb1K0ZjcZDveJlJMW4xZgIt2OSEzWWVR+qX10Y
 eF3A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUe2oVZcP7p5rYMCeTwxpM3S8GI4e1wKp7HTr8Y7vDsbl1AwMfdc2pgYcCrIvTYhsCgIhpdKiyBC2TdWZ89mR+5LxSYcu4=
X-Gm-Message-State: AOJu0YzlowzV8oO6vMc0qz0BD3KmYxJaz6eI0ILUj/bOYk+T6gekIy0M
 th8HLp8LJ/0NShAwIfc9bPUPrDjPUysHGNzMNOnmvKoIlTeEuj+cLTEkWAR7ig0=
X-Google-Smtp-Source: AGHT+IEZzWPGJNYAsdmEtpJBxQQjOo48WPrYdGByvL+cxs5/CIl2mza+eGdQYsuwMdH27okHAV/Blg==
X-Received: by 2002:a1f:ea43:0:b0:4c9:75c3:e79b with SMTP id
 i64-20020a1fea43000000b004c975c3e79bmr4782387vkh.6.1708977466804; 
 Mon, 26 Feb 2024 11:57:46 -0800 (PST)
Received: from n231-230-216.byted.org ([130.44.212.95])
 by smtp.gmail.com with ESMTPSA id
 ej5-20020a056122270500b004ca3dc45886sm712738vkb.47.2024.02.26.11.57.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Feb 2024 11:57:46 -0800 (PST)
From: Hao Xiang <hao.xiang@bytedance.com>
To: pbonzini@redhat.com, berrange@redhat.com, eduardo@habkost.net,
 peterx@redhat.com, farosas@suse.de, eblake@redhat.com, armbru@redhat.com,
 thuth@redhat.com, lvivier@redhat.com, jdenemar@redhat.com,
 marcel.apfelbaum@gmail.com, philmd@linaro.org, wangyanan55@huawei.com,
 qemu-devel@nongnu.org
Cc: Hao Xiang <hao.xiang@bytedance.com>
Subject: [PATCH v3 0/7] Introduce multifd zero page checking.
Date: Mon, 26 Feb 2024 19:56:47 +0000
Message-Id: <20240226195654.934709-1-hao.xiang@bytedance.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2e;
 envelope-from=hao.xiang@bytedance.com; helo=mail-vk1-xa2e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

v3 update:
* Change "zero" to "zero-pages" and use type size for "zero-bytes".
* Fixed ZeroPageDetection interface description.
* Move zero page unit tests to its own path.
* Removed some asserts.
* Added backward compatibility support for migration 9.0 -> 8.2.
* Removed fields "zero" and "normal" page address arrays from v2. Now
multifd_zero_page_check_send sorts normal/zero pages in the "offset" array.

v2 update:
* Implement zero-page-detection switch with enumeration "legacy",
"none" and "multifd".
* Move normal/zero pages from MultiFDSendParams to MultiFDPages_t.
* Add zeros and zero_bytes accounting.

This patchset is based on Juan Quintela's old series here
https://lore.kernel.org/all/20220802063907.18882-1-quintela@redhat.com/

In the multifd live migration model, there is a single migration main
thread scanning the page map, queuing the pages to multiple multifd
sender threads. The migration main thread runs zero page checking on
every page before queuing the page to the sender threads. Zero page
checking is a CPU intensive task and hence having a single thread doing
all that doesn't scale well. This change introduces a new function
to run the zero page checking on the multifd sender threads. This
patchset also lays the ground work for future changes to offload zero
page checking task to accelerator hardwares.

Use two Intel 4th generation Xeon servers for testing.

Architecture:        x86_64
CPU(s):              192
Thread(s) per core:  2
Core(s) per socket:  48
Socket(s):           2
NUMA node(s):        2
Vendor ID:           GenuineIntel
CPU family:          6
Model:               143
Model name:          Intel(R) Xeon(R) Platinum 8457C
Stepping:            8
CPU MHz:             2538.624
CPU max MHz:         3800.0000
CPU min MHz:         800.0000

Perform multifd live migration with below setup:
1. VM has 100GB memory. All pages in the VM are zero pages.
2. Use tcp socket for live migration.
3. Use 4 multifd channels and zero page checking on migration main thread.
4. Use 1/2/4 multifd channels and zero page checking on multifd sender
threads.
5. Record migration total time from sender QEMU console's "info migrate"
command.

+------------------------------------+
|zero-page-checking | total-time(ms) |
+------------------------------------+
|main-thread        | 9629           |
+------------------------------------+
|multifd-1-threads  | 6182           |
+------------------------------------+
|multifd-2-threads  | 4643           |
+------------------------------------+
|multifd-4-threads  | 4143           |
+------------------------------------+

Apply this patchset on top of commit
dd88d696ccecc0f3018568f8e281d3d526041e6f

Hao Xiang (7):
  migration/multifd: Add new migration option zero-page-detection.
  migration/multifd: Implement zero page transmission on the multifd
    thread.
  migration/multifd: Implement ram_save_target_page_multifd to handle
    multifd version of MigrationOps::ram_save_target_page.
  migration/multifd: Enable multifd zero page checking by default.
  migration/multifd: Add new migration test cases for legacy zero page
    checking.
  migration/multifd: Add zero pages and zero bytes counter to migration
    status interface.
  Update maintainer contact for migration multifd zero page checking
    acceleration.

 MAINTAINERS                         |  5 ++
 hw/core/machine.c                   |  4 +-
 hw/core/qdev-properties-system.c    | 10 ++++
 include/hw/qdev-properties-system.h |  4 ++
 migration/meson.build               |  1 +
 migration/migration-hmp-cmds.c      | 13 +++++
 migration/migration.c               |  2 +
 migration/multifd-zero-page.c       | 78 +++++++++++++++++++++++++++
 migration/multifd-zlib.c            | 21 ++++++--
 migration/multifd-zstd.c            | 20 +++++--
 migration/multifd.c                 | 83 ++++++++++++++++++++++++-----
 migration/multifd.h                 | 24 ++++++++-
 migration/options.c                 | 21 ++++++++
 migration/options.h                 |  1 +
 migration/ram.c                     | 40 ++++++++++----
 migration/trace-events              |  8 +--
 qapi/migration.json                 | 48 +++++++++++++++--
 tests/migration/guestperf/engine.py |  2 +
 tests/qtest/migration-test.c        | 52 ++++++++++++++++++
 19 files changed, 393 insertions(+), 44 deletions(-)
 create mode 100644 migration/multifd-zero-page.c

-- 
2.30.2


