Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E366CA5FE2
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 17:55:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xChRQ-00057O-AX; Fri, 02 Oct 2026 13:53:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xChQD-00049S-RD
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 13:51:52 -0400
Received: from mail-dy1-x132d.google.com ([2607:f8b0:4864:20::132d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xChQA-0007O6-CL
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 13:51:49 -0400
Received: by mail-dy1-x132d.google.com with SMTP id
 5a478bee46e88-32efd24b2aeso427997eec.1
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2026 10:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790963505; x=1791568305; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=X726aYrpD9juLsEOlPI9NMDBbZTvlx2zMhvFSPMsy/w=;
 b=XZ1y4xlE4kyR5EcYbgz5XkvXt5TxzodGuC5shAu2wvmD1bANicJxXzlWitWHhAcY7z
 tPZTnAW9gny5QetzGJV1zMe1OTcXbkG1dGdJwhNAeKmcrTJzkdSrq4o6FRj0pyvW5zMh
 O0J3k9meHpM5MVa88mOqdHk+bXUTLspciU+te03Ty9PyEoMO418/lkCyQp4nYXAOm7Ev
 QTuT3KsCXYd+rOFDXPhaSuabgoKsJJiLhUrlPRQCc77CcwYf5bTDJ+D2RqLJtGLTQOmt
 XVoRbMrR6zNsh9u2WNITUzo9bBy26VbIr39xMvkcpc4wIUmVT6SIhbHUZmYXtIvqFQx1
 Y7Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790963505; x=1791568305;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=X726aYrpD9juLsEOlPI9NMDBbZTvlx2zMhvFSPMsy/w=;
 b=TLQ52/xGHC5ZRmmHb8uJvLcpj+zEFh/fOkpqR5lEPpl0MekLOT4g85/jUM/AH5u9ju
 PJDlVlGhWdK0FaYbZQMr+CqpPvMzk4BfFhnt1d28THi/P8wPhYBKTTRkkpHE6KmYjpdp
 50zqOXJhitPLnAUh7GJL1jahXZ4B1b/0zpXboGH1PKPlvNgmjPAWab5o6mFz0ILYLl7/
 L/4cLe4PKtJ7OkndLubKOY9Fa3PU2bUTT/ZQGrUDS5VlvC0v5K9/v2WjnLMZ42lFdUh5
 7alWhHZFDAy62jnr6J7XHanNtN+rWKhBMoUiy/AlkxRPDjQzQB0AtJe7JElEEYtIIiYp
 M5fg==
X-Gm-Message-State: AFq9FYLpKzT6kYH/IVqe0T6+Qrq7YCl9jvvsxRA4ClqcbeaUVeq7BJMO
 fh5WALCwJk3RZ0Hdh6nA98wuIgtSY0cHWCyUHDmyZwTf9JOiAYnXPtzCnKkhilPD4zE=
X-Gm-Gg: AYBFou0a+HwG2OWJOTuzGJjcdsrXX8Jqlo8CWyoYfWiIXVSkKdkNrg+I9g+jOzFXGMo
 qIa9WEBt2bve3t77IPDW/m6N5OqRCPDoOXA8n22wGv4yNeIEjY5BLlOWJTraOzUwmYFZ7vdO0Ph
 IuFUqovMobft5T2yTrbO4b9jLmscvLLX7NKy35Ie9FWm4fK1uCt6hFMuWNciqZ+0HRYN1wQ9nYx
 S0Dr7IXpQF9FHAqW1bdjbMKJ09upzDbNJs5KhctNXRYEteeIxlpXK1yez7mz+lMkK03gzRLEZhs
 XCdynKjYZTp19r1XrEeV4eoBkFqs2lxA83bRKQOAyzwF1sXv1zP29C2qMUmTdLMRwle0JW/EbMe
 /n+UIi1UfJxhD+QsfEchHMm3i2eFS/0rdsirZRIv3IOTY+R2j2qAjxp4O2HXVwhisK73NbL/DQ1
 mQhTPWDV8X5IW7kdWwYHcZ0vwMFOcqjaHFgLWFKxFZWnzZ4AF+z/jh9VQ7zuF/96D/EITUS7Iy4
 bkfBGL9mf/1YpgGAyhd8/k/Mb8dN0KN
X-Received: by 2002:a05:7301:4b10:b0:34b:c18d:c294 with SMTP id
 5a478bee46e88-35111487d92mr347738eec.24.1790963504764; 
 Fri, 02 Oct 2026 10:51:44 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 5a478bee46e88-34f14f9f2afsm18027361eec.18.2026.10.02.10.51.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 10:51:44 -0700 (PDT)
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
Subject: [PATCH v3 07/27] target/hppa: remove helper_excp
Date: Sat,  3 Oct 2026 01:50:15 +0800
Message-ID: <20261002175037.1747-8-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <20261002175037.1747-1-luoyonggang@gmail.com>
References: <20261002175037.1747-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::132d;
 envelope-from=luoyonggang@gmail.com; helo=mail-dy1-x132d.google.com
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

Use the common raise_excp helper for translated exceptions and route
the remaining C callers through cpu_raise_excp().

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 target/hppa/helper.h     |  2 --
 target/hppa/op_helper.c  | 10 +---------
 target/hppa/sys_helper.c |  5 +++--
 target/hppa/translate.c  |  2 +-
 4 files changed, 5 insertions(+), 14 deletions(-)

diff --git a/target/hppa/helper.h b/target/hppa/helper.h
index 8369855d78e..5ed39e01e31 100644
--- a/target/hppa/helper.h
+++ b/target/hppa/helper.h
@@ -1,5 +1,3 @@
-DEF_HELPER_2(excp, noreturn, env, int)
-
 DEF_HELPER_FLAGS_3(stby_b, TCG_CALL_NO_WG, void, env, tl, tl)
 DEF_HELPER_FLAGS_3(stby_b_parallel, TCG_CALL_NO_WG, void, env, tl, tl)
 DEF_HELPER_FLAGS_3(stby_e, TCG_CALL_NO_WG, void, env, tl, tl)
diff --git a/target/hppa/op_helper.c b/target/hppa/op_helper.c
index 76a8d8a0d34..9c560a56d34 100644
--- a/target/hppa/op_helper.c
+++ b/target/hppa/op_helper.c
@@ -30,14 +30,6 @@
 #include "user/page-protection.h"
 #endif
 
-G_NORETURN void HELPER(excp)(CPUHPPAState *env, int excp)
-{
-    CPUState *cs = env_cpu(env);
-
-    cs->exception_index = excp;
-    cpu_loop_exit(cs);
-}
-
 G_NORETURN void hppa_dynamic_excp(CPUHPPAState *env, int excp, uintptr_t ra)
 {
     CPUState *cs = env_cpu(env);
@@ -341,7 +333,7 @@ target_ulong HELPER(probe)(CPUHPPAState *env, target_ulong addr,
         if (excp == EXCP_DTLB_MISS) {
             excp = EXCP_NA_DTLB_MISS;
         }
-        helper_excp(env, excp);
+        cpu_raise_excp(env_cpu(env), excp);
     }
     return (want & prot) != 0;
 #endif
diff --git a/target/hppa/sys_helper.c b/target/hppa/sys_helper.c
index 88109f0181a..1c10d3d85b3 100644
--- a/target/hppa/sys_helper.c
+++ b/target/hppa/sys_helper.c
@@ -21,6 +21,7 @@
 #include "qemu/log.h"
 #include "cpu.h"
 #include "exec/helper-proto.h"
+#include "accel/tcg/cpu-loop.h"
 #include "qemu/timer.h"
 #include "system/runstate.h"
 #include "system/system.h"
@@ -51,13 +52,13 @@ void HELPER(write_interval_timer)(CPUHPPAState *env, target_ulong val)
 void HELPER(halt)(CPUHPPAState *env)
 {
     qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
-    helper_excp(env, EXCP_HLT);
+    cpu_raise_excp(env_cpu(env), EXCP_HLT);
 }
 
 void HELPER(reset)(CPUHPPAState *env)
 {
     qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
-    helper_excp(env, EXCP_HLT);
+    cpu_raise_excp(env_cpu(env), EXCP_HLT);
 }
 
 target_ulong HELPER(swap_system_mask)(CPUHPPAState *env, target_ulong nsm)
diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 41300c0dd73..35766e6ee06 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -726,7 +726,7 @@ static void install_link(DisasContext *ctx, unsigned link, bool with_sr0)
 
 static void gen_excp_1(int exception)
 {
-    gen_helper_excp(tcg_env, tcg_constant_i32(exception));
+    gen_helper_raise_excp(tcg_env, tcg_constant_i32(exception));
 }
 
 static void gen_excp(DisasContext *ctx, int exception)
-- 
2.52.0.windows.1


