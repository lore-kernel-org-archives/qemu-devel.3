Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89EF2D73EB2
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Jan 2026 02:46:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vleWG-0002qU-BN; Thu, 29 Jan 2026 21:46:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1vleWE-0002pL-E7; Thu, 29 Jan 2026 21:45:58 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1vleWC-0003mb-Ao; Thu, 29 Jan 2026 21:45:58 -0500
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60TEnKjx012562;
 Fri, 30 Jan 2026 02:45:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=Ui2eHA
 SjfcgYuLqT//IXeJbNbMSGQqRAFkT+TflV5bI=; b=Ku6Hm8LZptQ0EBbELAM3zq
 bFSMMBU5Ev/pmLHMKxwKufTP9I8fprwYe4PZDnBgPasDiJ1aV2sBWvAeOpx2kNdf
 rgNwkV0HkFyklbDp6WJFDIHwpMFn/c9YoGtiDlY9I3Z5k3XXxkEHKrGlABV72XtS
 3kr+/trUy2C7TSfdxnR+Ae531FfMSUnGcwe2HOXoOm7vEhjFigB0/UOXYP8jdEoi
 NFtkyNHKI7ZhoWttO1jK/vW+U70cNwJRCMWo9lgWjjbgIvbbimdIAyKzRtAp8hER
 emAWUcrbRq1d0Qm3ndSpxjt4MZkUF8O6J3mhhUZBKgNR8u4xnL9/cHQG+HGH6PMQ
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvnk7c2t6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 30 Jan 2026 02:45:53 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60TNvMq3026384;
 Fri, 30 Jan 2026 02:45:52 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4bw9wkmhy3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 30 Jan 2026 02:45:52 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 60U2jp7v14877266
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 30 Jan 2026 02:45:51 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0A8FB58054;
 Fri, 30 Jan 2026 02:45:51 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A70015805A;
 Fri, 30 Jan 2026 02:45:49 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com (unknown
 [9.61.76.202]) by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 30 Jan 2026 02:45:49 +0000 (GMT)
Message-ID: <4e07acb2c45c02fdd82bf8fb51fe9a88c41b97bd.camel@linux.ibm.com>
Subject: Re: [PATCH v3 09/14] pc-bios/s390-ccw: Introduce PCI device
From: Eric Farman <farman@linux.ibm.com>
To: jrossi@linux.ibm.com, qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 thuth@redhat.com, mst@redhat.com
Cc: jjherne@linux.ibm.com, alifm@linux.ibm.com, mjrosato@linux.ibm.com,
 zycai@linux.ibm.com
Date: Thu, 29 Jan 2026 21:45:49 -0500
In-Reply-To: <20260127161547.459443-10-jrossi@linux.ibm.com>
References: <20260127161547.459443-1-jrossi@linux.ibm.com>
 <20260127161547.459443-10-jrossi@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Ot72wwg8A4YNXVagMgtGUgNP880aFpQS
X-Proofpoint-ORIG-GUID: Ot72wwg8A4YNXVagMgtGUgNP880aFpQS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTMwMDAxNiBTYWx0ZWRfX1+MVy039ZM4r
 j89DumK+FZS3OY2VnnxVCHl48bdEopkHB2zBlpQrM2d73QLgtesAHOd3C3vPlChIhGHLR65JzFS
 RJM7YxFhSDH3ZaruE8R4SwQ+nna/HHBK1V7rEICaK/H/qQvVY8Rq0S5IS+FxVmdAR0d151Pp3nW
 zR4jCav25vTVbFyNEVf/cfq3DoGXN+tgVUnTfMKv+c4YvKxMZOuMuU5boqQr6xqqldux/bc4+Rd
 7CSAfGMBNwd4cdPIKio7lyzYuZkGvBkvgJBplJKiSBJ27yxKQJGF/BJM1vhqcFCfkEUnFsHumJy
 zcAtea6VOU4kr7JX9Wq4RKpZut1k83RtbMJBLsYpuDC68CN3VCPrAl6zk+sCGILbjQLey6BdYbt
 MusJIOG3TYmiYuuqs3Kb/QAU61SLwfKgjmEeSpNLi2OdnYYpA1/dZ/sHlH+4+9cF7oxWzKFrP+Z
 mPmP2V9e5aDnYpA6VeA==
X-Authority-Analysis: v=2.4 cv=AMiVTGgp c=1 sm=1 tr=0 ts=697c1b61 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=6eE6Fw_7ZBLlnpbpiOQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-29_03,2026-01-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 phishscore=0 bulkscore=0 suspectscore=0
 adultscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
 definitions=main-2601300016
Received-SPF: pass client-ip=148.163.156.1; envelope-from=farman@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, 2026-01-27 at 11:15 -0500, jrossi@linux.ibm.com wrote:
> From: Jared Rossi <jrossi@linux.ibm.com>
>=20
> Define selected s390x PCI instructions.
>=20
> Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
> ---
>  pc-bios/s390-ccw/Makefile |   2 +-
>  pc-bios/s390-ccw/pci.c    | 194 ++++++++++++++++++++++++++++++++++++++
>  pc-bios/s390-ccw/pci.h    |  80 ++++++++++++++++
>  3 files changed, 275 insertions(+), 1 deletion(-)
>  create mode 100644 pc-bios/s390-ccw/pci.c
>  create mode 100644 pc-bios/s390-ccw/pci.h
>=20
> diff --git a/pc-bios/s390-ccw/Makefile b/pc-bios/s390-ccw/Makefile
> index 9c29548f84..a62fc9d766 100644
> --- a/pc-bios/s390-ccw/Makefile
> +++ b/pc-bios/s390-ccw/Makefile
> @@ -35,7 +35,7 @@ QEMU_DGFLAGS =3D -MMD -MP -MT $@ -MF $(@D)/$(*F).d
> =20
>  OBJECTS =3D start.o main.o bootmap.o jump2ipl.o sclp.o menu.o netmain.o =
\
>  	  virtio.o virtio-net.o virtio-scsi.o virtio-blkdev.o cio.o dasd-ipl.o =
\
> -	  virtio-ccw.o clp.o
> +	  virtio-ccw.o clp.o pci.o
> =20
>  SLOF_DIR :=3D $(SRC_PATH)/../../roms/SLOF
> =20
> diff --git a/pc-bios/s390-ccw/pci.c b/pc-bios/s390-ccw/pci.c
> new file mode 100644
> index 0000000000..9656be45ca
> --- /dev/null
> +++ b/pc-bios/s390-ccw/pci.c
> @@ -0,0 +1,194 @@
> +/*
> + * s390x PCI funcionality

functionality

> + *
> + * Copyright 2025 IBM Corp.
> + * Author(s): Jared Rossi <jrossi@linux.ibm.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "clp.h"
> +#include "pci.h"
> +#include "bswap.h"
> +#include <stdio.h>
> +#include <stdbool.h>
> +
> +/* PCI load */
> +static inline int pcilg(uint64_t *data, uint64_t req, uint64_t offset,
> +                        uint8_t *status)
> +{
> +    union register_pair req_off =3D {.even =3D req, .odd =3D offset};
> +    int cc =3D -1;
> +    uint64_t __data;
> +
> +    asm volatile (
> +        "     .insn   rre,0xb9d20000,%[data],%[req_off]\n"
> +        "     ipm     %[cc]\n"
> +        "     srl     %[cc],28\n"
> +        : [cc] "+d" (cc), [data] "=3Dd" (__data),
> +          [req_off] "+d" (req_off.pair) :: "cc");
> +    *status =3D req_off.even >> 24 & 0xff;
> +    *data =3D __data;
> +    return cc;
> +}
> +
> +/* PCI store */
> +static inline int pcistg(uint64_t data, uint64_t req, uint64_t offset,
> +                         uint8_t *status)
> +{
> +    union register_pair req_off =3D {.even =3D req, .odd =3D offset};
> +    int cc =3D -1;
> +
> +    asm volatile (
> +        "     .insn   rre,0xb9d00000,%[data],%[req_off]\n"
> +        "     ipm     %[cc]\n"
> +        "     srl     %[cc],28\n"
> +        : [cc] "+d" (cc), [req_off] "+d" (req_off.pair)
> +        : [data] "d" (data)
> +        : "cc");
> +    *status =3D req_off.even >> 24 & 0xff;
> +    return cc;
> +}
> +
> +/* store PCI function controls */
> +static inline int stpcifc(uint64_t req, PciFib *fib, uint8_t *status)
> +{
> +    uint8_t cc;
> +
> +    asm volatile (
> +        "     .insn   rxy,0xe300000000d4,%[req],%[fib]\n"
> +        "     ipm     %[cc]\n"
> +        "     srl     %[cc],28\n"
> +        : [cc] "=3Dd" (cc), [req] "+d" (req), [fib] "+Q" (*fib)
> +        : : "cc");
> +    *status =3D req >> 24 & 0xff;
> +    return cc;
> +}
> +
> +/* modify PCI function controls */
> +static inline int mpcifc(uint64_t req, PciFib *fib, uint8_t *status)
> +{
> +    uint8_t cc;
> +
> +    asm volatile (
> +        "     .insn   rxy,0xe300000000d0,%[req],%[fib]\n"
> +        "     ipm     %[cc]\n"
> +        "     srl     %[cc],28\n"
> +        : [cc] "=3Dd" (cc), [req] "+d" (req), [fib] "+Q" (*fib)
> +        : : "cc");
> +    *status =3D req >> 24 & 0xff;
> +    return cc;
> +}
> +
> +int pci_write(uint32_t fhandle, uint64_t offset, uint8_t pcias, uint64_t=
 data,
> +              uint8_t len)
> +{
> +
> +    uint64_t req =3D ZPCI_CREATE_REQ(fhandle, pcias, len);
> +    uint8_t status;
> +    int rc;
> +
> +    /* len must be non-zero power of 2 with a maximum of 8 bytes per wri=
te */
> +    switch (len) {
> +    case 1:
> +    case 2:
> +    case 4:
> +    case 8:
> +        rc =3D pcistg(data, req, offset, &status);
> +        break;
> +    default:
> +        rc =3D -1;
> +    }
> +
> +    /* Error condition detected */
> +    if (rc =3D=3D 1) {
> +        printf("PCI store failed with status condition %d\n", status);
> +        return -1;
> +    }
> +
> +    return rc ? -1 : 0;
> +}
> +
> +int pci_read(uint32_t fhandle, uint64_t offset, uint8_t pcias, void *buf=
,
> +             uint8_t len)
> +{
> +    uint64_t req, data;
> +    uint8_t status;
> +    int rc;
> +
> +    req =3D ZPCI_CREATE_REQ(fhandle, pcias, len);
> +    rc =3D pcilg(&data, req, offset, &status);
> +
> +    /* Error condition detected */
> +    if (rc =3D=3D 1) {
> +        printf("PCI load failed with status condition %d\n", status);
> +        return -1;
> +    }
> +
> +    switch (len) {
> +    case 1:
> +        *(uint8_t *)buf =3D data;
> +        break;
> +    case 2:
> +        *(uint16_t *)buf =3D data;
> +        break;
> +    case 4:
> +        *(uint32_t *)buf =3D data;
> +        break;
> +    case 8:
> +        *(uint64_t *)buf =3D data;
> +        break;
> +    default:
> +        return -1;
> +    }
> +
> +    return rc ? -1 : 0;
> +}
> +
> +int pci_dev_enable(PciDevice *pcidev)
> +{
> +    int rc;
> +
> +    rc =3D enable_pci_function(&pcidev->fhandle);
> +    if (rc) {
> +        return rc;
> +    }
> +
> +    pcidev->status =3D PCIST_ENABLED;
> +
> +    return pci_get_fib(&pcidev->fib, pcidev->fhandle);

Is pcidev->status meant to be left "enabled" if this fails? Seems that the =
error cases would be
unexpected, but severe.

Oh... But pci_dev_enable doesn't seem to be called anywhere (enable_pci_fun=
ction is called by
virtio_pci_setup_device, in patch 11). Nor pci_get/set_fib below... So mayb=
e all these chunks are
not needed? (Ditto the related structs in pci.h, below)

> +}
> +
> +int pci_get_fib(PciFib *fib, uint32_t fhandle)
> +{
> +    uint64_t req =3D ZPCI_CREATE_REQ(fhandle, 0, 0);
> +    uint8_t status;
> +    int rc;
> +
> +    rc =3D stpcifc(req, fib, &status);
> +
> +    if (rc =3D=3D 1) {
> +        return status;
> +    } else if (rc) {
> +        return rc;
> +    }
> +
> +    return 0;
> +}
> +
> +int pci_set_fib(PciFib *fib, uint32_t fhandle, uint8_t dma_as, uint8_t o=
pcontrol)
> +{
> +    uint64_t req =3D ZPCI_CREATE_REQ(fhandle, dma_as, opcontrol);
> +    uint8_t status;
> +    int rc;
> +
> +    rc =3D mpcifc(req, fib, &status);
> +
> +    if (rc =3D=3D 1) {
> +        return status;
> +    } else if (rc) {
> +        return rc;
> +    }
> +
> +    return 0;
> +}
> diff --git a/pc-bios/s390-ccw/pci.h b/pc-bios/s390-ccw/pci.h
> new file mode 100644
> index 0000000000..ff8d5687f4
> --- /dev/null
> +++ b/pc-bios/s390-ccw/pci.h
> @@ -0,0 +1,80 @@
> +/*
> + * s390x PCI definitions
> + *
> + * Copyright 2025 IBM Corp.
> + * Author(s): Jared Rossi <jrossi@linux.ibm.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef PCI_H
> +#define PCI_H
> +
> +#include <stdint.h>
> +#include <stdbool.h>
> +#include "clp.h"
> +
> +#define ZPCI_CREATE_REQ(handle, space, len)                    \
> +    ((uint64_t) handle << 32 | space << 16 | len)
> +
> +union register_pair {
> +    unsigned __int128 pair;
> +    struct {
> +        unsigned long even;
> +        unsigned long odd;
> +    };
> +};
> +
> +#define PCIFIB_FC_ENABLED      0x80
> +#define PCIFIB_FC_ERROR        0x40
> +#define PCIFIB_FC_BLOCKED      0x20
> +#define PCIFIB_FC_DMAREG       0x10
> +
> +#define PCIST_DISABLED         0x0
> +#define PCIST_ENABLED          0x1
> +
> +#define PCI_CFGBAR             0xF  /* Base Address Register for config =
space */
> +#define PCI_CAPABILITY_LIST    0x34 /* Offset of first capability list e=
ntry */
> +
> +struct PciFib {
> +    uint32_t reserved0[2];
> +    uint8_t fcflags;
> +    uint8_t reserved1[3];
> +    uint32_t reserved2;
> +    uint64_t pba;
> +    uint64_t pal;
> +    uint64_t iota;
> +    uint16_t isc:4;
> +    uint16_t noi:12;
> +    uint8_t reserved3:2;
> +    uint8_t aibvo:6;
> +    uint8_t s:1;
> +    uint8_t reserved4:1;
> +    uint8_t aisbo:6;
> +    uint32_t reserved5;
> +    uint64_t aibv;
> +    uint64_t aisb;
> +    uint64_t fmba;
> +    uint32_t reserved6[2];
> +};
> +typedef struct PciFib PciFib;
> +
> +struct PciDevice {
> +    uint16_t device_id;
> +    uint16_t vendor_id;
> +    uint32_t fid;
> +    uint32_t fhandle;
> +    uint8_t status;
> +    PciFib fib;
> +};
> +typedef struct PciDevice PciDevice;
> +
> +int pci_dev_enable(PciDevice *pcidev);
> +int pci_get_fib(PciFib *fib, uint32_t fhandle);
> +int pci_set_fib(PciFib *fib, uint32_t fhandle, uint8_t dma_as, uint8_t o=
pcontrol);
> +int pci_write(uint32_t fhandle, uint64_t offset, uint8_t pcias, uint64_t=
 data,
> +              uint8_t len);
> +int pci_read(uint32_t fhandle, uint64_t offset, uint8_t pcias, void *buf=
,
> +             uint8_t len);
> +
> +#endif

