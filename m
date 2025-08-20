Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 304DFCA0EFC
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Aug 2025 21:21:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoqDt-0005Hm-N4; Wed, 20 Aug 2025 17:19:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1uoqDq-0005G1-BU; Wed, 20 Aug 2025 17:19:54 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1uoqDm-0004zr-Pt; Wed, 20 Aug 2025 17:19:53 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-61a8b640e34so692206a12.1; 
 Wed, 20 Aug 2025 14:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755724787; x=1756329587; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=iTwLwKM/0oxk203muiX5V18KN2PyquNc0IkpBqSWFbw=;
 b=m4QZy8CXTdI6S4eRlAFPgN6/aQa3c7p00hWfFEgJX40oUHvVYxNHd4i1r9orrWNV46
 n70Ha6vJSPWyGf3FMby4IVtBkbpaUS6aQBrAsUHZXagTg1ysCU+chlL0+jJEd2NQXOB7
 ZgLQMScHiEpHtwt2X3mvb2FIJDgKcyWGpasoN26MTw1DDvNc+M7TYORPV/SjEMESo8Y0
 3s7i13y/IxqYPj1PEKoOGWObSAnxrRQbiHXFL2LXGJ++Hwwz+SLL+pSoounDdtVNdFaC
 tl86eSbuxMwHjkE1E29l0gdv6BYBfdSaaRJEK2OSM+Xe22u7StFSscWOQ4DP2z38MCHn
 6BHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755724787; x=1756329587;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iTwLwKM/0oxk203muiX5V18KN2PyquNc0IkpBqSWFbw=;
 b=JhgvmEfnilmjZtCyGZJV7WVZGGytWGwuvx0pYQkLJ9God+HOSFTpclaMfq/KEwlzI+
 2vXUZjyPgk/ADHgGQQbXseVd2mOqSJLSITpa9rQAfI9W1irUVOPXxQBM6ZRmX7YkMDLo
 F+nFm8a9jkuI/60cplWoLLiHwxvGPZthgR0FofmCKdcqw6FxJcTvoxcDCYF5BFH/gubp
 N0mKzVkQtLJLm8eVmksb+7/Oasx6Ly/bZ5ZDYwyLt/1T5uRascsulwdBeK0hWmmoSAWZ
 uDIEP+2JglVS99NYL4cNraS6ZNQ68agXDP88Q/5KC+hjoPE4U/kz0VTiXuIsrJEctXhh
 VXdA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWHj1ENRPCHeR1vxUIaodtF6st9xoHvX6tjGlL/h/rNL4K1SEFWnrkymQpab7MwwCwMmNasa7NQPQ==@nongnu.org
X-Gm-Message-State: AOJu0YyPzlMmxfcbO+dOSIGN7Q75v4d8QWgQ924XuHnlFgum+5r8TfsT
 p1KkH6tgYfZFSgqwN42GTyyEU4PD440aitmQUa8d4GsGObUa/fvrNNX+hmfYQw==
X-Gm-Gg: ASbGncsIOMfPI4SHitwhnrEXu48dJJe67seIv6Rq+hE7iycihSVN8nFBfYRyPA4QaoQ
 64A5zsThO4sS+Mu6IwrQYuZgNFD64wrpp9ieMdPJuwf8Lxh4qThhwqaGcXGungXOj9StmfjLph5
 QIgD+geVTeL3Wl9t3hK1bDP7GwDAf/1mSTGwsgqqqywzmY5HA9vblq7OPLeXqlmDXvhgpZKpLmU
 0swgkWVrPQ0krLpVu2guQyNKO/tvWv+zZiTu4PG2/X5FQ2O8BDkp6iP7VqrTG0A9BGriYysM1fs
 8KL567Jtphr+FtoHFg4cu+Z0T9s/NSYK1Sw8JlgINJUzlaSXH3n6zhGCPP+Ab9+U4HCGHeC7Uk/
 CnC/nEMKEUklICOeu7Af3eE65+BMn+7aJwarSSazxI0G8+hy6mE78IWA0T1auUph/+khXJ1WaIP
 +FiBPTDTiPY68xnpDxwgaD+45C0tHNZnuczvy+8GgGxKI=
X-Google-Smtp-Source: AGHT+IE4pvRhgUJeHgpn6z1UC7EZeyAwfFJL/LmNCaaYZrdx7BLyI/O9LxZviA0p13RgiNzd8P/KPw==
X-Received: by 2002:a05:6402:280c:b0:615:8bee:56b6 with SMTP id
 4fb4d7f45d1cf-61bf87478efmr119557a12.34.1755724787165; 
 Wed, 20 Aug 2025 14:19:47 -0700 (PDT)
Received: from Provence.localdomain
 (dynamic-2a02-3100-249c-be00-0219-99ff-feb2-2458.310.pool.telefonica.de.
 [2a02:3100:249c:be00:219:99ff:feb2:2458])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-61a755d9cfasm4161182a12.9.2025.08.20.14.19.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Aug 2025 14:19:46 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Andrey Smirnov <andrew.smirnov@gmail.com>, qemu-arm@nongnu.org,
 Bernhard Beschow <shentey@gmail.com>, Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 00/10] Designware PCIe host fixes
Date: Wed, 20 Aug 2025 23:19:22 +0200
Message-ID: <20250820211932.27302-1-shentey@gmail.com>
X-Mailer: git-send-email 2.50.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x52a.google.com
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

This series fixes the Designware PCIe host to work with cards other than
virio-net-pci, e.g. e1000. It was tested on the imx8mp-evk machine.

The series is structured as follows: The first part refactors the device
model to create memory regions for inbound/outbound PCI mappings on demand
rather than upfront since this approach doesn't scale for adding I/O space
support. The second part consists of fixing the memory mapping by adding I/O
space support and fixing default inbound viewport mapping. The third part
concludes the series by implementing device reset and cleaning up the imx8mp SoC
implementation.

Testing done:
* Boot imx8mp-evk machine with Buildroot while having an e1000 card attached.
Observe that it gets an IP address via DHCP and allows for downloading an HTML
file via HTTP.

Bernhard Beschow (10):
  hw/pci-host/designware: Eliminate some helper variables
  hw/pci-host/designware: Create viewport memory regions on demand
  hw/pci-host/designware: Determine PCIDevice of configuration region
    once
  hw/pci-host/designware: Distinguish stronger between viewport memory
    types
  hw/pci-host/designware: Implement I/O space
  hw/pci-host/designware: Fix I/O range
  hw/pci-host/designware: Don't map PCI memory space into PCI inbound
    window
  hw/pci-host/designware: Fix default inbound viewport mapping
  hw/pci-host/designware: Implement device reset
  hw/arm/fsl-imx8mp: Do not map PCI window as unimplemented

 include/hw/pci-host/designware.h |   5 +-
 hw/arm/fsl-imx8mp.c              |   1 +
 hw/pci-host/designware.c         | 284 ++++++++++++++++---------------
 3 files changed, 151 insertions(+), 139 deletions(-)

-- 
2.50.1


