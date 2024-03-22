Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F54EC47DD9
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Mar 2024 18:12:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnjNP-0006pq-OP; Fri, 22 Mar 2024 14:12:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rnjNJ-0006dv-SK
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 14:12:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rnjNH-00073S-UL
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 14:12:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711131134;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jWInMz9rmQLUefPoQzYe9Bf7sptu2RteyLyov8JGQb8=;
 b=inVD92AQJfabLyDnMlCOCmzxUwNXBFSrqJ8yaXuRh9LrXQwCQgO32mg6F0xYThokiH2p/W
 jHR4GJO2CHZ9Yk/OX3ooLyl+04qSeuy71ghJPI5XCadoKGGIX0ZOkLRBHWpcWg90htnq52
 unJ33mZdWsGYGfAn1wJU75dqaggCxvU=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-310-DEqICODdOayX-UIkZFAqvA-1; Fri, 22 Mar 2024 14:12:12 -0400
X-MC-Unique: DEqICODdOayX-UIkZFAqvA-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-513e0c5f399so2044809e87.3
 for <qemu-devel@nongnu.org>; Fri, 22 Mar 2024 11:12:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711131130; x=1711735930;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jWInMz9rmQLUefPoQzYe9Bf7sptu2RteyLyov8JGQb8=;
 b=LbW5IgqOojVHshXYXJlEvhaIpj4rgYJPP51scbEEOPfPMeF8A6YE70iveM6aM8B4tZ
 DUtC8AtmQAt9WoGjllRUXhrU74ceH1UPsoYnsMjj6ZYM4Q7dO2iLsScEKnnoUvO4OTM2
 XFftiUcAlU1mhYvlEuCg2FyO+qbCIt4gAo4dVZ5xTnexWUT7u7eYVVJgERFZNACgeSWT
 F9zSZM4ulTNqHlPituPEmzP+k9Lyr6Uc/nTUY7R5gqcAyXLVsDeWIdYYoAgml5w43Wgr
 hPhCkd4Nb3Zga7d6fVM95tl9+D3uSp/nnu7FVzrhfQCBmXvCjaf4gRt/OP5hLTx/35gM
 AjpQ==
X-Gm-Message-State: AOJu0YymC80/3MWdx9NZha+bN50Com/MP4Bs8WAY9oYPDzjfrWTyv/yU
 qPRZNuvEO5giOqfY58ZcK5EW1l/FyYOGENTO0txZpAcEDdxXAEWPiUFm4xgX1vpG0EyYBcD2sKo
 b6igk+a4NCjBTZ5D0aseFl7RwGeNRcsbpmZ5MuAT8Rxjz1oqjCuRahadn1cc5NZLgxeThDYK5DM
 BffFeGePisPQZp0W3zfcNFyN6ltWdRr7npUsjP
X-Received: by 2002:a05:6512:55c:b0:513:ccd1:563e with SMTP id
 h28-20020a056512055c00b00513ccd1563emr174951lfl.8.1711131130321; 
 Fri, 22 Mar 2024 11:12:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHOdvTe4TSUyXf9V2XkBMoxfe17psOJpqGWG723gMrqQYeklUrighyAEIlmTWp4EEgq/heV3Q==
X-Received: by 2002:a05:6512:55c:b0:513:ccd1:563e with SMTP id
 h28-20020a056512055c00b00513ccd1563emr174930lfl.8.1711131129978; 
 Fri, 22 Mar 2024 11:12:09 -0700 (PDT)
Received: from [192.168.10.118] ([151.95.49.219])
 by smtp.gmail.com with ESMTPSA id
 l22-20020aa7c316000000b00568c299eaedsm68240edq.81.2024.03.22.11.12.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Mar 2024 11:12:07 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: xiaoyao.li@intel.com,
	michael.roth@amd.com,
	david@redhat.com
Subject: [PATCH 16/26] target/i386: SEV: use KVM_SEV_INIT2 if possible
Date: Fri, 22 Mar 2024 19:11:06 +0100
Message-ID: <20240322181116.1228416-17-pbonzini@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240322181116.1228416-1-pbonzini@redhat.com>
References: <20240322181116.1228416-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
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
 target/i386/kvm/kvm.c |  2 ++
 target/i386/sev.c     | 41 +++++++++++++++++++++++++++++++++++++----
 2 files changed, 39 insertions(+), 4 deletions(-)

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index b599a7fae36..2577e345502 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -164,6 +164,8 @@ static int kvm_get_one_msr(X86CPU *cpu, int index, uint64_t *value);
 
 static const char *vm_type_name[] = {
     [KVM_X86_DEFAULT_VM] = "default",
+    [KVM_X86_SEV_VM] = "SEV",
+    [KVM_X86_SEV_ES_VM] = "SEV-ES",
 };
 
 bool kvm_is_vm_type_supported(int type)
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


