Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EEADD10F3A
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2024 01:19:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tCqO7-00017w-Ur; Sun, 17 Nov 2024 20:17:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1tCqO2-00012l-0l
 for qemu-devel@nongnu.org; Sun, 17 Nov 2024 20:17:06 -0500
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1tCqNx-0006Q2-Tq
 for qemu-devel@nongnu.org; Sun, 17 Nov 2024 20:17:04 -0500
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-720cb6ac25aso2854446b3a.3
 for <qemu-devel@nongnu.org>; Sun, 17 Nov 2024 17:16:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1731892618; x=1732497418;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ohgDmegIpcebV+ImvHj4TXEAkaSmzoAiG2T69HxohHg=;
 b=Oih2HBo7fURU5JOyui2rzWSwgzVphJA39Fv3xcnk0o1fjudepQaiue91oNRWVw/v0t
 0tvK3Lexg3w1NtqqBrNBlfQhLEJBVDMdv08JyJsRsAOWWj5St25vjxxil7G4wzCPO2bA
 l5uFn7xxoxVstRDR4AFMtoYGMPAyZCZYwxPMnEnEFrleb591D6B+NyiZ+Uzjjtozx4dL
 UQKQhKwgs63qKA3SsZkbp3TQlB7SoJ8I5XlyYYkpircNInLdSm5FSpd+dozLo2OhfAgb
 fla+NonYpP5FmtkA6OhRbu06rV+jFdVKk2MBQ/WiBITZCttvhL0uq96LXceeHR/cWj3o
 IPpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731892618; x=1732497418;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ohgDmegIpcebV+ImvHj4TXEAkaSmzoAiG2T69HxohHg=;
 b=FsRnNBD7OrEbnIOaRz6Cnpu99bbslQkiItEGzAu0w9eXv1ocYCXKVgCaXeTapjOoG1
 o++JndHTd3Lk+KmUyo53fZ2PPPFdpp3H41Zs48iUKYkbT+KjTQd8hjcXp5Ga+P60jUFv
 inUheoCuv0FDwuItDDFCaasTryd75EyXxtAzavWIDSmiD86hfDVD2qe368BWz2voVHn2
 WEZkpFqQSkiH4Ps0fReWOFtU9pCZ4Z+hLv/y+B0un/RDYRrbyUxSIExvRETC12VI6Zyd
 djpHQZqlX6OOD+SiFQNxCI54t4ceBxTqhZQa0ZWUFiyhhQOWiNM/SSzKeCLmnQ4qKZxl
 Razg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUXldDUZmzX4Wv0oNalMgMeQUjpJGOpJy8hjlqKhLhMyoX8i5tG1ksnFJrmpqCzGoP7c7LEIiyOdNax@nongnu.org
X-Gm-Message-State: AOJu0YxMRLC0vY50UKbxCwrtEu9cGaYYG3mKJT7SNy9ilxPeVFm84LYh
 uetmmzO67A+HcuzFjok3AABXTmAO0+vAc/8/pNWCfZcHU1aSV2eaKKbAaVaiQVjSZ9+PnkcLR33
 F
X-Google-Smtp-Source: AGHT+IGCrdO9obb+5iWi2afFJIXS+x2sTHe156h4tameoBEGNc4qJBm1kmerOnnN+zX2APHk6d7D8g==
X-Received: by 2002:a05:6a00:4fc8:b0:71e:5e04:be9b with SMTP id
 d2e1a72fcca58-72476bb89b3mr12660820b3a.12.1731892617737; 
 Sun, 17 Nov 2024 17:16:57 -0800 (PST)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-724771e8b75sm5134024b3a.147.2024.11.17.17.16.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 Nov 2024 17:16:57 -0800 (PST)
From: Atish Patra <atishp@rivosinc.com>
Date: Sun, 17 Nov 2024 17:15:53 -0800
Subject: [PATCH v3 05/11] target/riscv: Add properties for counter
 delegation ISA extensions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241117-counter_delegation-v3-5-476d6f36e3c8@rivosinc.com>
References: <20241117-counter_delegation-v3-0-476d6f36e3c8@rivosinc.com>
In-Reply-To: <20241117-counter_delegation-v3-0-476d6f36e3c8@rivosinc.com>
To: qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: kaiwenxue1@gmail.com, Atish Patra <atishp@rivosinc.com>, 
 palmer@dabbelt.com, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 bin.meng@windriver.com, dbarboza@ventanamicro.com, alistair.francis@wdc.com
X-Mailer: b4 0.15-dev-13183
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=atishp@rivosinc.com; helo=mail-pf1-x433.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

This adds the properties for counter delegation ISA extensions
(Smcdeleg/Ssccfg). Definitions of new registers and and implementation
will come in the next set of patches.

Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 target/riscv/cpu.c     | 2 ++
 target/riscv/cpu_cfg.h | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 963f1f3af9ae..82edd28e2e1d 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -184,11 +184,13 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(zhinx, PRIV_VERSION_1_12_0, ext_zhinx),
     ISA_EXT_DATA_ENTRY(zhinxmin, PRIV_VERSION_1_12_0, ext_zhinxmin),
     ISA_EXT_DATA_ENTRY(smaia, PRIV_VERSION_1_12_0, ext_smaia),
+    ISA_EXT_DATA_ENTRY(smcdeleg, PRIV_VERSION_1_13_0, ext_smcdeleg),
     ISA_EXT_DATA_ENTRY(smcntrpmf, PRIV_VERSION_1_12_0, ext_smcntrpmf),
     ISA_EXT_DATA_ENTRY(smcsrind, PRIV_VERSION_1_13_0, ext_smcsrind),
     ISA_EXT_DATA_ENTRY(smepmp, PRIV_VERSION_1_12_0, ext_smepmp),
     ISA_EXT_DATA_ENTRY(smstateen, PRIV_VERSION_1_12_0, ext_smstateen),
     ISA_EXT_DATA_ENTRY(ssaia, PRIV_VERSION_1_12_0, ext_ssaia),
+    ISA_EXT_DATA_ENTRY(ssccfg, PRIV_VERSION_1_13_0, ext_ssccfg),
     ISA_EXT_DATA_ENTRY(ssccptr, PRIV_VERSION_1_11_0, has_priv_1_11),
     ISA_EXT_DATA_ENTRY(sscofpmf, PRIV_VERSION_1_12_0, ext_sscofpmf),
     ISA_EXT_DATA_ENTRY(sscounterenw, PRIV_VERSION_1_12_0, has_priv_1_12),
diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index 8b974255f6fb..ae2b019703fe 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -78,6 +78,8 @@ struct RISCVCPUConfig {
     bool ext_ztso;
     bool ext_smstateen;
     bool ext_sstc;
+    bool ext_smcdeleg;
+    bool ext_ssccfg;
     bool ext_smcntrpmf;
     bool ext_smcsrind;
     bool ext_sscsrind;

-- 
2.34.1


