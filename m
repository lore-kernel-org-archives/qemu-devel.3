Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D703BCCF9E3
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 08:22:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGBR9-0007wc-PW; Tue, 04 Nov 2025 02:26:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1vGBR7-0007wD-VG
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 02:26:37 -0500
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1vGBQw-0007qj-3T
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 02:26:37 -0500
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-b8c0c0cdd61so5117502a12.2
 for <qemu-devel@nongnu.org>; Mon, 03 Nov 2025 23:26:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1762241182; x=1762845982; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=OxJXv9m3iIscnCjpxt+cOm1/YTFgQwOZ+IIvIJ5aN38=;
 b=JER1qiinrPg/rh1oi01iqBn3BkHfVpQF+dGJRUIhAYzNGL5+x0qU3drlIuyiojI2pz
 qfOnSt+oJtt9d+GxOdREiRT0Gw9aa2TUpPLRu6UnnlsIhfyEnNWut9c/Z6CVKNFpk34W
 SFAoO1Lb5/hzayrIaY7Ve8a3fDEQ3swPACZKTWvQOQMHKBKuAx+Db35nUe2OrAh43pUy
 kQPc9kDgcZDvNDWp01Al8IS38SGY+Hqj5inVjNrl7jPSuVlsbSQh21zqNd8eVtKrqWH1
 meCYoHKtQ/CuntUL11cgYIC30gBHRwjFMbAcVXfTE/KW1XxyGEt4W5cCykhOm21fHWjf
 0Cqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762241182; x=1762845982;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OxJXv9m3iIscnCjpxt+cOm1/YTFgQwOZ+IIvIJ5aN38=;
 b=l+Gq0P1A7a7HdclmDpisJub8chQvf8BMOm8AHwi5K9wRFgcew9nDfKb1QfM7798Hwo
 pdQRusGesp3CugYg/GDv+wdkfGROh+nU2zDofQPJgHEl/vfCoPhjNQeGQ5V15ptdcnUi
 w3+PE8gCSmxwSMUcdfYS5sTtSqnnhF8inNuAi9NZRY0ESf+T//xIz+Hd6G0k+7TPqiYx
 0mFdNUupomAnYOUeeWRpHFBeMtGzEN//QhB8XklNKSY+hK5bSmB6UZsuqU9pNlIYtvuU
 R7X2EeKpNVK/oPekYBLrL7kKzl76VKQD3JfeVPjSfU8sZisiumcdPBSUAaf2ol4EKgTf
 WJdA==
X-Gm-Message-State: AOJu0YwqjX14Re3LEiddyuKAJOVhR/BAiV0JsW+BnPiDNeANMHre3kMX
 +6t5VNLO1A/KCuBRruJugKIKxTTFbkIWVGh3RXIzIsF0xluFG7y/MuChZjE+kVBQwbac99VI2sG
 DyckjW/Vn1oLvba4x6OkqP8Ih5oitFPzAyNKtTlPqrTI2qz3KcmNih5RV2WEHa+m6VtIC+ey1V/
 p1t3X6JHJ7+PZwUemKkxiWpxOQCZaVArTKwsbVgHwn
X-Gm-Gg: ASbGncu3jWqLl5vHdj4fRPQO4O6prfigPPACCDSDs6unquPGXzHetG4mlzlK2+1dT6N
 +ptekMHHRiAM4N4lTH0axc7aQ8zSRT9yoL9MF+05M5hpmw6jHUEuWhogwdIkPD9goEvyXxQoUMF
 aM2FKzn+3mcn+vLiBtSUXeHAqkcDBNqxh2SlmEpJ6FQic7GoMqADp5xfdmV8CVUmLdDhIM4aR/6
 pqQN5jvuKaMN5jGV4tzPIKBQEUNJvQZWlmXwKn2KUHiyDjByhKOZaeB6RnPo75NjyzOD43rQ0k6
 S99rhKLtAeN79xPKpwdUWPraxGpgtJUxobdHzjNxQ9EDUmm6CfybE03uieUSt2hUmBrAx+U4roC
 +LY2369cCcs/G7F4PVFag/HzXzjG5PH3e6dXDfaRhJMCK7a4u4HBx6xGF9cO3xXl3gPll65WWA1
 F5nJiMKqu4HlJGIKhhZE6bW/CPclr913nFDHxa6ihzWiYCdZgcZg==
X-Google-Smtp-Source: AGHT+IH/oFHcEkBhKj2GPpzteDukhvwSFIjjpLCBONi/uUqwkeCsyvr8IyD45ibVW1hqsEqxIZHvwA==
X-Received: by 2002:a17:903:38c5:b0:269:d978:7ec0 with SMTP id
 d9443c01a7336-2951a45a15emr220079735ad.28.1762241181667; 
 Mon, 03 Nov 2025 23:26:21 -0800 (PST)
Received: from jchang-1875.internal.sifive.com ([136.226.240.200])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-296019729c0sm15431765ad.18.2025.11.03.23.26.19
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 03 Nov 2025 23:26:21 -0800 (PST)
From: Jay Chang <jay.chang@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Jay Chang <jay.chang@sifive.com>, Frank Chang <frank.chang@sifive.com>
Subject: [PATCH v1] target/riscv: Support Smpmpmt extension
Date: Tue,  4 Nov 2025 15:26:14 +0800
Message-ID: <20251104072614.20983-1-jay.chang@sifive.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=jay.chang@sifive.com; helo=mail-pg1-x530.google.com
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

The Smpmpmt extension provides a mechanism to control memory attributes
at the granularity of PMP (Physical Memory Protection) registers, similar
to how Svpbmt controls memory attributes at the page level.

Version 0.6
https://github.com/riscv/riscv-isa-manual/blob/smpmpmt/src/smpmpmt.adoc#svpbmt

Signed-off-by: Jay Chang <jay.chang@sifive.com>
Reviewed-by: Frank Chang <frank.chang@sifive.com>
---
 target/riscv/cpu.c                |  2 ++
 target/riscv/cpu_cfg_fields.h.inc |  1 +
 target/riscv/pmp.c                | 12 ++++++++++++
 target/riscv/pmp.h                |  1 +
 4 files changed, 16 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index ae8b721e55..a0290f06f6 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -230,6 +230,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(svinval, PRIV_VERSION_1_12_0, ext_svinval),
     ISA_EXT_DATA_ENTRY(svnapot, PRIV_VERSION_1_12_0, ext_svnapot),
     ISA_EXT_DATA_ENTRY(svpbmt, PRIV_VERSION_1_12_0, ext_svpbmt),
+    ISA_EXT_DATA_ENTRY(smpmpmt, PRIV_VERSION_1_12_0, ext_smpmpmt),
     ISA_EXT_DATA_ENTRY(svrsw60t59b, PRIV_VERSION_1_13_0, ext_svrsw60t59b),
     ISA_EXT_DATA_ENTRY(svukte, PRIV_VERSION_1_13_0, ext_svukte),
     ISA_EXT_DATA_ENTRY(svvptc, PRIV_VERSION_1_13_0, ext_svvptc),
@@ -1262,6 +1263,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
     MULTI_EXT_CFG_BOOL("svinval", ext_svinval, false),
     MULTI_EXT_CFG_BOOL("svnapot", ext_svnapot, false),
     MULTI_EXT_CFG_BOOL("svpbmt", ext_svpbmt, false),
+    MULTI_EXT_CFG_BOOL("smpmpmt", ext_smpmpmt, false),
     MULTI_EXT_CFG_BOOL("svrsw60t59b", ext_svrsw60t59b, false),
     MULTI_EXT_CFG_BOOL("svvptc", ext_svvptc, true),
 
diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_fields.h.inc
index a154ecdc79..b1096da664 100644
--- a/target/riscv/cpu_cfg_fields.h.inc
+++ b/target/riscv/cpu_cfg_fields.h.inc
@@ -57,6 +57,7 @@ BOOL_FIELD(ext_svadu)
 BOOL_FIELD(ext_svinval)
 BOOL_FIELD(ext_svnapot)
 BOOL_FIELD(ext_svpbmt)
+BOOL_FIELD(ext_smpmpmt)
 BOOL_FIELD(ext_svrsw60t59b)
 BOOL_FIELD(ext_svvptc)
 BOOL_FIELD(ext_svukte)
diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
index 3ef62d26ad..52a7677683 100644
--- a/target/riscv/pmp.c
+++ b/target/riscv/pmp.c
@@ -165,6 +165,18 @@ static bool pmp_write_cfg(CPURISCVState *env, uint32_t pmp_index, uint8_t val)
                           "ignoring pmpcfg write - invalid\n");
         } else {
             uint8_t a_field = pmp_get_a_field(val);
+
+            if (!riscv_cpu_cfg(env)->ext_smpmpmt) {
+                /* If smpmpmt not supported, clear the MTMATCH bit */
+                val &= ~PMP_MTMATCH;
+            } else if ((val & PMP_MTMATCH) == PMP_MTMATCH) {
+                /*
+                 * If trying to set reserved value (0x3) for MT field,
+                 * preserve the original MT field from current config.
+                 */
+                val = (val & ~PMP_MTMATCH) |
+                    (env->pmp_state.pmp[pmp_index].cfg_reg & PMP_MTMATCH);
+            }
             /*
              * When granularity g >= 1 (i.e., granularity > 4 bytes),
              * the NA4 (Naturally Aligned 4-byte) mode is not selectable
diff --git a/target/riscv/pmp.h b/target/riscv/pmp.h
index 271cf24169..467fb6b4b1 100644
--- a/target/riscv/pmp.h
+++ b/target/riscv/pmp.h
@@ -29,6 +29,7 @@ typedef enum {
     PMP_WRITE = 1 << 1,
     PMP_EXEC  = 1 << 2,
     PMP_AMATCH = (3 << 3),
+    PMP_MTMATCH = (3 << 5),
     PMP_LOCK  = 1 << 7
 } pmp_priv_t;
 
-- 
2.48.1


