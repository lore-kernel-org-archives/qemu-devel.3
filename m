Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 113A0CA0EE6
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Aug 2025 13:11:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umXeH-0003tO-Rs; Thu, 14 Aug 2025 09:05:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1umXd5-0002RE-Na
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 09:04:28 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1umXcx-0005Co-7r
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 09:04:25 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-76e2e8e54f8so765996b3a.1
 for <qemu-devel@nongnu.org>; Thu, 14 Aug 2025 06:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755176657; x=1755781457; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xwpjIKFwZpPOs1MrHyzWBavKC4efZpu/4iinDNh8yuo=;
 b=usTz9fTXBVkMY4ZuWxXPeIDns5tFcjOoXg2m6H9Q3ImOlj8xyYMooTEzGVC2aOjD+l
 4lU6orl+cKpllZUvmwbZefGBrtunmwzHAabhYbr9Y0NPa437q9sLqzS36H+TAD1tdPQl
 D5pQDB5xu0lH61R7n+R9yLics7C/4jHhhSr1wKIl14Dp8WJxispdxMuZjSNwGNIL5mdr
 HsMPfUvNRP36eTagr3U3cESLG+oEuVl6ClUi/O70T+Bb9bJ8rsT15WQTDEAv19rsIRSW
 ggwwZwXqe7+trqyuAhFtW4I937NNnV4/uthDNsQ+Fn/AhCumPbRYpLTSspTMtk7/Gvoi
 zC3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755176657; x=1755781457;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xwpjIKFwZpPOs1MrHyzWBavKC4efZpu/4iinDNh8yuo=;
 b=smEQVVUcY+d2iALOOMA20YMS0LB+jH/xZFWeIgNJdRb0HO7x0OafnDRfCQ5Uyt919Q
 1kapuS3DLHsByLab1tymvLzPHBY98L47vb6usDpo7X9tiRQRLGdZfA1JC5nvOISVuv/I
 ypTqDKT8wsfi8OrYnb5xh9CPd0eAkX1k+TE+071jvppdt5YBnDFDFBfTvUeVws66N4z3
 ckv1eO++Um+FZftYUYcelRBCuxm7FLv/D8GgTh9ke9MD8CY893KwrqHAVxqc44syxcAV
 I0PhIpjC4dgaG4nisq06Y6ATVFhRAC7Hzmd+V7xpgOzK8PIEG0Dvjm6bxe+YhHj2/PrY
 4MMA==
X-Gm-Message-State: AOJu0Yzu1DsNcry/t8Pc/aauPVXZjeCyJKdV49DAgsmNE78DI2LKv5wn
 T11HBnMPws4L30fpHKBEhab5OsIAGq3E7Y4Paawj13M7aCNofEhq61GluYuZvECaJU8hSRs6P80
 8lRuCdAI=
X-Gm-Gg: ASbGncvRIq42hOQ3Vz8I5iDz1KsahykrCasPP5oXQwdjymrvIwj12CBZY+PiWEUw65j
 i+7OEZ/N1ceIpIJt/fNSue6I7YKyg7ZbUdQkOCbAvLQj/rck2Csgu1c0CFlBawmd/XikLbr1+W7
 a5ab7S98Us9hJ1RXVtffTRS2EfytthGR3/4xRj9P/tULVmvY9pj2962xvhoKUzhCz85sAqXaURJ
 obenptZW2XwdYzxviMpWvE4abeMIngK3KBNa65cdptywyMznLQarf4aN/9Az0/LjjkFOoSMRXAo
 0gKEE6wzx0zMtNSw/UpEqT66qg41M5i31WUiLqIWhZlO7/YHJMeJO8G0Fx/SRxPgyW9QK+lvmGr
 y4dKQW3r75advOkw2H3B625nvqYdsjdlsDb2SPT+oVAaNjHM=
X-Google-Smtp-Source: AGHT+IGi4STbiXxqX7ydKBk1Eo4SwY7tndTuha0jz1nEHtSfIrUp90SXc6DtzkroqEInQgPbtarhgA==
X-Received: by 2002:a05:6a00:3d4b:b0:748:e9e4:d970 with SMTP id
 d2e1a72fcca58-76e2f8ce77bmr4073627b3a.1.1755176656425; 
 Thu, 14 Aug 2025 06:04:16 -0700 (PDT)
Received: from localhost.localdomain ([206.83.105.236])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-76bcce6f6fesm34480631b3a.26.2025.08.14.06.04.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Aug 2025 06:04:16 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 58/85] target/arm: Implement GCSB
Date: Thu, 14 Aug 2025 22:57:25 +1000
Message-ID: <20250814125752.164107-59-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250814125752.164107-1-richard.henderson@linaro.org>
References: <20250814125752.164107-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c | 8 ++++++++
 target/arm/tcg/a64.decode      | 1 +
 2 files changed, 9 insertions(+)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index e0548f7180..45ff7bb0b2 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -2072,6 +2072,14 @@ static bool trans_ESB(DisasContext *s, arg_ESB *a)
     return true;
 }
 
+static bool trans_GCSB(DisasContext *s, arg_GCSB *a)
+{
+    if (dc_isar_feature(aa64_gcs, s)) {
+        tcg_gen_mb(TCG_BAR_SC | TCG_MO_ALL);
+    }
+    return true;
+}
+
 static bool trans_PACIAZ(DisasContext *s, arg_PACIAZ *a)
 {
     if (s->pauth_active) {
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index d034d96b37..e8b0ef07eb 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -238,6 +238,7 @@ ERETA           1101011 0100 11111 00001 m:1 11111 11111 &reta  # ERETAA, ERETAB
     AUTIA1716   1101 0101 0000 0011 0010 0001 100 11111
     AUTIB1716   1101 0101 0000 0011 0010 0001 110 11111
     ESB         1101 0101 0000 0011 0010 0010 000 11111
+    GCSB        1101 0101 0000 0011 0010 0010 011 11111
     PACIAZ      1101 0101 0000 0011 0010 0011 000 11111
     PACIASP     1101 0101 0000 0011 0010 0011 001 11111
     PACIBZ      1101 0101 0000 0011 0010 0011 010 11111
-- 
2.43.0


