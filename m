Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2F35C55174
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2026 19:13:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrh31-00089J-8N; Wed, 05 Aug 2026 15:13:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <simonxhy0404@gmail.com>)
 id 1wrh2z-00088n-PN
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 15:13:01 -0400
Received: from mail-oa1-x34.google.com ([2001:4860:4864:20::34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <simonxhy0404@gmail.com>)
 id 1wrh2y-0005a8-1r
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 15:13:01 -0400
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-4518ad44e83so883159fac.0
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2026 12:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785957178; x=1786561978; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:content-type:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=P+/zS48YlBPvLSJbKrbixNLAeu6upOPlmlNFBogrFVw=;
 b=DnFAgWQRSwIu6meDTeWv5Ss+mRCjHvTosf9E4j4Nzdh3mnRoraVlBYK6RXaPvOtcqn
 J8TedNfw+4Xf67UqATBGVz2WqyMBD9hvvqRL4avt87fuv8Sfxc5bdVlbtWZGg3veWq3i
 XVpxz6jaJzz6OEdLnXp7zP0gBAj1vu5nT+Onl38GPhpNDKG65iNyzaiSuFKyeyYT1AGu
 KTbA8RoPxwyNSM6CiRElzPZALzSqIY7AKytfmNpwg664g7+P0ZeIGMDvdddH1QxXlJka
 vjZGvg/NT9V2RK/WQSpbJ0I1rqrkjs1blzFmctppKBiDCfOyaqGejdLw/Vvwk1hdCd6g
 ZnSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785957178; x=1786561978;
 h=content-transfer-encoding:mime-version:content-type:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=P+/zS48YlBPvLSJbKrbixNLAeu6upOPlmlNFBogrFVw=;
 b=D4JlW2tjWAjf+9MsIxbyGZEV8NfPWDnaAE7OlcL4gFwd+Pm0JhkspH+1RXgxAWRsMw
 ZDMNth7JNebVpk45qVlTlj6dvO1cCnSlGtzvlLcoZJLOTNgh3GyfSAKQDyqAYgBBgOYw
 Ss/tMvQ1DB87IcGb/W+mJvu1dIsKmCZHdB8utGp6yC4jb529oE3HQsDRTUYBHwv18i7g
 mqZOIUoAtSwMlyQO/HWOIyAxzetKXAPJO3d6gckSMCJx7spzdBh+KaaqXEnr3/+2S0Tr
 uUHc+8PRWuonBdBhzZodV7FU5KeuO8TDa+nZ48QEXx7XJVWlopaHSqvzA5NDTn2PazUc
 cuPg==
X-Gm-Message-State: AOJu0YwGJBnDG6FsmvwdvSetltRYCBY1j5OrrK9D3Bun3aeSrFwxxnfT
 HB3OpYgrwPK/0vdushGuchgTFcY6jgGgcIbqyGEC8UvW3eSvw9QYgKYEV1YXoza/
X-Gm-Gg: AR+sD12ktZniHItpLBdT7E4TYdwpFjXdkWKvYPr83D/aIRl8xfRI78vZQ0dNwYhAT6p
 nM2SdUiPP9Cntr1HK+x4wjx7vjgRd4CQKZdmvMmqoGi6P1Z906EQ0xFTY5+qqKKE8tatq6pT2oe
 lM/wU0M5cY4rFTH1O0x58iT/t1QTGuvjkNMtPnEpPkk+wd1xl1zoYQa5P+a47fC5M+zqonGBrof
 J/gKMJwEtqCn7L7J4KoK2g/BP89eZjPOjFQ7ZwDLo89ucy6mK2rWSTYQBkunZRhcPzIbOuqE1SK
 Lfd9NMmvBTQl16X0qY2K39auQogJ0cSIEFoTFyJbqQ8b9rZsx3b87TYbpyjjwTRGhI/40xEzn2M
 x+Eo++cJo2LcIThbF38+cUtuDAHxxMHcysn6IMNImicfA2SWlfGkOLwntQymJcUypNh2N24h8IO
 c2m1ftoo+dzk3250g/3JBY3rGwqK389dx69X5cf5kFKXfqDSkT7oBRbeSAoyTJWn+jPyBKs4rrC
 21xKuO3WGz3t1c=
X-Received: by 2002:a05:6870:2249:b0:448:3eb2:8c8c with SMTP id
 586e51a60fabf-4599eb81db8mr4509912fac.6.1785957178503; 
 Wed, 05 Aug 2026 12:12:58 -0700 (PDT)
Received: from HPE-2MQ6131DV6.ams.hpecorp.net ([170.85.98.248])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4599dd615ecsm3494867fac.0.2026.08.05.12.12.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2026 12:12:58 -0700 (PDT)
From: Simon Xu <simonxhy0404@gmail.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Simon Xu <simonxhy0404@gmail.com>
Subject: [PATCH 0/4] hw/arm: bugfixes for Arm SSE-300 and AN547 models
Date: Wed,  5 Aug 2026 14:12:53 -0500
Message-ID: <20260805191257.11303-1-simonxhy0404@gmail.com>
X-Mailer: git-send-email 2.53.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::34;
 envelope-from=simonxhy0404@gmail.com; helo=mail-oa1-x34.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

This patch series fixes bugs found in another patch series and more:
	SSE-300 SLOWCLK Secure Watchdog address was in non-secure region
	SSE-300 PPU addresses were copied from SSE-200 and not correct
	AN547 MPC ports were not correct
	AN547 was missing the DMA ports on AHB PPC EXP1

https://patchew.org/QEMU/20260723233605.805-1-simonxhy0404@gmail.com/

Signed-off-by: Simon Xu <simonxhy0404@gmail.com>

Simon Xu (4):
  hw/arm/armsse.c: fix SSE-300 s32kwatchdog address
  hw/arm/armsse.c: fix SSE-300 PPU addresses
  hw/arm/mps2-tz.c: fix AN547 APB PPC EXP0 MPC ports
  hw/arm/mps2-tz.c: add AN547 AHB PPC EXP1 DMA ports

 hw/arm/armsse.c  |  8 ++++----
 hw/arm/mps2-tz.c | 21 +++++++++++++++++++++
 2 files changed, 25 insertions(+), 4 deletions(-)

-- 
2.53.0


