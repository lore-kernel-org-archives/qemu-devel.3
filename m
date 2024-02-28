Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A2D0C54E41
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 18:52:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfP2A-0000q1-3p; Wed, 28 Feb 2024 13:52:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1rfP24-0000mY-6Y
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 13:51:56 -0500
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1rfP22-0006us-Gu
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 13:51:55 -0500
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-6da202aa138so4007750b3a.2
 for <qemu-devel@nongnu.org>; Wed, 28 Feb 2024 10:51:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1709146313; x=1709751113;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wsd4UJgUqZBGQqVPr0loi27Ch+LSMtssoNWVgdi64OI=;
 b=N4EcU+kSWEaYnQr2WekNE5+1L5tnOOnbESdh/oFjUZBFn/cRdWEKN/tpBaNDCu/EaB
 Zx0YvH44WBuJGV1gyo22NPQU43Df5mi8ZJylKx8bIivHcOKtg01wGJ3AgBG/n4bbHESs
 RVdgBl2DAo+fRZqBQu+Giw/hXqpjy22JgBYSPMHbs8FzZukHVpqJTuBoFTLuoBSS7Dzy
 yF+/Zlp6od088jqQzkEnoYlTvWFNrg10GkMuH9GnIs/qTKKwG20FGrldXQ3AQJgETFkx
 uP27fzbDra0ID5LVucp44qDV6nI77qcjMAQBHZ+QQGQrLKhY47uhOgxB8hBrhMUaa+9Z
 qMXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709146313; x=1709751113;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wsd4UJgUqZBGQqVPr0loi27Ch+LSMtssoNWVgdi64OI=;
 b=ID52QQ8B63NmjtF0oALhNY/kFfHeVrcIE7CJ6FiBwjj+Uc/q2AIpuFRGCeBsAH7PED
 EZ4fmTL0dwOj49mzJaMcXBAqDxB/o6nGmZ9rocveeFUVpIYO42c5w2ZWV7rKbEkSPWiv
 OqpAovmBXWEcjw5YuaItiL8/YtnT8GfXKcy9bHSZc1foysT/Sdj1bvkWrfhEoy3wpd0I
 y68vhPBVeQEDa8jqOJB4H2b62ErD2FPOETFtF4VowRboEkvdIuEMLMAKMOW2pLbTL1bL
 DfnfjxJdxUaB1ot4FdLjg0KsxYaNox9WgvhgWx4CGFm6ShWEibUGQDKNDSQgMA+rU/XT
 YuxQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXeRYbVfsB8ULPJgHS3sRmNqnajBVZtYy2HvC5pZXxNQIUkSk1BW8hncfw831oZeSn8di0NBwgMrO4cGaxNHUEi90ywuCw=
X-Gm-Message-State: AOJu0YytWSEg+2UN/1GSE30MYdZie2gvolgtIN4zO7tegVMxSw9Tpbql
 wAaunuSu/mwwjpwwdZnA4uTtRNu6zX2A7F9ilVGfzSNfY48VkSK/NW+zx6gkIPA=
X-Google-Smtp-Source: AGHT+IGViUo8qyT0MguJlDC6CdWNrZuARrlncVaSm2N8N02GKmAyc8JrY2Bo1Y1nUl0KqrO1A537Hw==
X-Received: by 2002:a05:6a21:3183:b0:1a1:1f7b:9b0f with SMTP id
 za3-20020a056a21318300b001a11f7b9b0fmr96768pzb.42.1709146313210; 
 Wed, 28 Feb 2024 10:51:53 -0800 (PST)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 o20-20020a635d54000000b005dbed0ffb10sm49562pgm.83.2024.02.28.10.51.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Feb 2024 10:51:52 -0800 (PST)
From: Atish Patra <atishp@rivosinc.com>
To: 
Cc: Atish Patra <atishp@rivosinc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, Weiwei Li <liwei1518@gmail.com>,
 kaiwenxue1@gmail.com
Subject: [PATCH v5 4/5] target/riscv: Add cycle & instret privilege mode
 filtering support
Date: Wed, 28 Feb 2024 10:51:15 -0800
Message-Id: <20240228185116.1321730-5-atishp@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240228185116.1321730-1-atishp@rivosinc.com>
References: <20240228185116.1321730-1-atishp@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=atishp@rivosinc.com; helo=mail-pf1-x42f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
 target/riscv/csr.c | 88 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 88 insertions(+)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index a3d979c4c72c..ff9bac537593 100644
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
@@ -826,6 +844,62 @@ static RISCVException read_hpmcounterh(CPURISCVState *env, int csrno,
 
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
@@ -4985,6 +5059,13 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
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
@@ -5044,6 +5125,13 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
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


