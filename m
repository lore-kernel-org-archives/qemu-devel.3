Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F225DC52D7F
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2024 18:18:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1seIXQ-0005Om-Re; Wed, 14 Aug 2024 14:16:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1seIXL-0005CF-Iu; Wed, 14 Aug 2024 14:15:55 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1seIXJ-0000Bq-Lj; Wed, 14 Aug 2024 14:15:55 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-367963ea053so123367f8f.2; 
 Wed, 14 Aug 2024 11:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723659351; x=1724264151; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pgBwQcTsY5kig6ob6QbX8yg1wENWhX6GNFsHsRJ5hkg=;
 b=geKisHJU+JXMwAG6C4BTlrnuawxFB9ezTbXMCKR1WUz4aKGrOuR4wwPGvTsIYolqAP
 yK097NWXc6fdGzZN4/N+/v1z5gdGcafhURNVAaFwVz73X6wlv3QEX8IMhuI9Ta/EfAUU
 Rh07XJOOgGYNyRKvCUHwNgED2wF8yPRf08jCQVKSYF/Yk6FUqLV8CtGRufT3JVZnOz9r
 JzUCIEIWsECq+jEEoOKW8IvBO3Y/+2/LUqaBFRvtmf8zp4/Aj1PeLBdyyT0G5D7eCdF0
 Rmst1Qc4/yLGLoxFsmpGnEAAw7zN0RgwNypH5u/09JTipwCpGsnnr6ZlUBS05DINfm2m
 hpUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723659351; x=1724264151;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pgBwQcTsY5kig6ob6QbX8yg1wENWhX6GNFsHsRJ5hkg=;
 b=VoRQgn9nrFWIbiOctRkoP0Lqw5d8C14WC52fmAweW4w/hrfi4SCJj0PEjjP8zkUuxF
 tLFnWEggtLZKwbNYvKN+qO7xkms3x4ueFWc49bYfxqAzsns6yeg29BhIPwFAbi3igPkr
 J7mPkvacrhWzxi/ElWB74i3BDRjVRUVNsXH9XyXT11QI6nE65yr2xqxkGNU/5rBQrR5o
 MYp5qzx/W0+z58qSZkFo0tb5eXIdMKYahqHfN2dU6/naT+L5GtLoAAahC2z1J4H5ri9u
 gnhLHmWYXNSmulYNwlOV1qjscK95WcPG+qv2Up+45PSM60w3Z3n5oQN4c2pnyLO41g0x
 MAfQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWHFUsAoeSgS89RMqKyHIk2q6H+WCeoTpUog+hMfJzJHUrDK0kRuQQuCztxzwuDnl77V1dGYKUgxAgJpTA7u2n4+G7Ol1xgK4Fu1DsbI2fyNboHIB9VEyGrF93WIkHXY2n+FA3X7aDOW4yhxMEG3h8=
X-Gm-Message-State: AOJu0YysjUwqvfj5R2yiEdxTnq/sU0eoTZSmugCYZLZbb/V6HB+xmKDr
 yQhhZWANcTzQaz8u7BqsXkAS1hElbVgShSJKUBDu7R/r/DzPv6SrBuQrUA==
X-Google-Smtp-Source: AGHT+IFX9LTvjT3b7ve5IYdfE3ktHjzApsErplWUB3VfLFvs2c4uwvRGIPQi/aciDQ8IYA5f6LLZ3A==
X-Received: by 2002:adf:f4cf:0:b0:371:869b:4e5e with SMTP id
 ffacd0b85a97d-371869b4f83mr478621f8f.1.1723659350403; 
 Wed, 14 Aug 2024 11:15:50 -0700 (PDT)
Received: from Provence.localdomain
 (dynamic-078-055-049-243.78.55.pool.telefonica.de. [78.55.49.243])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36e4c937bb9sm13557625f8f.34.2024.08.14.11.15.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Aug 2024 11:15:50 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, Bin Meng <bmeng.cn@gmail.com>,
 Paul Burton <paulburton@kernel.org>, Stafford Horne <shorne@gmail.com>,
 qemu-ppc@nongnu.org, Tyrone Ting <kfting@nuvoton.com>,
 Joel Stanley <joel@jms.id.au>, Eduardo Habkost <eduardo@habkost.net>,
 Sergio Lopez <slp@redhat.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Hao Wu <wuhaotsh@google.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, Jan Kiszka <jan.kiszka@web.de>,
 Beniamino Galvani <b.galvani@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Jia Liu <proljc@gmail.com>,
 Helge Deller <deller@gmx.de>, Max Filippov <jcmvbkbc@gmail.com>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Steven Lee <steven_lee@aspeedtech.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Huacai Chen <chenhuacai@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>, qemu-arm@nongnu.org,
 Aleksandar Rikalo <arikalo@gmail.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 qemu-riscv@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Song Gao <gaosong@loongson.cn>, Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH 2/5] hw/char/serial: Remove unused funtion
Date: Wed, 14 Aug 2024 20:15:31 +0200
Message-ID: <20240814181534.218964-3-shentey@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240814181534.218964-1-shentey@gmail.com>
References: <20240814181534.218964-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=shentey@gmail.com; helo=mail-wr1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The serial port's frequency is set via the "baudbase" property nowadays.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 include/hw/char/serial.h | 2 --
 hw/char/serial.c         | 7 -------
 2 files changed, 9 deletions(-)

diff --git a/include/hw/char/serial.h b/include/hw/char/serial.h
index 6e14099ee7..40aad21df3 100644
--- a/include/hw/char/serial.h
+++ b/include/hw/char/serial.h
@@ -93,8 +93,6 @@ struct SerialMM {
 extern const VMStateDescription vmstate_serial;
 extern const MemoryRegionOps serial_io_ops;
 
-void serial_set_frequency(SerialState *s, uint32_t frequency);
-
 #define TYPE_SERIAL "serial"
 OBJECT_DECLARE_SIMPLE_TYPE(SerialState, SERIAL)
 
diff --git a/hw/char/serial.c b/hw/char/serial.c
index d8b2db5082..6c5c4a23c7 100644
--- a/hw/char/serial.c
+++ b/hw/char/serial.c
@@ -951,13 +951,6 @@ static void serial_unrealize(DeviceState *dev)
     qemu_unregister_reset(serial_reset, s);
 }
 
-/* Change the main reference oscillator frequency. */
-void serial_set_frequency(SerialState *s, uint32_t frequency)
-{
-    s->baudbase = frequency;
-    serial_update_parameters(s);
-}
-
 const MemoryRegionOps serial_io_ops = {
     .read = serial_ioport_read,
     .write = serial_ioport_write,
-- 
2.46.0


