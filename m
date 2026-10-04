Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EFC4CA5FE6
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2026 12:29:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDLJy-0006cG-1W; Sun, 04 Oct 2026 08:28:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xDLJw-0006bH-EF
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 08:28:00 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xDLJu-0007Ax-SC
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 08:28:00 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-48b03f23305so846740f8f.1
 for <qemu-devel@nongnu.org>; Sun, 04 Oct 2026 05:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791116877; x=1791721677; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=p1vfDzd/FHQXQGH1Fm3PawIonhWP06q0FukTEX89uy8=;
 b=a5cu2pjV95QoFDo8M0nlD2vt6CT51FP3dWzGEBWeOUgXTbZF3N/hetT3duPHl+wzJR
 7YO2lH87TTYifeaTXGcoT/GEEoIY853IezWb0ToJFgWlhm6nZDEDSFVpqcGhfV+mvZH2
 3r3fcN/7F2UdKSb/JRVNxvq+IJT6Ahr7EQipiN+4W1p3RryPeTFzwmXcMd0mhD3rd6e8
 9bhMejHj/JSg8ajtAzS7XXkkB69VNfaZNhTaZX6C4ku/wfDF0WuUe4p6D2GCJj3uNxYf
 Cko8o87LKGuzQL+IxbkOXBBdYV0Sb5YQdvJ9EF/mVMmEYo45/pNRYbiQ0irb7zBCQlQP
 cHLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791116877; x=1791721677;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=p1vfDzd/FHQXQGH1Fm3PawIonhWP06q0FukTEX89uy8=;
 b=0IbykWo/RFtqSzzi5gIYiDxkQnTxY8nF29BspIAwvJv36iQJ8Gb8ENzPj3zTAkGR3H
 A/w7NW+8c7hB87JhL/+t3qc+gbcZehaWxb8tusSTyEboCiCoUdyiIZXJCj54DWYMvBPB
 V3IDeQSa5JMvpnmIQEFpyEDCAU9rgxFL3zlEBm0zCYadM/czRRN8CCOud69yq6Y5StlR
 ayBbZaZ9R2Dc+XWI5K6wnFw/cEfmP/XyzVwMMhFRSlHsW/v3rhzoOo11HYGwvU9HIi7G
 z1XYdbUzw3L0e6O6CK1nmNzt0jXbdhWt6eOteWIe5/uCvO1E3Yzd5YpOVM/MBgobhrqd
 VfvQ==
X-Gm-Message-State: AFuF++mQvdwqyMa5AyFY4qLT4jwNcw//+aQe4cDRfU9VJS79kVvuNgry
 g9IVQIwqMGkiygc/v0P48m/Y7YVLHkhNUIFWxJDmX2hrN8Iq97pe5O9kw3Q29w==
X-Gm-Gg: AYBFou1itmsIsksVdirbTxAsBG/p3gZAfT+42Q67uEGoR5WktFUXRTxDpT/lhNK6gay
 SCDwE3L+hecD7ey4BYqjcvacj0iMw7W4AVKiSzYDTk2Qpg2owRvQfxHQj2l5BjsaO3vhI+JIowK
 hFwqSo6uQQfYvDf+NUFavbq5YUSplQXptx8PwOw/Z2Q3gEswGm+p+tiBH+WSpPDt3ytlfOOzfED
 6P6CY/23jvIvTNOB1VOrnKnjUsBbFCiWw2ygfcCLsWQ1z+iRm42wDo83s6p6txJNv7XNZgA/xg9
 trIZfZpEmDn1KScru3PCZodIDnne0Sj3FzWfGApYoBw9XgsCtyP34pHv+qpzeWjP28Jz1N8zkUt
 NhlfgNAkTShQFrn9Ji4tfpbaRe6LTUPcMsriK/rdQplTLWLnAOJxUwPBJkDRrrB20vni7Ln3Nyt
 gWnXbTecpPJ9Xe8GYRBhEwahS6UKYXug+6jGQcRFNujCAeHxN+l7tSqcMlLdO+mW+MICZIxUGZi
 CSOWUJHPX3PKXU+IO1kYEh+3Z6/rP7f06FTlA==
X-Received: by 2002:a05:600c:4f4b:b0:4a1:6dca:51e3 with SMTP id
 5b1f17b1804b1-4a16dca51eamr45142185e9.3.1791116877187; 
 Sun, 04 Oct 2026 05:27:57 -0700 (PDT)
Received: from archlinux (pd95eda80.dip0.t-ipconnect.de. [217.94.218.128])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a027698f13sm242319975e9.1.2026.10.04.05.27.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Oct 2026 05:27:56 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Gaurav Sharma <gaurav.sharma_7@nxp.com>,
 Alistair Francis <alistair@alistair23.me>,
 Bernhard Beschow <shentey@gmail.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Jason Wang <jasowangio@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Bin Meng <bin.meng@processmission.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v2 16/30] hw/misc/Kconfig: Remove redundant USB_EHCI_SYSBUS
 from config IMX
Date: Sun,  4 Oct 2026 14:26:32 +0200
Message-ID: <20261004122647.3913-17-shentey@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261004122647.3913-1-shentey@gmail.com>
References: <20261004122647.3913-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=shentey@gmail.com; helo=mail-wr1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


