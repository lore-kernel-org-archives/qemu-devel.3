Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECBF5C02183
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 06:05:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYfNa-0000ts-0E; Fri, 17 Jan 2025 00:58:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tYfMl-0007oU-R9
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 00:58:03 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tYfMk-00067l-9Q
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 00:57:59 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-216401de828so29996795ad.3
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 21:57:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737093477; x=1737698277; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cqSkc2TSqmGrwYWaj16vXKKvXZ1iDZafs8vexvrvbSA=;
 b=NxRjtuciAg/mNgIBy9NssZVW9luelYwmQGNv0PJYcmdcouH3G3ewPXH8FKcKNttZDN
 quFjJIp1bBSJR1yaZscelpZUn/cPyQqyd6WwNWWoQZZpfKZMaFCG4mpDeKXsBUH4qDFt
 QvzKEQ23ufAVTfcmobUv9V7sGI/Nq0iHTQlSILdqGto28AkOGOVCZKqF3i7l8dSYYBdj
 5oR9a+2fh1+/CtuLOP7a9zwTN4upekIarS67lrp43BDH71sxXuxqoAYD+OiSti8TaLzV
 gwtN/aSKfllKHnpB2RNBkp2Gx83siEhWvbnpKewU5UtlVYoTExUeamK+j3qTNGIKtMPf
 KSBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737093477; x=1737698277;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cqSkc2TSqmGrwYWaj16vXKKvXZ1iDZafs8vexvrvbSA=;
 b=sJ7s3Y8zLbsjQLMIO/yGDna3EFm+ijY13O3W5oXbEo1+z3UgeWTZbkopx8z7xWZzvb
 tQkS4BZTXY3oU07dMPlLPqKK5fTsnoXNe5pwmPQGT+MgTGCb4zP/3skKSLOPR1p7euqq
 8RoTGExj45P397hPIbyjTAUoXs+TQs/G+neGlPRt5obaxkCGdCwbTO6PZA9uqT+q1I1T
 WbuW2aMlFBkuhR9I0X3M1vdvLOqjsJYE5BIy0q0pqLBqDoR1GSF62bLW837QhDpA+EpL
 T3GEhPIEI0baAOoDiDiwRJgumTJhg0dzgIrVL/BSA6fAN4Kp0uH7FwrEPlve55Nq/UsM
 BxXA==
X-Gm-Message-State: AOJu0YzWlb2wIz7QXoPmkFfg8CrLS9tDAfBgPfvHsJy6/mNFlvmVWOoe
 8qZn0m2HNPS0wJO5HNhvih6vm+leGfL1FErKiiPzITPkNlgm2Gj3jo6Qtw==
X-Gm-Gg: ASbGncuWix894AYXFvgTgXGHpB/Zc3ZCXmI0U+Q3MlR+tYcOAAJ2Eai023TMHTY9trh
 AIAhyeFHx/rcQ6W90ZnoLu4z+9IIWArjRa/9geZIWjypPUH5rXeK+YlD46d+t2z+ZdXQR2M4zFn
 6/zDmEXTRciJaJix/51Py328vVYUzI3Ud6Sam2nWLcwXPhiCajJJQQdSt7Duh+Jv0yDg2Rn7ps8
 xYcyrBOIbgD3/37L9oww0smsxyY7UlaPnioPn4RH//8dXylY6AI0H/UnfEXTqfpxFyLY7uowl6+
 /SatsqyS1ETVV1AJMlGa+DuOX5tnWsWLTwZ0XBI279zmTfoo+ty7MUtb0IS0
X-Google-Smtp-Source: AGHT+IED5MZhgi8SJCj9KhmPju9jyNIIQNFLezwt8by4sOv2HJGzRTQU2Q7jh/aY59EwLqpdlAUZHA==
X-Received: by 2002:a17:903:230a:b0:216:1543:1962 with SMTP id
 d9443c01a7336-21c35505464mr22744015ad.23.1737093476724; 
 Thu, 16 Jan 2025 21:57:56 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21c2d3d6fbbsm8563595ad.168.2025.01.16.21.57.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jan 2025 21:57:56 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Kaiwen Xue <kaiwenx@rivosinc.com>,
 Atish Patra <atishp@rivosinc.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 34/50] target/riscv: Add select value range check for counter
 delegation
Date: Fri, 17 Jan 2025 15:55:36 +1000
Message-ID: <20250117055552.108376-35-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250117055552.108376-1-alistair.francis@wdc.com>
References: <20250117055552.108376-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Kaiwen Xue <kaiwenx@rivosinc.com>

This adds checks in ops performed on xireg and xireg2-xireg6 so that the
counter delegation function will receive a valid xiselect value with the
proper extensions enabled.

Co-developed-by: Atish Patra <atishp@rivosinc.com>
Signed-off-by: Kaiwen Xue <kaiwenx@rivosinc.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
Message-ID: <20250110-counter_delegation-v5-7-e83d797ae294@rivosinc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/csr.c | 36 +++++++++++++++++++++++++++++++++++-
 1 file changed, 35 insertions(+), 1 deletion(-)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 49648ddc95..df748dffa3 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -2159,6 +2159,11 @@ static bool xiselect_aia_range(target_ulong isel)
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
@@ -2284,6 +2289,17 @@ done:
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
  * rmw_xireg_csrind: Perform indirect access to xireg and xireg2-xireg6
  *
@@ -2295,7 +2311,25 @@ static int rmw_xireg_csrind(CPURISCVState *env, int csrno,
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
2.47.1


