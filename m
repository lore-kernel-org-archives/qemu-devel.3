Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE221606A322
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 13:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=oY65UC+s
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVqaG-00057v-P5; Tue, 24 Nov 2026 08:29:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xVqa8-00055K-My
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 08:29:12 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xVqa6-0007Nn-Tx
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 08:29:12 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-4ac08f4a0b2so3215764f8f.3
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 05:29:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795526949; x=1796131749; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=137mkQ016tl/V+kNf+GtUcNZvyEcotqgF2sJNrkP6Dg=;
 b=oY65UC+suo4GrysqSu1qtfl/QXV2IyFSXXQ1cUlnlt2LnNmHg1JR5tH/a58kh8ke3o
 J8Y8cBWxANI8dwTgn04TfE6ypdqH9GqhWPoeJkZ2Ym51SSAA4yJyh0Mi1uOvgYNWfPS7
 kQ7Z/1hLZTwXxuYKa77wZrczG2e68TEPNRjtzASK/miOryU/krUjV61mfnoqHB/obiKR
 M2WQD6PxNPdRa2WN4xzOOnvlXxeKtFVI5/oh0V6Ou4cmUZ36AG2+nyW/uICl/OPB8UtT
 WT4r3tP5a/4qXaqivITsdbHnqS4kYfJWJEQq9FoIjD6pT3oKlIuTvGi3YamkvyjKN5mh
 l5QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795526949; x=1796131749;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=137mkQ016tl/V+kNf+GtUcNZvyEcotqgF2sJNrkP6Dg=;
 b=WTrz7C+o2zyCzxMpX2RfTpd11sn9lYJuTNM3e6a1lUatYkWgUxfQa5wjWeI0VSDGIB
 LZy8td3USFj8yEEmHOiL3qtY6XmYJqeHUk3l3MtgMXYuqBDua4HfrDxf1ubB/XsPrAsx
 rVdN9uf2k1jGn8spRLp2sNXujDLP7AvUm9eR5krZIP1DBhyEh0WN1uPEUawGd72d/1O/
 NEy1sIb3ih0E1XzL4wWOnt8V020MABmjjLG16jvv01lGQYCe56KmuhVkUNFsMRMg+pGd
 +WQ3NCKOH7ThpR0h+v5C12v2pswNvsw6290GMxEE9JQiun7I5FETWg4hvJ26JqlmaXBl
 5UBQ==
X-Gm-Message-State: APuU4Z8yQCTJRKkokVtSmV1lBEt+LC0nL7BBCnZbU1jWNw/yYnHoW31g
 IfW5NwBbfz0MN96WE4GeIuiCtTxIzygcgAI8gu0dfrlNShLi/G/7Rr6sSKWGnb0rrsJKm0+a+um
 KTsED
X-Gm-Gg: AZFdTZdsJmIhob/sCg83QuDQW7PRGEO60NxgLMwKQQK36VVsy8Y5gDWfbAQkNOs7kgb
 GmsbgP0EAhv/xZUYsLnVhouuhxYFZuR1+WM2cCV4wIdECnUhWZxDpWCzNl3eQ+rXN1ZolxR7gOr
 zivfIjAvSI6jBBCcEqfQG3zkIc2cvuUd0GGjhaXauxYxpzJTBDLMe39ADWG6bOA0JDhP9gOO5Kh
 YnSuUtXskadCezN/bRfPsy4gqc+ertbwZbHCaLLIHsjwjLgWIyxZJ9TRwMKc8ENgJd4t0x2uIqs
 wBGddYYESDjJQCs+/Ki/rPUH+Egre7qJ7Kx7DBA7+Y3WHKENtmNKTEevWoBcnQF3nWRG4kryn2l
 3E+UDP4IFVrE7fexQayrbo+67AMKPuvH8nSvXedQjXD1zjv+TYMRQaNuHt5wYWiXHq8bL93ZdPQ
 cobo0/PhD1ANxRlrnuoQDY03hqf5WI6t3oOeIY5ZIAB69Ux3877+ow4ADMpnr1FZZa5Wb4qsIWu
 QxOoPS6LX6u9Gmsk3ZTPYvfcurF5TI+nAQKxbcM2I6uLazHa4fbojJ/ANYs806fXoEaCzYQ8I3G
 Vywyrw51KsAaNWByQ7HbfLNnqsMobSK+pERPXRFa6vbTik2nhsyOMIocHDp12+e04u81t1cLmAb
 xofTcsqQd1fpH/RpIW2z77KlMmjatHcQoHFhaJswVtJuM36dQWS8nFiI=
X-Received: by 2002:a05:6000:604:b0:48e:47e6:fdfb with SMTP id
 ffacd0b85a97d-4abb0c5d588mr27576435f8f.13.1795526949384; 
 Tue, 24 Nov 2026 05:29:09 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6b10b2c9sm29098031f8f.31.2026.11.24.05.29.08
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 05:29:08 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 3/9] hw/ssi/aspeed_smc: Correct minimum_version_id in vmstate
Date: Tue, 24 Nov 2026 13:28:58 +0000
Message-ID: <20261124132904.138731-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261124132904.138731-1-peter.maydell@linaro.org>
References: <20261124132904.138731-1-peter.maydell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x434.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

In commit 29139270d8ad70f2 we made an incompatible change to the
migration state for the aspeed_smc device, and bumped the version_id
and minimum_version_id: this is because we increased ASPEED_SMC_R_MAX
and so the regs array is bigger.

However, the old vmstate was handling migration from a range of
vmstate versions, with version_id = 3 and minimum_version_id = 1.
The change to ASPEED_SMC_R_MAX is (intentionally) not compatible with
any of those older versions, and so it should have moved
minimum_version_id up to 4 (matching the new version_id), not merely
increment it.

The effect of this is that trying a migration save on v11.1.3 and
then a load on the current head of git fails in a confusing way
("Missing section footer for aspeed.smc") rather than clearly ("error
while loading state for instance 0x0 of device 'aspeed.smc':
aspeed.smc: incoming version_id 3 is too old for local minimum
version_id 5").

Since we now don't need to try to handle migration from versions 2
and 3 at all, we can drop the complications in the vmstate struct (an
unused field, and field only present in version 3 and up). Clean
these up and set the version_id and minimum_version_id to 5
accordingly.

Fixes: 29139270d8ad70f2 ("hw/ssi/aspeed_smc: Add Data FIFO-based flash access support for AST2700")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4880
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Message-id: 20261119171425.3186790-1-peter.maydell@linaro.org
---
 hw/ssi/aspeed_smc.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/hw/ssi/aspeed_smc.c b/hw/ssi/aspeed_smc.c
index ec9ad0f747e..f82947e752e 100644
--- a/hw/ssi/aspeed_smc.c
+++ b/hw/ssi/aspeed_smc.c
@@ -1218,12 +1218,11 @@ static void aspeed_smc_realize(DeviceState *dev, Error **errp)
 
 static const VMStateDescription vmstate_aspeed_smc = {
     .name = "aspeed.smc",
-    .version_id = 4,
-    .minimum_version_id = 2,
+    .version_id = 5,
+    .minimum_version_id = 5,
     .fields = (const VMStateField[]) {
         VMSTATE_UINT32_ARRAY(regs, AspeedSMCState, ASPEED_SMC_R_MAX),
-        VMSTATE_UNUSED_V(2, 2), /* was snoop_index/snoop_dummies */
-        VMSTATE_BOOL_V(unselect, AspeedSMCState, 3),
+        VMSTATE_BOOL(unselect, AspeedSMCState),
         VMSTATE_END_OF_LIST()
     }
 };
-- 
2.43.0


