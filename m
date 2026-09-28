Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F8D4C98328
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 05:27:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xB3sC-0008Em-EW; Mon, 28 Sep 2026 01:25:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xB3pS-0004ql-9f
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 01:23:06 -0400
Received: from mail-dl2-x0e.google.com ([2607:f8b0:4864:38::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xB3pO-00082L-T5
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 01:23:05 -0400
Received: by mail-dl2-x0e.google.com with SMTP id
 a92af1059eb24-144d60be6b0so1440236c88.0
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 22:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790572980; x=1791177780; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6BAn3e898xbc3rDUsn8jFYdwVTPtq1IAOzdpRZ1Zvbc=;
 b=LRYXpddysGpapTSQO9GR+N19Qy5L5fXH3U088x3o+5rdPaVqmusYHG4RnK5jgGmGKM
 qZIL+iIW+9rcWyvgC74tcBdZ7RTycOi6/mVwi+Rmvx8HIlC0mFf0ngB99ETzdtXmIrYo
 xP+lSvOvRMD3b3/FK0EJ9BJ//E65uuI1xJC9NGG1Jdm6nazg1CdDtq/BsZws1U7QOAt/
 tkV8lvFt79GywDbpGAX+WbityabWNSWKhXVpFIhJvE0Udg5k4Or/XcabbqW+5n5xXTvC
 aBuAWMOxdXfK05urMst/it9m/dqnEQbW6fG4JT3ONWwh9H/4OiYORkwuby4DBtkscPAw
 1X/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790572980; x=1791177780;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=6BAn3e898xbc3rDUsn8jFYdwVTPtq1IAOzdpRZ1Zvbc=;
 b=O7qJA3kVYEzLar92EqpaApIDLSTPfPIDDo7ma6yJuXfQ5Bq4KeY/8LoMcBHW1UDuWi
 3jhWNBngRtWs+67BMv6qEYr7OyPe1HPq/qG3KaqJameOFCyNfzOOqYmnvGCYkW7qu4DO
 7Kbjtev4E49GoKjn/wSeFJ/5YM5exVpgH1ymBdJH0tTfRGq2ZdkY0Nb/ivIk3Bpft+zC
 m/X/7jH8G8fuHueLHdSWZkmVeptNaPT47Futl8EWf/POvwe2se0bJl9clM/Wkiee6Vuw
 QKDS0QChoCg4jW0LNCuljt2+ZuFHYDBPOLtKZ3tjvkqI2R+FAJ4sBqvMsBv1i4asXPZ4
 wpeg==
X-Gm-Message-State: AFuF++lyi21XRK6oYTCfqoiMDRiQABJZ7+O68Byqi06eE3kdOHfQTTQD
 OnB63xMFrlaYVvn0oYfeWw1SenZ34lthqcAG+Pi2O/RmOIa5Q6RmZqnEh1ysPs2K7bk=
X-Gm-Gg: AYBFou2YosLEf2vHLOasuKQPlvqHWkfv6QO8+Bkb/4U3OVwfJ7mWwulPc3V3/Xl2XTJ
 jJT1SkkEWEkBLs7aGnjejbRX2ZLsxXuxXtuH7ea3ELJSohiYbukykNEwMI1nxzYYTfkzdQTB+C2
 a5F5jPV76VrhLUQZ6LYh4HaNYGjvGMi84o28GVSah5cGs2zF5aNLuVs0v8SfJ23OC4lr3S01fdT
 5ppzerG/CIMu9hVaC8yEiwOEpeDaolGWSwv1+L9S1qwIccPo6vOWOgX8v3+ouBSAymykGai6g00
 W0d+zUAJFYpQ5oNq2kaU2C81qDz2cto6ITTQmGoejgxEyL0C2bk6YL2H/QJW7d3pJU5BuD256nO
 PQV8EKy2MbVLU93RECGnwg0MmIyPHTohbcAUKx/zYpp2B+58oL8g3A2BhRjWIUhtx9QhFP2tjKI
 9ztruv1/NQOw+snaxnPr8mm2dA9hVx9kJq4UL9yKd6EZr4LkPRMXmkKZjdrTLgoME4qYfz18Mh/
 UEIywT6MnNIAO+sMgt4VZYEyGGTuEE=
X-Received: by 2002:a05:7022:7f11:b0:149:49c:234 with SMTP id
 a92af1059eb24-149049c046bmr3963937c88.24.1790572979615; 
 Sun, 27 Sep 2026 22:22:59 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 a92af1059eb24-146bb6551d9sm14726248c88.9.2026.09.27.22.22.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Sep 2026 22:22:58 -0700 (PDT)
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
Subject: [PATCH v2 15/24] target/alpha: convert excp to raise_excp
Date: Mon, 28 Sep 2026 13:20:41 +0800
Message-ID: <20260928052051.251-16-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <20260928052051.251-1-luoyonggang@gmail.com>
References: <20260928052051.251-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:38::e;
 envelope-from=luoyonggang@gmail.com; helo=mail-dl2-x0e.google.com
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

Store error_code in translate, then call raise_excp. Drop TCG excp.
Keep C dynamic_excp and arith_excp.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 target/alpha/helper.c    | 11 -----------
 target/alpha/helper.h    |  1 -
 target/alpha/translate.c |  8 +++-----
 3 files changed, 3 insertions(+), 17 deletions(-)

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
index c66e3f9c146..91941e5be8f 100644
--- a/target/alpha/translate.c
+++ b/target/alpha/translate.c
@@ -264,11 +264,9 @@ static void gen_pc_disp(DisasContext *ctx, TCGv_i64 dest, int32_t disp)
 
 static void gen_excp_1(int exception, int error_code)
 {
-    TCGv_i32 tmp1, tmp2;
-
-    tmp1 = tcg_constant_i32(exception);
-    tmp2 = tcg_constant_i32(error_code);
-    gen_helper_excp(tcg_env, tmp1, tmp2);
+    tcg_gen_st_i32(tcg_constant_i32(error_code), tcg_env,
+                   offsetof(CPUAlphaState, error_code));
+    gen_helper_raise_excp(tcg_env, tcg_constant_i32(exception));
 }
 
 static DisasJumpType gen_excp(DisasContext *ctx, int exception, int error_code)
-- 
2.52.0.windows.1


