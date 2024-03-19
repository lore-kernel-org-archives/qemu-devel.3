Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBA04C54E60
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 14:02:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rma17-0005bY-Qx; Tue, 19 Mar 2024 10:00:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rma12-0005Zr-90
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 10:00:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rma10-00074n-Mx
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 10:00:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710856829;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wDLmt4dXsnil5+MSxsOmljxdtxv2E/Tbja4ppJhpbW0=;
 b=Fgfbz6MoXJ+E2kMvME3sIyQG02b2O+Ey9XdgqzOYXYEMDVrc+nl0wws5lC66mfGGYE9+qV
 Fz/NfWVx4xETeKKyaV/ViKQGZTOHt7OorYljbDZnS9EWBuMfgCN/46531bll4An1t6QuDq
 COVPuK6qsnYSuTBr7rgVkdmc7pyEU6c=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-102-UBd-x95_NN6nIPXz0UvNrg-1; Tue, 19 Mar 2024 10:00:27 -0400
X-MC-Unique: UBd-x95_NN6nIPXz0UvNrg-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-5689f41cf4dso2955689a12.3
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 07:00:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710856825; x=1711461625;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wDLmt4dXsnil5+MSxsOmljxdtxv2E/Tbja4ppJhpbW0=;
 b=UOgmRrxZzTvGNMeRKCylpQVDqEQ8WjmWw7GrmTfO0Pc2Vf8p785F7VgpPV6iLGqZuR
 mhALOn8xer9wxvsLcUcQRSlaMze3zyVhd/bIp4FU12cVX+MDmrJb/cOl7FQWnYaHCniT
 +tksPz1rwG0HfMpsepsoPGFB2GiuWBOS0F+tKQhJv3mfCJxQIfFtGz4YBEfeavW4drbu
 2PAZbVpTlL8yTSnwPE0tTSpEwc8hREe02UI4HaCTf71Ynx2oGfwCDFvqo9N+b9sn0GVX
 wrpwlF3aYYNIutnu25nNSSfwC5rjHVMjRy1CdXzz/XvSiU0rJCA6U/3KK2SbIGYEy4E8
 6+eQ==
X-Gm-Message-State: AOJu0YyL7AcB5Bmvz374vVoEfQoC5JCu4vQqTUbcf/DDAat6eWG9sB0X
 8T7m+xgSRHCn/RoLBwkcHtVydIqZ0vvmZD2rU3lKlFYIIoXuw+dZBs62M1B7CemlsBvzzDasimS
 2XAx6QLN//bW8JBmcm9nJU4A+bG0IZiPBEt4k0ochw3xuOIM205vzWgQk5vlqphxQYP3CYjGrv6
 vfwFQI1Rft2X8x8TONHNz7D+xE8QnOk7pEdx/W
X-Received: by 2002:a05:6402:3884:b0:568:b610:b7f5 with SMTP id
 fd4-20020a056402388400b00568b610b7f5mr2258210edb.35.1710856825434; 
 Tue, 19 Mar 2024 07:00:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFPSILqxQhc4GvfPEbGVMh0uWkLCws/PfaHqLo/9y9pQnv7wrtdh7HAWznQqTNhvjubZ3JvcQ==
X-Received: by 2002:a05:6402:3884:b0:568:b610:b7f5 with SMTP id
 fd4-20020a056402388400b00568b610b7f5mr2258193edb.35.1710856825161; 
 Tue, 19 Mar 2024 07:00:25 -0700 (PDT)
Received: from [192.168.10.118] ([151.95.49.219])
 by smtp.gmail.com with ESMTPSA id
 c12-20020a0564021f8c00b005682f8b62a6sm5797193edc.97.2024.03.19.07.00.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Mar 2024 07:00:23 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: xiaoyao.li@intel.com,
	michael.roth@amd.com
Subject: [PATCH 7/7] target/i386: SEV: use KVM_SEV_INIT2 if possible
Date: Tue, 19 Mar 2024 15:00:00 +0100
Message-ID: <20240319140000.1014247-8-pbonzini@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240319140000.1014247-1-pbonzini@redhat.com>
References: <20240319140000.1014247-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.422,
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

Implement support for the KVM_X86_SEV_VM and KVM_X86_SEV_ES_VM virtual
machine types, and the KVM_SEV_INIT2 function of KVM_MEMORY_ENCRYPT_OP.

These replace the KVM_SEV_INIT and KVM_SEV_ES_INIT functions, and have
several advantages:

- sharing the initialization sequence with SEV-SNP and TDX

- allowing arguments including the set of desired VMSA features

- protection against invalid use of KVM_GET/SET_* ioctls for guests
  with encrypted state

If the KVM_X86_SEV_VM and KVM_X86_SEV_ES_VM types are not supported,
fall back to KVM_SEV_INIT and KVM_SEV_ES_INIT (which use the
default x86 VM type).

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/sev.c | 41 +++++++++++++++++++++++++++++++++++++----
 1 file changed, 37 insertions(+), 4 deletions(-)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index ebe36d4c10c..9dab4060b84 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -26,6 +26,7 @@
 #include "qemu/error-report.h"
 #include "crypto/hash.h"
 #include "sysemu/kvm.h"
+#include "kvm/kvm_i386.h"
 #include "sev.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/runstate.h"
@@ -56,6 +57,8 @@ OBJECT_DECLARE_SIMPLE_TYPE(SevGuestState, SEV_GUEST)
 struct SevGuestState {
     X86ConfidentialGuest parent_obj;
 
+    int kvm_type;
+
     /* configuration parameters */
     char *sev_device;
     uint32_t policy;
@@ -850,6 +853,26 @@ sev_vm_state_change(void *opaque, bool running, RunState state)
     }
 }
 
+static int sev_kvm_type(X86ConfidentialGuest *cg)
+{
+    SevGuestState *sev = SEV_GUEST(cg);
+    int kvm_type;
+
+    if (sev->kvm_type != -1) {
+        goto out;
+    }
+
+    kvm_type = (sev->policy & SEV_POLICY_ES) ? KVM_X86_SEV_ES_VM : KVM_X86_SEV_VM;
+    if (kvm_is_vm_type_supported(kvm_type)) {
+        sev->kvm_type = kvm_type;
+    } else {
+        sev->kvm_type = KVM_X86_DEFAULT_VM;
+    }
+
+out:
+    return sev->kvm_type;
+}
+
 static int sev_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
 {
     SevGuestState *sev = SEV_GUEST(cgs);
@@ -929,13 +952,19 @@ static int sev_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
                          __func__);
             goto err;
         }
-        cmd = KVM_SEV_ES_INIT;
-    } else {
-        cmd = KVM_SEV_INIT;
     }
 
     trace_kvm_sev_init();
-    ret = sev_ioctl(sev->sev_fd, cmd, NULL, &fw_error);
+    if (sev_kvm_type(X86_CONFIDENTIAL_GUEST(sev)) == KVM_X86_DEFAULT_VM) {
+        cmd = sev_es_enabled() ? KVM_SEV_ES_INIT : KVM_SEV_INIT;
+
+        ret = sev_ioctl(sev->sev_fd, cmd, NULL, &fw_error);
+    } else {
+        struct kvm_sev_init args = { 0 };
+
+        ret = sev_ioctl(sev->sev_fd, KVM_SEV_INIT2, &args, &fw_error);
+    }
+
     if (ret) {
         error_setg(errp, "%s: failed to initialize ret=%d fw_error=%d '%s'",
                    __func__, ret, fw_error, fw_error_to_str(fw_error));
@@ -1327,8 +1356,10 @@ static void
 sev_guest_class_init(ObjectClass *oc, void *data)
 {
     ConfidentialGuestSupportClass *klass = CONFIDENTIAL_GUEST_SUPPORT_CLASS(oc);
+    X86ConfidentialGuestClass *x86_klass = X86_CONFIDENTIAL_GUEST_CLASS(oc);
 
     klass->kvm_init = sev_kvm_init;
+    x86_klass->kvm_type = sev_kvm_type;
 
     object_class_property_add_str(oc, "sev-device",
                                   sev_guest_get_sev_device,
@@ -1357,6 +1388,8 @@ sev_guest_instance_init(Object *obj)
 {
     SevGuestState *sev = SEV_GUEST(obj);
 
+    sev->kvm_type = -1;
+
     sev->sev_device = g_strdup(DEFAULT_SEV_DEVICE);
     sev->policy = DEFAULT_GUEST_POLICY;
     object_property_add_uint32_ptr(obj, "policy", &sev->policy,
-- 
2.44.0


