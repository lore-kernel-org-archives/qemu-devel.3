Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C5F8C43458
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2026 00:44:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfoTz-0006E0-5g; Fri, 03 Jul 2026 20:43:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1wfoTx-0006DZ-M1; Fri, 03 Jul 2026 20:43:45 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1wfoTv-0001f1-BE; Fri, 03 Jul 2026 20:43:45 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 663KmHlm3769482; Sat, 4 Jul 2026 00:43:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=sDmBu1
 c6tAodC7YkUZ48MwiUHhLPc2yPQwxhrP+sKQM=; b=repAKFPK/RBrww5Urc1Hyj
 yXiatEzgpm6mice+7gA1npU/A1pr4Mi3+VxkuV6mxm5+wcqtEFcPAQzNS01t8XQb
 sN8s1Oh6WZlC8nS4Aat3oUufxPD5DOB6FnrbddmrQXwz11CpXYEjO2HoDi0lur6M
 O7hQnP3I7X6BSTVwQW/zD7iOdgxmAhynQcx8OcQstBsiOg0f0ga2V1F8Qa0w2Ml0
 MVnvDHuS3BrD2eiuPEg0j9ye8h+RXfTM8Q+QLraVLQkFF5Rv/jJZHV1bg7K6yW1U
 C0U9u5UMPmhymGwOUbge3I5NCH2CfIJfHtdgN+BM0cnKa08eZttLYkxZrkveYvwA
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26mk8x0n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 04 Jul 2026 00:43:41 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6640Yjsi020374;
 Sat, 4 Jul 2026 00:43:41 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f2tbhtwuc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 04 Jul 2026 00:43:40 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6640hdDf21168874
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 4 Jul 2026 00:43:39 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B029F58056;
 Sat,  4 Jul 2026 00:43:39 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 518E85803F;
 Sat,  4 Jul 2026 00:43:39 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com (unknown
 [9.61.19.96]) by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Sat,  4 Jul 2026 00:43:39 +0000 (GMT)
Message-ID: <76c7a257398ff5bfa12168b372695de1bdf85fee.camel@linux.ibm.com>
Subject: Re: [PATCH v13 23/33] pc-bios/s390-ccw: Add signature verification
 for secure IPL in audit mode
From: Eric Farman <farman@linux.ibm.com>
To: Zhuoying Cai <zycai@linux.ibm.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Date: Fri, 03 Jul 2026 20:43:38 -0400
In-Reply-To: <6fa4c5f7-0388-4acb-bacb-f929ecff1a09@linux.ibm.com>
References: <20260703022933.1805010-1-zycai@linux.ibm.com>
 <20260703022933.1805010-24-zycai@linux.ibm.com>
 <26e6d55b2ea246f2c2602ff911f459c7df8b57b0.camel@linux.ibm.com>
 <6fa4c5f7-0388-4acb-bacb-f929ecff1a09@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA0MDAwMSBTYWx0ZWRfX9JW7+RHEIokJ
 wFRn8NECLUzfx7VNLBtLUXuifbO449cNxOBbXOJPl9DjRCwniuC15vYqH+0o3IrPCooucf8h5CZ
 1ttf1ZKUDTkfUjStim2CqjI7VH9Otm7lBJPbzOp6+7F8xufEozyuM80/7o6Utp7ciu1P8HJX4/V
 EIaWVHOhwefVNIW7chRnHvGzNjH/7dcSx9d/YR4R/VoDiP07dCXZ7TY7Pdzd2S2XRX4NAse1tFW
 wGcS8dmOxEWTgxz8oHp6aQ+HR9pgOGClM7k5CI+lVHdt59mYu44LTtumPATB5ZeuPSixraA5RLe
 amtV6aYsFxl7Pfkupq//pCsdkRLYR7wFzSsdt1k6ZQfHDs2Pn4oLftMOEttvctEELPLVns5zGun
 MQwny6L/r0JcjBLtWEghXua1sslacrYlvBJwvGd4wztSIsjaokZO5/MwXt8jjkWFln2LQXZ8pUz
 VbMtUFmigcpttqXg/zg==
X-Proofpoint-GUID: tp7ASl7FMv87FU2zXldbHd638dTe4ALq
X-Authority-Analysis: v=2.4 cv=Z8bc2nRA c=1 sm=1 tr=0 ts=6a48573d cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=Lrc2qXfl7WQKukvHOm0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA0MDAwMSBTYWx0ZWRfX2dh2F7O32I4S
 dzgWqlWujanJUdCqFB5GttGN9G5pJyXOYA1se4v/jKNwNuMdagozARFfg+fm4zU8Qw8MC9bbCQx
 hKF67N4Z50xpVVQ4PBM7DywAgsj/Vh4=
X-Proofpoint-ORIG-GUID: tp7ASl7FMv87FU2zXldbHd638dTe4ALq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_04,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 spamscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607040001
Received-SPF: pass client-ip=148.163.158.5; envelope-from=farman@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On Fri, 2026-07-03 at 09:56 -0400, Zhuoying Cai wrote:
> On 7/3/26 7:40 AM, Eric Farman wrote:
> > On Thu, 2026-07-02 at 22:29 -0400, Zhuoying Cai wrote:
> > > Enable secure IPL in audit mode, which performs signature verificatio=
n,
> > > but any error does not terminate the boot process. Only warnings will=
 be
> > > logged to the console instead.
> > >=20
> > > Secure IPL in audit mode requires at least one certificate provided i=
n
> > > the key store along with necessary facilities (Secure IPL Facility,
> > > Certificate Store Facility and secure IPL extension support).
> > >=20
> > > Note: Secure IPL in audit mode is implemented for the SCSI scheme of
> > > virtio-blk/virtio-scsi devices.
> > >=20
> > > Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> > > ---
> > >  docs/system/s390x/secure-ipl.rst |  15 ++
> > >  hw/s390x/ipl.c                   |   9 +
> > >  pc-bios/s390-ccw/Makefile        |   2 +-
> > >  pc-bios/s390-ccw/bootmap.c       |  27 +++
> > >  pc-bios/s390-ccw/bootmap.h       |   9 +
> > >  pc-bios/s390-ccw/jump2ipl.c      |   7 +
> > >  pc-bios/s390-ccw/main.c          |  18 +-
> > >  pc-bios/s390-ccw/s390-ccw.h      |  20 ++
> > >  pc-bios/s390-ccw/sclp.c          |  27 +++
> > >  pc-bios/s390-ccw/sclp.h          |   6 +
> > >  pc-bios/s390-ccw/secure-ipl.c    | 363 +++++++++++++++++++++++++++++=
++
> > >  pc-bios/s390-ccw/secure-ipl.h    | 115 ++++++++++
> > >  12 files changed, 616 insertions(+), 2 deletions(-)
> > >  create mode 100644 pc-bios/s390-ccw/secure-ipl.c
> > >  create mode 100644 pc-bios/s390-ccw/secure-ipl.h
> > >=20
> >=20
> > ...snip...
> >=20
> > > diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
> > > index cd3d0776b0..7484429c9a 100644
> > > --- a/pc-bios/s390-ccw/main.c
> > > +++ b/pc-bios/s390-ccw/main.c
> > > @@ -20,6 +20,7 @@
> > >  #include "dasd-ipl.h"
> > >  #include "clp.h"
> > >  #include "virtio-pci.h"
> > > +#include "secure-ipl.h"
> > > =20
> > >  static SubChannelId blk_schid =3D { .one =3D 1 };
> > >  static char loadparm_str[LOADPARM_LEN + 1];
> > > @@ -383,6 +384,8 @@ static void probe_boot_device(void)
> > > =20
> > >  void main(void)
> > >  {
> > > +    int vcssb_len;
> > > +
> > >      iplb =3D &ipl_blocks.iplb;
> > > =20
> > >      copy_qipl();
> > > @@ -394,7 +397,20 @@ void main(void)
> > >          probe_boot_device();
> > >      }
> > > =20
> > > -    boot_mode =3D ZIPL_BOOT_MODE_NORMAL;
> > > +    boot_mode =3D get_boot_mode(iplb->hdr_flags);
> > > +    switch (boot_mode) {
> > > +    case ZIPL_BOOT_MODE_SECURE_AUDIT:
> > > +        if (!secure_ipl_supported()) {
> > > +            panic("Unable to boot in audit mode");
> > > +        }
> > > +
> > > +        vcssb_len =3D zipl_secure_get_vcssb();
> > > +        if (vcssb_len =3D=3D 0) {
> > > +            panic("Failed to query certificate storage information!"=
);
> > > +        }
> >=20
> > break? fallthrough?
> >=20
>=20
> Thanks for catching this!
>=20
> > > +    default:
> > > +        break;
> > > +    }
> > > =20
> > >      while (have_iplb) {
> > >          boot_setup();
> > > diff --git a/pc-bios/s390-ccw/s390-ccw.h b/pc-bios/s390-ccw/s390-ccw.=
h
> > > index 5420443ad2..ca2737054d 100644
> > > --- a/pc-bios/s390-ccw/s390-ccw.h
> > > +++ b/pc-bios/s390-ccw/s390-ccw.h
> > > @@ -40,6 +40,22 @@ typedef unsigned long long u64;
> > >                              ((b) =3D=3D 0 ? (a) : (MIN(a, b))))
> > >  #endif
> > > =20
> > > +/*
> > > + * Round number down to multiple. Requires that d be a power of 2.
> > > + * Works even if d is a smaller type than n.
> > > + */
> > > +#ifndef ROUND_DOWN
> > > +#define ROUND_DOWN(n, d) ((n) & -(0 ? (n) : (d)))
> > > +#endif
> > > +
> > > +/*
> > > + * Round number up to multiple. Requires that d be a power of 2.
> > > + * Works even if d is a smaller type than n.
> > > + */
> > > +#ifndef ROUND_UP
> > > +#define ROUND_UP(n, d) ROUND_DOWN((n) + (d) - 1, (d))
> > > +#endif
> > > +
> > >  #define ARRAY_SIZE(a) (sizeof(a) / sizeof((a)[0]))
> > > =20
> > >  #include "cio.h"
> > > @@ -64,6 +80,8 @@ void sclp_print(const char *string);
> > >  void sclp_set_write_mask(uint32_t receive_mask, uint32_t send_mask);
> > >  void sclp_setup(void);
> > >  void sclp_get_loadparm_ascii(char *loadparm);
> > > +bool sclp_is_diag320_on(void);
> > > +bool sclp_is_fac_ipl_flag_on(uint16_t fac_ipl_flag);
> > >  int sclp_read(char *str, size_t count);
> > > =20
> > >  /* bootmap.c */
> > > @@ -71,9 +89,11 @@ void zipl_load(void);
> > > =20
> > >  typedef enum ZiplBootMode {
> > >      ZIPL_BOOT_MODE_NORMAL =3D 0,
> > > +    ZIPL_BOOT_MODE_SECURE_AUDIT =3D 1,
> > >  } ZiplBootMode;
> > > =20
> > >  extern ZiplBootMode boot_mode;
> > > +ZiplBootMode get_boot_mode(uint8_t hdr_flags);
> > > =20
> > >  /* jump2ipl.c */
> > >  void write_reset_psw(uint64_t psw);
> > > diff --git a/pc-bios/s390-ccw/sclp.c b/pc-bios/s390-ccw/sclp.c
> > > index 4a07de018d..48bdfedf1f 100644
> > > --- a/pc-bios/s390-ccw/sclp.c
> > > +++ b/pc-bios/s390-ccw/sclp.c
> > > @@ -113,6 +113,33 @@ void sclp_get_loadparm_ascii(char *loadparm)
> > >      }
> > >  }
> > > =20
> > > +bool sclp_is_diag320_on(void)
> > > +{
> > > +    ReadInfo *sccb =3D (void *)_sccb;
> > > +
> > > +    memset((char *)_sccb, 0, sizeof(ReadInfo));
> > > +    sccb->h.length =3D SCCB_SIZE;
> > > +    if (!sclp_service_call(SCLP_CMDW_READ_SCP_INFO, sccb)) {
> > > +        return sccb->fac134 & SCCB_FAC134_DIAG320_BIT;
> > > +    }
> > > +
> > > +    return 0;
> > > +}
> > > +
> > > +/* check if specified IPL facility flag is enabled */
> > > +bool sclp_is_fac_ipl_flag_on(uint16_t fac_ipl_flag)
> > > +{
> > > +    ReadInfo *sccb =3D (void *)_sccb;
> > > +
> > > +    memset((char *)_sccb, 0, sizeof(ReadInfo));
> > > +    sccb->h.length =3D SCCB_SIZE;
> > > +    if (!sclp_service_call(SCLP_CMDW_READ_SCP_INFO, sccb)) {
> > > +        return sccb->fac_ipl & fac_ipl_flag;
> > > +    }
> > > +
> > > +    return 0;
> > > +}
> > > +
> > >  int sclp_read(char *str, size_t count)
> > >  {
> > >      ReadEventData *sccb =3D (void *)_sccb;
> > > diff --git a/pc-bios/s390-ccw/sclp.h b/pc-bios/s390-ccw/sclp.h
> > > index 64b53cad29..a8a41cd004 100644
> > > --- a/pc-bios/s390-ccw/sclp.h
> > > +++ b/pc-bios/s390-ccw/sclp.h
> > > @@ -50,6 +50,8 @@ typedef struct SCCBHeader {
> > >  } __attribute__((packed)) SCCBHeader;
> > > =20
> > >  #define SCCB_DATA_LEN (SCCB_SIZE - sizeof(SCCBHeader))
> > > +#define SCCB_FAC134_DIAG320_BIT 0x4
> > > +#define SCCB_FAC_IPL_SIPL_BIT   0x4000
> > > =20
> > >  typedef struct ReadInfo {
> > >      SCCBHeader h;
> > > @@ -57,6 +59,10 @@ typedef struct ReadInfo {
> > >      uint8_t rnsize;
> > >      uint8_t reserved[13];
> > >      uint8_t loadparm[LOADPARM_LEN];
> > > +    uint8_t reserved1[102];
> > > +    uint8_t fac134;
> > > +    uint8_t reserved2;
> > > +    uint16_t fac_ipl;
> > >  } __attribute__((packed)) ReadInfo;
> > > =20
> > >  typedef struct SCCB {
> > > diff --git a/pc-bios/s390-ccw/secure-ipl.c b/pc-bios/s390-ccw/secure-=
ipl.c
> > > new file mode 100644
> > > index 0000000000..2cfa16fb68
> > > --- /dev/null
> > > +++ b/pc-bios/s390-ccw/secure-ipl.c
> > > @@ -0,0 +1,363 @@
> > > +/*
> > > + * S/390 Secure IPL
> > > + *
> > > + * Functions to support IPL in secure boot mode (DIAG 320, DIAG 508,
> > > + * signature verification, and certificate handling).
> > > + *
> > > + * For secure IPL overview: docs/system/s390x/secure-ipl.rst
> > > + * For secure IPL technical: docs/specs/s390x-secure-ipl.rst
> > > + *
> > > + * Copyright 2025 IBM Corp.
> > > + * Author(s): Zhuoying Cai <zycai@linux.ibm.com>
> > > + *
> > > + * SPDX-License-Identifier: GPL-2.0-or-later
> > > + */
> > > +
> > > +#include <stdlib.h>
> > > +#include <string.h>
> > > +#include <stdio.h>
> > > +#include "s390-ccw.h"
> > > +#include "sclp.h"
> > > +#include "secure-ipl.h"
> > > +
> > > +static VCStorageSizeBlock vcssb __attribute__((__aligned__(8)));
> > > +
> > > +#define for_each_rb_entry(entry, list) \
> > > +    for (entry =3D (void *)(list) + sizeof((list)->ipl_info_header);=
 \
> > > +         (void *)(entry) + sizeof(*(entry)) <=3D \
> > > +         (void *)(list) + (list)->ipl_info_header.len; \
> > > +         entry++)
> > > +
> > > +int zipl_secure_get_vcssb(void)
> > > +{
> > > +    /* avoid retrieving vcssb multiple times */
> > > +    if (vcssb.length =3D=3D VCSSB_LEN_VALID) {
> > > +        goto out;
> > > +    }
> > > +
> > > +    vcssb.length =3D VCSSB_LEN_VALID;
> > > +    if (_diag320(&vcssb, DIAG_320_SUBC_QUERY_VCSI) !=3D DIAG_320_RC_=
OK) {
> > > +        vcssb.length =3D 0;
> > > +    }
> > > +
> > > +out:
> > > +    return vcssb.length;
> > > +}
> > > +
> > > +static uint32_t request_certificate(uint8_t *cert_buf, uint8_t index=
)
> > > +{
> > > +    VCEntryHeader *vce_hdr;
> > > +    struct vcb {
> > > +        VCBlockHeader vcb_hdr;
> > > +        struct vce {
> > > +            VCEntryHeader vce_hdr;
> > > +            uint8_t cert_buf[CERT_BUF_MAX_LEN];
> > > +        } vce;
> > > +    } __attribute__((__aligned__(PAGE_SIZE))) vcb =3D { 0 };
> > > +
> > > +    /*
> > > +     * Request single entry
> > > +     * Fill input fields of single-entry VCB
> > > +     *
> > > +     * First and last index must be equal because only one
> > > +     * VCE per VCB is currently supported
> > > +     */
> > > +    vcb.vcb_hdr.in_len =3D ROUND_UP(vcssb.max_single_vcb_len, PAGE_S=
IZE);
> >=20
> > Don't you need to convert max_single_vcb_len from be to cpu?
> >=20
>=20
> I don't think we need to convert max_single_vcb_len here, but please
> correct me if I'm missing something. If I understand correctly, the
> fields are written and read in big-endian format, so no additional
> conversion should be necessary.

No, you're right... Got my wires crossed about qemu vs bios. Sorry about th=
at.

>=20
> > > +    vcb.vcb_hdr.first_vc_index =3D index;
> > > +    vcb.vcb_hdr.last_vc_index =3D index;
> > > +
> > > +    if (_diag320(&vcb, DIAG_320_SUBC_STORE_VC) !=3D DIAG_320_RC_OK) =
{
> > > +        puts("Could not get certificate");
> > > +        return 0;
> > > +    }
> > > +
> > > +    if (vcb.vcb_hdr.out_len =3D=3D sizeof(VCBlockHeader)) {
> > > +        puts("No certificate entry");
> > > +        return 0;
> > > +    }
> > > +
> > > +    if (vcb.vcb_hdr.remain_ct !=3D 0) {
> > > +        panic("Not enough memory to store requested certificate");
> > > +    }
> > > +
> > > +    vce_hdr =3D &vcb.vce.vce_hdr;
> > > +    if (!(vce_hdr->flags & DIAG_320_VCE_FLAGS_VALID)) {
> > > +        puts("Invalid certificate");
> > > +        return 0;
> > > +    }
> > > +
> > > +    memcpy(cert_buf, (uint8_t *)&vcb.vce + vce_hdr->cert_offset, vce=
_hdr->cert_len);
> > > +
> > > +    return vce_hdr->cert_len;
> > > +}
> > > +
> [...]

