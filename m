Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A943C98328
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Sep 2026 07:09:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAMRT-0004k8-TE; Sat, 26 Sep 2026 03:03:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xAMQu-0003ON-3d
 for qemu-devel@nongnu.org; Sat, 26 Sep 2026 03:02:52 -0400
Received: from mail-dy2-x0e.google.com ([2607:f8b0:4864:36::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xAMQr-0000Z7-HT
 for qemu-devel@nongnu.org; Sat, 26 Sep 2026 03:02:51 -0400
Received: by mail-dy2-x0e.google.com with SMTP id
 5a478bee46e88-341d0522b4dso1977550eec.1
 for <qemu-devel@nongnu.org>; Sat, 26 Sep 2026 00:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790406168; x=1791010968; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=13Vpk3slAVMN43yepfwDbpWXacf+qhSBumghvgGIwSM=;
 b=aImukoiPsd8QaqmSkWQ8Yfx04QlyvcSSqJHERoKN5XRz/BGoD7ssnv45JxxdmZ3gv/
 PljWNuUEJx22pJ4nJU/gUqvc0/61R/NE7jj9ofrMD3XQxrU3Mrd8CYl7bvn54FlDPJ7n
 9D6YXwPvncd7qpIbGSXmtpsB9KkRhmETSXgPZ01QawlufcQXk7xey4KIRxxr2bjsWIp3
 ukZ9AuA+onhKBJc2bvqngyYeQnGzkpTC64mqwxBMNglszEjX3fvHUGsXi9ZZPQsfyFBB
 76DOFtpJ9OVsoWFIBRtMMqko5pE0qQeDGuJvmFwUXnUhINDGviAm7iK29iRnUgRAaRXz
 wSFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790406168; x=1791010968;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=13Vpk3slAVMN43yepfwDbpWXacf+qhSBumghvgGIwSM=;
 b=drvWbxuow+BHie20yxTuKfNhN/GnuvyQoszXJR0yky/Jm+CKuuiocKxa45hhHDUmsm
 tqXYAhmdd+eHgKGM9LQRP+13yxLJEuERY7/RjqjAv4zDATWD/O54RY2+P+3v0TyWbadU
 YsEHg4M75aBkQ/+3lAMfSLhwLioeHzjiUWi4jEUiA6OwCEMELMz7a+q91+lUtky2tdqk
 Da5YLCmiQl+XTOA0u659mUedt7bgItXv/IDa2MtfvGhqtPnmJyyrp0xECP1at+7+BwSr
 wX9F4f8+mg9jzGT+Xm2kB40CztcbPvABMt6YLpBSltTqOHlU+/R+INk/9MvCianqTbmR
 sUQg==
X-Gm-Message-State: AFuF++nFN4gU/riOxOnIC2L4FuW4LUy4Pds299Uld5dzD4Uo/YFGb8Hw
 qyt9PMJLDPVhGUa1Z8vywNKaH1j5aLivBcejnP0qdKKR0G3D/fNjlYlCfqHDscxr
X-Gm-Gg: AYBFou2yNlrLqt6B3cDZhHUxDFv8Cweq5/8KNkldryjYPZzDYKFQ1uSeJk9tkX+rLvR
 YHucfj8B3JPh3yf8gjqTyFV9YSdyKS1RfWpeEkHF97dgoLsOR0DG7bFco9/FNbJ4ZyB2ULohe2u
 XVf7D9Xu4Vwa4cyFmVXMLWTENlU2fRVWJvxKb5U2S2+76yo8pFlyiNAF1Ub1vgBD4bQMzZYi4cy
 fU6oOV15Ak8OEjo+TWH6NBf48MjgoG/tBVyyIxd7xj6Bq8Z6EKwqa5vNKEELxG/fJbP6PJG5KKn
 iUCxmr6tWBG7bfCGWrabQmMzt3+iPxPvO142dD0gFIWJDyHNe2MiZ5GFDkEEqToQAhnhgJTkbZc
 q/88STWCKVCjsIOvRFOUPoDeKhShjZTkTEEFBGnfpHcAGXSYarMdRpRaWHcyptLluYI41x8cR4F
 miFzXyaNec1CDaYkRQr06doqlREh66FfcvC2biDzxfLX7pq/yhMb8wFGs23qR3dyTbmOQaku5jQ
 z+tTzmR2/PTCTuTE/h9j9xmMDo9Q6w=
X-Received: by 2002:a05:7300:ae0f:b0:33b:eadd:9013 with SMTP id
 5a478bee46e88-342705b9cb5mr2029096eec.6.1790406168140; 
 Sat, 26 Sep 2026 00:02:48 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 5a478bee46e88-34145c166cfsm10615141eec.28.2026.09.26.00.02.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 26 Sep 2026 00:02:47 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-arm@nongnu.org, kvm@vger.kernel.org
Subject: [PATCH v4 26/55] accel/tcg: move helper_exit_atomic next to
 cpu_loop_exit_atomic
Date: Sat, 26 Sep 2026 15:00:25 +0800
Message-ID: <20260926070057.1234-27-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <20260926070057.1234-1-luoyonggang@gmail.com>
References: <20260926070057.1234-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:36::e;
 envelope-from=luoyonggang@gmail.com; helo=mail-dy2-x0e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 accel/tcg/cpu-exec-common.h        |  1 +
 accel/tcg/tcg-runtime.c            |  8 --------
 accel/tcg/tcg-runtime.h            |  2 --
 include/exec/helper-gen-common.h   |  4 ++++
 include/exec/helper-proto-common.h |  4 ++++
 6 files changed, 19 insertions(+), 10 deletions(-)
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
index 00000000000..922acc2179d
--- /dev/null
+++ b/accel/tcg/cpu-exec-common.h
@@ -0,0 +1 @@
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


