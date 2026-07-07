Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFAF9C43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 15:14:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh7Un-0007NR-5c; Tue, 07 Jul 2026 11:14:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wh7Um-0007NH-14
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 11:14:00 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wh7Uk-000781-0I
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 11:13:59 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 667C9Lox3740874
 for <qemu-devel@nongnu.org>; Tue, 7 Jul 2026 15:13:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=zDxq1SLIn9cg/3FIJOvmmw
 KGaFU/hR+myBWOeDDalGs=; b=FgdcAr/RI1CMoDziS6CK3VnsU30MUI69C9xGDF
 ZhXunIkQR4hKNUXLJ3h4bqbaW9Z/vgStvoqci90H2aNhuX68zkNPwpPSpSTXgbtC
 cTs6WM/yDGIG70bHn8d/KYSGfvq5ygDxaSQVHZEaIcablo1WlamhWiBAaNk/zu6c
 2UQtIeK3CIT54SRhz67JhISVAzouBhJ1ZpMj7klyr0Czr2/gLmQDUIiTLPYb4D32
 vXzs3SJ1Wika03VfW7ai+j4YTbFkQZ0TiJCVp3zmy8JYQxCr0NP8anzqj1+Is9LE
 sboPuKahdETDs/DhehekgnBtdQFRgnwWIK0Juo8KmGkrWzZA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8v9aa51w-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 15:13:55 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51c0f0a0760so85776651cf.2
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 08:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783437235; x=1784042035; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=zDxq1SLIn9cg/3FIJOvmmwKGaFU/hR+myBWOeDDalGs=;
 b=OJxYEeule1wFQ9omo5R5YL4nChmUgIJAL84skEoSpmO3bt2zC+WMC7FLEb9rIJwVhC
 Dz0RLbBxHSFZNkym72arl92GvZYbIbINL2G47PI6Wpm50O5IOGzS4NIKnmn9wDgVboSl
 Tx6nkDYVJTZVAXiwa2anTfnIwkoYJ9VLTr6wHyFYrtPiSyxUfwYc5XSvVu+7GQkjxP4O
 QmgdFDsvh2ouc4m7xPk17FBB+vIDpzJ0SPUMzZxoldRKxCSswevahp9MQuthl86jadDX
 qAM8KpsjLgQzmggUVnu06XqCd0vyECZ+xUlh7u6OwsRyN6laXU6WNEzNHQdyCdVknIPD
 osxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783437235; x=1784042035;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zDxq1SLIn9cg/3FIJOvmmwKGaFU/hR+myBWOeDDalGs=;
 b=Wwe/gecjRcfzSZ4028gu6GjKgVvwgRhcj5SECZUi9cEA+TeMgMh3BF9NbTJnf8Lk2q
 1+Sso17sekAdkQ0sCXyXnSx5A554V33UGgseUG943T4c7NbmcDlG/k0wY0jLloaI0AVJ
 WnVHkpPBy2P9GGGOJBcvzs7W6UQWiifU0yn0QHcun297wbIOkjfDN2bOqfsrhc6gNJs+
 tY1z/fOH0+QiNjVsVpyzFcDxN5bO4LAhiWWscGrxU+Pu9SpuWK5SVPbDi+IAAqhnH9u5
 AUkvFrMuiEuxNPIT9WroogkFTgeF6+JLfwKVdkQluliEcknXedJaNtbojYWpjAC8SJny
 I+xQ==
X-Gm-Message-State: AOJu0YwMrL7MM81sbI/9ogi2KwWMbcTTT3fVGB8n8uEytjPmUY9WI6OH
 ZI/2smbDr3svkhEdG9Pkj/QRf5dEKWLfBBDAHB/yhDA4kZgRenSAZ53OXRFr1h3sMhLnToo83uP
 RCsg7dReMKJE8/FFad0mSdmytz+5se5q2wbhsU7VHoSoB77E8LA40ZwqzQU/kBHQpxw==
X-Gm-Gg: AfdE7ckJQzYCcfD9+ZEeMCa+PiGvbWY4o1UusZZlgXckpSuj6iTFZyMQUKvbBVTG5GS
 ks+tM7hj5vFpJLRFII40Eg429x32Wu39qgCtwfTKaHnU1AFr0iT8Hb9wCqnC+rIWPH8EgG5qe78
 iz+IirNgeKKKFyzzBY6PIWTDYNmInlbejP6oUKA7jcSPDr6VI2QS2OwkIj79i8cbwAjDSfxf9p6
 ixepC0u8CDYEqlyRCyA8P2cnC1MMi+1Cynmfl5tMY/Y2DbhBwQEliXcVoK/I3ukgY9pgCvKoDar
 vlezNIDgeS5wK8Azq+qNb6xsA1FtvBDBVJEFKpcWy8uoVHtB6koLQPDVL9fIBa768bSAAeYyAAl
 I2IgxsQj6ZucwzbObkP8PrxJFlwnMlkyEEnptZ+epzop/lsnmoJ0y4VbP9nkBjiCnixL7
X-Received: by 2002:a05:622a:3c6:b0:51c:c67:2042 with SMTP id
 d75a77b69052e-51c748af0f5mr60381761cf.53.1783437234801; 
 Tue, 07 Jul 2026 08:13:54 -0700 (PDT)
X-Received: by 2002:a05:622a:3c6:b0:51c:c67:2042 with SMTP id
 d75a77b69052e-51c748af0f5mr60381261cf.53.1783437234014; 
 Tue, 07 Jul 2026 08:13:54 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493df7010aasm50163655e9.0.2026.07.07.08.13.52
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 07 Jul 2026 08:13:53 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 00/36] Misc HW patches for 2026-07-07
Date: Tue,  7 Jul 2026 17:13:47 +0200
Message-ID: <20260707151351.57769-1-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: sQUh1jQ9sR6gfDl5z_BOF7spTaAqjkXW
X-Proofpoint-ORIG-GUID: sQUh1jQ9sR6gfDl5z_BOF7spTaAqjkXW
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDE0OCBTYWx0ZWRfX29lBEaVPxaMZ
 AAntjejAwiq8jLxmN9MDaogwBpWn3GMO0NQdAWK/vTgJpZJmjv3V6f2ZIgCUWYB6jqpIY0FbFec
 F+ExRX2O7+KvzspmqKES5jqg09OBAHs=
X-Authority-Analysis: v=2.4 cv=b9yCJNGx c=1 sm=1 tr=0 ts=6a4d17b3 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=NEAV23lmAAAA:8 a=TXZ6irfhDgbKXUqdAp4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDE0OCBTYWx0ZWRfX3e2EztW8wXuK
 N8bkuEbRy2LzXx1riTogGKdHuJtaRum18eYIo4/5m8NBFUbn+PFOPFfuZKcNRPCigyvod1pmS6R
 Lg1osOfkPeDw3ToKGyQZsAXxr9sZnYHG73mqFZJ9jtL1ub5vzmKji3yZYSXHweM8CuyCpnft/9H
 wwqruGTFkevZmCccqvUrcTQbPJZcQa21CoXygITindiCIND5EyIleOCSg4ovBlrh4wT3G1pM/mr
 W16S8zOC40+UCKRgZL8Vt0x5V2TTJsghVN9Pv6lWSTmop2zRSeAFIC8a8/mi3Im1sd6ufngngQQ
 ulK/sw5J2MbQ1Y2IVHj1KcAo1gY3c5G/Q5smBs6Vnhk/32igveWbH0pYZOOi0lPfRZ1m0n5Kb6N
 6PpNTO7wxj0QRAd55HAdWyJnybRAZifDwX51mz4U9sraNp4kupCM9IRG9P0dNBvZYonIQJPBeT4
 lx36HmkjH8CISkCv/Hw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 priorityscore=1501 adultscore=0 malwarescore=0
 bulkscore=0 spamscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070148
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

for you to fetch changes up to 01e53bea65945c483dbcfa02793f68463886fbe3:

  MAINTAINERS: update Chao Liu's email address (2026-07-07 17:11:52 +0200)

----------------------------------------------------------------
Misc HW patches

- MAINTAINERS update
- Fix in few trace event formats
- A pair of improvements in util/
- FlexCAN3 to imx8mp-evk board
- Various fixes in hw/
  (EDU, ATI VGA, IDE AHCI, PCA9552, i8257 DMA,
   e1000e/igb, MPT SAS, Hyper-V, QXL, M25P80)

v2:
- Missing IDE AHCI Qtest
- MSF2 M25P80 fix from Cédric
- Update Chao Liu email
----------------------------------------------------------------

BALATON Zoltan (1):
  hw/display/ati: Include vga state in the blit context

Bernhard Beschow (5):
  hw/net/can/flexcan: Wire clock control module via link property
  hw/net/can/flexcan: Subclass TYPE_CAN_FLEXCAN
  hw/arm/imx8mp-evk: Open code DEFINE_MACHINE_AARCH64
  hw/arm/imx8mp-evk: Introduce FslImx8mpEvkState
  hw/arm: Add basic FlexCAN3 support to TYPE_FSL_IMX8MP and imx8mp-evk

Bin Meng (9):
  hw/block: m25p80: Fix dummy byte handling for Winbond flash
  hw/block: m25p80: Fix dummy byte handling for Numonyx/Micron flash
  hw/block: m25p80: Fix dummy byte handling for Macronix flash
  hw/block: m25p80: Fix dummy byte handling for Spansion flash
  hw/ssi: npcm7xx_fiu: Correct the dummy cycle emulation logic
  hw/ssi: xilinx_spips: Fix dummy phase handling
  hw/ssi: aspeed_smc: Fix direct-read dummy bytes
  Revert "aspeed/smc: Fix number of dummy cycles for FAST_READ_4
    command"
  Revert "aspeed/smc: snoop SPI transfers to fake dummy cycles"

Chao Liu (1):
  MAINTAINERS: update Chao Liu's email address

Cédric Le Goater (1):
  hw/arm/msf2-som: Fix spansion-cr2nv value for S25FL128S

Denis V. Lunev (2):
  hw/ide/ahci: cancel in-flight buffered reads on command engine restart
  tests/qtest/ahci: test ATAPI read completing after engine restart

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

 MAINTAINERS                   |   6 +-
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
 hw/arm/fsl-imx8mp.c           |  38 +++++++++
 hw/arm/imx8mp-evk.c           |  64 +++++++++++---
 hw/arm/msf2-som.c             |   2 +-
 hw/block/m25p80.c             | 154 ++++++++++++++++++++++------------
 hw/display/ati.c              |   2 +
 hw/display/ati_2d.c           |  44 +++++-----
 hw/display/qxl-render.c       |   8 +-
 hw/dma/i8257.c                |  13 +++
 hw/gpio/pca9552.c             |   8 +-
 hw/hyperv/hyperv.c            |   4 +-
 hw/ide/ahci.c                 |   3 +
 hw/intc/loongarch_dintc.c     |  13 +++
 hw/isa/lpc_ich9.c             |   1 +
 hw/misc/edu.c                 |  24 +++---
 hw/misc/imx8mp_ccm.c          |   3 +
 hw/net/can/flexcan.c          |  90 ++++++++++++++++----
 hw/net/net_tx_pkt.c           |   7 +-
 hw/rtc/mc146818rtc.c          |   4 +-
 hw/scsi/mptsas.c              |   4 +
 hw/ssi/aspeed_smc.c           | 135 ++++-------------------------
 hw/ssi/npcm7xx_fiu.c          |  25 ++----
 hw/ssi/xilinx_spips.c         | 123 +++++++++++++++++++--------
 tests/qtest/ahci-test.c       |  67 +++++++++++++++
 util/filemonitor-inotify.c    |  28 ++-----
 util/module.c                 |   2 +-
 backends/trace-events         |   2 +-
 hw/arm/Kconfig                |   1 +
 hw/ssi/trace-events           |   1 -
 39 files changed, 579 insertions(+), 334 deletions(-)

-- 
2.53.0


