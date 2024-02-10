Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AFB1C48260
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Feb 2024 10:26:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYkXa-000725-D7; Sat, 10 Feb 2024 05:24:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rYkXS-00070y-V4
 for qemu-devel@nongnu.org; Sat, 10 Feb 2024 05:24:51 -0500
Received: from mail-oo1-xc31.google.com ([2607:f8b0:4864:20::c31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rYkXM-0002dB-P8
 for qemu-devel@nongnu.org; Sat, 10 Feb 2024 05:24:50 -0500
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-599f5e71d85so1149729eaf.3
 for <qemu-devel@nongnu.org>; Sat, 10 Feb 2024 02:24:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1707560683; x=1708165483;
 darn=nongnu.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=+5bijzRXWVoE0Zr1vQzUuWpTYTB1t7Auoqsf4f2FtZk=;
 b=Sb6gwtD62rIroZ2wYxSvST176LfM88x9+MBWHrAg4VekKzqsacLg9isH2o538BHXUI
 /SCnYcxkC8+idoqs/XfP/OgvWvCWhn+MaehjKd7QBSk18pQiAdTHEz5LSVQSFwL1dITP
 U6rqaXdr2Ihot6bkLvowxVIO/JyKbeDSmLgh/X3O2ZAOPrr8bKshKLieiCV20c2GsGy4
 1y9YMu0+SwYxnWEOYVy8GtfNtBUYesHabChGheOZli3XM3v3MUneKBtynW46mb8jn3Ot
 0cZDphR4YQSz7a0jyw5UP3Y4uRNLZiUw7X4bn0l4YAdPLQBVgc2tGsYq91BadIJhDAKU
 C4DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707560683; x=1708165483;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+5bijzRXWVoE0Zr1vQzUuWpTYTB1t7Auoqsf4f2FtZk=;
 b=mn1D/7ZIJv5QZPvDo2zr/QQAPEoSLDwLdPBuMn+7QCqwFtmpRyVQTOhuyQz2EQ895Z
 jHCD3DbHd1+PP8TNe+PocSix5AO2PwwlTG0VULCrUsLXh43wN2LeW1eh9BpaoihZ2+Uv
 ZCbV+hnSkA3oywbzakXbgRlZR6JWg3epcs5AZfrdXi88kCkoQfRaA6fk6UVlp7aitOFw
 3pzSs+gmNh9wEKJHWo/J+Akbfy91d4ORmG1o0lo6OUz8XKL1Yve70VzPGOTtF3Erg61O
 zvwJGclVg9R57GbcjNOA+XQyweOj1dyKER4aNyFOjeviXn4gLi0kT5KmlWoWiUCxEz0F
 3xjg==
X-Gm-Message-State: AOJu0YyW6jQhkugkFjdcroFEcJ2k1W3SVHFlNc3UoCjAUNftitSDRkmg
 vIrvEXBKETlJzPAlfi+Q5pxArcGDDBa64T9zlYDYGYIVw5PngKsFt6bXTuqUQ/A=
X-Google-Smtp-Source: AGHT+IHxmkGIH5O829ddR+vNSRZfI48+7PS4w8DBxI/sJMssN1P4n+kOGDV/3nMOHGbIBEFK2TRhbA==
X-Received: by 2002:a05:6358:999b:b0:178:9b16:5bbe with SMTP id
 j27-20020a056358999b00b001789b165bbemr2747165rwb.9.1707560683147; 
 Sat, 10 Feb 2024 02:24:43 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCURiHKRRogakNJ2VnAxgEblKz8cSHzQPr4SAjO2VUaHKrWq0Yqs3VkeIBo1eAqMXF3apeaiKlHPfhYmxp4uyponzHt0+nh6Z0Lm5oZmDn7udKN77Q/y+WoHMDY29xXu5uelstqyrSZS3ZiF7TI6nXhIgAIt3ecSYiI9MSNzYpw5ODzNb0zIPcg8HYMm3Icxpl6qw/5j8cr+JEzYIqxqc5zdJGrM0CsH6frwCnF2pyX3rH8gVq0lRBc4nd2T9EYhSxn5ROwyBv1YKC1FmAqNic6z1sWaHLtLj8nAe7FA8qAFi0uc9GQbG47m95LIz2u+Yytw4XZS3MxCfb5ms0ZyD4tnNkZuIVy3/hTkMV5hfhHY8T0lLxYtUSXB9nGzpef5Qc5viiZ6bxPNSX3nJe9HsvtLzG0BxsSBCO7xAowhDA==
Received: from localhost ([157.82.200.138])
 by smtp.gmail.com with UTF8SMTPSA id
 j20-20020a056a00175400b006e04553a4c5sm1983732pfc.52.2024.02.10.02.24.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 10 Feb 2024 02:24:42 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v2 0/6] hw/pci: SR-IOV related fixes and improvements
Date: Sat, 10 Feb 2024 19:24:35 +0900
Message-Id: <20240210-reuse-v2-0-24ba2a502692@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAONOx2UC/y3MQQ6CMBCF4auQWVvTTsGAK+5hWJQyyCxsTasNh
 PTuVnT5v7x8O0QKTBGu1Q6BEkf2rgSeKrCLcXcSPJUGlFhLhZ0I9I4kZmMIcVSq0zWU7zPQzOv
 h3IbSC8eXD9vBJvVdfwJK/ReSElI0I7W2sXTRuu0nszlez9Y/YMg5fwDXACR6mwAAAA==
To: "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Alex Williamson <alex.williamson@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, 
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>, 
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>, 
 Klaus Jensen <its@irrelevant.dk>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.3
Received-SPF: none client-ip=2607:f8b0:4864:20::c31;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-oo1-xc31.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

I submitted a RFC series[1] to add support for SR-IOV emulation to
virtio-net-pci. During the development of the series, I fixed some
trivial bugs and made improvements that I think are independently
useful. This series extracts those fixes and improvements from the RFC
series. Below is an explanation of the patches:

Patch 1 adds a function to check if ROM BAR is explicitly enabled. It
is used in the RFC series to report an error if the user requests to
enable ROM BAR for SR-IOV VF. Patch 2 and 3 use it for vfio to remove
hacky device option dictionary inspection.

Patch 4 adds SR-IOV NumVFs validation to fix potential buffer overflow.

Patch 5 changes to realize SR-IOV VFs when the PF is being realized to
validate VF configuration.

Patch 6 fixes memory leak that occurs if a SR-IOV VF fails to realize.

[1]: https://patchew.org/QEMU/20231210-sriov-v2-0-b959e8a6dfaf@daynix.com/

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
Changes in v2:
- Reset after enabling a function so that NVMe VF state gets updated.
- Link to v1: https://lore.kernel.org/r/20240203-reuse-v1-0-5be8c5ce6338@daynix.com

---
Akihiko Odaki (6):
      hw/pci: Determine if rombar is explicitly enabled
      vfio: Avoid inspecting option QDict for rombar
      hw/qdev: Remove opts member
      pcie_sriov: Validate NumVFs
      pcie_sriov: Reuse SR-IOV VF device instances
      pcie_sriov: Release VFs failed to realize

 docs/pcie_sriov.txt         |   8 ++--
 include/hw/pci/pci.h        |   2 +-
 include/hw/pci/pci_device.h |   7 ++-
 include/hw/pci/pcie_sriov.h |   6 +--
 include/hw/qdev-core.h      |   4 --
 hw/core/qdev.c              |   1 -
 hw/net/igb.c                |  13 ++++--
 hw/nvme/ctrl.c              |  24 ++++++----
 hw/pci/pci.c                |  20 +++++----
 hw/pci/pci_host.c           |   4 +-
 hw/pci/pcie.c               |   4 +-
 hw/pci/pcie_sriov.c         | 105 +++++++++++++++++++++-----------------------
 hw/vfio/pci.c               |   3 +-
 system/qdev-monitor.c       |  12 ++---
 14 files changed, 116 insertions(+), 97 deletions(-)
---
base-commit: 4a4efae44f19528589204581e9e2fab69c5d39aa
change-id: 20240129-reuse-faae22b11934

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>


