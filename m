Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384E2606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 14:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=hPxDop5K
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKG3Q-0003UT-7Z; Fri, 23 Oct 2026 10:15:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xKG3K-0003L4-2D
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 10:15:26 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xKG3I-0006kx-6l
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 10:15:25 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4a214af2076so5073735e9.0
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 07:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792764923; x=1793369723; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bAxKmAS889O5MIMMW1OsCz8fGhgLVOUcUzqpZiMkmkw=;
 b=hPxDop5KNt78gDyzpq/LR02c1n61GQ46LpkgLAIKHBibptdyqzTMyhymGsXoqTBYRC
 ZB5BKkCXeMr+HV/L7D+q19Ckjnh6CsoW83tXHDMAgp0wKJJ71Y5s6iuWQPCi6zCk7UkZ
 1pkVLNI9Emim2+fULuhgK2zwXCxvDEOFBseSGwXflTatw3V0LJ8L8ZGK7o2CoGNDnYd6
 oFwS02LYsfnkPa+sTyI5YsBGIy7l7SNDMbedXXMiOTw4xg7ma2uQQvODwTua4nRPEAhd
 EYtXhyqAaLIvH3zgo8PSxJ4ruYWPS5C0PRvBguW+PrEvwOv5yAMf+3F2CV7FfllN7jpr
 MtAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792764923; x=1793369723;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=bAxKmAS889O5MIMMW1OsCz8fGhgLVOUcUzqpZiMkmkw=;
 b=osqNp8keItG56iLvqgDZChv12TulLNBL+Ye81p04+/lqvraOypwl6RZDhc7P74Xzdl
 H9IvyiZDfWkjBa00WVe3UNlpXioYChuH8lURWCQz6B44thTPN8Gc4bYTfvgMDduZICdA
 sM1McErAuDNajIYnBFBXHHfwjHiON9At8eFQU6nT8rhef6Vogx5QOklAFtNaYOD0e/bW
 ab9kX4UYHvHCHvSrsMCUkpsHAwr3hkpZHUhzlxgw6l96vGDU1DtdzD+2IIiGA7g3vjwm
 4Ytcp1rsl0O/sb0D2lOGhjDQOx51hDr15wXtL8yPkiH9uanGj6j7hXd5b+03kPOxwEMU
 Zo6w==
X-Gm-Message-State: AFq9FYIr1UPpBvGzbj4ua1rHxF46aaTtaNL1utl5V8r4kj7FT++tMBjv
 XVBYh4ky2SdecV0wBrQqkjBZudah3xk0mbhTOvR4lXTl+19LlzDbZHTQVGqlw0nnP88jYQVzk/N
 GHA3lY5Q=
X-Gm-Gg: AYBFou04EjDk9VHidHndhlyNJARHpZueimxQT9VkyYw+eaAOBDAcRvsmRrYbz/h1wIE
 oxdamBFzQU+JPLLkla1+LyAspRDD/CvUNrC2Vt+YG0cTB157weO7LdOZoBR1bXFswXevbvc5hUr
 m+s+Ye+kJlxrzNn/8vf2iKXO4rjevcJzvUd5Cd0WR8hAEMiXTjo0HgzgW5pXDz24j7hAh2derOV
 Nh719BRfo8BNQZCjpWwzSX0vHMZ1zod2yQtG2Yn7llZ04fpJ/XwGXwuQ1w3kUMQRjv0o0R4i3T0
 t6/JuTnnJJi/qN6J43Aury9rkiidMA6qfPlMr2BgX7CNLo7i0/V9GKq5R+Yb1pHvfbjociQMevz
 ClPJrzxgTD9FdbQybgVCjJFHMyGZbjnhSSZuR6tzvIkdNXsCyCp86R22JC33aasQUWCPhgdL03a
 FgG5DKbAIxpapcgwHfVuY6+/VBqC278sJ0fW9LzEtkbeUcFYEaKBKXHoNMvVUTnkOL6SDEEou0C
 UklzgtTTN4gAmjxsLEewTQ2qcd1WeoYFhNBfk5tMNjyuZ7B0XkkinkYFoXm7kI4uOvhWmlm7Pic
 m2jyOIOfkglNwWhYJOHDDqSt81oW+ACbpuRD5sGIJNq1gDqtyXkHEziyqx6TnZr8/gYatV44f2w
 RfpAbMw==
X-Received: by 2002:a05:600c:2196:b0:4a0:2391:6540 with SMTP id
 5b1f17b1804b1-4a211ee51famr27766015e9.25.1792764922755; 
 Fri, 23 Oct 2026 07:15:22 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a2fe31a7a4sm1310675e9.0.2026.10.23.07.15.21
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 07:15:21 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 11/16] hw/misc/bcm2835_cprman: Treat invalid clock mux source
 select as GND
Date: Fri, 23 Oct 2026 15:14:58 +0100
Message-ID: <20261023141503.1397009-12-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261023141503.1397009-1-peter.maydell@linaro.org>
References: <20261023141503.1397009-1-peter.maydell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The clock mux control registers in bcm2835_cprman have a 4 bit SRC
field that selects the input clock source to use.  There are only 10
valid SRC values.  Treat the invalid values as producing no clock
output, as if the GND clock source was used or the mux was disabled.
This avoids reading off the end of the mux->srcs[] array.

Cc: qemu-stable@nongnu.org
Fixes: fc9840850ba ("hw/misc/bcm2835_cprman: implement clock mux behaviour")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4695
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Luc Michel <luc@lmichel.fr>
Message-id: 20261019161900.3271815-1-peter.maydell@linaro.org
---
 hw/misc/bcm2835_cprman.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/misc/bcm2835_cprman.c b/hw/misc/bcm2835_cprman.c
index f9a77ff9bb0..10cad07623d 100644
--- a/hw/misc/bcm2835_cprman.c
+++ b/hw/misc/bcm2835_cprman.c
@@ -271,7 +271,7 @@ static void clock_mux_update(CprmanClockMuxState *mux)
 
     *mux->reg_ctl = FIELD_DP32(*mux->reg_ctl, CM_CLOCKx_CTL, BUSY, enabled);
 
-    if (!enabled) {
+    if (!enabled || src >= ARRAY_SIZE(mux->srcs)) {
         clock_update(mux->out, 0);
         return;
     }
-- 
2.43.0


