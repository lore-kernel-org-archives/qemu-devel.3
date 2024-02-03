Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 527EFC48298
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Feb 2024 09:33:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWCNr-0003xO-4F; Sat, 03 Feb 2024 04:32:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rWCNm-0003wo-Jf
 for qemu-devel@nongnu.org; Sat, 03 Feb 2024 04:32:21 -0500
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rWCNk-0005fz-BL
 for qemu-devel@nongnu.org; Sat, 03 Feb 2024 04:32:18 -0500
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-6daf694b439so2154599b3a.1
 for <qemu-devel@nongnu.org>; Sat, 03 Feb 2024 01:32:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1706952735; x=1707557535;
 darn=nongnu.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=TSpNm8azFWhXBT2yZYpwHfmfJNfPYLIR+KNRBuf5yRw=;
 b=vRGoA5fy6mTTi68F2F35kRjZBER10393WfkOVVEgicwS+/FG8llJpA8c3bM7W972q2
 vQHcua4w7O+TIdUyfmaHiFcUKUYfqRKxbM1qxI7JFS2ZIpJkCo64oVSE6RFwV+iyR3Y8
 E4e9YOASPPLdUWr1NaM104kXeVFPElM0pcuDHaDXbhwGl26EDMu1qPIA86GqzckTxIM2
 ZLuQfsJiJXkbYd2n1R70gZs/P3AFeXC7e5OdIgmEPTqwy11w9De5bTYyfNcLjmzzX1pA
 hRvqDNQm9wptmoydihnF8U0LhWX7P3vKAi0JRbWgC+Zug4Z1V4X2kItoKApq+xltH/5n
 O/Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706952735; x=1707557535;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TSpNm8azFWhXBT2yZYpwHfmfJNfPYLIR+KNRBuf5yRw=;
 b=AOB7jSIGcFL/VVaPRv+P7j4XApaHlxPZA9JPDXIJCM2DZ0IKlx08Ru9PgiBFQvU4un
 +3hjOgmt1fpSKQ65OXy6wzKT5BoYsaRolK2FtoWPhUDZvKH4btRMNklWeH9BrA4ETVKa
 iEFm03TWLQXawNUYx3SrPwDZnp5zwAz4tHCRmfk9Z6VekYlPIwCk2HeXcb51wz1wUOtt
 0XVmilGIkZzJQXg1RAcbe1al8T53/gQ327yORepkJ23jmD1YGB8SIhEgbK73BY7caaB3
 PveJR5iLZYzv193YdY5yhcf5Y8PfAZErlB2pDqYeH0ezujMry6xtBqXJJcsqSbOZ7ySJ
 v6ag==
X-Gm-Message-State: AOJu0Yx33Fwxw0wp0I3AuWjdw5Z715vw+NRrf/TrQGlAWUC5pAUK1hPi
 OG/gnjRfCQwo/RFDtcTgYNjMfcebMDrCTxffvS3e0chh1rVqrMAPTLjB897YKRM=
X-Google-Smtp-Source: AGHT+IHOvNXHhDrCdtEx8gcbTm++qn2Bivv9TZ8wlpuLusTXJ0kTfEEtd4ak7okd6FEDOtbDLRXjkA==
X-Received: by 2002:a05:6a20:d495:b0:19b:a07a:344d with SMTP id
 im21-20020a056a20d49500b0019ba07a344dmr12999619pzb.7.1706952734642; 
 Sat, 03 Feb 2024 01:32:14 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCU0SEnJcTsL5zdCugNBf+rJc3g7iCYMKyYLibx7vA/EANjzqfz2we7/WVa0tYRnRyLbRmV/2PnfDz1hQdYvFx/brOgHky07+Mhg5a/QWxUB3M8Kmqbgw1UpCFqSg4ZXBAt3f8303ikKbvSsYyHrfGSz33RT1ZXmwNQUWAj+oGewNhdqUwPBasY0PuPOKxlYxwokyibePUtGgOGz1ESfRNyhn5qIWG+tIIBTzj1kN0T+pqM8BWnTSRGjPRavsJQKuvON9itqCgDf/d0uRSUqyDd24zUyWMj31s7nLgEwCT9ibMudZGDSCAtGWTQ4JYmoQqqVpOzJAzlDw0mhVXPTrb/H0FT0p/09K0Z1bIV9OIkbkBBX/jlexHG+tcZA1qy9D0MITwDnEYpsyYEOYnEkCKGZPINYEKeTGwYOYB2MJg==
Received: from localhost ([157.82.200.138])
 by smtp.gmail.com with UTF8SMTPSA id
 ku12-20020a170903288c00b001d7284b9461sm2888350plb.128.2024.02.03.01.32.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 03 Feb 2024 01:32:14 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH 0/6] hw/pci: SR-IOV related fixes and improvements
Date: Sat, 03 Feb 2024 18:31:54 +0900
Message-Id: <20240203-reuse-v1-0-5be8c5ce6338@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAsIvmUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDQyNL3aLU0uJU3bTExFQjoyRDQ0tjEyWg2oKi1LTMCrA50bG1tQAUgI2
 DVwAAAA==
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
Received-SPF: none client-ip=2607:f8b0:4864:20::430;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x430.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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
 hw/nvme/ctrl.c              |  29 ++++++------
 hw/pci/pci.c                |  20 +++++----
 hw/pci/pci_host.c           |   4 +-
 hw/pci/pcie.c               |   4 +-
 hw/pci/pcie_sriov.c         | 105 +++++++++++++++++++++-----------------------
 hw/vfio/pci.c               |   3 +-
 system/qdev-monitor.c       |  12 ++---
 14 files changed, 116 insertions(+), 102 deletions(-)
---
base-commit: 4a4efae44f19528589204581e9e2fab69c5d39aa
change-id: 20240129-reuse-faae22b11934

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>


