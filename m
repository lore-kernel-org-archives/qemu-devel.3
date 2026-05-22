Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CA68CD5BAF
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 00:07:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQDPT-00042D-Fr; Thu, 21 May 2026 20:06:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wQDOE-0002du-47
 for qemu-devel@nongnu.org; Thu, 21 May 2026 20:05:28 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wQDOB-0004iu-W4
 for qemu-devel@nongnu.org; Thu, 21 May 2026 20:05:21 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2ba21d32776so49060235ad.2
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 17:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779408319; x=1780013119; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TgSVB8hbB12ipCIv+wwkqgZJqTEdlVVSjL31mZweUX8=;
 b=HAN0fD+avTi5R/pQnyyahlXk63L30y1EcvxD5V2anC4I8O1usgApuJcJ0gADXdsQku
 2HrYYMNLX0UWEoEBcsURqpg3kw7CeGk46SzPBQpb8VSGkAl6AdJ4N6MkAf6LeL4DJBHn
 y8AoTpqGebvl7U23v6oJWaCwPZxyI6nhGVPJrxdb4jWzgPCq6bDVbZ8feVUKgwYOX+uU
 YJeGDrG566TUifOCS11xNsXakB58nfPBPwDIyachfPtOfnD68xT4T7eUIb9v2MxeE1fF
 /xof8aX0x+KYTbahUy+2MHfD0qHbLTXC8EXhKXckvneWyGJyO9iiHCeT2i5daSydyP54
 trMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779408319; x=1780013119;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TgSVB8hbB12ipCIv+wwkqgZJqTEdlVVSjL31mZweUX8=;
 b=jm7XzRk8qCiKCRMVgu5UC6INGZe+agqx/jsLbEE51x9QMGPltKnpssW6caG5g9GBm/
 dSCiwTqLdJdsUFRrvZN7XzXIfof5uunAr+jiKUxiP5dGCQikQEEwBa7p/Ooi5VJ7uzz5
 nPgLsIc1r5AhDwEXCkSbmJ/fJpSPM0VxTUYuVShbh1GRwnCaUaJQaWXxmcH26eZyZllT
 tTkKsWsGK0UvKFaCr59cMdAYLlXdkUA1ANce8ZgwWkXbX88xEjcrsbNbb2WE+8+KQZlx
 peXJgujwRZxz0CzCNYB19OoBImzy18iohfYQY3TccZRXg4iKchEpxC/9NXJO+1SbeypW
 U6vg==
X-Gm-Message-State: AOJu0YwEQQ2rYBbFQeHDrT6NTkDZAUNyL2u7Op4zoB3+bYYvWEiyzH0m
 i5kDOdY5v6BzMuv+vk7rZO3Dyf/pp7geWlp4wx3SKaPINL5n6VDvwn14JDynq1Sv
X-Gm-Gg: Acq92OF7eXAYeggfTb4QbmhAhSKrZPbWi8YSE3qpZgUT+Cx/5mSFv1nQBI8ubu+l2ti
 qm7q7RhgwtUc6V+AGveQS4A8BuuKu9rnB7g57z4SF5QCSZ396cNgq1wNaofIGWWyfNSoZP1V3TR
 xG/Y8sAgqn0kggZd58Jkkaemo6gYOgWSvyl/OzjSW28+VIGG6rGv4DQfPKiUJNhf+IB6EBBl37Q
 wEU5cghRBGdohRzZXYY2LARzPjj+XjI6Nd5U3I01IVWrJctPRO4RgEDzNvTX0E3JBCIxcOAQxFK
 /nBPWnrC5deyufVSvbJiJDbtsU99KPwKkVjLKc5YrLbEZSydJD0vYREsXu3CVflxP0Yw6myOjnB
 CuPbW9yc1d8Svs06Ivhbw2N1YppK8VAXln2vbpqOV4HvrGvFSsMAsCr1sAdQ/GuJJL/ph6N80WN
 m5RTnYNd57GbiEIzD47NenuubvL+7M9acbJagv1Tk+Sw==
X-Received: by 2002:a17:903:244c:b0:2bd:7ff4:ab0b with SMTP id
 d9443c01a7336-2beb06552bbmr11009045ad.39.1779408318707; 
 Thu, 21 May 2026 17:05:18 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2beb114b54csm3915475ad.42.2026.05.21.17.05.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 17:05:18 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 32/48] target/riscv: remove riscv_cpu_named_features[]
Date: Fri, 22 May 2026 10:03:08 +1000
Message-ID: <20260522000324.23255-33-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260522000324.23255-1-alistair.francis@wdc.com>
References: <20260522000324.23255-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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

From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

This array has no uses left.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260512032926.1978818-8-daniel.barboza@oss.qualcomm.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h         |  1 -
 target/riscv/cpu.c         | 26 --------------------------
 target/riscv/tcg/tcg-cpu.c |  4 ++--
 3 files changed, 2 insertions(+), 29 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index f93d80ef22..b1bd69d4a9 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -992,7 +992,6 @@ typedef struct RISCVCPUMultiExtConfig {
 extern const RISCVCPUMultiExtConfig riscv_cpu_extensions[];
 extern const RISCVCPUMultiExtConfig riscv_cpu_vendor_exts[];
 extern const RISCVCPUMultiExtConfig riscv_cpu_experimental_exts[];
-extern const RISCVCPUMultiExtConfig riscv_cpu_named_features[];
 
 typedef struct isa_ext_data {
     const char *name;
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index ecf31599c5..64e3fa4ef0 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1411,32 +1411,6 @@ const RISCVCPUMultiExtConfig riscv_cpu_experimental_exts[] = {
     { },
 };
 
-/*
- * 'Named features' is the name we give to extensions that we
- * don't want to expose to users. They are either immutable
- * (always enabled/disable) or they'll vary depending on
- * the resulting CPU state.
- *
- * Some of them are always enabled depending on priv version
- * of the CPU and are declared directly in isa_edata_arr[].
- * The ones listed here have special checks during finalize()
- * time and require their own flags like regular extensions.
- * See riscv_cpu_update_named_features() for more info.
- */
-const RISCVCPUMultiExtConfig riscv_cpu_named_features[] = {
-    MULTI_EXT_CFG_BOOL("zic64b", ext_zic64b, true),
-    MULTI_EXT_CFG_BOOL("ssstateen", ext_ssstateen, true),
-    MULTI_EXT_CFG_BOOL("sha", ext_sha, true),
-
-    /*
-     * 'ziccrse' has its own flag because the KVM driver
-     * wants to enable/disable it on its own accord.
-     */
-    MULTI_EXT_CFG_BOOL("ziccrse", ext_ziccrse, true),
-
-    { },
-};
-
 static void cpu_set_prop_err(RISCVCPU *cpu, const char *propname,
                              Error **errp)
 {
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index c3e354b0ae..8dea22bae5 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -454,7 +454,7 @@ static void riscv_cpu_disable_priv_spec_isa_exts(RISCVCPU *cpu)
     }
 }
 
-static void riscv_cpu_update_named_features(RISCVCPU *cpu)
+static void riscv_cpu_update_cfg(RISCVCPU *cpu)
 {
     if (cpu->env.priv_ver >= PRIV_VERSION_1_11_0) {
         cpu->cfg.has_priv_1_11 = true;
@@ -1181,7 +1181,7 @@ void riscv_tcg_cpu_finalize_features(RISCVCPU *cpu, Error **errp)
         return;
     }
 
-    riscv_cpu_update_named_features(cpu);
+    riscv_cpu_update_cfg(cpu);
     riscv_cpu_validate_profiles(cpu);
 
     if (cpu->cfg.ext_smepmp && !cpu->cfg.pmp) {
-- 
2.53.0


