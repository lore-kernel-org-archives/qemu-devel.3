Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46C45CAC592
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 17:51:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyZpB-0006xY-Fe; Tue, 16 Sep 2025 13:50:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3ZqPJaAYKCiEVR8FKWDLLDIB.9LJNBJR-ABSBIKLKDKR.LOD@flex--yubinz.bounces.google.com>)
 id 1uyZp4-0006vn-6p
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 13:50:34 -0400
Received: from mail-pg1-x54a.google.com ([2607:f8b0:4864:20::54a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3ZqPJaAYKCiEVR8FKWDLLDIB.9LJNBJR-ABSBIKLKDKR.LOD@flex--yubinz.bounces.google.com>)
 id 1uyZp2-0008Ah-IC
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 13:50:33 -0400
Received: by mail-pg1-x54a.google.com with SMTP id
 41be03b00d2f7-b52047b3f21so3205199a12.2
 for <qemu-devel@nongnu.org>; Tue, 16 Sep 2025 10:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1758045030; x=1758649830; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=C2sbXY6bs/mvny00HoiBY8/e0G7pmko6uoGO6Lc1eg8=;
 b=SCOSMifc7IbWqaxqnhpnhgaqcqI47zdM4JoZlLmQqcznPTc8VI3o+Hu91dFke6L0GO
 c+RhPPncy2cGHW18bor94GUECP1GeBDs1yXcJLfxf4dA2h7s9N9uAf4IvEbneUhWlrMK
 6DU7pqGtnHCQssyIg6gFx/gbNGOVY+3y284nnD9b93j5EQ5BdZn7sJ4G/CGwwe9dgXKl
 Baf9tJIXxXoXD0UWn/hpWAapf0VDfnsRKpoz3OLnMNPSSnB+eAbISfGALG+PQzbMqJYR
 QRTzDQRRJ8m8C/7KRIH/YT69Hkcwa1GKNfn07oOoYGEyhyxjAAFDAkeigda0xjzikaw+
 R3nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758045030; x=1758649830;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=C2sbXY6bs/mvny00HoiBY8/e0G7pmko6uoGO6Lc1eg8=;
 b=RUN8/dWHYm7rELUOrcBZrhE/T0do5+FeEQ7q7uWoenfbJxI9uGHL7MxW58W5kOxEVy
 khU1fSl2VAM8axoXtjtJuhKGN8sD08a++tUmn6yaQrU7ZWIHk1XlefoP0VHTg0rRSwFe
 BEt3rClHsksLTk/zfV+s4k5cIF57TQ3UPbPLZ03N7vfYxXnBlz1aBkuZIIgvK0/3e3i4
 sftSzB6FaZeSSn8ysxa0zjBekccl/qE90PUursZBA2DxmyYce/5oDwjbQMROcPoYUUaL
 +YACHjAvCOHLCn0EmDvFEuUozeTYZYtSVGTb92yzZM5rxyVT2t+UmOkRejo4uPyMhGgE
 3hWg==
X-Gm-Message-State: AOJu0Yy28Iw/LDDSFJro3oHLf1UVAxCHUZaWlTw2syi0XrE8r07P6jz7
 vg4gtkbYGKA46AA6pYUYJTkXE4H1k/uU5D9G1dFpnj5RbhHS504pqMGF4MsgpCznP5are7RN915
 AwHxxScudfdHoNxapGO4clninfYKoki8x6Wtf5Wknn3hf3XqoCaTF7IXFQLkLrH6HE/viN0zogH
 uosCPUQarEkemoeqgSpBshpiJUm0IKFAyYAqY=
X-Google-Smtp-Source: AGHT+IGwoi3/55RlKfnOCjyz5JMtFpe1gTI0icV3nt0WS4zsk4ONA1zeCwsq40ejSZy83JX3W1dI+0nLX/k=
X-Received: from plon4.prod.google.com ([2002:a17:903:1a84:b0:24c:7ef0:65c3])
 (user=yubinz job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:c407:b0:24c:784c:4a90
 with SMTP id d9443c01a7336-25d24cac4e3mr243400305ad.1.1758045030409; Tue, 16
 Sep 2025 10:50:30 -0700 (PDT)
Date: Tue, 16 Sep 2025 17:50:16 +0000
In-Reply-To: <20250916-quanta-q71l-eeproms-v1-0-3648692cc441@google.com>
Mime-Version: 1.0
References: <20250916-quanta-q71l-eeproms-v1-0-3648692cc441@google.com>
X-Mailer: b4 0.14.2
Message-ID: <20250916-quanta-q71l-eeproms-v1-2-3648692cc441@google.com>
Subject: [PATCH 2/2] hw/arm: enable eeproms for quanta-q71l
From: Yubin Zou <yubinz@google.com>
To: qemu-devel@nongnu.org
Cc: "=?utf-8?q?C=C3=A9dric_Le_Goater?=" <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>, 
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, 
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Joel Stanley <joel@jms.id.au>, qemu-arm@nongnu.org,
 Yubin Zou <yubinz@google.com>, Patrick Venture <venture@google.com>
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::54a;
 envelope-from=3ZqPJaAYKCiEVR8FKWDLLDIB.9LJNBJR-ABSBIKLKDKR.LOD@flex--yubinz.bounces.google.com;
 helo=mail-pg1-x54a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=unavailable autolearn_force=no
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

From: Patrick Venture <venture@google.com>

Tested: Quanta-q71l firmware booted to login and was populated via the
-drives for the corresponding eeproms.
Signed-off-by: Patrick Venture <venture@google.com>
---
 hw/arm/aspeed.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index bae59ae7394882e3fc93863049a37ff5a8737ff8..8cef387a0b431576a873553704920886222cca86 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -562,16 +562,16 @@ static void quanta_q71l_bmc_i2c_init(AspeedMachineState *bmc)
     i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 1), "tmp105", 0x4f);
 
     /* Baseboard FRU */
-    at24c_eeprom_init(aspeed_i2c_get_bus(&soc->i2c, 1), 0x54, 8192);
+    at24c_eeprom_init_one(aspeed_i2c_get_bus(&soc->i2c, 1), 1, 0x54, 8192, 0);
     /* Frontpanel FRU */
-    at24c_eeprom_init(aspeed_i2c_get_bus(&soc->i2c, 1), 0x57, 8192);
+    at24c_eeprom_init_one(aspeed_i2c_get_bus(&soc->i2c, 1), 1, 0x57, 8192, 1);
     /* TODO: Add Memory Riser i2c mux and eeproms. */
 
     i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 2), "pca9546", 0x74);
     i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 2), "pca9548", 0x77);
 
     /* Add BIOS FRU */
-    at24c_eeprom_init(aspeed_i2c_get_bus(&soc->i2c, 3), 0x56, 8192);
+    at24c_eeprom_init_one(aspeed_i2c_get_bus(&soc->i2c, 3), 3, 0x56, 8192, 2);
 
     /* i2c-7 */
     i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 7), "pca9546", 0x70);
@@ -581,9 +581,9 @@ static void quanta_q71l_bmc_i2c_init(AspeedMachineState *bmc)
     /*        - i2c@3: pmbus@59 */
 
     /* PDB FRU */
-    at24c_eeprom_init(aspeed_i2c_get_bus(&soc->i2c, 7), 0x52, 8192);
+    at24c_eeprom_init_one(aspeed_i2c_get_bus(&soc->i2c, 7), 7, 0x52, 8192, 3);
     /* BMC FRU */
-    at24c_eeprom_init(aspeed_i2c_get_bus(&soc->i2c, 8), 0x50, 8192);
+    at24c_eeprom_init_one(aspeed_i2c_get_bus(&soc->i2c, 8), 8, 0x50, 8192, 4);
 }
 
 static void ast2500_evb_i2c_init(AspeedMachineState *bmc)

-- 
2.51.0.384.g4c02a37b29-goog


