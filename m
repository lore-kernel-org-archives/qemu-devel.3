Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DCF8C4345F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 07:55:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3tAk-0001kt-Ii; Mon, 06 May 2024 03:54:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s3tA2-0008Tt-RR
 for qemu-devel@nongnu.org; Mon, 06 May 2024 03:53:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s3tA0-0001or-TW
 for qemu-devel@nongnu.org; Mon, 06 May 2024 03:53:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714982000;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=B5HjsvcOl2UMW2kd+0qfMXmm+QI4Al82cfzwR58R5Iw=;
 b=Ddo6VDZhV2pwUeFW8h4K5MKVsPHkTLlcepVDT640ubYqEjIyUIZqJnR/9ZHvVGqT0jWLE+
 2ZHmivjFXXtoqZXfMPsduajlT7baK/pW5OtZLqMSe0ry+vBF0moUV2O1pPnZxheXYylAds
 sHydh8NGeKUa58JLvqXfuVXf7cCE7l0=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-529-xVBLdwATP7KZnoUfs8KYwA-1; Mon, 06 May 2024 03:53:18 -0400
X-MC-Unique: xVBLdwATP7KZnoUfs8KYwA-1
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-5725f45da8eso311820a12.0
 for <qemu-devel@nongnu.org>; Mon, 06 May 2024 00:53:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714981997; x=1715586797;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B5HjsvcOl2UMW2kd+0qfMXmm+QI4Al82cfzwR58R5Iw=;
 b=VFVY/O7Vdqbi6ks5PLllkQw94Rv8+QS6OSuWEa3W9c90pBAbMCfWAn6HsKpqS8jlu0
 SFyGOeBGuePQ5ZuNCcYlj9+IOtDr9y8cB6nQ8OYkEoiFuepy5ISjNV4mYQ4ioBmTWE/U
 yuVMtPvUxCxC2XLTMmgvhVioD3wvQCb2bih/mvgP1pouosMFmU5kLoP9RVGlkbpQ58l4
 1Fd7KFwGA4S8qc8hTlPVyQXurGZ770TN/2mKmRrQwVOK6MwwiMlS2ACkPw3oboUdvoPI
 UFaXYDkdBmmNVxToLDlxfA2XcJueYyRI+4JJZOq+zSwePwqO3O3vci+gnSI+0GJNhs8x
 HsWw==
X-Gm-Message-State: AOJu0YxigZirI4S0/P1agYQIm8oXLsHjQ5xHjnevGt+r9jGRbnXo2qc9
 m4SLIw21cSaoNnNbS1wCD55d9j3UG0Q6w+MjLq25UxbinisSjjEL6JcMCGh6WR7Cat+UVcXV903
 C/8PzKjWXv36iz4tEP3DusO7W/+WXmrCK4ZCnt0Id/LfWIbgsipfYKnBSlKq7J8GcIHY6JXvRto
 HAYGcLxydNZ1GY16/rco0rU2Y6MZxYxRNSHM4f
X-Received: by 2002:a50:aadc:0:b0:56f:e4f7:fbd9 with SMTP id
 r28-20020a50aadc000000b0056fe4f7fbd9mr6111765edc.20.1714981997022; 
 Mon, 06 May 2024 00:53:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFkXRb2XIWOBMaN8DgaSx3nuLesMCNot8X0Y/udzJQl6Rcrrs27An34u8lK1qCq0218TvSXiQ==
X-Received: by 2002:a50:aadc:0:b0:56f:e4f7:fbd9 with SMTP id
 r28-20020a50aadc000000b0056fe4f7fbd9mr6111752edc.20.1714981996599; 
 Mon, 06 May 2024 00:53:16 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 h25-20020a0564020e9900b00572cfb37bd6sm4047294eda.8.2024.05.06.00.53.16
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 May 2024 00:53:16 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 44/46] kvm: move target-dependent interrupt routing out of
 kvm-all.c
Date: Mon,  6 May 2024 09:51:23 +0200
Message-ID: <20240506075125.8238-45-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240506075125.8238-1-pbonzini@redhat.com>
References: <20240506075125.8238-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.431,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
 include/hw/s390x/adapter.h |  4 +--
 include/qemu/typedefs.h    |  1 -
 include/sysemu/kvm.h       |  5 +--
 accel/kvm/kvm-all.c        | 62 ++------------------------------------
 hw/hyperv/hyperv.c         | 25 +++++++++++++++
 hw/intc/s390_flic_kvm.c    | 28 +++++++++++++++++
 6 files changed, 61 insertions(+), 64 deletions(-)

diff --git a/include/hw/s390x/adapter.h b/include/hw/s390x/adapter.h
index 7f1703508c4..d4fadc4f7f8 100644
--- a/include/hw/s390x/adapter.h
+++ b/include/hw/s390x/adapter.h
@@ -12,12 +12,12 @@
 #ifndef S390X_ADAPTER_H
 #define S390X_ADAPTER_H
 
-struct AdapterInfo {
+typedef struct AdapterInfo {
     uint64_t ind_addr;
     uint64_t summary_addr;
     uint64_t ind_offset;
     uint32_t summary_offset;
     uint32_t adapter_id;
-};
+} AdapterInfo;
 
 #endif
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
index 3ea54ba818b..483dcca3083 100644
--- a/hw/hyperv/hyperv.c
+++ b/hw/hyperv/hyperv.c
@@ -373,6 +373,31 @@ int hyperv_set_event_flag(HvSintRoute *sint_route, unsigned eventno)
     return ret;
 }
 
+static int kvm_irqchip_add_hv_sint_route(KVMState *s, uint32_t vcpu, uint32_t sint)
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
diff --git a/hw/intc/s390_flic_kvm.c b/hw/intc/s390_flic_kvm.c
index baaa30dcb73..330f08dfdc2 100644
--- a/hw/intc/s390_flic_kvm.c
+++ b/hw/intc/s390_flic_kvm.c
@@ -324,6 +324,34 @@ static int kvm_s390_io_adapter_map(S390FLICState *fs, uint32_t id,
     return r ? -errno : 0;
 }
 
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
 static int kvm_s390_add_adapter_routes(S390FLICState *fs,
                                        AdapterRoutes *routes)
 {
-- 
2.44.0


