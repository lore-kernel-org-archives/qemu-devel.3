Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03FB606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 19:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=WQqRa4Hb;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=HK51o5HB
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLmmI-00014h-Aa; Tue, 27 Oct 2026 15:24:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLmlz-0000x3-Bh
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 15:23:52 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLmlw-0001la-0e
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 15:23:50 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69RIHO0Z3553868
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 19:23:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=P53v0x0Oq8hRyHUkGKVtXE
 3Q3isuGeOsklIQps3JtQM=; b=WQqRa4HbwVugqNTLdGNzy8rxgS1tCZ7P9+ZeTd
 66+Zjb6p4FF5hsfw0eJp6I/qzRZasYhGDHf/OKLr8ApNdFQ/rVr1km2YGoOSaxzR
 +5it4NdpOKoL3PMxXrgH8zj9ahqYzAVillGRbXKF0c+ASz7vwc9FX96HAgSXu2s4
 qzmhX5VV/UaxsAL+5jDXdhGlt3VzTq5VCDQxWY8/moXzyoweJIWTekfoGL1+p5zn
 jUgC0wvMC/O7s/sjdcnYNxdyGSModG1Q6vZa8WEcdWznNYRcv+KBWuvcWKDmpwq2
 SMGFqhvAuwLHpv2/a9dNAClo3T4x7ByLThxSAIjhlU7pxf8w==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjqw22wau-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 19:23:44 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-91c7c7e8becso2394686d6.0
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 12:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793129024; x=1793733824; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=P53v0x0Oq8hRyHUkGKVtXE3Q3isuGeOsklIQps3JtQM=;
 b=HK51o5HBfcf4axEWi1UfeVofEIbOXyqBWDp9z32U8rHmdQ6MvilaucTNql6z1gkMA3
 nJm3PGQ+tgMq/sjeSkojq5bUAtENq6XCsdMrKYZxIN3fZ4jnxd90N3DxKyyKsZbt8oLU
 MstZ0L+RjRba80v/tbP8f7A/YG6tP/KqfHf0k7z0o3qvixegKpicaRgSm1KyVLoaUqEr
 4qAIAp5X+U1ADkAdYnB2nL6s1wcKadSqVBeE9O3zcAsbRBhqcWeASA0Mn/tjKdD9cboL
 lIxcXHrp/xYJ9wTQ2BwmfDQCN3IE4176k7oXFNMGOMSwbDkzLpOa02vJ84rOZepwban9
 fvfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793129024; x=1793733824;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=P53v0x0Oq8hRyHUkGKVtXE3Q3isuGeOsklIQps3JtQM=;
 b=zpoT8kDJZmP1vnxLX6a1nryWKkTlyosesYu41lhtKOw54ZEGK7tMZDqHJffwpkA3tG
 jrx/Flgb1pnT1Vh/Fmb4gZGXdCaNGGgw8sAKRCpYfVzwvniIi8utydMWcY8OnkvboeGd
 7NNIu5L6y0taBZCmJu/E2vuy7bYlzbLkaBvBeVueDYPbHPDVx2FmcZ916orrtauZ8IQB
 oHNUsFK8SKCjgCDUZ8OWwBJ6rtrCFKm5LRt9K85d+LRkc1zqsqF07mkJtV57qnQAufcx
 ACBdM6/qoodgVZEB1IjXjxG8qzQOXjAU+AXYKsMvec/mpepuA2ck9PmBPWbrTnoITRpc
 EGhQ==
X-Gm-Message-State: AFq9FYIF5ZbGA6Q8hRdZlncPzTcnwPm4yH4GvPcqufxbMRDoaXQGRMs3
 Gopp/i6WoXDRMRue36D0k2jkrnmU71NUq859kbrwriVI3qpMQdVosHHPjcMqWNBTDxBhkDDaqNe
 4MRShU/zCeC0Z33qy4zaHleCKJm/tffk985XWJ/5VA7vbkMaCmDqWSZVEXHsmkw93OQ==
X-Gm-Gg: AYBFou3wG9RLv8cPUIupLcbU2ngIRK2+VPpxm7KmVxAXrI6Iw4M2l8uAE3KdfylcaYg
 0B8A8qR9xd6V8oxOZVzYcFKApf8oRZc8t9zg4jfUDmyZQFTlbm8eA1CpCmnNcIpQ00cXQdC6o/D
 EmnZYgynhO7EpX05m0VsJZL1mIEhS8KTNa5+hlHTv6PuoQyEBxB6S8qby2Hu7WnltONItGFdR1s
 8iuzbaLNc8soyASSwLHI5pYZn//3Id/3XMVu80wQAYnFo5d1dlvLhuORubAU9L969Q1XeeYWw2F
 I0lu13OeZSj1lxVZIHJMww4X9rAOoSfHHYHm1Y+uJ+YUsTfFNqeyWeUb7/QdOC6XojgJqXNhPlq
 U1y7Xs3xsWhkNriU5/BCiapIw8j+BCyI7uLEMdnGj/wz8/H90mFigjtlcAPwK3R1a29PArrLS+S
 IS7yOaKk4DZUjnpSUYLZNgqGBt174mOA==
X-Received: by 2002:a05:620a:a881:10b0:940:f53d:5f7 with SMTP id
 af79cd13be357-940f53d1553mr1150746385a.69.1793129023544; 
 Tue, 27 Oct 2026 12:23:43 -0700 (PDT)
X-Received: by 2002:a05:620a:a881:10b0:940:f53d:5f7 with SMTP id
 af79cd13be357-940f53d1553mr1150743085a.69.1793129022954; 
 Tue, 27 Oct 2026 12:23:42 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a94c021080sm2778655e9.2.2026.10.27.12.23.41
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 27 Oct 2026 12:23:42 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/59] Misc HW patches for 2026-10-27
Date: Tue, 27 Oct 2026 20:22:41 +0100
Message-ID: <20261027192341.9197-1-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA3NyBTYWx0ZWRfXyeqJmM64uERi
 WB859RXnsAzQqMqt0xwrqwaLK0siTxevHQsPs5K+LPr5UM4Ma8EOFlPtQy1dC3PFp8iVA3P4pnu
 qYt0WMQpXQdXSAgjOcCoPgpX1pN6qbO5oUbPUGaipL1rsqQQKJ5NFhGW+5dlya5gjLZgEcACSCG
 XPIk5czJ4mxLOKlfjiVyik9CO7aAQzATUPCMKorOwfhBENhu5AfBti0r+vKKCjGIBg3+f1cWvMU
 FWYjwFmjWhV0GuUTCVt5bwboHWYtRRjP13vxgxRZPEZOsAa9MmMi4DiVRiuiY0tlwgwLJgDM8Ka
 q7fFJtqjt84dqxWt1Ff4l4QvzV0/Fv8B7tZKgRFKRNDZUga+9c7ms9yKl/Mrvye+xpjuVlItuar
 VSKUnzrGw5TuT3iuQ0K1nsHyYT2YKNqSn3Ycu+g7+yKr56O1tOJC391VVZyiS8IP69rHsLrjHmY
 HkOA71UglcnxfYhKoTw==
X-Proofpoint-GUID: Bk-hzAsvq4DY1wx9QL_14IFR35bUDyno
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA3NyBTYWx0ZWRfXzkQlhbPARIVq
 sk53XY0XMhhYBKDy/kbZyiH5XWCqpCtAFT1q/16mbzxixcz2DFbEnavvm4u3bv2+A1+507GTWrk
 PlgWBFU9FBhkn4D4gnouQueazdRHtQ0=
X-Authority-Analysis: v=2.4 cv=PsYG/AM3 c=1 sm=1 tr=0 ts=6ae0fa40 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=p0WdMEafAAAA:8 a=NEAV23lmAAAA:8 a=b67tjSmBUQRZCt5wVhgA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-ORIG-GUID: Bk-hzAsvq4DY1wx9QL_14IFR35bUDyno
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610270077
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

I apologize for having kept this patch queue for so long before posting :/

The following changes since commit ab2e62917cab5fcf2c9abf9289d58ac263092e44:

  Merge tag 'pull-tcg-20261025' of https://gitlab.com/rth7680/qemu into staging (2026-10-27 09:22:37 -0500)

are available in the Git repository at:

  https://github.com/philmd/qemu.git tags/hw-misc-20261027

for you to fetch changes up to 17dd01a63b1657259ceac7eda9de370b946e892f:

  qemu/arch-defs: increase width of QEMU_ARCH_* masks enums to be 64 bits (2026-10-27 20:21:55 +0100)

Ignoring:

  ERROR: line over 90 characters
  #39: FILE: scripts/checkpatch.pl:1892:
  +				my $tag_space = not ($line =~ /^\s*fixes:? [0-9a-f]{5,40}/i);

and:

  tcg/sparc64/tcg-target.c.inc: In function 'tcg_out_movi_int':
  tcg/sparc64/tcg-target.c.inc:477:24: error: argument 2 null where non-null expected [-Werror=nonnull]
    477 |                        tcg_tbrel_diff(s, NULL));
        |                        ^~~~~~~~~~~~~~
  In file included from include/tcg/tcg-op-common.h:11,
                   from ../tcg/tcg.c:41:
  include/tcg/tcg.h:913:25: note: in a call to function 'tcg_tbrel_diff' declared 'nonnull'
    913 | static inline ptrdiff_t tcg_tbrel_diff(TCGContext *s, const void *target)
        |                         ^~~~~~~~~~~~~~
  cc1: all warnings being treated as errors 

----------------------------------------------------------------
Misc HW patches

- Don't complain about spaces before 'Fixes' tags in scripts/checkpatch.pl
- Various fixes (SD card, i.MX, SH4 UART, CAN, PCIe, ...)
- Widen QEMU_ARCH_* and arch_bitmask to 64-bit
- Remove deprecated 'debug-threads' option for -name
- MAINTAINERS updates
----------------------------------------------------------------

Bernhard Beschow (43):
  hw/watchdog/wdt_imx2: Preserve own locked bits in WCR
  hw/watchdog/wdt_imx2: Fix handling of write one once WCR bits
  hw/watchdog/wdt_imx2: Clear WDT lock on reset
  hw/watchdog/wdt_imx2: Remove redundant attributes
  hw/arm/imx8mm-evk: Fix reference count of SoC object
  docs, tests/functional: Drop redundant CLI arguments in imx8m*-evk
    invocations
  hw/arm/sabrelite: Have 4 CPUs and 1 GiB of RAM by default
  tests/functional/arm: Add console test for `sabrelite` machine
  hw/arm/mcimx6ul-evk: Have 512 MiB of RAM by default
  hw/arm/mcimx7d-sabre: Have 2 CPUs and 2 GiB of RAM by default
  tests/functional/arm: Add console test for `mcimx7d-sabre` machine
  hw/arm/fsl-imx25: Derive from TYPE_SYS_BUS_DEVICE
  hw/arm/fsl-imx31: Derive from TYPE_SYS_BUS_DEVICE
  hw/arm/fsl-imx6: Derive from TYPE_SYS_BUS_DEVICE
  hw/arm/fsl-imx6ul: Derive from TYPE_SYS_BUS_DEVICE
  hw/arm/fsl-imx7: Derive from TYPE_SYS_BUS_DEVICE
  hw/timer/imx_gpt: Wire clock control module via link property
  hw/timer/imx_epit: Wire clock control module via link property
  hw/arm/Kconfig: Select missing UNIMP in config FSL_IMX8MM
  hw/misc/Kconfig: Remove redundant USB_EHCI_SYSBUS from config IMX
  Kconfig: Extract config IMX_AVIC from config IMX
  Kconfig: Extract config IMX_GPCV2 from config IMX
  Kconfig: Extract config IMX_RNG from config IMX
  Kconfig: Extract config FSL_IMX7_GPR from config IMX
  Kconfig: Extract config FSL_IMX{6, 7}_SRC from config IMX
  Kconfig: Extract config FSL_IMX7_SNVS from config IMX
  Kconfig: Extract dedicated config FSL_IMXx_CCM from config IMX
  Kconfig: Extract config IMX_GPT from config IMX
  Kconfig: Extract config IMX_EPIT from config IMX
  Kconfig: Extract config GPIO_IMX from config IMX
  Kconfig: Extract config IMX_SPI from config IMX
  Kconfig: Extract config IMX_SERIAL from config IMX
  Kconfig: Remove config IMX
  hw/vmapple/Kconfig: Remove unused GPIO_PWR dependency
  hw/arm/fsl-imx8m: Fix typo
  hw/misc/imx6_src: Avoid casting from void *
  hw/char/imx_serial: Avoid casting from void *
  hw/intc/imx_avic: Avoid casting from void *
  hw/misc/imx*_ccm: Avoid casting from void *
  hw/usb/imx-usb-phy: Avoid casting from void *
  hw/net/imx_fec: Trace with QOM path where easily possible
  hw/net/lan9118_phy: Trace with QOM path
  hw/watchdog/wdt_imx2: Trace with QOM path

Bin Meng (1):
  hw/sd/sdcard: Keep high-capacity memory blocks at 512 bytes

Daniel P. Berrangé (1):
  hw/arm: remove pci-bridge/pci_expander_bridge.h from virt.c

Gustavo Romero (1):
  MAINTAINERS: Update Gustavo's email address

Jamin Lin (1):
  hw/pci-host/aspeed_pcie: Fix global MSI setting during class
    initialization

Marc-André Lureau (3):
  hw/char/sh_serial: fix RDF flag clear on FIFO reset
  hw/char/sh_serial: use rx_cnt for available FIFO space
  hw/char/sh_serial: fix break detection flag

Peter Maydell (5):
  scripts/checkpatch.pl: Don't complain about spaces before Fixes tags
  hw/net/can/flexcan: Fix FLEXCAN_CRCR_MBCRC definition
  hw/net/cadence_gem: Check guest-provided queue numbers in screening
    registers
  hw/misc/allwinner-h3-dramc: Avoid shift by negative amount
  hw/display/xlnx_dp: Make assertions clearer

Philippe Mathieu-Daudé (1):
  system: Remove deprecated 'debug-threads' option for -name

Yonggang Luo (3):
  qemu/arch-defs: extract QEMU_ARCH_BIT for QEMU_ARCH_* enums
  qemu/arch-defs: Use SYS_EMU_TARGET__MAX to define QEMU_ARCH_ALL
  qemu/arch-defs: increase width of QEMU_ARCH_* masks enums to be 64
    bits

 MAINTAINERS                                 |  6 +-
 docs/about/deprecated.rst                   |  7 ---
 docs/about/removed-features.rst             |  9 ++-
 docs/system/arm/imx8m.rst                   |  2 +-
 docs/system/arm/sabrelite.rst               |  4 +-
 hw/net/can/flexcan_regs.h                   |  2 +-
 include/hw/arm/fsl-imx25.h                  |  5 +-
 include/hw/arm/fsl-imx31.h                  |  5 +-
 include/hw/arm/fsl-imx6.h                   |  5 +-
 include/hw/arm/fsl-imx6ul.h                 |  5 +-
 include/hw/arm/fsl-imx7.h                   |  5 +-
 include/hw/arm/fsl-imx8mm.h                 |  4 +-
 include/hw/arm/fsl-imx8mp.h                 |  4 +-
 include/hw/watchdog/wdt_imx2.h              |  2 -
 include/qemu/base-arch-defs.h               | 67 +++++++++++----------
 monitor/monitor-hmp-internal.h              |  2 +-
 hw/arm/fsl-imx25.c                          | 13 ++--
 hw/arm/fsl-imx31.c                          | 13 ++--
 hw/arm/fsl-imx6.c                           | 10 +--
 hw/arm/fsl-imx6ul.c                         | 10 +--
 hw/arm/fsl-imx7.c                           |  8 +--
 hw/arm/fsl-imx8mm.c                         |  5 +-
 hw/arm/fsl-imx8mp.c                         |  5 +-
 hw/arm/imx25_pdk.c                          |  2 +-
 hw/arm/imx8mm-evk.c                         |  4 +-
 hw/arm/kzm.c                                |  2 +-
 hw/arm/mcimx6ul-evk.c                       |  3 +-
 hw/arm/mcimx7d-sabre.c                      |  4 +-
 hw/arm/sabrelite.c                          |  5 +-
 hw/arm/virt.c                               |  1 -
 hw/char/imx_serial.c                        | 10 +--
 hw/char/sh_serial.c                         |  6 +-
 hw/display/xlnx_dp.c                        |  4 +-
 hw/intc/imx_avic.c                          |  6 +-
 hw/misc/allwinner-h3-dramc.c                |  2 +-
 hw/misc/imx25_ccm.c                         |  4 +-
 hw/misc/imx31_ccm.c                         |  4 +-
 hw/misc/imx6_ccm.c                          |  8 +--
 hw/misc/imx6_src.c                          |  4 +-
 hw/misc/imx6ul_ccm.c                        |  8 +--
 hw/misc/imx7_src.c                          |  4 +-
 hw/net/cadence_gem.c                        | 21 +++++--
 hw/net/imx_fec.c                            | 28 +++++----
 hw/net/lan9118_phy.c                        | 10 +--
 hw/pci-host/aspeed_pcie.c                   |  4 +-
 hw/sd/sd.c                                  | 43 +++++++------
 hw/timer/imx_epit.c                         | 14 +++++
 hw/timer/imx_gpt.c                          | 14 +++++
 hw/usb/imx-usb-phy.c                        |  4 +-
 hw/watchdog/wdt_imx2.c                      | 29 +++------
 system/arch_init.c                          |  4 +-
 system/qdev-monitor.c                       |  2 +-
 system/vl.c                                 | 13 +---
 tests/qtest/migration/framework.c           |  4 +-
 tests/qtest/migration/precopy-tests.c       |  2 +-
 hw/arm/Kconfig                              | 57 +++++++++++++++---
 hw/char/Kconfig                             |  3 +
 hw/char/meson.build                         |  2 +-
 hw/gpio/Kconfig                             |  3 +
 hw/gpio/meson.build                         |  2 +-
 hw/intc/Kconfig                             |  6 ++
 hw/intc/meson.build                         |  3 +-
 hw/misc/Kconfig                             | 41 +++++++++++--
 hw/misc/meson.build                         | 24 ++++----
 hw/net/Kconfig                              |  2 +-
 hw/net/trace-events                         | 33 +++++-----
 hw/ssi/Kconfig                              |  4 ++
 hw/ssi/meson.build                          |  2 +-
 hw/timer/Kconfig                            | 10 +++
 hw/timer/meson.build                        |  4 +-
 hw/vmapple/Kconfig                          |  1 -
 hw/watchdog/trace-events                    |  8 +--
 qemu-options.hx                             |  7 +--
 scripts/checkpatch.pl                       |  2 +-
 tests/functional/aarch64/test_imx8mm_evk.py |  4 +-
 tests/functional/aarch64/test_imx8mp_evk.py |  4 +-
 tests/functional/arm/meson.build            |  4 ++
 tests/functional/arm/test_mcimx7d_sabre.py  | 46 ++++++++++++++
 tests/functional/arm/test_sabrelite.py      | 46 ++++++++++++++
 79 files changed, 502 insertions(+), 287 deletions(-)
 create mode 100755 tests/functional/arm/test_mcimx7d_sabre.py
 create mode 100755 tests/functional/arm/test_sabrelite.py

-- 
2.55.0


