Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0EF4C54E68
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Mar 2024 15:50:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnKfe-0005BI-KT; Thu, 21 Mar 2024 11:49:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rnKfd-00053b-1K
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 11:49:33 -0400
Received: from mail-lj1-x234.google.com ([2a00:1450:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rnKfb-0001N5-HG
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 11:49:32 -0400
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2d23114b19dso16605011fa.3
 for <qemu-devel@nongnu.org>; Thu, 21 Mar 2024 08:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711036169; x=1711640969; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xtEYan//81EtbsPaWQKotnbuaiGDwRNY8wJpHHZftjo=;
 b=Wku3XQxQuTrrTfU9SDHTMjvCfVXwMkDhw3/xkTzDRd48qF3Zg815r3L7suIfL7LlDV
 sNJKsNRRrwj5Kufu+to1kWwCH8XtBG5WsUZlqSwqNa2/L1dc/E+M5cT7EUu8qmxTf6j+
 cYt3BmdirCA+JZHRscApikUwbOVezz7A3dMIUz2yzp2LksfBOPt3yv74zhx4JKf6tDZW
 PgONOU4+DanuuPjNBDq66xMR9OEDyhZsLck/+JDC0DOktmwtj7OoXGw6Wd9v1EdUZhpP
 imKme1FjA0pPpVCW6huY/6+vo6J8uLI3yzM2jcNtZG/LQC5VzaLdbHb9NBHKZBJQK1vR
 1PzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711036169; x=1711640969;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xtEYan//81EtbsPaWQKotnbuaiGDwRNY8wJpHHZftjo=;
 b=IXX1phTFj3KslVpL2oBgts91Kclcm7IRCt0jbTsXACR1bwgaXwAC3ThAPbj0Xmh5FN
 kr1SsdmeGomNbfHGA5++JXlcPMSpE6dZme2Bfzw16NHeh1mYKxU34ofI2J1dBH3UApbw
 2eyLmyZ61rOpZwZPyiNKbP8exogEirnXd2hPWemMeh3Jc1xvE8Myw13mpcREScXu8u+j
 9KRNAjt2im45sWjr6uPyRlQM0WxRWF0nRPvFU9tp0Jd5xh61EqYfr1e/751M5KWhIWTx
 Xk8/9KbXuFgSFmhfbHdNc/jC1YjPDVMSuxAUTE9cOWFd8jvIB2cl53UbOD+bn1TWrrUe
 Kd8g==
X-Gm-Message-State: AOJu0YxX/cqW+LrjYUiqVxst2xMwnomgXqUtyOCqYPfjv7TUizGr78eH
 EJibdLGUjTifkQH6YhvZSIctwRpJtir/8pLKEASp/vgJ9ThLdn4Q4SJ98oBVaetGIYovoUUrRKl
 I/DU=
X-Google-Smtp-Source: AGHT+IFBPR/Pr+XbGKhCvPp0NGCaJSK4lXMlzsD5cUSrTyGZOKbh/UIHZyhyiNbuVk1m7v7sep95ug==
X-Received: by 2002:a2e:9c50:0:b0:2d4:6c08:5f94 with SMTP id
 t16-20020a2e9c50000000b002d46c085f94mr15024512ljj.37.1711036168978; 
 Thu, 21 Mar 2024 08:49:28 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.206.222])
 by smtp.gmail.com with ESMTPSA id
 r14-20020a05600c35ce00b004146aac1d2asm5952403wmq.27.2024.03.21.08.49.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 21 Mar 2024 08:49:28 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Artyom Tarasenko <atar4qemu@gmail.com>, Chris Wulff <crwulff@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Marek Vasut <marex@denx.de>, Max Filippov <jcmvbkbc@gmail.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-9.1 06/21] target/m68k: Have dump_ttr() take a
 @description argument
Date: Thu, 21 Mar 2024 16:48:22 +0100
Message-ID: <20240321154838.95771-7-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240321154838.95771-1-philmd@linaro.org>
References: <20240321154838.95771-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::234;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x234.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Slightly simplify dump_mmu() by passing the description as
argument to dump_ttr().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/m68k/helper.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/target/m68k/helper.c b/target/m68k/helper.c
index 310e26dfa1..cf9d83e47e 100644
--- a/target/m68k/helper.c
+++ b/target/m68k/helper.c
@@ -578,8 +578,9 @@ static void dump_address_map(Monitor *mon, CPUM68KState *env,
         break; \
     }
 
-static void dump_ttr(Monitor *mon, uint32_t ttr)
+static void dump_ttr(Monitor *mon, const char *desc, uint32_t ttr)
 {
+    monitor_printf(mon, "%s: ", desc);
     if ((ttr & M68K_TTR_ENABLED) == 0) {
         monitor_puts(mon, "disabled\n");
         return;
@@ -663,14 +664,10 @@ void dump_mmu(Monitor *mon, CPUM68KState *env)
         monitor_puts(mon, "\n");
     }
 
-    monitor_puts(mon, "ITTR0: ");
-    dump_ttr(mon, env->mmu.ttr[M68K_ITTR0]);
-    monitor_puts(mon, "ITTR1: ");
-    dump_ttr(mon, env->mmu.ttr[M68K_ITTR1]);
-    monitor_puts(mon, "DTTR0: ");
-    dump_ttr(mon, env->mmu.ttr[M68K_DTTR0]);
-    monitor_puts(mon, "DTTR1: ");
-    dump_ttr(mon, env->mmu.ttr[M68K_DTTR1]);
+    dump_ttr(mon, "ITTR0", env->mmu.ttr[M68K_ITTR0]);
+    dump_ttr(mon, "ITTR1", env->mmu.ttr[M68K_ITTR1]);
+    dump_ttr(mon, "DTTR0", env->mmu.ttr[M68K_DTTR0]);
+    dump_ttr(mon, "DTTR1", env->mmu.ttr[M68K_DTTR1]);
 
     monitor_printf(mon, "SRP: 0x%08x\n", env->mmu.srp);
     dump_address_map(mon, env, env->mmu.srp);
-- 
2.41.0


