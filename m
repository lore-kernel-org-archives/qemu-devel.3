Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36FAFD0C617
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2024 14:17:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4L3x-00048O-E9; Fri, 25 Oct 2024 10:13:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t4L3s-00042x-57
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 10:13:08 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t4L3m-0007nI-CA
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 10:13:07 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4315c1c7392so21121825e9.1
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2024 07:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729865581; x=1730470381; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YDlbbvylJyMrU/YJShcxhMfUmai1iRbva+PhQ15qan4=;
 b=O2s93LMAgXPvuN0338XpNBLW0UNo2M5/Kgk+ROvEM52yyeaN5uzbmk2gYnF9lHu2Lc
 JDouInfGo/lSWGLNW0EqQiXo/1ZnwSUYL2+3D48lEkb0qKDNZytlqyByju9SP5TAXYWn
 wHsfh7G2sBpR7j6xBihiAFL13b4ug89XNOW5jTMBgVu2UovagfCoq+npfffyeEjcdGnW
 1QKBwiCn0Dlctx6oLTOYZOxqZEttcN91LdKz+jblhqItmYpQzk0P47Hy6UdHx17qy4LZ
 N0y3MAI/1G+kHb069gIRHXrzJ1SB0rGR99wpG7SZdF4vGf8BNOHl5x+pZIloTamiL0WQ
 /VGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729865581; x=1730470381;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YDlbbvylJyMrU/YJShcxhMfUmai1iRbva+PhQ15qan4=;
 b=AFzUpNvbQjzVdq82GrTYvl1NBTvgYGr0cJtOmzuDJy2fe9yK05ZyhF/TZtTLA1WPmJ
 Qdqmpr5NEEz8kg9KXjswRUOGGijXA6yiClDCFXQLXOOOh1Pq/7px+5jc41YyEB42FhW/
 FR441V7Tpc9oltjkefnKZY2VWtxojj+900AOQUN7B21pecwI4hqs1cxu2mlfGKYVE3RS
 ZPoRjuMq11LDK4kBOlotbNc4Re3HBlzOF1xXlYCK8fi9r1RvCcvMVtPcHZ3J2nDJu++P
 O+JtbEwpgAQrKs+NZm+YktiaQQjDOP8szqCnkhTz1JHsE4Zak/Q4IVh58VOB0UfOFzqN
 DiGA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUcNaRht+KrRATa1kshZL7CE3UIzImIPJCbMX9wXDii7DiICbKEB4jEMnWOqk9ipuFDUJH7SSDVmPP8@nongnu.org
X-Gm-Message-State: AOJu0Yzzt223NZSYxzzJqVNlc6yYZj/ZTl5B0q6RujqB8nDYLLGqUcg5
 uKmDLiDEXaJKRM2CNkxTkqEJU9y04lfB4RKovsvFOiKsVFD+POyVIRKwsSoqXbU=
X-Google-Smtp-Source: AGHT+IGhrCfW0xMsmU6S61HVoy3sW36vUuPi9HltT0dQ13BCpWIevBn1kVk6idl0Da/qYmgJw0nA8w==
X-Received: by 2002:a05:600c:1c03:b0:42b:af5a:109 with SMTP id
 5b1f17b1804b1-4318424eb98mr90790405e9.24.1729865580849; 
 Fri, 25 Oct 2024 07:13:00 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4318b57b051sm50104535e9.42.2024.10.25.07.13.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Oct 2024 07:13:00 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Song Gao <gaosong@loongson.cn>, Eduardo Habkost <eduardo@habkost.net>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Stafford Horne <shorne@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>,
 qemu-ppc@nongnu.org, qemu-s390x@nongnu.org
Subject: [PATCH 05/21] target/loongarch: Explicitly set 2-NaN propagation rule
Date: Fri, 25 Oct 2024 15:12:38 +0100
Message-Id: <20241025141254.2141506-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241025141254.2141506-1-peter.maydell@linaro.org>
References: <20241025141254.2141506-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
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

Set the 2-NaN propagation rule explicitly in the float_status word we
use.

(There are a couple of places in fpu_helper.c where we create a
dummy float_status word with "float_status *s = { };", but these
are only used for calling float*_is_quiet_nan() so it doesn't
matter that we don't set a 2-NaN propagation rule there.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/loongarch/tcg/fpu_helper.c | 1 +
 fpu/softfloat-specialize.c.inc    | 6 +++---
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/target/loongarch/tcg/fpu_helper.c b/target/loongarch/tcg/fpu_helper.c
index f6753c5875b..21bc3b04a96 100644
--- a/target/loongarch/tcg/fpu_helper.c
+++ b/target/loongarch/tcg/fpu_helper.c
@@ -31,6 +31,7 @@ void restore_fp_status(CPULoongArchState *env)
     set_float_rounding_mode(ieee_rm[(env->fcsr0 >> FCSR0_RM) & 0x3],
                             &env->fp_status);
     set_flush_to_zero(0, &env->fp_status);
+    set_float_2nan_prop_rule(float_2nan_prop_s_ab, &env->fp_status);
 }
 
 int ieee_ex_to_loongarch(int xcpt)
diff --git a/fpu/softfloat-specialize.c.inc b/fpu/softfloat-specialize.c.inc
index c60b999aa3d..bbc3b70fa9d 100644
--- a/fpu/softfloat-specialize.c.inc
+++ b/fpu/softfloat-specialize.c.inc
@@ -402,10 +402,10 @@ static int pickNaN(FloatClass a_cls, FloatClass b_cls,
         /* target didn't set the rule: fall back to old ifdef choices */
 #if defined(TARGET_AVR) || defined(TARGET_HEXAGON) \
     || defined(TARGET_RISCV) || defined(TARGET_SH4) \
-    || defined(TARGET_TRICORE) || defined(TARGET_ARM) || defined(TARGET_MIPS)
+    || defined(TARGET_TRICORE) || defined(TARGET_ARM) || defined(TARGET_MIPS) \
+    || defined(TARGET_LOONGARCH64)
         g_assert_not_reached();
-#elif defined(TARGET_HPPA) || \
-    defined(TARGET_LOONGARCH64) || defined(TARGET_S390X)
+#elif defined(TARGET_HPPA) || defined(TARGET_S390X)
         rule = float_2nan_prop_s_ab;
 #elif defined(TARGET_PPC) || defined(TARGET_M68K)
         /*
-- 
2.34.1


