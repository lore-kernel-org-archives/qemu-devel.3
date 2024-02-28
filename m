Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA0A1C5478C
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 18:52:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfP22-0000lM-Ia; Wed, 28 Feb 2024 13:51:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1rfP20-0000kd-Nr
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 13:51:52 -0500
Received: from mail-oi1-x235.google.com ([2607:f8b0:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1rfP1y-0006tw-PG
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 13:51:52 -0500
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-3c19b7d9de7so2071694b6e.2
 for <qemu-devel@nongnu.org>; Wed, 28 Feb 2024 10:51:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1709146309; x=1709751109;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7vH3VUY1zOLA7qqRfQ/TyWVihmXP/uPzN9vWw0YjNAA=;
 b=vGg+0OCF17KGYS96CsHvecnY/nL2CtFPgKqz8Od4aAykEzGDIqA5ciDKl6dqk+axss
 MbvUPgtWMewuHlHL4AVVN81ej850kuLZOUh6NQWwhPZXK9X3oS/szy015aolqBd/M5xI
 CHw8v1yV6b32p9RUF3Eysq1hpCwfZSKtuJycZNUbUucBtn1JryhkWlolTtt8Jejivkn8
 lKKTPQQxdg0seSntMlu4ZEEbPzuU+MQPoA8M4kBunVGVUKAygKG7sxiLqS/5X1KKj7q/
 qzkFc7d1ECc9AKKDsgOAe2LL0px8EkUtTkFpbUJXeYnlsTGioeYkgrkmb3Q6fRvZfZ2D
 HEjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709146309; x=1709751109;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7vH3VUY1zOLA7qqRfQ/TyWVihmXP/uPzN9vWw0YjNAA=;
 b=Zs4C9HXVIBTzMAXtK4a1efXpXOBEfTlGgad2mihOwIh6DX8PZ8muGFQ3h7ghleb0Sd
 VuMHHMCa8G3pkJW2/mRvSCQEdCBPUbDM8H03QxhXHjxdaY1bkk7ahnVR4ZO05Qw+d0uz
 WOItq/ZgEZU0cO9i54+nKSIZz81hGkl34vXVjzoXn8gyJym1g2NGpZUEcG0k1Kaq4/zZ
 UmWnal9kJ5CKryRtSRD3xlfu8m9trp5weWizWp7AS+CoNzZ48CWfASACfOYhnIxYvfqx
 O+DuBE9/46LjIsPbteyHwxwPqKhDFvfCLfgFLc2ZQlKVmSgfWZ3T/q2tMcPTW5YJeL0r
 Y2RA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWqfSvEzqeykDHrRayiwPpLnjHXwXcsXSJhY1bvmZRRXTCH1RsYuaySmaU4rHZm7/Wqc4MhVcQZszI+1eLTGiO5+hQbij4=
X-Gm-Message-State: AOJu0YwmErm8TxBc2OWUD+qozDwYD5jxXUi8194lm3hsSvmxPDcLcuwv
 xIuuMIs1aCCf7lSdCybb9w5OymcoiyzCnmrLOZtg2txYFGA+PJPTmNnW2R0iZyQ=
X-Google-Smtp-Source: AGHT+IErEihPN3QBX/PuDNQLqefWqGx5Z/5EtJycJkUmzxkMFog8w4J2gI8JlP1nWcOMeU2q3SyNIA==
X-Received: by 2002:a05:6808:1511:b0:3c1:b146:d9e5 with SMTP id
 u17-20020a056808151100b003c1b146d9e5mr5451705oiw.36.1709146309251; 
 Wed, 28 Feb 2024 10:51:49 -0800 (PST)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 o20-20020a635d54000000b005dbed0ffb10sm49562pgm.83.2024.02.28.10.51.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Feb 2024 10:51:48 -0800 (PST)
From: Atish Patra <atishp@rivosinc.com>
To: 
Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Atish Patra <atishp@rivosinc.com>, Bin Meng <bin.meng@windriver.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, Weiwei Li <liwei1518@gmail.com>,
 kaiwenxue1@gmail.com
Subject: [PATCH v5 1/5] target/riscv: Fix the predicate functions for
 mhpmeventhX CSRs
Date: Wed, 28 Feb 2024 10:51:12 -0800
Message-Id: <20240228185116.1321730-2-atishp@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240228185116.1321730-1-atishp@rivosinc.com>
References: <20240228185116.1321730-1-atishp@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::235;
 envelope-from=atishp@rivosinc.com; helo=mail-oi1-x235.google.com
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

mhpmeventhX CSRs are available for RV32. The predicate function
should check that first before checking sscofpmf extension.

Fixes: 14664483457b ("target/riscv: Add sscofpmf extension support")
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 target/riscv/csr.c | 67 ++++++++++++++++++++++++++--------------------
 1 file changed, 38 insertions(+), 29 deletions(-)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index d4e8ac13b90c..a3d979c4c72c 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -227,6 +227,15 @@ static RISCVException sscofpmf(CPURISCVState *env, int csrno)
     return RISCV_EXCP_NONE;
 }
 
+static RISCVException sscofpmf_32(CPURISCVState *env, int csrno)
+{
+    if (riscv_cpu_mxl(env) != MXL_RV32) {
+        return RISCV_EXCP_ILLEGAL_INST;
+    }
+
+    return sscofpmf(env, csrno);
+}
+
 static RISCVException any(CPURISCVState *env, int csrno)
 {
     return RISCV_EXCP_NONE;
@@ -5035,91 +5044,91 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
     [CSR_MHPMEVENT31]    = { "mhpmevent31",    any,    read_mhpmevent,
                              write_mhpmevent                           },
 
-    [CSR_MHPMEVENT3H]    = { "mhpmevent3h",    sscofpmf,  read_mhpmeventh,
+    [CSR_MHPMEVENT3H]    = { "mhpmevent3h",    sscofpmf_32,  read_mhpmeventh,
                              write_mhpmeventh,
                              .min_priv_ver = PRIV_VERSION_1_12_0        },
-    [CSR_MHPMEVENT4H]    = { "mhpmevent4h",    sscofpmf,  read_mhpmeventh,
+    [CSR_MHPMEVENT4H]    = { "mhpmevent4h",    sscofpmf_32,  read_mhpmeventh,
                              write_mhpmeventh,
                              .min_priv_ver = PRIV_VERSION_1_12_0        },
-    [CSR_MHPMEVENT5H]    = { "mhpmevent5h",    sscofpmf,  read_mhpmeventh,
+    [CSR_MHPMEVENT5H]    = { "mhpmevent5h",    sscofpmf_32,  read_mhpmeventh,
                              write_mhpmeventh,
                              .min_priv_ver = PRIV_VERSION_1_12_0        },
-    [CSR_MHPMEVENT6H]    = { "mhpmevent6h",    sscofpmf,  read_mhpmeventh,
+    [CSR_MHPMEVENT6H]    = { "mhpmevent6h",    sscofpmf_32,  read_mhpmeventh,
                              write_mhpmeventh,
                              .min_priv_ver = PRIV_VERSION_1_12_0        },
-    [CSR_MHPMEVENT7H]    = { "mhpmevent7h",    sscofpmf,  read_mhpmeventh,
+    [CSR_MHPMEVENT7H]    = { "mhpmevent7h",    sscofpmf_32,  read_mhpmeventh,
                              write_mhpmeventh,
                              .min_priv_ver = PRIV_VERSION_1_12_0        },
-    [CSR_MHPMEVENT8H]    = { "mhpmevent8h",    sscofpmf,  read_mhpmeventh,
+    [CSR_MHPMEVENT8H]    = { "mhpmevent8h",    sscofpmf_32,  read_mhpmeventh,
                              write_mhpmeventh,
                              .min_priv_ver = PRIV_VERSION_1_12_0        },
-    [CSR_MHPMEVENT9H]    = { "mhpmevent9h",    sscofpmf,  read_mhpmeventh,
+    [CSR_MHPMEVENT9H]    = { "mhpmevent9h",    sscofpmf_32,  read_mhpmeventh,
                              write_mhpmeventh,
                              .min_priv_ver = PRIV_VERSION_1_12_0        },
-    [CSR_MHPMEVENT10H]   = { "mhpmevent10h",    sscofpmf,  read_mhpmeventh,
+    [CSR_MHPMEVENT10H]   = { "mhpmevent10h",    sscofpmf_32,  read_mhpmeventh,
                              write_mhpmeventh,
                              .min_priv_ver = PRIV_VERSION_1_12_0        },
-    [CSR_MHPMEVENT11H]   = { "mhpmevent11h",    sscofpmf,  read_mhpmeventh,
+    [CSR_MHPMEVENT11H]   = { "mhpmevent11h",    sscofpmf_32,  read_mhpmeventh,
                              write_mhpmeventh,
                              .min_priv_ver = PRIV_VERSION_1_12_0        },
-    [CSR_MHPMEVENT12H]   = { "mhpmevent12h",    sscofpmf,  read_mhpmeventh,
+    [CSR_MHPMEVENT12H]   = { "mhpmevent12h",    sscofpmf_32,  read_mhpmeventh,
                              write_mhpmeventh,
                              .min_priv_ver = PRIV_VERSION_1_12_0        },
-    [CSR_MHPMEVENT13H]   = { "mhpmevent13h",    sscofpmf,  read_mhpmeventh,
+    [CSR_MHPMEVENT13H]   = { "mhpmevent13h",    sscofpmf_32,  read_mhpmeventh,
                              write_mhpmeventh,
                              .min_priv_ver = PRIV_VERSION_1_12_0        },
-    [CSR_MHPMEVENT14H]   = { "mhpmevent14h",    sscofpmf,  read_mhpmeventh,
+    [CSR_MHPMEVENT14H]   = { "mhpmevent14h",    sscofpmf_32,  read_mhpmeventh,
                              write_mhpmeventh,
                              .min_priv_ver = PRIV_VERSION_1_12_0        },
-    [CSR_MHPMEVENT15H]   = { "mhpmevent15h",    sscofpmf,  read_mhpmeventh,
+    [CSR_MHPMEVENT15H]   = { "mhpmevent15h",    sscofpmf_32,  read_mhpmeventh,
                              write_mhpmeventh,
                              .min_priv_ver = PRIV_VERSION_1_12_0        },
-    [CSR_MHPMEVENT16H]   = { "mhpmevent16h",    sscofpmf,  read_mhpmeventh,
+    [CSR_MHPMEVENT16H]   = { "mhpmevent16h",    sscofpmf_32,  read_mhpmeventh,
                              write_mhpmeventh,
                              .min_priv_ver = PRIV_VERSION_1_12_0        },
-    [CSR_MHPMEVENT17H]   = { "mhpmevent17h",    sscofpmf,  read_mhpmeventh,
+    [CSR_MHPMEVENT17H]   = { "mhpmevent17h",    sscofpmf_32,  read_mhpmeventh,
                              write_mhpmeventh,
                              .min_priv_ver = PRIV_VERSION_1_12_0        },
-    [CSR_MHPMEVENT18H]   = { "mhpmevent18h",    sscofpmf,  read_mhpmeventh,
+    [CSR_MHPMEVENT18H]   = { "mhpmevent18h",    sscofpmf_32,  read_mhpmeventh,
                              write_mhpmeventh,
                              .min_priv_ver = PRIV_VERSION_1_12_0        },
-    [CSR_MHPMEVENT19H]   = { "mhpmevent19h",    sscofpmf,  read_mhpmeventh,
+    [CSR_MHPMEVENT19H]   = { "mhpmevent19h",    sscofpmf_32,  read_mhpmeventh,
                              write_mhpmeventh,
                              .min_priv_ver = PRIV_VERSION_1_12_0        },
-    [CSR_MHPMEVENT20H]   = { "mhpmevent20h",    sscofpmf,  read_mhpmeventh,
+    [CSR_MHPMEVENT20H]   = { "mhpmevent20h",    sscofpmf_32,  read_mhpmeventh,
                              write_mhpmeventh,
                              .min_priv_ver = PRIV_VERSION_1_12_0        },
-    [CSR_MHPMEVENT21H]   = { "mhpmevent21h",    sscofpmf,  read_mhpmeventh,
+    [CSR_MHPMEVENT21H]   = { "mhpmevent21h",    sscofpmf_32,  read_mhpmeventh,
                              write_mhpmeventh,
                              .min_priv_ver = PRIV_VERSION_1_12_0        },
-    [CSR_MHPMEVENT22H]   = { "mhpmevent22h",    sscofpmf,  read_mhpmeventh,
+    [CSR_MHPMEVENT22H]   = { "mhpmevent22h",    sscofpmf_32,  read_mhpmeventh,
                              write_mhpmeventh,
                              .min_priv_ver = PRIV_VERSION_1_12_0        },
-    [CSR_MHPMEVENT23H]   = { "mhpmevent23h",    sscofpmf,  read_mhpmeventh,
+    [CSR_MHPMEVENT23H]   = { "mhpmevent23h",    sscofpmf_32,  read_mhpmeventh,
                              write_mhpmeventh,
                              .min_priv_ver = PRIV_VERSION_1_12_0        },
-    [CSR_MHPMEVENT24H]   = { "mhpmevent24h",    sscofpmf,  read_mhpmeventh,
+    [CSR_MHPMEVENT24H]   = { "mhpmevent24h",    sscofpmf_32,  read_mhpmeventh,
                              write_mhpmeventh,
                              .min_priv_ver = PRIV_VERSION_1_12_0        },
-    [CSR_MHPMEVENT25H]   = { "mhpmevent25h",    sscofpmf,  read_mhpmeventh,
+    [CSR_MHPMEVENT25H]   = { "mhpmevent25h",    sscofpmf_32,  read_mhpmeventh,
                              write_mhpmeventh,
                              .min_priv_ver = PRIV_VERSION_1_12_0        },
-    [CSR_MHPMEVENT26H]   = { "mhpmevent26h",    sscofpmf,  read_mhpmeventh,
+    [CSR_MHPMEVENT26H]   = { "mhpmevent26h",    sscofpmf_32,  read_mhpmeventh,
                              write_mhpmeventh,
                              .min_priv_ver = PRIV_VERSION_1_12_0        },
-    [CSR_MHPMEVENT27H]   = { "mhpmevent27h",    sscofpmf,  read_mhpmeventh,
+    [CSR_MHPMEVENT27H]   = { "mhpmevent27h",    sscofpmf_32,  read_mhpmeventh,
                              write_mhpmeventh,
                              .min_priv_ver = PRIV_VERSION_1_12_0        },
-    [CSR_MHPMEVENT28H]   = { "mhpmevent28h",    sscofpmf,  read_mhpmeventh,
+    [CSR_MHPMEVENT28H]   = { "mhpmevent28h",    sscofpmf_32,  read_mhpmeventh,
                              write_mhpmeventh,
                              .min_priv_ver = PRIV_VERSION_1_12_0        },
-    [CSR_MHPMEVENT29H]   = { "mhpmevent29h",    sscofpmf,  read_mhpmeventh,
+    [CSR_MHPMEVENT29H]   = { "mhpmevent29h",    sscofpmf_32,  read_mhpmeventh,
                              write_mhpmeventh,
                              .min_priv_ver = PRIV_VERSION_1_12_0        },
-    [CSR_MHPMEVENT30H]   = { "mhpmevent30h",    sscofpmf,  read_mhpmeventh,
+    [CSR_MHPMEVENT30H]   = { "mhpmevent30h",    sscofpmf_32,  read_mhpmeventh,
                              write_mhpmeventh,
                              .min_priv_ver = PRIV_VERSION_1_12_0        },
-    [CSR_MHPMEVENT31H]   = { "mhpmevent31h",    sscofpmf,  read_mhpmeventh,
+    [CSR_MHPMEVENT31H]   = { "mhpmevent31h",    sscofpmf_32,  read_mhpmeventh,
                              write_mhpmeventh,
                              .min_priv_ver = PRIV_VERSION_1_12_0        },
 
-- 
2.34.1


