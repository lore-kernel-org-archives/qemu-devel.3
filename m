Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD4DBC25B5F
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2024 13:19:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5Q8N-0005rq-5C; Fri, 10 May 2024 09:17:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fea.wang@sifive.com>)
 id 1s5K8Z-0001hF-5q
 for qemu-devel@nongnu.org; Fri, 10 May 2024 02:53:47 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fea.wang@sifive.com>)
 id 1s5K8X-0004q4-IK
 for qemu-devel@nongnu.org; Fri, 10 May 2024 02:53:46 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-6ed3cafd766so1576483b3a.0
 for <qemu-devel@nongnu.org>; Thu, 09 May 2024 23:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1715324023; x=1715928823; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wQ6x5YYUL/lDfqaZOQY3/NuL3tGGxwqwExXQMFAPOo4=;
 b=RMF999yi/chZfC8i/HeNzcQiqg1lAuGEi3BOO9cJ4RKvj1Lc9B/v5GX2LiXErQC8U2
 Lfe/gyy34/pJJEcrtgSgCDMCAxbFVLejI89MQuNrxkQvxd474MchAxmOPe8nJxpQE2yx
 1BdTexk2OMvSpvmWUOPboQjMN+6iUUQCG6i5FzgTDcOXg7YaRneAfJNUUVjX7lCrl9ON
 voph5xTr4FB0ZcUX50x+xUt2nvqS7WzD5i7/Ky99S2CPRdaA74mxAMBLAHy1o9KjutUB
 IUK34oNvUgzfVpw2cgNtUwDgPP4vRvWPlgzkLRzqTU6QOuxCXq1K3p5WyF3d4fDsqprg
 o09g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715324023; x=1715928823;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wQ6x5YYUL/lDfqaZOQY3/NuL3tGGxwqwExXQMFAPOo4=;
 b=J01+zXaAMl+QwxYh8u28bhUkKbGfg0esLiNRqIpOeVI+PWpWYD0SiZQCwxIb9UUhn5
 WmT3HZifNIGy2nt1Ol/xTbPjSaoJThcCcvJGR2wkxYZPBkD3jO+3HDcLj7fqpzrsnASx
 2m30mO+tIuvbqzeJ2DMSi/Dz7Y2sd/TEY3Se7FCiozxnNcStoibcK/k18nJb9mxvAnrE
 cl41xsYTw8F7btZ9H3m0Bx+kQmeyf0tGch5b9czezj+0ZvxE2ZE6cd5PDQBsRR634jCa
 lui2iyFYqH1/nJJ24qVQ6XczprKBdcKsGoS6UUDNc7AcYeJ8rJgFsf1BLUV2k0BhpjLt
 qmkg==
X-Gm-Message-State: AOJu0Yzze2aVDrIvXqek2B08+s1CRQMgN64OV8y5Z2i8cjBrjK09VJxB
 LgEAm3GuRKFjwnEsmbk4H6Hyrhm93XXyZ69+ayTbfB3aXMDUahlo2XQj7bH78Mj+xi1pppWLnVl
 BRdMq9XlBlpkRiUL8Ino51HbE829tXX1PWpWufWb9Wks181v4VYapuVIoBNJfpS+Eubu80pa7iU
 p0o7Bg3igUWuQChoTaUCiN/CyWQUYrkL9bS85WdA==
X-Google-Smtp-Source: AGHT+IFHmlCOLyDzgMs9n27eOyHn22NwhAbhtFCaEYhwZn0J1+DEzVbg5zOaQoLE2fRFmtdpJSawgQ==
X-Received: by 2002:a05:6a21:680b:b0:1ac:e07f:e3aa with SMTP id
 adf61e73a8af0-1afde1b7264mr2328560637.48.1715324022840; 
 Thu, 09 May 2024 23:53:42 -0700 (PDT)
Received: from hsinchu36-syssw02.internal.sifive.com
 (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1ef0bf31a7asm25579175ad.140.2024.05.09.23.53.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 May 2024 23:53:42 -0700 (PDT)
From: "Fea.Wang" <fea.wang@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: "Fea.Wang" <fea.wang@sifive.com>, Frank Chang <frank.chang@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: [PATCH 4/5] target/riscv: Add MEDELEGH, HEDELEGH csrs for RV32
Date: Fri, 10 May 2024 14:58:54 +0800
Message-Id: <20240510065856.2436870-5-fea.wang@sifive.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240510065856.2436870-1-fea.wang@sifive.com>
References: <20240510065856.2436870-1-fea.wang@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=fea.wang@sifive.com; helo=mail-pf1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 10 May 2024 09:17:57 -0400
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
index d844ce770e..4d7313f456 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -3227,6 +3227,33 @@ static RISCVException write_hedeleg(CPURISCVState *env, int csrno,
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
@@ -4674,6 +4701,10 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
 
     [CSR_MSTATUSH]    = { "mstatush",   any32, read_mstatush,
                           write_mstatush                                   },
+    [CSR_MEDELEGH]    = { "medelegh",   any32, read_zero, write_ignore,
+                          .min_priv_ver = PRIV_VERSION_1_13_0              },
+    [CSR_HEDELEGH]    = { "hedelegh",   any32, read_hedelegh, write_hedelegh,
+                          .min_priv_ver = PRIV_VERSION_1_13_0              },
 
     /* Machine Trap Handling */
     [CSR_MSCRATCH] = { "mscratch", any,  read_mscratch, write_mscratch,
-- 
2.34.1


