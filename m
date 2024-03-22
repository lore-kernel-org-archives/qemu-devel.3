Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A6F0C54E71
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Mar 2024 18:13:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnjMq-0006GP-5D; Fri, 22 Mar 2024 14:11:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rnjMk-0006FU-Kl
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 14:11:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rnjMg-0006xC-Jx
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 14:11:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711131098;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=59VVKVlc1ld+hutkclS9cdAuQWLyVjIdlmMMEfUwj7s=;
 b=UbFmRWPOK4+Ziew8qppMi8HKA5B2ZTw7epM4rj6PnmT03kHLNn9hN4ihp3+i3el2jB/VBS
 8fsINKpmXTa/NFoSNCEsqY/XVr/k+AGAbKd3FXLQhD0L8oimRpelDwh/ckv1W3OKc9946H
 4DiMHLzPWxwTd+To+GJtpVnsRkyb4rw=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-385-6hfEqwmhNuiWrjUWYlyMSA-1; Fri, 22 Mar 2024 14:11:36 -0400
X-MC-Unique: 6hfEqwmhNuiWrjUWYlyMSA-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a473555ec36so51201466b.2
 for <qemu-devel@nongnu.org>; Fri, 22 Mar 2024 11:11:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711131094; x=1711735894;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=59VVKVlc1ld+hutkclS9cdAuQWLyVjIdlmMMEfUwj7s=;
 b=Q1o1W+VHePYVfE0xANcZ3FXcByDi4tERDfoNKfve/QxGKbFko76UEuJINgffyGMCXI
 QhwcA88zGiIWC+ln/SW/f7gejPiGvpFH56a8B0gPMJ/kw1/PUCVDAdq8oMacNi5yMM+z
 zFVstAKb/Tg4aD1NN6mxjNMzrV/GmIaqzXOxbswa3sG7D7CPDMIl1Fb79eSnhz8/DgVK
 t4iVglPh9IU7Mltoyzxb08DlYsdShBEYizkbNQRilW9uZNohGXpkXZhf6GmUVkbJp7ql
 tH8o72+WJyw002IcP/HJiZC76lpFAkLF1PvEQLgzxL7mITh6M81/GBuL1pm2pMY7KBvH
 RrnQ==
X-Gm-Message-State: AOJu0YxxN/R2QkbNRil7NOJuNm6jdOPKQdrcQO5efOI+xT+vexTSLxgW
 7RRzdmWCrP6tTTO8m8aI3x925daeMtfYjfOoHatB1tyvVGVxh7dVSb7Bzhq80y+uMGjU7QWHXH2
 pkSHX5bl69LyYFu7n5X0fpqqVwvPWQx8i5XYczS8M36+sbZ2sSFBrZURBV25jSLd0c8U3aPmWFn
 q3sghhh6Z512VyFDjwUsoMRoIvmOyp+BIr9rev
X-Received: by 2002:a17:906:d7b2:b0:a47:2087:c26f with SMTP id
 pk18-20020a170906d7b200b00a472087c26fmr343915ejb.73.1711131094012; 
 Fri, 22 Mar 2024 11:11:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHUdufqav+a70H9sIDyL0THMRjr48zflPwmyBvB634MdK3Q6nxDYnJoUTHIVbH0/zc93dCJgQ==
X-Received: by 2002:a17:906:d7b2:b0:a47:2087:c26f with SMTP id
 pk18-20020a170906d7b200b00a472087c26fmr343896ejb.73.1711131093691; 
 Fri, 22 Mar 2024 11:11:33 -0700 (PDT)
Received: from [192.168.10.118] ([151.95.49.219])
 by smtp.gmail.com with ESMTPSA id
 xa10-20020a170907b9ca00b00a454438091fsm76066ejc.70.2024.03.22.11.11.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Mar 2024 11:11:31 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: xiaoyao.li@intel.com,
	michael.roth@amd.com,
	david@redhat.com
Subject: [PATCH 04/26] i386/sev: Switch to use confidential_guest_kvm_init()
Date: Fri, 22 Mar 2024 19:10:54 +0100
Message-ID: <20240322181116.1228416-5-pbonzini@redhat.com>
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

From: Xiaoyao Li <xiaoyao.li@intel.com>

Use confidential_guest_kvm_init() instead of calling SEV
specific sev_kvm_init(). This allows the introduction of multiple
confidential-guest-support subclasses for different x86 vendors.

As a bonus, stubs are not needed anymore since there is no
direct call from target/i386/kvm/kvm.c to SEV code.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Message-Id: <20240229060038.606591-1-xiaoyao.li@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/sev.h           |   2 -
 target/i386/kvm/kvm.c       |  10 +--
 target/i386/kvm/sev-stub.c  |  21 ------
 target/i386/sev.c           | 127 ++++++++++++++++++------------------
 target/i386/kvm/meson.build |   2 -
 5 files changed, 69 insertions(+), 93 deletions(-)
 delete mode 100644 target/i386/kvm/sev-stub.c

diff --git a/target/i386/sev.h b/target/i386/sev.h
index e7499c95b1e..9e10d09539a 100644
--- a/target/i386/sev.h
+++ b/target/i386/sev.h
@@ -57,6 +57,4 @@ int sev_inject_launch_secret(const char *hdr, const char *secret,
 int sev_es_save_reset_vector(void *flash_ptr, uint64_t flash_size);
 void sev_es_set_reset_vector(CPUState *cpu);
 
-int sev_kvm_init(ConfidentialGuestSupport *cgs, Error **errp);
-
 #endif
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index e68cbe92930..de10155b37a 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -2538,10 +2538,12 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
      * mechanisms are supported in future (e.g. TDX), they'll need
      * their own initialization either here or elsewhere.
      */
-    ret = sev_kvm_init(ms->cgs, &local_err);
-    if (ret < 0) {
-        error_report_err(local_err);
-        return ret;
+    if (ms->cgs) {
+        ret = confidential_guest_kvm_init(ms->cgs, &local_err);
+        if (ret < 0) {
+            error_report_err(local_err);
+            return ret;
+        }
     }
 
     has_xcrs = kvm_check_extension(s, KVM_CAP_XCRS);
diff --git a/target/i386/kvm/sev-stub.c b/target/i386/kvm/sev-stub.c
deleted file mode 100644
index 1be5341e8a6..00000000000
--- a/target/i386/kvm/sev-stub.c
+++ /dev/null
@@ -1,21 +0,0 @@
-/*
- * QEMU SEV stub
- *
- * Copyright Advanced Micro Devices 2018
- *
- * Authors:
- *      Brijesh Singh <brijesh.singh@amd.com>
- *
- * This work is licensed under the terms of the GNU GPL, version 2 or later.
- * See the COPYING file in the top-level directory.
- *
- */
-
-#include "qemu/osdep.h"
-#include "sev.h"
-
-int sev_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
-{
-    /* If we get here, cgs must be some non-SEV thing */
-    return 0;
-}
diff --git a/target/i386/sev.c b/target/i386/sev.c
index 72930ff0dcc..b8f79d34d19 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -353,63 +353,6 @@ static void sev_guest_set_kernel_hashes(Object *obj, bool value, Error **errp)
     sev->kernel_hashes = value;
 }
 
-static void
-sev_guest_class_init(ObjectClass *oc, void *data)
-{
-    object_class_property_add_str(oc, "sev-device",
-                                  sev_guest_get_sev_device,
-                                  sev_guest_set_sev_device);
-    object_class_property_set_description(oc, "sev-device",
-            "SEV device to use");
-    object_class_property_add_str(oc, "dh-cert-file",
-                                  sev_guest_get_dh_cert_file,
-                                  sev_guest_set_dh_cert_file);
-    object_class_property_set_description(oc, "dh-cert-file",
-            "guest owners DH certificate (encoded with base64)");
-    object_class_property_add_str(oc, "session-file",
-                                  sev_guest_get_session_file,
-                                  sev_guest_set_session_file);
-    object_class_property_set_description(oc, "session-file",
-            "guest owners session parameters (encoded with base64)");
-    object_class_property_add_bool(oc, "kernel-hashes",
-                                   sev_guest_get_kernel_hashes,
-                                   sev_guest_set_kernel_hashes);
-    object_class_property_set_description(oc, "kernel-hashes",
-            "add kernel hashes to guest firmware for measured Linux boot");
-}
-
-static void
-sev_guest_instance_init(Object *obj)
-{
-    SevGuestState *sev = SEV_GUEST(obj);
-
-    sev->sev_device = g_strdup(DEFAULT_SEV_DEVICE);
-    sev->policy = DEFAULT_GUEST_POLICY;
-    object_property_add_uint32_ptr(obj, "policy", &sev->policy,
-                                   OBJ_PROP_FLAG_READWRITE);
-    object_property_add_uint32_ptr(obj, "handle", &sev->handle,
-                                   OBJ_PROP_FLAG_READWRITE);
-    object_property_add_uint32_ptr(obj, "cbitpos", &sev->cbitpos,
-                                   OBJ_PROP_FLAG_READWRITE);
-    object_property_add_uint32_ptr(obj, "reduced-phys-bits",
-                                   &sev->reduced_phys_bits,
-                                   OBJ_PROP_FLAG_READWRITE);
-}
-
-/* sev guest info */
-static const TypeInfo sev_guest_info = {
-    .parent = TYPE_CONFIDENTIAL_GUEST_SUPPORT,
-    .name = TYPE_SEV_GUEST,
-    .instance_size = sizeof(SevGuestState),
-    .instance_finalize = sev_guest_finalize,
-    .class_init = sev_guest_class_init,
-    .instance_init = sev_guest_instance_init,
-    .interfaces = (InterfaceInfo[]) {
-        { TYPE_USER_CREATABLE },
-        { }
-    }
-};
-
 bool
 sev_enabled(void)
 {
@@ -906,20 +849,15 @@ sev_vm_state_change(void *opaque, bool running, RunState state)
     }
 }
 
-int sev_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
+static int sev_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
 {
-    SevGuestState *sev
-        = (SevGuestState *)object_dynamic_cast(OBJECT(cgs), TYPE_SEV_GUEST);
+    SevGuestState *sev = SEV_GUEST(cgs);
     char *devname;
     int ret, fw_error, cmd;
     uint32_t ebx;
     uint32_t host_cbitpos;
     struct sev_user_data_status status = {};
 
-    if (!sev) {
-        return 0;
-    }
-
     ret = ram_block_discard_disable(true);
     if (ret) {
         error_report("%s: cannot disable RAM discard", __func__);
@@ -1384,6 +1322,67 @@ bool sev_add_kernel_loader_hashes(SevKernelLoaderContext *ctx, Error **errp)
     return ret;
 }
 
+static void
+sev_guest_class_init(ObjectClass *oc, void *data)
+{
+    ConfidentialGuestSupportClass *klass = CONFIDENTIAL_GUEST_SUPPORT_CLASS(oc);
+
+    klass->kvm_init = sev_kvm_init;
+
+    object_class_property_add_str(oc, "sev-device",
+                                  sev_guest_get_sev_device,
+                                  sev_guest_set_sev_device);
+    object_class_property_set_description(oc, "sev-device",
+            "SEV device to use");
+    object_class_property_add_str(oc, "dh-cert-file",
+                                  sev_guest_get_dh_cert_file,
+                                  sev_guest_set_dh_cert_file);
+    object_class_property_set_description(oc, "dh-cert-file",
+            "guest owners DH certificate (encoded with base64)");
+    object_class_property_add_str(oc, "session-file",
+                                  sev_guest_get_session_file,
+                                  sev_guest_set_session_file);
+    object_class_property_set_description(oc, "session-file",
+            "guest owners session parameters (encoded with base64)");
+    object_class_property_add_bool(oc, "kernel-hashes",
+                                   sev_guest_get_kernel_hashes,
+                                   sev_guest_set_kernel_hashes);
+    object_class_property_set_description(oc, "kernel-hashes",
+            "add kernel hashes to guest firmware for measured Linux boot");
+}
+
+static void
+sev_guest_instance_init(Object *obj)
+{
+    SevGuestState *sev = SEV_GUEST(obj);
+
+    sev->sev_device = g_strdup(DEFAULT_SEV_DEVICE);
+    sev->policy = DEFAULT_GUEST_POLICY;
+    object_property_add_uint32_ptr(obj, "policy", &sev->policy,
+                                   OBJ_PROP_FLAG_READWRITE);
+    object_property_add_uint32_ptr(obj, "handle", &sev->handle,
+                                   OBJ_PROP_FLAG_READWRITE);
+    object_property_add_uint32_ptr(obj, "cbitpos", &sev->cbitpos,
+                                   OBJ_PROP_FLAG_READWRITE);
+    object_property_add_uint32_ptr(obj, "reduced-phys-bits",
+                                   &sev->reduced_phys_bits,
+                                   OBJ_PROP_FLAG_READWRITE);
+}
+
+/* sev guest info */
+static const TypeInfo sev_guest_info = {
+    .parent = TYPE_CONFIDENTIAL_GUEST_SUPPORT,
+    .name = TYPE_SEV_GUEST,
+    .instance_size = sizeof(SevGuestState),
+    .instance_finalize = sev_guest_finalize,
+    .class_init = sev_guest_class_init,
+    .instance_init = sev_guest_instance_init,
+    .interfaces = (InterfaceInfo[]) {
+        { TYPE_USER_CREATABLE },
+        { }
+    }
+};
+
 static void
 sev_register_types(void)
 {
diff --git a/target/i386/kvm/meson.build b/target/i386/kvm/meson.build
index 84d9143e602..e7850981e62 100644
--- a/target/i386/kvm/meson.build
+++ b/target/i386/kvm/meson.build
@@ -7,8 +7,6 @@ i386_kvm_ss.add(files(
 
 i386_kvm_ss.add(when: 'CONFIG_XEN_EMU', if_true: files('xen-emu.c'))
 
-i386_kvm_ss.add(when: 'CONFIG_SEV', if_false: files('sev-stub.c'))
-
 i386_system_ss.add(when: 'CONFIG_HYPERV', if_true: files('hyperv.c'), if_false: files('hyperv-stub.c'))
 
 i386_system_ss.add_all(when: 'CONFIG_KVM', if_true: i386_kvm_ss)
-- 
2.44.0


