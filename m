Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3F2BC48BC1
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Feb 2024 11:18:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raDDU-0000TP-Da; Wed, 14 Feb 2024 06:14:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1raDDQ-0000Dt-Iv
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 06:14:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1raDDL-0006n4-RH
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 06:14:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707909243;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kuMPa6Sdwt4odkOM9VRUJLd71CBRiHTHNkqSTHJLh8o=;
 b=eBhY7IZwYKlyQUjBxv8EYJ5MFTTteM6rETdWQAEQzjcIzTt7ZaRM1Rr3g+gmPzKhnTOAnZ
 UrV+FLvnPg9xuaNLl/slgj2yrQU6bPqZYtPgA37rSZoK1eQmk4pUzmtfy03OyIwJ5d/4p3
 GkASvYUnfW50V9xaZFmVCEKHLpRFVLk=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-282-lVeGVbiRMzazLymJ-nUytA-1; Wed, 14 Feb 2024 06:14:01 -0500
X-MC-Unique: lVeGVbiRMzazLymJ-nUytA-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-5621c809a3bso451100a12.2
 for <qemu-devel@nongnu.org>; Wed, 14 Feb 2024 03:14:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707909238; x=1708514038;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kuMPa6Sdwt4odkOM9VRUJLd71CBRiHTHNkqSTHJLh8o=;
 b=gSgwxAaJoaRYg5DQnerFIkwZDnsoWolHyXNBJnqxPOnkN1sL0BYj2U3p8QABbOv6BY
 6uUtIph/E+NZypIoiRxodCR62astTXv1Ah5GD9242CGOkP2knaFuYYxRrGAbgaf6570r
 LlmnbpIIE+/RA1WsJag6+MTCjre5QeDj4bWzUdy7t1dcDi7JYIHH+BirHBNsjs9tX40r
 wZpWUSwExpW0dRuSOH7penx4e2r4qkDvi1f1mforFh+W6nJoYi89qHiaWRNEPEbEnaDS
 4pJST5Mi9hvfeymSxutPWo38nf0P95ff5zT8naZu1V41LfTrzMLWddU9RCrK9aG8Ry2w
 eBHw==
X-Gm-Message-State: AOJu0YwyTltB/Ujg+SNzXJBHwwjDDtAVjEItDs48AMEEqHfILqHpPRDs
 YRpewHYu+FrnWxKBDjA1LvS1BMPJ0HVnaqEYLmhUSgo+cXpoxmmP6AmOCtImMteF25T85LbkJdq
 LnCESYEqfh9K4qNDM2zNDszXG5yO4XH6shwqYZ8o/yZv94v4dMnL2IFajgi8NrUoHRer6ZF26Sf
 9tCYF8UZMnxw2pskDrJrI/WbDHFV9fDQ==
X-Received: by 2002:a05:6402:1501:b0:561:1b5e:14f0 with SMTP id
 f1-20020a056402150100b005611b5e14f0mr1799269edw.8.1707909238181; 
 Wed, 14 Feb 2024 03:13:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEQfP4NNHIBe2MSbizJBAXSAyxzZqDIo1wps/ANvV/Xk2uQZeCoNbyiCEK2tyZNHWCaH0g9PQ==
X-Received: by 2002:a05:6402:1501:b0:561:1b5e:14f0 with SMTP id
 f1-20020a056402150100b005611b5e14f0mr1799248edw.8.1707909237712; 
 Wed, 14 Feb 2024 03:13:57 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUYU+8eBjaj5a1xNVHyu5KFkGrEb3WzOkD8bpMVpQByN4c+EHKTJ/KzSc99nD3Dhyg47G10GzypQ4rKuw3ZStOQO+YO5/BTkQ7somrQp6TiVqjC/Sux7jmSw8MPysU+xW9AgoR6fRoQW0BVHwR6C3+oGNSLHhlM3ZmwVmalBss5+GZTIwtdXUC4N/eUkp8DQoie/AfHoywKOaBP8CFYCSB5LjkpJxf7H64A7l//
Received: from redhat.com ([2.52.26.67]) by smtp.gmail.com with ESMTPSA id
 g14-20020a056402428e00b0055fba4996d9sm4571428edc.71.2024.02.14.03.13.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Feb 2024 03:13:57 -0800 (PST)
Date: Wed, 14 Feb 2024 06:13:54 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Bui Quang Minh <minhquangbui99@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 13/60] apic: add support for x2APIC mode
Message-ID: <b5ee0468e9d28c6bd47cce70f90b5032dd10ecc2.1707909001.git.mst@redhat.com>
References: <cover.1707909001.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1707909001.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.504,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This commit extends the APIC ID to 32-bit long and remove the 255 max APIC
ID limit in userspace APIC. The array that manages local APICs is now
dynamically allocated based on the max APIC ID of created x86 machine.
Also, new x2APIC IPI destination determination scheme, self IPI and x2APIC
mode register access are supported.

Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
Message-Id: <20240111154404.5333-3-minhquangbui99@gmail.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/i386/apic.h          |   3 +-
 include/hw/i386/apic_internal.h |   7 +-
 target/i386/cpu.h               |   2 +
 hw/i386/x86.c                   |   6 +-
 hw/intc/apic.c                  | 287 ++++++++++++++++++++++++--------
 hw/intc/apic_common.c           |   9 +
 target/i386/cpu-sysemu.c        |  18 +-
 7 files changed, 258 insertions(+), 74 deletions(-)

diff --git a/include/hw/i386/apic.h b/include/hw/i386/apic.h
index ddea4213db..c8ca41ab44 100644
--- a/include/hw/i386/apic.h
+++ b/include/hw/i386/apic.h
@@ -3,8 +3,7 @@
 
 
 /* apic.c */
-void apic_deliver_irq(uint8_t dest, uint8_t dest_mode, uint8_t delivery_mode,
-                      uint8_t vector_num, uint8_t trigger_mode);
+void apic_set_max_apic_id(uint32_t max_apic_id);
 int apic_accept_pic_intr(DeviceState *s);
 void apic_deliver_pic_intr(DeviceState *s, int level);
 void apic_deliver_nmi(DeviceState *d);
diff --git a/include/hw/i386/apic_internal.h b/include/hw/i386/apic_internal.h
index 5f2ba24bfc..e796e6cae3 100644
--- a/include/hw/i386/apic_internal.h
+++ b/include/hw/i386/apic_internal.h
@@ -46,8 +46,10 @@
 #define APIC_DM_EXTINT                  7
 
 /* APIC destination mode */
-#define APIC_DESTMODE_FLAT              0xf
-#define APIC_DESTMODE_CLUSTER           1
+#define APIC_DESTMODE_PHYSICAL          0
+#define APIC_DESTMODE_LOGICAL           1
+#define APIC_DESTMODE_LOGICAL_FLAT      0xf
+#define APIC_DESTMODE_LOGICAL_CLUSTER   0
 
 #define APIC_TRIGGER_EDGE               0
 #define APIC_TRIGGER_LEVEL              1
@@ -187,6 +189,7 @@ struct APICCommonState {
     DeviceState *vapic;
     hwaddr vapic_paddr; /* note: persistence via kvmvapic */
     bool legacy_instance_id;
+    uint32_t extended_log_dest;
 };
 
 typedef struct VAPICState {
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index afabdeab75..08eaa61c56 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2239,8 +2239,10 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
                    uint32_t *eax, uint32_t *ebx,
                    uint32_t *ecx, uint32_t *edx);
 void cpu_clear_apic_feature(CPUX86State *env);
+void cpu_set_apic_feature(CPUX86State *env);
 void host_cpuid(uint32_t function, uint32_t count,
                 uint32_t *eax, uint32_t *ebx, uint32_t *ecx, uint32_t *edx);
+bool cpu_has_x2apic_feature(CPUX86State *env);
 
 /* helper.c */
 void x86_cpu_set_a20(X86CPU *cpu, int a20_state);
diff --git a/hw/i386/x86.c b/hw/i386/x86.c
index 2b6291ad8d..3d1bdd334e 100644
--- a/hw/i386/x86.c
+++ b/hw/i386/x86.c
@@ -137,7 +137,7 @@ void x86_cpus_init(X86MachineState *x86ms, int default_cpu_version)
      * a literal `0` in configurations where kvm_* aren't defined)
      */
     if (kvm_enabled() && x86ms->apic_id_limit > 255 &&
-        (!kvm_irqchip_in_kernel() || !kvm_enable_x2apic())) {
+        kvm_irqchip_in_kernel() && !kvm_enable_x2apic()) {
         error_report("current -smp configuration requires kernel "
                      "irqchip and X2APIC API support.");
         exit(EXIT_FAILURE);
@@ -147,6 +147,10 @@ void x86_cpus_init(X86MachineState *x86ms, int default_cpu_version)
         kvm_set_max_apic_id(x86ms->apic_id_limit);
     }
 
+    if (!kvm_irqchip_in_kernel()) {
+        apic_set_max_apic_id(x86ms->apic_id_limit);
+    }
+
     possible_cpus = mc->possible_cpu_arch_ids(ms);
     for (i = 0; i < ms->smp.cpus; i++) {
         x86_cpu_new(x86ms, possible_cpus->cpus[i].arch_id, &error_fatal);
diff --git a/hw/intc/apic.c b/hw/intc/apic.c
index 7a349c0723..178fb26b47 100644
--- a/hw/intc/apic.c
+++ b/hw/intc/apic.c
@@ -32,14 +32,13 @@
 #include "qapi/error.h"
 #include "qom/object.h"
 
-#define MAX_APICS 255
-#define MAX_APIC_WORDS 8
-
 #define SYNC_FROM_VAPIC                 0x1
 #define SYNC_TO_VAPIC                   0x2
 #define SYNC_ISR_IRR_TO_VAPIC           0x4
 
-static APICCommonState *local_apics[MAX_APICS + 1];
+static APICCommonState **local_apics;
+static uint32_t max_apics;
+static uint32_t max_apic_words;
 
 #define TYPE_APIC "apic"
 /*This is reusing the APICCommonState typedef from APIC_COMMON */
@@ -49,7 +48,19 @@ DECLARE_INSTANCE_CHECKER(APICCommonState, APIC,
 static void apic_set_irq(APICCommonState *s, int vector_num, int trigger_mode);
 static void apic_update_irq(APICCommonState *s);
 static void apic_get_delivery_bitmask(uint32_t *deliver_bitmask,
-                                      uint8_t dest, uint8_t dest_mode);
+                                      uint32_t dest, uint8_t dest_mode);
+
+void apic_set_max_apic_id(uint32_t max_apic_id)
+{
+    int word_size = 32;
+
+    /* round up the max apic id to next multiple of words */
+    max_apics = (max_apic_id + word_size - 1) & ~(word_size - 1);
+
+    local_apics = g_malloc0(sizeof(*local_apics) * max_apics);
+    max_apic_words = max_apics >> 5;
+}
+
 
 /* Find first bit starting from msb */
 static int apic_fls_bit(uint32_t value)
@@ -199,10 +210,10 @@ static void apic_external_nmi(APICCommonState *s)
 #define foreach_apic(apic, deliver_bitmask, code) \
 {\
     int __i, __j;\
-    for(__i = 0; __i < MAX_APIC_WORDS; __i++) {\
+    for (__i = 0; __i < max_apic_words; __i++) {\
         uint32_t __mask = deliver_bitmask[__i];\
         if (__mask) {\
-            for(__j = 0; __j < 32; __j++) {\
+            for (__j = 0; __j < 32; __j++) {\
                 if (__mask & (1U << __j)) {\
                     apic = local_apics[__i * 32 + __j];\
                     if (apic) {\
@@ -226,7 +237,7 @@ static void apic_bus_deliver(const uint32_t *deliver_bitmask,
             {
                 int i, d;
                 d = -1;
-                for(i = 0; i < MAX_APIC_WORDS; i++) {
+                for (i = 0; i < max_apic_words; i++) {
                     if (deliver_bitmask[i]) {
                         d = i * 32 + apic_ffs_bit(deliver_bitmask[i]);
                         break;
@@ -276,16 +287,18 @@ static void apic_bus_deliver(const uint32_t *deliver_bitmask,
                  apic_set_irq(apic_iter, vector_num, trigger_mode) );
 }
 
-void apic_deliver_irq(uint8_t dest, uint8_t dest_mode, uint8_t delivery_mode,
-                      uint8_t vector_num, uint8_t trigger_mode)
+static void apic_deliver_irq(uint32_t dest, uint8_t dest_mode,
+                             uint8_t delivery_mode, uint8_t vector_num,
+                             uint8_t trigger_mode)
 {
-    uint32_t deliver_bitmask[MAX_APIC_WORDS];
+    uint32_t *deliver_bitmask = g_malloc(max_apic_words * sizeof(uint32_t));
 
     trace_apic_deliver_irq(dest, dest_mode, delivery_mode, vector_num,
                            trigger_mode);
 
     apic_get_delivery_bitmask(deliver_bitmask, dest, dest_mode);
     apic_bus_deliver(deliver_bitmask, delivery_mode, vector_num, trigger_mode);
+    g_free(deliver_bitmask);
 }
 
 bool is_x2apic_mode(DeviceState *dev)
@@ -442,57 +455,123 @@ static void apic_eoi(APICCommonState *s)
     apic_update_irq(s);
 }
 
-static int apic_find_dest(uint8_t dest)
+static bool apic_match_dest(APICCommonState *apic, uint32_t dest)
 {
-    APICCommonState *apic = local_apics[dest];
+    if (is_x2apic_mode(&apic->parent_obj)) {
+        return apic->initial_apic_id == dest;
+    } else {
+        return apic->id == (uint8_t)dest;
+    }
+}
+
+static void apic_find_dest(uint32_t *deliver_bitmask, uint32_t dest)
+{
+    APICCommonState *apic = NULL;
     int i;
 
-    if (apic && apic->id == dest)
-        return dest;  /* shortcut in case apic->id == local_apics[dest]->id */
-
-    for (i = 0; i < MAX_APICS; i++) {
+    for (i = 0; i < max_apics; i++) {
         apic = local_apics[i];
-        if (apic && apic->id == dest)
-            return i;
-        if (!apic)
-            break;
+        if (apic && apic_match_dest(apic, dest)) {
+            apic_set_bit(deliver_bitmask, i);
+        }
     }
+}
 
-    return -1;
+/*
+ * Deliver interrupt to x2APIC CPUs if it is x2APIC broadcast.
+ * Otherwise, deliver interrupt to xAPIC CPUs if it is xAPIC
+ * broadcast.
+ */
+static void apic_get_broadcast_bitmask(uint32_t *deliver_bitmask,
+                                       bool is_x2apic_broadcast)
+{
+    int i;
+    APICCommonState *apic_iter;
+
+    for (i = 0; i < max_apics; i++) {
+        apic_iter = local_apics[i];
+        if (apic_iter) {
+            bool apic_in_x2apic = is_x2apic_mode(&apic_iter->parent_obj);
+
+            if (is_x2apic_broadcast && apic_in_x2apic) {
+                apic_set_bit(deliver_bitmask, i);
+            } else if (!is_x2apic_broadcast && !apic_in_x2apic) {
+                apic_set_bit(deliver_bitmask, i);
+            }
+        }
+    }
 }
 
 static void apic_get_delivery_bitmask(uint32_t *deliver_bitmask,
-                                      uint8_t dest, uint8_t dest_mode)
+                                      uint32_t dest, uint8_t dest_mode)
 {
-    APICCommonState *apic_iter;
+    APICCommonState *apic;
     int i;
 
-    if (dest_mode == 0) {
-        if (dest == 0xff) {
-            memset(deliver_bitmask, 0xff, MAX_APIC_WORDS * sizeof(uint32_t));
+    memset(deliver_bitmask, 0x00, max_apic_words * sizeof(uint32_t));
+
+    /*
+     * x2APIC broadcast is delivered to all x2APIC CPUs regardless of
+     * destination mode. In case the destination mode is physical, it is
+     * broadcasted to all xAPIC CPUs too. Otherwise, if the destination
+     * mode is logical, we need to continue checking if xAPIC CPUs accepts
+     * the interrupt.
+     */
+    if (dest == 0xffffffff) {
+        if (dest_mode == APIC_DESTMODE_PHYSICAL) {
+            memset(deliver_bitmask, 0xff, max_apic_words * sizeof(uint32_t));
+            return;
         } else {
-            int idx = apic_find_dest(dest);
-            memset(deliver_bitmask, 0x00, MAX_APIC_WORDS * sizeof(uint32_t));
-            if (idx >= 0)
-                apic_set_bit(deliver_bitmask, idx);
+            apic_get_broadcast_bitmask(deliver_bitmask, true);
+        }
+    }
+
+    if (dest_mode == APIC_DESTMODE_PHYSICAL) {
+        apic_find_dest(deliver_bitmask, dest);
+        /* Any APIC in xAPIC mode will interpret 0xFF as broadcast */
+        if (dest == 0xff) {
+            apic_get_broadcast_bitmask(deliver_bitmask, false);
         }
     } else {
-        /* XXX: cluster mode */
-        memset(deliver_bitmask, 0x00, MAX_APIC_WORDS * sizeof(uint32_t));
-        for(i = 0; i < MAX_APICS; i++) {
-            apic_iter = local_apics[i];
-            if (apic_iter) {
-                if (apic_iter->dest_mode == 0xf) {
-                    if (dest & apic_iter->log_dest)
-                        apic_set_bit(deliver_bitmask, i);
-                } else if (apic_iter->dest_mode == 0x0) {
-                    if ((dest & 0xf0) == (apic_iter->log_dest & 0xf0) &&
-                        (dest & apic_iter->log_dest & 0x0f)) {
+        /* XXX: logical mode */
+        for (i = 0; i < max_apics; i++) {
+            apic = local_apics[i];
+            if (apic) {
+                /* x2APIC logical mode */
+                if (apic->apicbase & MSR_IA32_APICBASE_EXTD) {
+                    if ((dest >> 16) == (apic->extended_log_dest >> 16) &&
+                        (dest & apic->extended_log_dest & 0xffff)) {
                         apic_set_bit(deliver_bitmask, i);
                     }
+                    continue;
                 }
-            } else {
-                break;
+
+                /* xAPIC logical mode */
+                dest = (uint8_t)dest;
+                if (apic->dest_mode == APIC_DESTMODE_LOGICAL_FLAT) {
+                    if (dest & apic->log_dest) {
+                        apic_set_bit(deliver_bitmask, i);
+                    }
+                } else if (apic->dest_mode == APIC_DESTMODE_LOGICAL_CLUSTER) {
+                    /*
+                     * In cluster model of xAPIC logical mode IPI, 4 higher
+                     * bits are used as cluster address, 4 lower bits are
+                     * the bitmask for local APICs in the cluster. The IPI
+                     * is delivered to an APIC if the cluster address
+                     * matches and the APIC's address bit in the cluster is
+                     * set in bitmask of destination ID in IPI.
+                     *
+                     * The cluster address ranges from 0 - 14, the cluster
+                     * address 15 (0xf) is the broadcast address to all
+                     * clusters.
+                     */
+                    if ((dest & 0xf0) == 0xf0 ||
+                        (dest & 0xf0) == (apic->log_dest & 0xf0)) {
+                        if (dest & apic->log_dest & 0x0f) {
+                            apic_set_bit(deliver_bitmask, i);
+                        }
+                    }
+               }
             }
         }
     }
@@ -516,29 +595,36 @@ void apic_sipi(DeviceState *dev)
     s->wait_for_sipi = 0;
 }
 
-static void apic_deliver(DeviceState *dev, uint8_t dest, uint8_t dest_mode,
+static void apic_deliver(DeviceState *dev, uint32_t dest, uint8_t dest_mode,
                          uint8_t delivery_mode, uint8_t vector_num,
-                         uint8_t trigger_mode)
+                         uint8_t trigger_mode, uint8_t dest_shorthand)
 {
     APICCommonState *s = APIC(dev);
-    uint32_t deliver_bitmask[MAX_APIC_WORDS];
-    int dest_shorthand = (s->icr[0] >> 18) & 3;
     APICCommonState *apic_iter;
+    uint32_t deliver_bitmask_size = max_apic_words * sizeof(uint32_t);
+    uint32_t *deliver_bitmask = g_malloc(deliver_bitmask_size);
+    uint32_t current_apic_id;
+
+    if (is_x2apic_mode(dev)) {
+        current_apic_id = s->initial_apic_id;
+    } else {
+        current_apic_id = s->id;
+    }
 
     switch (dest_shorthand) {
     case 0:
         apic_get_delivery_bitmask(deliver_bitmask, dest, dest_mode);
         break;
     case 1:
-        memset(deliver_bitmask, 0x00, sizeof(deliver_bitmask));
-        apic_set_bit(deliver_bitmask, s->id);
+        memset(deliver_bitmask, 0x00, deliver_bitmask_size);
+        apic_set_bit(deliver_bitmask, current_apic_id);
         break;
     case 2:
-        memset(deliver_bitmask, 0xff, sizeof(deliver_bitmask));
+        memset(deliver_bitmask, 0xff, deliver_bitmask_size);
         break;
     case 3:
-        memset(deliver_bitmask, 0xff, sizeof(deliver_bitmask));
-        apic_reset_bit(deliver_bitmask, s->id);
+        memset(deliver_bitmask, 0xff, deliver_bitmask_size);
+        apic_reset_bit(deliver_bitmask, current_apic_id);
         break;
     }
 
@@ -562,6 +648,7 @@ static void apic_deliver(DeviceState *dev, uint8_t dest, uint8_t dest_mode,
     }
 
     apic_bus_deliver(deliver_bitmask, delivery_mode, vector_num, trigger_mode);
+    g_free(deliver_bitmask);
 }
 
 static bool apic_check_pic(APICCommonState *s)
@@ -658,7 +745,11 @@ static int apic_register_read(int index, uint64_t *value)
 
     switch(index) {
     case 0x02: /* id */
-        val = s->id << 24;
+        if (is_x2apic_mode(dev)) {
+            val = s->initial_apic_id;
+        } else {
+            val = s->id << 24;
+        }
         break;
     case 0x03: /* version */
         val = s->version | ((APIC_LVT_NB - 1) << 16);
@@ -681,10 +772,19 @@ static int apic_register_read(int index, uint64_t *value)
         val = 0;
         break;
     case 0x0d:
-        val = s->log_dest << 24;
+        if (is_x2apic_mode(dev)) {
+            val = s->extended_log_dest;
+        } else {
+            val = s->log_dest << 24;
+        }
         break;
     case 0x0e:
-        val = (s->dest_mode << 28) | 0xfffffff;
+        if (is_x2apic_mode(dev)) {
+            val = 0;
+            ret = -1;
+        } else {
+            val = (s->dest_mode << 28) | 0xfffffff;
+        }
         break;
     case 0x0f:
         val = s->spurious_vec;
@@ -764,7 +864,12 @@ static void apic_send_msi(MSIMessage *msi)
 {
     uint64_t addr = msi->address;
     uint32_t data = msi->data;
-    uint8_t dest = (addr & MSI_ADDR_DEST_ID_MASK) >> MSI_ADDR_DEST_ID_SHIFT;
+    uint32_t dest = (addr & MSI_ADDR_DEST_ID_MASK) >> MSI_ADDR_DEST_ID_SHIFT;
+    /*
+     * The higher 3 bytes of destination id is stored in higher word of
+     * msi address. See x86_iommu_irq_to_msi_message()
+     */
+    dest = dest | (addr >> 32);
     uint8_t vector = (data & MSI_DATA_VECTOR_MASK) >> MSI_DATA_VECTOR_SHIFT;
     uint8_t dest_mode = (addr >> MSI_ADDR_DEST_MODE_SHIFT) & 0x1;
     uint8_t trigger_mode = (data >> MSI_DATA_TRIGGER_SHIFT) & 0x1;
@@ -788,6 +893,10 @@ static int apic_register_write(int index, uint64_t val)
 
     switch(index) {
     case 0x02:
+        if (is_x2apic_mode(dev)) {
+            return -1;
+        }
+
         s->id = (val >> 24);
         break;
     case 0x03:
@@ -807,9 +916,17 @@ static int apic_register_write(int index, uint64_t val)
         apic_eoi(s);
         break;
     case 0x0d:
+        if (is_x2apic_mode(dev)) {
+            return -1;
+        }
+
         s->log_dest = val >> 24;
         break;
     case 0x0e:
+        if (is_x2apic_mode(dev)) {
+            return -1;
+        }
+
         s->dest_mode = val >> 28;
         break;
     case 0x0f:
@@ -821,13 +938,27 @@ static int apic_register_write(int index, uint64_t val)
     case 0x20 ... 0x27:
     case 0x28:
         break;
-    case 0x30:
+    case 0x30: {
+        uint32_t dest;
+
         s->icr[0] = val;
-        apic_deliver(dev, (s->icr[1] >> 24) & 0xff, (s->icr[0] >> 11) & 1,
+        if (is_x2apic_mode(dev)) {
+            s->icr[1] = val >> 32;
+            dest = s->icr[1];
+        } else {
+            dest = (s->icr[1] >> 24) & 0xff;
+        }
+
+        apic_deliver(dev, dest, (s->icr[0] >> 11) & 1,
                      (s->icr[0] >> 8) & 7, (s->icr[0] & 0xff),
-                     (s->icr[0] >> 15) & 1);
+                     (s->icr[0] >> 15) & 1, (s->icr[0] >> 18) & 3);
         break;
+    }
     case 0x31:
+        if (is_x2apic_mode(dev)) {
+            return -1;
+        }
+
         s->icr[1] = val;
         break;
     case 0x32 ... 0x37:
@@ -856,6 +987,23 @@ static int apic_register_write(int index, uint64_t val)
             s->count_shift = (v + 1) & 7;
         }
         break;
+    case 0x3f: {
+        int vector = val & 0xff;
+
+        if (!is_x2apic_mode(dev)) {
+            return -1;
+        }
+
+        /*
+         * Self IPI is identical to IPI with
+         * - Destination shorthand: 1 (Self)
+         * - Trigger mode: 0 (Edge)
+         * - Delivery mode: 0 (Fixed)
+         */
+        apic_deliver(dev, 0, 0, APIC_DM_FIXED, vector, 0, 1);
+
+        break;
+    }
     default:
         s->esr |= APIC_ESR_ILLEGAL_ADDRESS;
         return -1;
@@ -933,12 +1081,6 @@ static void apic_realize(DeviceState *dev, Error **errp)
 {
     APICCommonState *s = APIC(dev);
 
-    if (s->id >= MAX_APICS) {
-        error_setg(errp, "%s initialization failed. APIC ID %d is invalid",
-                   object_get_typename(OBJECT(dev)), s->id);
-        return;
-    }
-
     if (kvm_enabled()) {
         warn_report("Userspace local APIC is deprecated for KVM.");
         warn_report("Do not use kernel-irqchip except for the -M isapc machine type.");
@@ -955,7 +1097,16 @@ static void apic_realize(DeviceState *dev, Error **errp)
     s->io_memory.disable_reentrancy_guard = true;
 
     s->timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, apic_timer, s);
-    local_apics[s->id] = s;
+
+    /*
+     * The --machine none does not call apic_set_max_apic_id before creating
+     * apic, so we need to call it here and set it to 1 which is the max cpus
+     * in machine none.
+     */
+    if (!local_apics) {
+        apic_set_max_apic_id(1);
+    }
+    local_apics[s->initial_apic_id] = s;
 
     msi_nonbroken = true;
 }
@@ -965,7 +1116,7 @@ static void apic_unrealize(DeviceState *dev)
     APICCommonState *s = APIC(dev);
 
     timer_free(s->timer);
-    local_apics[s->id] = NULL;
+    local_apics[s->initial_apic_id] = NULL;
 }
 
 static void apic_class_init(ObjectClass *klass, void *data)
diff --git a/hw/intc/apic_common.c b/hw/intc/apic_common.c
index 6c100b48d6..3c43ac9a1d 100644
--- a/hw/intc/apic_common.c
+++ b/hw/intc/apic_common.c
@@ -287,6 +287,10 @@ static void apic_common_realize(DeviceState *dev, Error **errp)
     }
     vmstate_register_with_alias_id(NULL, instance_id, &vmstate_apic_common,
                                    s, -1, 0, NULL);
+
+    /* APIC LDR in x2APIC mode */
+    s->extended_log_dest = ((s->initial_apic_id >> 4) << 16) |
+                            (1 << (s->initial_apic_id & 0xf));
 }
 
 static void apic_common_unrealize(DeviceState *dev)
@@ -427,6 +431,11 @@ static void apic_common_set_id(Object *obj, Visitor *v, const char *name,
         return;
     }
 
+    if (value >= 255 && !cpu_has_x2apic_feature(&s->cpu->env)) {
+        error_setg(errp, "APIC ID %d requires x2APIC feature in CPU", value);
+        return;
+    }
+
     s->initial_apic_id = value;
     s->id = (uint8_t)value;
 }
diff --git a/target/i386/cpu-sysemu.c b/target/i386/cpu-sysemu.c
index 2375e48178..7422096737 100644
--- a/target/i386/cpu-sysemu.c
+++ b/target/i386/cpu-sysemu.c
@@ -235,6 +235,16 @@ void cpu_clear_apic_feature(CPUX86State *env)
     env->features[FEAT_1_EDX] &= ~CPUID_APIC;
 }
 
+void cpu_set_apic_feature(CPUX86State *env)
+{
+    env->features[FEAT_1_EDX] |= CPUID_APIC;
+}
+
+bool cpu_has_x2apic_feature(CPUX86State *env)
+{
+    return env->features[FEAT_1_ECX] & CPUID_EXT_X2APIC;
+}
+
 bool cpu_is_bsp(X86CPU *cpu)
 {
     return cpu_get_apic_base(cpu->apic_state) & MSR_IA32_APICBASE_BSP;
@@ -281,11 +291,17 @@ void x86_cpu_apic_create(X86CPU *cpu, Error **errp)
                               OBJECT(cpu->apic_state));
     object_unref(OBJECT(cpu->apic_state));
 
-    qdev_prop_set_uint32(cpu->apic_state, "id", cpu->apic_id);
     /* TODO: convert to link<> */
     apic = APIC_COMMON(cpu->apic_state);
     apic->cpu = cpu;
     apic->apicbase = APIC_DEFAULT_ADDRESS | MSR_IA32_APICBASE_ENABLE;
+
+    /*
+     * apic_common_set_id needs to check if the CPU has x2APIC
+     * feature in case APIC ID >= 255, so we need to set apic->cpu
+     * before setting APIC ID
+     */
+    qdev_prop_set_uint32(cpu->apic_state, "id", cpu->apic_id);
 }
 
 void x86_cpu_apic_realize(X86CPU *cpu, Error **errp)
-- 
MST


