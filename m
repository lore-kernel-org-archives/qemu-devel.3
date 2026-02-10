Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61C59EB270F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 20:14:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpu7X-0005ox-2d; Tue, 10 Feb 2026 15:14:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vpu7V-0005nX-5i
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 15:14:01 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vpu7T-0007nU-0b
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 15:14:00 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2aae4816912so18824215ad.2
 for <qemu-devel@nongnu.org>; Tue, 10 Feb 2026 12:13:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770754437; x=1771359237; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f6lfjFGTpP9sqItRbR9rxD4pmFfc0wMz2+PxtkzkfnQ=;
 b=byyrD16t911RaHKcTnnf4F34A/v6HvcCCX7bwBq4thWDJ/xm8PW9IiIM5KcDjQ+zX7
 Cdy/zUQvurvDJgpl+NNuVCFkFHAe68TxzHyLaJhtKOqND/+lEReTa+V4y7vsQKdgPLAe
 d6/79+dYo0K+BzmFCkKqxjlhSxOqZQ4Rj9DEZdw06f946trJUKFiCgWcHnfLcwvk5Sq3
 hKFOLr3o93WNr9I+13PBNWl15lW8e4sey3Z5eAj70+fp+9vrQ8TuqRAo42zY/eXMb/Mh
 JZhUsoLS2BPsJ3oDgST81MpRTMSK0/lHp1xTQvRHjeUrZugN3or3MLCEQlM6QdbFUzd5
 C7tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770754437; x=1771359237;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=f6lfjFGTpP9sqItRbR9rxD4pmFfc0wMz2+PxtkzkfnQ=;
 b=G6RlZU5XQcU/9/Aspq3WXh2QLTh30h1EF+43L9LR/Zh04t6blygiyb0Lluev2cqznX
 SYtaIMwkdYQi7UPZRwC9HM/4OkCTX43urXCnAUNYsFfZDvRW745sswwAUsrXRN7dEHOF
 jeYGntwIpDGZe48PDWEe5ag5usKOoUJwkc/ZuTU6XHMBYFjdzkGVnR63tNNmwUHHz3dJ
 7yuL6NQXHHi7aK2ngSKvm82yQuwvFaO5u6sZtWV5yoRfE6gUWN3E2icCgvuD0ewJpad7
 qmtpOt9Wb5iomCnt0U1HH8eq9xiAG1PqFCAV2S1Rb3hiFub2rzeb6ZUeiJpRVMayoDv9
 qC4w==
X-Gm-Message-State: AOJu0Yyvgs3Px4debkCnMe3JJU3ZPUhVfvEiEfhvo2jTOLNgNndEz7Mk
 rmAol37vCLbR88rr1tKoGqyeT+Sw0BNNdhg7izPsgwDEWwgIAFnwnhMiNKwNZvfrHgfmzjT+a9a
 iIw6j
X-Gm-Gg: AZuq6aKpUr1iVNm3P8xk8Wb7j/qrnz8j10sU3KuQwPXMD2kt9aaUeYVEiqNmlTctZe4
 6p3DYgtht5AtLfKPDtRJYasD/fhwzdOym2aQqPaXL6VrafVvUWdZ5SXhuQ5pUxWV0GWQ3lgqNul
 y/n9TuViCjoGnWe+VdR3s4hsBZPTyNiGtIjxUAzNQDIYe+ic5R4q02dyXcj9nCZ1ZT5EKwWVi9e
 ophswsZuyWEixpo8yohQfq5Vls27yRFfmveCoLN2M3uTy/xXTEHNacWEg12c2waZPJaP4BYe0nn
 65mSb5qes4gT0Vcc4ESRX9GS2CkUKGmoeGRtqjGIZ6eZBm9Jcxmkmn57Z8yVfAwg+cupveVezhH
 CVJ61N1VfmcAWVF8ygKySqxe6MBgUu6r5+1mOR1+vkyk7Dif4/ZUQxmFX3oMyxk8q7MaIL9Sn9j
 AZEWt9ziNqnvrNZvR9Il5QIXFLVuW43pstfiozCjJtJQdk7b8X7w6DxVTbg+NhnKA3bL7S5+y29
 T3im7+6LKwPEEc=
X-Received: by 2002:a17:903:b46:b0:2aa:f43d:7c42 with SMTP id
 d9443c01a7336-2ab27d13dd8mr2959015ad.24.1770754437398; 
 Tue, 10 Feb 2026 12:13:57 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c6dcb5e3e8csm13930031a12.21.2026.02.10.12.13.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Feb 2026 12:13:57 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, alistair.francis@wdc.com,
 Mahmoud Mandour <ma.mandourr@gmail.com>, manos.pitsidianakis@linaro.org,
 philmd@linaro.org, anjo@rev.ng, brian.cain@oss.qualcomm.com
Subject: [PATCH 2/4] contrib/plugins/uftrace: add ops for walking frame
 pointers chain
Date: Tue, 10 Feb 2026 12:13:42 -0800
Message-ID: <20260210201344.1403613-3-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260210201344.1403613-1-pierrick.bouvier@linaro.org>
References: <20260210201344.1403613-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62c.google.com
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


