Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36294C48BC1
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Feb 2024 11:14:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raDDS-0000IP-It; Wed, 14 Feb 2024 06:14:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1raDDM-0000Ax-3N
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 06:14:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1raDDD-0006mR-7y
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 06:14:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707909238;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pNWPNdaeH/gm2+Fuc6t0CFL+yHMh3buRTqg9OHqLxYg=;
 b=LIza2OzcMqIPC4lL1k0LgdnZ+EepkGNFs/dhR6EUvlIIT/ETu41K/QU3RIKirTRzZZG5sj
 1Z91VLWyu0RQZXgYOyvzmyJ8ZIWvSX5gKmNnQ2k11x6WrhaPJ4uk2AjeXVxaVkdLASHqR3
 6u2Div7+xMae5hNDQMeph1s9S123jrE=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-321-VX0J20qoMLmm4FTcaIUzPg-1; Wed, 14 Feb 2024 06:13:57 -0500
X-MC-Unique: VX0J20qoMLmm4FTcaIUzPg-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-5114f2a1e81so1843829e87.1
 for <qemu-devel@nongnu.org>; Wed, 14 Feb 2024 03:13:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707909235; x=1708514035;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pNWPNdaeH/gm2+Fuc6t0CFL+yHMh3buRTqg9OHqLxYg=;
 b=JNQIPUrOHKwfhINv48NBjTlrG5kfeUoAuHDsg2hqZiyghSiq8yg/x5k2/NtuAJNJRo
 N96LfawRc8D7KZBPgbicajYDq1l9CyIsWz6hRnTwQBvOCFAhHqAQjt0B9DAmAe2OovUT
 8SW6biJ4UE3w+YAPGc2lxVRer/RtK3pMCG7IZ7DoftD2dB5JlqsBkAKN1zYH17qb5u/d
 qCtlU/esI90DnfAg38B8lYb4coxrKORjofxQrh0AmonjbTNMhKZJu0tLEYpF6cKF+eoR
 Kmn4VQV29fqOqR0Q+Bgk2O3uYPQ6CzNaSIrqY4H8MLodaOC5E4cZXJuFbUjiEyH9ekov
 9KTg==
X-Gm-Message-State: AOJu0YxMw4Wd3etzzTERR+567rtF4BoQGv9PzNG7UGm9+wxtSsAey0vx
 UUQh4KUE7sExp6F4Tw0F4ir8iUybvvelgSUWo2sVnNIIrna6GxFQECWi3ean49jPXohOdZfLd0S
 VNRnUMBNpx8Ze2wiRyrw+X3QUfdaF41iyJwQD045mghgFYczKm/vmJnzsa7SsV65/ipV/pbxzfG
 GvqhrKYWQAey0SYLk6jJFCc6dMiRiyRQ==
X-Received: by 2002:ac2:483c:0:b0:511:8b33:6c72 with SMTP id
 28-20020ac2483c000000b005118b336c72mr1559614lft.47.1707909234979; 
 Wed, 14 Feb 2024 03:13:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHi3EkOzzfe+qbA14LdRGgIHwn+PpD7zGPn8bFLmlyMv/AYtKcMbYZ8mCcEEsrVg7GNH42bAA==
X-Received: by 2002:ac2:483c:0:b0:511:8b33:6c72 with SMTP id
 28-20020ac2483c000000b005118b336c72mr1559603lft.47.1707909234598; 
 Wed, 14 Feb 2024 03:13:54 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUlfO48icVbYx/2bL46+VoxP/+vh/tCWiXAjqg88ei4dKkXm1N3Eur0KSCSQ7CIzALMkZpOPPNJhvE+7S7vCyMJFLmejnqdXmuly07TRPzPUiSU8ksmp/d8rSzk1ye0/WTD8Au+6B6wB/rcM24761Enxr+cWfl3TmmvIgmKsRSmw/dCgxl7dkMxYuRb8mLyphOvJ7vLRGo8TNQTNKvMt4AdRkypav9TmcZUpsVS
Received: from redhat.com ([2.52.26.67]) by smtp.gmail.com with ESMTPSA id
 fi27-20020a056402551b00b0055edfb81384sm4496217edb.60.2024.02.14.03.13.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Feb 2024 03:13:53 -0800 (PST)
Date: Wed, 14 Feb 2024 06:13:51 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Bui Quang Minh <minhquangbui99@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PULL 12/60] i386/tcg: implement x2APIC registers MSR access
Message-ID: <b2101358e591c9f0a93739dd3aee72935a79af80.1707909001.git.mst@redhat.com>
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

This commit creates apic_register_read/write which are used by both
apic_mem_read/write for MMIO access and apic_msr_read/write for MSR access.

The apic_msr_read/write returns -1 on error, accelerator can use this to
raise the appropriate exception.

Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
Message-Id: <20240111154404.5333-2-minhquangbui99@gmail.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/i386/apic.h               |   3 +
 target/i386/cpu.h                    |   3 +
 hw/intc/apic.c                       | 122 ++++++++++++++++++++-------
 target/i386/tcg/sysemu/misc_helper.c |  27 ++++++
 hw/intc/trace-events                 |   4 +-
 5 files changed, 127 insertions(+), 32 deletions(-)

diff --git a/include/hw/i386/apic.h b/include/hw/i386/apic.h
index bdc15a7a73..ddea4213db 100644
--- a/include/hw/i386/apic.h
+++ b/include/hw/i386/apic.h
@@ -18,6 +18,9 @@ void apic_sipi(DeviceState *s);
 void apic_poll_irq(DeviceState *d);
 void apic_designate_bsp(DeviceState *d, bool bsp);
 int apic_get_highest_priority_irr(DeviceState *dev);
+int apic_msr_read(int index, uint64_t *val);
+int apic_msr_write(int index, uint64_t val);
+bool is_x2apic_mode(DeviceState *d);
 
 /* pc.c */
 DeviceState *cpu_get_current_apic(void);
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 6a5b180ccb..afabdeab75 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -545,6 +545,9 @@ typedef enum X86Seg {
 #define MSR_IA32_VMX_TRUE_ENTRY_CTLS     0x00000490
 #define MSR_IA32_VMX_VMFUNC             0x00000491
 
+#define MSR_APIC_START                  0x00000800
+#define MSR_APIC_END                    0x000008ff
+
 #define XSTATE_FP_BIT                   0
 #define XSTATE_SSE_BIT                  1
 #define XSTATE_YMM_BIT                  2
diff --git a/hw/intc/apic.c b/hw/intc/apic.c
index ac3d47d231..7a349c0723 100644
--- a/hw/intc/apic.c
+++ b/hw/intc/apic.c
@@ -288,6 +288,13 @@ void apic_deliver_irq(uint8_t dest, uint8_t dest_mode, uint8_t delivery_mode,
     apic_bus_deliver(deliver_bitmask, delivery_mode, vector_num, trigger_mode);
 }
 
+bool is_x2apic_mode(DeviceState *dev)
+{
+    APICCommonState *s = APIC(dev);
+
+    return s->apicbase & MSR_IA32_APICBASE_EXTD;
+}
+
 static void apic_set_base(APICCommonState *s, uint64_t val)
 {
     s->apicbase = (val & 0xfffff000) |
@@ -636,24 +643,19 @@ static void apic_timer(void *opaque)
     apic_timer_update(s, s->next_time);
 }
 
-static uint64_t apic_mem_read(void *opaque, hwaddr addr, unsigned size)
+static int apic_register_read(int index, uint64_t *value)
 {
     DeviceState *dev;
     APICCommonState *s;
     uint32_t val;
-    int index;
-
-    if (size < 4) {
-        return 0;
-    }
+    int ret = 0;
 
     dev = cpu_get_current_apic();
     if (!dev) {
-        return 0;
+        return -1;
     }
     s = APIC(dev);
 
-    index = (addr >> 4) & 0xff;
     switch(index) {
     case 0x02: /* id */
         val = s->id << 24;
@@ -718,12 +720,46 @@ static uint64_t apic_mem_read(void *opaque, hwaddr addr, unsigned size)
     default:
         s->esr |= APIC_ESR_ILLEGAL_ADDRESS;
         val = 0;
+        ret = -1;
         break;
     }
-    trace_apic_mem_readl(addr, val);
+
+    trace_apic_register_read(index, val);
+    *value = val;
+    return ret;
+}
+
+static uint64_t apic_mem_read(void *opaque, hwaddr addr, unsigned size)
+{
+    uint64_t val;
+    int index;
+
+    if (size < 4) {
+        return 0;
+    }
+
+    index = (addr >> 4) & 0xff;
+    apic_register_read(index, &val);
+
     return val;
 }
 
+int apic_msr_read(int index, uint64_t *val)
+{
+    DeviceState *dev;
+
+    dev = cpu_get_current_apic();
+    if (!dev) {
+        return -1;
+    }
+
+    if (!is_x2apic_mode(dev)) {
+        return -1;
+    }
+
+    return apic_register_read(index, val);
+}
+
 static void apic_send_msi(MSIMessage *msi)
 {
     uint64_t addr = msi->address;
@@ -737,35 +773,18 @@ static void apic_send_msi(MSIMessage *msi)
     apic_deliver_irq(dest, dest_mode, delivery, vector, trigger_mode);
 }
 
-static void apic_mem_write(void *opaque, hwaddr addr, uint64_t val,
-                           unsigned size)
+static int apic_register_write(int index, uint64_t val)
 {
     DeviceState *dev;
     APICCommonState *s;
-    int index = (addr >> 4) & 0xff;
-
-    if (size < 4) {
-        return;
-    }
-
-    if (addr > 0xfff || !index) {
-        /* MSI and MMIO APIC are at the same memory location,
-         * but actually not on the global bus: MSI is on PCI bus
-         * APIC is connected directly to the CPU.
-         * Mapping them on the global bus happens to work because
-         * MSI registers are reserved in APIC MMIO and vice versa. */
-        MSIMessage msi = { .address = addr, .data = val };
-        apic_send_msi(&msi);
-        return;
-    }
 
     dev = cpu_get_current_apic();
     if (!dev) {
-        return;
+        return -1;
     }
     s = APIC(dev);
 
-    trace_apic_mem_writel(addr, val);
+    trace_apic_register_write(index, val);
 
     switch(index) {
     case 0x02:
@@ -839,8 +858,51 @@ static void apic_mem_write(void *opaque, hwaddr addr, uint64_t val,
         break;
     default:
         s->esr |= APIC_ESR_ILLEGAL_ADDRESS;
-        break;
+        return -1;
     }
+
+    return 0;
+}
+
+static void apic_mem_write(void *opaque, hwaddr addr, uint64_t val,
+                           unsigned size)
+{
+    int index = (addr >> 4) & 0xff;
+
+    if (size < 4) {
+        return;
+    }
+
+    if (addr > 0xfff || !index) {
+        /*
+         * MSI and MMIO APIC are at the same memory location,
+         * but actually not on the global bus: MSI is on PCI bus
+         * APIC is connected directly to the CPU.
+         * Mapping them on the global bus happens to work because
+         * MSI registers are reserved in APIC MMIO and vice versa.
+         */
+        MSIMessage msi = { .address = addr, .data = val };
+        apic_send_msi(&msi);
+        return;
+    }
+
+    apic_register_write(index, val);
+}
+
+int apic_msr_write(int index, uint64_t val)
+{
+    DeviceState *dev;
+
+    dev = cpu_get_current_apic();
+    if (!dev) {
+        return -1;
+    }
+
+    if (!is_x2apic_mode(dev)) {
+        return -1;
+    }
+
+    return apic_register_write(index, val);
 }
 
 static void apic_pre_save(APICCommonState *s)
diff --git a/target/i386/tcg/sysemu/misc_helper.c b/target/i386/tcg/sysemu/misc_helper.c
index 1ddfc9fe09..1c43a9f4f7 100644
--- a/target/i386/tcg/sysemu/misc_helper.c
+++ b/target/i386/tcg/sysemu/misc_helper.c
@@ -25,6 +25,7 @@
 #include "exec/address-spaces.h"
 #include "exec/exec-all.h"
 #include "tcg/helper-tcg.h"
+#include "hw/i386/apic.h"
 
 void helper_outb(CPUX86State *env, uint32_t port, uint32_t data)
 {
@@ -289,6 +290,19 @@ void helper_wrmsr(CPUX86State *env)
         env->msr_bndcfgs = val;
         cpu_sync_bndcs_hflags(env);
         break;
+    case MSR_APIC_START ... MSR_APIC_END: {
+        int ret;
+        int index = (uint32_t)env->regs[R_ECX] - MSR_APIC_START;
+
+        bql_lock();
+        ret = apic_msr_write(index, val);
+        bql_unlock();
+        if (ret < 0) {
+            goto error;
+        }
+
+        break;
+    }
     default:
         if ((uint32_t)env->regs[R_ECX] >= MSR_MC0_CTL
             && (uint32_t)env->regs[R_ECX] < MSR_MC0_CTL +
@@ -455,6 +469,19 @@ void helper_rdmsr(CPUX86State *env)
         val = (cs->nr_threads * cs->nr_cores) | (cs->nr_cores << 16);
         break;
     }
+    case MSR_APIC_START ... MSR_APIC_END: {
+        int ret;
+        int index = (uint32_t)env->regs[R_ECX] - MSR_APIC_START;
+
+        bql_lock();
+        ret = apic_msr_read(index, &val);
+        bql_unlock();
+        if (ret < 0) {
+            raise_exception_err_ra(env, EXCP0D_GPF, 0, GETPC());
+        }
+
+        break;
+    }
     default:
         if ((uint32_t)env->regs[R_ECX] >= MSR_MC0_CTL
             && (uint32_t)env->regs[R_ECX] < MSR_MC0_CTL +
diff --git a/hw/intc/trace-events b/hw/intc/trace-events
index 36ff71f947..1ef29d0256 100644
--- a/hw/intc/trace-events
+++ b/hw/intc/trace-events
@@ -14,8 +14,8 @@ cpu_get_apic_base(uint64_t val) "0x%016"PRIx64
 # apic.c
 apic_local_deliver(int vector, uint32_t lvt) "vector %d delivery mode %d"
 apic_deliver_irq(uint8_t dest, uint8_t dest_mode, uint8_t delivery_mode, uint8_t vector_num, uint8_t trigger_mode) "dest %d dest_mode %d delivery_mode %d vector %d trigger_mode %d"
-apic_mem_readl(uint64_t addr, uint32_t val)  "0x%"PRIx64" = 0x%08x"
-apic_mem_writel(uint64_t addr, uint32_t val) "0x%"PRIx64" = 0x%08x"
+apic_register_read(uint8_t reg, uint64_t val) "register 0x%02x = 0x%"PRIx64
+apic_register_write(uint8_t reg, uint64_t val) "register 0x%02x = 0x%"PRIx64
 
 # ioapic.c
 ioapic_set_remote_irr(int n) "set remote irr for pin %d"
-- 
MST


