Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02E18E77183
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 16:28:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLPS4-0000Im-Uz; Wed, 11 Dec 2024 11:20:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tLPRz-0000G2-9c
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:20:35 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tLPRx-0007iB-QT
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:20:35 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4361e89b6daso5559135e9.3
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 08:20:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733934032; x=1734538832; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=VgRz67Z5K6+YnxII3Thd0LIi5lCTv/FCJxlYwTXEoK0=;
 b=S5AL4420Wy1Guhf34quhFhNx9MGkvlfLMIbQt9RPyHfm3vIaS1tlH0Ozi+PnCWXrmQ
 ztLcdNOha1wTbkjds1AH90tB4ekWEpqkfGnHZ07eZ9SWwcefIMH/xgfX/B9P6keINreh
 MfJRSix3ZXutFGxbE+cKdn3xOVK2wKd+cJA9TD2xVvU+g/mXlERh6zLCpKOH48Z3h9/4
 IrGN0LT+dNUPEdMm1GVlxdJ5V30eicDi23nXBhTG4MBvqfisJRxayvPHPWoYaua4TIXd
 LzJmfrVIK9yM25bIuIbyedxi/y4lJkigAV9l6zLwq5s9DsoX0w6fr3lD0agFlgB4TSTB
 2Atw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733934032; x=1734538832;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VgRz67Z5K6+YnxII3Thd0LIi5lCTv/FCJxlYwTXEoK0=;
 b=RO25eGhCtq8c9naMRzoCyWZQ5TMdjV+H5HiuzpLEaT3TA7eNCJhEAfwRIejXwqpdVf
 rhfe083A0qaI983ZO/W5DZ8LmWt+hi+iRHt77QkhjD2Yd3CZsLHgJC42mMXiCVPDpS3R
 +9u3US2eHP9DDd7X0Yw0CFdA89PWzgs+kdjYSxzn6bpq8SJAZdy5B5C1Z3z/uWiRbuIf
 EPjiqOX7COigxpMzOC15YvV0+cTZam+IH9xCzGP/30eck03hTE4rnKevy4TGjP9LOKVQ
 63Y93KOWzwCw9mRYYHrPSiDbDbTqqKHLTV+vQY91c182PSwfhxZzthT7aalkgQKDYBSt
 V58A==
X-Gm-Message-State: AOJu0Yxx0O0rrzIkWjhDW3MulpO/CJlggex62k+yeX4zI0s3fq+YoTGS
 eioglPFzihvAsRA1+1UgTzjVJrfLW41JwzLecYtFOw9fAax93XHA2iIFCO6wvqawqkmj8kUp1V3
 K
X-Gm-Gg: ASbGncvZ765iLDLIMM9RIRt++jgkGhHV0y2YHlT6zs1jwyFFcBZicihfrsQ5WFCrFCf
 NcxRaf1zqWRHxXgpCIsZs0gggpb9l2P5SFkP0rUAmqp3VDuCcLcMYXXnHwHbVIn85UfdEyOFMj7
 UNX2VAAZ7c/DjQVaXZXUbyzuVLGcDOOL6wxXvnB3GuSqU8xu82PsuU9hmD8670rOLZ5/2XjVXk4
 q9lzSjgsjDT9ep5Pq/0tdxW6m86nCs/Xer+QkfENmWYZdh2mw43XHWIZ0XJ
X-Google-Smtp-Source: AGHT+IFzTBAHrP+RL+Z+z6uM11RfGmE2xoDOAyrbZBgTTim4wqommtjom1wYb/mQtS9keFTd+/JgoQ==
X-Received: by 2002:a05:600c:3552:b0:434:f131:1e6d with SMTP id
 5b1f17b1804b1-4361c360e94mr33896165e9.10.1733934032172; 
 Wed, 11 Dec 2024 08:20:32 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434f4dfdcdfsm121460595e9.39.2024.12.11.08.20.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 08:20:31 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 21/72] tests/fp: Explicitly set 3-NaN propagation rule
Date: Wed, 11 Dec 2024 16:19:13 +0000
Message-Id: <20241211162004.2795499-22-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241211162004.2795499-1-peter.maydell@linaro.org>
References: <20241211162004.2795499-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
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

Explicitly set a rule in the softfloat tests for propagating NaNs in
the muladd case.  In meson.build we put -DTARGET_ARM in fpcflags, and
so we should select here the Arm rule of float_3nan_prop_s_cab.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20241202131347.498124-17-peter.maydell@linaro.org
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


