Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7173FCD37BE
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 13:44:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMQ9H-00033q-Bj; Mon, 11 May 2026 08:54:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <inochiama@gmail.com>)
 id 1wMNCl-0006aV-Jy
 for qemu-devel@nongnu.org; Mon, 11 May 2026 05:46:28 -0400
Received: from mail-vs1-xe29.google.com ([2607:f8b0:4864:20::e29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <inochiama@gmail.com>)
 id 1wMNCW-0002jL-Mw
 for qemu-devel@nongnu.org; Mon, 11 May 2026 05:45:34 -0400
Received: by mail-vs1-xe29.google.com with SMTP id
 ada2fe7eead31-631a7868228so1244882137.0
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 02:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778492716; x=1779097516; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=uYN6cWY8lIbfsUp9D8wMCcQth753vG7tPWyzlMBowv0=;
 b=VOoMxNR6jf64AIFcGhYuFsNKVD7WY63gHUnmO0IusrWIIMX1jGCfsO9ge+68w2MP0M
 +0RsMGFyuH57XJzD/6IHtV+/LEMLqxxi3OPJjkmB/DIoOvWGcQgFP/y1IiKpnj2FIYT1
 NwjVpzgEarECtWQBbnL5YMhbHaO62Pjpg6s8cZ/LVzGnGnx/4vtI/gUWfAOC5zGfcuXw
 kJ6mOvbJKRQULDEDUL7jrTZYWgbePKb99HJqHSnkkt7QLb3Bfe5eEFTQzEzF7eZMnkaH
 gwWhQbNVZpU1cHlhCX8TFoR12qIQQnGM+NZub01crGRi8QQdPxRwvmL4a+FzC5ZQuPOr
 SksA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778492716; x=1779097516;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uYN6cWY8lIbfsUp9D8wMCcQth753vG7tPWyzlMBowv0=;
 b=RS9LZ+Qq6rcZFXRu0lWFvpxro6MGuoGTr4tMnL0RiBLz6/lS9FCKdwUc5EYsyHgj7p
 omPK6swpLROVqQyY4bMGVfPlNUboUsstTwSzG/pYii/v6qrQthO0JHvtAlBKu4GMyNlT
 wqWw9v+/jr0ci73QAlbrOYzJZH3F/cTwQXzvjBwi11N6sLsmybpbaqVJxpZOdQeyhXq9
 7/YTWQdYeB1bM3oV5zgYwVl0Z8PdcCG2KVTPoWRWwcdN9J0+d3Xbq6wdZRSfdah4ieiP
 6cP8yPYbZWP4PSQTwqLOeNpKuljnVcN6nz/HCYzzGxIBRjuTjSLyyYYv4vaDQevtN+0/
 52UA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+fBNTA/aXdrz2MSuBXFLaKya4Vj0BG4cbc+G4I6q0eoYcwOeq3/gMJ+W9u5DrbbaYQKtzU7AOrKfaE@nongnu.org
X-Gm-Message-State: AOJu0YxSVKKTMnuz2EYgvOUfdCwktpSrUf7U2xs9Qm9S2CwMtUP39yZp
 FVS1jWFDRPaMj5U3fInjI3AsPS2CjGzqRzgG4kZ6TpiFV6j+C3kF9Yah6qlGkGNBtvY=
X-Gm-Gg: Acq92OGKW1MRHur5RUOZc/uaS3ype54iHVBUKdVrxLnoBsz0Xla48WCyGNSnAVgktVh
 ZG4MEiLBzzxAOTn0F6djrvHLD5yEL084LhV9YzrRsyjxqJVYAP5vF8ZK/DIt+0upYEy+Lm3Gz0D
 EINAm9YV6qZn4GxQSsSTK53wDchwtplgypDXSY/u4/3Ki3EQrQe0CHgkpJp6PMHc2ASxqNWb0pe
 ysIoaZ3yVI9dWqekR3WVU5uIppxwZZzpURUr/MynDkUrr6pSlkB2yQwzbKiJHh5hETmCPZpew6+
 v0DNtEIleErfPrLkorT/aklY0SKkNw00G53Uy5sOVkz5mEQJY666kpvBpOcdrk3xBHdgShACqUM
 OSwJHn/BVFqiE4TCemplkAK+GRqx5uU4W7IhxSbGePB9YOv8FMV+rKLK1EPELjPCSU6Qz3xLXrm
 izXoY9miV5dXOLyOrlChsXYXI=
X-Received: by 2002:a17:90b:2d4f:b0:368:65bc:e32b with SMTP id
 98e67ed59e1d1-36865bce380mr2261073a91.15.1778488291988; 
 Mon, 11 May 2026 01:31:31 -0700 (PDT)
Received: from localhost ([2001:19f0:8001:1b2d:5400:5ff:fefa:a95d])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2baf1e358b2sm91352105ad.54.2026.05.11.01.31.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 01:31:31 -0700 (PDT)
From: Inochi Amaoto <inochiama@gmail.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>
Cc: Inochi Amaoto <inochiama@gmail.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH] target/riscv: Check PMP before updating PTE
Date: Mon, 11 May 2026 16:31:05 +0800
Message-ID: <20260511083105.641907-1-inochiama@gmail.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::e29;
 envelope-from=inochiama@gmail.com; helo=mail-vs1-xe29.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 11 May 2026 08:54:00 -0400
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

According to the RISC-V spec, the PTE update is a supervisor write
operations, and it should also follow the CPU PMP configuration like
the PTE read.

Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
---
 target/riscv/cpu_helper.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 39c3486ae0..6edce36138 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -1604,6 +1604,14 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
             return TRANSLATE_FAIL;
         }

+        int pmp_prot;
+        int pmp_ret = get_physical_address_pmp(env, &pmp_prot, pte_addr,
+                                               sxlen_bytes,
+                                               MMU_DATA_STORE, PRV_S);
+        if (pmp_ret != TRANSLATE_SUCCESS) {
+            return TRANSLATE_PMP_FAIL;
+        }
+
         /*
          * - if accessed or dirty bits need updating, and the PTE is
          *   in RAM, then we do so atomically with a compare and swap.
--
2.54.0


