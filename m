Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E689C87FC9
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Aug 2025 23:19:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiLO4-0002cQ-93; Sat, 02 Aug 2025 19:11:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLO0-0002GF-ED
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:11:32 -0400
Received: from mail-oo1-xc29.google.com ([2607:f8b0:4864:20::c29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLNy-0001kP-MP
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:11:32 -0400
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-60402c94319so2042474eaf.1
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 16:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754176289; x=1754781089; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=kj1rBrO0uYipNGIGIjdbbfhBOZFS6dyRhbCDoZFqGog=;
 b=cpVhgAoUp4M0QAaE2ahLDXIQc0xo3XYQo8V+m8wniogJSJYScW/fBUXEm21aBRKnrO
 LnLZcUS2dZzr7OX7iTrFk4Kf5H8ZtVgeGQfXKxD+andIfpF1IHdpgFGsfxF0Rl4YS9p2
 6gutsC47+5S3FxqiKp/Q/aB1+AWXBmUlBJQhxDwemPqvuVK05X1tFNG7vVU1nfGpsGii
 SlVz+rDzR/I0yxaDjLQrtjfePSl7OT30uV3oL3bDQfA56WJWKwavCBdNslBgqulwQiI/
 Q+321PrzviWtRz3JvxtQIIVUy8HX0uEnmessY/wTswKZEzPFgDCifYyzDwQjp+FDRjAs
 /oiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754176289; x=1754781089;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kj1rBrO0uYipNGIGIjdbbfhBOZFS6dyRhbCDoZFqGog=;
 b=FLl9dNU3InQ2VtmLzAoccrZzjmrpO9ErLQsNMyqv9Vh6Z5OcFkWkSyjRLGFwfqVBAs
 yikMOzkWWff5PFuD9LIP07P1ikcH4G8OTCpkOuGjwVDTTfLAWcUIclqH+HbtcWAo+Z7y
 /6/6zaliM8CAOmYJJPdMhaGw/Q9MM457+oW/BVUeEkaLn1jQYLbigLhaBdqR5Z5Ttw1Q
 jT+UGnxOLYu1UJ2qv9bLEfbaA95hDE6KCWqKRVVcwR3yCXN2tpaQXcBocR9cUrHt7fMe
 diKRGcJkV6kMCkMKKawWCv+uxKDHpal4PEs713iodDEH4i89e/HH7fRwIAS9GmFP+UUk
 Wh6A==
X-Gm-Message-State: AOJu0Yy+u24xmQ8am7KXaQJ88wqPW8zTbK2QT3F7WMZOVm+9eoDd+GlE
 dJSuqGbc0nc2a7GafiOA+uZkhkDdQX0gJFBdh3vWH1838ZUS/cgT2rChq4YnJNHXJmsMP6UcYib
 UgO8dczw=
X-Gm-Gg: ASbGncsiICpGJ3IGiY7JYxwpttbbjbHu49/JEJ4/JDNC9G2o1rq/WyeTTeNAjSm0+3y
 z8SYSs3ZZb4lQgYttpyZA9v34Puj+QeBpZktMdjnXQWdDHiJGk8UPbR6TxM2PFVFmt+QEkie8bZ
 Mg4pMRTfuXR+sFNBnVW21v76p24RYVDcZ+tMQ3WXFZSmxYbrHnya9e82C1kHiNMRUkeIm/PeXga
 Te8v7Xa/sqb0Ls8aQDvcGKn+4cYIHqcCRKD+NG6Y43v7n9ZjnwWv1I0GaFC/Ow4wezRvttIHlMV
 bDz1ALCYc4zbEG4YMUHH4Jz1F6qE9zrFjXfiHwa0YaaXokJaBwDEYEtq+WfRy8nlg+BdTmeaVKF
 7/nKVMOqyXVEmWaEdao/+7kVr2NpymXoj9BOMIioxgIBAZ8LSog3F
X-Google-Smtp-Source: AGHT+IEhML4IiTVrJq/g9Gctdq6ZeLA6181cd2ROzwu4WG89rmpI1EHjpgsoTFNOSA0EqDQhOnjUaQ==
X-Received: by 2002:a05:6820:8185:b0:619:5ed4:b198 with SMTP id
 006d021491bc7-6198f24d107mr2280751eaf.5.1754176289505; 
 Sat, 02 Aug 2025 16:11:29 -0700 (PDT)
Received: from stoup.. ([172.58.111.133]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-61970693ed9sm1084454eaf.20.2025.08.02.16.11.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Aug 2025 16:11:29 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 55/95] linux-user: Move elf_core_copy_regs to mips/elfload.c
Date: Sun,  3 Aug 2025 09:04:19 +1000
Message-ID: <20250802230459.412251-56-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250802230459.412251-1-richard.henderson@linaro.org>
References: <20250802230459.412251-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c29;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc29.google.com
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

Move elf_core_copy_regs to elfload.c.
Move ELF_NREG to target_elf.h.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/mips/target_elf.h   |  3 +++
 linux-user/mips64/target_elf.h |  3 +++
 linux-user/elfload.c           | 44 ----------------------------------
 linux-user/mips/elfload.c      | 41 +++++++++++++++++++++++++++++++
 4 files changed, 47 insertions(+), 44 deletions(-)

diff --git a/linux-user/mips/target_elf.h b/linux-user/mips/target_elf.h
index 08e699c085..a36ca5a83f 100644
--- a/linux-user/mips/target_elf.h
+++ b/linux-user/mips/target_elf.h
@@ -11,4 +11,7 @@
 #define HAVE_ELF_HWCAP          1
 #define HAVE_ELF_BASE_PLATFORM  1
 
+/* See linux kernel: arch/mips/include/asm/elf.h.  */
+#define ELF_NREG                45
+
 #endif
diff --git a/linux-user/mips64/target_elf.h b/linux-user/mips64/target_elf.h
index 24bb7fcd3f..ebfd62348f 100644
--- a/linux-user/mips64/target_elf.h
+++ b/linux-user/mips64/target_elf.h
@@ -11,4 +11,7 @@
 #define HAVE_ELF_HWCAP          1
 #define HAVE_ELF_BASE_PLATFORM  1
 
+/* See linux kernel: arch/mips/include/asm/elf.h.  */
+#define ELF_NREG                45
+
 #endif
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 834120c9f2..e5833ec3b4 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -395,50 +395,6 @@ static const VdsoImageInfo *vdso_image_info(uint32_t elf_flags)
 #define elf_check_abi(x) (!((x) & EF_MIPS_ABI2))
 #endif
 
-/* See linux kernel: arch/mips/include/asm/elf.h.  */
-#define ELF_NREG 45
-
-/* See linux kernel: arch/mips/include/asm/reg.h.  */
-enum {
-#ifdef TARGET_MIPS64
-    TARGET_EF_R0 = 0,
-#else
-    TARGET_EF_R0 = 6,
-#endif
-    TARGET_EF_R26 = TARGET_EF_R0 + 26,
-    TARGET_EF_R27 = TARGET_EF_R0 + 27,
-    TARGET_EF_LO = TARGET_EF_R0 + 32,
-    TARGET_EF_HI = TARGET_EF_R0 + 33,
-    TARGET_EF_CP0_EPC = TARGET_EF_R0 + 34,
-    TARGET_EF_CP0_BADVADDR = TARGET_EF_R0 + 35,
-    TARGET_EF_CP0_STATUS = TARGET_EF_R0 + 36,
-    TARGET_EF_CP0_CAUSE = TARGET_EF_R0 + 37
-};
-
-/* See linux kernel: arch/mips/kernel/process.c:elf_dump_regs.  */
-void elf_core_copy_regs(target_ulong *regs, const CPUMIPSState *env)
-{
-    int i;
-
-    for (i = 0; i < TARGET_EF_R0; i++) {
-        regs[i] = 0;
-    }
-    regs[TARGET_EF_R0] = 0;
-
-    for (i = 1; i < ARRAY_SIZE(env->active_tc.gpr); i++) {
-        regs[TARGET_EF_R0 + i] = tswapl(env->active_tc.gpr[i]);
-    }
-
-    regs[TARGET_EF_R26] = 0;
-    regs[TARGET_EF_R27] = 0;
-    regs[TARGET_EF_LO] = tswapl(env->active_tc.LO[0]);
-    regs[TARGET_EF_HI] = tswapl(env->active_tc.HI[0]);
-    regs[TARGET_EF_CP0_EPC] = tswapl(env->active_tc.PC);
-    regs[TARGET_EF_CP0_BADVADDR] = tswapl(env->CP0_BadVAddr);
-    regs[TARGET_EF_CP0_STATUS] = tswapl(env->CP0_Status);
-    regs[TARGET_EF_CP0_CAUSE] = tswapl(env->CP0_Cause);
-}
-
 #define ELF_EXEC_PAGESIZE        4096
 
 #endif /* TARGET_MIPS */
diff --git a/linux-user/mips/elfload.c b/linux-user/mips/elfload.c
index c353ccc1ad..b54e0d8d1c 100644
--- a/linux-user/mips/elfload.c
+++ b/linux-user/mips/elfload.c
@@ -122,3 +122,44 @@ const char *get_elf_base_platform(CPUState *cs)
 }
 
 #undef MATCH_PLATFORM_INSN
+
+/* See linux kernel: arch/mips/include/asm/reg.h.  */
+enum {
+#ifdef TARGET_MIPS64
+    TARGET_EF_R0 = 0,
+#else
+    TARGET_EF_R0 = 6,
+#endif
+    TARGET_EF_R26 = TARGET_EF_R0 + 26,
+    TARGET_EF_R27 = TARGET_EF_R0 + 27,
+    TARGET_EF_LO = TARGET_EF_R0 + 32,
+    TARGET_EF_HI = TARGET_EF_R0 + 33,
+    TARGET_EF_CP0_EPC = TARGET_EF_R0 + 34,
+    TARGET_EF_CP0_BADVADDR = TARGET_EF_R0 + 35,
+    TARGET_EF_CP0_STATUS = TARGET_EF_R0 + 36,
+    TARGET_EF_CP0_CAUSE = TARGET_EF_R0 + 37
+};
+
+/* See linux kernel: arch/mips/kernel/process.c:elf_dump_regs.  */
+void elf_core_copy_regs(target_ulong *regs, const CPUMIPSState *env)
+{
+    int i;
+
+    for (i = 0; i < TARGET_EF_R0; i++) {
+        regs[i] = 0;
+    }
+    regs[TARGET_EF_R0] = 0;
+
+    for (i = 1; i < ARRAY_SIZE(env->active_tc.gpr); i++) {
+        regs[TARGET_EF_R0 + i] = tswapl(env->active_tc.gpr[i]);
+    }
+
+    regs[TARGET_EF_R26] = 0;
+    regs[TARGET_EF_R27] = 0;
+    regs[TARGET_EF_LO] = tswapl(env->active_tc.LO[0]);
+    regs[TARGET_EF_HI] = tswapl(env->active_tc.HI[0]);
+    regs[TARGET_EF_CP0_EPC] = tswapl(env->active_tc.PC);
+    regs[TARGET_EF_CP0_BADVADDR] = tswapl(env->CP0_BadVAddr);
+    regs[TARGET_EF_CP0_STATUS] = tswapl(env->CP0_Status);
+    regs[TARGET_EF_CP0_CAUSE] = tswapl(env->CP0_Cause);
+}
-- 
2.43.0


