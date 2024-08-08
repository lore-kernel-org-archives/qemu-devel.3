Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1052FC52D6F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2024 11:39:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sc1U4-0008HK-0M; Thu, 08 Aug 2024 07:39:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1sc1U1-00086e-Oc
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 07:39:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1sc1Ty-0006OD-H0
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 07:39:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723117140;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=nXtLRQ2oPUYqp5KSsNYob3Fl3+peknmF9tE6ROEjpF0=;
 b=IR+34d9didzpdW3T0JuvnrSDSKgp80po77SnJya7/S7IKoioVJiWP8HJmf5Yct/cjE4xQF
 Npy1bcCQi6HduTZkOpbslgnhNh95NQsJ7R4HGlHlYV+gESWEmkugyhYt/pvabRDH/wkf1P
 av51UFQaJR8L8Z56T1yE4ppg0Z93XAI=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-477-1haoGqA_PkO6I6gS0wA04A-1; Thu, 08 Aug 2024 07:38:58 -0400
X-MC-Unique: 1haoGqA_PkO6I6gS0wA04A-1
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-1fd9a0efe4eso8527295ad.0
 for <qemu-devel@nongnu.org>; Thu, 08 Aug 2024 04:38:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723117138; x=1723721938;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nXtLRQ2oPUYqp5KSsNYob3Fl3+peknmF9tE6ROEjpF0=;
 b=fRVdBwvJwvJu8gBWF7DJ/OFBWa7Y3JC/+HoUeQBYxJ0sfCY1VPyclIrKxYmn8RUsYa
 Iaq2pqdysMKHAUkb/nJunmTMwhrYigOw1bVd5Ob4is6FEbcPMhXhgw4+QE/LuDNJre6B
 CJUndGv/Zjorl+8gH0TiUQ7nHRsCCJFlx9iwbA+Zl2QjoMNunIJwiJVJeeXDXaSOvqxi
 kO+XezsZ1XN1lesWUjCXXRe1Kub683emy1+vaWR4Daumdh3XxQF+JiWVeRKuHBJZz1fP
 cbdj4d5gRLN8BL38MPRdKBpzLtuWzb8UQUSPXN05zopq18GzL+NivBHEQSReT54uusJ3
 9MOA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXhBIPQGOVAtX+Ua+DaAYpiEZOSDyP+jMOMcQVdnqeMe3hQXSnUXOUwcNvAD2h/Cqwqgx0gup/9yG7yXTkVvtW9VTmAWuw=
X-Gm-Message-State: AOJu0YxyR9WOBlCJ99IgKwwje3ow+W0jCdDTmPGDGKXzMPuAi3l9kPfb
 DyZstnKMEChumWEHBvyq2uSffYUaYVWZITkEhUgE5lGi+UvwPWpWPOxayMsTVkchMIoCxsqNYxi
 SyYY57nl1+A3dTfGFMfpOhhfqAttDsjmkERGvnB1DrvJOsgdIbH5G
X-Received: by 2002:a17:902:ced2:b0:1fc:726e:15b4 with SMTP id
 d9443c01a7336-2009525ebf4mr20323265ad.28.1723117137758; 
 Thu, 08 Aug 2024 04:38:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEvVFaLF9oQkLVng5OH4Ty0GBNS1LouM5Ox2xgGRWOluP8qj8etxA0d22WlIXoCbwu3GvQ+wA==
X-Received: by 2002:a17:902:ced2:b0:1fc:726e:15b4 with SMTP id
 d9443c01a7336-2009525ebf4mr20323025ad.28.1723117137292; 
 Thu, 08 Aug 2024 04:38:57 -0700 (PDT)
Received: from localhost.localdomain ([115.96.146.217])
 by smtp.googlemail.com with ESMTPSA id
 d9443c01a7336-1ff58f19efdsm122143365ad.31.2024.08.08.04.38.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Aug 2024 04:38:56 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>, zhao1.liu@intel.com, kvm@vger.kernel.org,
 qemu-devel@nongnu.org
Subject: [PATCH v2] kvm: refactor core virtual machine creation into its own
 function
Date: Thu,  8 Aug 2024 17:08:38 +0530
Message-ID: <20240808113838.1697366-1-anisinha@redhat.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Refactoring the core logic around KVM_CREATE_VM into its own separate function
so that it can be called from other functions in subsequent patches. There is
no functional change in this patch.

CC: pbonzini@redhat.com
CC: zhao1.liu@intel.com
Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 accel/kvm/kvm-all.c | 93 +++++++++++++++++++++++++++------------------
 1 file changed, 56 insertions(+), 37 deletions(-)

changelog:
v2: s/fprintf/warn_report as suggested by zhao

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 75d11a07b2..c2e177c39f 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -2385,6 +2385,60 @@ uint32_t kvm_dirty_ring_size(void)
     return kvm_state->kvm_dirty_ring_size;
 }
 
+static int do_kvm_create_vm(MachineState *ms, int type)
+{
+    KVMState *s;
+    int ret;
+
+    s = KVM_STATE(ms->accelerator);
+
+    do {
+        ret = kvm_ioctl(s, KVM_CREATE_VM, type);
+    } while (ret == -EINTR);
+
+    if (ret < 0) {
+        warn_report("ioctl(KVM_CREATE_VM) failed: %d %s", -ret,
+                    strerror(-ret));
+
+#ifdef TARGET_S390X
+        if (ret == -EINVAL) {
+            warn_report("Host kernel setup problem detected. Please verify:");
+            warn_report("- for kernels supporting the switch_amode or"
+                        " user_mode parameters, whether");
+            warn_report("  user space is running in primary address space");
+            warn_report("- for kernels supporting the vm.allocate_pgste "
+                        "sysctl, whether it is enabled");
+        }
+#elif defined(TARGET_PPC)
+        if (ret == -EINVAL) {
+            warn_report("PPC KVM module is not loaded. Try modprobe kvm_%s.",
+                        (type == 2) ? "pr" : "hv");
+        }
+#endif
+    }
+
+    return ret;
+}
+
+static int find_kvm_machine_type(MachineState *ms)
+{
+    MachineClass *mc = MACHINE_GET_CLASS(ms);
+    int type;
+
+    if (object_property_find(OBJECT(current_machine), "kvm-type")) {
+        g_autofree char *kvm_type;
+        kvm_type = object_property_get_str(OBJECT(current_machine),
+                                           "kvm-type",
+                                           &error_abort);
+        type = mc->kvm_type(ms, kvm_type);
+    } else if (mc->kvm_type) {
+        type = mc->kvm_type(ms, NULL);
+    } else {
+        type = kvm_arch_get_default_type(ms);
+    }
+    return type;
+}
+
 static int kvm_init(MachineState *ms)
 {
     MachineClass *mc = MACHINE_GET_CLASS(ms);
@@ -2467,49 +2521,14 @@ static int kvm_init(MachineState *ms)
     }
     s->as = g_new0(struct KVMAs, s->nr_as);
 
-    if (object_property_find(OBJECT(current_machine), "kvm-type")) {
-        g_autofree char *kvm_type = object_property_get_str(OBJECT(current_machine),
-                                                            "kvm-type",
-                                                            &error_abort);
-        type = mc->kvm_type(ms, kvm_type);
-    } else if (mc->kvm_type) {
-        type = mc->kvm_type(ms, NULL);
-    } else {
-        type = kvm_arch_get_default_type(ms);
-    }
-
+    type = find_kvm_machine_type(ms);
     if (type < 0) {
         ret = -EINVAL;
         goto err;
     }
 
-    do {
-        ret = kvm_ioctl(s, KVM_CREATE_VM, type);
-    } while (ret == -EINTR);
-
+    ret = do_kvm_create_vm(ms, type);
     if (ret < 0) {
-        fprintf(stderr, "ioctl(KVM_CREATE_VM) failed: %d %s\n", -ret,
-                strerror(-ret));
-
-#ifdef TARGET_S390X
-        if (ret == -EINVAL) {
-            fprintf(stderr,
-                    "Host kernel setup problem detected. Please verify:\n");
-            fprintf(stderr, "- for kernels supporting the switch_amode or"
-                    " user_mode parameters, whether\n");
-            fprintf(stderr,
-                    "  user space is running in primary address space\n");
-            fprintf(stderr,
-                    "- for kernels supporting the vm.allocate_pgste sysctl, "
-                    "whether it is enabled\n");
-        }
-#elif defined(TARGET_PPC)
-        if (ret == -EINVAL) {
-            fprintf(stderr,
-                    "PPC KVM module is not loaded. Try modprobe kvm_%s.\n",
-                    (type == 2) ? "pr" : "hv");
-        }
-#endif
         goto err;
     }
 
-- 
2.45.2


