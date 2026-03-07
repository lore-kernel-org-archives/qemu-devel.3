Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8312F513F1
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2026 15:02:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyt9Y-0005V9-EO; Sat, 07 Mar 2026 10:01:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vyt9W-0005SC-IX
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 10:01:14 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vyt9U-00055G-5j
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 10:01:14 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-48336a6e932so65994135e9.3
 for <qemu-devel@nongnu.org>; Sat, 07 Mar 2026 07:01:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772895666; x=1773500466; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Gcg/exchlRz2hW0LJ3FgJGNryHP56rv8IoAX8A7KL5Q=;
 b=O7LUmdVkFQFY9nAweepQvRnVAh2PUYPujDyf9F5zBFCO1bwTdrFo4lXewl8cv3lVaE
 Vq6Id+fJ2NzI/OJTODFj74aWIFHmQ9Z8iMkBeWJPDXTatR2IQqbez1TRyIydHzwIpSk4
 JGeC3TpHoDmxqu9SXD/MwQZWSiew7P7n7YoeKU499HeycgDZ4f65VfZUetU0IavVZ/Y3
 iEEs1LzTYQgowzlmebZSZmcGhhdZJqqPY4rOojb25PT2jjwqR00riqPOgNpdGyXuYTKh
 5Ooj5SOamE33rtrTQZwf3Xtn5Hxa8vnhaNx46JF6b+yG6Vn+F2rtDgZLN+yMAevcfuP8
 qdWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772895666; x=1773500466;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Gcg/exchlRz2hW0LJ3FgJGNryHP56rv8IoAX8A7KL5Q=;
 b=UXc/uFD0hmZwyOacGdUhIX0djffiSZhiUDD7JFeT3SUcmr7eTQc25IowhMkiN5zHub
 hf/gMJ8NO/7NzVYt+GegmHA0H4zxOEyxSoMU4Sw4pZf3moUcMIU20thCRN/B5owlev+q
 dL377aVXA+2H2wgoD32UFMXGtQlKY9EwciWUKnUm6Y29mfm8e5jqMu8E1TUmESBfkkCl
 qw3l0XSVYG2ygIkD/5LPzUsQvfmFRKXUUxzvL6DueM/3XGVBboOsGOBG6lVeiTx9utCX
 7nsgGJ/qt5x/VED23zjWYXu/Lhof2sAZe3V101XUopan92mJGb5Saf+UxXCw+vgcx2yv
 WfcQ==
X-Gm-Message-State: AOJu0YzIr7BnxepCUl9vw0SvH0ZSXzZgWoj16fT8z8xG9OZEMU7UQKZy
 Y5+5PXb5w9cGdOAGs7auVa70q04Gl+0NM6yDMgFrEIqprt4jAYdGucHSFLhdu5wDQcF8H+95DSG
 X93vw0fY=
X-Gm-Gg: ATEYQzyB+rPGrB4B0KnJ3O56aQ8Ngsrwt+kSoqNOwD5WGrQMr70YXMjWlK7xIOiKICV
 KcnPn3jCymwN8YDBkKF1Gzg6FHhyXQBHwr5jX5l9iKl7I3dCP2FEGcLRK7RS+OEITExS7HeZLEM
 hn24KQYVJjlq1oX+Qvl50LaEsiXx5Lgr4Hsu6vYR0T15321wi7jMa43vefvqP1LTmFzC8qWTeA0
 osTI+TA9xTclwz3XqJ7ea4TsmqZH5TnQfxrSreLmnlbSgFMC3atFGXXinoWlZUOSQkrBupVf1c1
 ewhuUjtQ8tDGGXcXOtrFaL8yBhT+KC+a03f2/63upRNXbfoCMXjfwqvuRTKrAmcXk/cffi41pqw
 Al3CgTBRr37h3lzw+6tjNyvmZk8M4znOsxzMqM4KMRuP0XPt6Y2BChHtNDwfoPW6lL4wnYYRRYN
 /46dhvckx2UCgdwDls+H9iBtS4hWxUPBsjo+8xQQIJkURgnN9fZMqzOd3QTX0z/+70Y18znP9YU
 qmVvCqv7r4=
X-Received: by 2002:a05:600c:8115:b0:477:a219:cdb7 with SMTP id
 5b1f17b1804b1-485268bd69fmr99358265e9.0.1772895665487; 
 Sat, 07 Mar 2026 07:01:05 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4851fa87e56sm190814005e9.0.2026.03.07.07.01.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 07 Mar 2026 07:01:04 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 kvm@vger.kernel.org
Subject: [PATCH 3/4] target/i386/kvm: Remove X86CPU::hyperv_synic_kvm_only
 field
Date: Sat,  7 Mar 2026 16:00:41 +0100
Message-ID: <20260307150042.78030-4-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260307150042.78030-1-philmd@linaro.org>
References: <20260307150042.78030-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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
2.52.0


