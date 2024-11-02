Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0E6BE677FC
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Nov 2024 13:19:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7E1B-0003eG-HW; Sat, 02 Nov 2024 09:18:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1t7E0o-00037P-Kl; Sat, 02 Nov 2024 09:17:54 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1t7E0m-0001zq-Od; Sat, 02 Nov 2024 09:17:54 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5ceca7df7f0so584295a12.1; 
 Sat, 02 Nov 2024 06:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730553470; x=1731158270; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FdlRSFSVE5+jilPfwmoz97fjdKJLulipSEMWN67GtgY=;
 b=CVWIrmkYi0KYpKuOMb1qHxYC1pXe3XDmen5iar5Jdkv/6wqiSeW/p74Rvk9LV2Bpgx
 nXvTadtsvI6cRiB6w/g6DN/ghUGhUqLwG5/ya7Advoy2llfouEILlUBAgfu8JYascu42
 HG4l7XZ4d5PSwbR9+Nlk51E3oATWiVMOcodPL1r3B1nQ1V15kuitC68OZmkIeMTw0WOc
 7Ba8fRbFPMSzvCSFlUwepa74rftC2458INif55LSM0tbwO3VP0xEGLY89Fbt8HjOyu+9
 2zciP03G5R6t3n/BaBLt+2iDugk9Y53768iCw+eMHKxyawDAMnCGaG1XysyZQD9Whuk3
 9kMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730553470; x=1731158270;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FdlRSFSVE5+jilPfwmoz97fjdKJLulipSEMWN67GtgY=;
 b=NvMqgiECz4J/eE/YhpfJcCoDEa/vg06t5HnSEAwZot3xJ6fYD0dg+hgoAgU1zOM6o+
 u8Y62NxtojC4KXaaVpq9IpdPTvrjXQ8+KiWypRk+3jnLSzADoAurCLZXS+z5746TW+Jc
 9UJsRVRF3P/UpZogH27j+evw7F4sxcFaY1sGwU9Nl1RU3e8yXDFVYnPxuyYfCFJ5/g2S
 DgFcc2T+7MfxFa1qwptwVwNJXgoFzrf3bIx87MdBGnF3I5z5RQpdi6Eu1OJV799jCA3B
 7SYFvY603lRxaQqUFbGu4YyG6FM9O99g1+Jxyka9zlT5L2ZRT0P8bADmU+7O26vvFii0
 hJcA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXFV0PvnW6+9dpbuJ8EMF4unAll3rgx8l25MFAK4aG8pojYiq62RNkpoTGqIBsz5q1dQu/0y9ijxW78@nongnu.org,
 AJvYcCXUvytAgyWSnzhZVqTONEYe7Mz+GRJSi8g9nVeKrFedZfS/QXsckReryngX2qwCKYdnbjuaqM7TzNQ=@nongnu.org
X-Gm-Message-State: AOJu0YwqsMaVuhpGRtkeVhBhj5Z7kRnq5IoohzG6mxIfb7wxZ6wCFtUr
 67EyKn7Uz9wj5CIVpR5tMHNAgtuTi/+JqiebDL+10FnldFjjv5RJwZb+8w==
X-Google-Smtp-Source: AGHT+IHWAmadtq2H8x8vkXXajemY4CQNXF+sufmMYE8SBjrdsSdHgXnfrD3qtu/EGtdZe3bNK+Bcug==
X-Received: by 2002:a17:907:9407:b0:a77:c30c:341 with SMTP id
 a640c23a62f3a-a9e652a2f0dmr654804166b.0.1730553469923; 
 Sat, 02 Nov 2024 06:17:49 -0700 (PDT)
Received: from archlinux.. (pd9ed7f6d.dip0.t-ipconnect.de. [217.237.127.109])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9e5664350esm307859066b.159.2024.11.02.06.17.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Nov 2024 06:17:49 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-block@nongnu.org,
 Bin Meng <bmeng.cn@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jason Wang <jasowang@redhat.com>, Bernhard Beschow <shentey@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, qemu-ppc@nongnu.org,
 Corey Minyard <cminyard@mvista.com>
Subject: [PATCH v3 15/26] hw/net/fsl_etsec/miim: Reuse MII constants
Date: Sat,  2 Nov 2024 14:17:04 +0100
Message-ID: <20241102131715.548849-16-shentey@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241102131715.548849-1-shentey@gmail.com>
References: <20241102131715.548849-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x52a.google.com
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

Instead of defining redundant constants and using magic numbers reuse the
existing MII constants.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/net/fsl_etsec/miim.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/hw/net/fsl_etsec/miim.c b/hw/net/fsl_etsec/miim.c
index b48d2cb57b..4e9169907a 100644
--- a/hw/net/fsl_etsec/miim.c
+++ b/hw/net/fsl_etsec/miim.c
@@ -29,13 +29,6 @@
 
 /* #define DEBUG_MIIM */
 
-#define MIIM_CONTROL    0
-#define MIIM_STATUS     1
-#define MIIM_PHY_ID_1   2
-#define MIIM_PHY_ID_2   3
-#define MIIM_T2_STATUS  10
-#define MIIM_EXT_STATUS 15
-
 static void miim_read_cycle(eTSEC *etsec)
 {
     uint8_t  phy;
@@ -47,14 +40,14 @@ static void miim_read_cycle(eTSEC *etsec)
     addr = etsec->regs[MIIMADD].value & 0x1F;
 
     switch (addr) {
-    case MIIM_CONTROL:
+    case MII_BMCR:
         value = etsec->phy_control;
         break;
-    case MIIM_STATUS:
+    case MII_BMSR:
         value = etsec->phy_status;
         break;
-    case MIIM_T2_STATUS:
-        value = 0x1800;           /* Local and remote receivers OK */
+    case MII_STAT1000:
+        value = MII_STAT1000_LOK | MII_STAT1000_ROK;
         break;
     default:
         value = 0x0;
@@ -84,8 +77,8 @@ static void miim_write_cycle(eTSEC *etsec)
 #endif
 
     switch (addr) {
-    case MIIM_CONTROL:
-        etsec->phy_control = value & ~(0x8100);
+    case MII_BMCR:
+        etsec->phy_control = value & ~(MII_BMCR_RESET | MII_BMCR_FD);
         break;
     default:
         break;
-- 
2.47.0


