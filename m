Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA348CD8CB2
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 16:21:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXLY8-0001YI-1Q; Wed, 10 Jun 2026 12:13:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wXLXm-00084E-VS
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 12:12:43 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wXLXl-0005Zk-Gm
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 12:12:42 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-4600cbb06deso14154f8f.1
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 09:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781107960; x=1781712760; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=c/TfSGVvY8nzxqxkofw6FPXPq3S+M9BJuc8yb76835U=;
 b=hyXCDqwliSBoPbxwujPhVfK8cMuikv4nvEyvsmiCX9moRzfRW7kD+/qRTtO3mOR1bu
 pIBUcXNNq+lFsgIGmJZMPxD55wileXNv+qyRJMAHLHV6QonEjeo+7Lb0hNEYW29cSj6W
 XhWXxECiiWMcuL7MiYkX/tejPHzIEDdCWtnUMfPieseKQsGwFznA/tkEfMjSTpdMvc7L
 77Q1ArSa/Dhw9qhQsNkEatjCkf9moOrIFehktz9GE8pYgVPx9eYksmfDUEg4YK5aMm4I
 v/YlC11e3no8b79zMkDU6u9IPu7sErb5S7ZPhuvBvO5xYBeUMeQYCvzzaYy5X6vxa4eK
 f4Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781107960; x=1781712760;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=c/TfSGVvY8nzxqxkofw6FPXPq3S+M9BJuc8yb76835U=;
 b=RH7MvDzMWJMDQTIZpffWrofTB3ndVdT0rAOOy+kA/660ilXnmIpkRHQw1uZbNY6bsu
 oQyzRXiWLsqKAEBy2wUVG0L4YTF3Q1mb+KbB+KZ1wcjPTydchmK2sFDfibEaC4YWpG+S
 wdllsouXhn4xt2i5UrZcEOrA3O2/MXcLfcth4NEwBR+qTesLhwO3uFdzt/bKzQ/vN8iB
 j6EFDt3xGC9wcXZxYGiG1ArTTuNmxkoIEu6rOXqjn88ouYv5dCqqIffJn/MdA0P59M7p
 /wraKvo8Y+5F9S44koEpcUW/v1+UzW6nCB9F3u9wG17aV+fo9patwzgNSJU4OozxhTKJ
 4ufA==
X-Gm-Message-State: AOJu0Yxg1wNUGhZDM9EnUPwm/IukDbDv103/lMevg38VA5GUtatyatBz
 eVljRbYZD5d9dAscPTKMBvmhkMiP3yuqz1d3o8ZjDSYAM8wdm2Rbnvgc6g1A4/nOS6/7Ex8Zu1J
 vJ4wW
X-Gm-Gg: Acq92OGreu1wJtjgX7d35sVTdGN34htuffbZmFVgZExpqFnE8vbCoOIzOcMWv7Sb2pJ
 tin4d9rdI9862tWVtmxnKmxGprINv+e9pPvaRWvX6dppTHZlYnLKvU77pkUIEsMtLvGCXJcdfVi
 dDkSj/nu5UtgGUJUxqz5uv/pFJ/66JGiD/h3l4lOI1TpjJfAQACt2hrvACqya7G7UoB9jdDnnb/
 jvW8SpRnBItdi3hHlzB6MxXXETm6eKz1Cz6El8pDZ25DMZHNvwxVkBPE6wK4OJ02ugI+qsWh9uJ
 b/w8B0ot98eE7P0lHHYbAGptbZxcXTYKZ2GB+a6NFN9iNj7XTSB2M1H1hQvzc/3g3nX77NjGK4r
 FbxmkcOt7RR5n4SI3UmsLP1lai7StMp5Tgroca/7raOmrdHp5VHfayIvFJMow2bKrm9z567dG79
 I6b1mOHsrkwKiOr7IwLibvoP69elSrl+nIqyzMme+QArv1cfMSfK5bWDucscFOWCErMjtDkIQns
 +eOredUZDvJL4OY3q1N+VuYa/ylvNOk/2+4nILtlZU=
X-Received: by 2002:a05:6000:cc1:b0:460:3210:950d with SMTP id
 ffacd0b85a97d-46032fd7d26mr23905451f8f.21.1781107959932; 
 Wed, 10 Jun 2026 09:12:39 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f2dcbe3sm67911360f8f.8.2026.06.10.09.12.38
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 09:12:38 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 26/71] fpu: Handle all rounding modes in
 partsN_round_to_int_normal
Date: Wed, 10 Jun 2026 17:11:17 +0100
Message-ID: <20260610161202.2235298-27-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260610161202.2235298-1-peter.maydell@linaro.org>
References: <20260610161202.2235298-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x431.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Missed float_round_nearest_even_max and float_round_to_odd_inf
in both switch statements.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-id: 20260608190155.637067-3-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 fpu/softfloat-parts.c.inc | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
index c86fc9ccc5..deb712e092 100644
--- a/fpu/softfloat-parts.c.inc
+++ b/fpu/softfloat-parts.c.inc
@@ -1127,6 +1127,7 @@ static bool partsN(round_to_int_normal)(FloatPartsN *a, FloatRoundMode rmode,
         /* All fractional */
         switch (rmode) {
         case float_round_nearest_even:
+        case float_round_nearest_even_max:
             one = false;
             if (a->exp == -1) {
                 FloatPartsN tmp;
@@ -1149,6 +1150,7 @@ static bool partsN(round_to_int_normal)(FloatPartsN *a, FloatRoundMode rmode,
             one = a->sign;
             break;
         case float_round_to_odd:
+        case float_round_to_odd_inf:
             one = true;
             break;
         default:
@@ -1195,6 +1197,7 @@ static bool partsN(round_to_int_normal)(FloatPartsN *a, FloatRoundMode rmode,
 
     switch (rmode) {
     case float_round_nearest_even:
+    case float_round_nearest_even_max:
         inc = ((a->frac_lo & rnd_even_mask) != frac_lsbm1 ? frac_lsbm1 : 0);
         break;
     case float_round_ties_away:
@@ -1210,6 +1213,7 @@ static bool partsN(round_to_int_normal)(FloatPartsN *a, FloatRoundMode rmode,
         inc = a->sign ? rnd_mask : 0;
         break;
     case float_round_to_odd:
+    case float_round_to_odd_inf:
         inc = a->frac_lo & frac_lsb ? 0 : rnd_mask;
         break;
     default:
-- 
2.43.0


