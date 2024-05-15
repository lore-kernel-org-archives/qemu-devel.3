Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13AD9C25B7C
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 07:49:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s79Nk-0000ir-V2; Wed, 15 May 2024 03:49:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fea.wang@sifive.com>)
 id 1s79NS-0000KU-2T
 for qemu-devel@nongnu.org; Wed, 15 May 2024 03:48:43 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fea.wang@sifive.com>)
 id 1s79NE-0000L9-1K
 for qemu-devel@nongnu.org; Wed, 15 May 2024 03:48:41 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-6f43ee95078so6292427b3a.1
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 00:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1715759306; x=1716364106; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ldPciugSQGSMOBR5lY12EK6xTqHmCiheKzOXbbN7QuY=;
 b=cZUY3kfFiffYfzzxFgsr4puYSviwPFZ1GYKJg/r5SG7SMkCaHMlTDGfdj6tE3GVi8m
 g1dDaoX9AsN9Hph3aRWXShacdHmN3hKVQthswRWdI0/VN+W72CKmeHgAZL/oi0E9C1IF
 nRuggxtRLgXKjZ8IE/8sM1eGwkkfMMuB8DZ44akRyOOil5duR9frTCJKGr71OWDWFuGc
 VBm1UcawvomOp/FEUQuzML4WcBW/DZp5CpWsoaHxRgARgCYUZbFy0Ft88PUZ9Bv9ZH3U
 OpTZC1IeNxKRB8MDC93zkBb7h/HAOXjGfvvUvTxFKpS8qBjPoYK0z89a/w8saV/9p2KG
 4blA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715759306; x=1716364106;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ldPciugSQGSMOBR5lY12EK6xTqHmCiheKzOXbbN7QuY=;
 b=eenvFFCUQkc9EVi6xM9I+kz107zGNH1RUB5GTMNkKNbgtIG51nJvyDY1AjIYboCOsJ
 ekFCnyzX3UyQt4XcKyx2EsJrEMLvFeOTA7vmR5nDREOoNrBJaqY4b4OUOuHbtnFiYWEk
 qp9tHysjo6WGcL8ZUne6XKTtHie0hAX/yX8XmfUm2iQaByw4Qy1svJXAruCwvijDN2s1
 7GH2QhXkxoxFDgcMpI3sPRqeyHpyF1+QGhbUbC2dp6NvyOmIUnekILU9ushrlA+BsUq0
 JRo7SAM0pEPDnfv7JUVt7KJGuTOGerU3/yXWtHtT3ADCpKEZxSw9Gh6fouj3SlkgDfY1
 1znQ==
X-Gm-Message-State: AOJu0YxFcI7nuf3I/mcZH8DXe6VMENLxD2HgQNxmEaf1tIh1L3ruBpFw
 xVuzljTHK+IjU4EPfbisPlRT41CUzNJyM5xYQ9iVb8n6LxHLR3DeNO0EwaKhpLvqEf/113gQDhU
 thjQolwJdGivYQk00hU1AcdSv4cW5ZoIpVBR2bFCaryFUySuxgiHcJfcv3/lbGz2xzoL/HVXuVU
 GRl2CERt0WV6wMLw1lRyxFQi/2baQiZf52Hk8=
X-Google-Smtp-Source: AGHT+IG+EfaUSRuCYNgIXCOVGPcSnpvwJpIFchUtzWLs0IluX42Pnng43VG4TYD0syBmYiIbkXtVmQ==
X-Received: by 2002:a05:6a00:1943:b0:6ed:de6e:dd24 with SMTP id
 d2e1a72fcca58-6f4e02cebeamr16918823b3a.16.1715759306103; 
 Wed, 15 May 2024 00:48:26 -0700 (PDT)
Received: from hsinchu36-syssw02.internal.sifive.com
 (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f4d2af2bafsm10389060b3a.162.2024.05.15.00.48.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 May 2024 00:48:25 -0700 (PDT)
From: "Fea.Wang" <fea.wang@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: "Fea.Wang" <fea.wang@sifive.com>, Frank Chang <frank.chang@sifive.com>,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH 4/5] target/riscv: Add MEDELEGH, HEDELEGH csrs for RV32
Date: Wed, 15 May 2024 15:53:35 +0800
Message-Id: <20240515075340.2675136-5-fea.wang@sifive.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240515075340.2675136-1-fea.wang@sifive.com>
References: <20240515075340.2675136-1-fea.wang@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=fea.wang@sifive.com; helo=mail-pf1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Based on privileged spec 1.13, the RV32 needs to implement MEDELEGH
and HEDELEGH for exception codes 32-47 for reserving and exception codes
48-63 for custom use. Add the CSR number though the implementation is
just reading zero and writing ignore. Besides, for accessing HEDELEGH, it
should be controlled by mstateen0 'P1P13' bit.

Signed-off-by: Fea.Wang <fea.wang@sifive.com>
Reviewed-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
---
 target/riscv/cpu_bits.h |  2 ++
 target/riscv/csr.c      | 31 +++++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index 28bd3fb0b4..f888025c59 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -156,6 +156,8 @@
 
 /* 32-bit only */
 #define CSR_MSTATUSH        0x310
+#define CSR_MEDELEGH        0x312
+#define CSR_HEDELEGH        0x612
 
 /* Machine Trap Handling */
 #define CSR_MSCRATCH        0x340
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index bdbc8de0e2..c5ff40eed8 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -3225,6 +3225,33 @@ static RISCVException write_hedeleg(CPURISCVState *env, int csrno,
     return RISCV_EXCP_NONE;
 }
 
+static RISCVException read_hedelegh(CPURISCVState *env, int csrno,
+                                   target_ulong *val)
+{
+    RISCVException ret;
+    ret = smstateen_acc_ok(env, 0, SMSTATEEN0_P1P13);
+    if (ret != RISCV_EXCP_NONE) {
+        return ret;
+    }
+
+    /* Reserved, now read zero */
+    *val = 0;
+    return RISCV_EXCP_NONE;
+}
+
+static RISCVException write_hedelegh(CPURISCVState *env, int csrno,
+                                    target_ulong val)
+{
+    RISCVException ret;
+    ret = smstateen_acc_ok(env, 0, SMSTATEEN0_P1P13);
+    if (ret != RISCV_EXCP_NONE) {
+        return ret;
+    }
+
+    /* Reserved, now write ignore */
+    return RISCV_EXCP_NONE;
+}
+
 static RISCVException rmw_hvien64(CPURISCVState *env, int csrno,
                                     uint64_t *ret_val,
                                     uint64_t new_val, uint64_t wr_mask)
@@ -4672,6 +4699,10 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
 
     [CSR_MSTATUSH]    = { "mstatush",   any32, read_mstatush,
                           write_mstatush                                   },
+    [CSR_MEDELEGH]    = { "medelegh",   any32, read_zero, write_ignore,
+                          .min_priv_ver = PRIV_VERSION_1_13_0              },
+    [CSR_HEDELEGH]    = { "hedelegh",   hmode32, read_hedelegh, write_hedelegh,
+                          .min_priv_ver = PRIV_VERSION_1_13_0              },
 
     /* Machine Trap Handling */
     [CSR_MSCRATCH] = { "mscratch", any,  read_mscratch, write_mscratch,
-- 
2.34.1


