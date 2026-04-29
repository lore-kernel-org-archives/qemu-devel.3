Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAEBDFF8864
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 05:00:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHwtu-0000h2-Jw; Wed, 29 Apr 2026 00:51:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wHwtf-0008O8-JO
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 00:51:39 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wHwtZ-00010G-LT
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 00:51:39 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2aae146b604so81329175ad.3
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2026 21:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777438292; x=1778043092; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KFx2dAGT4WMIbJyRWvsN+yaaSACktQl5+DAxcc8Afmg=;
 b=CTnpq7OMAHG2ehAFpzELGM2MPP7l4gV4m3HSSOmXMLhHx+borqZX1ICFhWMuxWg6Sp
 ri6Uuonp+tetIhM6jsQGakS2AbyDO+/i1EsmMrUQ/gQCTYbfBDsF1PB9+7tWkd7WGpuL
 q/Ylkvzy47+2xf6LepAUcRE4A/oG6j5VpFGz3+OaVZiv5aKf3vAFwBTxPXT4zW0m4qeE
 gu44bsc5oMyEEzL5cD8YD/6dcTUaRqIug2rotQp/+vhbrdFG41C8fUhNEIATDgLYPZYt
 hnf7ilQmirooWucP/TUf6/+x1rvipCnzKsfGLOnFC02FaKbt8GmsIY3EBJJa2eII74KA
 4gMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777438292; x=1778043092;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KFx2dAGT4WMIbJyRWvsN+yaaSACktQl5+DAxcc8Afmg=;
 b=eTVFdKke3xEyzqvUeFvCRmIOUL8eHMHG2C5hzFI44hKmqv1zPa2UccKj0URXRU7aOZ
 xuTt6HeQZcYad/cOoxQpJyDUATx06m5fEt4fvqcx+4uZXiqy+wEbwKfvmhSgRrPZh8ez
 QZZ1EYullHXdvDWRz4YmXZwshV0zzsWuTa9t5oluYP7z4iqE8J3vhul6szD3wAGnjWjd
 0U46NjnkXxw7hDeOaJdC1QOiCl8yzuWzFUS77rBy7fydp8mtK0jVG92VRsAQWh31isDU
 NgwUJWojQchXJ6TG9h8UD05L5JQva/RT9Qklct2L0JrQMFnw+k8TEgSDUJ3Kjwp03+xz
 J7Fg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+s69zxZ3JR4ZYckfVSzk8s+VXt6fQiRLV2/c9L3lBisOYOI2GpVDbUBpYe3erApNWaO44hUKiE86c6@nongnu.org
X-Gm-Message-State: AOJu0YwSZOWOTQCE/ZkA0uYB0dmEURlgblbUqL3Q/ZpyGp85b0tDLbWX
 Z4ORFIzVVt4VOMhTs/QOPsT1tIQCkSLoxr/IO0qjtqPDLuVo6f3la/Sz
X-Gm-Gg: AeBDiev0TAwmwWj6v47T7SBtc9oLHbXAzYt3AYF1AoKVfMgQfPzY1Um5dZ8B2GvNFpx
 wmPCQN13WZRC0VhzojNBO/Sm5OHj7wtCj9BWoi4PYbONWccyOAZ9RaaRACVqDC+ERuWsAnyEH8a
 q7buxjqaWYfdAkfemuh7Yrjd+MlhYi8lHKi54h+64RZDXZ0Qxd1PMZeOUt0IEqeIZX+qBs2/NYs
 O/FMZb+cCdD25Gpv5OfcJuM2d0t3Gc5hTJM1H4QjK5PdFDmfyHTEx/0zlf1uMhPN016i5+6C/Bh
 MmGQgEDbCqYFk1WWR0ABbDVfwRYyj/wFEZqQKhQuS2sbvn2IGJWtZfYmvGXvUrWWn8ZEL60fre7
 mfbhjOEYsicdU0vGPQSIybnHQxD5sBCtDUevJzAyhOpV05zWkrPcEBJIRaCFSyXZmnOQLmqlxlW
 SxITbcHkF3L/3qj8CNtTqAyzv7hfMCu/7bk7wd2IX8+Rj1K5adU1p3
X-Received: by 2002:a17:902:ebca:b0:2b4:5931:bc4c with SMTP id
 d9443c01a7336-2b97c437ccdmr58540555ad.15.1777438292289; 
 Tue, 28 Apr 2026 21:51:32 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b988772ae8sm7756145ad.7.2026.04.28.21.51.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 21:51:31 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: palmer@dabbelt.com, liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Frank Chang <frank.chang@sifive.com>,
 Max Chou <max.chou@sifive.com>, Nutty Liu <nutty.liu@hotmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 40/51] target/riscv: Initialize riscv_excp_names[] and
 riscv_intr_names[] using designated initializer
Date: Wed, 29 Apr 2026 14:47:41 +1000
Message-ID: <20260429044752.4176397-41-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260429044752.4176397-1-alistair.francis@wdc.com>
References: <20260429044752.4176397-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x629.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Frank Chang <frank.chang@sifive.com>

Use designated initializers to initialize riscv_excp_names[] and
riscv_intr_names[] so that we don't have to explicitly add "reserved"
items. Also, add the missing trap names: sw_check, hw_error,
virt_illegal_instruction, semihost, s_guest_external, and
counter_overflow.

Signed-off-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Max Chou <max.chou@sifive.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260421071107.2848439-1-frank.chang@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 89 +++++++++++++++++++++++-----------------------
 1 file changed, 45 insertions(+), 44 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 72c6f4f0f1..ce15a17c37 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -328,60 +328,61 @@ const char * const riscv_rvv_regnames[] = {
 };
 
 static const char * const riscv_excp_names[] = {
-    "misaligned_fetch",
-    "fault_fetch",
-    "illegal_instruction",
-    "breakpoint",
-    "misaligned_load",
-    "fault_load",
-    "misaligned_store",
-    "fault_store",
-    "user_ecall",
-    "supervisor_ecall",
-    "hypervisor_ecall",
-    "machine_ecall",
-    "exec_page_fault",
-    "load_page_fault",
-    "reserved",
-    "store_page_fault",
-    "double_trap",
-    "reserved",
-    "reserved",
-    "reserved",
-    "guest_exec_page_fault",
-    "guest_load_page_fault",
-    "reserved",
-    "guest_store_page_fault",
+    [RISCV_EXCP_INST_ADDR_MIS] = "misaligned_fetch",
+    [RISCV_EXCP_INST_ACCESS_FAULT] = "fault_fetch",
+    [RISCV_EXCP_ILLEGAL_INST] = "illegal_instruction",
+    [RISCV_EXCP_BREAKPOINT] = "breakpoint",
+    [RISCV_EXCP_LOAD_ADDR_MIS] = "misaligned_load",
+    [RISCV_EXCP_LOAD_ACCESS_FAULT] = "fault_load",
+    [RISCV_EXCP_STORE_AMO_ADDR_MIS] = "misaligned_store",
+    [RISCV_EXCP_STORE_AMO_ACCESS_FAULT] = "fault_store",
+    [RISCV_EXCP_U_ECALL] = "user_ecall",
+    [RISCV_EXCP_S_ECALL] = "supervisor_ecall",
+    [RISCV_EXCP_VS_ECALL] = "hypervisor_ecall",
+    [RISCV_EXCP_M_ECALL] = "machine_ecall",
+    [RISCV_EXCP_INST_PAGE_FAULT] = "exec_page_fault",
+    [RISCV_EXCP_LOAD_PAGE_FAULT] = "load_page_fault",
+    [RISCV_EXCP_STORE_PAGE_FAULT] = "store_page_fault",
+    [RISCV_EXCP_DOUBLE_TRAP] = "double_trap",
+    [RISCV_EXCP_SW_CHECK] = "sw_check",
+    [RISCV_EXCP_HW_ERR] = "hw_error",
+    [RISCV_EXCP_INST_GUEST_PAGE_FAULT] = "guest_exec_page_fault",
+    [RISCV_EXCP_LOAD_GUEST_ACCESS_FAULT] = "guest_load_page_fault",
+    [RISCV_EXCP_VIRT_INSTRUCTION_FAULT] = "virt_illegal_instruction",
+    [RISCV_EXCP_STORE_GUEST_AMO_ACCESS_FAULT] = "guest_store_page_fault",
+    [RISCV_EXCP_SEMIHOST] = "semihost",
 };
 
 static const char * const riscv_intr_names[] = {
-    "u_software",
-    "s_software",
-    "vs_software",
-    "m_software",
-    "u_timer",
-    "s_timer",
-    "vs_timer",
-    "m_timer",
-    "u_external",
-    "s_external",
-    "vs_external",
-    "m_external",
-    "reserved",
-    "reserved",
-    "reserved",
-    "reserved"
+    [IRQ_U_SOFT] = "u_software",
+    [IRQ_S_SOFT] = "s_software",
+    [IRQ_VS_SOFT] = "vs_software",
+    [IRQ_M_SOFT] = "m_software",
+    [IRQ_U_TIMER] = "u_timer",
+    [IRQ_S_TIMER] = "s_timer",
+    [IRQ_VS_TIMER] = "vs_timer",
+    [IRQ_M_TIMER] = "m_timer",
+    [IRQ_U_EXT] = "u_external",
+    [IRQ_S_EXT] = "s_external",
+    [IRQ_VS_EXT] = "vs_external",
+    [IRQ_M_EXT] = "m_external",
+    [IRQ_S_GEXT] = "s_guest_external",
+    [IRQ_PMU_OVF] = "counter_overflow",
 };
 
 const char *riscv_cpu_get_trap_name(target_ulong cause, bool async)
 {
     if (async) {
-        return (cause < ARRAY_SIZE(riscv_intr_names)) ?
-               riscv_intr_names[cause] : "(unknown)";
+        if ((cause < ARRAY_SIZE(riscv_intr_names)) && riscv_intr_names[cause]) {
+            return riscv_intr_names[cause];
+        }
     } else {
-        return (cause < ARRAY_SIZE(riscv_excp_names)) ?
-               riscv_excp_names[cause] : "(unknown)";
+        if ((cause < ARRAY_SIZE(riscv_excp_names)) && riscv_excp_names[cause]) {
+            return riscv_excp_names[cause];
+        }
     }
+
+    return "(unknown)";
 }
 
 void riscv_cpu_set_misa_ext(CPURISCVState *env, uint32_t ext)
-- 
2.53.0


