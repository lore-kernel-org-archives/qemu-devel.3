Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64A5EC54E64
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Mar 2024 14:17:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rol71-0007Aw-Gk; Mon, 25 Mar 2024 10:15:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rol5z-0005vb-0i
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 10:14:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rol5v-000636-5v
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 10:14:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711376074;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Zv7uoW8BcW2DUtPiB85YBCA8z40qzSGvlwy4r6AeK90=;
 b=Cqr/Lk4HEGOYxfL4wev2bPVQMYm2EG9jD//1gHlaZbUGerKi7meSpvnxgmNBksKPa5tx2c
 wfd93wdlRfA7BMkBxcAEXB4b/riog0uqfSpZF5fsg7XFiniultOnONBKObwpW78ipPgD8K
 igcxGZ/xJFxKG0hgCD1erea2ykInVkY=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-x2Z0TuwvPTy1ml0HyLBE4w-1; Mon, 25 Mar 2024 10:14:32 -0400
X-MC-Unique: x2Z0TuwvPTy1ml0HyLBE4w-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-515adcf2004so766047e87.2
 for <qemu-devel@nongnu.org>; Mon, 25 Mar 2024 07:14:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711376069; x=1711980869;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Zv7uoW8BcW2DUtPiB85YBCA8z40qzSGvlwy4r6AeK90=;
 b=kplgl1BOPj8n6CmK9eKAvpnCa5rxV4mCqJ6wiHxooJAPua3UYY4B70Gt6x240dQkfH
 AGU1L4S1TCjN9YT7Xlu3esk/VyeFJ2nIXh3iysDdqxmLsvqRb2GOiK5iHNcYvbdA/cq+
 0xbdzoa9Gkt7tLOuC5+bt1twUHGrucEwJdQDhg+rvwQPdHKoI3LT4X2QZg1ffJ4tFKUS
 UOJzHW+WN0CikY9zS4DnzulZqFog2VC1hyHZI4c8jm7BbPhdCLleXFTsYLJF3FNCNEz3
 FS8+AIPGPge2H+XOzRf93qV9rlxlZkrcnhYBBhq70WYpB5xnkEomIfxLqlWgBTyGMJIj
 1a9Q==
X-Gm-Message-State: AOJu0YzzaeXuRAcWbSSFHjtgnxPvDZatF0xQK94UZEietEts7YjJGvwt
 UnvECBR//ZRcnfkycejrSj4WfGT6eYgHDJhfATplBIquBia8xsIVPD+rpdf1N8GcFCIW9t4dB7n
 c9C8d8C9Z6NLOX1U1TDwklcpdr4z0XKWn5x7dOHggOjIgnjyL6RR7C699zgxPUvWBMiN6emRXtm
 TGlXZzrrDOgI49bK8kuOiQYB6hryaRPxlfgB7j
X-Received: by 2002:a19:9108:0:b0:515:8550:58c9 with SMTP id
 t8-20020a199108000000b00515855058c9mr5632580lfd.63.1711376069261; 
 Mon, 25 Mar 2024 07:14:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE1K2Gy9c3Ze3o23ubwmlygWg1Un6OMU1GF8QMuOlSaADdGdpJXZ6ru6SUO2X4wzbXJanzSYw==
X-Received: by 2002:a19:9108:0:b0:515:8550:58c9 with SMTP id
 t8-20020a199108000000b00515855058c9mr5632558lfd.63.1711376068956; 
 Mon, 25 Mar 2024 07:14:28 -0700 (PDT)
Received: from [192.168.10.118] ([151.95.49.219])
 by smtp.gmail.com with ESMTPSA id
 um8-20020a170906cf8800b00a4dac3d3a05sm173858ejb.111.2024.03.25.07.14.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Mar 2024 07:14:27 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
	Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PATCH for-9.1 v5 2/3] target/i386: add guest-phys-bits cpu property
Date: Mon, 25 Mar 2024 15:14:21 +0100
Message-ID: <20240325141422.1380087-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240325141422.1380087-1-pbonzini@redhat.com>
References: <20240325141422.1380087-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.065,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Gerd Hoffmann <kraxel@redhat.com>

Allows to set guest-phys-bits (cpuid leaf 80000008, eax[23:16])
via -cpu $model,guest-phys-bits=$nr.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20240318155336.156197-3-kraxel@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
v4->v5:
- move here all non-KVM parts
- add compat property and support for special value "-1" (accelerator
  defines value)

 target/i386/cpu.h |  1 +
 hw/i386/pc.c      |  4 +++-
 target/i386/cpu.c | 22 ++++++++++++++++++++++
 3 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 6b057380791..83e47358451 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2026,6 +2026,7 @@ struct ArchCPU {
 
     /* Number of physical address bits supported */
     uint32_t phys_bits;
+    uint32_t guest_phys_bits;
 
     /* in order to simplify APIC support, we leave this pointer to the
        user */
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 461fcaa1b48..9c4b3969cc8 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -78,7 +78,9 @@
     { "qemu64-" TYPE_X86_CPU, "model-id", "QEMU Virtual CPU version " v, },\
     { "athlon-" TYPE_X86_CPU, "model-id", "QEMU Virtual CPU version " v, },
 
-GlobalProperty pc_compat_9_0[] = {};
+GlobalProperty pc_compat_9_0[] = {
+    { TYPE_X86_CPU, "guest-phys-bits", "0" },
+};
 const size_t pc_compat_9_0_len = G_N_ELEMENTS(pc_compat_9_0);
 
 GlobalProperty pc_compat_8_2[] = {};
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 33760a2ee16..eef3d08473e 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -6570,6 +6570,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
         if (env->features[FEAT_8000_0001_EDX] & CPUID_EXT2_LM) {
             /* 64 bit processor */
              *eax |= (cpu_x86_virtual_addr_width(env) << 8);
+             *eax |= (cpu->guest_phys_bits << 16);
         }
         *ebx = env->features[FEAT_8000_0008_EBX];
         if (cs->nr_cores * cs->nr_threads > 1) {
@@ -7329,6 +7330,14 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
         goto out;
     }
 
+    if (cpu->guest_phys_bits == -1) {
+        /*
+         * If it was not set by the user, or by the accelerator via
+         * cpu_exec_realizefn, clear.
+         */
+        cpu->guest_phys_bits = 0;
+    }
+
     if (cpu->ucode_rev == 0) {
         /*
          * The default is the same as KVM's. Note that this check
@@ -7379,6 +7388,14 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
         if (cpu->phys_bits == 0) {
             cpu->phys_bits = TCG_PHYS_ADDR_BITS;
         }
+        if (cpu->guest_phys_bits &&
+            (cpu->guest_phys_bits > cpu->phys_bits ||
+            cpu->guest_phys_bits < 32)) {
+            error_setg(errp, "guest-phys-bits should be between 32 and %u "
+                             " (but is %u)",
+                             cpu->phys_bits, cpu->guest_phys_bits);
+            return;
+        }
     } else {
         /* For 32 bit systems don't use the user set value, but keep
          * phys_bits consistent with what we tell the guest.
@@ -7387,6 +7404,10 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
             error_setg(errp, "phys-bits is not user-configurable in 32 bit");
             return;
         }
+        if (cpu->guest_phys_bits != 0) {
+            error_setg(errp, "guest-phys-bits is not user-configurable in 32 bit");
+            return;
+        }
 
         if (env->features[FEAT_1_EDX] & (CPUID_PSE36 | CPUID_PAE)) {
             cpu->phys_bits = 36;
@@ -7887,6 +7908,7 @@ static Property x86_cpu_properties[] = {
     DEFINE_PROP_BOOL("x-force-features", X86CPU, force_features, false),
     DEFINE_PROP_BOOL("kvm", X86CPU, expose_kvm, true),
     DEFINE_PROP_UINT32("phys-bits", X86CPU, phys_bits, 0),
+    DEFINE_PROP_UINT32("guest-phys-bits", X86CPU, guest_phys_bits, -1),
     DEFINE_PROP_BOOL("host-phys-bits", X86CPU, host_phys_bits, false),
     DEFINE_PROP_UINT8("host-phys-bits-limit", X86CPU, host_phys_bits_limit, 0),
     DEFINE_PROP_BOOL("fill-mtrr-mask", X86CPU, fill_mtrr_mask, true),
-- 
2.44.0


