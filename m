Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CF54C5B555
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 12:59:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMRE9-00087W-RF; Tue, 03 Jun 2025 08:58:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rreyes@linux.ibm.com>)
 id 1uMRE5-00087A-RJ; Tue, 03 Jun 2025 08:58:46 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rreyes@linux.ibm.com>)
 id 1uMRDy-0003RI-PB; Tue, 03 Jun 2025 08:58:45 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5536oELo013970;
 Tue, 3 Jun 2025 12:58:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=4Rd9cI
 KbImqWB/REmhKw1Bxw+4IRWhyDH3bJAYuFb30=; b=JZJx/en6sjxqgvpcINaBWt
 O6TcjjU/wmjmqntD03ok95HELptax0A4mQKeYw3CIUwTItz8+ygSMliHU0z+rE5o
 9lNQ3d4MedaHS6a6i4RdwCoePUO8l0/uctp/T5WTpQD6ugzDD1T8Eekfj5A61JRP
 LzpEDIiS165eRgZX1fu9qs8vBHMTX0AyX7HXlaBQQv1gf3IOc9tydkn0X//sxwQp
 zLSaBv9eMW6w+dWLH/lH23HlQPYlVlubmbtN+x8Rv3LTuJjVpv+5t0QWCEF1MeqI
 +PTC9mN9B5X8CXQeShIyyXUP+iCGtF70uhtx10EsVgPP0iRX22A2B4JLkLI8tYsg
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 471geymeuj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 03 Jun 2025 12:58:32 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 553A6YRt028431;
 Tue, 3 Jun 2025 12:58:32 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 470eakan0u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 03 Jun 2025 12:58:32 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 553CwUK432637538
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 3 Jun 2025 12:58:30 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 699D35805B;
 Tue,  3 Jun 2025 12:58:30 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6C79D58058;
 Tue,  3 Jun 2025 12:58:29 +0000 (GMT)
Received: from [9.61.255.197] (unknown [9.61.255.197])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  3 Jun 2025 12:58:29 +0000 (GMT)
Message-ID: <834be7a8-922a-4e39-8453-6c9a1957d3ac@linux.ibm.com>
Date: Tue, 3 Jun 2025 08:58:28 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v11 3/4] hw/vfio/ap: Storing event information for an
 AP configuration change event
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org, 
 qemu-s390x@nongnu.org
Cc: pbonzini@redhat.com, cohuck@redhat.com, pasic@linux.ibm.com,
 jjherne@linux.ibm.com, borntraeger@linux.ibm.com,
 alex.williamson@redhat.com, thuth@redhat.com, akrowiak@linux.ibm.com
References: <20250523160338.41896-1-rreyes@linux.ibm.com>
 <20250523160338.41896-4-rreyes@linux.ibm.com>
 <66ad7451-b7a6-4112-8f20-1af06d5b482a@redhat.com>
Content-Language: en-US
From: Rorie Reyes <rreyes@linux.ibm.com>
In-Reply-To: <66ad7451-b7a6-4112-8f20-1af06d5b482a@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: k8bParzvx6SqLGsTWGnEp5CNplZaTDLj
X-Proofpoint-ORIG-GUID: k8bParzvx6SqLGsTWGnEp5CNplZaTDLj
X-Authority-Analysis: v=2.4 cv=X4dSKHTe c=1 sm=1 tr=0 ts=683ef178 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=sWKEhP36mHoA:10 a=VnNF1IyMAAAA:8
 a=pWkGqAWMjnBmbXB93jwA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjAzMDEwOSBTYWx0ZWRfX54wzA8rlMhNp
 6G/wSTDb2g8bv4KIbyf8YLBAzBHTgvSrD7gj+1CQjuSGPWr2EMcsvdEx180Khsbpw3BPlSl/XMX
 e0FMxr3mpBqEder3DL4jXyk3ahXfs4h/LP1fDswgivf37AEJ8FcHOfv+7Bfa5gNbdgNqjWfMEcI
 HCefaCvT4uuB5VljRPCAYBUXTBfhfjO6K58XdMzF3RPE5kZ/jHjTS8O+xYj9jvrcRfbpl+LUV7X
 M8HZNSGEn09eWRNwIxVm56Gp+pP7UGA60bBtR8OvAJVjy6Xtq6214+PhMA0JFgSKrWfDuvm4j/p
 434xnvCRrvN0A4Kz4h4sbAi+D2mN8wtfJB2eu5nMyhRZWqGBncAiPrMia2mK3ih9Lh6rA4CIlXD
 Mx0pzMUZHT72ieFHOnYUM6uTxoF9hb8Cc2YX7s7mYhBEjFc1gxcY5H7WaMXySVyIhHfsL3QL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-03_01,2025-06-02_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 clxscore=1015 phishscore=0 bulkscore=0
 malwarescore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506030109
Received-SPF: pass client-ip=148.163.158.5; envelope-from=rreyes@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Hey Cedric,

You mentioned the following in my v9 patches

"In that case, let's keep it simple (no mutex) and add a 
assert(bql_locked())
statement where we think the bql should be protecting access to shared
resources. "

Does this still apply down bellow?

On 5/26/25 4:40 AM, Cédric Le Goater wrote:
> On 5/23/25 18:03, Rorie Reyes wrote:
>> These functions can be invoked by the function that handles interception
>> of the CHSC SEI instruction for requests indicating the accessibility of
>> one or more adjunct processors has changed.
>>
>> Signed-off-by: Rorie Reyes <rreyes@linux.ibm.com>
>> ---
>>   hw/vfio/ap.c                 | 53 ++++++++++++++++++++++++++++++++++++
>>   include/hw/s390x/ap-bridge.h | 39 ++++++++++++++++++++++++++
>>   2 files changed, 92 insertions(+)
>>
>> diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
>> index fc435f5c5b..97a42a575a 100644
>> --- a/hw/vfio/ap.c
>> +++ b/hw/vfio/ap.c
>> @@ -10,6 +10,7 @@
>>    * directory.
>>    */
>>   +#include <stdbool.h>
>>   #include "qemu/osdep.h"
>>   #include CONFIG_DEVICES /* CONFIG_IOMMUFD */
>>   #include <linux/vfio.h>
>> @@ -48,6 +49,8 @@ typedef struct APConfigChgEvent {
>>   static QTAILQ_HEAD(, APConfigChgEvent) cfg_chg_events =
>>       QTAILQ_HEAD_INITIALIZER(cfg_chg_events);
>>   +static QemuMutex cfg_chg_events_lock;
>> +
>>   OBJECT_DECLARE_SIMPLE_TYPE(VFIOAPDevice, VFIO_AP_DEVICE)
>>     static void vfio_ap_compute_needs_reset(VFIODevice *vdev)
>> @@ -96,6 +99,49 @@ static void vfio_ap_cfg_chg_notifier_handler(void 
>> *opaque)
>>     }
>>   +int ap_chsc_sei_nt0_get_event(void *res)
>> +{
>> +    ChscSeiNt0Res *nt0_res  = (ChscSeiNt0Res *)res;
>> +    APConfigChgEvent *cfg_chg_event;
>> +
>> +    qemu_mutex_lock(&cfg_chg_events_lock);
>
> please consider using WITH_QEMU_LOCK_GUARD()
>
See note above about bql_locked
>> +    if (!ap_chsc_sei_nt0_have_event()) {
>> +        qemu_mutex_unlock(&cfg_chg_events_lock);
>> +        return EVENT_INFORMATION_NOT_STORED;
>> +    }
>> +
>> +    cfg_chg_event = QTAILQ_FIRST(&cfg_chg_events);
>> +    QTAILQ_REMOVE(&cfg_chg_events, cfg_chg_event, next);
>> +
>> +    qemu_mutex_unlock(&cfg_chg_events_lock);
>> +
>> +    memset(nt0_res, 0, sizeof(*nt0_res));
>> +    g_free(cfg_chg_event);
>> +
>> +    /*
>> +     * If there are any AP configuration change events in the queue,
>> +     * indicate to the caller that there is pending event info in
>> +     * the response block
>> +     */
>> +    if (ap_chsc_sei_nt0_have_event()) {
>> +        nt0_res->flags |= PENDING_EVENT_INFO_BITMASK;
>> +    }
>> +
>> +    nt0_res->length = sizeof(ChscSeiNt0Res);
>> +    nt0_res->code = NT0_RES_RESPONSE_CODE;
>> +    nt0_res->nt = NT0_RES_NT_DEFAULT;
>> +    nt0_res->rs = NT0_RES_RS_AP_CHANGE;
>> +    nt0_res->cc = NT0_RES_CC_AP_CHANGE;
>> +
>> +    return EVENT_INFORMATION_STORED;
>> +}
>> +
>> +bool ap_chsc_sei_nt0_have_event(void)
>
> hmm, no locking ?
>
See not above for bql_locked
>> +{
>> +    return !QTAILQ_EMPTY(&cfg_chg_events);
>> +}
>> +
>>   static bool vfio_ap_register_irq_notifier(VFIOAPDevice *vapdev,
>>                                             unsigned int irq, Error 
>> **errp)
>>   {
>> @@ -192,6 +238,13 @@ static void vfio_ap_realize(DeviceState *dev, 
>> Error **errp)
>>       VFIOAPDevice *vapdev = VFIO_AP_DEVICE(dev);
>>       VFIODevice *vbasedev = &vapdev->vdev;
>>   +    static bool lock_initialized;
>> +
>> +    if (!lock_initialized) {
>> +        qemu_mutex_init(&cfg_chg_events_lock);
>> +        lock_initialized = true;
>> +    }
>
> this could be replaced with a constructor routine. See hyperv.
>
>
> Thanks,
>
> C.
>
Noted
>
>
>>       if (!vfio_device_get_name(vbasedev, errp)) {
>>           return;
>>       }
>> diff --git a/include/hw/s390x/ap-bridge.h b/include/hw/s390x/ap-bridge.h
>> index 470e439a98..7efc52928d 100644
>> --- a/include/hw/s390x/ap-bridge.h
>> +++ b/include/hw/s390x/ap-bridge.h
>> @@ -16,4 +16,43 @@
>>     void s390_init_ap(void);
>>   +typedef struct ChscSeiNt0Res {
>> +    uint16_t length;
>> +    uint16_t code;
>> +    uint8_t reserved1;
>> +    uint16_t reserved2;
>> +    uint8_t nt;
>> +#define PENDING_EVENT_INFO_BITMASK 0x80;
>> +    uint8_t flags;
>> +    uint8_t reserved3;
>> +    uint8_t rs;
>> +    uint8_t cc;
>> +} QEMU_PACKED ChscSeiNt0Res;
>> +
>> +#define NT0_RES_RESPONSE_CODE 1
>> +#define NT0_RES_NT_DEFAULT    0
>> +#define NT0_RES_RS_AP_CHANGE  5
>> +#define NT0_RES_CC_AP_CHANGE  3
>> +
>> +#define EVENT_INFORMATION_NOT_STORED 1
>> +#define EVENT_INFORMATION_STORED     0
>> +
>> +/**
>> + * ap_chsc_sei_nt0_get_event - Retrieve the next pending AP config
>> + * change event
>> + * @res: Pointer to a ChscSeiNt0Res struct to be filled with event
>> + * data
>> + *
>> + * This function checks for any pending AP config change events and,
>> + * if present, populates the provided response structure with the
>> + * appropriate SEI NT0 fields.
>> + *
>> + * Return:
>> + *   EVENT_INFORMATION_STORED - An event was available and written 
>> to @res
>> + *   EVENT_INFORMATION_NOT_STORED - No event was available
>> + */
>> +int ap_chsc_sei_nt0_get_event(void *res);
>> +
>> +bool ap_chsc_sei_nt0_have_event(void);
>> +>   #endif
>

