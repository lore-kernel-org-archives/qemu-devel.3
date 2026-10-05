Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87EC6CA5FF0
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 16:20:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDlQk-0000ro-Q1; Mon, 05 Oct 2026 12:20:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1xDlQf-0000rR-Rm; Mon, 05 Oct 2026 12:20:41 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1xDlQc-0007u7-LK; Mon, 05 Oct 2026 12:20:40 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 695EZhtV964451; Mon, 5 Oct 2026 16:20:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=KnJtQf
 iC0aGIj/qERqWj7TOIo+tp3DB46IBsBm74fZ4=; b=gWsM+uNZCAdsZGEGitG5E2
 Tp+dM7rnORXspui7lnmJKI2E4gP5rdKWwgCC8Wdglyc70Exc6Qghf+0lhvbryYSQ
 UGiIIb3jJ3bffJm7eJCphpY75OvHXubTm1xONnPqGwpllH7k9Qz//SPOeg7ECKaA
 XESrM9bPmED4GFdfTOscIUbK66cVlGBWkhaAMd9JUCZhTr5msWj9CVpyJfbN1s3N
 IZQjG/1OjLUO9R50V6VrgGehTEe6qrM7VY4iK5dB0iHTyrxep9yoP/IuljseeRih
 HhSY8GS0glN0bvn37CpEaAc61oetrY0GPOrC6+b66jWq5h2FT2EP1/Fbn/uwwT/w
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2s74kbx2-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 05 Oct 2026 16:20:34 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 695ElTsG3042183; Mon, 5 Oct 2026 16:20:33 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h3cdvpac2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 05 Oct 2026 16:20:33 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 695GKWbL1573394
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 5 Oct 2026 16:20:32 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0F6D358052;
 Mon,  5 Oct 2026 16:20:32 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CC15F58056;
 Mon,  5 Oct 2026 16:20:31 +0000 (GMT)
Received: from [9.16.60.171] (unknown [9.16.60.171])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  5 Oct 2026 16:20:31 +0000 (GMT)
Message-ID: <2ef53f92-e5b4-4632-b296-de57b99c8b96@linux.ibm.com>
Date: Mon, 5 Oct 2026 11:20:31 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 14/16] s390x/pci: Factor ioat sanity checks into a
 separate function
Content-Language: en-US
To: Matthew Rosato <mjrosato@linux.ibm.com>
Cc: alifm@linux.ibm.com, farman@linux.ibm.com, richard.henderson@linaro.org,
 iii@linux.ibm.com, david@kernel.org, cohuck@redhat.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
References: <20260930145255.140164-1-kshk@linux.ibm.com>
 <20260930145255.140164-15-kshk@linux.ibm.com>
 <a58ad322-bfb3-4ca6-a9fd-098391da4f3b@linux.ibm.com>
 <606b2a78-52b5-40a7-87cc-3f247985aa51@linux.ibm.com>
 <cbd6f028-1c29-42fc-b7fc-7510ecc08ac6@linux.ibm.com>
 <8f105949-c5e1-479a-a996-3dacede11738@linux.ibm.com>
From: Konstantin Shkolnyy <kshk@linux.ibm.com>
In-Reply-To: <8f105949-c5e1-479a-a996-3dacede11738@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 3HLy8_gri8baOJyf4TQkhvg1bVbs0H1o
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDA2MyBTYWx0ZWRfXy6v7inHUERon
 OgKyCd7bkaYOujJMbjAiaujJVhgJZ7Hj3jUm/+844EPuWDfpNsYHPWsV3xyxpNU5CvtimebyAvb
 bwc0NCVnNm0us1Vjk2Z8vGQDHzSEvXs=
X-Proofpoint-GUID: 3HLy8_gri8baOJyf4TQkhvg1bVbs0H1o
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDA2MyBTYWx0ZWRfX1+LxtvNVrQqC
 5jlJMVf3HlwdbPoBpgomR9NInmUoJjXyUEp+RDuWfm1xedWQ8JxcqZufx39J2EdhsB12mih0QwQ
 cGlJ91ghEpWTfMFelrkhepASsvFINSQjPKzKxdjrChYkm9e6/nCoYMpsCfMhBFDtqvC6c0YRIjO
 AWYdoiJR2Z5km/dLTCJxE1P2o0l37Lrpof+7hW25ct5b8qwAbE57HFu9rjJ0d8q/rvnOkI1puBk
 MYbi2f1fMF2+fZRnd3UIPLtM+4k1eRR7vi6BkcVfai46D3+kfFOalMGHT540D9IkPv6DLY+QVHb
 dLZZYMd3XOl18MjJ4gAQ0IpIZIXLi7wpiMNkPhWgSXkSkj/gaPT+EvedMaskz9UwsP8CRgGYTND
 p7LCXAdJ61oJ3/+mCTZl6ifM8Z0ZZA1AKu5/cxPKPzqsPOGMXlNR4au07bfNQP/4EzUONnYrWEi
 zPV3yftoJxK2LreC6Zg==
X-Authority-Analysis: v=2.4 cv=fM2sTpae c=1 sm=1 tr=0 ts=6ac3ce52 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=rabq5xu0FV1yoOBActIA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_04,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 phishscore=0 adultscore=0 malwarescore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610050063
Received-SPF: pass client-ip=148.163.156.1; envelope-from=kshk@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On 261005 08:46, Matthew Rosato wrote:
> On 10/5/26 9:23 AM, Konstantin Shkolnyy wrote:
>> On 261002 19:43, Konstantin Shkolnyy wrote:
>>> On 261002 13:28, Matthew Rosato wrote:
>>>>
>>>>> -static int reg_ioat(CPUS390XState *env, S390PCIBusDevice *pbdev,
>>>>> ZpciFib fib,
>>>>> -                    uintptr_t ra)
>>>>> +bool s390_pci_ioat_validate(S390PCIBusDevice *pbdev, uint64_t pba,
>>>>> +                             uint64_t pal, uint64_t g_iota, Error
>>>>> **errp)
>>>>>    {
>>>>> -    uint64_t pba = ldq_be_p(&fib.pba);
>>>>> -    uint64_t pal = ldq_be_p(&fib.pal);
>>>>> -    uint64_t g_iota = ldq_be_p(&fib.iota);
>>>>>        uint8_t dt = (g_iota >> 2) & 0x7;
>>>>>        bool t = s390_pci_is_translation_enabled(g_iota);
>>>>> -    pba &= ~0xfff;
>>>>> -    pal |= 0xfff;
>>>>>        if (pba > pal || pba < pbdev->zpci_fn.sdma || pal > pbdev-
>>>>>> zpci_fn.edma) {
>>>>> -        s390_program_interrupt(env, PGM_OPERAND, ra);
>>>>> -        return -EINVAL;
>>>>> +        return false;
>>>>
>>>> This will now violate include/qapi/error.h because you're returning
>>>> false but not setting errp:
>>>>
>>>>    * - On success, the function should not touch *errp.  On failure, it
>>>>    *   should set a new error, e.g. with error_setg(errp, ...), or
>>>>    *   propagate an existing one, e.g. with error_propagate(errp, ...).
>>>>
>>>> A simple solution would be to add a new message for this case.
>>>
>>> But the original reg_ioat() also didn't print any message in this
>>> error branch. I had to assume it was intentional, and preserved the
>>> behavior.
>>>
>>> If you believe a new message should be introduced, I can insert a
>>> commit for that - what would be the explanation?
>>
>> Other code sites reporting PGM_OPERAND also don't generate error
>> messages - it appears, the current policy is not to do that in the cases
>> when the guest is at fault (gave invalid parameters). The case at hand
>> falls in that category.
>>
> The other 2 cases in this very function, where we are providing an error
> message, are also due to invalid guest parameters.  We advertised the
> necessary information to make a correct decision via CLP query payloads,
> but the guest gave us bad input anyway.

OK, since we already have a precedent right here, I'll add the message 
you've suggested in the earlier reply.

> 
> The fact that these messages are in response to guest parameters is why
> it made sense to switch to qemu_log_mask(LOG_GUEST_ERROR, ...) -- the
> guest can control if the message pops by purposely setting bad inputs.
> 
> With that in mind, there's probably an argument for adding more messages
> and/or trace events to other PGM_OPERAND paths for debug purposes since
> these aren't things expected to fail on a normally-behaving guest.  But
> that's beyond the scope of this series.
> 
> For this series:  you need to either add a message to this case or, if
> you feel that strongly about not reporting a message for it, then
> another solution would be to remove it from the s390_pci_ioat_validate()
> function and check it in 2 places so that a message is not required and
> then everything in s390_pci_ioat_validate() will generate an errp for
> the false case, satisfying include/qapi/error.h.
> 
> Thanks,
> Matt


