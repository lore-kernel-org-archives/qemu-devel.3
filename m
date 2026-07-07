Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FD22C43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 13:12:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh5bI-0000Cc-Gp; Tue, 07 Jul 2026 09:12:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wh5bH-0000CE-21
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 09:12:35 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wh5bF-0000PV-6o
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 09:12:34 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 667C8sZA3768510
 for <qemu-devel@nongnu.org>; Tue, 7 Jul 2026 13:12:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=hglY9z9DhlMTsxuYr6Gngg
 mVMP2dwKzXDhwXE1ZoQjk=; b=KGn27sqGfHHuQmsT6M8xA+v3jAklNr0NIqvOvz
 ZPwHRbADf1pBt8x88Z+J3fHvAG6GEASHoF84KD4CmaCxRWCa2JUL2xAE23dt9V0U
 fiVIrU80hQYGmbLFCReaRlpxCsFJBpurjSzrGRWOq8JqdDQkQ4pR90RSmq/lPSGK
 VjFZgZQYe4GDKBkpbG0Mb7Nb+jsDHH2y7E2X91LzLXuKdVws5zlBPWbvd6yaSB1E
 6cdY7/Q7WB4m08U8OolwoXEgi4VBby0QFjlbTXI6zXcpf8Gh6nuL1zPBQPpCt+y7
 aPovRkVXCUFNw2dHmEFqBUKGGqJWA04N2iwjwVFuOX4jLMTA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8qj7ajrv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 13:12:31 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-51c1e6f602cso72729661cf.3
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 06:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783429951; x=1784034751; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=hglY9z9DhlMTsxuYr6GnggmVMP2dwKzXDhwXE1ZoQjk=;
 b=kZj5xFGYi517vs9KqQtCXqEtNv0cFZ5T7dOE5oWrU+/qalM0HG+5SEqEYrrKPWGLwS
 Lg2LoVPvlDDfCjtmZNfqWTxTHA/4fzQ7X9+foWzKIdplrNbbO/yK0xhr8cFANlijQY/G
 LjOvgx9N76erYVZlE6YE3T0H5sEuVO+VEVdiSQfKpafsdQxAYQLCNcVybCZKtHufmD7w
 iyHyFnLf5Eqvi0ZpZsWX+uatqloZq3SGWi64triOtrjJlFREHcyN+rNBg3ZLKqidiAjr
 b/1zC3kcTy0uYTorUDVXk2vmIUJ3hyuf4WeaiTZpBKPL1MsIl8sCyXPB6Fa9B6wbQGqs
 E9QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783429951; x=1784034751;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hglY9z9DhlMTsxuYr6GnggmVMP2dwKzXDhwXE1ZoQjk=;
 b=UzbM6yXazVR3/EUNG7AJNqv51s0/TZ/KC1EiU3I09J2PvSa4sm1N/4EEQLThBrBerm
 kPZLn4wfFc3JzYRIU7PQBmR8XgYqjYOMCxGDt77qV6bDgCyZd/bRZ0IRuEgIjUq/v2OT
 cvuWjDz+n4l7k22JIM8I+6wfsO7eKgsMmWakhpBU8f9ZdbiAilpf5/M90GZwa518caEi
 hZm5uUdTQcFRIeFlQ3nLxhh9s98+HTbV5rX/FmzUseg6+M4ff62ok+qra7Bqp7IwMBUH
 9bTAE8+1s4w3vJwtdkrlm61wz7YMC6JMQPZ2IzxEftPXhYXfBiSSVHRZnJKU3U/pFQUF
 A9+Q==
X-Gm-Message-State: AOJu0YyiAnFjiruT8xF0MRvIW/0+A6tJ+hQH+/hnwL7Jiz2fV2aEKjOn
 +WlbbMBqDI5jrE8Hfu+EnKKMJ56WTBYOFUL25DTG63Wxb141xhU6rX1S/D6vwm9C2HrcJg197cA
 A+mnKcCx9KUkbYs3qHeEKznGU3jH6RCpDZLQIiRgWTkD2VB42Ks3Rj/hNEq6hG9Gwjw==
X-Gm-Gg: AfdE7clN6ipwsT6pGJFpmB77cJeJtV+P3T/T+HGif4NEIMvouu0yqXrp7vKQrgMVQFs
 DZMYkwQaJ9TsHN0Z7/8rAN0ZEJNYDTaO2gNcMVUF8gchN9+xjMSgtD4RBB/YedjjMcY/Fle6dXa
 9xHump9WVKNJaSLo8h2Cw9vcwj53hN0w/DDufu0D4TwGqNI7T6Q3JG/FnGnyySBJ7SPCn6cy4Sw
 rZ6KDMrOIccbbFMg3xWjG6AIsNMuMbx/oN18qnKxbJYFO1eftvD2fD9cqYWFgARjV85dJ7Rrqs1
 5filML28mSPGV2gk8QMw6A9EKhpLWmY0Ec6JNboeRUPiNTeHN2XCa6x+5EYlQdE7b6DZ31rpNXC
 fBejIHqWoyBNSCkbSD/vhGEr9R7nW5yLdBuHTbLYbsOaVw3oCdbAfe6iunnG1A1Cf6j1g
X-Received: by 2002:ac8:5dd1:0:b0:51c:11ba:c51e with SMTP id
 d75a77b69052e-51c748b56famr53010401cf.56.1783429945618; 
 Tue, 07 Jul 2026 06:12:25 -0700 (PDT)
X-Received: by 2002:ac8:5dd1:0:b0:51c:11ba:c51e with SMTP id
 d75a77b69052e-51c748b56famr53009821cf.56.1783429945038; 
 Tue, 07 Jul 2026 06:12:25 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c15ad84a8absm136704666b.18.2026.07.07.06.12.24
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 07 Jul 2026 06:12:24 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/32] Misc HW patches for 2026-07-07
Date: Tue,  7 Jul 2026 15:11:50 +0200
Message-ID: <20260707131223.51505-1-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: qWgnXobKv84LHtU58uFbxfuoLMc-hWSt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDEyOCBTYWx0ZWRfX1JX4RsZ8b7ov
 UsDkA9Ja8Rb6G2W6MMY/Svwj588XW5F5AHesGptHWNbVrkZ0Jf8nSlp8edNSsEG19uyzfRec3Jq
 aQJL0tlPrf7asmC85IqyOommTNXBTBwfWzUA31no2WgtulyUpzQ9M+EF832h0WQf35kbyIG4kIN
 9FsQq+1Ymq0e6xD0WwntrTBtxnVbcA9uvXTdimsO0FE2x1PcWz/ck+uJtqL5hKv+hN7VpIcdbZg
 TBbqNyQUkK6fvINAYLCDIRFPuviqrTb78jpZate58kpubHunyb7PdJgFzJFZpUfsZS31A1CmkgX
 C4IhE+N4tk43ki4iav7XkBTrHRE/I01xUtWnstM4HQqDJvjHAbVzpaGS8D61WNxZhdj8Tei33lR
 cnmA7mp18NbvDFJI51xsLc14aB6MvTohiLlDf8Wa5SLqSwQMwcNBOzKrthqxBw9hxTWpDLsrDAh
 6SA1xu6quHoEJPbphNw==
X-Authority-Analysis: v=2.4 cv=PIM/P/qC c=1 sm=1 tr=0 ts=6a4cfb3f cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=NEAV23lmAAAA:8 a=SFspyduigjFL_68jv5EA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDEyOCBTYWx0ZWRfX/jTzDWRriD9p
 8/YYOKxfWrmHoSs5L/DnX8kDsAoDli7PxqwyhqcrzcfQS10FOMRAm1/Bjay4VOmdmaAOIdiqgXc
 9sY3Y42dxq0ggMJNH325EHir/ybJXFI=
X-Proofpoint-GUID: qWgnXobKv84LHtU58uFbxfuoLMc-hWSt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 impostorscore=0 malwarescore=0 adultscore=0
 phishscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070128
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

The following changes since commit 94826ec1370328375c3b6d1e80fdc94c8f46c348:

  Merge tag 'accel-20260706' of https://github.com/philmd/qemu into staging (2026-07-06 18:38:14 +0200)

are available in the Git repository at:

  https://github.com/philmd/qemu.git tags/hw-misc-20260707

for you to fetch changes up to 04584a27dd59741bc20272c6faab96c08bcbb926:

  Revert "aspeed/smc: snoop SPI transfers to fake dummy cycles" (2026-07-07 15:08:41 +0200)

----------------------------------------------------------------
Misc HW patches

- Fix in few trace event formats
- A pair of improvements in util/
- FlexCAN3 to imx8mp-evk board
- Various fixes in hw/
  (EDU, ATI VGA, IDE AHCI, PCA9552, i8257 DMA,
   e1000e/igb, MPT SAS, Hyper-V, QXL, M25P80)
----------------------------------------------------------------

BALATON Zoltan (1):
  hw/display/ati: Include vga state in the blit context

Bernhard Beschow (5):
  hw/net/can/flexcan: Wire clock control module via link property
  hw/net/can/flexcan: Subclass TYPE_CAN_FLEXCAN
  hw/arm/imx8mp-evk: Open code DEFINE_MACHINE_AARCH64
  hw/arm/imx8mp-evk: Introduce FslImx8mpEvkState
  hw/arm: Add basic FlexCAN3 support to TYPE_FSL_IMX8MP and imx8mp-evk

Bin Meng (8):
  hw/block: m25p80: Fix dummy byte handling for Winbond flash
  hw/block: m25p80: Fix dummy byte handling for Numonyx/Micron flash
  hw/block: m25p80: Fix dummy byte handling for Macronix flash
  hw/ssi: npcm7xx_fiu: Correct the dummy cycle emulation logic
  hw/ssi: xilinx_spips: Fix dummy phase handling
  hw/ssi: aspeed_smc: Fix direct-read dummy bytes
  Revert "aspeed/smc: Fix number of dummy cycles for FAST_READ_4
    command"
  Revert "aspeed/smc: snoop SPI transfers to fake dummy cycles"

Denis V. Lunev (1):
  hw/ide/ahci: cancel in-flight buffered reads on command engine restart

Dmitry Frolov (1):
  utils/module: fix memleak in module_load()

Evgeny Kolmakov (1):
  util/filemonitor-inotify: Use QEMU_LOCK_GUARD()

Junjie Cao (2):
  hw/display/ati: reset host_data.next in write handler after flush
  hw/display/ati: guard against zero bpp in ati_host_data_flush

Mark Cave-Ayland (2):
  hw/rtc/mc146818rtc: convert date from object prop to class prop
  hw/acpi/ich9: move initial property values into
    ich9_reset_properties()

Peter Maydell (3):
  hw/dma/i8257: Return zeroes for read_memory in verify mode
  hw/scsi/mptsas: Reset doorbell state on reset
  hw/hyperv: Avoid crash if hyperv_find_cpu() passed invalid vp_index

Sanjeeva Yerrapureddy (1):
  hw/net: fix e1000e/igb ip_len inflation by Ethernet minimum-frame
    padding

Shameer Kolothum (1):
  backends/iommufd: Fix dev_id and type order in viommu trace

Song Gao (1):
  hw/intc/loongarch_dintc: Fix OOB access in DINT MMIO write handler

Thomas Huth (1):
  hw/display/qxl: Fix mono cursor validation that can read past a cursor
    chunk

Torin Carey (1):
  hw/misc/edu: restrict dma access to dma buffer

yujun (3):
  hw/gpio/pca9552: fix off-by-one in QOM led index validation
  ebpf: fix swapped toeplitz/indirection args in set_data trace
  crypto/x509-utils: fix gnutls error code in crt_init failure path

 docs/system/arm/imx8m.rst     |   1 +
 include/hw/acpi/ich9.h        |   2 +
 include/hw/arm/fsl-imx8mp.h   |   8 ++
 include/hw/net/flexcan.h      |   4 +-
 include/hw/ssi/aspeed_smc.h   |   2 -
 include/hw/ssi/xilinx_spips.h |   2 +-
 crypto/x509-utils.c           |   3 +-
 ebpf/ebpf_rss.c               |   2 +-
 hw/acpi/ich9.c                |   8 +-
 hw/arm/fsl-imx6.c             |   5 +-
 hw/arm/fsl-imx8mp.c           |  38 ++++++++++
 hw/arm/imx8mp-evk.c           |  64 +++++++++++++---
 hw/block/m25p80.c             | 122 +++++++++++++++++++-----------
 hw/display/ati.c              |   2 +
 hw/display/ati_2d.c           |  44 +++++------
 hw/display/qxl-render.c       |   8 +-
 hw/dma/i8257.c                |  13 ++++
 hw/gpio/pca9552.c             |   8 +-
 hw/hyperv/hyperv.c            |   4 +-
 hw/ide/ahci.c                 |   3 +
 hw/intc/loongarch_dintc.c     |  13 ++++
 hw/isa/lpc_ich9.c             |   1 +
 hw/misc/edu.c                 |  24 +++---
 hw/misc/imx8mp_ccm.c          |   3 +
 hw/net/can/flexcan.c          |  90 ++++++++++++++++++-----
 hw/net/net_tx_pkt.c           |   7 +-
 hw/rtc/mc146818rtc.c          |   4 +-
 hw/scsi/mptsas.c              |   4 +
 hw/ssi/aspeed_smc.c           | 135 +++++-----------------------------
 hw/ssi/npcm7xx_fiu.c          |  25 ++-----
 hw/ssi/xilinx_spips.c         | 123 ++++++++++++++++++++++---------
 util/filemonitor-inotify.c    |  28 ++-----
 util/module.c                 |   2 +-
 backends/trace-events         |   2 +-
 hw/arm/Kconfig                |   1 +
 hw/ssi/trace-events           |   1 -
 36 files changed, 488 insertions(+), 318 deletions(-)

-- 
2.53.0


