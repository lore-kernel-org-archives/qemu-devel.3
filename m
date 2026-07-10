Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDD02C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 14:33:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiCI9-0006os-Mw; Fri, 10 Jul 2026 10:33:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rdmitry0911@gmail.com>)
 id 1wiBNp-0003aw-Fm
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 09:35:18 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rdmitry0911@gmail.com>)
 id 1wiBNl-0004kD-MO
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 09:35:12 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-47df440fcd5so502851f8f.3
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 06:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783690506; x=1784295306; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=EcpyO9YPEYhCRw56J+zTglMTassEZTi9UwcPRp700Ww=;
 b=jX7Mk3bfjQty4BgItwr5WEK/09rkCBN+8BmoNtpRQXNFyksHkquhovQSqa49bq7Fdj
 p6OK2AFdDmBDvO8GysAAGBVT0ETLqv3WQ/8pHh7t4xdRhpi6AxnWEHdnFHQiEmAwDdpS
 Yv7QvQOc4ZFcPXbUL71W94gkIr5hGLoD1OTwFgaLQh7Ou/pHvl9yBYyMiwwN3WLgwdkl
 wUL7o+jvMzO4OqGjkBoF+A0C+sfyctZnUIIOyprYjRXOVjYeSa8YaUTYq7KPCx9pFzYv
 RPmPgMRc0VPjrcAoiHDlJPJr8jGuBXUUSJfnlrIFGSgSUbps+qSryoUFlx2+ica1wNbT
 VkoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783690506; x=1784295306;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EcpyO9YPEYhCRw56J+zTglMTassEZTi9UwcPRp700Ww=;
 b=kYZjmTJozt84kMTkWKgnhU0vPZyjPqTrtGqXjBRZ7HPnOCZkhRLbWP6I0ZZW1d9NyN
 eQclkRVBLfN0wghH6S243CVxTAkGvGt5dCFf8zk39p0NRYnFqgbRAK5BAyaXwmuZ5Hk0
 CwAmbqjNeVb7haRquq9Z5h9xisPXcmqA9YRD4zZOzhYhxdXDx3df0yThVDEDvquz4L1d
 6FTNjd5u7fFTbwNA2yu46fxPVo5Sv0WLz1Fwnnn5U5R/QZqpgj6YuddFZdaLQnqYP9l6
 3Ca5y2GMqSfNgKOwx0kRjgINkLxC1LtaAN4PWOOjLFbKAc08SzbVG+NOsukZENPX8BC4
 o2kw==
X-Gm-Message-State: AOJu0YwuXxl1KBMTSxfMoHQ6NByaCFs1HPKp1ine91rQHM+TZFKtsfVj
 9La9/kkGBc7poIZlv+pfc+m5SqU+K7NpL+xrD0DRh2SIov0oH5KW75GIrVVHl7Kxq+Y=
X-Gm-Gg: AfdE7clZur2jQVx3ITtlNBaqVWb6OrHio8RIJY9Dif6Xxr0eidjWUVon4ErgbQhvNa1
 NLnvcQm8REjYE8888v5+FcBxYZSlc3RlGJJSAs+dvWg3Zu9TzhNLCNH9Wnwr8NjsRz4RFe42fhI
 T/fVvlTjk4UvLkJRCc9esVa4m/U9wl3LE5wp27U90KT0AzTyoynh3yyRyrffc9KKCP5TFEZVEqP
 6xfwJMzpvFFkQ6GpLwTtjXHLfwo7pEgKAc1NWNMUj2F3b1jQoCspzDUIk6RUHGpru5yAZP3PY0s
 7D2l939AtsOmK00w2ek+Di4hUIH0MF8OWHnnGIU7Llagrstttg0iGjmvuAGq/00kOSaqmuxSwG0
 ixpAU3HjR6dcCYaxVGxxnXXR5GEi3tQOsNMSFOxQ1XPhkiLSXdY3eIYCEYTolNL4XpMOckBjTks
 K5JX7hWa3FnlU4ZaW9PVP8Pp+WxAJJwZNqP6cB3vPg790mlbNhWIei+KRGvh6XYlKlz7VKy7V0v
 6ehF4kgTqlEspqF/sk=
X-Received: by 2002:a05:6000:402a:b0:46e:98a7:232b with SMTP id
 ffacd0b85a97d-47df07a8676mr13668587f8f.10.1783690505342; 
 Fri, 10 Jul 2026 06:35:05 -0700 (PDT)
Received: from debian-for-building.localdomain
 (static.244.71.243.136.clients.your-server.de. [136.243.71.244])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47a9b4d850dsm61405779f8f.0.2026.07.10.06.35.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 06:35:04 -0700 (PDT)
From: Dmitry R <rdmitry0911@gmail.com>
To: qemu-devel@nongnu.org
Cc: Dmitry R <rdmitry0911@gmail.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [RFC PATCH v1 0/1] Thunderbolt PCIe hotplug layer
Date: Fri, 10 Jul 2026 16:34:37 +0300
Message-ID: <20260710133440.2845828-1-rdmitry0911@gmail.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=rdmitry0911@gmail.com; helo=mail-wr1-x433.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 10 Jul 2026 10:33:23 -0400
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This RFC adds a Thunderbolt-flavoured PCIe hotplug layer for QEMU.

The main goal is hotplug and hot-unplug of real and virtual devices in
guests where direct hotplug for those devices is not supported or not
usable.  macOS is the main validation target for this path: the guest can
observe endpoints through a guest-visible Thunderbolt layer even when direct
PCIe hotplug for the same endpoint is not usable.

The series intentionally keeps regular QEMU PCI endpoint devices intact.
Devices behind the new layer remain normal QEMU PCI devices; the
Thunderbolt root port controls guest-visible link presence, publishes ACPI
properties, and emits PCIe hotplug notifications.

The patch adds:

* thunderbolt-root-port, creating a thunderbolt-bus secondary bus.
* thunderbolt-pcie-pci-bridge for tunnelled PCI endpoints.
* thunderbolt-vga, a separate stdvga-compatible hotpluggable endpoint.
* README/specs documentation with VGA, USB storage, and NVMe examples.
* qtest coverage for the Thunderbolt VGA hotplug path.

The regular QEMU VGA device is not changed and remains non-hotpluggable.
The Thunderbolt display path uses the separate thunderbolt-vga device type.

Runtime validation performed so far:

* macOS guest booted from QCOW2 overlays over immutable base disk images.
* Thunderbolt VGA hotplug/removal while the standard boot VGA remains.
* NVMe hotplug/removal with guest driver instance checks.
* USB controller hotplug, USB storage mount/write/eject, controller removal,
  replug, and data persistence verification.

Build/test validation:

* ninja -C build qemu-system-x86_64 tests/qtest/display-vga-test
* meson test -C build qtest-x86_64/display-vga-test --print-errorlogs
* scripts/checkpatch.pl --no-tree --no-signoff on the full diff:
  0 errors, with expected warnings for MIT inheritance in thunderbolt-vga.c
  and possible MAINTAINERS coverage.

Open questions:

* Whether this should be split into smaller review patches after the overall
  Thunderbolt modelling direction is accepted.
* Which MAINTAINERS entry should own the Thunderbolt PCIe layer.
* Whether the guest-visible properties are sufficient for non-macOS guests
  that may also benefit from Thunderbolt-style tunnelling.

Dmitry R (1):
  hw/pci-bridge: add Thunderbolt PCIe hotplug layer

 README.md                                   |  91 ++++
 docs/specs/index.rst                        |   1 +
 docs/specs/thunderbolt-pcie-hotplug.rst     |  99 ++++
 hw/display/meson.build                      |   1 +
 hw/display/thunderbolt-vga.c                | 275 ++++++++++
 hw/pci-bridge/meson.build                   |   2 +
 hw/pci-bridge/thunderbolt_pcie_pci_bridge.c | 156 ++++++
 hw/pci-bridge/thunderbolt_root_port.c       | 565 ++++++++++++++++++++
 tests/qtest/display-vga-test.c              |  68 +++
 9 files changed, 1258 insertions(+)
 create mode 100644 README.md
 create mode 100644 docs/specs/thunderbolt-pcie-hotplug.rst
 create mode 100644 hw/display/thunderbolt-vga.c
 create mode 100644 hw/pci-bridge/thunderbolt_pcie_pci_bridge.c
 create mode 100644 hw/pci-bridge/thunderbolt_root_port.c

-- 
2.47.3

