Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94666CFA472
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Nov 2025 05:05:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMJK7-0006EO-1k; Fri, 21 Nov 2025 00:04:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1vMJJx-00068C-9v
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 00:04:33 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1vMJJu-0006oM-EF
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 00:04:33 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-29555b384acso19792965ad.1
 for <qemu-devel@nongnu.org>; Thu, 20 Nov 2025 21:04:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1763701467; x=1764306267; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JY7v5PFUTvqG5xjU8tx4kJ2bLxHjuCr4rVrZ2t+pKeU=;
 b=iQDVq+ils4rLp0h6PE8du57BQA9Z7NdW4bbQyBNpXaDDD5bdmSUmhw5YVp8bFLawJY
 ZXC7Vg6UZ9EsvNWAwPjsW+oB2wschCdFM36S0KfiBVd3K4L+Kc+Z40f1RuK8r1n5WsTf
 MVVUyiAPMzKLZ06r4vX2QLwxob6fV3KDScl7SrNTocHJ8oeDAikK2uCATHSyObkzFEk4
 8NLDg7Xut+01X6lqxdjdfunvfV+K2Z9pnZkfjFoqT2OXeTRwZFTISEutqThQGxUxvRAr
 If82f1oSuF1YFUiIyF+PI/5kSmeFLLnrV2aNZMDjpNB15bFmKkVVnkXlkdVmr5CTQKD1
 YlKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763701467; x=1764306267;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JY7v5PFUTvqG5xjU8tx4kJ2bLxHjuCr4rVrZ2t+pKeU=;
 b=gDAgNg2QF/SD5thGxZeE5h8qtOgCkKT/iJPb/8W/y0AUUDqlm3FOl7vqMGT9felEaY
 Bm6nCAX95mT//MT0xjiUPm6GiUBVk798VTk462pLDTbD/wxuvYjBvhFDCyYDVQTvn3Vj
 JtWo3EybNrtWKOCH5PYsBRPP+AvYxDzBGDnIku5CMGBq+361cgc1Z1tHQIKxtK8XC0Np
 lnokaZt1XgEylufl63K/SzgK9gwXYQAy+bUDeIof47mdmSA+YhE5imaeFPPtI4oG7JYj
 l6JtSXunRPUjl49IqsvLqS4qwrUBFrlQ/nf64DIEC5c43yO6zj/q8o71/rxupq5cNbb+
 PoSQ==
X-Gm-Message-State: AOJu0YyU1z+/mI+NqLIWQye2KuDznDlAIsgXE6bxnFo1t9Yd8iUONF4W
 MMUmHiPrFm41DI3Md66FnYSGOiX5ZL8sK8VnT+Rb37gO93UhrEirR2lyfnr+TqvHwDb77tdRqFV
 vQN4ojivpWfsFa+ffAK/XuP0T05Wcy7XLp7td8VW6G2BilrtyK31Zq0TNJQWAqI1UuJW3HW6+EH
 tQEMjDXpY9Vtg5XqZatU/xJ0qPq/xt0lh8neY+xmItMAg=
X-Gm-Gg: ASbGncsSVo67aJ9nKPAS+J4/TSzNu3SnQTNgXxRMvZ0l7NGFZKbsWR4ttLFu7qwUC7+
 cuCmupq8+vpofrlqEpPXlmZuB0voHw/cuzWArD4KN0V4kz/nhhQ3YEaiUJZ2iOwXJDY4ewfg7HX
 JzJaFeZBOGnYHlYmsU0M8Be7GVCVVDonDVnvO5STNh6pgzpo+DFzOPK2ZR8m5NtQIAXwWAAefEb
 RdIRBDMjvt2bksSyUuoq6aSk1aWb8oPWsFvHl6IPe/9j8gIWlSSeMbRhxsriHboLf4/MlbRL0JR
 p84SKTSb3uQ21IjiJrAppGGxQ2EkDgA8EVDeiKUopQS/nqu+v1iXCzf1CusVCKmVsalJFhPAJ2L
 SxJtS7dE8m1wWa+dL8dC2lRKbxCvx4xiZQgKp9Kzq+P6lwHJy9rWNy9tQWzCir+NIhiejhGPjrU
 CkubqR4FS5+PWPMNIKDQ4kUR4LXWcnyNgKz4MUCg==
X-Google-Smtp-Source: AGHT+IGDQsx3GUn9fEEQjlCOT+4TGxmxEVZX+br837s4osQ4OwsxBH3JauGV/XGQuAw43so8gGJwCQ==
X-Received: by 2002:a17:902:ce88:b0:295:5132:1a99 with SMTP id
 d9443c01a7336-29b6c68be3emr15581185ad.44.1763701467333; 
 Thu, 20 Nov 2025 21:04:27 -0800 (PST)
Received: from hsinchu16.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29b5b26fed2sm43384525ad.69.2025.11.20.21.04.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Nov 2025 21:04:26 -0800 (PST)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 qemu-riscv@nongnu.org (open list:RISC-V TCG CPUs),
 Frank Chang <frank.chang@sifive.com>
Subject: [PATCH v2 4/6] target/riscv: Fix pointer masking for virtual-machine
 load/store insns
Date: Fri, 21 Nov 2025 13:04:11 +0800
Message-ID: <20251121050413.3718427-5-frank.chang@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251121050413.3718427-1-frank.chang@sifive.com>
References: <20251121050413.3718427-1-frank.chang@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=frank.chang@sifive.com; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Frank Chang <frank.chang@sifive.com>

The effective privilege of explicit memory accesses made by
virtual-machine load/store instructions (HLV.* and HSV.*) is controlled
by hstatus.SPVP. mstatus.MPRV does not affect these virtual-machine
load/store instructions.

Signed-off-by: Frank Chang <frank.chang@sifive.com>
---
 target/riscv/cpu_helper.c | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index acfc6c10607..bf747834dcc 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -261,16 +261,25 @@ RISCVPmPmm riscv_pm_get_pmm(CPURISCVState *env)
 RISCVPmPmm riscv_pm_get_virt_pmm(CPURISCVState *env)
 {
 #ifndef CONFIG_USER_ONLY
-    int priv_mode = cpu_address_mode(env);
+    int priv_mode;
 
-    if (priv_mode == PRV_U) {
-        return get_field(env->hstatus, HSTATUS_HUPMM);
-    } else {
-        if (get_field(env->hstatus, HSTATUS_SPVP)) {
-            return get_field(env->henvcfg, HENVCFG_PMM);
-        } else {
-            return get_field(env->senvcfg, SENVCFG_PMM);
-        }
+    if (get_field(env->mstatus, MSTATUS_MXR) ||
+        !riscv_cpu_cfg(env)->ext_ssnpm) {
+        return PMM_FIELD_DISABLED;
+    }
+
+    priv_mode = get_field(env->hstatus, HSTATUS_SPVP);
+
+    switch (priv_mode) {
+    case PRV_S:
+        /* Effective privilege mode: VS */
+        return get_field(env->henvcfg, HENVCFG_PMM);
+    case PRV_U:
+        /* Effective privilege mode: VU */
+        return (env->priv == PRV_U) ? get_field(env->hstatus, HSTATUS_HUPMM) :
+                                      get_field(env->senvcfg, SENVCFG_PMM);
+    default:
+        return PMM_FIELD_DISABLED;
     }
 #else
     return PMM_FIELD_DISABLED;
-- 
2.43.0


