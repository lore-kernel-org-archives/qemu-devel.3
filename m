Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9387C71136
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Jun 2025 16:37:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRZJF-000436-Ro; Tue, 17 Jun 2025 12:37:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uRZGE-0000mP-2o
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 12:34:10 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uRZG5-0000fC-Dn
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 12:34:09 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-450ce3a2dd5so56423695e9.3
 for <qemu-devel@nongnu.org>; Tue, 17 Jun 2025 09:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750178039; x=1750782839; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n0sO4FG8MJlTgihEHf66llt9xMF7CLK1g/3AupI01Bo=;
 b=s0vs5UOOotw2kRN4LmSwxK4N+WEi3Jp4sxZ2s7OVvdofGc+o9IISIENtUymGifxr6w
 U3BYvuBdUNGwLB+owhz94rjrUF2oX5g7dE/Qntjsq74is/LTb/65wVovOxiF8AoC7xw3
 k+jLizw0u9l2AIuQe9qeb65eoD/qci7bZJNX9ndA2NTabMRGDzKF0MikuPnTMXaJZEfV
 E2qizVp4DLO8PMop44u9Z46/U38WyTdmebxy9TXohHjuAO3uYXMWnQC0Q140spGPPvQF
 scnnqBBd+LVqCA9kPqwsqPVeS74ka5Jj0Hn4c4RkE1qQ8jGSsHD7aCrFaN3SnKjMvB5a
 GpdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750178039; x=1750782839;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n0sO4FG8MJlTgihEHf66llt9xMF7CLK1g/3AupI01Bo=;
 b=XptscxX2VT8UDZbNEpXzbSiwwjtkHK30trjo7LJpm1Z8zC9+5OgU7TdUD/sj1PWnFt
 bkDQxpXV7ul/t6Y+NSku9s/6xzVTQyqz6fcyAgWn/NJFFQUupkhT4Eq3Hs3sv5ufN6D4
 W5NHALFFW945dNDk4+tfm49uJRFMR4ufnIt8GPld9L95vH1QU+0nHCsnoRfuDTf89uBR
 krXqHba8+ewJkvwldbeoFpxFexZ1W2Lpz0V60mCmCt5+y/SG1zul3KKJe/QLOe6K6afN
 096ZWFLCU5RIi0V99/ZcGrYBVexG26ryaozW7aNLbDHbFV/535+8LHTaVslgsism4KC/
 psRg==
X-Gm-Message-State: AOJu0Yz2egPN5mTcA1Bv79rSHkz1qoz7Mw6yTjdixH74XKfC4YWeeUXi
 qFmwKusqTL9/jzvT+AGlVf9v0Gy5zJFMmicQgH7hlrpUmyB4/6xT22vKQoYCJRISnrEbaaW8Q+0
 lJue5QYk=
X-Gm-Gg: ASbGncuD+CS4aNDBzIOwfi7THTU7AJUdbbf+Dpmxf3gk5IexiCXqXtJKaTP3DJ3SNLh
 oYq1zDEFT9NGrmhWIqUDF8DlgBsdb10lagKLCyjNMwhSHbhTVmRaCzRTqadG25Wfiq+0ZZPfBDz
 vF/7VmLdP6OyW9C1ZvjF/UJyr/zW+YbNcGGSr6JMpqZWKcgJgJhDEiMMQ8kKl5FYHncaY3e2L4V
 AAze0fJNgaIN6ZJQHT5l0PCaA/gV8T4JwyT463bFZFi6gHgPcYoIITXeFo/cGVFkqusZqbIiUlQ
 MdtqKxsPvXRKoDhgam2QN1JlzQIi6ad/iF6761SePUKEhtg3eBOloYD2DbfGYBBmX2wZ04vzyg=
 =
X-Google-Smtp-Source: AGHT+IHtPPp86JB1WL2NUMpWWPzLqOSjoM5yKoDid7gycB2n4vWQmDxDEGw2087UlKh+t1YO5wHSuA==
X-Received: by 2002:a05:600c:3b92:b0:43d:2230:300f with SMTP id
 5b1f17b1804b1-4533c9c6e8fmr147105255e9.0.1750178038731; 
 Tue, 17 Jun 2025 09:33:58 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a568a73845sm14651906f8f.35.2025.06.17.09.33.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Jun 2025 09:33:55 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id C30215F91D;
 Tue, 17 Jun 2025 17:33:52 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Cornelia Huck <cohuck@redhat.com>, qemu-arm@nongnu.org,
 Mark Burton <mburton@qti.qualcomm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Alexander Graf <graf@amazon.com>,
 kvm@vger.kernel.org, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [RFC PATCH 09/11] kvm/arm: implement sysreg trap handler
Date: Tue, 17 Jun 2025 17:33:49 +0100
Message-ID: <20250617163351.2640572-10-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250617163351.2640572-1-alex.bennee@linaro.org>
References: <20250617163351.2640572-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Fortunately all the information about which sysreg is being accessed
should be in the ISS field of the ESR. Once we process that we can
figure out what we need to do.

[AJB: the read/write stuff should probably go into a shared helper].

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/arm/kvm.c        | 95 +++++++++++++++++++++++++++++++++++++++++
 target/arm/trace-events |  2 +
 2 files changed, 97 insertions(+)

diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index f2255cfdc8..0a852af126 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -24,6 +24,7 @@
 #include "system/runstate.h"
 #include "system/kvm.h"
 #include "system/kvm_int.h"
+#include "cpregs.h"
 #include "kvm_arm.h"
 #include "cpu.h"
 #include "trace.h"
@@ -1414,6 +1415,98 @@ static bool kvm_arm_handle_debug(ARMCPU *cpu,
     return false;
 }
 
+/*
+ * To handle system register traps we should be able to extract the
+ * encoding from the ISS encoding and go from there.
+ */
+static int kvm_arm_handle_sysreg_trap(ARMCPU *cpu,
+                                      uint64_t esr_iss,
+                                      uint64_t elr)
+{
+    int op0 = extract32(esr_iss, 20, 2);
+    int op2 = extract32(esr_iss, 17, 3);
+    int op1 = extract32(esr_iss, 14, 3);
+    int crn = extract32(esr_iss, 10, 4);
+    int rt = extract32(esr_iss, 5, 5);
+    int crm = extract32(esr_iss, 1, 4);
+    bool is_read = extract32(esr_iss, 0, 1);
+
+    uint32_t key = ENCODE_AA64_CP_REG(CP_REG_ARM64_SYSREG_CP, crn, crm, op0, op1, op2);
+    const ARMCPRegInfo *ri = get_arm_cp_reginfo(cpu->cp_regs, key);
+
+    if (ri) {
+        CPUARMState *env = &cpu->env;
+        uint64_t val = 0;
+        bool take_bql = ri->type & ARM_CP_IO;
+
+        if (ri->accessfn) {
+            if (ri->accessfn(env, ri, true) != CP_ACCESS_OK) {
+                g_assert_not_reached();
+            }
+        }
+
+        if (take_bql) {
+            bql_lock();
+        }
+
+        if (is_read) {
+            if (ri->type & ARM_CP_CONST) {
+                val = ri->resetvalue;
+            } else if (ri->readfn) {
+                val = ri->readfn(env, ri);
+            } else {
+                val = CPREG_FIELD64(env, ri);
+            }
+            trace_kvm_sysreg_read(ri->name, val);
+
+            if (rt < 31) {
+                env->xregs[rt] = val;
+            } else {
+                /* this would be deeply weird */
+                g_assert_not_reached();
+            }
+        } else {
+            /* x31 == zero reg */
+            if (rt < 31) {
+                val = env->xregs[rt];
+            }
+
+            if (ri->writefn) {
+                ri->writefn(env, ri, val);
+            } else {
+                CPREG_FIELD64(env, ri) = val;
+            }
+            trace_kvm_sysreg_write(ri->name, val);
+        }
+
+        if (take_bql) {
+            bql_unlock();
+        }
+
+        /*
+         * Set PC to return.
+         *
+         * Note we elr_el2 doesn't seem to be what we need so lets
+         * rely on env->pc being correct.
+         *
+         * TODO We currently skip to the next instruction
+         * unconditionally but that is at odds with the kernels code
+         * which only does that conditionally (see kvm_handle_sys_reg
+         * -> perform_access):
+         *
+         *    if (likely(r->access(vcpu, params, r)))
+         *        kvm_incr_pc(vcpu);
+         *
+         */
+        env->pc = env->pc + 4;
+        return 0;
+    }
+
+    fprintf(stderr, "%s: @ %" PRIx64 " failed to find sysreg crn:%d crm:%d op0:%d op1:%d op2:%d\n",
+            __func__, elr, crn, crm, op0, op1, op2);
+    return -1;
+}
+
 /**
  * kvm_arm_handle_hard_trap:
  * @cpu: ARMCPU
@@ -1443,6 +1536,8 @@ static int kvm_arm_handle_hard_trap(ARMCPU *cpu,
     kvm_cpu_synchronize_state(cs);
 
     switch (esr_ec) {
+    case EC_SYSTEMREGISTERTRAP:
+        return kvm_arm_handle_sysreg_trap(cpu, esr_iss, elr);
     default:
         qemu_log_mask(LOG_UNIMP, "%s: unhandled EC: %x/%x/%x/%d\n",
                 __func__, esr_ec, esr_iss, esr_iss2, esr_il);
diff --git a/target/arm/trace-events b/target/arm/trace-events
index 4438dce7be..69bb4d370d 100644
--- a/target/arm/trace-events
+++ b/target/arm/trace-events
@@ -13,3 +13,5 @@ arm_gt_update_irq(int timer, int irqstate) "gt_update_irq: timer %d irqstate %d"
 
 # kvm.c
 kvm_arm_fixup_msi_route(uint64_t iova, uint64_t gpa) "MSI iova = 0x%"PRIx64" is translated into 0x%"PRIx64
+kvm_sysreg_read(const char *name, uint64_t val) "%s => 0x%" PRIx64
+kvm_sysreg_write(const char *name, uint64_t val) "%s <=  0x%" PRIx64
-- 
2.47.2


