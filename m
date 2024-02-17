Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71A54C48BF6
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Feb 2024 00:03:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rb89j-0003RQ-6c; Fri, 16 Feb 2024 19:02:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1rb89g-0003PX-7Y
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 19:02:08 -0500
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1rb89Q-0007vj-Lc
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 19:02:07 -0500
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-6e09a890341so1658264b3a.3
 for <qemu-devel@nongnu.org>; Fri, 16 Feb 2024 16:01:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1708128108; x=1708732908;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xvIpWUym5/yIAwAbNTwXXgkxED4xulVwom9cPTjrKJ4=;
 b=SjhbR00bfl8Plq2UbIAEUpPX7rwoFo6HBES9q1tQmO2nMw/rbdOZXJGg46PuhxqBp7
 nNp0pjqSPKz7/tGzllKfnWfsyjOa669c86XryrO+z22E+f4s4Ar15GScRnMe0qJ1KiJ9
 oY1F6QorVtj60O3OYTzNPD8bv3HvoZxwLtY6k8EMXX+gymyhwu434zyLlMx/2JKho/Q9
 g1c0FeWlkitxZxCfOc2cZ1j9CoprSfg3Ph7Al/TGuVsg3k9JUmwAoNgJDnoEPTNaktcx
 pj2OuvIAHJ2PzmCqNSZGMnoA37a/xJHLnEt06QmT1yrBw6xU/sngKDDzn9uuQCDxGZcR
 fGqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708128108; x=1708732908;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xvIpWUym5/yIAwAbNTwXXgkxED4xulVwom9cPTjrKJ4=;
 b=vMx7sGxhFkvpMuh7UgXAce33DCMP97ibyyXU8TPtruHwGh8gM24ZEi7/dEdSQJ18zY
 ZUnqrEOlgE+9TdCpTSo8kl/8ug1AMCwvfRuHeBZyBKD/AnKcdXqdCguUIPcZvpwQ0EfJ
 WAEstzoOpJDeqRuAn/zclMxRDXTrFlcPS2JxL7emW3iI2RqhwPqVW0SLN+g2VyaCsXwO
 pSkYZYdWn58hJaoZ0sx1Ok3R5OzYdPJvWy57Y4eDLyBk7YoF3RBip5+IKcZTqEbRlM4o
 +rhilwvNYxppdfDylAVvJUXl1OIh5zMXScIspu9H38VhVYA3bjpUfyzJ+GbBopeRoByZ
 7ONg==
X-Gm-Message-State: AOJu0YyY/KlDzQPjvkaXfdK3hIuveHpYs2hPJuMV2duUpOkKyd4Af0oQ
 b46wXHTcOH5Na280MX9v4gKEgKVUPGs2CR65I54hUjar32CHuGJG3qzLmMVtfYi/h+3EVdnDzUL
 d
X-Google-Smtp-Source: AGHT+IFLMFB8jhSbfcmfKL0QIyU57lbaWYaONsPj+bEK5TxuHi9z3yTbnM8oXL8tfN4P84+IrZrLaQ==
X-Received: by 2002:a05:6a21:9212:b0:19e:9b8e:8bda with SMTP id
 tl18-20020a056a21921200b0019e9b8e8bdamr7871306pzb.42.1708128108587; 
 Fri, 16 Feb 2024 16:01:48 -0800 (PST)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 p13-20020a635b0d000000b005d66caee3d0sm464015pgb.22.2024.02.16.16.01.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Feb 2024 16:01:48 -0800 (PST)
From: Atish Patra <atishp@rivosinc.com>
To: qemu-devel@nongnu.org
Cc: Atish Patra <atishp@rivosinc.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, qemu-riscv@nongnu.org,
 Weiwei Li <liwei1518@gmail.com>, kaiwenxue1@gmail.com
Subject: [PATCH RFC 3/8] target/riscv: Enable S*stateen bits for AIA
Date: Fri, 16 Feb 2024 16:01:29 -0800
Message-Id: <20240217000134.3634191-4-atishp@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240217000134.3634191-1-atishp@rivosinc.com>
References: <20240217000134.3634191-1-atishp@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=atishp@rivosinc.com; helo=mail-pf1-x434.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

As per the ratified AIA spec v1.0, three stateen bits control AIA CSR
access.

Bit 60 controls the indirect CSRs
Bit 59 controls the most AIA CSR state
Bit 58 controls the IMSIC state such as stopei and vstopei

Enable the corresponding bits in [m|h]stateen and enable corresponding
checks in the CSR accessor functions.

Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 target/riscv/csr.c | 89 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 88 insertions(+), 1 deletion(-)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 1af0c8890a2b..89a1325a02a5 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -316,19 +316,42 @@ static int smode32(CPURISCVState *env, int csrno)
 
 static int aia_smode(CPURISCVState *env, int csrno)
 {
+    int ret;
+
     if (!riscv_cpu_cfg(env)->ext_ssaia) {
         return RISCV_EXCP_ILLEGAL_INST;
     }
 
+    if (csrno == CSR_STOPEI) {
+        ret = smstateen_acc_ok(env, 0, SMSTATEEN0_IMSIC);
+    } else {
+        ret = smstateen_acc_ok(env, 0, SMSTATEEN0_AIA);
+    }
+
+    if (ret != RISCV_EXCP_NONE) {
+        return ret;
+    }
+
     return smode(env, csrno);
 }
 
 static int aia_smode32(CPURISCVState *env, int csrno)
 {
+    int ret;
+
     if (!riscv_cpu_cfg(env)->ext_ssaia) {
         return RISCV_EXCP_ILLEGAL_INST;
     }
 
+    ret = smstateen_acc_ok(env, 0, SMSTATEEN0_AIA);
+    if (ret != RISCV_EXCP_NONE) {
+        return ret;
+    }
+
+    if (ret != RISCV_EXCP_NONE) {
+        return ret;
+    }
+
     return smode32(env, csrno);
 }
 
@@ -552,15 +575,38 @@ static RISCVException pointer_masking(CPURISCVState *env, int csrno)
 
 static int aia_hmode(CPURISCVState *env, int csrno)
 {
+    int ret;
+
     if (!riscv_cpu_cfg(env)->ext_ssaia) {
         return RISCV_EXCP_ILLEGAL_INST;
      }
 
-     return hmode(env, csrno);
+    if (csrno == CSR_VSTOPEI) {
+        ret = smstateen_acc_ok(env, 0, SMSTATEEN0_IMSIC);
+    } else {
+        ret = smstateen_acc_ok(env, 0, SMSTATEEN0_AIA);
+    }
+
+    if (ret != RISCV_EXCP_NONE) {
+        return ret;
+    }
+
+    return hmode(env, csrno);
 }
 
 static int aia_hmode32(CPURISCVState *env, int csrno)
 {
+    int ret;
+
+    if (!riscv_cpu_cfg(env)->ext_ssaia) {
+        return RISCV_EXCP_ILLEGAL_INST;
+     }
+
+    ret = smstateen_acc_ok(env, 0, SMSTATEEN0_AIA);
+    if (ret != RISCV_EXCP_NONE) {
+        return ret;
+    }
+
     if (!riscv_cpu_cfg(env)->ext_ssaia) {
         return RISCV_EXCP_ILLEGAL_INST;
     }
@@ -1851,6 +1897,12 @@ static int rmw_xiselect(CPURISCVState *env, int csrno, target_ulong *val,
                         target_ulong new_val, target_ulong wr_mask)
 {
     target_ulong *iselect;
+    int ret;
+
+    ret = smstateen_acc_ok(env, 0, SMSTATEEN0_SVSLCT);
+    if (ret != RISCV_EXCP_NONE) {
+        return ret;
+    }
 
     /* Translate CSR number for VS-mode */
     csrno = sxcsrind_xlate_vs_csrno(env, csrno);
@@ -2020,6 +2072,11 @@ static int rmw_xireg(CPURISCVState *env, int csrno, target_ulong *val,
     int ret = -EINVAL;
     target_ulong isel;
 
+    ret = smstateen_acc_ok(env, 0, SMSTATEEN0_SVSLCT);
+    if (ret != RISCV_EXCP_NONE) {
+        return ret;
+    }
+
     /* Translate CSR number for VS-mode */
     csrno = sxcsrind_xlate_vs_csrno(env, csrno);
 
@@ -2419,6 +2476,23 @@ static RISCVException write_mstateen0(CPURISCVState *env, int csrno,
         wr_mask |= SMSTATEEN0_FCSR;
     }
 
+    /*
+     * TODO: Do we need to check ssaia as well ? Can we enable ssaia without
+     * smaia ?
+     */
+    if (riscv_cpu_cfg(env)->ext_smaia) {
+        wr_mask |= SMSTATEEN0_SVSLCT;
+    }
+
+    /*
+     * As per the AIA specification, SMSTATEEN0_IMSIC is valid only if IMSIC is
+     * implemented. However, that information is with MachineState and we can't
+     * figure that out in csr.c. Just enable if Smaia is available.
+     */
+    if (riscv_cpu_cfg(env)->ext_smaia) {
+        wr_mask |= (SMSTATEEN0_AIA | SMSTATEEN0_IMSIC);
+    }
+
     return write_mstateen(env, csrno, wr_mask, new_val);
 }
 
@@ -2495,6 +2569,19 @@ static RISCVException write_hstateen0(CPURISCVState *env, int csrno,
         wr_mask |= SMSTATEEN0_FCSR;
     }
 
+    if (riscv_cpu_cfg(env)->ext_ssaia) {
+        wr_mask |= SMSTATEEN0_SVSLCT;
+    }
+
+    /*
+     * As per the AIA specification, SMSTATEEN0_IMSIC is valid only if IMSIC is
+     * implemented. However, that information is with MachineState and we can't
+     * figure that out in csr.c. Just enable if Ssaia is available.
+     */
+    if (riscv_cpu_cfg(env)->ext_ssaia) {
+        wr_mask |= (SMSTATEEN0_AIA | SMSTATEEN0_IMSIC);
+    }
+
     return write_hstateen(env, csrno, wr_mask, new_val);
 }
 
-- 
2.34.1


