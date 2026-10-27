Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9D6606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 19:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Hj4nVR/6
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLnE0-0002vD-Hk; Tue, 27 Oct 2026 15:52:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gessingate@gmail.com>)
 id 1xLnDp-0002p2-Ki
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 15:52:39 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gessingate@gmail.com>)
 id 1xLnDn-0004rz-1v
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 15:52:36 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-48df4e9d2d4so138011f8f.3
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 12:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793130754; x=1793735554; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9jRX61TYPGRlmpi8eH3adBessAOSuidJl6Eeu2cnOG4=;
 b=Hj4nVR/66FrkoST+37pKB/vPBOx+7HmTTSB0kGuro2038PrgUXEJVHgBzcehmUvgPq
 KRry96dLJo3suWhv6Ak+TumVNyf36oqBVJn2LFbkZUnJSZ1wcTVWoEJpSyLJyUHbSMgO
 RMfZSbD++3VFxDSyQwhlSbEx8fJHYyymPrIlVQhdxC7aG83MUPHBd3mNzcuaghokcqeH
 HdkoNKCm97On6JurTjCfbMRJNarjBEw7VwcTjETSpeSRe2j7UJ9hIZ8YawOfLMfJCp68
 eJmSdMsB1yY6r0McQB8mstQL3ORFgtHhW8xe5AqePN0vGiDQJA1Su1gRYF8L7OCzwO6W
 qZEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793130754; x=1793735554;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=9jRX61TYPGRlmpi8eH3adBessAOSuidJl6Eeu2cnOG4=;
 b=eQBr/LdjWmKHEdH3/6cUnWmZ6hg0UN2eiyQifp43xTxx1Mmc/bvSK63rbyy4PKMUBS
 gMgwLQLvSQqi49VWG6Pyrj05ti8ZxGSDYejHXfgSbcIJ+4OLQovM1M5eZ9wFI0C67tCa
 sFkLCfsb/m2QuY6LMWa3pcjrQyVPZ5WxCGaZTG4KEIs3xrgxjvCpdH9KPXImWKHhRWYW
 6ZZfdELk4Ag0BoWxSK8HAi1JPGyLqj0t9Dkf9+Rt6GDhoZAUyKUnDUSrvi5lobFZYzOW
 6O+7ZRUH5PBNJlo0KIOJkvO6Rqxni5M51L1lCNjiGMNXHikxDB6fsLZAwau3Mwmdr08j
 WI9Q==
X-Gm-Message-State: AFq9FYLYPMfNOTRAEZmarHCDJGDSt35Rgskr94Qe12Yi0cSrtuqDTHR5
 IZdxryFut7zZyGYNkHKjBXO+Ee17+VKslXIokq2bEgrkdxZkwyTyti56
X-Gm-Gg: AYBFou1PYQ1B/ZkiGAX1lp+67+YsltSEvxjGA/coDxSqkA1RgeVOQ7ERZZ2Ud7vVY4Q
 EuruqD3UDH0cYPtgmPm3aPKXWAg9O7nGghu35UWaKqLskQrFVsAU3hckzcMDaSr0A0RjM9ME6OR
 GUWaKVz/SNns3QTlgnF1s0zk1kvOhZJvRIkB+zDgufhqNT6cTFegZ5wkb05RIkl1w/GgZurl8z7
 LE9BhCCLdEjiB2BPQB7vk9J5DZUhyCB2vhJP8bpD1hp3vwN4y1NjuJaTWP9UvN2WiVAJ+Khc636
 zVVLyZy/P3PolY24NiGBRYElLUv2BLD3r2/JLQ7NbjV+BprYlnE69Euq6L68XBWKgiuMe4EEo+t
 WvuQulM4cWAojwPOfzb3KP2pRnhpqC39I3diY7Ini1Sto/2qdGj1yxVSX5mWAZXBXMuyC1ssJ8/
 L9tX4mmtP07cNt81CPhWjb6jY2OZ6236CaCZEALWrDURmyQXSniEjG1o4SYJDnCVChgaJwHwEOl
 NGVGVp/coPEmZSslza17AGwc47v8hoYB9fEamjAF+HK3PCxd5k+Q6cx026K83cmI7Ssh8/Y7CIW
 LI7ZUAgL9a0Y1iE=
X-Received: by 2002:a05:6000:2610:b0:48e:b1a:fa6 with SMTP id
 ffacd0b85a97d-48e5d5a40f9mr981352f8f.40.1793130753585; 
 Tue, 27 Oct 2026 12:52:33 -0700 (PDT)
Received: from [127.0.1.1] (95-24-99-141.broadband.corbina.ru. [95.24.99.141])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebcb846sm24746368f8f.25.2026.10.27.12.52.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 12:52:33 -0700 (PDT)
From: Timur Maksimov <gessingate@gmail.com>
Date: Tue, 27 Oct 2026 22:50:46 +0300
Subject: [PATCH v2 5/6] hw/i2c/aspeed: fix DMA transfer in non-packet mode
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261027-aspeed-i2c-nonpkt-fix-v2-5-07deed1dff60@gmail.com>
References: <20261027-aspeed-i2c-nonpkt-fix-v2-0-07deed1dff60@gmail.com>
In-Reply-To: <20261027-aspeed-i2c-nonpkt-fix-v2-0-07deed1dff60@gmail.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 qemu-arm@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Timur Maksimov <gessingate@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793130744; l=1480;
 i=gessingate@gmail.com; s=20261022; h=from:subject:message-id;
 bh=55QMlLZQiV6C0P8h17/NZJrFzRnM7avkzJDMbK5RsZs=;
 b=P6YJV46BP0JdTEanWEO2TKhfPipjpO/SbcQh8lgcHfgqevU+qZ9zWXv91GDLRpDEcvl1DkpOW
 03GWDYXEr40CnvPDf8vlK6YjdiRg/GnzfC0HvqrHBrtg1hgjHCNrjCi
X-Developer-Key: i=gessingate@gmail.com; a=ed25519;
 pk=xF4NKIzSbKMdte17nQ66S/q9m/A2gu6GiEWc8ZnyJmo=
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=gessingate@gmail.com; helo=mail-wr1-x431.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Avoid calling aspeed_i2c_set_tx_dma_dram_offset twice in non-packet mode
where this function is called first in aspeed_i2c_get_addr.
Also fix writing to I2CD_DMA_ADDR in old register mode.

Signed-off-by: Timur Maksimov <gessingate@gmail.com>
---
 hw/i2c/aspeed_i2c.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/hw/i2c/aspeed_i2c.c b/hw/i2c/aspeed_i2c.c
index 510758fb7a..a2b4c8b576 100644
--- a/hw/i2c/aspeed_i2c.c
+++ b/hw/i2c/aspeed_i2c.c
@@ -416,7 +416,9 @@ static int aspeed_i2c_bus_send(AspeedI2CBus *bus, bool send_addr)
         if (aspeed_i2c_is_new_mode(bus->controller)) {
             ARRAY_FIELD_DP32(bus->regs, I2CM_DMA_LEN_STS, TX_LEN, 0);
         }
-        aspeed_i2c_set_tx_dma_dram_offset(bus);
+        if (!send_addr) {
+            aspeed_i2c_set_tx_dma_dram_offset(bus);
+        }
         while (bus->regs[reg_dma_len]) {
             uint8_t data;
             ret = aspeed_i2c_dma_read(bus, &data);
@@ -1070,11 +1072,13 @@ static void aspeed_i2c_bus_old_write(AspeedI2CBus *bus, hwaddr offset,
         bus->pending_intr_sts |= old_intr & cmd_intr;
         aspeed_i2c_bus_raise_interrupt(bus);
         break;
+
     case A_I2CD_DMA_ADDR:
         if (!aic->has_dma) {
             qemu_log_mask(LOG_GUEST_ERROR, "%s: No DMA support\n",  __func__);
             break;
         }
+        bus->regs[R_I2CD_DMA_ADDR] = value;
         break;
 
     case A_I2CD_DMA_LEN:

-- 
2.53.0


