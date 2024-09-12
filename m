Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E490EE6451
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 06:53:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sodhQ-0005VD-D3; Thu, 12 Sep 2024 02:53:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sodhO-0005ME-Iv
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 02:53:02 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sodhM-0003RX-Td
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 02:53:02 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-428e1915e18so4373065e9.1
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 23:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726123979; x=1726728779; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=vlRmpnbCbgSErzwwLA97yhTv9fMzKif0TAzO/KO/JOk=;
 b=WtR5X7Kr61e7FTeTtdt7RHjLuhvm9ZcmZAHx8w4m6CU6T3DFKZILu1/6UqxxC1Yuua
 d/+lnh1TXhcIOCYNaho7D2YMvbKoxYUVfXkAkhpudVuyl+Ag7LAohwfQrU59ivFnKwp8
 GgsgIaVL5InyxlcNsXp5NitxHdAFnjAAq3E3ujGLUtkSqKtXe4I+sdPq1VG4XJ5vT9ky
 NU/zhc33vfvNtg+YmBr3SbBGi1C5lEY0j37LlBRMwHUvgRGLRmW72I59tLbHjdEkxRWD
 UYaoAxla3/FdDKSfIHf/8w4X+nQ8VUBXNjwGFuAGyiKeO5S9REujHpGuWjCJ0YsvG6Cg
 tXdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726123979; x=1726728779;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vlRmpnbCbgSErzwwLA97yhTv9fMzKif0TAzO/KO/JOk=;
 b=sCkJZkxp7qQeFecb0R7g98aftutTAxL20Cb0nDpyy5XlEsWmunYEIK1VytQ2QTYqel
 xgAkd8nCP5jsBzbgK/MABAOOXTvSBW99mXHhswVCxiQIELrbfSR0j5KS0PSV9jMrxUSn
 8NGOCQAzdUDLFtdElklKJoID8odJpEDLTkIAICW6zOzGxMclzMwGGEE7AUlhvEX3wgj4
 TYRN0QOvMHYlqlkQPP7HbhRMSdAKXw25f8yc0blkl5RDajsQK7G6fITCI4VYsueWLTOy
 TXiSP/+LeAjGX9bQqoSFM6nRUeK1tBFzSyeBefR9Ky1eD4U/EAQUOhR7ZIemURflIpAd
 O4ng==
X-Gm-Message-State: AOJu0YzyBCoNl8mTtZhUiysH7fC8BLEKiYOp0bgis3XlhqaO0v6ldCJu
 K0faU51rqrArw4bmtrIe+IfCjEnKpAdf5dzwj7dJGh4HYvbfkgyF/rWPsihzw+5/98Fr253tdqi
 4
X-Google-Smtp-Source: AGHT+IGGtZ/zMnYkWwPixxjcn4uYI/2wK63nJJqTbjum7r4iqYgemDIaPQUyc/MzYToGLQaGuaHcPg==
X-Received: by 2002:a05:600c:1c1f:b0:42c:b6e4:e3ac with SMTP id
 5b1f17b1804b1-42cdb531d35mr12560495e9.3.1726123978958; 
 Wed, 11 Sep 2024 23:52:58 -0700 (PDT)
Received: from m1x-phil.lan (mic92-h03-176-184-33-210.dsl.sta.abo.bbox.fr.
 [176.184.33.210]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42caeb444b0sm163333205e9.21.2024.09.11.23.52.58
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 11 Sep 2024 23:52:58 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL v2 48/61] hw/sensor/tmp105: Lower 4 bit of limit registers are
 always 0
Date: Thu, 12 Sep 2024 08:52:19 +0200
Message-ID: <20240912065227.67848-6-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240912065227.67848-1-philmd@linaro.org>
References: <20240912065227.67848-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

From: Guenter Roeck <linux@roeck-us.net>

Per datasheet, "HIGH AND LOW LIMIT REGISTERS", the lower 4 bit
of the limit registers are unused and always report 0.
The lower 4 bit should not be used for temperature comparisons,
so mask the unused bits before storing the limits.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Message-Id: <20240906154911.86803-6-philmd@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sensor/tmp105.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/sensor/tmp105.c b/hw/sensor/tmp105.c
index f5101af919..9d7b911f59 100644
--- a/hw/sensor/tmp105.c
+++ b/hw/sensor/tmp105.c
@@ -171,7 +171,7 @@ static void tmp105_write(TMP105State *s)
     case TMP105_REG_T_HIGH:
         if (s->len >= 3) {
             s->limit[s->pointer & 1] = (int16_t)
-                    ((((uint16_t) s->buf[0]) << 8) | s->buf[1]);
+                    ((((uint16_t) s->buf[0]) << 8) | (s->buf[1] & 0xf0));
         }
         tmp105_alarm_update(s, false);
         break;
-- 
2.45.2


