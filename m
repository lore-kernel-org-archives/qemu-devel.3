Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19410D232E1
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 05:39:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ve56u-0004rq-NC; Fri, 09 Jan 2026 00:32:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ve56s-0004mI-JI
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 00:32:30 -0500
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ve56r-0003lK-3e
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 00:32:30 -0500
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-34ca40c1213so2178366a91.0
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 21:32:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767936748; x=1768541548; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SkqAwu3RipWMPSb9TAaPzeMQgKDaSDTMklDM2Toa600=;
 b=iEMVq7iOQZ+e9l+uQZzRNZb9zkN2CB36mphSiWDH072a/gS7dExAPS5KcamxboIEw8
 XRBNZs9i7CfRIMTPlDFvoQQR+x678fDxd6nY0Ed2Wq7iXLBR+OU1xTaGcB/vMP13h6Ga
 Gg6K3AKDS2NhN4zWiZR+zEPM/iuS6ZFK8wbqUxwxzms1dQWvvMYRRZVLZAww93B5nMYL
 J3r6R97LV66tOLuBoRKyBEyUKaopPqSQaqMUmLgVObVeOl3fE6yU0KNfckYkq/0Wj+Wy
 uK0XqFKN2dbLenerLvl8KFWJsyakY7X40kCVDUyzXDmcPNbX5e215/TROjiKrNqUrwP4
 gJlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767936748; x=1768541548;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SkqAwu3RipWMPSb9TAaPzeMQgKDaSDTMklDM2Toa600=;
 b=HkYPIrYOpTHi1RA9H8LyiX+QVDmfer3cEYbMuunMuiDlMLrNIk0vnB3fDoJgbIDkqU
 hvREJH+hWTxtKyzeHk/zWRCBCyZDuhnqWWxv62+yDqNFAxxXCB0waSbfhb53gvuc0bqU
 vPeobdKRaEKrxxUZvDOMneZ0/w2bB2fBnZnhQ36elVik+q9f+1LfgG4YBGgSfP8XAXu2
 EQ64Q0Q+FBRFauCyr2ANjmtgby1lKUCm56UuAa77z+Ydst4yeXKUGlC449ncOEpDEV7O
 N/x0BqE8qcG3/kHSaZ4iHSveAY47shxxinQqTJKrtCmqyFddyi9ezH61zSqpoEW2H/cL
 MVMA==
X-Gm-Message-State: AOJu0YzBrYkUDyIAADhcTNpUZWsMalConMZeg7DAS/x6R+t/Repfri2c
 VbwMF2btIlg7JdRKFGnDDFClp4WG8B3q2sLcUtiFAHBeos1bj8ytGQ1DhEaIs1nhTxlLpIosu7V
 qEJuY
X-Gm-Gg: AY/fxX4O/RYw5RRunOpE1vbcysB4c36L0H6NAKO/hGLnCR1WeBGTafZAuxYsU0zr8Ur
 8/QlKEsHfXcE/W/nnjVH8d3rwCCozqYil7gL+s3FJHSdFu0xO7tyQkYlTKq/g5jdF2JMyBm9JCG
 NRc/brYPGmdqUTqKBgY6S+jBoW3m7M4COD5WByE53761w2PPs/+B3tPECY9Gp2HBlF1VBmXA5eu
 oinD7DAgNBVYX6lrgb+9wTbS7cF/5qzsiWRAdaivOvW9VB3DH8dNmsWHy5xINIBTylMz3BfieK4
 TubSZbx/ZNVC/RB2/LhWqBWwqiW0lHTA1ES047AY7DUIqMb8hTK0o2m3GIoDSNv9PLSxIRx04+b
 OVgtp9GQvEVkw9qnQVO27szNndUhpFHLQK569F++1S0ZirY9ov0mWTckYWFSTV8lOWoKZnCu2Ze
 cMq5ZETBP/VPaQveSjwehHCLL6f3IrdshiMkp0QwNmW0cvzobYe5wMU36iaQh8OY3R
X-Google-Smtp-Source: AGHT+IETWcvArC6mvesyjjBPcABmhg4esYgIDkcrZmYTKGVBos10VAAm7PMg2Wwv5EKpYjHGIplLMw==
X-Received: by 2002:a17:90b:57c4:b0:34c:a211:e52a with SMTP id
 98e67ed59e1d1-34f68cae46emr8219493a91.27.1767936747721; 
 Thu, 08 Jan 2026 21:32:27 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-34f5fa93f30sm9260137a91.5.2026.01.08.21.32.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 21:32:27 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Jim MacArthur <jim.macarthur@linaro.org>, anjo@rev.ng,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 26/29] target/arm/tcg/translate.c: remove MO_TE usage
Date: Thu,  8 Jan 2026 21:31:55 -0800
Message-ID: <20260109053158.2800705-27-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260109053158.2800705-1-pierrick.bouvier@linaro.org>
References: <20260109053158.2800705-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1030.google.com
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

dc->be_data is already set just above in the same function:
```
    dc->be_data = EX_TBFLAG_ANY(tb_flags, BE_DATA) ? MO_BE : MO_LE;
```

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/tcg/translate.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index ec4358ba402..55b89817cb1 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -6327,7 +6327,6 @@ static void arm_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
 
     if (arm_feature(env, ARM_FEATURE_M)) {
         dc->vfp_enabled = 1;
-        dc->be_data = MO_TE;
         dc->v7m_handler_mode = EX_TBFLAG_M32(tb_flags, HANDLER);
         dc->v8m_secure = EX_TBFLAG_M32(tb_flags, SECURE);
         dc->v8m_stackcheck = EX_TBFLAG_M32(tb_flags, STACKCHECK);
-- 
2.47.3


