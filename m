Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61DBCC4829D
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Feb 2024 10:21:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZTQg-0007ox-Mi; Mon, 12 Feb 2024 05:20:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rZTQX-0007mj-2I
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 05:20:41 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rZTQU-0007ai-L6
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 05:20:40 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1d934c8f8f7so22649735ad.2
 for <qemu-devel@nongnu.org>; Mon, 12 Feb 2024 02:20:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1707733236; x=1708338036;
 darn=nongnu.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=OIpbMmCo6wr1U0mNh1+A6niiCtk/94EEMEFXygx3QNg=;
 b=Ngg/djGOJhPBk2SOYX2A08B/3IcULeDZVpOG4H3TkeTsd+DWjoifVm7JlcEXjOVBrx
 VUoQKz9IEV3ul9Ef0R+kpRnJozSHuUBojTooejjYyTJwQRlkBtFRqcMEBHC37PnJtpNy
 AK/41yLtkovrYLAjzgwGxjKdxNro8h1v4k0y8xwmTBhRlP487TimDXmP9a2vXCg8Fdso
 ih/9sOvolhrRGs+qtzvk2VJOlaxip4Y2H0thBzRVif798w/lla9vRfyXg4SPEfS+hlO6
 g2qrjqrXnOsbY1DK7xxVN6F9xgf7qelWJlUTIRWoMOZ1YfvESDvcumU7nuKd1xefAmeP
 d12A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707733236; x=1708338036;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OIpbMmCo6wr1U0mNh1+A6niiCtk/94EEMEFXygx3QNg=;
 b=jrU9Lt4R/HQC1L/tGLyel+9Aapgd4AlPDFo2C8ZaiDnNhRRj29V8ubpmqbhZslBBmU
 Sukq3b0sPvAJVSdtz/bLHHr6ZtejKJhIl1cqtcjXjhk4hAptGFV179rKkQXzMr0fWsw4
 Vv7W3ViYPPbGg5XFIvumbcnl8Ys5+GLimjJ7H+d5LCAHgYeNxccjBe80qMOMfRYb9DNt
 +Qm/HjXyeM8i3thGw7jTo+kVlSIGYCVGQKNx/F7SSzMQIHsBcxPUpCJC+pzMPO2cYZmf
 FSYP+xWYm6ZtXgJuu4hfb2Cd+ZgyRbLVQi95WrJLCU1BTLs36dHEMVh31CstELb/NmxM
 Oqvg==
X-Gm-Message-State: AOJu0Yx2wGkkSAXSsn9Ok2WATwKQ7o4CqiOrlM+oe3IlWl3Ph565uohW
 yc3m1rm5Yz4jZvbMYGyScfIqmGxRIoogYQ3ir4bncsfy07ZgrP00WWOCA7fRCJI=
X-Google-Smtp-Source: AGHT+IEQWutYRRhgHehiRqGcRlD/JP/P8xFMk+0utY132ZAgIzUGUmrdxGymK7oBRJgH4VoDFVo5Vg==
X-Received: by 2002:a17:902:b688:b0:1d9:c86c:39c2 with SMTP id
 c8-20020a170902b68800b001d9c86c39c2mr5533916pls.14.1707733236553; 
 Mon, 12 Feb 2024 02:20:36 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCU05LXOPxrkZRA0QRH1s0ivlJ+jZBxvxBI0AC1/lejZ5V46B3lrq/Nf/RqmiOUQm0lqs+ecMtgN6jmszIR4y4/jSowLbv2sAADEQ6XkNWT7mjDRNeJv8OWIfrFYeohhgEP4LwLpZC8vleolbYWetaZYIAyzCLqzQpupsTqUOOT9oxtZQBrsxCkM81T4KWBT9lt9UYHuzNgEDrE8OOmoiIYQmrGG2QkxZ06RV72HPKIC9r4p2d6rlQYC1d2b4C7mKuDILh0kcyGRPzTy3+27NudkguwgNetwjiQiVHAlJgJoegYHpG/EalsXmWr+i5mtGBG8T2IixfYskpYeAzB6ZFDfo/Qihmx1zB3Dw3rijBoD60q34mz6I0pQOVg+O+M0zeFe68cguApBz57cYYfWoe9tPnSr/xuzkfFjPlvgZ4Hjg/qDqdDngY2UwAOB5wk=
Received: from localhost ([157.82.207.134])
 by smtp.gmail.com with UTF8SMTPSA id
 f6-20020a17090274c600b001db28ae5d81sm50332plt.159.2024.02.12.02.20.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Feb 2024 02:20:36 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v3 0/7] hw/pci: SR-IOV related fixes and improvements
Date: Mon, 12 Feb 2024 19:20:28 +0900
Message-Id: <20240212-reuse-v3-0-8017b689ce7f@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAOzwyWUC/1WMQQ6CMBBFr0JmbU07LQRccQ/jopRBZiGYVhsI4
 e4W1ESX7+e/t0AgzxTglC3gKXLgcUigDxm43g5XEtwmBpRopMJKeHoGEp21hNgoVWkD6Xv31PG
 0d86XxD2Hx+jnPRvVtr4LKPWnEJWQIm+odLmjQuuybu088HR04w22RMQfTcmvhklD01i0ucSiw
 j9tXdcXr72FzNIAAAA=
To: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
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
Received-SPF: none client-ip=2607:f8b0:4864:20::630;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x630.google.com
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
Akihiko Odaki (7):
      hw/pci: Use -1 as a default value for rombar
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


