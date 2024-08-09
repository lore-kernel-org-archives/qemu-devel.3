Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CAD7C3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2024 04:54:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1scHdM-0002qS-Oc; Fri, 09 Aug 2024 00:53:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1scHdK-0002hg-M6
 for qemu-devel@nongnu.org; Fri, 09 Aug 2024 00:53:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1scHdJ-0008HQ-2y
 for qemu-devel@nongnu.org; Fri, 09 Aug 2024 00:53:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723179224;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6y/Dx9WfBuoEyBP+LUel142LcScGzpkHOUr2wWRP0X0=;
 b=av5wUfbqQC4nVhcbRv4gRqZbgF/5L67UJOTOlGMQH+zOgWAnXK3myuGjCyGRnq2F8bImKf
 Fho/yk6216Q3WMe0iOleT7ijs4jNwnupSGSAHsXnELlwlq+TUNeAyyd1Co2eO50xHaPjxz
 M74trJ8SyZc+qGn3xH491P+U6yvYwbw=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-387-Q6uTvj7ONIir2eEnFYZWWw-1; Fri, 09 Aug 2024 00:53:42 -0400
X-MC-Unique: Q6uTvj7ONIir2eEnFYZWWw-1
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-7104d2cac39so2048992b3a.1
 for <qemu-devel@nongnu.org>; Thu, 08 Aug 2024 21:53:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723179221; x=1723784021;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6y/Dx9WfBuoEyBP+LUel142LcScGzpkHOUr2wWRP0X0=;
 b=nZHcvKsqIF1W0Mu/tBiJK5TYdvucN4KjG1cyuVjRZafqiX+YjFxIJ3nL7mz4kn0N95
 1ea80zARwJ1XM5ycPqhNZujFGOJoqGrzFwcBBpKeHS/QZA1yKxUkKukCqkOt66RE3Fgc
 TMoIY0t621w8FdM3Z1+afdC+0DXO/FZT9CAz22SDRazq+WG5WnKlKiViK0FBhmSQSK8z
 Mx5d/9BromTtm/clsQGJ1Qv7Ua3nzLRDclUOkwT/sC8BIifK5cNjGvunSuHwCzJksUSA
 Q3MESpJFf5ISZ7cuwIuY1dGfPZPTE7ST4LXdAdoomwp6iQdESM7coPX79M6gyMGOFik6
 xfSw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXlnYS91pvATbZRpH9LgIUwOwOHA2fZ2RbSTj1zIOs9/v6yp09k38TRz44y+6TePXdb//2JN1u8wucKfDVEGmh2/D489o8=
X-Gm-Message-State: AOJu0Yww2Davplp4dX12wzkQtlOhNMKa6/dIl05eH93lxOf8/TsJUTjP
 QmX7WXDpMGVbFtefJP9q9I1181CpdGE3F92Vbz+t8BP0cx6UKM0RD08sY0HDTABQ+XlMuWdFUiA
 GE1R/jrAxqtSHsqHzNoBmIR8Vhy/CYftt6wCrc2UpF46AvNFFX04e
X-Received: by 2002:a05:6a21:458a:b0:1c4:8650:d6d7 with SMTP id
 adf61e73a8af0-1c89fec2cd2mr507347637.16.1723179221103; 
 Thu, 08 Aug 2024 21:53:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG7CZUoFnBycRjnM0orNNjv+/SuxPUpkqJGSE9wtp9gfcdEF73syhQeo7PZom0vG5inUvKBJQ==
X-Received: by 2002:a05:6a21:458a:b0:1c4:8650:d6d7 with SMTP id
 adf61e73a8af0-1c89fec2cd2mr507328637.16.1723179220671; 
 Thu, 08 Aug 2024 21:53:40 -0700 (PDT)
Received: from localhost.localdomain ([115.96.114.241])
 by smtp.googlemail.com with ESMTPSA id
 d9443c01a7336-1ff58f6a540sm133516895ad.118.2024.08.08.21.53.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Aug 2024 21:53:40 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>, zhao1.liu@intel.com, cfontana@suse.de,
 qemu-trivial@nongnu.org, kvm@vger.kernel.org, qemu-devel@nongnu.org
Subject: [PATCH v3 2/2] kvm: refactor core virtual machine creation into its
 own function
Date: Fri,  9 Aug 2024 10:21:53 +0530
Message-ID: <20240809045153.1744397-3-anisinha@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240809045153.1744397-1-anisinha@redhat.com>
References: <20240809045153.1744397-1-anisinha@redhat.com>
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
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
CC: cfontana@suse.de
CC: qemu-trivial@nongnu.org
Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 accel/kvm/kvm-all.c | 88 +++++++++++++++++++++++++++------------------
 1 file changed, 54 insertions(+), 34 deletions(-)

changelog:
v2: s/fprintf/warn_report as suggested by zhao
v3: s/warn_report/error_report. function names adjusted to conform to
other names. fprintf -> error_report() moved to its own patch.

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 899b5264e3..610b3ead32 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -2385,6 +2385,57 @@ uint32_t kvm_dirty_ring_size(void)
     return kvm_state->kvm_dirty_ring_size;
 }
 
+static int kvm_create_vm(MachineState *ms, KVMState *s, int type)
+{
+    int ret;
+
+    do {
+        ret = kvm_ioctl(s, KVM_CREATE_VM, type);
+    } while (ret == -EINTR);
+
+    if (ret < 0) {
+        error_report("ioctl(KVM_CREATE_VM) failed: %d %s", -ret,
+                    strerror(-ret));
+
+#ifdef TARGET_S390X
+        if (ret == -EINVAL) {
+            error_report("Host kernel setup problem detected. Please verify:");
+            error_report("- for kernels supporting the switch_amode or"
+                        " user_mode parameters, whether");
+            error_report("  user space is running in primary address space");
+            error_report("- for kernels supporting the vm.allocate_pgste "
+                        "sysctl, whether it is enabled");
+        }
+#elif defined(TARGET_PPC)
+        if (ret == -EINVAL) {
+            error_report("PPC KVM module is not loaded. Try modprobe kvm_%s.",
+                        (type == 2) ? "pr" : "hv");
+        }
+#endif
+    }
+
+    return ret;
+}
+
+static int kvm_machine_type(MachineState *ms)
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
@@ -2467,47 +2518,16 @@ static int kvm_init(MachineState *ms)
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
+    type = kvm_machine_type(ms);
     if (type < 0) {
         ret = -EINVAL;
         goto err;
     }
 
-    do {
-        ret = kvm_ioctl(s, KVM_CREATE_VM, type);
-    } while (ret == -EINTR);
-
+    ret = kvm_create_vm(ms, s, type);
     if (ret < 0) {
-        error_report("ioctl(KVM_CREATE_VM) failed: %d %s", -ret,
-                    strerror(-ret));
-
-#ifdef TARGET_S390X
-        if (ret == -EINVAL) {
-            error_report("Host kernel setup problem detected. Please verify:");
-            error_report("- for kernels supporting the switch_amode or"
-                        " user_mode parameters, whether");
-            error_report("  user space is running in primary address space");
-            error_report("- for kernels supporting the vm.allocate_pgste "
-                        "sysctl, whether it is enabled");
-        }
-#elif defined(TARGET_PPC)
-        if (ret == -EINVAL) {
-            error_report("PPC KVM module is not loaded. Try modprobe kvm_%s.",
-                        (type == 2) ? "pr" : "hv");
-        }
-#endif
-    }
         goto err;
+    }
 
     s->vmfd = ret;
 
-- 
2.45.2


