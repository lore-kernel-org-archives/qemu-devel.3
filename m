Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 532F0D1268A
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 11:21:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8HbA-0004RJ-1t; Tue, 05 Nov 2024 06:19:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t8Hb7-0004QQ-JH
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 06:19:46 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t8Hb3-00074y-UK
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 06:19:45 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4315e62afe0so45657845e9.1
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 03:19:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730805579; x=1731410379; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=PpqwR/1H2EcJ1oj53HzNbcXsnQdNGMTHaKQ/8EPL8YI=;
 b=SYUVtkAFtVW4ohN/yw6g3Afya/m+D3uSFKpHRmrQH2MjALQgigYJKNHIHPd95i8WZC
 yna82juLOWpWaGpRIC+vhYk+QjF8pY5cAYLmNbXnTi1KJe6+1ajBNEuUnUmLixxIyPGM
 3w8Me6wvnvIzC7MKjD3UqFcNH8tsTlboOq3lCPhCVO7jpTsmZpj3jRj1g3gUC9F6KVdI
 X22OoGE/PbqW13yLO7srFP1hPDtgrPsQb5AidzBrYOQ4KoLTpw0LDRW47rQmeeoKePck
 MFM17eVJ1ozKifQMr1wIqU9Eft3UsnftZQW/0ycbrmbyMsP1IY0rzw+8tlW/Z5xo8ydi
 vi8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730805579; x=1731410379;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PpqwR/1H2EcJ1oj53HzNbcXsnQdNGMTHaKQ/8EPL8YI=;
 b=bRVfAdXruOokAaSaFod1/X7PJg77IL0OObc8RNDJ04P5w+DkCUuvWjmLqj1Q5dcMiq
 tx3DAw5zu5vL/8rnXH+SwViZQWS8c6L6fzE5I5HUdoWEMoGzsGgippcJ6emquytJ4hRm
 yvnAf4cZqb7Xaw5PcgQRs1JlWNp+u5XV6OJ+DeC3DJ4AKCQGVuZiBnQEkmJnVVVOSSwm
 /kX8GR3+87q9xWiQfW/WZwHnfhZv9z4lnat6QqY2mFs2HMCI5yQEoQXBtmG+vlLpDeIV
 3gdqLAE0mv6y3oPyJx1ILQjsdhRDEVnB2+X8fL/2oRKVT+xnqFI52Q5h5hFyTEreSRxd
 BU/A==
X-Gm-Message-State: AOJu0Ywc97dOjdpOOe1Qgye3SQZNGXDgPGDHK1Qk7X5ybmaJpPv9+MEx
 2x9ZlBnFSBKxpGQZ6ckcAkKnmBb36aXYCleATNEiJtWw3OMucy1QVE6fFZODVUNllHMOdpoHCS1
 n
X-Google-Smtp-Source: AGHT+IG77r+9OsiPmL+SCGyvG2HBEtkjdn69NvQKH7VazKuNR3TOgBwOpkWwQkVj3+NmywzThfpXvg==
X-Received: by 2002:a05:600c:44c7:b0:432:7c30:abe6 with SMTP id
 5b1f17b1804b1-4327c30aceemr168130635e9.21.1730805578931; 
 Tue, 05 Nov 2024 03:19:38 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432a3688813sm16354555e9.1.2024.11.05.03.19.38
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Nov 2024 03:19:38 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 02/31] tests/fp: Explicitly set 2-NaN propagation rule
Date: Tue,  5 Nov 2024 11:19:06 +0000
Message-Id: <20241105111935.2747034-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241105111935.2747034-1-peter.maydell@linaro.org>
References: <20241105111935.2747034-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
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

Explicitly set a 2-NaN propagation rule in the softfloat tests.  In
meson.build we put -DTARGET_ARM in fpcflags, and so we should select
here the Arm propagation rule of float_2nan_prop_s_ab.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20241025141254.2141506-3-peter.maydell@linaro.org
---
 tests/fp/fp-bench.c     | 2 ++
 tests/fp/fp-test-log2.c | 1 +
 tests/fp/fp-test.c      | 2 ++
 3 files changed, 5 insertions(+)

diff --git a/tests/fp/fp-bench.c b/tests/fp/fp-bench.c
index 8ce0ca1545d..75c07d5d1f1 100644
--- a/tests/fp/fp-bench.c
+++ b/tests/fp/fp-bench.c
@@ -488,6 +488,8 @@ static void run_bench(void)
 {
     bench_func_t f;
 
+    set_float_2nan_prop_rule(float_2nan_prop_s_ab, &soft_status);
+
     f = bench_funcs[operation][precision];
     g_assert(f);
     f();
diff --git a/tests/fp/fp-test-log2.c b/tests/fp/fp-test-log2.c
index 4eae93eb7cc..de702c4c80d 100644
--- a/tests/fp/fp-test-log2.c
+++ b/tests/fp/fp-test-log2.c
@@ -70,6 +70,7 @@ int main(int ac, char **av)
     float_status qsf = {0};
     int i;
 
+    set_float_2nan_prop_rule(float_2nan_prop_s_ab, &qsf);
     set_float_rounding_mode(float_round_nearest_even, &qsf);
 
     test.d = 0.0;
diff --git a/tests/fp/fp-test.c b/tests/fp/fp-test.c
index 36b5712cda0..5f6f25c8821 100644
--- a/tests/fp/fp-test.c
+++ b/tests/fp/fp-test.c
@@ -935,6 +935,8 @@ void run_test(void)
 {
     unsigned int i;
 
+    set_float_2nan_prop_rule(float_2nan_prop_s_ab, &qsf);
+
     genCases_setLevel(test_level);
     verCases_maxErrorCount = n_max_errors;
 
-- 
2.34.1


