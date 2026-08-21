Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3237FC5DF7D
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 11:02:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxN0K-00064E-Jp; Fri, 21 Aug 2026 07:01:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wxN06-00061B-L4
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 07:01:30 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wxN05-0007Dl-3l
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 07:01:30 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-49557167508so7159145e9.1
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2026 04:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787310087; x=1787914887; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Vo9PbbbPqYN1Ef4Ej8cwJZ2Oz8N8SbnTX3lrcCjaQzQ=;
 b=skmfRxiHlpfER+/yM1Q7S7TeRFlgRjJbe77ovhqR4WABmsF1vQNgWcTyQccbThctSt
 RK5PW2lEQ0tK9PCdekvL8TrWTs1Ue/yVb/4inrPmyzlXaEr2fw3ZJ2JuQ/5PFEi2Of21
 13Ni4Vzn8ufuQE7aMfjcJXxb3BFVOUYKcqHEn9KoOlHJqRgFGtVechMqvErqe3QLPvjL
 3CmoxaXw87AP8mGcA+cW97z9rGFNEmeTVekEdKRi0jNMZ3OKWVuHVomT9RG1h5Mx1vD8
 Erv/5SDxZcp+QwYe8UXdYVGcwGRK2hLKisBOhpxnJ3NinUpVFM2T2hY/MmO9PdPpaQdR
 KgTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787310087; x=1787914887;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Vo9PbbbPqYN1Ef4Ej8cwJZ2Oz8N8SbnTX3lrcCjaQzQ=;
 b=mKqBbQLyOyurA/dghZPX2I5aqXptYIdyu4HW2UVLcw2LVib5W/AIYwvHD4IQU7NugF
 6DgHZI3BRslq7+b/bXj1NJCP7piBA+lJ5Ilk/G0CaSi1jul5B8NvGmj6QGq9zH1rBsPl
 6nHLdDa4yzTzxBPG0ZpxhRwvdswlHo7JIs/AAsq0OeOgljOWyY5lVNIET39LEJSgAS6F
 ozLAXVRYRhTwCy0tPKucJAmQKn2jRgfv22AoYBrWu9Ooj+Ds0dRX2yGX7Nh8vPwTgtqW
 fDjggMFdIG+PTToMmRiCXE64XVZ46jCPpZ9qrc15KPgWIUgKMjNja104ORQnRw7eAFI9
 2DDw==
X-Gm-Message-State: AOJu0YzoR6Fur/botMECBTo4XXOrpebSeQfBZggpd0l0Zau2S9jM5zG6
 KcV1OHVceqnFmIOLcLp/4H8FKsW+Bq5p9pJZ7Luxlsr40J2FB1OgshGz4Y5wsCXtHZkPO2VGHSn
 JYqnk
X-Gm-Gg: AR+sD12gRTJEljctrgQfYhazcUNskyepgRQ5FC/1zxBVtwjOs/gvgf0UZEQ01F6gEVp
 ga1aqm2OgI62W+xJuNK4c+IftN8ifHWEsTlmWkjfed818+MlEyafsx9vQSUOrTxYnQqYKaH8vRY
 bs+fAmSpqfoTQFBfB14nlhdNtcDwEwbsdk8Mf609yFujo+saTmg+Gqwo1UEGEYK4pTiwJO2f1d5
 hHZWXo08Q0N8iK1f4JuAto5Ib31uxY/gFGzElMjL6R2XPblFoQ61DpU+f2UDSCBIfLuqMFzRxKo
 +X2xNCaN7k3HZ7JLKnBkax1lZp/N9lNZMe/TEfT3TXKqS69YXCmpwk6RL46xUw5RbZTIGsoaqW5
 fB/e8lKdwMKJ+e8OvxLUsWTJBi9LWZgo0eB1ppBlgu6FHe5h+k6+PBacKSrjFLs+ZAVnEkqS9w4
 U83wNgLZZJ3N/BsJb8hXxlhD5Q+YUCmBlcSXqjAl82O/bJEakHKRBw3l1SCi73wwfNlEuV7DjtT
 0o+JdrmlqzGthIYhpo5zXsTnvJml2VAW+yy+lQpMX5TInamQBrIzIPjwxwrM+lzA64ylw==
X-Received: by 2002:a05:600c:64c6:b0:499:afcb:24c1 with SMTP id
 5b1f17b1804b1-499b82e8528mr90396955e9.5.1787310073219; 
 Fri, 21 Aug 2026 04:01:13 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499b90e7e20sm22875985e9.5.2026.08.21.04.01.09
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 04:01:10 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 01/43] target/arm: Restrict arm_do_plugin_vcpu_discon_cb() to
 TCG
Date: Fri, 21 Aug 2026 12:00:19 +0100
Message-ID: <20260821110101.3971391-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260821110101.3971391-1-peter.maydell@linaro.org>
References: <20260821110101.3971391-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

So far TCG plugins can only be used when TCG is available.
Move the arm_do_plugin_vcpu_discon_cb() call within the
'if tcg_enabled' block and wrap the definition with #ifdef'ry.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-id: 20260814080507.23196-1-philmd@oss.qualcomm.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index af45234ad2a..adae2b2b8e5 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -8915,6 +8915,7 @@ static void take_aarch32_exception(CPUARMState *env, int new_mode,
     }
 }
 
+#ifdef CONFIG_TCG
 void arm_do_plugin_vcpu_discon_cb(CPUState *cs, uint64_t from)
 {
     switch (cs->exception_index) {
@@ -8932,6 +8933,7 @@ void arm_do_plugin_vcpu_discon_cb(CPUState *cs, uint64_t from)
         qemu_plugin_vcpu_exception_cb(cs, from);
     }
 }
+#endif
 
 static void arm_cpu_do_interrupt_aarch32_hyp(CPUState *cs)
 {
@@ -9677,9 +9679,9 @@ void arm_cpu_do_interrupt(CPUState *cs)
 
     if (tcg_enabled()) {
         cpu_set_interrupt(cs, CPU_INTERRUPT_EXITTB);
-    }
 
-    arm_do_plugin_vcpu_discon_cb(cs, last_pc);
+        arm_do_plugin_vcpu_discon_cb(cs, last_pc);
+    }
 }
 #endif /* !CONFIG_USER_ONLY */
 
-- 
2.43.0


