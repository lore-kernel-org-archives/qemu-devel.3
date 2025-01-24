Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C146C0218B
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 10:16:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbGiW-0002bU-2F; Fri, 24 Jan 2025 05:15:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1tbGiO-0002Wm-LF
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 05:15:04 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1tbGiM-0007pn-Qx
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 05:15:04 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2166022c5caso30210225ad.2
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 02:15:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1737713700; x=1738318500; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=726JYc2EOYPtf39xK4E0IwFh2U+9H3MDOohIfk12nUI=;
 b=IlrePebfSX4wg2vDQWIKOIjRnk3xaXdNJux226vjF6JVWTmQOgrQQO+pb3cA05WHlS
 BUlzWSOVn1h8YEDu2OaIQgVFs5fm7Qs7jSPh5tBeF3zMSOl9w7G9r+idQT1Wr+6lqulf
 lOjcCJVw0sylBroHPtNEJQPUXtp4Run4hJrrc0nyb8sUb5x57qdy9CuI24ft7cDRhQ7m
 N2Y7ZTJndWdPMNiXomQhUiwubF8ZDKdW9x4RBjCZa6FkXSRX7KIWFWkkSE43VywLyu6a
 YDZJiaNYpzJChKScXh+t2maLlaRmBxHtrBXUMBdSzB0JzJhEpKCXRkV8agpdkFCHFW6W
 d7lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737713700; x=1738318500;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=726JYc2EOYPtf39xK4E0IwFh2U+9H3MDOohIfk12nUI=;
 b=H5Wi8/p3v9gLXChBIi74Bt1pFyhZagcalIpr/QqxfqtCcQgdN6E2ZSzZlLUI639E5z
 1iGqKro0GKoOHONlEHMbxyGKLk0VFD2QXrOwW0u2qZiKxkslxykDuhxvqFXKf4w4Mj99
 r6askjSSdWwd8Snc3y7LR0+qOrkI4FbqRmCKmA0JWNuNlNI/oA5Zo8Z7LVVSywbMlmU3
 CLovyu5/FAecV8HgR9WeNrZslSW7KPI+hj2I5WFUAfY4ohJFW4DreV5NVnsmbHsPyqwQ
 dp0C7rN0vOGk/KvZj3Jpspcs/U/hvVfgoNU9g3uGFGaBOPIbKpsNl4m3+0qQe1rc/Pn6
 9oFw==
X-Gm-Message-State: AOJu0YxwzmQiRSkt5owa2v4cloi5ZyWSJ5zfHhz7G3WOK/nNNRXC/u3i
 kh4UpZNgqudQ+ueU1QKvUHdPOKcCeZcFKS3IYC1kKpMd/N6yrfVHI/X+R0OkYqfS57pAzFwK/eE
 cW2qs5zqwMfezLvG6TFkbnW44AytpkPx/xoi8WAagjl/D4LLR9NRRnDGoxIi1ouayfN1r7sO33j
 E3og+KMmlywzUbJvbPS4K/xTbkm8pdLIb3x+MPBw==
X-Gm-Gg: ASbGncuKOCUsy1g3Z7H74SWYvr6NCxhM89eEl/P9vWcUmB/svdHL0HRXIcrhtrLRjt2
 FBqHHDiYwwVeO303rE3atqIKDqDGxd1bO1UfFpIvymWTIgWA5YGOp/zeqfTC+4R5q/whUouM6vI
 MBIlPE/SI3jq8d3OrN6Mogk0WeQXT44JRJqulNaWMMmHKMN2xEH5448DVCKyDJtIZAXerbqg5Ul
 4ob4nUsr1fJI9BLc44ZDvVAEnENlf3uMVyPj6tlx+9j4S4qC/lirbJ/UO79Id4ZLaWLs6q820gg
 ZO1mne0nWHsATn2WYzQwNFNLmvKnDf5p+xaZWcciCMr8Zsb7Nw==
X-Google-Smtp-Source: AGHT+IF5/O9f0U22I7akfqHnEXp6zoaRQ2aXvubjD+5ok+uDqU/B79QZrIEddie1r59UfmcgpBitMA==
X-Received: by 2002:a05:6a20:7f8e:b0:1e6:8f39:d635 with SMTP id
 adf61e73a8af0-1eb2146009bmr44951682637.9.1737713699157; 
 Fri, 24 Jan 2025 02:14:59 -0800 (PST)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72f8a69eb75sm1521502b3a.12.2025.01.24.02.14.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2025 02:14:58 -0800 (PST)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Max Chou <max.chou@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: [PATCH] target/riscv: rvv: Fix unexpected behavior of vector
 reduction instructions when vl is 0
Date: Fri, 24 Jan 2025 18:14:47 +0800
Message-Id: <20250124101452.2519171-1-max.chou@sifive.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=max.chou@sifive.com; helo=mail-pl1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

According to the Vector Reduction Operations section in the RISC-V "V"
Vector Extension spec,
"If vl=0, no operation is performed and the destination register is not
updated."

The vd should be updated when vl is larger than 0.

Signed-off-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/vector_helper.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 5386e3b97c5..7773df6a7c7 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -4659,7 +4659,9 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1,          \
         }                                                 \
         s1 = OP(s1, (TD)s2);                              \
     }                                                     \
-    *((TD *)vd + HD(0)) = s1;                             \
+    if (vl > 0) {                                         \
+        *((TD *)vd + HD(0)) = s1;                         \
+    }                                                     \
     env->vstart = 0;                                      \
     /* set tail elements to 1s */                         \
     vext_set_elems_1s(vd, vta, esz, vlenb);               \
@@ -4745,7 +4747,9 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1,           \
         }                                                  \
         s1 = OP(s1, (TD)s2, &env->fp_status);              \
     }                                                      \
-    *((TD *)vd + HD(0)) = s1;                              \
+    if (vl > 0) {                                          \
+        *((TD *)vd + HD(0)) = s1;                          \
+    }                                                      \
     env->vstart = 0;                                       \
     /* set tail elements to 1s */                          \
     vext_set_elems_1s(vd, vta, esz, vlenb);                \
-- 
2.34.1


