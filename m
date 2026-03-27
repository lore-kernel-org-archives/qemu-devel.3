Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F076710F2853
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 16:52:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w6AP7-0006bJ-IO; Fri, 27 Mar 2026 12:51:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w6AOl-0006Bo-No
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 12:51:04 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w6AOh-0005Hh-0Q
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 12:51:00 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-829a9d08644so1269011b3a.1
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2026 09:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774630257; x=1775235057; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HIcfvrH1mrscajbqrnw45GLeLRQ46NncRATLpy0ZTNM=;
 b=g80gdofRiztd43pkN5/UomqWFBO49x/A3It8Mtjw/kdhhC23+5+Ph8cIkLo+/XN7ys
 hAyWhEoymCFjDrjipT8qok1Rj4aYOJih/el4EDPXbBLW5MHHHuYj/FgP+hErSCFzU2fu
 4x1II7zJ9TK0KlZsgnhR2eQYonDOMabHcRmyCGL4pV4ASIHYdBhXi4UofjXMPOFmgoBO
 coRHMe4g7NDVPmHs1CxCYETELbDiYu1tgRjuN68I2ueJnrsLoB5amVzXPsjs4eBQ/B2n
 PhZm45sTsSXQd5jzrNYF9UHPylhZEFvmtlw9ZJMWLSiSjLJ2kVCdyEm+i9RIwoeFFXOs
 eboQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774630257; x=1775235057;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HIcfvrH1mrscajbqrnw45GLeLRQ46NncRATLpy0ZTNM=;
 b=fLkkO21D0qGEgLEvVSdGuJ5khtzvxpO3HFT/mqO5EatxX+us2nn3qn1E3Kn4iPsUZi
 4/iagFJWugBLKM2+W1Jh8atDpTY9EVMm/oJ0KdZwuTWHujlllxOhJGvL4c7WYiDKojt9
 rcW6JaWvQIHZMnPriHZpgNX0ScNgjERJzGBjIHr8oghYuU3tB52sXAiED9mf4K6mdhY1
 0Xr9QBcpVePDPSZCquZci15hKmG7YNhDBpRQ32Oywg8JZQTAnCYKxrPNaphuNGRWMZ9N
 x4XnAtQ75jdfFf75XNBX3RKhpFrzK8vtWLyEqiTHPp5syGMkAFocJiYc7MZzvmQCH/9B
 pJrw==
X-Gm-Message-State: AOJu0Yxqh0nnD7ojmTWnU//VHhxpNCidIbinITqT5jV5b9DkGJS0abeB
 bCxZSbm1pYgr33WbZyW18vt+adGealr1NAU0x7ollfvRIvcv5rCDT1pst5tUV/fygTMxWYGKf0Z
 MYLTZk5E=
X-Gm-Gg: ATEYQzzTQbXNp3FNqaK1iOSGMtRFG7Ay1iklrjZKctOxazg7rJI5LM/r2SNOOvffK0w
 Yfru1y9a6/+nI39wQHcQ2AeXr88YUMKheEqbVvqFAQRKJuwW+ZU9qt7NQhD6mR3x2XHJsIli2sl
 PaFHF0O7OHPPwJd4JHOdOUBS7y6YdjfhaWTwqVK0zgGxfzY2f98ohW0+OimqkSds7TYlF9lODLP
 uJtLpF7sdDDWhs1VxAd9q2BQoHwJ5NMbeVG/bYWDQ103m6T2Ifr23XGOPW374ewqpC92zrrbEvb
 X2IcSK57PzEoiIS0LUZjJPnEhw+m0LlhlEUGaWCy/5B7UmKu+6lVJLVP8yC+ciw1YydvbyhSHRl
 W2ClEypMsx0uEYJEBZ06vKombxzBBQigz9O8mWnU/5wJcjakWCDWLYD8cVYfq6dfm+KImq9dW31
 FqDLJh+No7SzyLPIhyzb8r+48zpnHQAkvoX2tdfjdQ4SKN4cWhfIanGaOsA6FHvFYYtZt4XIny4
 Hd3
X-Received: by 2002:a05:6300:210c:b0:39b:f292:d7c0 with SMTP id
 adf61e73a8af0-39c87b6aed6mr3274481637.58.1774630257499; 
 Fri, 27 Mar 2026 09:50:57 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c767399e0casm5514038a12.31.2026.03.27.09.50.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2026 09:50:56 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, philmd@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, jim.macarthur@linaro.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v5 10/12] target/arm/tcg/gengvec.c: make compilation unit
 common
Date: Fri, 27 Mar 2026 09:50:40 -0700
Message-ID: <20260327165042.604105-11-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260327165042.604105-1-pierrick.bouvier@linaro.org>
References: <20260327165042.604105-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x430.google.com
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/tcg/meson.build | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/arm/tcg/meson.build b/target/arm/tcg/meson.build
index a2b944e81c4..70e6d8a96f0 100644
--- a/target/arm/tcg/meson.build
+++ b/target/arm/tcg/meson.build
@@ -25,7 +25,6 @@ arm_ss.add(when: 'TARGET_AARCH64', if_false: files('stubs32.c'))
 
 arm_ss.add(files(
   'cpu32.c',
-  'gengvec.c',
   'translate.c',
   'm_helper.c',
   'mve_helper.c',
@@ -67,6 +66,7 @@ arm_common_system_ss.add(
   'cpregs-at.c',
   'debug.c',
   'hflags.c',
+  'gengvec.c',
   'neon_helper.c',
   'op_helper.c',
   'psci.c',
@@ -81,6 +81,7 @@ arm_common_system_ss.add(
 ))
 arm_user_ss.add(files(
   'debug.c',
+  'gengvec.c',
   'hflags.c',
   'neon_helper.c',
   'op_helper.c',
-- 
2.47.3


