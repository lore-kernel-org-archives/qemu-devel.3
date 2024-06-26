Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66A3BC3065A
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2024 23:59:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMcWJ-0007lq-99; Wed, 26 Jun 2024 19:57:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1sMcWH-0007kz-32
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 19:57:45 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1sMcWD-0005Ws-CK
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 19:57:43 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1fa2ea1c443so35407105ad.0
 for <qemu-devel@nongnu.org>; Wed, 26 Jun 2024 16:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1719446260; x=1720051060;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=nDQ3jPehOm7jzw/xdikGD5KLWVY4jFRNgfvWhNKrejQ=;
 b=W+xAyOkhRMfwojZNqp1yH1FA5QcFS4uRNZR5ZLZvY59XmjLu+0ZlmzoAl0SEQxTE/I
 MfF/YYK2b5Msuo1xfElSMWFYh5FMx1aAb18rnbHoprOEj5wIMJLZ60BQ9An+MzRrrtsO
 WoX4OKZUxWrnhRYz3kM/uqoEBJHJpSU82Gne1loFDxRrXuEzAsNx5kuohDaLl6wciCLE
 0wQ5PrMWga9eACfF5XOBJ8rIFvai8UrI65Epbbvbtt5YwHpL67TN1w6MEYHqECEPjxW9
 VHGsWfcxqQXbC3bLqXQUTjv15O/t7Lsrf+fFhlR+PESlokmujLMeDgWvlbMlUXtsMlmw
 Xy2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719446260; x=1720051060;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nDQ3jPehOm7jzw/xdikGD5KLWVY4jFRNgfvWhNKrejQ=;
 b=X4JW9K0aAdL1fRwNZY+O+/7Iyz6QKB8l2+HAe2ePGRCd1Sm4lpVOR1kooWn2ltyotl
 FP5EXJb7UWPNsyrtDJvvDCg3B3MNOX7Lm1WmgLPjMkwJwYqg2Cx9T7Mpy63/d+ZDrOo4
 53Ydp9QQxpVCyGPM7rmKY0PCOQIqmxaSvu0zawSL7im/yVGdeRVeIBRHUUVTiFPq1PYq
 2AuRsuy5vujUQMtiGnSrneRCkDTMWVkjBY9HPtycIr99nHm71rSTi0AGZMnvPUlMXW9e
 IMNywSJFsEITcIMrrtRUiLqYPi/c+DUJp5D5wEtEPc/qB1CraAjDBkn4SZEPcXZscTFB
 vskg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXyC4PMypT/UjTR4gAiECcVff4LbTQToM6CRJClGz21ZQ7ACdTPzuiIV0enic/qmXONqvQ91eQFMGm6LbXBaoPv5GA/wSY=
X-Gm-Message-State: AOJu0YwceTsuv3/2rmf6v+tZ0Q28+TopG4ok00KSm4Cn4ezVAqd1J6zU
 SMf2OiEnlo1SnG9ixPksC2sJdFHLpD2/EpkBSjbIEtJllSe+NOwL8Zr+rQyCs6w=
X-Google-Smtp-Source: AGHT+IEHE9RTNzx3DDPgdE1zj3WTtrc+RfjpgQtVrJLi6E4KvgOKZ2TbWnQ9QeiATXoEEFW4oc+f4g==
X-Received: by 2002:a17:902:ec8e:b0:1f7:3d0d:4d0 with SMTP id
 d9443c01a7336-1fa23cd7cf4mr139983035ad.25.1719446259848; 
 Wed, 26 Jun 2024 16:57:39 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1faac998398sm630965ad.225.2024.06.26.16.57.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Jun 2024 16:57:39 -0700 (PDT)
From: Atish Patra <atishp@rivosinc.com>
Date: Wed, 26 Jun 2024 16:57:25 -0700
Subject: [PATCH v7 05/11] target/riscv: Add cycle & instret privilege mode
 filtering support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240626-smcntrpmf_v7-v7-5-bb0f10af7fa9@rivosinc.com>
References: <20240626-smcntrpmf_v7-v7-0-bb0f10af7fa9@rivosinc.com>
In-Reply-To: <20240626-smcntrpmf_v7-v7-0-bb0f10af7fa9@rivosinc.com>
To: qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: Rajnesh Kanwal <rkanwal@rivosinc.com>, 
 Atish Patra <atishp@rivosinc.com>, palmer@dabbelt.com, liwei1518@gmail.com, 
 zhiwei_liu@linux.alibaba.com, bin.meng@windriver.com, 
 dbarboza@ventanamicro.com, alistair.francis@wdc.com, 
 Kaiwen Xue <kaiwenx@rivosinc.com>
X-Mailer: b4 0.15-dev-13183
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=atishp@rivosinc.com; helo=mail-pl1-x62b.google.com
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

From: Kaiwen Xue <kaiwenx@rivosinc.com>

QEMU only calculates dummy cycles and instructions, so there is no
actual means to stop the icount in QEMU. Hence this patch merely adds
the functionality of accessing the cfg registers, and cause no actual
effects on the counting of cycle and instret counters.

Signed-off-by: Atish Patra <atishp@rivosinc.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Signed-off-by: Kaiwen Xue <kaiwenx@rivosinc.com>
---
 target/riscv/csr.c | 88 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 88 insertions(+)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 3ad851707e5c..665c534db1a0 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -236,6 +236,24 @@ static RISCVException sscofpmf_32(CPURISCVState *env, int csrno)
     return sscofpmf(env, csrno);
 }
 
+static RISCVException smcntrpmf(CPURISCVState *env, int csrno)
+{
+    if (!riscv_cpu_cfg(env)->ext_smcntrpmf) {
+        return RISCV_EXCP_ILLEGAL_INST;
+    }
+
+    return RISCV_EXCP_NONE;
+}
+
+static RISCVException smcntrpmf_32(CPURISCVState *env, int csrno)
+{
+    if (riscv_cpu_mxl(env) != MXL_RV32) {
+        return RISCV_EXCP_ILLEGAL_INST;
+    }
+
+    return smcntrpmf(env, csrno);
+}
+
 static RISCVException any(CPURISCVState *env, int csrno)
 {
     return RISCV_EXCP_NONE;
@@ -830,6 +848,62 @@ static RISCVException read_hpmcounterh(CPURISCVState *env, int csrno,
 
 #else /* CONFIG_USER_ONLY */
 
+static RISCVException read_mcyclecfg(CPURISCVState *env, int csrno,
+                                     target_ulong *val)
+{
+    *val = env->mcyclecfg;
+    return RISCV_EXCP_NONE;
+}
+
+static RISCVException write_mcyclecfg(CPURISCVState *env, int csrno,
+                                      target_ulong val)
+{
+    env->mcyclecfg = val;
+    return RISCV_EXCP_NONE;
+}
+
+static RISCVException read_mcyclecfgh(CPURISCVState *env, int csrno,
+                                      target_ulong *val)
+{
+    *val = env->mcyclecfgh;
+    return RISCV_EXCP_NONE;
+}
+
+static RISCVException write_mcyclecfgh(CPURISCVState *env, int csrno,
+                                       target_ulong val)
+{
+    env->mcyclecfgh = val;
+    return RISCV_EXCP_NONE;
+}
+
+static RISCVException read_minstretcfg(CPURISCVState *env, int csrno,
+                                       target_ulong *val)
+{
+    *val = env->minstretcfg;
+    return RISCV_EXCP_NONE;
+}
+
+static RISCVException write_minstretcfg(CPURISCVState *env, int csrno,
+                                        target_ulong val)
+{
+    env->minstretcfg = val;
+    return RISCV_EXCP_NONE;
+}
+
+static RISCVException read_minstretcfgh(CPURISCVState *env, int csrno,
+                                        target_ulong *val)
+{
+    *val = env->minstretcfgh;
+    return RISCV_EXCP_NONE;
+}
+
+static RISCVException write_minstretcfgh(CPURISCVState *env, int csrno,
+                                         target_ulong val)
+{
+    env->minstretcfgh = val;
+    return RISCV_EXCP_NONE;
+}
+
 static RISCVException read_mhpmevent(CPURISCVState *env, int csrno,
                                      target_ulong *val)
 {
@@ -5051,6 +5125,13 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
                              write_mcountinhibit,
                              .min_priv_ver = PRIV_VERSION_1_11_0       },
 
+    [CSR_MCYCLECFG]      = { "mcyclecfg",   smcntrpmf, read_mcyclecfg,
+                             write_mcyclecfg,
+                             .min_priv_ver = PRIV_VERSION_1_12_0       },
+    [CSR_MINSTRETCFG]    = { "minstretcfg", smcntrpmf, read_minstretcfg,
+                             write_minstretcfg,
+                             .min_priv_ver = PRIV_VERSION_1_12_0       },
+
     [CSR_MHPMEVENT3]     = { "mhpmevent3",     any,    read_mhpmevent,
                              write_mhpmevent                           },
     [CSR_MHPMEVENT4]     = { "mhpmevent4",     any,    read_mhpmevent,
@@ -5110,6 +5191,13 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
     [CSR_MHPMEVENT31]    = { "mhpmevent31",    any,    read_mhpmevent,
                              write_mhpmevent                           },
 
+    [CSR_MCYCLECFGH]     = { "mcyclecfgh",   smcntrpmf_32, read_mcyclecfgh,
+                             write_mcyclecfgh,
+                             .min_priv_ver = PRIV_VERSION_1_12_0        },
+    [CSR_MINSTRETCFGH]   = { "minstretcfgh", smcntrpmf_32, read_minstretcfgh,
+                             write_minstretcfgh,
+                             .min_priv_ver = PRIV_VERSION_1_12_0        },
+
     [CSR_MHPMEVENT3H]    = { "mhpmevent3h",    sscofpmf_32,  read_mhpmeventh,
                              write_mhpmeventh,
                              .min_priv_ver = PRIV_VERSION_1_12_0        },

-- 
2.34.1


