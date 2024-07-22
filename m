Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4D52C3DA61
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 00:23:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVgkw-00006i-FR; Sun, 21 Jul 2024 20:18:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sVgks-0008Cj-A4
 for qemu-devel@nongnu.org; Sun, 21 Jul 2024 20:18:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sVgkq-0005so-1P
 for qemu-devel@nongnu.org; Sun, 21 Jul 2024 20:18:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721607495;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gJr1WpFyP035ncVh4reYlb2V1cyFXZTXswtAGoUIz8s=;
 b=hQRQHs1E3WIHJySdgU5CE/KhIcfDGwv+/iPvKHQprQyyvBROAkkolUVS1VTCuvuTrLdxqn
 l4tPPITlVgm+CxEX/favgX+Fcm5VABgvALj9m30JDfQ2dDRX//Zd/YoBzuij3P578FDc+L
 /XFJMPiD0SiWn5/Hw7DcF/HkWJAf0IQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-mm-JpQqPPn-mX0o2sRC4qQ-1; Sun, 21 Jul 2024 20:18:13 -0400
X-MC-Unique: mm-JpQqPPn-mX0o2sRC4qQ-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-42794cb8251so27670125e9.2
 for <qemu-devel@nongnu.org>; Sun, 21 Jul 2024 17:18:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721607491; x=1722212291;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gJr1WpFyP035ncVh4reYlb2V1cyFXZTXswtAGoUIz8s=;
 b=CzyAI0imxtqXpZGhbZ3l44HIrdxDqmvTWDTmzPOy3HkgTRMtlWDZiGDPwtUnM+dbrm
 lNl0B0bbDrUWVPoJGRtLbNX6BAAxHggiypUpCmZvN/pvHiO0uJ5U4VUTgUC/RuWzKj82
 DXZYc27py3wgKP+dzBOwImLMZ4iE6k9lRVsqe/D2VwYPIndsPfzT5VBqg01KaHHgCFHs
 zP74GaEo2yFrir4sz8vdlovuP7GHUPcZyE4OISGfQDOPV+cL3PHamROtmjBmakoOtnr+
 n7zfAC0AOAYmwdR3dV6xjBFpzIL5HEwS6Vl1SaJL1ziJ2cqFsyknzbJc6wSCkq4EBO+G
 VOhA==
X-Gm-Message-State: AOJu0Yw7CtVgYkyEfO9JuEV2IMHPPbRs+MhKcKPydRSOKKwG/Enec9B5
 qaLieY9o9aRt2zpuKBLFsceObHelaWKNMwTJS6RWHjla9snz0QtxjMRvKpO1MGKz3iMBr6ycctf
 AEs32PpTI27ZSLJsDIIPi8UOVr/pIcCwele9MqTdloi5dplF1zfetjJLX6d57GncU1SGvGbbo2V
 4tbG89CsaHwSsQqrM5a6jWuz8PfZIhFg==
X-Received: by 2002:a05:600c:1c09:b0:426:8884:3781 with SMTP id
 5b1f17b1804b1-427daa61ca9mr38652365e9.24.1721607491639; 
 Sun, 21 Jul 2024 17:18:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFp6+9baDwsEiyEPnA7xIaxHkcyq2LXt0iMcBVbyVGBbQ+k+uHq2tc7uERjPkGcHeAVyTHa5g==
X-Received: by 2002:a05:600c:1c09:b0:426:8884:3781 with SMTP id
 5b1f17b1804b1-427daa61ca9mr38652065e9.24.1721607491075; 
 Sun, 21 Jul 2024 17:18:11 -0700 (PDT)
Received: from redhat.com (mob-5-90-113-158.net.vodafone.it. [5.90.113.158])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3687868b24csm6992468f8f.25.2024.07.21.17.18.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Jul 2024 17:18:10 -0700 (PDT)
Date: Sun, 21 Jul 2024 20:18:08 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Salil Mehta <salil.mehta@huawei.com>, Gavin Shan <gshan@redhat.com>,
 Vishnu Pajjuri <vishnu@os.amperecomputing.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Xianglai Li <lixianglai@loongson.cn>, Miguel Luis <miguel.luis@oracle.com>,
 Shaoqin Huang <shahuang@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>, Zhao Liu <zhao1.liu@intel.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
Subject: [PULL 38/63] accel/kvm: Extract common KVM vCPU {creation,parking}
 code
Message-ID: <5a847065050b8bef70a8819ecc057b6103798514.1721607331.git.mst@redhat.com>
References: <cover.1721607331.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1721607331.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

From: Salil Mehta <salil.mehta@huawei.com>

KVM vCPU creation is done once during the vCPU realization when Qemu vCPU thread
is spawned. This is common to all the architectures as of now.

Hot-unplug of vCPU results in destruction of the vCPU object in QOM but the
corresponding KVM vCPU object in the Host KVM is not destroyed as KVM doesn't
support vCPU removal. Therefore, its representative KVM vCPU object/context in
Qemu is parked.

Refactor architecture common logic so that some APIs could be reused by vCPU
Hotplug code of some architectures likes ARM, Loongson etc. Update new/old APIs
with trace events. New APIs qemu_{create,park,unpark}_vcpu() can be externally
called. No functional change is intended here.

Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
Reviewed-by: Gavin Shan <gshan@redhat.com>
Tested-by: Vishnu Pajjuri <vishnu@os.amperecomputing.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Tested-by: Xianglai Li <lixianglai@loongson.cn>
Tested-by: Miguel Luis <miguel.luis@oracle.com>
Reviewed-by: Shaoqin Huang <shahuang@redhat.com>
Reviewed-by: Vishnu Pajjuri <vishnu@os.amperecomputing.com>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Tested-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <20240716111502.202344-2-salil.mehta@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 accel/kvm/kvm-cpus.h   |  1 -
 include/sysemu/kvm.h   | 25 +++++++++++
 accel/kvm/kvm-all.c    | 95 ++++++++++++++++++++++++++++--------------
 accel/kvm/trace-events |  5 ++-
 4 files changed, 92 insertions(+), 34 deletions(-)

diff --git a/accel/kvm/kvm-cpus.h b/accel/kvm/kvm-cpus.h
index ca40add32c..171b22fd29 100644
--- a/accel/kvm/kvm-cpus.h
+++ b/accel/kvm/kvm-cpus.h
@@ -22,5 +22,4 @@ bool kvm_supports_guest_debug(void);
 int kvm_insert_breakpoint(CPUState *cpu, int type, vaddr addr, vaddr len);
 int kvm_remove_breakpoint(CPUState *cpu, int type, vaddr addr, vaddr len);
 void kvm_remove_all_breakpoints(CPUState *cpu);
-
 #endif /* KVM_CPUS_H */
diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
index c31d9c7356..c4a914b3d8 100644
--- a/include/sysemu/kvm.h
+++ b/include/sysemu/kvm.h
@@ -313,6 +313,31 @@ int kvm_create_device(KVMState *s, uint64_t type, bool test);
  */
 bool kvm_device_supported(int vmfd, uint64_t type);
 
+/**
+ * kvm_create_vcpu - Gets a parked KVM vCPU or creates a KVM vCPU
+ * @cpu: QOM CPUState object for which KVM vCPU has to be fetched/created.
+ *
+ * @returns: 0 when success, errno (<0) when failed.
+ */
+int kvm_create_vcpu(CPUState *cpu);
+
+/**
+ * kvm_park_vcpu - Park QEMU KVM vCPU context
+ * @cpu: QOM CPUState object for which QEMU KVM vCPU context has to be parked.
+ *
+ * @returns: none
+ */
+void kvm_park_vcpu(CPUState *cpu);
+
+/**
+ * kvm_unpark_vcpu - unpark QEMU KVM vCPU context
+ * @s: KVM State
+ * @vcpu_id: Architecture vCPU ID of the parked vCPU
+ *
+ * @returns: KVM fd
+ */
+int kvm_unpark_vcpu(KVMState *s, unsigned long vcpu_id);
+
 /* Arch specific hooks */
 
 extern const KVMCapabilityInfo kvm_arch_required_capabilities[];
diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 64bf47a033..0f110cce3e 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -340,14 +340,71 @@ err:
     return ret;
 }
 
+void kvm_park_vcpu(CPUState *cpu)
+{
+    struct KVMParkedVcpu *vcpu;
+
+    trace_kvm_park_vcpu(cpu->cpu_index, kvm_arch_vcpu_id(cpu));
+
+    vcpu = g_malloc0(sizeof(*vcpu));
+    vcpu->vcpu_id = kvm_arch_vcpu_id(cpu);
+    vcpu->kvm_fd = cpu->kvm_fd;
+    QLIST_INSERT_HEAD(&kvm_state->kvm_parked_vcpus, vcpu, node);
+}
+
+int kvm_unpark_vcpu(KVMState *s, unsigned long vcpu_id)
+{
+    struct KVMParkedVcpu *cpu;
+    int kvm_fd = -ENOENT;
+
+    QLIST_FOREACH(cpu, &s->kvm_parked_vcpus, node) {
+        if (cpu->vcpu_id == vcpu_id) {
+            QLIST_REMOVE(cpu, node);
+            kvm_fd = cpu->kvm_fd;
+            g_free(cpu);
+        }
+    }
+
+    trace_kvm_unpark_vcpu(vcpu_id, kvm_fd > 0 ? "unparked" : "!found parked");
+
+    return kvm_fd;
+}
+
+int kvm_create_vcpu(CPUState *cpu)
+{
+    unsigned long vcpu_id = kvm_arch_vcpu_id(cpu);
+    KVMState *s = kvm_state;
+    int kvm_fd;
+
+    /* check if the KVM vCPU already exist but is parked */
+    kvm_fd = kvm_unpark_vcpu(s, vcpu_id);
+    if (kvm_fd < 0) {
+        /* vCPU not parked: create a new KVM vCPU */
+        kvm_fd = kvm_vm_ioctl(s, KVM_CREATE_VCPU, vcpu_id);
+        if (kvm_fd < 0) {
+            error_report("KVM_CREATE_VCPU IOCTL failed for vCPU %lu", vcpu_id);
+            return kvm_fd;
+        }
+    }
+
+    cpu->kvm_fd = kvm_fd;
+    cpu->kvm_state = s;
+    cpu->vcpu_dirty = true;
+    cpu->dirty_pages = 0;
+    cpu->throttle_us_per_full = 0;
+
+    trace_kvm_create_vcpu(cpu->cpu_index, vcpu_id, kvm_fd);
+
+    return 0;
+}
+
 static int do_kvm_destroy_vcpu(CPUState *cpu)
 {
     KVMState *s = kvm_state;
     long mmap_size;
-    struct KVMParkedVcpu *vcpu = NULL;
     int ret = 0;
 
-    trace_kvm_destroy_vcpu();
+    trace_kvm_destroy_vcpu(cpu->cpu_index, kvm_arch_vcpu_id(cpu));
 
     ret = kvm_arch_destroy_vcpu(cpu);
     if (ret < 0) {
@@ -373,10 +430,7 @@ static int do_kvm_destroy_vcpu(CPUState *cpu)
         }
     }
 
-    vcpu = g_malloc0(sizeof(*vcpu));
-    vcpu->vcpu_id = kvm_arch_vcpu_id(cpu);
-    vcpu->kvm_fd = cpu->kvm_fd;
-    QLIST_INSERT_HEAD(&kvm_state->kvm_parked_vcpus, vcpu, node);
+    kvm_park_vcpu(cpu);
 err:
     return ret;
 }
@@ -389,24 +443,6 @@ void kvm_destroy_vcpu(CPUState *cpu)
     }
 }
 
-static int kvm_get_vcpu(KVMState *s, unsigned long vcpu_id)
-{
-    struct KVMParkedVcpu *cpu;
-
-    QLIST_FOREACH(cpu, &s->kvm_parked_vcpus, node) {
-        if (cpu->vcpu_id == vcpu_id) {
-            int kvm_fd;
-
-            QLIST_REMOVE(cpu, node);
-            kvm_fd = cpu->kvm_fd;
-            g_free(cpu);
-            return kvm_fd;
-        }
-    }
-
-    return kvm_vm_ioctl(s, KVM_CREATE_VCPU, (void *)vcpu_id);
-}
-
 int kvm_init_vcpu(CPUState *cpu, Error **errp)
 {
     KVMState *s = kvm_state;
@@ -415,19 +451,14 @@ int kvm_init_vcpu(CPUState *cpu, Error **errp)
 
     trace_kvm_init_vcpu(cpu->cpu_index, kvm_arch_vcpu_id(cpu));
 
-    ret = kvm_get_vcpu(s, kvm_arch_vcpu_id(cpu));
+    ret = kvm_create_vcpu(cpu);
     if (ret < 0) {
-        error_setg_errno(errp, -ret, "kvm_init_vcpu: kvm_get_vcpu failed (%lu)",
+        error_setg_errno(errp, -ret,
+                         "kvm_init_vcpu: kvm_create_vcpu failed (%lu)",
                          kvm_arch_vcpu_id(cpu));
         goto err;
     }
 
-    cpu->kvm_fd = ret;
-    cpu->kvm_state = s;
-    cpu->vcpu_dirty = true;
-    cpu->dirty_pages = 0;
-    cpu->throttle_us_per_full = 0;
-
     mmap_size = kvm_ioctl(s, KVM_GET_VCPU_MMAP_SIZE, 0);
     if (mmap_size < 0) {
         ret = mmap_size;
diff --git a/accel/kvm/trace-events b/accel/kvm/trace-events
index 681ccb667d..37626c1ac5 100644
--- a/accel/kvm/trace-events
+++ b/accel/kvm/trace-events
@@ -9,6 +9,10 @@ kvm_device_ioctl(int fd, int type, void *arg) "dev fd %d, type 0x%x, arg %p"
 kvm_failed_reg_get(uint64_t id, const char *msg) "Warning: Unable to retrieve ONEREG %" PRIu64 " from KVM: %s"
 kvm_failed_reg_set(uint64_t id, const char *msg) "Warning: Unable to set ONEREG %" PRIu64 " to KVM: %s"
 kvm_init_vcpu(int cpu_index, unsigned long arch_cpu_id) "index: %d id: %lu"
+kvm_create_vcpu(int cpu_index, unsigned long arch_cpu_id, int kvm_fd) "index: %d, id: %lu, kvm fd: %d"
+kvm_destroy_vcpu(int cpu_index, unsigned long arch_cpu_id) "index: %d id: %lu"
+kvm_park_vcpu(int cpu_index, unsigned long arch_cpu_id) "index: %d id: %lu"
+kvm_unpark_vcpu(unsigned long arch_cpu_id, const char *msg) "id: %lu %s"
 kvm_irqchip_commit_routes(void) ""
 kvm_irqchip_add_msi_route(char *name, int vector, int virq) "dev %s vector %d virq %d"
 kvm_irqchip_update_msi_route(int virq) "Updating MSI route virq=%d"
@@ -25,7 +29,6 @@ kvm_dirty_ring_reaper(const char *s) "%s"
 kvm_dirty_ring_reap(uint64_t count, int64_t t) "reaped %"PRIu64" pages (took %"PRIi64" us)"
 kvm_dirty_ring_reaper_kick(const char *reason) "%s"
 kvm_dirty_ring_flush(int finished) "%d"
-kvm_destroy_vcpu(void) ""
 kvm_failed_get_vcpu_mmap_size(void) ""
 kvm_cpu_exec(void) ""
 kvm_interrupt_exit_request(void) ""
-- 
MST


