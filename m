Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFAF1CCA464
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 18:17:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHPvN-0001Gz-Q0; Thu, 15 Oct 2026 14:11:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcelomanzo@gmail.com>)
 id 1xHPvL-0001Bc-L9
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 14:11:27 -0400
Received: from mail-qt1-x82a.google.com ([2607:f8b0:4864:20::82a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcelomanzo@gmail.com>)
 id 1xHPvJ-0001Rk-S4
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 14:11:27 -0400
Received: by mail-qt1-x82a.google.com with SMTP id
 d75a77b69052e-53606d2351aso18290801cf.3
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 11:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792087885; x=1792692685; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=kDi6Ms4VOCBYgAFNYh2oj+riu0usSjF6z3/Qp8bt9l4=;
 b=ix+hFRZgc+JWYU+jUbXCf4CoeP+omyBwf4uwVM1l7R77RYzw8veeU+qCvbsxctCsD6
 ADTy9VlVarBH9PTWoQ1vHTkEyeA4G92hB/Z+B/N4sS8h0WC8DsHAS2LhF1FPZVU9C9Ik
 L/hnURoI4pc29jbza7/ED66rFtXwZDqXNKlsNp8XyhG0CZAtk6wotyxRxoioAwvfmeEj
 Tz5pWeQKyDAKDcpjE7/rq8eUTE5p6TtA1xwdzYf3oKAp9PF3umtyAkpdKEM3avUDTCU3
 6otVy6U8hoLHf5bXUQjUrQ5gQvM3NIpNmzEWDrVy9fUlCmIQfA1nrc0/slbagelv/4Aj
 Vszw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792087885; x=1792692685;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kDi6Ms4VOCBYgAFNYh2oj+riu0usSjF6z3/Qp8bt9l4=;
 b=LR1fDNQ+Tq6TzXOBFzwcWLMX+qDYBlRS+UDc42MnYuYX9McSUlFbrD+OAwLIVoeVES
 j/KHiSNbA500IVoabGcwEjsN3VgFU8wB1FtcgcuxzwhrWbAcTdnvF6l8dDrmWy4BMDF3
 QQKo1zekNc308jL6bbP+GeLh1xV2jDdBMgQgeLqFIrccc2TK1OiObu9t9JEIix4aEpBY
 SW8Gz+yf2okqUUD2PxKUfs0EmdT0CK+gtDhPawT4mVPZMQ28guyrggWXA0z1jvZ3X1qs
 pjAV8C6KCKUuQxG7xc/0hXBzfiqeoIdF+8SYrWABhltK2kF0wD7ZrxN4GPQ5S+8GWvYF
 r+Jg==
X-Gm-Message-State: AFq9FYJHPYn2bcWo27V0dEZ2+0l5cy87v2Yxbh6QYbAIDSunn12aONOn
 AZeK9LsZ6tpGOhfRKaY1Q65AHI16SU0dWh2iO9sOc+Pxp4+FwtvjSy+KmrOUIgtI
X-Gm-Gg: AYBFou3D3V1YkW+QgAwNXIvAbMJy80KAdQvlvg4sZBF02E2BU8yQWSlNKSRP0ecazJX
 Cb3MHiEL+cG8D7Q/Tx3YaxPxCdz48S+TwdGvDGN0WFnsxn3hw2p6SXnp9noAlKqw2PEL3x1ldeM
 Bnn9a2nGOoa4PP/6KaBUw7TBHluepOhDgTWateYJr1cbcKmRVXu1vdYwiBnlXTDG0Pi2UEHnftu
 kAWb0Ido9zo9OrhN1d4WqHuB0HPalUkod/Idd+b7Vn1oQtgxUzoDbGS//3htj+6fpn2dpiXeWF6
 WzESkWewvyCiERIQ/QfkzkdMI+TjkijOU0WdReUqghlbrGybf4qlDRtLnFFpncq8rzKCrh0c+N7
 K9e4Kc/ihBUFUA3Yo5ckuFCYFPGZsuoQijoHOP6wYrWIpl4HaOQTn5PxW//+l5Ubqbnd5kPDot4
 ZMw8/rVLSFKCRug57up2pDCJs3jfKyp1TPFrBfXfZFa5s1zB8kToT58TOL6C7yww1mc+G3DYkga
 +Nq6bInf73ikV57P4LuyhzcmKN/xdmKJ2IB0S0v6RjTaQUvY7/Nsq8FcTECPo/OH8V7Eg==
X-Received: by 2002:a05:622a:ab03:20b0:534:20b8:5d08 with SMTP id
 d75a77b69052e-53628350fa2mr7722071cf.45.1792087884680; 
 Thu, 15 Oct 2026 11:11:24 -0700 (PDT)
Received: from localhost.localdomain ([2606:6d00:159:2900:919:5388:4e10:5949])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-536127efe4asm32130611cf.19.2026.10.15.11.11.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 15 Oct 2026 11:11:23 -0700 (PDT)
From: Marcelo Manzo <marcelomanzo@gmail.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Marcelo Manzo <marcelomanzo@gmail.com>
Subject: [PATCH v3 00/16] hw/arm/raspi4b: working PCIe and GENET (real
 networking)
Date: Thu, 15 Oct 2026 14:11:05 -0400
Message-ID: <20261015181122.60608-1-marcelomanzo@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::82a;
 envelope-from=marcelomanzo@gmail.com; helo=mail-qt1-x82a.google.com
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

This series gets raspi4b's PCIe root complex and GENET Ethernet
controller working end to end: the PCIe link comes up and devices on
it enumerate, and GENET passes real network traffic (DHCP, SSH, bulk
downloads) under both older (Debian 11, 5.15) and newer (Debian 13,
6.18) guest kernels. Most of the GENET code is Sergey Kambalin's
2024 series (patchwork series 829638), carried forward with his
authorship and Signed-off-by kept.

v3: thanks to Peter for the review (and for running it under UBSan),
and to Philippe.

  - Fix the UB Peter found by running "make check-functional" under
    clang's UBSan: bcm2838_genet_rdma() built the per-packet status
    block by casting the (misaligned) RX buffer to a C struct. It now
    fills the status block in with stl_le_p(), which is also correct
    on big-endian hosts. The functional tests now run clean under
    --enable-ubsan.
  - Fold the three bugfix patches that were in v2 (PHY autonegotiation
    restart, RX checksum reporting, TX ring activation check) into the
    patches that introduce the code they fix: the MDIO patch, the TX
    path patch and the RX path patch respectively. The series goes
    from 19 patches to 16. Philippe's Reviewed-by on the old "fix TX
    ring activation check" patch is not carried over, since that
    change now lives inside the TX path patch.
  - While in bcm2838_genet_rdma() I also found that the RX descriptor
    index and the DMA write length come from guest-programmed
    registers and were not checked against the size of the descriptor
    array / our packet buffer. Add those checks (in the RX path
    patch).
  - Rebased on current master (7e8d3c7fc4).

This conflicts trivially (three files: raspi4b.c and
bcm2838_peripherals.[ch]) with the RNG200/thermal sensor series
("[PATCH v2 0/5] hw/arm/raspi4b: RNG200 and thermal sensor"), which is
posted separately. Whichever lands second, I will rebase.

Tested: checkpatch.pl reports no errors; the series builds on current
master and tests/functional/aarch64/test_raspi4.py passes, including
under clang --enable-ubsan; and unmodified Raspberry Pi OS Bullseye
and Trixie based images boot under raspi4b with a working network
(DHCP, ping, 2MB downloads) and SSH.

Marcelo Manzo (7):
  hw/arm/bcm2838_pcie: add BCM2838 PCIe Root Complex
  hw/arm/bcm2838_pcie: add BCM2838 PCIe host
  hw/arm/bcm2838: enable BCM2838 PCIe host bridge
  hw/net/bcm2838_genet: add GENET stub device
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
 hw/arm/bcm2838.c                        |   15 +
 hw/arm/bcm2838_pcie.c                   |  308 ++++++
 hw/arm/bcm2838_peripherals.c            |   46 +
 hw/arm/meson.build                      |    4 +-
 hw/arm/raspi4b.c                        |    2 -
 hw/arm/trace-events                     |    4 +
 hw/net/bcm2838_genet.c                  | 1136 +++++++++++++++++++++++
 hw/net/meson.build                      |    2 +
 hw/net/trace-events                     |   16 +
 include/hw/arm/bcm2838_pcie.h           |   75 ++
 include/hw/arm/bcm2838_peripherals.h    |    7 +
 include/hw/net/bcm2838_genet.h          |  428 +++++++++
 tests/functional/aarch64/test_raspi4.py |   30 +
 14 files changed, 2074 insertions(+), 5 deletions(-)
 create mode 100644 hw/arm/bcm2838_pcie.c
 create mode 100644 hw/net/bcm2838_genet.c
 create mode 100644 include/hw/arm/bcm2838_pcie.h
 create mode 100644 include/hw/net/bcm2838_genet.h

-- 
2.55.0


