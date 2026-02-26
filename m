Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A574FD8FCE
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 15:56:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvdiJ-0005JH-Na; Thu, 26 Feb 2026 10:55:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vvdiI-0005IZ-6k
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 10:55:42 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vvdiG-0003jA-FW
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 10:55:41 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-43989bd056bso877883f8f.1
 for <qemu-devel@nongnu.org>; Thu, 26 Feb 2026 07:55:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772121339; x=1772726139; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=0aW5QS6awRTQP4v+qDxXUEry2KGxlG04nu2nu/gqLQI=;
 b=J36MTAcgAIhUUawqgeIJokWekE3mmTvTnpPBCYUAY8V7dQZRxJaRW4mzR+zGdmUHbT
 VqJGz4q74ytQdNOIee/jqGHis2Hhe7NrNIiXEXY/H6VBJMInHh7pUwjDh4pN0JkG5KCI
 UNGdRSKaO4lyaQesBaswGbh/CGVLAiWa9tCMx49L8lt7E0PX/WIqi95yc+26NwA3qYxU
 iQqeOGnDwZ69lzZVigGCqv9oYqSC24Y71yoq5iAR+gFxsdwE3xtc2P4mx4rmGNVdBDDA
 kvu2+gywHUXkLawFSfzQn/+xm3tXAXRY/uxnrKCmuSA11b5Gs551akm20B/57S/yms7b
 RTpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772121339; x=1772726139;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=0aW5QS6awRTQP4v+qDxXUEry2KGxlG04nu2nu/gqLQI=;
 b=m+55O4ih+/eDwrCk3Csrjp4bQJj0TW9mUKnlYZqRSzr5kTMIwkQzmiHCKVXxUhemrO
 86+n5J9psVhafJi3LsqCS3quto/Ta7XR/oxtjGPDSYBytkY2HpBWHd4QeZxGChBWT+aD
 pI3ov9NbptTpwKfR7UM/ogke13IqdNAWpKuPzDHTuP/uQmVPIGcv8azWJRNAFirp1dz5
 z4JzSfTDabycb759lDS5IWgaTn3veJJ+KOT17vbgIZbbmWnahB0jh6cYe/YfofgeBJHM
 EmxpYVRfYZcFXzUTspDfSUsq/HzgbM5Af4hA2YwB4huRYJN75GmJ5599V/27uyVsqHX+
 y4JQ==
X-Gm-Message-State: AOJu0YxSOtAC04uYvu+oWlBBCKj3dKcCTSK/78w8UoqUlW9XqumTYnLe
 XMhZdabLxYXuB5NJaMO5Cci20z2DzVYviBJuwHbn2sPc8abBKlnO+WauH8C5AkV6UUTbRzCoT+P
 bCSNv
X-Gm-Gg: ATEYQzw5gMhd9AZQh5GCkTQqW1wFl3W31xatxtsVvVRB2bYXYwwS13xHDbwVKTJh3AD
 BkL0/5Yy/40S+t8kqPg1C+U1Gg/qSGC7O1dtiw7QFrZTNYCPZRdx7M78UqH1sUPPhRYYVw1d1Gu
 dfpxNet/OmNi6i6F6eJV3zNFwAnj3bIqnyOFs71KNIuSFeR5iklth8Vs0CAUGbd8XcO8emVR9Iu
 1ZE6C7xo+evd6hrQzeMMQUN0Mwb9OZBl9yZ5fkoWk/xyyheZVWlXiPbGK0pll4FUZc3P5mzs0QZ
 lZ2Hu01WqG+UJUfdzSMzGwHuF7atoK/5RIev9bPuor/xBqScvnDsJThgC7dKJh7EwR1d++PtA2z
 RwMvtBwD+RF3f7xxkWtyUE4RdHIXkVeA47noyxPyMZL00rhe2yPI2hSu0z9UaMJT6HJJCwTv3+g
 6UAHIYQiK0t63Zb513fZDNhlPoWxOZCUIuyYixFWdU5WZXKoARSHZp/Cr45iUJa8/xbNZiHIP7U
 e/sxpVCBn4xBGNz/JTY+8d4gPvUVeE=
X-Received: by 2002:a05:6000:144c:b0:439:909f:c594 with SMTP id
 ffacd0b85a97d-439971ae7f0mr7126093f8f.10.1772121338692; 
 Thu, 26 Feb 2026 07:55:38 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4399c75b8afsm407235f8f.23.2026.02.26.07.55.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Feb 2026 07:55:38 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 02/20] target/arm: set the correct TI bits for WFIT traps
Date: Thu, 26 Feb 2026 15:55:17 +0000
Message-ID: <20260226155535.1171290-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260226155535.1171290-1-peter.maydell@linaro.org>
References: <20260226155535.1171290-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42e.google.com
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

From: Alex Bennée <alex.bennee@linaro.org>

The WFIT trap should be reported as 0b10.

Cc: qemu-stable@nongnu.org
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Gustavo Romero <gustavo.romero@linaro.org>
Message-id: 20260220171945.1065102-1-alex.bennee@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/op_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/tcg/op_helper.c b/target/arm/tcg/op_helper.c
index 4d70863506..aa14f15eb6 100644
--- a/target/arm/tcg/op_helper.c
+++ b/target/arm/tcg/op_helper.c
@@ -448,7 +448,7 @@ void HELPER(wfit)(CPUARMState *env, uint64_t timeout)
 
     if (target_el) {
         env->pc -= 4;
-        raise_exception(env, excp, syn_wfx(1, 0xe, 0, false), target_el);
+        raise_exception(env, excp, syn_wfx(1, 0xe, 2, false), target_el);
     }
 
     if (uadd64_overflow(timeout, offset, &nexttick)) {
-- 
2.43.0


