Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6534C4345F
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2024 15:50:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2YhH-0007tJ-NC; Thu, 02 May 2024 11:50:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s2YhE-0007si-Bb
 for qemu-devel@nongnu.org; Thu, 02 May 2024 11:50:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s2YhC-0001iK-G7
 for qemu-devel@nongnu.org; Thu, 02 May 2024 11:50:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714665005;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=FZqkYH2xV60DtnOIeX+F6KC+s+0/Oyj82Gs+VdqvN3E=;
 b=YaO7ULHADIakSlKd0E8FAuvs6VFUTa+D9BWM8n0upX2HCvlv4h+0yFaRz9jEDF/3leed0R
 /87d4DeWBK1rixmJSJfGodPD1VYSAL1CxSF3L4Nxccft6ycokTsgcdlkgEO3isDgvkNVLg
 kak+pRhEL0hwAnN1f+/J84jrBuvPhRw=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-290-35arZaLsOZqrnO8TFsarQQ-1; Thu, 02 May 2024 11:50:04 -0400
X-MC-Unique: 35arZaLsOZqrnO8TFsarQQ-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a55a8c841e8so427258766b.2
 for <qemu-devel@nongnu.org>; Thu, 02 May 2024 08:50:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714665002; x=1715269802;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FZqkYH2xV60DtnOIeX+F6KC+s+0/Oyj82Gs+VdqvN3E=;
 b=M/SMYxGhm0RII2QZxJMZoa+kGsGQB2tP84CBk3Gdk7AmhWj1e0faWjX7hBh2yOVrDv
 jV2KR8OZmaueI9reb53gGpZhqIVOGZQI5CoSCSBwfr38rm0oG5wc1JXToe2c7u57EZ3I
 qAFRy7pBuDoFF9jYGO5lWnPx3L8Oou9Yh/ZRHLw0T7Oj48FqV9mfjiwgJgje1nIdSRV/
 H9W5EBFx4RSKkU5SAV+6k0ccjo8IbEsGoL+N93YuVm6AFmRVtVon0Ig5Ldh9bImasWto
 gEGHnQoPcTBx02RNLSyPbJNEcaAM2Gih3kRVQL64WON1mLVEYfbCw2AEgkoL0G4rs1NJ
 mQeA==
X-Gm-Message-State: AOJu0Yy8rBEfUV+h8AzJ0rA038tj0Mal/QYxMU+bTKAGD8uraWsZXVVY
 w4aZOdjyDhX6IC628RQeSibZRWxKpOSt6sqbiUWMz4oWtu9ifI7RQc7XPmZuyED3qGnDXezGnLw
 xzE8bwB5Fuc7ABjOfzxJ3nIUiI68LSJOo9/LRSEZVs0hXIcAzqRIRthbzZW8voZhHAzXpJT2kmE
 D8uLp/uROAaYK6xSoQXoR5eecETFWXQ6XBqMpl
X-Received: by 2002:a17:906:4ed1:b0:a58:ea69:97e2 with SMTP id
 i17-20020a1709064ed100b00a58ea6997e2mr2209522ejv.6.1714665002439; 
 Thu, 02 May 2024 08:50:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEd42Vm/kj6Nv8UzdFwgK8wCrTkvILJORbzKWFv3wY6kW/wHbLNSc7oJyusotE9ljzpiRKD+g==
X-Received: by 2002:a17:906:4ed1:b0:a58:ea69:97e2 with SMTP id
 i17-20020a1709064ed100b00a58ea6997e2mr2209496ejv.6.1714665001811; 
 Thu, 02 May 2024 08:50:01 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 s20-20020a170906061400b00a52274ee0a7sm700137ejb.171.2024.05.02.08.50.01
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 May 2024 08:50:01 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] kvm: move target-dependent interrupt routing out of kvm-all.c
Date: Thu,  2 May 2024 17:49:59 +0200
Message-ID: <20240502154959.108165-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.476,
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

Let hw/hyperv/hyperv.c and hw/intc/s390_flic.c handle (respectively)
SynIC and adapter routes, removing the code from target-independent
files.  This also removes the only occurrence of AdapterInfo outside
s390 code, so remove that from typedefs.h.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/qemu/typedefs.h |  1 -
 include/sysemu/kvm.h    |  5 ++--
 accel/kvm/kvm-all.c     | 62 ++---------------------------------------
 hw/hyperv/hyperv.c      | 25 +++++++++++++++++
 hw/intc/s390_flic.c     | 28 +++++++++++++++++++
 5 files changed, 59 insertions(+), 62 deletions(-)

diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
index 5d999e20d7c..2ff50bf5970 100644
--- a/include/qemu/typedefs.h
+++ b/include/qemu/typedefs.h
@@ -23,7 +23,6 @@
  */
 typedef struct AccelCPUState AccelCPUState;
 typedef struct AccelState AccelState;
-typedef struct AdapterInfo AdapterInfo;
 typedef struct AddressSpace AddressSpace;
 typedef struct AioContext AioContext;
 typedef struct Aml Aml;
diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
index eaf801bc934..c31d9c73566 100644
--- a/include/sysemu/kvm.h
+++ b/include/sysemu/kvm.h
@@ -470,10 +470,11 @@ static inline void kvm_irqchip_commit_route_changes(KVMRouteChange *c)
     }
 }
 
+int kvm_irqchip_get_virq(KVMState *s);
 void kvm_irqchip_release_virq(KVMState *s, int virq);
 
-int kvm_irqchip_add_adapter_route(KVMState *s, AdapterInfo *adapter);
-int kvm_irqchip_add_hv_sint_route(KVMState *s, uint32_t vcpu, uint32_t sint);
+void kvm_add_routing_entry(KVMState *s,
+                           struct kvm_irq_routing_entry *entry);
 
 int kvm_irqchip_add_irqfd_notifier_gsi(KVMState *s, EventNotifier *n,
                                        EventNotifier *rn, int virq);
diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index d7281b93f3b..c0be9f5eedb 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -1909,8 +1909,8 @@ void kvm_irqchip_commit_routes(KVMState *s)
     assert(ret == 0);
 }
 
-static void kvm_add_routing_entry(KVMState *s,
-                                  struct kvm_irq_routing_entry *entry)
+void kvm_add_routing_entry(KVMState *s,
+                           struct kvm_irq_routing_entry *entry)
 {
     struct kvm_irq_routing_entry *new;
     int n, size;
@@ -2007,7 +2007,7 @@ void kvm_irqchip_change_notify(void)
     notifier_list_notify(&kvm_irqchip_change_notifiers, NULL);
 }
 
-static int kvm_irqchip_get_virq(KVMState *s)
+int kvm_irqchip_get_virq(KVMState *s)
 {
     int next_virq;
 
@@ -2165,62 +2165,6 @@ static int kvm_irqchip_assign_irqfd(KVMState *s, EventNotifier *event,
     return kvm_vm_ioctl(s, KVM_IRQFD, &irqfd);
 }
 
-int kvm_irqchip_add_adapter_route(KVMState *s, AdapterInfo *adapter)
-{
-    struct kvm_irq_routing_entry kroute = {};
-    int virq;
-
-    if (!kvm_gsi_routing_enabled()) {
-        return -ENOSYS;
-    }
-
-    virq = kvm_irqchip_get_virq(s);
-    if (virq < 0) {
-        return virq;
-    }
-
-    kroute.gsi = virq;
-    kroute.type = KVM_IRQ_ROUTING_S390_ADAPTER;
-    kroute.flags = 0;
-    kroute.u.adapter.summary_addr = adapter->summary_addr;
-    kroute.u.adapter.ind_addr = adapter->ind_addr;
-    kroute.u.adapter.summary_offset = adapter->summary_offset;
-    kroute.u.adapter.ind_offset = adapter->ind_offset;
-    kroute.u.adapter.adapter_id = adapter->adapter_id;
-
-    kvm_add_routing_entry(s, &kroute);
-
-    return virq;
-}
-
-int kvm_irqchip_add_hv_sint_route(KVMState *s, uint32_t vcpu, uint32_t sint)
-{
-    struct kvm_irq_routing_entry kroute = {};
-    int virq;
-
-    if (!kvm_gsi_routing_enabled()) {
-        return -ENOSYS;
-    }
-    if (!kvm_check_extension(s, KVM_CAP_HYPERV_SYNIC)) {
-        return -ENOSYS;
-    }
-    virq = kvm_irqchip_get_virq(s);
-    if (virq < 0) {
-        return virq;
-    }
-
-    kroute.gsi = virq;
-    kroute.type = KVM_IRQ_ROUTING_HV_SINT;
-    kroute.flags = 0;
-    kroute.u.hv_sint.vcpu = vcpu;
-    kroute.u.hv_sint.sint = sint;
-
-    kvm_add_routing_entry(s, &kroute);
-    kvm_irqchip_commit_routes(s);
-
-    return virq;
-}
-
 #else /* !KVM_CAP_IRQ_ROUTING */
 
 void kvm_init_irq_routing(KVMState *s)
diff --git a/hw/hyperv/hyperv.c b/hw/hyperv/hyperv.c
index 3ea54ba818b..3d85573efa3 100644
--- a/hw/hyperv/hyperv.c
+++ b/hw/hyperv/hyperv.c
@@ -373,6 +373,31 @@ int hyperv_set_event_flag(HvSintRoute *sint_route, unsigned eventno)
     return ret;
 }
 
+int kvm_irqchip_add_hv_sint_route(KVMState *s, uint32_t vcpu, uint32_t sint)
+{
+    struct kvm_irq_routing_entry kroute = {};
+    int virq;
+
+    if (!kvm_gsi_routing_enabled()) {
+        return -ENOSYS;
+    }
+    virq = kvm_irqchip_get_virq(s);
+    if (virq < 0) {
+        return virq;
+    }
+
+    kroute.gsi = virq;
+    kroute.type = KVM_IRQ_ROUTING_HV_SINT;
+    kroute.flags = 0;
+    kroute.u.hv_sint.vcpu = vcpu;
+    kroute.u.hv_sint.sint = sint;
+
+    kvm_add_routing_entry(s, &kroute);
+    kvm_irqchip_commit_routes(s);
+
+    return virq;
+}
+
 HvSintRoute *hyperv_sint_route_new(uint32_t vp_index, uint32_t sint,
                                    HvSintMsgCb cb, void *cb_data)
 {
diff --git a/hw/intc/s390_flic.c b/hw/intc/s390_flic.c
index f4a848460b8..a658252fc8a 100644
--- a/hw/intc/s390_flic.c
+++ b/hw/intc/s390_flic.c
@@ -23,6 +23,34 @@
 #include "qapi/error.h"
 #include "hw/s390x/s390-virtio-ccw.h"
 
+static int kvm_irqchip_add_adapter_route(KVMState *s, AdapterInfo *adapter)
+{
+    struct kvm_irq_routing_entry kroute = {};
+    int virq;
+
+    if (!kvm_gsi_routing_enabled()) {
+        return -ENOSYS;
+    }
+
+    virq = kvm_irqchip_get_virq(s);
+    if (virq < 0) {
+        return virq;
+    }
+
+    kroute.gsi = virq;
+    kroute.type = KVM_IRQ_ROUTING_S390_ADAPTER;
+    kroute.flags = 0;
+    kroute.u.adapter.summary_addr = adapter->summary_addr;
+    kroute.u.adapter.ind_addr = adapter->ind_addr;
+    kroute.u.adapter.summary_offset = adapter->summary_offset;
+    kroute.u.adapter.ind_offset = adapter->ind_offset;
+    kroute.u.adapter.adapter_id = adapter->adapter_id;
+
+    kvm_add_routing_entry(s, &kroute);
+
+    return virq;
+}
+
 S390FLICStateClass *s390_get_flic_class(S390FLICState *fs)
 {
     static S390FLICStateClass *class;
-- 
2.44.0


