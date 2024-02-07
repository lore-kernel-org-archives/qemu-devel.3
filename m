Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 172C5C4828D
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Feb 2024 12:00:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXgao-0000QQ-P8; Wed, 07 Feb 2024 06:59:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christoph.muellner@vrull.eu>)
 id 1rXgam-0000Jm-Ec
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 06:59:52 -0500
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <christoph.muellner@vrull.eu>)
 id 1rXgah-0008Pn-4U
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 06:59:52 -0500
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-5114b2b3b73so614052e87.0
 for <qemu-devel@nongnu.org>; Wed, 07 Feb 2024 03:59:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vrull.eu; s=google; t=1707307183; x=1707911983; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JVuDGiZQbjNstMd9itLMja4mWMGmzy39OyjDgJoEy1g=;
 b=auNFJR83oVuSDygLPYGcV2CyWLaLJAMR815uOggYYwGvIaPatkGeP6cNf8vJV/It7N
 axnQtEG5cKj3B5KiIOwSLPK9CDyKia5FUOhTD3KGG2xNIx+aBQ57n/5q8rxwJ5IJNExn
 OpRGCoM+jGUgu9TiTNqLADzhDQVC0OybiiUyCVZbg3bswjs2xZGFgkxsiZPYhvSPPhlg
 MCkU8F2b7KbqOuDL0u5m+9I/SHYPJlmG2fQvXRBPp6kLL8fm1WGNie4PILpWCGFqvnUd
 z7AzWFN1xu0lD2jOuxadPQcR1fnnBI5f1KEMxEVAosEGXg+YIG5srat+8Ctgc2z+MKCV
 5Odw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707307183; x=1707911983;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JVuDGiZQbjNstMd9itLMja4mWMGmzy39OyjDgJoEy1g=;
 b=asmIvrghi4lljzJre/1Ytye0Lq8D74gDI/rhUhq2IPfuajE02N/QCFjxTvq31Y/DLd
 N7aA7qfJKiu6lrRSvVBn1S6DKymiQBcl5npTHRKZ+r3N+/Dj51OdiSgGVpG+bXPgE+41
 e88BA6v9X6Bt0jrlNM2uyXUZdIGD7g3G5pUHntkansSAqteugfv1gHFYdScpj5LR5fco
 y41xfP5oKyI2XO3JbjAywnZUg/o+gRbdy3bm+JnbVIJh+Yc8mqi8HjA71qBmoVtwlt9O
 WNOVGL+HNC3ZROhRGX3LeOkB/FemI1+ORLWtfrXOGISrxqfRJotNShV8Ls01xPQI4ffW
 ooAQ==
X-Gm-Message-State: AOJu0YyWj6TzIxmVbitKxWTtaR1vmVuYLzR4cut0M/8Q4hk9xK31Fakr
 31HGWrxiszFsn6Tty6GsFhKAG5H8je/LiiKX/c2B8/ycJXUocVOpoxVRym+nkQw=
X-Google-Smtp-Source: AGHT+IGOHNgGXRLZ3ZHv4DjFFhA0j5/xHbVr4++izDlzudor9xWmjBcppIECgAY0B6bNi4orrP1FPw==
X-Received: by 2002:a2e:7d02:0:b0:2d0:a037:b93d with SMTP id
 y2-20020a2e7d02000000b002d0a037b93dmr4172040ljc.41.1707307182938; 
 Wed, 07 Feb 2024 03:59:42 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCXCm2pNfAN/cp34fmYGgJy872L8bC9uwJ2JlbajkDRm9UFjaKIO13Wb73NrO308CDuLAseFjOQSs2IOZwZfD5sbwBoa7JDg2Ej1Q5MZ11E4baQruDK1wH7cIEp5mPMBXLD9YwhgDCQ0CYISkbEyTwBK3U1muk6jU86MyG84zd8Onx6UtAqT1vfImGWLjuiqPlJAytkXwjUE7U9Hy3F1iG6YL40NSnxsNUl7qtZOOROIJzGt5clkU8t6j9EyyTtKeU+xR8u4aAKNxBwWwjOGL5V5GLAPQWoMFZIms7Cff2bJtjEsHYDRtjfGuocKiy9tvkOOpRF4BsF408eZ5PUZDifEcXZ9duJIVbptmg==
Received: from beast.fritz.box (62-178-148-172.cable.dynamic.surfer.at.
 [62.178.148.172]) by smtp.gmail.com with ESMTPSA id
 v2-20020aa7d802000000b0055efaddeafdsm588455edq.86.2024.02.07.03.59.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Feb 2024 03:59:42 -0800 (PST)
From: =?UTF-8?q?Christoph=20M=C3=BCllner?= <christoph.muellner@vrull.eu>
To: qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Andrew Jones <ajones@ventanamicro.com>
Cc: =?UTF-8?q?Christoph=20M=C3=BCllner?= <christoph.muellner@vrull.eu>,
 Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH 2/2] linux-user/riscv: Sync hwprobe keys with Linux
Date: Wed,  7 Feb 2024 12:59:26 +0100
Message-ID: <20240207115926.887816-3-christoph.muellner@vrull.eu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207115926.887816-1-christoph.muellner@vrull.eu>
References: <20240207115926.887816-1-christoph.muellner@vrull.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::136;
 envelope-from=christoph.muellner@vrull.eu; helo=mail-lf1-x136.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Upstream Linux recently added many additional keys to the hwprobe API.
This patch adds support for all of them with the exception of Ztso,
which is currently not supported in QEMU.

Signed-off-by: Christoph Müllner <christoph.muellner@vrull.eu>
---
 linux-user/syscall.c | 98 ++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 91 insertions(+), 7 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 43467c9707..3ba20f99ad 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -8793,13 +8793,41 @@ static int do_getdents64(abi_long dirfd, abi_long arg2, abi_long count)
 #define     RISCV_HWPROBE_BASE_BEHAVIOR_IMA (1 << 0)
 
 #define RISCV_HWPROBE_KEY_IMA_EXT_0     4
-#define     RISCV_HWPROBE_IMA_FD       (1 << 0)
-#define     RISCV_HWPROBE_IMA_C        (1 << 1)
-#define     RISCV_HWPROBE_IMA_V        (1 << 2)
-#define     RISCV_HWPROBE_EXT_ZBA      (1 << 3)
-#define     RISCV_HWPROBE_EXT_ZBB      (1 << 4)
-#define     RISCV_HWPROBE_EXT_ZBS      (1 << 5)
-#define     RISCV_HWPROBE_EXT_ZICBOZ   (1 << 6)
+#define		RISCV_HWPROBE_IMA_FD		(1 << 0)
+#define		RISCV_HWPROBE_IMA_C		(1 << 1)
+#define		RISCV_HWPROBE_IMA_V		(1 << 2)
+#define		RISCV_HWPROBE_EXT_ZBA		(1 << 3)
+#define		RISCV_HWPROBE_EXT_ZBB		(1 << 4)
+#define		RISCV_HWPROBE_EXT_ZBS		(1 << 5)
+#define		RISCV_HWPROBE_EXT_ZICBOZ	(1 << 6)
+#define		RISCV_HWPROBE_EXT_ZBC		(1 << 7)
+#define		RISCV_HWPROBE_EXT_ZBKB		(1 << 8)
+#define		RISCV_HWPROBE_EXT_ZBKC		(1 << 9)
+#define		RISCV_HWPROBE_EXT_ZBKX		(1 << 10)
+#define		RISCV_HWPROBE_EXT_ZKND		(1 << 11)
+#define		RISCV_HWPROBE_EXT_ZKNE		(1 << 12)
+#define		RISCV_HWPROBE_EXT_ZKNH		(1 << 13)
+#define		RISCV_HWPROBE_EXT_ZKSED		(1 << 14)
+#define		RISCV_HWPROBE_EXT_ZKSH		(1 << 15)
+#define		RISCV_HWPROBE_EXT_ZKT		(1 << 16)
+#define		RISCV_HWPROBE_EXT_ZVBB		(1 << 17)
+#define		RISCV_HWPROBE_EXT_ZVBC		(1 << 18)
+#define		RISCV_HWPROBE_EXT_ZVKB		(1 << 19)
+#define		RISCV_HWPROBE_EXT_ZVKG		(1 << 20)
+#define		RISCV_HWPROBE_EXT_ZVKNED	(1 << 21)
+#define		RISCV_HWPROBE_EXT_ZVKNHA	(1 << 22)
+#define		RISCV_HWPROBE_EXT_ZVKNHB	(1 << 23)
+#define		RISCV_HWPROBE_EXT_ZVKSED	(1 << 24)
+#define		RISCV_HWPROBE_EXT_ZVKSH		(1 << 25)
+#define		RISCV_HWPROBE_EXT_ZVKT		(1 << 26)
+#define		RISCV_HWPROBE_EXT_ZFH		(1 << 27)
+#define		RISCV_HWPROBE_EXT_ZFHMIN	(1 << 28)
+#define		RISCV_HWPROBE_EXT_ZIHINTNTL	(1 << 29)
+#define		RISCV_HWPROBE_EXT_ZVFH		(1 << 30)
+#define		RISCV_HWPROBE_EXT_ZVFHMIN	(1 << 31)
+#define		RISCV_HWPROBE_EXT_ZFA		(1ULL << 32)
+#define		RISCV_HWPROBE_EXT_ZACAS		(1ULL << 34)
+#define		RISCV_HWPROBE_EXT_ZICOND	(1ULL << 35)
 
 #define RISCV_HWPROBE_KEY_CPUPERF_0     5
 #define     RISCV_HWPROBE_MISALIGNED_UNKNOWN     (0 << 0)
@@ -8860,6 +8888,62 @@ static void risc_hwprobe_fill_pairs(CPURISCVState *env,
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
2.43.0


