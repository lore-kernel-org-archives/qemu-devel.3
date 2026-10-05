Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45010CA5FF0
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 10:19:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDfmt-0002NJ-9d; Mon, 05 Oct 2026 06:19:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xDfm9-0002EK-A6
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 06:18:30 -0400
Received: from mail-wr2-x10.google.com ([2a00:1450:4864:30::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xDfm5-0000uV-B9
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 06:18:28 -0400
Received: by mail-wr2-x10.google.com with SMTP id
 ffacd0b85a97d-4834977ae75so812972f8f.3
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2026 03:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791195503; x=1791800303; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fM7at0yHqHEVoYkayjVwz2Cz63FNCL0ZKzg1XE7m+cY=;
 b=TuH4QUwNgyHNjWSeSXb6b/4dPHhxfqZoGlGxbd2Psyeo1fH7fAAlncXoq8LW1jjscU
 qStBgdz++RGyXQbHjunw/K8WbgQBeJGe6gSLEZz7fE2srws9JN1usp3DR0fYY6+pDNEw
 Ff0QTvUl69DLZfkO3szzxvIXm20bDol9mTu9vlRoTnHLs4ye6EqdmjUA3uXkNO2jXS+t
 m/zrwgD7nOSrydNu0gD+gDmIQDXabRd5qqGBTZtpfadp2fW1mhamkc10Z3KbDP8sjLoN
 0KjHO35ZENWK44fmGWnQf7tWU3c8N0FUex5cxKCnmxrbQoLY1T33NqDCPF0FOczIt4R8
 sEjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791195503; x=1791800303;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=fM7at0yHqHEVoYkayjVwz2Cz63FNCL0ZKzg1XE7m+cY=;
 b=0jccT/QBc9YXXUcjTxSUx0KmNEtVzYx5RfjYDKFn7lOUFcP+jBNkcDi4ZFEyjnzUfX
 ytI/RShmw0DAg5CVtxo5TiiHfpwCvZqXUdk+9W7zOZwTDeTrPjadQbBIOWsS3h6xzsHv
 DVWxcUtR5ukPOUjfafbS4H6IbCYswZnML9PpC8ret/GAp7wwLAK4EZ1M1yHkJEkGgn+k
 A90MAYj9cZ2sfxnvsv2hZ0HFs+cW4BWNv27IwJRS38dWvROQlOFZprzBX5LHgrpxJCvY
 URNyHBZIZUpsUqcKQXJpDwwGCy8t14G3+7lbxSLqT5jDn3tCtJhuoPiLY8u/srv9fLAO
 phMw==
X-Gm-Message-State: AFq9FYIMo18fhlzD6Ban3Z4hnD/Wt2hsbFYmcmJI0O3D7p4+UhFUJW78
 zoaeT0rNyxfz4/Dx6a7WYoPPKRX9fMu36QAITYYQ9z+b/DibFejwhMBhpbexSg==
X-Gm-Gg: AYBFou0SO7/BSIzHaasuu+QSXM3qEoSmX1AKjiLUvuF3eDBuvSXihxfpWuqmp1w1HcT
 8z56/lPZAE1ANdJvkR5c+GgScroNoXR1qCG7XQ/l0O27pNk/bGXYI6FuLpWFlS+H2XxEzcbDS0S
 g0qVz8FZr+nnStutxT//GRtpewj1wEZVnEwuZSfNwP7NmlRHMoiG3KIOUdv8MiaH5SBDbdYtF/v
 4fys6TgpPsZ5a0BkZBtQ1vZBQpm3F25tHtuNfXsAnGEq9CGr50bHWv8K+2Gsuf24cT31qwUIxSh
 EMzOd65Yv8XFbUuxGKYBbq+TGkgD24bPEFfqNcM9H7gGWmyzmPDMCXam5vg4kMglYCw7YjcuxZv
 xKQxQ7cQYQTP01hS9gxfNA+txsj6qQWgpSGNPPrgH1hTzeGx0i+KjqHnX74DJBkfIxCwkaeTUHy
 2YOos+CYYthkW2KF+ApiBwtdEnnCDXZla65hsKaZFomxkIQgaP8pSyT7runcWR5Gy7ZTxsQugDH
 Nw8hhFITVDmYujECXR0L5Jusx8o4SU7OQ58xBg=
X-Received: by 2002:a5d:470c:0:b0:487:27f6:a4e3 with SMTP id
 ffacd0b85a97d-48b1275cc02mr13466009f8f.51.1791195503372; 
 Mon, 05 Oct 2026 03:18:23 -0700 (PDT)
Received: from archlinux (pd95eda80.dip0.t-ipconnect.de. [217.94.218.128])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48c622ab7b5sm2742111f8f.37.2026.10.05.03.18.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 03:18:22 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Gaurav Sharma <gaurav.sharma_7@nxp.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Bernhard Beschow <shentey@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowangio@gmail.com>,
 qemu-arm@nongnu.org, Bin Meng <bin.meng@processmission.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v3 03/31] hw/watchdog/wdt_imx2: Clear WDT lock on reset
Date: Mon,  5 Oct 2026 12:17:30 +0200
Message-ID: <20261005101800.10821-4-shentey@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261005101800.10821-1-shentey@gmail.com>
References: <20261005101800.10821-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:30::10;
 envelope-from=shentey@gmail.com; helo=mail-wr2-x10.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The WDT bit gets reset and becomes writeable after power on reset which
imx2_wdt_reset() represents. While the WDT bit in the WCR register
already gets reset, its locked attribute wasn't. Fix this inconsistency
by adding the missing unlock of its locked attribute.

Fixes: daca13d495a1 ("hw/watchdog: Implement full i.MX watchdog support")
cc: qemu-stable
Reported-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Bin Meng <bin.meng@processmission.com>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 include/hw/watchdog/wdt_imx2.h | 2 +-
 hw/watchdog/wdt_imx2.c         | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/hw/watchdog/wdt_imx2.h b/include/hw/watchdog/wdt_imx2.h
index ad36b8820d..fc01fc46e7 100644
--- a/include/hw/watchdog/wdt_imx2.h
+++ b/include/hw/watchdog/wdt_imx2.h
@@ -85,7 +85,7 @@ struct IMX2WdtState {
 
     bool wcr_locked;            /* affects WDZST, WDBG, and WDW */
     bool wcr_wde_locked;        /* affects WDE */
-    bool wcr_wdt_locked;        /* affects WDT (never cleared) */
+    bool wcr_wdt_locked;        /* affects WDT, cleared on POR */
 };
 
 #endif /* WDT_IMX2_H */
diff --git a/hw/watchdog/wdt_imx2.c b/hw/watchdog/wdt_imx2.c
index d897ff6e52..a15f452d48 100644
--- a/hw/watchdog/wdt_imx2.c
+++ b/hw/watchdog/wdt_imx2.c
@@ -60,6 +60,7 @@ static void imx2_wdt_reset(DeviceState *dev)
     s->wicr_locked = false;
     s->wcr_locked = false;
     s->wcr_wde_locked = false;
+    s->wcr_wdt_locked = false;
 
     s->wcr = IMX2_WDT_WCR_WDA | IMX2_WDT_WCR_SRS;
     s->wsr = 0;
-- 
2.56.0


