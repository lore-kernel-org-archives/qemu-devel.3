Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4879E7719D
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 18:49:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWK3J-0002OD-Mn; Fri, 10 Jan 2025 13:48:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tWK2a-0000ON-Ah
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 13:47:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tWK2X-0001C6-PV
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 13:47:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736534845;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KwvMlaaL+tPMbyB1+Vl82XLEBLQqNeaz0XWCjaoRtTw=;
 b=VGLjURof/tVcmHj1tVssuS3BILZFW0gmcZRjwegxsumHaJocoLk7xFQQLQvD5An80Fd5a4
 ifF/o6FQIpmUhm7l+us9N+kGctQZbDsFyjdcUPSE676oLHFe0wL9M6BRsoF7OfkDUEOL9/
 bUxEE8yIGux8bfK8+kB1/1+jyW6pYm8=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-686-sNHVW9b6OMS7Fso_hPYbAg-1; Fri, 10 Jan 2025 13:47:24 -0500
X-MC-Unique: sNHVW9b6OMS7Fso_hPYbAg-1
X-Mimecast-MFC-AGG-ID: sNHVW9b6OMS7Fso_hPYbAg
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-aa67855b3deso200726566b.1
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 10:47:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736534842; x=1737139642;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KwvMlaaL+tPMbyB1+Vl82XLEBLQqNeaz0XWCjaoRtTw=;
 b=Lox7jsoKcGlYxXlx/u4U7l0e/iOqKHcMLJ78J59nyx9PjRnXhcWJdpMF64oJsOeAQ1
 SCBzp/f7hMm+7R88RZJRYZpPQbMhJyxdzUu5n4I+yDtqT0FJhVv4q7bibyN3iIKZpDMA
 weoVe8ZrruBi21Or1pC5gG8uWIhX4WUo5ZTar6fbgPokY78nb4VX8u8VQ3HDizbxiprL
 WDJKFgxskBaVhtDe9s+SqFtUal500JmvxjtWZQ5bDxSI4BL5ZL+FZmE9YllVmOe1/HT2
 lZIKte8f9zlnHCAppe3j3LKwoGl8B+odrIZ4MEuERSQTB6Zzqmt/OHM6iocybkJrUt5B
 kODg==
X-Gm-Message-State: AOJu0Yz8V761u9PfXp6SLulaD5LJeOerVpgwDGsmHhl+2X2RIl63H8Kl
 CTsbgZ/aPyBzXdKrR216frSc/gZtVk5/853NGSNT2gD9WDn3ZzQZZfiCNEiXMjI7Xz5FGrmTugD
 BchA1rbbD7IVUH78oU+GcjGNxD0X0I+lBjczpP1Bnh31KKtsnCrvneL52ISsiFM3h+O+X5XRNWX
 CkzYJ0G6d1fALnGMIy0HzKB8tNLjCeADjBklZ/kgY=
X-Gm-Gg: ASbGnct6KbFVDoie2quhDrsiGkJPcglpE65PpyDl+sRaivswyGxJ6vTGverT1GveerV
 oi8+rTUUYK4BmJsixUbtT7ANitskGY3zlztyLgTwT3KtpHn7iEhahxFA05softUfE4lc9nGKnoS
 97wB4+YtfxSyr8jU6c7JqTMWZiz/LgoT8+PyK08P1q2uKGi0uasxEjp7YygqxTv5U9k/svqwsYC
 79jDnWRWubhBmQDmoEwn1FFUjLMkKDtnRgHLgc85uwtU7bZCIKuAjJQXWQ=
X-Received: by 2002:a17:906:c102:b0:aa6:7f99:81aa with SMTP id
 a640c23a62f3a-ab2ab676541mr974933266b.6.1736534842209; 
 Fri, 10 Jan 2025 10:47:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFSOtxbDmrlKrcpt/J7ZFm/gGnj3omYM4o1KKX8yxlVl+duSSQJUFniPqFWRRSA9ObS5oIJiA==
X-Received: by 2002:a17:906:c102:b0:aa6:7f99:81aa with SMTP id
 a640c23a62f3a-ab2ab676541mr974930866b.6.1736534841748; 
 Fri, 10 Jan 2025 10:47:21 -0800 (PST)
Received: from [192.168.10.3] ([151.62.105.73])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab2c95648b1sm192320666b.112.2025.01.10.10.47.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jan 2025 10:47:19 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 26/38] target/i386/kvm: Return -1 when
 kvm_msr_energy_thread_init() fails
Date: Fri, 10 Jan 2025 19:46:07 +0100
Message-ID: <20250110184620.408302-27-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250110184620.408302-1-pbonzini@redhat.com>
References: <20250110184620.408302-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.432,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Zhao Liu <zhao1.liu@intel.com>

It is common practice to return a negative value (like -1) to indicate
an error, and other functions in kvm_arch_init() follow this style.

To avoid confusion (sometimes returned -1 indicates failure, and
sometimes -1, in a same function), return -1 when
kvm_msr_energy_thread_init() fails.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20241106030728.553238-10-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/kvm/kvm.c | 29 +++++++++++------------------
 1 file changed, 11 insertions(+), 18 deletions(-)

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 097a040da30..3624abbb397 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -2936,7 +2936,6 @@ static int kvm_msr_energy_thread_init(KVMState *s, MachineState *ms)
 {
     MachineClass *mc = MACHINE_GET_CLASS(ms);
     struct KVMMsrEnergy *r = &s->msr_energy;
-    int ret = 0;
 
     /*
      * Sanity check
@@ -2946,13 +2945,11 @@ static int kvm_msr_energy_thread_init(KVMState *s, MachineState *ms)
     if (!is_host_cpu_intel()) {
         error_report("The RAPL feature can only be enabled on hosts "
                      "with Intel CPU models");
-        ret = 1;
-        goto out;
+        return -1;
     }
 
     if (!is_rapl_enabled()) {
-        ret = 1;
-        goto out;
+        return -1;
     }
 
     /* Retrieve the virtual topology */
@@ -2974,16 +2971,14 @@ static int kvm_msr_energy_thread_init(KVMState *s, MachineState *ms)
     r->host_topo.maxcpus = vmsr_get_maxcpus();
     if (r->host_topo.maxcpus == 0) {
         error_report("host max cpus = 0");
-        ret = 1;
-        goto out;
+        return -1;
     }
 
     /* Max number of packages on the host */
     r->host_topo.maxpkgs = vmsr_get_max_physical_package(r->host_topo.maxcpus);
     if (r->host_topo.maxpkgs == 0) {
         error_report("host max pkgs = 0");
-        ret = 1;
-        goto out;
+        return -1;
     }
 
     /* Allocate memory for each package on the host */
@@ -2995,8 +2990,7 @@ static int kvm_msr_energy_thread_init(KVMState *s, MachineState *ms)
     for (int i = 0; i < r->host_topo.maxpkgs; i++) {
         if (r->host_topo.pkg_cpu_count[i] == 0) {
             error_report("cpu per packages = 0 on package_%d", i);
-            ret = 1;
-            goto out;
+            return -1;
         }
     }
 
@@ -3013,8 +3007,7 @@ static int kvm_msr_energy_thread_init(KVMState *s, MachineState *ms)
 
     if (s->msr_energy.sioc == NULL) {
         error_report("vmsr socket opening failed");
-        ret = 1;
-        goto out;
+        return -1;
     }
 
     /* Those MSR values should not change */
@@ -3026,15 +3019,13 @@ static int kvm_msr_energy_thread_init(KVMState *s, MachineState *ms)
                                     s->msr_energy.sioc);
     if (r->msr_unit == 0 || r->msr_limit == 0 || r->msr_info == 0) {
         error_report("can't read any virtual msr");
-        ret = 1;
-        goto out;
+        return -1;
     }
 
     qemu_thread_create(&r->msr_thr, "kvm-msr",
                        kvm_msr_energy_thread,
                        s, QEMU_THREAD_JOINABLE);
-out:
-    return ret;
+    return 0;
 }
 
 int kvm_arch_get_default_type(MachineState *ms)
@@ -3342,7 +3333,9 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
 
         if (s->msr_energy.enable == true) {
             kvm_vm_enable_energy_msrs(s);
-            if (kvm_msr_energy_thread_init(s, ms)) {
+
+            ret = kvm_msr_energy_thread_init(s, ms);
+            if (ret < 0) {
                 error_report("kvm : error RAPL feature requirement not met");
                 exit(1);
             }
-- 
2.47.1


