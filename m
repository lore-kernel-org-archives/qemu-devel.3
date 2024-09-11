Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79E10EE499F
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 12:42:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soMYZ-0000hB-Rq; Wed, 11 Sep 2024 08:34:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1soMYB-0007XT-P9
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 08:34:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1soMY9-00016J-Ur
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 08:34:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726058061;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gU4vA1l3j7vpb6U9RGVZr3j7o9V0Y0q871++U1XS99U=;
 b=iWyq6cK4B3Tgix9WnlnoChny3MjXgJdMIakpyUr9tybvHzBoZeAB4QcmKgYFbDSOqXV0sp
 ze6aOfhb7QoRZu74fExFN2Pb9f2xoLlcB0QqB6+5vZJdpzXOMEHnWhGq4e0IsCaVARahGp
 kCmACmWE0gCOWe44u4xnQsA25TqY0bM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-684-WctiAn0ANhyw_cS2vb2miA-1; Wed, 11 Sep 2024 08:34:20 -0400
X-MC-Unique: WctiAn0ANhyw_cS2vb2miA-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-42cb6ed7f9dso30852565e9.3
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 05:34:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726058059; x=1726662859;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gU4vA1l3j7vpb6U9RGVZr3j7o9V0Y0q871++U1XS99U=;
 b=Ba8PfAu7Ur2/IbYGWDCeo8fvPt31SS4IXdHeEz+isu0Cb4edf0SBhz7a9I2jsPu7zx
 6aVHbQG7GPIHcpbDGHEiTgq0wb32cfqB1zIrhq8b4Nn3JD0jfygtFP0GLjRzhVwBr/Wv
 kINUUBP6F8aUo55gupoGO+bMwCqHOKrZa8UF1VQ4yKrq66Ij67T57+oSVawkjyNi5FzR
 y0h7EJjQPJGgMruM6D1JTYS5NuGl5HEzI/szL82TcxmM5SiE1V/VnFqR/VwGvObqavwm
 9se4oF1Q/RaE1J+4H8PedMnEFFfFx/p4dqtD9nLxkYsazIQJmxsHqudEMAFBJ740l/df
 sCGA==
X-Gm-Message-State: AOJu0YzU9DtWCRhROq900akTSVc8o2ZUL9V+vMgIplIHcZQ7g0jbvJ1u
 QeFZ8PitRbW4+8P/2rjVO2LO/GyOZ56xBNWbmBC/5xKyD7Ylv7GB6VSW3Vm9A/SdgTbdTIHLgET
 VROcI5auksN/4gQza2/l4dymvsemdN2Tu/fc0nutLX0lkuFFJjBt+hkyH0Fw4tfZOiOh5QHdjb0
 GDMBbrEakkVYY8TnCkXeDLNteN/au0EvQtxdTLeM8=
X-Received: by 2002:a5d:4387:0:b0:374:c160:269e with SMTP id
 ffacd0b85a97d-378922a6d58mr12067515f8f.22.1726058058769; 
 Wed, 11 Sep 2024 05:34:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF1syhIqZn9kkdR5trZlf4NlSE5E+KBXO4xNaw8uzj3xmc6XFKG/brCDEo8NOohUZZrfsloHw==
X-Received: by 2002:a5d:4387:0:b0:374:c160:269e with SMTP id
 ffacd0b85a97d-378922a6d58mr12067493f8f.22.1726058058284; 
 Wed, 11 Sep 2024 05:34:18 -0700 (PDT)
Received: from avogadro.local ([151.95.101.29])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3789564aea0sm11454160f8f.20.2024.09.11.05.34.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2024 05:34:17 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>, pbonzini@redhat.com, zhao1.liu@intel.com
Subject: [PULL 11/17] kvm: refactor core virtual machine creation into its own
 function
Date: Wed, 11 Sep 2024 14:33:36 +0200
Message-ID: <20240911123342.339482-12-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240911123342.339482-1-pbonzini@redhat.com>
References: <20240911123342.339482-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Ani Sinha <anisinha@redhat.com>

Refactoring the core logic around KVM_CREATE_VM into its own separate function
so that it can be called from other functions in subsequent patches. There is
no functional change in this patch.

CC: pbonzini@redhat.com
CC: zhao1.liu@intel.com
Signed-off-by: Ani Sinha <anisinha@redhat.com>
Link: https://lore.kernel.org/r/20240808113838.1697366-1-anisinha@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 accel/kvm/kvm-all.c | 89 ++++++++++++++++++++++++++++-----------------
 1 file changed, 56 insertions(+), 33 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index fcc157f0e60..ebaa632a21e 100644
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
+        error_report("ioctl(KVM_CREATE_VM) failed: %s", strerror(-ret));
+
+#ifdef TARGET_S390X
+        if (ret == -EINVAL) {
+            error_printf("Host kernel setup problem detected."
+                         " Please verify:\n");
+            error_printf("- for kernels supporting the"
+                        " switch_amode or user_mode parameters, whether");
+            error_printf(" user space is running in primary address space\n");
+            error_printf("- for kernels supporting the vm.allocate_pgste"
+                         " sysctl, whether it is enabled\n");
+        }
+#elif defined(TARGET_PPC)
+        if (ret == -EINVAL) {
+            error_printf("PPC KVM module is not loaded. Try modprobe kvm_%s.\n",
+                         (type == 2) ? "pr" : "hv");
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
@@ -2467,45 +2521,14 @@ static int kvm_init(MachineState *ms)
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
-        error_report("ioctl(KVM_CREATE_VM) failed: %s", strerror(-ret));
-
-#ifdef TARGET_S390X
-        if (ret == -EINVAL) {
-            error_printf("Host kernel setup problem detected."
-                         " Please verify:\n");
-            error_printf("- for kernels supporting the"
-                        " switch_amode or user_mode parameters, whether");
-            error_printf(" user space is running in primary address space\n");
-            error_printf("- for kernels supporting the vm.allocate_pgste"
-                         " sysctl, whether it is enabled\n");
-        }
-#elif defined(TARGET_PPC)
-        if (ret == -EINVAL) {
-            error_printf("PPC KVM module is not loaded. Try modprobe kvm_%s.\n",
-                         (type == 2) ? "pr" : "hv");
-        }
-#endif
         goto err;
     }
 
-- 
2.46.0


