Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80748C982D9
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 00:46:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7Mil-0000xH-AQ; Thu, 17 Sep 2026 20:44:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1x7MiQ-0008FZ-E7
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 20:44:36 -0400
Received: from mail-pz2-x0d.google.com ([2607:f8b0:4864:3b::d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1x7MiN-0001p2-MX
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 20:44:34 -0400
Received: by mail-pz2-x0d.google.com with SMTP id
 d2e1a72fcca58-86efece610cso175630b3a.0
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 17:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789692270; x=1790297070; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=D+g8VjDLv7LBzByOiE3Y+YGTu83URWzi5nMysP+Y4jc=;
 b=AYDQYqq7GvFlREYKf5tKOlL7wR6DJunigAXPm+zAkAQE/bMxyrsQmAqfahxCKvj9K/
 yuN6BqUicj6VrkpFPhx0Fneqmt2ClDDXNMK3sIw8aj634zzO+JlJH7g9lBXboTX9Fx8Z
 zesxrEjltmEZGJnzXYW7LUawwFq80VuF8IEV+ojPGECCj8ETyi8QrOIwCqQy+C5B0/Ri
 JEd4C/dyR09rfVR5SKP2D1mnSVGVKeMrStUNY0fT0e2j358/mnuSHPTDkhDYW/zYhNmH
 6ojBusVnBM3/di99NcHNi691sgYeY093FxUNghDYEsf6mSnrVzziF9u6E7zd/TR8mhJU
 jYqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789692270; x=1790297070;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=D+g8VjDLv7LBzByOiE3Y+YGTu83URWzi5nMysP+Y4jc=;
 b=v6gSvic6rYQPoLhvUw1iUi3m4kkNpUhhWplIbGJVzVx8nFSkZYSrr1LmgQ7JZjXy5k
 tZLQsZJBq9VB/iQINVLn/ecpN0cQZNwTp6gVNKo5n94WrOIy6FfAOBIwL606IR5SfqUP
 FZpxRPYyXKjM+2KaoK87L6DiUMmwgwHnKRN8efR1du2duLNiRt7S0Yume/dzJ1DonB0Q
 V9kI/tDiZTFzdcnl1IeMgyOl2haun+JIxheh3TuVi6na/bNTMDlTQS3C+nuX0r4RkD+W
 u/4dUYmnFcCaRkx01UOjqvIYWzqlMYdmHtFhi39pQa/wPvxvBXCdSH+CfZwcjc+b7yfq
 p47g==
X-Gm-Message-State: AFuF++m3bzKOgZGUseG0epiGjs2EpheVUEp1x3vCNU76eOYWpUGnvJpu
 C14wdkWdhE5psQEAFrANsto7UMLNm7u4HehMlejfNvdiZiJGBLVzvcknmVusFIJRk38=
X-Gm-Gg: AYBFou13Ykpba/ZE2BQADthlNvyfVVy3gi3ON4OaGKz0ZN79pO2LWEIrq3vvDVLgGVX
 RjYQU+psKAkJ3IX+mxoaa7O7xdT4prb0lUEZ0o6/6kTnUbwPsQPuq/1y0ZKOg1ZrVzDsbMoDa8r
 XZblX6nrPqntEB6qv++/UK3jCyjD48jadEjqeFMGoz6HS3r5n+84WWLnlisoKZ30NK0u3KtrqAk
 Cwi+Myv57eGupb0rqLEB11izD+SQxdQIiR0DsvFshZZFCEO2z99hnsqdEoj7R3boyegaU/du9Dm
 J+P6jmwklFsQD2RiJSPfxESfeHXvN34MX6oAy/UzyFg5D0+Le2Bqs9TbbIAUEd9oHj1rUwTF0sY
 EI6C87zVPXZGAc2r9oTLCjoCx0mYJMVFpVbY+Y089jlLkVMyL2FMG6O3k1EMvoSng/6unL+YKMP
 nrWPrvbrojkqXDtYhOiXKcaRURR3PTG0Rnn3J9sWtgO0q9FOR5JUs5tSGTQoh2quLU0RVGzqu/h
 qIsBv3dG6agFDHZnn7IV2tX9/WHxH/P
X-Received: by 2002:a05:6a21:e85:b0:3d9:3626:1326 with SMTP id
 adf61e73a8af0-3dd8c335bd2mr1540567637.2.1789692270409; 
 Thu, 17 Sep 2026 17:44:30 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 a92af1059eb24-144cdfc3df2sm600286c88.5.2026.09.17.17.44.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 17:44:29 -0700 (PDT)
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
Subject: [PATCH 13/21] target/alpha: convert excp to raise_excp
Date: Fri, 18 Sep 2026 08:42:15 +0800
Message-ID: <20260918004225.827-14-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <20260918004225.827-1-luoyonggang@gmail.com>
References: <20260918004225.827-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::d;
 envelope-from=luoyonggang@gmail.com; helo=mail-pz2-x0d.google.com
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

Store error_code in translate, then call gen_helper_raise_excp
with restore 0. Drop TCG excp. Keep C dynamic_excp and arith_excp.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 target/alpha/helper.c    | 11 -----------
 target/alpha/helper.h    |  1 -
 target/alpha/translate.c |  9 ++++-----
 3 files changed, 4 insertions(+), 17 deletions(-)

diff --git a/target/alpha/helper.c b/target/alpha/helper.c
index c3614ecafda..d1497547181 100644
--- a/target/alpha/helper.c
+++ b/target/alpha/helper.c
@@ -533,17 +533,6 @@ void alpha_cpu_dump_state(CPUState *cs, FILE *f, int flags)
     qemu_fprintf(f, "\n");
 }
 
-/* This should only be called from translate, via gen_excp.
-   We expect that ENV->PC has already been updated.  */
-G_NORETURN void helper_excp(CPUAlphaState *env, int excp, int error)
-{
-    CPUState *cs = env_cpu(env);
-
-    cs->exception_index = excp;
-    env->error_code = error;
-    cpu_loop_exit(cs);
-}
-
 /* This may be called from any of the helpers to set up EXCEPTION_INDEX.  */
 G_NORETURN void dynamic_excp(CPUAlphaState *env, uintptr_t retaddr,
                              int excp, int error)
diff --git a/target/alpha/helper.h b/target/alpha/helper.h
index 954a5c8294c..cdb36384a7b 100644
--- a/target/alpha/helper.h
+++ b/target/alpha/helper.h
@@ -1,4 +1,3 @@
-DEF_HELPER_3(excp, noreturn, env, int, int)
 DEF_HELPER_FLAGS_1(load_pcc, TCG_CALL_NO_RWG_SE, i64, env)
 
 DEF_HELPER_FLAGS_3(check_overflow, TCG_CALL_NO_WG, void, env, i64, i64)
diff --git a/target/alpha/translate.c b/target/alpha/translate.c
index c66e3f9c146..b9970f4aa5b 100644
--- a/target/alpha/translate.c
+++ b/target/alpha/translate.c
@@ -264,11 +264,10 @@ static void gen_pc_disp(DisasContext *ctx, TCGv_i64 dest, int32_t disp)
 
 static void gen_excp_1(int exception, int error_code)
 {
-    TCGv_i32 tmp1, tmp2;
-
-    tmp1 = tcg_constant_i32(exception);
-    tmp2 = tcg_constant_i32(error_code);
-    gen_helper_excp(tcg_env, tmp1, tmp2);
+    tcg_gen_st_i32(tcg_constant_i32(error_code), tcg_env,
+                   offsetof(CPUAlphaState, error_code));
+    gen_helper_raise_excp(tcg_env, tcg_constant_i32(exception),
+                         tcg_constant_i32(0));
 }
 
 static DisasJumpType gen_excp(DisasContext *ctx, int exception, int error_code)
-- 
2.52.0.windows.1


