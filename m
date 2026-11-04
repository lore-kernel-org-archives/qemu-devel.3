Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ABF4606B390
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 19:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sifive.com header.i=@sifive.com header.a=rsa-sha256 header.s=google header.b=WO2BZJFu
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOgtC-0002p2-3X; Wed, 04 Nov 2026 14:43:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1xOgsn-0002Nv-7p
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 14:42:54 -0500
Received: from mail-dy1-x1333.google.com ([2607:f8b0:4864:20::1333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1xOgsl-0002Pk-Im
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 14:42:52 -0500
Received: by mail-dy1-x1333.google.com with SMTP id
 5a478bee46e88-3535a54bed9so1455797eec.1
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2026 11:42:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1793821370; x=1794426170; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SiPCF3xlwqQkTa55LvTY9LHo8r9GifIY+XV4J0fb6cE=;
 b=WO2BZJFuQTH6GZ2+NV+03TDoSpbiRCyIDggViTm5BXzuApRfAZEwyiZtJAoa6QTZ4d
 A6hKDZ6I9zAfLMV/ne7HB8YpMhAq6gWYpaDaASj3ukLPArWjcAevxZVFmoYUL0SuxP2g
 qMu78CsqXZXyNycWf4xs9DaDuzEBkqA44+OK08TzNGf+uWOn0oRr8h1RBUhaY3qq1S4G
 4T6aA+lfERytZm/oFv7PUjN6NSthSu3AslwHg0MXC2NFi8vSeUk/6W5DZ6rTnOut1+oj
 bOnXIfizP3IwZ1Je1OsJ6yHIFBoKJJNOUuCMPp689dy4/9zSz1jdbC96oLb0nT0jb74U
 0Y+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793821370; x=1794426170;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=SiPCF3xlwqQkTa55LvTY9LHo8r9GifIY+XV4J0fb6cE=;
 b=O9RzpxqSWHUylvPfQDwvSE9MCoCX2mkf0lyMZ3MXEdtURTHFAwZx8z5AtgG6Cj4vYw
 ZNlJneexMDGrD/MbIUk2D2+R0nY1p9PF+cmaGugi4kt+/2TbcboQc6xyBqd+XssRVYC6
 MQ3+Qv5+Jc9cv3LdM4msB8sjAXzM3XF2ilOjftpEZABMUR/0nKydRiOOCTobk11cZBN2
 xvnf8zniHjhq1u+e3Kj/Ad/ilhK92GZVFR7EHFqv1myidmIOAza79BduAWBg8/2Z1snH
 IxnMluwqONP9G5ymGHku5mVXC7V3QemI9GaiUNqNiRecnB12HswmpifhVMFXkce7qYW0
 tm6Q==
X-Gm-Message-State: APuU4Z+QakhchCacnBjcnvEyi43bjAvWUI+U2hohjNUwhuWyMMdbSa8m
 87o7OtbsnY3aqLdD/YdXCsuKl6DCKwLe7vuekLTMza+q1sPh3Ot/6XjPWe8S3Uy2ob1b9O3d6pD
 BNMAkpi8fb9EEDBSYs/rHEm+AvMc/MnuPvLyNcuFSC7G9/M1SIMVIkIAT7I7HM0b53vkr2cmm3c
 TqembXprHyywz+uXEtTlOKHHWVREkHEwcCw/M6mCPKdw==
X-Gm-Gg: AYBFou0hcveEDdOG2tyKE3BHJiBHcdBzf9LbY29bAy1/ivHyTr3+dcp9FO5KzCFXd2u
 a73ORJiI0JJ/DRR3Uu5DHJePKN4bpw5VzvOp7wJTHn1qK9U2Z8OFU7MlqJRZI7I74kgLXBvLWyN
 0K9egLOLsANwuGHUz/eqCf44EZAnvItTvZIBYCuYxRVtQW1yDi/kbMO/3DcZpvbexUJwzTceqER
 Hnf197aGgOZiltKf74kNcgAxdCOX63+inFFMJrMrd1ZRDCLl8VaGIh9wApv5CEEobhQS8ypEsgC
 kd2hvibKHplaF95NKw03oYzudhp5H/guuyJzLOC49nxsNkLHR2DiETECbbyMQZ2EWwfH0doVUYk
 XDUWS1y8itsNb6wXBU9Qev83n6Gov8JCSl1cDlsIClyTAHyPnSMg5MWeaVT9RnipX6ofPiahmP/
 1WpYqJ0GveIin71dXZ6NYjKkXRLfZmVAzITopfpeASXzo+0JQyElwej4/e3nizzh9ye7Ifu/eJB
 EgNd1WYYzkwtc7swdd/4V1DghwNnudb+/kQaC6Ck2zooz5lp3VezLcsLswDas7x7EgE4Ls/3wPz
 VkD5MrppK3eUVIrZavEFOOTEOdxIhMykoSw8dseQxdzXltQS3RB45b6ARnwDuZl1iqlUxQNOZj5
 37A2tEz7nQ4Dj1jjjDZhDvJiRe5oIBqANDHX4GJKTZYwGfmbwsg==
X-Received: by 2002:a05:7300:6d22:b0:36a:13e1:c889 with SMTP id
 5a478bee46e88-36a425e10f8mr39018735eec.36.1793821369884; 
 Wed, 04 Nov 2026 11:42:49 -0800 (PST)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36ca38d36a1sm11299527eec.12.2026.11.04.11.42.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 11:42:49 -0800 (PST)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>, Max Chou <max.chou@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [RFC PATCH 11/38] target/riscv: Add cfg property for Zvfwdota16bf
 extension
Date: Thu,  5 Nov 2026 03:41:26 +0800
Message-ID: <20261104194155.679241-12-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261104194155.679241-1-max.chou@sifive.com>
References: <20261104194155.679241-1-max.chou@sifive.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1333;
 envelope-from=max.chou@sifive.com; helo=mail-dy1-x1333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add CPU configuration property of Zvfwdota16bf extension which depends on
the Zve32f extension per the specification.

Signed-off-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/cpu.c                | 2 ++
 target/riscv/cpu_cfg_fields.h.inc | 1 +
 target/riscv/tcg/tcg-cpu.c        | 5 +++++
 target/riscv/tcg/vector_helper.c  | 2 ++
 4 files changed, 10 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index ae859128d30..d6e2b07c401 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -236,6 +236,8 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(zvfbfwma, PRIV_VERSION_1_12_0, ext_zvfbfwma),
     ISA_EXT_DATA_ENTRY(zvfh, PRIV_VERSION_1_12_0, ext_zvfh),
     ISA_EXT_DATA_ENTRY(zvfhmin, PRIV_VERSION_1_12_0, ext_zvfhmin),
+    ISA_EXPERIMENTAL_EXT_DATA_ENTRY(zvfwdota16bf, PRIV_VERSION_1_13_0,
+                                    ext_zvfwdota16bf),
     ISA_EXT_DATA_ENTRY(zvkb, PRIV_VERSION_1_12_0, ext_zvkb),
     ISA_EXT_DATA_ENTRY(zvkg, PRIV_VERSION_1_12_0, ext_zvkg),
     ISA_EXT_DATA_ENTRY(zvkn, PRIV_VERSION_1_12_0, ext_zvkn),
diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_fields.h.inc
index 8bac69a17f7..30c404863c8 100644
--- a/target/riscv/cpu_cfg_fields.h.inc
+++ b/target/riscv/cpu_cfg_fields.h.inc
@@ -106,6 +106,7 @@ BOOL_FIELD(ext_zvfbfmin)
 BOOL_FIELD(ext_zvfbfwma)
 BOOL_FIELD(ext_zvfh)
 BOOL_FIELD(ext_zvfhmin)
+BOOL_FIELD(ext_zvfwdota16bf)
 BOOL_FIELD(ext_zvqwdota16i)
 BOOL_FIELD(ext_zvqwdota8i)
 BOOL_FIELD(ext_sdext)
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 54749125acf..91e009072e6 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -701,6 +701,11 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
         return;
     }
 
+    if (cpu->cfg.ext_zvfwdota16bf && !cpu->cfg.ext_zve32f) {
+        error_setg(errp, "Zvfwdota16bf extension depends on Zve32f extension");
+        return;
+    }
+
     if ((cpu->cfg.ext_zdinx || cpu->cfg.ext_zhinxmin) && !cpu->cfg.ext_zfinx) {
         error_setg(errp, "Zdinx/Zhinx/Zhinxmin extensions require Zfinx");
         return;
diff --git a/target/riscv/tcg/vector_helper.c b/target/riscv/tcg/vector_helper.c
index 57a381098f6..41b526d25ef 100644
--- a/target/riscv/tcg/vector_helper.c
+++ b/target/riscv/tcg/vector_helper.c
@@ -40,6 +40,7 @@ static target_ulong vtype_reserved(CPURISCVState *env, target_ulong vtype)
     target_ulong reserved = 0;
 
     if (riscv_cpu_cfg(env)->ext_zvfbfa ||
+        riscv_cpu_cfg(env)->ext_zvfwdota16bf ||
         riscv_cpu_cfg(env)->ext_zvqwdota16i ||
         riscv_cpu_cfg(env)->ext_zvqwdota8i) {
         reserved = vtype & MAKE_64BIT_MASK(R_VTYPE_RESERVED_SHIFT,
@@ -95,6 +96,7 @@ target_ulong HELPER(vsetvl)(CPURISCVState *env, target_ulong s1,
         break;
     case MO_16:
         ill_altfmt &= !(cpu->cfg.ext_zvfbfa ||
+                        cpu->cfg.ext_zvfwdota16bf ||
                         cpu->cfg.ext_zvqwdota16i);
         break;
     default:
-- 
2.56.0


