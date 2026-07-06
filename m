Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4248C43602
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 10:45:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wggiu-0007iA-Po; Mon, 06 Jul 2026 06:38:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wggio-0007RL-08
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 06:38:42 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wggil-0003Wl-Q3
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 06:38:41 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-493ae59eca6so20662195e9.1
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 03:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783334318; x=1783939118; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=5VkK9k74ebQRJ38950Z9aIqi2wp8L5ul2wcu1BDzewM=;
 b=WFrP3v+xXM3tVdH+koPgYCMS4aRam2k6DgNzYrC7GQvrEMPvXBJrzIV+23VOxofmQZ
 wARgHpSLrzzdSG5jRzMBUqfXSjQKrLz6/3UB6KjKUNClwaQpFKh5JxP7toARy1knXgdJ
 iR0f5v/lXSKaB5gPNBypMGcBZWdMFC3EsQQ0uACguESjJHb4rnCKUcgezcMOQJc8cTlm
 fgCsoQT4Z0ixYIicoTDUAzwcW16448/sHKgJKFPfuEfDU49lCGgSGP2sGSsrscM61Uwh
 StzSM647Rkh2jJyb/NVUy0R+wh6QVIxVyHoeDsmIQGKDvqqFWNl+OZijDi9ikdSp3W5z
 FgrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783334318; x=1783939118;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=5VkK9k74ebQRJ38950Z9aIqi2wp8L5ul2wcu1BDzewM=;
 b=KDsc7tO8cPWUlpn+SbSOI5Moqvl8JJ3wkBUjiYpy8bthTtaB3qiVFwfHR3ALbkMshg
 iHrENALzRuzt7t4suCt4xPHDXuk8XQgl8+u2p68Cty4JK6+zr9E2HUWf5+sy/ymr1SyH
 13CVtR5CtwCtn0MFm70aL8/78bNYhjrt/Kc6+BrpXNOkLQgyMBm671EHT7w0BtnfIsFQ
 9N0w2uw5gXCOTNfULsjJvj402EqkCQhJZHyV+ySBtcMzHGi/ZrEZaw+osZOonLTEtpsk
 yX7dRhmTMt+pQVG+JH+DZglq/J87qQEI1xRF0u7HUWDHeE5YssQMcP9knoje6TwXkX8w
 6YnA==
X-Gm-Message-State: AOJu0YzVTkm0bnMWBHT63frDI9rPLoTUtDI6gVpIU7s7f9s2cLZG/KKV
 Gdt6U9sgfpsGe1+dnNpegSnRy+dvg8pW8pQinhUWnk0yoPlJFQRkDiimmgJZkL1aCzRHee+BBbD
 xNQL2C922Dw==
X-Gm-Gg: AfdE7clnKl1afu6owm+kLx194lSEi/Oz/QVgFhpVVFs3MuSX6dxmz1l51N0zmK9bmB4
 h5Gh9vapWtwsVl8j8CTva021H54gZFhe5KqJGxLRfBzLbidtVMQjKEu9Mg9+IvWu3yiSwjYQXpX
 7udd6BiLLujppYK4z2b+UIMX/QXW3qxia5kQpFbUuzCbpxx13XPiP5i+0rIVqtb5E24hu/fL03q
 Qf8ldsCOQO1x1q2jhx0JJfRP+ZkOvVIuQcx65+3O1qciM2IkbVs3pCTNVqfp/bID5ZxMwNQBeLx
 ldtuEysbaHE0f5EfDBkMTm7ThbO3QD9n4yZfqRBxjcZtXvlzGE3nhIr1IzAs0THcAf38lAmmBi2
 VybkgPDlV+ol4RtD6Tbe+DPZhA1AJ1DcSLdQ9n3Kazd1P28x0G/2A2kplZw3zmkF9h11zVckef7
 sh4ohXvi6h+lFjH42JtPdFrqSwrbw2N4el0K/l6YzaMZdTD+AW7ooV4KZYMQ7tCVOSzTha3vFqN
 zBxYLld5mquo8DSVriMyw==
X-Received: by 2002:a05:600c:19c7:b0:493:b3ba:84b4 with SMTP id
 5b1f17b1804b1-493d11f5b11mr125569365e9.29.1783334318278; 
 Mon, 06 Jul 2026 03:38:38 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493c63b6f1bsm329501805e9.10.2026.07.06.03.38.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 03:38:37 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 42/49] target/arm: Implement UMOP4[AS] (2-way)
Date: Mon,  6 Jul 2026 11:37:45 +0100
Message-ID: <20260706103752.320511-43-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260706103752.320511-1-peter.maydell@linaro.org>
References: <20260706103752.320511-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
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
Message-id: 20260702204314.79224-13-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/helper-sme-defs.h | 3 +++
 target/arm/tcg/sme.decode        | 2 ++
 target/arm/tcg/sme_helper.c      | 3 +++
 target/arm/tcg/translate-sme.c   | 3 +++
 4 files changed, 11 insertions(+)

diff --git a/target/arm/tcg/helper-sme-defs.h b/target/arm/tcg/helper-sme-defs.h
index 3da40d9f33..38b23690d1 100644
--- a/target/arm/tcg/helper-sme-defs.h
+++ b/target/arm/tcg/helper-sme-defs.h
@@ -382,6 +382,9 @@ DEF_HELPER_FLAGS_5(sme_ah_fmop4s_sh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env,
 
 DEF_HELPER_FLAGS_4(sme_smop4a_sh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sme_smop4s_sh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sme_umop4a_sh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sme_umop4s_sh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
 DEF_HELPER_FLAGS_4(sme_smop4a_sb, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sme_smop4s_sb, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sme_smop4a_dh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index aef3fae8db..fbc85b8206 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -1118,6 +1118,8 @@ FMOP4A_sb       1000 0000 001. ...0 0000 00.. ..00 00..         @mop4_o2_s0
 FMOP4A_hb       1000 0000 001. ...0 0000 00.. ..00 100.         @mop4_o1_s0
 
 SMOP4_sh        1000 0000 000. ...0 1000 00.. ..0. 10..         @mop4_o2
+UMOP4_sh        1000 0001 000. ...0 1000 00.. ..0. 10..         @mop4_o2
+
 SMOP4_sb        1000 0000 000. ...0 1000 00.. ..0. 00..         @mop4_o2
 SMOP4_dh        1010 0000 110. ...0 0000 00.. ..0. 1...         @mop4_o3
 
diff --git a/target/arm/tcg/sme_helper.c b/target/arm/tcg/sme_helper.c
index 5a9e3b8398..fd085850ed 100644
--- a/target/arm/tcg/sme_helper.c
+++ b/target/arm/tcg/sme_helper.c
@@ -2953,6 +2953,9 @@ void HELPER(sme_##NAME)(void *vza, void *vzn, void *vzm, uint32_t desc) \
 IMOP4_2WAY(smop4a_sh, +, int32_t, int16_t, int16_t)
 IMOP4_2WAY(smop4s_sh, -, int32_t, int16_t, int16_t)
 
+IMOP4_2WAY(umop4a_sh, +, int32_t, uint16_t, uint16_t)
+IMOP4_2WAY(umop4s_sh, -, int32_t, uint16_t, uint16_t)
+
 #undef IMOP4_2WAY
 
 #define IMOP4_4WAY(NAME, OP, TYPED, TYPEN, TYPEM)                       \
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index fce07b2565..a8fcb0630d 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -2110,6 +2110,9 @@ static bool do_mop4_int(DisasContext *s, arg_mop4 *a, MemOp esz,
 
 TRANS_FEAT(SMOP4_sh, aa64_sme_mop4, do_mop4_int, a, MO_32,
            a->s ? gen_helper_sme_smop4s_sh : gen_helper_sme_smop4a_sh)
+TRANS_FEAT(UMOP4_sh, aa64_sme_mop4, do_mop4_int, a, MO_32,
+           a->s ? gen_helper_sme_umop4s_sh : gen_helper_sme_umop4a_sh)
+
 TRANS_FEAT(SMOP4_sb, aa64_sme_mop4, do_mop4_int, a, MO_32,
            a->s ? gen_helper_sme_smop4s_sb : gen_helper_sme_smop4a_sb)
 TRANS_FEAT(SMOP4_dh, aa64_sme_mop4_i16i64, do_mop4_int, a, MO_64,
-- 
2.43.0


