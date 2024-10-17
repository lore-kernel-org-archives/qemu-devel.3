Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F16BDD374A5
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2024 14:54:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1Rsa-0003au-Jq; Thu, 17 Oct 2024 10:53:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1t1RsY-0003Qz-Aj
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 10:53:30 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1t1RsW-0006zO-9s
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 10:53:29 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-7d4fa972cbeso911883a12.2
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2024 07:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1729176804; x=1729781604;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=71RCoEK2c3EE51YgECa9iN01Uc+4u3MvG3YZ4vrNInM=;
 b=SMkK3u1JDtaJJNV8jA7hTKpJNqZOLuklA7+B48TwrO1jc9euFu/RZC7V28tMIGepc0
 1Rzhum5H/nCOShR8nTDlXl6Mp7tXQ33rr8dH1diLb4ivlhv0hte6ERExO89eYLb8PDg0
 qPn8jAaQ4z8l5mN0QnriAvGduI528/1iQrOQYJqrzZM1tVagVHZhLKMySRuquc8GiX1h
 x020V1HpVjDn5jr3/AOY3AHOVqXBikPAa7CMxGbRP0ZjsuonifIednXlGx48CcDHzekO
 d8CDcnJMK5bbTIUhqng60PLIaE6bjzdUXF4P56pz7j8gJSCFpR6byw6gzf3XeAIrzDbE
 3Wfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729176804; x=1729781604;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=71RCoEK2c3EE51YgECa9iN01Uc+4u3MvG3YZ4vrNInM=;
 b=qvjm8sbjouQnE7EaYYFjwcfiIdTde+r5M6TI3EEPPRZ6J2mG2ZfJu0H6Cip4pq+icM
 E3HQx6/QaJIZ6cQazgqAhlCdX26f6sXdtMnZvveYddtKKuT+re1gzsYn/9rul6+nK3PG
 ZekLaKtoKlcxzTsN2dMjFG532A6MJp5Y/zXVzpdiEsqKhSEkHubjY/fSSpDFkyHu3Tq3
 L2Qr4/uflPpstk+Qu7UVHBVQeBAE5XxBamJV8T/tBSwih4bD80iSYKbPCEvl5ENB9syG
 gSCH3Iqe1oAB04AY0UtBcKRQnsVyX6qfDeMfVjS4Ni6DLi11WUdazTd5NO/iU/P+oKaw
 8mfA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWcYFmDyRnVlC5vH2II6NP0LXsholRByQfq6iUeA7uQcGsPwOn0ClZ+qeTmkCJAUZ51LSqT695KJBWP@nongnu.org
X-Gm-Message-State: AOJu0Ywr49BuJQQumJK1+21tqdeHQcXtJzxgiYvODSX5rmDuyUo5OO6Z
 1et0x4jEYXTdXhdJEWdU4TFCxFKKZyQRmLlsZVZ91VScII7wyq8MZSrKLneiDqM=
X-Google-Smtp-Source: AGHT+IE5Pn2etMSIgWE6FHlzO7/J/ea++TOT9G8x1+cQf+Xe4tLWUimUMOnFkixZkDVmF0kBxWLqFA==
X-Received: by 2002:a05:6a20:78a5:b0:1d9:aa7:d6cc with SMTP id
 adf61e73a8af0-1d90aa7d708mr7845358637.24.1729176804554; 
 Thu, 17 Oct 2024 07:53:24 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71e77371193sm4859580b3a.21.2024.10.17.07.53.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2024 07:53:24 -0700 (PDT)
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
Subject: [PATCH v4 6/9] target/riscv: Add Smdbltrp CSRs handling
Date: Thu, 17 Oct 2024 16:52:17 +0200
Message-ID: <20241017145226.365825-7-cleger@rivosinc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241017145226.365825-1-cleger@rivosinc.com>
References: <20241017145226.365825-1-cleger@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=cleger@rivosinc.com; helo=mail-pg1-x532.google.com
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

Add `ext_smdbltrp`in RISCVCPUConfig and implement MSTATUS.MDT behavior.
Also set MDT to 1 at reset according to the specification.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
---
 target/riscv/cpu.c      |  3 +++
 target/riscv/cpu_bits.h |  1 +
 target/riscv/cpu_cfg.h  |  1 +
 target/riscv/csr.c      | 13 +++++++++++++
 4 files changed, 18 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 39555364bf..15b21e4f7d 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -959,6 +959,9 @@ static void riscv_cpu_reset_hold(Object *obj, ResetType type)
             env->mstatus_hs = set_field(env->mstatus_hs,
                                         MSTATUS64_UXL, env->misa_mxl);
         }
+        if (riscv_cpu_cfg(env)->ext_smdbltrp) {
+            env->mstatus = set_field(env->mstatus, MSTATUS_MDT, 1);
+        }
     }
     env->mcause = 0;
     env->miclaim = MIP_SGEIP;
diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index 0d0f253fcb..b368e27ca0 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -561,6 +561,7 @@
 #define MSTATUS_SDT         0x01000000
 #define MSTATUS_GVA         0x4000000000ULL
 #define MSTATUS_MPV         0x8000000000ULL
+#define MSTATUS_MDT         0x40000000000ULL /* Smdbltrp extension */
 
 #define MSTATUS64_UXL       0x0000000300000000ULL
 #define MSTATUS64_SXL       0x0000000C00000000ULL
diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index 518102d748..8ac1e7fce3 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -78,6 +78,7 @@ struct RISCVCPUConfig {
     bool ext_sstc;
     bool ext_smcntrpmf;
     bool ext_ssdbltrp;
+    bool ext_smdbltrp;
     bool ext_svadu;
     bool ext_svinval;
     bool ext_svnapot;
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 9aa33611f7..9d2caf34ba 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -1616,6 +1616,13 @@ static RISCVException write_mstatus(CPURISCVState *env, int csrno,
         }
     }
 
+    if (riscv_cpu_cfg(env)->ext_smdbltrp) {
+        mask |= MSTATUS_MDT;
+        if ((val & MSTATUS_MDT) != 0) {
+            val &= ~MSTATUS_MIE;
+        }
+    }
+
     if (xl != MXL_RV32 || env->debugger) {
         if (riscv_has_ext(env, RVH)) {
             mask |= MSTATUS_MPV | MSTATUS_GVA;
@@ -1654,6 +1661,12 @@ static RISCVException write_mstatush(CPURISCVState *env, int csrno,
     uint64_t valh = (uint64_t)val << 32;
     uint64_t mask = riscv_has_ext(env, RVH) ? MSTATUS_MPV | MSTATUS_GVA : 0;
 
+    if (riscv_cpu_cfg(env)->ext_smdbltrp) {
+        mask |= MSTATUS_MDT;
+        if ((valh & MSTATUS_MDT) != 0) {
+            mask |= MSTATUS_MIE;
+        }
+    }
     env->mstatus = (env->mstatus & ~mask) | (valh & mask);
 
     return RISCV_EXCP_NONE;
-- 
2.45.2


