Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D04EC83F1B
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 11:13:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubH6X-0007XK-F6; Mon, 14 Jul 2025 07:12:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ubGz6-0000bn-BG
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 07:04:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ubGz2-0001Xx-HR
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 07:04:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752491071;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hCVHCI24r7fBMBEIXiJinu8XMfmmZF1IzGCvCSdEy6k=;
 b=WM/5p36stv2m4IhmvEEus+IeX7sCHb4Njaqvn1vpbHWXcnRlQEja8hc9m7gQDhKgnlHY1M
 Ay7x/hR7MHT0lKw3IQ4PVZbyy/eiyDLMv63utQKjRaG44L/aU/epq6PI43NnstQPPLicr6
 aan6s8kEAQmhPXwHYCSZN/gYbLd3nQU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-389-zWg07cboOXWk8X5a-eBUWQ-1; Mon, 14 Jul 2025 07:04:30 -0400
X-MC-Unique: zWg07cboOXWk8X5a-eBUWQ-1
X-Mimecast-MFC-AGG-ID: zWg07cboOXWk8X5a-eBUWQ_1752491069
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3a5058f9ef4so1738564f8f.2
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 04:04:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752491069; x=1753095869;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hCVHCI24r7fBMBEIXiJinu8XMfmmZF1IzGCvCSdEy6k=;
 b=AVQBAsK1bMbE1mhELZ1CzDxSMR11hb3kf92ld91xkLKxji/1HMa3e+LITPKTGs42Qz
 o5O+l8up7WRH4e53hAuBc/rYKJexDIk0xdhgwcCvkiEgheCNYi0DCX7k775AQiBNAmSa
 IO69wLsv3IMjphMxbuhw8/Eakzb+IpMjqAvL1dNZeN5/Sg1ItIATBAwq8p07ItG9DXCa
 HJ0u2EFw28mHPygAxNPIn51vrKvUcfTvx9VrC1jtPAxOkFFXjhJWHLHNaFZaDxzmj6Zk
 OE80V95RsUH9UsRqPxQV0a6ASAHMCr+YFq3hMnQktrQBitS6jOZ91kE6emrLZTZHz1Pu
 qMvw==
X-Gm-Message-State: AOJu0YyvX8EDPkfOM0Y+bkRSYGDNqS2iwHGgvuGQIbpoVwp1HHz9sBzg
 +B/ludvWL9wDMgyIaEfX208Fwma1JVHDP6qujNLh835xgJy1qLE5OFNsfaJCqokrw0oRdtsRJXg
 p0vu7PsZLTlVunUOv5A8UI6c73KtkFSg/falaGAraDCQl3NqsKnuwDt7EbVE+EzYv2OsgP4CVCj
 /qxJbh6t61XvtGIJ7UiT2iLZDhOlySZ08AYdmsY0cT
X-Gm-Gg: ASbGnct93Di08g5//FOPBu9ep+ryrsWBZ03wQaKDRsAi0zfn2IDkSn8+WnDZovrxx31
 BI6GAmJuSvzzr2fa+mYYm8jgJ+EIyPTybrRRgIlhR5vg9LSlcH+vkq3RKQ5OLmh+dCstF5j1/3L
 XsA5L1GSABu8K/c7vgmkZOSaHDtDqM4UjfW8sn7vEoB4E3+TnBlrTBSMHH6s7vQ+DK/0iDETjZa
 Wnqc/2AB8h2Z3SsqHephXEbuWylrs/zNbrK4EyBws5RdW4fg4/STJlQkAFvngCbWpCmjBKwMPg4
 JdPU21iCfC1995a86kSfkNsxKq2YqaaLVMXWDJsr7SE=
X-Received: by 2002:a05:6000:4310:b0:3b3:a6c2:1a10 with SMTP id
 ffacd0b85a97d-3b5f351eb04mr9261869f8f.12.1752491068660; 
 Mon, 14 Jul 2025 04:04:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF8qBmASoRtbGGlek/AkqVmkwOsFPxJLjOTn+ZdCoWlqVIc1BAPJGvHrLizNX/jTjhEGQowAA==
X-Received: by 2002:a05:6000:4310:b0:3b3:a6c2:1a10 with SMTP id
 ffacd0b85a97d-3b5f351eb04mr9261827f8f.12.1752491068056; 
 Mon, 14 Jul 2025 04:04:28 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.73.155])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8e0d719sm12234549f8f.54.2025.07.14.04.04.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 04:04:25 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Xiaoyao Li <xiaoyao.li@intel.com>,
	Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 07/77] target/i386: move max_features to class
Date: Mon, 14 Jul 2025 13:02:56 +0200
Message-ID: <20250714110406.117772-8-pbonzini@redhat.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250714110406.117772-1-pbonzini@redhat.com>
References: <20250714110406.117772-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

max_features is always set to true for instances created by -cpu max or
-cpu host; it's always false for other classes.  Therefore it can be
turned into a field in the X86CPUClass.

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.h         | 2 +-
 target/i386/cpu.c         | 7 ++++---
 target/i386/hvf/hvf-cpu.c | 3 ++-
 target/i386/kvm/kvm-cpu.c | 5 +++--
 4 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 51e10139dfd..be3ae6d546e 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2196,7 +2196,6 @@ struct ArchCPU {
     bool expose_tcg;
     bool migratable;
     bool migrate_smi_count;
-    bool max_features; /* Enable all supported features automatically */
     uint32_t apic_id;
 
     /* Enables publishing of TSC increment and Local APIC bus frequencies to
@@ -2349,6 +2348,7 @@ struct X86CPUClass {
      */
     const X86CPUModel *model;
 
+    bool max_features; /* Enable all supported features automatically */
     bool host_cpuid_required;
     int ordering;
     bool migration_safe;
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 0d35e95430f..4d4e5234246 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -6187,6 +6187,7 @@ static void max_x86_cpu_class_init(ObjectClass *oc, const void *data)
 
     xcc->ordering = 9;
 
+    xcc->max_features = true;
     xcc->model_description =
         "Enables all features supported by the accelerator in the current host";
 
@@ -6201,7 +6202,6 @@ static void max_x86_cpu_initfn(Object *obj)
     /* We can't fill the features array here because we don't know yet if
      * "migratable" is true or false.
      */
-    cpu->max_features = true;
     object_property_set_bool(OBJECT(cpu), "pmu", true, &error_abort);
 
     /*
@@ -8282,6 +8282,7 @@ static void x86_cpu_enable_xsave_components(X86CPU *cpu)
  */
 void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
 {
+    X86CPUClass *xcc = X86_CPU_GET_CLASS(cpu);
     CPUX86State *env = &cpu->env;
     FeatureWord w;
     int i;
@@ -8301,12 +8302,12 @@ void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
         }
     }
 
-    /*TODO: Now cpu->max_features doesn't overwrite features
+    /* TODO: Now xcc->max_features doesn't overwrite features
      * set using QOM properties, and we can convert
      * plus_features & minus_features to global properties
      * inside x86_cpu_parse_featurestr() too.
      */
-    if (cpu->max_features) {
+    if (xcc->max_features) {
         for (w = 0; w < FEATURE_WORDS; w++) {
             /* Override only features that weren't set explicitly
              * by the user.
diff --git a/target/i386/hvf/hvf-cpu.c b/target/i386/hvf/hvf-cpu.c
index dfdda701268..2b991f2fc8e 100644
--- a/target/i386/hvf/hvf-cpu.c
+++ b/target/i386/hvf/hvf-cpu.c
@@ -61,13 +61,14 @@ static void hvf_cpu_xsave_init(void)
 static void hvf_cpu_instance_init(CPUState *cs)
 {
     X86CPU *cpu = X86_CPU(cs);
+    X86CPUClass *xcc = X86_CPU_GET_CLASS(cpu);
 
     host_cpu_instance_init(cpu);
 
     /* Special cases not set in the X86CPUDefinition structs: */
     /* TODO: in-kernel irqchip for hvf */
 
-    if (cpu->max_features) {
+    if (xcc->max_features) {
         hvf_cpu_max_instance_init(cpu);
     }
 
diff --git a/target/i386/kvm/kvm-cpu.c b/target/i386/kvm/kvm-cpu.c
index 16bde4de01e..0fb88a239d4 100644
--- a/target/i386/kvm/kvm-cpu.c
+++ b/target/i386/kvm/kvm-cpu.c
@@ -41,6 +41,7 @@ static void kvm_set_guest_phys_bits(CPUState *cs)
 static bool kvm_cpu_realizefn(CPUState *cs, Error **errp)
 {
     X86CPU *cpu = X86_CPU(cs);
+    X86CPUClass *xcc = X86_CPU_GET_CLASS(cpu);
     CPUX86State *env = &cpu->env;
     bool ret;
 
@@ -63,7 +64,7 @@ static bool kvm_cpu_realizefn(CPUState *cs, Error **errp)
      *   check/update ucode_rev, phys_bits, guest_phys_bits, mwait
      *   cpu_common_realizefn() (via xcc->parent_realize)
      */
-    if (cpu->max_features) {
+    if (xcc->max_features) {
         if (enable_cpu_pm) {
             if (kvm_has_waitpkg()) {
                 env->features[FEAT_7_0_ECX] |= CPUID_7_0_ECX_WAITPKG;
@@ -216,7 +217,7 @@ static void kvm_cpu_instance_init(CPUState *cs)
         x86_cpu_apply_props(cpu, kvm_default_props);
     }
 
-    if (cpu->max_features) {
+    if (xcc->max_features) {
         kvm_cpu_max_instance_init(cpu);
     }
 
-- 
2.50.0


