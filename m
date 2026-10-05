Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B8C6CA5FCE
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 13:32:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDin4-0000Nv-Ko; Mon, 05 Oct 2026 09:31:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1xDim0-0000C6-P6; Mon, 05 Oct 2026 09:30:44 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1xDilw-0005c7-On; Mon, 05 Oct 2026 09:30:32 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 695CZwlH504522; Mon, 5 Oct 2026 13:30:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=ogb9hj
 XlOKKootPVTWwXkZ3/EWrVX0poOaAX9BoAIyo=; b=Xh2onLz4/n0jyBB1JA8his
 NbWJbwoujIhhxpKr9g+On3E4n14Vda6K6tfpYqUlQ1F3owRpBcBo+MF/uadK7ijD
 954hGADTnmx7Cy3pZeEmibbDTNe2jgWq2G2uyUbL3mpyNk7CD09JbLnYWhqdW8gY
 4ZcrN16xaiKSF7j82niINEpbGLuj0NIcd3ALEpzh13cX5SAAPZmNZv0frON2MbUo
 xYtNhzRPAvEiXr3/CptPrKAtxJdfVImgiww0JAuv8CA/WLy7VSwnk0p9FO3+PnqI
 NOLeMFc+nWsIkcZSqsLTKuE6UrH9epl1N8xML3klWRdlYfv3vjQbL/xpN0Ut0TJw
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2q4jj39n-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 05 Oct 2026 13:30:23 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 695CHrgi2913169; Mon, 5 Oct 2026 13:30:22 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h3eqy5cud-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 05 Oct 2026 13:30:22 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 695DULM656295858
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 5 Oct 2026 13:30:21 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 46DCC58108;
 Mon,  5 Oct 2026 13:30:21 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3A5D258106;
 Mon,  5 Oct 2026 13:30:20 +0000 (GMT)
Received: from [9.61.15.56] (unknown [9.61.15.56])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  5 Oct 2026 13:30:20 +0000 (GMT)
Message-ID: <fc472877-5b10-4dc8-bde4-f149e4e3ddc7@linux.ibm.com>
Date: Mon, 5 Oct 2026 09:30:19 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 14/16] s390x/pci: Factor ioat sanity checks into a
 separate function
To: Konstantin Shkolnyy <kshk@linux.ibm.com>
Cc: alifm@linux.ibm.com, farman@linux.ibm.com, richard.henderson@linaro.org,
 iii@linux.ibm.com, david@kernel.org, cohuck@redhat.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
References: <20260930145255.140164-1-kshk@linux.ibm.com>
 <20260930145255.140164-15-kshk@linux.ibm.com>
 <a58ad322-bfb3-4ca6-a9fd-098391da4f3b@linux.ibm.com>
 <606b2a78-52b5-40a7-87cc-3f247985aa51@linux.ibm.com>
From: Matthew Rosato <mjrosato@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <606b2a78-52b5-40a7-87cc-3f247985aa51@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: t8N0yvCrZ0m8t8hu6YwcZItMyM8KrDnR
X-Proofpoint-GUID: t8N0yvCrZ0m8t8hu6YwcZItMyM8KrDnR
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDA1MSBTYWx0ZWRfX/gwLpn542ioa
 IZ2/0H0N7r+KlLXRQeVeyyrBPqwB0BDSAVDbFRhxvkSREcBCLn1GbHExzDLaNp83OQexZBjAv2v
 lb1TRzuEI7jFaH3sY+Q7vwMctGmzi3k=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDA1MSBTYWx0ZWRfXzQM4YqwMei1U
 +vXArR/0SLqpcY7njpxOmmkursw6QqUSy9XYHWcO+whF8OAt9fL679Mh218IH2dD4Lk+A7zPO+v
 s1Xlj/PVs0feZF0aP/yy8hvHRjKlSHLXhPrNa+T5utH/TMZ5Dsh7BEunUmpA8JN/iWQuLfCel+D
 AojlUZalciJE8NFRu8K80F7WDWMoClyPgWvns1AkunEcqninMX35G4P1iJskgapHNhm5f644qay
 5c9THPvtVtIdHqW/Jm3wj7ZIH6N0fP1hJq2qQkfRXD4GDWCFryrCbkskD9QsvsUZDbt0ckMN89n
 KaxiFbVqra/XNQEJ5H8fYZwaXzbDAYy2nJZT9zJo8Rkkmu0APsq3AuGkeffKz4KGJ21TM1u6TAs
 Cw4oO1UgcsHmRnTYrQaGUrNOYRkVdcBb9o82A/mc6BX9m2lyb3vlrdsKz4FC0sg/PAfVR+siJPD
 dpBEf3l9mn34PF/+N7g==
X-Authority-Analysis: v=2.4 cv=eYeo7LEH c=1 sm=1 tr=0 ts=6ac3a66f cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=z3K8K9NUDgSIFGxd8u8A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_03,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0 clxscore=1015
 spamscore=0 malwarescore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610050051
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
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

On 10/2/26 8:43 PM, Konstantin Shkolnyy wrote:
> On 261002 13:28, Matthew Rosato wrote:
>>
>>> -static int reg_ioat(CPUS390XState *env, S390PCIBusDevice *pbdev,
>>> ZpciFib fib,
>>> -                    uintptr_t ra)
>>> +bool s390_pci_ioat_validate(S390PCIBusDevice *pbdev, uint64_t pba,
>>> +                             uint64_t pal, uint64_t g_iota, Error
>>> **errp)
>>>   {
>>> -    uint64_t pba = ldq_be_p(&fib.pba);
>>> -    uint64_t pal = ldq_be_p(&fib.pal);
>>> -    uint64_t g_iota = ldq_be_p(&fib.iota);
>>>       uint8_t dt = (g_iota >> 2) & 0x7;
>>>       bool t = s390_pci_is_translation_enabled(g_iota);
>>>   -    pba &= ~0xfff;
>>> -    pal |= 0xfff;
>>>       if (pba > pal || pba < pbdev->zpci_fn.sdma || pal > pbdev-
>>> >zpci_fn.edma) {
>>> -        s390_program_interrupt(env, PGM_OPERAND, ra);
>>> -        return -EINVAL;
>>> +        return false;
>>
>> This will now violate include/qapi/error.h because you're returning
>> false but not setting errp:
>>
>>   * - On success, the function should not touch *errp.  On failure, it
>>   *   should set a new error, e.g. with error_setg(errp, ...), or
>>   *   propagate an existing one, e.g. with error_propagate(errp, ...).
>>
>> A simple solution would be to add a new message for this case.
> 
> But the original reg_ioat() also didn't print any message in this error
> branch. I had to assume it was intentional, and preserved the behavior.
> 

Yes, but the original path was not passing an Error *errp back to a
caller, it was calling error_report (and then qemu_log_mask) directly;
your patch is changing this to a model where we return an Error *errp to
a caller.  Which in and of itself is totally fine, but we should make
efforts to then adhere to the rules laid out in include/qapi/error.h
where all failure paths should have an error when passing back an errp.

> If you believe a new message should be introduced, I can insert a commit
> for that - what would be the explanation?

Separate commit not needed, it only becomes necessary as part of this
change as described above.

As for a message, something like the following?

"ioat pba 0x%"PRIx64" pal 0x%"PRIx64" out of device dma range
[0x%"PRIx64" 0x%"PRIx64"]", pba, pal, pbdev->zpci_fn.sdma,
pbdev->zpci_fn.edma

> 
>>
>> [...]
>>> +
>>> +static int reg_ioat(CPUS390XState *env, S390PCIBusDevice *pbdev,
>>> ZpciFib fib,
>>> +                    uintptr_t ra)
>>> +{
>>> +    Error *err = NULL;
>>> +    uint64_t pba = ldq_be_p(&fib.pba);
>>> +    uint64_t pal = ldq_be_p(&fib.pal);
>>> +    uint64_t g_iota = ldq_be_p(&fib.iota);
>>> +    bool t = s390_pci_is_translation_enabled(g_iota);
>>> +
>>> +    pba &= ~0xfff;
>>> +    pal |= 0xfff;
>>> +
>>> +    if (!s390_pci_ioat_validate(pbdev, pba, pal, g_iota, &err)) {
>>> +        if (err) {
>>> +            qemu_log_mask(LOG_GUEST_ERROR, "%s\n",
>>> error_get_pretty(err));
>>> +            error_free(err);
>>> +        }
>>
>> With that change, you won't need the if (err) check anymore.
>>
>> Thanks,
>> Matt
> 


