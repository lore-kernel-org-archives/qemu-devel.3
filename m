Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B0FDCCD19A
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 12:20:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9MvU-0007kc-BB; Thu, 16 Oct 2025 08:17:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9Muo-0007C7-0B
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 08:17:06 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9Mui-0008Hb-JS
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 08:17:04 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-46e6ba26c50so4851975e9.2
 for <qemu-devel@nongnu.org>; Thu, 16 Oct 2025 05:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760617015; x=1761221815; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=QVt484XWSZptPjJV65VDtGr+u22va0W1CgZg+7OsB20=;
 b=fAm7tado/NdsALG2lPmUK+Y2DtP8WlSpJYm/5wllxjExjuqhgQPeTHD446k7BFOgYJ
 M1qRTHHyGxfrKJttLPzehHYxGyDzeTW4dOh9pCxakzTGoI19n7SdbrA1YgMXKdzBvEY8
 FlJjp4qIYFcpnStt/sZjK8TxiFv1lFLy7kFZBOuUZOYVjGa+0Z2dKrwUG/tFQZqz8RSc
 QcFmCoWJZdddW5yfhwFS9rIbIl5s6Q+2QUhk0J6NwdmtwBBsfsaUA7KmVt+SKuaMYpIQ
 nKpf4tlaZ9jYoNI523EQDZJCIisKr8UwXiqXDAk8GCQjZm0GLEikH1Iww8MRMOw/yjSs
 rQMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760617015; x=1761221815;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QVt484XWSZptPjJV65VDtGr+u22va0W1CgZg+7OsB20=;
 b=B6SQoLPFufVACVSpLbG3ECwvuJMgtMc0JUVRIxDRhoX7JaT4hwgnDJbDUgkFQtISSd
 Wtqf85zHwQSeAmHJXWszfGJm6Zm4PnyYapKAarOXdQ3UEc26F0BW+yoXwSfQbzLaJFl7
 6w8iYpzFPf51YzW6fHGYDyGRRsv0MIFyEjeTEr7JA9QcWKIVJ6oEmPCg+q2aLp74S5Pj
 8yXrOoFqWPH2r7k5icm2JpS6q6anLGczXli9rJQZdWGQ6LmCthY+584CxPnXTvl7MV0x
 DQwdDstWQISvnUyjRuqEc25cZr9sBGljvd1XtplWWew6K6IxPsynlUreux7nYpsNeAZK
 4ESQ==
X-Gm-Message-State: AOJu0YyPTY57skJpxgFD62VErnKBnlfoiJvgyxoj2VMLzGz0l/l9MjxB
 WQkjZzmzZpl+nmxrT1w4uo5O+YsQ7XNzZqRc4XEcwQyz9kYqP1JIBBA8cADXO+sUpz6mFL1VcHu
 t0CupPmg=
X-Gm-Gg: ASbGnctzbSk2NYSrqZ0JuLFn2NhM5P8L8w2eocpfz1fInLZMnCFmUSKo+WJ4sHtRSVy
 tK5gFPI7/olT29KLPrze+BkbseLxEAD/mDgznrlakMmJOaRrZm0G1mbRzlXKq/wqGbww16x09vO
 uvM9qwavhGMAaXQ3xmWGPyD301WUCNTuEvF7LuSMRlbagmnd5toaoUAGe0NhWm9cnxa5EHC6/qg
 I4NY9bZCVixKrw/xPPdiYo6ea7rTEc4vgtVQTtNqyhk6KT700lxbH8F6VWNWEOicF56QSA7qXJI
 CKkorBj7Em7xeE5nm3vuL/MmokCX+A9hE2eCpQrI/CAxTcD12I2QhvUpNPUlxa7kFOSaLVOG0Bt
 cTSv+1XQOymOpYPkXZ1TaaRUwkkD6FTForBFj+K3isVAKeopwRo9v4Y+lVpyoLGh0eA82W1jkm9
 duk35ZBqLj5FKxYjL6/1SKLVTDbrSo1sqQbTTz/itjTumQ0ix8Rj0E/HrQIS/aDe9W
X-Google-Smtp-Source: AGHT+IFgmlQ1MP5iTI4opbdCqXRsvGMmLI+8H+G8rpPu3zTBQWzwleftRpwISuufibRh3PRYImkxwQ==
X-Received: by 2002:a05:600d:8110:b0:46d:a04:50c6 with SMTP id
 5b1f17b1804b1-46fa9b01fb1mr229786685e9.30.1760617015166; 
 Thu, 16 Oct 2025 05:16:55 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-471144b5c34sm27639775e9.10.2025.10.16.05.16.54
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 16 Oct 2025 05:16:54 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 17/75] target/loongarch: Do not use target_ulong type for LDDIR
 level
Date: Thu, 16 Oct 2025 14:14:33 +0200
Message-ID: <20251016121532.14042-18-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251016121532.14042-1-philmd@linaro.org>
References: <20251016121532.14042-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

The LDDIR level page table is a 5-bit immediate. Using the
uint32_t type for it is sufficient. Avoid the target_ulong type.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Song Gao <gaosong@loongson.cn>
Message-Id: <20251009201947.34643-5-philmd@linaro.org>
---
 target/loongarch/cpu-mmu.h                             | 2 +-
 target/loongarch/tcg/helper.h                          | 2 +-
 target/loongarch/cpu_helper.c                          | 2 +-
 target/loongarch/tcg/tlb_helper.c                      | 4 ++--
 target/loongarch/tcg/insn_trans/trans_privileged.c.inc | 2 +-
 5 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/target/loongarch/cpu-mmu.h b/target/loongarch/cpu-mmu.h
index 0068d22efcb..dbc69c7c0f2 100644
--- a/target/loongarch/cpu-mmu.h
+++ b/target/loongarch/cpu-mmu.h
@@ -34,7 +34,7 @@ TLBRet get_physical_address(CPULoongArchState *env, MMUContext *context,
                             MMUAccessType access_type, int mmu_idx,
                             int is_debug);
 void get_dir_base_width(CPULoongArchState *env, uint64_t *dir_base,
-                               uint64_t *dir_width, target_ulong level);
+                        uint64_t *dir_width, unsigned int level);
 hwaddr loongarch_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
 
 #endif  /* LOONGARCH_CPU_MMU_H */
diff --git a/target/loongarch/tcg/helper.h b/target/loongarch/tcg/helper.h
index db57dbfc167..7e508c5a7b9 100644
--- a/target/loongarch/tcg/helper.h
+++ b/target/loongarch/tcg/helper.h
@@ -129,7 +129,7 @@ DEF_HELPER_2(invtlb_all_asid, void, env, tl)
 DEF_HELPER_3(invtlb_page_asid, void, env, tl, tl)
 DEF_HELPER_3(invtlb_page_asid_or_g, void, env, tl, tl)
 
-DEF_HELPER_4(lddir, tl, env, tl, tl, i32)
+DEF_HELPER_4(lddir, tl, env, tl, i32, i32)
 DEF_HELPER_4(ldpte, void, env, tl, tl, i32)
 DEF_HELPER_1(ertn, void, env)
 DEF_HELPER_1(idle, void, env)
diff --git a/target/loongarch/cpu_helper.c b/target/loongarch/cpu_helper.c
index 4a9db3ea4c1..867e7c88670 100644
--- a/target/loongarch/cpu_helper.c
+++ b/target/loongarch/cpu_helper.c
@@ -17,7 +17,7 @@
 #include "tcg/tcg_loongarch.h"
 
 void get_dir_base_width(CPULoongArchState *env, uint64_t *dir_base,
-                        uint64_t *dir_width, target_ulong level)
+                        uint64_t *dir_width, unsigned int level)
 {
     switch (level) {
     case 1:
diff --git a/target/loongarch/tcg/tlb_helper.c b/target/loongarch/tcg/tlb_helper.c
index f1d183cb641..e119f78d925 100644
--- a/target/loongarch/tcg/tlb_helper.c
+++ b/target/loongarch/tcg/tlb_helper.c
@@ -599,7 +599,7 @@ bool loongarch_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
 }
 
 target_ulong helper_lddir(CPULoongArchState *env, target_ulong base,
-                          target_ulong level, uint32_t mem_idx)
+                          uint32_t level, uint32_t mem_idx)
 {
     CPUState *cs = env_cpu(env);
     target_ulong badvaddr, index, phys;
@@ -607,7 +607,7 @@ target_ulong helper_lddir(CPULoongArchState *env, target_ulong base,
 
     if (unlikely((level == 0) || (level > 4))) {
         qemu_log_mask(LOG_GUEST_ERROR,
-                      "Attepted LDDIR with level %"PRId64"\n", level);
+                      "Attepted LDDIR with level %u\n", level);
         return base;
     }
 
diff --git a/target/loongarch/tcg/insn_trans/trans_privileged.c.inc b/target/loongarch/tcg/insn_trans/trans_privileged.c.inc
index a407ab51b74..64e53a44606 100644
--- a/target/loongarch/tcg/insn_trans/trans_privileged.c.inc
+++ b/target/loongarch/tcg/insn_trans/trans_privileged.c.inc
@@ -380,7 +380,7 @@ static bool trans_lddir(DisasContext *ctx, arg_lddir *a)
     if (check_plv(ctx)) {
         return false;
     }
-    gen_helper_lddir(dest, tcg_env, src, tcg_constant_tl(a->imm), mem_idx);
+    gen_helper_lddir(dest, tcg_env, src, tcg_constant_i32(a->imm), mem_idx);
     return true;
 }
 
-- 
2.51.0


