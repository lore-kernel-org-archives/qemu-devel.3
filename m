Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE966CF9C6F
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2024 10:18:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ssg7H-0001R8-8L; Mon, 23 Sep 2024 06:16:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1ssg7G-0001PW-5e; Mon, 23 Sep 2024 06:16:26 -0400
Received: from mail-lj1-x236.google.com ([2a00:1450:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1ssg7E-0003mk-AM; Mon, 23 Sep 2024 06:16:25 -0400
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2f75de9a503so36338331fa.0; 
 Mon, 23 Sep 2024 03:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727086581; x=1727691381; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=XmTbYRcHV1szwxyogdy38XkkEf7HJri9e6GOsnw70n4=;
 b=bi5WauPWSoxDz/O7U8SIuhTKuVhgcCNsxODuL2XhGQQ/bOc3pjPIYUSk/Enr8kCwJ2
 +reGYwVXMpAYl0GQqzUyGUsRxRU1RIARiNWZiJ+eyA07mpscyXcTsX2sE7iJWBn7mzz8
 TWQhLIqtKXZSuJ5Sa/cFFvtF6Y5EdCfToXGQv2U85KhbhVk2kAcBCYSTBz9oIh6teJsy
 OaATAupu4FGdmcFzZJ84nDcGFQAo/O5Hefmg+xqd6lsrNajDuK+AffAnxFXUmqWdK1RQ
 XgrpMBmLQn6XWcPC9Po/0Z0QvrckMygYJWqbUV5wfoVAqnu7MSeUrzI4fBOxIho1DQNc
 Vizw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727086581; x=1727691381;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XmTbYRcHV1szwxyogdy38XkkEf7HJri9e6GOsnw70n4=;
 b=M7gyKgtJoPOtD/TwCczv/cArSqkMcmDVWEo9/8ODzxEE1fARHA8JXhM2fsmkje8BGR
 aN2r0/DssrfHt8xAFVo9dcX3G5oudW1JkFVs+ffboIqPnz71I2WgTC2W/vxMbSKye0US
 8WlXy/9/AiJj+TdzjwOs4p7ncl83UeQh/4rxAVC8zd5G15SGJqNiVUdlwE6AYaCXDbaP
 Jx6i63NOJAJvS1vyS2Wo/gG1cEazBQKG1Uj4Lwt+XeNCIEYlZfIaVpJlaUXlWr3wUWHo
 VvJ2E9nXTEVIFGZu3ZZ5pARc63zTfhSTdTer7egEGpLl3o4zMCjWxi57LBIyvW1y2hSb
 OSMA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUftdsvgXiL5sBRVbuCUFuUiiOFNGznaMBYuD3LTg2pk9sWCNP1SaJfSdfFYE9lC5Nkbh8qGR8XMQ==@nongnu.org
X-Gm-Message-State: AOJu0YyQe9uLfE5d43ndVcgmV0rAJrYUCoF+1N+ypucJf49R046ErT6H
 Fn7bKPrWdiZKJTZ3GDQgiWHCah+tD9jNWwAInwt8GMRifpc+rQi796kxLg==
X-Google-Smtp-Source: AGHT+IEl3RLBf+T7KBeevSUObenHaaxKhemqRlAOTV4Kr5qpUk6fDFqTwxJijZdNsY5u/KwKJE1Ijw==
X-Received: by 2002:a05:6512:31d2:b0:536:536f:c663 with SMTP id
 2adb3069b0e04-536ac2e5296mr5676109e87.22.1727086581139; 
 Mon, 23 Sep 2024 03:16:21 -0700 (PDT)
Received: from archlinux.. (90-181-218-29.rco.o2.cz. [90.181.218.29])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a90610f43e9sm1187655566b.72.2024.09.23.03.16.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Sep 2024 03:16:20 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-ppc@nongnu.org,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH 0/3] Split TYPE_GPIOPWR and reuse in E500 machines
Date: Mon, 23 Sep 2024 12:15:51 +0200
Message-ID: <20240923101554.12900-1-shentey@gmail.com>
X-Mailer: git-send-email 2.46.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::236;
 envelope-from=shentey@gmail.com; helo=mail-lj1-x236.google.com
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

This series is part of a bigger series exploring data-driven machine creati=
on=0D
using device tree blobs on top of the e500 machines [1]. The idea is to=0D
instantiate a QEMU device model for each device tree node containing a=0D
compatible property. [1] achieves feature-parity with the hardcoded machine=
s=0D
when supplied the same device tree blob that the hardcoded machine would=0D
generate.=0D
=0D
Just like the ARM virt machine, the ppce500 machine implements a=0D
"gpio-poweroff"-compatible device tree node. Unfortunately, the implementat=
ion=0D
isn't shared which this series fixes. In order to reflect device tree which=
 has=0D
separate bindings for gpio-poweroff and gpio-reset, and to prepare for the=
=0D
above, the gpio-pwr device model is split.=0D
=0D
Note: If the split seems too fine-grained, the existing gpio-pwr device mod=
el=0D
could probably be reused in ppce500, too.=0D
=0D
Testing done:=0D
* Build qemu_ppc64_e5500_defconfig in Buildroot, run it in the ppce500 mach=
ine=0D
  and issue the `poweroff` command. Observe that QEMU is shut down cleanly.=
=0D
* ARM virt: How to test the secure path?=0D
=0D
[1] https://github.com/shentok/qemu/tree/e500-fdt=0D
=0D
Bernhard Beschow (3):=0D
  MAINTAINERS: Add hw/gpio/gpio_pwr.c=0D
  hw/gpio/gpio_pwr: Split into separate gpio_poweroff and gpio_restart=0D
    devices=0D
  hw/ppc/e500: Reuse TYPE_GPIO_POWEROFF=0D
=0D
 MAINTAINERS             |  2 ++=0D
 hw/arm/virt.c           | 32 +++++++++++++------=0D
 hw/gpio/gpio_poweroff.c | 51 ++++++++++++++++++++++++++++++=0D
 hw/gpio/gpio_pwr.c      | 70 -----------------------------------------=0D
 hw/gpio/gpio_restart.c  | 51 ++++++++++++++++++++++++++++++=0D
 hw/ppc/e500.c           | 15 ++-------=0D
 hw/arm/Kconfig          |  3 +-=0D
 hw/gpio/Kconfig         |  5 ++-=0D
 hw/gpio/meson.build     |  3 +-=0D
 hw/ppc/Kconfig          |  1 +=0D
 10 files changed, 138 insertions(+), 95 deletions(-)=0D
 create mode 100644 hw/gpio/gpio_poweroff.c=0D
 delete mode 100644 hw/gpio/gpio_pwr.c=0D
 create mode 100644 hw/gpio/gpio_restart.c=0D
=0D
-- =0D
2.46.1=0D
=0D

