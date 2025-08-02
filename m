Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 375D5C87FC9
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Aug 2025 23:08:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiLJ5-0001Wm-86; Sat, 02 Aug 2025 19:06:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLIl-00016D-7L
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:06:15 -0400
Received: from mail-ot1-x329.google.com ([2607:f8b0:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLIg-00017I-V8
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:06:06 -0400
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-741af48e9e7so58323a34.3
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 16:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754175962; x=1754780762; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QHUbngbNrOIebBs0pvinM66UBm6mSJ9+oXdPY+2wgcQ=;
 b=g0/q3InzKeH2PFeVcYUmfZgrFeHdPJxEsECPqZ9jKHqPCo55Rr2tNIkxwq4lrhi8VS
 D45slS87A0HhFz4vjmO5OGc6A9+PtXkDrTQ4jXeru4OFGM3DYxTlrL9mr1PVBuswpMDK
 7JeLn4PVMx1uTtrDtmEUNg4dVCWhq2b+um+PFttAYb4lRypfyPGHm9LZZIrlktnt6ITG
 AgBso5pFAwT/ToQ991TcEkVAXhMIzrh5RWK5aCtYdJpn88d6kVptKDAV/mcHmXtAyQsy
 RVLslthUIbetEZnVG2mYMIbx3YCmF7riBmEhvOwv9JOoWqKRJvEQGZBreQe5hEVGABmJ
 HSpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754175962; x=1754780762;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QHUbngbNrOIebBs0pvinM66UBm6mSJ9+oXdPY+2wgcQ=;
 b=XnUuOjMdnlDvXBuakNgy7W90cEa/ULWMbPcmIX6D+YX2pJgVUbFVAbF0oErMbkQPuG
 IMRAxYFSw/8HoyQ74O4BxfOyRGIY1UtcZkdWvzb7mkeq7iefUnvVTJL/TNIExs1wez99
 1uanrFYTf8niyuRjYPI7jYDghgDr4eA4i78Dt1f1BwtuX8ZWcqFbQjBZ/7i+kFTstukk
 /sLebJsieN7zHCwgL3lvYnsdG67trOOWSfRykTXw9Z/oiz5cxUU/G0+IDn7rKj1wRCEG
 y7DNk7CZB3ZKyWyBL3OhT3EbpXAG5ic6la+m1xwFZDmDTyigyo9QeY2MeByyUxrCJJRV
 ynAA==
X-Gm-Message-State: AOJu0YwGWOcnSQR7JO12AjqfJdxM82ja5DtTr+l7gqT76I1i23OthKqn
 B+4x1PKbmmGts6qosbxFbT8A32Lq1cPaW8/JT4RDJcQrZGEOdHuAzAyAs85MQlXEvba30AMOoj0
 llV+dQPU=
X-Gm-Gg: ASbGncuhPTv9h4cRLHqVd1PhK8zie14EOWx21FTaxvSd1nehbW/Y8boSgx5Rpan2Ms3
 c6KbnqVAavYbRhiucvztan2Rv+KqJ6BZMZKc95vUxO+RiDo0PjNKlgKDFt124nVaIxHdHq86duP
 g1GyOp6i5c6JjrHM2jmRwk+VT7S8NRfVMYQLOUvT+UGUp2oto931giX3w5s2K4av3ZOiJJu9r0z
 qHIDH9eli1kAz5CMHtj72/Qaa/vxDP8VYdg73S9VRqmSgWi9eeqilG+Vwld2TFeJJ7LfLh2G5ag
 DJDEezHxiOG0PLlOFt21F6aNTOVUwz4N207DPtkaTmBw0HLXspWHg17RTlh90t4g+NjzxF3bbbe
 8UX7QYCAbHz9B5SiffB7VaMj4PeIRqfD4bRK9r5kyZVkCvOE2kvt0
X-Google-Smtp-Source: AGHT+IHFqqGsLRjFojuxcd3Xp55SHWNG/txLuFthLCpCKDMjOP2hUcLoYWvYwSZ3e2qt7iCQP0se5A==
X-Received: by 2002:a05:6808:1796:b0:40c:f698:c132 with SMTP id
 5614622812f47-433f023518amr2781276b6e.11.1754175961738; 
 Sat, 02 Aug 2025 16:06:01 -0700 (PDT)
Received: from stoup.. ([172.58.111.133]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-61970693b48sm1093401eaf.19.2025.08.02.16.05.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Aug 2025 16:06:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 14/95] linux-user: Move get_elf_hwcap to riscv/elfload.c
Date: Sun,  3 Aug 2025 09:03:38 +1000
Message-ID: <20250802230459.412251-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250802230459.412251-1-richard.henderson@linaro.org>
References: <20250802230459.412251-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::329;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x329.google.com
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

Change the return type to abi_ulong, and pass in the cpu.
As this is the last instance of get_elf_hwcap to be converted,
remove the ifdef around the declaration in loader.h.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/loader.h           |  5 -----
 linux-user/riscv/target_elf.h |  2 ++
 linux-user/elfload.c          | 14 +-------------
 linux-user/riscv/elfload.c    | 12 ++++++++++++
 4 files changed, 15 insertions(+), 18 deletions(-)

diff --git a/linux-user/loader.h b/linux-user/loader.h
index c14e69f551..729723cc06 100644
--- a/linux-user/loader.h
+++ b/linux-user/loader.h
@@ -101,13 +101,8 @@ extern unsigned long guest_stack_size;
 /* Note that Elf32 and Elf64 use uint32_t for e_flags. */
 const char *get_elf_cpu_model(uint32_t eflags);
 
-#if defined(TARGET_I386) || defined(TARGET_X86_64) || defined(TARGET_ARM) \
-    || defined(TARGET_SPARC) || defined(TARGET_PPC) \
-    || defined(TARGET_LOONGARCH64) || defined(TARGET_MIPS) \
-    || defined(TARGET_SH4) || defined(TARGET_S390X)
 abi_ulong get_elf_hwcap(CPUState *cs);
 abi_ulong get_elf_hwcap2(CPUState *cs);
-#endif
 const char *elf_hwcap_str(uint32_t bit);
 const char *elf_hwcap2_str(uint32_t bit);
 
diff --git a/linux-user/riscv/target_elf.h b/linux-user/riscv/target_elf.h
index bfe86105d0..48d9af557b 100644
--- a/linux-user/riscv/target_elf.h
+++ b/linux-user/riscv/target_elf.h
@@ -8,4 +8,6 @@
 #ifndef RISCV_TARGET_ELF_H
 #define RISCV_TARGET_ELF_H
 
+#define HAVE_ELF_HWCAP          1
+
 #endif
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index ba8593368d..ce4055b0e9 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -1099,19 +1099,7 @@ static void elf_core_copy_regs(target_elf_gregset_t *regs,
 #define VDSO_HEADER "vdso-64.c.inc"
 #endif
 
-#define ELF_HWCAP get_elf_hwcap()
-
-static uint32_t get_elf_hwcap(void)
-{
-#define MISA_BIT(EXT) (1 << (EXT - 'A'))
-    RISCVCPU *cpu = RISCV_CPU(thread_cpu);
-    uint32_t mask = MISA_BIT('I') | MISA_BIT('M') | MISA_BIT('A')
-                    | MISA_BIT('F') | MISA_BIT('D') | MISA_BIT('C')
-                    | MISA_BIT('V');
-
-    return cpu->env.misa_ext & mask;
-#undef MISA_BIT
-}
+#define ELF_HWCAP get_elf_hwcap(thread_cpu)
 
 static inline void init_thread(struct target_pt_regs *regs,
                                struct image_info *infop)
diff --git a/linux-user/riscv/elfload.c b/linux-user/riscv/elfload.c
index f92adb7308..2e7d622232 100644
--- a/linux-user/riscv/elfload.c
+++ b/linux-user/riscv/elfload.c
@@ -9,3 +9,15 @@ const char *get_elf_cpu_model(uint32_t eflags)
 {
     return "max";
 }
+
+abi_ulong get_elf_hwcap(CPUState *cs)
+{
+#define MISA_BIT(EXT) (1 << (EXT - 'A'))
+    RISCVCPU *cpu = RISCV_CPU(cs);
+    uint32_t mask = MISA_BIT('I') | MISA_BIT('M') | MISA_BIT('A')
+                    | MISA_BIT('F') | MISA_BIT('D') | MISA_BIT('C')
+                    | MISA_BIT('V');
+
+    return cpu->env.misa_ext & mask;
+#undef MISA_BIT
+}
-- 
2.43.0


