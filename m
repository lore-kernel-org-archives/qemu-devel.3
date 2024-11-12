Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4935D42BB4
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2024 17:03:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAuHW-0003C5-Gz; Tue, 12 Nov 2024 12:02:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>)
 id 1tAuHT-00033D-TT; Tue, 12 Nov 2024 12:02:19 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>)
 id 1tAuHR-0001S5-Rq; Tue, 12 Nov 2024 12:02:19 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-20c805a0753so57826865ad.0; 
 Tue, 12 Nov 2024 09:02:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731430935; x=1732035735; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
 bh=wpdtWALVC9Zb2PdRWt2qNAXWCEw8toj+5ihbBNs4L+s=;
 b=Fl5jmXACZ09kz/9C2J51oZABCi+n2MzPqvqkeRXb4ouIfLFFBWfwDNNf4PRwf6lZpS
 lmElNl36E0dMy2GtWLGMZ8mjDTEuvRbdE3Ydf3lv7TZf1JIbFW5K/lUDOj70aO42L7gF
 uue8H8WjC1q0G/eepJmqmllPX5ucynMLeHIRoij54yNhXLtZA4u11afAWe0/EfW1cOTF
 RSeEALVnI9vkd/Qr+nDKMK8CiWqLxPB9RINNj0Q+3iBFAUslc3lPSKj8VaMKSe6kB98y
 n5Uhpfxu6cnzN3G+juo89/eHI8ksVXv8JtD9sg0zS203othkfgsjWrsFZmfHdPL9qz2X
 pjdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731430935; x=1732035735;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wpdtWALVC9Zb2PdRWt2qNAXWCEw8toj+5ihbBNs4L+s=;
 b=JcJro1glp6wNfjeExGcdGxEp9pA+pEHzFxE35RYZtv6Y1cc/c6Ln0aoU/m1K1CVEB1
 uWGtWUPDXmX8BA34CJZNInEiIV8bhYt1Iu8MlMQpNbWKjfRmL0cpSRuFC1ZZka5wJbq0
 nEg0O8rDooCjq8PVBCGohJKIqdDJL7M7RjX/hRMxkogTZUqWPrRJFtuqcrjPOkvfpE+f
 iOBV/qkP8C6+0ObsIfPCXDSugeuxFIY6Fxc20Xh9QcdQy6owCDV7dg4zbjSYFonnTvsQ
 TpyVOzDl/sV9XwGAtuOREUNSJWmYmR3TJTHrxt27qu6P4pv2Spq/AJ2E+9BUCojC5RWV
 aNeA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWnVLHlJzkFK2mCwUaH42PDSA7vGFRnMSfhEgUYus/q0Ewvi2rbserQD5f4kQNnW4kBJDOP62tQDg==@nongnu.org
X-Gm-Message-State: AOJu0Yx4B+NmGC3TdTkS6Oc7nUCIICmTTfl/jwLqpKewR9AUhrcApLdz
 WPGfSQW9PWhE0SlhYkGeeq/6hFJEq98m0Lm29B3o8tiP7MK8GDuslf3ILA==
X-Google-Smtp-Source: AGHT+IG/ORwbK65igUBzGjTHGEh9pdDgnL0bvgAATdJH/E4fvbmwVV/nbtIzZQ1eD6x4eFf395MTgA==
X-Received: by 2002:a17:902:f541:b0:20d:1866:ed6f with SMTP id
 d9443c01a7336-21183ccf11bmr232226175ad.4.1731430934730; 
 Tue, 12 Nov 2024 09:02:14 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21177e5c3eesm96448055ad.216.2024.11.12.09.02.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Nov 2024 09:02:12 -0800 (PST)
From: Guenter Roeck <linux@roeck-us.net>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, BALATON Zoltan <balaton@eik.bme.hu>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-arm@nongnu.org, Guenter Roeck <linux@roeck-us.net>
Subject: [RESEND PATCH 00/10] usb/uhci: Add UHCI sysbus support,
 and enable for AST machines
Date: Tue, 12 Nov 2024 09:01:42 -0800
Message-ID: <20241112170152.217664-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=groeck7@gmail.com; helo=mail-pl1-x630.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

[ Trying again, with updated subject ]

Some machines (like Aspeed ARM) only support a sysbus UHCI controller.
The current UHCI implementation in qemu only supports PCI based UHCI
controllers.

This patch series separates basic and PCI functionality from the hcd-uhci
implementation and then adds uhci-sysbus support. This is then used
to implement and enable sysbus based UHCI support for Aspeed machines.

The series is submitted as RFC since I am quite sure that I didn't get
everything right. All code surrounding VMStates deserves special scrutiny,
as well as the changes outside hw/usb/ and hw/arm/.

A side effect of this patch series is that Aspeed AST2400/2500 machines
will now instantiate UHCI, even if the machine does not actually support
it (it also always instantiates both EHCI ports, so that is not really
different). This means that the default USB bus is now the UHCI bus,
not the second EHCI bus. The bus number must therefore now be specified
explicitly when attaching a device unless attaching it to the UHCI port
is ok. I don't know if it is possible to avoid that and to ensure that
the default USB port is still the second EHCI port.

The code was tested on x86 machines to ensure that the existing UHCI
implementation still works. It was also tested on various Aspeed machines
with enabled UHCI ports (ast2500-evb, ast2600-evb, and rainier-bmc).

Changes since RFC:
- Rebased to v9.1.0-1673-g134b443512
- Added Reviewed-by: tags
- Fixed bug in interrupt initialization of vt82c686-uhci-pci.c
  which if instantiated caused a machine crash
- Instantiate UHCI controllers as companion devices on AST2600 machines

----------------------------------------------------------------
Guenter Roeck (10):
      usb/uhci: checkpatch cleanup
      usb/uhci: Introduce and use register defines
      usb/uhci: Move PCI-related code into a separate file
      usb/uhci: enlarge uhci memory space
      usb/uhci: Add support for usb-uhci-sysbus
      usb/uhci: Add aspeed specific read and write functions
      aspeed: Add uhci support for ast2600
      aspeed: Add uhci support for ast2400 and ast2500
      usb-hub: Add support for v2.0 hubs
      usb-hub: Fix handling port power control messages

 hw/arm/Kconfig                |   1 +
 hw/arm/aspeed_ast2400.c       |  14 ++
 hw/arm/aspeed_ast2600.c       |  20 +++
 hw/isa/Kconfig                |   4 +-
 hw/isa/vt82c686.c             |   4 +-
 hw/usb/Kconfig                |  10 +-
 hw/usb/dev-hub.c              |  85 ++++++++++-
 hw/usb/hcd-uhci-pci.c         | 255 ++++++++++++++++++++++++++++++++
 hw/usb/hcd-uhci-pci.h         |  63 ++++++++
 hw/usb/hcd-uhci-sysbus.c      | 202 +++++++++++++++++++++++++
 hw/usb/hcd-uhci-sysbus.h      |  34 +++++
 hw/usb/hcd-uhci.c             | 337 +++++++++++++-----------------------------
 hw/usb/hcd-uhci.h             |  30 ++--
 hw/usb/meson.build            |   2 +
 hw/usb/vt82c686-uhci-pci.c    |  18 +--
 include/hw/arm/aspeed_soc.h   |   3 +
 include/hw/southbridge/piix.h |   4 +-
 include/hw/usb/uhci-regs.h    |  11 ++
 18 files changed, 822 insertions(+), 275 deletions(-)
 create mode 100644 hw/usb/hcd-uhci-pci.c
 create mode 100644 hw/usb/hcd-uhci-pci.h
 create mode 100644 hw/usb/hcd-uhci-sysbus.c
 create mode 100644 hw/usb/hcd-uhci-sysbus.h

