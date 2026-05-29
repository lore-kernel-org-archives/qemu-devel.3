Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07590CD4F54
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 19:52:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wT3En-0007qf-AY; Fri, 29 May 2026 15:51:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wT3Ec-0007dR-BW
 for qemu-devel@nongnu.org; Fri, 29 May 2026 15:51:10 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wT3EZ-0004sJ-KB
 for qemu-devel@nongnu.org; Fri, 29 May 2026 15:51:10 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4905e190c71so71002645e9.3
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 12:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780084261; x=1780689061; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6ACAuqBSNPM8qIatOkZfzbxNuahjvLF1jUZgEVx43Yg=;
 b=F4tSw1ladLWqW8eiIAtw7vWS00D3xiD1+0gnFUiDPD5RgiK++PHFPckIS9nn/RChDD
 fe3ZU+3/AW45ZuBBXhSnsubPKFfeUy8R+jVXwlUcJQWR8QWRfFo4GrXy0z4GOmCLrkpx
 wwQ7RS7V/olU3i3OhyyXuppwWKpQfnx5U3YapbgrBtv6ghS7tpDjof65khpop5BMLVOo
 fFHkShPbf38PUVkYkCyXAcEKifplSrvJqOvEzS0PGOfOlX0Y0XOHhkiOrdnvwQyg7YbC
 4oA9o0PstdlJ2j5r7eev7K3lKSKYoDNLZlcuh8BPzUSd+GtBnUKcGBxXc8lIetg/ii8s
 tD7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780084261; x=1780689061;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6ACAuqBSNPM8qIatOkZfzbxNuahjvLF1jUZgEVx43Yg=;
 b=GaoRrmJkZxsP2UH4DIJjteP9JgiwezG+L5TBfzaekTm9D1lmYQOl4aLgGYohaauY+b
 KYBcZz5DkrHkw+QhITBHNFPAu3KWyBAwhHKtQI8G4Xw9Z4FHnUZoo7vlJWSa/a4LVn5j
 0JDu/1scfKx1VQln9+IhzkdPVApQgvpdzUC4dL23EjJMpP7HFm5TfKczvi71u/h1sPZV
 nDa8I+xrsO331ac40w3/iOZo1jLUvRB0RQLatrc+822VCBISdmVelxTYzTKjkCjKf4Mm
 LWfHaaJbKXlVwN6YvtoAZK6ylYc+nuKVRG+gGEMQVqNfOyYeoqwKLf1QAq45La7Nkbh/
 u2Zw==
X-Gm-Message-State: AOJu0YwceB9BlIbUaMXmW7jZEqTqhg52lfBhHs+aaU24KdHlCHOhgOPY
 e6XwBXD2nm7nGcK3WlnGuwfZiwlJNUnULgVmxx5vXNPiHamHIXtXDGx1wr3sHR/+/HC0U7VjyZv
 WNuFGCmc5jg==
X-Gm-Gg: Acq92OEzKz0wQQ3iUAZiWEpGSIZWvy1O/ZbVdYxHsoD9KajEptWa0KkepwnTt4iTMEG
 XTNRLJFiGwIkpP6mN61NThyAIx6ycL6cHmMKa3SrwjC4DrQNQ3jLOgnEhaLL+z/BEb8g4mTtaSv
 9dWniLPRA/LNqecGti841BsS9g00knMYYu1Q7f9w73Fa52mcuisvnBiPOx0tvpwsYQpr1bIAuQH
 rv+6UHSSy8yKi8RPHoROGxxE5/3D8CTSsuWgSCsgzqycgXv4OZhyhHbVuDUQ4m/HWeXTVQfZxK/
 KzCUsX7Wi4t70dniP7tinZteqWHRhI3Vasay4lMmWDPznv/U6sh9fZKCfz70EMG0izFVTFtkx7N
 UTQQasIwsw+PKBDuXUN9prQEvN7BpMIVC1O9sr1bIqPUPz7PjpkkSmjevuEHqvbl4xu0+eifKYU
 cvLM2EwpiOb6jz7Ua4Eh24k+6KF99rfYXf6uPcHxgaYPur/q8Rjbd1miah2cahOnllkg==
X-Received: by 2002:a05:600c:8b12:b0:490:2238:4021 with SMTP id
 5b1f17b1804b1-490a29079a0mr18527745e9.8.1780084261187; 
 Fri, 29 May 2026 12:51:01 -0700 (PDT)
Received: from m15.home (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45ef35874b7sm5949931f8f.35.2026.05.29.12.50.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 29 May 2026 12:51:00 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Weiwei Li <liwei1518@gmail.com>, Glenn Miles <milesg@linux.ibm.com>,
 kvm@vger.kernel.org, qemu-s390x@nongnu.org,
 Chao Liu <chao.liu.zevorn@gmail.com>, David Hildenbrand <david@kernel.org>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Song Gao <gaosong@loongson.cn>, Paolo Bonzini <pbonzini@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Anton Johansson <anjo@rev.ng>, Claudio Fontana <cfontana@suse.de>,
 Eric Farman <farman@linux.ibm.com>, Alexander Graf <agraf@csgraf.de>,
 Chinmay Rath <rathc@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 qemu-riscv@nongnu.org, Roman Bolshakov <rbolshakov@ddn.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Cornelia Huck <cohuck@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Reinoud Zandijk <reinoud@netbsd.org>, Halil Pasic <pasic@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 09/17] accel/hvf: Convert AccelCPUClass ->
 AccelOpsClass::cpu_instance_init
Date: Fri, 29 May 2026 21:49:31 +0200
Message-ID: <20260529194940.97143-10-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260529194940.97143-1-philmd@linaro.org>
References: <20260529194940.97143-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

HVF cpu_instance_init() was only implemented for X86.
Add a stub for ARM, allowing to register as generic
AccelOpsClass::cpu_instance_init hook.

X86's ACCEL_CPU_NAME("hvf") TypeInfo is now empty, remove it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 include/system/hvf_int.h  |  1 +
 accel/hvf/hvf-accel-ops.c |  1 +
 target/arm/hvf/hvf.c      |  4 ++++
 target/i386/hvf/hvf-cpu.c | 25 +------------------------
 4 files changed, 7 insertions(+), 24 deletions(-)

diff --git a/include/system/hvf_int.h b/include/system/hvf_int.h
index d5eaf26dda8..cb8abbc7cc9 100644
--- a/include/system/hvf_int.h
+++ b/include/system/hvf_int.h
@@ -109,6 +109,7 @@ int hvf_update_guest_debug(CPUState *cpu);
  */
 bool hvf_arch_supports_guest_debug(void);
 
+void hvf_arch_cpu_instance_init(CPUState *cpu);
 bool hvf_arch_cpu_realize(CPUState *cpu, Error **errp);
 uint32_t hvf_arch_get_default_ipa_bit_size(void);
 uint32_t hvf_arch_get_max_ipa_bit_size(void);
diff --git a/accel/hvf/hvf-accel-ops.c b/accel/hvf/hvf-accel-ops.c
index 6edc2242ed9..a9c9d5d9a81 100644
--- a/accel/hvf/hvf-accel-ops.c
+++ b/accel/hvf/hvf-accel-ops.c
@@ -356,6 +356,7 @@ static void hvf_accel_ops_class_init(ObjectClass *oc, const void *data)
 {
     AccelOpsClass *ops = ACCEL_OPS_CLASS(oc);
 
+    ops->cpu_instance_init = hvf_arch_cpu_instance_init;
     ops->cpu_realize = hvf_arch_cpu_realize;
 
     ops->create_vcpu_thread = hvf_start_vcpu_thread;
diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index d88cbe7c82a..b825a1ae6d4 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1504,6 +1504,10 @@ int hvf_arch_init_vcpu(CPUState *cpu)
     return 0;
 }
 
+void hvf_arch_cpu_instance_init(CPUState *cpu)
+{
+}
+
 bool hvf_arch_cpu_realize(CPUState *cs, Error **errp)
 {
     ARMCPU *cpu = ARM_CPU(cs);
diff --git a/target/i386/hvf/hvf-cpu.c b/target/i386/hvf/hvf-cpu.c
index 35f6bddbc0e..536bcecd7d2 100644
--- a/target/i386/hvf/hvf-cpu.c
+++ b/target/i386/hvf/hvf-cpu.c
@@ -14,7 +14,6 @@
 #include "system/system.h"
 #include "hw/core/boards.h"
 #include "system/hvf.h"
-#include "accel/accel-cpu-target.h"
 #include "hvf-i386.h"
 
 static void hvf_cpu_max_instance_init(X86CPU *cpu)
@@ -56,7 +55,7 @@ static void hvf_cpu_xsave_init(void)
     }
 }
 
-static void hvf_cpu_instance_init(CPUState *cs)
+void hvf_arch_cpu_instance_init(CPUState *cs)
 {
     X86CPU *cpu = X86_CPU(cs);
     X86CPUClass *xcc = X86_CPU_GET_CLASS(cpu);
@@ -77,25 +76,3 @@ bool hvf_arch_cpu_realize(CPUState *cs, Error **errp)
 {
     return host_cpu_realizefn(cs, errp);
 }
-
-static void hvf_cpu_accel_class_init(ObjectClass *oc, const void *data)
-{
-    AccelCPUClass *acc = ACCEL_CPU_CLASS(oc);
-
-    acc->cpu_instance_init = hvf_cpu_instance_init;
-}
-
-static const TypeInfo hvf_cpu_accel_type_info = {
-    .name = ACCEL_CPU_NAME("hvf"),
-
-    .parent = TYPE_ACCEL_CPU,
-    .class_init = hvf_cpu_accel_class_init,
-    .abstract = true,
-};
-
-static void hvf_cpu_accel_register_types(void)
-{
-    type_register_static(&hvf_cpu_accel_type_info);
-}
-
-type_init(hvf_cpu_accel_register_types);
-- 
2.53.0


