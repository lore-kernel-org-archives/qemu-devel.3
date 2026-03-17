Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5D43FF6E9B
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 22:58:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2dMU-0007TV-JN; Tue, 17 Mar 2026 18:58:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w2dMT-0007RK-5P
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 18:58:05 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w2dMR-0001oM-Hf
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 18:58:04 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-82a07738118so3641007b3a.0
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 15:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773788282; x=1774393082; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3adXOulV1dTwRwi3VaDDPIxHsr/yRTuhhOa3Gu78OXA=;
 b=pttTTNqaQ6XjwHAKfRfWbFMD/SoK1LeLKar1IGe8tT6LVErEYg+2JS9hZ/Uok5I0mC
 J3GIl8gm66ECCaLF3XBXkp79mqYJMfNTbV7osrHk2T/Grl3dRUJRKFWKoU4yuC8ca7LL
 YfZM7UVvKN0LcOz8bJhkOWP+TnXA2CZfT7lx+oSNCLnK+kHND7wXshLnNoOqwVxcI+Ud
 aB1gKJQ6NLaeoCTmHRfe/fqeyq/97+SvIcCEQqvpd+R9i/xSEC2ft8H49vzEurmmsaSv
 EIOBEEZ8dDL0Q3FNHgJhyunULI+jyzrPmrZrq7UsIIYDsEFaOuYf5F8uIt6cvhJcVTX/
 IFXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773788282; x=1774393082;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3adXOulV1dTwRwi3VaDDPIxHsr/yRTuhhOa3Gu78OXA=;
 b=F9HFLc8IcFHT61Oex0Zw4WY8Ym6USeYxU0HLIk2S4NOwaflTLPCsH1CJsb86rixy1b
 NIhsOmeUP5vQ0J2giu0aWv4eIC+pv3jumeO+QR24i48fEpwuB7bPANA9KAB5k0uNfeE3
 QyvhPpH3Sl9Uk2Td0Bj3UfHqt4xgJmScOEJrOiAtxV/XHLJmFK1RYF5YzHi5WssBDIIt
 Jm6xDK4CUtBt7KF4sQb1dmTDPMuhh0aW9aPYTMLasZ/kV7dy7ingAhadSfDP6u6GpMC5
 3fg1HI7hEgVktFRxP1HYtWpn46IQcQKB2Bn4jL69nb+ON+TrUmWU79kFmeg8nH7Z1bXh
 dy9A==
X-Gm-Message-State: AOJu0YwMXZqG5VxWEIAWPnpET3GlLK3p9CDonaFmyWqFIlXQBmLjI7Db
 FB/vbFsV4TEghwQ1ATkThPP6EhZH/YeIlrJlvNmk3op6ctFiqpYpKpfEIBliwlfmWc7JCyOkzcD
 9MKq6UHg=
X-Gm-Gg: ATEYQzzZjXDXsPhRGiYWvUhJwnxgWBkJanN7iwsR5iGArlVdHBvWOp3env4MHCVf8jm
 svS3htskSFMDUDLGAWfuY/TiI1nVuXdxw0Ix30zGyOwfC7Y3OWLjm4PoLET+3c4eBoT+qFGGXqA
 ja9qiIRAQWJpSx3g18hzDGocS3rL1WlMo1Ut1xALOphg4o4ko1i/1VKij5pc4j2giVMzdtFa45C
 S4Y4geYPI/RiJnvSpY/mU6ubNte1YiHqXwnmVw7MYnXtsHACEF70JYpKlT3by/5pW2LmgfTjX9L
 HCkClKyAKC/2ZLW4hp+nt/aOrjYYaFnL2a3DWc8sdOPMKZv1EA3QWJTIsVQ5/uR1AbTyyB3pWhk
 Ci+My6ZY29WkTZNGTMABnrf8FlQTmbDaeb/AAwOYzIYVNtkhTx/3Ntj0ZApZuqphVMPexrLpNu2
 /pMKvLqBPQC7RGlO4M89ZdyJlum/EBvkBNr3lAUeLto09Um/0jBaigQXlifPflcj2QztK0bn+dZ
 0t1
X-Received: by 2002:a05:6a00:10c2:b0:821:807a:e427 with SMTP id
 d2e1a72fcca58-82a6acbd7f6mr832457b3a.21.1773788281798; 
 Tue, 17 Mar 2026 15:58:01 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82a6bbe7cc9sm484825b3a.48.2026.03.17.15.58.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2026 15:58:01 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>, Yi Liu <yi.l.liu@intel.com>,
 Alex Williamson <alex@shazbot.org>, Eric Auger <eric.auger@redhat.com>,
 philmd@linaro.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 2/2] hw/vfio/iommufd.c: report hint to user when
 vfio-dev/vfio*/dev is missing
Date: Tue, 17 Mar 2026 15:57:51 -0700
Message-ID: <20260317225751.1325098-3-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260317225751.1325098-1-pierrick.bouvier@linaro.org>
References: <20260317225751.1325098-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x429.google.com
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

Give a hint about missing kernel config CONFIG_VFIO_DEVICE_CDEV.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 hw/vfio/iommufd.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index 131612eb836..3e33dfbb356 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -274,7 +274,10 @@ static int iommufd_cdev_getfd(const char *sysfs_path, Error **errp)
     }
 
     if (!g_file_get_contents(vfio_dev_path, &contents, &length, NULL)) {
-        error_setg(errp, "failed to load \"%s\"", vfio_dev_path);
+        error_setg(errp,
+                   "failed to load \"%s\""
+                   " (is your kernel config missing CONFIG_VFIO_DEVICE_CDEV?)",
+                   vfio_dev_path);
         goto out_close_dir;
     }
 
-- 
2.47.3


