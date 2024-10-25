Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB7A0D0C616
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2024 14:18:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4L4I-0004VJ-9m; Fri, 25 Oct 2024 10:13:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t4L4A-0004PK-Kq
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 10:13:26 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t4L3y-0007uk-EN
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 10:13:26 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4314f38d274so27178475e9.1
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2024 07:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729865593; x=1730470393; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ID1X5YPOP+wvOiim/+MbdA0+ojv9rI9zYRkjUusf1JE=;
 b=frUVCa6zjscDYAOYmoQ8cjuBVXi9RkfQzHEIXNN41ZZV86q2w5A/+NuWeG/1eSgVxq
 kjH0pmkygx55ygkHZoSbT4CSLBwcoKHx1ZlT8aP2tmon9HxCA4/BMUXlSlnlc7hIa+st
 v4M5JI+s/p3+C+6oVGnIB5yxH7F2blMWFXiALkAYNsTIY4IUZHVGv3+K1N6u9xeodi1x
 6ofMEW5gthepKcGKjPP/nniHttGyqCvwWCc7fTHq2LAdwnp7KfKadl4LBF5jGaWfeqMm
 K8viK/smDnec+yXRuxV3NlZidwycqY47bZQe1N+gvO9/noWRYMRawwiaT6NQ/WlAB7BL
 4Geg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729865593; x=1730470393;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ID1X5YPOP+wvOiim/+MbdA0+ojv9rI9zYRkjUusf1JE=;
 b=vqQU9EAb9R6LQx8k63hrVg4hzNP5aJUjsMvlA+mqe9WcT47fA5EODfTwcBPcCCTM72
 dH8CfP0MeA5l6DTo3uNv5zP6qmyMyje2aXsTWUh9Axc6kYIJLQd84hnG0VlFY29S9E0g
 OX/mDyNaepuVQUFGmFNSkI+WZ8lKpAEUxfFDDwlPvIVCFMb+M7dy3KFe2jgGPo2tkiJf
 nGTAY/217PVu7kvGZGh1FoHYyqnHqOD5groDPxqiGC5hy46StEAOtXD/0CTPDRvNzLrX
 2i8Q3oPwo5tJY7GxZqDmHrfUwgeToHcgCxcFB0+sM2sOiFfQfJNcn52UsY2aa1k3EEpy
 9wkg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVn1jWLWtTyS0zKDzJyQ86UnVdHj77R3RgDGyvfOCNczTK2RQiN7DhJFAn0jQqf15+vPBEEJO8KT0hi@nongnu.org
X-Gm-Message-State: AOJu0Yz+8RprHoMc9OHKYvGBeP1fXps4vuN0TLhSUlpEuhJV4LP9eH4B
 vexVAbozARx4pzjn3imPUdl9RisVdqNPMk2zitla6n1RnkWvGDwgkaeo5WcXCpM=
X-Google-Smtp-Source: AGHT+IGy1w+80bOSIQXUmP56n98o4p/PcDYHpGIXkWufhknYuh37RULU8ikJ7ZEtnUhTzvm7qJRzVw==
X-Received: by 2002:a05:600c:4f04:b0:431:24c3:dbaa with SMTP id
 5b1f17b1804b1-4318c8db165mr63501525e9.2.1729865592796; 
 Fri, 25 Oct 2024 07:13:12 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4318b57b051sm50104535e9.42.2024.10.25.07.13.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Oct 2024 07:13:12 -0700 (PDT)
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
Subject: [PATCH 19/21] target/openrisc: Explicitly set 2-NaN propagation rule
Date: Fri, 25 Oct 2024 15:12:52 +0100
Message-Id: <20241025141254.2141506-20-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241025141254.2141506-1-peter.maydell@linaro.org>
References: <20241025141254.2141506-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
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

Set the NaN propagation rule explicitly for the float_status word
used in the openrisc target.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/openrisc/cpu.c          | 6 ++++++
 fpu/softfloat-specialize.c.inc | 2 +-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/target/openrisc/cpu.c b/target/openrisc/cpu.c
index 6ec54ad7a6c..b96561d1f26 100644
--- a/target/openrisc/cpu.c
+++ b/target/openrisc/cpu.c
@@ -105,6 +105,12 @@ static void openrisc_cpu_reset_hold(Object *obj, ResetType type)
 
     set_float_detect_tininess(float_tininess_before_rounding,
                               &cpu->env.fp_status);
+    /*
+     * TODO: this is probably not the correct NaN propagation rule for
+     * this architecture.
+     */
+    set_float_2nan_prop_rule(float_2nan_prop_x87, &cpu->env.fp_status);
+
 
 #ifndef CONFIG_USER_ONLY
     cpu->env.picmr = 0x00000000;
diff --git a/fpu/softfloat-specialize.c.inc b/fpu/softfloat-specialize.c.inc
index 40cbb1ab73b..ee5c73cad46 100644
--- a/fpu/softfloat-specialize.c.inc
+++ b/fpu/softfloat-specialize.c.inc
@@ -407,7 +407,7 @@ static int pickNaN(FloatClass a_cls, FloatClass b_cls,
     || defined(TARGET_S390X) || defined(TARGET_PPC) || defined(TARGET_M68K) \
     || defined(TARGET_SPARC) || defined(TARGET_XTENSA) \
     || defined(TARGET_I386) || defined(TARGET_ALPHA) \
-    || defined(TARGET_MICROBLAZE)
+    || defined(TARGET_MICROBLAZE) || defined(TARGET_OPENRISC)
         g_assert_not_reached();
 #else
         rule = float_2nan_prop_x87;
-- 
2.34.1


