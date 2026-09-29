Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC1D0CA5FA7
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 20:25:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBeNI-00065D-Qw; Tue, 29 Sep 2026 16:24:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <weqaar.janjua@packetfive.com>)
 id 1xBeNG-00064x-BT
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 16:24:26 -0400
Received: from mail-wm2-x10.google.com ([2a00:1450:4864:31::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <weqaar.janjua@packetfive.com>)
 id 1xBeNE-0005D5-Ft
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 16:24:26 -0400
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49d1fb0cf5eso43329195e9.3
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 13:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=packetfive-com.20251104.gappssmtp.com; s=20251104; t=1790713462; x=1791318262;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=RtJUOQyE5bXIVFY6cddWz8JdOAteX+W5F6NJomG4teE=;
 b=G7Q/j2+hp4ySyXOzLQSvwCaFwjmIKogS5r5P1OkoF3/OKjcX1vGsvraZpdrWgHjvbd
 D4N30zDSpMvfAUTlRDJGpwxjXuhPkj9L5bTU918KF2+X607MxRkbLWDyS6Mo18rSAkTK
 jZGKyBAg87ZMxcpDJWVAXvDt8J6b6c2hNyJ2OK1WPP2uxquVZ3PgbSlkRdcmqYTTM2x5
 lvrTeahTbG0teR69Iyf2WMFEzlt6VQT0Y7Ud1Eanu+tO14h6T+O6kf/odiT+EVze8rD3
 JQEDVmjDg3dHiTWzLPLQQ0q0nivUK2jjk1iYfamfScCphf4GoPsW7LHVO0QqYaucCTut
 XZhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790713462; x=1791318262;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RtJUOQyE5bXIVFY6cddWz8JdOAteX+W5F6NJomG4teE=;
 b=EuDnlL1sZGlOmbdH/dLPlLOOBhVMHTg8n0ra+S3fLlorZ3Om1vjL5GF5k8Rk4QVWrn
 re1MOr+WpQC/MFtY3t7weQnoc6ZNzxPEvdtx0N9wknJw+QahwjgwODaWCPWCiYM6lHY2
 Sw1bMQPg6ouzwkNvS4gTGDVDcX3Mcxo7a17b/JvEJrZ44NOl/KA+dfq4tDmIbqc9RCmh
 dRo8AHkQE8UZSktAoYFVlw4H3+oyBWztGJRO0yJl9m7f3XJ11ok+uiE8CkeDLhqeXl9r
 bIywJ3Vx5UVYutNoDD4Dqh546SrSWLZjtTS7QloyZ5v/iaVhDdT3Z+k7gjM51mDX2M+B
 uxtA==
X-Gm-Message-State: AFuF++nK1er9CopoLd0pHqdWHkOImHZ8rKnGkuGdA4XpP82/087Cuo27
 GmeYUjDW9/VcsIt5uk4gv+UvaSk1rAfkXDmR2FiygA0KU+DBsCVXdm46Kday1MR9SdVJZY7zRmV
 F4btyNqY=
X-Gm-Gg: AYBFou1Z0j7Yfu79gJn0VIfofOXxCQqxPkxRquvYGBN3VeHS+YFd9qfxSvX6bWdHYnF
 RGArHdMVgmnkA++92NXqtk9GWJMMoM6RzLTMoAZjl+0XiZfl/MuSSd3Xd3V6UebvEivq2ZORq0Y
 oyOLanVXyYXLagElmCt+rANuxaWQD3w4cEwA6/Fk6cK6MkNYoBDvMCfIBsuzPzmFqhx19pX+PI2
 /G9dNmgbsR6hrhhOWblimcyd7FqNIGwcEUa+6MlufXDhKAn5Pvs1b84YQBhZS7BK5BlherfzexD
 FVFj5jBAnTNuQvIKE4XF1BRQYjEdO41mdmXZiSJ7QEJ0cjktNdOG0bpqiMsYE9My2H6ojednvBK
 93PLV7yOh6TyNRERdX2U/Y4xYXoh1KFwwKehm4wSz9qRqqZuzoVKCXjMDWGCJVVdDdDJ8XDx9Wt
 F3rjHyKFfk6d12Oz0ACADTMDriX4b3gXAH3XQpAPhW0NaU1D2LI6Yac5q3dMRQWZsWGy+gewMpH
 3zF5t6FVYFE5Sb+51y4ndgs0rf/p8OE597L5QxDztb5pvJlGAowNsN6dy5o/aYHqg==
X-Received: by 2002:a05:600c:4f86:b0:4a0:c22:2620 with SMTP id
 5b1f17b1804b1-4a015027dc8mr3811945e9.13.1790713462381; 
 Tue, 29 Sep 2026 13:24:22 -0700 (PDT)
Received: from node-dev.home
 (86-45-19-184-dynamic.agg1.roc.bbh-prp.eircom.net. [86.45.19.184])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a014f77aa3sm7021525e9.7.2026.09.29.13.24.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 13:24:21 -0700 (PDT)
From: Weqaar Janjua <weqaar.janjua@packetfive.com>
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com, peter.maydell@linaro.org, mst@redhat.com,
 pierrick.bouvier@oss.qualcomm.com, jasowangio@gmail.com,
 pbonzini@redhat.com, farosas@suse.de, lvivier@redhat.com
Subject: [PATCH v3 0/6] hw: Add Cnuas virtual devices
Date: Tue, 29 Sep 2026 20:23:51 +0000
Message-ID: <20260929202358.725310-1-weqaar.janjua@packetfive.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2a00:1450:4864:31::10;
 envelope-from=weqaar.janjua@packetfive.com; helo=mail-wm2-x10.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

This series adds PCI IDs and QEMU models for the Cnuas virtual network
adapter and CnuasGPU AI/ML accelerator.

CnuasNIC provides guest DMA and Linux SOCK_SEQPACKET transport. CnuasGPU
provides MMIO control, device memory, and optional link transport. Both
models include reset and migration state, MSI and INTx support,
documentation, and functional qtests.

Changes since v2:

- use 1b36:0017 (CnuasNIC) and 1b36:0018 (CnuasGPU) to avoid PCI ID
  conflicts
- add PCI-ID documentation links along with their target document additions

The complete QEMU device implementation is included in this patch series.

Regards,

Weqaar Janjua
Packet Five Networks Ltd.
Dublin, Ireland
https://www.packetfive.com

Weqaar Janjua (6):
  pci: Add device ID for CnuasNIC
  hw/net: Add Cnuas virtual network adapter
  tests/qtest: Add Cnuas virtual network adapter tests
  pci: Add device ID for CnuasGPU
  hw/misc: Add CnuasGPU virtual accelerator
  tests/qtest: Add CnuasGPU tests

 MAINTAINERS                   |  10 +
 docs/specs/cnuas-vnic.rst     |  78 +++++
 docs/specs/cnuasgpu.rst       |  91 ++++++
 docs/specs/index.rst          |   2 +
 docs/specs/pci-ids.rst        |   4 +
 hw/misc/Kconfig               |   5 +
 hw/misc/cnuasgpu.c            | 557 ++++++++++++++++++++++++++++++++++
 hw/misc/meson.build           |   1 +
 hw/net/Kconfig                |   5 +
 hw/net/cnuas_vnic.c           | 508 +++++++++++++++++++++++++++++++
 hw/net/meson.build            |   1 +
 include/hw/pci/pci.h          |   2 +
 tests/qtest/cnuas-vnic-test.c | 233 ++++++++++++++
 tests/qtest/cnuasgpu-test.c   | 274 +++++++++++++++++
 tests/qtest/meson.build       |   2 +
 15 files changed, 1773 insertions(+)
 create mode 100644 docs/specs/cnuas-vnic.rst
 create mode 100644 docs/specs/cnuasgpu.rst
 create mode 100644 hw/misc/cnuasgpu.c
 create mode 100644 hw/net/cnuas_vnic.c
 create mode 100644 tests/qtest/cnuas-vnic-test.c
 create mode 100644 tests/qtest/cnuasgpu-test.c

--
2.43.0

