Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29F2DC83F17
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 00:07:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ua1I6-0006Oh-8G; Thu, 10 Jul 2025 20:07:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ua1Hq-0006N0-1N
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 20:06:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ua1Hk-0007Ys-Vv
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 20:06:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752192397;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fGW0HRmDK6hg15Zwtq0nBpsTyFBRjks26Xbj01uEwQU=;
 b=CjcYHMkgBNXsUNOm0vFmGMiiR2D3tlLv8cOZ88s4xASp16VvdoNuDO5DOEtL9fUPjDcbPC
 LJoeBDqjCv+pWifkErxerOqpGT42aTwNqvp3XZzkt26oErC2y1kGv6AEsEsYp6bmMqUKBd
 3TCigxOOI6kbiXzVbRJ4Hm4K7IZe5MA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-Yey_nKBSPFK06zSQuCGKUA-1; Thu, 10 Jul 2025 20:06:29 -0400
X-MC-Unique: Yey_nKBSPFK06zSQuCGKUA-1
X-Mimecast-MFC-AGG-ID: Yey_nKBSPFK06zSQuCGKUA_1752192388
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3a4f65a705dso1090541f8f.2
 for <qemu-devel@nongnu.org>; Thu, 10 Jul 2025 17:06:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752192387; x=1752797187;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fGW0HRmDK6hg15Zwtq0nBpsTyFBRjks26Xbj01uEwQU=;
 b=U2RZvhRbaHv0fM8S+Knkh6H3LIniZSpnD1M1iM0RyIQjn/ym9GElFW9yj5Vm+oyb8v
 jRb+QJHu5W5jbEMaMFg94cYJK7UeDswZRjtf6eHUaswZeLFGKdVtOCUQspW0Eh7ib/Zm
 OtkAR4K7/LXAM94CZGWZqA8wiYI8JavrUpMk8ZLmJI8AdiA44rY75rn/5III1ObvnaYR
 v0PRFZQODJFALdTcTcd+BOApXcF3nneHveMdjhLEvwDLUmfeT1pc4HPGn+p0GrTPmLtM
 EHDYdfgJfsU1pWgWFe8MzUbOWbvqkVsgRptSAfce40Uaoghser88medox2vWHXQHC5qS
 FOXg==
X-Gm-Message-State: AOJu0YzGIhmVnckioZUcjD6RhQJ9GjfwDRA1dWdZ0IUDZCgjwJC+bDi8
 mDo/wt65RwjEhhLLAr/u3IlgANSV22OMlVekYArNULW9nZpNC3XUX+yfiJtR0mLLyQExAXUCHUh
 QBuVrZbFjtd9ziX0GJhltlpVIn6sarNg4YDGX1G9xpYdO4KUJhU5CWkIXeqp0zuQsiPXq3i05c1
 tewbhld3RF1g6SF50aaZdyzuBufyDSjznZLg8P1WX7
X-Gm-Gg: ASbGncsHktak3WVdjGkAtQ7h3ZsGHqE6hT5mD5XRywH2Xw1y8awEuz+swR4SLk6jv2V
 xZcd0qdv4l3eD2zpo8R0knvOYmuIQHahmIris9C3yUPwz7nL9zUI/ioCAMVf8ZwMVhsKNlpXaTn
 a/ssiPXAfl5KpqRftwjNWeUcCZVZjXrZiAsGJPBUmrVYCqjmR1+G7lyWcp6d8Ra7cF4Z1/R9VNg
 3mvLQSaWHkd7HFDDMhTdzTchHtBpsuIfKnN2aeXzb79BRnsM9yQWsNotJGelPfqOeaJNLRNczwu
 N9MYnRKsx+7C33mKdythOFWugg4Tggrpo8y3XctLb/aX
X-Received: by 2002:a05:6000:26ca:b0:3aa:caea:aa7f with SMTP id
 ffacd0b85a97d-3b5f2e4901amr447822f8f.56.1752192387226; 
 Thu, 10 Jul 2025 17:06:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGCeBCjWW7gscQYOiEalbWaDB7ZdEriztzByvyPw7w09XAUBAbNyb3kuQ4/BOueiLDu8DRl+w==
X-Received: by 2002:a05:6000:26ca:b0:3aa:caea:aa7f with SMTP id
 ffacd0b85a97d-3b5f2e4901amr447805f8f.56.1752192386738; 
 Thu, 10 Jul 2025 17:06:26 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.202.169])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8dc91d8sm2996066f8f.42.2025.07.10.17.06.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Jul 2025 17:06:22 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: xiaoyao.li@intel.com,
	zhao1.liu@intel.com
Subject: [PATCH 3/4] target/i386: allow reordering max_x86_cpu_initfn vs accel
 CPU init
Date: Fri, 11 Jul 2025 02:06:02 +0200
Message-ID: <20250711000603.438312-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250711000603.438312-1-pbonzini@redhat.com>
References: <20250711000603.438312-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

The PMU feature is only supported by KVM, so move it there.  And since
all accelerators other than TCG overwrite the vendor, set it in
max_x86_cpu_initfn only if it has not been initialized by the
superclass.  This makes it possible to run max_x86_cpu_initfn
after accelerator init.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c         | 24 ++++++++++++------------
 target/i386/kvm/kvm-cpu.c |  2 ++
 2 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 69bdffbfe46..46d59229200 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -6204,21 +6204,21 @@ static void max_x86_cpu_class_init(ObjectClass *oc, const void *data)
 static void max_x86_cpu_initfn(Object *obj)
 {
     X86CPU *cpu = X86_CPU(obj);
-
-    /* We can't fill the features array here because we don't know yet if
-     * "migratable" is true or false.
-     */
-    object_property_set_bool(OBJECT(cpu), "pmu", true, &error_abort);
+    CPUX86State *env = &cpu->env;
 
     /*
-     * these defaults are used for TCG and all other accelerators
-     * besides KVM and HVF, which overwrite these values
+     * these defaults are used for TCG, other accelerators overwrite these
+     * values
      */
-    object_property_set_str(OBJECT(cpu), "vendor", CPUID_VENDOR_AMD,
-                            &error_abort);
-    object_property_set_str(OBJECT(cpu), "model-id",
-                            "QEMU TCG CPU version " QEMU_HW_VERSION,
-                            &error_abort);
+    if (!env->cpuid_vendor1) {
+        object_property_set_str(OBJECT(cpu), "vendor", CPUID_VENDOR_AMD,
+                                &error_abort);
+    }
+    if (!env->cpuid_model[0]) {
+        object_property_set_str(OBJECT(cpu), "model-id",
+                                "QEMU TCG CPU version " QEMU_HW_VERSION,
+                                &error_abort);
+    }
 }
 
 static const TypeInfo max_x86_cpu_type_info = {
diff --git a/target/i386/kvm/kvm-cpu.c b/target/i386/kvm/kvm-cpu.c
index 0fb88a239d4..6fed353548e 100644
--- a/target/i386/kvm/kvm-cpu.c
+++ b/target/i386/kvm/kvm-cpu.c
@@ -111,6 +111,8 @@ static void kvm_cpu_max_instance_init(X86CPU *cpu)
 
     host_cpu_max_instance_init(cpu);
 
+    object_property_set_bool(OBJECT(cpu), "pmu", true, &error_abort);
+
     if (lmce_supported()) {
         object_property_set_bool(OBJECT(cpu), "lmce", true, &error_abort);
     }
-- 
2.50.0


