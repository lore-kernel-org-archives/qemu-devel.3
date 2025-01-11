Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56B06E7719A
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jan 2025 18:39:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWgMR-00070x-Sw; Sat, 11 Jan 2025 13:37:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tWgMP-000709-N2; Sat, 11 Jan 2025 13:37:25 -0500
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tWgMO-0003tp-41; Sat, 11 Jan 2025 13:37:25 -0500
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-aaf3c3c104fso528238566b.1; 
 Sat, 11 Jan 2025 10:37:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736620640; x=1737225440; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=RoziYUKRnYnrxagpLXRXx22rtFkGtEbmADAZ6jidbtg=;
 b=OwvfuzPOdQZHszqMwynIoTfA5qlgqfi18H4oJHmJX/Si2+7/Q5JymMjJX0A9myT8c/
 hOG47uVlsaV/OC0ffVMs96c8uVBBMS/Dm4hSqAP3+Cvl9MSrH2foKDk4/43mbZeZxNx3
 hnRfyssQE9vU7FktVu7wMLsrNMSHhGLS1wK3rvDkkC+pyLvNJEB79FU0CAtR3OWfmdHT
 vQh7XeA8UDWk9PYD9Np+fMbPfmLsSkCMqA0KbZvapZPbm1367dvKEIaD88VjXOtAQkps
 IJHhnU1wo4hmG9FM7+6ix2OY/FhueDpW/BVLG1LQTCGhTVBX+0XgDtbKqrq81PAqDsG7
 bU7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736620640; x=1737225440;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RoziYUKRnYnrxagpLXRXx22rtFkGtEbmADAZ6jidbtg=;
 b=jaQ06C8grMurkfOMiu3V5K6fq5ZQ29gqsqvIdfwnwimEkSwnpGAGhGa8nw/4CuXFqH
 o/gdlqE+AtZhNB3bPvpUGUfskzqJ6+qhwl5DTUjLDftzqQH3WTBH2b6yhmGC7AbuhUOZ
 I11tA52blj9SjZFQkCAELYZroJPyAQsQa+bILDlND3rinufsKdThzTkjgwwFW2vGaxQ8
 IcZOfaMesUFZDZxgePDbxXnF0geJn1Dsqc84AbLpT2mlXdBOI27d8soAoVUC4D7WhFZi
 udQlNv0hM/p8lnAESE/8EQlKKuA0mSuY5bw8JpzwvpGBAAIhwVEVQD4XPMcQspd4cmtu
 tThQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU1miFvCSJe7XZHiZKO17GH3HtuTXj+fg3re31XwQJ+FKdXp0MqC+5EO3c9P8mwIVi6LL1oUiS6aQZUyw==@nongnu.org,
 AJvYcCUDjKCN4roJVOpY4LB6vJV9+BsuNPz4ia3dcjyKOKkkmls+KOZdHMv+QhrD8agVRrrISvM+EWFqNg==@nongnu.org
X-Gm-Message-State: AOJu0Yyp20mbCpS7c1MckK3fOGUCC7/80dXiUp6YyAYwr54WIoNNRx97
 dHkXD/KH7Rnodd9ripNUG745bclvLFniHRpLElfInwtNc8iDjVMDU9KNIg==
X-Gm-Gg: ASbGncuTj0A1wxbAgPANhV7XEcQatESzH/SCaEXwABfLcKgJKwI0bG54SNSbW8x3K/I
 Z+UembypqamE49nGK8DZEjJcOo6Y52Y1uRP+zecUkRb4Mn/KjeSv2OeyPpZkf2yGxhCCY3fCMCX
 J3fiiWd6qjTWqhj3wYvT0yPfdz1qw8JnDWdd0hJF5IizTSFufJb9L4Pl90LnPpNeT/+7j2mcTl2
 EgUDIOFuFp/PzTknwPDnQ4rsQAcnJKibcV/8mxfpTtHmscyv6IufGuX40Rfi4btz9fYr6WwpG2M
 3Zjx76Qa8ZKCB6UaWChsVJt+yAnv+XEKlsJX8ztC9D8=
X-Google-Smtp-Source: AGHT+IEo9jM0CqOrvAxD15rCaGEwbz1WfiRt4FyB7MwtqZHr62JhXzdLVkhTU8qGvPTX3xt/mcmZAQ==
X-Received: by 2002:a17:907:6d23:b0:aae:a087:f972 with SMTP id
 a640c23a62f3a-ab2ab16b1d6mr1255846866b.11.1736620639504; 
 Sat, 11 Jan 2025 10:37:19 -0800 (PST)
Received: from Provence.localdomain
 (dynamic-078-054-101-099.78.54.pool.telefonica.de. [78.54.101.99])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab2c95af187sm299026666b.142.2025.01.11.10.37.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Jan 2025 10:37:19 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Guenter Roeck <linux@roeck-us.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Andrey Smirnov <andrew.smirnov@gmail.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Laurent Vivier <lvivier@redhat.com>, Bin Meng <bmeng.cn@gmail.com>,
 qemu-block@nongnu.org, Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v2 00/13] i.MX and SDHCI improvements
Date: Sat, 11 Jan 2025 19:36:58 +0100
Message-ID: <20250111183711.2338-1-shentey@gmail.com>
X-Mailer: git-send-email 2.48.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x632.google.com
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

This series fixes some details in i.MX platform devices, improves SDHCI=0D
compatibility with U-Boot and modernizes some code.=0D
=0D
The first 5 patches are bugfixes 1/ resolving infinite loop in U-Boot esdhc=
=0D
driver, 2/ fixing a character echoing issue in imx-serial, 3/ fixing IRQ sh=
aring=0D
issue in Designware PCIe emulation, and 4/ fixing GPIO level preservation a=
cross=0D
resets in imx-gpio.=0D
=0D
Patches 6 and 7 modernize SD card emulation by turning presence and=0D
write-protect GPIOs into qdev GPIOs and then further allowing the GPIOs to =
be=0D
inverted, just like device tree allows.=0D
=0D
The rest of the series is cosmetics including turning DPRINTF() into trace=
=0D
events which eases debugging.=0D
=0D
v2:=0D
* Drop redundant implementation of TYPE_OR_IRQ (David, Zoltan)=0D
* Use absolute QOM paths when tracing in imx_gpio and imx_i2c (Phil)=0D
* Trace hexadecimal values in imx_serial (Phil)=0D
* Do NOT move inversion of presence and write-protect GPIOs since that chan=
ges=0D
the internal logic of the device=0D
=0D
Bernhard Beschow (13):=0D
  hw/sd/sdhci: Set SDHC_NIS_DMA bit when appropriate=0D
  hw/char/imx_serial: Fix reset value of UFCR register=0D
  hw/char/imx_serial: Update all state before restarting ageing timer=0D
  hw/pci-host/designware: Expose MSI IRQ=0D
  hw/gpio/imx_gpio: Don't clear input GPIO values upon reset=0D
  hw/sd/sd: Remove legacy sd_set_cb() in favor of GPIOs=0D
  hw/sd/sd: Allow for inverting polarities of presence and write-protect=0D
    GPIOs=0D
  hw/char/imx_serial: Turn some DPRINTF() statements into trace events=0D
  hw/timer/imx_gpt: Remove unused define=0D
  tests/qtest/libqos: Reuse TYPE_IMX_I2C define=0D
  hw/i2c/imx_i2c: Convert DPRINTF() to trace events=0D
  hw/misc/imx6_src: Convert DPRINTF() to trace events=0D
  hw/gpio/imx_gpio: Turn DPRINTF() into trace events=0D
=0D
 include/hw/arm/fsl-imx6.h                  |  4 +-=0D
 include/hw/arm/fsl-imx7.h                  |  4 +-=0D
 include/hw/char/imx_serial.h               |  2 +-=0D
 include/hw/pci-host/designware.h           |  1 +=0D
 include/hw/sd/sdcard_legacy.h              |  1 -=0D
 hw/arm/fsl-imx6.c                          | 13 ++++-=0D
 hw/arm/fsl-imx7.c                          | 13 ++++-=0D
 hw/char/imx_serial.c                       | 65 ++++++++++++++--------=0D
 hw/gpio/imx_gpio.c                         | 19 +++----=0D
 hw/i2c/imx_i2c.c                           | 21 ++-----=0D
 hw/misc/imx6_src.c                         | 23 ++------=0D
 hw/pci-host/designware.c                   |  7 +--=0D
 hw/sd/sd.c                                 | 39 ++++++-------=0D
 hw/sd/sdhci.c                              | 11 +++-=0D
 hw/timer/imx_gpt.c                         |  4 --=0D
 tests/qtest/libqos/arm-imx25-pdk-machine.c |  5 +-=0D
 tests/qtest/libqos/i2c-imx.c               |  4 +-=0D
 hw/arm/Kconfig                             |  2 +=0D
 hw/char/trace-events                       |  5 ++=0D
 hw/gpio/trace-events                       |  5 ++=0D
 hw/i2c/trace-events                        |  5 ++=0D
 hw/misc/trace-events                       |  6 ++=0D
 22 files changed, 151 insertions(+), 108 deletions(-)=0D
=0D
-- =0D
2.48.0=0D
=0D

