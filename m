Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 040ADCAC5B0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 17:22:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3HYm-00026g-EZ; Mon, 29 Sep 2025 13:21:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1v3HYi-00025e-Ej; Mon, 29 Sep 2025 13:21:08 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1v3HYa-0001QJ-Bo; Mon, 29 Sep 2025 13:21:08 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58TH4wkv006555;
 Mon, 29 Sep 2025 17:20:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=7iHJoJ
 t/TwpYePxs2wnHFRlsZOkCvypFIsP7+HcOc+c=; b=jNGZKYH9b2cmyjGU+J82kJ
 L2LaVAm8SryaEeNrBemEo0BTmmyNWWbF/plb+jQHXuwW4tKQb/4XAOmWKuZm45fJ
 nyr/j2qo78GriA9suSOnQw8qmfPO1I1v35m2uzfXV3zbAWZYWPSx3YA5Om+jhbGs
 GwJ5BxIqbftp5flUni9FcY2gtH03HQq8bQjf0NsBmYPdQbTSrdFsHPgpCxALoToZ
 1Tk/HMGZ5687DQi6d76cOcgR+2rG7uPkNaCpFwSnKpGMRot1QnN1w0Jg0g6OfJwl
 O6x6hK1c5GlruJmXtw7XT5Y9hpjmDYZR9A/NGTmYtLmwPkvzbOrbQQAzaDAa41TA
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49e7ku3vg1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 29 Sep 2025 17:20:54 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58TE3k3l024110;
 Mon, 29 Sep 2025 17:20:53 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 49evy0xxqw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 29 Sep 2025 17:20:53 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 58THKfJf24707796
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 29 Sep 2025 17:20:41 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 978DD58052;
 Mon, 29 Sep 2025 17:20:52 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C0EB858050;
 Mon, 29 Sep 2025 17:20:51 +0000 (GMT)
Received: from [9.61.248.197] (unknown [9.61.248.197])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 29 Sep 2025 17:20:51 +0000 (GMT)
Message-ID: <0c221734-5faf-4829-bc17-21ec96a91fa5@linux.ibm.com>
Date: Mon, 29 Sep 2025 10:20:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/5] vfio/pci: Add an error handler callback
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, mjrosato@linux.ibm.com,
 thuth@redhat.com, alex.williamson@redhat.com
References: <20250925174852.1302-1-alifm@linux.ibm.com>
 <20250925174852.1302-3-alifm@linux.ibm.com> <87qzvtstd7.fsf@pond.sub.org>
 <90de0c70-9309-4fd0-a5d7-3bd9e7088a0e@linux.ibm.com>
 <87ms6gmo4j.fsf@pond.sub.org>
 <4207529b-a0a5-4360-8449-f4c20661e9e8@redhat.com>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <4207529b-a0a5-4360-8449-f4c20661e9e8@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=T7WBjvKQ c=1 sm=1 tr=0 ts=68dabff6 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=Iq89dDL6uS_rAWto0rgA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: EftZPmcMekQGGQuLeyc9LapsbjbN615E
X-Proofpoint-ORIG-GUID: EftZPmcMekQGGQuLeyc9LapsbjbN615E
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAyNSBTYWx0ZWRfX1eAjQ0upGugW
 h5hW7opXkX8uhC+naVRDWVf8Z7IUV9X87pJzlkZ8QXan+MnLk2v3+ip4WO7VtKMNXKEoxhhZmtB
 WGGA8TWgFlXvRPooLSmI0vg/T31Cd02rgpXRMNtxyrFwx4YTKHPm2T4Tbu7mTWifpabL39P7Gqj
 NH9nRS/1cwDYaAHcdaJ3jZ4uZWUI/uq2CjeBqp31M3VAOol31gYOxNsdG0GUEpySHitlrPmb/sV
 n+oeCXQf+ps8uyfdqGaUZ6i5ZkuS0plvJtCbOW0MOuZtDzuIChJ3ShVY6dwHVUXIdGk8F5VC9+I
 zC7I88UQqfYtZYVZjdQXTQyz0tiCYD2PBMTLMNBBl5hML8x7tkNFvmrSNG/InnxA72+gADVX53a
 uP96rG8y2ZESxlngx3ZnaaBPXkT48w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-29_06,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 spamscore=0 suspectscore=0 priorityscore=1501
 bulkscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270025
Received-SPF: pass client-ip=148.163.156.1; envelope-from=alifm@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
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


On 9/27/2025 12:05 AM, Cédric Le Goater wrote:
> On 9/27/25 07:59, Markus Armbruster wrote:
>> Farhan Ali <alifm@linux.ibm.com> writes:
>>
>>> On 9/25/2025 9:57 PM, Markus Armbruster wrote:
>>>> Farhan Ali <alifm@linux.ibm.com> writes:
>>>>
>>>>> Provide a vfio error handling callback, that can be used by 
>>>>> devices to
>>>>> handle PCI errors for passthrough devices.
>>>>>
>>>>> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
>>>>> ---
>>>>>    hw/vfio/pci.c | 8 ++++++++
>>>>>    hw/vfio/pci.h | 1 +
>>>>>    2 files changed, 9 insertions(+)
>>>>>
>>>>> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
>>>>> index bc0b4c4d56..b02a974954 100644
>>>>> --- a/hw/vfio/pci.c
>>>>> +++ b/hw/vfio/pci.c
>>>>> @@ -3063,11 +3063,19 @@ void vfio_pci_put_device(VFIOPCIDevice *vdev)
>>>>>   static void vfio_err_notifier_handler(void *opaque)
>>>>>   {
>>>>>       VFIOPCIDevice *vdev = opaque;
>>>>> +    Error *err = NULL;
>>>>>
>>>>>       if (!event_notifier_test_and_clear(&vdev->err_notifier)) {
>>>>>           return;
>>>>>       }
>>>>>
>>>>> +    if (vdev->err_handler) {
>>>>> +        if (vdev->err_handler(vdev, &err)) {
>>>>> +            return;
>>>>> +        }
>>>>> +        error_report_err(err);
>>>>> +    }
>>>>
>>>> This is unusual.
>>>>
>>>> Functions taking an Error ** argument usually do so to report errors.
>>>> The rules spelled out in qapi/error.h apply.  In particular:
>>>>
>>>>    * - On success, the function should not touch *errp.  On 
>>>> failure, it
>>>>    *   should set a new error, e.g. with error_setg(errp, ...), or
>>>>    *   propagate an existing one, e.g. with error_propagate(errp, 
>>>> ...).
>>>>    *
>>>>    * - Whenever practical, also return a value that indicates 
>>>> success /
>>>>    *   failure.  This can make the error checking more concise, and 
>>>> can
>>>>    *   avoid useless error object creation and destruction. Note that
>>>>    *   we still have many functions returning void.  We recommend
>>>>    *   • bool-valued functions return true on success / false on 
>>>> failure,
>>>>
>>>> If ->err_handler() behaved that way, it @err would be null after it
>>>> returns false.  We'd call error_report_err(NULL), and crash.
>>>>
>>>> Functions with unusual behavior need a contract: a comment spelling 
>>>> out
>>>> their behavior.
>>>>
>>>> What is the intended behavior of the err_handler() callback?
>>>
>>> Hi Markus,
>>>
>>> Thanks for reviewing! The intended behavior for err_handler() is to 
>>> set errp and report the error on false/failure. With the above code, 
>>> I also intended fall through to vm_stop() when err_handler() fails.
>>>
>>> I think I misunderstood the errp error handling, it seems like the 
>>> correct way to do what I intended would be
>>>
>>> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
>>> index b02a974954..630de46c90 100644
>>> --- a/hw/vfio/pci.c
>>> +++ b/hw/vfio/pci.c
>>> @@ -3070,10 +3070,11 @@ static void vfio_err_notifier_handler(void 
>>> *opaque)
>>>       }
>>>
>>>       if (vdev->err_handler) {
>>> -        if (vdev->err_handler(vdev, &err)) {
>>> +        if (!vdev->err_handler(vdev, &err)) {
>>> +            error_report_err(err);
>>> +        } else {
>>>               return;
>>>           }
>>> -        error_report_err(err);
>>>       }
>>>
>>> Please correct me if I missed anything.
>>
>> Resulting function:
>>
>>     static void vfio_err_notifier_handler(void *opaque)
>>     {
>>         VFIOPCIDevice *vdev = opaque;
>>         Error *err = NULL;
>>
>>         if (!event_notifier_test_and_clear(&vdev->err_notifier)) {
>>             return;
>>         }
>>
>>         if (vdev->err_handler) {
>>             if (!vdev->err_handler(vdev, &err)) {
>>                 error_report_err(err);
>>             } else {
>>                 return;
>>             }
>>         }
>>
>>         /*
>>          * TBD. Retrieve the error details and decide what action
>>          * needs to be taken. One of the actions could be to pass
>>          * the error to the guest and have the guest driver recover
>>          * from the error. This requires that PCIe capabilities be
>>          * exposed to the guest. For now, we just terminate the
>>          * guest to contain the error.
>>          */
>>
>>         error_report("%s(%s) Unrecoverable error detected. Please 
>> collect any data possible and then kill the guest", __func__, 
>> vdev->vbasedev.name);
>>
>>         vm_stop(RUN_STATE_INTERNAL_ERROR);
>>     }
>>
>> Slighly rearranged for clearer control flow:
>>
>>     static void vfio_err_notifier_handler(void *opaque)
>>     {
>>         VFIOPCIDevice *vdev = opaque;
>>         Error *err = NULL;
>>
>>         if (!event_notifier_test_and_clear(&vdev->err_notifier)) {
>>             return;
>>         }
>>
>>         if (vdev->err_handler) {
>>             if (vdev->err_handler(vdev, &err)) {
>>                 /* Error successfully handled */
>>                 return;
>>             }
>>             error_report_err(err);
>>         }

Yes, this is what i intended to do with my patch and provide a clearer 
flow. Though the compiler error reported by Cedric, is a little 
confusing, need to understand why that happens.


>>
>>         /*
>>          * TBD. Retrieve the error details and decide what action
>>          * needs to be taken. One of the actions could be to pass
>>          * the error to the guest and have the guest driver recover
>>          * from the error. This requires that PCIe capabilities be
>>          * exposed to the guest. For now, we just terminate the
>>          * guest to contain the error.
>>          */
>>
>>         error_report("%s(%s) Unrecoverable error detected. Please 
>> collect any data possible and then kill the guest", __func__, 
>> vdev->vbasedev.name);
>>
>>         vm_stop(RUN_STATE_INTERNAL_ERROR);
>>     }
>>
>> Questions / issues:
>>
>> * Is the comment still accurate?

This comment would still apply for vfio-pci devices on other 
architectures except for s390x. We are trying to change this behavior 
for s390x.

>>
>> * When ->err_handler() fails, we report the error twice. Would it make
>>    sense to combine the two error reports into one?
>
> Yes. It was my request too.
>
> Thanks,
>
> C.

I was a little hesitant about changing the existing error message as its 
been there for almost 12 years (since commit 7b4b0e9eda ("vfio: 
QEMU-AER: Qemu changes to support AER for VFIO-PCI devices")). Nothing 
should ever dependent on specific error messages, but still.. .If the 
preference is to combine/change the message I can do that.


>
>
>
>> * Preexisting: the second error message is ugly.
>>
>>    Error messages should be short and to the point: single phrase, with
>>    no newline or trailing punctuation.  The "please collect ..." part
>>    does not belong to the error message proper, it's advice on what to
>>    do.  Better: report the error, then print advice:
>>
>>         error_report("%s(%s) Unrecoverable error detected",
>>                      __func__, vdev->vbasedev.name);
>>         error_printf("Please collect any data possible and then kill 
>> the guest.");
>>
>>    Including __func__ in an error message is an anti-pattern. Look at
>>
>>      vfio_err_notifier_handler(fred) Unrecoverable error detected
>>
>>    with a user's eyes: "vfio_err_notifier_handler" is programmer
>>    gobbledygook, the device name "fred" is useful once you realize what
>>    it is, "Unrecoverable error detected" lacks detail.
>>
>> [...]
>>
>
How about "(device) Unrecoverable PCIe error detected for device"

Thanks
Farhan



