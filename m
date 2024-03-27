Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54242C47DD9
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Mar 2024 09:54:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpPzE-0008OG-Vc; Wed, 27 Mar 2024 05:54:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rpPyV-0007fJ-16
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 05:53:42 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rpPyT-000750-7q
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 05:53:38 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a466fc8fcccso829713666b.1
 for <qemu-devel@nongnu.org>; Wed, 27 Mar 2024 02:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711533211; x=1712138011; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GNAyK3lGFt7pCi07DIyw1qVnA4J8LeB4ju/ikziy2DE=;
 b=Lza21vgmE04xxElR9tJzMEGgyx7FbKoJ5hTUJzGu2bCbqu13jjtVMQLtNNJz2QjTxF
 nQjwdwXGf0LqTQ+U6iJ02eXRbBksxglxTiWX8BQ2KmHTCy1bumkKt3G1ntm+pqV7sR2h
 jir55obDRwc2QbtM5/0z/CCTb1ofOCkWy4cf+cn7HgQW2jOGtzIXzVHWUzrI3n5I/Zon
 CBqM5eAbQ3P4TRccU1VjIdSfH/X4asJXrIIaQyJTf/Hw/QUKsxu4tzvIEKivzzepXwYS
 cxS5KoDSCX7zRGzBzeFPxCokJogD7vGpsQmM5Qy5d8J0kUeDqiXhPc3muVQhhWcfTOIk
 JWYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711533211; x=1712138011;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GNAyK3lGFt7pCi07DIyw1qVnA4J8LeB4ju/ikziy2DE=;
 b=F3y00a9qFX/x/XiK+wp9QBY++vCrZJ1wlAveRRM2ESfYk/Y7kz6g/CqR7YlGCpTyme
 4Urk9BGeSfbfRemDc3yQPCoKeYqG0QQevWsTi2okE/toKvbXvOXjIu+lH7fw9keRlHXF
 AVRjEaLklZ6oIKOMIBxC83N7oW6CD4qTAX8lR41wO2UZWMQlnx3fKdDNQI4rRk4E+5fv
 JKFXXBeeqOPKOzO8UnlwXUbND05Iu7DGqTZVAjPTKQYA4zPlrPvgGoiwhu1BOQIeAeER
 CEGJORRHi70PiCOy5Xufx0IVtjyXiz4hD3QAVQgS9nVE2FiHVmVtFLDScuyHCIz/iyl7
 S3/A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVRSl/fI+1paP0DN+9UwruFTeGVJuelqt4UN+7VDPYamj2NDKnhnhgryThVQytXS2/DYlJ1Mzk4sj955KrF3Zu+h8CJUnw=
X-Gm-Message-State: AOJu0YxQzZUh9OFcw3gxKr6u/6JzGEBdo1XN9d5xle0GW5Qa6OBOg3Ab
 PlBhG2zsGj3dLW8rOfoMbU3en+atQ2F+xNTcvRuBI/sFfLshKOaloftLxs8IxlpoR85V158K94N
 4
X-Google-Smtp-Source: AGHT+IFqlzJkjsEArB0K4+VQ5UbPfp4Drf5hySW8JZyMQzhoQOcPjv7NaxQMw4TTbsNtYR4e4aRJTg==
X-Received: by 2002:a17:906:b257:b0:a47:39c6:8970 with SMTP id
 ce23-20020a170906b25700b00a4739c68970mr2716915ejb.39.1711533211584; 
 Wed, 27 Mar 2024 02:53:31 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.205.175])
 by smtp.gmail.com with ESMTPSA id
 n6-20020a170906700600b00a474b3c90c4sm4437161ejj.24.2024.03.27.02.53.29
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 27 Mar 2024 02:53:31 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, devel@lists.libvirt.org,
 Zhao Liu <zhao1.liu@intel.com>, Gerd Hoffmann <kraxel@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcelo Tosatti <mtosatti@redhat.com>, kvm@vger.kernel.org
Subject: [PATCH-for-9.1 v2 20/21] target/i386: Remove
 X86CPU::kvm_no_smi_migration field
Date: Wed, 27 Mar 2024 10:51:22 +0100
Message-ID: <20240327095124.73639-21-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240327095124.73639-1-philmd@linaro.org>
References: <20240327095124.73639-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

X86CPU::kvm_no_smi_migration was only used by the
pc-i440fx-2.3 machine, which got removed. Remove it
and simplify kvm_put_vcpu_events().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/i386/cpu.h     | 3 ---
 target/i386/cpu.c     | 2 --
 target/i386/kvm/kvm.c | 7 +------
 3 files changed, 1 insertion(+), 11 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 6b05738079..5b016d6667 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2018,9 +2018,6 @@ struct ArchCPU {
     /* if set, limit maximum value for phys_bits when host_phys_bits is true */
     uint8_t host_phys_bits_limit;
 
-    /* Stop SMI delivery for migration compatibility with old machines */
-    bool kvm_no_smi_migration;
-
     /* Forcefully disable KVM PV features not exposed in guest CPUIDs */
     bool kvm_pv_enforce_cpuid;
 
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 33760a2ee1..f9991e7398 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -7905,8 +7905,6 @@ static Property x86_cpu_properties[] = {
     DEFINE_PROP_BOOL("x-vendor-cpuid-only", X86CPU, vendor_cpuid_only, true),
     DEFINE_PROP_BOOL("lmce", X86CPU, enable_lmce, false),
     DEFINE_PROP_BOOL("l3-cache", X86CPU, enable_l3_cache, true),
-    DEFINE_PROP_BOOL("kvm-no-smi-migration", X86CPU, kvm_no_smi_migration,
-                     false),
     DEFINE_PROP_BOOL("kvm-pv-enforce-cpuid", X86CPU, kvm_pv_enforce_cpuid,
                      false),
     DEFINE_PROP_BOOL("vmware-cpuid-freq", X86CPU, vmware_cpuid_freq, true),
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index e68cbe9293..88f4a7da33 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -4337,6 +4337,7 @@ static int kvm_put_vcpu_events(X86CPU *cpu, int level)
     events.sipi_vector = env->sipi_vector;
 
     if (has_msr_smbase) {
+        events.flags |= KVM_VCPUEVENT_VALID_SMM;
         events.smi.smm = !!(env->hflags & HF_SMM_MASK);
         events.smi.smm_inside_nmi = !!(env->hflags2 & HF2_SMM_INSIDE_NMI_MASK);
         if (kvm_irqchip_in_kernel()) {
@@ -4351,12 +4352,6 @@ static int kvm_put_vcpu_events(X86CPU *cpu, int level)
             events.smi.pending = 0;
             events.smi.latched_init = 0;
         }
-        /* Stop SMI delivery on old machine types to avoid a reboot
-         * on an inward migration of an old VM.
-         */
-        if (!cpu->kvm_no_smi_migration) {
-            events.flags |= KVM_VCPUEVENT_VALID_SMM;
-        }
     }
 
     if (level >= KVM_PUT_RESET_STATE) {
-- 
2.41.0


