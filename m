Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A2C4CAC598
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 18:08:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uya4Y-00035v-HF; Tue, 16 Sep 2025 14:06:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uya4T-00033C-1Z
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 14:06:29 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uya4R-0001aR-F8
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 14:06:28 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-45f2fa8a1adso1012815e9.1
 for <qemu-devel@nongnu.org>; Tue, 16 Sep 2025 11:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758045986; x=1758650786; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=d1YOtX8BVonSDnFz/8OmLW8ozY+GsiqJe/aKd0r4lgo=;
 b=x7/YZjPlL55MXy3A4ZwyuNX5CMW1jR8AxkLNclQfg3a+GwbvkUoCoWzrEeK0u3dweI
 jiWNyT9WEEyQHP1rnx8Egd1gd4Aefml51DGdBuaWwSnYui1JSVUYNGD+fKncjf3D+T3a
 hWIWpFw6KJToAgGjKzj9FznZAWOYsvlt54yaVGH5gDZmK+lk5ECgqwMs3rJipNxujOra
 uqiuU1UJKdPEhAGChKYF8HKNUXTvKlg1Huzj6uftLq53irsPBODF/adVa1gUlaWiB6jw
 GIjzO7acYE4+k9MCzICU0rpSAShN/QWr3km2X/bk6XfYTHiq5jatzu6ceipysSh0NVYn
 CM6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758045986; x=1758650786;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d1YOtX8BVonSDnFz/8OmLW8ozY+GsiqJe/aKd0r4lgo=;
 b=p+0hYgzt01VuNsAVcZ2w6VY6ni8Xpgv9GbKy6EUWIAA5vc6aSs9RnZ5iT4Vfg3pLdE
 eGfEESpMRWCCx6oWIQwMgBeeg3lTv09sPO7YOnoqS04CsR8PHz5OVPvBMFn2lv0Fpr7G
 5kAE1LbiqikZelq25MqtzpsJzdEM0U6eXqZf/oqwy0E2p+gSiGT4Nr1YAgvAeUrOMY7F
 Ul9Ff/bzEapzxMU+qSYGaSdN+ls4gh0OzSoStvutgQIixVpyOhiTNJb8NhGojhOf5cK6
 Wk47T6iIikaaIvc6jMBnTdg0XfZrcFRjXAdZVtpbzvBXwVfO/OeYrxrNwNHZXC/TmXgQ
 DW7A==
X-Gm-Message-State: AOJu0Yx+ywsRVpivH2dyftwEEi6pyjY4sjcK/Xr9p+HOZEmikDJEzWwA
 B+sj8hogYNtukxjpF7Tqst91D4ti6QxAHcpzhrhjcmAYKq0Y+M6ZN9W86z3dNdjPFxTF/DBVXvf
 rabRv
X-Gm-Gg: ASbGnctAno1pN842Cc2sMgzys1RhtOIMIV0xYVYXtotntkB/SX6D6wUbttWxRxV7y2q
 CRSV42fcxnyd4GOdWYslALGW0SpqhTIymU19ZBH+aqzBpg442DDZEgTC3vC6Z4WwTEHmP8NxjcP
 j4EorFXvT95lawfTbVRqO+EZL+UQMYItlbgfKKQlmTSgyb9ZNPWSdE5dRwJs4UZQEw+hd8Oleow
 YbzWUhow0J8jSaPP5ZTlAy6dtTo/KsEr9TG5MG1wJCjjVgenz+PFf62K4vNaerDBTqLFadFS9bU
 LyGhF7qbTuj8uwkIjQJF56nvjK/F8d/SveQDgOA8zqrgw/xNf28VgQfbYXpTLkL75XuhRSLW0IP
 SPxAow48L9AsmNQvIWjuHX63sz1JM
X-Google-Smtp-Source: AGHT+IF1fi3mmM0AQE7XU+b9bNI+eikHNGKr+qetIYt+ByhJZ+ArZzYCMZqtGrdO/xbFb4KugWio6A==
X-Received: by 2002:a05:6000:2888:b0:3e8:6b2b:25e0 with SMTP id
 ffacd0b85a97d-3ec9ffa425emr3004068f8f.25.1758045985797; 
 Tue, 16 Sep 2025 11:06:25 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3e760775880sm23033286f8f.2.2025.09.16.11.06.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Sep 2025 11:06:25 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 12/36] target/arm: Remove outdated comment for ZCR_EL12
Date: Tue, 16 Sep 2025 19:05:46 +0100
Message-ID: <20250916180611.1481266-13-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250916180611.1481266-1-peter.maydell@linaro.org>
References: <20250916180611.1481266-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

The comment about not being included in the summary table
has been out of date for quite a while.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250830054128.448363-12-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 19637e7301b..b641229ba0c 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -4563,11 +4563,6 @@ static void define_arm_vh_e2h_redirects_aliases(ARMCPU *cpu)
         { K(3, 0, 14, 1, 0), K(3, 4, 14, 1, 0), K(3, 5, 14, 1, 0),
           "CNTKCTL", "CNTHCTL_EL2", "CNTKCTL_EL12" },
 
-        /*
-         * Note that redirection of ZCR is mentioned in the description
-         * of ZCR_EL2, and aliasing in the description of ZCR_EL1, but
-         * not in the summary table.
-         */
         { K(3, 0,  1, 2, 0), K(3, 4,  1, 2, 0), K(3, 5, 1, 2, 0),
           "ZCR_EL1", "ZCR_EL2", "ZCR_EL12", isar_feature_aa64_sve },
         { K(3, 0,  1, 2, 6), K(3, 4,  1, 2, 6), K(3, 5, 1, 2, 6),
-- 
2.43.0


