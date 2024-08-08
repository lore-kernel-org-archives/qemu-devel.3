Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4445FC52D73
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2024 10:35:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sc0Tj-0001DN-Or; Thu, 08 Aug 2024 06:34:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1sc0Ti-0001Cc-6B
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 06:34:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1sc0Tg-0005Th-Bn
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 06:34:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723113276;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=3jp20j69AOkCh4ksiug+Aiw4wNRR8vEVdoqWHRD95fw=;
 b=TwK4ugR/PtK4FqoCZZ7TYtUdce2gnYl6u1MEX5FQCQe8SNJgv6dWztbsusDFTdNwMMTyt4
 1Cctm1ryuoQb5FEV21HqZuwfODbyRDogoKgysm9ZICmmbmY0Jiot3Z1tPuBd1BZ1DtNczu
 Vj2Anrc+UIAy4uzd7wQQPu0mjHNoSMU=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-690-H97sdFU-MRedd2mWrLaJVw-1; Thu, 08 Aug 2024 06:34:35 -0400
X-MC-Unique: H97sdFU-MRedd2mWrLaJVw-1
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-710ca162162so648613b3a.0
 for <qemu-devel@nongnu.org>; Thu, 08 Aug 2024 03:34:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723113274; x=1723718074;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3jp20j69AOkCh4ksiug+Aiw4wNRR8vEVdoqWHRD95fw=;
 b=uCvHbY9ixUJV+OVmX5xrjv6DvT4moTXCigwCvoyE2W514mSfSbxjeicMgajW4SbYDO
 33mZll0zGua+kLvE+/3YSbutHmffvBYfQCvhjE99DGmAOmjI8cV6sWQhx1E7YnGfaNF8
 Ucs/W2kf0TJtD3qecdSI09/qZsMN7FD30MeO6W0hwEftRSLIZ75QWqLzlaBgHODDo3OJ
 lmbUPo27NY4onJZoS7n/rLGmuautqdzkrQAXCyT7c69SoT9AQ7HvIGkgQhIGnW5jmDgk
 QIn53vSPkpfnpbVw1M0SbfC9Fdkb7YIH430gGpVfZSfT/xaS4IPgp9J6z/EPFAQuGApU
 EspA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWKoE6r9lxY3vCBmXHH86gQANp5WOXyLqcjF0yO6HqfgetPSNZRyf2911Rb7ICvwJYP4VeSCNWuxFMuuv/WvGTtqwmUi8s=
X-Gm-Message-State: AOJu0Yz7P0bYR//kLFtDTM+i3SrgoPuyBkkGz72N0JlI/PZ/bI3AbQiz
 s5vcRmtFBot/I+9hjhFKsFbPwrh9sCDIfWWkK6TKBGZAPXW01CC6xtSaHfyFuvi21jLRwsLRmdW
 XI7NdUzbV2oRiVdZh6L8AjZYdIGhWlJb8/gl813X20iYA6COOKYWr
X-Received: by 2002:a05:6a00:2293:b0:70b:2efd:7bee with SMTP id
 d2e1a72fcca58-710cae1c228mr1847948b3a.21.1723113273920; 
 Thu, 08 Aug 2024 03:34:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGPLc3kXqGoPqUMUK2UiRu0w2H2clgC5tCMbLgI/76PbvADokfZOrDKqq7qkameuDjloxqOaQ==
X-Received: by 2002:a05:6a00:2293:b0:70b:2efd:7bee with SMTP id
 d2e1a72fcca58-710cae1c228mr1847928b3a.21.1723113273466; 
 Thu, 08 Aug 2024 03:34:33 -0700 (PDT)
Received: from localhost.localdomain ([115.96.146.217])
 by smtp.googlemail.com with ESMTPSA id
 d2e1a72fcca58-710cb20a175sm909127b3a.16.2024.08.08.03.34.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Aug 2024 03:34:32 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>, kvm@vger.kernel.org, qemu-devel@nongnu.org
Subject: [PATCH] kvm: refactor core virtual machine creation into its own
 function
Date: Thu,  8 Aug 2024 16:03:36 +0530
Message-ID: <20240808103336.1675148-1-anisinha@redhat.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
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

Refactoring the core logic around KVM_CREATE_VM into its own separate function
so that it can be called from other functions in subsequent patches. There is
no functional change in this patch.

CC: pbonzini@redhat.com
Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 accel/kvm/kvm-all.c | 97 ++++++++++++++++++++++++++++-----------------
 1 file changed, 60 insertions(+), 37 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 75d11a07b2..2bcd00126a 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -2385,6 +2385,64 @@ uint32_t kvm_dirty_ring_size(void)
     return kvm_state->kvm_dirty_ring_size;
 }
 
+static int do_create_vm(MachineState *ms, int type)
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
+        fprintf(stderr, "ioctl(KVM_CREATE_VM) failed: %d %s\n", -ret,
+                strerror(-ret));
+
+#ifdef TARGET_S390X
+        if (ret == -EINVAL) {
+            fprintf(stderr,
+                    "Host kernel setup problem detected. Please verify:\n");
+            fprintf(stderr, "- for kernels supporting the switch_amode or"
+                    " user_mode parameters, whether\n");
+            fprintf(stderr,
+                    "  user space is running in primary address space\n");
+            fprintf(stderr,
+                    "- for kernels supporting the vm.allocate_pgste sysctl, "
+                    "whether it is enabled\n");
+        }
+#elif defined(TARGET_PPC)
+        if (ret == -EINVAL) {
+            fprintf(stderr,
+                    "PPC KVM module is not loaded. Try modprobe kvm_%s.\n",
+                    (type == 2) ? "pr" : "hv");
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
@@ -2467,49 +2525,14 @@ static int kvm_init(MachineState *ms)
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
+    ret = do_create_vm(ms, type);
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


