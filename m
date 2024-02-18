Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1E39C5475B
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Feb 2024 13:18:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rbh2q-0004C7-QR; Sun, 18 Feb 2024 08:17:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1rbh2p-0004Ba-AY
 for qemu-devel@nongnu.org; Sun, 18 Feb 2024 08:17:23 -0500
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1rbh2n-0007vM-LZ
 for qemu-devel@nongnu.org; Sun, 18 Feb 2024 08:17:22 -0500
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-55f50cf2021so4711287a12.1
 for <qemu-devel@nongnu.org>; Sun, 18 Feb 2024 05:17:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708262238; x=1708867038; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8Bh5JWkARm7F+KGgyKASEzzRgeCfrtjvyMyrKpxULIs=;
 b=cCPzFhYUn2ji+UZFgvG5Ol2aCKiDKT0Zs0ZreHeTmhqYOae+J7zOamEe/R7TVtbjfm
 KZcavXAzxLLsq+X0+sZwD9scMmgiA4r/Tr07yeCK7CcON3zZjAcLfcq7SZGH9L0mbKou
 n1h/mdcKMtduea0rMeTC7kUwqvSlQHLJBaX3gSKArT+xWEojbyVPySu8IHvKAGn4cyl4
 BoV5943+Ilr77NaEF4Zm+rXsACGVQiwxBosWlt8QKwrPX/NEQ5E+pQ2GSGd/72gqMGLt
 pV+0/32dsY8ExDcrRoPQUIIJNq9NW7aQAMmCREs8UGY8PD5A3sP9N8He0B90GWRKnE03
 p6JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708262238; x=1708867038;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8Bh5JWkARm7F+KGgyKASEzzRgeCfrtjvyMyrKpxULIs=;
 b=XKQGH+0W7linAQ4Bv2xRQMbVeZWo0Fh/n3d0MwVxvlnjNhqcN9A55Eh2+a+Dyrtl2J
 LFvhODDMwA6GMwRzuIlPhFbE11EXmP/8zsuB7YEGK6XaPLRcq5QbkLcTNtpAz7llMomt
 jFFO33zxuB8bzfera1z/0U9tp2JuO4I0k233K6ZvJioNBo1kPziV3X3G2n5op2CFZXe9
 pUo6GRzGLs8AgD3deRQP8ePGjlqLXiQhv8nmr/dAC0ALU6Z+cXOdoNO8IZBiq0ju+6Tv
 MSHrDUgGfccNTy27pW/IZkpaX0CJDf+efWHocn+OviM5t+jQfLzFhxuISKwinamCPqYk
 b1xA==
X-Gm-Message-State: AOJu0YwgJqalEIUqEw+ZiRs1PnFvMPpBRC1bQe1czBmsA6U6YX0KoRzI
 w1zvIv4kunTdMmrTX7cEDuwxLH2x/p2EHHf3PB+4y5qPmROTeyE4g2ZCb+Wf
X-Google-Smtp-Source: AGHT+IHjIT/sxjPqS6XoxCBwzhl8QSw0QbQ/KlmVNcTUYkn1HbwNmk7XMys0hhpqyNkYVXWOlYPT3Q==
X-Received: by 2002:a17:906:b0c:b0:a3e:5b7f:6d31 with SMTP id
 u12-20020a1709060b0c00b00a3e5b7f6d31mr1247018ejg.5.1708262237854; 
 Sun, 18 Feb 2024 05:17:17 -0800 (PST)
Received: from archlinux.. (dynamic-078-054-149-080.78.54.pool.telefonica.de.
 [78.54.149.80]) by smtp.gmail.com with ESMTPSA id
 jw15-20020a170906e94f00b00a3e86a9c55asm255088ejb.146.2024.02.18.05.17.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Feb 2024 05:17:16 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH 5/5] hw/isa/vt82c686: Embed TYPE_PORT92
Date: Sun, 18 Feb 2024 14:17:01 +0100
Message-ID: <20240218131701.91132-6-shentey@gmail.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240218131701.91132-1-shentey@gmail.com>
References: <20240218131701.91132-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x530.google.com
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

Port 92 is an integral part of the south bridge, so instantiate it there.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/isa/vt82c686.c | 7 +++++++
 hw/isa/Kconfig    | 1 +
 2 files changed, 8 insertions(+)

diff --git a/hw/isa/vt82c686.c b/hw/isa/vt82c686.c
index aa91942745..c7b96b3133 100644
--- a/hw/isa/vt82c686.c
+++ b/hw/isa/vt82c686.c
@@ -22,6 +22,7 @@
 #include "hw/qdev-properties.h"
 #include "hw/ide/pci.h"
 #include "hw/isa/isa.h"
+#include "hw/isa/port92.h"
 #include "hw/isa/superio.h"
 #include "hw/intc/i8259.h"
 #include "hw/irq.h"
@@ -597,6 +598,7 @@ struct ViaISAState {
     uint16_t irq_state[ISA_NUM_IRQS];
     ViaSuperIOState via_sio;
     MC146818RtcState rtc;
+    Port92State port92;
     PCIIDEState ide;
     UHCIState uhci[2];
     ViaPMState pm;
@@ -619,6 +621,7 @@ static void via_isa_init(Object *obj)
     ViaISAState *s = VIA_ISA(obj);
 
     object_initialize_child(obj, "rtc", &s->rtc, TYPE_MC146818_RTC);
+    object_initialize_child(obj, "port92", &s->port92, TYPE_PORT92);
     object_initialize_child(obj, "ide", &s->ide, TYPE_VIA_IDE);
     object_initialize_child(obj, "uhci1", &s->uhci[0], TYPE_VT82C686B_USB_UHCI);
     object_initialize_child(obj, "uhci2", &s->uhci[1], TYPE_VT82C686B_USB_UHCI);
@@ -740,6 +743,10 @@ static void via_isa_realize(PCIDevice *d, Error **errp)
     }
     isa_connect_gpio_out(ISA_DEVICE(&s->rtc), 0, s->rtc.isairq);
 
+    if (!qdev_realize(DEVICE(&s->port92), BUS(isa_bus), errp)) {
+        return;
+    }
+
     for (i = 0; i < PCI_CONFIG_HEADER_SIZE; i++) {
         if (i < PCI_COMMAND || i >= PCI_REVISION_ID) {
             d->wmask[i] = 0;
diff --git a/hw/isa/Kconfig b/hw/isa/Kconfig
index f42a087c07..d94f58a2c1 100644
--- a/hw/isa/Kconfig
+++ b/hw/isa/Kconfig
@@ -66,6 +66,7 @@ config VT82C686
     select I8259
     select IDE_VIA
     select MC146818RTC
+    select PORT92
 
 config SMC37C669
     bool
-- 
2.43.2


