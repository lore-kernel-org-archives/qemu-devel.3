Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40057C43458
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 10:21:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wes1s-0000ZR-0n; Wed, 01 Jul 2026 06:18:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wes1p-0000Tg-IT
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 06:18:49 -0400
Received: from mail-dl1-x1231.google.com ([2607:f8b0:4864:20::1231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wes1n-0004hH-Uk
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 06:18:49 -0400
Received: by mail-dl1-x1231.google.com with SMTP id
 a92af1059eb24-139b914bab6so540232c88.1
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2026 03:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782901126; x=1783505926; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fN4MRw+BnrddfO5S62VeAje597hHSVZtAx/lMrwd+BM=;
 b=Vx1Uy25lddfLwvBrSgM2NCcm6LKtr/yxdbyRQxVNugPaWGXpDmtzeCmw08FeTTQioB
 VJchkvRYYUiw7Lc8DFwtNf8uuuWG+iQAd3M1UOHlMOAwAeVuimkksBkRk1LNufW86zfP
 uppxk7Lw6iUGfhn1otbvn0BFHFd4ITE/rVICw8zHx4Y4uST9ZJT6+01H0aIA1yUjjUSs
 ErNxtif+f4zJxnY/xwEn7CHjEMuZSZP8VbzCoe3jvv3Re7Vzmx+ePb/sFA514NerseFY
 ASX+6fbjgSyRsp0AQMEr1eUy4iCe3KV5x+XrVW6iS2ftvCjpxwvHO/lINdOc+F/FwIqv
 mgVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782901126; x=1783505926;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fN4MRw+BnrddfO5S62VeAje597hHSVZtAx/lMrwd+BM=;
 b=Y5NUlAedU3+o/9ybOsuCTC3vjmm3TWpiZaXVN7KANONpUTtxaRPIN1Bb6jSg74FtWq
 GOyhZvKffItpE4ABihD6MH0Kbfnl05YQsZgNzpWA2AaitJlCIu03KKeqRP+PXvYsZHHt
 /U71OMe4ThI85TBPxietzaFvVFEaqvIWNYFsHBUxRFf8P2PBZYroX9/BBwiXRvFweGQp
 EUtsT/s7clQOwflCdYQVnH8KlgIEMMkbThwxVWDc411Pt1LNorWAa5Iel2USqazLbfma
 +jzhy+9Jgytec2hHD7irv262VyS8Inzel+gUpXFNxb45DlyGw3Rhkl7fN5/2b4oSX9nU
 jXYA==
X-Gm-Message-State: AOJu0Yw6/cXbbxKLruGCqYBl1Jl6NiEr/FjWbin97p087leWzFUQtNiC
 D2PbcNxjU2ZMx5lOldnfuLCyvlW7KEgo6LjciiKrHc/9Q0g+7b8auSQ0RnHYDg==
X-Gm-Gg: AfdE7cme9OkaB5uBa9Rbs4M2upA5F/3Acpe0e8wvG7PC9vs9dtC3B4yTLjg9lp7mKYt
 Sa8X+7GjUYKm6dIyXtLxrkJ1aJ8sQJrpPMWSDftS6mR/GNupd2/k6yeKfB8hEUHDlh3Dw18Fy2G
 ANWuIn2lgQEmMfbenfaROiLJ3ho1BNuW2TXIxtl2KEwVK7ufl6zNq/h6XxI6FOK1PavFNgnpWbJ
 9p/kdp0Dh7UpPRjPVarhkDP/A2RdS6Mxv/sEGBUlVKIJlqJLu/8+14fyY0R1ePq22BBTvwOroRu
 NmR5EbCgVv31wJci3Ki9Z8JxsAmp3xO4hBd0MoGssJGSu5b5YeGiq3pMVFRjA1V73KG0gDG3WIS
 kDUD3PGIgIPETWd522sS7cCgI2/rRT7CSJODZODffWoHczIKHAmttddCzR70+xBFNrJSR3kIYcF
 ZTEfuRTYpgMbfAs+wMasuIFbZB6B2VXFo=
X-Received: by 2002:a05:7022:41d:b0:136:c77a:6509 with SMTP id
 a92af1059eb24-13b36dd3a16mr974956c88.25.1782901126262; 
 Wed, 01 Jul 2026 03:18:46 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b2ab2e0e3sm19355047c88.7.2026.07.01.03.18.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 03:18:45 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Meng Zhuo <mengzhuo@iscas.ac.cn>,
 Alistair Francis <alistair.francis@wdc.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>
Subject: [PULL 12/39] target/riscv/kvm: skip FP/Vector sync on
 KVM_PUT_RUNTIME_STATE
Date: Wed,  1 Jul 2026 20:17:25 +1000
Message-ID: <20260701101752.2522962-13-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260701101752.2522962-1-alistair.francis@wdc.com>
References: <20260701101752.2522962-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1231;
 envelope-from=alistair23@gmail.com; helo=mail-dl1-x1231.google.com
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

From: Meng Zhuo <mengzhuo@iscas.ac.cn>

During KVM exit processing (KVM_PUT_RUNTIME_STATE), QEMU never modifies
FP or Vector registers — only core GPRs/PC and CSRs are potentially
changed.  Re-syncing 32 FP and 32 Vector registers on every KVM exit
wastes 36-68 individual KVM_SET_ONE_REG ioctls per vCPU exit.

Follow the s390x pattern: early return on RUNTIME after syncing core
registers and CSRs.  KVM_PUT_FULL_STATE and KVM_PUT_RESET_STATE continue
to sync everything for correctness during migration and initialization.

Signed-off-by: Meng Zhuo <mengzhuo@iscas.ac.cn>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
Message-ID: <20260518102118.2768383-1-mengzhuo@iscas.ac.cn>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/kvm/kvm-cpu.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index f0de5c3071..39d48a9db4 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -1395,6 +1395,17 @@ int kvm_arch_put_registers(CPUState *cs, KvmPutState level, Error **errp)
         return ret;
     }
 
+    /*
+     * For RUNTIME_STATE, KVM already has the correct FP and Vector state
+     * from the preceding KVM_RUN exit. QEMU never modifies these registers
+     * during exit handling, so re-syncing is unnecessary.  This saves ~68
+     * KVM_SET_ONE_REG ioctls per vCPU exit.  See also s390x which uses
+     * the same pattern.
+     */
+    if (KVM_PUT_RUNTIME_STATE == level) {
+        return ret;
+    }
+
     ret = kvm_riscv_put_regs_fp(cs);
     if (ret) {
         return ret;
@@ -1407,11 +1418,9 @@ int kvm_arch_put_registers(CPUState *cs, KvmPutState level, Error **errp)
 
     if (KVM_PUT_RESET_STATE == level) {
         RISCVCPU *cpu = RISCV_CPU(cs);
-        if (cs->cpu_index == 0) {
-            ret = kvm_riscv_sync_mpstate_to_kvm(cpu, KVM_MP_STATE_RUNNABLE);
-        } else {
-            ret = kvm_riscv_sync_mpstate_to_kvm(cpu, KVM_MP_STATE_STOPPED);
-        }
+        int state = cs->cpu_index == 0 ? KVM_MP_STATE_RUNNABLE
+                                       : KVM_MP_STATE_STOPPED;
+        ret = kvm_riscv_sync_mpstate_to_kvm(cpu, state);
         if (ret) {
             return ret;
         }
-- 
2.54.0


