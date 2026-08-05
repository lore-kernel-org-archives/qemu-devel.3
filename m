Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 341A3C55174
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2026 22:02:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrjgn-0006qE-4W; Wed, 05 Aug 2026 18:02:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1wrjgk-0006pZ-KU; Wed, 05 Aug 2026 18:02:14 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1wrjgi-0007Uu-MX; Wed, 05 Aug 2026 18:02:14 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 675HlYot315362; Wed, 5 Aug 2026 22:02:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=3oS6ib
 wQuAtqA2115uOEFcpvfquvAuZxs9/Vg4AzP2I=; b=RoNfFntw0hKeATw74sGruB
 wdYaJJ4roqHihsXeSUVSi0gr7fHeEHDJCnQutjNffblfnKUdbL9kAb/jhLbTs0t6
 SOIZDtz6yeRQYdf67HIsf2VF/cFw+iznYTEqjC+sUjbZaNPCiaa+8BJ7wUC12Dff
 eCFJHJXZfRzWZUoMXwtJ9QrbUqPYsBxIf4RqSG+esRx9tK3ihScCkdD6IkBo5QxP
 yKZ9AUaC+3//lE/TyeZbmbdvYzErgersxDqFl6AhjZIzWPdeg52dD+779MuKHRmx
 mVseT5XZtQMGnJVdBbg8HVbBvfdSsNAiVNHT7x3/1Pwbun9GdWUo1Js4SkJo+SBw
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8a4592y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 05 Aug 2026 22:02:06 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 675LuKvl002937;
 Wed, 5 Aug 2026 22:02:05 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsv4k8ha4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 05 Aug 2026 22:02:05 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 675M24Nt61473036
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 5 Aug 2026 22:02:04 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 59D8158062;
 Wed,  5 Aug 2026 22:02:04 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8F32C58056;
 Wed,  5 Aug 2026 22:02:03 +0000 (GMT)
Received: from [9.61.249.77] (unknown [9.61.249.77])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  5 Aug 2026 22:02:03 +0000 (GMT)
Message-ID: <b3bd5351-c51b-42fb-a1dc-09eb998befa9@linux.ibm.com>
Date: Wed, 5 Aug 2026 15:02:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 14/15] s390x/pci: Implement migration for emulated
 devices
To: Konstantin Shkolnyy <kshk@linux.ibm.com>, mjrosato@linux.ibm.com
Cc: farman@linux.ibm.com, richard.henderson@linaro.org, iii@linux.ibm.com,
 david@kernel.org, cohuck@redhat.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
References: <20260804024443.56445-1-kshk@linux.ibm.com>
 <20260804024443.56445-15-kshk@linux.ibm.com>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <20260804024443.56445-15-kshk@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=E6P9Y6dl c=1 sm=1 tr=0 ts=6a73b2de cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=20KFwNOVAAAA:8
 a=VnNF1IyMAAAA:8 a=W118-njQ60ViCOaqzc4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: v_at3GInW_q4XiFBjQ3au49vyrqxSnnH
X-Proofpoint-GUID: v_at3GInW_q4XiFBjQ3au49vyrqxSnnH
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDE3OSBTYWx0ZWRfX8e8wyEsSZv8R
 7CozNTdLZDIDqyvpuKuHdtG0keUaG0jcpa7iZshLwqDEpdIUFK3W82nbJB0U8BoFW+rq66Euqyk
 eTtM78LvYpNKsZnkk5zIPp0eAqaDev8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDE3OSBTYWx0ZWRfXzAqRz5yi4rEV
 fNRHyxRIlXX70bzSLIfXLUVhlo+Tp+UbQ2xmCfS11FeyIW8Y36tTnkp10Kthi5NtWLQu0RZrtFx
 DVfV/CvwmM8DpPRJ0xpP3yX++a/TNtZWIPyEDJ1NtaFRoiOcGD+rCs4nYAWji+HZsJnxu0kIc9g
 xE7AnK79+G4bm+gpEuFvHeWYBClJqluUMRz5hiqmuUeBmi89rApqN77ttithrzhcxNAV7FvRWEo
 o6+g1lLsnFDHOQ/E2LE2nQMfzH3DvsTT1pV1UmTjIYtR5m3IoeqLihysx7tWts2zucNLLf2mqf8
 0F/xQERvpmLfTYWcfvDAy80h8obeb9dfKGJNjFrtD5ZCPMshqzuUbBHLWsn4JgFjGodM+geFYgd
 5TlmVjSbimeRhhhavVguxRLDtXRkb/0ww870ilWrd2kM3IRfT4KvTeLFuA9Lodkt0ZVgtjrftQ5
 LrX+ag0qzdU+lWCUqGw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_05,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608050179
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


On 8/3/2026 7:44 PM, Konstantin Shkolnyy wrote:
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
> Signed-off-by: Konstantin Shkolnyy<kshk@linux.ibm.com>
> ---
>   hw/s390x/s390-pci-bus.c         | 189 +++++++++++++++++++++++++++++++-
>   hw/s390x/s390-pci-inst.c        |   2 +-
>   hw/s390x/s390-virtio-ccw.c      |   4 +
>   include/hw/s390x/s390-pci-bus.h |   4 +
>   4 files changed, 193 insertions(+), 6 deletions(-)
>
> diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
> index a94e24a2ac..9441c80ef4 100644
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
> @@ -917,6 +923,23 @@ static void set_pbdev_info(S390PCIBusDevice *pbdev)
>       pbdev->pci_group = s390_group_find(ZPCI_DEFAULT_FN_GRP);
>   }
>   
> +static int s390_set_emul_dev_migration_blocker(S390pciState *s, Error **errp)
> +{
> +    if (s->emul_dev_migr_enabled) {
> +        return 0;
> +    }
> +    error_setg(&s->emul_dev_migr_blocker,
> +               "Migration disabled for emulated zPCI devices on this machine type");
> +    return migrate_add_blocker(&s->emul_dev_migr_blocker, errp);
> +}
> +
I was trying to test this patch series, and something i tried was doing 
was a save/restore of a VM with just CCW devices. But with this patch 
the save/restore of the VM fails with error:

error: Requested operation is not valid: cannot migrate domain: 
Migration disabled for emulated zPCI devices on this machine type

I think this is a regression, as the save/restore works with the same 
guest definition with current master branch. I also think this may break 
live migration for guest with just CCW devices. Something to also note, 
by default libvirt auto adds a pci-root controller to the guest 
definition [1]. So i wonder if that's tripping up the migration blocker?


[1] 
https://docs.redhat.com/en/documentation/red_hat_enterprise_linux/7/html/virtualization_deployment_and_administration_guide/sect-guest_virtual_machine_device_configuration-configuring_device_controllers 


Thanks

Farhan


