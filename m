Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1925BC5B56A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 18:18:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtr2u-0001Kg-Gg; Tue, 11 Aug 2026 14:17:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1wtr2s-00018L-4q; Tue, 11 Aug 2026 14:17:50 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1wtr2q-0007XZ-0g; Tue, 11 Aug 2026 14:17:49 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67BGVQa33260512; Tue, 11 Aug 2026 18:17:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=mlRwtl
 rxMG1qEtPhWLsJ0KUsSrwzz1TwpQ/pXnvzsZM=; b=LbDMtw9RiqxTg4BgIX0QUR
 3kSJbkcJOsOKUPouM6QsvQE3c8js9uFMJcnEF7WOyhbOQ7iFHZEguISBrEQi8ILI
 PFJxU3kmQ3Arf7tNageFW7rfvF8smNHp8Y8mdyNmxkKOH2UrAM4fmAeJqFuniZNV
 Usc8FNBbM8csvcir34dJejswjhZssywfXFWCyc1r9U/wOfPnm3ySIWSN59iok/2H
 RJK3ZlhIKQoP8Y4qYhGb8hkNpYfufYAn4S/mcBXLDazvqP3JaCogr29oXI6PfZwI
 ziw1AVoq7KDPDWFTKwqcQELF6OTR88j752DMV1gCm6Y1/fHWbCnYV8BIuMezG0EQ
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvjyxcyu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 11 Aug 2026 18:17:43 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67BIBF6Q024683;
 Tue, 11 Aug 2026 18:17:42 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxhfy1yar-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 11 Aug 2026 18:17:42 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67BIHfIi22676180
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 11 Aug 2026 18:17:41 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7F7785805A;
 Tue, 11 Aug 2026 18:17:41 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A9F9C58052;
 Tue, 11 Aug 2026 18:17:40 +0000 (GMT)
Received: from [9.61.240.229] (unknown [9.61.240.229])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 11 Aug 2026 18:17:40 +0000 (GMT)
Message-ID: <d4ee50cf-df97-48ee-9b5f-81de236b2451@linux.ibm.com>
Date: Tue, 11 Aug 2026 11:17:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 14/15] s390x/pci: Implement migration for emulated
 devices
To: Konstantin Shkolnyy <kshk@linux.ibm.com>, mjrosato@linux.ibm.com
Cc: farman@linux.ibm.com, richard.henderson@linaro.org, iii@linux.ibm.com,
 david@kernel.org, cohuck@redhat.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
References: <20260807170812.658820-1-kshk@linux.ibm.com>
 <20260807170812.658820-15-kshk@linux.ibm.com>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <20260807170812.658820-15-kshk@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDE1MSBTYWx0ZWRfX4XnTiO0xIwGB
 M74ZRlzUYFf9c+80Ikkoh0Dc0lZ3UnB1u27xHrTBiq5KOCjAt9bIwx4NflG0RG9meOkVFEJOSLa
 BhMkEDkQ9mk/uohMxHsKWb/O+yr23UggQs9cXX1zPsiYj4z8Kn5tVREuuqM/dX18qWKrBjhaWPr
 8M47+glv8dvVJHHVKKwTXvAwFVeaNlL9N3RfgpLoufAFgXkyHTT/bN/jidQmkZZI/mjt3vFbRZ8
 cKEpJ4DjmGCeAhYfCh++vpXoYJJ5SvPskEBVX919JelTc8bfSZb+BTcg1i9KEUGLuvOONAPD1PR
 ps+FRfMzmTfe01nnD079skwl5jUbn3BwN+C1YJWgaTMa8v9Bs9V84UEfPKvb1OGbkr+4KtjPelz
 uLy49exFKEeR09dZqMtFHpWBPc5Ou1ndMtX2rY482/8K6Mnv/a/XIW5QrRLyJ4XNpzmjG/bJFcD
 nMDau+9B/UiTRm9H2UQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDE1MSBTYWx0ZWRfX+PwSxHjid4cQ
 HuznxYayrpb74hoFgoAqylBYqmMDflfKtryF0CTd/OAnsh+91gV/rrTRfIJAu9AIsl06vrm6hh2
 3fOYRX6W/9fKdkppbRGf7uIwBAZMYfY=
X-Authority-Analysis: v=2.4 cv=RqD16imK c=1 sm=1 tr=0 ts=6a7b6747 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=ZGkJw53VMvRlTP6bY0MA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: C8PG7cqVFuPGu0Ebg3hMwcHi13b3185V
X-Proofpoint-ORIG-GUID: C8PG7cqVFuPGu0Ebg3hMwcHi13b3185V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-11_04,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608110151
Received-SPF: pass client-ip=148.163.156.1; envelope-from=alifm@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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


On 8/7/2026 10:08 AM, Konstantin Shkolnyy wrote:
> Implement zPCI device state migration, consequently enabling migration
> of VMs that have emulated PCI devices, whether virtio or not.
> Migration is allowed for devices whose function handle has the
> FH_SHM_EMUL bit set. For these devices QEMU will save and restore the
> state of its zPCI emulator.
>
> This will enable emulated PCI migration starting with s390-ccw-virtio-11.1.
>
> Passthrough devices will continue to block migration.
>
> Signed-off-by: Konstantin Shkolnyy <kshk@linux.ibm.com>
> ---
>   hw/s390x/s390-pci-bus.c         | 196 +++++++++++++++++++++++++++++++-
>   hw/s390x/s390-pci-inst.c        |   2 +-
>   hw/s390x/s390-virtio-ccw.c      |   4 +
>   include/hw/s390x/s390-pci-bus.h |   4 +
>   4 files changed, 200 insertions(+), 6 deletions(-)
>
> diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
> index a94e24a2ac..f043dc5524 100644
> --- a/hw/s390x/s390-pci-bus.c
> +++ b/hw/s390x/s390-pci-bus.c
> @@ -26,6 +26,7 @@
>   #include "hw/pci/pci_bridge.h"
>   #include "hw/pci/msi.h"
>   #include "exec/cpu-common.h"
> +#include "migration/blocker.h"
>   #include "qemu/error-report.h"
>   #include "qemu/module.h"
>   #include "system/physmem.h"
> @@ -34,6 +35,11 @@
>   
>   #include "trace.h"
>   
> +static const Property phb_props[] = {
> +    DEFINE_PROP_BOOL("x-zpci-emul-dev-migr-enabled", S390pciState,
> +                     emul_dev_migr_enabled, true),
> +};
> +
>   S390pciState *s390_get_phb(void)
>   {
>       static S390pciState *phb;
> @@ -1129,6 +1135,47 @@ static int s390_pci_interp_plug(S390pciState *s, S390PCIBusDevice *pbdev)
>       return 0;
>   }
>   
> +static int s390_set_emul_dev_migration_blocker(S390PCIBusDevice *pbdev,
> +        S390pciState *s, Error **errp)
> +{
> +    if (s->emul_dev_migr_enabled) {
> +        return 0;
> +    }
> +    error_setg(&pbdev->emul_dev_migr_blocker,
> +               "Migration blocked on this machine type by emulated zPCI device "
> +               "fh 0x%x uid %d fid %d", pbdev->fh, pbdev->uid, pbdev->fid);
> +    return migrate_add_blocker(&pbdev->emul_dev_migr_blocker, errp);
> +}
> +
> +static void s390_clear_emul_dev_migration_blocker(S390PCIBusDevice *pbdev,
> +        S390pciState *s)

I don't think we need to pass the S390pciState here, as it's not used 
anymore. So we should remove it and update the callsites.

With this fixed
Reviewed-by: Farhan Ali<alifm@linux.ibm.com>

> +{
> +    if (pbdev->emul_dev_migr_blocker) {
> +        migrate_del_blocker(&pbdev->emul_dev_migr_blocker);
> +    }
> +}
> +

<..snip..>



