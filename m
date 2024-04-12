Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 338ABC04FF6
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2024 07:36:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvBQO-00076F-Op; Fri, 12 Apr 2024 03:34:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rvBQL-00075o-Lr
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 03:34:15 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rvBQH-0007Cx-Bu
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 03:34:12 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-6ecf3943040so590694b3a.0
 for <qemu-devel@nongnu.org>; Fri, 12 Apr 2024 00:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712907245; x=1713512045; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SD4AFTXyCoH1gQiMjEXl2qngbfpinlSjJhmj7iTFm1s=;
 b=d8kiwJ09tTOoem0RH9l2oMbxyLJKBTUoO0z3VB1eh9vG/Nwc2lCspwuLIMp3MlK3l0
 1eKDaiUNHcUBYEdjXX8lTd/qT4Xm7TEGKThRtgFtulHFFQjyAdbkNjc0T/bWnPYY72yU
 aqvLOIh+l3yuFxzrPXXDvqAa/YqKqYZkzLsii2Ew0sM9Oy7vMP6yUKO6bxucpTESm4qu
 yJ/3z2nlKXuEtwzlkW/eFIebjPEdJmvd0+6AS6aTfVJ0/2golKD1IDbJfeR3S1Z7xX60
 UX3Kp7TWE8ECkPwVmYbAfrH5rjYzI76SldtqpNSO9ZhJAdK26AI2CovzAh+eM3lc5Uw9
 JykQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712907245; x=1713512045;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SD4AFTXyCoH1gQiMjEXl2qngbfpinlSjJhmj7iTFm1s=;
 b=M6DPhfE1DJRWMa3M9akWKuVPvWbX7DZlsPGnCKlpTX77uaXSHeBrGLWF9+FZ86w/x6
 CYIhDVx5WIIWkg6rcPLvP0or8rzD//qpwpxWFFago9m6iggqvmWQOBL0uvWS3Cy4qM+5
 Tn1ydAeJDm9YIhA0d/CmL4JR4FhRS6k7286LTEfQKtifmh7onmBgRVKiB/qoJqB+49FH
 385Ug6e7+Zi3R5m/lZB7sIRsxlmw9r2SjGNJpb3w6HEZj65zXc+9T/u4EnrHioAOhUsk
 VNFwWJAKHleo1sqIf0jjpGJf0WNEGGtZc1A+p4pMLfb7iEJTSoIaG6FhySgIU2VAaLms
 tnWA==
X-Gm-Message-State: AOJu0Yxh0zmok7czmxzmoL75LIDFcZsF4nKlHlDQwzhP3sQx0pnt81eE
 yVSmDrrHDsChFBXcG0MS34NFe1Q9ZbNl3tvZ2Gvhz0abRbVSuUj9j/UbS0/5FWzqmmH3bVRI18Z
 j
X-Google-Smtp-Source: AGHT+IGXw2bxDzoQnxtljKtVtj4Xto5md8qwPUVkUeCmEIb4oNB+jUeyCGUzB8/EZS/+BjjWWo0ceQ==
X-Received: by 2002:a05:6300:630e:b0:1a7:a21b:66f9 with SMTP id
 jn14-20020a056300630e00b001a7a21b66f9mr1823376pzc.43.1712907245187; 
 Fri, 12 Apr 2024 00:34:05 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 e5-20020a17090301c500b001e556734814sm2206099plh.134.2024.04.12.00.34.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Apr 2024 00:34:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 22/27] linux-user/flatload: Replace sprintf() by snprintf()
Date: Fri, 12 Apr 2024 00:33:41 -0700
Message-Id: <20240412073346.458116-23-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240412073346.458116-1-richard.henderson@linaro.org>
References: <20240412073346.458116-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

sprintf() is deprecated on Darwin since macOS 13.0 / XCode 14.1,
resulting in painful developper experience. Use snprintf() instead.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20240411104340.6617-5-philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/flatload.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/linux-user/flatload.c b/linux-user/flatload.c
index 5b62aa0a2b..1bb2f400bc 100644
--- a/linux-user/flatload.c
+++ b/linux-user/flatload.c
@@ -692,7 +692,7 @@ static int load_flat_shared_library(int id, struct lib_info *libs)
 	char buf[16];
 
 	/* Create the file name */
-	sprintf(buf, "/lib/lib%d.so", id);
+        snprintf(buf, sizeof(buf), "/lib/lib%d.so", id);
 
 	/* Open the file up */
 	bprm.filename = buf;
-- 
2.34.1


