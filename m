Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27390C4829D
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 23:21:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXUjq-0006BI-9d; Tue, 06 Feb 2024 18:20:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1rXUjo-0006B2-Hh
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 18:20:24 -0500
Received: from mail-ua1-x934.google.com ([2607:f8b0:4864:20::934])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1rXUjh-0005h7-Rn
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 18:20:24 -0500
Received: by mail-ua1-x934.google.com with SMTP id
 a1e0cc1a2514c-7d5bbbe5844so2720998241.0
 for <qemu-devel@nongnu.org>; Tue, 06 Feb 2024 15:20:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1707261610; x=1707866410; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=CwvaGu7nGoerqbXwOafuEYJvW6/zzuvPXBf6xCZHMUo=;
 b=CBwSFrcMzefv+enGj5OMr7rOwa5lQ9byCSOnB1Dp4Z8JJFkoFrRcGM3E6OQjOHMYic
 AyEtJ3sa3LUGD7uR563T9OxemrXVJsrEZv8/obhfstyR/n7MAel4bRtWciiHlZ6BPbuH
 anVubowEk+Svne6K4MUN7PkuOk65hNvx2fIUi5AkOHrxMGfirSTis958tG/rTFYHKiVA
 cTZRvjW4D4cDG6/ShtXZ+gXszDKOVhUtG4X88mrTygC3y66SP7+OJkI1DbsWokzfa9gm
 KGepudY+0fxzsxZZLw7a5jad/sgOkMtwXOg7CLHypCOVMu3X/xX3WM2XIpWbSlHz0P1V
 FINQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707261610; x=1707866410;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CwvaGu7nGoerqbXwOafuEYJvW6/zzuvPXBf6xCZHMUo=;
 b=nYxa7Dwb9s0CWjKGPQ1woaQJFDkQMkHjH45zivwV4q/wcwhBNtMUaqLgQvaTzdLdF2
 2llvvsMOmgmkdpdQS4NoSyCH3EKJ3zWpKXSQa47z/ENjV3FY/MzJvXiYhLsnr9d7psZV
 de5IJj4H6vOwF8JDqednHU5KrIl8bW4GO4PxaJw6pycDKVNKeLBfbfwj22hry84TnsRj
 bYxIcqvRahU2/cxWIZJl96nzQx0Hp+7GBAfjoRT1kssN743bzLBzur8qc6RcQv2Qc0VV
 6nyXaZU6furpyTEXBABOOmlYmRk4NoYSLRAGaeNu0km8k2vhgUxVdI73iy3j3/mANyMC
 0mwA==
X-Gm-Message-State: AOJu0YwwPMQYKYbl+Rfr7VE3GCK+u4zYWNj3vpzE8FJjnMq4RIcIxs/a
 F3F9qoztPc8Y2Xi9VDWA/tHgdtWaNG9gFSsmdHHmSfut3C6d7lRfSXm15+ZjRU7rwdWmnT/nN1v
 qpS4=
X-Google-Smtp-Source: AGHT+IHgN+PP83BA7lcnu4Y+Zf4PjBj4sWOiFUlvostECUwmJ5QUlwAA02wsvn44/GJI9VFk/aA9/A==
X-Received: by 2002:a05:6102:3667:b0:46d:31c4:c4cc with SMTP id
 bg7-20020a056102366700b0046d31c4c4ccmr967564vsb.2.1707261610460; 
 Tue, 06 Feb 2024 15:20:10 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCWOS+zf/RilrGSYRgY3Olea4MYmIofaUOC13cMz7ZnvPqBJFXoYyz8h9vU6cY8WsexkzWnu22QHK7jEzDgaGf+Y3CHbbF6fe5IBo3nFoZkawppN
Received: from n231-230-216.byted.org ([130.44.215.112])
 by smtp.gmail.com with ESMTPSA id
 d11-20020a67b60b000000b0046d20ce8886sm2352vsm.1.2024.02.06.15.20.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Feb 2024 15:20:09 -0800 (PST)
From: Hao Xiang <hao.xiang@bytedance.com>
To: qemu-devel@nongnu.org,
	farosas@suse.de,
	peterx@redhat.com
Cc: Hao Xiang <hao.xiang@bytedance.com>
Subject: [PATCH 0/6] Introduce multifd zero page checking.
Date: Tue,  6 Feb 2024 23:19:02 +0000
Message-Id: <20240206231908.1792529-1-hao.xiang@bytedance.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::934;
 envelope-from=hao.xiang@bytedance.com; helo=mail-ua1-x934.google.com
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
2. Use tcp socket for live migratio.
3. Use 4 multifd channels and zero page checking on migration main thread.
4. Use 1/2/4 multifd channels and zero page checking on multifd sender
threads.
5. Record migration total time from sender QEMU console's "info migrate"
command.
6. Calculate throughput with "100GB / total time".

+------------------------------------------------------+
|zero-page-checking | total-time(ms) | throughput(GB/s)|
+------------------------------------------------------+
|main-thread        | 9629           | 10.38GB/s       |
+------------------------------------------------------+
|multifd-1-threads  | 6182           | 16.17GB/s       |
+------------------------------------------------------+
|multifd-2-threads  | 4643           | 21.53GB/s       |
+------------------------------------------------------+
|multifd-4-threads  | 4143           | 24.13GB/s       |
+------------------------------------------------------+

Apply this patchset on top of commit
39a6e4f87e7b75a45b08d6dc8b8b7c2954c87440

Hao Xiang (6):
  migration/multifd: Add new migration option multifd-zero-page.
  migration/multifd: Add zero pages and zero bytes counter to migration
    status interface.
  migration/multifd: Support for zero pages transmission in multifd
    format.
  migration/multifd: Zero page transmission on the multifd thread.
  migration/multifd: Enable zero page checking from multifd threads.
  migration/multifd: Add a new migration test case for legacy zero page
    checking.

 migration/migration-hmp-cmds.c |  11 ++++
 migration/multifd.c            | 106 ++++++++++++++++++++++++++++-----
 migration/multifd.h            |  22 ++++++-
 migration/options.c            |  20 +++++++
 migration/options.h            |   1 +
 migration/ram.c                |  49 ++++++++++++---
 migration/trace-events         |   8 +--
 qapi/migration.json            |  39 ++++++++++--
 tests/qtest/migration-test.c   |  26 ++++++++
 9 files changed, 249 insertions(+), 33 deletions(-)

-- 
2.30.2


