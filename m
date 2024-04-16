Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2859DC04FF6
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2024 19:03:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwo4V-0005U0-SZ; Tue, 16 Apr 2024 15:02:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rwo4F-0003go-Qp
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 15:02:08 -0400
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rwo4C-0005tr-Cm
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 15:02:07 -0400
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-516d727074eso6174608e87.0
 for <qemu-devel@nongnu.org>; Tue, 16 Apr 2024 12:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713294122; x=1713898922; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h1653K/UfEWnXUTbr/YeJw2UmUosHHOUFfds+vppZrE=;
 b=m1uu1bXdSeZn95aU1obdUE+N8UpmxJNLlyH3r5X5RSKi06txBlJsLRQMVBh4ZsI6oF
 5SYh+aa3YvHPNO7p7hmWL4GoJM6y+1BmZLf0oAN5c+VksvXVuAzi4WDIYOHa55cEmeuo
 p6kGy1xPcalKykCSlcGZNtkDDG2qDia+dPBWx8cqd6MWi2IuqEIJKXfs6Am7oqYbRWyh
 sE0DSE8LLy/rO7cGXPJ9ldDrUJUkz75P8fB1knZhlRw4cv8qbpwdRaR6GAwzVwvWlQaV
 /jPjxRMF7RgywrF0eqmm4sigJdTvVFCWIvenwqELTHiZJg5QDQQiAd3sIf69i3LZsdk6
 kSCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713294122; x=1713898922;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h1653K/UfEWnXUTbr/YeJw2UmUosHHOUFfds+vppZrE=;
 b=cRo7V9DtRM702xcrFGDGenQ9NANCw55BAN3iDkzO0ND/dYr21hjOYzmRq0OGoSZ4iT
 Mn3ZEW2+zVkwG2NcvCz6L2GEXYkKkvwh2QC8lW72XTWd5OyG+/i9oYVW2gYKxgPGY/7Y
 45DRWN+6uYXmbhF7eMfn1puY/nO9m77/YWkSPZ3CN9qc8i3BaFME6pu5vQK7Rx8626Pc
 r59VO3daQW1S9QOw7Xi0vgTaoIr3Z1UGWZ7RXk8ri64Wg7cV6NGm53dtU6Iibdt5nfez
 oQVCp0vjaBWWuG3f1ipQc4GXx+euCdr0pd1dtXPj6C1ke3Qyi6GO6Pwde2D4uf52tt8a
 3o7g==
X-Gm-Message-State: AOJu0YwAMy8zR1RlawLx1uNtOef68Q6JADFiGom7IU0p1N0bU5nQlDXd
 FaIQJXVAzaE3/N7/qHIqSX+ZpVGHoudYKqjBZanULnVH+uHjuwTOTfAJfNe0OGI+zVG99Lak6Cs
 1
X-Google-Smtp-Source: AGHT+IEHRsVutYB17m+/QrIlhkoNuNzc8b/Lou/MToYRe0nANYYcGjkDKUkf+XUo5NjTJqJrDznq6w==
X-Received: by 2002:ac2:5a0f:0:b0:518:d259:8542 with SMTP id
 q15-20020ac25a0f000000b00518d2598542mr5101592lfn.2.1713294122153; 
 Tue, 16 Apr 2024 12:02:02 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.155.61])
 by smtp.gmail.com with ESMTPSA id
 y9-20020a170906470900b00a51a74409dcsm7262977ejq.221.2024.04.16.12.01.58
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 16 Apr 2024 12:02:01 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Thomas Huth <thuth@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-riscv@nongnu.org,
 David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 kvm@vger.kernel.org, qemu-ppc@nongnu.org, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Marcelo Tosatti <mtosatti@redhat.com>
Subject: [PATCH v4 21/22] target/i386: Remove X86CPU::kvm_no_smi_migration
 field
Date: Tue, 16 Apr 2024 20:59:37 +0200
Message-ID: <20240416185939.37984-22-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240416185939.37984-1-philmd@linaro.org>
References: <20240416185939.37984-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::136;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x136.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
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


