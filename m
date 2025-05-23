Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4513BC54ED0
	for <qemu-devel@archiver.kernel.org>; Fri, 23 May 2025 13:02:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uIS1t-0000mK-NS; Fri, 23 May 2025 09:01:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akrowiak@linux.ibm.com>)
 id 1uIS11-0000N8-G2; Fri, 23 May 2025 09:01:17 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akrowiak@linux.ibm.com>)
 id 1uIS0y-0005Uo-52; Fri, 23 May 2025 09:00:46 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54NATqxL004941;
 Fri, 23 May 2025 13:00:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=oW2JTE
 PCyY0nVtHR/WG1y9y99mrjDBoQ3jS9hB7IQYY=; b=mYgu8egBQkAE7PRJOuHAFe
 CafgU7dg9GOWuivldcPJ1SkRAGooOdlW9659/0rR/BKJYn8qyyG0ou8vcRmVv9aL
 E1tLjJridVZxvAdkqFVjqfaqMYyfycy7RdWMhKX1TtGbdxM/GTYcqf6rQiu1f7Js
 q0N0L+AhOKBDc9viwtAaAvw8Ssmmx8eLDwI43ShnaoiUS51jpiUOamYMTCuXXdIK
 caIys8FLhfmcN4rLaU981NXrDvBCffqZyUZfJ71VPe33eAJWAyushrWVc8zcIkZB
 pXq2Mo78e1+0CInlGldPjvLkykxALmQynn8A9bGot1iZisYkjVXa9RJOqb3/c4wA
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46t14jpxg7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 23 May 2025 13:00:39 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54NAhUIL032076;
 Fri, 23 May 2025 13:00:38 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 46rwnmpkkt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 23 May 2025 13:00:38 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 54ND0bGP23790250
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 23 May 2025 13:00:37 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 28B7B58054;
 Fri, 23 May 2025 13:00:37 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9F5685805F;
 Fri, 23 May 2025 13:00:35 +0000 (GMT)
Received: from [9.61.89.69] (unknown [9.61.89.69])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 23 May 2025 13:00:35 +0000 (GMT)
Message-ID: <073a01a0-dce2-4788-b07c-dbc75a54f54e@linux.ibm.com>
Date: Fri, 23 May 2025 09:00:35 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v10 3/4] hw/vfio/ap: Storing event information for an
 AP configuration change event
To: Rorie Reyes <rreyes@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Cc: pbonzini@redhat.com, cohuck@redhat.com, pasic@linux.ibm.com,
 jjherne@linux.ibm.com, borntraeger@linux.ibm.com,
 alex.williamson@redhat.com, clg@redhat.com, thuth@redhat.com
References: <20250523044741.59936-1-rreyes@linux.ibm.com>
 <20250523044741.59936-4-rreyes@linux.ibm.com>
Content-Language: en-US
From: Anthony Krowiak <akrowiak@linux.ibm.com>
In-Reply-To: <20250523044741.59936-4-rreyes@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 7cLgLu-oRbBfp_FNCM-Nd-LIIqZl3wjJ
X-Authority-Analysis: v=2.4 cv=XOkwSRhE c=1 sm=1 tr=0 ts=68307177 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=sWKEhP36mHoA:10 a=VnNF1IyMAAAA:8
 a=UVT0B71CJiwNM4Nh_BQA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIzMDExMCBTYWx0ZWRfXysmtXE0u8dkW
 DzC/YgU06UhD8m6M1W5LCMkJW9SXJHTHfeTS2dtXvtwQXx0XLPcZkvazFki5WR2ANNtWeIk4F83
 gYVYSAGUhitG0Eo+M1BIiXD1l0sNRqTK4RFY/P8KAwkv0R+tWg5A+s/YMY9SP8S4wq9bgUNhWQq
 EpAVJmOG9nBpc06v6tBCraIC8IXOJDltEuhxhAqHT6RHwtmpafL+U7Q6i7wj01SjZGyzFkOT7jn
 LoYTSeCkgaBOqwciXyVPas4TbrtqVNW5WfaRZOYVMqOAFv9dUjj2J3Ma7EMpMN+AcSniGCCUPJ3
 RiHHVcgb/3ZbxjexeRjHQQJbb4QB5g/0ePMhfYG0LRObHdKcgQbk+PGntsrZvxxf5C1zqo2wXNk
 jLWjkPi11iP+vnWL8kDupSWRUvEJuGTW2hOPip+crYbeNia4TbrqXvih9YZql8EF8Jsjm+h8
X-Proofpoint-GUID: 7cLgLu-oRbBfp_FNCM-Nd-LIIqZl3wjJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-23_03,2025-05-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 lowpriorityscore=0 adultscore=0
 impostorscore=0 suspectscore=0 priorityscore=1501 spamscore=0 phishscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505230110
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=akrowiak@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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




On 5/23/25 12:47 AM, Rorie Reyes wrote:
> These functions can be invoked by the function that handles interception
> of the CHSC SEI instruction for requests indicating the accessibility of
> one or more adjunct processors has changed.
>
> Signed-off-by: Rorie Reyes <rreyes@linux.ibm.com>
> ---
>   hw/vfio/ap.c                 | 53 ++++++++++++++++++++++++++++++++++++
>   include/hw/s390x/ap-bridge.h | 36 ++++++++++++++++++++++++
>   2 files changed, 89 insertions(+)
>
> diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
> index fc435f5c5b..a6b4514606 100644
> --- a/hw/vfio/ap.c
> +++ b/hw/vfio/ap.c
> @@ -10,6 +10,7 @@
>    * directory.
>    */
>   
> +#include <stdbool.h>
>   #include "qemu/osdep.h"
>   #include CONFIG_DEVICES /* CONFIG_IOMMUFD */
>   #include <linux/vfio.h>
> @@ -48,6 +49,8 @@ typedef struct APConfigChgEvent {
>   static QTAILQ_HEAD(, APConfigChgEvent) cfg_chg_events =
>       QTAILQ_HEAD_INITIALIZER(cfg_chg_events);
>   
> +static QemuMutex cfg_chg_events_lock;
> +
>   OBJECT_DECLARE_SIMPLE_TYPE(VFIOAPDevice, VFIO_AP_DEVICE)
>   
>   static void vfio_ap_compute_needs_reset(VFIODevice *vdev)
> @@ -96,6 +99,49 @@ static void vfio_ap_cfg_chg_notifier_handler(void *opaque)
>   
>   }
>   
> +bool ap_chsc_sei_nt0_get_event(void *res)
> +{
> +    ChscSeiNt0Res *nt0_res  = (ChscSeiNt0Res *)res;
> +    APConfigChgEvent *cfg_chg_event;
> +
> +    qemu_mutex_lock(&cfg_chg_events_lock);
> +
> +    if (!ap_chsc_sei_nt0_have_event()) {
> +        qemu_mutex_unlock(&cfg_chg_events_lock);
> +        return true;
> +    }
> +
> +    cfg_chg_event = QTAILQ_FIRST(&cfg_chg_events);
> +    QTAILQ_REMOVE(&cfg_chg_events, cfg_chg_event, next);
> +
> +    qemu_mutex_unlock(&cfg_chg_events_lock);
> +
> +    memset(nt0_res, 0, sizeof(*nt0_res));
> +    g_free(cfg_chg_event);
> +
> +    /*
> +     * If there are any AP configuration change events in the queue,
> +     * indicate to the caller that there is pending event info in
> +     * the response block
> +     */
> +    if (ap_chsc_sei_nt0_have_event()) {
> +        nt0_res->flags |= PENDING_EVENT_INFO_BITMASK;
> +    }
> +
> +    nt0_res->length = sizeof(ChscSeiNt0Res);
> +    nt0_res->code = NT0_RES_RESPONSE_CODE;
> +    nt0_res->nt = NT0_RES_NT_DEFAULT;
> +    nt0_res->rs = NT0_RES_RS_AP_CHANGE;
> +    nt0_res->cc = NT0_RES_CC_AP_CHANGE;
> +
> +    return false;
> +}

The boolean return values in the function above do not make logical sense.
What they are effectively saying is that event information has been stored
in the response when there is no event information to store (i.e., the event
queue is empty), and that event information has not been stored if the
response has been filled with event information.

After looking at the calling code in target/s390x/ionst.c, apparently 
the meaning of
the int value originally returned from the above function was not in 
fact intended to
be a boolean value. It looks like the caller uses this value to indicate 
whether the
response code should be set to 0x0001 (this function returns 0) or 
0x0005 (this
function returns 1); so, the boolean values returned match what is 
expected by
the caller. I think this is why your original pass at returning a 
boolean caused your
patch to fail; because you did what made logical sense in this function.

I think the calling code is very convoluted to say the least, so maybe 
what makes sense
here is to continue to return an int and use #define to document the 
return value; for
example:

#define EVENT_INFORMATION_STORED           0
#define EVENT_INFORMATION_NOT_STORED 1

It would probably make a great deal of sense to refactor the calling 
code, but that
could potentially open up a large can of worms, so at least this makes 
sense from
the perspective of reading this code.

> +
> +bool ap_chsc_sei_nt0_have_event(void)
> +{
> +    return !QTAILQ_EMPTY(&cfg_chg_events);
> +}

It's probably fine to return boolean from the above function because it
makes sense even from the caller's perspective.

> +
>   static bool vfio_ap_register_irq_notifier(VFIOAPDevice *vapdev,
>                                             unsigned int irq, Error **errp)
>   {
> @@ -192,6 +238,13 @@ static void vfio_ap_realize(DeviceState *dev, Error **errp)
>       VFIOAPDevice *vapdev = VFIO_AP_DEVICE(dev);
>       VFIODevice *vbasedev = &vapdev->vdev;
>   
> +    static bool lock_initialized;
> +
> +    if (!lock_initialized) {
> +        qemu_mutex_init(&cfg_chg_events_lock);
> +        lock_initialized = true;
> +    }
> +
>       if (!vfio_device_get_name(vbasedev, errp)) {
>           return;
>       }
> diff --git a/include/hw/s390x/ap-bridge.h b/include/hw/s390x/ap-bridge.h
> index 470e439a98..ae31532f6e 100644
> --- a/include/hw/s390x/ap-bridge.h
> +++ b/include/hw/s390x/ap-bridge.h
> @@ -16,4 +16,40 @@
>   
>   void s390_init_ap(void);
>   
> +typedef struct ChscSeiNt0Res {
> +    uint16_t length;
> +    uint16_t code;
> +    uint8_t reserved1;
> +    uint16_t reserved2;
> +    uint8_t nt;
> +#define PENDING_EVENT_INFO_BITMASK 0x80;
> +    uint8_t flags;
> +    uint8_t reserved3;
> +    uint8_t rs;
> +    uint8_t cc;
> +} QEMU_PACKED ChscSeiNt0Res;
> +
> +#define NT0_RES_RESPONSE_CODE 1
> +#define NT0_RES_NT_DEFAULT    0
> +#define NT0_RES_RS_AP_CHANGE  5
> +#define NT0_RES_CC_AP_CHANGE  3
> +
> +/**
> + * ap_chsc_sei_nt0_get_event - Retrieve the next pending AP config
> + * change event
> + * @res: Pointer to a ChscSeiNt0Res struct to be filled with event
> + * data
> + *
> + * This function checks for any pending AP config change events and,
> + * if present, populates the provided response structure with the
> + * appropriate SEI NT0 fields.
> + *
> + * Return:
> + *   false - An event was available and written to @res
> + *   true - No event was available
> + */
> +bool ap_chsc_sei_nt0_get_event(void *res);
> +
> +bool ap_chsc_sei_nt0_have_event(void);
> +
>   #endif


