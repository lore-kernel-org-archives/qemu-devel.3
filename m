Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8E65CA5FC4
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 17:58:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xChUA-0000lb-JD; Fri, 02 Oct 2026 13:55:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xChRO-00057c-TW
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 13:53:03 -0400
Received: from mail-dy2-x0e.google.com ([2607:f8b0:4864:36::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xChR9-0007aJ-8S
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 13:52:49 -0400
Received: by mail-dy2-x0e.google.com with SMTP id
 5a478bee46e88-3428f70d7e7so4560254eec.3
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2026 10:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790963566; x=1791568366; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5o8QBC2V06VU8Hip/Yv/GKks4ZOHoJaCkD3lW4u1eNA=;
 b=s71HdQiZLZQDFJBMoFa+WMbIWFWjOIa8hU5J8J6oCEYDno44RzK+WdzdUAwWWtlUjp
 ogq0bp26C2vFAAcw8ykiq3CnGhQJdxOMVazqzGN+N1rZBmKbjp7jXJ5IcIzmAt+PXt/Q
 XXGkIHt3TQ0SJ+xzgsSy0DTG2lZhh+kZHRt68Yo5/DWnnbk1Y1H9rfplyirDq/UEWDrM
 aVcR/LGAEEh2TJMuLK9eME3JfGp99DAcM9MHFKXaswqdcElc8/a9MqUDCFY9ExocbbpV
 1fHw5ybQaQcPzyjBCWEBwVABhR5IQkae98JqsGkR/0je6Ui8nY1XJ9VQhbespfWa6EvR
 njsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790963566; x=1791568366;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=5o8QBC2V06VU8Hip/Yv/GKks4ZOHoJaCkD3lW4u1eNA=;
 b=BWqVntOUA+V9YFQ01K1bjAzrvChVkL7N7UR65LJgt+j0Gb6okaOEfYxg6HkonI9Zgg
 dCr1+kbC+LQvuaF6EzUz7h1iLEBwkRPwRxGO6F+SuBbEpQ6Sdkm4WNkVJPdETeDad64N
 3Bp+8wNEIoOSpVdfpmcjHu6GOwWR6VtQjT31sc/OuOlIudeovpzGHSp+7rpHKjWRMiyO
 s7oOeMFn5yTPLGvylokgT9QmRftt1mPK+oKqYxpkd6Omh8UVxydGrexDyPimD+oUYRCD
 mZ4w79Cc913qH+kxSujg0YOxH8hU44unFX/opMAigwLFm127ZQUDWOh3amEaGgpveVkQ
 yqhQ==
X-Gm-Message-State: AFuF++mC0oJEcVQRG7C9CyO0MlTtTe1MhrwLEf6eqhLxstcyTOZNyER1
 F/GL8WsSv/njKwjVKOA6pCDsqwi8FWyT2ZeU6N5CXwzf2uzgpCeSPr//6qC349+JIpc=
X-Gm-Gg: AYBFou2LEB8gTHrK3yvgbLk2Fh3fk7oYi7ZCcHPOF30cP+UzVPjkbfDyQVy6/3jXtby
 A9uCN9BSJr3AeSfZ26l25yAmsn+oLbSY/DX3mzTHxmu0P8/Gz7pkl4P+9Gcot0rmue8D5TZqSzt
 jzpWK+j+7fAQoTS3ehgsGuIsOwUbSU/XYfFN0vskMNRtEZLuPBOcO+y44E+R4MLQ2iYPNVQeuIg
 nG5O/5XIugywtKeTPuzaqj9i2Ya1SSV98T7nY5XUKzFMroJJRDiB3dzgVYG5PJe7slJCl+7+zrv
 QE3Zlu6xz5aSt1NW4M80jIh+84L62zLPTKOLKaAWMcYFrFSE1FF7cl5G3wobf90p7l5bFFuHdWN
 x1D2edsiL/teT4hquBHIYCIje+0bwfAas/TMKBicsGgrnc1V6dpAVdqURm2B10mZB7Zabw14N3e
 M3fKAhje5fBZ8tGB6zSzNfv9nkKlDCXYcS8G8UnWLo93r/RN5cB5rE0BcmPqtPVqt2YewlP5UOS
 z6pu+I7FD1xSXw3GAFoLXH/urGN89Q=
X-Received: by 2002:a05:7301:dd97:b0:34b:d8dc:430f with SMTP id
 5a478bee46e88-34f150ab82fmr3257575eec.7.1790963565409; 
 Fri, 02 Oct 2026 10:52:45 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 5a478bee46e88-34f14f9f2afsm18027361eec.18.2026.10.02.10.52.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 10:52:44 -0700 (PDT)
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
Subject: [PATCH v3 15/27] target/microblaze: convert raise_exception to
 raise_excp
Date: Sat,  3 Oct 2026 01:50:23 +0800
Message-ID: <20261002175037.1747-16-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <20261002175037.1747-1-luoyonggang@gmail.com>
References: <20261002175037.1747-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:36::e;
 envelope-from=luoyonggang@gmail.com; helo=mail-dy2-x0e.google.com
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

Use the shared raise_excp helper for translated exceptions. Use
cpu_raise_excp_restore() for GETPC() paths and preserve explicit
cpu_loop_exit_restore() for MMU callbacks with possibly-zero retaddr.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 target/microblaze/helper.h    |  2 --
 target/microblaze/op_helper.c | 19 +++----------------
 target/microblaze/translate.c |  2 +-
 3 files changed, 4 insertions(+), 19 deletions(-)

diff --git a/target/microblaze/helper.h b/target/microblaze/helper.h
index 1429c1727ef..ad9c22ed5b7 100644
--- a/target/microblaze/helper.h
+++ b/target/microblaze/helper.h
@@ -1,5 +1,3 @@
-DEF_HELPER_FLAGS_2(raise_exception, TCG_CALL_NO_WG, noreturn, env, i32)
-
 DEF_HELPER_FLAGS_3(divs, TCG_CALL_NO_WG, i32, env, i32, i32)
 DEF_HELPER_FLAGS_3(divu, TCG_CALL_NO_WG, i32, env, i32, i32)
 
diff --git a/target/microblaze/op_helper.c b/target/microblaze/op_helper.c
index 3da0c68da39..9010c838d90 100644
--- a/target/microblaze/op_helper.c
+++ b/target/microblaze/op_helper.c
@@ -62,25 +62,14 @@ uint32_t helper_get(uint32_t id, uint32_t ctrl)
     return 0xdead0000 | id;
 }
 
-void helper_raise_exception(CPUMBState *env, uint32_t index)
-{
-    CPUState *cs = env_cpu(env);
-
-    cs->exception_index = index;
-    cpu_loop_exit(cs);
-}
-
 /* Raises ESR_EC_DIVZERO if exceptions are enabled.  */
 static void raise_divzero(CPUMBState *env, uint32_t esr, uintptr_t unwind_pc)
 {
     env->msr |= MSR_DZ;
 
     if ((env->msr & MSR_EE) && env_archcpu(env)->cfg.div_zero_exception) {
-        CPUState *cs = env_cpu(env);
-
         env->esr = esr;
-        cs->exception_index = EXCP_HW_EXCP;
-        cpu_loop_exit_restore(cs, unwind_pc);
+        cpu_raise_excp_restore(env_cpu(env), EXCP_HW_EXCP, unwind_pc);
     }
 }
 
@@ -123,8 +112,7 @@ static void raise_fpu_exception(CPUMBState *env, uintptr_t ra)
     CPUState *cs = env_cpu(env);
 
     env->esr = ESR_EC_FPU;
-    cs->exception_index = EXCP_HW_EXCP;
-    cpu_loop_exit_restore(cs, ra);
+    cpu_raise_excp_restore(cs, EXCP_HW_EXCP, ra);
 }
 
 static void update_fpu_flags(CPUMBState *env, int flags, uintptr_t ra)
@@ -390,8 +378,7 @@ void helper_stackprot(CPUMBState *env, uint32_t addr)
 
         env->ear = addr;
         env->esr = ESR_EC_STACKPROT;
-        cs->exception_index = EXCP_HW_EXCP;
-        cpu_loop_exit_restore(cs, GETPC());
+        cpu_raise_excp_restore(cs, EXCP_HW_EXCP, GETPC());
     }
 }
 
diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 8b219afb5dd..9424208a04b 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -100,7 +100,7 @@ static void t_sync_flags(DisasContext *dc)
 
 static void gen_raise_exception(DisasContext *dc, uint32_t index)
 {
-    gen_helper_raise_exception(tcg_env, tcg_constant_i32(index));
+    gen_helper_raise_excp(tcg_env, tcg_constant_i32(index));
     dc->base.is_jmp = DISAS_NORETURN;
 }
 
-- 
2.52.0.windows.1


