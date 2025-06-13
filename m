Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05C90C61CE8
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Jun 2025 00:04:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPru7-0005lV-Iu; Thu, 12 Jun 2025 20:04:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3_GpLaAcKCkkvzxwzotrzzrwp.nzx1px5-op6pwyzyry5.z2r@flex--komlodi.bounces.google.com>)
 id 1uPru5-0005kp-FA
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 20:04:17 -0400
Received: from mail-pl1-x64a.google.com ([2607:f8b0:4864:20::64a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3_GpLaAcKCkkvzxwzotrzzrwp.nzx1px5-op6pwyzyry5.z2r@flex--komlodi.bounces.google.com>)
 id 1uPru3-0000W8-Ir
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 20:04:17 -0400
Received: by mail-pl1-x64a.google.com with SMTP id
 d9443c01a7336-23494a515e3so11681865ad.2
 for <qemu-devel@nongnu.org>; Thu, 12 Jun 2025 17:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1749773053; x=1750377853; darn=nongnu.org;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=xHB2wVr9eppzOj+XqM7fXd+adiP1FJb4VBsiDTWY/A0=;
 b=V/D/0zDITYOFsoHmQjHgI9ZOVF6aHacONn5OmHx3kjimRqb/US1ZRYiYDuGzKYXtVu
 Qb85eC7nFHX/tJTNduJqDjYg88LRaaIIYtmK4JeuIjkkM0K6G4op+F1cRKzb6OiLW3OV
 BTb8efCd6P6gnWYJPh6lw/EJI4yH08+0B5RhVVOBvVQGN80rLxIiL3xLvHTdJezy0t0S
 g2ZyF/OtbvevO5rWvqC7cIxcbYJv6irMsekDJ5BE48DAHzCtGauaQFS2kesGVa7pV1I+
 cOEkY/x1C7GiBYVFobk/G27WfRjj061NO1fNlrOOvQoFbuMooaprnEZGAppkPu/Cf367
 2mKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749773053; x=1750377853;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xHB2wVr9eppzOj+XqM7fXd+adiP1FJb4VBsiDTWY/A0=;
 b=uuPKa9UCepG8aiXei8SUOm4ZyJH45r7PqfZvfZK9/2MQnNmwvcTDLJyRGb/TYvwqvM
 Koy7/pGwjo/FD35RYwq0PlYw9jlVaP9nKUG54Ys+RGUFGC761ccn/ToN0iKU3862H9ze
 aNzie/ZCebdBCGSG1mkuF+eE00dapEq4SM7ugcStXhpWHHBW0JSdcGFSKQ3SJ9pekDSv
 1b6fDjDdIon82BsnQbGqCQVb/C+E+eUfYd3R9Nk/oau67RS2LXR7uOTC1uHTklpOdwYi
 a1ipxBHRHfu5eruuQNn3kuiaEnY2MvbZJ0wGvKo78+0P8S/+R+qxd5nunKk+pkh2lkVZ
 Hzaw==
X-Gm-Message-State: AOJu0YwDnuuY0CmrdaI6COgED4tnyexvh/D6gAdqxaJ2UPNOzQvp/F84
 j65lMI6E4J64JR5XytOiUKPw6fJ4ICDDXEqgeIbplHZGK607qxpDuQc8/zuDpmBI6nC+S5tyhy/
 74Bm6kuXzsQ5aN1aiVHynSitgbnWHJ7yrPIhYFwjxs5n5StopkxifGUeoWNKxBCdPfSk7VFyknH
 nsbU2y8kAoaoygIbN+O2MA3CcGVRsypmcTOQS8hz3G
X-Google-Smtp-Source: AGHT+IE6ndQiMaHn7pAdm/SU/4eJErbXozzEt1eONvXWy6iUY8ognuK8x0obBDVuKRiuhK4/vNFgdTBdP94k
X-Received: from pgbda7.prod.google.com ([2002:a05:6a02:2387:b0:b2c:4fcd:fe1b])
 (user=komlodi job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:e84e:b0:234:ba37:87ae
 with SMTP id d9443c01a7336-2365d89390cmr15112365ad.4.1749773052493; Thu, 12
 Jun 2025 17:04:12 -0700 (PDT)
Date: Fri, 13 Jun 2025 00:03:52 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.rc1.591.g9c95f17f64-goog
Message-ID: <20250613000411.1516521-1-komlodi@google.com>
Subject: [PATCH 00/19] i3c: aspeed: Add I3C support
From: Joe Komlodi <komlodi@google.com>
To: qemu-devel@nongnu.org
Cc: venture@google.com, komlodi@google.com, clg@kaod.org, 
 peter.maydell@linaro.org, steven_lee@aspeedtech.com, leetroy@gmail.com, 
 jamin_lin@aspeedtech.com, andrew@codeconstruct.com.au, joel@jms.id.au, 
 qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::64a;
 envelope-from=3_GpLaAcKCkkvzxwzotrzzrwp.nzx1px5-op6pwyzyry5.z2r@flex--komlodi.bounces.google.com;
 helo=mail-pl1-x64a.google.com
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

Hi all,

This series adds I3C bus support to QEMU and adds more functionality to the
Aspeed I3C controller.

This implementation is a basic implementation that introduces IBIs
(including hot-join), CCCs, and SDR data transfer. As-is, it doesn't support
multi-controller buses or HDR transfers.

First we add the I3C bus and controller model. With that added we extend
the functionality of the Aspeed I3C controller so it can do transfers
and handle IBIs.

Next, we add a mock I3C target. It's intended to be a very simple target
just to verify that I3C is working on the guest. Internally, we've used it
on Linux to verify that i3C devices can be probed and can send/receive data
and IBIs.
This target is sort of like an EEPROM, and it can also send IBIs upon
reception of a user-defined magic number.

Lastly we add  hotplugging support. The hotplugging doesn't do anything too
complicated, it just adds the device attempting to hotplug to the bus. It
is the device's responsibility to hot-join and go through the DAA process
to participate on the bus.

Thanks,
Joe

Joe Komlodi (19):
  hw/misc/aspeed_i3c: Move to i3c directory
  hw/i3c: Add bus support
  hw/i3c: Split DesignWare I3C out of Aspeed I3C
  hw/i3c/dw-i3c: Add more register fields
  hw/i3c/aspeed_i3c: Add more register fields
  hw/i3c/dw-i3c: Add more reset values
  hw/i3c/aspeed_i3c: Add register RO field masks
  hw/i3c/dw-i3c: Add register RO field masks
  hw/i3c/dw-i3c: Treat more registers as read-as-zero
  hw/i3c/dw-i3c: Use 32 bits on MMIO writes
  hw/i3c/dw-i3c: Add IRQ MMIO behavior
  hw/i3c/dw-i3c: Add data TX and RX
  hw/i3c/dw-i3c: Add IBI handling
  hw/i3c/dw-i3c: Add ctrl MMIO handling
  hw/i3c/dw-i3c: Add controller resets
  hw/i3c/aspeed: Add I3C bus get function
  hw/i3c: Add Mock target
  hw/arm/aspeed: Build with I3C_DEVICES
  hw/i3c: Add hotplug support

 hw/Kconfig                            |    1 +
 hw/arm/Kconfig                        |    3 +
 hw/i3c/Kconfig                        |   15 +
 hw/i3c/aspeed_i3c.c                   |  261 ++++
 hw/i3c/core.c                         |  669 +++++++++
 hw/i3c/dw-i3c.c                       | 1881 +++++++++++++++++++++++++
 hw/i3c/meson.build                    |    6 +
 hw/i3c/mock-i3c-target.c              |  311 ++++
 hw/i3c/trace-events                   |   47 +
 hw/i3c/trace.h                        |    2 +
 hw/meson.build                        |    1 +
 hw/misc/aspeed_i3c.c                  |  383 -----
 hw/misc/meson.build                   |    1 -
 hw/misc/trace-events                  |    6 -
 include/hw/arm/aspeed_soc.h           |    2 +-
 include/hw/{misc => i3c}/aspeed_i3c.h |   22 +-
 include/hw/i3c/dw-i3c.h               |  201 +++
 include/hw/i3c/i3c.h                  |  277 ++++
 include/hw/i3c/mock-i3c-target.h      |   52 +
 meson.build                           |    1 +
 20 files changed, 3735 insertions(+), 407 deletions(-)
 create mode 100644 hw/i3c/Kconfig
 create mode 100644 hw/i3c/aspeed_i3c.c
 create mode 100644 hw/i3c/core.c
 create mode 100644 hw/i3c/dw-i3c.c
 create mode 100644 hw/i3c/meson.build
 create mode 100644 hw/i3c/mock-i3c-target.c
 create mode 100644 hw/i3c/trace-events
 create mode 100644 hw/i3c/trace.h
 delete mode 100644 hw/misc/aspeed_i3c.c
 rename include/hw/{misc => i3c}/aspeed_i3c.h (63%)
 create mode 100644 include/hw/i3c/dw-i3c.h
 create mode 100644 include/hw/i3c/i3c.h
 create mode 100644 include/hw/i3c/mock-i3c-target.h

-- 
2.50.0.rc1.591.g9c95f17f64-goog


