Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87EE7606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 21:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=KB8dW3d+
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLSG6-0001No-Se; Mon, 26 Oct 2026 17:29:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gessingate@gmail.com>)
 id 1xLSFz-0001LX-MJ
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 17:29:28 -0400
Received: from mail-qv1-xf2e.google.com ([2607:f8b0:4864:20::f2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gessingate@gmail.com>)
 id 1xLSFx-00077i-2e
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 17:29:27 -0400
Received: by mail-qv1-xf2e.google.com with SMTP id
 6a1803df08f44-917c04630c2so38517016d6.3
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 14:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793050162; x=1793654962; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=O/N1K8D/SpacXzaFnyxWTfnjEcncC7vi42PU2GqoRBg=;
 b=KB8dW3d+IlSLg517BTeOLQFNplMup0+7G8MCef0rQLGpTuce0HyBqPt7QjGGvS88s/
 EhRMpMQhvxL6LUHYOiZ8R/XPNMxiWnoJI2r8Zyflx83U7iMoi6pOASYgvci7SESEIKkt
 jAEflyM0G8eoUO+K3qSZvBHpC6Z/PRuPlVi7x0oFeCzkFfAzkhOygAjZDAzcQNZlbFSh
 i117yuU6biTdOJUJING1gUKlwyi3MqL7+6NV6LbuL+WneWSi/nBL//feQagys9YUz2WM
 khMCWKpamlVnZLhFc/KzyPbMhotxOreZ4sZWwZH0XzDsS2m1eJu7HC3I0yKPGa22f+P3
 p4sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793050162; x=1793654962;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=O/N1K8D/SpacXzaFnyxWTfnjEcncC7vi42PU2GqoRBg=;
 b=pbpzWUIl5OzFPmM8mhjFyC+NsNNpsE88awAK6repiltYd+T7UD+QwF+KVOh1pTyCkO
 zerWzWpKBvEbZkFKxnnuKSidWDCOoWQFEF4TsSFeB/g3ORltfm1Gw0eTQq0ie0/+Q+yA
 +7BfifTsMACtkLG2hPvddB97HedoEYbpGRu76846ILdUHEG7rdGaeMZgwXrjdBElXLov
 9g98wXK3YBzyqmzNA9+VxXr6ktO6dkFaWRoev7/A7Beim6zLMDztb7hbGFgO+eCrEqai
 BxFdZNP2Mcijw2t1EiHfEfrLl1b+rqwghAs+sxCqklojkv0g/SHHCH61Rsu5jrksiq30
 Uzqg==
X-Gm-Message-State: AFq9FYK7fmBHLukFdieazbNqFoXDLTD5tWg72oX/6XowqiGQJxb2qgcl
 BtFD0C1MAqGuKCaYUIIcx2PoGl6Q752Sa07gA6uGo814p55yFqQtKq+0
X-Gm-Gg: AYBFou3fFHZLt9X62V3RYDLWBY1JApojk+jYvahS0oFrCrLV8xOFvjC4PnGnwjzx0A7
 5LoTeILFT2RIgH02IjsP98xmw2HmeyzrmS1vP6EDfcRbyVe8t0IOaIz9xy0EJqB6pBSN9A23JIM
 Hek1XJhKhRxHm6vQRwTIhc8O0nTLb+4+kEEsQeAvfu4riHaL5a+bFkYe4zzzptYxpAxTYvQC1lu
 EkjSkjCVB1HwHupQpjdG6+W0AAdLAoczkuvN4kpU6Y1uPSQd8HoTN3xPlt62CsvEvrHjN088ihW
 EtRsUcnsE/jr7rzEg9YvdlNj3dKCVw+7BzIgEs62oOeuq47FPcWwEondPwog673i0/KR6l+dbtN
 z3vopUrOIJN/Z6T6LrT/JVLaQTSDouKxsJmvMi7TFf3HzUE8THQrVuPlpL5YW0FNmFZicjiLfur
 5ZuS01kvxj8D0vxdncwjsi2rYuRP1oGnxKccdSjHq8M6QY9H7bOksX83/ibE9XgINqluZXmGdjj
 1WyrV1QBMPm1OuVA0t3vw5V0eK/g7SNyGj2wdgzVJovJTujlN5RwtKt8UeW4PtydU7L0bgf6RL9
 0ZRBj0y7fZsJ7X8=
X-Received: by 2002:ad4:5ae3:0:b0:91c:1647:41f8 with SMTP id
 6a1803df08f44-91c48eaae20mr135294346d6.45.1793050162566; 
 Mon, 26 Oct 2026 14:29:22 -0700 (PDT)
Received: from [127.0.1.1] (95-24-99-141.broadband.corbina.ru. [95.24.99.141])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91c47c6f3bcsm85206376d6.29.2026.10.26.14.29.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 14:29:22 -0700 (PDT)
From: Timur Maksimov <gessingate@gmail.com>
Date: Tue, 27 Oct 2026 00:28:39 +0300
Subject: [PATCH 3/6] hw/i2c/aspeed: fix buffer transfer in a non-packet
 mode
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261027-aspeed-i2c-nonpkt-fix-v1-3-076cdde514f8@gmail.com>
References: <20261027-aspeed-i2c-nonpkt-fix-v1-0-076cdde514f8@gmail.com>
In-Reply-To: <20261027-aspeed-i2c-nonpkt-fix-v1-0-076cdde514f8@gmail.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 qemu-arm@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Timur Maksimov <gessingate@gmail.com>, 
 "Timur Maksimov gessingate"@gmail.com
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793050151; l=2922;
 i=gessingate@gmail.com; s=20261022; h=from:subject:message-id;
 bh=qCtyqmUQnMtbRxbl1P/V7v0HhfAIOI5DaatQrdCnOdA=;
 b=PSlvPIlm5wbMnwvTsVoa8kStERjU+AmCUKy/SFds9FkGc+LiP+lzwp7/opD8dLCllvQbJG8BI
 jYvF/pK2KACBZrYZJeysvP5vEuIbPtNFf7RjuGJTpSrir023QHq3I9C
X-Developer-Key: i=gessingate@gmail.com; a=ed25519;
 pk=xF4NKIzSbKMdte17nQ66S/q9m/A2gu6GiEWc8ZnyJmo=
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2e;
 envelope-from=gessingate@gmail.com; helo=mail-qv1-xf2e.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Buffer pool first tx byte contains a device address in non-packet mode.

Fixes: 961faf3ddbd8 ("hw/i2c/aspeed: Fix TXBUF transmission start position error")
Signed-off-by: Timur Maksimov gessingate@gmail.com
---
 hw/i2c/aspeed_i2c.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/hw/i2c/aspeed_i2c.c b/hw/i2c/aspeed_i2c.c
index 136d4eb859..ec46f6c94c 100644
--- a/hw/i2c/aspeed_i2c.c
+++ b/hw/i2c/aspeed_i2c.c
@@ -382,7 +382,7 @@ static void aspeed_i2c_bus_recv_dma_pool(AspeedI2CBus *bus)
     SHARED_ARRAY_FIELD_DP32(bus->regs, reg_cmd, RX_DMA_EN, 0);
 }
 
-static int aspeed_i2c_bus_send(AspeedI2CBus *bus)
+static int aspeed_i2c_bus_send(AspeedI2CBus *bus, bool send_addr)
 {
     AspeedI2CClass *aic = ASPEED_I2C_GET_CLASS(bus->controller);
     int ret = -1;
@@ -391,11 +391,12 @@ static int aspeed_i2c_bus_send(AspeedI2CBus *bus)
     uint32_t reg_pool_ctrl = aspeed_i2c_bus_pool_ctrl_offset(bus);
     uint32_t reg_byte_buf = aspeed_i2c_bus_byte_buf_offset(bus);
     uint32_t reg_dma_len = aspeed_i2c_bus_dma_len_offset(bus);
+    uint8_t pool_offset = send_addr ? 1 : 0;
     int pool_tx_count = SHARED_ARRAY_FIELD_EX32(bus->regs, reg_pool_ctrl,
                                                 TX_COUNT) + 1;
 
     if (SHARED_ARRAY_FIELD_EX32(bus->regs, reg_cmd, TX_BUFF_EN)) {
-        for (i = 0; i < pool_tx_count; i++) {
+        for (i = pool_offset; i < pool_tx_count; i++) {
             uint8_t *pool_base = aic->bus_pool_base(bus);
 
             trace_aspeed_i2c_bus_send("BUF", i + 1, pool_tx_count,
@@ -633,6 +634,7 @@ static void aspeed_i2c_bus_handle_cmd(AspeedI2CBus *bus, uint64_t value)
     uint32_t reg_intr_sts = aspeed_i2c_bus_intr_sts_offset(bus);
     uint32_t reg_cmd = aspeed_i2c_bus_cmd_offset(bus);
     uint32_t reg_dma_len = aspeed_i2c_bus_dma_len_offset(bus);
+    bool start_cmd = SHARED_ARRAY_FIELD_EX32(bus->regs, reg_cmd, M_START_CMD);
 
     if (!aspeed_i2c_check_sram(bus)) {
         return;
@@ -642,7 +644,7 @@ static void aspeed_i2c_bus_handle_cmd(AspeedI2CBus *bus, uint64_t value)
         aspeed_i2c_bus_cmd_dump(bus);
     }
 
-    if (SHARED_ARRAY_FIELD_EX32(bus->regs, reg_cmd, M_START_CMD)) {
+    if (start_cmd) {
         uint8_t state = aspeed_i2c_get_state(bus) & I2CD_MACTIVE ?
             I2CD_MSTARTR : I2CD_MSTART;
         uint8_t addr;
@@ -686,7 +688,8 @@ static void aspeed_i2c_bus_handle_cmd(AspeedI2CBus *bus, uint64_t value)
 
     if (SHARED_ARRAY_FIELD_EX32(bus->regs, reg_cmd, M_TX_CMD)) {
         aspeed_i2c_set_state(bus, I2CD_MTXD);
-        if (aspeed_i2c_bus_send(bus)) {
+        if (aspeed_i2c_bus_send(bus, start_cmd &&
+                                     !aspeed_i2c_bus_pkt_mode_en(bus))) {
             SHARED_ARRAY_FIELD_DP32(bus->regs, reg_intr_sts, TX_NAK, 1);
             i2c_end_transfer(bus->bus);
         } else {

-- 
2.53.0


