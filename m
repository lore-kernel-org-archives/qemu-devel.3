Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00A39C54F32
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2024 12:46:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjI4B-0003Z3-U1; Wed, 28 Aug 2024 08:46:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1sjI43-0003Wm-Sk
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 08:46:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1sjI42-0004Pc-5u
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 08:46:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724849176;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=2T1tTA9ko0YOWVFq5y4ifBO7b+LeUQvtX/jUULrFmb0=;
 b=Lh31Ig3lffR4uau+xT+obKSJQelC3fhOS1Nu3+EWEq5Bzsl0pXtkI5kuhPMZFix0OPtyd1
 m9sAgiS2Yg+HyEze/64oJ/xqfAhNxLv7QwJsRy5opdOP1I2knEXUjmllH95qfSsIpBW+xF
 cONwvnI5K8oMFMDX/ikYO0MtiAjAjDw=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-E72b-71BNqK9HK_bB7wxEw-1; Wed, 28 Aug 2024 08:46:14 -0400
X-MC-Unique: E72b-71BNqK9HK_bB7wxEw-1
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2035232f929so78201485ad.2
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2024 05:46:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724849172; x=1725453972;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2T1tTA9ko0YOWVFq5y4ifBO7b+LeUQvtX/jUULrFmb0=;
 b=RSj3buFVf8fa9F0RayG4lkLOYwESWNNRt8J9UJl6MFWkDnnBWe+U4mj+vFLt0q6whm
 6UFPvQAZAB3NXyiirECgs7ikiQMnFBzsEpgTFAribl6G8yGGNuEbksEFEshXrBsorGJG
 mU0iWxqA8cPKczi6Z5ONFvf2x7vRqIXxlKss7RRSpJN8/yhWYwSY52oIT50zKAD4F8na
 5qoWxlkxggue4B6pvuNegCbN6a++LMfcHKcDjJLSGaYnE3XeDDXrE9PYSX28vL7KldC4
 WcODsLnrCk+2zOeDTQGmqH2hbb6h1f9TeLkdgwWM2WcqgoRYkDr7XG83MS7IQ5rXdEPh
 KX/g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUuu9eUCTPpR3clpXY523kqR+x1tp7K7QMMr1w3Fur4P/1yoLcR2tEUwDYZD8qmkviSZymZ8Z5bTuEa@nongnu.org
X-Gm-Message-State: AOJu0YynKDTzij3TRuXoyslKQYBf798sgcF65tnjiZO9jXSVqxeRJJng
 aZuOaPjVx4FeOqVrg64MxvVoBNsVEmmyhWJ4wIS1Mci8n8GckME91eavMr3FDoT4tC1FuHa71Nr
 k+jNSMueUmtEA1jBiwauLyVCIV1VoQpPd8DiEv+lMFqSTB8RNEMh3VU5CXm7tgt0=
X-Received: by 2002:a17:902:e750:b0:202:401f:ec6c with SMTP id
 d9443c01a7336-2039e4f1d23mr188247195ad.48.1724849171927; 
 Wed, 28 Aug 2024 05:46:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEIbCZfQ1T//KOqu77wrHDWoUYiCjpxF2W/r8bUX4UIMnm1FyADOmQECxRobicGc7XZR1lQQg==
X-Received: by 2002:a17:902:e750:b0:202:401f:ec6c with SMTP id
 d9443c01a7336-2039e4f1d23mr188246975ad.48.1724849171473; 
 Wed, 28 Aug 2024 05:46:11 -0700 (PDT)
Received: from localhost.localdomain ([115.96.157.236])
 by smtp.googlemail.com with ESMTPSA id
 d9443c01a7336-204f1b80cf5sm15047485ad.164.2024.08.28.05.46.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2024 05:46:10 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>, qemu-trivial@nongnu.org,
 zhao1.liu@intel.com, armbru@redhat.com, kvm@vger.kernel.org,
 qemu-devel@nongnu.org
Subject: [PATCH v6] kvm: replace fprintf with error_report()/printf() in
 kvm_init()
Date: Wed, 28 Aug 2024 18:15:39 +0530
Message-ID: <20240828124539.62672-1-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
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
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

error_report() is more appropriate for error situations. Replace fprintf with
error_report() and error_printf() as appropriate. Some improvement in error
reporting also happens as a part of this change. For example:

From:
$ ./qemu-system-x86_64 --accel kvm
Could not access KVM kernel module: No such file or directory

To:
$ ./qemu-system-x86_64 --accel kvm
qemu-system-x86_64: --accel kvm: Could not access KVM kernel module: No such file or directory

CC: qemu-trivial@nongnu.org
CC: zhao1.liu@intel.com
CC: armbru@redhat.com
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 accel/kvm/kvm-all.c | 40 ++++++++++++++++++----------------------
 1 file changed, 18 insertions(+), 22 deletions(-)

changelog:
v2: fix a bug.
v3: replace one instance of error_report() with error_printf(). added tags.
v4: changes suggested by Markus.
v5: more changes from Markus's comments on v4.
v6: commit message update as per suggestion from Markus. Tag added.

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 75d11a07b2..fcc157f0e6 100644
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
+        error_report("ioctl(KVM_CREATE_VM) failed: %s", strerror(-ret));
 
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
+            error_printf("Host kernel setup problem detected."
+                         " Please verify:\n");
+            error_printf("- for kernels supporting the"
+                        " switch_amode or user_mode parameters, whether");
+            error_printf(" user space is running in primary address space\n");
+            error_printf("- for kernels supporting the vm.allocate_pgste"
+                         " sysctl, whether it is enabled\n");
         }
 #elif defined(TARGET_PPC)
         if (ret == -EINVAL) {
-            fprintf(stderr,
-                    "PPC KVM module is not loaded. Try modprobe kvm_%s.\n",
-                    (type == 2) ? "pr" : "hv");
+            error_printf("PPC KVM module is not loaded. Try modprobe kvm_%s.\n",
+                         (type == 2) ? "pr" : "hv");
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
+        error_report("kvm does not support %s", missing_cap->name);
+        error_printf("%s", upgrade_note);
         goto err;
     }
 
-- 
2.42.0


