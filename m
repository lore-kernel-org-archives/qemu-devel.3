Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF828CD8CA4
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 19:02:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWfEn-0004cp-Nd; Mon, 08 Jun 2026 15:02:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wWfEX-0004JU-8O
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 15:02:01 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wWfEV-00073A-OA
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 15:02:00 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2bf114b0cf9so41556125ad.2
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2026 12:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780945318; x=1781550118; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RR3f6n7QOv11gidVm90QTUAQNyftyjjJwksqYB2mkq4=;
 b=jb1Dgo7M1TC2s61FUL7Uq72M6oHEWhH5cBUygwKtfYsDjHFY0BFav/FuDRFcVPPZeG
 UKyv+dyBkIgGU/vpSrBFaCDrePF9UNV2A3Q9SKY+DzHjEZzb/90FXPnSzBREXq2p/sm5
 Ox1NJDIPy6FHvuvzeodbsUaSEx6EO2Xa32qsGp4axqWPFfEgSqsgq3uSYpz33T9zSmvU
 VWnRyI9AlVkdbJgc1VG2Qe0viFdc/04Id46eS7QsuBQP9XjNsmBg4Yb9uLEPUpJiZ/Pl
 zdXZZklWaY00nbdw0LSunBy/B9486UsGl9K0LizfhloRTuRfY0UADBc6zU1PndMyCtxY
 L1zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780945318; x=1781550118;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RR3f6n7QOv11gidVm90QTUAQNyftyjjJwksqYB2mkq4=;
 b=KUGyJB6lk91bmiGkBm3MFucgW8Fi01BCh3m1hG4P34SZ2zgo7ztfElp+D3Oc/JVpMr
 eF6R2c/fG84kiYYDuUpBmokn5klxXHjUWNllanyi2J3EpqlBFbuf4dvUwBfLcCbc5/oi
 qKOGNJb1wXfRoSUeTz9s5lLOc1YQ7jdOll1nayPxB17+hsFfk34NW/SawHiRNBlVZORT
 WE2IYCn1xtYc2kh7c3n8jB2ruHp3CKQc6iACR8a3VWaM8Fl+ox04kqwlUWtqso8449o9
 I/u6KPYf1aMVW0jjryZYoioX2/mFTH7QKstjMedWQXZbipHLkXRJULpdJMqghgXKq1Bb
 YuKg==
X-Gm-Message-State: AOJu0YxvJAS+3hPQ6TFX183iCi2xNWFCqTjeUUUjmyN28Sy6MibO+EWi
 nU8HKUwKW5Blox6mbmO4jZdpXLjnnCfJuj7H0pVNaOhL0eZVhwHJhhsXCsqgGCqyRuoOUq96kST
 o7+vKBrc=
X-Gm-Gg: Acq92OEczy5VMyXm+t4Yq0rUU6THSergnqyNsu/AzfpL1NPi/5IWtv8BDP4Em0auvtV
 hJ8cighXIvfDydzgqSZrBsTLfCnJtyLOm77gmAqvm8zEg1w/yuaJcCGkYgeE1k9E3EAjO8DQZk7
 q9XxZlSi6ToeUmXy406+nzF1uQOHXXNUWdGEfwoQeL05CrsvBbpHUIoUyy0xlqCguGWwEuFjc+r
 8p9EF6r7rwvSG4jL/ryRjYZZ43r1ON/MRnndVwHtNm5mgGyNA7JRxqcB/c0Ya+hqPOS5VxTQsxW
 Z+jiXk7Dfh0UbXYy6Bhu4iHi0n4HyfyZOGZ6jwfrw6yLgoFOjC6JLVvAbI4VG1lTqOmBVrJVKhO
 6bSlq06h2WtnLGBnNT5jhz4NpEk8pLlJHSmU0TUvGko9lnrltqOeAbe1X6wpbNZqOnBk+isIsFZ
 ZAZR6SNS5JelTjfT29O9AhVfTfKpjdIXbPU27OsN4=
X-Received: by 2002:a17:903:2a84:b0:2c0:c389:d99c with SMTP id
 d9443c01a7336-2c1e8332a7cmr185718865ad.15.1780945317848; 
 Mon, 08 Jun 2026 12:01:57 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c24edbb49bsm60900875ad.38.2026.06.08.12.01.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2026 12:01:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH 1/2] fpu: Handle all rounding modes in partsN_uncanon_normal
Date: Mon,  8 Jun 2026 12:01:54 -0700
Message-ID: <20260608190155.637067-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260608190155.637067-1-richard.henderson@linaro.org>
References: <20260608190155.637067-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

Missed float_round_nearest_even_max when recomputing round.

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat-parts.c.inc | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
index a154faf32b..c86fc9ccc5 100644
--- a/fpu/softfloat-parts.c.inc
+++ b/fpu/softfloat-parts.c.inc
@@ -437,6 +437,7 @@ static void partsN(uncanon_normal)(FloatPartsN *p, float_status *s,
             /* Need to recompute round-to-even/round-to-odd. */
             switch (get_float_rounding_mode(s)) {
             case float_round_nearest_even:
+            case float_round_nearest_even_max:
                 if (N > 64 && frac_lsb == 0) {
                     inc = ((p->frac_hi & 1) ||
                            (p->frac_lo & round_mask) != frac_lsbm1
-- 
2.43.0


