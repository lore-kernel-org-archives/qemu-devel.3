Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88723E677FC
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Nov 2024 12:58:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7DhO-0004Mp-GJ; Sat, 02 Nov 2024 08:57:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1t7DhJ-0004Ks-GC; Sat, 02 Nov 2024 08:57:45 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1t7DhI-0003Xe-23; Sat, 02 Nov 2024 08:57:45 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5c903f5bd0eso4820207a12.3; 
 Sat, 02 Nov 2024 05:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730552262; x=1731157062; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KIqTwKVmMLCPHX5uGIHR9/NgmD1AyevqjxxApzMtNnc=;
 b=HGC40/mwEfZS7FgdfFKpa7VWsT8GpWtm6HDVp4QArGIvFXxK072FoAyN1OGGPVt+vs
 hNgrjbGLCq50V4mWppgR0CA+D3bGhny9vIF/BT+1cqNZMKe4Q4P6EV4UoV4q/UnxRtlo
 9I0FkkfVOLxPW/jCnyiP70V2gwgV1nxag/HSaJmm81Er5vCG86v0GYxVE4kD3VWy9qIN
 +RXDrK2Z4Ailx1hfQeu/T2Y0I64d7khZPdxLEv71XY8k7iPg6uMPdEHzBq/o9QUT+O86
 TzRzrNb+SmKyiNc5K/851spSGdE3Zui0L65hHJwdBCP4k1OUtO8B+zi6brqtknktCX4y
 Sc0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730552262; x=1731157062;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KIqTwKVmMLCPHX5uGIHR9/NgmD1AyevqjxxApzMtNnc=;
 b=xJlYSkN6KRkB3hNAoGyTKfqvpQiOXbaIF0Lv6w/QDc9X3QHfja7IAUoRsxKhrYo4Kp
 aR/t7bAjlitXKiQeRH7nS8kwa7HgimfosN4ooxwbM5ymKoxnpIIr9nJZw7AafoGKZ50b
 iNNetEMQDZXosLNA+WA83YQobdFTWuAETccGwjqShYewWwvJ7Qj04y6zQyrv+58OvAYj
 0azrJkbMhQu3kI/rzA0NtYWCWfRDYwG1N+hBYiTxwPi+ITqUZKh62QgBwH3ej/RL9oAy
 JThyM+6raWTUzzlSrt0lmvV4m2oDdsFZi/m4V0Lq+EEQxeuJCH08oNxmMNFIlgTU2Jwf
 UzuQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVDuHCk0WPKD58t03azORJ+cdOFoTrpONSWcF/MZ5GtD7jpsQWjWvDEz9QphS7VlLFYIN14EvhdIw==@nongnu.org
X-Gm-Message-State: AOJu0Yz08UPMVNz7i73HFW5LnVPMIA5zy6JD2GWvz6S2Vlz2TBg60ltF
 fBUBZttDTfW2EDq5BPpOVcO4pMx8CLOKs6JfX4q8H8FCCzvyLpbVUiwgig==
X-Google-Smtp-Source: AGHT+IE7MhNdOrxr3+Ya0t3LJ8oX+yKsR1ReiGn8Je62iux2rioOc9vOXRr+bKKJBw6S+Yutgm90Iw==
X-Received: by 2002:a17:907:9706:b0:a9a:5004:cecf with SMTP id
 a640c23a62f3a-a9e5089f85fmr958974966b.9.1730552261543; 
 Sat, 02 Nov 2024 05:57:41 -0700 (PDT)
Received: from archlinux.. (pd9ed7f6d.dip0.t-ipconnect.de. [217.237.127.109])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9e566846a7sm305836666b.206.2024.11.02.05.57.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Nov 2024 05:57:41 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, Guenter Roeck <linux@roeck-us.net>,
 qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v3 5/5] hw/net/lan9118_phy: Add missing 100 mbps full duplex
 advertisement
Date: Sat,  2 Nov 2024 13:57:24 +0100
Message-ID: <20241102125724.532843-6-shentey@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241102125724.532843-1-shentey@gmail.com>
References: <20241102125724.532843-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x529.google.com
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

The real device advertises this mode and the device model already advertises
100 mbps half duplex and 10 mbps full+half duplex. So advertise this mode to
make the model more realistic.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/net/lan9118_phy.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/net/lan9118_phy.c b/hw/net/lan9118_phy.c
index 874dae4155..5c53a4a1e3 100644
--- a/hw/net/lan9118_phy.c
+++ b/hw/net/lan9118_phy.c
@@ -110,8 +110,8 @@ void lan9118_phy_write(Lan9118PhyState *s, int reg, uint16_t val)
         break;
     case MII_ANAR:
         s->advertise = (val & (MII_ANAR_RFAULT | MII_ANAR_PAUSE_ASYM |
-                               MII_ANAR_PAUSE | MII_ANAR_10FD | MII_ANAR_10 |
-                               MII_ANAR_SELECT))
+                               MII_ANAR_PAUSE | MII_ANAR_TXFD | MII_ANAR_10FD |
+                               MII_ANAR_10 | MII_ANAR_SELECT))
                      | MII_ANAR_TX;
         break;
     case 30: /* Interrupt mask */
-- 
2.47.0


