Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F7C9CE7B10
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 13:31:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smZ25-0004Pn-9g; Fri, 06 Sep 2024 09:29:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>) id 1smZ1g-0003gu-G0
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 09:29:24 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>) id 1smZ1e-0008Nb-V9
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 09:29:24 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-71798a15ce5so1037381b3a.0
 for <qemu-devel@nongnu.org>; Fri, 06 Sep 2024 06:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725629361; x=1726234161; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ua6iXDxKUBr7o/WWA42XxNhrwoqsmd6/uR8lhmhMlkc=;
 b=afaqDZVQIzXjjIezdVBoTQITvinnTnMtMP1Fs5UdJTY+IEMxjfd0j4r9jXEwtFuOe1
 FCMz4Sxpfl/EbA1GBgjMsdX6soLKatYIzGAFj+Pwb1Mi4n3truSKuE+Kf2ghdoHzwUh0
 kpHgTpw252Q/CEBGVcNWneN065e8fPiP6Iao0LfjbfCPtmMWlBRwbL0Eq5kE6RhrD2h+
 8nbyk4W6T9ZnVPwRYex06JbT7fEAaqiIceNxXE+r7lazpm3igYLQL0J+u4bOVStaP2Wg
 PQ3msvf1gnXE/IKAhWMe4y+ihxx885qeZTqDOTHXBTo5MzzBYo6TKTJNH6FXV0R/cYfP
 fcnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725629361; x=1726234161;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ua6iXDxKUBr7o/WWA42XxNhrwoqsmd6/uR8lhmhMlkc=;
 b=w0SC75+NT3jDpMnobGylh7b1oRF0fvsuBjGuEHAYju3PlQEldZ3vWeHCpoYKvqaxqQ
 jlneAt39r1HIUbMVmRXlGluh6kTzr5hYd0mthYuFoOWUOw8reNxgBpgwtsLJ5BuC5ZQW
 CBmdASycWTMaaoyhNdmwI5Px7rTlHXaMf8VrPL+GnO5pDiNeahcVBWcPUdyCbTWYJFpE
 Xc5fVoVv0QPz4W62embZNXMRzzaw87KABkz2kLSA6YWAfOW2ENIZWWCCOujjVAq1eJQ0
 1+gwUCdEzmsijkTYKWkwIp5oX5zFXcVQq0upRZKu25cAFrh8MvPnGT3r0wObThnhN2RK
 7Vbw==
X-Gm-Message-State: AOJu0Yxe8irm29WNJ1mL1/HESoXQLiXB2ktKpS2Fe1LJqBKh9vMRLvmy
 txe1dEKfMp9oG2+RQWQHvfoAb3UHkccp+o05zQQvkRDJ+tVkJtDECDNDvg==
X-Google-Smtp-Source: AGHT+IFdHX1kl7apzhRu8xyY/loiKYdL/v4L0AGPm/Ze+Hgzjq/oJ0RZOXaeunsXYH0Rc8X40J4dHg==
X-Received: by 2002:a05:6a21:e8c:b0:1cf:126c:3b77 with SMTP id
 adf61e73a8af0-1cf1c12aa84mr4118403637.25.1725629360990; 
 Fri, 06 Sep 2024 06:29:20 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-718d516444csm1438199b3a.149.2024.09.06.06.29.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Sep 2024 06:29:20 -0700 (PDT)
From: Guenter Roeck <linux@roeck-us.net>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 2/3] tmp105: OS (one-shot) bit in configuration register
 always returns 0
Date: Fri,  6 Sep 2024 06:29:11 -0700
Message-ID: <20240906132912.3826089-3-linux@roeck-us.net>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240906132912.3826089-1-linux@roeck-us.net>
References: <20240906132912.3826089-1-linux@roeck-us.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=groeck7@gmail.com; helo=mail-pf1-x432.google.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Per datasheet, "ONE-SHOT (OS)", the OS bit always returns 0 when reading
the configuration register.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 hw/sensor/tmp105.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/sensor/tmp105.c b/hw/sensor/tmp105.c
index 77fbf2f8d3..22728798f7 100644
--- a/hw/sensor/tmp105.c
+++ b/hw/sensor/tmp105.c
@@ -133,7 +133,7 @@ static void tmp105_read(TMP105State *s)
         break;
 
     case TMP105_REG_CONFIG:
-        s->buf[s->len++] = s->config;
+        s->buf[s->len++] = s->config & 0x7f;
         break;
 
     case TMP105_REG_T_LOW:
-- 
2.45.2


