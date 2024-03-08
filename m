Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73ABDC54E5C
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 11:13:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riY9S-0006bA-VG; Fri, 08 Mar 2024 06:12:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1riY9O-0006ZB-SQ
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 06:12:30 -0500
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1riY9I-0001Qh-QP
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 06:12:29 -0500
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-5e42b4bbfa4so477603a12.1
 for <qemu-devel@nongnu.org>; Fri, 08 Mar 2024 03:12:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709896343; x=1710501143; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5YioOzPq6dtbeSZOgq1vL0KqpugyX6Ofr7K2JZKU12I=;
 b=T4lgGraNPoiRzbotKLoWCSZdjvl1iDyOrwdKmq8ezU1PAac1N2qbV/453SlbMkJRu0
 YPgQeGriuvo/Y68tM+4XkvtZ750CbcYWsDR++5yjhvTj5QwUyoz/Sf7M7dSRMh+9n0Ci
 b5OScSHtLpbvRmI0rKS9ItqHB0L9S/tM2m1kN5vF6DG+wPLtL75kkArT8rJyBzWRih4p
 bVwNZkrXllB1QtRK3wdAt8M/e45fvPH0+R0XGSp4KBNNFsfqZry4IjImJ77DOTZBHbQM
 OloBVRSepLKU0cVhd/ojp93/go3PvU52K3VOTWgfI5mvKn2NLqlNvkaBfeBTaSDV412w
 9sYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709896343; x=1710501143;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5YioOzPq6dtbeSZOgq1vL0KqpugyX6Ofr7K2JZKU12I=;
 b=o4y6ukOX+es2XXmzyB14JEVJdNk/Fe6BDIQxzQ+VoUwkSMJCSiiX0PmuK9q3Afy+Tb
 RrHt143aHay+bA6Trj9HAOWCuWYlwdzmJWa4Fkdmb2ROGw4o12TzEqzQGEDYjsZ90X5u
 qjoV4joZ3zekYi8gs4m3Q964OL2EhL0MRyXKipAipGcVbza6ct1S56snm+p7sUjtFkGJ
 +QfOqwRjTmtYT2fPoRmGWwuPpBhdN0fkdBqL0l42MpdnJx2DirCCMlbydck0ZX8fjF2G
 YxUUhRXrYblBlMM4XvGK3lQAJ2JEdGWnRoyG6wJHfnubUfKu0VR0GVxm3MpomwukZx11
 iRPA==
X-Gm-Message-State: AOJu0YxF98ZsprquxL+8DSPyIa9RILBWI+P8Vi7Ud3Vkwz3nDtmhv8+w
 yKjjl3GB0pJdZLL+qOLevqPN9z5tR3iBziq8AMR1N32hstM1EpAPun6cEiZ42qe4Zg==
X-Google-Smtp-Source: AGHT+IGCzmAHbldIPGnKIRz/25j2l7X8eOZmOkRnqCN573FJnXvaB0ArnhcIochVFSQMoa55oHnofw==
X-Received: by 2002:a05:6a20:6d90:b0:19e:bca3:213f with SMTP id
 gl16-20020a056a206d9000b0019ebca3213fmr8796418pzb.52.1709896343114; 
 Fri, 08 Mar 2024 03:12:23 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 a6-20020a170902ecc600b001dcfbbb1ca5sm12006468plh.35.2024.03.08.03.12.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Mar 2024 03:12:22 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
 =?UTF-8?q?Christoph=20M=C3=BCllner?= <christoph.muellner@vrull.eu>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 06/34] linux-user/riscv: Sync hwprobe keys with Linux
Date: Fri,  8 Mar 2024 21:11:24 +1000
Message-ID: <20240308111152.2856137-7-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240308111152.2856137-1-alistair.francis@wdc.com>
References: <20240308111152.2856137-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x533.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 UPPERCASE_50_75=0.008 autolearn=no autolearn_force=no
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

From: Christoph Müllner <christoph.muellner@vrull.eu>

Upstream Linux recently added many additional keys to the hwprobe API.
This patch adds support for all of them with the exception of Ztso,
which is currently not supported in QEMU.

Signed-off-by: Christoph Müllner <christoph.muellner@vrull.eu>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Message-ID: <20240207115926.887816-3-christoph.muellner@vrull.eu>
[ Changes by AF:
 - Fixup whitespace
]
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 linux-user/syscall.c | 100 +++++++++++++++++++++++++++++++++++++++----
 1 file changed, 92 insertions(+), 8 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 81801f3dff..09239d2288 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -8808,14 +8808,42 @@ static int do_getdents64(abi_long dirfd, abi_long arg2, abi_long count)
 #define RISCV_HWPROBE_KEY_BASE_BEHAVIOR 3
 #define     RISCV_HWPROBE_BASE_BEHAVIOR_IMA (1 << 0)
 
-#define RISCV_HWPROBE_KEY_IMA_EXT_0     4
-#define     RISCV_HWPROBE_IMA_FD       (1 << 0)
-#define     RISCV_HWPROBE_IMA_C        (1 << 1)
-#define     RISCV_HWPROBE_IMA_V        (1 << 2)
-#define     RISCV_HWPROBE_EXT_ZBA      (1 << 3)
-#define     RISCV_HWPROBE_EXT_ZBB      (1 << 4)
-#define     RISCV_HWPROBE_EXT_ZBS      (1 << 5)
-#define     RISCV_HWPROBE_EXT_ZICBOZ   (1 << 6)
+#define RISCV_HWPROBE_KEY_IMA_EXT_0         4
+#define     RISCV_HWPROBE_IMA_FD            (1 << 0)
+#define     RISCV_HWPROBE_IMA_C             (1 << 1)
+#define     RISCV_HWPROBE_IMA_V             (1 << 2)
+#define     RISCV_HWPROBE_EXT_ZBA           (1 << 3)
+#define     RISCV_HWPROBE_EXT_ZBB           (1 << 4)
+#define     RISCV_HWPROBE_EXT_ZBS           (1 << 5)
+#define     RISCV_HWPROBE_EXT_ZICBOZ        (1 << 6)
+#define     RISCV_HWPROBE_EXT_ZBC           (1 << 7)
+#define     RISCV_HWPROBE_EXT_ZBKB          (1 << 8)
+#define     RISCV_HWPROBE_EXT_ZBKC          (1 << 9)
+#define     RISCV_HWPROBE_EXT_ZBKX          (1 << 10)
+#define     RISCV_HWPROBE_EXT_ZKND          (1 << 11)
+#define     RISCV_HWPROBE_EXT_ZKNE          (1 << 12)
+#define     RISCV_HWPROBE_EXT_ZKNH          (1 << 13)
+#define     RISCV_HWPROBE_EXT_ZKSED         (1 << 14)
+#define     RISCV_HWPROBE_EXT_ZKSH          (1 << 15)
+#define     RISCV_HWPROBE_EXT_ZKT           (1 << 16)
+#define     RISCV_HWPROBE_EXT_ZVBB          (1 << 17)
+#define     RISCV_HWPROBE_EXT_ZVBC          (1 << 18)
+#define     RISCV_HWPROBE_EXT_ZVKB          (1 << 19)
+#define     RISCV_HWPROBE_EXT_ZVKG          (1 << 20)
+#define     RISCV_HWPROBE_EXT_ZVKNED        (1 << 21)
+#define     RISCV_HWPROBE_EXT_ZVKNHA        (1 << 22)
+#define     RISCV_HWPROBE_EXT_ZVKNHB        (1 << 23)
+#define     RISCV_HWPROBE_EXT_ZVKSED        (1 << 24)
+#define     RISCV_HWPROBE_EXT_ZVKSH         (1 << 25)
+#define     RISCV_HWPROBE_EXT_ZVKT          (1 << 26)
+#define     RISCV_HWPROBE_EXT_ZFH           (1 << 27)
+#define     RISCV_HWPROBE_EXT_ZFHMIN        (1 << 28)
+#define     RISCV_HWPROBE_EXT_ZIHINTNTL     (1 << 29)
+#define     RISCV_HWPROBE_EXT_ZVFH          (1 << 30)
+#define     RISCV_HWPROBE_EXT_ZVFHMIN       (1 << 31)
+#define     RISCV_HWPROBE_EXT_ZFA           (1ULL << 32)
+#define     RISCV_HWPROBE_EXT_ZACAS         (1ULL << 34)
+#define     RISCV_HWPROBE_EXT_ZICOND        (1ULL << 35)
 
 #define RISCV_HWPROBE_KEY_CPUPERF_0     5
 #define     RISCV_HWPROBE_MISALIGNED_UNKNOWN     (0 << 0)
@@ -8876,6 +8904,62 @@ static void risc_hwprobe_fill_pairs(CPURISCVState *env,
                      RISCV_HWPROBE_EXT_ZBS : 0;
             value |= cfg->ext_zicboz ?
                      RISCV_HWPROBE_EXT_ZICBOZ : 0;
+            value |= cfg->ext_zbc ?
+                     RISCV_HWPROBE_EXT_ZBC : 0;
+            value |= cfg->ext_zbkb ?
+                     RISCV_HWPROBE_EXT_ZBKB : 0;
+            value |= cfg->ext_zbkc ?
+                     RISCV_HWPROBE_EXT_ZBKC : 0;
+            value |= cfg->ext_zbkx ?
+                     RISCV_HWPROBE_EXT_ZBKX : 0;
+            value |= cfg->ext_zknd ?
+                     RISCV_HWPROBE_EXT_ZKND : 0;
+            value |= cfg->ext_zkne ?
+                     RISCV_HWPROBE_EXT_ZKNE : 0;
+            value |= cfg->ext_zknh ?
+                     RISCV_HWPROBE_EXT_ZKNH : 0;
+            value |= cfg->ext_zksed ?
+                     RISCV_HWPROBE_EXT_ZKSED : 0;
+            value |= cfg->ext_zksh ?
+                     RISCV_HWPROBE_EXT_ZKSH : 0;
+            value |= cfg->ext_zkt ?
+                     RISCV_HWPROBE_EXT_ZKT : 0;
+            value |= cfg->ext_zvbb ?
+                     RISCV_HWPROBE_EXT_ZVBB : 0;
+            value |= cfg->ext_zvbc ?
+                     RISCV_HWPROBE_EXT_ZVBC : 0;
+            value |= cfg->ext_zvkb ?
+                     RISCV_HWPROBE_EXT_ZVKB : 0;
+            value |= cfg->ext_zvkg ?
+                     RISCV_HWPROBE_EXT_ZVKG : 0;
+            value |= cfg->ext_zvkned ?
+                     RISCV_HWPROBE_EXT_ZVKNED : 0;
+            value |= cfg->ext_zvknha ?
+                     RISCV_HWPROBE_EXT_ZVKNHA : 0;
+            value |= cfg->ext_zvknhb ?
+                     RISCV_HWPROBE_EXT_ZVKNHB : 0;
+            value |= cfg->ext_zvksed ?
+                     RISCV_HWPROBE_EXT_ZVKSED : 0;
+            value |= cfg->ext_zvksh ?
+                     RISCV_HWPROBE_EXT_ZVKSH : 0;
+            value |= cfg->ext_zvkt ?
+                     RISCV_HWPROBE_EXT_ZVKT : 0;
+            value |= cfg->ext_zfh ?
+                     RISCV_HWPROBE_EXT_ZFH : 0;
+            value |= cfg->ext_zfhmin ?
+                     RISCV_HWPROBE_EXT_ZFHMIN : 0;
+            value |= cfg->ext_zihintntl ?
+                     RISCV_HWPROBE_EXT_ZIHINTNTL : 0;
+            value |= cfg->ext_zvfh ?
+                     RISCV_HWPROBE_EXT_ZVFH : 0;
+            value |= cfg->ext_zvfhmin ?
+                     RISCV_HWPROBE_EXT_ZVFHMIN : 0;
+            value |= cfg->ext_zfa ?
+                     RISCV_HWPROBE_EXT_ZFA : 0;
+            value |= cfg->ext_zacas ?
+                     RISCV_HWPROBE_EXT_ZACAS : 0;
+            value |= cfg->ext_zicond ?
+                     RISCV_HWPROBE_EXT_ZICOND : 0;
             __put_user(value, &pair->value);
             break;
         case RISCV_HWPROBE_KEY_CPUPERF_0:
-- 
2.44.0


