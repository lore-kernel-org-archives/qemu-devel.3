Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12AF7C4451B
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jul 2026 21:20:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlYvF-0007WF-EE; Sun, 19 Jul 2026 17:19:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1wlYvD-0007V4-Fr
 for qemu-devel@nongnu.org; Sun, 19 Jul 2026 17:19:39 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1wlYvC-0006ph-0Y
 for qemu-devel@nongnu.org; Sun, 19 Jul 2026 17:19:39 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-49553515a8bso12605835e9.1
 for <qemu-devel@nongnu.org>; Sun, 19 Jul 2026 14:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784495976; x=1785100776; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:content-type:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=qt2C5RS5kxCF8pM+u++9Adv3L5rr8/2rjYzvmiQrNzA=;
 b=fDFs9+1u6v+SmloWFXJ854V8a0EdFAtLIPpcSS4Ru28coqB9Fb/NjLiywVzXy7X+MP
 hVL+grHnVRu8f4K06k3tQfD+MpoSKl+kyDy/Jl+DdTC4q/P6tmMk2bQbOxmBaLNr/Mhz
 drtq7P9EWNJC3kKYeEF9SHWHeU4OoFJq2vgvzhtg+gz9XDFOEM7fTOx9eFXpeiuc2W31
 xLZyuemObmqSKnBVaiheTsYPBX+n1k57LXmNUUVjg43vyAPJD6ykIFBwQ3drX1Q9R0IY
 fXh0uO6oyvPmPT+7UaEyTkJX3VoeK4Usdu8m2hXZLZKamhNEr4Pdf7m/fzrZDLBBs3Rs
 h4ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784495976; x=1785100776;
 h=content-transfer-encoding:mime-version:content-type:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=qt2C5RS5kxCF8pM+u++9Adv3L5rr8/2rjYzvmiQrNzA=;
 b=Sh6dt4twbewz9tx89eOajxjf3WMSxh117u9ah/HxwWThZteW/FWk2Xljm6rtaHa8m8
 Ad0Z0GKVUCU1orgniDB01Jd9+mnT9ePrd7SoSQhhqmlFgYmN7jt4fThQ/6GtPVtiEcCG
 6lFbbhSRhR+wJ4wK5/bwcyYV1K0aZQVznAJOnBiJCC3stJoIsBGYiv3Kao7HIDiKyaIb
 FrwpHUD9Ec94NcIQI3xmTIk+gkLB82NCG/mGTsdhUoz3j65xsLmDo3foA0Vtz/9GH2Wl
 6SrKkmI3EQ8WzetD31Zqvkc9U7eDzLA3e0RvVvz7s8GyTPf37lKTJs/jxGPp9nPIo9L0
 Q6Fw==
X-Gm-Message-State: AOJu0YwFBgrpVEYMzsrYeSfywg6LNSloC5/wIZQtXf8/q+jVFpexRg2l
 o5WpxJQ24j99NUHNwbmzwXnn5UaIKq3jn6HumTW+IHG0xWy2KCCGAF2EJDGebw==
X-Gm-Gg: AfdE7cml+0CenW3rtq9VFHBpyhaRDgbCpRszY2FucjR53G2AMnU6AHOpyw1mJIUlNcz
 ffSgfDuJSCRb40r5f5Ufw5GtJg33yltvTvEeUCy6VZKn9A38Vz681eyiLBjUTJNafgmd1IzWec6
 jwH/TJS/NllnSXaeW/t8YzJTF7a+MucSTxFpj+bts0wh8YjH/730NN7PlpY7YqQmMUImjh18hF3
 r8FzkxIKzXmyfaWvclMWHCglJpNUgn125Ug4L0xoBda/GpPXwoJdg/ZWecd0iFltLpRjz4Gqnje
 4N5cvMbsTup5G43lQKi3bjeNSbK5PE6xrxv0lgsBU2vIw/uoj6oBIXfMDeXbfzCzl1pKJrM1oXM
 bqSkMkXF/esH2dYcx6th2OEp+MOiO5jSQSEKVLLc8ZszZN30O7nYemrfqdYhuG4ZisQyHgOyMRF
 E09ObYOOH/qqfJdsXda56MwVpedyjHob2IxDou8ZGaGEPQCZ7z3OZ1kr1Z9P5mXRfRkYSNmbVP1
 VJgd2qjR9w6SdzFOfqFVYqYPw==
X-Received: by 2002:a05:600c:a44:b0:492:68bc:3237 with SMTP id
 5b1f17b1804b1-4954a40c014mr112669825e9.32.1784495975879; 
 Sun, 19 Jul 2026 14:19:35 -0700 (PDT)
Received: from Provence.localdomain
 (dynamic-2a02-3100-1c56-1500-0219-99ff-feb2-2458.310.pool.telefonica.de.
 [2a02:3100:1c56:1500:219:99ff:feb2:2458])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4954a2a24b6sm234235155e9.3.2026.07.19.14.19.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Jul 2026 14:19:35 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 qemu-block@nongnu.org, Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH 0/2] SD & SDHCI fixes for 11.2
Date: Sun, 19 Jul 2026 23:19:21 +0200
Message-ID: <20260719211923.1079282-1-shentey@gmail.com>
X-Mailer: git-send-email 2.55.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x331.google.com
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

This series fixes two issues in the SD subsystem. The first one could send QEMU
into an endless loop or crash it (depending on whether assert() does something).
The second patch fixes possible file system corruption in e500 and imx25-pdk
machines, i.e. the ones using eSDHC rather than uSDHC, though I could only
verify that with imx53 emulation on my imx53 branch [1].

[1] https://github.com/shentok/qemu/tree/imx53

Bernhard Beschow (2):
  hw/sd/sd: Fix error case for CMD18
  hw/sd/sdhci: Extract uSDHC-specific quirk

 hw/sd/sd.c    |  3 ++-
 hw/sd/sdhci.c | 73 +++++++++++++++++++++++++++++++--------------------
 2 files changed, 46 insertions(+), 30 deletions(-)

-- 
2.55.0


