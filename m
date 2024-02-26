Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A563C48BF6
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 20:18:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rehPu-0001dm-W0; Mon, 26 Feb 2024 15:17:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1rehPs-0001dK-KY
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 15:17:36 -0500
Received: from mail-oi1-x22b.google.com ([2607:f8b0:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1rehPr-00080T-34
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 15:17:36 -0500
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-3bb9d54575cso2843902b6e.2
 for <qemu-devel@nongnu.org>; Mon, 26 Feb 2024 12:17:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708978653; x=1709583453; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G8J7F2iE5kae+EJMR1Fj9GxIukzXTHmw7zGOIwbFMQA=;
 b=BE8twdb330PofWpkkN7hEK/zvyaZBgFRcswu9WsSXDR3J9zzF+DaHKruUAiQtTq/bY
 YkVVaWp5RpQU0OPdmdTMUzNqScyHEb0eLNnSdxe/xm7eOicrSfx9oSwP6IuTuyKD1GGW
 5QXgPtdBe0xd9bYQKfkKEXX9m1MAxHnw/h2WGMehyEHARYKlxqVbOBEDc3E4CPpkX+hy
 z31RPtQ8ZGxENIP8qfwbkTBx71214ydmHg8N95OBUHiKuEXkwgawsSLl3TnCVhNlAY74
 AB4eo9FJ5Gi586QC7jBWdq3vxn7Uw0ila+0FmTTVwgX8JO4E2f1gQ2+7aRNKtMMV7H6R
 kmKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708978653; x=1709583453;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=G8J7F2iE5kae+EJMR1Fj9GxIukzXTHmw7zGOIwbFMQA=;
 b=AO3TZKz5MXwRpXA12wngs1I6JOd7dS/rhp+wXTpjeoPBxAMc3MN/wC8IKi7Wt6yuej
 O4aIrLSy2wofpvqwWsEx+ZoBecCg8wfelvdiwAZ3Gk3hFDN4+tz9DwE18ZzKju3+F39H
 IP/SkjcR5BZsWHXrGq6ZVOksVTqN09/BBcS88WyisfRvQ3mMfl3ngmrpbyLBWvYoji5R
 kPQJMOXKUjxw86mIUEJoeuK9URlECBVgGy21e05K/7ZjSue7echt3731fkSNEtzxTqfW
 5GB5IM5dQ3XLvMA7YUuSWgMbs+mBpyVZsw/1JZuiRxYjkIUBl4PEeiVLRhgjrEecmS76
 ZHQA==
X-Gm-Message-State: AOJu0YxLpvwqRFbUEiiakfjN/P5yRQFS0bRAsNVgMUO37+8z/Z75YyWf
 fsCwb9qQwY0qdvZQUcNfOiwgnG7g1k4Vx6YUxHGqf1WsvrYvL1BjZ2NKoVHRO+E=
X-Google-Smtp-Source: AGHT+IEF+Gf5eHD4D9fvOwUflsXd+8nXtTRdx8mW78HPwg4g0NWFhwKusFrCTpriaLNL/8rqcJIscg==
X-Received: by 2002:a05:6808:17a6:b0:3c1:9b7b:5836 with SMTP id
 bg38-20020a05680817a600b003c19b7b5836mr256826oib.12.1708978652743; 
 Mon, 26 Feb 2024 12:17:32 -0800 (PST)
Received: from taylor-ubuntu.austin.rr.com (068-203-008-061.res.spectrum.com.
 [68.203.8.61]) by smtp.gmail.com with ESMTPSA id
 by11-20020a056808340b00b003c1a4a9ad17sm330594oib.46.2024.02.26.12.17.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Feb 2024 12:17:32 -0800 (PST)
From: Taylor Simpson <ltaylorsimpson@gmail.com>
To: qemu-devel@nongnu.org
Cc: bcain@quicinc.com, quic_mathbern@quicinc.com, sidneym@quicinc.com,
 quic_mliebel@quicinc.com, richard.henderson@linaro.org, philmd@linaro.org,
 ale@rev.ng, anjo@rev.ng, ltaylorsimpson@gmail.com
Subject: [PATCH 5/9] Hexagon (tests/tcg/hexagon) Test HVX .new read from high
 half of pair
Date: Mon, 26 Feb 2024 13:17:18 -0700
Message-Id: <20240226201722.391879-6-ltaylorsimpson@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240226201722.391879-1-ltaylorsimpson@gmail.com>
References: <20240226201722.391879-1-ltaylorsimpson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22b;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-oi1-x22b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Make sure the decoding of HVX .new is correctly handling this case

Signed-off-by: Taylor Simpson <ltaylorsimpson@gmail.com>
---
 tests/tcg/hexagon/hvx_misc.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/tests/tcg/hexagon/hvx_misc.c b/tests/tcg/hexagon/hvx_misc.c
index b45170acd1..1fe14b5158 100644
--- a/tests/tcg/hexagon/hvx_misc.c
+++ b/tests/tcg/hexagon/hvx_misc.c
@@ -1,5 +1,5 @@
 /*
- *  Copyright(c) 2021-2023 Qualcomm Innovation Center, Inc. All Rights Reserved.
+ *  Copyright(c) 2021-2024 Qualcomm Innovation Center, Inc. All Rights Reserved.
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
@@ -231,6 +231,7 @@ static void test_masked_store(bool invert)
 static void test_new_value_store(void)
 {
     void *p0 = buffer0;
+    void *p1 = buffer1;
     void *pout = output;
 
     asm("{\n\t"
@@ -242,6 +243,19 @@ static void test_new_value_store(void)
     expect[0] = buffer0[0];
 
     check_output_w(__LINE__, 1);
+
+    /* Test the .new read from the high half of a pair */
+    asm("v7 = vmem(%0 + #0)\n\t"
+        "v12 = vmem(%1 + #0)\n\t"
+        "{\n\t"
+        "    v5:4 = vcombine(v12, v7)\n\t"
+        "    vmem(%2 + #0) = v5.new\n\t"
+        "}\n\t"
+        : : "r"(p0), "r"(p1), "r"(pout) : "v4", "v5", "v7", "v12", "memory");
+
+    expect[0] = buffer1[0];
+
+    check_output_w(__LINE__, 1);
 }
 
 static void test_max_temps()
-- 
2.34.1


