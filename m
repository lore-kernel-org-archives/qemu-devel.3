Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1B99C5B549
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Jun 2025 13:48:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMoT8-0005aM-F5; Wed, 04 Jun 2025 09:47:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akrowiak@linux.ibm.com>)
 id 1uMoSs-0005Vm-1E; Wed, 04 Jun 2025 09:47:35 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akrowiak@linux.ibm.com>)
 id 1uMoSp-0007pS-0S; Wed, 04 Jun 2025 09:47:33 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5543sEXu022823;
 Wed, 4 Jun 2025 13:47:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=zF4io4
 D8HJJgvuHUpfceWMmhTxBuH4KiDu5ePGvqgN4=; b=olkbNqFcsHauGbVgBKHGCN
 9e0XvlCKYkkFKSOAaxCgQRMExHkKjgnJwMmR6hnKtZ75pbNEWyaPH5Omw7WkxY5+
 uyF7T/85s8eLgHxM8zsJ/c5t0a4T/5qR4Ru6H30wv/AyDnj3dFu23Z05IuImwqko
 HTPxv95pK3RhbGQTlaGbs3c6RU+Pw1QGRqpzV2E96YbgHWLDe1VaW7VNTxJUGdnz
 1BX1W7YB6afV7FMd7qdAwezh9bU3CGFq/JaR+LAFL+5XccVcLoa758jsytpiFZug
 sqTvdN0+YTdXvR7DGV65FXY7CoRBe6SfcXkEcN5V1mX5nYvvLOFZ3tSM37neFHLg
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 471geytyvu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Jun 2025 13:47:26 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 554BrcXY022530;
 Wed, 4 Jun 2025 13:47:25 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 470c3tg529-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Jun 2025 13:47:25 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 554DlOoL27066960
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 4 Jun 2025 13:47:24 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1098F58052;
 Wed,  4 Jun 2025 13:47:24 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B08EE5805E;
 Wed,  4 Jun 2025 13:47:22 +0000 (GMT)
Received: from [9.61.64.137] (unknown [9.61.64.137])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  4 Jun 2025 13:47:22 +0000 (GMT)
Message-ID: <02f064f7-e400-4d7b-ba04-cb5dc6ee93f0@linux.ibm.com>
Date: Wed, 4 Jun 2025 09:47:22 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v11 3/4] hw/vfio/ap: Storing event information for an
 AP configuration change event
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Rorie Reyes <rreyes@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Cc: pbonzini@redhat.com, cohuck@redhat.com, pasic@linux.ibm.com,
 jjherne@linux.ibm.com, borntraeger@linux.ibm.com,
 alex.williamson@redhat.com, thuth@redhat.com
References: <20250523160338.41896-1-rreyes@linux.ibm.com>
 <20250523160338.41896-4-rreyes@linux.ibm.com>
 <66ad7451-b7a6-4112-8f20-1af06d5b482a@redhat.com>
 <834be7a8-922a-4e39-8453-6c9a1957d3ac@linux.ibm.com>
 <1a896c28-783b-4a1e-9cf5-6b8abfe8d7e4@redhat.com>
 <adca5063-786e-4c4e-90f8-dd378a2aa71c@linux.ibm.com>
 <5248c4f1-923e-4f6b-9c3f-ac24666fea04@redhat.com>
Content-Language: en-US
From: Anthony Krowiak <akrowiak@linux.ibm.com>
In-Reply-To: <5248c4f1-923e-4f6b-9c3f-ac24666fea04@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Pq2TbxM3 c=1 sm=1 tr=0 ts=68404e6e cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=sWKEhP36mHoA:10 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=xNgNI3Vgro7NdL7tVQwA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA0MDEwMyBTYWx0ZWRfX6UHDGaLGx9Ty
 Ji+29E11wMhyhfgZ0qTJGSBo/GUno3oSHSh/VoBcVB946mT1DPB1mYhwSUlplDySH0lnr2QaTvU
 /Wct7L+3QSJ/0qOsQTajPXEWUWin/FVT/7/d26df3hnkkB0VeedHVRfC+Qq0qgtaX2YVl+zKqab
 1fKRI6mHsbtYsSmCZmWgj/C8eDqEaQ4aR8AH0B7uQBULwB5Q7xIX+LuXm+oeAyVZ1vm13+Trudn
 yMPSci8zEbW75YFyvqbfX04Yr4uHhHdWW9/88emwj9qrVPNNA27zRBUn7xqpWWkPbo/OfEzFxm0
 vyPSNoqFg6CbgMsj3l/PjwX/Cn+135mFHCqJruzdjcaUeoXUhN3/0ah+0h61B46sGWVQcFHdmST
 qLVZB5O5GV3NQWgsbuIpcMA4dgzISc98FAlvdI7jWoT0sB7gtJ3TVwstKM/oOI0eF/lAdz+d
X-Proofpoint-GUID: MTs8Zh8531XXBttFftO7BHK4j5NYz5P2
X-Proofpoint-ORIG-GUID: MTs8Zh8531XXBttFftO7BHK4j5NYz5P2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-04_03,2025-06-03_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0 priorityscore=1501
 mlxscore=0 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506040103
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=akrowiak@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
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




On 6/3/25 4:30 PM, Cédric Le Goater wrote:
> On 6/3/25 20:01, Rorie Reyes wrote:
>>
>> On 6/3/25 10:21 AM, Cédric Le Goater wrote:
>>> On 6/3/25 14:58, Rorie Reyes wrote:
>>>> Hey Cedric,
>>>>
>>>> You mentioned the following in my v9 patches
>>>>
>>>> "In that case, let's keep it simple (no mutex) and add a 
>>>> assert(bql_locked())
>>>> statement where we think the bql should be protecting access to shared
>>>> resources. "
>>>>
>>>> Does this still apply down bellow?
>>>
>>> Anthony replied :
>>>
>>> https://lore.kernel.org/qemu-devel/ed2a2aa3-68a7-480c-a6a4-a8219af12d7b@linux.ibm.com/ 
>>>
>>>
>>> Thanks,
>>>
>>> C.
>>>
>> So we'll still use WITH_QEMU_LOCK_GUARD?
>
> If a lock is needed to protect the list, then 
> ap_chsc_sei_nt0_have_event()
> should lock/unlock too. WITH_QEMU_LOCK_GUARD() is just a pratical way to
> do so.

Since ap_chsc_sei_nt0_have_event() is a single line that returns
!QTAILQ_EMPTY(&cfg_chg_events), wouldn't it be better to just
use the QEMU_LOCK_GUARD macro which, if I'm not mistaken,
will unlock on the return statement?

>
>
> Thanks,
>
> C.
>
>
>
>>>>
>>>> On 5/26/25 4:40 AM, Cédric Le Goater wrote:
>>>>> On 5/23/25 18:03, Rorie Reyes wrote:
>>>>>> These functions can be invoked by the function that handles 
>>>>>> interception
>>>>>> of the CHSC SEI instruction for requests indicating the 
>>>>>> accessibility of
>>>>>> one or more adjunct processors has changed.
>>>>>>
>>>>>> Signed-off-by: Rorie Reyes <rreyes@linux.ibm.com>
>>>>>> ---
>>>>>>   hw/vfio/ap.c                 | 53 
>>>>>> ++++++++++++++++++++++++++++++++++++
>>>>>>   include/hw/s390x/ap-bridge.h | 39 ++++++++++++++++++++++++++
>>>>>>   2 files changed, 92 insertions(+)
>>>>>>
>>>>>> diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
>>>>>> index fc435f5c5b..97a42a575a 100644
>>>>>> --- a/hw/vfio/ap.c
>>>>>> +++ b/hw/vfio/ap.c
>>>>>> @@ -10,6 +10,7 @@
>>>>>>    * directory.
>>>>>>    */
>>>>>>   +#include <stdbool.h>
>>>>>>   #include "qemu/osdep.h"
>>>>>>   #include CONFIG_DEVICES /* CONFIG_IOMMUFD */
>>>>>>   #include <linux/vfio.h>
>>>>>> @@ -48,6 +49,8 @@ typedef struct APConfigChgEvent {
>>>>>>   static QTAILQ_HEAD(, APConfigChgEvent) cfg_chg_events =
>>>>>>       QTAILQ_HEAD_INITIALIZER(cfg_chg_events);
>>>>>>   +static QemuMutex cfg_chg_events_lock;
>>>>>> +
>>>>>>   OBJECT_DECLARE_SIMPLE_TYPE(VFIOAPDevice, VFIO_AP_DEVICE)
>>>>>>     static void vfio_ap_compute_needs_reset(VFIODevice *vdev)
>>>>>> @@ -96,6 +99,49 @@ static void 
>>>>>> vfio_ap_cfg_chg_notifier_handler(void *opaque)
>>>>>>     }
>>>>>>   +int ap_chsc_sei_nt0_get_event(void *res)
>>>>>> +{
>>>>>> +    ChscSeiNt0Res *nt0_res  = (ChscSeiNt0Res *)res;
>>>>>> +    APConfigChgEvent *cfg_chg_event;
>>>>>> +
>>>>>> +    qemu_mutex_lock(&cfg_chg_events_lock);
>>>>>
>>>>> please consider using WITH_QEMU_LOCK_GUARD()
>>>>>
>>>> See note above about bql_locked
>>>>>> +    if (!ap_chsc_sei_nt0_have_event()) {
>>>>>> +        qemu_mutex_unlock(&cfg_chg_events_lock);
>>>>>> +        return EVENT_INFORMATION_NOT_STORED;
>>>>>> +    }
>>>>>> +
>>>>>> +    cfg_chg_event = QTAILQ_FIRST(&cfg_chg_events);
>>>>>> +    QTAILQ_REMOVE(&cfg_chg_events, cfg_chg_event, next);
>>>>>> +
>>>>>> +    qemu_mutex_unlock(&cfg_chg_events_lock);
>>>>>> +
>>>>>> +    memset(nt0_res, 0, sizeof(*nt0_res));
>>>>>> +    g_free(cfg_chg_event);
>>>>>> +
>>>>>> +    /*
>>>>>> +     * If there are any AP configuration change events in the 
>>>>>> queue,
>>>>>> +     * indicate to the caller that there is pending event info in
>>>>>> +     * the response block
>>>>>> +     */
>>>>>> +    if (ap_chsc_sei_nt0_have_event()) {
>>>>>> +        nt0_res->flags |= PENDING_EVENT_INFO_BITMASK;
>>>>>> +    }
>>>>>> +
>>>>>> +    nt0_res->length = sizeof(ChscSeiNt0Res);
>>>>>> +    nt0_res->code = NT0_RES_RESPONSE_CODE;
>>>>>> +    nt0_res->nt = NT0_RES_NT_DEFAULT;
>>>>>> +    nt0_res->rs = NT0_RES_RS_AP_CHANGE;
>>>>>> +    nt0_res->cc = NT0_RES_CC_AP_CHANGE;
>>>>>> +
>>>>>> +    return EVENT_INFORMATION_STORED;
>>>>>> +}
>>>>>> +
>>>>>> +bool ap_chsc_sei_nt0_have_event(void)
>>>>>
>>>>> hmm, no locking ?
>>>>>
>>>> See not above for bql_locked
>>>>>> +{
>>>>>> +    return !QTAILQ_EMPTY(&cfg_chg_events);
>>>>>> +}
>>>>>> +
>>>>>>   static bool vfio_ap_register_irq_notifier(VFIOAPDevice *vapdev,
>>>>>>                                             unsigned int irq, 
>>>>>> Error **errp)
>>>>>>   {
>>>>>> @@ -192,6 +238,13 @@ static void vfio_ap_realize(DeviceState 
>>>>>> *dev, Error **errp)
>>>>>>       VFIOAPDevice *vapdev = VFIO_AP_DEVICE(dev);
>>>>>>       VFIODevice *vbasedev = &vapdev->vdev;
>>>>>>   +    static bool lock_initialized;
>>>>>> +
>>>>>> +    if (!lock_initialized) {
>>>>>> +        qemu_mutex_init(&cfg_chg_events_lock);
>>>>>> +        lock_initialized = true;
>>>>>> +    }
>>>>>
>>>>> this could be replaced with a constructor routine. See hyperv.
>>>>>
>>>>>
>>>>> Thanks,
>>>>>
>>>>> C.
>>>>>
>>>> Noted
>>>>>
>>>>>
>>>>>>       if (!vfio_device_get_name(vbasedev, errp)) {
>>>>>>           return;
>>>>>>       }
>>>>>> diff --git a/include/hw/s390x/ap-bridge.h 
>>>>>> b/include/hw/s390x/ap-bridge.h
>>>>>> index 470e439a98..7efc52928d 100644
>>>>>> --- a/include/hw/s390x/ap-bridge.h
>>>>>> +++ b/include/hw/s390x/ap-bridge.h
>>>>>> @@ -16,4 +16,43 @@
>>>>>>     void s390_init_ap(void);
>>>>>>   +typedef struct ChscSeiNt0Res {
>>>>>> +    uint16_t length;
>>>>>> +    uint16_t code;
>>>>>> +    uint8_t reserved1;
>>>>>> +    uint16_t reserved2;
>>>>>> +    uint8_t nt;
>>>>>> +#define PENDING_EVENT_INFO_BITMASK 0x80;
>>>>>> +    uint8_t flags;
>>>>>> +    uint8_t reserved3;
>>>>>> +    uint8_t rs;
>>>>>> +    uint8_t cc;
>>>>>> +} QEMU_PACKED ChscSeiNt0Res;
>>>>>> +
>>>>>> +#define NT0_RES_RESPONSE_CODE 1
>>>>>> +#define NT0_RES_NT_DEFAULT    0
>>>>>> +#define NT0_RES_RS_AP_CHANGE  5
>>>>>> +#define NT0_RES_CC_AP_CHANGE  3
>>>>>> +
>>>>>> +#define EVENT_INFORMATION_NOT_STORED 1
>>>>>> +#define EVENT_INFORMATION_STORED     0
>>>>>> +
>>>>>> +/**
>>>>>> + * ap_chsc_sei_nt0_get_event - Retrieve the next pending AP config
>>>>>> + * change event
>>>>>> + * @res: Pointer to a ChscSeiNt0Res struct to be filled with event
>>>>>> + * data
>>>>>> + *
>>>>>> + * This function checks for any pending AP config change events 
>>>>>> and,
>>>>>> + * if present, populates the provided response structure with the
>>>>>> + * appropriate SEI NT0 fields.
>>>>>> + *
>>>>>> + * Return:
>>>>>> + *   EVENT_INFORMATION_STORED - An event was available and 
>>>>>> written to @res
>>>>>> + *   EVENT_INFORMATION_NOT_STORED - No event was available
>>>>>> + */
>>>>>> +int ap_chsc_sei_nt0_get_event(void *res);
>>>>>> +
>>>>>> +bool ap_chsc_sei_nt0_have_event(void);
>>>>>> +>   #endif
>>>>>
>>>>
>>>
>>
>


