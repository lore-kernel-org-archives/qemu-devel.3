Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19EC3F46C6D
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2026 18:29:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w9oel-0007TU-S4; Mon, 06 Apr 2026 14:26:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w9oeg-0007PE-EP
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 14:26:36 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w9oee-0002Ol-Bl
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 14:26:33 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-35c206f0481so4085893a91.0
 for <qemu-devel@nongnu.org>; Mon, 06 Apr 2026 11:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775499990; x=1776104790; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/IALcLXX/d7LO0liU9vJMgW15Lrt2XEwGveOJyMimkI=;
 b=EObqqvDcn3+vImdSSIATVIbdYqBSUOWmeo165uCxFpdM0RrzsBzG1o1os2/ArkB3ns
 WFjwUPLGlKVs6GwYJuKtK5m4QwLdwoIEyw7EeyZdieKLlzoj1xej/yb/Tg7uGJkX7Gkx
 RUd+I7hA+e11JPJ6ZnlEHwzyuskEv0/96nAKpBvZ0xasbyahCUrV/kfMMAwjbO+G7pG+
 4F3GmhKeBRyZNNp+IJxlhQtQ8qFTbp+Q47gxz34mewOQHDCQpc8VZgxWGQ9hqh57I9g5
 69T3wcWlk9vmZTo+d4cBGQlphOXfc4X1Pt6cfT8FX93RrxiQAUdFeaAJKsS3AO5Y0M8h
 Uo8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775499990; x=1776104790;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/IALcLXX/d7LO0liU9vJMgW15Lrt2XEwGveOJyMimkI=;
 b=gc5p/agsxkoEeXjbPWkgNborSlrlOdUsMcsxLvyeRc+noFJtavONNBcgYNsYJ8JtTW
 p623keYa3bbIo01FAcrzFQTXKQin8Ms/nlHJa/DV4AIcOa8fm9DBwas9AQ/wSU56pTmz
 PfAfZ4pFUmQl3Byqf0O4xi1Kdtc+iyXRgUp37BZDYrWFKSnviQYMXAe95viKmxUHC97k
 21p2AqUCqXVSsqeDaezxy87nbEkxO2hgFSV1upY3FGlunI4Z17UIuolJx168uNQgLnOa
 SM4+78pjFjwEDALyot5KjSfc3pvraR2cVnCHWBi+H8LsZgLg41EMgpqtXhKoO9r2CcYf
 AVjA==
X-Gm-Message-State: AOJu0YzoEShZn2dlwc87uwbXoccm4nkTmCsb98Csd3CDXTeuqP8c3POt
 qiSaycCsTUh79QOcqgOveDvdtUhhyvKaP9GvcWiNvXEZzFCDkV5hX3UPCdW955rbq5wGM2ICBnk
 BaAzPltZZjg==
X-Gm-Gg: AeBDietXurPx6zg2ipM+NW/xqtrmHdUx0ThDAc7q8hnG8R3wozJ5D9QjtaSq4Lz1q+T
 zFmDGIB3SWU+ThK7CWjgH9QBHOLjYYy0f1SBWvBVILaPmBsvsW80dUD8Ufhvjmk46C4arAvyq7d
 m97fuX/LprMNBDYn6cxXegZZ/LNT5bpbEfclvLapZ8x020vWdtmmc0GK9JHfIHx687eVuB0GW/e
 mr8Xy14Oe8fHpFQ/RLdmljRxSpPEU1rXpLRGz+yh5AaN6LLBbBMxjq+3115dfRkr0ymrI93v2+M
 yStAanh2Oarpv7MJMoFHcqRDoAwf6gP+0RdirbomrbBJthF75tnj+FfiMW0z8W79bbCNIR0WMz8
 unEKmJq4ngNJrWLGiIQgsNiIF1dkGMfxdkRhwFgUHh88wKf5MQ+OMOKpyWTthrdSV+OsAJ4WuEm
 JfnQCrRh4QzF2IxEe1A38emoDoYAaYeE93VPY7N1EGS4cZb4AWToBflP78kRWmyb2dVd4jOuhCt
 0ty
X-Received: by 2002:a17:90b:224e:b0:35b:e56e:a17e with SMTP id
 98e67ed59e1d1-35de68cf52fmr13822521a91.17.1775499989782; 
 Mon, 06 Apr 2026 11:26:29 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c76c6561fe9sm12765080a12.15.2026.04.06.11.26.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2026 11:26:28 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, jim.macarthur@linaro.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, philmd@linaro.org,
 qemu-arm@nongnu.org, qemu-stable@nongnu.org
Subject: [PATCH v8 11/20] target/arm/tcg/translate.c: remove MO_TE usage
Date: Mon,  6 Apr 2026 11:26:00 -0700
Message-ID: <20260406182609.193886-12-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260406182609.193886-1-pierrick.bouvier@linaro.org>
References: <20260406182609.193886-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102a.google.com
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

dc->be_data is already set just above in the same function:
```
    dc->be_data = EX_TBFLAG_ANY(tb_flags, BE_DATA) ? MO_BE : MO_LE;
```

Cc: qemu-stable@nongnu.org
Fixes: a729a46b05a ("target/arm: Add wrapper macros for accessing tbflags")
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/tcg/translate.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index 56ef1e0eb59..4546bbeeeff 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -6344,7 +6344,6 @@ static void arm_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
 
     if (arm_feature(env, ARM_FEATURE_M)) {
         dc->vfp_enabled = 1;
-        dc->be_data = MO_TE;
         dc->v7m_handler_mode = EX_TBFLAG_M32(tb_flags, HANDLER);
         dc->v8m_secure = EX_TBFLAG_M32(tb_flags, SECURE);
         dc->v8m_stackcheck = EX_TBFLAG_M32(tb_flags, STACKCHECK);
-- 
2.47.3


