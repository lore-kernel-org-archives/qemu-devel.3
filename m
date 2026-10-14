Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85DEECA9EBD
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 03:48:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGpqO-0004za-8L; Tue, 13 Oct 2026 23:39:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xGpqM-0004xc-1T
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 23:39:54 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xGpqK-0001OM-Cx
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 23:39:53 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-3ac397836fbso1199781a91.1
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 20:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791949191; x=1792553991; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YNC9KovvsCcPFhw1oKBW9JKFDxmX8NTxlxV0Y0y94Tk=;
 b=RJyd1QzeCpuxKOOxuJKGJQmMbrrKFo8gR/TEMMEquYy0FpjyjZyObeUQkYTpGh5Y2U
 W/CGAxXe8ddxsYZBXmlg6fvIBOEoBjx9bvw0LxY3NOVZXF5YZQSfe1m5P7Nt9Bh8YJhs
 YXvw8gbb3JYh5vUmmX8ph241HDd5gvhLB0k5mdrf827HBMFY2IPH3SEHP3R0VKJCnyo+
 Wz+zHQCb2KrxsC185aPwt6h9OsPdUXvs+kPnmDLbbwTduGbHVPCunhg+9Ef4ivssyHNO
 YANbRAOskYu4+Zw8+Wh1w2HbP/2P9kg/l7dJfMyOkxz7URBjIxPB4/UoKR+VMaUH8KcB
 85xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791949191; x=1792553991;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=YNC9KovvsCcPFhw1oKBW9JKFDxmX8NTxlxV0Y0y94Tk=;
 b=aShNgfl23dvoWH0W7mfaT4kNlXLi9i/vxLaMk9KKH3Lwt93DPK82wqAHBw7Cb1tBjD
 Pq/eoga5w12M25rnkFLnCa5MpdHzUKDuR8eZGsG4zdgdaht9ejE0Cs3lKc3ad1tisU4J
 w1aauzCwkaHLHiaDnqrMzFOLBgtTotGqdowdkPvL6ZDQaGdCUBos2FyQfcoFFgyhEIQX
 X8sBxrrPyawUYCNRiNw+j8azmZfCnGXV0WkprQEjJ5mAUtQ6MJC2CKSlYWV85RJiPFzA
 UZdzEXRpTKj+leukguezZT+ITBTnVMLGLti6GNaiV85yAnp29RCBPrf9u24tOoi6zNLa
 Hw8Q==
X-Gm-Message-State: AFq9FYLSN0TwkTDGtvIyd7kHNTWvIRkqebEXGkRMEikhCCD7riA7sgoL
 Ur1hrvDM8ReK9cag3SCSBjQER5q07H3IzLu+OoGzcZ3SIw6eY63DPEZ/wvKMEA==
X-Gm-Gg: AYBFou0943uaX6iIw6tFMJFaDJhiNWIQmmmExsQsntXAyzsFbDLmZvKzHPh60xcU/uz
 yRVgG4y7ZWqyRiHVQUcd9gOwy7K76FTxJvkMNVa7WZq5zPBpChajd7k/GyX7BHffMrm9gEg4Y6t
 MvxwBQMGfGTuGBvxNKhqqHMDGuvMipQAPsvE850hLbUm8q5DYpmYorcaH7JtV6q9b/lYsmIGYJb
 VTLv17FlMHdnyqTabuVBAislOJ3v+HGE9sfg0/Xfysgs8cY2BSLZBBF7fq1LCcv2VWyAFnRgjja
 mEG/qYBi3cmCRuhwj/7v9YhebNFPVJa77hDdE7zC5tdwybjdNYN+HK2ST0VfhXH1gt6Z7I6kbLe
 +rPD0oG/IKrGY44Geci7vVYdXlftCI3FYskkA8uOWe7H6UUu8x9SOA5KWVRgJFGo812eHZiIplK
 P3V1fCBZbdNNPfx1vfSkxJ79kVcXyUC1UP+COSKW45LXum4gMFpcNU8rBdh0TJdWvOQ9mSRVaXn
 SacK+Ujzy3jQuhBwUrbL5WuOjk=
X-Received: by 2002:a17:90b:5827:b0:3ac:17c:6e74 with SMTP id
 98e67ed59e1d1-3ac017c6fe0mr6107447a91.53.1791949191165; 
 Tue, 13 Oct 2026 20:39:51 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ac61170b7bsm2321457a91.16.2026.10.13.20.39.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 20:39:50 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Xie Bo <xb@ultrarisc.com>, qemu-stable@nongnu.org,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 09/52] target/riscv/kvm: Preserve VCSR across migration
Date: Wed, 14 Oct 2026 13:38:24 +1000
Message-ID: <20261014033907.3332383-10-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261014033907.3332383-1-alistair.francis@wdc.com>
References: <20261014033907.3332383-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x1036.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Xie Bo <xb@ultrarisc.com>

The vector state sync handles vstart, vl and vtype, but leaves vcsr
behind.  vxrm and vxsat in the migration stream are therefore stale,
and the destination does not restore the values held by KVM.

Read vcsr when collecting vector state and split it into vxrm and
vxsat.  Rebuild it from those fields when writing vector state back.

Fixes: 3ca78c0689d5 ("target/riscv/kvm: add RVV and Vector CSR regs")
Cc: qemu-stable@nongnu.org
Signed-off-by: Xie Bo <xb@ultrarisc.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Message-ID: <20260831074106.1798671-4-xb@ultrarisc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/kvm/kvm-cpu.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index 1993bd446b..45ad5e1525 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -910,6 +910,13 @@ static int kvm_riscv_get_regs_vector(CPUState *cs)
     }
     env->vtype = reg;
 
+    ret = kvm_get_one_reg(cs, RISCV_VECTOR_CSR_REG(vcsr), &reg);
+    if (ret) {
+        return ret;
+    }
+    env->vxrm = (reg & VCSR_VXRM) >> VCSR_VXRM_SHIFT;
+    env->vxsat = (reg & VCSR_VXSAT) >> VCSR_VXSAT_SHIFT;
+
     if (kvm_v_vlenb.supported) {
         ret = kvm_get_one_reg(cs, RISCV_VECTOR_CSR_REG(vlenb), &reg);
         if (ret) {
@@ -966,6 +973,13 @@ static int kvm_riscv_put_regs_vector(CPUState *cs)
         return ret;
     }
 
+    reg = (env->vxrm << VCSR_VXRM_SHIFT) |
+          (env->vxsat << VCSR_VXSAT_SHIFT);
+    ret = kvm_set_one_reg(cs, RISCV_VECTOR_CSR_REG(vcsr), &reg);
+    if (ret) {
+        return ret;
+    }
+
     if (kvm_v_vlenb.supported) {
         reg = cpu->cfg.vlenb;
         ret = kvm_set_one_reg(cs, RISCV_VECTOR_CSR_REG(vlenb), &reg);
-- 
2.55.0


