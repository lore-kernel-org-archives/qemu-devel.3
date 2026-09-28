Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AA7FC98328
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 05:27:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xB3tO-0000v2-0i; Mon, 28 Sep 2026 01:27:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xB3pz-0005YL-Ew
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 01:23:40 -0400
Received: from mail-dl2-x10.google.com ([2607:f8b0:4864:38::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xB3pw-000885-JD
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 01:23:39 -0400
Received: by mail-dl2-x10.google.com with SMTP id
 a92af1059eb24-142dd025d07so2146948c88.2
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 22:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790573011; x=1791177811; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wW97M9h5uz6Wpe5eAT7kR3We6DeGskL6XRa4AtfhML4=;
 b=p7QbhaA5KeRC/mzPg9AeZucPL8s5wx0aKswd4ysrfOImxUpmpWr0Ls12xB2UVKxjx0
 BPxZnId8ZMeGqMjRsbfEgyVySLhimnfQgciqeqvyspyhf3mOyohKs4s1cK9U/IBz863k
 3Y1A3rcCsQ1gNnjf2hiWN32UCI+oqNcrlr2dRRLabzJC5Rj6XXThDHx4tIRuyzAAk23y
 XUMgBAn3jO1FiwZPj2pScPurbRQfBAK/9q/DHCFVAr/+oWYFRGytauzGTFB8eUY5NptL
 BCcjiXPklXouSB9nEm+yXTubl7UB8khLwU+aSqUZfvxJ+ONc7Cw4HJPF9k9p45fuU/jq
 Ru5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790573011; x=1791177811;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=wW97M9h5uz6Wpe5eAT7kR3We6DeGskL6XRa4AtfhML4=;
 b=DhU8x83ZLaEPwGNKYRzeYuAr8Po8xK+SKH4sQMvnUcD8gkzqxr963lMUnxXNR/dMhI
 U3yTANL7gNWhp2JtZQVrvrKgVWSBPMS4ndfgYOS2+7gW3UziKmfn0JMYCZlr+T7YCjz8
 4mm7mZdsIW45acR4gdfZ3Lhjf6aTDEsQvqdjBfvIjYtVc0oZcWjzmZje1d4R5RfmZWy3
 BkdponAfG/Uq45rT1ZlREw4NIAGHeMP+BoguG7Xr3KvuoY4J3Vu8E390c8grzpelyyXQ
 w/RyC/55bR8BMoKJiXw6crS8BpYq8Im2bRjz1FAmwO3A0+V+bLpDSqeQJov7c+/3RVHi
 PqIw==
X-Gm-Message-State: AFuF++l7NRRae8OmvS6NKxHETz4kmYJALFMw2Lfj0qQ+fyuvVcH8H24q
 vQVxZTp4ddMe+UzRnUwohVAK+mGo8vpeFdDB9wOLK+5RGLVZfhOeLpx8gm0xVJu8Uiw=
X-Gm-Gg: AYBFou1zny3aCX+4k/XMQEnf2WF7U2Nmu/ThDMe7/Gm0p9B7UeRhxx3kj1k2+sHyc7G
 X1p6VlKFhMDbCbo7Hk/7Lw9ysqzeSGBHS1V9TiRKTliQWyUArvg3x04zsSaZTnrVwoIttgrSPlr
 9Yta17NGB32qPmu0OHoKIIGKu61WrvV9t+0HfVFh6pfCkqak+Wh9cZ+W2CEj9/hNN/rgepiTj1F
 ytsm5/Zs8lprMfxURTuj7Ks2MK8OzIRMybOiGAFhFiyxmdfxmX2N/Ye/EHCr07ARRsyi4FJu2ro
 Ht1+IV9wdz0tVFFraClabbcruk7wXH4YDl7FY2zTGEx8FLj70XPF8aVFT5lce9PJ13HyK4HaxAr
 oOH9tsU5jqQTeQTiSTl/Xoin2O/wdtqAAHaF9bCxl10BQR/yBoZxmdG9/OUOHj/6t3FZ2w1pXvQ
 +s1uGrvPFwswN/7kbvkPKF6unXslmBX4VUyVQXHU3M0KKnn647EJm2zcNdYUjIoC+e4aIbtgx6z
 Ew8GpItWK19lx9qx++Khb8ZaNJfY5o=
X-Received: by 2002:a05:701a:c909:b0:144:fd7d:dbdd with SMTP id
 a92af1059eb24-146cdfbecf3mr9671810c88.10.1790573010787; 
 Sun, 27 Sep 2026 22:23:30 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 a92af1059eb24-146bb6551d9sm14726248c88.9.2026.09.27.22.23.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Sep 2026 22:23:30 -0700 (PDT)
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
Subject: [PATCH v2 19/24] target/avr: convert debug/break/sleep to raise_excp
Date: Mon, 28 Sep 2026 13:20:45 +0800
Message-ID: <20260928052051.251-20-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <20260928052051.251-1-luoyonggang@gmail.com>
References: <20260928052051.251-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:38::10;
 envelope-from=luoyonggang@gmail.com; helo=mail-dl2-x10.google.com
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

Replace debug, break, and sleep TCG helpers with raise_excp. Keep
unsupported.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 target/avr/helper.c    | 24 ------------------------
 target/avr/helper.h    |  3 ---
 target/avr/translate.c |  4 ++--
 3 files changed, 2 insertions(+), 29 deletions(-)

diff --git a/target/avr/helper.c b/target/avr/helper.c
index f452c9d9040..ca58a0191fd 100644
--- a/target/avr/helper.c
+++ b/target/avr/helper.c
@@ -152,14 +152,6 @@ bool avr_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
  *  helpers
  */
 
-void helper_sleep(CPUAVRState *env)
-{
-    CPUState *cs = env_cpu(env);
-
-    cs->exception_index = EXCP_HLT;
-    cpu_loop_exit(cs);
-}
-
 void helper_unsupported(CPUAVRState *env)
 {
     CPUState *cs = env_cpu(env);
@@ -176,22 +168,6 @@ void helper_unsupported(CPUAVRState *env)
     cpu_loop_exit(cs);
 }
 
-void helper_debug(CPUAVRState *env)
-{
-    CPUState *cs = env_cpu(env);
-
-    cs->exception_index = EXCP_DEBUG;
-    cpu_loop_exit(cs);
-}
-
-void helper_break(CPUAVRState *env)
-{
-    CPUState *cs = env_cpu(env);
-
-    cs->exception_index = EXCP_DEBUG;
-    cpu_loop_exit(cs);
-}
-
 void helper_wdr(CPUAVRState *env)
 {
     qemu_log_mask(LOG_UNIMP, "WDG reset (not implemented)\n");
diff --git a/target/avr/helper.h b/target/avr/helper.h
index e8d13e925f4..09ce0624915 100644
--- a/target/avr/helper.h
+++ b/target/avr/helper.h
@@ -19,8 +19,5 @@
  */
 
 DEF_HELPER_1(wdr, void, env)
-DEF_HELPER_1(debug, noreturn, env)
-DEF_HELPER_1(break, noreturn, env)
-DEF_HELPER_1(sleep, noreturn, env)
 DEF_HELPER_1(unsupported, noreturn, env)
 DEF_HELPER_3(fullwr, void, env, i32, i32)
diff --git a/target/avr/translate.c b/target/avr/translate.c
index 3c576060970..477610cd349 100644
--- a/target/avr/translate.c
+++ b/target/avr/translate.c
@@ -2554,7 +2554,7 @@ static bool trans_BREAK(DisasContext *ctx, arg_BREAK *a)
 
 #ifdef BREAKPOINT_ON_BREAK
     tcg_gen_movi_tl(cpu_pc, ctx->npc - 1);
-    gen_helper_debug(tcg_env);
+    gen_helper_raise_excp(tcg_env, tcg_constant_i32(EXCP_DEBUG));
     ctx->base.is_jmp = DISAS_EXIT;
 #else
     /* NOP */
@@ -2580,7 +2580,7 @@ static bool trans_NOP(DisasContext *ctx, arg_NOP *a)
  */
 static bool trans_SLEEP(DisasContext *ctx, arg_SLEEP *a)
 {
-    gen_helper_sleep(tcg_env);
+    gen_helper_raise_excp(tcg_env, tcg_constant_i32(EXCP_HLT));
     ctx->base.is_jmp = DISAS_NORETURN;
     return true;
 }
-- 
2.52.0.windows.1


