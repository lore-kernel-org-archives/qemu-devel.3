Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14FC4F364B0
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 10:48:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wB9Oh-00026l-Td; Fri, 10 Apr 2026 06:47:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akrowiak@linux.ibm.com>)
 id 1wB9Of-00024w-8t; Fri, 10 Apr 2026 06:47:33 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akrowiak@linux.ibm.com>)
 id 1wB9Od-00007v-AL; Fri, 10 Apr 2026 06:47:33 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63A3ZmID4127453; Fri, 10 Apr 2026 10:47:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=v7cHye
 DksBOGwBdzd5aylcFyQe3xZZKadR3NFO4lREs=; b=JKuiXvp7FTgyh+99KZyuHT
 92+Ef1v6vXxtXXuWWa8BBtxodP+NLGoowXZd1Korlz7p5mtLVcTxM/naL8TGkvG1
 Ne7ObKt9cfKlRV+vlWbp7atMJueBjp8EUBE0ZRbIof3sRCIPas3yYku6Q/lW0S1M
 5FovKSN/qcZAfwm2TIY7j/f+OsIaDadUryEDFOFF9CU2cAOkXtIkrXhmovt21/Eb
 UeKijd8oeDPGxCfvu6NW9P/9LwBtrkZ8dt8jL1UzkaKDenTzveU4qzRPwh+XJRmX
 o4pMe1FTI3kI/rG3mS3RFx59lsEP/i5gBo+XXAKtuyujVd4k0bqvkqK7K1QPecnA
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dcn2ehhua-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 10 Apr 2026 10:47:28 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63A8oFm2026723;
 Fri, 10 Apr 2026 10:47:27 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dcmg87jj6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 10 Apr 2026 10:47:27 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 63AAlQIO24642138
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 10 Apr 2026 10:47:26 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C737658065;
 Fri, 10 Apr 2026 10:47:26 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0973358058;
 Fri, 10 Apr 2026 10:47:26 +0000 (GMT)
Received: from [9.61.133.90] (unknown [9.61.133.90])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 10 Apr 2026 10:47:25 +0000 (GMT)
Message-ID: <74bec63f-a251-4493-a2bb-f40675bad3c5@linux.ibm.com>
Date: Fri, 10 Apr 2026 06:47:25 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] hw/vfio/ap: Callbacks for migration of guests with
 pass-through access to AP devices
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, mjrosato@linux.ibm.com, jjherne@linux.ibm.com,
 pasic@linux.ibm.com, farman@linux.ibm.com, borntraeger@linux.ibm.com,
 alex@shazbot.org, cohuck@redhat.com
References: <20260409141352.997844-1-akrowiak@linux.ibm.com>
 <20260409141352.997844-3-akrowiak@linux.ibm.com>
 <be428e83-258e-407f-ade3-e1d48a80b074@redhat.com>
Content-Language: en-US
From: Anthony Krowiak <akrowiak@linux.ibm.com>
In-Reply-To: <be428e83-258e-407f-ade3-e1d48a80b074@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Tq_juyFEwwPJzgHhKD62n61cBnD0DKSC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEwMDEwMCBTYWx0ZWRfX7jmYn7GS8Th6
 u1Gwy7Q/OllQ03ZMMJNS7HENLGUDO9Oc7H6IkKW91xSGYHPiOgl4BpqtrquKp4I1VZOEiD62ObK
 ssNiaw3TvuL+qio78YsBxp7MouqqTh8cOg2gqZm/JSBk1+exYdB/Gu/M+koKfytWEm4TVYUpc3E
 yUx2duMFyhgtXEUcJT3t5FWiUUG/EXs+4oIzq44wniw6ubkDkxXxKV+QyfStwu+SmA7GUuoPMg0
 TMk/uLkFRPq2yhDSzK/kPkfd0Z0yQHl4jhrC9ximb5KWgdi6Y3U8U9gx6hTekjMmTYDqQxOjtjf
 Y5odH2egJKaMHJnQjCHxEzZ14Iu6xUgLyyx9Fv9CEsE+/+IPxND4WeOeT2W5uJYeb7+IGjC4e9w
 oqesH8P5j2l/6CrRtRb8aaw8TPYb53UChRKk9sWtrRA36XMnEcAZam1aWq4wuWGFJJCvwM062Ik
 63FyEZK6wajWNvEH7CA==
X-Authority-Analysis: v=2.4 cv=Cfw4Irrl c=1 sm=1 tr=0 ts=69d8d540 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=EJE7A_Tmek1c15OkdScA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: Tq_juyFEwwPJzgHhKD62n61cBnD0DKSC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-10_03,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 adultscore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604100100
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=akrowiak@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
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



On 4/10/26 4:19 AM, Cédric Le Goater wrote:
> On 4/9/26 16:13, Anthony Krowiak wrote:
>> From: Anthony  Krowiak <akrowiak@linux.ibm.com>
>>
>> Implements the callbacks used by the VFIO migration framework to migrate
>> guests with pass-through access to s390 crypto devices.
>>
>> Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
>> ---
>>   hw/vfio/ap.c | 43 +++++++++++++++++++++++++++++++++++++++----
>>   1 file changed, 39 insertions(+), 4 deletions(-)
>>
>> diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
>> index fd68983702..49947b18c3 100644
>> --- a/hw/vfio/ap.c
>> +++ b/hw/vfio/ap.c
>> @@ -32,6 +32,7 @@
>>   #include "hw/s390x/ap-bridge.h"
>>   #include "system/address-spaces.h"
>>   #include "qom/object.h"
>> +#include "vfio-migration-internal.h"
>>     #define TYPE_VFIO_AP_DEVICE      "vfio-ap"
>>   @@ -47,6 +48,7 @@ static const VMStateDescription vmstate_ap_device 
>> = {
>>       .name = "vfio-ap-device",
>>       .version_id = 1,
>>       .minimum_version_id = 1,
>> +    .unmigratable = 0,
>
> unneeded.

I'll remove it

>
>>       .fields = (const VMStateField[]) {
>>           VMSTATE_END_OF_LIST()
>>       },
>> @@ -66,17 +68,44 @@ static void __attribute__((constructor)) 
>> vfio_ap_global_init(void)
>>       qemu_mutex_init(&cfg_chg_events_lock);
>>   }
>>   +static int vfio_ap_save_config(VFIODevice *vdev, QEMUFile *f, 
>> Error **errp)
>> +{
>> +    VFIOAPDevice *vapdev = container_of(vdev, VFIOAPDevice, vdev);
>> +
>> +    return vmstate_save_state(f, &vmstate_ap_device, vapdev, NULL, 
>> errp);
>> +}
>> +
>> +static int vfio_ap_load_config(VFIODevice *vdev, QEMUFile *f)
>> +{
>> +    VFIOAPDevice *vapdev = container_of(vdev, VFIOAPDevice, vdev);
>> +    Error *err = NULL;
>> +    int ret;
>> +
>> +    ret = vmstate_load_state(f, &vmstate_ap_device, vapdev, 1, &err);
>> +    if (ret) {
>> +        error_report_err(err);
>> +    }
>> +
>> +    return ret;
>> +}
>> +
>> +static Object *vfio_ap_get_object(VFIODevice *vbasedev)
>> +{
>> +    VFIOAPDevice *vdev = container_of(vbasedev, VFIOAPDevice, vdev);
>> +
>> +    return OBJECT(vdev);
>> +}
>> +
>>   static void vfio_ap_compute_needs_reset(VFIODevice *vdev)
>>   {
>>       vdev->needs_reset = false;
>>   }
>>   -/*
>> - * We don't need vfio_hot_reset_multi and vfio_eoi operations for
>> - * vfio-ap device now.
>> - */
>>   struct VFIODeviceOps vfio_ap_ops = {
>>       .vfio_compute_needs_reset = vfio_ap_compute_needs_reset,
>> +    .vfio_save_config = vfio_ap_save_config,
>> +    .vfio_load_config = vfio_ap_load_config,
>> +    .vfio_get_object = vfio_ap_get_object,
>>   };
>>     static void vfio_ap_req_notifier_handler(void *opaque)
>> @@ -251,6 +280,10 @@ static void vfio_ap_realize(DeviceState *dev, 
>> Error **errp)
>>           goto error;
>>       }
>>   +    if (!vfio_migration_realize(vbasedev, errp)) {
>> +        goto error;
>> +    }
>> +
>>       if (!vfio_ap_register_irq_notifier(vapdev, 
>> VFIO_AP_REQ_IRQ_INDEX, &err)) {
>>           /*
>>            * Report this error, but do not make it a failing condition.
>> @@ -287,6 +320,8 @@ static void vfio_ap_unrealize(DeviceState *dev)
>>     static const Property vfio_ap_properties[] = {
>>       DEFINE_PROP_STRING("sysfsdev", VFIOAPDevice, vdev.sysfsdev),
>> +    DEFINE_PROP_ON_OFF_AUTO("enable-migration", VFIOAPDevice,
>> +                            vdev.enable_migration, ON_OFF_AUTO_ON),
>
> Why not ON_OFF_AUTO_AUTO ? This would enable migration only if kernel
> has migration support. If not, the VM would still start but migration
> would be blocked.

I will make that change but I'm wondering; how does QEMU know whether the
kernel has support for migration of vfio-ap devices or not?

>
>
> thanks,
>
> C.
>
>
>>   #ifdef CONFIG_IOMMUFD
>>       DEFINE_PROP_LINK("iommufd", VFIOAPDevice, vdev.iommufd,
>>                        TYPE_IOMMUFD_BACKEND, IOMMUFDBackend *),
>


