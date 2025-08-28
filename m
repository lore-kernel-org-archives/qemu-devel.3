Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97CEEC8303F
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 17:15:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urgDP-0004GG-9l; Thu, 28 Aug 2025 13:15:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urbXj-0001DH-N5
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 08:15:55 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urbXg-0000LM-Ue
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 08:15:51 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-24633f57e0bso5564365ad.0
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 05:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756383347; x=1756988147; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+fMdc66z+1eXUdLndIT85qIQpM1j8AYTmXXRdsfc7RE=;
 b=DBxR8s9DrwGEGS58Kb/lYIWrTurrfaHx6p5q9C1JQMD9Nnt2U0y1Ah4PPSfRRKPXJ/
 krqqbGw0i+HtLOUVxYRL6oXyjsMp3XWq4Sxj5qpTQpx5ycDKiwiNM6l7kA8AH36VqmVU
 sFZ78hr7sw4LI753ruMUENkHzLu1bmR8QOvuRWizGz9tYuwwC3srNDw66q9HHOUq2XuP
 DWd3OjrIENnj81agbuCT2HjSmsNzF+fv/oR7c34ssWnDU0+VgoQ01Qc8EbfdpFto3rdz
 U9HdE8Ch6JuZ7Nnlti2G/zK3nM/rKV6IdQ5fUZM1CEB1hwQdR5x//hdFvMh0K/l6TnNI
 ZzZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756383347; x=1756988147;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+fMdc66z+1eXUdLndIT85qIQpM1j8AYTmXXRdsfc7RE=;
 b=Bgb9oVDRRAFt7Vg17C2YMrbIGYvFa3V5T4CsTI5iigoT+Al/9rdej/bxFsyELZLrTF
 f2uCfUjTmbviJp8p1kQA7UEoI539uCkHGSRiMOrfrJ4ZFC6gFxv9tB+R5PBIg5DG7oDP
 a1zhJ742PTMeofswhXXpt+l3vByGj7+8ooeT1xffVGM5OCw1qkEa5RDY7VVhRWRkHyJ5
 9Aeo9oL3cJVmACr4NyuTnbSDcI2QSP2iMNSNZh2kk1BfAQ2qLpxzE1urEmIOYO40dlca
 dKoAqNoETxppb2g0nMUSVCgXZKN5OFMHVnV1Wl0rrCWbi9fr6Ihwb9tkw9p4/z/2BIw8
 LmgQ==
X-Gm-Message-State: AOJu0YyI6SDXL3D6h99y8BaQ4TyqsRplSUdAjfBxXVdmAAvLa0vKOOS4
 b0HLdSpesOangWvfoFdfpysQx7VMr+Hnq/lEKLpy6zlRq3WyfprDdVzhbtcUsUA3hkI1ZGnUjd0
 ZMj5LGQk=
X-Gm-Gg: ASbGncsBzY1eOPTilw6KiPnHE4xwTX7t/JV7L0lViX6lwi0DGm64yvhEh7rz4SvuUnl
 wMrOgF0oiBgjmaAhFWvamdkcOH+RJPpFaX8EOceM9zeaztNlqg7jbFYEsQsY1osdp6M4WRCS1Hh
 ghX/gSuS2M0JdTGEXPQjaYW0MAL3mxEwa6NG2L9MJnaBaYWSekYSNV75YvrP7m725VZFJ5mItqu
 aaWxBgb16tRkLPjclDrZfeb1bOs12pmemY55TLvotLIbz0M0OyM4MYT+95cTPaW7TIlVV5e4mpG
 uDNvwMjfVSXWaaV3imov8wnqyRf0SoPNiYwqMQY5Ebbbo1XyWZx+/CIf95XTa/z0cu9ZzO/HWuF
 3psPdSvswFfvnL3eFTM9in8B6Vw6xXYlWfpN/
X-Google-Smtp-Source: AGHT+IEWniJfyJUWCp4uZ7n8nFX/lxPddQlhchCEK2gpuA2qc/UqEBU0JDSuLU5ZQtUzQQXbTXAxDQ==
X-Received: by 2002:a17:903:3d10:b0:246:d383:3964 with SMTP id
 d9443c01a7336-246d3833ba3mr176360235ad.18.1756383347539; 
 Thu, 28 Aug 2025 05:15:47 -0700 (PDT)
Received: from stoup.. ([144.6.121.55]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-248e3e0b75esm15129025ad.8.2025.08.28.05.15.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Aug 2025 05:15:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH v3 77/87] linux-user: Move elf parameters to hppa/target_elf.h
Date: Thu, 28 Aug 2025 22:08:26 +1000
Message-ID: <20250828120836.195358-78-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250828120836.195358-1-richard.henderson@linaro.org>
References: <20250828120836.195358-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/hppa/target_elf.h |  6 ++++++
 linux-user/elfload.c         | 11 -----------
 2 files changed, 6 insertions(+), 11 deletions(-)

diff --git a/linux-user/hppa/target_elf.h b/linux-user/hppa/target_elf.h
index b654758afa..9b6363a0a7 100644
--- a/linux-user/hppa/target_elf.h
+++ b/linux-user/hppa/target_elf.h
@@ -8,8 +8,14 @@
 #ifndef HPPA_TARGET_ELF_H
 #define HPPA_TARGET_ELF_H
 
+#define ELF_CLASS               ELFCLASS32
+#define ELF_ARCH                EM_PARISC
+
 #define HAVE_ELF_PLATFORM       1
 
 #define LO_COMMPAGE             0
+#define STACK_GROWS_DOWN        0
+#define STACK_ALIGNMENT         64
+#define VDSO_HEADER             "vdso.c.inc"
 
 #endif
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 6e476d5308..6732011332 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -130,17 +130,6 @@ typedef abi_uint        target_gid_t;
 #endif
 typedef abi_int         target_pid_t;
 
-#ifdef TARGET_HPPA
-
-#define ELF_CLASS       ELFCLASS32
-#define ELF_ARCH        EM_PARISC
-#define STACK_GROWS_DOWN 0
-#define STACK_ALIGNMENT  64
-
-#define VDSO_HEADER "vdso.c.inc"
-
-#endif /* TARGET_HPPA */
-
 #ifdef TARGET_XTENSA
 
 #define ELF_CLASS       ELFCLASS32
-- 
2.43.0


