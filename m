Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1C1606A31E
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 08:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=THkxj8Eh;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=XWUZt7mS
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLzCc-0002xH-Pv; Wed, 28 Oct 2026 04:40:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLzCb-0002wK-7h
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 04:40:09 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLzCW-0000mX-8M
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 04:40:07 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69S8K8Hc253377
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 08:40:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=azQf1STaKpnYizRi3PZf0f
 R2r4IKD7Fep5PuyozTTV0=; b=THkxj8Ehn4k3xJH02m95hgP6pIi0iU9onZth0w
 MqwtEA8sVgOrMjH/sPju8eQxqSxNaCFVVhYOuZ9JaSpvk5FF1g+4ksUfTNBcRKjO
 7z8gjm0gNwrvJZ1KNGt1Cf0UzIeqofsa77cWjnnDzDaiDPfd3BivvoZsSn+DsIro
 UKwWq5cipuJgh6vewizb7ZcB4BMQRvFba2m0eqef02w8yWTgvFe9FSaOlb5PX7m2
 gFaZddLN3pm/vQgOKEG5kvCvWDJl76Kza9itoY4294oj7MNIEfdD9FmQVVyl5SI0
 umgQr8N1xvXJpaBPEjMzA331/0eISDtcBYx9YLn03fsS6Bfg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hk6be1jpk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 08:40:01 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93f33438950so143952385a.1
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 01:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793176801; x=1793781601; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=azQf1STaKpnYizRi3PZf0fR2r4IKD7Fep5PuyozTTV0=;
 b=XWUZt7mScX9WSDmyoOKgxp2Zr7WDIztn3T/msYbFLkw/XxvD4CbCULMIAntPwD5duW
 bveuvsgZITh5Ob4a1A5MvxTJMdZ0uYNcDA0AHtyotr5TBrBEMp5eb1xshYhAQn9pO+FL
 pKdXlerZarA03Sv2Dl9b78LzmBVgEq3qQlpk+8BRxlEMVIGrXiRrYbVIqvjd2U7RCK2Y
 ly+3e8kxVvh7lQnhx/qOc3EpI/41Hh4CQ37HQ5g2/9e91Rc3mRkAfYzFIlxZ2zafdGbE
 gwdSRSqui7g0ank5Q8SQNuZXfOgRp9AuG9T2uQxWU2fgIlkKHhrNzCBkIzoHnMFGqbkK
 ncVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793176801; x=1793781601;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=azQf1STaKpnYizRi3PZf0fR2r4IKD7Fep5PuyozTTV0=;
 b=O0DhdhdbU8EJD1HerE6zdwhzq69/Q5YxWXAQNMlp0HtcplodbPe9o2NCUw7jkQujhY
 8KuSTwXX1J9Z1b1cYKS6OtcumunVqhZdRsIgSfE6gJCK6K+fzj2TKrocx6+COdjyi1Cu
 2Ek6WgxLEfG1PM6UA/ZexXbp2yHFLOgzxz9nkOkcuve27fZ/xHhhZRSRYxZBGh0ydnYA
 +UnlcKTiYVtWJ4NgR9QHU+nss86BWb+DcDjWpQwW6/zWyovFThy+MojVS+cOW/OG0xW5
 FYZDnc/uQML/1pvo95U0GUVh7b3OuehlVfchRWMTMYoWaQkehbk4Opd751/SIfnTNhnN
 zD8A==
X-Gm-Message-State: AFq9FYLJX4XVpE80ICJrZv51Z2Pwb92mlcqwD2piic4nG7lB46TA9Kjh
 szrlDKqwqCk7iiiyNpnRmhyXXXE0kbq7IQp0IZH6dugx7swTg1DvxWpZrRX03u2dtbE+nB41Dsp
 M80EXc9qatzBZhuTS6yEurxfv9G0NkOyZXYJHmY2dwAW1H3E1OVkgvdG58OArDq9owg==
X-Gm-Gg: AYBFou1RkHErUKDfNsWkXfGS6e8C+18EqVYeRgodT7Z1U9+FEKVTBqOQ5Gc+izrBv8I
 29U9UcEqwEwp0hTv9Y4t7ss7S9Axc8YACh8vXp9n6a7AoWDX18OBAC1p39sPnkWSgzNHJ+o9YM2
 UfXlGqsIgp6YwTtOd2MTm4//Eln/2KN00TcQX5O1vXENI2XXK1qOdhjXv0Nq0snmxlCfcEhAO4j
 ug40LowclDXrXwLd05fE3EBMTpyhiKXULGqmXlXxUhU9r3yAorK0c34npJQKbevDsFxgP0JGhC0
 pXK94d+1TuF0iiiXCaXqbbS2VhTKFIvpRpdcuP0ROe1A+MRPADzy1sqKOSF+3Shb8vyzeMuEhJ8
 nKGDH/91C/nDX1vqL7XjyXKmXFoJHLQuKdKFLTVxwYhuSS0oSvmjjCn0qd6AvM8ICdKL09ctmBd
 zj7jhOX9VFpU+VAA5tK3GNIzfhEn5ndQ==
X-Received: by 2002:a05:620a:1789:b0:93f:5843:1055 with SMTP id
 af79cd13be357-94408cb4e30mr207143185a.13.1793176801016; 
 Wed, 28 Oct 2026 01:40:01 -0700 (PDT)
X-Received: by 2002:a05:620a:1789:b0:93f:5843:1055 with SMTP id
 af79cd13be357-94408cb4e30mr207139885a.13.1793176800364; 
 Wed, 28 Oct 2026 01:40:00 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ecd3c32sm28034553f8f.47.2026.10.28.01.39.59
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 28 Oct 2026 01:39:59 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 00/59] Misc HW patches for 2026-10-27
Date: Wed, 28 Oct 2026 09:39:58 +0100
Message-ID: <20261028083958.75340-1-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: ULRbZNr8TMtinUgs0ESsplmJU84Tao3v
X-Authority-Analysis: v=2.4 cv=HeuB3SE8 c=1 sm=1 tr=0 ts=6ae1b4e1 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=p0WdMEafAAAA:8 a=NEAV23lmAAAA:8 a=bdAztKToEkM9brp92i0A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDAzNCBTYWx0ZWRfXxYzMFoM0eP4m
 87kfzn5rQCBoM9xRHbTe8WsY7OyLmcc6qkdQmbPp6YlW4B57iXKBD0s3ygVK2BhxyGAl/IPzL8s
 n9PJB/M6/mQ/1U/c9vOyMaLP6FciAnI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDAzNCBTYWx0ZWRfXyGr4E0lVsAsV
 Kao5uSOLbMsGOPPDDmiGkD9noNrPlEVC/U4l3nRzxXFoDlIUrXhNwIS4WNS3HelnSQaQE5XgzpK
 7fI8H+Pj+/LID8ay+SAmTy26v5bU2PTWNjDMcpFvGM3R2tSl/zeYi+C4qrp/uUbtFn7IgFMi8hx
 4a1v3qj0B6TRfzO1bDr+MaGhz6w0ypphTFYYNdQixlvVAC+zNjLRGaAtVeipqZjbBUqOvrGxu6T
 cHj+0lkQY2RJufB/F5NMB0sIy596FnL6q6JlUidwdANea2PBXyblBpFqa9L1OgINIP37+zoNyIL
 fiaiDFwTXsSDWCBes02vHuNMIihUeeLaBLxSPnnFjvsK1paf6wq+6bBAWTiuSj7EXNlIaGv7OKm
 KJoIH6Jm/oFUb83DjPIWx/2PYiH1draONjrbnaHKwnkscA3KYay0fXcmfPpHDM3sLQvjcmHjBmT
 kKE/oeeYL8AOWNIIcEg==
X-Proofpoint-GUID: ULRbZNr8TMtinUgs0ESsplmJU84Tao3v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 phishscore=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610280034
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

v2: Do not remove deprecated 'debug-threads' option

The following changes since commit 29b1dc631d6ac6bfc39464e0be8bf4cad556a591:

  Merge tag 'block-pull-request' of https://gitlab.com/stefanha/qemu into staging (2026-10-27 20:02:57 -0500)

are available in the Git repository at:

  https://github.com/philmd/qemu.git tags/hw-misc-20261027

for you to fetch changes up to 8930d9cca2f830565da6483128414f9a38e4d8d8:

  qemu/arch-defs: increase width of QEMU_ARCH_* masks enums to be 64 bits (2026-10-28 09:25:48 +0100)

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

Yonggang Luo (3):
  qemu/arch-defs: extract QEMU_ARCH_BIT for QEMU_ARCH_* enums
  qemu/arch-defs: Use SYS_EMU_TARGET__MAX to define QEMU_ARCH_ALL
  qemu/arch-defs: increase width of QEMU_ARCH_* masks enums to be 64
    bits

 MAINTAINERS                                 |  6 +-
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
 system/vl.c                                 |  2 +-
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
 scripts/checkpatch.pl                       |  2 +-
 tests/functional/aarch64/test_imx8mm_evk.py |  4 +-
 tests/functional/aarch64/test_imx8mp_evk.py |  4 +-
 tests/functional/arm/meson.build            |  4 ++
 tests/functional/arm/test_mcimx7d_sabre.py  | 46 ++++++++++++++
 tests/functional/arm/test_sabrelite.py      | 46 ++++++++++++++
 74 files changed, 489 insertions(+), 260 deletions(-)
 create mode 100755 tests/functional/arm/test_mcimx7d_sabre.py
 create mode 100755 tests/functional/arm/test_sabrelite.py

-- 
2.55.0


