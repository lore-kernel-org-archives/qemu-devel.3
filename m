Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47D17C54798
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 22:25:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rf5sD-0006tI-1a; Tue, 27 Feb 2024 17:24:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3FGHeZQcKCoUtxvuxmrpxxpun.lxvznv3-mn4nuwxwpw3.x0p@flex--komlodi.bounces.google.com>)
 id 1rf5sB-0006sn-Cb
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 17:24:27 -0500
Received: from mail-pg1-x54a.google.com ([2607:f8b0:4864:20::54a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3FGHeZQcKCoUtxvuxmrpxxpun.lxvznv3-mn4nuwxwpw3.x0p@flex--komlodi.bounces.google.com>)
 id 1rf5s7-0008Hw-4M
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 17:24:27 -0500
Received: by mail-pg1-x54a.google.com with SMTP id
 41be03b00d2f7-5c66a69ec8eso3696651a12.3
 for <qemu-devel@nongnu.org>; Tue, 27 Feb 2024 14:24:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1709072661; x=1709677461; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=+xSYC9woE8ejU2ZMzJv9wgrGS4seNQMp4/9INbjIsDE=;
 b=34sq/53O+T8R2ea8sr7D5zNezT7xqN5PqIxcLHDNhMwn/1Va71noEvGUOjJc3TtMwV
 4EUQ0/Kvk34xQ93pOXakuFRFAJIG8+bbtjxIDNLd9gz+T8OKVX/zqE2MyI9O80dxeOuX
 gMQyfNDHPoIGOVE/AhwDMOeHoggQOdIeIK2bsZuOj0dLMDaYWJuK4lPhWkZH5h0TtiNz
 eom0Hafi5y15BAeQEnbKJ5xGHvRcRhjIhgvU+KyB/HnBr9djW4lyPDP6egTF7K5X2S3k
 awW4wnFEe5yAZumgFJBznhom/ss3lEpa/eQvtfe5vByOAG4hR8N+wg+fGy0CUMl4NrhF
 4IYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709072661; x=1709677461;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+xSYC9woE8ejU2ZMzJv9wgrGS4seNQMp4/9INbjIsDE=;
 b=o/zW02DTaQe+JZxamPhiIxjZH5lH3IlxnhV370nyGhq4ojU9MTW/mPyv3OcHHRMOxr
 /+aY4AaYqoh8K80oqUdDeb/xYKcf4VB+BG3v3QRB2q/njQqy5QQNYh8+nclWQPG4qSw6
 bvyMxBu/DaqywkUF0Nvj5TjhyRBGm3LcCGl0N65Mp/XbswJ6UPv6jb0Ob567ems24aCN
 zlaQBc1rAcWs7mY3Y+7ucS71OyiuegZfuRlKX1+A3aU34SrmRjguJ+uT2CCJrkSQKknF
 RjUw7TR8X65gmHbwMJT8BV5/qVMWwR7qAkzp4dx/PXoFEjkaRc5lv9MdXlR8Q98v/nuR
 QXQA==
X-Gm-Message-State: AOJu0YwOAwpjS32uX6OJgSTAyGkLBQ5EiZqVdPkeVFwVLNUTP6aR7NNm
 sVk1Y7GZekbkq9ePMFRbECuwAbWmrWdA3y7bFXipW2+oEgOAKjuxbu9UomrTrqG/URf/NSwdxrq
 zc+GCtkRCPME8DPMjhYObAMtLld/Kz2JYfd13qu4ovc5IMyztBkr+0rkVD4G4wiwj9yZF+3Me6+
 UDMQLXrNYfixA1oX3JzW1nS/zE7xN8+KQJYbUk
X-Google-Smtp-Source: AGHT+IHsEXKg30e7rEt6uzwaJM+AGs9+9OuSrjMAijwMmYmczmtWBV0xD9Cmg+Y0rhupt3k7vwf5BVqU9ITM
X-Received: from komlodi.c.googlers.com
 ([fda3:e722:ac3:cc00:7f:e700:c0a8:35ee])
 (user=komlodi job=sendgmr) by 2002:a65:6753:0:b0:5ce:6c6:6973 with SMTP id
 c19-20020a656753000000b005ce06c66973mr49128pgu.8.1709072660644; Tue, 27 Feb
 2024 14:24:20 -0800 (PST)
Date: Tue, 27 Feb 2024 22:24:13 +0000
In-Reply-To: <20240227222417.929367-1-komlodi@google.com>
Mime-Version: 1.0
References: <20240227222417.929367-1-komlodi@google.com>
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
Message-ID: <20240227222417.929367-2-komlodi@google.com>
Subject: [RFC PATCH 1/5] target/arm: Add requester ID to memattrs
From: Joe Komlodi <komlodi@google.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, peterx@redhat.com, david@redhat.com, 
 peter.maydell@linaro.org, marcel.apfelbaum@gmail.com, mst@redhat.com, 
 philmd@linaro.org, roqueh@google.com, slongfield@google.com, 
 komlodi@google.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::54a;
 envelope-from=3FGHeZQcKCoUtxvuxmrpxxpun.lxvznv3-mn4nuwxwpw3.x0p@flex--komlodi.bounces.google.com;
 helo=mail-pg1-x54a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

I've seen a few different instances where a CPU or a memory region is
behind some sort of IOMMU, and the IOMMU translates (or denies) accesses
based on the requester ID of the CPU.

This patch only does it on ARM CPUs, because I did not see CPU-agnostic
code that added CPU attributes when creating TLBs. Similarly, we add the
requester ID during PTW, while populating the rest of the memory
attributes.

We add the requester ID during GPC and descriptor grabbing as well as
PTWs.

Signed-off-by: Joe Komlodi <komlodi@google.com>
---
 target/arm/cpu.c | 4 ++++
 target/arm/cpu.h | 6 ++++++
 target/arm/ptw.c | 5 +++++
 3 files changed, 15 insertions(+)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 5fa86bc8d5..9cfbba10c2 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2402,6 +2402,9 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
         }
     }
 
+    /* For MemTxAttrs. */
+    env->requester_id = cpu->requester_id;
+
     qemu_init_vcpu(cs);
     cpu_reset(cs);
 
@@ -2439,6 +2442,7 @@ static Property arm_cpu_properties[] = {
                         mp_affinity, ARM64_AFFINITY_INVALID),
     DEFINE_PROP_INT32("node-id", ARMCPU, node_id, CPU_UNSET_NUMA_NODE_ID),
     DEFINE_PROP_INT32("core-count", ARMCPU, core_count, -1),
+    DEFINE_PROP_UINT16("requester-id", ARMCPU, requester_id, 0),
     DEFINE_PROP_END_OF_LIST()
 };
 
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 63f31e0d98..5fc572e077 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -774,6 +774,9 @@ typedef struct CPUArchState {
     /* Linux syscall tagged address support */
     bool tagged_addr_enable;
 #endif
+
+    /* For MemTxAttrs. */
+    uint16_t requester_id;
 } CPUARMState;
 
 static inline void set_feature(CPUARMState *env, int feature)
@@ -1091,6 +1094,9 @@ struct ArchCPU {
 
     /* Generic timer counter frequency, in Hz */
     uint64_t gt_cntfrq_hz;
+
+    /* Requester ID, used in MemTxAttrs. */
+    uint16_t requester_id;
 };
 
 typedef struct ARMCPUInfo {
diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 5eb3577bcd..148af3a000 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -287,6 +287,7 @@ static bool granule_protection_check(CPUARMState *env, uint64_t paddress,
     MemTxAttrs attrs = {
         .secure = true,
         .space = ARMSS_Root,
+        .requester_id = env->requester_id,
     };
     ARMCPU *cpu = env_archcpu(env);
     uint64_t gpccr = env->cp15.gpccr_el3;
@@ -638,6 +639,7 @@ static uint32_t arm_ldl_ptw(CPUARMState *env, S1Translate *ptw,
         MemTxAttrs attrs = {
             .space = ptw->out_space,
             .secure = arm_space_is_secure(ptw->out_space),
+            .requester_id = env->requester_id,
         };
         AddressSpace *as = arm_addressspace(cs, attrs);
         MemTxResult result = MEMTX_OK;
@@ -684,6 +686,7 @@ static uint64_t arm_ldq_ptw(CPUARMState *env, S1Translate *ptw,
         MemTxAttrs attrs = {
             .space = ptw->out_space,
             .secure = arm_space_is_secure(ptw->out_space),
+            .requester_id = env->requester_id,
         };
         AddressSpace *as = arm_addressspace(cs, attrs);
         MemTxResult result = MEMTX_OK;
@@ -3306,6 +3309,8 @@ static bool get_phys_addr_nogpc(CPUARMState *env, S1Translate *ptw,
     result->f.attrs.space = ptw->in_space;
     result->f.attrs.secure = arm_space_is_secure(ptw->in_space);
 
+    result->f.attrs.requester_id = env->requester_id;
+
     switch (mmu_idx) {
     case ARMMMUIdx_Phys_S:
     case ARMMMUIdx_Phys_NS:
-- 
2.44.0.rc0.258.g7320e95886-goog


