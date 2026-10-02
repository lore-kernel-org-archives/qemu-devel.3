Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE497CA5FC4
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 17:55:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xChPd-0003jr-6K; Fri, 02 Oct 2026 13:51:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xChPV-0003gM-7K
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 13:51:06 -0400
Received: from mail-dy1-x1335.google.com ([2607:f8b0:4864:20::1335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xChPR-0007He-BP
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 13:51:04 -0400
Received: by mail-dy1-x1335.google.com with SMTP id
 5a478bee46e88-34bb8b31647so242637eec.0
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2026 10:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790963458; x=1791568258; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=D+6+qn+yh1OD1CvirI1XQx+kYJP3uEKSWNOVrm/1f1s=;
 b=DIYuJAQOtA5cbT8MtlSYXuKjmHVmeW3gXJJLeFZNVwBPNaQOeZe9feYkivA3Icbd5/
 DmV+RDDKWo1fJ4ll41Mh5yx2uj0oVfWy7goy0TsbLZcQ+udutz/eMzS33DkOvEOcHhhx
 SDrU1ih9kDv3uw7KCwvybJth5ijzhHvR2rHMOjz07p+MnxKU/yt8jUIqUV2tNPzFT3Ba
 hVWd0rbgZ7j/VmJZtoQ0HcEMVMjp3kKzZdnqfC7f/O4kFw87NKgcsGTzC1Idk5qAnErb
 /ECmYjbJmrpGKRICi68PjTO6jRzSWFaJm7k7QQJE5TfcHRgraIq22J5wevL7CQefkR2y
 xXTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790963458; x=1791568258;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=D+6+qn+yh1OD1CvirI1XQx+kYJP3uEKSWNOVrm/1f1s=;
 b=hO/krWhTwwtQ0f0g6tpf4URNUF5mRB4CkNZtke4ZSjpywjQKafhCpT7c+ePoyTBCQL
 r+M2kA759A2LmolvnU16v5CqU8g+nlb34wT1pgSucMwmdiPxjy3oLGDQSK3r3jnqz2av
 PyrpY+jayRib2KfoQmcvbH5ps8r7QdkAkYT/2Kkgxt+lbVxhNmSlJi9QudC34u24xHk9
 FjL4D0AeQR0vXCPOC/uITiyDiinNXdDgQ9bScYidevv2e8VM51rfRaeogJiWKQVQyzsZ
 GdMRkaMEdm8+ugy5IwxtSOF+zoomOdfRQza4s4VTY8oX0Xk+BhJD2xH1sm60wboz648F
 +rqQ==
X-Gm-Message-State: AFq9FYJQogfpUVBeHEFbFKKgtz2PS6wsHTTdFmO0wIG0RKsE/nSR8682
 N7Fy+hLnk0jeJ9QoX02mPK+K3pX09t78ypkTfLtbEXKyktSCwUVe9PUihZc+VDbU8F8=
X-Gm-Gg: AYBFou1OyS4XrTDkzXJCpe5VPzyzXGlWLS3y+sXtLWOoCYl4N6Awx7BdY/n8910eq/4
 /MWRXxb9cRSsTdwadX2nBeTukX3O1evOqRGZnFPn5Ih//fssYpSJCQE81tTFD3DsxxQTc9cUKcT
 qJP/Q38WucL6tXMDqwVX7KZM3SXx4yLbZLC+7hw42f81UwMXL064Daf8q5aOK38N75NZAWR/i4a
 jaVCIFuaxsm48JkVX/a/c6yRLuwZ/G/TBITFy1ZCkBY5BfEW+ywPw76p8SUIRFhCkPAHmouQVkj
 hD52bggWumHc+oLyUAp21BNW23f1iE3nRdPldlT7AsVDnWcBOs95P7KRTIvUQ/dY1maY8Or7Jwa
 tnjitsw5Ue8musNLJ2Vg1XCtFp45P3+8nsej92a/MoVfEQpS04KL0b+998pn+/trI94L49flm/5
 sFPQxOL1KzYK+1nGtH0cMpQ46hgjFjBFk9U0YL3Z5d1f9oBz3W9QP5Ml1X2UvQKfoSHLpoQIo84
 amKuow+eT06EJgTGwADRfdNJqX6vPo=
X-Received: by 2002:a05:7300:8248:b0:34b:f031:be93 with SMTP id
 5a478bee46e88-35111502821mr391268eec.31.1790963457884; 
 Fri, 02 Oct 2026 10:50:57 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 5a478bee46e88-34f14f9f2afsm18027361eec.18.2026.10.02.10.50.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 10:50:56 -0700 (PDT)
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
Subject: [PATCH v3 01/27] accel/tcg: move helper_exit_atomic next to
 cpu_loop_exit_atomic
Date: Sat,  3 Oct 2026 01:50:09 +0800
Message-ID: <20261002175037.1747-2-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <20261002175037.1747-1-luoyonggang@gmail.com>
References: <20261002175037.1747-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1335;
 envelope-from=luoyonggang@gmail.com; helo=mail-dy1-x1335.google.com
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

helper_exit_atomic only forwards to cpu_loop_exit_atomic. Define it
in cpu-exec-common.c with that function, and move its DEF_HELPER line
to cpu-exec-common.h. That file emits helper_info_exit_atomic.
tcg-runtime.c keeps the integer helpers.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 accel/tcg/cpu-exec-common.c        | 10 ++++++++++
 accel/tcg/cpu-exec-common.h        |  2 ++
 accel/tcg/tcg-runtime.c            |  8 --------
 accel/tcg/tcg-runtime.h            |  2 --
 include/exec/helper-gen-common.h   |  4 ++++
 include/exec/helper-proto-common.h |  4 ++++
 6 files changed, 20 insertions(+), 10 deletions(-)
 create mode 100644 accel/tcg/cpu-exec-common.h

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


