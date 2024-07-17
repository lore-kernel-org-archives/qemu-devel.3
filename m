Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B49DBC3DA42
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 05:05:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTwpQ-0000CF-I0; Wed, 17 Jul 2024 01:03:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sTwpM-00005l-TU
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 01:03:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sTwpI-0001wi-0u
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 01:03:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721192619;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xvBboM0gBLgPXgc0OfI2YETwpo6vg79+rDTOsfSo04k=;
 b=LI0wWaE2fopgIG7sZGLoBmSBIXjmfpLMT0oYcSIfbFyWTlTL/LSOXPgqBEj4b6H9Vz2gh+
 JnwKYhS8kTUC+eP+46fAdFPkIgxmJGPrjLrqtoIbPQ3h+8IBpnQkvQHpJDckGEyvZ5kVZl
 Lpdh9TcbM9ArbqLP95v3HTyFyEeCeRc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-522-JAFsuMDwNamn-_ERjFSmJw-1; Wed, 17 Jul 2024 01:03:37 -0400
X-MC-Unique: JAFsuMDwNamn-_ERjFSmJw-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4266d0183feso41323795e9.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 22:03:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721192616; x=1721797416;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xvBboM0gBLgPXgc0OfI2YETwpo6vg79+rDTOsfSo04k=;
 b=BXhoXaLF7LyycsyXOBKMBE95U3C0tHF1Cpp6pgol6+RPg408Pf293H4BX+aeXftN3T
 UPtRFH3SDrZeZ3eojXY6bAQOU1c2nJ7eFKr87UiWQxkb97jvKTgNC+YWhj+Sx7T6/zZs
 PODXkSRfDVJElNWNlZrU8g1+5wsRqMYdlDBwlphR0zj+xyxYvRZirWEWSBB86ed8VTWG
 jibHV8anEz3DMEotpHIBTqLZB2ViFdmRpWLktWxwN2tGd6+X5EV9f1yqmhg/7ky+Jw+m
 8YD6YDeDynYOTZiQueMKw5pXeLf2HGxIQe8PbQkCX8xso9IF3HQcQ2/AMjgjCdaUAB6l
 Rchw==
X-Gm-Message-State: AOJu0YyortVlcrTAk0aLISMv2JbSK6VIB5DiDFLFNsqwCJuwe501kbs/
 WIdg+kxG7TRrwk4oCFVB2Ou2nODkF8DRWX9ho1IC9yF+HgQ83ByFBKYiz14IYNARVFnUStM+9nV
 rqy3YQwdes3v488OlLfF9O7Dvz+NHo87kZT/URA3N/a4tTippGceJdnV5ZASCZNMUexN8XFs6Vs
 j+Nz4Kf38w57UFYvm44o52ZYfq972woS6tXGkY
X-Received: by 2002:a05:600c:4690:b0:426:6696:9e50 with SMTP id
 5b1f17b1804b1-427c2cb0869mr2671695e9.14.1721192615832; 
 Tue, 16 Jul 2024 22:03:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF0dJd1zzIHD6YIbXa+f5V3qfglRo8jsbLkdiBokdBFJ2faTewrH4mT6rdxGu48prFtIHsKVw==
X-Received: by 2002:a05:600c:4690:b0:426:6696:9e50 with SMTP id
 5b1f17b1804b1-427c2cb0869mr2671585e9.14.1721192615513; 
 Tue, 16 Jul 2024 22:03:35 -0700 (PDT)
Received: from avogadro.local ([151.95.101.29])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427a5e77488sm158244645e9.9.2024.07.16.22.03.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jul 2024 22:03:34 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Michael Roth <michael.roth@amd.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 kvm@vger.kernel.org
Subject: [PULL 01/20] i386/sev: Don't allow automatic fallback to legacy
 KVM_SEV*_INIT
Date: Wed, 17 Jul 2024 07:03:11 +0200
Message-ID: <20240717050331.295371-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240717050331.295371-1-pbonzini@redhat.com>
References: <20240717050331.295371-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

From: Michael Roth <michael.roth@amd.com>

Currently if the 'legacy-vm-type' property of the sev-guest object is
'on', QEMU will attempt to use the newer KVM_SEV_INIT2 kernel
interface in conjunction with the newer KVM_X86_SEV_VM and
KVM_X86_SEV_ES_VM KVM VM types.

This can lead to measurement changes if, for instance, an SEV guest was
created on a host that originally had an older kernel that didn't
support KVM_SEV_INIT2, but is booted on the same host later on after the
host kernel was upgraded.

Instead, if legacy-vm-type is 'off', QEMU should fail if the
KVM_SEV_INIT2 interface is not provided by the current host kernel.
Modify the fallback handling accordingly.

In the future, VMSA features and other flags might be added to QEMU
which will require legacy-vm-type to be 'off' because they will rely
on the newer KVM_SEV_INIT2 interface. It may be difficult to convey to
users what values of legacy-vm-type are compatible with which
features/options, so as part of this rework, switch legacy-vm-type to a
tri-state OnOffAuto option. 'auto' in this case will automatically
switch to using the newer KVM_SEV_INIT2, but only if it is required to
make use of new VMSA features or other options only available via
KVM_SEV_INIT2.

Defining 'auto' in this way would avoid inadvertantly breaking
compatibility with older kernels since it would only be used in cases
where users opt into newer features that are only available via
KVM_SEV_INIT2 and newer kernels, and provide better default behavior
than the legacy-vm-type=off behavior that was previously in place, so
make it the default for 9.1+ machine types.

Cc: Daniel P. Berrangé <berrange@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
cc: kvm@vger.kernel.org
Signed-off-by: Michael Roth <michael.roth@amd.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Link: https://lore.kernel.org/r/20240710041005.83720-1-michael.roth@amd.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 qapi/qom.json     | 18 ++++++----
 hw/i386/pc.c      |  2 +-
 target/i386/sev.c | 87 +++++++++++++++++++++++++++++++++++++++--------
 3 files changed, 84 insertions(+), 23 deletions(-)

diff --git a/qapi/qom.json b/qapi/qom.json
index 8e75a419c30..7eccd2e14e2 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -924,12 +924,16 @@
 # @handle: SEV firmware handle (default: 0)
 #
 # @legacy-vm-type: Use legacy KVM_SEV_INIT KVM interface for creating the VM.
-#                  The newer KVM_SEV_INIT2 interface syncs additional vCPU
-#                  state when initializing the VMSA structures, which will
-#                  result in a different guest measurement. Set this to
-#                  maintain compatibility with older QEMU or kernel versions
-#                  that rely on legacy KVM_SEV_INIT behavior.
-#                  (default: false) (since 9.1)
+#                  The newer KVM_SEV_INIT2 interface, from Linux >= 6.10, syncs
+#                  additional vCPU state when initializing the VMSA structures,
+#                  which will result in a different guest measurement. Set
+#                  this to 'on' to force compatibility with older QEMU or kernel
+#                  versions that rely on legacy KVM_SEV_INIT behavior. 'auto'
+#                  will behave identically to 'on', but will automatically
+#                  switch to using KVM_SEV_INIT2 if the user specifies any
+#                  additional options that require it. If set to 'off', QEMU
+#                  will require KVM_SEV_INIT2 unconditionally.
+#                  (default: off) (since 9.1)
 #
 # Since: 2.12
 ##
@@ -939,7 +943,7 @@
             '*session-file': 'str',
             '*policy': 'uint32',
             '*handle': 'uint32',
-            '*legacy-vm-type': 'bool' } }
+            '*legacy-vm-type': 'OnOffAuto' } }
 
 ##
 # @SevSnpGuestProperties:
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 4fbc5774708..c74931d577a 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -83,7 +83,7 @@ GlobalProperty pc_compat_9_0[] = {
     { TYPE_X86_CPU, "x-amd-topoext-features-only", "false" },
     { TYPE_X86_CPU, "x-l1-cache-per-thread", "false" },
     { TYPE_X86_CPU, "guest-phys-bits", "0" },
-    { "sev-guest", "legacy-vm-type", "true" },
+    { "sev-guest", "legacy-vm-type", "on" },
     { TYPE_X86_CPU, "legacy-multi-node", "on" },
 };
 const size_t pc_compat_9_0_len = G_N_ELEMENTS(pc_compat_9_0);
diff --git a/target/i386/sev.c b/target/i386/sev.c
index 2ba5f517228..a1157c0ede6 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -144,7 +144,7 @@ struct SevGuestState {
     uint32_t policy;
     char *dh_cert_file;
     char *session_file;
-    bool legacy_vm_type;
+    OnOffAuto legacy_vm_type;
 };
 
 struct SevSnpGuestState {
@@ -1369,6 +1369,17 @@ sev_vm_state_change(void *opaque, bool running, RunState state)
     }
 }
 
+/*
+ * This helper is to examine sev-guest properties and determine if any options
+ * have been set which rely on the newer KVM_SEV_INIT2 interface and associated
+ * KVM VM types.
+ */
+static bool sev_init2_required(SevGuestState *sev_guest)
+{
+    /* Currently no KVM_SEV_INIT2-specific options are exposed via QEMU */
+    return false;
+}
+
 static int sev_kvm_type(X86ConfidentialGuest *cg)
 {
     SevCommonState *sev_common = SEV_COMMON(cg);
@@ -1379,14 +1390,39 @@ static int sev_kvm_type(X86ConfidentialGuest *cg)
         goto out;
     }
 
-    kvm_type = (sev_guest->policy & SEV_POLICY_ES) ?
-                KVM_X86_SEV_ES_VM : KVM_X86_SEV_VM;
-    if (kvm_is_vm_type_supported(kvm_type) && !sev_guest->legacy_vm_type) {
-        sev_common->kvm_type = kvm_type;
-    } else {
+    /* These are the only cases where legacy VM types can be used. */
+    if (sev_guest->legacy_vm_type == ON_OFF_AUTO_ON ||
+        (sev_guest->legacy_vm_type == ON_OFF_AUTO_AUTO &&
+         !sev_init2_required(sev_guest))) {
         sev_common->kvm_type = KVM_X86_DEFAULT_VM;
+        goto out;
     }
 
+    /*
+     * Newer VM types are required, either explicitly via legacy-vm-type=on, or
+     * implicitly via legacy-vm-type=auto along with additional sev-guest
+     * properties that require the newer VM types.
+     */
+    kvm_type = (sev_guest->policy & SEV_POLICY_ES) ?
+                KVM_X86_SEV_ES_VM : KVM_X86_SEV_VM;
+    if (!kvm_is_vm_type_supported(kvm_type)) {
+        if (sev_guest->legacy_vm_type == ON_OFF_AUTO_AUTO) {
+            error_report("SEV: host kernel does not support requested %s VM type, which is required "
+                         "for the set of options specified. To allow use of the legacy "
+                         "KVM_X86_DEFAULT_VM VM type, please disable any options that are not "
+                         "compatible with the legacy VM type, or upgrade your kernel.",
+                         kvm_type == KVM_X86_SEV_VM ? "KVM_X86_SEV_VM" : "KVM_X86_SEV_ES_VM");
+        } else {
+            error_report("SEV: host kernel does not support requested %s VM type. To allow use of "
+                         "the legacy KVM_X86_DEFAULT_VM VM type, the 'legacy-vm-type' argument "
+                         "must be set to 'on' or 'auto' for the sev-guest object.",
+                         kvm_type == KVM_X86_SEV_VM ? "KVM_X86_SEV_VM" : "KVM_X86_SEV_ES_VM");
+        }
+
+        return -1;
+    }
+
+    sev_common->kvm_type = kvm_type;
 out:
     return sev_common->kvm_type;
 }
@@ -1477,14 +1513,24 @@ static int sev_common_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
     }
 
     trace_kvm_sev_init();
-    if (x86_klass->kvm_type(X86_CONFIDENTIAL_GUEST(sev_common)) == KVM_X86_DEFAULT_VM) {
+    switch (x86_klass->kvm_type(X86_CONFIDENTIAL_GUEST(sev_common))) {
+    case KVM_X86_DEFAULT_VM:
         cmd = sev_es_enabled() ? KVM_SEV_ES_INIT : KVM_SEV_INIT;
 
         ret = sev_ioctl(sev_common->sev_fd, cmd, NULL, &fw_error);
-    } else {
+        break;
+    case KVM_X86_SEV_VM:
+    case KVM_X86_SEV_ES_VM:
+    case KVM_X86_SNP_VM: {
         struct kvm_sev_init args = { 0 };
 
         ret = sev_ioctl(sev_common->sev_fd, KVM_SEV_INIT2, &args, &fw_error);
+        break;
+    }
+    default:
+        error_setg(errp, "%s: host kernel does not support the requested SEV configuration.",
+                   __func__);
+        return -1;
     }
 
     if (ret) {
@@ -2074,14 +2120,23 @@ sev_guest_set_session_file(Object *obj, const char *value, Error **errp)
     SEV_GUEST(obj)->session_file = g_strdup(value);
 }
 
-static bool sev_guest_get_legacy_vm_type(Object *obj, Error **errp)
+static void sev_guest_get_legacy_vm_type(Object *obj, Visitor *v,
+                                         const char *name, void *opaque,
+                                         Error **errp)
 {
-    return SEV_GUEST(obj)->legacy_vm_type;
+    SevGuestState *sev_guest = SEV_GUEST(obj);
+    OnOffAuto legacy_vm_type = sev_guest->legacy_vm_type;
+
+    visit_type_OnOffAuto(v, name, &legacy_vm_type, errp);
 }
 
-static void sev_guest_set_legacy_vm_type(Object *obj, bool value, Error **errp)
+static void sev_guest_set_legacy_vm_type(Object *obj, Visitor *v,
+                                         const char *name, void *opaque,
+                                         Error **errp)
 {
-    SEV_GUEST(obj)->legacy_vm_type = value;
+    SevGuestState *sev_guest = SEV_GUEST(obj);
+
+    visit_type_OnOffAuto(v, name, &sev_guest->legacy_vm_type, errp);
 }
 
 static void
@@ -2107,9 +2162,9 @@ sev_guest_class_init(ObjectClass *oc, void *data)
                                   sev_guest_set_session_file);
     object_class_property_set_description(oc, "session-file",
             "guest owners session parameters (encoded with base64)");
-    object_class_property_add_bool(oc, "legacy-vm-type",
-                                   sev_guest_get_legacy_vm_type,
-                                   sev_guest_set_legacy_vm_type);
+    object_class_property_add(oc, "legacy-vm-type", "OnOffAuto",
+                              sev_guest_get_legacy_vm_type,
+                              sev_guest_set_legacy_vm_type, NULL, NULL);
     object_class_property_set_description(oc, "legacy-vm-type",
             "use legacy VM type to maintain measurement compatibility with older QEMU or kernel versions.");
 }
@@ -2125,6 +2180,8 @@ sev_guest_instance_init(Object *obj)
     object_property_add_uint32_ptr(obj, "policy", &sev_guest->policy,
                                    OBJ_PROP_FLAG_READWRITE);
     object_apply_compat_props(obj);
+
+    sev_guest->legacy_vm_type = ON_OFF_AUTO_AUTO;
 }
 
 /* guest info specific sev/sev-es */
-- 
2.45.2


