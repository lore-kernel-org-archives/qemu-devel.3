Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C1D16075258
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 19:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sifive.com header.i=@sifive.com header.a=rsa-sha256 header.s=google header.b=TAJDtsej
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOgss-0002U7-PQ; Wed, 04 Nov 2026 14:42:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1xOgsS-0002Cp-Hi
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 14:42:33 -0500
Received: from mail-dy1-x132f.google.com ([2607:f8b0:4864:20::132f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1xOgsQ-0002K2-Pj
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 14:42:32 -0500
Received: by mail-dy1-x132f.google.com with SMTP id
 5a478bee46e88-36a0f27c9f4so2005754eec.1
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2026 11:42:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1793821349; x=1794426149; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7yA3xFBVVRlyroBJQNGyki+/VZND+ociAzE2DZ7Hwwo=;
 b=TAJDtsej8rLv2x/FDI4NWJzoNO6a73fh9ZpDrZ5E+YXynA6CR76EJaaiHD02dAYK47
 /4grpYFsvAuoxDDp6gOs1h22YWiQvS7drnK8+VGWXnKHVA3gd1MUASwboEvlwLoOdtRx
 qIdKEqQPoQHJfO3fzisKEtYV9VV+nvAoQ8MU8nOHT9dBm16XmGXwGq0nu23d0XICOnpI
 g+8fY+xbjQ4nZuObQGOrD3eiybBQV3+uO43sDEUCaMnDLTXC+3pwgr2GW7SSqLyEOy2t
 2RhqnaJPZi2hZg1bVevecvbX2D3BcxPoKhoQbnPHfP7/Hrssjvo5ftXXUi7V5e7KwS7g
 pFlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793821349; x=1794426149;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=7yA3xFBVVRlyroBJQNGyki+/VZND+ociAzE2DZ7Hwwo=;
 b=pX8MFr7FXpX+n+5AtiusEHpKfBFXVCKqulIANLSIkKUPVo/cVSDstISYCnbFm+ng3m
 ivpHH9fhkUFcDtpukMWEPqJureygWmp6Ghg4TEdcosldwzcBI3NwDyaaxBcISFeBvXhk
 fhBBRCOtwiWipBv9c3tiJl+WUw7AqWBc+pRq82LMIWsF0mcx8dSyuwI01qMbZXjoi7LL
 gW+bwTUDVXdI4bReBS7h7cjvOvPDxiaTwcDS23M+7uVLTd8XQ5YRcY0CgXyQy6bWysHi
 lwOjQB5wucBDqlTsNn+/iR+0zKnx5ajtTBdK0BeIf/ITRyQyV2g/XR8SW4Q7oFgdK9c9
 CIAw==
X-Gm-Message-State: APuU4Z9P2KWXjsSRzu0mt8xOvNEe3bQE8nL0jul7J+L/WcE81BJah4ih
 uvYJI8kBJMf3I16JV1GfucyFqJ2cOX8bfg4eCBrW8Waljeny1VVKq8HQ8EM5GiUmfAFTQVdOmAD
 RuLPlDBdEFbCevv4KE9677aHSqcZkg9L1EomKAcr6Y2H7Zy2DLyunnmgj4wjbJGfSc8myYs37jW
 tBEdMQrZyXSyq82kvdWdfkxeskvU6tbo4YjZPYNAYpng==
X-Gm-Gg: AYBFou27SAHEE6DbwkBjslqIijfe/dTFV6P2zWROc5ycQZ6gRAqt5xI89MbXe9kv07g
 D+iIRykFzJ+OKxXXhvA1hxmMREM1Xu/QtHpxokY3AtVNeBGgb5m7U1Dx3URyxLkyw6rN6LYO9KI
 vJTtKJwB4N/GEsn//Bd1hsv7jwj2WuzqY0XCTBMbu92e+gBhI41ckHhxN4xYiVhkYvK+iAqDRuT
 6ktFbSyQEXRQYOWWd22Yhb1bL0zMzD/yPW6siGi7Y/B6BSQp0uRwXN85NYeuvVC7ZC+KYqAZa4k
 FffX7M0ts/g95tK7wvqIrAxQ5SoBb5hPZx4FlGHC0jdmJzmuCbsT+QcHQlETxh8VC7tT0eckYIw
 uQbFYVMCL3yKbTpffOfAJYRPJP1PWA8AuBhq7AfA0MIv0XCZZ4/TkgaEFJRC6uochXnD5AEdSZH
 J7vJVdFxko5WZiBIl2YpqaOdKfnkrugwBmU4rUxQYX7VO9JaS0CzwspVtM5dNRbgeQvW0bIoe1g
 5H4D69Ev7UAjD7ziiIRmZpVYG14j2QCN4XdnNGfEejkaF9Scy3vkUKHZva6LraLK6Cggnj1rUdc
 S2pdWj2BRkn0/THO61kRi7qw8206XcFyfCw+rESq7eNFGU2Yzq0amW2OESSzWqovH8xxW4uU2iX
 ySK3ZrmauP5ixrZSdl1lpwTIKM2yM
X-Received: by 2002:a05:693c:4142:20b0:36a:6106:4f63 with SMTP id
 5a478bee46e88-36a6106506dmr19325393eec.16.1793821349268; 
 Wed, 04 Nov 2026 11:42:29 -0800 (PST)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36ca38d36a1sm11299527eec.12.2026.11.04.11.42.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 11:42:28 -0800 (PST)
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
Subject: [RFC PATCH 04/38] target/riscv: Add cfg property for Zvqwdota8i
 extension
Date: Thu,  5 Nov 2026 03:41:19 +0800
Message-ID: <20261104194155.679241-5-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261104194155.679241-1-max.chou@sifive.com>
References: <20261104194155.679241-1-max.chou@sifive.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::132f;
 envelope-from=max.chou@sifive.com; helo=mail-dy1-x132f.google.com
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
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add CPU configuration for the Zvqwdota8i extension which depends on the
Zve32x extension per the specification.

Signed-off-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/cpu.c                | 2 ++
 target/riscv/cpu_cfg_fields.h.inc | 1 +
 target/riscv/tcg/tcg-cpu.c        | 5 +++++
 target/riscv/tcg/vector_helper.c  | 6 ++++--
 4 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 53ecce8c398..96a1d76c5a2 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -250,6 +250,8 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(zvksg, PRIV_VERSION_1_12_0, ext_zvksg),
     ISA_EXT_DATA_ENTRY(zvksh, PRIV_VERSION_1_12_0, ext_zvksh),
     ISA_EXT_DATA_ENTRY(zvkt, PRIV_VERSION_1_12_0, ext_zvkt),
+    ISA_EXPERIMENTAL_EXT_DATA_ENTRY(zvqwdota8i, PRIV_VERSION_1_13_0,
+                                    ext_zvqwdota8i),
     ISA_EXT_DATA_ENTRY(zhinx, PRIV_VERSION_1_12_0, ext_zhinx),
     ISA_EXT_DATA_ENTRY(zhinxmin, PRIV_VERSION_1_12_0, ext_zhinxmin),
     ISA_EXT_DATA_ENTRY(sdext, PRIV_VERSION_1_12_0, ext_sdext),
diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_fields.h.inc
index 85fc3ad8bb8..0c08d688ac1 100644
--- a/target/riscv/cpu_cfg_fields.h.inc
+++ b/target/riscv/cpu_cfg_fields.h.inc
@@ -106,6 +106,7 @@ BOOL_FIELD(ext_zvfbfmin)
 BOOL_FIELD(ext_zvfbfwma)
 BOOL_FIELD(ext_zvfh)
 BOOL_FIELD(ext_zvfhmin)
+BOOL_FIELD(ext_zvqwdota8i)
 BOOL_FIELD(ext_sdext)
 BOOL_FIELD(ext_sdtrig)
 BOOL_FIELD(ext_smaia)
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 5834ec1524f..1c51ea94489 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -691,6 +691,11 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
         }
     }
 
+    if (cpu->cfg.ext_zvqwdota8i && !cpu->cfg.ext_zve32x) {
+        error_setg(errp, "Zvqwdota8i extension depends on Zve32x extension");
+        return;
+    }
+
     if ((cpu->cfg.ext_zdinx || cpu->cfg.ext_zhinxmin) && !cpu->cfg.ext_zfinx) {
         error_setg(errp, "Zdinx/Zhinx/Zhinxmin extensions require Zfinx");
         return;
diff --git a/target/riscv/tcg/vector_helper.c b/target/riscv/tcg/vector_helper.c
index 172ae0f11dc..4ba0a89f4b5 100644
--- a/target/riscv/tcg/vector_helper.c
+++ b/target/riscv/tcg/vector_helper.c
@@ -39,7 +39,8 @@ static target_ulong vtype_reserved(CPURISCVState *env, target_ulong vtype)
     int xlen = riscv_cpu_xlen(env);
     target_ulong reserved = 0;
 
-    if (riscv_cpu_cfg(env)->ext_zvfbfa) {
+    if (riscv_cpu_cfg(env)->ext_zvfbfa ||
+        riscv_cpu_cfg(env)->ext_zvqwdota8i) {
         reserved = vtype & MAKE_64BIT_MASK(R_VTYPE_RESERVED_SHIFT,
                                            xlen - 1 - R_VTYPE_RESERVED_SHIFT);
     } else {
@@ -88,7 +89,8 @@ target_ulong HELPER(vsetvl)(CPURISCVState *env, target_ulong s1,
 
     switch (vsew) {
     case MO_8:
-        ill_altfmt &= !(cpu->cfg.ext_zvfbfa);
+        ill_altfmt &= !(cpu->cfg.ext_zvfbfa ||
+                        cpu->cfg.ext_zvqwdota8i);
         break;
     case MO_16:
         ill_altfmt &= !(cpu->cfg.ext_zvfbfa);
-- 
2.56.0


