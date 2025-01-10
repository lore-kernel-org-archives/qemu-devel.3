Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 618FFE77188
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 18:49:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWK49-0002rB-EC; Fri, 10 Jan 2025 13:49:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tWK2d-0000PU-2A
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 13:47:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tWK2a-0001CI-L3
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 13:47:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736534847;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u/jSh3phCjmXrmFZbNzmUVTDDUThSgA5sAsWR34V2mc=;
 b=fua/zNkyp9iOeYlThrzYkbV2bTGHfQrA3fxVi/WfmBIX3yXmchYpRKyvW0AAlJNqOJZX80
 Mnhu33HSAw9iW6LXbMUzDWL7cDi/2L+pxIkvmW1202vFfpUX5drpcdfE1FrCJMovd4XLCt
 usnNyRd0Ii74hCMkXU9odnA0rVqxomw=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-509-WU6jeKFLPOuGBUeTUMlDLw-1; Fri, 10 Jan 2025 13:47:26 -0500
X-MC-Unique: WU6jeKFLPOuGBUeTUMlDLw-1
X-Mimecast-MFC-AGG-ID: WU6jeKFLPOuGBUeTUMlDLw
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-5d3fe991854so2899197a12.0
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 10:47:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736534844; x=1737139644;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u/jSh3phCjmXrmFZbNzmUVTDDUThSgA5sAsWR34V2mc=;
 b=hr1bnFONqmYCT7lKrIW9jfupKz7mXKB4T7A3SFDeuiilcmBInccvjepPCeWutTvfTH
 3m5/siE93qnBd5GM6c/NtD+h3pXLx1dG85jc8OU87aN24hCszdM4vZoCpR25FgXypwFN
 nGwTwgNBfd5lwwVx3HVqGm2+2jaU6I9q30hydLJxNemfdrlGwjDKpMI610yjyHgKDsV/
 2UGB4h3n1NCfpRKUuumca1PKMSrf3BjLWWiD4UjDvXVNEZcn2V6+MVDwCFey60+KfD7b
 f3bzWO9SUlYRfUjvSjRcHctpRrLVnu2ZpXcB0LRWRmC52fpDkgBSvI+NO5nPVplMZqyi
 GOJQ==
X-Gm-Message-State: AOJu0YzEaUZCyN/fEl4rsO3mS/Q7pwvbQ+x2/rQKFJVtIw2InwffhQbA
 UqZ9P/RnVn39GrNXkNsL5GhuWRk9ysan3Yf4/kG119ve/8CvYdYxAJGjZg1DkSpsHRUhwRFIi2j
 cAu33Dpc6nT9Hd3hLuUJL4LO9erEQLGyCeYlXGAj8iYqLhyZfDNDgO6gfY+L01v/634J5NAeaGN
 asVzc5eI9liI3N2KC1HUSiY3gx7hn7vcbctcT2u50=
X-Gm-Gg: ASbGncvajycP4qAz7y4biwaowztwQnuxozobCSF6HVpz6jI88MnLtda9xGGsCWjpFg7
 7XDsinHkFtIA+dAhoioQrzeLANBN2I+z3R7zlAsK7FGDsMYRPNlDdBQ4PdvxVAnzukZGpPVjf3/
 tujmi//RZsz6clAxPYoSFsPi+JXJOmlQ13wiSQ56avtgcDejzD/TJTq3M/FQMb771gn0T4rzyrE
 Nx3fw0Eco/+Ox2PLa95yD4Bic7EgpnujBUVIviHFAiaY8CcTOGZVO0fDC8=
X-Received: by 2002:a05:6402:27cd:b0:5d9:a55:8104 with SMTP id
 4fb4d7f45d1cf-5d972e4cb87mr9775250a12.21.1736534844393; 
 Fri, 10 Jan 2025 10:47:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE5AWBFycH3ZDFwFvcgt0PbW2JGhLn4J43JPcA3/Zjz9FOKUBh+wWU4/ykqP6ahu/b3Ku3UIg==
X-Received: by 2002:a05:6402:27cd:b0:5d9:a55:8104 with SMTP id
 4fb4d7f45d1cf-5d972e4cb87mr9775239a12.21.1736534843887; 
 Fri, 10 Jan 2025 10:47:23 -0800 (PST)
Received: from [192.168.10.3] ([151.62.105.73])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5d99046a17fsm1919522a12.62.2025.01.10.10.47.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jan 2025 10:47:22 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>,
	Zide Chen <zide.chen@intel.com>
Subject: [PULL 27/38] target/i386/kvm: Clean up error handling in
 kvm_arch_init()
Date: Fri, 10 Jan 2025 19:46:08 +0100
Message-ID: <20250110184620.408302-28-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250110184620.408302-1-pbonzini@redhat.com>
References: <20250110184620.408302-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.432,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Zhao Liu <zhao1.liu@intel.com>

Currently, there're following incorrect error handling cases in
kvm_arch_init():
* Missed to handle failure of kvm_get_supported_feature_msrs().
* Missed to return when kvm_vm_enable_disable_exits() fails.
* MSR filter related cases called exit() directly instead of returning
  to kvm_init(). (The caller of kvm_arch_init() - kvm_init() - needs to
  know if kvm_arch_init() fails in order to perform cleanup).

Fix the above cases.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Zide Chen <zide.chen@intel.com>
Link: https://lore.kernel.org/r/20241106030728.553238-11-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/kvm/kvm.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 3624abbb397..6f424774b33 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -3162,7 +3162,7 @@ static int kvm_vm_enable_userspace_msr(KVMState *s)
     return 0;
 }
 
-static void kvm_vm_enable_energy_msrs(KVMState *s)
+static int kvm_vm_enable_energy_msrs(KVMState *s)
 {
     int ret;
 
@@ -3172,7 +3172,7 @@ static void kvm_vm_enable_energy_msrs(KVMState *s)
         if (ret < 0) {
             error_report("Could not install MSR_RAPL_POWER_UNIT handler: %s",
                          strerror(-ret));
-            exit(1);
+            return ret;
         }
 
         ret = kvm_filter_msr(s, MSR_PKG_POWER_LIMIT,
@@ -3180,7 +3180,7 @@ static void kvm_vm_enable_energy_msrs(KVMState *s)
         if (ret < 0) {
             error_report("Could not install MSR_PKG_POWER_LIMIT handler: %s",
                          strerror(-ret));
-            exit(1);
+            return ret;
         }
 
         ret = kvm_filter_msr(s, MSR_PKG_POWER_INFO,
@@ -3188,17 +3188,17 @@ static void kvm_vm_enable_energy_msrs(KVMState *s)
         if (ret < 0) {
             error_report("Could not install MSR_PKG_POWER_INFO handler: %s",
                          strerror(-ret));
-            exit(1);
+            return ret;
         }
         ret = kvm_filter_msr(s, MSR_PKG_ENERGY_STATUS,
                              kvm_rdmsr_pkg_energy_status, NULL);
         if (ret < 0) {
             error_report("Could not install MSR_PKG_ENERGY_STATUS handler: %s",
                          strerror(-ret));
-            exit(1);
+            return ret;
         }
     }
-    return;
+    return 0;
 }
 
 int kvm_arch_init(MachineState *ms, KVMState *s)
@@ -3265,7 +3265,10 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
         return ret;
     }
 
-    kvm_get_supported_feature_msrs(s);
+    ret = kvm_get_supported_feature_msrs(s);
+    if (ret < 0) {
+        return ret;
+    }
 
     uname(&utsname);
     lm_capable_kernel = strcmp(utsname.machine, "x86_64") == 0;
@@ -3301,6 +3304,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
         if (ret < 0) {
             error_report("kvm: guest stopping CPU not supported: %s",
                          strerror(-ret));
+            return ret;
         }
     }
 
@@ -3332,12 +3336,15 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
         }
 
         if (s->msr_energy.enable == true) {
-            kvm_vm_enable_energy_msrs(s);
+            ret = kvm_vm_enable_energy_msrs(s);
+            if (ret < 0) {
+                return ret;
+            }
 
             ret = kvm_msr_energy_thread_init(s, ms);
             if (ret < 0) {
                 error_report("kvm : error RAPL feature requirement not met");
-                exit(1);
+                return ret;
             }
         }
     }
-- 
2.47.1


