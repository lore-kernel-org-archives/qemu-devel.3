Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7497CF9C6B
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2024 22:24:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stDsZ-0000xZ-4v; Tue, 24 Sep 2024 18:19:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1stDsV-0000Y1-RT
 for qemu-devel@nongnu.org; Tue, 24 Sep 2024 18:19:29 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1stDsU-0001iX-9a
 for qemu-devel@nongnu.org; Tue, 24 Sep 2024 18:19:27 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2053a0bd0a6so60737915ad.3
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2024 15:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727216364; x=1727821164; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ydYBR9CS7vE3KvTVV/eJ6sMuPPlgLEqI5qHhODbtvEs=;
 b=AJsskPLLGV4Hc84FYsYUEJxFYDbppvhFAjmKtukI2qWKt8t2AhL2ukgVMWhVpJBuEw
 n/waIkdA3rMnLDeSjZUh5kopwaVW2BynEcwgl1c8p8UJv/uL0yFYRdGR0NubgrsBvr12
 a9r1S1/JdB+9LvbO4NNJkdYKbk/fqx6s4Z9GLrcJwMYH7Wx0r6xF2t7/zkzEJolPC4H4
 L9zKVx9r1exkOi5EbOCAFMK1vWcVVPtj3LRJcymvwpCJ0+QV3QJO0Y2iejkVl/Wwcden
 sTjoEhsRZzSc3xriQxQWAU9C6tfaSUXORFAMfv+pcckcZmBBh4nxNJ66fcH8RNc3tXWZ
 0woQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727216364; x=1727821164;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ydYBR9CS7vE3KvTVV/eJ6sMuPPlgLEqI5qHhODbtvEs=;
 b=Z+mKni7I+GVhQoWf1wCL2IkRt3+aGEsVnfALjiTUi4YEDRmPSL7elsvdztPBmJ8slZ
 MuIwlX8mH1H6Kza0O/Fjj7guW0DBdWkCwgk93rHGFe+nmSSzgaFjH26MGsWx86PCspLt
 mmK1xOtugCxi4IMg3pcyy6oYeyDskozR1ZYkGyvP0Ss4/rq85gznFbwIoDorc4KzlnhO
 SJ5S13OwPh92mBv1w3nllWE+PYF+Kk5GhcasT2uN0OLINkswyTcrNCoCzWVFixwlQaxj
 9wGYiGONXyeR/FpiFRjv+sTRPR1nB6xJ79LkaHUZ2TuhZNyzb6d5VDb8OWakain0peVC
 pm5g==
X-Gm-Message-State: AOJu0Yw2MnD6wU/UflWk6lO+3RquWnK09fgSCvmMnD0KaFyuQ3FxVuZM
 Yhm6jeYf56DfjFad80mav6sSMrWa0/b4djNiD5Qsg76q/510VLbwE3CTXw==
X-Google-Smtp-Source: AGHT+IFfW4P3yItMqF9RcdLPmuPLmaK1yUB3QgWkl23aY6tVk1pXMT+nwa0nupsQdUO5nAaD6/Rk0w==
X-Received: by 2002:a05:6300:668b:b0:1ce:dd2e:d875 with SMTP id
 adf61e73a8af0-1d4e0bed98amr677636637.37.1727216364383; 
 Tue, 24 Sep 2024 15:19:24 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71afc8342easm1665310b3a.11.2024.09.24.15.19.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Sep 2024 15:19:23 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Alexandre Ghiti <alexghiti@rivosinc.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 27/47] target: riscv: Add Svvptc extension support
Date: Wed, 25 Sep 2024 08:17:28 +1000
Message-ID: <20240924221751.2688389-28-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20240924221751.2688389-1-alistair.francis@wdc.com>
References: <20240924221751.2688389-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62f.google.com
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

From: Alexandre Ghiti <alexghiti@rivosinc.com>

The Svvptc extension describes a uarch that does not cache invalid TLB
entries: that's the case for qemu so there is nothing particular to
implement other than the introduction of this extension.

Since qemu already exposes Svvptc behaviour, let's enable it by default
since it allows to drastically reduce the number of sfence.vma emitted
by S-mode.

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20240828083651.203861-1-alexghiti@rivosinc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_cfg.h | 1 +
 target/riscv/cpu.c     | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index 96fe26d4ea..355afedfd3 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -81,6 +81,7 @@ struct RISCVCPUConfig {
     bool ext_svinval;
     bool ext_svnapot;
     bool ext_svpbmt;
+    bool ext_svvptc;
     bool ext_zdinx;
     bool ext_zaamo;
     bool ext_zacas;
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 89bc3955ee..658bdb4ae1 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -197,6 +197,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(svinval, PRIV_VERSION_1_12_0, ext_svinval),
     ISA_EXT_DATA_ENTRY(svnapot, PRIV_VERSION_1_12_0, ext_svnapot),
     ISA_EXT_DATA_ENTRY(svpbmt, PRIV_VERSION_1_12_0, ext_svpbmt),
+    ISA_EXT_DATA_ENTRY(svvptc, PRIV_VERSION_1_13_0, ext_svvptc),
     ISA_EXT_DATA_ENTRY(xtheadba, PRIV_VERSION_1_11_0, ext_xtheadba),
     ISA_EXT_DATA_ENTRY(xtheadbb, PRIV_VERSION_1_11_0, ext_xtheadbb),
     ISA_EXT_DATA_ENTRY(xtheadbs, PRIV_VERSION_1_11_0, ext_xtheadbs),
@@ -1494,6 +1495,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
     MULTI_EXT_CFG_BOOL("svinval", ext_svinval, false),
     MULTI_EXT_CFG_BOOL("svnapot", ext_svnapot, false),
     MULTI_EXT_CFG_BOOL("svpbmt", ext_svpbmt, false),
+    MULTI_EXT_CFG_BOOL("svvptc", ext_svvptc, true),
 
     MULTI_EXT_CFG_BOOL("zicntr", ext_zicntr, true),
     MULTI_EXT_CFG_BOOL("zihpm", ext_zihpm, true),
-- 
2.46.1


