Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DEC0CA5FE6
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2026 12:33:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDLJe-0006PQ-FO; Sun, 04 Oct 2026 08:27:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xDLJa-0006NH-8O
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 08:27:38 -0400
Received: from mail-wm2-x10.google.com ([2a00:1450:4864:31::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xDLJX-00075L-7L
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 08:27:37 -0400
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-4a16bc7ad39so1247285e9.1
 for <qemu-devel@nongnu.org>; Sun, 04 Oct 2026 05:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791116854; x=1791721654; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+K+rCpfMJFNVG3mUSTsCEEVuDUjKTak8WjFMBdYORMo=;
 b=Kny80EXHQjlqfw+tUO6wKdRv119xiSQXKCwzq70wzth+Zi0LoTrCFOemsN1Jx42n/J
 p9hjJlTOlzxCj7AzVMv5soAqID5PCbO+S7ZCBsGfWD1Gja4EP1DPyzZpNB097SjUrEsw
 w896gNsmTgR6GzYLQqRVWHBXhCgvmcw/q2wln7SAsL1cSwisUpG/V7QokEhPRkTk97PA
 G8jei4kNPNGrN81JepNQ5Je7F1g903qtTAtH0a7+M+RQBwODq2Um0htp+SVleU7STuVz
 RDZAlS5qd3pCjxklg7gM9ZrskPMZX4QEJvSH3YVgD68WqTVeq/ZeQCJehF43SiICBKRx
 ITOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791116854; x=1791721654;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=+K+rCpfMJFNVG3mUSTsCEEVuDUjKTak8WjFMBdYORMo=;
 b=P4eQ5L5YJKxZyZcSk1jkR2GgiTmjasqZBc8kbQ3w7UJQ/Z9NZbqGpv+A7vX89im+J2
 bdpH89VNQFTqEcsp715qijP1eEDCNcg/cC/iAGmQytEUgJNRYE9mpHXChFI/NKN9ZrtG
 4mMXLDMSy74JKEPMvW3ODTbk7D68v5DJq99mDc8BnGqGKZbFbMZOo1mXhBzsGaz8lY6E
 vETuN9zmtrV30obdU5heGBzd+CW5+0NFnh3LcVyAD8W996mtDj+j7PiNtaF05XsT4lIe
 s96KGyTxcwHQT092B8alD+i36lxLyrAvbQz2YMhw5OJ5DE5Od6YegI530KnH1Q59+HM7
 3DUg==
X-Gm-Message-State: AFuF++lMrrrQC6h15S/swcx9JE6WJmROQlANUCn9DZa6MTacOQDW2SDb
 xG5MqZnJ0I/QbFPky3BWmrLhKFxqsAwZQkIUYY6tO9VEUaFgqOnf+L2cRYWyCA==
X-Gm-Gg: AYBFou3aIcdGP0cmi6Z5EAFKKaGAkTkB8tzvMUPmOOum/xF4tfOBfwd+ien2daRqLEW
 6xl2R4Wq9XUrBI6kxvXyQpV2PEIij3VGKz17jbCXxChMSKtCZw2+T7XBqIxzHTHok3O5YIrFqOG
 pNZoPZuTZ0+vWMlBas7zNl6UXLgzM9dcHk12i8cGk4dNe3u0QbssoU0lDx3aUka3tNrf2cVdVEy
 RYVt08aeCfu7TSKcS6Ux1OipEQnc0z1PBLh4qSJwFSRbiucJlOtrpiYrInLH4sx9SyxbVq7Ow21
 7HcGMcXnMuoPwYIvMGY8NJ0ODh4ektpW5fP7gDYsT+NEXYVI8xddtsG75k8QkG7kdH2WxVJqfA1
 L1vyuK75CZaummQUS+nLabyyib3N3H+O3tOvUesJlW7Z1YoA68kTOLQnCYfjeihTMaAvlDYJpW1
 CRj4sHl5U47ZfPhj7fv/fjYosSi/tuD8S2RFJGqzj6wz9T3eg4ekdotMZSULpcKt18oO65hJytW
 1rQZEp1XSA7mxzAWp0TFP5r1FANJh2kU9lsBQ==
X-Received: by 2002:a05:600c:8b77:b0:49e:6581:7baf with SMTP id
 5b1f17b1804b1-4a0274bcb2amr64311345e9.2.1791116853656; 
 Sun, 04 Oct 2026 05:27:33 -0700 (PDT)
Received: from archlinux (pd95eda80.dip0.t-ipconnect.de. [217.94.218.128])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a027698f13sm242319975e9.1.2026.10.04.05.27.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Oct 2026 05:27:33 -0700 (PDT)
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
Subject: [PATCH v2 01/30] hw/watchdog/wdt_imx2: Fix handling of write-once WCR
 bits
Date: Sun,  4 Oct 2026 14:26:17 +0200
Message-ID: <20261004122647.3913-2-shentey@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261004122647.3913-1-shentey@gmail.com>
References: <20261004122647.3913-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:31::10;
 envelope-from=shentey@gmail.com; helo=mail-wm2-x10.google.com
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

Guests such as u-boot may experience inadvertant reboots when configuring
the WCR register. Apparently there is a typo in the WCR locked bits
handling: The locked values for s->wcr must come from itself rather than
from s->wicr, so fix that.

Fixes: daca13d495a1 ("hw/watchdog: Implement full i.MX watchdog support")
cc: qemu-stable
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/watchdog/wdt_imx2.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/watchdog/wdt_imx2.c b/hw/watchdog/wdt_imx2.c
index c83d4107c1..3283990bbf 100644
--- a/hw/watchdog/wdt_imx2.c
+++ b/hw/watchdog/wdt_imx2.c
@@ -156,18 +156,18 @@ static void imx2_wdt_write(void *opaque, hwaddr addr,
     case IMX2_WDT_WCR:
         if (s->wcr_locked) {
             value &= ~IMX2_WDT_WCR_LOCK_MASK;
-            value |= (s->wicr & IMX2_WDT_WCR_LOCK_MASK);
+            value |= (s->wcr & IMX2_WDT_WCR_LOCK_MASK);
         }
         s->wcr_locked = true;
         if (s->wcr_wde_locked) {
             value &= ~IMX2_WDT_WCR_WDE;
-            value |= (s->wicr & ~IMX2_WDT_WCR_WDE);
+            value |= (s->wcr & ~IMX2_WDT_WCR_WDE);
         } else if (value & IMX2_WDT_WCR_WDE) {
             s->wcr_wde_locked = true;
         }
         if (s->wcr_wdt_locked) {
             value &= ~IMX2_WDT_WCR_WDT;
-            value |= (s->wicr & ~IMX2_WDT_WCR_WDT);
+            value |= (s->wcr & ~IMX2_WDT_WCR_WDT);
         } else if (value & IMX2_WDT_WCR_WDT) {
             s->wcr_wdt_locked = true;
         }
-- 
2.56.0


