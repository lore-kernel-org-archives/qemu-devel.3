Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 343F2C52D71
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2024 06:51:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1scJSq-0007Qc-0H; Fri, 09 Aug 2024 02:51:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1scJSi-0007NY-HU
 for qemu-devel@nongnu.org; Fri, 09 Aug 2024 02:50:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1scJSg-00025V-OE
 for qemu-devel@nongnu.org; Fri, 09 Aug 2024 02:50:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723186253;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=r7Z50sX7S2lP3FksAHizbuHlweuHnvbw/fal6Z+4SqY=;
 b=audfpNKx3ob2z/psZ+ImdkblfVY4xvAk8WasTznH7PkFNXYNznwRUBB02m2jaIMnyOe/oR
 1tTjP+yIPxtuPx0+kRGFy/4njDzjEnCRzHGlDD1LRkEHnIl8lD7oAFkJQQLIU7UbqeFXex
 ySb+jhE5SCzJqJ3XJORDKyjQEZ7BGeU=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-237-NZNcO0XtNeiYP0Bwzl6NhA-1; Fri, 09 Aug 2024 02:50:51 -0400
X-MC-Unique: NZNcO0XtNeiYP0Bwzl6NhA-1
Received: by mail-oi1-f198.google.com with SMTP id
 5614622812f47-3db174abaa0so2097151b6e.3
 for <qemu-devel@nongnu.org>; Thu, 08 Aug 2024 23:50:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723186250; x=1723791050;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=r7Z50sX7S2lP3FksAHizbuHlweuHnvbw/fal6Z+4SqY=;
 b=HYeaw7Z8EI+iiR+9H2T/XgvJ75W9GdqAHWbG7497kVYwNUAMAg27hUc58O50wg/z8P
 nnrU1NFk+c6VU/hrMcYaobWA4cY7HthkzTw35nLhFJ6Cdo75Iph8n3OOQknHYBxqaZXH
 CvoHpd/DJwTMsATq41Vcwxryk8Wwa026BltI3QXxhbte0U1hyf8NOkMC2crQnTnJgNNc
 8Gt/nW4zNgL4ixYcSefI8Q62D6Kb8N0/Z5PAGTHCpTaxBer+6P9jAGGyBXShKSwwjTQ7
 Hv0nVuRKZ/QCLXXAvVrAyxdRb6BZkR5gOemVdPBIJK1ZA6MkmUTq/tVEaE13mDMggtlf
 K3DA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUWVQJaq6vn6ReJL/Ybzk2MOGRQlcCgj9JqrwssP7votXX3dohK4N1e/EeF//8x7wbsd5YQZAhqPBbeNr8dNC0udqxmH6c=
X-Gm-Message-State: AOJu0YwIlS70qtOqiddrvvfnsc/ZkxOU5/hU8pD2BqoGw80wIum+Tleo
 K7SsgAp5VuqpXF8UgmznYPvgiptLfbE7vxMEW3dXjatoR9kU2OcVFgBBTq0PsTNPtpegf/70tdJ
 u8BQIM78SF5qio+Ei08GMzfN1QS07rmEPLWl+rrwcyav9V80bWal1
X-Received: by 2002:a05:6808:1b08:b0:3da:a48b:d1e6 with SMTP id
 5614622812f47-3dc4167be9bmr622733b6e.16.1723186250400; 
 Thu, 08 Aug 2024 23:50:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFHkTD65z+yldFUt1QaxBa4CrGdN0oQ16aB+/2N5VM7yzbXUvvKg2qlQyzVOkVm4Ijwc9puiw==
X-Received: by 2002:a05:6808:1b08:b0:3da:a48b:d1e6 with SMTP id
 5614622812f47-3dc4167be9bmr622715b6e.16.1723186249971; 
 Thu, 08 Aug 2024 23:50:49 -0700 (PDT)
Received: from localhost.localdomain ([115.96.114.241])
 by smtp.googlemail.com with ESMTPSA id
 d2e1a72fcca58-710cb2d11besm2042982b3a.127.2024.08.08.23.50.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Aug 2024 23:50:49 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>, qemu-trivial@nongnu.org,
 zhao1.liu@intel.com, kvm@vger.kernel.org, qemu-devel@nongnu.org
Subject: [PATCH v3] kvm: replace fprintf with error_report/printf() in
 kvm_init()
Date: Fri,  9 Aug 2024 12:19:40 +0530
Message-ID: <20240809064940.1788169-1-anisinha@redhat.com>
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

error_report() is more appropriate for error situations. Replace fprintf with
error_report. Cosmetic. No functional change.

CC: qemu-trivial@nongnu.org
CC: zhao1.liu@intel.com
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 accel/kvm/kvm-all.c | 40 ++++++++++++++++++----------------------
 1 file changed, 18 insertions(+), 22 deletions(-)

changelog:
v2: fix a bug.
v3: replace one instance of error_report() with error_printf(). added tags.

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 75d11a07b2..5bc9d35b61 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -2427,7 +2427,7 @@ static int kvm_init(MachineState *ms)
     QLIST_INIT(&s->kvm_parked_vcpus);
     s->fd = qemu_open_old(s->device ?: "/dev/kvm", O_RDWR);
     if (s->fd == -1) {
-        fprintf(stderr, "Could not access KVM kernel module: %m\n");
+        error_report("Could not access KVM kernel module: %m");
         ret = -errno;
         goto err;
     }
@@ -2437,13 +2437,13 @@ static int kvm_init(MachineState *ms)
         if (ret >= 0) {
             ret = -EINVAL;
         }
-        fprintf(stderr, "kvm version too old\n");
+        error_report("kvm version too old");
         goto err;
     }
 
     if (ret > KVM_API_VERSION) {
         ret = -EINVAL;
-        fprintf(stderr, "kvm version not supported\n");
+        error_report("kvm version not supported");
         goto err;
     }
 
@@ -2488,26 +2488,22 @@ static int kvm_init(MachineState *ms)
     } while (ret == -EINTR);
 
     if (ret < 0) {
-        fprintf(stderr, "ioctl(KVM_CREATE_VM) failed: %d %s\n", -ret,
-                strerror(-ret));
+        error_report("ioctl(KVM_CREATE_VM) failed: %d %s", -ret,
+                    strerror(-ret));
 
 #ifdef TARGET_S390X
         if (ret == -EINVAL) {
-            fprintf(stderr,
-                    "Host kernel setup problem detected. Please verify:\n");
-            fprintf(stderr, "- for kernels supporting the switch_amode or"
-                    " user_mode parameters, whether\n");
-            fprintf(stderr,
-                    "  user space is running in primary address space\n");
-            fprintf(stderr,
-                    "- for kernels supporting the vm.allocate_pgste sysctl, "
-                    "whether it is enabled\n");
+            error_report("Host kernel setup problem detected. Please verify:");
+            error_report("- for kernels supporting the switch_amode or"
+                        " user_mode parameters, whether");
+            error_report("  user space is running in primary address space");
+            error_report("- for kernels supporting the vm.allocate_pgste "
+                        "sysctl, whether it is enabled");
         }
 #elif defined(TARGET_PPC)
         if (ret == -EINVAL) {
-            fprintf(stderr,
-                    "PPC KVM module is not loaded. Try modprobe kvm_%s.\n",
-                    (type == 2) ? "pr" : "hv");
+            error_report("PPC KVM module is not loaded. Try modprobe kvm_%s.",
+                        (type == 2) ? "pr" : "hv");
         }
 #endif
         goto err;
@@ -2526,9 +2522,9 @@ static int kvm_init(MachineState *ms)
                         nc->name, nc->num, soft_vcpus_limit);
 
             if (nc->num > hard_vcpus_limit) {
-                fprintf(stderr, "Number of %s cpus requested (%d) exceeds "
-                        "the maximum cpus supported by KVM (%d)\n",
-                        nc->name, nc->num, hard_vcpus_limit);
+                error_report("Number of %s cpus requested (%d) exceeds "
+                             "the maximum cpus supported by KVM (%d)",
+                             nc->name, nc->num, hard_vcpus_limit);
                 exit(1);
             }
         }
@@ -2542,8 +2538,8 @@ static int kvm_init(MachineState *ms)
     }
     if (missing_cap) {
         ret = -EINVAL;
-        fprintf(stderr, "kvm does not support %s\n%s",
-                missing_cap->name, upgrade_note);
+        error_printf("kvm does not support %s\n%s",
+                     missing_cap->name, upgrade_note);
         goto err;
     }
 
-- 
2.45.2


