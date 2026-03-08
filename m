Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD4EFEA8546
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2026 22:35:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzMiD-0007fK-QB; Sun, 08 Mar 2026 18:35:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzMiC-0007et-3l
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 18:35:00 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzMiA-00034J-Ff
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 18:34:59 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-439cd6b0aedso3204339f8f.1
 for <qemu-devel@nongnu.org>; Sun, 08 Mar 2026 15:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773009297; x=1773614097; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=2eWZXbz4yjyxTABS3MihpjpSp6QDbbBisgS9JgOQq/Y=;
 b=NNNeIGfnFa3xT6qxI/X/sRBeuF3nV75wweRuQ/lwEONi95RW2zHiIZt9XKT/uYOCk5
 db/RBiM4+eiO7cpVSrl3cqCB2HSNzIZ4+P4Kp9wxHsQl/GSX55aODVDEohPKGSnYrKFj
 VpRSYiXjk3YtMrFC+eb9sNM7Af3HF0ZeGHWY9u98ZpuFoi6pUEsGQFRd80LhCAsRLfsV
 dwrCMYgY/0AJb/CxiAX95zMVc0Kg/S/y8j7LdrpYgtlIzx8T7AUPJ+sMB7Fz6FAiToY3
 DEBryB3blnt9+I69eP4j5QUSJ6CdrIXZou07g8E8q2V2IJDMrlcapbci0SiRFJD3YQnK
 KPTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773009297; x=1773614097;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=2eWZXbz4yjyxTABS3MihpjpSp6QDbbBisgS9JgOQq/Y=;
 b=vxdlgdhknlD7AjkkbUx0QDwoZrDmwcwpio9eV7RAQAFSYmliCD0okndSlr3546n+U9
 vb7b48ptlR0xIxWgQ0vRbyd1TojJaQTiVk9SUHEbZChxELPqQAMxenedgqYl2dvnsCtD
 biJ7db8LWIDWnkJncT6fa7lT/rMpwNLZYfvUG18Q97PisfwX/qmYPkQjvdFgnbZn7kQh
 1FYcK/V1/HBWLKRp5/DFLbZtA6BZl1ZjcR+w7vGnUr8i3navjh3RCmANcXEh0bcQr/lA
 FORC0FznPi6ot/bFHaNriU1adNOsGnehLPr0AEt5cu9a808IniE+xNFDyZop3MSbtOQj
 vrXg==
X-Gm-Message-State: AOJu0YwMMS6wVzHINRh2AuBi8KtFxHairT+sIkkvB3DE3egOjx14qQ52
 c3oHKCtcVK7V/wVJ2eJEMPsLSHHU4faHVTIHjM8RSGMtCv+byE03x231eExdxL663+PjCG0qKyj
 uu6NwNzM=
X-Gm-Gg: ATEYQzxJJ6sLXTJDfEiI47eDmUtF8ROODjSBO9UPRwH4o4J/P/I+oYlDfKb5bq6q/f5
 lmHH2d8Q5wpR3iiMQ7Akjk02v+uZRijgVmqAwZOMDRK9bh8FmQt5MWiyDPvtmGsG0+0DQIvlEEc
 nTIWhok1gYPhvqU38/r7UxVvxADAo1nBNSVuqXWD0ZrRrCsqHNPYYslnff+l7TaImXoXmGIQcfD
 JoKfBi/ds2eoyfkmqU6zbCC4ritXvuXOWN1oyJJgxkHhTchQkw0SBYQqCF+Ah3ET6XbI5iD6BaH
 PJKY2NVWgOdMBsIay9TRe1gzPGF57uE6jhggE7AIrgc18Qw7mgWrB58hDKfGQPGJkjp2cUQo5nh
 41/7wsnf0qVrOfvJCeUbcjvpflb0/8/kt2gFpkPJq1DP5KkXywtb7LdrxkAaWgi0so3046NpkcU
 QFhQZUOCZbOI6q2W8CBfEeEuta+GchGkv+z5G78jbOyPvEP7q6IVpe+CZkt9cKcTg6voqXEyrDW
 vDKCg==
X-Received: by 2002:a05:6000:1865:b0:437:8fd6:d849 with SMTP id
 ffacd0b85a97d-439da8a2ef3mr15383767f8f.54.1773009296475; 
 Sun, 08 Mar 2026 15:34:56 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439dae2b9fbsm21102875f8f.23.2026.03.08.15.34.54
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 08 Mar 2026 15:34:55 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 03/49] target/i386/kvm: Remove X86CPU::hyperv_synic_kvm_only
 field
Date: Sun,  8 Mar 2026 23:33:47 +0100
Message-ID: <20260308223433.25503-4-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260308223433.25503-1-philmd@linaro.org>
References: <20260308223433.25503-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

The X86CPU::hyperv_synic_kvm_only boolean (see commit 9b4cf107b09
"hyperv: only add SynIC in compatible configurations") was only set
in the pc_compat_3_0[] array, via the 'x-hv-synic-kvm-only=on'
property. We removed all machines using that array, lets remove that
property and all the code around it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20260307150042.78030-4-philmd@linaro.org>
---
 target/i386/cpu.h     |  1 -
 target/i386/cpu.c     |  2 --
 target/i386/kvm/kvm.c | 15 ++++-----------
 3 files changed, 4 insertions(+), 14 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index f2679cc5b72..2b70d56e9b0 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2335,7 +2335,6 @@ struct ArchCPU {
 
     uint32_t hyperv_spinlock_attempts;
     char *hyperv_vendor;
-    bool hyperv_synic_kvm_only;
     uint64_t hyperv_features;
     bool hyperv_passthrough;
     OnOffAuto hyperv_no_nonarch_cs;
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 01b64940b17..c77addd2c25 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -10589,8 +10589,6 @@ static const Property x86_cpu_properties[] = {
      * to the specific Windows version being used."
      */
     DEFINE_PROP_INT32("x-hv-max-vps", X86CPU, hv_max_vps, -1),
-    DEFINE_PROP_BOOL("x-hv-synic-kvm-only", X86CPU, hyperv_synic_kvm_only,
-                     false),
     DEFINE_PROP_BOOL("x-intel-pt-auto-level", X86CPU, intel_pt_auto_level,
                      true),
     DEFINE_PROP_BOOL("x-l1-cache-per-thread", X86CPU, l1_cache_per_core, true),
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 27b1b848d6a..a29f757c168 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -1278,10 +1278,7 @@ static struct kvm_cpuid2 *get_supported_hv_cpuid_legacy(CPUState *cs)
     }
 
     if (has_msr_hv_synic) {
-        unsigned int cap = cpu->hyperv_synic_kvm_only ?
-            KVM_CAP_HYPERV_SYNIC : KVM_CAP_HYPERV_SYNIC2;
-
-        if (kvm_check_extension(cs->kvm_state, cap) > 0) {
+        if (kvm_check_extension(cs->kvm_state, KVM_CAP_HYPERV_SYNIC2) > 0) {
             entry_feat->eax |= HV_SYNIC_AVAILABLE;
         }
     }
@@ -1543,7 +1540,6 @@ bool kvm_hyperv_expand_features(X86CPU *cpu, Error **errp)
 
     /* Additional dependencies not covered by kvm_hyperv_properties[] */
     if (hyperv_feat_enabled(cpu, HYPERV_FEAT_SYNIC) &&
-        !cpu->hyperv_synic_kvm_only &&
         !hyperv_feat_enabled(cpu, HYPERV_FEAT_VPINDEX)) {
         error_setg(errp, "Hyper-V %s requires Hyper-V %s",
                    kvm_hyperv_properties[HYPERV_FEAT_SYNIC].desc,
@@ -1608,8 +1604,7 @@ static int hyperv_fill_cpuids(CPUState *cs,
     c->eax |= HV_HYPERCALL_AVAILABLE;
 
     /* SynIC and Vmbus devices require messages/signals hypercalls */
-    if (hyperv_feat_enabled(cpu, HYPERV_FEAT_SYNIC) &&
-        !cpu->hyperv_synic_kvm_only) {
+    if (hyperv_feat_enabled(cpu, HYPERV_FEAT_SYNIC)) {
         c->ebx |= HV_POST_MESSAGES | HV_SIGNAL_EVENTS;
     }
 
@@ -1752,16 +1747,14 @@ static int hyperv_init_vcpu(X86CPU *cpu)
     }
 
     if (hyperv_feat_enabled(cpu, HYPERV_FEAT_SYNIC)) {
-        uint32_t synic_cap = cpu->hyperv_synic_kvm_only ?
-            KVM_CAP_HYPERV_SYNIC : KVM_CAP_HYPERV_SYNIC2;
-        ret = kvm_vcpu_enable_cap(cs, synic_cap, 0);
+        ret = kvm_vcpu_enable_cap(cs, KVM_CAP_HYPERV_SYNIC2, 0);
         if (ret < 0) {
             error_report("failed to turn on HyperV SynIC in KVM: %s",
                          strerror(-ret));
             return ret;
         }
 
-        if (!cpu->hyperv_synic_kvm_only && !hyperv_is_synic_enabled()) {
+        if (!hyperv_is_synic_enabled()) {
             ret = hyperv_x86_synic_add(cpu);
             if (ret < 0) {
                 error_report("failed to create HyperV SynIC: %s",
-- 
2.53.0


