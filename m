Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70374FF8862
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 12:57:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHLUm-0001RJ-PK; Mon, 27 Apr 2026 08:55:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHLOB-0008K5-Vi
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 08:48:41 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHLO9-0005oC-M9
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 08:48:39 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-488b0e1b870so172758825e9.2
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 05:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777294116; x=1777898916; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=jLexmZ22R7yN//oFkj+EbU4YprJnXV4rKA/t3VPqaqc=;
 b=QC91NU5aQuieAWl1Rt5Q9eyUAGPThUl60JkKQppgncLB8Ufx+c4FXjbDlA0Bbi2It4
 haUOx37AOYPmfsscf2kWjUdhwo52Ie9UdvIPJafWD/o76Du/nlRBpqOBwuVVp3easV62
 kBQVeiwuetcI6axxvvH8dEpBxjaHFK4hk23ZQbocZhxStEiIr+xv2VorFSLaNA9b4bL5
 zu8Rjafe2PikIXwagNYzYWcoDYjfKo9OnlE53ZsRbCqJb4B5L0nWMRZvjpzIQ473gJrm
 6xN/iGgAuRJaOaadAW7afw24GLiagtYhEgn+YQrWCD3N5iyw976L/Z53U+ZUO03yc45S
 4pJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777294116; x=1777898916;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=jLexmZ22R7yN//oFkj+EbU4YprJnXV4rKA/t3VPqaqc=;
 b=sk9nF0hIYkEDzsKdeochj8kjPueq8XN6JawuRcT/AyLEadzI/uj5d6yfNw8VRyQeiy
 WQqWREz2VKpIf2nYXwwPw9kbpLPSKqHclLjDNY/tDSEOKqflPmj2n6bHhIvGXlzlkRc0
 mPzyD+zMRgnC58PH7fKyEtFa4DfXSv9alri8cyQ7sHbD1zIGaTeuxI20PmPbs2IIU1Hf
 3Bv++XzI28W5WIoyTHhK9aC25eUUz4IEOP2Z/0KEENSeVWtqi6cVVDxliKFaoknOnjY4
 YlDiAthW/QKDGZRQHUa1T9Hz42VWdQUvTwECpyS/B9In5/AC1ujfTMyjmpSeU4glOBJh
 1Y2g==
X-Gm-Message-State: AOJu0YzrafciQD0dcOa7fkUEYHg2qSDzIZLPUDGwhuam9hMo8oSOrLaI
 FDukx9ko6XdRhrH0KI7/65e6Ta36jKQ1U+cjtUDzYK5GjTwnIhCPwo/pMSoA5qQTvpXZdlBnTEm
 bk38F
X-Gm-Gg: AeBDietcLN1OL+J7mgX3ndWEDqNjVS2JHYMgkUjMzWMuLXJIbrBbOFYXL+7bTuF50fh
 JjuR9WXAOSLkJBo6RwrGG9bCOkZukoeOaHcavlMSzI70Gt0q+5wah18ppojuTq2I9pPnNg+aex4
 rln5M9PJ0RU9Bintpg9VU1+lIwtOg3CttPIehnx9i/ygt9Wpsuai/c+6iCNB8MzX5hnxNH9ldEj
 kCBQ6w7RPBtlQE3l705CvNw/VQY6oaqui205UAMwJMQFSWjGELmmbv1rsNJI0maLnhqkDFFt84H
 MXKVuXNio0kGXYuBkpGurND/VS2wuznfvfpH7CUWqdMIm3T/todUrQr7+S7+N+qrB1Pni3Q/QlW
 ySYzPnQ3fXwQa/U9yrjlsJWD3dhuFMnP+foB7YEuMK7vf4RL08ezvpqhFK7DxD0W1d+WsUADSLh
 yJUJmAeWySN6G8Y8tSjOnMPwSxvdrV9WmLh3R5VLSIZ5g0nZRoXXUSGHF8MK+Dj/5x/iDb9r17m
 Vnv8ymh8PAQopkC3oy5O0C2ijuw+LyHMeHEJelBBg==
X-Received: by 2002:a05:600c:4e4f:b0:488:a2ac:a34c with SMTP id
 5b1f17b1804b1-488fb7433ddmr592030455e9.12.1777294116093; 
 Mon, 27 Apr 2026 05:48:36 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488ffc5e3f4sm448974115e9.2.2026.04.27.05.48.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2026 05:48:35 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 62/63] target/arm: remove old syndrome defines
Date: Mon, 27 Apr 2026 13:47:36 +0100
Message-ID: <20260427124738.966578-63-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260427124738.966578-1-peter.maydell@linaro.org>
References: <20260427124738.966578-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
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

From: Alex Bennée <alex.bennee@linaro.org>

Now everything is defined with registerfields we can drop the old
defines.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-id: 20260422125250.1303100-23-alex.bennee@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/syndrome.h | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/target/arm/syndrome.h b/target/arm/syndrome.h
index d4dfab8cd1..04a71eebcb 100644
--- a/target/arm/syndrome.h
+++ b/target/arm/syndrome.h
@@ -106,15 +106,6 @@ typedef enum {
     GCS_IT_GCSPOPX = 9,
 } GCSInstructionType;
 
-#define ARM_EL_EC_LENGTH 6
-#define ARM_EL_IL_SHIFT 25
-#define ARM_EL_ISV_SHIFT 24
-#define ARM_EL_IL (1 << ARM_EL_IL_SHIFT)
-#define ARM_EL_ISV (1 << ARM_EL_ISV_SHIFT)
-
-/* In the Data Abort syndrome */
-#define ARM_EL_VNCR (1 << 13)
-
 static inline uint32_t syn_get_ec(uint32_t syn)
 {
     return FIELD_EX32(syn, SYNDROME, EC);
-- 
2.43.0


