Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 114B0CAC58F
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Sep 2025 08:14:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uxLNS-0002qw-7U; Sat, 13 Sep 2025 04:12:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uxLMz-0001oF-Jc
 for qemu-devel@nongnu.org; Sat, 13 Sep 2025 04:12:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uxLMs-0005HZ-1c
 for qemu-devel@nongnu.org; Sat, 13 Sep 2025 04:12:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757751140;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v+L5IOFvaCrhn4Znhl/4a3Hvrnw7OeLoFEwsYYsO8qU=;
 b=VrcPgsw+UFZwtEKTJi8FXJ3A4HMIK+9egu41pC7DmtsH3uQep6oSmPS+U+0L2AXzNeoHJz
 KEUkRmqvTJK3OWwVe1S2xQUHcuUu3k0pvi/qaRdWzBIUiv8cVQUXe6ZgO0Sn4P6yBPw6cL
 rXG8V1TEkaefJhpF3FnGg4aaX+DVcsk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518-gbn8SXgqOwaZo1bIzUvHyw-1; Sat, 13 Sep 2025 04:12:19 -0400
X-MC-Unique: gbn8SXgqOwaZo1bIzUvHyw-1
X-Mimecast-MFC-AGG-ID: gbn8SXgqOwaZo1bIzUvHyw_1757751138
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-45df7e734e0so16324345e9.0
 for <qemu-devel@nongnu.org>; Sat, 13 Sep 2025 01:12:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757751137; x=1758355937;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=v+L5IOFvaCrhn4Znhl/4a3Hvrnw7OeLoFEwsYYsO8qU=;
 b=gU265ahIw9FnOt9sfWzkRXCi+H66uf0Aav0kWDRXscDuQNzr9hh0jVDwTsmbvmlW5i
 Bp7ignLnqwiDaAVIsQVJBDh+hHdvE1JS6uesreb1RArqci/NEoEUXumCqWfTjp0d2C3J
 yIWktGnRCE0VfMBOSpNxKazAZ/0bnfsT75/0uVNhiyAp3D/06Bjfx0yTBX4Tj01lYEkG
 GsK1BXh8wkCsv3kYig/rmE5+Ew4TWgG9QGUhuthEnAGWnL79BSvL6Yq1s0ElDid/nOQT
 1LQ/Z0NYH0q9p5LE6UacBBSpijmYNMGD7yDT3HLeLBvxY89h/G42mo8dNY5jyqjaSioW
 6low==
X-Gm-Message-State: AOJu0YxRGXT/wFK4fvdlAVd57zgJ9Z8sIfsVOP2+zKSRpc5W4Xa6joQL
 nRreE0VnknmrT5tUBCK/CedywaIKIddVEMh+J/lSBwJF9LRvgQM2RBaAX0Njz/BmoEsfWcLpgB6
 9zcL/04TEuGP/pgvF6t9zLk0gkkqXyTGvpbTr9Qwox24+gLmOkapHHH1BcFFiX+76PLhi0SvD6S
 7aSlGUT/hPGA3T1xHBFG6lTYIDdI8B827lHigtQEci
X-Gm-Gg: ASbGncu8JPkMc1iRpk8uO2tpFpHsCF07laSPe3G//+0wZvOPah+YKEp42oynM+iQU2h
 8u5/uv1Ek6mh7gB+jbGFBI9DFN9z963p+qElcI497L/eU0YADnZxktLwYt40Km40TyW8RlU6rOg
 BhNvmTP4EnPvnOYBTQuVBOPxtEbi//5mfL/huaZ4VvzWtkOWn/4ya97+kVl3fU4Lxf+/TZ26Pw5
 bUalvuiqnNhQfuTPhCC0eWE3h4tUWgoWCNb6Q9/4VyKnp/wEz/E46I79fpUzQzyHPJMNhdNZ2QY
 v2hx3SnrQkH4tt/M+wpQr9SNFJpva0MK5zk/0HTgkz2/xbuz0nGgzxpRjujyfGqr3dZkAaX3Hj4
 4fMJawHC0yPfObzo0dSjzjv+4ZV0eDLFEQFD1j3WSsK4=
X-Received: by 2002:a05:600c:3b26:b0:45b:7a93:f108 with SMTP id
 5b1f17b1804b1-45f211c4c47mr48345575e9.3.1757751137507; 
 Sat, 13 Sep 2025 01:12:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFRO3NpPrMB2IFTYqcOj2IxBf6t8aavGLmDHKZmLo3QhIfQtU68JRno3niWas0LsCcEtExeMg==
X-Received: by 2002:a05:600c:3b26:b0:45b:7a93:f108 with SMTP id
 5b1f17b1804b1-45f211c4c47mr48345265e9.3.1757751137009; 
 Sat, 13 Sep 2025 01:12:17 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.56.250])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45e0156d40esm95692575e9.1.2025.09.13.01.12.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 13 Sep 2025 01:12:15 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Xiaoyao Li <xiaoyao.li@intel.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>,
 Kirill Martynov <stdcalllevi@yandex-team.ru>
Subject: [PULL 55/61] target/i386: Define enum X86ASIdx for x86's address
 spaces
Date: Sat, 13 Sep 2025 10:09:36 +0200
Message-ID: <20250913080943.11710-56-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250913080943.11710-1-pbonzini@redhat.com>
References: <20250913080943.11710-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
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

Define X86ASIdx as enum, like ARM's ARMASIdx, so that it's clear index 0
is for memory and index 1 is for SMM.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Tested-By: Kirill Martynov <stdcalllevi@yandex-team.ru>
Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Link: https://lore.kernel.org/r/20250730095253.1833411-3-xiaoyao.li@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.h                | 5 +++++
 target/i386/kvm/kvm-cpu.c        | 2 +-
 target/i386/kvm/kvm.c            | 4 ++--
 target/i386/tcg/system/tcg-cpu.c | 4 ++--
 4 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index f977fc49a77..e0be7a74068 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2574,6 +2574,11 @@ static inline bool x86_has_cpuid_0x1f(X86CPU *cpu)
 void x86_cpu_set_a20(X86CPU *cpu, int a20_state);
 void cpu_sync_avx_hflag(CPUX86State *env);
 
+typedef enum X86ASIdx {
+    X86ASIdx_MEM = 0,
+    X86ASIdx_SMM = 1,
+} X86ASIdx;
+
 #ifndef CONFIG_USER_ONLY
 static inline int x86_asidx_from_attrs(CPUState *cs, MemTxAttrs attrs)
 {
diff --git a/target/i386/kvm/kvm-cpu.c b/target/i386/kvm/kvm-cpu.c
index 1dc1ba9b486..9c25b558395 100644
--- a/target/i386/kvm/kvm-cpu.c
+++ b/target/i386/kvm/kvm-cpu.c
@@ -99,7 +99,7 @@ static bool kvm_cpu_realizefn(CPUState *cs, Error **errp)
      * initialized at register_smram_listener() after machine init done.
      */
     cs->num_ases = x86_machine_is_smm_enabled(X86_MACHINE(current_machine)) ? 2 : 1;
-    cpu_address_space_init(cs, 0, "cpu-memory", cs->memory);
+    cpu_address_space_init(cs, X86ASIdx_MEM, "cpu-memory", cs->memory);
 
     return true;
 }
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index d191d7177f1..28012d2b578 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -2728,10 +2728,10 @@ static void register_smram_listener(Notifier *n, void *unused)
 
     address_space_init(&smram_address_space, &smram_as_root, "KVM-SMRAM");
     kvm_memory_listener_register(kvm_state, &smram_listener,
-                                 &smram_address_space, 1, "kvm-smram");
+                                 &smram_address_space, X86ASIdx_SMM, "kvm-smram");
 
     CPU_FOREACH(cpu) {
-        cpu_address_space_init(cpu, 1, "cpu-smm", &smram_as_root);
+        cpu_address_space_init(cpu, X86ASIdx_SMM, "cpu-smm", &smram_as_root);
     }
 }
 
diff --git a/target/i386/tcg/system/tcg-cpu.c b/target/i386/tcg/system/tcg-cpu.c
index 0538a4fd51a..7255862c244 100644
--- a/target/i386/tcg/system/tcg-cpu.c
+++ b/target/i386/tcg/system/tcg-cpu.c
@@ -74,8 +74,8 @@ bool tcg_cpu_realizefn(CPUState *cs, Error **errp)
     memory_region_set_enabled(cpu->cpu_as_mem, true);
 
     cs->num_ases = 2;
-    cpu_address_space_init(cs, 0, "cpu-memory", cs->memory);
-    cpu_address_space_init(cs, 1, "cpu-smm", cpu->cpu_as_root);
+    cpu_address_space_init(cs, X86ASIdx_MEM, "cpu-memory", cs->memory);
+    cpu_address_space_init(cs, X86ASIdx_SMM, "cpu-smm", cpu->cpu_as_root);
 
     /* ... SMRAM with higher priority, linked from /machine/smram.  */
     cpu->machine_done.notify = tcg_cpu_machine_done;
-- 
2.51.0


