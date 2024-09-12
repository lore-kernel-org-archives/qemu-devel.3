Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADE60EEB569
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 08:49:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sofWH-00058i-GQ; Thu, 12 Sep 2024 04:49:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1sofVY-00022E-Eq
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 04:48:56 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1sofVV-0000M5-LP
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 04:48:56 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-42cba6cdf32so5566805e9.1
 for <qemu-devel@nongnu.org>; Thu, 12 Sep 2024 01:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1726130931; x=1726735731;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eLUH+r45114WMEvaAcjXsA6R1Njb1Sm2E3aFCFu9vyg=;
 b=ElV/01zMqUYpy39PL62iNPFmHUlxOFrGdwFFm84sT2lJp6+nXlBI+PBo7ykLlVAvwW
 nJEtAiAjMd7ndB9mjm9y6oI0MiHQIkuHf9j2ZoTPWxy6WLYE6USTlcvtLQlxSQ6orOgY
 UxvMmNl74a7WM+jEEW5/wdZv0swDGW1oakMrmfiWftjz9NZsWAs/QBf3UDGSZ7vWx2dB
 +A7JawwT4rC58+tAIvkvnkDu2SHCR3P3aJsuSaaaTKZHdM7BERJqcNOWkTBJfXel/xPZ
 HYmAjTFPOW7dfF2C75L+fAR8I2JTmdbC6TJADErs0cV0GZvvUWXTGcJtx5ZdL5OhlJin
 aQNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726130931; x=1726735731;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eLUH+r45114WMEvaAcjXsA6R1Njb1Sm2E3aFCFu9vyg=;
 b=YF8+RY0KxN85A5WzIH3YfQ6B/t79P6glLHEMnyjJFUCU9Bbl/wrKD6HcF95FCzgmet
 7+FGLivT6xtW+NvNI5Uryx5ihpNk2RNxeIhEogZ7iXUKNgF85pMwVWhlp5u0wrv1xrXt
 VwyvHMiHsZHfTvgzNsQrRZv0XMlk7bIOX69XM2Z8nU/QLsU0ucOygJijR6Pu8ISwWC/5
 Z3PKAIoWod7E5/oUgUikcQ9qtCd0zCKEHuYoLchL8NFU/fiW4YGBWCHwpQshcGN8P/dW
 M62HQwbjdtNTWt7Q4vX+VqjgM/xNcj17tvD/XQ9giuFxOjLLUrt/Ck3oEFSR6crM3m6u
 SWow==
X-Forwarded-Encrypted: i=1;
 AJvYcCXxbbOC6aHLBUANXjD80NR2R03RoH1P5I7mhcpWfpMVLt7mgrwD04R85ViwE4svjDkTZCdhO+0R1N3b@nongnu.org
X-Gm-Message-State: AOJu0YxldbmpJulP9WnOZtQKF9/Ugbx0XlyHQB4oOUOp6M5SOB/JI73+
 fNab3kwogLE7QpzkJY3H2D+EWTlujj3gLt/3CDFymJcsDazAuyT55vr6AcTsEA0=
X-Google-Smtp-Source: AGHT+IH1v+QbjLzkKBxfLPQ5n+gRUk1EJoFu/eydGhVZmoWOMghTMZsCRWGtrJSrkIZ1uZ1gAdGaCw==
X-Received: by 2002:a05:600c:1d23:b0:428:eb6:2e73 with SMTP id
 5b1f17b1804b1-42cdb58db62mr16088985e9.29.1726130931030; 
 Thu, 12 Sep 2024 01:48:51 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42caeb33a92sm165637475e9.20.2024.09.12.01.48.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Sep 2024 01:48:50 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To: qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>
Cc: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Ved Shanbhogue <ved@rivosinc.com>, Atish Patra <atishp@rivosinc.com>,
 qemu-devel@nongnu.org
Subject: [PATCH 10/10] target/riscv: Add Smdbltrp ISA extension enable switch
Date: Thu, 12 Sep 2024 10:48:29 +0200
Message-ID: <20240912084832.2906991-11-cleger@rivosinc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240912084832.2906991-1-cleger@rivosinc.com>
References: <20240912084832.2906991-1-cleger@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=cleger@rivosinc.com; helo=mail-wm1-x336.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Add the switch to enable the Smdbltrp ISA extension.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
---
 target/riscv/cpu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index f9b2ce4463..3a3009bd23 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -183,6 +183,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(zhinxmin, PRIV_VERSION_1_12_0, ext_zhinxmin),
     ISA_EXT_DATA_ENTRY(smaia, PRIV_VERSION_1_12_0, ext_smaia),
     ISA_EXT_DATA_ENTRY(smcntrpmf, PRIV_VERSION_1_12_0, ext_smcntrpmf),
+    ISA_EXT_DATA_ENTRY(smdbltrp, PRIV_VERSION_1_12_0, ext_smdbltrp),
     ISA_EXT_DATA_ENTRY(smepmp, PRIV_VERSION_1_12_0, ext_smepmp),
     ISA_EXT_DATA_ENTRY(smrnmi, PRIV_VERSION_1_12_0, ext_smrnmi),
     ISA_EXT_DATA_ENTRY(smstateen, PRIV_VERSION_1_12_0, ext_smstateen),
@@ -1518,6 +1519,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
     MULTI_EXT_CFG_BOOL("sstc", ext_sstc, true),
 
     MULTI_EXT_CFG_BOOL("smaia", ext_smaia, false),
+    MULTI_EXT_CFG_BOOL("smdbltrp", ext_smdbltrp, false),
     MULTI_EXT_CFG_BOOL("smepmp", ext_smepmp, false),
     MULTI_EXT_CFG_BOOL("smrnmi", ext_smrnmi, false),
     MULTI_EXT_CFG_BOOL("smstateen", ext_smstateen, false),
-- 
2.45.2


