Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92EE2D42BB1
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2024 16:57:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAuBo-00031t-DN; Tue, 12 Nov 2024 11:56:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>)
 id 1tAuBm-00031Z-9Q; Tue, 12 Nov 2024 11:56:26 -0500
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>)
 id 1tAuBk-0000eB-Fn; Tue, 12 Nov 2024 11:56:26 -0500
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-2e30fb8cb07so4584349a91.3; 
 Tue, 12 Nov 2024 08:56:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731430582; x=1732035382; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
 bh=uEGLL8Osei+laAE+APczp24CjcUKSmexoRxy4mvuA2E=;
 b=m+lfOvEo28e1AHmGj+s63vSwSm/eAB5wk9TMg8NAjQsixQbALzx80tSimamStBrzae
 mQhtthCt5b0sq7eKN9cx+DxlR7ckr2ZGjXPFIqAXi4O9darSunF1uyLBDX1Gf+8Y4mCI
 WbKhVouUccVnW+bCchKNDZCIgkvXd4bSLjQluGWaKbr7Gtp0eBYeB3DTvnxPW9RCRTN7
 RKGd49v7S7D1kYnXJISoSwOLalVx078pJZgW9OCoqHagSDgQKA7YP09P3ywy2yEO8d+j
 bQQkswB5/cFPyzCNg3Q8KaFc518Q74TiX3e9v1mN+CHi23uRMalUSKwtNNyxNf9HMXJo
 LEWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731430582; x=1732035382;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uEGLL8Osei+laAE+APczp24CjcUKSmexoRxy4mvuA2E=;
 b=PNposEV118tud3KReQqzd9OVN+87vPRBEha4FuCpBIvL+Ug0IHIvmj0pGJEijIijgJ
 vjr90roVSiHkA/+zZKmM58DJeaKPvY+MllpSrSpwSRSfbhBUbJe9X39hsD5H7Lg2DFUb
 UN3iWb5CKjQbhIAd34kyaZyBGIHzEMipAQRtc3PIOsIxvM1yjcUnLzOcX5Fr2ZLvI2pD
 UxzK0ZlHXxg919UY3d21GvgY8SpXVzpR6wkreJof7XgXpobeQ554a7Q0wSX+7lRmtxfC
 PvIdgNzHMANV0xgEa9iYEVu0JU0NCqtklcoRo1KOYHRIpTwhDB50yRgP5SU22OFlS53x
 wMRg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXDgA+cqw3vCAHn1H0TmmoexO442rGx01ymE/xvfF3ygMLe2oZbI2fQBGHsymqrux89OrwGNq8Hog==@nongnu.org
X-Gm-Message-State: AOJu0Yx/p/jYK1Uq//Y+8UVluyiVxoEFe/rlbkr+GXy5YSMqOdIsEk/F
 qxWLrujSeuhu1rgve6lr17DYi9OsLIYHWOEDdxAhEhzW6PLUpXVkMMycyA==
X-Google-Smtp-Source: AGHT+IHzp7XLobraGv5WjQ290BNyQDvUv6yfIWfGHaO3fWJ48P64q1ScwKgCQbnAE7WlSXe+aPYETQ==
X-Received: by 2002:a17:90a:e7d0:b0:2d8:dd14:79ed with SMTP id
 98e67ed59e1d1-2e9e4c9e8cbmr4311335a91.31.1731430581638; 
 Tue, 12 Nov 2024 08:56:21 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e99a62d686sm12802939a91.52.2024.11.12.08.56.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Nov 2024 08:56:20 -0800 (PST)
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
Subject: [RFC PATCH 0/8] usb/uhci: Add UHCI sysbus support,
 and enable for AST machines
Date: Tue, 12 Nov 2024 08:56:09 -0800
Message-ID: <20241112165618.217454-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=groeck7@gmail.com; helo=mail-pj1-x102a.google.com
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

