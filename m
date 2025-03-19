Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55513C35FFA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 13:47:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tutkz-0004EB-7z; Wed, 19 Mar 2025 09:46:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tutk0-0003N3-Pm
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 09:45:54 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tutjy-00044L-T9
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 09:45:52 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-43cf034d4abso48336815e9.3
 for <qemu-devel@nongnu.org>; Wed, 19 Mar 2025 06:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742391949; x=1742996749; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SPrx/qQq0qEoYxnErEWIYikr7yzsC+mHkGeoZcaDE8c=;
 b=PsPKZDPFcKqX9hO8xoDauVoZ4E8+IuRJSbDoiFdflhJ/FUlwYPp8iTmqkYUDP/9xGH
 1LXQboeBOeNZZSUd19ZGPUp1tQ/PiXcuyz52bpiNdgvTaPi537w9jDMRCk3wwzwGNVyK
 cYXpfbxSP2LuqLjK36MD6ApF1abt9OFbnQlJza19MkrXL2y63bAAbW2fqLXndZWSnuex
 w6zdyBvPuW0ddcgjgsTl5pVYvTL+qzvkClFYNSld5qCA7gletaL9blrbIWC1cgWHXuVr
 k7dJq0hReAjBIMeiE8GE4EXoY5JnOhDjneBCri6Hkw5QPUPy8FSRlQ5Ghne9zl7kIYDD
 YVXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742391949; x=1742996749;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SPrx/qQq0qEoYxnErEWIYikr7yzsC+mHkGeoZcaDE8c=;
 b=pVySWzoKYN/APZRW0v/dl8jqtORb63+Nm/VwG9Y/ioPzYu1qcJ93ayRJFX0r/BDctE
 yyRvvx7n+Bs0nn/V7JnHGcuwBCZNS2uLxJi2PxfHrthvCayEGBygD2Efva1gS1LK8fyC
 KmA5HeZsaICu+EiarAKR+r25an8xLp8/GQSk2ZpOh3OzSsuMkvZiIdpmX3lmvsFm42to
 AERIFrHkPHDqj+JJQOE9N5O0Q31P+8qyUIDNBcUehwbKIRLUAahcQmOTsitLBMxo8drR
 ES7HUYxmElWpauENsGzjl2a0D0jiUNtFvxL5Lc44OSlKNf9MYU2X90S+36TXVR6B3ejG
 Pl+Q==
X-Gm-Message-State: AOJu0YzD9r70jvyJAJNsHkxA6A8pUEOmEKYsb0rmVqQpjHCLIr78yG3M
 ILolJ78xPrS9AHxFFZfBn52w6QU/yz95wIAN2viWbzzhadV28VGrT9XUqYVJiulHgu8AEdHDXWc
 o
X-Gm-Gg: ASbGncshxdDsihO5ZTDY9YUz3j5O3Xa6rJczdzkysDnWrBQsDEQLTfgHo4oykHl6VzZ
 2su8/it1I/aaGm1msoB6zKDX9BUSYfWqUn4IUZX8OJAkWIvkukNd091U3RKta5yfc5ANgAyP6vU
 BwaXfiy+aT1FStbdy+ahmuI99Ma+IiIyeHHmtGPbmE/JEW1geRetRQSBlNFLdL78kErKMeoL67n
 XgyFUf3ESP2uSd4XdiKxH9/36R+n0Mij4lgN5yjwhU5tqSnn6oEHNJ6aNlqL/vp2XOzxrt2s/t5
 WAqUUW+C4bMq9GGsvxsrY/GYf7q9jW9UvQQgSvsGFehUyHjR/gi61LQFjIkFr+dzgpnHEMiDaLK
 8U/i/nqQ6UsY/T24fWXo=
X-Google-Smtp-Source: AGHT+IHdjs7aQ50tjKQlQC0Vj2JE6chXiS8iHMl/1H/jv8dgqA7RU+H5Ct0xNT3xYIarlJ8IRNph5A==
X-Received: by 2002:a05:600c:b8f:b0:43c:f470:7605 with SMTP id
 5b1f17b1804b1-43d4379505amr29533475e9.12.1742391948777; 
 Wed, 19 Mar 2025 06:45:48 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d43f37665sm19623035e9.2.2025.03.19.06.45.47
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 19 Mar 2025 06:45:48 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>, Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.1 08/12] tcg: Declare arrays using
 TARGET_INSN_START_WORDS_MAX
Date: Wed, 19 Mar 2025 14:45:02 +0100
Message-ID: <20250319134507.45045-9-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250319134507.45045-1-philmd@linaro.org>
References: <20250319134507.45045-1-philmd@linaro.org>
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

Prefer the target-agnostic TARGET_INSN_START_WORDS_MAX definition
over the target-specific TARGET_INSN_START_WORDS. The former is
guaranty to hold the latter.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/tcg/translate-all.c    | 2 +-
 target/i386/helper.c         | 3 ++-
 target/openrisc/sys_helper.c | 3 ++-
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 5e2a89dc474..2f8cf6db144 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -206,7 +206,7 @@ static int cpu_unwind_data_from_tb(TranslationBlock *tb, uintptr_t host_pc,
 void cpu_restore_state_from_tb(CPUState *cpu, TranslationBlock *tb,
                                uintptr_t host_pc)
 {
-    uint64_t data[TARGET_INSN_START_WORDS];
+    uint64_t data[TARGET_INSN_START_WORDS_MAX];
     int insns_left = cpu_unwind_data_from_tb(tb, host_pc, data);
 
     if (insns_left < 0) {
diff --git a/target/i386/helper.c b/target/i386/helper.c
index c07b1b16ea1..90e113c8b5a 100644
--- a/target/i386/helper.c
+++ b/target/i386/helper.c
@@ -31,6 +31,7 @@
 #include "qemu/log.h"
 #ifdef CONFIG_TCG
 #include "tcg/insn-start-words.h"
+#include "tcg/tcg.h"
 #endif
 
 void cpu_sync_avx_hflag(CPUX86State *env)
@@ -524,7 +525,7 @@ void cpu_x86_inject_mce(Monitor *mon, X86CPU *cpu, int bank,
 static inline target_ulong get_memio_eip(CPUX86State *env)
 {
 #ifdef CONFIG_TCG
-    uint64_t data[TARGET_INSN_START_WORDS];
+    uint64_t data[TARGET_INSN_START_WORDS_MAX];
     CPUState *cs = env_cpu(env);
 
     if (!cpu_unwind_state_data(cs, cs->mem_io_pc, data)) {
diff --git a/target/openrisc/sys_helper.c b/target/openrisc/sys_helper.c
index 21bc137ccca..cf521461954 100644
--- a/target/openrisc/sys_helper.c
+++ b/target/openrisc/sys_helper.c
@@ -28,6 +28,7 @@
 #include "hw/boards.h"
 #endif
 #include "tcg/insn-start-words.h"
+#include "tcg/tcg.h"
 
 #define TO_SPR(group, number) (((group) << 11) + (number))
 
@@ -218,7 +219,7 @@ target_ulong HELPER(mfspr)(CPUOpenRISCState *env, target_ulong rd,
 {
     OpenRISCCPU *cpu = env_archcpu(env);
 #ifndef CONFIG_USER_ONLY
-    uint64_t data[TARGET_INSN_START_WORDS];
+    uint64_t data[TARGET_INSN_START_WORDS_MAX];
     MachineState *ms = MACHINE(qdev_get_machine());
     CPUState *cs = env_cpu(env);
     int idx;
-- 
2.47.1


