Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46934C9833E
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 05:23:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xB3ni-0003Jo-LQ; Mon, 28 Sep 2026 01:21:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xB3ng-0003Ic-OD
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 01:21:16 -0400
Received: from mail-dl2-x0d.google.com ([2607:f8b0:4864:38::d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xB3nd-0007kp-CH
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 01:21:16 -0400
Received: by mail-dl2-x0d.google.com with SMTP id
 a92af1059eb24-148b5c829e8so740866c88.0
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 22:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790572872; x=1791177672; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VkeT4VEb7dbNZHrc7V8wy1qO12OU0ezx6Qp6yR7AiHI=;
 b=VhAPNbN+znXDwO1tvq92aK/J8rCuGDGzyjBniQIF9BfanNGBdJjxoMduc9Uu1lS3Gn
 5Rh7ETWBMxmOj0zlFdQ0rTjrwt2l1HSumZHqmVCn4GdiU252wgx9hiJoydsQuyJWRXn9
 1vJ1eNo51plBsAY7/0I/Q78v2AEV1RcVEFgKm94rMoaJGaiuPYgPwmjXv8zUrUZdUDe0
 3yX7QmpfAVDkFM06BhWgIxU0iCcvCURGsWD1t2FvqeI1To6kqOMzmEoymHfObmLxoaki
 awPTCFZERkgSZkgVdyT/h6XcZzes8NDMY8LvqHVKtIQ+UuzE4yrvg/PNzgqwOpSMmJp3
 rFyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790572872; x=1791177672;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=VkeT4VEb7dbNZHrc7V8wy1qO12OU0ezx6Qp6yR7AiHI=;
 b=HDTZld6NhvThVTncaPgwJwptPfAb2YFCfs2T6js19b+yZLY/WMN8tv1ImeRYrgE4Ul
 Z3sXyKqlo+Ird3MRBQFl3c2q5qTTMrvyv6p5O+Qzf9CX4Z6qKWzjMr+V31+fa3HV3IIi
 ykNzquOmF8SGEr/G6IaeBP4yLUHzFmcDDXdEoteTkuPP9nBONV02k0YrBm5Ym8V3LUb+
 vQYQTDrWXfo2yIdZrN47nPQ8FP2vJZC8K1iEE/aj1PWyGCrBmoicMpwZgZsh764Xa9Xf
 k58L0qjb893VBg0Yhc/vlY6tnIjyHRicMbzqoB+HWyXBwRf+w2Yd6wls28Wvy6HfN9UD
 dj9g==
X-Gm-Message-State: AFuF++kwPMuStuEbovbpON19DooG7hSfmE/9Ff8wJDpIxcn77QOAJunW
 AFl1T5Hvfz4FQnk0YnzHtzjBL347vIxd3fVeirJjIucssFWJXzldc+VdAfguFE8EPn4=
X-Gm-Gg: AYBFou0AcImmHskdX8n/MhLP7MCZgYm14KyAEoLfirEyEq+5bmaj7KRwq7KgTcIrAfK
 HqCVa+3/4Uhogi4/l2GRoxAzb7N0TOiXnZ86t7dD+g59paaPewnAFwORc8RVCHrQrrYcgc1U69s
 sHBs7M32xph8GD3UT46qlJ6kR3+LGAdWmyq7Agk5P6bvPToPWF9z79bpTgK0WZVP9uPsQG26pdM
 2D1/b00BNzQTT6gOoSH4wbBxNL78Vh9LF6BG8kSGlFJ4JhShoF9XmYmsmwL+y1LoO9Bx/+ho3cM
 /f2c5BiV9mL6/VuyDjhD2czX+Yn/MLUA+nHROWAq3muxWtuZ3cmrKcDxtjeopf7CLsj8P7z7BJ6
 +QkGS2aHZirUq4hNJwb6L6xIy2uBMEc3qL1SzyL8o6pwtNue1ImDZ1V566In1WAVl4RnjKzfbQx
 tDZ+nYldUSTaDfDVzO6OWTMuN2FjFvpW2eF/IR2st7fPBH8vjpYW49hGu7VgaajPRfSGzmOJBXO
 Vzu1z4ULRDTQ8CPCRur7XCtzLr2BIY=
X-Received: by 2002:a05:7022:6881:b0:139:b575:d42f with SMTP id
 a92af1059eb24-146ce39a169mr13894870c88.17.1790572871683; 
 Sun, 27 Sep 2026 22:21:11 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 a92af1059eb24-146bb6551d9sm14726248c88.9.2026.09.27.22.21.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Sep 2026 22:21:10 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Weiwei Li <liwei1518@gmail.com>, Brian Cain <brian.cain@oss.qualcomm.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Chao Liu <chao.liu@processmission.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Stafford Horne <shorne@gmail.com>, Chinmay Rath <rathc@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Eric Farman <farman@linux.ibm.com>, qemu-riscv@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@kernel.org>, Glenn Miles <milesg@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Song Gao <17746591750@163.com>, qemu-ppc@nongnu.org, qemu-arm@nongnu.org,
 Michael Rolnik <mrolnik@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-s390x@nongnu.org
Subject: [PATCH v2 01/24] accel/tcg: move helper_exit_atomic next to
 cpu_loop_exit_atomic
Date: Mon, 28 Sep 2026 13:20:27 +0800
Message-ID: <20260928052051.251-2-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <20260928052051.251-1-luoyonggang@gmail.com>
References: <20260928052051.251-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:38::d;
 envelope-from=luoyonggang@gmail.com; helo=mail-dl2-x0d.google.com
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

helper_exit_atomic only forwards to cpu_loop_exit_atomic. Define it
in cpu-exec-common.c with that function, and move its DEF_HELPER line
to cpu-exec-common.h. That file emits helper_info_exit_atomic.
tcg-runtime.c keeps the integer helpers.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 MAINTAINERS                        |  1 +
 accel/tcg/cpu-exec-common.c        | 10 ++++++++++
 accel/tcg/cpu-exec-common.h        |  2 ++
 accel/tcg/tcg-runtime.c            |  8 --------
 accel/tcg/tcg-runtime.h            |  2 --
 include/exec/helper-gen-common.h   |  4 ++++
 include/exec/helper-proto-common.h |  4 ++++
 7 files changed, 21 insertions(+), 10 deletions(-)
 create mode 100644 accel/tcg/cpu-exec-common.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 1b66c65f689..7fa78a9bd74 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -174,6 +174,7 @@ F: system/watchpoint.c
 F: page-vary-system.c
 F: page-vary-common.c
 F: accel/tcg/
+F: accel/tcg/cpu-exec-common.h
 F: accel/stubs/tcg-stub.c
 F: util/cacheflush.c
 F: scripts/decodetree.py
diff --git a/accel/tcg/cpu-exec-common.c b/accel/tcg/cpu-exec-common.c
index 68077c8fd9d..d20cece1c5f 100644
--- a/accel/tcg/cpu-exec-common.c
+++ b/accel/tcg/cpu-exec-common.c
@@ -23,8 +23,13 @@
 #include "qemu/plugin.h"
 #include "qemu/main-loop.h"
 #include "accel/tcg/cpu-loop.h"
+#include "exec/helper-proto-common.h"
 #include "internal-common.h"
 
+#define HELPER_H "accel/tcg/cpu-exec-common.h"
+#include "exec/helper-info.c.inc"
+#undef  HELPER_H
+
 bool tcg_allowed;
 
 /*
@@ -120,3 +125,8 @@ void cpu_loop_exit_atomic(CPUState *cpu, uintptr_t pc)
     cpu->exception_index = EXCP_ATOMIC;
     cpu_loop_exit_restore(cpu, pc);
 }
+
+void HELPER(exit_atomic)(CPUArchState *env)
+{
+    cpu_loop_exit_atomic(env_cpu(env), GETPC());
+}
diff --git a/accel/tcg/cpu-exec-common.h b/accel/tcg/cpu-exec-common.h
new file mode 100644
index 00000000000..19359a97bae
--- /dev/null
+++ b/accel/tcg/cpu-exec-common.h
@@ -0,0 +1,2 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+DEF_HELPER_FLAGS_1(exit_atomic, TCG_CALL_NO_WG, noreturn, env)
diff --git a/accel/tcg/tcg-runtime.c b/accel/tcg/tcg-runtime.c
index 7c0aab98a80..764c62c684d 100644
--- a/accel/tcg/tcg-runtime.c
+++ b/accel/tcg/tcg-runtime.c
@@ -23,10 +23,7 @@
  */
 #include "qemu/osdep.h"
 #include "qemu/host-utils.h"
-#include "exec/cpu-common.h"
 #include "exec/helper-proto-common.h"
-#include "accel/tcg/cpu-loop.h"
-#include "accel/tcg/getpc.h"
 
 #define HELPER_H  "accel/tcg/tcg-runtime.h"
 #include "exec/helper-info.c.inc"
@@ -129,8 +126,3 @@ uint64_t HELPER(ctpop_i64)(uint64_t arg)
 {
     return ctpop64(arg);
 }
-
-void HELPER(exit_atomic)(CPUArchState *env)
-{
-    cpu_loop_exit_atomic(env_cpu(env), GETPC());
-}
diff --git a/accel/tcg/tcg-runtime.h b/accel/tcg/tcg-runtime.h
index 0b832176b33..9b4c1c24916 100644
--- a/accel/tcg/tcg-runtime.h
+++ b/accel/tcg/tcg-runtime.h
@@ -22,8 +22,6 @@ DEF_HELPER_FLAGS_1(ctpop_i64, TCG_CALL_NO_RWG_SE, i64, i64)
 
 DEF_HELPER_FLAGS_1(lookup_tb_ptr, TCG_CALL_NO_WG_SE, cptr, env)
 
-DEF_HELPER_FLAGS_1(exit_atomic, TCG_CALL_NO_WG, noreturn, env)
-
 #ifndef IN_HELPER_PROTO
 /*
  * Pass calls to memset directly to libc, without a thunk in qemu.
diff --git a/include/exec/helper-gen-common.h b/include/exec/helper-gen-common.h
index 834590dc4e5..ed5521ad881 100644
--- a/include/exec/helper-gen-common.h
+++ b/include/exec/helper-gen-common.h
@@ -7,6 +7,10 @@
 #ifndef HELPER_GEN_COMMON_H
 #define HELPER_GEN_COMMON_H
 
+#define HELPER_H "accel/tcg/cpu-exec-common.h"
+#include "exec/helper-gen.h.inc"
+#undef  HELPER_H
+
 #define HELPER_H "accel/tcg/tcg-runtime.h"
 #include "exec/helper-gen.h.inc"
 #undef  HELPER_H
diff --git a/include/exec/helper-proto-common.h b/include/exec/helper-proto-common.h
index 76e6c25becb..28afa7782d0 100644
--- a/include/exec/helper-proto-common.h
+++ b/include/exec/helper-proto-common.h
@@ -9,6 +9,10 @@
 
 #include "qemu/atomic128.h"  /* for HAVE_CMPXCHG128 */
 
+#define HELPER_H "accel/tcg/cpu-exec-common.h"
+#include "exec/helper-proto.h.inc"
+#undef  HELPER_H
+
 #define HELPER_H "accel/tcg/tcg-runtime.h"
 #include "exec/helper-proto.h.inc"
 #undef  HELPER_H
-- 
2.52.0.windows.1


