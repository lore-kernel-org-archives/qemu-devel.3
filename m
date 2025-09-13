Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BBA5CAC58E
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Sep 2025 08:25:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uxLNd-0003hC-0u; Sat, 13 Sep 2025 04:13:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uxLMx-0001gS-Df
 for qemu-devel@nongnu.org; Sat, 13 Sep 2025 04:12:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uxLMp-0005H3-RR
 for qemu-devel@nongnu.org; Sat, 13 Sep 2025 04:12:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757751138;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kXV8lyIjHzKxLuPEWkgQ4DrNPB+JccPFBiYkgzxwKUQ=;
 b=QEKhLMOs4knW69J3pgACjJtFAXBIoiZx6rNvqmJDcem3kJBOBVpYkLfo8WGMmuPdArqGWK
 pXX4COewLgjl/rNNupkYgDT7zza/eUA5PFXY4FvS9BA4WdKnCWKZeX9X7TO6Fd7L6EP8WD
 2SKXJiBhCdTCy/CJ23Fb3HypJyFYztg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-373-ZuAyM5Z4OxmmDrcUbFtEZw-1; Sat, 13 Sep 2025 04:12:16 -0400
X-MC-Unique: ZuAyM5Z4OxmmDrcUbFtEZw-1
X-Mimecast-MFC-AGG-ID: ZuAyM5Z4OxmmDrcUbFtEZw_1757751136
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-45d6c770066so12719695e9.0
 for <qemu-devel@nongnu.org>; Sat, 13 Sep 2025 01:12:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757751134; x=1758355934;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kXV8lyIjHzKxLuPEWkgQ4DrNPB+JccPFBiYkgzxwKUQ=;
 b=YkZptVcX4RqotqLv5un/8Vw97NfOKHbaDnhVRNYubkG/V5lOtMVN4nt8NjqwcZ8hZA
 kq73//dRru2SUbTIXTPh4yk5p1MRuxu/iXxz4Xg1v9b4Q9fsMex6CB82QzQPjAtscFqL
 DmZ5saw13MAkeogbpVsjwE7qlKcELQAzQtwkUpsQXk5QsMksCEwdzMrSYB9BrHdF1yCv
 SmfERC85mbbYeY9qwr8C+CfDPN2NXTA/EE18w2eM/GUYU3f9WMLU+DgjWb0D5QS2D/oN
 a0+2v/w2PARiC27rSfZDYOEaQPzKVyJSXeBCu9e1w8fwB5KgBCum6UF0c67ZbPExRfJQ
 CyEA==
X-Gm-Message-State: AOJu0YwCqgHIMY4ozJ4xvS36wJCG86+2A/2wHHTep4yL5GS0n8cpSiqV
 r4f/pQqLnmFST4XORs+DiEzns5jBMp/Rt9qMObfgpbVJAkafdoI3/B2Ku/Yypm56bRtN8HJBT+m
 5gcY9t3PU+Riv6ranYP3RmNDjj594R9XrqlRzdQKw8PZV9cP0mZ8w4h7YWuOEkAB5pgvWSmbsXG
 ZG5JNTQ9CeotvUub9T7aWaVDrXWGQb1GBgrhTIZwZZ
X-Gm-Gg: ASbGncusTgJwG52TNzNCF87o/sd2jk6FWW1s4c1sjAaXuZc2JdqaqqjBPSjiRNd8g3V
 8SgNnCGPUx/qg1GMOgzKCPfbCb7QvUirgZM/WWZ1rLMcAvQXoDzuMNn6v3eC95LoYzFN5M/8upD
 znbxe6+R2NyQtPgjx0lgFjYeNlYfdEiIVW+3NdHvlOlXtjLdVGZUXqbc47BWP6FTCq7jQ0Yt2am
 okZYhq9/8ivl/QKLnNwnxkYp4medIeWP19F44TE5jXWD5SpZ19dFW8HerK17k098f0dEPts9Zs2
 mypHnPL3vOAl4l5yPAD6q/Yb0QvqJHwWKHFnQbbuUrAfOKJL0Nqg74+Yu1hpjgAOvLB84iDrisH
 KAqeGK7N7cBiDozQ1kJUZMA7VlgX1ex23/ySQ2NDecrw=
X-Received: by 2002:a05:600c:364b:b0:45d:dae8:b137 with SMTP id
 5b1f17b1804b1-45f211f3140mr39730665e9.22.1757751134406; 
 Sat, 13 Sep 2025 01:12:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHP6pu/Hcg3CnH5TXuMk4llyoUElyCIeSvuynbeIkybWWTxciigS6OBh2u/qLw/qjSFQ3burg==
X-Received: by 2002:a05:600c:364b:b0:45d:dae8:b137 with SMTP id
 5b1f17b1804b1-45f211f3140mr39730405e9.22.1757751133848; 
 Sat, 13 Sep 2025 01:12:13 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.56.250])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45e01832af1sm50583305e9.3.2025.09.13.01.12.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 13 Sep 2025 01:12:12 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Xiaoyao Li <xiaoyao.li@intel.com>,
 Kirill Martynov <stdcalllevi@yandex-team.ru>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 54/61] i386/cpu: Enable SMM cpu address space under KVM
Date: Sat, 13 Sep 2025 10:09:35 +0200
Message-ID: <20250913080943.11710-55-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250913080943.11710-1-pbonzini@redhat.com>
References: <20250913080943.11710-1-pbonzini@redhat.com>
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
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Xiaoyao Li <xiaoyao.li@intel.com>

Kirill Martynov reported assertation in cpu_asidx_from_attrs() being hit
when x86_cpu_dump_state() is called to dump the CPU state[*]. It happens
when the CPU is in SMM and KVM emulation failure due to misbehaving
guest.

The root cause is that QEMU i386 never enables the SMM address space for
cpu since KVM SMM support has been added.

Enable the SMM cpu address space under KVM when the SMM is enabled for
the x86machine.

[*] https://lore.kernel.org/qemu-devel/20250523154431.506993-1-stdcalllevi@yandex-team.ru/

Reported-by: Kirill Martynov <stdcalllevi@yandex-team.ru>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Tested-by: Kirill Martynov <stdcalllevi@yandex-team.ru>
Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Link: https://lore.kernel.org/r/20250730095253.1833411-2-xiaoyao.li@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 system/physmem.c          |  5 -----
 target/i386/kvm/kvm-cpu.c | 10 ++++++++++
 target/i386/kvm/kvm.c     |  5 +++++
 3 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/system/physmem.c b/system/physmem.c
index 311011156c7..a12c7ea1956 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -793,9 +793,6 @@ void cpu_address_space_init(CPUState *cpu, int asidx,
         cpu->as = as;
     }
 
-    /* KVM cannot currently support multiple address spaces. */
-    assert(asidx == 0 || !kvm_enabled());
-
     if (!cpu->cpu_ases) {
         cpu->cpu_ases = g_new0(CPUAddressSpace, cpu->num_ases);
         cpu->cpu_ases_count = cpu->num_ases;
@@ -818,8 +815,6 @@ void cpu_address_space_destroy(CPUState *cpu, int asidx)
 
     assert(cpu->cpu_ases);
     assert(asidx >= 0 && asidx < cpu->num_ases);
-    /* KVM cannot currently support multiple address spaces. */
-    assert(asidx == 0 || !kvm_enabled());
 
     cpuas = &cpu->cpu_ases[asidx];
     if (tcg_enabled()) {
diff --git a/target/i386/kvm/kvm-cpu.c b/target/i386/kvm/kvm-cpu.c
index 89a79536594..1dc1ba9b486 100644
--- a/target/i386/kvm/kvm-cpu.c
+++ b/target/i386/kvm/kvm-cpu.c
@@ -13,6 +13,7 @@
 #include "qapi/error.h"
 #include "system/system.h"
 #include "hw/boards.h"
+#include "hw/i386/x86.h"
 
 #include "kvm_i386.h"
 #include "accel/accel-cpu-target.h"
@@ -91,6 +92,15 @@ static bool kvm_cpu_realizefn(CPUState *cs, Error **errp)
         kvm_set_guest_phys_bits(cs);
     }
 
+    /*
+     * When SMM is enabled, there is 2 address spaces. Otherwise only 1.
+     *
+     * Only initialize address space 0 here, the second one for SMM is
+     * initialized at register_smram_listener() after machine init done.
+     */
+    cs->num_ases = x86_machine_is_smm_enabled(X86_MACHINE(current_machine)) ? 2 : 1;
+    cpu_address_space_init(cs, 0, "cpu-memory", cs->memory);
+
     return true;
 }
 
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 34e74f24470..d191d7177f1 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -2704,6 +2704,7 @@ static MemoryRegion smram_as_mem;
 
 static void register_smram_listener(Notifier *n, void *unused)
 {
+    CPUState *cpu;
     MemoryRegion *smram =
         (MemoryRegion *) object_resolve_path("/machine/smram", NULL);
 
@@ -2728,6 +2729,10 @@ static void register_smram_listener(Notifier *n, void *unused)
     address_space_init(&smram_address_space, &smram_as_root, "KVM-SMRAM");
     kvm_memory_listener_register(kvm_state, &smram_listener,
                                  &smram_address_space, 1, "kvm-smram");
+
+    CPU_FOREACH(cpu) {
+        cpu_address_space_init(cpu, 1, "cpu-smm", &smram_as_root);
+    }
 }
 
 static void *kvm_msr_energy_thread(void *data)
-- 
2.51.0


