Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F420CA6002
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 08:22:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEMuc-0001XO-Bj; Wed, 07 Oct 2026 04:22:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xEGKi-0002dR-6E
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 21:20:43 -0400
Received: from mail-lf1-x131.google.com ([2a00:1450:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xEGKV-0005vW-QN
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 21:20:28 -0400
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-5bcb2ecebb4so1111546e87.2
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2026 18:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791336015; x=1791940815; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RMh0wnw3agFF2IsElQcMdXFWf485YmO8ORQx8WUZoWU=;
 b=ZV98JErt/pBGTh7gMd6ivExez3IQ35d6tV14ZphwIwwE9xqmTsD9USs8E1uP4vh2GQ
 QnW634ka+5m5TE5Z8+x0f5f2P7REpTIuM8i8r7p91I9uiP8Li1Qx4HATgz4Ry9zqKp6l
 eRFhfZAiavnItXoftRNIJb3+gu2kdj5XcRC+4rZ43NIL2YOy0qoJzzFLaI+tPfQa8p6N
 GNxub72u+ddFvQ9XBdkEaELu/gr8DnKULt7j7pw3gItlNotjPoU76m8A7UlfqU103VJo
 cxqAVTBHw+pKHD5dmrjPY/NVUc/QBZx3Ju2PmV7lMi1gS4kfE/qpA9Uy5hPvaotgcRdi
 rhWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791336015; x=1791940815;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=RMh0wnw3agFF2IsElQcMdXFWf485YmO8ORQx8WUZoWU=;
 b=uYIoX2fppIIwRhfwLoZsLsSC//Wsb3v7NOFZiwM/WyVKJPV1K5iFjsEiOD66cdR+9O
 4GFuQRTCZ7XKQTWVkKpV4sYrOhngCsFEl1Sl6gStxFS7kACzHI0DGwHCawN6b8ROjeIV
 BTBMcB8T4Tg2TNWFX9o9q43tn9aRg46nyxMnIzWsjuSIrrn2cFhzrFhtUkki0OQBpUSd
 Z8YAvJ1ahQhr8Nduiok4bW89mLpoa8fUOiD0c7TW3Q9QdISZ8TbxoKzVNt06FkRU6hWF
 HjhHxatwKcAuW6dqliw90NFYuflsSOaf0viMom4syFDPhw1OHBKcEGUximYGJYdhJRU+
 qjKA==
X-Gm-Message-State: AFq9FYJsBep+8ojrSvpTd4datJNmdW5fk2ESdKATvbLIqxcv+rQuCRrw
 MoZpI+Rik6bchfDZuYVtX7vdOhNX3ocKx61ZtESeUIuk+oNOaZLepbLbgti2dg==
X-Gm-Gg: AYBFou2zt95uT+jwdL47ckouZBwVjWS3jCQW/fvcywDVqRJCpFdOH/yhGMG3BRcT+xI
 CBCQkS6/eTqdem1v0rIGjqPJWBBX+WLP6VxZqZjQaP67KXzCD1ePdCL5aE0Tne10uvWnbyB0Tl+
 YRyke93uzGSPFeeoHl3PIvw9JdrZBCrJ5VzAqJBRtd2s02Br+CLrOPd9uX1eOL2U2vH3C89qUQ5
 lDCQhBaJr2hZm49/qs3Y2alxPVKRnFHeXPliM1e1N2EjQtDLduWQbaZpiB9p7K08aVszewoSJJw
 zhPTGB54vlBp5TnHXhZGvIiCE9SHqFmnKXbHf9LncKjfnWqdUCxFUr498mEUyDplDCO13myFXxn
 DHe0z1j6X3DnRZ4PpFtZOV63dNWuUPqqJXTlR3h2xM4v+wG5EariBGyL6RObvLcZoDSGhUS1CIG
 5sQ14cJPK3pjF/47GUnXIE5ABOnfe5E/xRQrNaOw6z+qSKlv7LRGNL+CWYPpsbBA71rXQ6DkPCo
 ore1/y+pw8QNMxhwBRLlgtp6GEhu0lKyL5esg==
X-Received: by 2002:a05:600c:c16f:b0:4a1:65d2:7912 with SMTP id
 5b1f17b1804b1-4a17b527aebmr11741325e9.8.1791275740674; 
 Tue, 06 Oct 2026 01:35:40 -0700 (PDT)
Received: from archlinux (pd95eda80.dip0.t-ipconnect.de. [217.94.218.128])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48c6cdb281csm1566764f8f.55.2026.10.06.01.35.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2026 01:35:39 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Bin Meng <bin.meng@processmission.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Gaurav Sharma <gaurav.sharma_7@nxp.com>,
 Bernhard Beschow <shentey@gmail.com>, qemu-arm@nongnu.org,
 Jason Wang <jasowangio@gmail.com>,
 Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v4 17/31] hw/misc/Kconfig: Remove redundant USB_EHCI_SYSBUS
 from config IMX
Date: Tue,  6 Oct 2026 10:34:29 +0200
Message-ID: <20261006083445.30362-18-shentey@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261006083445.30362-1-shentey@gmail.com>
References: <20261006083445.30362-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::131;
 envelope-from=shentey@gmail.com; helo=mail-lf1-x131.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Since commit 464ce71a963b "Kconfig: Extract CONFIG_USB_CHIPIDEA from
CONFIG_IMX" all relevant i.MX SoC models select USB_CHIPIDEA such
that selecting USB_EHCI_SYSBUS became redundant in CONFIG_IMX. Remove
it.

Fixes: 464ce71a963b ("Kconfig: Extract CONFIG_USB_CHIPIDEA from CONFIG_IMX")
Reviewed-by: Bin Meng <bin.meng@processmission.com>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/misc/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index 46e3c03cc8..d1711433ef 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -93,7 +93,6 @@ config IMX
     bool
     select PTIMER
     select SSI
-    select USB_EHCI_SYSBUS
 
 config FSL_IMX8MP_ANALOG
     bool
-- 
2.56.0


