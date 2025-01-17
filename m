Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EC88C02185
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 06:05:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYfNi-0001tm-Ir; Fri, 17 Jan 2025 00:58:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tYfNZ-0000yu-TY
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 00:58:50 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tYfNY-0006DI-8W
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 00:58:49 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2166651f752so39912435ad.3
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 21:58:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737093527; x=1737698327; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=smsH0NgH7gY8Lj2dZ1J8X+n9SS/wg8j9485bpIxh+ws=;
 b=Q+GnbAR8FOmcvKvHa1V/78QlmrVlYFE+TWj3c2BWWf2Iw6Vsk0dKX/USIKMq99Eo9l
 dEjEMTT11xtk2g+9GDSAFACC9bpPAmv0I571SbpFp59bmD/oLeyeb2vNs0mPxkjkkQYo
 keuS4Dt81fRhEFP0leLTntO5lEOph6OhC5bcD5IEMhokd2cx9kT8UViyK/m88TQ/YQqf
 Gt0soJrZTwojgTzsUfP3QdY6Rm5ES7C1WIdlGQj4gS3QchYhiBrkXP3yQUe6uIZLmnb0
 LnjMz5L7VXCExGfIoOe4ySpn0xCDDP99XOz642OySiQYKn5X7B36VAwEnHJuxDDkShhJ
 ZjSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737093527; x=1737698327;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=smsH0NgH7gY8Lj2dZ1J8X+n9SS/wg8j9485bpIxh+ws=;
 b=f1AQldDmqgtHSURMqbOVn3nCYhIZywM2r76jq5RulFyEW1V+UMbKBbJ7eOjZkW4QbB
 Xcycjs57m/RhCUMk5sXwvWEUnUa2/B3ghOwY5uIjQ1HMzASUVZH3kplQPcnWHwqwgLMJ
 Kzd82aEkCNOJy42VtK1K8TEUTXAyEze3pkXwwuXmdEga/6q3cUJ3BSivBpn6CjgS6ZZ9
 pvOjqBV9TuGAC0qJ5WGHHJ37CVYwpZYqJaOghXRJACgFlNDfGyqN/XBRWvPVFqeb6u3X
 bdBL7Pxr1A6tbhi1K/QCOQ9O5Rt5Ld/NZf1xB5ALHktuE+38PSlv5Dc68sbV0mhJ8eP3
 a9Qw==
X-Gm-Message-State: AOJu0YzJibj6J7VidUmFK8ctLJQOTQ2RdKB1cI5hmG+KkaFrRGQD3U+a
 ImKq+rTp0NoR6OOX+Xzh8WEkgQlIW7ov2mKE/pPASndPnnyeM+R/QQ3z0Q==
X-Gm-Gg: ASbGncujW9KS+zVMLBmrqUsyWo9LY8GPOzpRSNj+RYxhJJklOBkJpsuN888YiKNX7XU
 0r7aV3E6cDWcY+pa8e/V8yi4cSfAljCgMedDTDTwTqFqvvDzTlzEhXwv3fSTKuhyZdzMh1vnxOw
 2MjJSR2GcpZtvufhFLgnMR6IHJkT6cmgWeLwbH6eaW4sPt61o0Wbv9VWH/Kp7kmrPG0TbAmP4y4
 /PAb88e4HA3f7EZ0ZZqCFsr+JRrf1CCprBJIn+z2xSRES5VQVe39haLbNyhHz4mgmrcptTttnpU
 7ebQFxnSsMcww/bZxlKWfbYj96dcqIcZDWRc7Uwj0QC7TqNMICFbq79b1m90
X-Google-Smtp-Source: AGHT+IHhJbLnzZpnLhNz2DYz3u5WNeIm4VLsJgl7la6tcD3VvbApePzVl9209kIpHzKJo6Em8FbN6g==
X-Received: by 2002:a17:903:2284:b0:216:48f4:4f3d with SMTP id
 d9443c01a7336-21c3550e86cmr19129975ad.13.1737093526726; 
 Thu, 16 Jan 2025 21:58:46 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21c2d3d6fbbsm8563595ad.168.2025.01.16.21.58.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jan 2025 21:58:46 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Alexey Baturo <baturo.alexey@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 49/50] target/riscv: Support Supm and Sspm as part of Zjpm v1.0
Date: Fri, 17 Jan 2025 15:55:51 +1000
Message-ID: <20250117055552.108376-50-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250117055552.108376-1-alistair.francis@wdc.com>
References: <20250117055552.108376-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x629.google.com
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
2.47.1


