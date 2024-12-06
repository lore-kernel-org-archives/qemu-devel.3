Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD948E77171
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 03:14:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJOlp-0006rX-2X; Thu, 05 Dec 2024 22:12:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tJOlm-0006pV-Cq
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 22:12:42 -0500
Received: from mail-ot1-x331.google.com ([2607:f8b0:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tJOlk-0004SY-Gt
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 22:12:41 -0500
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-71d5ef7daf1so870357a34.1
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2024 19:12:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733454759; x=1734059559; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7dGWprqAXOmm+0OGOUE5FTt7v9zxqhHfWAdJSXgLsVU=;
 b=txqoO+y+y9BE2qPNgoJeSOpFBzyeniSt0iG2OlnXrmQxXhP4xnk1vf6Zp1mPxQiYV/
 ki32bE4op5iAKo9p4VtXVpRZ73hVXSrpwznmR7LIy1qWlTRUAhxfKIerpujsHHG7mf3H
 S6n+bsyXqRk9UD8wbZ3BdaONYabT/nvRqEOuLg73b8i2GeNdGZ6I6sz2E1rRfgSJzVnL
 6IaAYwlOrPN5JnAor1edO+zS7e3+jqRQHUxrBC4sJoXL9Y/5uti56mna5ExGKYJPYs2a
 Geac443QaqGqf1sxC0gM0vKWyUQWkRQkinjUSSs8HqEIH5n1VfiVeiVjU/uCACWoSo5J
 7jOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733454759; x=1734059559;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7dGWprqAXOmm+0OGOUE5FTt7v9zxqhHfWAdJSXgLsVU=;
 b=l00T/Ur+kjNjiL7Pv3XsMnLJZewF6WEw346cUPCI9cSuXzdD98iAXt5NCkfB3lmn5F
 1KqHeGzylOyG9IoNzKRlnzp4yJ8ycisVKmEHHikL59me2llYlYg0TlgePg7TNt+lAatT
 eh60erYLEuTwZ23n/CwcMJLuSP5F8OtRDnVEfpfFm1/Onqzhvtfemrxs+FmFpHu6ozra
 dUfoJ2mp1zxqHopg9bIMdJ/Ihzfzdgv3p0xkEpgsC7KHaE6SBal4JBw/esHhWZ8XBM6N
 ThuefO6L3+BkukmYdObs+5FJgWwMVzkmsTHul5XApPtLy1vE/HTqk/Ilk6moRSdIqmGw
 i6Pw==
X-Gm-Message-State: AOJu0YznBs6STE1y5u+0HzPkwnK3wQ38XKDzHx+N4x1D0nTgIqr3hidr
 /W2K2fmGYl/cfFatZsuVeK11QdG4TSIBzRwVSgLBw2FFYmIpc/cmNW+iSMiuZNx3I9LF7LcvqGb
 E7IARwub8
X-Gm-Gg: ASbGncu+yvPWWhYU/aE5DrsVV/nQCX/9arqNPy2dxOX0idabGi9JX7UuoBrbHWGs2D/
 obhTc4g2Do/gB2ckD9Nyz/T7fm2Lel01mDShssh6onOUH/eCJgu0aSWWYzvxz+7kWENpgJRpdq5
 uCUcnr2GHapVP/THC0qlv4sF/wTgGLBBIZbZ2OOZgmMWYgw5DRBK6fuwOFmaCY/cYw3F8J6J0Ky
 tET2cVfuy06ONMhfGyKxixNTJ60tKIcwAqit6koKYILp+uhWwNpJNPb68Z2jdoTuSV7BJm9TMnm
 cZ375P55g/382p3ga1Dfs4UuyH5FURjlkZbe
X-Google-Smtp-Source: AGHT+IGDEURuWvPxchcFXe+HQ1twhGwVXE6OSBi0ohga+mu14e4Bi3Id4GKfbwsL/+UEpXyEvVxZ7Q==
X-Received: by 2002:a05:6830:4995:b0:718:9d30:3c5a with SMTP id
 46e09a7af769-71dcf4bf7bcmr1875863a34.2.1733454759097; 
 Thu, 05 Dec 2024 19:12:39 -0800 (PST)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71dc493b2dfsm596442a34.9.2024.12.05.19.12.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Dec 2024 19:12:38 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 7/9] target/arm: Convert sme_helper.c to fpst alias
Date: Thu,  5 Dec 2024 21:12:22 -0600
Message-ID: <20241206031224.78525-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241206031224.78525-1-richard.henderson@linaro.org>
References: <20241206031224.78525-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::331;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/helper-sme.h | 4 ++--
 target/arm/tcg/sme_helper.c | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/target/arm/tcg/helper-sme.h b/target/arm/tcg/helper-sme.h
index 59ecaa1548..858d69188f 100644
--- a/target/arm/tcg/helper-sme.h
+++ b/target/arm/tcg/helper-sme.h
@@ -123,9 +123,9 @@ DEF_HELPER_FLAGS_5(sme_addva_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_7(sme_fmopa_h, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_FLAGS_7(sme_fmopa_s, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_7(sme_fmopa_d, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_7(sme_bfmopa, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_FLAGS_6(sme_smopa_s, TCG_CALL_NO_RWG,
diff --git a/target/arm/tcg/sme_helper.c b/target/arm/tcg/sme_helper.c
index 8cf12654e5..a0e6b4a41e 100644
--- a/target/arm/tcg/sme_helper.c
+++ b/target/arm/tcg/sme_helper.c
@@ -904,7 +904,7 @@ void HELPER(sme_addva_d)(void *vzda, void *vzn, void *vpn,
 }
 
 void HELPER(sme_fmopa_s)(void *vza, void *vzn, void *vzm, void *vpn,
-                         void *vpm, void *vst, uint32_t desc)
+                         void *vpm, float_status *fpst_in, uint32_t desc)
 {
     intptr_t row, col, oprsz = simd_maxsz(desc);
     uint32_t neg = simd_data(desc) << 31;
@@ -916,7 +916,7 @@ void HELPER(sme_fmopa_s)(void *vza, void *vzn, void *vzm, void *vpn,
      * update the cumulative fp exception status.  It also produces
      * default nans.
      */
-    fpst = *(float_status *)vst;
+    fpst = *fpst_in;
     set_default_nan_mode(true, &fpst);
 
     for (row = 0; row < oprsz; ) {
@@ -946,13 +946,13 @@ void HELPER(sme_fmopa_s)(void *vza, void *vzn, void *vzm, void *vpn,
 }
 
 void HELPER(sme_fmopa_d)(void *vza, void *vzn, void *vzm, void *vpn,
-                         void *vpm, void *vst, uint32_t desc)
+                         void *vpm, float_status *fpst_in, uint32_t desc)
 {
     intptr_t row, col, oprsz = simd_oprsz(desc) / 8;
     uint64_t neg = (uint64_t)simd_data(desc) << 63;
     uint64_t *za = vza, *zn = vzn, *zm = vzm;
     uint8_t *pn = vpn, *pm = vpm;
-    float_status fpst = *(float_status *)vst;
+    float_status fpst = *fpst_in;
 
     set_default_nan_mode(true, &fpst);
 
-- 
2.43.0


