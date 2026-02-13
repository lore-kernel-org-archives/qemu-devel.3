Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DD9CEEA853
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 00:43:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqhGz-0003nA-Uk; Thu, 12 Feb 2026 19:43:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vqhGy-0003me-OF
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 19:43:04 -0500
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vqhGw-0000qR-TW
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 19:43:04 -0500
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-82318b640beso222246b3a.0
 for <qemu-devel@nongnu.org>; Thu, 12 Feb 2026 16:43:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770943381; x=1771548181; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MhP9UxZvtyw4qXts11XqOhuLW6bLHIrLsrfSheQGMKU=;
 b=yd0wJ6m0ompvTeVoSrf+WzlEeLF1ViV76VeY+dK2+9CSjDiwCz6iKb2mrHkPKop9Ju
 rLbMcdA86jLyStttx9hWEiwF2+QmnHgeh9oDhbEaR/j8CDufB23BPVgFyZLLT2jREAv/
 MOwQpnpsPj6ixJaG35xu3400INEix3MzKrGAxES3I2p3Gw0RbEv6Q2YDmXPKU4UpISIH
 z/H9mG1t7/5Fg+vP0bW2wBoGykzrZHYFrzVsi4ob7DUSU5FCCnuMIKb4mNeEQGAqGhsS
 EmUfunSlD4Lc+Y5v+E6cmIcK6F6+61CKSID3eFpdUOT1iaXfsZhudKm/h7N8568nT9yf
 K58A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770943381; x=1771548181;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MhP9UxZvtyw4qXts11XqOhuLW6bLHIrLsrfSheQGMKU=;
 b=s3D0fw75kIOqcEY6K/nBqalCeWM36Crt5GqJCNpb0xpoc7xMudQsO2KJ/nrEixNzDC
 qtRRNF7e9cTDRtX9JutOqSRKmuu04rV8Exx5FEkfmxWNwvqaCfTHpnzXVwUMjPOUBeKd
 zicVoGRCodIwqG9VMe3XcuO6E15EpWpgAFvGBr0rf6zdqsYYlUT2IbuAeILDFXfBBQmK
 JYEE5agqrIEq1ZTSoqAM5g5i+TUDKYYIA/xbed43njDEif5zeONo/+6h75etYM4bjjB4
 UlL4RiRD+0/ri6Wnd/JWyKqfUIaV/dSpfm2oMTyfhzFNYcGtRszDnCqAE5THkInI7jCq
 gkxw==
X-Gm-Message-State: AOJu0YzaJRwtC5gH+lXBfDBg5lwXYtQXLmrs6nTs1mJW/fBrUYFi9BQl
 pYo8OWqfNIRq64piWbAeW8qqcUQcqU3xzZvPz6nge2MEbrafLGRangDqHlY3BXOIyXB7/rY4zfL
 gj3LP
X-Gm-Gg: AZuq6aLOB0/84bQQQr/p7UeOEpjYmT5hg5SvTDvXzObNSOEtxXmwZMgdkscCfvjUeUz
 rAFOfVOPUUMvv28L3FVZKfOo/2m+LWH4/X4MfpD7y+d+UVsEIN5OlqlVjf/kNHjp0nJ2VEfnl8t
 p9wDZm+Y2PM9c8PevLdifZLPegBK+N0+kJjWi7Q4LF816I4WvdHGPZzhrxycx0DXDY7emA8YAkP
 vIbzMs4C0h5LMDIfpSk6MJqctHKcUFTAmdlwwJNzp/JeI7/3/ChEXkXb3N/XhZSxhxKeFsf1LsO
 ox6gXZgvf7oEUb37Tq+XaLsgVfNw9W5VRec1GqJ64gbfeYw7ZtLc9vJ4yYOyMxTV5VIdpR4QpJ6
 y8+3c51T2CzNMRZGH61y5UriOSAMSNWkxdH1NbTd2nCqLeJ0H6Jl2elx3q0z9PxASr7ytKVW18s
 9MCFaGrQ2ulArC0T9szmCarCLsXfU9VK0eSevjx/oVb2NH3Nm3hWLOfTOxbsMjC/A4smMhHaXRV
 54/
X-Received: by 2002:a05:6a00:4515:b0:821:8ebc:2899 with SMTP id
 d2e1a72fcca58-824c9446cf7mr284157b3a.7.1770943381452; 
 Thu, 12 Feb 2026 16:43:01 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-824c6a431f2sm504326b3a.22.2026.02.12.16.43.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Feb 2026 16:43:01 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@linaro.org
Subject: [PULL 2/4] contrib/plugins/uftrace: add ops for walking frame
 pointers chain
Date: Thu, 12 Feb 2026 16:42:52 -0800
Message-ID: <20260213004254.493059-3-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260213004254.493059-1-pierrick.bouvier@linaro.org>
References: <20260213004254.493059-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x434.google.com
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

x86_64 and aarch64 use same stack layout. However, other architectures
might use different offset for return address and next frame pointer.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Link: https://lore.kernel.org/qemu-devel/20260210201344.1403613-3-pierrick.bouvier@linaro.org
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 contrib/plugins/uftrace.c | 38 ++++++++++++++++++++++++++++++++------
 1 file changed, 32 insertions(+), 6 deletions(-)

diff --git a/contrib/plugins/uftrace.c b/contrib/plugins/uftrace.c
index 1ed982999ed..21ac1402047 100644
--- a/contrib/plugins/uftrace.c
+++ b/contrib/plugins/uftrace.c
@@ -46,6 +46,8 @@ typedef struct {
     void (*init)(Cpu *cpu);
     void (*end)(Cpu *cpu);
     uint64_t (*get_frame_pointer)(Cpu *cpu);
+    uint64_t (*get_next_frame_pointer)(Cpu *cpu, uint64_t fp);
+    uint64_t (*get_next_return_address)(Cpu *cpu, uint64_t fp);
     uint8_t (*get_privilege_level)(Cpu *cpu);
     uint8_t (*num_privilege_levels)(void);
     const char *(*get_privilege_level_name)(uint8_t pl);
@@ -421,7 +423,9 @@ static uint32_t cpu_read_register32(Cpu *cpu, struct qemu_plugin_register *reg)
 
 static uint64_t cpu_read_memory64(Cpu *cpu, uint64_t addr)
 {
-    g_assert(addr);
+    if (!addr) {
+        return 0;
+    }
     GByteArray *buf = cpu->buf;
     g_byte_array_set_size(buf, 0);
     bool read = qemu_plugin_read_memory_vaddr(addr, buf, 8);
@@ -449,10 +453,8 @@ static void cpu_unwind_stack(Cpu *cpu, uint64_t frame_pointer, uint64_t pc)
         CallstackEntry e = {.frame_pointer = frame_pointer, .pc = pc};
         unwind[depth] = e;
         depth++;
-        if (frame_pointer) {
-            frame_pointer = cpu_read_memory64(cpu, frame_pointer);
-        }
-        pc = cpu_read_memory64(cpu, frame_pointer + 8); /* read previous lr */
+        frame_pointer = cpu->ops.get_next_frame_pointer(cpu, frame_pointer);
+        pc = cpu->ops.get_next_return_address(cpu, frame_pointer);
     } while (frame_pointer && pc && depth < UNWIND_STACK_MAX_DEPTH);
     #undef UNWIND_STACK_MAX_DEPTH
 
@@ -545,6 +547,16 @@ static uint64_t aarch64_get_frame_pointer(Cpu *cpu_)
     return cpu_read_register64(cpu_, cpu->reg_fp);
 }
 
+static uint64_t aarch64_get_next_frame_pointer(Cpu *cpu_, uint64_t fp)
+{
+    return cpu_read_memory64(cpu_, fp);
+}
+
+static uint64_t aarch64_get_next_return_address(Cpu *cpu_, uint64_t fp)
+{
+    return cpu_read_memory64(cpu_, fp + 8);
+}
+
 static void aarch64_init(Cpu *cpu_)
 {
     Aarch64Cpu *cpu = g_new0(Aarch64Cpu, 1);
@@ -580,6 +592,8 @@ static CpuOps aarch64_ops = {
     .init = aarch64_init,
     .end = aarch64_end,
     .get_frame_pointer = aarch64_get_frame_pointer,
+    .get_next_frame_pointer = aarch64_get_next_frame_pointer,
+    .get_next_return_address = aarch64_get_next_return_address,
     .get_privilege_level = aarch64_get_privilege_level,
     .num_privilege_levels = aarch64_num_privilege_levels,
     .get_privilege_level_name = aarch64_get_privilege_level_name,
@@ -623,6 +637,16 @@ static uint64_t x64_get_frame_pointer(Cpu *cpu_)
     return cpu_read_register64(cpu_, cpu->reg_rbp);
 }
 
+static uint64_t x64_get_next_frame_pointer(Cpu *cpu_, uint64_t fp)
+{
+    return cpu_read_memory64(cpu_, fp);
+}
+
+static uint64_t x64_get_next_return_address(Cpu *cpu_, uint64_t fp)
+{
+    return cpu_read_memory64(cpu_, fp + 8);
+}
+
 static void x64_init(Cpu *cpu_)
 {
     X64Cpu *cpu = g_new0(X64Cpu, 1);
@@ -649,6 +673,8 @@ static CpuOps x64_ops = {
     .init = x64_init,
     .end = x64_end,
     .get_frame_pointer = x64_get_frame_pointer,
+    .get_next_frame_pointer = x64_get_next_frame_pointer,
+    .get_next_return_address = x64_get_next_return_address,
     .get_privilege_level = x64_get_privilege_level,
     .num_privilege_levels = x64_num_privilege_levels,
     .get_privilege_level_name = x64_get_privilege_level_name,
@@ -710,7 +736,7 @@ static void track_callstack(unsigned int cpu_index, void *udata)
         return;
     }
 
-    uint64_t caller_fp = fp ? cpu_read_memory64(cpu, fp) : 0;
+    uint64_t caller_fp = cpu->ops.get_next_frame_pointer(cpu, fp);
     if (caller_fp == top.frame_pointer) {
         /* call */
         callstack_push(cs, (CallstackEntry){.frame_pointer = fp, .pc = pc});
-- 
2.47.3


