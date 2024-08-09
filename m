Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2A3FC52D71
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2024 05:12:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1scHuV-0002DV-Sw; Fri, 09 Aug 2024 01:11:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1scHuU-00028t-Pp
 for qemu-devel@nongnu.org; Fri, 09 Aug 2024 01:11:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1scHuT-0002mS-9d
 for qemu-devel@nongnu.org; Fri, 09 Aug 2024 01:11:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723180288;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VFVzUlNsVsXQ/Du+Ve53FGF58OzF7Hoq8mZruS9vw88=;
 b=WJ4TFMDfjVrmFSUwBIM8yJwl5FZI6lmZgGP1x7WQVcFrgTS4YVBGtAUT2sBroOnFrbPNU8
 xjVbPmAvvKzNB4sKJJ1cea7gK8ktGgrN3Z3WL71fnX++MtfJxXAm3M8l/3Ifih4IlNe1GV
 6PWlfnhveaRqdMV02oR+s9MeclcXQro=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-483-VUAcvqvAOd6m8yV9mU7MxA-1; Fri, 09 Aug 2024 01:11:26 -0400
X-MC-Unique: VUAcvqvAOd6m8yV9mU7MxA-1
Received: by mail-yw1-f199.google.com with SMTP id
 00721157ae682-66628e9ec89so35926707b3.1
 for <qemu-devel@nongnu.org>; Thu, 08 Aug 2024 22:11:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723180285; x=1723785085;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VFVzUlNsVsXQ/Du+Ve53FGF58OzF7Hoq8mZruS9vw88=;
 b=GpzCm41MPpDDHrsSViOb/6JslohfnTFtixEwKiswLX6jlhJZTzp1AUVI42+MXso8aq
 PDPLM+ObH2cqLwp7dqEW1qZOdlYlW7a9r+c7Z9CgVQPIDJnj4pXm8KtKhJlqjihvqa3s
 T773z2dkMN0THHMSZG1+70IMrl7oIlISti+XqC3UpxChW5HwhuboB1DUKXHewbkNwz7j
 qAFh8cvwBXXhh2iW1AAg5vtlP+hZXR/MuM+k0U9JkRyP5wt952naig5R/EWu9ZW/Ffq/
 W35MtcjCkDG9Ys6l6TKchn3sDFavIjtvLV6LcZ44GXBb9Q2TYabEvRwTQVMyDFfIDyzg
 enrw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUPeqlcFMEeJzFbjNA8SvyJU9AuEYIGVUNI2asMCWhBIcOywFTmX5XH6ioFWnHhnA78bf9sCkkU2GsdumnVwyRLTYn2wpc=
X-Gm-Message-State: AOJu0YxcrdIwFZdf9sTlVkwoAqKC1Y9EtVnfIMiu5EEIv3pQXwG5EYfT
 btITVJO4iFDrW//MrnxXAEOUjsIdpFJ2MlCjHJEqXXXjclAlbAMmsm3Wqbvrm3vcQBkxZCwoXNs
 rEJebqxLXZup1pWvYAPwQSH0bqHtCXmx7UZyarNFcg2RsSo5Cr6sg
X-Received: by 2002:a05:690c:4292:b0:651:6888:a018 with SMTP id
 00721157ae682-69ec5f414d7mr4786067b3.26.1723180285575; 
 Thu, 08 Aug 2024 22:11:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IESxQ+gkuExf9qc7vHUqL759aFOHOfgP2U0oqXC1HAlKJzIsPV8FKQvsxiLnMad+g7fVVCucA==
X-Received: by 2002:a05:690c:4292:b0:651:6888:a018 with SMTP id
 00721157ae682-69ec5f414d7mr4785867b3.26.1723180285247; 
 Thu, 08 Aug 2024 22:11:25 -0700 (PDT)
Received: from localhost.localdomain ([115.96.114.241])
 by smtp.googlemail.com with ESMTPSA id
 d2e1a72fcca58-710cb2e52bfsm1961777b3a.145.2024.08.08.22.11.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Aug 2024 22:11:24 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>, zhao1.liu@intel.com, cfontana@suse.de,
 qemu-trivial@nongnu.org, kvm@vger.kernel.org, qemu-devel@nongnu.org
Subject: [PATCH v3 2/2] kvm: refactor core virtual machine creation into its
 own function
Date: Fri,  9 Aug 2024 10:40:54 +0530
Message-ID: <20240809051054.1745641-3-anisinha@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240809051054.1745641-1-anisinha@redhat.com>
References: <20240809051054.1745641-1-anisinha@redhat.com>
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
CC: cfontana@suse.de
CC: qemu-trivial@nongnu.org
Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 accel/kvm/kvm-all.c | 86 ++++++++++++++++++++++++++++-----------------
 1 file changed, 53 insertions(+), 33 deletions(-)

changelog:
v2: s/fprintf/warn_report as suggested by zhao
v3: s/warn_report/error_report. function names adjusted to conform to
other names. fprintf -> error_report() moved to its own patch.

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index ac168b9663..610b3ead32 100644
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
         goto err;
     }
 
-- 
2.45.2


