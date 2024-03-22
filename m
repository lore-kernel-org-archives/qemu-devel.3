Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C1B0C54E71
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Mar 2024 18:16:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnjNa-0007j9-6l; Fri, 22 Mar 2024 14:12:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rnjNV-00079i-PV
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 14:12:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rnjNE-00073E-58
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 14:12:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711131131;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=glw032yBeIofkVgO0zZmbqSSWrrsI8f/pRheVVoaBak=;
 b=dVV0FNGvdPj3MQeTf21YJEincnKZOo6g4uS9bPQq/R5dxod3OKj4eTTQJsi8zKvOvM5xO0
 PK4NKH8q0UQAbNUcPzKeYsBWhGW403kDQTsq3bvus+BkDBRoJ1sJ7iTxLABINrJZAczbUf
 QCdtmRj4Ztla8JAhYhcdhdLQofu/qGc=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-153-Tw3O3nnGMfyTcYVPdp2NeQ-1; Fri, 22 Mar 2024 14:12:09 -0400
X-MC-Unique: Tw3O3nnGMfyTcYVPdp2NeQ-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a473ac9d263so23012166b.1
 for <qemu-devel@nongnu.org>; Fri, 22 Mar 2024 11:12:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711131127; x=1711735927;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=glw032yBeIofkVgO0zZmbqSSWrrsI8f/pRheVVoaBak=;
 b=UR+NvpsijiTHmOSAQxSMstoxTEqTeQbIPSPu4p/7mbsrHOgiDqx3GnoFLvaf7gMF9L
 HIuDSuf/SrgyCCNjEaWHw3xyxbT50R09oJWaHkdciN5mIR+8dEn4b3rRGrm2ZPzt9oPF
 jSkYUr38wrA981QSsMfn1bRZdsu7DDQlpW16CO+05PELnBRucqdL0E0MZ5s/fZiQOPU8
 5UMds9Fb0+i6g3Yr+ZXruv4uKo2wB35fwpuHC8F/RWRcfPDRYag4ivmE5/px3zq9NSPu
 +gdG78nW7D6hc5wtzEAYfpX5wxPOuwKLi8t8SuFxUvHn9o8PWbJa2gumq0rCOJHTEfbZ
 6fPg==
X-Gm-Message-State: AOJu0YyM66rc0QWCYUp+exq2GFdK0RX2uJ6xbyHCXNuG37CGs3ToKqGt
 tjve1VBciOnUXU1t5N9JuHKhYFkmDM4BNUFv4RnTgAjExt2rz7nZSUWpqlZDH7lkXCNXfu0VGKP
 D3tO5SvaPrPwilSq4mQljDD93QfP06EvXliHuQdnPaWuVQGBbDnYsOdhrFAgOuhf+S+Kg9fSb42
 JI2YuX2fQ+ykjxnUnzU6kzrrRr7cAyAL0nykHN
X-Received: by 2002:a17:907:100a:b0:a46:930c:825d with SMTP id
 ox10-20020a170907100a00b00a46930c825dmr329304ejb.69.1711131126920; 
 Fri, 22 Mar 2024 11:12:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG/456wzOKa22BBbylk9Aii2/PupSKVyb3Gt79gUIG4JGhkjVOsg6h4mBB97NQdgu0/7oRing==
X-Received: by 2002:a17:907:100a:b0:a46:930c:825d with SMTP id
 ox10-20020a170907100a00b00a46930c825dmr329290ejb.69.1711131126572; 
 Fri, 22 Mar 2024 11:12:06 -0700 (PDT)
Received: from [192.168.10.118] ([151.95.49.219])
 by smtp.gmail.com with ESMTPSA id
 bm6-20020a170906c04600b00a46b4544da2sm70727ejb.125.2024.03.22.11.12.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Mar 2024 11:12:05 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: xiaoyao.li@intel.com,
	michael.roth@amd.com,
	david@redhat.com
Subject: [PATCH 15/26] target/i386: Implement mc->kvm_type() to get VM type
Date: Fri, 22 Mar 2024 19:11:05 +0100
Message-ID: <20240322181116.1228416-16-pbonzini@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240322181116.1228416-1-pbonzini@redhat.com>
References: <20240322181116.1228416-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.222,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

KVM is introducing a new API to create confidential guests, which
will be used by TDX and SEV-SNP but is also available for SEV and
SEV-ES.  The API uses the VM type argument to KVM_CREATE_VM to
identify which confidential computing technology to use.

Since there are no other expected uses of VM types, delegate
mc->kvm_type() for x86 boards to the confidential-guest-support
object pointed to by ms->cgs.

For example, if a sev-guest object is specified to confidential-guest-support,
like,

  qemu -machine ...,confidential-guest-support=sev0 \
       -object sev-guest,id=sev0,...

it will check if a VM type KVM_X86_SEV_VM or KVM_X86_SEV_ES_VM
is supported, and if so use them together with the KVM_SEV_INIT2
function of the KVM_MEMORY_ENCRYPT_OP ioctl. If not, it will fall back to
KVM_SEV_INIT and KVM_SEV_ES_INIT.

This is a preparatory work towards TDX and SEV-SNP support, but it
will also enable support for VMSA features such as DebugSwap, which
are only available via KVM_SEV_INIT2.

Co-developed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/confidential-guest.h | 19 ++++++++++++++
 target/i386/kvm/kvm_i386.h       |  2 ++
 hw/i386/x86.c                    | 11 ++++++++
 target/i386/kvm/kvm.c            | 44 ++++++++++++++++++++++++++++++++
 4 files changed, 76 insertions(+)

diff --git a/target/i386/confidential-guest.h b/target/i386/confidential-guest.h
index ca12d5a8fba..532e172a60b 100644
--- a/target/i386/confidential-guest.h
+++ b/target/i386/confidential-guest.h
@@ -36,5 +36,24 @@ struct X86ConfidentialGuest {
 struct X86ConfidentialGuestClass {
     /* <private> */
     ConfidentialGuestSupportClass parent;
+
+    /* <public> */
+    int (*kvm_type)(X86ConfidentialGuest *cg);
 };
+
+/**
+ * x86_confidential_guest_kvm_type:
+ *
+ * Calls #X86ConfidentialGuestClass.unplug callback of @plug_handler.
+ */
+static inline int x86_confidential_guest_kvm_type(X86ConfidentialGuest *cg)
+{
+    X86ConfidentialGuestClass *klass = X86_CONFIDENTIAL_GUEST_GET_CLASS(cg);
+
+    if (klass->kvm_type) {
+        return klass->kvm_type(cg);
+    } else {
+        return 0;
+    }
+}
 #endif
diff --git a/target/i386/kvm/kvm_i386.h b/target/i386/kvm/kvm_i386.h
index 30fedcffea3..6b44844d95d 100644
--- a/target/i386/kvm/kvm_i386.h
+++ b/target/i386/kvm/kvm_i386.h
@@ -37,6 +37,7 @@ bool kvm_hv_vpindex_settable(void);
 bool kvm_enable_sgx_provisioning(KVMState *s);
 bool kvm_hyperv_expand_features(X86CPU *cpu, Error **errp);
 
+int kvm_get_vm_type(MachineState *ms);
 void kvm_arch_reset_vcpu(X86CPU *cs);
 void kvm_arch_after_reset_vcpu(X86CPU *cpu);
 void kvm_arch_do_init_vcpu(X86CPU *cs);
@@ -49,6 +50,7 @@ void kvm_request_xsave_components(X86CPU *cpu, uint64_t mask);
 
 #ifdef CONFIG_KVM
 
+bool kvm_is_vm_type_supported(int type);
 bool kvm_has_adjust_clock_stable(void);
 bool kvm_has_exception_payload(void);
 void kvm_synchronize_all_tsc(void);
diff --git a/hw/i386/x86.c b/hw/i386/x86.c
index 84a48019770..3d5b51e92db 100644
--- a/hw/i386/x86.c
+++ b/hw/i386/x86.c
@@ -1381,6 +1381,16 @@ static void machine_set_sgx_epc(Object *obj, Visitor *v, const char *name,
     qapi_free_SgxEPCList(list);
 }
 
+static int x86_kvm_type(MachineState *ms, const char *vm_type)
+{
+    /*
+     * No x86 machine has a kvm-type property.  If one is added that has
+     * it, it should call kvm_get_vm_type() directly or not use it at all.
+     */
+    assert(vm_type == NULL);
+    return kvm_enabled() ? kvm_get_vm_type(ms) : 0;
+}
+
 static void x86_machine_initfn(Object *obj)
 {
     X86MachineState *x86ms = X86_MACHINE(obj);
@@ -1405,6 +1415,7 @@ static void x86_machine_class_init(ObjectClass *oc, void *data)
     mc->cpu_index_to_instance_props = x86_cpu_index_to_props;
     mc->get_default_cpu_node_id = x86_get_default_cpu_node_id;
     mc->possible_cpu_arch_ids = x86_possible_cpu_arch_ids;
+    mc->kvm_type = x86_kvm_type;
     x86mc->save_tsc_khz = true;
     x86mc->fwcfg_dma_enabled = true;
     nc->nmi_monitor_handler = x86_nmi;
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 0ec69109a2b..b599a7fae36 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -31,6 +31,7 @@
 #include "sysemu/kvm_int.h"
 #include "sysemu/runstate.h"
 #include "kvm_i386.h"
+#include "../confidential-guest.h"
 #include "sev.h"
 #include "xen-emu.h"
 #include "hyperv.h"
@@ -161,6 +162,49 @@ static KVMMSRHandlers msr_handlers[KVM_MSR_FILTER_MAX_RANGES];
 static RateLimit bus_lock_ratelimit_ctrl;
 static int kvm_get_one_msr(X86CPU *cpu, int index, uint64_t *value);
 
+static const char *vm_type_name[] = {
+    [KVM_X86_DEFAULT_VM] = "default",
+};
+
+bool kvm_is_vm_type_supported(int type)
+{
+    uint32_t machine_types;
+
+    /*
+     * old KVM doesn't support KVM_CAP_VM_TYPES but KVM_X86_DEFAULT_VM
+     * is always supported
+     */
+    if (type == KVM_X86_DEFAULT_VM) {
+        return true;
+    }
+
+    machine_types = kvm_check_extension(KVM_STATE(current_machine->accelerator),
+                                        KVM_CAP_VM_TYPES);
+    return !!(machine_types & BIT(type));
+}
+
+int kvm_get_vm_type(MachineState *ms)
+{
+    int kvm_type = KVM_X86_DEFAULT_VM;
+
+    if (ms->cgs) {
+        if (!object_dynamic_cast(OBJECT(ms->cgs), TYPE_X86_CONFIDENTIAL_GUEST)) {
+            error_report("configuration type %s not supported for x86 guests",
+                         object_get_typename(OBJECT(ms->cgs)));
+            exit(1);
+        }
+        kvm_type = x86_confidential_guest_kvm_type(
+            X86_CONFIDENTIAL_GUEST(ms->cgs));
+    }
+
+    if (!kvm_is_vm_type_supported(kvm_type)) {
+        error_report("vm-type %s not supported by KVM", vm_type_name[kvm_type]);
+        exit(1);
+    }
+
+    return kvm_type;
+}
+
 bool kvm_has_smm(void)
 {
     return kvm_vm_check_extension(kvm_state, KVM_CAP_X86_SMM);
-- 
2.44.0


