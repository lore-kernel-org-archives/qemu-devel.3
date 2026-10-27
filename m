Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A32F606A31E
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 14:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Lt3edqzR
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLiCU-0007Hh-0X; Tue, 27 Oct 2026 10:30:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcelomanzo@gmail.com>)
 id 1xLiCN-0007Gs-IO
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 10:30:48 -0400
Received: from mail-qv1-xf36.google.com ([2607:f8b0:4864:20::f36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcelomanzo@gmail.com>)
 id 1xLiCJ-00056I-IG
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 10:30:45 -0400
Received: by mail-qv1-xf36.google.com with SMTP id
 6a1803df08f44-91b8306b9f8so41572226d6.3
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 07:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793111442; x=1793716242; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=MD1OxnYXvJPYG47I444Lm3D04UGVnEoVyDyy2sy/8YY=;
 b=Lt3edqzRFUM3UBhovrttlSYc966gwU9z8yeCYT7v/XCm21j7yODP54TV/4kQr+l26a
 2Md8pkj+sMzjDdqGy6fqouBJtXDgMRgr6SE0+s8E8i7rT0dM4/yWAiNV5vL4JfkrSIR2
 mP+VRLw62J83KowAOm5Xuca/6xZZMGxn+gO3uVgm/1Uw7VIxpATq4/pvsbTXSulITbbY
 hHUg/d6Q5THYEDiJAeqV/PbLHp18o99iolWjkZ5vzYdK0fYFeyFnG3ORpLDZCBZGL5XL
 9nL15aZkSRQP3RtRpS2fgAQfM1LNEkVsikhHDxDrXocxqbVpCfWMdn9X2bhNkUyRjwqB
 iQCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793111442; x=1793716242;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MD1OxnYXvJPYG47I444Lm3D04UGVnEoVyDyy2sy/8YY=;
 b=G4jAsaZhaq+EHLnPpTb/R38dDmuVAm4rzR8/SnagfCVoMnpbH4W/oK5xnpadcivOhJ
 Png8FlwFkaeo5g1UZNE+OwoW+QlYIYpsLW6lc7ZHN9g5jXev483ADywZoUgpsbvgHqnW
 eEXbqQ3p6lKAyCo5irgVijErsGUQ0yki2C+DPtfP2G9YBtjhz8zD+H78v8j6RnFYX8jN
 zi3MC1WW477g6moC5+5tC/PpdaWK/PJMDZkB2rGPcUZnOK4Rbqr8vMGjgbSnQ5eSGr1P
 dDETEDMYMuA4Qe5TKpZImOjfnDM+b95C18oYL0EKGBNGg47Oep5RtWxd2+rp9aausNNM
 Xvgg==
X-Gm-Message-State: AFq9FYJUvhs8S1SR4pUzeV0VXapkkqz6Z4KB3+CQ0LVgTE+DCu2PYR9d
 j3O3ivw+Vv8b3D0MGeAQoYJQlWfr4bwot6g+S+3TPYQEcp9N+HZWnAAlStuRrDe3
X-Gm-Gg: AYBFou1+4wMds+x0PpkmYPNMtZMzonNZRP+raLVxZXFgxMtT4n20af7s8PJUO/dp1Xs
 t/PQ6H5oRrRYQIOpNnrQbXdEQqFXJUip/J9jHrVyGri0rzjiaMyMrWlNzQkiV8gbqh7xsCcTRaK
 Aypo0ObjCmtQIgEZzDD4ob/5SIbZjtRxPbw7cKFkc0o2bZntT6xJnklRJuSM5ShFgym+yLWV/Rl
 WMxWBOCF3LwxInHPr6jMEKLNTWSTZarDwDlvhNBqxFBp8S9ekb8ZXPJogQorj3CDRh0sm2ugC1v
 BD9LqY01RN5FoWDF0d/h7rIO2fmuB5zms4lp4w+UoA1qdi7u+7hVAd8NYusSqQ6F5fpewSydsUD
 Q8BO+RTd6OTUFOHREJYRPnbGP2ULDvT3H2sBOAPno9VKlp7wKTcZr6YBd66rqCD+hlmM4yvlozR
 IwkRjeJAzGi3cY1A3V6YCx0dxkdn2tp+gWuYiKcdpnErymeSKrJO/hYcIQaq7JOqlbJqMlZjGhD
 u6meG5x/dyyM1pmaGLI61YoKvKkhmKOlL5e1ZkcDwCOixLTL306YYdpOdQeTQoqmd2qZwNihOhw
 ydBtEKxAmGdYvWtz5VTo8hwkiewcJ2hv86bmz28noRU78o75big=
X-Received: by 2002:a05:620a:4549:b0:93e:7834:3940 with SMTP id
 af79cd13be357-940ef8aed31mr1476431785a.18.1793111441316; 
 Tue, 27 Oct 2026 07:30:41 -0700 (PDT)
Received: from localhost.localdomain ([2606:6d00:159:2900:9872:3600:589:5f3a])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-940f0a78c06sm986400885a.35.2026.10.27.07.30.36
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 27 Oct 2026 07:30:39 -0700 (PDT)
From: Marcelo Manzo <marcelomanzo@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org, philmd@oss.qualcomm.com,
 Marcelo Manzo <marcelomanzo@gmail.com>
Subject: [PATCH v6 00/17] hw/arm/raspi4b: working PCIe and GENET (real
 networking)
Date: Tue, 27 Oct 2026 10:30:19 -0400
Message-ID: <20261027143036.44973-1-marcelomanzo@gmail.com>
X-Mailer: git-send-email 2.55.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f36;
 envelope-from=marcelomanzo@gmail.com; helo=mail-qv1-xf36.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series gets raspi4b's PCIe root complex and GENET Ethernet
controller working end to end: the PCIe link comes up and devices on
it enumerate, and GENET passes real network traffic (DHCP, SSH, bulk
downloads) under both older (Debian 11, 5.15) and newer (Debian 13,
6.18) guest kernels. Most of the GENET code is Sergey Kambalin's
2024 series (patchwork series 829638), carried forward with his
authorship and Signed-off-by kept.

v6: thanks to Peter for the review of v5.

  - Patch 14 (v4's migration patch, which v5 had dropped): add a
    VMStateDescription for the GENET device, as Peter asked. The MAC
    and PHY register blocks contain only uint32_t or uint16_t fields,
    so each is overlaid with an array of that element type in an
    anonymous union (the rest of the code keeps its s->regs.foo
    accesses) and is migrated with VMSTATE_UINT32_ARRAY() or
    VMSTATE_UINT16_ARRAY(), which is correct across hosts of
    different endianness. There is no post_load function: the
    interrupt outputs are derived from the registers and the device
    at the other end of each line migrates its own state.
  - Patch 10: add the trailing comma to the .size initializer of
    bcm2838_genet_client_info, so that the RX patch does not have to
    edit that line.
  - Added Peter's Reviewed-by to patches 1, 2 and 13.

v5: thanks to Peter for the review of v4.

  - Patch 1: the vmstate describes the PCI device and the AER log in
    the same way as the other PCIe root port models that add state
    of their own (gen_pcie_root_port.c, ioh3420.c,
    xio3130_downstream.c): through the PCIESlot that the root port
    embeds.
  - Patch 2: pass accesses to the EXT_CFG_DATA window to
    pci_host_config_read_common()/pci_host_config_write_common() for
    the function that EXT_CFG_INDEX selects, instead of calling the
    ECAM region's read/write ops; this also means that
    pcie_host_mmcfg_init() is no longer needed, so the call is gone
    and the commit message no longer lists it as a fixed defect (it
    also said "four" for a list of three). Set .impl.max_access_size
    to 8, and replace the comment on the unassigned-address windows,
    which had been copied from gpex.c, with one that only says what
    the code does. On map_irq: only slot 0 exists behind the root
    port, so there is nothing to swizzle; I added a comment saying
    so.
  - Patch 10: return early on an out-of-range access in the write
    handler, and assert that the register offset is a multiple of 4
    in bcm2838_genet_reg().
  - Patch 13: clamp the length of each copy so that it cannot exceed
    what is left of rx_packet[] after the status block, rather than
    relying on the caller's size check.
  - Dropped v4 patch 14 (GENET migration state); restored in v6.
  - Added Peter's Reviewed-by to patches 10, 11 and 12 (patch 10 now
    includes the two changes he asked for).

v4: thanks to Peter for the review of v3.

  - Patch 1: move the dc->user_creatable rationale comment next to
    the line it explains; add a VMStateDescription for the root port
    (PCI device, AER log and the regs[] array).
  - Patch 2: treat root_port.regs[] as little-endian bytes and access
    it with ldn_le_p()/stn_le_p()/ldl_le_p() instead of memcpy() and
    a uint32_t * overlay. Drop pci_bus_set_route_irq_fn(), its
    callback and the irq_num[] storage that only fed it: INTx routing
    queries come only from VFIO (with KVM irqfds), some x86 code and
    hw/remote, none of which applies to raspi4b.
  - Patch 3: drop the call to the removed set_irq_num() helper.
  - Patch 4: set both min and max access size on impl and valid.
  - Patch 8: BCM2838GenetPhyAuxShdRegs becomes an array of uint16_t
    rather than a struct, as suggested on patch 11.
  - Patch 10: access the register block as host-order uint32_t at the
    register's offset instead of memcpy() of an arbitrary size (the
    HFB filter array becomes uint32_t too, so every register in the
    block is one); do not call qemu_macaddr_default_if_unset() when
    the guest programs a MAC address, just update the NIC info
    string; accept an access that ends exactly at the end of the
    register block.
  - Patch 11: do not call bcm2838_genet_phy_update_link() from the
    MDIO patch; it is only defined by the RX patch, so the series did
    not build at this point. The prototype and the call move to the
    RX patch. Reword the "8 bits" comment and assert that the
    expansion shadow register indexes are in range.
  - Patch 12: check that a TX frame is at least a status block plus
    an Ethernet header, and that a frame's descriptors fit in
    tx_packet[]; check that reading the frame from guest memory
    succeeded; use lduw_be_p()/stw_be_p(); lower-case local names; add
    a helper for building 64-bit values from register halves; drop
    redundant "!= 0" on bools; split the producer-index handling out
    of bcm2838_genet_tdma() to reduce nesting.
  - Patch 13: the same clean-ups as the TX path where they apply;
    replace the comment that described an old bug with one noting
    that we do not implement the hardware's partial RX checksum and
    rely on the guest checking in software.
  - Patch 16: call require_netdev('user') so the test is skipped on
    builds without the user-mode network backend.

Based on master (7e8d3c7fc4). It conflicts trivially (raspi4b.c and
bcm2838_peripherals.[ch]) with the RNG200/thermal series, which is in
target-arm.next; I will rebase once that lands.

Tested: checkpatch.pl reports no errors; every patch builds on its
own; tests/functional/aarch64/test_raspi4.py passes; and unmodified
Raspberry Pi OS Bullseye and Trixie images boot under raspi4b with a
working network (DHCP, ping) and SSH login; and a booted Debian 13
guest keeps its state and its network across savevm/loadvm.


Marcelo Manzo (8):
  hw/arm/bcm2838_pcie: add BCM2838 PCIe Root Complex
  hw/arm/bcm2838_pcie: add BCM2838 PCIe host
  hw/arm/bcm2838: enable BCM2838 PCIe host bridge
  hw/net/bcm2838_genet: add GENET stub device
  hw/net/bcm2838_genet: add migration state
  hw/arm/bcm2838: enable BCM2838 GENET controller
  docs/system/arm/raspi: move PCIe/GENET from missing to implemented
  tests/functional/aarch64: add raspi4b GENET networking test

Sergey Kambalin (9):
  hw/net/bcm2838_genet: add GENET register structs, part 1/4
  hw/net/bcm2838_genet: add GENET register structs, part 2/4
  hw/net/bcm2838_genet: add GENET register structs, part 3/4
  hw/net/bcm2838_genet: add GENET register structs, part 4/4
  hw/net/bcm2838_genet: add GENET register access macros
  hw/net/bcm2838_genet: implement GENET register ops
  hw/net/bcm2838_genet: implement GENET MDIO
  hw/net/bcm2838_genet: implement GENET TX path
  hw/net/bcm2838_genet: implement GENET RX path

 docs/system/arm/raspi.rst               |    6 +-
 hw/arm/bcm2838.c                        |   13 +
 hw/arm/bcm2838_pcie.c                   |  313 ++++++
 hw/arm/bcm2838_peripherals.c            |   46 +
 hw/arm/meson.build                      |    4 +-
 hw/arm/raspi4b.c                        |    2 -
 hw/arm/trace-events                     |    4 +
 hw/net/bcm2838_genet.c                  | 1185 +++++++++++++++++++++++
 hw/net/meson.build                      |    2 +
 hw/net/trace-events                     |   16 +
 include/hw/arm/bcm2838_pcie.h           |   73 ++
 include/hw/arm/bcm2838_peripherals.h    |    7 +
 include/hw/net/bcm2838_genet.h          |  455 +++++++++
 tests/functional/aarch64/test_raspi4.py |   31 +
 14 files changed, 2152 insertions(+), 5 deletions(-)
 create mode 100644 hw/arm/bcm2838_pcie.c
 create mode 100644 hw/net/bcm2838_genet.c
 create mode 100644 include/hw/arm/bcm2838_pcie.h
 create mode 100644 include/hw/net/bcm2838_genet.h

-- 
2.55.0


