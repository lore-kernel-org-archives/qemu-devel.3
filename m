Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68132CAC5B8
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 17:17:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3dxG-0006oh-OH; Tue, 30 Sep 2025 13:15:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1v3dx1-0006jo-2s; Tue, 30 Sep 2025 13:15:43 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1v3dwu-0007z0-Kc; Tue, 30 Sep 2025 13:15:41 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58UFaqc2011317;
 Tue, 30 Sep 2025 17:15:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=ziQ4RA
 TlhP+MJCndhQNpHm+ky/DCXPBb8a82TNWHEfU=; b=UT0RjgoGvVIr6MD1J221VE
 sne01FjR5wxMaW4IouJD7xmitS4qIUIW/NcK3rb08jclaBmBcuMEmr0AAF0LAHpc
 kCy6pExQ5k1s4J/eDoqWZ7Xox59rPFQGrBLgoguElVdMQe6DxMP6uFlwmMM/bMN2
 O0sdhllobSwCycPk6DihgMY/4n6GNQyprRaQF/2ySmhvKwqzGAM6LiYjsq4s1koJ
 L/OX/WOYjPAXgLc6VzNMCgVrIHsIr656jtwWo7qBycYLQmvyTeiS/MA9qG9uDj+T
 UZKPG5D+1ddZ4OKX16w0dflmqDRJR/yjomqUtRkU8K7MG/oMg2ZqWWCdQpzQ6J2A
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49e6bhj4k3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 30 Sep 2025 17:15:30 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58UG0AK5020074;
 Tue, 30 Sep 2025 17:15:29 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 49et8s4reu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 30 Sep 2025 17:15:29 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 58UHFTw320709892
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 30 Sep 2025 17:15:29 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1072358062;
 Tue, 30 Sep 2025 17:15:29 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7751C58058;
 Tue, 30 Sep 2025 17:15:28 +0000 (GMT)
Received: from [9.61.249.240] (unknown [9.61.249.240])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 30 Sep 2025 17:15:28 +0000 (GMT)
Message-ID: <5ebeb8ec-395b-46ca-b6d4-b2c78ae0465f@linux.ibm.com>
Date: Tue, 30 Sep 2025 10:15:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/5] vfio/pci: Add an error handler callback
To: Markus Armbruster <armbru@redhat.com>
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org, 
 qemu-s390x@nongnu.org, mjrosato@linux.ibm.com, thuth@redhat.com,
 alex.williamson@redhat.com
References: <20250925174852.1302-1-alifm@linux.ibm.com>
 <20250925174852.1302-3-alifm@linux.ibm.com> <87qzvtstd7.fsf@pond.sub.org>
 <90de0c70-9309-4fd0-a5d7-3bd9e7088a0e@linux.ibm.com>
 <87ms6gmo4j.fsf@pond.sub.org>
 <4207529b-a0a5-4360-8449-f4c20661e9e8@redhat.com>
 <0c221734-5faf-4829-bc17-21ec96a91fa5@linux.ibm.com>
 <87qzvo9tzk.fsf@pond.sub.org>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <87qzvo9tzk.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Se/6t/Ru c=1 sm=1 tr=0 ts=68dc1032 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=4j1KLcSeRx0eW2i8PyQA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAxMCBTYWx0ZWRfX04wLwojA0LTA
 Hxb+nm5nll+VjbKKGQrKzyez+XjGxcbRl1+9hjU5gCPAQ2HKvZDWMnywG33vpS4okiOZkUApHcg
 QLF8TDcWM/8gNBuKBCn0C9StsyDYc0S34vr/+ml13wlCTIlSoQtT5BkfPOF3WrmO3bdn41nxrvB
 Z5dopeFcKMxNVW/1ARoUPBlbPoBtS7togj5dL6nQ4GdH/+gqy/gluX3aCkKk1tMWGGyHaOAwcR+
 FmfqSQgFsb6kPoq+zO/4Y2uakU2xG591EtX6PaITbm3S81ikicAi/pl55aI+Pc5IabrMzvkVGmF
 +Jk0dlg0ubI/T2U4yh3+ard9pqrk4wdjUZs9kYLdvE+JwGqWjsCfIbfRxz68iK3atVhVhFQAOSn
 ds7GS9ZxwYcIPulZQDzhDogfEa34xQ==
X-Proofpoint-GUID: 4BI-AAEw9m-Mmn0VFZpHJRBpIBhCauQL
X-Proofpoint-ORIG-GUID: 4BI-AAEw9m-Mmn0VFZpHJRBpIBhCauQL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-30_03,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 clxscore=1015 phishscore=0 priorityscore=1501 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270010
Received-SPF: pass client-ip=148.163.158.5; envelope-from=alifm@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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


On 9/30/2025 2:20 AM, Markus Armbruster wrote:
> Farhan Ali <alifm@linux.ibm.com> writes:
>
>> On 9/27/2025 12:05 AM, Cédric Le Goater wrote:
>>> On 9/27/25 07:59, Markus Armbruster wrote:
>>>> Farhan Ali <alifm@linux.ibm.com> writes:
>>>>
>>>>> On 9/25/2025 9:57 PM, Markus Armbruster wrote:
>>>>>> Farhan Ali <alifm@linux.ibm.com> writes:
>>>>>>
>>>>>>> Provide a vfio error handling callback, that can be used by devices to
>>>>>>> handle PCI errors for passthrough devices.
>>>>>>>
>>>>>>> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
>>>>>>> ---
>>>>>>>     hw/vfio/pci.c | 8 ++++++++
>>>>>>>     hw/vfio/pci.h | 1 +
>>>>>>>     2 files changed, 9 insertions(+)
>>>>>>>
>>>>>>> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
>>>>>>> index bc0b4c4d56..b02a974954 100644
>>>>>>> --- a/hw/vfio/pci.c
>>>>>>> +++ b/hw/vfio/pci.c
>>>>>>> @@ -3063,11 +3063,19 @@ void vfio_pci_put_device(VFIOPCIDevice *vdev)
>>>>>>>    static void vfio_err_notifier_handler(void *opaque)
>>>>>>>    {
>>>>>>>        VFIOPCIDevice *vdev = opaque;
>>>>>>> +    Error *err = NULL;
>>>>>>>
>>>>>>>        if (!event_notifier_test_and_clear(&vdev->err_notifier)) {
>>>>>>>            return;
>>>>>>>        }
>>>>>>>
>>>>>>> +    if (vdev->err_handler) {
>>>>>>> +        if (vdev->err_handler(vdev, &err)) {
>>>>>>> +            return;
>>>>>>> +        }
>>>>>>> +        error_report_err(err);
>>>>>>> +    }
>>>>>> This is unusual.
>>>>>>
>>>>>> Functions taking an Error ** argument usually do so to report errors.
>>>>>> The rules spelled out in qapi/error.h apply.  In particular:
>>>>>>
>>>>>>     * - On success, the function should not touch *errp.  On failure, it
>>>>>>     *   should set a new error, e.g. with error_setg(errp, ...), or
>>>>>>     *   propagate an existing one, e.g. with error_propagate(errp, ...).
>>>>>>     *
>>>>>>     * - Whenever practical, also return a value that indicates success /
>>>>>>     *   failure.  This can make the error checking more concise, and can
>>>>>>     *   avoid useless error object creation and destruction. Note that
>>>>>>     *   we still have many functions returning void.  We recommend
>>>>>>     *   • bool-valued functions return true on success / false on failure,
>>>>>>
>>>>>> If ->err_handler() behaved that way, it @err would be null after it
>>>>>> returns false.  We'd call error_report_err(NULL), and crash.
>>>>>>
>>>>>> Functions with unusual behavior need a contract: a comment spelling out
>>>>>> their behavior.
>>>>>>
>>>>>> What is the intended behavior of the err_handler() callback?
>>>>> Hi Markus,
>>>>>
>>>>> Thanks for reviewing! The intended behavior for err_handler() is to set errp and report the error on false/failure. With the above code, I also intended fall through to vm_stop() when err_handler() fails.
>>>>>
>>>>> I think I misunderstood the errp error handling, it seems like the correct way to do what I intended would be
>>>>>
>>>>> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
>>>>> index b02a974954..630de46c90 100644
>>>>> --- a/hw/vfio/pci.c
>>>>> +++ b/hw/vfio/pci.c
>>>>> @@ -3070,10 +3070,11 @@ static void vfio_err_notifier_handler(void *opaque)
>>>>>        }
>>>>>
>>>>>        if (vdev->err_handler) {
>>>>> -        if (vdev->err_handler(vdev, &err)) {
>>>>> +        if (!vdev->err_handler(vdev, &err)) {
>>>>> +            error_report_err(err);
>>>>> +        } else {
>>>>>                return;
>>>>>            }
>>>>> -        error_report_err(err);
>>>>>        }
>>>>>
>>>>> Please correct me if I missed anything.
>>>> Resulting function:
>>>>
>>>>      static void vfio_err_notifier_handler(void *opaque)
>>>>      {
>>>>          VFIOPCIDevice *vdev = opaque;
>>>>          Error *err = NULL;
>>>>
>>>>          if (!event_notifier_test_and_clear(&vdev->err_notifier)) {
>>>>              return;
>>>>          }
>>>>
>>>>          if (vdev->err_handler) {
>>>>              if (!vdev->err_handler(vdev, &err)) {
>>>>                  error_report_err(err);
>>>>              } else {
>>>>                  return;
>>>>              }
>>>>          }
>>>>
>>>>          /*
>>>>           * TBD. Retrieve the error details and decide what action
>>>>           * needs to be taken. One of the actions could be to pass
>>>>           * the error to the guest and have the guest driver recover
>>>>           * from the error. This requires that PCIe capabilities be
>>>>           * exposed to the guest. For now, we just terminate the
>>>>           * guest to contain the error.
>>>>           */
>>>>
>>>>          error_report("%s(%s) Unrecoverable error detected. Please collect any data possible and then kill the guest", __func__, vdev->vbasedev.name);
>>>>
>>>>          vm_stop(RUN_STATE_INTERNAL_ERROR);
>>>>      }
>>>>
>>>> Slighly rearranged for clearer control flow:
>>>>
>>>>      static void vfio_err_notifier_handler(void *opaque)
>>>>      {
>>>>          VFIOPCIDevice *vdev = opaque;
>>>>          Error *err = NULL;
>>>>
>>>>          if (!event_notifier_test_and_clear(&vdev->err_notifier)) {
>>>>              return;
>>>>          }
>>>>
>>>>          if (vdev->err_handler) {
>>>>              if (vdev->err_handler(vdev, &err)) {
>>>>                  /* Error successfully handled */
>>>>                  return;
>>>>              }
>>>>              error_report_err(err);
>>>>          }
>> Yes, this is what i intended to do with my patch and provide a clearer flow. Though the compiler error reported by Cedric, is a little confusing, need to understand why that happens.
>>
>>
>>>>          /*
>>>>           * TBD. Retrieve the error details and decide what action
>>>>           * needs to be taken. One of the actions could be to pass
>>>>           * the error to the guest and have the guest driver recover
>>>>           * from the error. This requires that PCIe capabilities be
>>>>           * exposed to the guest. For now, we just terminate the
>>>>           * guest to contain the error.
>>>>           */
>>>>
>>>>          error_report("%s(%s) Unrecoverable error detected. Please collect any data possible and then kill the guest", __func__, vdev->vbasedev.name);
>>>>
>>>>          vm_stop(RUN_STATE_INTERNAL_ERROR);
>>>>      }
>>>>
>>>> Questions / issues:
>>>>
>>>> * Is the comment still accurate?
>> This comment would still apply for vfio-pci devices on other architectures except for s390x. We are trying to change this behavior for s390x.
> The comment is about things that should be done to handle the error.
> Would these things be done here, or in a suitable ->err_handler()?

Ideally in the err_handler(). And for s390x we try do what the comment 
mentions, which is inject the error into the guest through s390x 
architecture specific mechanism. I can remove the comment block.


>
>>>> * When ->err_handler() fails, we report the error twice. Would it make
>>>>     sense to combine the two error reports into one?
>>> Yes. It was my request too.
>>>
>>> Thanks,
>>>
>>> C.
>> I was a little hesitant about changing the existing error message as its been there for almost 12 years (since commit 7b4b0e9eda ("vfio: QEMU-AER: Qemu changes to support AER for VFIO-PCI devices")). Nothing should ever dependent on specific error messages, but still.. .If the preference is to combine/change the message I can do that.
> Don't hesitate to improve error messages.
>
>>>> * Preexisting: the second error message is ugly.
>>>>
>>>>     Error messages should be short and to the point: single phrase, with
>>>>     no newline or trailing punctuation.  The "please collect ..." part
>>>>     does not belong to the error message proper, it's advice on what to
>>>>     do.  Better: report the error, then print advice:
>>>>
>>>>          error_report("%s(%s) Unrecoverable error detected",
>>>>                       __func__, vdev->vbasedev.name);
>>>>          error_printf("Please collect any data possible and then kill the guest.");
>>>>
>>>>     Including __func__ in an error message is an anti-pattern. Look at
>>>>
>>>>       vfio_err_notifier_handler(fred) Unrecoverable error detected
>>>>
>>>>     with a user's eyes: "vfio_err_notifier_handler" is programmer
>>>>     gobbledygook, the device name "fred" is useful once you realize what
>>>>     it is, "Unrecoverable error detected" lacks detail.
>>>>
>>>> [...]
>>>>
>> How about "(device) Unrecoverable PCIe error detected for device"
> Suggest "for device %s", where %s identifies the device to the user.

Sure, I can make the change.

Thanks

Farhan

>

