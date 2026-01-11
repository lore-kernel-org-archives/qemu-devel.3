Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D055D25031
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Jan 2026 21:59:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vf3SC-0005IS-FZ; Sun, 11 Jan 2026 16:58:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vf3SB-0005I7-Jl
 for qemu-devel@nongnu.org; Sun, 11 Jan 2026 16:58:31 -0500
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vf3S9-0003ps-Vw
 for qemu-devel@nongnu.org; Sun, 11 Jan 2026 16:58:31 -0500
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-bcfd82f55ebso1941437a12.1
 for <qemu-devel@nongnu.org>; Sun, 11 Jan 2026 13:58:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768168708; x=1768773508; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7t6nw/UxLr3T9liZ2npxtCDDAh6coiuxkrxLk4TiJc0=;
 b=cYF1MWSM6XIBpLUje+KXkBKClXZQhYdnINjnGE0eEGXmDTbfEf+StMvMwTPON72mPD
 AtJg3WG8u1nbZbI/oAOuZ+lTh3yTKNebn2PSGkptUm8sSDD3lI8WHTtUUHHG+2Oxj/4j
 VL67uNoCdok55gYSh/rr3TN97AyTgaaZSDP+b1vlykmVacmUnEW2sSg5c4hoS0mCYBq1
 SXp1DDpabn2CW9o9iobrBHaCAzF5fJLu1Q01UuZMww2i2CRghVn/4J+Ekwc2fq6dYRAC
 tA/9NysqINgoZpRuXUu6ODdN0eRhxiHbZ5fcyVpRQdkbRCToS16gdNdAvWIacMDymWYC
 WWxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768168708; x=1768773508;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7t6nw/UxLr3T9liZ2npxtCDDAh6coiuxkrxLk4TiJc0=;
 b=InFRSo1NOgrNyJqI5QPcXGy0MDx/Rlq0xSZtahVNVM42SmrFe2PfC4zR0+z59GbLf6
 kTZ8Z4KYyZi5ZMoq6AXQVZyowK9vnd2SRLTzcF7Fqt6Ct88gsQ0APGa0VT1Iptzz1BSD
 6LH40hH1aBykbX/TSnRKW5CAd1zsjHYfymTF1Nr7gd5Y7udB642a9E5wevszlcPgRbW4
 QZwxshXrCpYof8nMLtGtiSYDnOywOLMMsuIAULGNyZ3Ckc+00kKP8TXCp2UVtMH4awk4
 F00PcGxGesrMf2KfNAiLp8qb8v7ruV2H0bOtmxkDUzC5vxJnPzN0czw4SSngWLKNd54X
 aJVw==
X-Gm-Message-State: AOJu0YxS/ONcFakhroBwwwHg77Wwhu0xMxDQ8WtS3DRRGcD25oWN88ef
 yueXeBwLLuqH3SYy38bMqDr6sMV+x+q65Osd4ttixgbn4ytb9kgHJoNz7Lz95L19DYBxbQJGv9n
 kcj/UWKI=
X-Gm-Gg: AY/fxX5xmT7PR/wEBkz2oUMI1u1+2Z6pc+ivjmHRQtJKyzOxKf0YZfIl/v4I7XChymL
 iNHVonhYu1Dtaba0q3ON6yeQ/XGVmdqZwcxGAkMmBuLY9FD5hSFLwL1DqvWQI+PwqQcXp1lzyW+
 D9KCzZM0xn2AymQ5JyoDIRsqCGFANNrvwqapAXdBBtABfLmFuWqiGBK9ciFEy706b+L5vngthcS
 nTRnkQjnYmbdcI9yrEwtQdFFbaV60s1ooVO722LJ2uDUB0vAo2aYH/qa1Sk1h0+GMRBxJByx/Lt
 /dzRfVnP4EHLucRh0u7t8rqgONbWp+hreMg2g8ZdMG7qXkmgxoo8PzNlop6hdVh7JPW2mJKO7Fi
 6yAbyeWmztEB7+2pcjDYRRrM0R/Suikumfn52MqqSYyNIEvfgtlHqkbxPI/WFWxz9rye5mBpi8w
 HHHgnC+756R/KG/Tw=
X-Google-Smtp-Source: AGHT+IFnMIw/Ex0rYkycWspwa+H8hW2C7c/OqLWPVPP8ld4TEqlL5WfypXwLSTdsLOugzOkfGJrGkQ==
X-Received: by 2002:a17:902:f606:b0:295:28a4:f0c6 with SMTP id
 d9443c01a7336-2a3eda6542bmr170960435ad.0.1768168708356; 
 Sun, 11 Jan 2026 13:58:28 -0800 (PST)
Received: from stoup.. ([202.86.209.61]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a3e3c3a31dsm155272365ad.9.2026.01.11.13.58.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Jan 2026 13:58:28 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 01/13] tcg/optimize: Save o_mask in fold_masks_zosa_int
Date: Mon, 12 Jan 2026 08:58:06 +1100
Message-ID: <20260111215819.569209-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260111215819.569209-1-richard.henderson@linaro.org>
References: <20260111215819.569209-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x531.google.com
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

When adding o_mask to this function, we used it in a
couple of places but failed to save it for future use.
Also, update a related comment.

Cc: qemu-stable@nongnu.org
Fixes: 56f15f67ea1 ("tcg/optimize: Add one's mask to TempOptInfo")
Reported-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index f69702b26e..1f95da487b 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1088,8 +1088,9 @@ static bool fold_masks_zosa_int(OptContext *ctx, TCGOp *op,
 
     ti = ts_info(ts);
     ti->z_mask = z_mask;
+    ti->o_mask = o_mask;
 
-    /* Canonicalize s_mask and incorporate data from z_mask. */
+    /* Canonicalize s_mask and incorporate data from [zo]_mask. */
     rep = clz64(~s_mask);
     rep = MAX(rep, clz64(z_mask));
     rep = MAX(rep, clz64(~o_mask));
-- 
2.43.0


