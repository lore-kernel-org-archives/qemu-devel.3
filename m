Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5B4EC43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 10:39:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wggiv-0007nK-J6; Mon, 06 Jul 2026 06:38:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wggio-0007Rp-Kz
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 06:38:42 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wggim-0003X8-TK
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 06:38:42 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-493b27c7451so34830825e9.0
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 03:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783334319; x=1783939119; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=u4Ubu5fLnvcD1Q+9KJ/USHZyKDfzCrXvumx3JNJFasw=;
 b=kbmdytYFM0BJl6UM+FrKiMYY6yHuPNm2u+0kYITyvXUgX47vDsz4Vsc9+AMfb9YId2
 UXRZcBy18bJ8+oJCz+X31eL/a2xQVVgJCdMy7zB1g1ZFzIVmU5iuxwf2h+F0cgCVxzE7
 cKA4XPyyIF0Z6kjTKb3DFS6SkXPMDEKqrOpi6dH6+S5gHTpCd4h1VSuV90CJV/n6MNty
 8l2Oq/p4aKjv8mHexnso4IvVOTeg49zU7TUXJFC4c4SOrTE3I5YLwh4MYwhIvaebvh1S
 AIwzePKxyxF5f6AgjHYgmhImU0wyfcI3ZFTV8GMuBbuz4iXehKOjUjvRi61YcskOPy7Q
 63Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783334319; x=1783939119;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=u4Ubu5fLnvcD1Q+9KJ/USHZyKDfzCrXvumx3JNJFasw=;
 b=AGbvHwyuM5rdQbokn5G6LoSuvrG79C5HqicaGQNu9OEjVBNp2f53QBleLp5eunyQ5r
 9CU3Ktv1WztJuP78F53lTGz9VbUOntr4qUXedhQ/Z1RqIbFMiHEkVxFrKufe41IrA/mA
 37V/dJJqN5+k1fcdvAUIFLyiAQXgCnl+3dJeo4XW5MXirBASZyfDAf5DduxdAqdtkg+E
 Kp8JslMtjgQ53ICwQJMzscfTXSeYWGmatCCD16izrxv9ruES1XqxCeDjOuF40byl4TYg
 CjCLvbU60JITfuUACF0ypIRsFGg5k9UDpI72JH8WfRMceKEEemCcx07XqjNDibZ7ss8m
 gAMA==
X-Gm-Message-State: AOJu0YyM/IFwHtOGLfAXPFEiWjhtnPrBTMFvhSECS9EjO9USZCLZ1EwF
 dRyh99bzHVzqCYhnNJZEPBetYUGYfWPfrJo0kZmPjjVYRIpH2RHbnwJZXahxlMXWhUE3JHtpedj
 vMH/6akAtAg==
X-Gm-Gg: AfdE7cl790bkokIUrCU+WEYLmMKrv5CwuuEDrJ9uBsiWi2RhRn8GR0J9CuU13/OnkTz
 xoPLCGoVMPaNZglvptkbCh/yZPtm05nBNoXuBNf9GkgBO5seMvIXKzskyRn7wPHGvHcvbej2mZ1
 d45QF1T8fblNyzzH8bUbvisQWkHTjzDaDaq4VuQlC5lXtttjE6ceBZ3cC2qfKCELZVi0VXUvGMy
 7rYcfu/aJfVTmrOenPoAMuQNWOMjFpjH+ojS0z6Pf+Bg41I/B0pqPXxHEPJI5lpLXTMb4NkHL76
 6bhdGJ/yXtessPdHssQRxllaq1qycxNXefnXPTDRzBnbMqh2jHACXUqQh5M7/6E5Szs/Lp7kDws
 ehJbGOUYWaGFb2IdTd4N2aOvNuX+KShDvvfohWcOmd8N5Vt0/KztL2zzVSUIXVFLCg7qtHz04LO
 xM0Tg/Jd7SklBy+eggb9JcTuaBjUZZruglk1PkuqK9dWHX9AOmFn+UGV/YDkgLtlZdlr8hYgL2k
 jTyO/90cBRYdLWBXWJfz763w4yDUHZC
X-Received: by 2002:a05:600c:6986:b0:493:d117:18a8 with SMTP id
 5b1f17b1804b1-493dece4a7bmr871225e9.9.1783334319375; 
 Mon, 06 Jul 2026 03:38:39 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493c63b6f1bsm329501805e9.10.2026.07.06.03.38.38
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 03:38:38 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 43/49] target/arm: Implement UMOP4[AS] (4-way)
Date: Mon,  6 Jul 2026 11:37:46 +0100
Message-ID: <20260706103752.320511-44-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260706103752.320511-1-peter.maydell@linaro.org>
References: <20260706103752.320511-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
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
Message-id: 20260702204314.79224-14-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/helper-sme-defs.h | 5 +++++
 target/arm/tcg/sme.decode        | 3 +++
 target/arm/tcg/sme_helper.c      | 5 +++++
 target/arm/tcg/translate-sme.c   | 5 +++++
 4 files changed, 18 insertions(+)

diff --git a/target/arm/tcg/helper-sme-defs.h b/target/arm/tcg/helper-sme-defs.h
index 38b23690d1..60bc3c6e9b 100644
--- a/target/arm/tcg/helper-sme-defs.h
+++ b/target/arm/tcg/helper-sme-defs.h
@@ -394,3 +394,8 @@ DEF_HELPER_FLAGS_4(sme_sumop4a_sb, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sme_sumop4s_sb, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sme_sumop4a_dh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sme_sumop4s_dh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(sme_umop4a_sb, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sme_umop4s_sb, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sme_umop4a_dh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sme_umop4s_dh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index fbc85b8206..aca6a79be3 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -1125,3 +1125,6 @@ SMOP4_dh        1010 0000 110. ...0 0000 00.. ..0. 1...         @mop4_o3
 
 SUMOP4_sb       1000 0000 001. ...0 1000 00.. ..0. 00..         @mop4_o2
 SUMOP4_dh       1010 0000 111. ...0 0000 00.. ..0. 1...         @mop4_o3
+
+UMOP4_sb        1000 0001 001. ...0 1000 00.. ..0. 00..         @mop4_o2
+UMOP4_dh        1010 0001 111. ...0 0000 00.. ..0. 1...         @mop4_o3
diff --git a/target/arm/tcg/sme_helper.c b/target/arm/tcg/sme_helper.c
index fd085850ed..f5fa69841d 100644
--- a/target/arm/tcg/sme_helper.c
+++ b/target/arm/tcg/sme_helper.c
@@ -2980,4 +2980,9 @@ IMOP4_4WAY(sumop4s_sb, -, int32_t, int8_t, uint8_t)
 IMOP4_4WAY(sumop4a_dh, +, int64_t, int16_t, uint16_t)
 IMOP4_4WAY(sumop4s_dh, -, int64_t, int16_t, uint16_t)
 
+IMOP4_4WAY(umop4a_sb, +, int32_t, uint8_t, uint8_t)
+IMOP4_4WAY(umop4s_sb, -, int32_t, uint8_t, uint8_t)
+IMOP4_4WAY(umop4a_dh, +, int64_t, uint16_t, uint16_t)
+IMOP4_4WAY(umop4s_dh, -, int64_t, uint16_t, uint16_t)
+
 #undef IMOP4_4WAY
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index a8fcb0630d..b14aac2c17 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -2122,3 +2122,8 @@ TRANS_FEAT(SUMOP4_sb, aa64_sme_mop4, do_mop4_int, a, MO_32,
            a->s ? gen_helper_sme_sumop4s_sb : gen_helper_sme_sumop4a_sb)
 TRANS_FEAT(SUMOP4_dh, aa64_sme_mop4_i16i64, do_mop4_int, a, MO_64,
            a->s ? gen_helper_sme_sumop4s_dh : gen_helper_sme_sumop4a_dh)
+
+TRANS_FEAT(UMOP4_sb, aa64_sme_mop4, do_mop4_int, a, MO_32,
+           a->s ? gen_helper_sme_umop4s_sb : gen_helper_sme_umop4a_sb)
+TRANS_FEAT(UMOP4_dh, aa64_sme_mop4_i16i64, do_mop4_int, a, MO_64,
+           a->s ? gen_helper_sme_umop4s_dh : gen_helper_sme_umop4a_dh)
-- 
2.43.0


