Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5160DC43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 10:44:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wggj0-00085a-Bl; Mon, 06 Jul 2026 06:38:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wggiq-0007Vx-64
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 06:38:44 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wggin-0003XW-N3
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 06:38:43 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-493ba701891so22644065e9.3
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 03:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783334320; x=1783939120; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=8k8eqVcYkRAHjMMhhMtpbFzS2zs5ffXVgQxhGMJdJEM=;
 b=rpDTAkJH3i/bM7IXFcivNReoL9/kUYs4k2H3F7gp31BuJiX/Nvwj0OnSsTfYSGHWqx
 bDO8BVrtCOZ8n10cd8byE49ndyCnkqRd6NqEJhSzF1azX0CYJSisUPHDMTiPuFGJaO4y
 bvEkvdpJ7bgPHuYofFYI3qht5RT5fCtJss+AJ+/uO3sEF6AF3ScSoRazg2MMtEELsWmf
 4B1xfvX6a9lzadEcFpC7d8I0bkNHoHNT8Ehu32wFjTZiaR6u/T8a941ZMrXuZwmmKm1k
 +cOyeseagpbrcTqrcMA3MGlwCEOHvHdtbEMzYb+qGNpZ6rSoV8hrzHjzUglweGrTvyTY
 iEHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783334320; x=1783939120;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=8k8eqVcYkRAHjMMhhMtpbFzS2zs5ffXVgQxhGMJdJEM=;
 b=lIMK1q2mHN7z0jwQ8JnM6iUMiK0sBfowXKZX2dayfG+N44JV14rfKQu1U5ExA/N2Fm
 8VcwxbwyMd0NfHQlFQj/E92Wcluturtcc9hJ+plMqcl+37hgvwQtzEFFQdXMFm6EG8+k
 XXNUmBSsRvnOT60WhktlajiLrd8asHCFAKGwTSr77uEqF6ezSvQNfIPDRsrOk/G0v5MY
 p4gXE5BAZRzjd7W9myaI2yVs8KePGr3qFz8GSNtzsaUO3nAWrNYEflHZdEaGDKwvqWnl
 PYApBlPA3T9f22zE/EFJO/bQMM8yuOKT3r4TurVJraNcXet5cAUUrNiupTUrkC+Kmzph
 EpPw==
X-Gm-Message-State: AOJu0YxZJugdxQTI94NAsE/T/GeKe3ZneNaf67Zat2paxTyNcRIHOpHZ
 jGoraEBZ4BMQEcFMSvqyAAg1fwVyvbF/UNL3QNjo8oRy1UAhq6vh0PGgiSwZcCFtZi3ptMyBH8K
 9vjJ+k/e8Ag==
X-Gm-Gg: AfdE7ck7uncxvhW9JHC3dRiq1QOG4tz5j5dnMKDNq+eMQQO3Ceq3iRuAhMKCVSgLER0
 FB29R4oG6jofFgW6KTTwG/ZiXUy3rUPQv2GABeQ+aHokcIlT629WMNOxv+o4a352mPhTl6mvZiA
 qDstrnyfBgxY43FJGzC+qUDkw34FLPw2uaZQfcXwP5OOVEsc0O/YBO+JHhoTCubjeufB5d/DQ2t
 tZzW7rPuu68i5fvAJlduggbW6pmXUKEhDrrzWVGfYTH2n2+bZrCx/FlJ0aZBEcyqKbbMNY0wWj9
 OLp/1cB/ZD+XGu0/vmy+MHq9mwzNG5jRaLA1i9xmxdeh81iS+JJqgi4vDmDLOROfXk6xyOzFwLV
 Ro/XfYosYxr3c5Kuipc/vNQel2dOYB/MsVx4hgOLOYwFF5Bnd/UPwnDX7oVJ8QaAA0Xb1I846tT
 XS/SrUk6vK3XhX/tZeXg+HAzAKvUoYAdM279aVwOGoq4n4YC6LQOewvPXFmLkXOWBoHKJbDEW8z
 gibVM+SxkGlKV1ct/Tbng==
X-Received: by 2002:a05:600c:19d2:b0:493:a96b:fa0b with SMTP id
 5b1f17b1804b1-493de00875amr11045705e9.24.1783334320153; 
 Mon, 06 Jul 2026 03:38:40 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493c63b6f1bsm329501805e9.10.2026.07.06.03.38.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 03:38:39 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 44/49] target/arm: Implement USMOP4[AS]
Date: Mon,  6 Jul 2026 11:37:47 +0100
Message-ID: <20260706103752.320511-45-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260706103752.320511-1-peter.maydell@linaro.org>
References: <20260706103752.320511-1-peter.maydell@linaro.org>
MIME-Version: 1.0
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260702204314.79224-15-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/helper-sme-defs.h | 5 +++++
 target/arm/tcg/sme.decode        | 3 +++
 target/arm/tcg/sme_helper.c      | 5 +++++
 target/arm/tcg/translate-sme.c   | 5 +++++
 4 files changed, 18 insertions(+)

diff --git a/target/arm/tcg/helper-sme-defs.h b/target/arm/tcg/helper-sme-defs.h
index 60bc3c6e9b..7fc7129e54 100644
--- a/target/arm/tcg/helper-sme-defs.h
+++ b/target/arm/tcg/helper-sme-defs.h
@@ -399,3 +399,8 @@ DEF_HELPER_FLAGS_4(sme_umop4a_sb, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sme_umop4s_sb, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sme_umop4a_dh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sme_umop4s_dh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(sme_usmop4a_sb, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sme_usmop4s_sb, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sme_usmop4a_dh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sme_usmop4s_dh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index aca6a79be3..53e7e67feb 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -1128,3 +1128,6 @@ SUMOP4_dh       1010 0000 111. ...0 0000 00.. ..0. 1...         @mop4_o3
 
 UMOP4_sb        1000 0001 001. ...0 1000 00.. ..0. 00..         @mop4_o2
 UMOP4_dh        1010 0001 111. ...0 0000 00.. ..0. 1...         @mop4_o3
+
+USMOP4_sb       1000 0001 000. ...0 1000 00.. ..0. 00..         @mop4_o2
+USMOP4_dh       1010 0001 110. ...0 0000 00.. ..0. 1...         @mop4_o3
diff --git a/target/arm/tcg/sme_helper.c b/target/arm/tcg/sme_helper.c
index f5fa69841d..23bb816b6a 100644
--- a/target/arm/tcg/sme_helper.c
+++ b/target/arm/tcg/sme_helper.c
@@ -2985,4 +2985,9 @@ IMOP4_4WAY(umop4s_sb, -, int32_t, uint8_t, uint8_t)
 IMOP4_4WAY(umop4a_dh, +, int64_t, uint16_t, uint16_t)
 IMOP4_4WAY(umop4s_dh, -, int64_t, uint16_t, uint16_t)
 
+IMOP4_4WAY(usmop4a_sb, +, int32_t, uint8_t, int8_t)
+IMOP4_4WAY(usmop4s_sb, -, int32_t, uint8_t, int8_t)
+IMOP4_4WAY(usmop4a_dh, +, int64_t, uint16_t, int16_t)
+IMOP4_4WAY(usmop4s_dh, -, int64_t, uint16_t, int16_t)
+
 #undef IMOP4_4WAY
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index b14aac2c17..dcc4690fba 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -2127,3 +2127,8 @@ TRANS_FEAT(UMOP4_sb, aa64_sme_mop4, do_mop4_int, a, MO_32,
            a->s ? gen_helper_sme_umop4s_sb : gen_helper_sme_umop4a_sb)
 TRANS_FEAT(UMOP4_dh, aa64_sme_mop4_i16i64, do_mop4_int, a, MO_64,
            a->s ? gen_helper_sme_umop4s_dh : gen_helper_sme_umop4a_dh)
+
+TRANS_FEAT(USMOP4_sb, aa64_sme_mop4, do_mop4_int, a, MO_32,
+           a->s ? gen_helper_sme_usmop4s_sb : gen_helper_sme_usmop4a_sb)
+TRANS_FEAT(USMOP4_dh, aa64_sme_mop4_i16i64, do_mop4_int, a, MO_64,
+           a->s ? gen_helper_sme_usmop4s_dh : gen_helper_sme_usmop4a_dh)
-- 
2.43.0


