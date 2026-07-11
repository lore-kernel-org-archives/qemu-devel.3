Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA1F3C43458
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2026 09:49:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiUK5-0004cV-VJ; Sat, 11 Jul 2026 05:48:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rdmitry0911@gmail.com>)
 id 1wiUK4-0004b6-3A
 for qemu-devel@nongnu.org; Sat, 11 Jul 2026 05:48:36 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rdmitry0911@gmail.com>)
 id 1wiUK2-0002vn-95
 for qemu-devel@nongnu.org; Sat, 11 Jul 2026 05:48:35 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-4728c12ba97so724834f8f.0
 for <qemu-devel@nongnu.org>; Sat, 11 Jul 2026 02:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783763311; x=1784368111; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fHMF608ViM3meYtTIhdTIQXdBSuZ8GsIRk22bURZIGs=;
 b=r1Uf+ThBaZ654bmfLUH+h/EA+KD/vjwhgcclI7WswrKCpz5g9JCLTM95+Z8go4LjPg
 E2qg0oCHpmcK0BgNS7rsq6tEYqeqCXzntYLI4WfAsMLp0x+HHQ2yjwRLMty9/zI/YEZo
 TafDwne0li+VP/Uvit9w15pn7mSK2K6CwLEgY7LnZX21GBzFEZQ6P19/SHLgBugbM7LZ
 ZdIQsxciP83/1yIP+Dz5ChhR5hsXj6fsQ/1/7o1cjH8gaf21N4by6kOX5RHo5TPscikY
 mAjXhJt0ryKBUVGu5e9juddQm+iWaT0LTrVjd0w7rDJOsfgLuGTWsV2cQuliJMVUig2a
 ExSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783763311; x=1784368111;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=fHMF608ViM3meYtTIhdTIQXdBSuZ8GsIRk22bURZIGs=;
 b=BNn328WmP2Mw//+Ynpn5tQ1AG/cEHJ4XicbfnNuUnIFTW7ztk8uHLophiDLoMFK2Lx
 7wXW8Ema4mWxXtRm89+ZXdNR3bfv6+llMkrgK4vTtMRG7qa44SY6TUF/fzP1THGj7RIG
 cDcE6DhYTJ7BmokzCizsC+IbiEiypgB+W3eyRiy/l+SHVr1YQYVDmWMV4cwyv7CEvocN
 u+QUTkq6GnGXJjpU4RBKZTyfSh2+6+pJkwtTLRJ93lveqZc5BiPn6/Xdub6yXRYXHK45
 X7Khg1CR9B1dWr9aYHRgYTlIqV8b9VoG29QCCyNM0Y7e5iYsVDRTB9G1hqPjtT+AuYdi
 FZHQ==
X-Gm-Message-State: AOJu0YyJEWSMgJoBqdtu+oKPzS2s7pE2aAs3njTengsNhJDq1IlBLifz
 i2sRawkdz0V6EZdF5fNj0OJie94shvNrGau8C82H8+CXFIZTqqGNCa4+RFzQbmOU
X-Gm-Gg: AfdE7cmeCxctgEKgyKkAWraMN5Tprqh4AsBNX+gz+D/oT0fAmtHJjGBACOHK30KHMZP
 Ic6mx77wp5wjtKB3MpQvlMvwCKXwnd9zVXoaXBW4bFUUTvRS5w5Sqmvx2XMyw8Qcad/oZ83OCRd
 jVL2aRSpVYNW2TKmzXk4XvyqweenCPiaA79ZC1huym1YHDUz3ez7NJ/+UISbIWKc0i1dskOE0f/
 T9PvP16QQHetLK98/Fl8GclOwDGjhpGi5ZPcj+vLwPLtTFI60I6feE9/i7t1Q9EKVMpBN1yGXKc
 yDqHky2y13tP9HuTt7irCBvW3GCKnil8J0T2oqI87/9nSjSgENROI8zwYvkS/Vj0n/pBZxp6lTS
 xqZNLEQm4gSg7Kr7wTFyf+D9TD775d3SQjj6YBJK2qL+0cV9Nq6WvJ6ixpXfc9JnSar+7SOORE3
 GcxffPdMPOPDYh6vNXdYGRFoNHhnpXTOoW9aYt7r/9bbw1YSSRkhIzHdpdy0O3fvXBohti/olkk
 bAEXbeRbi5irVaHcM5lbDNpOjrFhQ==
X-Received: by 2002:a05:6000:400a:b0:47f:25b1:e7b6 with SMTP id
 ffacd0b85a97d-47f2dcec940mr2004587f8f.30.1783763310811; 
 Sat, 11 Jul 2026 02:48:30 -0700 (PDT)
Received: from debian-for-building.localdomain
 (static.244.71.243.136.clients.your-server.de. [136.243.71.244])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47aa039ad21sm66558181f8f.20.2026.07.11.02.48.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Jul 2026 02:48:29 -0700 (PDT)
From: Dmitry R <rdmitry0911@gmail.com>
To: qemu-devel@nongnu.org
Cc: Dmitry R <rdmitry0911@gmail.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [RFC PATCH v2 0/5] Thunderbolt PCIe hotplug layer
Date: Sat, 11 Jul 2026 12:47:56 +0300
Message-ID: <20260711094803.3589239-1-rdmitry0911@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710133440.2845828-1-rdmitry0911@gmail.com>
References: <20260710133440.2845828-1-rdmitry0911@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=rdmitry0911@gmail.com; helo=mail-wr1-x431.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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

In v2, the series is split so the modelling part is explicit:

* patch 1 adds the Thunderbolt root port and thunderbolt-bus.  This is the
  core Thunderbolt PCIe model: endpoint devices remain normal QEMU PCI
  devices, while the root port controls guest-visible link presence and PCIe
  hotplug signalling.
* patch 2 adds the Thunderbolt PCIe-to-PCI bridge for tunnelled PCI
  endpoints.
* patch 3 adds a separate thunderbolt-vga endpoint for display hotplug tests.
  The regular QEMU VGA device remains untouched and non-hotpluggable.
* patch 4 adds qtest coverage.
* patch 5 adds documentation and MAINTAINERS coverage.

I added myself as reviewer for the Thunderbolt PCIe files.  The files still
match the existing PCI area through their paths, so PCI maintainership is
inherited by normal get_maintainer.pl matching.

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
  0 errors, with one expected warning for MIT inheritance in thunderbolt-vga.c.

Changes since v1:

* Split the single large patch into five patches.
* Clarified that the modelling piece is the Thunderbolt root port/bus.
* Added a MAINTAINERS entry with Dmitry R as reviewer.

Dmitry R (5):
  hw/pci-bridge: add Thunderbolt root port
  hw/pci-bridge: add Thunderbolt PCIe-to-PCI bridge
  hw/display: add Thunderbolt VGA endpoint
  tests/qtest: cover Thunderbolt VGA hotplug
  docs: document Thunderbolt PCIe hotplug layer

 MAINTAINERS                                 |   7 +
 README.md                                   |  91 ++++
 docs/specs/index.rst                        |   1 +
 docs/specs/thunderbolt-pcie-hotplug.rst     |  99 ++++
 hw/display/meson.build                      |   1 +
 hw/display/thunderbolt-vga.c                | 275 ++++++++++
 hw/pci-bridge/meson.build                   |   2 +
 hw/pci-bridge/thunderbolt_pcie_pci_bridge.c | 156 ++++++
 hw/pci-bridge/thunderbolt_root_port.c       | 565 ++++++++++++++++++++
 tests/qtest/display-vga-test.c              |  68 +++
 10 files changed, 1265 insertions(+)
 create mode 100644 README.md
 create mode 100644 docs/specs/thunderbolt-pcie-hotplug.rst
 create mode 100644 hw/display/thunderbolt-vga.c
 create mode 100644 hw/pci-bridge/thunderbolt_pcie_pci_bridge.c
 create mode 100644 hw/pci-bridge/thunderbolt_root_port.c

-- 
2.47.3

