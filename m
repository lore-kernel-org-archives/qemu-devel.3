Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90294C25B10
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2024 13:19:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5Q8P-0005tC-6G; Fri, 10 May 2024 09:18:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fea.wang@sifive.com>)
 id 1s5K8R-0001fE-3i
 for qemu-devel@nongnu.org; Fri, 10 May 2024 02:53:39 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fea.wang@sifive.com>)
 id 1s5K8P-0004oe-CM
 for qemu-devel@nongnu.org; Fri, 10 May 2024 02:53:38 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-6f447260f9dso1494963b3a.0
 for <qemu-devel@nongnu.org>; Thu, 09 May 2024 23:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1715324015; x=1715928815; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VAsL4QSkEAe6lAFIQlVDgyR+n6eZ4E85ah8Bz0EmYD0=;
 b=SVVRpz/GwFF9uMyfbiOV9+yei4et7thMAB9J/RAHg33CGzWKyPovW2Jp4SiviXLUGi
 E8xizI+cIM/YVT8Zha/TdoRc5XcbBNs1rWoRcdG1k1azArs2/7pqknqlS5DdUO342P0G
 FPbIAqdIMBEnXDkYhUeSaJjtPXSTtGp0eZug8AejzqnzYwSqAWbffh6RgpgTTwYoFmNj
 SU79r2NE96Tn5pRKuICL5lIkBUXi53kKdTEChBlYtmyemTrEfoobqztzYRQElbIzGx10
 O03N8HItbTXZunExH+rr2JrzC4uJx47btqEvLx2pkaWn593tPemmNqVOLsJAkr+2W/Or
 cpNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715324015; x=1715928815;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VAsL4QSkEAe6lAFIQlVDgyR+n6eZ4E85ah8Bz0EmYD0=;
 b=uYcDtX3JYhoctlNfmEwQHARg/rdih3cCNq/NqO6lHB6fjendFI2I5LnBRRfJHtlvVh
 hHJbnifTbfknZnNRgHZMNrfjcYgQFD6EFwp8ZgVfP1ETr/D5jj4TMKUawsZY4/T2ctZL
 OoV51X/12FdslAna1afo07BapFXtyPM2FureRueROQH8nFkqRJLdct1FdSHpoyE8Vs/U
 aJQJ/8rMnjMp11weHH8+lavTV3CTcg/mjze5wnflV6H9gTa7UnkaBhhp3Wn/SDGmP93S
 Am2bx7DyGcR9nUK2A2Yw2HGDD/XHtZggSewhNI4z/A8GS8M4g4Li3eUOT/0PDouNz78a
 oSSQ==
X-Gm-Message-State: AOJu0Yyr6OENRys73z1AeJ/FW+bsg0N2HWsQuUZTkcBMD7lZoWLo9Jo2
 91bwD7TfmpuA15cg1AalG/wfcFVhdbewChE03S6Cxvh8hha3ouW+T+AlieIeOtiCrEcjOz+A5o9
 sD8qrGpNIBhTtaS9luauVbfGKg7uFtG2v8+5XyzSJ3ullBzidu/CaoIo3I2YDxtydWWZz1zOGbG
 4479Fz6eI3a21KmBGiGEcv3Fd8rAqbUK/yj/MF5A==
X-Google-Smtp-Source: AGHT+IFB/h0yf0oUPaFIYpT5TbgQkYZMBTvyBBPDGTbnqSCimmq/zEPgB4SaDGJWomYSgwV2V77NRA==
X-Received: by 2002:a05:6a20:96cd:b0:1aa:4289:5921 with SMTP id
 adf61e73a8af0-1afde1b0187mr1686905637.50.1715324015361; 
 Thu, 09 May 2024 23:53:35 -0700 (PDT)
Received: from hsinchu36-syssw02.internal.sifive.com
 (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1ef0bf31a7asm25579175ad.140.2024.05.09.23.53.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 May 2024 23:53:35 -0700 (PDT)
From: "Fea.Wang" <fea.wang@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: "Fea.Wang" <fea.wang@sifive.com>, Frank Chang <frank.chang@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Andrew Jones <ajones@ventanamicro.com>, Max Chou <max.chou@sifive.com>
Subject: [PATCH 2/5] target/riscv: Support the version for ss1p13
Date: Fri, 10 May 2024 14:58:52 +0800
Message-Id: <20240510065856.2436870-3-fea.wang@sifive.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240510065856.2436870-1-fea.wang@sifive.com>
References: <20240510065856.2436870-1-fea.wang@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=fea.wang@sifive.com; helo=mail-pf1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 10 May 2024 09:17:57 -0400
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

Add RISC-V privilege 1.13 support.

Signed-off-by: Fea.Wang <fea.wang@sifive.com>
Reviewed-by: Frank Chang <frank.chang@sifive.com>
---
 target/riscv/cpu.c         | 6 +++++-
 target/riscv/cpu.h         | 4 +++-
 target/riscv/cpu_cfg.h     | 1 +
 target/riscv/tcg/tcg-cpu.c | 4 ++++
 4 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index b6b48e5620..a6298c3298 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1773,7 +1773,9 @@ int priv_spec_from_str(const char *priv_spec_str)
 {
     int priv_version = -1;
 
-    if (!g_strcmp0(priv_spec_str, PRIV_VER_1_12_0_STR)) {
+    if (!g_strcmp0(priv_spec_str, PRIV_VER_1_13_0_STR)) {
+        priv_version = PRIV_VERSION_1_13_0;
+    } else if (!g_strcmp0(priv_spec_str, PRIV_VER_1_12_0_STR)) {
         priv_version = PRIV_VERSION_1_12_0;
     } else if (!g_strcmp0(priv_spec_str, PRIV_VER_1_11_0_STR)) {
         priv_version = PRIV_VERSION_1_11_0;
@@ -1793,6 +1795,8 @@ const char *priv_spec_to_str(int priv_version)
         return PRIV_VER_1_11_0_STR;
     case PRIV_VERSION_1_12_0:
         return PRIV_VER_1_12_0_STR;
+    case PRIV_VERSION_1_13_0:
+        return PRIV_VER_1_13_0_STR;
     default:
         return NULL;
     }
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 7696102697..776939b56b 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -96,12 +96,14 @@ extern RISCVCPUProfile *riscv_profiles[];
 #define PRIV_VER_1_10_0_STR "v1.10.0"
 #define PRIV_VER_1_11_0_STR "v1.11.0"
 #define PRIV_VER_1_12_0_STR "v1.12.0"
+#define PRIV_VER_1_13_0_STR "v1.13.0"
 enum {
     PRIV_VERSION_1_10_0 = 0,
     PRIV_VERSION_1_11_0,
     PRIV_VERSION_1_12_0,
+    PRIV_VERSION_1_13_0,
 
-    PRIV_VERSION_LATEST = PRIV_VERSION_1_12_0,
+    PRIV_VERSION_LATEST = PRIV_VERSION_1_13_0,
 };
 
 #define VEXT_VERSION_1_00_0 0x00010000
diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index e1e4f32698..fb7eebde52 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -136,6 +136,7 @@ struct RISCVCPUConfig {
      * TCG always implement/can't be user disabled,
      * based on spec version.
      */
+    bool has_priv_1_13;
     bool has_priv_1_12;
     bool has_priv_1_11;
 
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index faa8de9b83..a9d188a9fd 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -320,6 +320,10 @@ static void riscv_cpu_update_named_features(RISCVCPU *cpu)
         cpu->cfg.has_priv_1_12 = true;
     }
 
+    if (cpu->env.priv_ver >= PRIV_VERSION_1_13_0) {
+        cpu->cfg.has_priv_1_13 = true;
+    }
+
     /* zic64b is 1.12 or later */
     cpu->cfg.ext_zic64b = cpu->cfg.cbom_blocksize == 64 &&
                           cpu->cfg.cbop_blocksize == 64 &&
-- 
2.34.1


