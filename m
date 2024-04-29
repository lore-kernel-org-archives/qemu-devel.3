Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37CEBC4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 21:33:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1YbX-00080M-T0; Mon, 29 Apr 2024 17:32:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1YbG-0007fs-5w
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 17:31:53 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1YbD-0003MP-LK
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 17:31:49 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-41c7ac6f635so7038865e9.3
 for <qemu-devel@nongnu.org>; Mon, 29 Apr 2024 14:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714426306; x=1715031106; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XKYG6Le200XvNAWzyHkVzuEjCu+nWrYe1aCCZD9ag2M=;
 b=gikHS9gfjU9Jp/zfL1yuEAA8iYzSwhfKqqhXzKES4zoZHEILkx+SANp02Vz5iGgdmm
 q/ZmxzQeh2TtS5Ne0jX81XaJXhWbezZIQMtSLSVhX9kBMyrTggMYh0F6MwzELtAWhXo+
 ELM2MoSk+BzCH0/yWjYTvTuYRp+fkvo1x1TEzHixqg/xDZMgYwJkrS8IKI/JD7z0fojL
 4kLFvMIasjhAE7dSF2J0Lnu3w/oW0srzAlnN1qkfgT4EfBftkNUnZycAlgF4LbILyq8C
 d0sTttNp+648mrH3ElBVlX6TaKLZYDbGhmhoUEX/6htqaviTzxA4QiWSqDw9PQI/rtJY
 qwEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714426306; x=1715031106;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XKYG6Le200XvNAWzyHkVzuEjCu+nWrYe1aCCZD9ag2M=;
 b=WPPHENVLfJ0eh0tL3bZ2uRdZPWwIqscqKIGO7ffXCHr1/0TRzXs1+lGEAZxkTmkBaD
 p8BdY/3P1pSLO9ZnEwOd1ql/iIzG5fez3fdvxmJ6gSuKYB9qNvkivGMoQZ1FWBDtpZFC
 75JVs1kDodDeraELqaOchVsNeu9DdbjSbjgSX74HnHfkWONEyoPfps4hnzJ/gSPj4dnE
 eCsQNS+/ZL06ZxzVrG9FPW6+C5McSjvWbd7MBsY47/QAMVQPomvuCOu1RPFc9AT80ZVY
 b2wFglJjr6opUoVBnq4t7Rnt/QW2GXRa+liyXTTvuyHYzI0KJbFqtEplL25ZG+8e8zAz
 6nNA==
X-Gm-Message-State: AOJu0YyYQrUfU9LMjWBPS+DKpJ0b0mr3WGsib7d78wD43WksnS1hpr6J
 8ZR62frqwguc4KKnfq+g4XHkNR9NQOflE9s/0vOqDkjPVc9yskMPcjj6RL1sSrCXkK+swgggYd3
 mKzc=
X-Google-Smtp-Source: AGHT+IG0Xamq0agm5O6t6N2GP52GSmnqeURhlP/GDFMWYWds2SgsSXyjZhy5XiJWl4Z5H7bvCNczvw==
X-Received: by 2002:a05:600c:474d:b0:41b:f106:bb89 with SMTP id
 w13-20020a05600c474d00b0041bf106bb89mr6756151wmo.18.1714426305814; 
 Mon, 29 Apr 2024 14:31:45 -0700 (PDT)
Received: from m1x-phil.lan (bny92-h02-176-184-44-142.dsl.sta.abo.bbox.fr.
 [176.184.44.142]) by smtp.gmail.com with ESMTPSA id
 p6-20020a05600c468600b0041563096e15sm47015588wmo.5.2024.04.29.14.31.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 29 Apr 2024 14:31:45 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v2 10/13] accel/tcg: Remove NULL check in tcg_flush_jmp_cache()
Date: Mon, 29 Apr 2024 23:30:47 +0200
Message-ID: <20240429213050.55177-11-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240429213050.55177-1-philmd@linaro.org>
References: <20240429213050.55177-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

I /think/ this check added in commit 4e4fa6c12d ("accel/tcg:
Complete cpu initialization before registration") is now
unnecessary, but I don't have the WASM reproducer mentioned
in:
https://lore.kernel.org/qemu-devel/20221027141856.w5umjgklawgu7pqv@heavy/
to confirm. Ilya, do you mind testing? If so, we could
squash this with the previous patch.

Cc: Ilya Leoshkevich <iii@linux.ibm.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/tcg/translate-all.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index ca1e193633..9b02f21b23 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -652,14 +652,8 @@ void cpu_io_recompile(CPUState *cpu, uintptr_t retaddr)
  */
 void tcg_flush_jmp_cache(CPUState *cpu)
 {
-    CPUJumpCache *jc;
+    CPUJumpCache *jc = &cpu->accel->tb_jmp_cache;
 
-    /* During early initialization, the cache may not yet be allocated. */
-    if (unlikely(cpu->accel == NULL)) {
-        return;
-    }
-
-    jc = &cpu->accel->tb_jmp_cache;
     for (int i = 0; i < TB_JMP_CACHE_SIZE; i++) {
         qatomic_set(&jc->array[i].tb, NULL);
     }
-- 
2.41.0


