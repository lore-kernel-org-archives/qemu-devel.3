Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F560C54E67
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Mar 2024 03:59:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkyhj-00027t-7n; Thu, 14 Mar 2024 23:57:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rkyhh-00027Z-H5
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 23:57:57 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rkyhf-0001yl-5c
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 23:57:57 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1dc09556599so12899035ad.1
 for <qemu-devel@nongnu.org>; Thu, 14 Mar 2024 20:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1710475073; x=1711079873;
 darn=nongnu.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=+WGQdIUSycucIhx4oyJHIkWidp1I1uRjNUdLbz5q894=;
 b=RVQCG5v59zsvDCK65EzjaR4+rW6XeI1ij4kGyCfMPse5+MEK01J93dSrbLZJghEyUo
 WAszgfSSuYac4aiCa/V4EY+a52ks5anB52RUnjmPcbcEDnTRa/iHd4i2FObVSSVPxMNz
 yuQQLkbQ+DmULt3McFbcpqd6X8QMWHQ1tCAMoNq8HGoRtLN9K6osTGB6Zqh97GfqpgcU
 HMSonozxsdni6S8Tq/FwCyoNKZ8FVD0WybcZ8tq3HYeoNeWO3ilCZqpeBuSwQcIoUxgQ
 //VIEHxR44rhOhWVcFqo6VFmbPVVaAhvw4FLlUD1AVOlcSvIID9tijnw8YNXvCDZFsW7
 W/Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710475073; x=1711079873;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+WGQdIUSycucIhx4oyJHIkWidp1I1uRjNUdLbz5q894=;
 b=qRFJh8nEKIyCgwArjVvS9ML+SKDtNii9ceiMrTfDr1HsYzsH89Z4YoTkXyHPrFlOlD
 p600WlQY3GZxCAxq22KyiXuH+WQFY2ZMvyYQFDXFI9szNpUkeIA0+Z26Ob4X/yHVbVXn
 J1OTaaIE5Hvd3pi4OsXKaVTOITaBHBgrdHsXx6bwlJwzqTO8DVShFJp1Pl1W/3gZLCjK
 +tzvJ+D0G0re9JuueO5mynRh05u2wgLIbq0KDEIzmIGEWW65ADU91p4HpXJG99cW8G6L
 gjofTBf9viZa7sPH1l/F29aXppX4hPqTFjq+SLTypM01c6Z7hTJONiH3b1qt/3zbJfFQ
 iaXg==
X-Gm-Message-State: AOJu0Ywh5npcf0WUHK7jDb8LOvbFOnDu70LU81eIkttFQH9GrU029KsX
 awDfSfuW6gORYUJWhT0ZU/w8wUHLFAw8yX48WjsX6nnIoBhJaODhr3hcyDWGo/0=
X-Google-Smtp-Source: AGHT+IHHcTXKk+6R+Vc8XQhPldtbt3H6ma3FMrooxEdGF9CXfMZaEhwcWnusM9qdjPzZaTrDSUb1TA==
X-Received: by 2002:a17:902:eb8c:b0:1dd:611d:3be3 with SMTP id
 q12-20020a170902eb8c00b001dd611d3be3mr2324757plg.17.1710475073287; 
 Thu, 14 Mar 2024 20:57:53 -0700 (PDT)
Received: from localhost ([2400:4050:a840:1e00:9ac7:6d57:2b16:6932])
 by smtp.gmail.com with UTF8SMTPSA id
 u11-20020a170902e5cb00b001dc01efaec2sm2607507plf.168.2024.03.14.20.57.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Mar 2024 20:57:52 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH for 9.1 v9 00/11] hw/pci: SR-IOV related fixes and improvements
Date: Fri, 15 Mar 2024 12:57:47 +0900
Message-Id: <20240315-reuse-v9-0-67aa69af4d53@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIADvH82UC/2XPTW6EMAwF4KugrMvIcX5Iuuo9qi6S4HSyKIxCi
 2Y04u4NqKBULC37e/J7solyoom9Nk+WaU5TGocy2JeGhasbPqlNfZkZAkrgaNtMPxO10TlC9Jx
 bIVm5vWWK6b7lvLM45sZeOPsoi2uavsf82PJnvq23KATxFzXzFlrlyQQVSAth3nr3GNL9EsavL
 WLGinHYGRaG0jt0ClBbPDFRM9yZKMwA77w2NlAXT0zWTO5Mrsy6Hqxw0EV5YqpmZmeqMJIx8MC
 tV86emK4YHt302o0kOjQeQjx362p2PNmtzAYuffBWIZ2YqdnxpFmZQa0BDScN/9iyLL+6oI+YJ
 QIAAA==
To: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Alex Williamson <alex.williamson@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, 
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, 
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>, 
 Klaus Jensen <its@irrelevant.dk>, Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.3
Received-SPF: none client-ip=2607:f8b0:4864:20::62c;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62c.google.com
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
series.

[1]: https://patchew.org/QEMU/20231210-sriov-v2-0-b959e8a6dfaf@daynix.com/

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
Changes in v9:
- Rebased.
- Restored '#include "qapi/error.h"' (Michael S. Tsirkin)
- Added patch "pcie_sriov: Ensure VF function number does not overflow"
  to fix abortion with wrong PF addr.
- Link to v8: https://lore.kernel.org/r/20240228-reuse-v8-0-282660281e60@daynix.com

Changes in v8:
- Clarified that "hw/pci: Replace -1 with UINT32_MAX for romsize" is
  not a bug fix. (Markus Armbruster)
- Squashed patch "vfio: Avoid inspecting option QDict for rombar" into
  "hw/pci: Determine if rombar is explicitly enabled".
  (Markus Armbruster)
- Noted the minor semantics change for patch "hw/pci: Determine if
  rombar is explicitly enabled". (Markus Armbruster)
- Link to v7: https://lore.kernel.org/r/20240224-reuse-v7-0-29c14bcb952e@daynix.com

Changes in v7:
- Replaced -1 with UINT32_MAX when expressing uint32_t.
  (Markus Armbruster)
- Added patch "hw/pci: Replace -1 with UINT32_MAX for romsize".
- Link to v6: https://lore.kernel.org/r/20240220-reuse-v6-0-2e42a28b0cf2@daynix.com

Changes in v6:
- Fixed migration.
- Added patch "pcie_sriov: Do not manually unrealize".
- Restored patch "pcie_sriov: Release VFs failed to realize" that was
  missed in v5.
- Link to v5: https://lore.kernel.org/r/20240218-reuse-v5-0-e4fc1c19b5a9@daynix.com

Changes in v5:
- Added patch "hw/pci: Always call pcie_sriov_pf_reset()".
- Added patch "pcie_sriov: Reset SR-IOV extended capability".
- Removed a reference to PCI_SRIOV_CTRL_VFE in hw/nvme.
  (Michael S. Tsirkin)
- Noted the impact on the guest of patch "pcie_sriov: Do not reset
  NumVFs after unregistering VFs". (Michael S. Tsirkin)
- Changed to use pcie_sriov_num_vfs().
- Restored pci_set_power() and changed it to call pci_set_enabled() only
  for PFs with an expalanation. (Michael S. Tsirkin)
- Reordered patches.
- Link to v4: https://lore.kernel.org/r/20240214-reuse-v4-0-89ad093a07f4@daynix.com

Changes in v4:
- Reverted the change to pci_rom_bar_explicitly_enabled().
  (Michael S. Tsirkin)
- Added patch "pcie_sriov: Do not reset NumVFs after unregistering VFs".
- Added patch "hw/nvme: Refer to dev->exp.sriov_pf.num_vfs".
- Link to v3: https://lore.kernel.org/r/20240212-reuse-v3-0-8017b689ce7f@daynix.com

Changes in v3:
- Extracted patch "hw/pci: Use -1 as a default value for rombar" from
  patch "hw/pci: Determine if rombar is explicitly enabled"
  (Philippe Mathieu-Daudé)
- Added an audit result of PCIDevice::rom_bar to the message of patch
  "hw/pci: Use -1 as a default value for rombar"
  (Philippe Mathieu-Daudé)
- Link to v2: https://lore.kernel.org/r/20240210-reuse-v2-0-24ba2a502692@daynix.com

Changes in v2:
- Reset after enabling a function so that NVMe VF state gets updated.
- Link to v1: https://lore.kernel.org/r/20240203-reuse-v1-0-5be8c5ce6338@daynix.com

---
Akihiko Odaki (11):
      hw/pci: Rename has_power to enabled
      pcie_sriov: Do not manually unrealize
      pcie_sriov: Ensure VF function number does not overflow
      pcie_sriov: Reuse SR-IOV VF device instances
      pcie_sriov: Release VFs failed to realize
      pcie_sriov: Remove num_vfs from PCIESriovPF
      pcie_sriov: Register VFs after migration
      hw/pci: Replace -1 with UINT32_MAX for romsize
      hw/pci: Use UINT32_MAX as a default value for rombar
      hw/pci: Determine if rombar is explicitly enabled
      hw/qdev: Remove opts member

 docs/pcie_sriov.txt         |   8 ++-
 include/hw/pci/pci.h        |   2 +-
 include/hw/pci/pci_device.h |  22 ++++++-
 include/hw/pci/pcie_sriov.h |   9 +--
 include/hw/qdev-core.h      |   4 --
 hw/core/qdev.c              |   1 -
 hw/net/igb.c                |  13 +++-
 hw/nvme/ctrl.c              |  24 ++++---
 hw/pci/pci.c                |  31 +++++----
 hw/pci/pci_host.c           |   4 +-
 hw/pci/pcie_sriov.c         | 149 ++++++++++++++++++++++++--------------------
 hw/vfio/pci.c               |   3 +-
 hw/xen/xen_pt_load_rom.c    |   2 +-
 system/qdev-monitor.c       |  12 ++--
 hw/pci/trace-events         |   2 +-
 15 files changed, 172 insertions(+), 114 deletions(-)
---
base-commit: ba49d760eb04630e7b15f423ebecf6c871b8f77b
change-id: 20240129-reuse-faae22b11934

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>


