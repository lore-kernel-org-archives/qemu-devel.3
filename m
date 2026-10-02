Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29C15CA5FDD
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 17:58:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xChUh-00016a-9n; Fri, 02 Oct 2026 13:56:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xChRO-00057Y-SL
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 13:53:03 -0400
Received: from mail-dy2-x0d.google.com ([2607:f8b0:4864:36::d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xChRB-0007Yl-G0
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 13:52:51 -0400
Received: by mail-dy2-x0d.google.com with SMTP id
 5a478bee46e88-34bcb929cceso2698409eec.0
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2026 10:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790963558; x=1791568358; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=C60WimnL9SSW7LAxTDiiRt6rrJtccQkGf4ZasbM1n6Q=;
 b=VVW+CxTm2dW7C60OpiOuQElo9whgO3Jgp/bu2x6+mbTjUcFLU1tv2rqCdB1keoc6Cp
 IOte1oDRQZNXCr/UdW+fvP4/yXP0+cY31/AbV+5KSS46ZZz9jlpWB8vUI/UFoqP/sfLo
 Cm4REO9HgHsNFt1sPod7v3eok++Gt6kATnQ8BoTXLZAsoufIzEOyVsnZ3ed1RY8LZlAN
 AOcNFmIuFYeQ89WQGe80eUoHGWvYAsqx1HL0gh7mooVR6m52W8ghbMpad3Ww4o+28eDC
 np9si8MjkVDiTB4DYV9nYVJfO41LkyXU0bHI1RMhj3kCmCV0D+iCVWihrBuSK5XFlu6o
 HQhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790963558; x=1791568358;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=C60WimnL9SSW7LAxTDiiRt6rrJtccQkGf4ZasbM1n6Q=;
 b=H8kjlQiDKAyR4X35YD8KCydjUK9LQLBxqY9oAi5l+TTKanR/pWrP5XTHvQqkRfmA4H
 6IY/LEKSUGB6ZLm5SlIy9v84RIDUPbA/SCAmGUIWW0DssMWbCBswDeN6iJ4kdhMuGBiT
 ak72JWb+/DgpN363if2lChgsHeUQ5so3Bqzq9Fl6iFvSCsVSNyiIwvqRvChCo6y51oIA
 bnxMxLCeJjALe1ipD0zEKbNjRsS+OZr7hOoPo+BuByZxdKKk5InXX33Cb22aIqsgPtK+
 h+p58edvBjLCBDoUxObzvjGBdclSM/53n5c3MrNTNKQRaTggAit8ryGt1Dz5L/n20U5N
 czVw==
X-Gm-Message-State: AFq9FYKQVHOi4eSZ8PK/EK89oe8/tlN1D7Zf0fwC/ESiuOSL+AITmw59
 xV5FG/H4WJzssf7zjpqPr3XtW04l493mgpS/Ew1S8xUw4+ffwc43p+jEcTbLQ6wEvWI=
X-Gm-Gg: AYBFou38pBmTZDh+2+IMoQGIYyuGqu77byChjR7n4b7l/7I36JqBtP76Yl8BYtorDqN
 +TOTzsc8Cc9UMDlkl1T+7qMQAY25BAkx7WjEUlCaWzvvE8+sKcgdSdb87Su3Uartzfz1qJR/0bH
 OTphIKHojIc28FImuN10P+QezFm6W7NUpC0uq170u7c8izU/3b9Ou4yRBcYnZDboXeAk41rZEbU
 S41466H1YDTNJw0Bsp9F2qcPsbphUaA2ycYGw+/6S3gfjbgLrwgOoHC8+3e+Nxqs7MdFbu6sWKP
 6QRWRRkfa+iHyoAvIHzRpm2kuMXVxQz6wE577eCfsfyKMLk/++Z5oauTe9khXDGGGC01lTEGcxc
 UjPAG25xZ2BLbei66HOwo+QVgmZ6c4VIeoz4LBBT+/syuFkvdxsVblS4WWAZEU4IjEhE0+jIPQy
 xgNOs3FWFVfxtnQ7hMlbFU2D10nSsjh88Ca13eWPHiXzKnMNgacFy/Qb2Vx9uK7DxIn7GGRuWjq
 fS+EQgzjehG3T977Xc80dE+GPqUTpk=
X-Received: by 2002:a05:693c:4154:20b0:351:853:54a4 with SMTP id
 5a478bee46e88-35108535aa9mr2020614eec.33.1790963557732; 
 Fri, 02 Oct 2026 10:52:37 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 5a478bee46e88-34f14f9f2afsm18027361eec.18.2026.10.02.10.52.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 10:52:37 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Max Filippov <jcmvbkbc@gmail.com>, Stafford Horne <shorne@gmail.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Eric Farman <farman@linux.ibm.com>, Song Gao <17746591750@163.com>,
 qemu-riscv@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, qemu-s390x@nongnu.org,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Michael Rolnik <mrolnik@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, Cornelia Huck <cohuck@redhat.com>,
 Helge Deller <deller@gmx.de>, Chinmay Rath <rathc@linux.ibm.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-ppc@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Chao Liu <chao.liu@processmission.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@kernel.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Weiwei Li <liwei1518@gmail.com>, Yoshinori Sato <yoshinori.sato@nifty.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Laurent Vivier <laurent@vivier.eu>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Glenn Miles <milesg@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v3 14/27] target/or1k: convert exception to raise_excp
Date: Sat,  3 Oct 2026 01:50:22 +0800
Message-ID: <20261002175037.1747-15-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <20261002175037.1747-1-luoyonggang@gmail.com>
References: <20261002175037.1747-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:36::d;
 envelope-from=luoyonggang@gmail.com; helo=mail-dy2-x0d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Use the shared raise_excp helper for translated exceptions. Use
cpu_raise_excp_restore() for overflow helpers with GETPC() and
cpu_raise_excp() for the zero-PC C wrapper.

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
index f62fc314c1f..a206816d4d7 100644
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
+    cpu_raise_excp(CPU(cpu), excp);
+}
 
 #endif /* TARGET_OPENRISC_EXCEPTION_H */
diff --git a/target/or1k/exception_helper.c b/target/or1k/exception_helper.c
index 3bd82b29719..113012439c8 100644
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
+    cpu_raise_excp_restore(env_cpu(env), EXCP_RANGE, pc);
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
index e00ef45b9b7..243a8eede23 100644
--- a/target/or1k/translate.c
+++ b/target/or1k/translate.c
@@ -140,7 +140,7 @@ void openrisc_translate_init(void)
 
 static void gen_exception(DisasContext *dc, unsigned int excp)
 {
-    gen_helper_exception(tcg_env, tcg_constant_i32(excp));
+    gen_helper_raise_excp(tcg_env, tcg_constant_i32(excp));
 }
 
 static void gen_illegal_exception(DisasContext *dc)
-- 
2.52.0.windows.1


