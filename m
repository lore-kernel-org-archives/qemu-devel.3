Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0800C48BF3
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Feb 2024 22:41:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rb6tF-0004lG-FC; Fri, 16 Feb 2024 17:41:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1rb6tC-0004kN-Dw
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 17:41:02 -0500
Received: from mail-vk1-xa29.google.com ([2607:f8b0:4864:20::a29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1rb6t9-0007BH-4R
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 17:41:02 -0500
Received: by mail-vk1-xa29.google.com with SMTP id
 71dfb90a1353d-4c02a647ed9so362944e0c.1
 for <qemu-devel@nongnu.org>; Fri, 16 Feb 2024 14:40:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1708123254; x=1708728054; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=BSrh0A6b1wzxyYV0aUTvyNr5QACCprfe6jGPgNTZNTw=;
 b=dwWTC224xTcscBJUIDx3MBlpZ85TUwVeyS9bQ97iAzDfrgO3a4ndKVcG2+FjRzMkQI
 zULJVlpoHUbxaVurUhCu7WlDzdKNYyqBqaCddVkCTXxkkG71kiXkHDrmpf8Qqa65SjcF
 EhorB1b8NlmmB2Wpz8rbv7MrbAgVZ8boCRp7BxZ073/G6jnjuE7LNk12NCRZpB4cpxld
 aS7OdCKlwsalVKR1TnEmZUu678r+BXKC+z9ak3LIMAnyOubUl9II9nbEZjKfVN6KmgNR
 x3TXv5kTeVx5pLxgLHc1RO/PV9JDJq8ZhDLSFVldodl0R+slMziZwHSsMyijuHBnYpAs
 fIxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708123254; x=1708728054;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BSrh0A6b1wzxyYV0aUTvyNr5QACCprfe6jGPgNTZNTw=;
 b=BYaGEcQyNqhPf+RPYqx91Dk63MVmagdK6n07D4b4Zm6h1AKkhGSiva2Q9XvRgp6Bm0
 EBsdGfF5n65gGvbV7PGcWeygekhBhmIzQTf0HfEOVQ4LEAbhuYDtkQGC0ARgaVg1Yr1w
 o6h8rGF6Gla7glTFRwKY5QMNBaYSjG5v10it4XU3zO6yVjK0AW4SczhgW8hrz/g+uwjz
 WQ/JcUqAga7SYXO0Y/7ja4uAYcv0hPWMgvBW3dQM7HcQN5FYzZd6JntX7Qow/f5muFhh
 RnLv8AX4FGafLlX4DWm21kmHkVqnPf+RgQ5+DlgbAVaaCNEIROdyEZK3LBH7tI834aGB
 mWPg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUGVV1cxPcRaGYWphNzHkKU1t8Zy5zecYQMy+hEsB9Ol+Egmho+Mf417Irw3/cHA4cVy1zKS9W5u8oC5h01fG2TaO+OO7I=
X-Gm-Message-State: AOJu0YyqXgVZKNGipwai+6yTcx7JiYT8gWI/V4tGcpCmsXPQZvfzbzE1
 p5eHo5RCiXPF06IB8PiXwe2BWJDwWHbJG0sOhoneY/As+5gPtx+WV0dmGxw1fJw=
X-Google-Smtp-Source: AGHT+IFDbFkNmRGkRu/DTWWn8MwFMqMJ9+Vtvm0HgLkW+kmeRk5fRPqAZ5F0VXHlI4XJkq5/taErzQ==
X-Received: by 2002:a1f:db44:0:b0:4c0:375a:d68 with SMTP id
 s65-20020a1fdb44000000b004c0375a0d68mr5831136vkg.11.1708123254344; 
 Fri, 16 Feb 2024 14:40:54 -0800 (PST)
Received: from n231-230-216.byted.org ([130.44.212.104])
 by smtp.gmail.com with ESMTPSA id
 cz18-20020a056122449200b004c0a12c4d53sm120991vkb.51.2024.02.16.14.40.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Feb 2024 14:40:53 -0800 (PST)
From: Hao Xiang <hao.xiang@bytedance.com>
To: pbonzini@redhat.com, berrange@redhat.com, eduardo@habkost.net,
 peterx@redhat.com, farosas@suse.de, eblake@redhat.com, armbru@redhat.com,
 thuth@redhat.com, lvivier@redhat.com, qemu-devel@nongnu.org,
 jdenemar@redhat.com
Cc: Hao Xiang <hao.xiang@bytedance.com>
Subject: [PATCH v2 0/7] Introduce multifd zero page checking.
Date: Fri, 16 Feb 2024 22:39:55 +0000
Message-Id: <20240216224002.1476890-1-hao.xiang@bytedance.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::a29;
 envelope-from=hao.xiang@bytedance.com; helo=mail-vk1-xa29.google.com
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
5767815218efd3cbfd409505ed824d5f356044ae

Hao Xiang (7):
  migration/multifd: Add new migration option zero-page-detection.
  migration/multifd: Support for zero pages transmission in multifd
    format.
  migration/multifd: Zero page transmission on the multifd thread.
  migration/multifd: Enable zero page checking from multifd threads.
  migration/multifd: Add new migration test cases for legacy zero page
    checking.
  migration/multifd: Add zero pages and zero bytes counter to migration
    status interface.
  Update maintainer contact for migration multifd zero page checking
    acceleration.

 MAINTAINERS                         |  5 ++
 hw/core/qdev-properties-system.c    | 10 ++++
 include/hw/qdev-properties-system.h |  4 ++
 migration/meson.build               |  1 +
 migration/migration-hmp-cmds.c      | 13 +++++
 migration/migration.c               |  2 +
 migration/multifd-zero-page.c       | 59 +++++++++++++++++++
 migration/multifd-zlib.c            | 26 +++++++--
 migration/multifd-zstd.c            | 25 ++++++--
 migration/multifd.c                 | 90 ++++++++++++++++++++++++-----
 migration/multifd.h                 | 28 ++++++++-
 migration/options.c                 | 21 +++++++
 migration/options.h                 |  1 +
 migration/ram.c                     | 50 ++++++++++++----
 migration/trace-events              |  8 +--
 qapi/migration.json                 | 47 +++++++++++++--
 tests/migration/guestperf/engine.py |  2 +
 tests/qtest/migration-test.c        | 52 +++++++++++++++++
 18 files changed, 399 insertions(+), 45 deletions(-)
 create mode 100644 migration/multifd-zero-page.c

-- 
2.30.2


