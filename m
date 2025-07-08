Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32156C8303C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Jul 2025 21:24:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZFF4-0000ud-92; Tue, 08 Jul 2025 16:48:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uZE1P-0002Ae-T9
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 15:30:42 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uZE1L-0003Bu-II
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 15:30:30 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3b45edf2303so4517602f8f.2
 for <qemu-devel@nongnu.org>; Tue, 08 Jul 2025 12:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752003024; x=1752607824; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LWuEN0hS2XdfQkxKVaw5JgDv90FSfB0Ty4N9QjBE+jg=;
 b=GrSThDAfewCjR9ETf3dEgm5EJwlZ1zcsEtVBA6XxVI3ZZvH5gDl2QP716r8Zqsg29f
 SzjrM1ZaDdI4gJNPg3sV7JHIrBMKaf0DogAUilh7Buv6QHUO8UtYjIkFwBrzj8CUam+X
 vTcrs7q43PSc50Od/Pttkv5o+x9+Xa8jVrG43IVAJUycmPGEb4jcMMUZRhPCwXUGAidX
 SXkPqoDyeWzaoDSz5Z8cO8pKclVDWDVp7bA3Gkn3qE2AJeFNzH1QDREtyqrQnfdOG+7G
 qPx1nLLSfyWwZg+vRQ7cGNLinHIFvihZEH6FvEcjqPPLtuP+vvMh8rHaK45NLBFyTtsK
 0umQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752003024; x=1752607824;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LWuEN0hS2XdfQkxKVaw5JgDv90FSfB0Ty4N9QjBE+jg=;
 b=P4+xw7jNRVEyZZEJW8Wn+XwbfQUenzHivqFyqVsjd/REEduyF5XAjVGDE1c6Hx58Ie
 +DXiJTqfMj0FfSoLcEe5sbCvvKIA6nx4rBPPx9Jp7NyPz4+K9/tUOUEX2L7J2DUkSWEW
 0potb2nRhM4yoOtXKfAGz5RGxKxbUuvj6a7bUZ7//rV6Rpx7TaebooeuSGIce4jj2Ldp
 nUcDFaezWZirUK/IZQPACqvk3jsA7G5eaAW4ivgD0norqb+jCI5cN+ZoWGf5rhEZ2Erz
 tqIjL4Wt8bGF5uT6RhImbGTvmMNgst+b5a4CvvR1wJiLZNjHzcz79ZLXx8nJ38X3tSzu
 jj5A==
X-Gm-Message-State: AOJu0Yyn9o8xbj4oTb49tpPzTX3jCFEcFRB2hZcp/bD0VofQKxBoLVZd
 u9mtPaFb83sbfHvoCD9W4TrBRMmIjlxL6QOEonhbmkgQwK7ytNJ6fCG6K2zHU/3sz6v8TExvG3T
 pOLUqad0=
X-Gm-Gg: ASbGnctuloE/SeYpnXwJTYv25UdaZnkihue9qJX+4v2IlSCoch1lZQJwrU8yPb6Ti6d
 CZpVHwswvzzJh/iNzJNo6X9BFG/BlssFyewl7cy/aQe60QZ27gIbALLcJu0RL1j0n1NrcJYsta7
 FY2IX157g9d5IOJON8f0BsSRJdbw5YslZG9sq59D6NgUeipGktUyiPgSvBHJKbOaKDkZ3AXePA7
 v5JK6JqZHNHcWPto7Ejrs45jvdT1vXk8O40YnbQeHZ5x9kYxjBbrwNVTg9eVl/hCKgh1Awznpmk
 L/Q8F0UtSvh5BQ57GMrziaVwz4xv/dgEXf2BS6/rqDJdqCz0v7JGCcyKvMdJvWYuPLkNuqJ2TU5
 HPCTihHWfSEkCLLaEZjsh9lTfhdieyiQt0hR7R4RKu3L81yg=
X-Google-Smtp-Source: AGHT+IEqr33OCIQaiUClO0SKW/O7WqQ/SH2fI24iOSXB3VjU8R3QtideLDR/HQe/Pr+dSaqKEA2eJQ==
X-Received: by 2002:a05:6000:2209:b0:3a4:fb33:85ce with SMTP id
 ffacd0b85a97d-3b5ddebd1a4mr2034117f8f.46.1751968677985; 
 Tue, 08 Jul 2025 02:57:57 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b4708d099esm12352782f8f.21.2025.07.08.02.57.57
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 08 Jul 2025 02:57:57 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-s390x@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 2/4] target/s390x: Expose s390_count_running_cpus() method
Date: Tue,  8 Jul 2025 11:57:44 +0200
Message-ID: <20250708095746.12697-3-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250708095746.12697-1-philmd@linaro.org>
References: <20250708095746.12697-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

In order to simplify the next commit where s390_count_running_cpus()
is split out of s390_cpu_halt(), make its prototype public as a
preliminary step.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/s390x/s390x-internal.h | 1 +
 target/s390x/cpu-system.c     | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/s390x/s390x-internal.h b/target/s390x/s390x-internal.h
index 6894f0a2569..145e472edf0 100644
--- a/target/s390x/s390x-internal.h
+++ b/target/s390x/s390x-internal.h
@@ -238,6 +238,7 @@ uint32_t calc_cc(CPUS390XState *env, uint32_t cc_op, uint64_t src, uint64_t dst,
 
 /* cpu.c */
 #ifndef CONFIG_USER_ONLY
+unsigned int s390_count_running_cpus(void);
 unsigned int s390_cpu_halt(S390CPU *cpu);
 void s390_cpu_unhalt(S390CPU *cpu);
 void s390_cpu_system_init(Object *obj);
diff --git a/target/s390x/cpu-system.c b/target/s390x/cpu-system.c
index 9b380e343c2..2fa8c4d75db 100644
--- a/target/s390x/cpu-system.c
+++ b/target/s390x/cpu-system.c
@@ -196,7 +196,7 @@ static bool disabled_wait(CPUState *cpu)
                             (PSW_MASK_IO | PSW_MASK_EXT | PSW_MASK_MCHECK));
 }
 
-static unsigned s390_count_running_cpus(void)
+unsigned s390_count_running_cpus(void)
 {
     CPUState *cpu;
     int nr_running = 0;
-- 
2.49.0


