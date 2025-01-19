Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F08ABC02185
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jan 2025 01:17:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tZJuz-0003vu-QT; Sat, 18 Jan 2025 20:16:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tZJuX-0003DM-9H
 for qemu-devel@nongnu.org; Sat, 18 Jan 2025 20:15:34 -0500
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tZJuV-0003kF-F4
 for qemu-devel@nongnu.org; Sat, 18 Jan 2025 20:15:33 -0500
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-2ef28f07dbaso4615900a91.2
 for <qemu-devel@nongnu.org>; Sat, 18 Jan 2025 17:15:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737249330; x=1737854130; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hgSaKWB8rUAhhnJ9qRrawIZfwUrD8dwnyF5A0jyTJuE=;
 b=OcA5KLRKnOC+laivuXAYfoaqEk4mBE/nkPs6/OjNzWMBIgECRHHAcTsAvyASsUMOL/
 O0bXD7ZTFz9PGHdZm3KcRRCySJYFBVeCcDAU0D7d794uwir/KVVcYsvxFeB2IJpF0eqh
 dtSNpu/mWfG+9wbJo02hJe0btyCT2g8wfnssOFF6UBHQmhHKKLwk/b4ZngcrLJEjLcd4
 ACCfskj4QGtAtNRfsCXWOMgad46lxGsf/IvuPWkJFj0sorTbOlhEkROBBPMvI2weYhB2
 gT7d0PsxKqXSESbazNYY8wdrC5W+yxigdX0H+SaF5Oh+hjmVoD4dGLTXLfU0/rDTd63v
 Gqmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737249330; x=1737854130;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hgSaKWB8rUAhhnJ9qRrawIZfwUrD8dwnyF5A0jyTJuE=;
 b=i0N6ggBJ58avGIvrZvsrGJBtHm/rrW+XIcS8pbBD+RJXhhW+A1cVrTo8TDZXZfdOq1
 Nta7fZ4RmTXynOuc8Uwik3TynJjlribey8cnA/h6yR6QAMqahDezYFxwYtemMvZlkEsh
 VmcgwJSnUW6pr5WQGH3GnNsc32iPqffRye4N1YS9LTXetA0cjV+uynoZmuauOO33PhdM
 OkY+p707pcEEHIq2JoaDR1aSF7Xm01LQ/D4/uCi4ye5yW5rjWAaUAr0pfUEE+deDcE5F
 xKb0q8aWRBmHA/Uw/Wao125MVVKZ2PvQTMAD2+qXimlimLenYXLJWZq3YDKXx+oTPwvM
 /bBw==
X-Gm-Message-State: AOJu0YwHf8zVmS7qFPhjSzdJPuarG7rn1Vd7pK+H1GqtcFje8eOtLdiZ
 Lo/qfEWSlMdyXcqwf1LrDjgw8ikUtRZUtf+AF7XpJfCYBTF/P5r+MB84uLb0
X-Gm-Gg: ASbGncsIO8L5K8TeQFwH1ZDJ/ynX4O+bGMtqdjk8fSy1I51EkY2t9BO1YQAuizrFxyd
 PnTF5YJphrLiQR6GOIvTtkD9uvXAL6MgT1G5Zz/auWnGvYNZJvrTPe/M0qqmeBcq5QZc4eCkBYJ
 eebpnZpJY7A4zt0pEX+pOg/JmFZGHVJn0/9oe4EpIDue8OAbpxMCbpigOYs4BAi3D5TUzwc/Siu
 2W2XJOr3meDonx4jowQqj5n/+UjKLNvD3n/hQTYcwwMIVTgyi/UjMTm59oYYKsqRUoR3Xik8pZD
 WueGjv/pBEtms04MJg+EsHZ4CTsHJAblbckkUSD3v4u3vIXpEnqKpmpQv/7r06D3V0VKJyoZVw=
 =
X-Google-Smtp-Source: AGHT+IHnrYBTaSQCsu/BDSTLFt5ZcCzTZPx9W9sg3wL9pH/ap3c68NILhDS8s5+vO0VEtDsLFruUoA==
X-Received: by 2002:a17:90b:258b:b0:2ee:c2df:5d30 with SMTP id
 98e67ed59e1d1-2f782d4edb9mr10365700a91.26.1737249329902; 
 Sat, 18 Jan 2025 17:15:29 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f776185b02sm4760314a91.21.2025.01.18.17.15.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Jan 2025 17:15:29 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Alexey Baturo <baturo.alexey@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 49/50] target/riscv: Support Supm and Sspm as part of Zjpm
 v1.0
Date: Sun, 19 Jan 2025 11:12:24 +1000
Message-ID: <20250119011225.11452-50-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250119011225.11452-1-alistair.francis@wdc.com>
References: <20250119011225.11452-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x1033.google.com
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

From: Alexey Baturo <baturo.alexey@gmail.com>

The Zjpm v1.0 spec states there should be Supm and Sspm extensions that
are used in profile specification. Enabling Supm extension enables both
Ssnpm and Smnpm, while Sspm enables only Smnpm.

Signed-off-by: Alexey Baturo <baturo.alexey@gmail.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Message-ID: <20250113194410.1307494-1-baturo.alexey@gmail.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_cfg.h |  2 ++
 target/riscv/cpu.c     | 23 +++++++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index aef896ba00..b410b1e603 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -139,6 +139,8 @@ struct RISCVCPUConfig {
     bool ext_ssnpm;
     bool ext_smnpm;
     bool ext_smmpm;
+    bool ext_sspm;
+    bool ext_supm;
     bool rvv_ta_all_1s;
     bool rvv_ma_all_1s;
     bool rvv_vl_half_avl;
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index bddf1ba75e..3d4bd157d2 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -208,10 +208,12 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(sscsrind, PRIV_VERSION_1_12_0, ext_sscsrind),
     ISA_EXT_DATA_ENTRY(ssdbltrp, PRIV_VERSION_1_13_0, ext_ssdbltrp),
     ISA_EXT_DATA_ENTRY(ssnpm, PRIV_VERSION_1_13_0, ext_ssnpm),
+    ISA_EXT_DATA_ENTRY(sspm, PRIV_VERSION_1_13_0, ext_sspm),
     ISA_EXT_DATA_ENTRY(ssstateen, PRIV_VERSION_1_12_0, ext_ssstateen),
     ISA_EXT_DATA_ENTRY(sstc, PRIV_VERSION_1_12_0, ext_sstc),
     ISA_EXT_DATA_ENTRY(sstvala, PRIV_VERSION_1_12_0, has_priv_1_12),
     ISA_EXT_DATA_ENTRY(sstvecd, PRIV_VERSION_1_12_0, has_priv_1_12),
+    ISA_EXT_DATA_ENTRY(supm, PRIV_VERSION_1_13_0, ext_supm),
     ISA_EXT_DATA_ENTRY(svade, PRIV_VERSION_1_11_0, ext_svade),
     ISA_EXT_DATA_ENTRY(svadu, PRIV_VERSION_1_12_0, ext_svadu),
     ISA_EXT_DATA_ENTRY(svinval, PRIV_VERSION_1_12_0, ext_svinval),
@@ -1625,6 +1627,8 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
     MULTI_EXT_CFG_BOOL("zvfhmin", ext_zvfhmin, false),
     MULTI_EXT_CFG_BOOL("sstc", ext_sstc, true),
     MULTI_EXT_CFG_BOOL("ssnpm", ext_ssnpm, false),
+    MULTI_EXT_CFG_BOOL("sspm", ext_sspm, false),
+    MULTI_EXT_CFG_BOOL("supm", ext_supm, false),
 
     MULTI_EXT_CFG_BOOL("smaia", ext_smaia, false),
     MULTI_EXT_CFG_BOOL("smdbltrp", ext_smdbltrp, false),
@@ -2781,6 +2785,24 @@ static RISCVCPUImpliedExtsRule SSCFG_IMPLIED = {
     },
 };
 
+static RISCVCPUImpliedExtsRule SUPM_IMPLIED = {
+    .ext = CPU_CFG_OFFSET(ext_supm),
+    .implied_multi_exts = {
+        CPU_CFG_OFFSET(ext_ssnpm), CPU_CFG_OFFSET(ext_smnpm),
+
+        RISCV_IMPLIED_EXTS_RULE_END
+    },
+};
+
+static RISCVCPUImpliedExtsRule SSPM_IMPLIED = {
+    .ext = CPU_CFG_OFFSET(ext_sspm),
+    .implied_multi_exts = {
+        CPU_CFG_OFFSET(ext_smnpm),
+
+        RISCV_IMPLIED_EXTS_RULE_END
+    },
+};
+
 RISCVCPUImpliedExtsRule *riscv_misa_ext_implied_rules[] = {
     &RVA_IMPLIED, &RVD_IMPLIED, &RVF_IMPLIED,
     &RVM_IMPLIED, &RVV_IMPLIED, NULL
@@ -2799,6 +2821,7 @@ RISCVCPUImpliedExtsRule *riscv_multi_ext_implied_rules[] = {
     &ZVFH_IMPLIED, &ZVFHMIN_IMPLIED, &ZVKN_IMPLIED,
     &ZVKNC_IMPLIED, &ZVKNG_IMPLIED, &ZVKNHB_IMPLIED,
     &ZVKS_IMPLIED,  &ZVKSC_IMPLIED, &ZVKSG_IMPLIED, &SSCFG_IMPLIED,
+    &SUPM_IMPLIED, &SSPM_IMPLIED,
     NULL
 };
 
-- 
2.48.1


