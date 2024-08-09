Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BAFEC49EA1
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2024 04:54:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1scHdK-0002f5-3B; Fri, 09 Aug 2024 00:53:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1scHdI-0002bx-Ak
 for qemu-devel@nongnu.org; Fri, 09 Aug 2024 00:53:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1scHdG-0008Gn-QJ
 for qemu-devel@nongnu.org; Fri, 09 Aug 2024 00:53:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723179222;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FfU6XyO2Jk8i4FOiwyJKt1ccqOlc2vNSvzjRNpOVJfs=;
 b=NLmQe+UvrERLM/olQxjfCk9SNG0BgutOvF1Fj4zW0LhhNuBDeXhhmN/yUeUNQMZy53BUgz
 9We4C38/bAl98U5IQq11DoTW19qGIx2iBNQAnLwmjxU3BGO6yxzTSc1Mkqpu1pwMRHvUxj
 OzQkf4hCnzO+JGBykRXnzJbkb4wam5A=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-jNOXuUqSMq-ztbiLeiVgTA-1; Fri, 09 Aug 2024 00:53:39 -0400
X-MC-Unique: jNOXuUqSMq-ztbiLeiVgTA-1
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-7a28f78c67aso1810896a12.1
 for <qemu-devel@nongnu.org>; Thu, 08 Aug 2024 21:53:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723179218; x=1723784018;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FfU6XyO2Jk8i4FOiwyJKt1ccqOlc2vNSvzjRNpOVJfs=;
 b=EymjMVNPHjW9Il4FM8JUJpSgjox7TZwaD9f/XietT74XhgAZdgl7ZRoJPWr6JQQpss
 UJic53z59nzhquuT2BIeaz1oSgKKnhdxtGJtfNHnJfqSm0KE6unrATdpWnP6FxKOcVmX
 kE4xe0hCvAOzDIHc/Sj4rl1i53CuzMElCuCrBS+jSmPpRs0col8apeQTXvc5aMWABPJF
 v/Ax8ZfgVs3EX/zNuQULxnXQqet5+F08pkt9leVH0FN9tpuTDEiWkSom1NyiVmyENEd7
 fd3SNp/0pP6PvZvNanKxkkiDqeQNS/7v7dyJgEaarsZouy9PfgUSaylncIisXRkvmK3A
 3+Ow==
X-Forwarded-Encrypted: i=1;
 AJvYcCXvfNs3lZ5Atrm90sJ08ojNRhbVsW0Lmq6Lv88ktuIfMc7MJtYH04PPobaaqg6+MEa3df2wWhBtYZzR8YYdBpNVLxhQZaI=
X-Gm-Message-State: AOJu0YySNIQUKSoKtqtBI+evj9jLx4fBXunNgfwyBeDpSIh1pK9Xa0Lw
 0dKDUdPd1Z7/EBsoAueJb210PeizSOJDhHAZI2ft4zsE62aUo2bjP26xyRsmFEipv84Ldgt1IJq
 xMaCb+Jep4lIMsO17hlM8+SEXpCICdv59TzqmNJwu3VvZxDBoJD0mRGBZENAa
X-Received: by 2002:a05:6a21:3993:b0:1c0:f5fa:d1e9 with SMTP id
 adf61e73a8af0-1c89fce5652mr592198637.15.1723179217723; 
 Thu, 08 Aug 2024 21:53:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFXIKuqH70u2Lx+GwuqOZ8MGvHc3rF9cXAtufWKuQhkfNhxF7aPPB1+YhD3cDXDoG1FQCrEFQ==
X-Received: by 2002:a05:6a21:3993:b0:1c0:f5fa:d1e9 with SMTP id
 adf61e73a8af0-1c89fce5652mr592182637.15.1723179217298; 
 Thu, 08 Aug 2024 21:53:37 -0700 (PDT)
Received: from localhost.localdomain ([115.96.114.241])
 by smtp.googlemail.com with ESMTPSA id
 d9443c01a7336-1ff58f6a540sm133516895ad.118.2024.08.08.21.53.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Aug 2024 21:53:36 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>, qemu-trivial@nongnu.org,
 zhao1.liu@intel.com, kvm@vger.kernel.org, qemu-devel@nongnu.org
Subject: [PATCH 1/2] kvm: replace fprintf with error_report() in kvm_init()
 for error conditions
Date: Fri,  9 Aug 2024 10:21:52 +0530
Message-ID: <20240809045153.1744397-2-anisinha@redhat.com>
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

error_report() is more appropriate for error situations. Replace fprintf with
error_report. Cosmetic. No functional change.

CC: qemu-trivial@nongnu.org
CC: zhao1.liu@intel.com
Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 accel/kvm/kvm-all.c | 42 +++++++++++++++++++-----------------------
 1 file changed, 19 insertions(+), 23 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 75d11a07b2..899b5264e3 100644
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
 
@@ -2488,30 +2488,26 @@ static int kvm_init(MachineState *ms)
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
-        goto err;
     }
+        goto err;
 
     s->vmfd = ret;
 
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
+        error_report("kvm does not support %s", missing_cap->name);
+        error_report("%s", upgrade_note);
         goto err;
     }
 
-- 
2.45.2


