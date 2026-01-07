Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C865D0D170
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 20:40:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdaJZ-0004Qa-2f; Wed, 07 Jan 2026 15:39:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1vdaJW-0004Kv-PK; Wed, 07 Jan 2026 15:39:30 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1vdaJT-0000Bo-N5; Wed, 07 Jan 2026 15:39:30 -0500
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 6079lop4028692;
 Wed, 7 Jan 2026 20:39:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=32qijb
 f9MdBjMk+G6RSsXgDZlKtJ6BFyYRPEK4SSnC8=; b=mTj+rR7pD4+NBp2mMIhiOv
 whOiB53ftCZ6MjKfORxqVHbpR7E0kcYgYi3Qz+lhelSzD16j0XtGdgoijdbO4n93
 9lY8u+wZY5kiIKsCJ/vnEoIuJFAX3MmuBVA2u9VFnEcqdGEeXCvlmLC62M8zkXps
 zCSmU5P+NkltUw6KkhS0cnHV5/WaP2A1jiHnttb3ESvJIf2kLCKasL0PGAGmn4TW
 y0XPiGckIyyYKxvwHer9djdpGAnV6Tyon4hMCJZVLKFMcQjLCsO2DBfGUOE0sLqL
 hRziUKDzTZ/1Yo+K0CLdzDpucmt/1bfrGWA+oWDBw/H20JKxekA+0acLyar9GZ5w
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4betm7b7pc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 07 Jan 2026 20:39:24 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 607I7HF2005284;
 Wed, 7 Jan 2026 20:39:23 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4bfexkb9vp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 07 Jan 2026 20:39:22 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 607KdLES10158744
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 7 Jan 2026 20:39:21 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5FA3E5805F;
 Wed,  7 Jan 2026 20:39:21 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D1E6258052;
 Wed,  7 Jan 2026 20:39:19 +0000 (GMT)
Received: from [9.61.168.21] (unknown [9.61.168.21])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
 Wed,  7 Jan 2026 20:39:19 +0000 (GMT)
Message-ID: <fb11a282-6100-4c4b-9899-6ec332e58ba0@linux.ibm.com>
Date: Wed, 7 Jan 2026 15:39:18 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/10] pc-bios/s390-ccw: Add support for virtio-blk-pci IPL
To: jrossi@linux.ibm.com, qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 thuth@redhat.com, mst@redhat.com
Cc: jjherne@linux.ibm.com, alifm@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com
References: <20251210205449.2783111-1-jrossi@linux.ibm.com>
 <20251210205449.2783111-8-jrossi@linux.ibm.com>
Content-Language: en-US
From: Zhuoying Cai <zycai@linux.ibm.com>
In-Reply-To: <20251210205449.2783111-8-jrossi@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=OdmVzxTY c=1 sm=1 tr=0 ts=695ec47c cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=d1gRInHLOWNApm_0vsUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 9VXSjjRUtgXpLMjlsGivqP35eVbSHJVm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA3MDE2MCBTYWx0ZWRfX2aFXjBbRSQcF
 3lywNNZzvV92vyUAEZ9QiiVRGBGcVxiAYo4cUdY+B7QEEYoXl1MDkF8sGOvXHr73SBt7z/ljArB
 zrCYVidoZKpOkbLn8y5GM2nnRvvKK15paywVyBXvhl5lXhzz3jXXMNMbVz7hd03MmU6SuPYIn8d
 /ZqrPspXPH2hRIvGVnbJG9FOAYphwuGfVCAKFZ8la4lt6AbgRLrco4huHzath0fV0OmOOaYJiRG
 oMCHK9/OgzG2lnNuQS+OlG9Zm6ysAWW4mUYGvjSk+dpY2ti9PsmJ94zPVIf/Te+pLtYjms2amhw
 xhTJ3NdanJ+mzCrbkHKj5q9csNNhlSOgM28RJ7G53gx+5UUclqWT9S9thZQVSidMfVp016JDLmQ
 XhJPKvSGQwM9tsdmS4Wr+zAeaq0G9b8IBG0Qz2ZmPT7Qae1YoAm4QWD2OXU3JdvieUi5nmfAOyx
 ustdgPgVaGdca/4cMDA==
X-Proofpoint-ORIG-GUID: 9VXSjjRUtgXpLMjlsGivqP35eVbSHJVm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-07_03,2026-01-07_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1011 phishscore=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2512120000
 definitions=main-2601070160
Received-SPF: pass client-ip=148.163.156.1; envelope-from=zycai@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 12/10/25 3:54 PM, jrossi@linux.ibm.com wrote:
> From: Jared Rossi <jrossi@linux.ibm.com>
> 
> Enable virt-queue PCI configuration and add routines for virtio-blk-pci devices.
> 
> Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
> ---
>  include/hw/s390x/ipl/qipl.h      |  10 +
>  pc-bios/s390-ccw/virtio-pci.h    |  79 +++++++
>  pc-bios/s390-ccw/virtio.h        |   1 +
>  pc-bios/s390-ccw/main.c          |  60 +++++-
>  pc-bios/s390-ccw/virtio-blkdev.c |   3 +
>  pc-bios/s390-ccw/virtio-pci.c    | 360 +++++++++++++++++++++++++++++++
>  pc-bios/s390-ccw/virtio.c        |   5 +
>  pc-bios/s390-ccw/Makefile        |   2 +-
>  8 files changed, 517 insertions(+), 3 deletions(-)
>  create mode 100644 pc-bios/s390-ccw/virtio-pci.h
>  create mode 100644 pc-bios/s390-ccw/virtio-pci.c
> 
> diff --git a/include/hw/s390x/ipl/qipl.h b/include/hw/s390x/ipl/qipl.h
> index 8199b839f0..5c7779a1c3 100644
> --- a/include/hw/s390x/ipl/qipl.h
> +++ b/include/hw/s390x/ipl/qipl.h
> @@ -22,6 +22,7 @@
>  
>  #define S390_IPL_TYPE_FCP 0x00
>  #define S390_IPL_TYPE_CCW 0x02
> +#define S390_IPL_TYPE_PCI 0x04
>  #define S390_IPL_TYPE_PV 0x05
>  #define S390_IPL_TYPE_QEMU_SCSI 0xff
>  
> @@ -105,6 +106,14 @@ struct IplBlockQemuScsi {
>  } QEMU_PACKED;
>  typedef struct IplBlockQemuScsi IplBlockQemuScsi;
>  
> +struct IplBlockPci {
> +    uint32_t reserved0[80];
> +    uint8_t  opt;
> +    uint8_t  reserved1[3];
> +    uint32_t fid;
> +} QEMU_PACKED;
> +typedef struct IplBlockPci IplBlockPci;
> +
>  union IplParameterBlock {
>      struct {
>          uint32_t len;
> @@ -120,6 +129,7 @@ union IplParameterBlock {
>              IplBlockFcp fcp;
>              IPLBlockPV pv;
>              IplBlockQemuScsi scsi;
> +            IplBlockPci pci;
>          };
>      } QEMU_PACKED;
>      struct {
> diff --git a/pc-bios/s390-ccw/virtio-pci.h b/pc-bios/s390-ccw/virtio-pci.h
> new file mode 100644
> index 0000000000..b203f37aea
> --- /dev/null
> +++ b/pc-bios/s390-ccw/virtio-pci.h
> @@ -0,0 +1,79 @@
> +/*
> + * Definitions for virtio-pci
> + *
> + * Copyright 2025 IBM Corp.
> + * Author(s): Jared Rossi <jrossi@linux.ibm.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef VIRTIO_PCI_H
> +#define VIRTIO_PCI_H
> +
> +/* Common configuration */
> +#define VPCI_CAP_COMMON_CFG          1
> +/* Notifications */
> +#define VPCI_CAP_NOTIFY_CFG          2
> +/* ISR access */
> +#define VPCI_CAP_ISR_CFG             3
> +/* Device specific configuration */
> +#define VPCI_CAP_DEVICE_CFG          4
> +/* PCI configuration access */
> +#define VPCI_CAP_PCI_CFG             5
> +/* Additional shared memory capability */
> +#define VPCI_CAP_SHARED_MEMORY_CFG   8
> +/* PCI vendor data configuration */
> +#define VPCI_CAP_VENDOR_CFG          9
> +
> +/* Offsets within capability header */
> +#define VPCI_CAP_VNDR        0
> +#define VPCI_CAP_NEXT        1
> +#define VPCI_CAP_LEN         2
> +#define VPCI_CAP_CFG_TYPE    3
> +#define VPCI_CAP_BAR         4
> +#define VPCI_CAP_OFFSET      8
> +#define VPCI_CAP_LENGTH      12
> +
> +#define VPCI_N_CAP_MULT 16 /* Notify multiplier, VPCI_CAP_NOTIFY_CFG only */
> +
> +/* Common Area Offsets for virtio-pci queue */
> +#define VPCI_C_OFFSET_DFSELECT      0
> +#define VPCI_C_OFFSET_DF            4
> +#define VPCI_C_OFFSET_GFSELECT      8
> +#define VPCI_C_OFFSET_GF            12
> +#define VPCI_C_COMMON_NUMQ          18
> +#define VPCI_C_OFFSET_STATUS        20
> +#define VPCI_C_OFFSET_Q_SELECT      22
> +#define VPCI_C_OFFSET_Q_SIZE        24
> +#define VPCI_C_OFFSET_Q_ENABLE      28
> +#define VPCI_C_OFFSET_Q_NOFF        30
> +#define VPCI_C_OFFSET_Q_DESCLO      32
> +#define VPCI_C_OFFSET_Q_DESCHI      36
> +#define VPCI_C_OFFSET_Q_AVAILLO     40
> +#define VPCI_C_OFFSET_Q_AVAILHI     44
> +#define VPCI_C_OFFSET_Q_USEDLO      48
> +#define VPCI_C_OFFSET_Q_USEDHI      52
> +
> +#define VPCI_S_RESET            0
> +#define VPCI_S_ACKNOWLEDGE      1
> +#define VPCI_S_DRIVER           2
> +#define VPCI_S_DRIVER_OK        4
> +#define VPCI_S_FEATURES_OK      8
> +
> +#define VIRTIO_F_VERSION_1      (1 << (32 - 32)) /* Feature bit 32 */
> +
> +#define VIRT_Q_SIZE 16
> +
> +struct VirtioPciCap {
> +    uint8_t bar;     /* Which PCIAS it's in */
> +    uint32_t off;    /* Offset within bar */
> +};
> +typedef struct VirtioPciCap  VirtioPciCap;
> +
> +long virtio_pci_notify(uint32_t fhandle, int vq_id);
> +int virtio_pci_setup(VDev *vdev);
> +int virtio_pci_setup_device(void);
> +int virtio_pci_reset(VDev *vdev);
> +void virtio_pci_id2type(VDev *vdev, uint16_t device_id);
> +
> +#endif
> diff --git a/pc-bios/s390-ccw/virtio.h b/pc-bios/s390-ccw/virtio.h
> index e747891a2c..cc68c2f8a9 100644
> --- a/pc-bios/s390-ccw/virtio.h
> +++ b/pc-bios/s390-ccw/virtio.h
> @@ -256,6 +256,7 @@ struct VDev {
>      uint8_t scsi_dev_heads;
>      bool scsi_device_selected;
>      ScsiDevice selected_scsi_device;
> +    uint32_t pci_fh;
>      uint32_t max_transfer;
>      uint32_t guest_features[2];
>  };
> diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
> index e82d60bbb7..562eeede63 100644
> --- a/pc-bios/s390-ccw/main.c
> +++ b/pc-bios/s390-ccw/main.c
> @@ -15,7 +15,9 @@
>  #include "s390-arch.h"
>  #include "s390-ccw.h"
>  #include "cio.h"
> +#include "clp.h"
>  #include "virtio.h"
> +#include "virtio-pci.h"
>  #include "virtio-scsi.h"
>  #include "dasd-ipl.h"
>  
> @@ -151,6 +153,21 @@ static bool find_subch(int dev_no)
>      return false;
>  }
>  
> +static bool find_fid(uint32_t fid)
> +{
> +    ClpFhListEntry entry;
> +    VDev *vdev = virtio_get_device();
> +
> +    if (find_pci_function(fid, &entry)) {
> +        return false;
> +    }
> +
> +    vdev->pci_fh = entry.fh;
> +    virtio_pci_id2type(vdev, entry.device_id);
> +
> +    return vdev->dev_type != 0;
> +}
> +
>  static void menu_setup(void)
>  {
>      if (memcmp(loadparm_str, LOADPARM_PROMPT, LOADPARM_LEN) == 0) {
> @@ -238,6 +255,9 @@ static bool find_boot_device(void)
>          blk_schid.ssid = iplb.scsi.ssid & 0x3;
>          found = find_subch(iplb.scsi.devno);
>          break;
> +     case S390_IPL_TYPE_PCI:
> +        found = find_fid(iplb.pci.fid);
> +        break;
>      default:
>          puts("Unsupported IPLB");
>      }
> @@ -276,7 +296,7 @@ static int virtio_setup(void)
>      return ret;
>  }
>  
> -static void ipl_boot_device(void)
> +static void ipl_ccw_device(void)
>  {
>      switch (cutype) {
>      case CU_TYPE_DASD_3990:
> @@ -289,7 +309,43 @@ static void ipl_boot_device(void)
>          }
>          break;
>      default:
> -        printf("Attempting to boot from unexpected device type 0x%X\n", cutype);
> +        printf("Cannot boot CCW device with cu type 0x%X\n", cutype);
> +    }
> +}
> +
> +static void ipl_pci_device(void)
> +{
> +    VDev *vdev = virtio_get_device();
> +    vdev->is_cdrom = false;
> +    vdev->scsi_device_selected = false;
> +
> +    if (virtio_pci_setup_device()) {
> +        return;
> +    }
> +
> +    switch (vdev->dev_type) {
> +    case VIRTIO_ID_BLOCK:
> +        if (virtio_setup() == 0) {
> +            zipl_load();
> +        }
> +        break;
> +    default:
> +        printf("Cannot boot PCI device type 0x%X\n", vdev->dev_type);
> +    }
> +}
> +
> +static void ipl_boot_device(void)
> +{
> +    switch (virtio_get_device()->ipl_type) {
> +    case S390_IPL_TYPE_QEMU_SCSI:
> +    case S390_IPL_TYPE_CCW:
> +        ipl_ccw_device();
> +        break;
> +    case S390_IPL_TYPE_PCI:
> +        ipl_pci_device();
> +        break;
> +    default:
> +        puts("Unrecognized IPL type!");
>      }
>  }
>  
> diff --git a/pc-bios/s390-ccw/virtio-blkdev.c b/pc-bios/s390-ccw/virtio-blkdev.c
> index 87ab9a9513..0542b4feee 100644
> --- a/pc-bios/s390-ccw/virtio-blkdev.c
> +++ b/pc-bios/s390-ccw/virtio-blkdev.c
> @@ -13,6 +13,7 @@
>  #include "virtio.h"
>  #include "virtio-scsi.h"
>  #include "virtio-ccw.h"
> +#include "virtio-pci.h"
>  
>  #define VIRTIO_BLK_F_GEOMETRY   (1 << 4)
>  #define VIRTIO_BLK_F_BLK_SIZE   (1 << 6)
> @@ -242,6 +243,8 @@ int virtio_blk_setup_device(void)
>      case S390_IPL_TYPE_QEMU_SCSI:
>      case S390_IPL_TYPE_CCW:
>          return virtio_ccw_setup(vdev);
> +    case S390_IPL_TYPE_PCI:
> +        return virtio_pci_setup(vdev);
>      }
>  
>      return 1;
> diff --git a/pc-bios/s390-ccw/virtio-pci.c b/pc-bios/s390-ccw/virtio-pci.c
> new file mode 100644
> index 0000000000..838231d86c
> --- /dev/null
> +++ b/pc-bios/s390-ccw/virtio-pci.c
> @@ -0,0 +1,360 @@
> +/*
> + * Functionality for virtio-pci
> + *
> + * Copyright 2025 IBM Corp.
> + * Author(s): Jared Rossi <jrossi@linux.ibm.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "clp.h"
> +#include "pci.h"
> +#include "helper.h"
> +#include "s390-ccw.h"
> +#include "virtio.h"
> +#include "bswap.h"
> +#include "virtio-pci.h"
> +#include "s390-time.h"
> +#include <stdio.h>
> +
> +/* Variable offsets used for reads/writes to modern memory regions */
> +VirtioPciCap c_cap; /* Common capabilities  */
> +VirtioPciCap d_cap; /* Device capabilities  */
> +VirtioPciCap n_cap; /* Notify capabilities  */
> +uint32_t notify_mult;
> +uint16_t q_notify_offset;
> +
> +static int virtio_pci_set_status(VDev *vdev, uint8_t status)
> +{
> +    int rc = pci_write_byte(vdev->pci_fh, c_cap.off + VPCI_C_OFFSET_STATUS,
> +                             c_cap.bar, status);
> +    if (rc) {
> +        puts("Failed to write virtio-pci status");
> +        return -EIO;
> +    }
> +
> +    return 0;
> +}
> +
> +static int virtio_pci_get_status(VDev *vdev, uint8_t *status)
> +{
> +    int rc = pci_read_byte(vdev->pci_fh, c_cap.off + VPCI_C_OFFSET_STATUS,
> +                           c_cap.bar, status);
> +    if (rc) {
> +        puts("Failed to read virtio-pci status");
> +        return -EIO;
> +    }
> +
> +    return 0;
> +}
> +
> +/*
> + * Find the position of the capability config within PCI configuration
> + * space for a given cfg type.  Return the position if found, otherwise 0.
> + */
> +static uint8_t find_cap_pos(uint32_t fhandle, uint8_t cfg_type)
> +{
> +    uint8_t next, cfg;
> +    int rc;
> +
> +    rc = pci_read_byte(fhandle, PCI_CAPABILITY_LIST, PCI_CFGBAR, &next);
> +    rc |= pci_read_byte(fhandle, next + 3, PCI_CFGBAR, &cfg);
> +
> +    while (!rc && (cfg != cfg_type) && next) {
> +        rc = pci_read_byte(fhandle, next + 1, PCI_CFGBAR, &next);
> +        rc |= pci_read_byte(fhandle, next + 3, PCI_CFGBAR, &cfg);
> +    }
> +
> +    return rc ? 0 : next;
> +}
> +
> +static int virtio_pci_get_hfeatures(VDev *vdev, uint64_t *features)
> +{
> +    uint32_t feat0, feat1;
> +    int rc;
> +
> +    rc = pci_bswap32_write(vdev->pci_fh, c_cap.off + VPCI_C_OFFSET_DFSELECT,
> +                           c_cap.bar, 0);
> +
> +    rc |= pci_read_bswap32(vdev->pci_fh, c_cap.off + VPCI_C_OFFSET_DF,
> +                           c_cap.bar, &feat0);
> +
> +    rc |= pci_bswap32_write(vdev->pci_fh, c_cap.off + VPCI_C_OFFSET_DFSELECT,
> +                            c_cap.bar, 1);
> +
> +    rc |= pci_read_bswap32(vdev->pci_fh, c_cap.off + VPCI_C_OFFSET_DF,
> +                               c_cap.bar, &feat1);
> +
> +    if (rc) {
> +        puts("Failed to get PCI feature bits");
> +        return -EIO;
> +    }
> +
> +    *features = (uint64_t) feat1 << 32;
> +    *features |= (uint64_t) feat0;
> +
> +    return 0;
> +}
> +
> +static int virtio_pci_set_gfeatures(VDev *vdev)
> +{
> +    int rc;
> +
> +    rc = pci_bswap32_write(vdev->pci_fh, c_cap.off + VPCI_C_OFFSET_GFSELECT,
> +                           c_cap.bar, 0);
> +
> +    rc |= pci_bswap32_write(vdev->pci_fh, c_cap.off + VPCI_C_OFFSET_GF,
> +                            c_cap.bar, vdev->guest_features[1]);
> +
> +    rc |= pci_bswap32_write(vdev->pci_fh, c_cap.off + VPCI_C_OFFSET_GFSELECT,
> +                            c_cap.bar, 1);
> +
> +    rc |= pci_bswap32_write(vdev->pci_fh, c_cap.off + VPCI_C_OFFSET_GF,
> +                                c_cap.bar, vdev->guest_features[0]);
> +
> +    if (rc) {
> +        puts("Failed to set PCI feature bits");
> +        return -EIO;
> +    }
> +
> +    return 0;
> +}
> +
> +static int virtio_pci_get_blk_config(VDev *vdev)
> +{
> +    return pci_read_flex(vdev->pci_fh, d_cap.off, d_cap.bar, &vdev->config.blk,
> +                         sizeof(VirtioBlkConfig));
> +}
> +
> +/* virtio spec v1.3 section 4.1.2.1 */
> +void virtio_pci_id2type(VDev *vdev, uint16_t device_id)
> +{
> +    switch (device_id) {
> +    case 0x1001:
> +        vdev->dev_type = VIRTIO_ID_BLOCK;
> +        break;
> +    case 0x1000: /* Other valid but currently unsupported virtio device types */
> +    case 0x1004:
> +    default:
> +        vdev->dev_type = 0;
> +    }
> +}
> +
> +/*
> + * Read PCI configuration space to find the offset of the Common, Device, and
> + * Notification memory regions within the modern memory space.
> + * Returns 0 if success, 1 if a capability could not be located, or a
> + * negative RC if the configuration read failed.
> + */
> +static int virtio_pci_read_pci_cap_config(VDev *vdev)
> +{
> +    uint8_t pos;
> +    int rc;
> +
> +    /* Common capabilities */
> +    pos = find_cap_pos(vdev->pci_fh, VPCI_CAP_COMMON_CFG);
> +    if (!pos) {
> +        puts("Failed to locate PCI common configuration");
> +        return 1;
> +    }
> +
> +    rc = pci_read_byte(vdev->pci_fh, pos + VPCI_CAP_BAR, PCI_CFGBAR, &c_cap.bar);
> +    if (rc || pci_read_bswap32(vdev->pci_fh, pos + VPCI_CAP_OFFSET, PCI_CFGBAR,
> +                               &c_cap.off)) {
> +        puts("Failed to read PCI common configuration");
> +        return -EIO;
> +    }
> +
> +    /* Device capabilities */
> +    pos = find_cap_pos(vdev->pci_fh, VPCI_CAP_DEVICE_CFG);
> +    if (!pos) {
> +        puts("Failed to locate PCI device configuration");
> +        return 1;
> +    }
> +
> +    rc = pci_read_byte(vdev->pci_fh, pos + VPCI_CAP_BAR, PCI_CFGBAR, &d_cap.bar);
> +    if (rc || pci_read_bswap32(vdev->pci_fh, pos + VPCI_CAP_OFFSET, PCI_CFGBAR,
> +                               &d_cap.off)) {
> +        puts("Failed to read PCI device configuration");
> +        return -EIO;
> +    }
> +
> +    /* Notification capabilities */
> +    pos = find_cap_pos(vdev->pci_fh, VPCI_CAP_NOTIFY_CFG);
> +    if (!pos) {
> +        puts("Failed to locate PCI notification configuration");
> +        return 1;
> +    }
> +
> +    rc = pci_read_byte(vdev->pci_fh, pos + VPCI_CAP_BAR, PCI_CFGBAR, &n_cap.bar);
> +    if (rc || pci_read_bswap32(vdev->pci_fh, pos + VPCI_CAP_OFFSET, PCI_CFGBAR,
> +                               &n_cap.off)) {
> +        puts("Failed to read PCI notification configuration");
> +        return -EIO;
> +    }
> +
> +    rc = pci_read_bswap32(vdev->pci_fh, pos + VPCI_N_CAP_MULT, PCI_CFGBAR, &notify_mult);
> +    if (rc || pci_read_bswap16(vdev->pci_fh, d_cap.off + VPCI_C_OFFSET_Q_NOFF,
> +                               d_cap.bar, &q_notify_offset)) {

Hi Jared, I think this came up in the previous version -- should
q_notify_offset be taken from the common configuration structure?

> +        puts("Failed to read notification queue configuration");
> +        return -EIO;
> +    }
> +
> +    return 0;
> +}
> +
> +int virtio_pci_reset(VDev *vdev)
> +{
> +    int rc;
> +    uint8_t status = VPCI_S_RESET;
> +
> +    rc = virtio_pci_set_status(vdev, status);
> +    rc |= virtio_pci_get_status(vdev, &status);
> +
> +    if (rc || status) {
> +        puts("Failed to reset virtio-pci device");
> +        return 1;
> +    }
> +
> +    return 0;
> +}
> +
> +int virtio_pci_set_selected_vq(VDev *vdev, uint16_t queue_num)
> +{
> +    return pci_bswap16_write(vdev->pci_fh, c_cap.off + VPCI_C_OFFSET_Q_SELECT,
> +                             c_cap.bar, queue_num);
> +}
> +
> +int virtio_pci_set_queue_size(VDev *vdev, uint16_t queue_size)
> +{
> +    return pci_bswap16_write(vdev->pci_fh, c_cap.off + VPCI_C_OFFSET_Q_SIZE,
> +                             c_cap.bar, queue_size);
> +}
> +
> +static int virtio_pci_set_queue_enable(VDev *vdev, uint16_t enabled)
> +{
> +    return pci_bswap16_write(vdev->pci_fh, c_cap.off + VPCI_C_OFFSET_Q_ENABLE,
> +                             c_cap.bar, enabled);
> +}
> +
> +static int set_pci_vq_addr(VDev *vdev, uint64_t config_off, void *addr)
> +{
> +    return pci_bswap64_write(vdev->pci_fh, c_cap.off + config_off, c_cap.bar,
> +                             (uint64_t) addr);
> +}
> +
> +int virtio_pci_setup(VDev *vdev)
> +{
> +    VRing *vr;
> +    int rc;
> +    uint64_t pci_features;
> +    uint8_t status;
> +    int i = 0;
> +
> +    vdev->config.blk.blk_size = 0;
> +    vdev->guessed_disk_nature = VIRTIO_GDN_NONE;
> +    vdev->cmd_vr_idx = 0;
> +
> +    if (virtio_reset(vdev)) {
> +        return -EIO;
> +    }
> +
> +    status = VPCI_S_ACKNOWLEDGE;
> +    rc = virtio_pci_set_status(vdev, status);
> +    if (rc) {
> +        puts("Virtio-pci device Failed to ACKNOWLEDGE");
> +        return -EIO;
> +    }
> +
> +    rc = virtio_pci_read_pci_cap_config(vdev);
> +    if (rc) {
> +        printf("Invalid PCI capabilities");
> +        return -EIO;
> +    }
> +
> +    switch (vdev->dev_type) {
> +    case VIRTIO_ID_BLOCK:
> +        vdev->nr_vqs = 1;
> +        vdev->cmd_vr_idx = 0;
> +        virtio_pci_get_blk_config(vdev);
> +        break;
> +    default:
> +        puts("Unsupported virtio device");
> +        return -ENODEV;
> +    }
> +
> +    status |= VPCI_S_DRIVER;
> +    rc = virtio_pci_set_status(vdev, status);
> +    if (rc) {
> +        puts("Set status failed");
> +        return -EIO;
> +    }
> +
> +    /* Feature negotiation */
> +    rc = virtio_pci_get_hfeatures(vdev, &pci_features);
> +    if (rc || virtio_pci_set_gfeatures(vdev)) {
> +        return -EIO;
> +    }
> +
> +    /* Configure virt-queues for pci */
> +    for (i = 0; i < vdev->nr_vqs; i++) {
> +        VqInfo info = {
> +            .queue = (unsigned long long) virtio_get_ring_area() + (i * VIRTIO_RING_SIZE),
> +            .align = KVM_S390_VIRTIO_RING_ALIGN,
> +            .index = i,
> +            .num = 0,
> +        };
> +
> +        vr = &vdev->vrings[i];
> +
> +        if (pci_read_flex(vdev->pci_fh, VPCI_C_COMMON_NUMQ, c_cap.bar, &info.num, 2)) {
> +            return -EIO;
> +        }
> +
> +        vring_init(vr, &info);
> +
> +        if (virtio_pci_set_selected_vq(vdev, vr->id)) {
> +            puts("Failed to set selected virt-queue");
> +            return -EIO;
> +        }
> +
> +        if (virtio_pci_set_queue_size(vdev, VIRTIO_RING_SIZE)) {
> +            puts("Failed to set virt-queue size");
> +            return -EIO;
> +        }
> +
> +        rc = set_pci_vq_addr(vdev, VPCI_C_OFFSET_Q_DESCLO, vr->desc);
> +        rc |= set_pci_vq_addr(vdev, VPCI_C_OFFSET_Q_AVAILLO, vr->avail);
> +        rc |= set_pci_vq_addr(vdev, VPCI_C_OFFSET_Q_USEDLO, vr->used);
> +        if (rc) {
> +            puts("Failed to configure virt-queue address");
> +            return -EIO;
> +        }
> +
> +        if (virtio_pci_set_queue_enable(vdev, true)) {
> +            puts("Failed to set virt-queue enabled");
> +            return -EIO;
> +        }
> +    }
> +
> +    status |= VPCI_S_FEATURES_OK | VPCI_S_DRIVER_OK;
> +    return virtio_pci_set_status(vdev, status);
> +}
> +
> +int virtio_pci_setup_device(void)
> +{
> +    VDev *vdev = virtio_get_device();
> +
> +    if (enable_pci_function(&vdev->pci_fh)) {
> +        puts("Failed to enable PCI function");
> +        return -ENODEV;
> +    }
> +
> +    return 0;
> +}
> +
> +long virtio_pci_notify(uint32_t fhandle, int vq_id)
> +{
> +    uint32_t offset = n_cap.off + notify_mult * q_notify_offset;
> +    return pci_bswap16_write(fhandle, offset, n_cap.bar, (uint16_t) vq_id);
> +}
> diff --git a/pc-bios/s390-ccw/virtio.c b/pc-bios/s390-ccw/virtio.c
> index 0488b3a07e..50afb11f6a 100644
> --- a/pc-bios/s390-ccw/virtio.c
> +++ b/pc-bios/s390-ccw/virtio.c
> @@ -15,6 +15,7 @@
>  #include "virtio.h"
>  #include "virtio-scsi.h"
>  #include "virtio-ccw.h"
> +#include "virtio-pci.h"
>  #include "bswap.h"
>  #include "helper.h"
>  #include "s390-time.h"
> @@ -109,6 +110,8 @@ bool vring_notify(VRing *vr)
>      case S390_IPL_TYPE_QEMU_SCSI:
>      case S390_IPL_TYPE_CCW:
>          vr->cookie = virtio_ccw_notify(vr->schid, vr->id, vr->cookie);
> +    case S390_IPL_TYPE_PCI:
> +        vr->cookie = virtio_pci_notify(virtio_get_device()->pci_fh, vr->id);
>      }
>  
>      return vr->cookie >= 0;
> @@ -182,6 +185,8 @@ int virtio_reset(VDev *vdev)
>      case S390_IPL_TYPE_QEMU_SCSI:
>      case S390_IPL_TYPE_CCW:
>          return virtio_ccw_reset(vdev);
> +    case S390_IPL_TYPE_PCI:
> +        return virtio_pci_reset(vdev);
>      default:
>          return -1;
>      }
> diff --git a/pc-bios/s390-ccw/Makefile b/pc-bios/s390-ccw/Makefile
> index a62fc9d766..3e5dfb64d5 100644
> --- a/pc-bios/s390-ccw/Makefile
> +++ b/pc-bios/s390-ccw/Makefile
> @@ -35,7 +35,7 @@ QEMU_DGFLAGS = -MMD -MP -MT $@ -MF $(@D)/$(*F).d
>  
>  OBJECTS = start.o main.o bootmap.o jump2ipl.o sclp.o menu.o netmain.o \
>  	  virtio.o virtio-net.o virtio-scsi.o virtio-blkdev.o cio.o dasd-ipl.o \
> -	  virtio-ccw.o clp.o pci.o
> +	  virtio-ccw.o clp.o pci.o virtio-pci.o
>  
>  SLOF_DIR := $(SRC_PATH)/../../roms/SLOF
>  


