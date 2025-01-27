Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9416FC02188
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2025 11:56:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcNhV-0006P6-J5; Mon, 27 Jan 2025 06:54:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tcNhU-0006OO-4h
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 06:54:44 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tcNhR-0006rB-2u
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 06:54:43 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-43635796b48so27492365e9.0
 for <qemu-devel@nongnu.org>; Mon, 27 Jan 2025 03:54:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737978878; x=1738583678; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H4U+Bby0D2aGRLyzE2lLHHXc/1St8N4BxVIFjrIyGIc=;
 b=rp0YXDrjA195qfunesIyzkSDjlV+dPgW5A77jn+DhpWGEidDti9y8XxEKq/jjORms+
 HzKRTRxG0j4/WMatn+qg6eIjv9xlxIur9x481eiMYJQmWPQzn1SRgVBgTNYOsTWwzy4T
 Dn3etz7MxWRHHueHOeou3fKrlYTcO9nvE80GpgqDyX868O0lJMdihNv8MQxCLvJVoj4w
 r802cQo4namWeQmim6z7yYdza9zWoTu/4XTEtosC5OrUvGSOpwJc1CYWLqhgO5sbW4bA
 9pNW+BPwYolWgLDohegdKTmwOOmYqWlXH0LKUqMrjAMaMK07mtqSu2iTcoakqNP5q9dk
 Biqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737978878; x=1738583678;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=H4U+Bby0D2aGRLyzE2lLHHXc/1St8N4BxVIFjrIyGIc=;
 b=WxvXb4bENott593djYTVO0JxLxgsgXA9ru3zkSW06ZlPNiWWnpTo6KFGGVr1RXTJmi
 Fa2Hn3uebgOcEZp+m5vtRcoj7S2O9tnCAmnKKuznLVrCwj+21LhoGx4JKuowGISB5vt6
 7ZImh1nk0zK94GjHX0FrCsyGp5Inc6RtiZV5UCOlqrAEN/iaK4+K0F5j1AqJx2X9vQ+q
 1ThELB8IAn90NA9s+o9NmaCSVb5ns0AvSfoSBCOK9qARsrOtbju3c9xJFt0FZXBS8qSo
 dT0jKoKOw/oM5/FjeG04ZxPybSPm6/3BExDVHibamPXnN2cwKMV7g3QUgB+v92Jjjm8r
 UhfA==
X-Gm-Message-State: AOJu0YzWko6HOKZ0AxWbN946OG6yVykbW0PfMbqXiL7WLyJ+AZ2E4Xbh
 CfK9RUDSlyG9P+6iXyBYlD8QtuPOpcJa9sGjZyhV26MpDEDS3K/x+y4qaxKlM2jyNH8fec+VG0p
 zgmY=
X-Gm-Gg: ASbGncvdJzosDeRHINKc1ABN+ILI9SqC46FafrqivCLY+EIpnIfE+84gEjNICjC0c/m
 tqYwi8267ey4vhb4GdYvCxGYhrwM/txA9XLpMTkgQbW5+XmCJuVG421MstegLxE0Rjs/eTIOwN2
 iaEswZ1IVqgriI3f2LMXvhc52s54Qn/o8oigFALUFcb5kHa2pvUlvultXzDQOaA2Hdw8OmGBjEI
 t5PezMK1IZNmNiSklvc2L8HjO1eLEJ7z7FVp+VSxpX5auUr0e3S+w1g9kebYZrFi8aGg12UStk1
 RPsm0llSSihmeca5enzFhFbLSOj3EzmPQ2Vi246R9R++r5cn9aopvIw=
X-Google-Smtp-Source: AGHT+IHm6JEkKlkhLd4ePz5IrtOmCODTX3fhUZHXMtkKVKfY5bVdq0FHYNd9L1TAxpvIBjXt3ymQ3g==
X-Received: by 2002:a05:600c:6d46:b0:434:92f8:54a8 with SMTP id
 5b1f17b1804b1-438bcfd440dmr102138005e9.0.1737978878022; 
 Mon, 27 Jan 2025 03:54:38 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd54c098sm131475935e9.31.2025.01.27.03.54.37
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 27 Jan 2025 03:54:37 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-s390x@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-riscv@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 02/10] target: Set disassemble_info::endian value for
 big-endian targets
Date: Mon, 27 Jan 2025 12:54:18 +0100
Message-ID: <20250127115426.51355-3-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250127115426.51355-1-philmd@linaro.org>
References: <20250127115426.51355-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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
disassemble_info::endian field for big-endian targets.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/hppa/cpu.c     | 1 +
 target/m68k/cpu.c     | 1 +
 target/openrisc/cpu.c | 1 +
 target/s390x/cpu.c    | 1 +
 target/sparc/cpu.c    | 1 +
 5 files changed, 5 insertions(+)

diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
index f2441d4d7fb..1bc5cd746ec 100644
--- a/target/hppa/cpu.c
+++ b/target/hppa/cpu.c
@@ -144,6 +144,7 @@ static int hppa_cpu_mmu_index(CPUState *cs, bool ifetch)
 static void hppa_cpu_disas_set_info(CPUState *cs, disassemble_info *info)
 {
     info->mach = bfd_mach_hppa20;
+    info->endian = BFD_ENDIAN_BIG;
     info->print_insn = print_insn_hppa;
 }
 
diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
index 5eac4a38c62..ff167aaea71 100644
--- a/target/m68k/cpu.c
+++ b/target/m68k/cpu.c
@@ -122,6 +122,7 @@ static void m68k_cpu_reset_hold(Object *obj, ResetType type)
 static void m68k_cpu_disas_set_info(CPUState *s, disassemble_info *info)
 {
     info->print_insn = print_insn_m68k;
+    info->endian = BFD_ENDIAN_BIG;
     info->mach = 0;
 }
 
diff --git a/target/openrisc/cpu.c b/target/openrisc/cpu.c
index 0669ba2fd10..b81179bbbaa 100644
--- a/target/openrisc/cpu.c
+++ b/target/openrisc/cpu.c
@@ -83,6 +83,7 @@ static int openrisc_cpu_mmu_index(CPUState *cs, bool ifetch)
 
 static void openrisc_disas_set_info(CPUState *cpu, disassemble_info *info)
 {
+    info->endian = BFD_ENDIAN_BIG;
     info->print_insn = print_insn_or1k;
 }
 
diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index 3bea014f9ee..972d265478d 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -243,6 +243,7 @@ static void s390_cpu_disas_set_info(CPUState *cpu, disassemble_info *info)
 {
     info->mach = bfd_mach_s390_64;
     info->cap_arch = CS_ARCH_SYSZ;
+    info->endian = BFD_ENDIAN_BIG;
     info->cap_insn_unit = 2;
     info->cap_insn_split = 6;
 }
diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index e3b46137178..9fd222e4c82 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -106,6 +106,7 @@ static bool sparc_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
 static void cpu_sparc_disas_set_info(CPUState *cpu, disassemble_info *info)
 {
     info->print_insn = print_insn_sparc;
+    info->endian = BFD_ENDIAN_BIG;
 #ifdef TARGET_SPARC64
     info->mach = bfd_mach_sparc_v9b;
 #endif
-- 
2.47.1


