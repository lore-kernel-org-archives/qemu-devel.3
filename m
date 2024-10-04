Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60080CF884D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2024 16:42:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swlIn-0002iq-Cu; Fri, 04 Oct 2024 12:37:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1swlGe-0006r3-AN
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 12:35:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1swlGa-0006Bx-57
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 12:34:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728059695;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ggDZoeB06EyPk6F7B4bvzLC8eI1WG/pc242INantOA0=;
 b=GL2aTVvzmu3aXr2lkR9oGwZYOdu5CUUANvMx4GMlRyha+B95oK1F6AsK2UxsedKKZTb2uU
 IqfxmAWGdvZQPU1GMKCn2npzBA7PqbLfTyUppcp31k2M6gIBri0zhFL7qmUSohUEhZimgr
 w5Tp5k4JSXlK736NcNciOmqulJez2r0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-227-xtaQa8NdP0GOFNUsJRTFag-1; Fri, 04 Oct 2024 12:34:54 -0400
X-MC-Unique: xtaQa8NdP0GOFNUsJRTFag-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-42ca8037d9aso14215905e9.3
 for <qemu-devel@nongnu.org>; Fri, 04 Oct 2024 09:34:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728059692; x=1728664492;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ggDZoeB06EyPk6F7B4bvzLC8eI1WG/pc242INantOA0=;
 b=I2eS4qT/ZjOKWEe0vl8rAD+iu27dF3YrZMd/rPgktZdHeCO6Zk13Zk/ibmWmmtA3BJ
 h0XSpuqiu1597/zsSYWCI55xX+fbM36LDR91ScODhIsKWEOjnALO033AbU7/LLO0YDDv
 2kyycFx8uuAbsTxMKnwQXwE/6vtd5xB3xm0Q+D/lH3g4TN5u99xANUQYIX4Ua2LxY5p/
 iqxkCKo0sRJno1W02LS1h4WlB3T8YGdbEL8XjitCBA4enCh0OGuUw2//Vy/UEbMGyAGD
 vsu66UX4XDWCcvPZ8zSboJug6krknCN0GRgj9nt39i0TK4UmejRneJFj9Mz5CDL15AeU
 YPGQ==
X-Gm-Message-State: AOJu0Yw58diqM5nnGtJzOOFqcjFRrZ6uZrp5IZjwf0hhKlIIM/YPRkjg
 0uxb9x49QrumsvYddlBnEBpzc4cu98300KYmkj4z9TsaW0pj6L0aHM7gY7HFeV23piGJEhCnjM0
 VRbUACox6rCJnVKXh4+xEYG6k4yEG/dJKZHZoz5tDhi9xS0rFVTzKZj6o59eQx4Trste8Lfu8VR
 v6cA5l3/ALUQjBXJ3Hnu731p4N/SteBpdF06cdwLs=
X-Received: by 2002:a05:600c:1ca5:b0:42c:cd88:d0f7 with SMTP id
 5b1f17b1804b1-42f85ab4830mr24588705e9.10.1728059692429; 
 Fri, 04 Oct 2024 09:34:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IECHg3vsdUjUEJJbqmvmUEZaThBhJBapO/NtQiLSmiqlIOEFPxe37fO36XfDRJJGmmr4yMPeQ==
X-Received: by 2002:a05:600c:1ca5:b0:42c:cd88:d0f7 with SMTP id
 5b1f17b1804b1-42f85ab4830mr24588505e9.10.1728059692048; 
 Fri, 04 Oct 2024 09:34:52 -0700 (PDT)
Received: from avogadro.local ([151.95.43.71])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42f86b4a38bsm19428535e9.39.2024.10.04.09.34.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Oct 2024 09:34:51 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>, pbonzini@redhat.com, zhao1.liu@intel.com
Subject: [PULL 11/23] kvm: refactor core virtual machine creation into its own
 function
Date: Fri,  4 Oct 2024 18:34:03 +0200
Message-ID: <20241004163415.951106-12-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20241004163415.951106-1-pbonzini@redhat.com>
References: <20241004163415.951106-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.146,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
index 4c920b7bfe7..e06cf3a4157 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -2381,6 +2381,60 @@ uint32_t kvm_dirty_ring_size(void)
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
@@ -2463,45 +2517,14 @@ static int kvm_init(MachineState *ms)
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
2.46.1


