Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A35BE77183
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 17:45:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tM9aj-0001xF-HO; Fri, 13 Dec 2024 12:36:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tM9Y2-0008HX-PO
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 12:33:57 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tM9Xz-0001k6-I5
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 12:33:54 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4361fe642ddso20466455e9.2
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 09:33:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734111229; x=1734716029; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Iu6/mYPMj4sIgrpfHxPuinFzD7tP6UGxaUnV9V3hRtM=;
 b=Ffjdv46U3swuZymAhMXNwnDXA2GwW0nqkl0r3ZNpplaF4/dSDbuVnLLeDgck5AMP9s
 AntVD+hbeRMo7qeZdSYjVTFFE9HU24zuG1BND2wLV0+HKPE7MBsKLr0gFQlYzF6GNNul
 NFLDfSNHUyL7C5uvflW/eBuep6QROpov55+E1CWKnad40xClLr87Fjlh/9IgXB5NI6nn
 YcCCGwE5OYwT9VGXNcDCsvu1G2FnC+NiKl9SjM6yHsatm/T+SoEDIjwVwWPTnqRn4IrQ
 z6jw/LFC1BT1hQLTezCTPs4OT5iSCev+7GteiDOpxF6MWBkOLw+TWW6/cGvHRkvKD0XD
 XugA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734111229; x=1734716029;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Iu6/mYPMj4sIgrpfHxPuinFzD7tP6UGxaUnV9V3hRtM=;
 b=lE9hnOurELswquSex+B0/ljLRjvS9oUR09Yls3B6+vLrJf93KYD/x18NaVhbYtnIAi
 sJl/00J8IcIyg9naCQ0BB6XE3rcOMYTclaJPfyxTwLfnf+9havrrXrIOcYTc1fV+Y87S
 Anke+YfyTueHKuxXEIPmrRm2gOZ24VUbTS2+tt1uDqQwyluRORJC4WWcPvq9uDSoQZZA
 z9XYQ0AYSnvS9rFTD2/JwS/2tiAM+Dj46XkcBVFiuYQpmM66wbbGkQht/5vII3hR9kEg
 uSYFkI3QaDNS225xR37RcNzat8yaomav7Xm3EBpFctcjKneUiXIO9+d1cX31hkU++a0S
 bJuQ==
X-Gm-Message-State: AOJu0YwFS62bhQUhHSmew74YuLwwHzEVTrvhw3k1cRdNk0JZbJz6LYlh
 x9ZTGwi4MSCGWIY100HLoYR06QtJT9wTrlQP0HiraoJp9pywOtPEwVBT0qq6XnJUH3yzA5h1nQQ
 c
X-Gm-Gg: ASbGnct5EzQ1pRrWhSt5siCM6BTcKyZYf0gfmLqCLnJubiK0Hgkd7CecuXrUGBvcT0w
 Lfqn4+b89pvilFa4nELhbXiAmkFUE0Qn1tW/Je49tJyFgP/bjHuR9zZpVA72X/nQYT2l5JS1IO2
 50FG5XB1tytmVwg1GqNh7WtaP70IMqAqLyvTzoxGZ7xCp08rh2aOOQqjLWxPz/qt9m6VqktAOIa
 5zc1ejbriDfAzMlxByhynxu02p+V2E08SitU2LJwCGRS8p0MvEFllIs/2JgMA==
X-Google-Smtp-Source: AGHT+IFsA5t4suN2xU6J7LQsz01QLuN4iZPGK+Nfl6Wy8Qlbv5Zm8FeJIlXF8y1gIavY1duRUL9bng==
X-Received: by 2002:a05:600c:3548:b0:434:f753:600f with SMTP id
 5b1f17b1804b1-4362aa408fcmr29869535e9.19.1734111229106; 
 Fri, 13 Dec 2024 09:33:49 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-388c80162ddsm87026f8f.37.2024.12.13.09.33.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2024 09:33:48 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 73/85] docs/system/arm/xlnx-versal-virt: document ospi-flash
 property
Date: Fri, 13 Dec 2024 17:32:17 +0000
Message-Id: <20241213173229.3308926-74-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241213173229.3308926-1-peter.maydell@linaro.org>
References: <20241213173229.3308926-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 WEIRD_QUOTING=0.001 autolearn=ham autolearn_force=no
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-id: 20241206192254.3889131-4-pierrick.bouvier@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/system/arm/xlnx-versal-virt.rst | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/docs/system/arm/xlnx-versal-virt.rst b/docs/system/arm/xlnx-versal-virt.rst
index 0bafc76469d..c5f35f28e4f 100644
--- a/docs/system/arm/xlnx-versal-virt.rst
+++ b/docs/system/arm/xlnx-versal-virt.rst
@@ -178,6 +178,9 @@ Run the following at the U-Boot prompt:
   fdt set /chosen/dom0 reg <0x00000000 0x40000000 0x0 0x03100000>
   booti 30000000 - 20000000
 
+It's possible to change the OSPI flash model emulated by using the machine model
+option ``ospi-flash``.
+
 BBRAM File Backend
 """"""""""""""""""
 BBRAM can have an optional file backend, which must be a seekable
-- 
2.34.1


