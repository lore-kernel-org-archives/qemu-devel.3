Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8CA8C282D1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 15:57:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqDVk-0004sF-7j; Thu, 06 Mar 2025 10:51:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqDUP-0003hL-8b
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 10:50:27 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqDUM-0006gz-Im
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 10:50:24 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3912c09bea5so644473f8f.1
 for <qemu-devel@nongnu.org>; Thu, 06 Mar 2025 07:50:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741276220; x=1741881020; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Ry6/HgwBxYCoKXfN3GlNL4j5WQBtuJxwtVuKKIpyAK8=;
 b=o3TpJpR+rk3kqyNABZsa41b4IYAbS4RVtAyhEVdTSfGa7CoMx7WcCObYlCsMmW6bKK
 Mt3kzabmEWKYe9brMV+AOSdQ+LaUEXYLOJ2fOvXjVNKQ8ouoOXTJHN6G3kXGn2oH0lwl
 f46/UCn3ZQrDRk/Jzah+b3PGuABA4nUSxqNJyX0C8ummdyM8NMXq3lrUlNW4SByENHYi
 9IxU7BBvj+Z0bOi8pJmys3T40xwogwGCVUq+Wt1Y2HtifO8rvKMqb1ORZquW2I8Q14Jw
 nSkpXjm8otrPuErCFXZmpbkK7ADHZp4uwqwp93Mq6Xw7d3iS0iVNtVtVSbPXigV62ZNJ
 MheQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741276220; x=1741881020;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ry6/HgwBxYCoKXfN3GlNL4j5WQBtuJxwtVuKKIpyAK8=;
 b=dPglJy6bLg3LBhLzCplPTwkzf6eScOgzGMIl2W0o8T5KeGcPs/r4mGgH6tN01XX5l+
 GstUwqOcR0spHoTH6FFkiKmt/Adz2gNFn3IVisS9TI9HrQ7My2IblQHCGr1u+z/LHKv8
 8sruqPn8ap8lKhR40DTPgjcpsOGhOplJ3Q30p1vkLHyOaiF53qaWBXEa8o20xBGE8gwv
 XgZRRnd7O5wTWF4Bf8pm/b7SL/8vTjRtRgDyMVCo35FZQQlcyBi8kf3aEeNpzCl/4s5F
 t7xRAJTOKqxfo5HebtMwWmUA7bKnW9h6zZiv2lMGRjU/n/+v7blgf6ZuO+DBUM8Bz3Rn
 PqMA==
X-Gm-Message-State: AOJu0Yx47LduexftVA0SdkDlX9JrejRXk6NkyvPpHWHn7UCI73abGzdM
 YmvaH7d2MQxjURcXBCMKi1XrOiGlmlOTIn0gKYbJNzzfyU5fwKgjzIB9Jn5bWRd+AybwgHXki5T
 m5UU=
X-Gm-Gg: ASbGncsjz+kNcmRTa5PLikiKJoq9CJqId76YdC7tUF2Y7FKlWw77T69F1vRVkJ5GZSc
 jlpic0/V6iMaaj6OYpEuLgi1D2eYCrct8BLD1S4yXfZwaHL/C4w8FNtbe1K6UYy6kIl3YNGa25D
 LRYOVFnwvnlX3kb3TMl9aZgigJDNgc+bcTaLqQvqapuwl5renvKcmCb2uEExDQ37zW74CRwQ3rR
 go0EfacQK1fZTCdJEhGIWiYUq1wWUq6Fz0hfyIn0AdVSwHkiMQUs6fdjy3eVAD40dpP9uyzedLb
 hxnCw++0alYUZ4w/cYze0mFRXP/6qMKgaFaHMGo+PLS7BrIKzi6t59koipaINbQNCTIlqyTBu6g
 R5CZW587DhqqfRin4GjE=
X-Google-Smtp-Source: AGHT+IGuVmeIe36OU9zq6iMxhSWQc5X9fYBdoOfWLmlXBjkCjsttFPU3MRi0GDBse0aec0STqcmHmQ==
X-Received: by 2002:a05:6000:18ad:b0:391:1388:64b7 with SMTP id
 ffacd0b85a97d-3911f7c39c7mr6755696f8f.46.1741276220321; 
 Thu, 06 Mar 2025 07:50:20 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912bfdfad7sm2393099f8f.26.2025.03.06.07.50.19
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 06 Mar 2025 07:50:19 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 36/54] target: Set disassemble_info::endian value for
 little-endian targets
Date: Thu,  6 Mar 2025 16:47:18 +0100
Message-ID: <20250306154737.70886-37-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250306154737.70886-1-philmd@linaro.org>
References: <20250306154737.70886-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

Have the CPUClass::disas_set_info() callback set the
disassemble_info::endian field for little-endian targets.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20250210212931.62401-2-philmd@linaro.org>
---
 target/alpha/cpu.c     | 1 +
 target/avr/cpu.c       | 1 +
 target/hexagon/cpu.c   | 1 +
 target/i386/cpu.c      | 1 +
 target/loongarch/cpu.c | 1 +
 target/rx/cpu.c        | 1 +
 6 files changed, 6 insertions(+)

diff --git a/target/alpha/cpu.c b/target/alpha/cpu.c
index 57e41fcd784..2eabd7724df 100644
--- a/target/alpha/cpu.c
+++ b/target/alpha/cpu.c
@@ -85,6 +85,7 @@ static int alpha_cpu_mmu_index(CPUState *cs, bool ifetch)
 
 static void alpha_cpu_disas_set_info(CPUState *cpu, disassemble_info *info)
 {
+    info->endian = BFD_ENDIAN_LITTLE;
     info->mach = bfd_mach_alpha_ev6;
     info->print_insn = print_insn_alpha;
 }
diff --git a/target/avr/cpu.c b/target/avr/cpu.c
index 5a0e21465e5..2871d30540a 100644
--- a/target/avr/cpu.c
+++ b/target/avr/cpu.c
@@ -102,6 +102,7 @@ static void avr_cpu_reset_hold(Object *obj, ResetType type)
 
 static void avr_cpu_disas_set_info(CPUState *cpu, disassemble_info *info)
 {
+    info->endian = BFD_ENDIAN_LITTLE;
     info->mach = bfd_arch_avr;
     info->print_insn = avr_print_insn;
 }
diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
index 238e63bcea4..a9beb9a1757 100644
--- a/target/hexagon/cpu.c
+++ b/target/hexagon/cpu.c
@@ -293,6 +293,7 @@ static void hexagon_cpu_reset_hold(Object *obj, ResetType type)
 static void hexagon_cpu_disas_set_info(CPUState *s, disassemble_info *info)
 {
     info->print_insn = print_insn_hexagon;
+    info->endian = BFD_ENDIAN_LITTLE;
 }
 
 static void hexagon_cpu_realize(DeviceState *dev, Error **errp)
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 0cd9b70938d..ab328485acc 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -8691,6 +8691,7 @@ static void x86_disas_set_info(CPUState *cs, disassemble_info *info)
     X86CPU *cpu = X86_CPU(cs);
     CPUX86State *env = &cpu->env;
 
+    info->endian = BFD_ENDIAN_LITTLE;
     info->mach = (env->hflags & HF_CS64_MASK ? bfd_mach_x86_64
                   : env->hflags & HF_CS32_MASK ? bfd_mach_i386_i386
                   : bfd_mach_i386_i8086);
diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index b4b82425b18..d2e739a029f 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -624,6 +624,7 @@ static void loongarch_cpu_reset_hold(Object *obj, ResetType type)
 
 static void loongarch_cpu_disas_set_info(CPUState *s, disassemble_info *info)
 {
+    info->endian = BFD_ENDIAN_LITTLE;
     info->print_insn = print_insn_loongarch;
 }
 
diff --git a/target/rx/cpu.c b/target/rx/cpu.c
index 17ede51cd11..1c40c8977e7 100644
--- a/target/rx/cpu.c
+++ b/target/rx/cpu.c
@@ -168,6 +168,7 @@ static void rx_cpu_set_irq(void *opaque, int no, int request)
 
 static void rx_cpu_disas_set_info(CPUState *cpu, disassemble_info *info)
 {
+    info->endian = BFD_ENDIAN_LITTLE;
     info->mach = bfd_mach_rx;
     info->print_insn = print_insn_rx;
 }
-- 
2.47.1


