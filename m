Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55C3CC5472D
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2024 07:57:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjDXx-0003qd-2j; Wed, 28 Aug 2024 03:56:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1sjDXv-0003kd-Ha
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 03:56:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1sjDXt-00063P-TH
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 03:56:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724831809;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zYl3uaCkxHjT2nDUPL1WDle3wL/fOkENv7M02v+JPJY=;
 b=gKUQIaDN87zxthEiqYIYbBSEqQwloMn60Fxtbv0sMIJcszFEEOSQ+clgybuHEzIg4/7+H3
 ZYfi4q+Ha/a/sd47dDjGFccjOJapRZdxtbGi3tgoPVeksH3AaoCT75laGVjhpApjv8RRoT
 dFgocKvPQShPJBMqkjozIto3vxE8yn8=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-79-_kZeOcCDNsGjIvYf3daHUA-1; Wed, 28 Aug 2024 03:56:46 -0400
X-MC-Unique: _kZeOcCDNsGjIvYf3daHUA-1
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-2d441cdb503so7307789a91.1
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2024 00:56:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724831805; x=1725436605;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zYl3uaCkxHjT2nDUPL1WDle3wL/fOkENv7M02v+JPJY=;
 b=R9fwfj+XcjCkDROh6dLjyiWbidr68apeoNtQjBRdBzLo9tx+X6s6d8zM72HfObphmI
 LoD2bpQBVIjzTDU2D9eOXD1gbzRrCnFlmXoI5rxlz11U6FBZsQlCHYFa1pCGKBmnSjTq
 w7fLbKg+xZu76TFANWnDfxYDoUAQYD6iF8GQgSm/WjyE8LkdNLBaKqr1vU9FCCOGmEd+
 7bQZ/5I/2hQkRZOLPBDzSHnc9wD4WNJczHPoziyyaKj/1epONuz8JKqQDf5wWgnvUICP
 miAHAWNvlQVN4gb2owo4jeDvThwKGTQazy7GhvDteaCDbjyX8mspJmYn9cHKPkEBefyr
 LPxA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWDjak40Hq1V/VqiPEZAb0Oz1X3sY7jn7jdVJWtbcEcvUvY8l/f/oDxTfEyMW+72sW7BmDo2S/DFx4P@nongnu.org
X-Gm-Message-State: AOJu0YzOXaFBb7N/QrxJU0/k00qgnWJ/corloWLap+kKhis5lOWYvuH9
 IpZgoJEi77+rZCbUuHoW5iUsUIIqBVAc1oP0lka2FngqAQluFh7yMYLK1Q4WuWdTpW0dpO5yRA9
 j5kO6AKOwy+QJYcbykF0hquN5MdRAUVqF/dHi/Oyl3+tSNOfPqUUR
X-Received: by 2002:a17:90a:7408:b0:2d3:cc3e:4d6d with SMTP id
 98e67ed59e1d1-2d646b91092mr14510028a91.9.1724831805447; 
 Wed, 28 Aug 2024 00:56:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHnS9wmiNKpmg/gLxiSQVdrbd8UyjUO09X7ptuxTKXWPb9mBB1kZo5ol5VgojZc/qD+8UvY6w==
X-Received: by 2002:a17:90a:7408:b0:2d3:cc3e:4d6d with SMTP id
 98e67ed59e1d1-2d646b91092mr14510013a91.9.1724831805035; 
 Wed, 28 Aug 2024 00:56:45 -0700 (PDT)
Received: from localhost.localdomain ([115.96.157.236])
 by smtp.googlemail.com with ESMTPSA id
 98e67ed59e1d1-2d8445fbf0dsm1013534a91.19.2024.08.28.00.56.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2024 00:56:44 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>, zhao1.liu@intel.com, cfontana@suse.de,
 armbru@redhat.com, qemu-trivial@nongnu.org, kvm@vger.kernel.org,
 qemu-devel@nongnu.org
Subject: [PATCH v5 2/2] kvm: refactor core virtual machine creation into its
 own function
Date: Wed, 28 Aug 2024 13:26:29 +0530
Message-ID: <20240828075630.7754-3-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240828075630.7754-1-anisinha@redhat.com>
References: <20240828075630.7754-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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
so that it can be called from other functions in future patches. There is
no functional change in this patch.

CC: pbonzini@redhat.com
CC: zhao1.liu@intel.com
CC: cfontana@suse.de
CC: armbru@redhat.com
CC: qemu-trivial@nongnu.org
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Claudio Fontana <cfontana@suse.de>
Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 accel/kvm/kvm-all.c | 86 ++++++++++++++++++++++++++++-----------------
 1 file changed, 53 insertions(+), 33 deletions(-)

v2: s/fprintf/warn_report as suggested by zhao
v3: s/warn_report/error_report. function names adjusted to conform to
other names. fprintf -> error_report() moved to its own patch.
v4: added tags and rebased.
v5: rebased.

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index fcc157f0e6..cf3d820b94 100644
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
@@ -2467,45 +2518,14 @@ static int kvm_init(MachineState *ms)
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
2.42.0


