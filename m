Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C85B3C87FC9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 00:29:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugucw-0000zD-Fv; Tue, 29 Jul 2025 20:25:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uguJM-0004uD-Rl
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 20:04:48 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uguJK-0004h4-S4
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 20:04:48 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-7490702fc7cso214224b3a.1
 for <qemu-devel@nongnu.org>; Tue, 29 Jul 2025 17:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753833885; x=1754438685; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=beNBwLii5Jeq9xzNg4DtNko2NKZVFnUreMAkEt6EnY0=;
 b=b5RcCzdoJlslOxAwh9dhyZ8YybtXjtG39WikIfQSF4qmt/qjZlj3qSACV+m1jD8isV
 TfJsT3LZDnrVXr8TvUIZF35/vjnDHY0yyT0H4t1iI66vZNrZKNcMeri4/WBCQsKdDCFs
 hTO0ihRZP9f1f/R+aYEdk7pcQFOS+FWEdYoTT3Js83+QtZZFAynb+ecO3mmKKxnQqivH
 6dne8XASEUzajBHQBVRTAB2No4sIRAM0RTDLM4znJpYjI+fj9rqrgbtLBqBDRVw1999D
 6aLM7EORVaZKXWOEYZwHCAMadYWtZT4J5NZNwFX5p2RxMuT+HabD7Kt0gvAfOTi+NToV
 jniw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753833885; x=1754438685;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=beNBwLii5Jeq9xzNg4DtNko2NKZVFnUreMAkEt6EnY0=;
 b=GEJNPLQ5xA0LBn8ZfS9H82cWerrINU+OZUyV/hqxKereEfdf4y/8ZbjofrnbHg7hQa
 U3Q20WB8FCdEQhAdW4BN2RTFlvNz8eNnZUcQyaqbR9hV9plrhiuyG2pFVmJxFsqcQJM1
 cgRrmQjRo5x7LEO3ZogPmTmhgqTWrm7U2iqBibyHg5ydm0/z2FOYSd9gnRw+rwCRwhMI
 XXmtN1G+lOa0r3jO4WvnGDz9LaxZp06eieXDqPWYNnQQ1QRVjVNaNHSuZ1yCyAdJime0
 MX/6jBPRcIPAP6amjF97ZloLjQ8I0We3x1Kel/xk+aT0XgP1nR4VpDh/a7GI0eTIVhC/
 5SuQ==
X-Gm-Message-State: AOJu0YyjdS7UER2WsnEpUFGqgeSUAu5v9wrR6IoaIEM0DdThfb6TJP/W
 sMhaYtJftW/Wbb9zBR6nZvi3DXxIuEFpE5P7QKQ24aCAqL6ForN6pJ7+ldPeSvDJa9kwZ48liNF
 iN1Ke
X-Gm-Gg: ASbGnctlXWXZR4lF3SRa2Z2xTjFYdVwVKsS7C2hnxc5nDZHD/fZsBhpXRyCo0EVsYXc
 boVQssiquvqzK/rEm9G/7pxDuqrNf6msrsm/V6bGOpO7XBPBEKDvQO/OeyrVYQs7bi0kHWUayhd
 /hyr4UIECw1eyqPPcAi1Ht/AGc4quCwdgSZNjrjRpyP36iYKtwB73eqPPCqX+CFexp6E57mPj6x
 1t8a4Nv8a8FtyiZDDb+cria7+7ywrmFp6tIVBd4qr5E9cbGGIC5MS3z+3c0InkLALZM/T3Beoyu
 YBq01slSHuuoLs1sJZvBnjTWbX76VhOYtvNj4mX1010s+oQ9A31ue/XZnEMieeJJPLVKHZv+zeJ
 LDXAVFtorC6gPtq+SeYqfMyYdwJGGyKaaEFxWlaBp5uwWjFqKUKo0tVWDS3L938OJQEPR6vJ61a
 9JXyrCXHoYFQ==
X-Google-Smtp-Source: AGHT+IEdbgrxAqklWPMdyvmV4Ju/g3hL4HuIs6FO1f+sMrMWIYnJxUmxcYnGX2qz6tz4p6ZAKynJxQ==
X-Received: by 2002:a05:6a20:729c:b0:231:620a:4509 with SMTP id
 adf61e73a8af0-23dc0e59dd5mr1824299637.30.1753833885191; 
 Tue, 29 Jul 2025 17:04:45 -0700 (PDT)
Received: from localhost.localdomain (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7640ad06762sm9101302b3a.80.2025.07.29.17.04.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Jul 2025 17:04:44 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 69/89] linux-user: Move elf parameters to
 microblaze/target_elf.h
Date: Tue, 29 Jul 2025 13:59:42 -1000
Message-ID: <20250730000003.599084-70-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250730000003.599084-1-richard.henderson@linaro.org>
References: <20250730000003.599084-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/microblaze/target_elf.h |  5 +++++
 linux-user/elfload.c               | 10 ----------
 2 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/linux-user/microblaze/target_elf.h b/linux-user/microblaze/target_elf.h
index bfe2997fd2..738a101f67 100644
--- a/linux-user/microblaze/target_elf.h
+++ b/linux-user/microblaze/target_elf.h
@@ -8,4 +8,9 @@
 #ifndef MICROBLAZE_TARGET_ELF_H
 #define MICROBLAZE_TARGET_ELF_H
 
+#define ELF_CLASS           ELFCLASS32
+#define ELF_ARCH            EM_MICROBLAZE
+#define elf_check_arch(x)   ((x) == EM_MICROBLAZE || (x) == EM_MICROBLAZE_OLD)
+#define USE_ELF_CORE_DUMP
+
 #endif
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 609e9b99b5..aa05abec05 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -138,16 +138,6 @@ typedef abi_uint        target_gid_t;
 #endif
 typedef abi_int         target_pid_t;
 
-#ifdef TARGET_MICROBLAZE
-
-#define elf_check_arch(x) ( (x) == EM_MICROBLAZE || (x) == EM_MICROBLAZE_OLD)
-
-#define ELF_CLASS   ELFCLASS32
-#define ELF_ARCH    EM_MICROBLAZE
-
-#define USE_ELF_CORE_DUMP
-#endif /* TARGET_MICROBLAZE */
-
 #ifdef TARGET_OPENRISC
 
 #define ELF_ARCH EM_OPENRISC
-- 
2.43.0


