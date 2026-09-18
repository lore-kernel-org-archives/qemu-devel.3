Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CE8FC982D6
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 00:45:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7MiT-0008Iv-Ch; Thu, 17 Sep 2026 20:44:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1x7Mhb-0007a5-8K
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 20:43:45 -0400
Received: from mail-pj2-x10.google.com ([2607:f8b0:4864:39::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1x7MhY-0001gC-4E
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 20:43:43 -0400
Received: by mail-pj2-x10.google.com with SMTP id
 98e67ed59e1d1-398a147688bso228554a91.1
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 17:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789692219; x=1790297019; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Oq4JWXp3oz3ldmAG6qZLGf5kIk6ecRtfBN29V43kXo4=;
 b=P0BdiaivGFU5sz3oOYrIOqxG/Sgj9mMqKSdNrh2DeQ1XAZhaq6S7mxIsQPeqzSF0mR
 U/aGpHc3/0ujOMSjYoGTrS6moALCxo8TP0tC6oFS/fCWpl5TBtqevFKtkQcIuK/XgDF5
 XyZdJqbs9bSCOm6l3Yi4n1AF+tJjMsRV187P1tcwq0fglqwhGc6NjB2oQM29G/BEgor9
 YE9+VjXqTl3Ev/UQTQ9wa2MGSg5M1xmlZbBBaBtE8rJhN9oimkNGYWJwuzxledmGV1q4
 3PWijZ+V/PpVTIZe/ezdcRTagoEWf5RW0W/01utkUfAk5GGi7P4enA1DKFY2nle9DCRD
 0N1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789692219; x=1790297019;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Oq4JWXp3oz3ldmAG6qZLGf5kIk6ecRtfBN29V43kXo4=;
 b=r8JdfoE+0UfBGWqeA+erCEoSJblMLweyjZ1FOD8YCDgYVfTLhGQ54EwZk12wGlqaX2
 JDLB1cRpn2buh2kQ9lKIJI5+SD6SiMZ7UAsSbTRKAqMApFq8D+fZ1QTXPgqiRV/desCj
 qlhGpTTsk/hFrKRefh3Ez3CUyIAyluC0hz7RED/E7XxQ+ZZIVM+BaiDS0HO6WsKW854J
 uOY0E9VvnuJprew6bUerX4jl/byX1OH4s26coru1YwJQIi1K34YWYiaAD6UGiu60lmf/
 rb4CkeSacV0LjHA6XGRSL+KpyxfgeHnRALFpx63xwDi3P5jIJWuhKh+sGQqt/F7svueL
 BBRw==
X-Gm-Message-State: AFuF++k+KosTSsPxvq/9XsireoNpvLHHda94UYPQja4Y28MwfMOfQwik
 y2A4+46NQCxZvcrudmRAqXcxHnmWPXoOTtsLfvpz0qDlZn8he804jv0o7lAd7PHO6eU=
X-Gm-Gg: AYBFou34b8tfAEXAIyEEpmxNRHkkg8Ctk91buvvTx5E48sYWUgCVVRvoJDpkv+GD2Hy
 1oXKQMo09YuFfpUVz8kUqntywMqJT4W8j134FabQTuJi6swN8329fIsXpu3L4OA+WNJXapwbNft
 JddKL2MFS6tj/fClZNoiH7YnwIj04YmoRhj560DB6E3z09fxJ0MbQHoJX7d7fwvih0Z9v3Eqre2
 AmhMwZ+lD/Ro3ZrPr3Ax0yyyGNzHTklUrYdgVJLjc7XllAVdUAuPbt1675Osk9K6xop5GvQvkpI
 eXfrtUnZfq+8Afavhh4n/LH3tyIfyWi3Gg7Ei70R6gFJgUxGBdmOOKIzVKVz65N//Vo1c+ImGNb
 hZKNfpEKueIJEIfR5FXcQw5403sMaIysc37Q7WTwpAL2SIDl6TH9FG97Txi2FhoBdz6qGo6+HPI
 HNMOcr9/TYRYWIPmj3DNcIos2UaiaqNgtam7z5HphZ1fL1d8+gt395IauWjmLDALv0F4lhuiG40
 5Lee2D3tWhaABoBH3HtigKpxQHb52d7
X-Received: by 2002:a17:90b:224a:b0:39e:4c81:6c99 with SMTP id
 98e67ed59e1d1-39e54fa5deamr1676603a91.31.1789692218771; 
 Thu, 17 Sep 2026 17:43:38 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 a92af1059eb24-144cdfc3df2sm600286c88.5.2026.09.17.17.43.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 17:43:38 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Xianglai Li <lixianglai@loongson.cn>, qemu-s390x@nongnu.org,
 David Hildenbrand <david@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Nicholas Piggin <npiggin@gmail.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Stafford Horne <shorne@gmail.com>, Weiwei Li <liwei1518@gmail.com>,
 Cornelia Huck <cohuck@redhat.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Chinmay Rath <rathc@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>,
 Eric Farman <farman@linux.ibm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Michael Rolnik <mrolnik@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>,
 qemu-arm@nongnu.org, Bibo Mao <maobibo@loongson.cn>,
 Chao Liu <chao.liu@processmission.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Helge Deller <deller@gmx.de>,
 Glenn Miles <milesg@linux.ibm.com>, Zhao Liu <zhao1.liu@intel.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, qemu-riscv@nongnu.org,
 Song Gao <17746591750@163.com>, Matthew Rosato <mjrosato@linux.ibm.com>
Subject: [PATCH 07/21] target/or1k: convert exception to raise_excp
Date: Fri, 18 Sep 2026 08:42:09 +0800
Message-ID: <20260918004225.827-8-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <20260918004225.827-1-luoyonggang@gmail.com>
References: <20260918004225.827-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::10;
 envelope-from=luoyonggang@gmail.com; helo=mail-pj2-x10.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Translate through gen_helper_raise_excp with restore 0. Drop TCG
exception helper and exception.c. Keep C raise_exception as a
static inline in exception.h. Exit RANGE overflow through
cpu_loop_exit_excp.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 target/or1k/exception.c        | 31 -------------------------------
 target/or1k/exception.h        |  7 ++++++-
 target/or1k/exception_helper.c | 13 +------------
 target/or1k/helper.h           |  1 -
 target/or1k/meson.build        |  1 -
 target/or1k/translate.c        |  2 +-
 6 files changed, 8 insertions(+), 47 deletions(-)
 delete mode 100644 target/or1k/exception.c

diff --git a/target/or1k/exception.c b/target/or1k/exception.c
deleted file mode 100644
index 0479a069592..00000000000
--- a/target/or1k/exception.c
+++ /dev/null
@@ -1,31 +0,0 @@
-/*
- * OpenRISC exception.
- *
- * Copyright (c) 2011-2012 Jia Liu <proljc@gmail.com>
- *
- * This library is free software; you can redistribute it and/or
- * modify it under the terms of the GNU Lesser General Public
- * License as published by the Free Software Foundation; either
- * version 2.1 of the License, or (at your option) any later version.
- *
- * This library is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * Lesser General Public License for more details.
- *
- * You should have received a copy of the GNU Lesser General Public
- * License along with this library; if not, see <http://www.gnu.org/licenses/>.
- */
-
-#include "qemu/osdep.h"
-#include "accel/tcg/cpu-loop.h"
-#include "cpu.h"
-#include "exception.h"
-
-G_NORETURN void raise_exception(OpenRISCCPU *cpu, uint32_t excp)
-{
-    CPUState *cs = CPU(cpu);
-
-    cs->exception_index = excp;
-    cpu_loop_exit(cs);
-}
diff --git a/target/or1k/exception.h b/target/or1k/exception.h
index f62fc314c1f..a49a6c90f0d 100644
--- a/target/or1k/exception.h
+++ b/target/or1k/exception.h
@@ -21,7 +21,12 @@
 #define TARGET_OPENRISC_EXCEPTION_H
 
 #include "cpu.h"
+#include "accel/tcg/cpu-loop.h"
 
-G_NORETURN void raise_exception(OpenRISCCPU *cpu, uint32_t excp);
+static inline G_NORETURN
+void raise_exception(OpenRISCCPU *cpu, uint32_t excp)
+{
+    cpu_loop_exit_excp(CPU(cpu), excp, 0);
+}
 
 #endif /* TARGET_OPENRISC_EXCEPTION_H */
diff --git a/target/or1k/exception_helper.c b/target/or1k/exception_helper.c
index 3bd82b29719..c9b80093b25 100644
--- a/target/or1k/exception_helper.c
+++ b/target/or1k/exception_helper.c
@@ -21,22 +21,11 @@
 #include "cpu.h"
 #include "accel/tcg/cpu-loop.h"
 #include "exec/helper-proto.h"
-#include "exception.h"
-
-void HELPER(exception)(CPUOpenRISCState *env, uint32_t excp)
-{
-    OpenRISCCPU *cpu = env_archcpu(env);
-
-    raise_exception(cpu, excp);
-}
 
 static G_NORETURN
 void do_range(CPUOpenRISCState *env, uintptr_t pc)
 {
-    CPUState *cs = env_cpu(env);
-
-    cs->exception_index = EXCP_RANGE;
-    cpu_loop_exit_restore(cs, pc);
+    cpu_loop_exit_excp(env_cpu(env), EXCP_RANGE, pc);
 }
 
 void HELPER(ove_cy)(CPUOpenRISCState *env)
diff --git a/target/or1k/helper.h b/target/or1k/helper.h
index e0a8d402271..d6e6bd4ffbc 100644
--- a/target/or1k/helper.h
+++ b/target/or1k/helper.h
@@ -18,7 +18,6 @@
  */
 
 /* exception */
-DEF_HELPER_FLAGS_2(exception, TCG_CALL_NO_WG, void, env, i32)
 DEF_HELPER_FLAGS_1(ove_cy, TCG_CALL_NO_WG, void, env)
 DEF_HELPER_FLAGS_1(ove_ov, TCG_CALL_NO_WG, void, env)
 DEF_HELPER_FLAGS_1(ove_cyov, TCG_CALL_NO_WG, void, env)
diff --git a/target/or1k/meson.build b/target/or1k/meson.build
index 7cea45287a2..dba5044b655 100644
--- a/target/or1k/meson.build
+++ b/target/or1k/meson.build
@@ -5,7 +5,6 @@ or1k_ss.add(gen)
 or1k_ss.add(files(
   'cpu.c',
   'disas.c',
-  'exception.c',
   'exception_helper.c',
   'fpu_helper.c',
   'interrupt_helper.c',
diff --git a/target/or1k/translate.c b/target/or1k/translate.c
index eb4485312f2..44b408b56cd 100644
--- a/target/or1k/translate.c
+++ b/target/or1k/translate.c
@@ -140,7 +140,7 @@ void openrisc_translate_init(void)
 
 static void gen_exception(DisasContext *dc, unsigned int excp)
 {
-    gen_helper_exception(tcg_env, tcg_constant_i32(excp));
+    gen_helper_raise_excp(tcg_env, tcg_constant_i32(excp), tcg_constant_i32(0));
 }
 
 static void gen_illegal_exception(DisasContext *dc)
-- 
2.52.0.windows.1


