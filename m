Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DE2BE7719D
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 08:22:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWAHF-0000NQ-3F; Fri, 10 Jan 2025 03:21:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1tWAHD-0000Le-6b
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 03:21:55 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1tWAH9-0008Ko-PS
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 03:21:54 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-21a7ed0155cso30000405ad.3
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 00:21:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1736497310; x=1737102110;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=aa8igiMjR5VtzxpOB+s7UK21OwDYljrRRB4w4Qxef7c=;
 b=O/Mik8wvgj3m9gYbU9jghba0GEh5DL90Es6S1J0FOmLwFzdQXwSecBPOD/14nlOmah
 b2IKFffRvhtZOsxkykL1Hl7c5Rx4CCsIKfBwmQQjuDHAjqC6/QNhGdn7XUNbpRY6Hpud
 HZDm9zVtDk96mIKPeviNdTOjjmlwT4Axc6qZ+IUyO5Iv/HCy7gFHH6aTdYkGmkePRt29
 fIWNDmIVePItYu4eu1BKP9EPbpKwN0d5jXK3nduk4YgY3OxDNaSqKtbDRT589z7YlZzX
 tEO8Zfs9QTcaaBNE2K360Z+/52QQU2nye3pVYrcRwCfraKBCyqjlIj0ulY+HjDzn/Tya
 4Xyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736497310; x=1737102110;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aa8igiMjR5VtzxpOB+s7UK21OwDYljrRRB4w4Qxef7c=;
 b=D9zBUHG1zBqvEICvmxw8XbS8L88qa8lxsKojYiJ9YuOVnSTsUf9b0vhGz6yjXiuaZe
 vNDG3CzPkj+2QYnbUQZpTpGz8o8rIvaCPJyhkIXhRk3WssPxBCOWrQztcJKSC5v6+qPG
 jlZytU7mP/5ntrFNvOv5H2osJ6BE0mlDgNXpXvPwboWiQpWS6k4IglAnHEqbo9Li64oP
 5Y918fPKN4S9b91Mu67SXUtvlBMfo/B7SsmczvqA0zAAa1gY4pgdnlu01B/OiXBEsqGw
 XqzxIV02e6s7dk0LoQs0xZ9wvb/XPd7aO2Z8qqI9cRjv79G6lnv+C+DXGu4du8OLqoMQ
 luzg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXZJUTJYXBU5Uy19rl59tO+XsUIcdlBle4mEOrTffEtpatTbki84G5oN155N4XJvK6dFanhpncqnLIA@nongnu.org
X-Gm-Message-State: AOJu0YwalFsfSRTJz1/p+3k0dj1kEsc4lqTfoo+LF+B9gXkBEb+rukiN
 +LvfzJrNTz1sWTRs7lSmvOk6G4hfMa1W4LOmWXhods9GqexlWDg3iH50iiqRrq6MrynWBcs1w4t
 y
X-Gm-Gg: ASbGnctOEJoPEUsxXyagGK3KqgQ81BNaqorEpnBLMhyxJ7nGjkUTA4y925exwXcnbwh
 NLiHFlDmc3yxs/Gk+KnkmyqoNBFXYIPoI4YArtnLk+bNQV6HpmUcT5UAIljqyJqfE2NwUNsxRHx
 x40QqR36fzVTt0IGCdakMRXQqI5u2G/AQRm/7C9KqDH9xtGS4iC74X4GgnFYa7VNf/qLZCdS+Ub
 HEjI9diDN+bU8x2m4RerkfbWt/I+XyZABJUKChNirOeGe4fbYMh5XVj7QEpt3MHF07W0A==
X-Google-Smtp-Source: AGHT+IHz+uPKHeGYXTwUxbHCePU5sUyNazRERX+KMSqYmrhwWSAwiXsArh/djUQqwnLTMVy/0PXr2Q==
X-Received: by 2002:a17:902:d50d:b0:215:7421:27c with SMTP id
 d9443c01a7336-21a83f696a9mr148672125ad.29.1736497310552; 
 Fri, 10 Jan 2025 00:21:50 -0800 (PST)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21a9f22ee09sm9278715ad.200.2025.01.10.00.21.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jan 2025 00:21:50 -0800 (PST)
From: Atish Patra <atishp@rivosinc.com>
Date: Fri, 10 Jan 2025 00:21:31 -0800
Subject: [PATCH v5 03/11] target/riscv: Enable S*stateen bits for AIA
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250110-counter_delegation-v5-3-e83d797ae294@rivosinc.com>
References: <20250110-counter_delegation-v5-0-e83d797ae294@rivosinc.com>
In-Reply-To: <20250110-counter_delegation-v5-0-e83d797ae294@rivosinc.com>
To: qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: kaiwenxue1@gmail.com, Atish Patra <atishp@rivosinc.com>, 
 palmer@dabbelt.com, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 bin.meng@windriver.com, dbarboza@ventanamicro.com, alistair.francis@wdc.com
X-Mailer: b4 0.15-dev-13183
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=atishp@rivosinc.com; helo=mail-pl1-x636.google.com
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

As per the ratified AIA spec v1.0, three stateen bits control AIA CSR
access.

Bit 60 controls the indirect CSRs
Bit 59 controls the most AIA CSR state
Bit 58 controls the IMSIC state such as stopei and vstopei

Enable the corresponding bits in [m|h]stateen and enable corresponding
checks in the CSR accessor functions.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 target/riscv/csr.c | 85 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 84 insertions(+), 1 deletion(-)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 123e9fd2bd7b..7f4348fe86f3 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -335,19 +335,42 @@ static RISCVException smode32(CPURISCVState *env, int csrno)
 
 static RISCVException aia_smode(CPURISCVState *env, int csrno)
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
 
 static RISCVException aia_smode32(CPURISCVState *env, int csrno)
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
 
@@ -576,15 +599,38 @@ static RISCVException hgatp(CPURISCVState *env, int csrno)
 
 static RISCVException aia_hmode(CPURISCVState *env, int csrno)
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
 
 static RISCVException aia_hmode32(CPURISCVState *env, int csrno)
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
@@ -2033,6 +2079,12 @@ static RISCVException rmw_xiselect(CPURISCVState *env, int csrno,
                                    target_ulong wr_mask)
 {
     target_ulong *iselect;
+    int ret;
+
+    ret = smstateen_acc_ok(env, 0, SMSTATEEN0_SVSLCT);
+    if (ret != RISCV_EXCP_NONE) {
+        return ret;
+    }
 
     /* Translate CSR number for VS-mode */
     csrno = csrind_xlate_vs_csrno(env, csrno);
@@ -2203,6 +2255,11 @@ static RISCVException rmw_xireg(CPURISCVState *env, int csrno,
     int ret = -EINVAL;
     target_ulong isel;
 
+    ret = smstateen_acc_ok(env, 0, SMSTATEEN0_SVSLCT);
+    if (ret != RISCV_EXCP_NONE) {
+        return ret;
+    }
+
     /* Translate CSR number for VS-mode */
     csrno = csrind_xlate_vs_csrno(env, csrno);
 
@@ -2703,6 +2760,19 @@ static RISCVException write_mstateen0(CPURISCVState *env, int csrno,
         wr_mask |= SMSTATEEN0_P1P13;
     }
 
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
 
@@ -2783,6 +2853,19 @@ static RISCVException write_hstateen0(CPURISCVState *env, int csrno,
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


