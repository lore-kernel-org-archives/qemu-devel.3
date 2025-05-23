Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0867C54ED1
	for <qemu-devel@archiver.kernel.org>; Fri, 23 May 2025 03:28:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uIJ4C-0002ZQ-8v; Thu, 22 May 2025 23:27:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rreyes@linux.ibm.com>)
 id 1uIJ49-0002Yu-RW; Thu, 22 May 2025 23:27:25 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rreyes@linux.ibm.com>)
 id 1uIJ46-0000lz-VB; Thu, 22 May 2025 23:27:25 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54MNWEf0006420;
 Fri, 23 May 2025 03:27:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=sqd2IP8caI1qHulr71yUgJgGM5U4ck
 LiTj9KH9mW4AQ=; b=m8MxcyoulOYGpOFFzz55q/jb1q0zd/n7w6F2GZA8MReAFA
 DHFqwyROwYlj7BPzdx4fpp6qHSGatgowQulYqfvZGUjVqxeW6aioXVrgMYYvRbVl
 2LgYpNf6l9bexZYY3fo0NK7wu3NwwpWDYfTa4csiZ3JNd4iQs8hshZaCYMDEIcyL
 0IV35y2o+U5hiMecKaq+vDGKHWtEBS/SUy7rs7Le5IJ1dEatjKQ6f/59sg2YOHvs
 VT/Kq4sQpDhzPI0CmPxqeusNrVOAcaDSMkBdcjdSC2H9Q0IKyBWKYLTenM0cVw6p
 j6KY4AL2hQZNcQKn4sqGLvJV561TfRksVxuJ1iRA==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46t9m7su9y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 23 May 2025 03:27:20 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54N1pYD6015487;
 Fri, 23 May 2025 03:27:19 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 46rwnnmp0r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 23 May 2025 03:27:19 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 54N3RHim30343804
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 23 May 2025 03:27:18 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CDA8C58059;
 Fri, 23 May 2025 03:27:17 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D40A358057;
 Fri, 23 May 2025 03:27:16 +0000 (GMT)
Received: from [9.61.243.208] (unknown [9.61.243.208])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 23 May 2025 03:27:16 +0000 (GMT)
Content-Type: multipart/alternative;
 boundary="------------nFx8NSKvZPhRsUkgaKwMy16S"
Message-ID: <fe07b974-4f5c-45df-ba1b-6e9c16b8187f@linux.ibm.com>
Date: Thu, 22 May 2025 23:27:16 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v9 3/4] hw/vfio/ap: Storing event information for an
 AP configuration change event
From: Rorie Reyes <rreyes@linux.ibm.com>
To: Anthony Krowiak <akrowiak@linux.ibm.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: pbonzini@redhat.com, cohuck@redhat.com, pasic@linux.ibm.com,
 jjherne@linux.ibm.com, borntraeger@linux.ibm.com,
 alex.williamson@redhat.com, thuth@redhat.com
References: <20250512180230.50129-1-rreyes@linux.ibm.com>
 <20250512180230.50129-4-rreyes@linux.ibm.com>
 <f94d3555-2f09-4620-b0e7-19fbdae86323@redhat.com>
 <8a80ca26-69f3-4d7c-85c1-19d269fea504@linux.ibm.com>
 <aa68cf90-640e-4456-8918-75fb19c1847c@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <aa68cf90-640e-4456-8918-75fb19c1847c@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=SMZCVPvH c=1 sm=1 tr=0 ts=682feb18 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=dt9VzEwgFbYA:10 a=sWKEhP36mHoA:10 a=r77TgQKjGQsHNAKrUKIA:9 a=VnNF1IyMAAAA:8
 a=vGqDY7RxVrV9ny0PwA0A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=eOMxQ1cS9dQaMRMiKsEA:9 a=TI1nKImqGOUZx_2Z:21
 a=_W_S_7VecoQA:10 a=lqcHg5cX4UMA:10
X-Proofpoint-GUID: jCi9ixQwkWBU8UJPGqX06yvlvGcFP-He
X-Proofpoint-ORIG-GUID: jCi9ixQwkWBU8UJPGqX06yvlvGcFP-He
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIzMDAyNiBTYWx0ZWRfX1hOJ/ARCzm31
 p6bN7JsZoS7CM7P2Xxz8YmyJuMIjh6f+TDlqWMojvGqrezPJRo4N80wtf3fCl9nmwJ70ajM3Ae8
 7e1xI/52o2Emf1H9z6BYV3WnRut+f6nEC34/L0ThTdQNJjhRBzy8Fe/BMbyl1iwa85oRsM4z67/
 hm1/4yJP76qGZZjQHfgcLodEKFfqqwt8LFh6ULbL69FeVflqT1PjpjlMP8SpJ8r0FwzrAItknFm
 piqGjbveH7yh6gMYjdd2OQqvOFVe+b5+cPeJf0bngn1ek8rhTcFsBdBUvxbWtT8DMyoupYsBezV
 yU+6GvbMlfIIgPxr37A0xWiOPq+GrsHBGrh8Qts6cTVsXup9LfGQFagQoZnPb1IP3HVnq3PHRsN
 32zfwO2E7o/1DtN4IHCA5uTvnTz3cpfwZLPZKI4Vq0Tdf5wKXvfJ8lqg/npR57KC29sY1SBL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-23_02,2025-05-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 mlxlogscore=999 suspectscore=0 bulkscore=0 clxscore=1015 adultscore=0
 phishscore=0 mlxscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0
 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505230026
Received-SPF: pass client-ip=148.163.158.5; envelope-from=rreyes@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

This is a multi-part message in MIME format.
--------------nFx8NSKvZPhRsUkgaKwMy16S
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Please ignore my comments bellow. I made some foundational mistakes 
going through this process. I should be able to return bools based on 
Cedric's remarks. I flipped the meaning behind returning 1 vs 0 as false 
vs true which is incorrect. Returning 1 is true and returning 0 is 
false. I had those concepts mixed up. I apologize

On 5/22/25 11:05 PM, Rorie Reyes wrote:
>
>
> On 5/22/25 3:02 PM, Anthony Krowiak wrote:
>>
>>
>>
>> On 5/22/25 9:35 AM, Cédric Le Goater wrote:
>>> On 5/12/25 20:02, Rorie Reyes wrote:
>>>> These functions can be invoked by the function that handles 
>>>> interception
>>>> of the CHSC SEI instruction for requests indicating the 
>>>> accessibility of
>>>> one or more adjunct processors has changed.
>>>>
>>>> Signed-off-by: Rorie Reyes <rreyes@linux.ibm.com>
>>>> ---
>>>>   hw/vfio/ap.c                 | 39 
>>>> ++++++++++++++++++++++++++++++++++++
>>>>   include/hw/s390x/ap-bridge.h | 22 ++++++++++++++++++++
>>>>   2 files changed, 61 insertions(+)
>>>>
>>>> diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
>>>> index 5ea5dd9cca..4f88f80c54 100644
>>>> --- a/hw/vfio/ap.c
>>>> +++ b/hw/vfio/ap.c
>>>> @@ -96,6 +96,45 @@ static void 
>>>> vfio_ap_cfg_chg_notifier_handler(void *opaque)
>>>>     }
>>>>   +int ap_chsc_sei_nt0_get_event(void *res)
>>>> +{
>>>> +    ChscSeiNt0Res *nt0_res  = (ChscSeiNt0Res *)res;
>>>> +    APConfigChgEvent *cfg_chg_event;
>>>> +
>>>> +    if (!ap_chsc_sei_nt0_have_event()) {
>>>> +        return 1;
>>>> +    }
>>>> +
>>>> +    cfg_chg_event = QTAILQ_FIRST(&cfg_chg_events);
>>>> +    memset(nt0_res, 0, sizeof(*nt0_res));
>>>> +
>>>> +    QTAILQ_REMOVE(&cfg_chg_events, cfg_chg_event, next);
>>>> +    g_free(cfg_chg_event);
>>>> +
>>>> +    /*
>>>> +     * If there are any AP configuration change events in the queue,
>>>> +     * indicate to the caller that there is pending event info in
>>>> +     * the response block
>>>> +     */
>>>> +    if (ap_chsc_sei_nt0_have_event()) {
>>>> +        nt0_res->flags |= PENDING_EVENT_INFO_BITMASK;
>>>> +    }
>>>> +
>>>> +    nt0_res->length = sizeof(ChscSeiNt0Res);
>>>> +    nt0_res->code = NT0_RES_RESPONSE_CODE;
>>>> +    nt0_res->nt = NT0_RES_NT_DEFAULT;
>>>> +    nt0_res->rs = NT0_RES_RS_AP_CHANGE;
>>>> +    nt0_res->cc = NT0_RES_CC_AP_CHANGE;
>>>> +
>>>> +    return 0;
>>>> +
>>>
>>> extra white line ^
>>>
>>> and returning a bool would make more sense.
>>
>> It may make more sense from a readability standpoint,
>> but if you look at the caller (chsc_sei_nt0_get_event in 
>> target/s390x/ioinst.c),
>> it returns an int, so it can simply return whatever is returned from 
>> this
>> function. On the other hand, it really doesn't make a difference, so if
>> you feel strongly about this, then it can be changed to a bool.
>>
>>
> I think I'd rather keep the returns as is because I've went through 
> several changes that uses a bool return and my code doesn't work as 
> designed. The ap config doesn't update in real time which allows the 
> polling time to take over when notifying the guest. Would it suffice 
> to document the following in ap-bridge.h (the comment bellow)
>>>
>>>> +}
>>>> +
>>>> +int ap_chsc_sei_nt0_have_event(void)
>>>> +{
>>>> +    return !QTAILQ_EMPTY(&cfg_chg_events);
>>>
>>> same here for the bool.
>>
>> same as above
>>
>>>
>>>> +}
>>>> +
>>>>   static bool vfio_ap_register_irq_notifier(VFIOAPDevice *vapdev,
>>>>                                             unsigned int irq, Error 
>>>> **errp)
>>>>   {
>>>> diff --git a/include/hw/s390x/ap-bridge.h 
>>>> b/include/hw/s390x/ap-bridge.h
>>>> index 470e439a98..f4d838bf99 100644
>>>> --- a/include/hw/s390x/ap-bridge.h
>>>> +++ b/include/hw/s390x/ap-bridge.h
>>>> @@ -16,4 +16,26 @@
>>>>     void s390_init_ap(void);
>>>>   +typedef struct ChscSeiNt0Res {
>>>> +    uint16_t length;
>>>> +    uint16_t code;
>>>> +    uint8_t reserved1;
>>>> +    uint16_t reserved2;
>>>> +    uint8_t nt;
>>>> +#define PENDING_EVENT_INFO_BITMASK 0x80;
>>>> +    uint8_t flags;
>>>> +    uint8_t reserved3;
>>>> +    uint8_t rs;
>>>> +    uint8_t cc;
>>>> +} QEMU_PACKED ChscSeiNt0Res;
>>>> +
>>>> +#define NT0_RES_RESPONSE_CODE 1;
>>>> +#define NT0_RES_NT_DEFAULT    0;
>>>> +#define NT0_RES_RS_AP_CHANGE  5;
>>>> +#define NT0_RES_CC_AP_CHANGE  3;
>>>> +
>>>> +int ap_chsc_sei_nt0_get_event(void *res);
>>>
>>> Documentation would be nice to have since a "return 1" means failure.
>>
>> True.
>>
> Since I want to keep the return as is, will this documentation suffice?
>
>
> /**
> * ap_chsc_sei_nt0_get_event - Retrieve the next pending AP config
> * change event
> * @res:Pointer to a ChscSeiNt0Res struct to be filled with event
> * data
> *
> * This function checks for any pending AP config change events and,
> * if present, populates the provided response structure with the
> * appropriate SEI NT0 fields.
> *
> * Return:
> * 0 - An event was available and written to @res
> * 1 - No event was available
> */
>>>
>>>> +
>>>> +int ap_chsc_sei_nt0_have_event(void);
>>>> +>   #endif
>>>
>>>
>>> Thanks,
>>>
>>> C.
>>>
>>>
>>
--------------nFx8NSKvZPhRsUkgaKwMy16S
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p>Please ignore my comments bellow. I made some foundational
      mistakes going through this process. I should be able to return
      bools based on Cedric's remarks. I flipped the meaning behind
      returning 1 vs 0 as false vs true which is incorrect. Returning 1
      is true and returning 0 is false. I had those concepts mixed up. I
      apologize <br>
    </p>
    <div class="moz-cite-prefix">On 5/22/25 11:05 PM, Rorie Reyes wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:aa68cf90-640e-4456-8918-75fb19c1847c@linux.ibm.com">
      <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
      <p><br>
      </p>
      <div class="moz-cite-prefix">On 5/22/25 3:02 PM, Anthony Krowiak
        wrote:<br>
      </div>
      <blockquote type="cite"
        cite="mid:8a80ca26-69f3-4d7c-85c1-19d269fea504@linux.ibm.com"> <br>
        <br>
        <br>
        On 5/22/25 9:35 AM, Cédric Le Goater wrote: <br>
        <blockquote type="cite">On 5/12/25 20:02, Rorie Reyes wrote: <br>
          <blockquote type="cite">These functions can be invoked by the
            function that handles interception <br>
            of the CHSC SEI instruction for requests indicating the
            accessibility of <br>
            one or more adjunct processors has changed. <br>
            <br>
            Signed-off-by: Rorie Reyes <a class="moz-txt-link-rfc2396E"
              href="mailto:rreyes@linux.ibm.com" moz-do-not-send="true">&lt;rreyes@linux.ibm.com&gt;</a>
            <br>
            --- <br>
              hw/vfio/ap.c                 | 39
            ++++++++++++++++++++++++++++++++++++ <br>
              include/hw/s390x/ap-bridge.h | 22 ++++++++++++++++++++ <br>
              2 files changed, 61 insertions(+) <br>
            <br>
            diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c <br>
            index 5ea5dd9cca..4f88f80c54 100644 <br>
            --- a/hw/vfio/ap.c <br>
            +++ b/hw/vfio/ap.c <br>
            @@ -96,6 +96,45 @@ static void
            vfio_ap_cfg_chg_notifier_handler(void *opaque) <br>
                } <br>
              +int ap_chsc_sei_nt0_get_event(void *res) <br>
            +{ <br>
            +    ChscSeiNt0Res *nt0_res  = (ChscSeiNt0Res *)res; <br>
            +    APConfigChgEvent *cfg_chg_event; <br>
            + <br>
            +    if (!ap_chsc_sei_nt0_have_event()) { <br>
            +        return 1; <br>
            +    } <br>
            + <br>
            +    cfg_chg_event = QTAILQ_FIRST(&amp;cfg_chg_events); <br>
            +    memset(nt0_res, 0, sizeof(*nt0_res)); <br>
            + <br>
            +    QTAILQ_REMOVE(&amp;cfg_chg_events, cfg_chg_event,
            next); <br>
            +    g_free(cfg_chg_event); <br>
            + <br>
            +    /* <br>
            +     * If there are any AP configuration change events in
            the queue, <br>
            +     * indicate to the caller that there is pending event
            info in <br>
            +     * the response block <br>
            +     */ <br>
            +    if (ap_chsc_sei_nt0_have_event()) { <br>
            +        nt0_res-&gt;flags |= PENDING_EVENT_INFO_BITMASK; <br>
            +    } <br>
            + <br>
            +    nt0_res-&gt;length = sizeof(ChscSeiNt0Res); <br>
            +    nt0_res-&gt;code = NT0_RES_RESPONSE_CODE; <br>
            +    nt0_res-&gt;nt = NT0_RES_NT_DEFAULT; <br>
            +    nt0_res-&gt;rs = NT0_RES_RS_AP_CHANGE; <br>
            +    nt0_res-&gt;cc = NT0_RES_CC_AP_CHANGE; <br>
            + <br>
            +    return 0; <br>
            + <br>
          </blockquote>
          <br>
          extra white line ^ <br>
          <br>
          and returning a bool would make more sense. <br>
        </blockquote>
        <br>
        It may make more sense from a readability standpoint, <br>
        but if you look at the caller (chsc_sei_nt0_get_event in
        target/s390x/ioinst.c), <br>
        it returns an int, so it can simply return whatever is returned
        from this <br>
        function. On the other hand, it really doesn't make a
        difference, so if <br>
        you feel strongly about this, then it can be changed to a bool.
        <br>
        <br>
        <br>
      </blockquote>
      I think I'd rather keep the returns as is because I've went
      through several changes that uses a bool return and my code
      doesn't work as designed. The ap config doesn't update in real
      time which allows the polling time to take over when notifying the
      guest. Would it suffice to document the following in ap-bridge.h
      (the comment bellow)<br>
      <blockquote type="cite"
        cite="mid:8a80ca26-69f3-4d7c-85c1-19d269fea504@linux.ibm.com">
        <blockquote type="cite"> <br>
          <blockquote type="cite">+} <br>
            + <br>
            +int ap_chsc_sei_nt0_have_event(void) <br>
            +{ <br>
            +    return !QTAILQ_EMPTY(&amp;cfg_chg_events); <br>
          </blockquote>
          <br>
          same here for the bool. <br>
        </blockquote>
        <br>
        same as above <br>
        <br>
        <blockquote type="cite"> <br>
          <blockquote type="cite">+} <br>
            + <br>
              static bool vfio_ap_register_irq_notifier(VFIOAPDevice
            *vapdev, <br>
                                                        unsigned int
            irq, Error **errp) <br>
              { <br>
            diff --git a/include/hw/s390x/ap-bridge.h
            b/include/hw/s390x/ap-bridge.h <br>
            index 470e439a98..f4d838bf99 100644 <br>
            --- a/include/hw/s390x/ap-bridge.h <br>
            +++ b/include/hw/s390x/ap-bridge.h <br>
            @@ -16,4 +16,26 @@ <br>
                void s390_init_ap(void); <br>
              +typedef struct ChscSeiNt0Res { <br>
            +    uint16_t length; <br>
            +    uint16_t code; <br>
            +    uint8_t reserved1; <br>
            +    uint16_t reserved2; <br>
            +    uint8_t nt; <br>
            +#define PENDING_EVENT_INFO_BITMASK 0x80; <br>
            +    uint8_t flags; <br>
            +    uint8_t reserved3; <br>
            +    uint8_t rs; <br>
            +    uint8_t cc; <br>
            +} QEMU_PACKED ChscSeiNt0Res; <br>
            + <br>
            +#define NT0_RES_RESPONSE_CODE 1; <br>
            +#define NT0_RES_NT_DEFAULT    0; <br>
            +#define NT0_RES_RS_AP_CHANGE  5; <br>
            +#define NT0_RES_CC_AP_CHANGE  3; <br>
            + <br>
            +int ap_chsc_sei_nt0_get_event(void *res); <br>
          </blockquote>
          <br>
          Documentation would be nice to have since a "return 1" means
          failure. <br>
        </blockquote>
        <br>
        True. <br>
        <br>
      </blockquote>
      <p>Since I want to keep the return as is, will this documentation
        suffice?</p>
      <p><br>
      </p>
      <div
style="color: #cccccc;background-color: #1f1f1f;font-family: Menlo, Monaco, 'Courier New', monospace;font-weight: normal;font-size: 12px;line-height: 18px;white-space: pre;"><div><span
      style="color: #6a9955;">/**</span></div><div><span
      style="color: #6a9955;"> * ap_chsc_sei_nt0_get_event - Retrieve the next pending AP config</span></div><div><span
      style="color: #6a9955;"> * change event</span></div><div><span
      style="color: #6a9955;"> * </span><span style="color: #569cd6;">@res:</span><span
      style="color: #6a9955;"> Pointer to a ChscSeiNt0Res struct to be filled with event</span></div><div><span
      style="color: #6a9955;"> * data</span></div><div><span
      style="color: #6a9955;"> * </span></div><div><span
      style="color: #6a9955;"> * This function checks for any pending AP config change events and,</span></div><div><span
      style="color: #6a9955;"> * if present, populates the provided response structure with the</span></div><div><span
      style="color: #6a9955;"> * appropriate SEI NT0 fields.</span></div><div><span
      style="color: #6a9955;"> * </span></div><div><span
      style="color: #6a9955;"> * Return:</span></div><div><span
      style="color: #6a9955;"> *   0 - An event was available and written to @res</span></div><div><span
      style="color: #6a9955;"> *   1 - No event was available</span></div><div><span
      style="color: #6a9955;"> */</span></div></div>
      <blockquote type="cite"
        cite="mid:8a80ca26-69f3-4d7c-85c1-19d269fea504@linux.ibm.com">
        <blockquote type="cite"> <br>
          <blockquote type="cite">+ <br>
            +int ap_chsc_sei_nt0_have_event(void); <br>
            +&gt;   #endif <br>
          </blockquote>
          <br>
          <br>
          Thanks, <br>
          <br>
          C. <br>
          <br>
          <br>
        </blockquote>
        <br>
      </blockquote>
    </blockquote>
  </body>
</html>

--------------nFx8NSKvZPhRsUkgaKwMy16S--


