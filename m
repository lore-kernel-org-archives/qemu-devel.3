Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2590BEE644B
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 05:43:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1socSl-0007Wm-M5; Thu, 12 Sep 2024 01:33:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1socRN-0000su-OA
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 01:32:31 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1socRK-0003Bi-Sq
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 01:32:24 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-7179069d029so372806b3a.2
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 22:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726119141; x=1726723941; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rkFJkoUJd/HT9/094fGs2I2PCMVZbUiqtYOftglCzrg=;
 b=f4P/3j78pHImy8Sru7e3Z8Ln7z/fh8kmBEiMWM6ArBt59Q1VxkxJuxUFsYsrx4OwlK
 2SccLnw9kp43MwrjYeN57eKtcyNYIh6l9lK9F2rozaMG8SlgbVpbFmmRVXEn59S2hyo8
 Hf0VinDbOdiGfc9nZZTS1h8vHqFoLkYOVYgx/X3MLtPlVlYe+lmUIsdcrMuPjc7wZcMc
 zbKQBW1k6ZpMtns6QUx+d+0wjLgrfYx01mLip8ftOcmtqO2Ozdshmk3DdSdoTv0hM43H
 IKnKTK2Znc4w3SPxncA1VH4GgBQKnRdmdSW3+IxiLI8URPXm9zZGKlIJcLNS4wsCV1fK
 nMvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726119141; x=1726723941;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rkFJkoUJd/HT9/094fGs2I2PCMVZbUiqtYOftglCzrg=;
 b=HQ/haFgcVtqwWP3H2VszpB5haHlLF9epTsskal/Jve7UF6QcTNL7d5viuYgx5N878r
 99jkZ5ECm4ApVYv3gwRIsAtJNTzv1tDkI4KYem21/OpXmR980ZWvJN0GKQKDa1rzC987
 MkHocPI6Uw01ELwEo3o1CKNo29Fq3AebM1FHx4WhDajE9qcvj9uYr7YIz+krPb+w9paX
 cdDWx22EWLBirTsSF3BSJPBP8mlBo0w8qvte4qqt+jr9Qjf1z4ABLsZqG1/ii0ryMJOV
 9QLjK/GCFkA+aCU8Epe+8OUrj07OV85l/uyHKpqeHT326WMRzQ5WMBxVKKAPMvtA7+l5
 K6Rg==
X-Gm-Message-State: AOJu0YzqvCC8zg56I3fPvT85lP7KIj+t98Q6dOk5gbwjE+ejzx7il7Ub
 DXVfr4W8RZotcw75hpxIfHmyN2t5sTs3mxMucW8nUSfJijdJT2d3tC9Tqw==
X-Google-Smtp-Source: AGHT+IHUPAi7uCdOZoqoBDDeK/nKiyXIvApcmmtHKlDqWJbzsrDBSbtot8XFFP4SRZ+RHnPakjLK6A==
X-Received: by 2002:a05:6a00:1906:b0:714:1a74:9953 with SMTP id
 d2e1a72fcca58-71926087dc4mr2476261b3a.16.1726119141281; 
 Wed, 11 Sep 2024 22:32:21 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71908fc8fdesm3833034b3a.1.2024.09.11.22.32.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2024 22:32:20 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Alexandre Ghiti <alexghiti@rivosinc.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 44/47] target: riscv: Add Svvptc extension support
Date: Thu, 12 Sep 2024 15:29:49 +1000
Message-ID: <20240912052953.2552501-45-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240912052953.2552501-1-alistair.francis@wdc.com>
References: <20240912052953.2552501-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x436.google.com
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
index d215681905..cb675f0278 100644
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
@@ -1520,6 +1521,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
     MULTI_EXT_CFG_BOOL("svinval", ext_svinval, false),
     MULTI_EXT_CFG_BOOL("svnapot", ext_svnapot, false),
     MULTI_EXT_CFG_BOOL("svpbmt", ext_svpbmt, false),
+    MULTI_EXT_CFG_BOOL("svvptc", ext_svvptc, true),
 
     MULTI_EXT_CFG_BOOL("zicntr", ext_zicntr, true),
     MULTI_EXT_CFG_BOOL("zihpm", ext_zihpm, true),
-- 
2.46.0


