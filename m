Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94AE606A31E
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 04:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=spacecubics-com.20260707.gappssmtp.com header.i=@spacecubics-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=aUYNX+wK
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWnF1-0002Pv-2N; Thu, 26 Nov 2026 23:07:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maxz@spacecubics.com>)
 id 1xWlTU-0001oh-Qy
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 21:14:10 -0500
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <maxz@spacecubics.com>)
 id 1xWlTS-0001Gu-RB
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 21:14:08 -0500
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-cdb2e0062bbso2960582a12.1
 for <qemu-devel@nongnu.org>; Thu, 26 Nov 2026 18:14:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=spacecubics-com.20260707.gappssmtp.com; s=20260707; t=1795745645;
 x=1796350445; darn=nongnu.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=V36/QCccPERYuJGvGmmznNPNi+22pIIOZJQylgbbt+o=;
 b=aUYNX+wKGv2BPBVahq0RjKsmQyYxzOl/8LDnAlth+Z6q6h62wba/+zSaYpnLb2So/7
 iFBzroW9ZWJLzz5BS4zkGFhvsz/K8DfnjQpSvYSYG3ft3DlVsCBnCbqJ0aTZVXUyKP5u
 6xr1hKpycJ8Ms+wE9Zu606IWZif9Q3VT/VvT0AghsHiGvoOiGljJOFWEugMgjyiJY8aN
 BHM971PRpc2fUWIh1IyMXUoeMV0pyNR1Ogx2+V1kjYy2xEdg9ddnqspMO86g8C3FiRy4
 zIdrnEs2dBV4QalUUnsM2TaTmVtep36LW9tn/IIZUphh4tq+6NBFQhdi6+dews0Ox9pp
 u1wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795745645; x=1796350445;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=V36/QCccPERYuJGvGmmznNPNi+22pIIOZJQylgbbt+o=;
 b=VCXsWj9yMbFMG1fvpzSbaVrLp0iGK1JtHvx2cemRqEpDRopiGmGWS+GERaB3O/OmCM
 x5RslETxPvFWHRx/qdVIwWZ5UJ5YJfrUBYhBmLpPRQ4wg1vLLxncOR/g9gj7mirFiWFG
 xwsHIFSxLUme+LfgAO18ynXf3pWZjvXZU42nulZLjMr1wMVUyIQXAt2MUQwAEaF+OUkY
 0r5TnTru5S9Apzb5KRgQ/Xz7lsIcXzIyb0fN045aNkm9Fh20Lrs2aJg4uzCzHJoP6Exy
 /G7EYKNGk+xOuv/4Ve/8Ajr/ql4WYFwW0vTZdIjMPzFHq++Ly0fzexND/v6unim/IBED
 uDgQ==
X-Gm-Message-State: APuU4Z/inzxSrvPLIypFD5dVdjj59vhgocR14Y/XUf5SDQFO8P5hjD1U
 mepJuyiLDs7HZsMmiLKUDbX2ngBqApzt+KfWTn1rnGfDXrhFNol9wMQZA6zPtcyM7zE=
X-Gm-Gg: AZFdTZc5kCjD1ZnFWVnqFIValmczmXseDReBcF2gtXPgej9m7Udm2SXIbECdgOPC69S
 m81A5tm0r/jdo+AyhNiduQvydkzbmdDQSHC5Lz7DQbielxIrfx5rlsOEfZIdOVQ4fpWAn82nGlg
 s1vCl7JjB5upuOKKwskr9pkKJdyW+lUth268neM4fl82kBjo+hntfM7yENxnjkg+hQjsa73jbvB
 vUKqXWUbuNM7rrRSWV2u61cf598LrqRdlYqjl0wXsCLtSQTfXQpnGOFUDE1ONnLOFScAZ6kMIgt
 qjygZjEtSGtryhazNViWCp8QaT0rtFYwB5jupw4GihMlTT59ryOZ8/8AB/eIFPB1EL7FNVivgOV
 k4A/sKq2nw0J3r7lPYGpChy6ODfuO39jzg9RKtOxTostBBYqWusX0FHzOpXyVifpZxbzt3LC5Td
 UGq4MRDPJg38DQVyvOTgJZMQsLeI1rVLQpydbQ0ngh4SwEqYO/3oVRn4FruHY1uyPRcc/ZaluoQ
 jiCNfXxfWj+pSv2nTZpXVfi8niwxPjCIWaeQqyD/p9Nn+7cftyxhrn8eq1oMThcp87HRRjBRkA+
 Vr85C0gPFE03HFsKsIMumSC4ilI5aBnL8gpf7HBcF4lKt/VvNHNWMEaWhdzfzYO8ZQ==
X-Received: by 2002:a17:90b:35c2:b0:3a8:c0cd:57f3 with SMTP id
 98e67ed59e1d1-3b41c8e0c7emr19549724a91.18.1795745644753; 
 Thu, 26 Nov 2026 18:14:04 -0800 (PST)
Received: from [127.0.0.2] (182-166-200-88f1.hyg1.eonet.ne.jp.
 [182.166.200.88]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b53479b149sm1368372a91.6.2026.11.26.18.14.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2026 18:14:04 -0800 (PST)
From: Maximilian Zimmermann <maxz@spacecubics.com>
Subject: [PATCH 0/3] hw/arm: Add Space Cubics SC-OBC Module A1 board
 support
Date: Fri, 27 Nov 2026 11:13:33 +0900
Message-Id: <20261127-add-scobc-a1-board-v1-0-b572280dcde1@spacecubics.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMwQrCMAyA4VcZORtYujFkryIe0jTV7LBKoyKMv
 bt1Hr/D/2/gWk0d5m6Dqm9zK2sDnTqQO683RUvNEPowEYUJOSV0KVGQCWPhmpDzMJD2mWQ8Qws
 fVbN9junl+re/4qLy/J1g379TGaY+dgAAAA==
X-Change-ID: 20261126-add-scobc-a1-board-af331e0f1c48
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org, 
 Maximilian Zimmermann <maxz@spacecubics.com>
X-Mailer: b4 0.15.2
Received-SPF: none client-ip=2607:f8b0:4864:20::52f;
 envelope-from=maxz@spacecubics.com; helo=mail-pg1-x52f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 26 Nov 2026 23:07:06 -0500
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
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The SC-OBC Module A1 is an on-board computer module for CubeSats made by
Space Cubics. Its processing system is implemented in an Artix-7 FPGA,
which hosts a Cortex-M3, 4 MiB of main memory (HRMEM) and a set of
peripherals. The module must be mounted on a base I/O board. This machine
only models the module and not the base I/O board.

The default FPGA image provided by Space Cubics contains so-called
mission bus peripherals, which are user definable via an FPGA image and
live in the range 0x5000_0000 to 0x6000_0000. This is the only image this
machine models.

The board is already commercially available and in upstream Zephyr
as scobc_a1. To make development and CI easier we want to add it to
upstream QEMU as well.

Currently only a small subset of hardware is modelled, mainly the CPU,
memory map + mirror, console UART and 6 mission bus UARTs. They are
register compatible with Xilinx UART Lite, hence the existing device
implementation is reused. Other devices are mapped as unimplemented
devices and are planned to be implemented in further patches.

The hardware is publicly documented and can be accessed via the
following links. The memory map and interrupt page are partly
in Japanese only at the moment, but should be understandable to English
speakers as well:
- https://docs.zephyrproject.org/4.5.0/boards/sc/scobc_a1/doc/index.html
- https://docs.spacecubics.com/scobc-a1/latest/key-specs
- https://docs.spacecubics.com/scobc-a1-ja/latest/fpga/memory_map
- https://docs.spacecubics.com/scobc-a1-ja/latest/fpga/interrupt
- https://spacecubics.com/en/products/scobc_a1/

I added a small functional test, checking that the provided Zephyr ELF
boots and "hello world" is printed. The ELF is an unmodified
samples/hello_world from Zephyr v4.5.0 and hosted on
downloads.spacecubics.com.

The board and possible future additions will be maintained by me.

Signed-off-by: Maximilian Zimmermann <maxz@spacecubics.com>
---
Maximilian Zimmermann (3):
      hw/arm: Add Space Cubics SC-OBC Module A1 board
      hw/arm/scobc_a1: Add mission bus UARTs
      tests/functional/arm: Add SC-OBC Module A1 test

 MAINTAINERS                           |   8 ++
 docs/system/arm/scobc-a1.rst          |  59 +++++++++++++
 docs/system/target-arm.rst            |   1 +
 hw/arm/Kconfig                        |   8 ++
 hw/arm/meson.build                    |   1 +
 hw/arm/scobc_a1.c                     | 151 ++++++++++++++++++++++++++++++++++
 tests/functional/arm/meson.build      |   1 +
 tests/functional/arm/test_scobc_a1.py |  30 +++++++
 8 files changed, 259 insertions(+)
---
base-commit: 6bf90d4fc5027567cb704d7888f5ec792b4ed75a
change-id: 20261126-add-scobc-a1-board-af331e0f1c48

Best regards,
--  
Maximilian Zimmermann <maxz@spacecubics.com>


