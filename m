Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E78F9E77180
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 16:25:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLPSG-0000OK-CE; Wed, 11 Dec 2024 11:20:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tLPSE-0000NK-7e
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:20:50 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tLPSC-0007lR-Lw
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:20:50 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-43618283d48so12310835e9.1
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 08:20:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733934047; x=1734538847; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=GJ2MxfIn+bPI815lGa0YYGJVtmHJ6iQzs9ubSygVReI=;
 b=CKD0pyToKz8Ks8RSiTY/CmPYRr/AG2YmNukOVTtp3o+bZeGGLNvYrD9rfFVUIW89MK
 jHV7H6QBBuezFCy9xXunhE9i4NOAgW0AVcf5zVndWy8LWKxj7xgjfhQqvlKUokB+NQvs
 vbXyaYTBoXhMdTwHm+O4dy4CKBn2SkwQFcfgkT/EMWFbm7vkun9Cn9dZPYYGHCmcYmwn
 78MfS93sfJ9XF3wKVb+yM2J+dOhHA8iEq1mjf+Jxd2ulJlHVe4+rn8sS2QbrEqJlpxoS
 X+EvmdWw1NZqDG/W8mdohVtrE/gjXyEHsK4zIIiL74FxfJamwDq4hiMCI3zXXwDS4Ztz
 RfRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733934047; x=1734538847;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GJ2MxfIn+bPI815lGa0YYGJVtmHJ6iQzs9ubSygVReI=;
 b=qv1Agj8Ndl0VacNwQu73U/ZTyxL5pjpWPpwp/CLQ6NvNmogEo5KazBBNDLKRH/FPgN
 6i494/2UA5PnZ9fRpTjDyf5lrZTsyjVfBa0Q9/lNpe+nK4l8DPBaD4HV9IU3T8f7tDxn
 2QYQy3oxWfiIRJOhKfRiGZeJUmMKbKELnt3eDtBvgjXzeECbxL2ObUi+aykHBn7YtaAZ
 ffqKOVlK0lRydeznZXycbMxkzNxTj24nyKe9VosN7rZ7eUi7HLno+Aps8buwAWx1Dn6Z
 Eitgqf6HFqEjQ4vorsXXL027rR4hxlsTHmVET36NWHNXCXqKJrwZjRIaqVBsdSVGE5U5
 LhBw==
X-Gm-Message-State: AOJu0YxvXoif+EAAU0ucqoxh+L+9OU+J5tJASgA/Vw51YbVx6Nyd8D89
 ljp4VMmVQgbLZBQld9sYEfKUIdOq8tyHqLQaLMN7HJsRjb1mEK/ZryXdvFIe6NVdIzqIBjYk6Wp
 U
X-Gm-Gg: ASbGncsvIb7HL6FLBTNlvwTIAwK5KAn651+fT0CK9L51DzaKCFlvyUn2YE8p1yQt+Qo
 1Z23nqjs01UHejzdyOVV8Gs2GIervC6kxpL++Dwhv/5h2+0enHG7xaiBzB72OzDhji++KfEJkBl
 RkFx/zD+hmLPFERQy8j1L0TJsoUV7wXAPjenPGUl1tO1zUppf3q5ejJ/TbOQcR8CQ8LIYYll8SB
 alEcTKyz3v7gXdpJyf2DX3NYLgx4i61CDdN4glAkT3U4Qzgjl3BokmD2Rxk
X-Google-Smtp-Source: AGHT+IHbNwGi42RPHzPeAaV49J8dicMj7ttfd4ajM7NNaERdDyTJxMh7R4KmYLPDXNvJqGuhIl91RA==
X-Received: by 2002:a05:6000:1565:b0:385:fd24:3303 with SMTP id
 ffacd0b85a97d-3864cdeb18bmr2513796f8f.0.1733934047296; 
 Wed, 11 Dec 2024 08:20:47 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434f4dfdcdfsm121460595e9.39.2024.12.11.08.20.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 08:20:46 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 35/72] target/m68k: In frem helper,
 initialize local float_status from env->fp_status
Date: Wed, 11 Dec 2024 16:19:27 +0000
Message-Id: <20241211162004.2795499-36-peter.maydell@linaro.org>
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

In the frem helper, we have a local float_status because we want to
execute the floatx80_div() with a custom rounding mode.  Instead of
zero-initializing the local float_status and then having to set it up
with the m68k standard behaviour (including the NaN propagation rule
and copying the rounding precision from env->fp_status), initialize
it as a complete copy of env->fp_status. This will avoid our having
to add new code in this function for every new config knob we add
to fp_status.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20241202131347.498124-31-peter.maydell@linaro.org
---
 target/m68k/fpu_helper.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/target/m68k/fpu_helper.c b/target/m68k/fpu_helper.c
index a605162b71f..e3f4a188501 100644
--- a/target/m68k/fpu_helper.c
+++ b/target/m68k/fpu_helper.c
@@ -615,15 +615,13 @@ void HELPER(frem)(CPUM68KState *env, FPReg *res, FPReg *val0, FPReg *val1)
 
     fp_rem = floatx80_rem(val1->d, val0->d, &env->fp_status);
     if (!floatx80_is_any_nan(fp_rem)) {
-        float_status fp_status = { };
+        /* Use local temporary fp_status to set different rounding mode */
+        float_status fp_status = env->fp_status;
         uint32_t quotient;
         int sign;
 
         /* Calculate quotient directly using round to nearest mode */
-        set_float_2nan_prop_rule(float_2nan_prop_ab, &fp_status);
         set_float_rounding_mode(float_round_nearest_even, &fp_status);
-        set_floatx80_rounding_precision(
-            get_floatx80_rounding_precision(&env->fp_status), &fp_status);
         fp_quot.d = floatx80_div(val1->d, val0->d, &fp_status);
 
         sign = extractFloatx80Sign(fp_quot.d);
-- 
2.34.1


