Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ED69C48BF5
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Feb 2024 00:03:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rb89j-0003Rm-SZ; Fri, 16 Feb 2024 19:02:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1rb89h-0003Qe-Tb
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 19:02:10 -0500
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1rb89U-0007wt-Me
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 19:02:09 -0500
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-6e0a37751cbso2378262b3a.2
 for <qemu-devel@nongnu.org>; Fri, 16 Feb 2024 16:01:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1708128114; x=1708732914;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pGQiJiXNpe+wJDP0dh67sKLX3rZ5tlLVJog8RYCQlBY=;
 b=fbfjzXbDfZJuwjHoekjJDU/L2MmXlSl/+gCwUBg9wtK+scVjZQQwzG9d/BNl8itVd9
 LqlCeu1fjygKHDsTB2D4v9n9lsHlq6cjsrTRdzrtHQbhZT/i8H5Hg/ZklSYiaEF2eViB
 o60Ql+pwkjMHxjp/EpLWUa+GavUVq+PBHFWN35Fdco1R1Y/Qafi+rPgBTJuq3MPBqjY6
 J96AMfDT7Ky/NTZYJFsBSwXi4xzLPZJZtqTt0cpTMhBdSmXyFBTTiwH/xfD1KEG6N9yu
 Gypi88FtOoi//MopTUxfi0YDjSYMQsLAxk6jnW380CajcZoP1MKaJnMzMx6QWUs5SjRH
 tfBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708128114; x=1708732914;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pGQiJiXNpe+wJDP0dh67sKLX3rZ5tlLVJog8RYCQlBY=;
 b=ouPHC1c90R9lMTwDTtn0+ujj7t4u0bUjQpX5FMB0zwgTGLnf0Q6vGoJWrFFRS43NrS
 d2ZokVeazX0wosVBsaQBJq4epnc2HIMNfpEnQKLKuD/8SllwpQSUxT+U/5Xf2XkRU/M+
 dfW1QMiOJY4D73U5R3cDnet5EnfI1VRBd/ujrZL0f91G++B2pMf3XSF1euFXQdkkYu9O
 ztyDFXYhG1+H5ROfPWeik62UzXlW8PMCIIP53VSGI72TYanYFzP+gnIdl1NOpOkCkhzv
 M3JJxkVwWhfBbmKi7eF3u8HPt/zgjiIHg7sBisFNQhg5mVPwwhPUkaqed57p0C29Qn+D
 +7mQ==
X-Gm-Message-State: AOJu0YzJ0PiNSavz7YO1C6Fwf1wucKmHeZ4RVLqHjMGDvaH7edMKBxS4
 47554oDcDLv8PePZGNSOPjZ98GR+5++jUo1qGOVwR8OC8d0ThvSyk/o0526QT6XaG1OI957kRGr
 1
X-Google-Smtp-Source: AGHT+IE+BcpsV8o0P/1okl123Yl9xKC9JhUIsD9fg8fUUpMOCaVGJEr+Ce9YnGPNKh+8fdc3oT7V1Q==
X-Received: by 2002:a05:6a20:43a0:b0:1a0:849a:45be with SMTP id
 i32-20020a056a2043a000b001a0849a45bemr6354522pzl.46.1708128114259; 
 Fri, 16 Feb 2024 16:01:54 -0800 (PST)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 p13-20020a635b0d000000b005d66caee3d0sm464015pgb.22.2024.02.16.16.01.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Feb 2024 16:01:53 -0800 (PST)
From: Atish Patra <atishp@rivosinc.com>
To: qemu-devel@nongnu.org
Cc: Atish Patra <atishp@rivosinc.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, qemu-riscv@nongnu.org,
 Weiwei Li <liwei1518@gmail.com>, kaiwenxue1@gmail.com
Subject: [PATCH RFC 7/8] target/riscv: Add select value range check for
 counter delegation
Date: Fri, 16 Feb 2024 16:01:33 -0800
Message-Id: <20240217000134.3634191-8-atishp@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240217000134.3634191-1-atishp@rivosinc.com>
References: <20240217000134.3634191-1-atishp@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=atishp@rivosinc.com; helo=mail-pf1-x432.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

This adds checks in ops performed on xireg and xireg2-xireg6 so that the
counter delegation function will receive a valid xiselect value with the
proper extensions enabled.

Co-developed-by: Atish Patra <atishp@rivosinc.com>
Signed-off-by: Kaiwen Xue <kaiwenx@rivosinc.com>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 target/riscv/csr.c | 36 +++++++++++++++++++++++++++++++++++-
 1 file changed, 35 insertions(+), 1 deletion(-)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index a1c10f1d010a..d5218a47ffbf 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -1978,6 +1978,11 @@ static bool xiselect_aia_range(target_ulong isel)
            (ISELECT_IMSIC_FIRST <= isel && isel <= ISELECT_IMSIC_LAST);
 }
 
+static bool xiselect_cd_range(target_ulong isel)
+{
+    return (ISELECT_CD_FIRST <= isel && isel <= ISELECT_CD_LAST);
+}
+
 static int rmw_iprio(target_ulong xlen,
                      target_ulong iselect, uint8_t *iprio,
                      target_ulong *val, target_ulong new_val,
@@ -2103,6 +2108,17 @@ done:
     return RISCV_EXCP_NONE;
 }
 
+static int rmw_xireg_cd(CPURISCVState *env, int csrno,
+                        target_ulong isel, target_ulong *val,
+                        target_ulong new_val, target_ulong wr_mask)
+{
+    if (!riscv_cpu_cfg(env)->ext_smcdeleg) {
+        return RISCV_EXCP_ILLEGAL_INST;
+    }
+    /* TODO: Implement the functionality later */
+    return RISCV_EXCP_NONE;
+}
+
 /*
  * rmw_xireg_sxcsrind: Perform indirect access to xireg and xireg2-xireg6
  *
@@ -2114,7 +2130,25 @@ static int rmw_xireg_sxcsrind(CPURISCVState *env, int csrno,
                               target_ulong isel, target_ulong *val,
                               target_ulong new_val, target_ulong wr_mask)
 {
-    return -EINVAL;
+    int ret = -EINVAL;
+    bool virt = csrno == CSR_VSIREG ? true : false;
+
+    if (xiselect_cd_range(isel)) {
+        ret = rmw_xireg_cd(env, csrno, isel, val, new_val, wr_mask);
+    } else {
+        /*
+         * As per the specification, access to unimplented region is undefined
+         * but recommendation is to raise illegal instruction exception.
+         */
+        return RISCV_EXCP_ILLEGAL_INST;
+    }
+
+    if (ret) {
+        return (env->virt_enabled && virt) ?
+               RISCV_EXCP_VIRT_INSTRUCTION_FAULT : RISCV_EXCP_ILLEGAL_INST;
+    }
+
+    return RISCV_EXCP_NONE;
 }
 
 static int rmw_xiregi(CPURISCVState *env, int csrno, target_ulong *val,
-- 
2.34.1


