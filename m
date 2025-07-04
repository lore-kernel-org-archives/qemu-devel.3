Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78574C83F09
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 14:51:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXhTj-0001oB-J3; Fri, 04 Jul 2025 10:33:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXhP8-0002O2-71
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:28:44 -0400
Received: from mail-oa1-x2c.google.com ([2001:4860:4864:20::2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXhP5-0001Jc-Sc
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:28:41 -0400
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-2ea34731c5dso864243fac.0
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 07:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751639318; x=1752244118; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mE+L0a4Yv78oWbvNtAlRfemO9fxwjgUBwoQXmXgyee0=;
 b=Rio9bp1Jdd5OE3gIF4RwlMyd29XkIYF8aBl7MN3KE3fMUf+QtR7sJZqGzmvgAfMfvs
 O3hsWzs9h8SHoWpP41xpDNRr4rs7YmilH1MtOo+LJ6l6m9H9xjLee8u0vO/gQi3P/fDE
 SoauYTPswF+QTwl3JhQI+Sr4c08kYqCOkO4+h8BM7PPAqdR05IspoKR+vC1pW3quxd2F
 xAMoMTEZ/3Io+F2KvG6AwOsgyTaEcqaJmwsAHMpyNT9p125N5J6ucbZesXWH+d/2Y8HU
 QzIPYvl5GFRCz4Kc8EfWyaJlbHPQ6PZsHSspN8jDwwmm210Hl9XzP74iH7tLssav2utm
 57yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751639318; x=1752244118;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mE+L0a4Yv78oWbvNtAlRfemO9fxwjgUBwoQXmXgyee0=;
 b=s/5hdMzUPrf3YIU4gfu3uzXmfdHS+7XzUO4r9oZMsMEcM67pCMlgj6gXjAYQnxydRq
 dtEeeNNbRf2/8KNg00VBd88oYm9rI3mcVwn9Ns/RajJpzDdO4qQRZLok+ydpbp89NJ7+
 1JKFc/6tY47Bpc5SnBkPsPpkPfyLHabf1Y/YNhrVCunbn3jaOlAd2yM3yFntAJckK83D
 rCQDzLdjllfAV4BZW5S8vX6I7jhitRY55pt18lemqDMLOrSJQY2SCL9hGALz6DLbLMQl
 0xnQupWyL7vWnhSwcbApswOHyxVVlTFULjHZBSQpNvNPgBgSxrGx9XXaA/9h6K4c5I++
 eGnA==
X-Gm-Message-State: AOJu0YwHde1lNcPEgkL4n6ykS2ua5d8A0rT4jOkrzSCVbiHyDpoz7b1h
 yKJigxOveK//UwA9ZL9JR+DXiq7sF4Y4G6tl2+R3nc7X27SbcwbIOu+QSZ94Q+4zlz8+tlqgH4l
 OIv1gi1U=
X-Gm-Gg: ASbGncuw7gigl/mifLMp5c0YM3bVbbx2Pm8zGAfUcuMYX12HQcWB17t3xR1I5BZ4rWE
 fVeArkdY1sMu7t1lvhBw28o3teQQua2yUvil51lGfQFGq+BIEWTDlC5r+QKzMPdzTxsQ7V7U2ar
 xiub5VbmIAc0prKyeO6HrxvOfLBAKYZeKzysSFXXiumr/eXW+R+mIRcxLoFdUQhXNbvymoRtRfS
 8vylfsrHk0cds5QmDgj1t3mAssWnl8B+77dWw7vjDRf1we/yoZOshXA92IuAWZITwxxrLZsvxDL
 wcqDX5hG74cEMQ8O7YLFhLaKJKsWtdKaFCmLwzakAaINuTIBG18LvMhsb6UkVt0tp07IYb1G9kz
 /FltLNNkQmgKTQa0ISkuWtRNqPaua3WLSyx9SsLo2a3nGqUFp
X-Google-Smtp-Source: AGHT+IFKuLE3sJdiOEqZtPhJKeuA/kD73zzPZkg2943XOxbjYQ8dGX1toEnd9/4frRLHReyBzQQH7w==
X-Received: by 2002:a05:6870:ac0d:b0:2d8:957a:5163 with SMTP id
 586e51a60fabf-2f791d4ecedmr2340480fac.10.1751639318497; 
 Fri, 04 Jul 2025 07:28:38 -0700 (PDT)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2f78ff55633sm531448fac.20.2025.07.04.07.28.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 07:28:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	peter.maydell@linaro.org
Subject: [PATCH v4 080/108] target/arm: Implement SVE2p1 PTRUE (predicate as
 counter)
Date: Fri,  4 Jul 2025 08:20:43 -0600
Message-ID: <20250704142112.1018902-81-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704142112.1018902-1-richard.henderson@linaro.org>
References: <20250704142112.1018902-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2c;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2c.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-sve.c | 16 ++++++++++++++++
 target/arm/tcg/sve.decode      |  1 +
 2 files changed, 17 insertions(+)

diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index c93dca224c..651b4aa378 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -1679,6 +1679,22 @@ static bool do_predset(DisasContext *s, int esz, int rd, int pat, bool setflag)
 
 TRANS_FEAT(PTRUE, aa64_sve, do_predset, a->esz, a->rd, a->pat, a->s)
 
+static bool trans_PTRUE_cnt(DisasContext *s, arg_PTRUE_cnt *a)
+{
+    if (!dc_isar_feature(aa64_sme2_or_sve2p1, s)) {
+        return false;
+    }
+    if (sve_access_check(s)) {
+        /* Canonical TRUE is 0 count, invert bit, plus element size. */
+        int val = (1 << 15) | (1 << a->esz);
+
+        /* Write val to the first uint64_t; clear all of the rest. */
+        tcg_gen_gvec_dup_imm(MO_64, pred_full_reg_offset(s, a->rd),
+                             8, size_for_gvec(pred_full_reg_size(s)), val);
+    }
+    return true;
+}
+
 /* Note pat == 31 is #all, to set all elements.  */
 TRANS_FEAT_NONSTREAMING(SETFFR, aa64_sve,
                         do_predset, 0, FFR_PRED_NUM, 31, false)
diff --git a/target/arm/tcg/sve.decode b/target/arm/tcg/sve.decode
index 389a72d824..3517efb31b 100644
--- a/target/arm/tcg/sve.decode
+++ b/target/arm/tcg/sve.decode
@@ -730,6 +730,7 @@ PTEST           00100101 01 010000 11 pg:4 0 rn:4 0 0000
 
 # SVE predicate initialize
 PTRUE           00100101 esz:2 01100 s:1 111000 pat:5 0 rd:4
+PTRUE_cnt       00100101 esz:2 1000000111100000010 ...          rd=%pnd
 
 # SVE initialize FFR
 SETFFR          00100101 0010 1100 1001 0000 0000 0000
-- 
2.43.0


