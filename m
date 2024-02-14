Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 704A1C48BEB
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Feb 2024 11:17:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raDDU-0000Uu-P7; Wed, 14 Feb 2024 06:14:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1raDDQ-0000DP-HD
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 06:14:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1raDDL-0006nO-S5
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 06:14:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707909246;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=c1T4mZW1Lt2fEcvTpJpGMJKvoac/0r1T6DraMR3Q2iM=;
 b=Z0S/q/Hkq2hpqo+Ygzs19Z1NaYy7ISdPxio7KCmGppHj8+qybZ0NFYXH2aKKxRa629oTxC
 XZnUDCukMDBA4QXy2gtYPFonultbGhHPGpI8SI789gTm/PVqMUdAT42aJEYWoIQeGoQm5J
 VPwxSorK6tvFSRqplKOr4YTafjolMAc=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-227-20oApC2QO0CIxgHAOR4oSg-1; Wed, 14 Feb 2024 06:14:05 -0500
X-MC-Unique: 20oApC2QO0CIxgHAOR4oSg-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a3bdd99a243so68558766b.0
 for <qemu-devel@nongnu.org>; Wed, 14 Feb 2024 03:14:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707909243; x=1708514043;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c1T4mZW1Lt2fEcvTpJpGMJKvoac/0r1T6DraMR3Q2iM=;
 b=LuCvKQWhA0bHQg/KPntW96TxkQLQOYgOeX72iOZ2ZR9WgNhOUBa5k+len2YHuQxj2/
 L1XBHsHZvy3Deo73q4yBXLzzAMW6k/prwxaW7EFrHFiYnRZslQXEaSOc2qFyL789//Xf
 QnFu9PHMxsmLcB2us1rquFcaCLbWfUgvAKUFqsRPSXz7K5rKhIds+NwQQaDHOpcclDJF
 hX0sJGGY1E42K7aIyopGOspp3MsIylZnP5XtPtkeMo/dDU86ZvhcdKAqd7vgzIwefo/N
 BfOhmQ354U0jJ0wd+aylc+Z46f+68qValpIMOECWbu2/Fu6zfNSpNmRyhN56sV182eNn
 4Ojg==
X-Gm-Message-State: AOJu0Yx9N6MpYHlDhvjQvUITkYEvalyr3lSwFoRHydn6rnWSE+vZnrtZ
 V7824wZ/6cQK0xrqoKj2cGSAGKEaKJb7R8l2FNaywLOuZl14q4ILRTYt70mlLPDqZtPiSh0YJPF
 Niz9ZRnv3QgHKNWUTkTO/Ekvaa4VEb88KfhxJRS14MtOy2xJWiTyLcA536xkRA4hjQM4K2AqNJk
 VYtOjwMMOaArNfZRb6LQTq3NuY/iUuHg==
X-Received: by 2002:a17:906:aacb:b0:a3c:d0d0:4602 with SMTP id
 kt11-20020a170906aacb00b00a3cd0d04602mr1474615ejb.6.1707909243514; 
 Wed, 14 Feb 2024 03:14:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH8PGa8fe+YzlQNsaQxLZwEWdxHc893kIKDULDI4XVDmy08H/IvVqWGbByMSYsf44RIBF6RxQ==
X-Received: by 2002:a17:906:aacb:b0:a3c:d0d0:4602 with SMTP id
 kt11-20020a170906aacb00b00a3cd0d04602mr1474559ejb.6.1707909242253; 
 Wed, 14 Feb 2024 03:14:02 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCXzRh2VKZgo8A+woJ9nPu2okdk+XErDylKqAwVKf+sraUsUJAczLmragZ3ncuj+Z6gPCv/6xLKry8uh0vcpB7oLoDWlHlKxDV1VU2kqdG7uW+KLSabxeWUYT0SJzIB8y5XTgOIhWIJoZyEJWTP7pIVzIPL9arbFi8oUEQJWNIwMy37kApC/rRlAPXUHbU75UO8npXBekk5cXAm+Zo7QQfoKktb99+icWJ8zFp6+HqJcuTP6Z95etyaO2pW2Hlji3fBUmakvB0UwdaD9NzPFIOknAMjRD/w9UM2GtuI+bD0a+H3DWT3O9EuqWWeL9phyZZ4edKF2UUA2k46f1aQhrj08zjpcdxPAXKMBomkkOgSwmAl40S95V6ImclLcuJ6meqzuR+YL2w==
Received: from redhat.com ([2.52.26.67]) by smtp.gmail.com with ESMTPSA id
 gv24-20020a170906f11800b00a3bd8a34b1bsm2212432ejb.164.2024.02.14.03.13.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Feb 2024 03:14:00 -0800 (PST)
Date: Wed, 14 Feb 2024 06:13:57 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Bui Quang Minh <minhquangbui99@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>,
 Sunil Muthuswamy <sunilmut@microsoft.com>, xen-devel@lists.xenproject.org
Subject: [PULL 14/60] apic, i386/tcg: add x2apic transitions
Message-ID: <774204cf9874e58dc7fc13394a505452357750ad.1707909001.git.mst@redhat.com>
References: <cover.1707909001.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1707909001.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.504,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Bui Quang Minh <minhquangbui99@gmail.com>

This commit adds support for x2APIC transitions when writing to
MSR_IA32_APICBASE register and finally adds CPUID_EXT_X2APIC to
TCG_EXT_FEATURES.

The set_base in APICCommonClass now returns an integer to indicate error in
execution. apic_set_base return -1 on invalid APIC state transition,
accelerator can use this to raise appropriate exception.

Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
Message-Id: <20240111154404.5333-4-minhquangbui99@gmail.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/i386/apic.h               |  2 +-
 include/hw/i386/apic_internal.h      |  2 +-
 target/i386/cpu.h                    |  4 ++
 hw/i386/kvm/apic.c                   |  3 +-
 hw/i386/xen/xen_apic.c               |  3 +-
 hw/intc/apic.c                       | 62 +++++++++++++++++++++++++++-
 hw/intc/apic_common.c                | 13 +++---
 target/i386/cpu.c                    |  9 ++--
 target/i386/tcg/sysemu/misc_helper.c | 14 ++++++-
 target/i386/whpx/whpx-apic.c         |  3 +-
 10 files changed, 96 insertions(+), 19 deletions(-)

diff --git a/include/hw/i386/apic.h b/include/hw/i386/apic.h
index c8ca41ab44..f6e7489f2d 100644
--- a/include/hw/i386/apic.h
+++ b/include/hw/i386/apic.h
@@ -8,7 +8,7 @@ int apic_accept_pic_intr(DeviceState *s);
 void apic_deliver_pic_intr(DeviceState *s, int level);
 void apic_deliver_nmi(DeviceState *d);
 int apic_get_interrupt(DeviceState *s);
-void cpu_set_apic_base(DeviceState *s, uint64_t val);
+int cpu_set_apic_base(DeviceState *s, uint64_t val);
 uint64_t cpu_get_apic_base(DeviceState *s);
 void cpu_set_apic_tpr(DeviceState *s, uint8_t val);
 uint8_t cpu_get_apic_tpr(DeviceState *s);
diff --git a/include/hw/i386/apic_internal.h b/include/hw/i386/apic_internal.h
index e796e6cae3..d6e85833da 100644
--- a/include/hw/i386/apic_internal.h
+++ b/include/hw/i386/apic_internal.h
@@ -137,7 +137,7 @@ struct APICCommonClass {
 
     DeviceRealize realize;
     DeviceUnrealize unrealize;
-    void (*set_base)(APICCommonState *s, uint64_t val);
+    int (*set_base)(APICCommonState *s, uint64_t val);
     void (*set_tpr)(APICCommonState *s, uint8_t val);
     uint8_t (*get_tpr)(APICCommonState *s);
     void (*enable_tpr_reporting)(APICCommonState *s, bool enable);
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 08eaa61c56..dfe43b8204 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -379,6 +379,10 @@ typedef enum X86Seg {
 #define MSR_IA32_APICBASE_ENABLE        (1<<11)
 #define MSR_IA32_APICBASE_EXTD          (1 << 10)
 #define MSR_IA32_APICBASE_BASE          (0xfffffU<<12)
+#define MSR_IA32_APICBASE_RESERVED \
+        (~(uint64_t)(MSR_IA32_APICBASE_BSP | MSR_IA32_APICBASE_ENABLE \
+                     | MSR_IA32_APICBASE_EXTD | MSR_IA32_APICBASE_BASE))
+
 #define MSR_IA32_FEATURE_CONTROL        0x0000003a
 #define MSR_TSC_ADJUST                  0x0000003b
 #define MSR_IA32_SPEC_CTRL              0x48
diff --git a/hw/i386/kvm/apic.c b/hw/i386/kvm/apic.c
index 1e89ca0899..a72c28e8a7 100644
--- a/hw/i386/kvm/apic.c
+++ b/hw/i386/kvm/apic.c
@@ -95,9 +95,10 @@ void kvm_get_apic_state(DeviceState *dev, struct kvm_lapic_state *kapic)
     apic_next_timer(s, s->initial_count_load_time);
 }
 
-static void kvm_apic_set_base(APICCommonState *s, uint64_t val)
+static int kvm_apic_set_base(APICCommonState *s, uint64_t val)
 {
     s->apicbase = val;
+    return 0;
 }
 
 static void kvm_apic_set_tpr(APICCommonState *s, uint8_t val)
diff --git a/hw/i386/xen/xen_apic.c b/hw/i386/xen/xen_apic.c
index 7c7a60b166..101e16a766 100644
--- a/hw/i386/xen/xen_apic.c
+++ b/hw/i386/xen/xen_apic.c
@@ -49,8 +49,9 @@ static void xen_apic_realize(DeviceState *dev, Error **errp)
     msi_nonbroken = true;
 }
 
-static void xen_apic_set_base(APICCommonState *s, uint64_t val)
+static int xen_apic_set_base(APICCommonState *s, uint64_t val)
 {
+    return 0;
 }
 
 static void xen_apic_set_tpr(APICCommonState *s, uint8_t val)
diff --git a/hw/intc/apic.c b/hw/intc/apic.c
index 178fb26b47..1d887d66b8 100644
--- a/hw/intc/apic.c
+++ b/hw/intc/apic.c
@@ -308,8 +308,49 @@ bool is_x2apic_mode(DeviceState *dev)
     return s->apicbase & MSR_IA32_APICBASE_EXTD;
 }
 
-static void apic_set_base(APICCommonState *s, uint64_t val)
+static int apic_set_base_check(APICCommonState *s, uint64_t val)
 {
+    /* Enable x2apic when x2apic is not supported by CPU */
+    if (!cpu_has_x2apic_feature(&s->cpu->env) &&
+        val & MSR_IA32_APICBASE_EXTD) {
+        return -1;
+    }
+
+    /*
+     * Transition into invalid state
+     * (s->apicbase & MSR_IA32_APICBASE_ENABLE == 0) &&
+     * (s->apicbase & MSR_IA32_APICBASE_EXTD) == 1
+     */
+    if (!(val & MSR_IA32_APICBASE_ENABLE) &&
+        (val & MSR_IA32_APICBASE_EXTD)) {
+        return -1;
+    }
+
+    /* Invalid transition from disabled mode to x2APIC */
+    if (!(s->apicbase & MSR_IA32_APICBASE_ENABLE) &&
+        !(s->apicbase & MSR_IA32_APICBASE_EXTD) &&
+        (val & MSR_IA32_APICBASE_ENABLE) &&
+        (val & MSR_IA32_APICBASE_EXTD)) {
+        return -1;
+    }
+
+    /* Invalid transition from x2APIC to xAPIC */
+    if ((s->apicbase & MSR_IA32_APICBASE_ENABLE) &&
+        (s->apicbase & MSR_IA32_APICBASE_EXTD) &&
+        (val & MSR_IA32_APICBASE_ENABLE) &&
+        !(val & MSR_IA32_APICBASE_EXTD)) {
+        return -1;
+    }
+
+    return 0;
+}
+
+static int apic_set_base(APICCommonState *s, uint64_t val)
+{
+    if (apic_set_base_check(s, val) < 0) {
+        return -1;
+    }
+
     s->apicbase = (val & 0xfffff000) |
         (s->apicbase & (MSR_IA32_APICBASE_BSP | MSR_IA32_APICBASE_ENABLE));
     /* if disabled, cannot be enabled again */
@@ -318,6 +359,25 @@ static void apic_set_base(APICCommonState *s, uint64_t val)
         cpu_clear_apic_feature(&s->cpu->env);
         s->spurious_vec &= ~APIC_SV_ENABLE;
     }
+
+    /* Transition from disabled mode to xAPIC */
+    if (!(s->apicbase & MSR_IA32_APICBASE_ENABLE) &&
+        (val & MSR_IA32_APICBASE_ENABLE)) {
+        s->apicbase |= MSR_IA32_APICBASE_ENABLE;
+        cpu_set_apic_feature(&s->cpu->env);
+    }
+
+    /* Transition from xAPIC to x2APIC */
+    if (cpu_has_x2apic_feature(&s->cpu->env) &&
+        !(s->apicbase & MSR_IA32_APICBASE_EXTD) &&
+        (val & MSR_IA32_APICBASE_EXTD)) {
+        s->apicbase |= MSR_IA32_APICBASE_EXTD;
+
+        s->log_dest = ((s->initial_apic_id & 0xffff0) << 16) |
+                      (1 << (s->initial_apic_id & 0xf));
+    }
+
+    return 0;
 }
 
 static void apic_set_tpr(APICCommonState *s, uint8_t val)
diff --git a/hw/intc/apic_common.c b/hw/intc/apic_common.c
index 3c43ac9a1d..16ab40a35f 100644
--- a/hw/intc/apic_common.c
+++ b/hw/intc/apic_common.c
@@ -35,20 +35,19 @@
 
 bool apic_report_tpr_access;
 
-void cpu_set_apic_base(DeviceState *dev, uint64_t val)
+int cpu_set_apic_base(DeviceState *dev, uint64_t val)
 {
     trace_cpu_set_apic_base(val);
 
     if (dev) {
         APICCommonState *s = APIC_COMMON(dev);
         APICCommonClass *info = APIC_COMMON_GET_CLASS(s);
-        /* switching to x2APIC, reset possibly modified xAPIC ID */
-        if (!(s->apicbase & MSR_IA32_APICBASE_EXTD) &&
-            (val & MSR_IA32_APICBASE_EXTD)) {
-            s->id = s->initial_apic_id;
-        }
-        info->set_base(s, val);
+        /* Reset possibly modified xAPIC ID */
+        s->id = s->initial_apic_id;
+        return info->set_base(s, val);
     }
+
+    return 0;
 }
 
 uint64_t cpu_get_apic_base(DeviceState *dev)
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index ef46755a50..2126b0e589 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -631,8 +631,8 @@ void x86_cpu_vendor_words2str(char *dst, uint32_t vendor1,
  * in CPL=3; remove them if they are ever implemented for system emulation.
  */
 #if defined CONFIG_USER_ONLY
-#define CPUID_EXT_KERNEL_FEATURES (CPUID_EXT_PCID | CPUID_EXT_TSC_DEADLINE_TIMER | \
-                                 CPUID_EXT_X2APIC)
+#define CPUID_EXT_KERNEL_FEATURES \
+          (CPUID_EXT_PCID | CPUID_EXT_TSC_DEADLINE_TIMER)
 #else
 #define CPUID_EXT_KERNEL_FEATURES 0
 #endif
@@ -642,12 +642,13 @@ void x86_cpu_vendor_words2str(char *dst, uint32_t vendor1,
           CPUID_EXT_XSAVE | /* CPUID_EXT_OSXSAVE is dynamic */   \
           CPUID_EXT_MOVBE | CPUID_EXT_AES | CPUID_EXT_HYPERVISOR | \
           CPUID_EXT_RDRAND | CPUID_EXT_AVX | CPUID_EXT_F16C | \
-          CPUID_EXT_FMA | CPUID_EXT_KERNEL_FEATURES)
+          CPUID_EXT_FMA | CPUID_EXT_X2APIC | CPUID_EXT_KERNEL_FEATURES)
           /* missing:
           CPUID_EXT_DTES64, CPUID_EXT_DSCPL, CPUID_EXT_VMX, CPUID_EXT_SMX,
           CPUID_EXT_EST, CPUID_EXT_TM2, CPUID_EXT_CID,
           CPUID_EXT_XTPR, CPUID_EXT_PDCM, CPUID_EXT_PCID, CPUID_EXT_DCA,
-          CPUID_EXT_X2APIC, CPUID_EXT_TSC_DEADLINE_TIMER */
+          CPUID_EXT_TSC_DEADLINE_TIMER
+          */
 
 #ifdef TARGET_X86_64
 #define TCG_EXT2_X86_64_FEATURES CPUID_EXT2_LM
diff --git a/target/i386/tcg/sysemu/misc_helper.c b/target/i386/tcg/sysemu/misc_helper.c
index 1c43a9f4f7..7de0a6e866 100644
--- a/target/i386/tcg/sysemu/misc_helper.c
+++ b/target/i386/tcg/sysemu/misc_helper.c
@@ -158,9 +158,19 @@ void helper_wrmsr(CPUX86State *env)
     case MSR_IA32_SYSENTER_EIP:
         env->sysenter_eip = val;
         break;
-    case MSR_IA32_APICBASE:
-        cpu_set_apic_base(env_archcpu(env)->apic_state, val);
+    case MSR_IA32_APICBASE: {
+        int ret;
+
+        if (val & MSR_IA32_APICBASE_RESERVED) {
+            goto error;
+        }
+
+        ret = cpu_set_apic_base(env_archcpu(env)->apic_state, val);
+        if (ret < 0) {
+            goto error;
+        }
         break;
+    }
     case MSR_EFER:
         {
             uint64_t update_mask;
diff --git a/target/i386/whpx/whpx-apic.c b/target/i386/whpx/whpx-apic.c
index 8710e37567..7e14ded978 100644
--- a/target/i386/whpx/whpx-apic.c
+++ b/target/i386/whpx/whpx-apic.c
@@ -90,9 +90,10 @@ static void whpx_get_apic_state(APICCommonState *s,
     apic_next_timer(s, s->initial_count_load_time);
 }
 
-static void whpx_apic_set_base(APICCommonState *s, uint64_t val)
+static int whpx_apic_set_base(APICCommonState *s, uint64_t val)
 {
     s->apicbase = val;
+    return 0;
 }
 
 static void whpx_put_apic_base(CPUState *cpu, uint64_t val)
-- 
MST


