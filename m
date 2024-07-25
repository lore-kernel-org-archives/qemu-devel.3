Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7856FC3DA49
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2024 00:01:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sX8KK-0007zR-Ir; Thu, 25 Jul 2024 19:56:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sX8KF-0007cF-5u; Thu, 25 Jul 2024 19:56:47 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sX8KD-0001BJ-5I; Thu, 25 Jul 2024 19:56:46 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-6e7e23b42c3so311684a12.1; 
 Thu, 25 Jul 2024 16:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721951803; x=1722556603; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4yMi6In23P6bInFXkhc2m7lENqnlPytoZ2pAkbCQpwc=;
 b=mJTCm+CKzVZy5AG6lJYLt7AXFT0OYIxq2R65nMK9SxnG7WbABQRSGjnyK9sWEAm6Wg
 8j/cIsZx4DHjWPyft0/qyNwHUbtrJOtVJjVa3xedAvbYmatYJepxCyxUW2EvHSwJwVZw
 2mVyAd7dhv8dHPH/1+cd/HYVPEF9m2InRP0VgQj62WUCVml3oOpEn1NA9Byv0V8umpOY
 cwRVj5gwSno+WAwlpjUuIq6Trlhn/c5vj1NoBqzj2v3iT4ressIgsGpq5VDLSG3DZend
 y696aGgSBK9Ic2OwiBvXxlMYZfeVpHiBontJYDlqFopdMK+OnB3RtsTQyZLoCwGhC+l/
 v7sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721951803; x=1722556603;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4yMi6In23P6bInFXkhc2m7lENqnlPytoZ2pAkbCQpwc=;
 b=AAjzz4hqJhSfviOdnaBAtqNpQ/KkKu+gMqPisoCdLNpW4sESc25cE6hKHtGsf4cLrx
 fBxzPV/Y8ddZllyf1GHYKhDGlTTtVvaLjcsp5+2avMu6WICWoaj3TayC3WBwm+6lGjrm
 6EDuitT4bJmT/4cm//gmGIFz83OlEsXbR4r2XlNPoM3H5IMtDxZ9HSvpclKQGGBI5XxK
 anE0iBjk1YqtPTzNX1nSoIfDGXhmlG9bQS9lKLuyQVGt3RJ0J62AcuXN89R4CEQRcOt+
 rM2WsWKqNn+098/NB6+kDpguEu/N0DKK5Pe0Ypaesfje7Vjep4gjUCfiwnXMGK1RmL27
 K1/w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXtmRIJ0Yq1efXoG9Ussq82a3ifd0X2XIwnE0J2NFplTVhFbrCngxNj0Doo1AcZ57+BkZQPmFzu8Rzj8YbtXqi8uct4
X-Gm-Message-State: AOJu0YxigIU+rh63hRF5JPf9A/57dtIfl2nBgblfam/266HNoBSu+kU5
 Hp6OFYBD64or+IgF+KJ1N7g0VewhgqSnYpYfZaKCWXDqnx5ZBQRVR6JuGw==
X-Google-Smtp-Source: AGHT+IE2z5ZUrcCk1mtoaPnuL5ScgZXPvZHKViXwY33mrKoWZI3wewByO4RllBMxQoGmfdmxBUOjpQ==
X-Received: by 2002:a17:90b:1d88:b0:2c9:5fae:4f7e with SMTP id
 98e67ed59e1d1-2cf237b7a61mr4849446a91.16.1721951803162; 
 Thu, 25 Jul 2024 16:56:43 -0700 (PDT)
Received: from wheely.local0.net ([203.220.44.216])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2cf28c7fef3sm2142060a91.16.2024.07.25.16.56.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 16:56:42 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Chalapathi V <chalapathi.v@linux.ibm.com>,
 Glenn Miles <milesg@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PULL 39/96] hw/block: Add Microchip's 25CSM04 to m25p80
Date: Fri, 26 Jul 2024 09:53:12 +1000
Message-ID: <20240725235410.451624-40-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240725235410.451624-1-npiggin@gmail.com>
References: <20240725235410.451624-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x52c.google.com
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

From: Chalapathi V <chalapathi.v@linux.ibm.com>

Add Microchip's 25CSM04 Serial EEPROM to m25p80.  25CSM04 provides 4 Mbits
of Serial EEPROM utilizing the Serial Peripheral Interface (SPI) compatible
bus. The device is organized as 524288 bytes of 8 bits each (512Kbyte) and
is optimized for use in consumer and industrial applications where reliable
and dependable nonvolatile memory storage is essential.

Signed-off-by: Chalapathi V <chalapathi.v@linux.ibm.com>
Reviewed-by: Glenn Miles <milesg@linux.ibm.com>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/block/m25p80.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
index 9e99107b42..0b94af3653 100644
--- a/hw/block/m25p80.c
+++ b/hw/block/m25p80.c
@@ -357,6 +357,9 @@ static const FlashPartInfo known_devices[] = {
       .sfdp_read = m25p80_sfdp_w25q512jv },
     { INFO("w25q01jvq",   0xef4021,      0,  64 << 10, 2048, ER_4K),
       .sfdp_read = m25p80_sfdp_w25q01jvq },
+
+    /* Microchip */
+    { INFO("25csm04",      0x29cc00,      0x100,  64 << 10,  8, 0) },
 };
 
 typedef enum {
-- 
2.45.2


