Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3A16D78320
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 13:37:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tI6Ye-0001Mf-OS; Mon, 02 Dec 2024 08:33:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tI6H3-00033l-2P
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 08:15:38 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tI6GY-0003EW-TE
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 08:15:36 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-434a736518eso53475065e9.1
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2024 05:14:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733145255; x=1733750055; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I1o8XZNdx+7TX2Hd+GlCvP6YeG8j6TyLd31LJRVrH9U=;
 b=XWxwHwcf2W2NDuErBMhXqVtSpPUEAySQHSDIFRXVd4jGnQathLuzce3hFfiABubNBM
 ym+DQGcMduvkiQIf5e5xY/fyaEasUJRdhr54GfV/cFqY0eQG4X1NXFMsfDdnNnJLYFyw
 c9OPJGpAQY/pwSx3zSQO30OmFZVK+MmmTizfyyH2n48vOb9XfAHsYWcgeJKeWWxHEdrr
 jYie/btJAaGfFQebyGqxke26Zn1jTLc3ZhEC06azm5CMoo7uZuTx7Mv2u4Jykx2HrTaJ
 590ctuy8gzjRAebsKww0Bv0DA4olR60mGKRdYEahUv6wyXg1XqYnUe0WnCoMZ6yN52P4
 0FZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733145255; x=1733750055;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I1o8XZNdx+7TX2Hd+GlCvP6YeG8j6TyLd31LJRVrH9U=;
 b=H2E2hIOzEusJ0PQLEuO9if39ftXUDkJ6tVbtgpGvvSgTI0fru1VfgQaE0E3cqlKGqh
 JTqxceUf8zL3m8h90dp+KTC0XCJGrUrRcu+52vVQAOF9MLljEhOJMcCXxKwOqKgmnBSY
 /IHt0Pb/R/0TKdQ+0C8cIq1nm4jFnVlBPLCrq1TRbjan2rpUgVuDzqmuF0HUL6cpNCOE
 DtOhcaqyYuiZXlEoKH2xC/FMPIG+rmk93BuiOvNmMVSZ/ALoFOgdDq5H74QWP2CcT3Ni
 Ok2pwlS/yKcBG52N2KC4d8eiQR4dmQzx7mLZRphwcoA0ZD8HDHiutEG9fhdAqg1cGUHf
 hfAg==
X-Gm-Message-State: AOJu0YzXf7zZzJ+IxyMOvOyxUZgpfFvwJskUveTxnu6A24+fDaVMlBv6
 9M9HOJJ/L0W2AjpTzk5gaH/IFnqZv7PwFh+9wi61Dx6T7Rg6rk5NzGWwRPJ4APZttIiBxFvsZPz
 D
X-Gm-Gg: ASbGncuxFMO/jEQLoR3Iy3cQ1H1AOPlrakqpfSZTWNTPf5dYAW51VdS4PCxjv65ld+G
 srfJ8ky1fu8W7MuTkemBLo87tvrESrSqhhMYyJQkJ6z7UFlekJ8rq7oYe0RCTcR0e2C06nuriM1
 mAepLLNuEBB1QpuOFRU/I6NhpkLmCZyG1E7GErN7llnQJo4apjVR6+1Zavp66gMtQSnJvr/Uh9Z
 XPI4MaMVvXqLb10nnL1kch7fx8v+s0AUrGZS1A3/Ql5FJzlk9hxkh0=
X-Google-Smtp-Source: AGHT+IHC0YjjZ9AQjXw67UBGp3IT7FRgmD1pMeQ/h0Fw/MRF7TXN1I7D+96J+L1KlfsQ3kwY/1WEJQ==
X-Received: by 2002:a05:600c:5024:b0:434:a1d3:a321 with SMTP id
 5b1f17b1804b1-434a9dbb663mr276864655e9.3.1733145255500; 
 Mon, 02 Dec 2024 05:14:15 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-385dea1e4ebsm10160157f8f.1.2024.12.02.05.14.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Dec 2024 05:14:15 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Song Gao <gaosong@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH v2 for-10.0 16/54] tests/fp: Explicitly set 3-NaN propagation
 rule
Date: Mon,  2 Dec 2024 13:13:09 +0000
Message-Id: <20241202131347.498124-17-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241202131347.498124-1-peter.maydell@linaro.org>
References: <20241202131347.498124-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
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

Explicitly set a rule in the softfloat tests for propagating NaNs in
the muladd case.  In meson.build we put -DTARGET_ARM in fpcflags, and
so we should select here the Arm rule of float_3nan_prop_s_cab.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 tests/fp/fp-bench.c | 1 +
 tests/fp/fp-test.c  | 1 +
 2 files changed, 2 insertions(+)

diff --git a/tests/fp/fp-bench.c b/tests/fp/fp-bench.c
index fde64836194..39d80c9038f 100644
--- a/tests/fp/fp-bench.c
+++ b/tests/fp/fp-bench.c
@@ -493,6 +493,7 @@ static void run_bench(void)
      * doesn't specify match those used by the Arm architecture.
      */
     set_float_2nan_prop_rule(float_2nan_prop_s_ab, &soft_status);
+    set_float_3nan_prop_rule(float_3nan_prop_s_cab, &soft_status);
     set_float_infzeronan_rule(float_infzeronan_dnan_if_qnan, &soft_status);
 
     f = bench_funcs[operation][precision];
diff --git a/tests/fp/fp-test.c b/tests/fp/fp-test.c
index 251c278ede9..f290d523ab1 100644
--- a/tests/fp/fp-test.c
+++ b/tests/fp/fp-test.c
@@ -940,6 +940,7 @@ void run_test(void)
      * doesn't specify match those used by the Arm architecture.
      */
     set_float_2nan_prop_rule(float_2nan_prop_s_ab, &qsf);
+    set_float_3nan_prop_rule(float_3nan_prop_s_cab, &qsf);
     set_float_infzeronan_rule(float_infzeronan_dnan_if_qnan, &qsf);
 
     genCases_setLevel(test_level);
-- 
2.34.1


