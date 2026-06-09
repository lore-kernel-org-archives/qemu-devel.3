Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A786FCD8CB2
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 16:57:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWzkQ-00019C-7C; Tue, 09 Jun 2026 12:56:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1wWzkM-00015u-Om; Tue, 09 Jun 2026 12:56:15 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1wWzkJ-0005E4-Tq; Tue, 09 Jun 2026 12:56:14 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 659DXA653906532; Tue, 9 Jun 2026 16:56:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=04IN00
 ohQly9JWWn+Sus1Kzms9D+oxU30Rd6plGhK6c=; b=Y+vIP5hCmQ5aBeUpz81nTj
 8oWfX2DYK04wGo2CN7AeC/4XpXd+jJGF09BxgN7u7M3wINUrAIzSRKyAgo8ic39M
 PvvQla3ExnwT5ur41fXcnSwktU3Di4s2hC0lDO1IMiaZmxW4+dYfg3i0Ufq3wobp
 vjIgEi4z9A5Exdts7O3nRy095nLkWXHp7MAFv67bB4qubhTxJ2WZR0q96B2ciQ3B
 lrW27KtkQUn4/bIL7JT1hsRMjRaCyIDd9igN4SK1yKn4DsFHN94VilWdh+8+SZBb
 3XH53JhlSibTxaD5wKucLiRh+7OeX7eToyrrNa4svsR1A6/bR+2RNr1/2nzGKnbg
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4em9ye536g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 09 Jun 2026 16:56:04 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 659Gna8n001647;
 Tue, 9 Jun 2026 16:56:03 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4en0jyapau-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 09 Jun 2026 16:56:03 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 659Gu2xV19071568
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 9 Jun 2026 16:56:02 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BD5B358056;
 Tue,  9 Jun 2026 16:56:02 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 94D2058060;
 Tue,  9 Jun 2026 16:56:01 +0000 (GMT)
Received: from [9.61.108.75] (unknown [9.61.108.75])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTPS;
 Tue,  9 Jun 2026 16:56:01 +0000 (GMT)
Message-ID: <acbf88ff-bffb-49a1-870a-843ddf6e98c7@linux.ibm.com>
Date: Tue, 9 Jun 2026 12:56:00 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 21/32] pc-bios/s390-ccw: Add signature verification
 for secure IPL in audit mode
To: Zhuoying Cai <zycai@linux.ibm.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Cc: cohuck@redhat.com, berrange@redhat.com, richard.henderson@linaro.org,
 david@kernel.org, walling@linux.ibm.com, jjherne@linux.ibm.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com, alifm@linux.ibm.com, brueckner@linux.ibm.com,
 pierrick.bouvier@oss.qualcomm.com, jdaley@linux.ibm.com
References: <20260505201905.997996-1-zycai@linux.ibm.com>
 <20260505201905.997996-22-zycai@linux.ibm.com>
 <632db3ab-408a-4d0c-b8ce-be6d52bb9cad@linux.ibm.com>
 <251df87f-e0d5-4897-94ce-34dbf3dadf53@linux.ibm.com>
Content-Language: en-US
From: Jared Rossi <jrossi@linux.ibm.com>
In-Reply-To: <251df87f-e0d5-4897-94ce-34dbf3dadf53@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDE1NyBTYWx0ZWRfX4RygZAn40hNg
 Yt3Tlq+CRh4lfNi9jx9+RQPlj6tp1Zzv2/oeMHerjaLjK5MXCERKdJGXHjq3i/BC3G9La2sQlQ6
 UX18qigWZfw40bvWxLZxz7OqIqU30ECifZJnkfuxCU0sycApVdef1YSOty/UCI33b6GxQEDuewJ
 oNTkD/jGEEiczYKROQ9b3DLg+dGhWshoN4xp9qzdaETL3J1/z4b8M+RDB8wyUClkaMsPJafC4EB
 c4C+mzSzrP/elGYUwgRAwo53f0msJLOogJI7HesS1MOgnIxF5cJxsu85fzRWcESgubqYhxE10Dx
 N4oQL1Wrnkhs2d721tiOMzhZQW30EHZlt+JUz86MFXmUuOcj+bcyAgV4KmNNPx4HMduubSM/j5I
 /LBsShZgDgB7r+Sj3uEEymSMOrSgt4fkM+lcAKY8ksvCa3XxNlWX7Qe7pqVL5TMkbmNA+DbPT4b
 UvWFnAWOBGrwlc3Pghg==
X-Authority-Analysis: v=2.4 cv=QKhYgALL c=1 sm=1 tr=0 ts=6a2845a4 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=6l_tzqz7drRbC8CdRVwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: VbZ-yNpixxp1ca6WJ1hYKPYkSwxpg3aw
X-Proofpoint-ORIG-GUID: VbZ-yNpixxp1ca6WJ1hYKPYkSwxpg3aw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_04,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 adultscore=0 phishscore=0
 malwarescore=0 impostorscore=0 suspectscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606090157
Received-SPF: pass client-ip=148.163.158.5; envelope-from=jrossi@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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



On 6/9/26 11:44 AM, Zhuoying Cai wrote:
> Thanks for the feedback and suggestion!
>
> On 6/1/26 4:24 PM, Jared Rossi wrote:
>>
>> On 5/5/26 4:18 PM, Zhuoying Cai wrote:
>>> Enable secure IPL in audit mode, which performs signature verification,
>>> but any error does not terminate the boot process. Only warnings will be
>>> logged to the console instead.
>>>
>>> Add a comp_len variable to store the length of a segment in
>>> zipl_load_segment. comp_len variable is necessary to store the
>>> calculated segment length and is used during signature verification.
>>> Return the length on success, or a negative return code on failure.
>>>
>>> Secure IPL in audit mode requires at least one certificate provided in
>>> the key store along with necessary facilities (Secure IPL Facility,
>>> Certificate Store Facility and secure IPL extension support).
>>>
>>> Note: Secure IPL in audit mode is implemented for the SCSI scheme of
>>> virtio-blk/virtio-scsi devices.
>>>
>>> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
>>> ---
>>>    docs/system/s390x/secure-ipl.rst |  15 ++
>>>    pc-bios/s390-ccw/Makefile        |   2 +-
>>>    pc-bios/s390-ccw/bootmap.c       |  16 ++
>>>    pc-bios/s390-ccw/bootmap.h       |   9 +
>>>    pc-bios/s390-ccw/main.c          |  10 +-
>>>    pc-bios/s390-ccw/s390-ccw.h      |  24 ++
>>>    pc-bios/s390-ccw/sclp.c          |  27 +++
>>>    pc-bios/s390-ccw/sclp.h          |   6 +
>>>    pc-bios/s390-ccw/secure-ipl.c    | 364 +++++++++++++++++++++++++++++++
>>>    pc-bios/s390-ccw/secure-ipl.h    | 113 ++++++++++
>>>    10 files changed, 584 insertions(+), 2 deletions(-)
>>>    create mode 100644 pc-bios/s390-ccw/secure-ipl.c
>>>    create mode 100644 pc-bios/s390-ccw/secure-ipl.h
>>>
> [...]
>
>>> diff --git a/pc-bios/s390-ccw/secure-ipl.c b/pc-bios/s390-ccw/secure-ipl.c
>>> new file mode 100644
>>> index 0000000000..6e943446a7
>>> --- /dev/null
>>> +++ b/pc-bios/s390-ccw/secure-ipl.c
>>> @@ -0,0 +1,364 @@
>>> +/*
>>> + * S/390 Secure IPL
>>> + *
>>> + * Functions to support IPL in secure boot mode (DIAG 320, DIAG 508,
>>> + * signature verification, and certificate handling).
>>> + *
>>> + * For secure IPL overview: docs/system/s390x/secure-ipl.rst
>>> + * For secure IPL technical: docs/specs/s390x-secure-ipl.rst
>>> + *
>>> + * Copyright 2025 IBM Corp.
>>> + * Author(s): Zhuoying Cai <zycai@linux.ibm.com>
>>> + *
>>> + * SPDX-License-Identifier: GPL-2.0-or-later
>>> + */
>>> +
>>> +#include <stdlib.h>
>>> +#include <string.h>
>>> +#include <stdio.h>
>>> +#include "bootmap.h"
>>> +#include "s390-ccw.h"
>>> +#include "sclp.h"
>>> +#include "secure-ipl.h"
>>> +
>>> +static VCStorageSizeBlock vcssb __attribute__((__aligned__(8)));
>>> +
>>> +VCStorageSizeBlock *zipl_secure_get_vcssb(void)
>>> +{
>>> +    /* avoid retrieving vcssb multiple times */
>>> +    if (vcssb.length == VCSSB_MIN_LEN) {
>>> +        return &vcssb;
>>> +    }
>> I don't quite understand what is happening with the VCSSB_MIN_LENGTH
>> here.  Why
>> is the minimum length significant, as opposed to simply non-zero?
>>
> VCSSB must be set to VCSSB_MIN_LENGTH (128), as this represents the size
> of the VCSSB struct and indicates that it is present. Any other value
> would be considered an invalid length for VCSSB.
>
> To avoid confusion, we could consider renaming VCSSB_MIN_LENGTH to
> VCSSB_LEN.

Maybe it could be VCSSB_LEN_VALID?  This would make it more clear that it
is a specific size we expect that any valid VCSSB will conform to.

>
>>> +
>>> +    vcssb.length = VCSSB_MIN_LEN;
>>> +    if (_diag320(&vcssb, DIAG_320_SUBC_QUERY_VCSI) != DIAG_320_RC_OK) {
>>> +        vcssb.length = 0;
>>> +        return NULL;
>>> +    }
>>> +
>>> +    return &vcssb;
>>> +}
>>> +
>>> +static uint32_t get_total_certs_length(void)
>>> +{
>>> +    if (zipl_secure_get_vcssb() == NULL) {
>>> +        return 0;
>>> +    }
>> Should we check if vcssb.len == 4 for the early return?  I think it
>> designates
>> an empty cert store and nothing else gets initialized.
>>
> Yes, this check is currently in [PATCH v11 27/32] pc-bios/s390-ccw:
> Handle true secure IPL mode. I’ll refactor it so it can be performed
> earlier during the secure boot process.
>
>>> +
>>> +    return vcssb.total_vcb_len - sizeof(VCBlockHeader) -
>>> +           vcssb.total_vc_ct * sizeof(VCEntryHeader);
>>> +}
>>> +
>>> +static uint32_t request_certificate(uint8_t *cert_buf, uint8_t index)
>>> +{
>>> +    VCEntryHeader *vce_hdr;
>>> +    struct vcb {
>>> +        VCBlockHeader vcb_hdr;
>>> +        struct vce {
>>> +            VCEntryHeader vce_hdr;
>>> +            uint8_t cert_buf[CERT_BUF_MAX_LEN];
>>> +        } vce;
>>> +    } __attribute__((__aligned__(4096))) vcb = { 0 };
>> Regarding Collin's comments about using CERT_BUF_MAX_LEN versus
>> vcssb.max_single_vcb_len,
>> because the VCB must be 4k aligned we didn't want to malloc a variable
>> length
>> buffer, which is why the constant max was used.  AFAIK malloc cannot enforce
>> any alignment requirements and we do not have the libraries for memalign
>> in BIOS.
>>
>> I thought I saw that the cert store does already reject certs exceeding
>> this size,
>> but if not, I agree with Collin that it should.
>>
> Maybe we could use vcssb.max_single_vcb_len - sizeof(VCBlockHeader) -
> sizeof(VCEntryHeader) instead of CERT_BUF_MAX_LEN when sizing cert_buf.
>
> The cert store already rejects anything larger than CERT_BUF_MAX_LEN, so
> the requested size is guaranteed to stay within bounds.
>
> Since vcssb.max_single_vcb_len is also used as the input length for the
> VCB, basing cert_buf on it would make the buffer size more accurate.
>
> Does this sound reasonable to you?

Isn't the objective of using static allocation to make the 4K alignment
easier?  I'm not strictly opposed to using dynamic sizing, but it seems to
add a lot of complexity for only a little benefit.  You are correct that
using the max size will have some excess space allocated, but this is just
a temporary buffer, right?  The data the IIRB points and what the kernel
reads will be the correct size in the end.

Regards,
Jared Rossi

