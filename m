Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCC44C54E65
	for <qemu-devel@archiver.kernel.org>; Thu, 22 May 2025 19:03:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uIBBv-0008EE-PT; Thu, 22 May 2025 15:02:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akrowiak@linux.ibm.com>)
 id 1uIBBt-0008Dd-DE; Thu, 22 May 2025 15:02:53 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akrowiak@linux.ibm.com>)
 id 1uIBBr-0005r5-GG; Thu, 22 May 2025 15:02:53 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54MIt0OP014553;
 Thu, 22 May 2025 19:02:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=NXqTeV
 c815y6Tg/w2L6LBYcu0DDwrTEzUIw/aF/9KHk=; b=fAWKfF9243n76jhGO5gSeP
 sT+/SkVwOjRz/Eoo3uYGVMNN8SZJA9XX/E9phPbTRs4xpvf/QsUsvGFYSjYB4OnC
 Pz35+6AoXJpfZGwaAIZhEii5b/lfWH3fQuL0L21JtVRarLYGxXJLoI3iALe74HgJ
 AAqb//X+OmDpdYrjNhxkF/Wl/4mZmyjIRoB0KPHkEaYNoc13yrRG3LsdSxQ7Nf9I
 QigDCLyBr1p87Iv122ygbdjrZ1qTqQV3zquwwH7RYAWiwWPtzdXCP2tPcFFVx0xt
 VgSd3a6NNYoRVHUIvQ1mqqXYA5yLDhZmz8iW3Mnw06//UhdwFOpV0pPd0FCMoCeg
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46t9m7r1ey-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 22 May 2025 19:02:49 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54MHpA2G024701;
 Thu, 22 May 2025 19:02:48 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46rwkrav5n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 22 May 2025 19:02:48 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 54MJ2lDK23658892
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 22 May 2025 19:02:47 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 780AA58052;
 Thu, 22 May 2025 19:02:47 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2170F58050;
 Thu, 22 May 2025 19:02:46 +0000 (GMT)
Received: from [9.61.89.69] (unknown [9.61.89.69])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 22 May 2025 19:02:45 +0000 (GMT)
Message-ID: <8a80ca26-69f3-4d7c-85c1-19d269fea504@linux.ibm.com>
Date: Thu, 22 May 2025 15:02:45 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v9 3/4] hw/vfio/ap: Storing event information for an
 AP configuration change event
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Rorie Reyes <rreyes@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Cc: pbonzini@redhat.com, cohuck@redhat.com, pasic@linux.ibm.com,
 jjherne@linux.ibm.com, borntraeger@linux.ibm.com,
 alex.williamson@redhat.com, thuth@redhat.com
References: <20250512180230.50129-1-rreyes@linux.ibm.com>
 <20250512180230.50129-4-rreyes@linux.ibm.com>
 <f94d3555-2f09-4620-b0e7-19fbdae86323@redhat.com>
Content-Language: en-US
From: Anthony Krowiak <akrowiak@linux.ibm.com>
In-Reply-To: <f94d3555-2f09-4620-b0e7-19fbdae86323@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=SMZCVPvH c=1 sm=1 tr=0 ts=682f74d9 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=sWKEhP36mHoA:10 a=VnNF1IyMAAAA:8
 a=KLN-wKzAY43euIGoA2oA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: ZK6heknAdAnby-OAHxsq_cFd62q6rn75
X-Proofpoint-ORIG-GUID: ZK6heknAdAnby-OAHxsq_cFd62q6rn75
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIyMDE4NyBTYWx0ZWRfX9/+IyphjX1RG
 VqiFFgnSTIQ3J4E6+iKB5WVRH+y5OHiFpPBCCr1gvboK50jjrHfYdIlK15d1BjNyUin2/9hRsh6
 nEXvlXrulsmZ+sTUzWJGVKMDLz6YduWVwNy487ODHEzYaLL7l43FzHSrNS4mN4yAKskb2+XMkus
 aKbyJmYBy+/XDnfnNtqb/eSiEWFq2+34RHAmQu/8lMnDw7lLEmXJSRS6vgcPffPJg+nueN/oZqw
 pzm9YQoLXYR2JFrGBXjkiewTKVlWUNGa9e7Tr3mpoXyhd9ms38AEcxFk2qUvG0IJjgTtz5lwDNH
 M0C+XE6b47BBZqxhhmBNRluzkIz02O0ukygQ2nAkE/52M9TLZz71dwCJtx/fnIjZs4N2zph+Y49
 niF4o69AaPRhkR9p6DDu3A1w6hxhR9nd6FkxVShPJhzcWHOljEF5d8FTMECnKbnsAxHVRLcV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-22_09,2025-05-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 mlxlogscore=999 suspectscore=0 bulkscore=0 clxscore=1015 adultscore=0
 phishscore=0 mlxscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0
 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505220187
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=akrowiak@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
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




On 5/22/25 9:35 AM, Cédric Le Goater wrote:
> On 5/12/25 20:02, Rorie Reyes wrote:
>> These functions can be invoked by the function that handles interception
>> of the CHSC SEI instruction for requests indicating the accessibility of
>> one or more adjunct processors has changed.
>>
>> Signed-off-by: Rorie Reyes <rreyes@linux.ibm.com>
>> ---
>>   hw/vfio/ap.c                 | 39 ++++++++++++++++++++++++++++++++++++
>>   include/hw/s390x/ap-bridge.h | 22 ++++++++++++++++++++
>>   2 files changed, 61 insertions(+)
>>
>> diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
>> index 5ea5dd9cca..4f88f80c54 100644
>> --- a/hw/vfio/ap.c
>> +++ b/hw/vfio/ap.c
>> @@ -96,6 +96,45 @@ static void vfio_ap_cfg_chg_notifier_handler(void 
>> *opaque)
>>     }
>>   +int ap_chsc_sei_nt0_get_event(void *res)
>> +{
>> +    ChscSeiNt0Res *nt0_res  = (ChscSeiNt0Res *)res;
>> +    APConfigChgEvent *cfg_chg_event;
>> +
>> +    if (!ap_chsc_sei_nt0_have_event()) {
>> +        return 1;
>> +    }
>> +
>> +    cfg_chg_event = QTAILQ_FIRST(&cfg_chg_events);
>> +    memset(nt0_res, 0, sizeof(*nt0_res));
>> +
>> +    QTAILQ_REMOVE(&cfg_chg_events, cfg_chg_event, next);
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
>> +    return 0;
>> +
>
> extra white line ^
>
> and returning a bool would make more sense.

It may make more sense from a readability standpoint,
but if you look at the caller (chsc_sei_nt0_get_event in 
target/s390x/ioinst.c),
it returns an int, so it can simply return whatever is returned from this
function. On the other hand, it really doesn't make a difference, so if
you feel strongly about this, then it can be changed to a bool.


>
>> +}
>> +
>> +int ap_chsc_sei_nt0_have_event(void)
>> +{
>> +    return !QTAILQ_EMPTY(&cfg_chg_events);
>
> same here for the bool.

same as above

>
>> +}
>> +
>>   static bool vfio_ap_register_irq_notifier(VFIOAPDevice *vapdev,
>>                                             unsigned int irq, Error 
>> **errp)
>>   {
>> diff --git a/include/hw/s390x/ap-bridge.h b/include/hw/s390x/ap-bridge.h
>> index 470e439a98..f4d838bf99 100644
>> --- a/include/hw/s390x/ap-bridge.h
>> +++ b/include/hw/s390x/ap-bridge.h
>> @@ -16,4 +16,26 @@
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
>> +#define NT0_RES_RESPONSE_CODE 1;
>> +#define NT0_RES_NT_DEFAULT    0;
>> +#define NT0_RES_RS_AP_CHANGE  5;
>> +#define NT0_RES_CC_AP_CHANGE  3;
>> +
>> +int ap_chsc_sei_nt0_get_event(void *res);
>
> Documentation would be nice to have since a "return 1" means failure.

True.

>
>> +
>> +int ap_chsc_sei_nt0_have_event(void);
>> +>   #endif
>
>
> Thanks,
>
> C.
>
>


