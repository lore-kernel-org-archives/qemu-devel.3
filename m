Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EBA8D11194
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 00:26:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7kqG-00026Z-QV; Sun, 03 Nov 2024 19:21:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1t7kqD-0001rV-OK; Sun, 03 Nov 2024 19:21:09 -0500
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1t7kqC-0002fI-4J; Sun, 03 Nov 2024 19:21:09 -0500
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-71ec997ad06so2939425b3a.3; 
 Sun, 03 Nov 2024 16:21:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730679666; x=1731284466; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u3pa1qIAf5Pto6BGGrw30p+Tnm3/DG2zMWLpFWSye10=;
 b=XX3erpPobRwA5Ye1LPsZdWC2IYEmPwHoawyZR1aqgo12NTIzpEqoClQVyxR72pS7R5
 B+6O3qRhc765pbBOJWxTEPzpmU8Gtxb1LV9fMq2Mx/+lRSFUT9UDE8us0NfQYZnqikyQ
 FhmNObTbZmXXg2nDmMSRjPtL69AS8K6c9yPiiUYBzTm84unSA7QhWdyPgQs9oj25nlpq
 h6zO2yzNgab3CORxxDzN5xmSfMyYsteWQRVu6nQ2GA5EghAeOls//5kmUG4fXbOty5wd
 wjEfA6QBZ2am4h8wFJEXHmGtzeG/1VGw1h22Z7sPqpHfgyaFTk0wwYmDUJzhECcN8U6l
 AJIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730679666; x=1731284466;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u3pa1qIAf5Pto6BGGrw30p+Tnm3/DG2zMWLpFWSye10=;
 b=inVrDY1m9HI0TbyxJvYYB78YIRzMim/vQ+8ZG9IJLmCUiRdgLmZywAV0VIxPmP/MH1
 9jwPk4wW6SHzNbDZkAB7XKIFSZCp83HstmBZBzzP4YSigrm4pG2uRhWz8iCefYztB96x
 HPmD42OfGgk2Q1dIxOzEi87Wx6qE7aPzmGnGyTMBPsOelWRPB4SYdP1sxktVhBigAP0n
 H085NmfBYqrZ2YP2siaHW5qyd3vnV2G+jKB0C/HvYre7hpmKXZtWihC890t0Kllk/zkZ
 c5uqIOadU/lkUvxbCcLHN8q9yHiNwRA6P3DiAVw1SKvg53c2MrpZx7S567jdExkPsGM2
 U9jw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWYPTByga8uMIQVVICiatHeF+3401IF0GmO/YzPIe1IfapY8L1zICcMhMNb2N8SkO06meqyMfTSLw==@nongnu.org
X-Gm-Message-State: AOJu0Yw8isFfAJAhE0a++QrLundCqFwHgcn4IadTtnE8HUeXfVhZVzfG
 OnrDaqqwMMxq5zvCeWzsKd6IDVAkKEryrPQ4LKFE4IMpDI6o7X8Zo7YfAg==
X-Google-Smtp-Source: AGHT+IET1csJaGF2C0ZH+VPDc3vWD4I1j/hmk/cc23QpAKmN6gkK5HDH4+nBNDiLRESCaEpmCSjOMg==
X-Received: by 2002:a05:6a00:331b:b0:721:19bc:4bf4 with SMTP id
 d2e1a72fcca58-72119bc986cmr5677850b3a.23.1730679665811; 
 Sun, 03 Nov 2024 16:21:05 -0800 (PST)
Received: from wheely.local0.net (124-171-217-17.tpgi.com.au. [124.171.217.17])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7ee45a0081esm5900648a12.59.2024.11.03.16.21.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Nov 2024 16:21:05 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Aditya Gupta <adityag@linux.ibm.com>,
 Amit Machhiwal <amachhiw@linux.ibm.com>
Subject: [PULL 31/67] target/ppc: Introduce
 'PowerPCCPUClass::spapr_logical_pvr'
Date: Mon,  4 Nov 2024 10:18:20 +1000
Message-ID: <20241104001900.682660-32-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241104001900.682660-1-npiggin@gmail.com>
References: <20241104001900.682660-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: Aditya Gupta <adityag@linux.ibm.com>

Introduce 'PnvChipClass::spapr_logical_pvr' to know corresponding logical
PVR of a PowerPC CPU.
This helps to have a one-to-one mapping between PVR and logical PVR for
a CPU, and used in a later commit to handle cases where PCR of two
generations of Power chip is same, which causes regressions with
compat-mode.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
Tested-by: Amit Machhiwal <amachhiw@linux.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/cpu.h      | 1 +
 target/ppc/cpu_init.c | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index b838bc2ab9..daa12f8733 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1473,6 +1473,7 @@ struct PowerPCCPUClass {
     void (*parent_parse_features)(const char *type, char *str, Error **errp);
 
     uint32_t pvr;
+    uint32_t spapr_logical_pvr;
     /*
      * If @best is false, match if pcc is in the family of pvr
      * Else match only if pcc is the best match for pvr in this family.
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 7c3716b56f..bc8ec77fa0 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -6154,6 +6154,7 @@ POWERPC_FAMILY(POWER7)(ObjectClass *oc, void *data)
 
     dc->fw_name = "PowerPC,POWER7";
     dc->desc = "POWER7";
+    pcc->spapr_logical_pvr = CPU_POWERPC_LOGICAL_2_06_PLUS;
     pcc->pvr_match = ppc_pvr_match_power7;
     pcc->pcr_mask = PCR_VEC_DIS | PCR_VSX_DIS | PCR_COMPAT_2_05;
     pcc->pcr_supported = PCR_COMPAT_2_06 | PCR_COMPAT_2_05;
@@ -6317,6 +6318,7 @@ POWERPC_FAMILY(POWER8)(ObjectClass *oc, void *data)
 
     dc->fw_name = "PowerPC,POWER8";
     dc->desc = "POWER8";
+    pcc->spapr_logical_pvr = CPU_POWERPC_LOGICAL_2_07;
     pcc->pvr_match = ppc_pvr_match_power8;
     pcc->pcr_mask = PCR_TM_DIS | PCR_COMPAT_2_06 | PCR_COMPAT_2_05;
     pcc->pcr_supported = PCR_COMPAT_2_07 | PCR_COMPAT_2_06 | PCR_COMPAT_2_05;
@@ -6510,6 +6512,7 @@ POWERPC_FAMILY(POWER9)(ObjectClass *oc, void *data)
 
     dc->fw_name = "PowerPC,POWER9";
     dc->desc = "POWER9";
+    pcc->spapr_logical_pvr = CPU_POWERPC_LOGICAL_3_00;
     pcc->pvr_match = ppc_pvr_match_power9;
     pcc->pcr_mask = PPC_PCR_MASK_POWER9;
     pcc->pcr_supported = PPC_PCR_SUPPORTED_POWER9;
@@ -6644,6 +6647,7 @@ POWERPC_FAMILY(POWER10)(ObjectClass *oc, void *data)
 
     dc->fw_name = "PowerPC,POWER10";
     dc->desc = "POWER10";
+    pcc->spapr_logical_pvr = CPU_POWERPC_LOGICAL_3_10;
     pcc->pvr_match = ppc_pvr_match_power10;
     pcc->pcr_mask = PPC_PCR_MASK_POWER10;
     pcc->pcr_supported = PPC_PCR_SUPPORTED_POWER10;
-- 
2.45.2


