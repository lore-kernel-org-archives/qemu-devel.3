Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E66EC54791
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 06:11:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkHp5-0000Wa-EB; Wed, 13 Mar 2024 02:10:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hchauhan@ventanamicro.com>)
 id 1rkHot-0000Ux-Hp
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 02:10:32 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hchauhan@ventanamicro.com>)
 id 1rkHok-0008RD-Ua
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 02:10:30 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1dcc0d163a1so13125015ad.0
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 23:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1710310218; x=1710915018; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=unnAXJbPYPZ3SFQaDxFCULuepgVukaNHvc6kAQD83Mg=;
 b=DYDxfYCFlUKeE9+kemlXKnUplAo7FutV9+7q/m9+imu2kS2jsqnPIEFmBxhEhxgzP1
 NuaHkYMVlWrbNrmYLZK6gHjp9I5fgHt4ef2YRf7fOqb9FuuQORGSLFa0oZqOIAivA1BJ
 udk3uGHsjN8qmOTdaPv6iMVyUJOqIu9PCeP4xt/eeM5ES283NrLXL0PwdVNRL+Iy9+0K
 1aonarhzld43cD8zKWAjAAlF7pa/YpH5LoGRagzMgRyPFQeN3J0MSleRXssAJbo5QXT6
 YhtdGeRGfmFwRmTXmZUC27bIP3lbIXurAze1DOJdZQ7Jxzs9QxhzQ656H2tWxYxDD37W
 lcgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710310218; x=1710915018;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=unnAXJbPYPZ3SFQaDxFCULuepgVukaNHvc6kAQD83Mg=;
 b=wO7NRu3tUIZqaee1MOPgO7VEsTatYVD5PeUhE0iFW7pktv04sAtmSD1EOmxn5Q1aCM
 V9vxZFoxRyeCxEBHvAJdxjQKQqXgfFOZfUaom7gWeMwEPq03q8UmHJ8ayaWzH+y5gQWD
 fUhcnoXP1yHIacBeDGi/2OvMfPG9KdG+OoK4ltP3xB827ucPzBrJdV+rwffhQheqy4UM
 5z5bMs+ZpcNMqixcU8mPFPiYNdCCu1WvhkxYsXN+gB4kPvZmcP8OoORa06W/YvmQKlmW
 ckyl1RGEBbGoUHlK6DFBTHmc9ZoIPCv7t5lnxI2E5KTAH4wrGR9NiHwcNqxsZb3MP5so
 tq7Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXLtF1/8vYW6GRN3SRis4ZDfYHbwmQaQypkNqFD+3woq14g+05Dz3BNqdapcvyFxsHGtwzsOF5fJeqLqxEX5v22PBT9/r8=
X-Gm-Message-State: AOJu0Yy5k7U7sIBMOeQ271Ra2TG1ataWbCfID+FLs/8l4h5FhN2e7gby
 2Qqj0Hyv++oMHvjZp0NCZsuNTegKtPBrcWbhTHPttwDweiLA6IyaW+8SEWaZmM8aejADEaveD3M
 L
X-Google-Smtp-Source: AGHT+IGtJFfCuPj4EK5G/SINU6FLz3LBPeObe2Wl+GqYTiLAuH5R8N6maKWj8eWPachbnAdY/PfVRg==
X-Received: by 2002:a17:902:c10c:b0:1dc:82bc:c072 with SMTP id
 12-20020a170902c10c00b001dc82bcc072mr12684563pli.1.1710310218338; 
 Tue, 12 Mar 2024 23:10:18 -0700 (PDT)
Received: from localhost.localdomain ([106.51.83.242])
 by smtp.gmail.com with ESMTPSA id
 kj14-20020a17090306ce00b001dd3bc79142sm7755402plb.264.2024.03.12.23.10.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 23:10:18 -0700 (PDT)
From: Himanshu Chauhan <hchauhan@ventanamicro.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v4 2/3] target/riscv: Expose sdtrig ISA extension
Date: Wed, 13 Mar 2024 11:39:30 +0530
Message-Id: <20240313060931.242161-3-hchauhan@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240313060931.242161-1-hchauhan@ventanamicro.com>
References: <20240313060931.242161-1-hchauhan@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=hchauhan@ventanamicro.com; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This patch adds "sdtrig" in the ISA string when sdtrig extension is enabled.
The sdtrig extension may or may not be implemented in a system. Therefore, the
           -cpu rv64,sdtrig=<true/false>
option can be used to dynamically turn sdtrig extension on or off.

Since, the sdtrig ISA extension is a superset of debug specification, disable
the debug property when sdtrig is enabled. A warning is printed when this is
done.

By default, the sdtrig extension is disabled and debug property enabled as usual.

Signed-off-by: Himanshu Chauhan <hchauhan@ventanamicro.com>
---
 target/riscv/cpu.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 2602aae9f5..ab057a0926 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -175,6 +175,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(zvkt, PRIV_VERSION_1_12_0, ext_zvkt),
     ISA_EXT_DATA_ENTRY(zhinx, PRIV_VERSION_1_12_0, ext_zhinx),
     ISA_EXT_DATA_ENTRY(zhinxmin, PRIV_VERSION_1_12_0, ext_zhinxmin),
+    ISA_EXT_DATA_ENTRY(sdtrig, PRIV_VERSION_1_12_0, ext_sdtrig),
     ISA_EXT_DATA_ENTRY(smaia, PRIV_VERSION_1_12_0, ext_smaia),
     ISA_EXT_DATA_ENTRY(smepmp, PRIV_VERSION_1_12_0, ext_smepmp),
     ISA_EXT_DATA_ENTRY(smstateen, PRIV_VERSION_1_12_0, ext_smstateen),
@@ -1008,6 +1009,12 @@ static void riscv_cpu_reset_hold(Object *obj)
     set_default_nan_mode(1, &env->fp_status);
 
 #ifndef CONFIG_USER_ONLY
+    if (cpu->cfg.debug && cpu->cfg.ext_sdtrig) {
+	    warn_report("Disabling debug property since sdtrig ISA extension "
+			"is enabled");
+	    cpu->cfg.debug = 0;
+    }
+
     if (cpu->cfg.debug || cpu->cfg.ext_sdtrig) {
         riscv_trigger_reset_hold(env);
     }
@@ -1480,6 +1487,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
     MULTI_EXT_CFG_BOOL("zvfhmin", ext_zvfhmin, false),
     MULTI_EXT_CFG_BOOL("sstc", ext_sstc, true),
 
+    MULTI_EXT_CFG_BOOL("sdtrig", ext_sdtrig, false),
     MULTI_EXT_CFG_BOOL("smaia", ext_smaia, false),
     MULTI_EXT_CFG_BOOL("smepmp", ext_smepmp, false),
     MULTI_EXT_CFG_BOOL("smstateen", ext_smstateen, false),
-- 
2.34.1


