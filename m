Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 389A4C2BD09
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2024 15:27:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRCjx-0004gT-Qn; Tue, 09 Jul 2024 11:26:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sRCjv-0004Ur-Ua
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 11:26:47 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sRCju-0006Hr-A9
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 11:26:47 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-426685732dcso16441365e9.1
 for <qemu-devel@nongnu.org>; Tue, 09 Jul 2024 08:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720538804; x=1721143604; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jD29YVy94pKbQqMrPlTZs935rnLUzr1rrw21fvjgKcg=;
 b=wkUSSrtTEMBLbjSD3SUW4Qj57LOYtmzzTYnLyHlMJBftbldSdLZ106aEu2/PfYname
 Ib4V8B0S8FrDMchZNTD81NEN9IwLpZlEyOZG0cUh9bU0I+3rr4ATFAZGGh+9KdYX14H+
 k9UI1GbqIf5RRE3jrTpTxKX91EH6oO2GzqQ75DLQC+163RjhvtcW5KTt9nQBggwg/mQf
 mzm5J/pLkz+DBm36w32F6L+W1lDEhVQZAvAbssMEc8tL5tIK9yEY4p5p0bArM+wQyJlf
 Q7rTzdQk+GeY0TUv1ea8cQrMFqswG5Q+eXkJma/MWmFtldleM6UE6ITg270BcXawLTKR
 FxFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720538804; x=1721143604;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jD29YVy94pKbQqMrPlTZs935rnLUzr1rrw21fvjgKcg=;
 b=p6UW8aJKw2TRrkHHqyD2LPo7i1secr5YRbSuNXQI9TCrpccdqOEFsmQx05eUmB3+zF
 0rGst3kC3dMIdLMO0aiZUVELfxTC+N1OtxzqimE7D+Qr+P1Ge0HPOV4WUn0sCJTtLLm2
 MR8GvP2wxTdyDkW8sykkDq58bqFLTKR+mzufvdL94QSSFILZWJfzqySO8iY53HSFbgBk
 9Y4siDFEyn2g9HtqqTEWVQcLiCIYiLCQptXHLeu1D/xo6wk1pORKYaBNuPNUDTugksHM
 TyaW2ImBTP4pAJQi14YLMYA3yteQ7iWOEUTe1My0Pg7VMM9IO8viQwPku6hCv1vWlSjo
 aOnQ==
X-Gm-Message-State: AOJu0YzaEO/Jq1iP60MZAOQXt2xglyT9rfkxHPZrqojebL3Alvnzyc3Y
 G7Cufe6s9U4KMFbxu3HTlk0n3TiR6WNVchNqxnnf4UnmbGPjQOOil0aktD7hiYbKSVQnoKbaXzQ
 N
X-Google-Smtp-Source: AGHT+IEXjb306JzxR/cR26c8BXpG0hrN7iEeHN5aN8GmhonxUKGP9ExWzo7zaVwrFdS6Jo1MAhRnjw==
X-Received: by 2002:a05:600c:6d8:b0:426:6389:94c4 with SMTP id
 5b1f17b1804b1-426708f9d84mr19273695e9.37.1720538804219; 
 Tue, 09 Jul 2024 08:26:44 -0700 (PDT)
Received: from m1x-phil.lan (vau06-h02-176-184-43-20.dsl.sta.abo.bbox.fr.
 [176.184.43.20]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-367cdfa070asm2843999f8f.83.2024.07.09.08.26.42
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 09 Jul 2024 08:26:43 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, qemu-block@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Bin Meng <bmeng.cn@gmail.com>, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>
Subject: [PATCH v47 07/19] hw/sd/sdcard: Fix SET_BLOCK_COUNT command argument
 on eMMC (CMD23)
Date: Tue,  9 Jul 2024 17:25:44 +0200
Message-ID: <20240709152556.52896-8-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240709152556.52896-1-philmd@linaro.org>
References: <20240709152556.52896-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

From: Cédric Le Goater <clg@kaod.org>

The number of blocks is defined in the lower bits [15:0].

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20240628070216.92609-88-philmd@linaro.org>
---
 hw/sd/sd.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 83d45c897f..216d4dfa89 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1533,6 +1533,9 @@ static sd_rsp_type_t sd_cmd_SET_BLOCK_COUNT(SDState *sd, SDRequest req)
     }
 
     sd->multi_blk_cnt = req.arg;
+    if (sd_is_emmc(sd)) {
+        sd->multi_blk_cnt &= 0xffff;
+    }
     trace_sdcard_set_block_count(sd->multi_blk_cnt);
 
     return sd_r1;
-- 
2.41.0


