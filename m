Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37309CA5FFD
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 10:21:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDfoV-0003CZ-RG; Mon, 05 Oct 2026 06:21:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xDfm9-0002EJ-0c
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 06:18:30 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xDfm5-0000uM-2u
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 06:18:27 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-48b0ef9c76eso1388454f8f.0
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2026 03:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791195502; x=1791800302; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=64hePJipeN8Fs5nwKi76fMFIZFKTMyNTsfqNW9sCfE0=;
 b=gIz4rw4IOo0vnyzC0Y5iUTJR5WnXlqyRWLf+9Av9/Ah21m2NyPq9oE1omz8KKHgMlm
 75hxLDpZkTkn5PHM6mdV2SWOS6lByya/APw+/lUVJeuWPBfA1vwGGWNZEFlLzO8O8n6j
 iPZr3zNQRAakbPS9CFzAmVEdxbetT5N4vSIqkV1hXzrXqnqWDzDBAGtAhQ+7asDADdTs
 ZpQT02pUaGlTMupzj6Z5vdR9LuY/Aujf3BGKHiZYlQ0KcBmRw80qbIVTgXAKTCX/08VD
 YfRrko2F1r5WVLRizXpJwP2n7Q9GK7FdTCOxlDWy15MOBQ8JxSFnH0AR9j6dar26cvaR
 +Mkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791195502; x=1791800302;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=64hePJipeN8Fs5nwKi76fMFIZFKTMyNTsfqNW9sCfE0=;
 b=c0gFhSP/4Tq7N2HDQM7lmPolG3GuDdlSU4aZsCdt2g1MDERTBYyZ+h1UkrAups8s/f
 YVEYhhsuh47S2fATP/GnODXUMk2qZoX20M/GKnXnXJZ2HZMxTmKtkBDvVeUcO63+SGwL
 Kgq86pu2moHbute6FAwKMDrFyemeISYhtuQtplSxuavSu1LIXEnNw/xya0sVZzUTycwA
 o2nKISMhgG6bIka0qh1DCxmKMLodyDgcwS7F0byqfn4qFG2VhJ4A0EtggFYWcdU/xnIG
 qlFLpMf64q2FZGCqM7Km2L8urdhSOSujqrBUIYcy6wiTMbU1cuyL8Bd+p7G/WX9qtOPH
 wUfQ==
X-Gm-Message-State: AFq9FYJhZlUH9weawWw7sHfQPdjSO+S8FdgusuRA4J4P1Tm9VK7ZDNuw
 r3QB0hMsGsH84jKrKFLfqyxTcWfVaVvh8cwIjS7rEMNx1VHHNzXRokW+AMF6Xg==
X-Gm-Gg: AYBFou0nPGrZwYn+bpYt7JVDLVSqtspqMN9yDF87FwRsMe4yCibSVLQ0Mg9gD6SeNQi
 y4MUEUtsG9gI3cA7H6E2acS4Cxr/5iTyVN8+BOuUz+o4/oG9dY+C80tUo7DCf5xS/nnCHtG0O57
 8dXF55zc2o2bvwTNO6qng6kocTw4/CjPnobl30Zz/kSy0RQ4WLiKAw7Vj22Dhhbsy5gykVKb9JX
 +boqoqzAqswUEJW2Hyrh0Ov//CTqswFIktddekqKK6uqAy8ZDNwrAIS8JiLCSLvujKjeIAyVqMg
 BZudSF+GPOmVbpYAY2LwrlKWYrT7vAM3HMrqzYT2NS7kIl/0om5OXXzj5dH8tHn567Fr+sVD4yj
 Z+JUGGgfDIYBMXMNpT65ni2W8Ou/uacKNbLHzuPjDacwnEandS470ggp5oXdobhpu8ZFZx4up0r
 /81cTl2Bb+xBsGHZcQxCbOs+K3XjlzbD1wS/iwGk8YD8dHtz3X2InFC3AtWHxsY1jZ3VKZ3rJHz
 3ovHT/dBtiCp5Q9k0VoLajP5e433uXPbCi9SnFgFTsmdULV
X-Received: by 2002:a05:6000:2589:b0:48b:1124:f2fb with SMTP id
 ffacd0b85a97d-48c47fc91a3mr10950401f8f.13.1791195502015; 
 Mon, 05 Oct 2026 03:18:22 -0700 (PDT)
Received: from archlinux (pd95eda80.dip0.t-ipconnect.de. [217.94.218.128])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48c622ab7b5sm2742111f8f.37.2026.10.05.03.18.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 03:18:21 -0700 (PDT)
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
Subject: [PATCH v3 02/31] hw/watchdog/wdt_imx2: Fix handling of write one once
 WCR bits
Date: Mon,  5 Oct 2026 12:17:29 +0200
Message-ID: <20261005101800.10821-3-shentey@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261005101800.10821-1-shentey@gmail.com>
References: <20261005101800.10821-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=shentey@gmail.com; helo=mail-wr1-x435.google.com
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

In locked state, the WDE and WDT bits of the WCR register are one and
need to be preserved when written. At the moment, the logic is reversed
such that all but the locked bits are preserved in locked state. Fix
that.

Fixes: daca13d495a1 ("hw/watchdog: Implement full i.MX watchdog
support")
cc: qemu-stable
Reported-by: Bin Meng <bin.meng@processmission.com>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/watchdog/wdt_imx2.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/watchdog/wdt_imx2.c b/hw/watchdog/wdt_imx2.c
index 3283990bbf..d897ff6e52 100644
--- a/hw/watchdog/wdt_imx2.c
+++ b/hw/watchdog/wdt_imx2.c
@@ -161,13 +161,13 @@ static void imx2_wdt_write(void *opaque, hwaddr addr,
         s->wcr_locked = true;
         if (s->wcr_wde_locked) {
             value &= ~IMX2_WDT_WCR_WDE;
-            value |= (s->wcr & ~IMX2_WDT_WCR_WDE);
+            value |= (s->wcr & IMX2_WDT_WCR_WDE);
         } else if (value & IMX2_WDT_WCR_WDE) {
             s->wcr_wde_locked = true;
         }
         if (s->wcr_wdt_locked) {
             value &= ~IMX2_WDT_WCR_WDT;
-            value |= (s->wcr & ~IMX2_WDT_WCR_WDT);
+            value |= (s->wcr & IMX2_WDT_WCR_WDT);
         } else if (value & IMX2_WDT_WCR_WDT) {
             s->wcr_wdt_locked = true;
         }
-- 
2.56.0


