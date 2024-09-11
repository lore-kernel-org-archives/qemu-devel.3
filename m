Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9AEAEE499F
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 12:34:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soMY9-0007Dz-4R; Wed, 11 Sep 2024 08:34:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1soMY2-0006OW-Nh
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 08:34:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1soMXz-00014G-Rh
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 08:34:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726058050;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mBgLkkL3Ij9Xb+6zZYO4yZDOwxGEAxoAbZBtbC+FfYw=;
 b=Ta88RH6EL8tz3FOr+y0xeR/d9XevWxI2XRLniQGIHom+gyFHU4RxVkjtFHVHus6FkICpEH
 yBZnHsOBO371Rd84b/Ml38BYcrMCJ1eiY9xvPn6SmaKbWmMtMcLoMqGMgAAVtuZyLfypCq
 /4CdAfhcoDkhIyrfwGoCv0ysppEUvjs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-AWbIQKy8M-i0UJMBrZOjIw-1; Wed, 11 Sep 2024 08:34:09 -0400
X-MC-Unique: AWbIQKy8M-i0UJMBrZOjIw-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-42cb89fbb8cso21731775e9.0
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 05:34:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726058048; x=1726662848;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mBgLkkL3Ij9Xb+6zZYO4yZDOwxGEAxoAbZBtbC+FfYw=;
 b=LuFpQ4+YMofj/4o8V9A+AGMC7D/V5Djoh2kz2wz2b1Uj7aUpg+b7r1ffkGUtHCAAWJ
 VTMMFisgSlIvtdEDZZxtN8WWBSRiB3q/EnZxE2TjKrHkzsRV00hgCXK/zkgxmvtU5nlv
 +dXR54Klj8mACbg7SSSYKjCQ/tlKYonwys2N5qbGlRKJa23vKE7mn52KZvtWY8fLAP4B
 0OqWOXZEB+ysKmt53/Ym4BBTjgDaSMHBvH3FwJttTUKKUluH4ZHiHeoXufShp0xUmN9I
 6ySma3xSt6MtrqKXYiWEdjxfFgBz2K7j6gvYAYEhFD8moAyZDfkssEyu6rzFO1vqkB4a
 ozQg==
X-Gm-Message-State: AOJu0Ywt/OzKU2K7G/GDPF9v1PoBaosuNC4SjTmPAogdYTi7j5/bJ8kH
 Ey6iztK23eOm+3ECpFQkVWKNWJ72gdcTstQvnVRIWHjLj0eLrbJtKdWI9uwpsMuX/7fsXYIyJLv
 DTwq2Bfa3T8MBIZYSDoSDfzZJC8RHC1njVImLp0I+jCJNb/qlDkLP8GnH3kRsACpfpH0efPhiqY
 aunDbKNnOHXS1vdfYZ6dvacdr7aWUTPEBNvOpkN5c=
X-Received: by 2002:a05:600c:45c8:b0:429:dc88:7e65 with SMTP id
 5b1f17b1804b1-42cad760eedmr101160115e9.12.1726058047886; 
 Wed, 11 Sep 2024 05:34:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHndJ996xi0cDrIvpw8cBgdEm0rBe9b+En4atTREDihcyNBz2Hu1sd8h5zKcisloIazlU0Kug==
X-Received: by 2002:a05:600c:45c8:b0:429:dc88:7e65 with SMTP id
 5b1f17b1804b1-42cad760eedmr101159735e9.12.1726058047239; 
 Wed, 11 Sep 2024 05:34:07 -0700 (PDT)
Received: from avogadro.local ([151.95.101.29])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-378956d3796sm11446737f8f.80.2024.09.11.05.34.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2024 05:34:06 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>, qemu-trivial@nongnu.org,
 zhao1.liu@intel.com, armbru@redhat.com
Subject: [PULL 08/17] kvm: replace fprintf with error_report()/printf() in
 kvm_init()
Date: Wed, 11 Sep 2024 14:33:33 +0200
Message-ID: <20240911123342.339482-9-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240911123342.339482-1-pbonzini@redhat.com>
References: <20240911123342.339482-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
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
Link: https://lore.kernel.org/r/20240828124539.62672-1-anisinha@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 accel/kvm/kvm-all.c | 40 ++++++++++++++++++----------------------
 1 file changed, 18 insertions(+), 22 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 75d11a07b2b..fcc157f0e60 100644
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
2.46.0


