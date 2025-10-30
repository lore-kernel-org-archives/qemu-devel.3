Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75698CCF9F8
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 08:05:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vENf2-0006Sh-NS; Thu, 30 Oct 2025 04:05:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vENf0-0006SN-EZ
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 04:05:30 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vENev-0001lG-RF
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 04:05:28 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59U0C2FC026651;
 Thu, 30 Oct 2025 08:05:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=Pur6lQ
 qiPE/btq4kKrjaY7+yIyJve2PYXBugJaZcow0=; b=oy21WzwvImrzqulu5I9vfe
 rHuL2T4oGuXH1d7n4zbfKa+br8adgeNAVkzlGMiXAC5D40UG37sL0oKYjS0RzTJD
 sB/mAcMO/paLKrPWYWfl2Syk6V70Q9K23OBRONsQD4XK/hBma37e6wHToAiYQ/iK
 SJ5qcQ45VW6vZFjQ3vssOUytn5TJD+tQfcAi8AuPHrFuI6Grc2n22W9aBBZsrrNV
 OUDV1o+IEpWQeIIMKmGbquRF/ETxyfwjhmddQaJGikSNDohNsUjOW+maqRx95OuV
 lGYU+gzYkL3kXAN1tgnXrUcMwrcy6pLmIql6w/dxJolLPd+E6/UQB9e8ctn1LQbQ
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a34acq820-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 30 Oct 2025 08:05:17 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59U6GTrv027440;
 Thu, 30 Oct 2025 08:05:17 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4a33w2qfpg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 30 Oct 2025 08:05:17 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59U85FBt34013584
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 30 Oct 2025 08:05:15 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 166A558056;
 Thu, 30 Oct 2025 08:05:15 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2410B58052;
 Thu, 30 Oct 2025 08:05:13 +0000 (GMT)
Received: from [9.109.242.24] (unknown [9.109.242.24])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 30 Oct 2025 08:05:12 +0000 (GMT)
Message-ID: <47ac6382-3270-4179-8455-43cee36a9ca9@linux.ibm.com>
Date: Thu, 30 Oct 2025 13:35:11 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] hw/ppc: Fix missing return on allocation failure
To: Shivang Upadhyay <shivangu@linux.ibm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: peter.maydell@linaro.org, adityag@linux.ibm.com, qemu-devel@nongnu.org,
 sourabhjain@linux.ibm.com
References: <20251028080551.92722-1-shivangu@linux.ibm.com>
 <20251028080551.92722-2-shivangu@linux.ibm.com>
 <8d5a8cce-d769-4cd8-9753-7e9ad37d8a47@linaro.org>
 <dio77m3m5jj6ccgqpswkifiqztf5fz45qsjpspu2yszgwrfgha@mcwjruxszkn5>
Content-Language: en-US
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <dio77m3m5jj6ccgqpswkifiqztf5fz45qsjpspu2yszgwrfgha@mcwjruxszkn5>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=XbuEDY55 c=1 sm=1 tr=0 ts=69031c3d cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=f7IdgyKtn90A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8
 a=KKAkSRfTAAAA:8 a=NuKsrJnVAG_wn9fm84IA:9 a=0bXxn9q0MV6snEgNplNhOjQmxlI=:19
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
 a=oH34dK2VZjykjzsv8OSz:22 a=pHzHmUro8NiASowvMSCR:22 a=n87TN5wuljxrRezIQYnT:22
X-Proofpoint-ORIG-GUID: kcKEwjUV5yMIWGw1t2JZ-buReqp0ZPbw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDE2NiBTYWx0ZWRfX5cJiTtb71PZo
 +QjZB3eUGXPj5awfvR0c8HaTVj8n0htlQb0XiEHjTxHLmORg513cyMjz+VKRhSwqjnljwtK7lXt
 9csfbKZyo6ESpoDSuxUAaKOK0XHzot61x4HDSBDsMr23h70lBhiIuUR3VHs/cLvb87P2qhQfazQ
 nfxkeh0xAK0EicToIdZOTaLqz5qhiQx17qr/SzRiZMO58h4v1ZAtsz/NT1EKf1R9VhE1vAbylUW
 EB8fVlxhw9EOaklKZ+811vlByDW3xZLEPTNyrIEuWFshHy+VSBGLd+0D2oz0XNvlKVZcht/wQUU
 1VN84KOvCucpQo9PLzOcFSjBt1CP9ODH0YI1kL8Qnu/LO0B8Ls06XUzouoKbzcrUGXhdeOkO7SQ
 LRVojib0sonTfDAx/GrGzIy/jIMUzg==
X-Proofpoint-GUID: kcKEwjUV5yMIWGw1t2JZ-buReqp0ZPbw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_02,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 suspectscore=0 bulkscore=0 spamscore=0
 impostorscore=0 phishscore=0 priorityscore=1501 clxscore=1015
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2510280166
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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



On 10/28/25 15:54, Shivang Upadhyay wrote:
> On Tue, Oct 28, 2025 at 09:35:40AM +0100, Philippe Mathieu-Daudé wrote:
>> On 28/10/25 09:05, Shivang Upadhyay wrote:
>>> Fixes coverity (CID 1642026)
>>>
>>> Cc: Aditya Gupta <adityag@linux.ibm.com>
>>> Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>
>>> Link: https://lore.kernel.org/qemu-devel/CAFEAcA-SPmsnU1wzsWxBcFC=ZM_DDhPEg1N4iX9Q4bL1xOnwBg@mail.gmail.com/
>>> Reported-by: Peter Maydell <peter.maydell@linaro.org>
>>> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
>>> Signed-off-by: Shivang Upadhyay <shivangu@linux.ibm.com>
>>> ---
>>>    hw/ppc/spapr_fadump.c | 1 +
>>>    1 file changed, 1 insertion(+)
>>>
>>> diff --git a/hw/ppc/spapr_fadump.c b/hw/ppc/spapr_fadump.c
>>> index fa3aeac94c..883a60cdcf 100644
>>> --- a/hw/ppc/spapr_fadump.c
>>> +++ b/hw/ppc/spapr_fadump.c
>>> @@ -234,6 +234,7 @@ static bool do_preserve_region(FadumpSection *region)
>>>            qemu_log_mask(LOG_GUEST_ERROR,
>>
>> FWIW host heap exhaustion is not really a *guest* error, because the
>> guest can not control it.
> Hi, Philippe
> 
> 
> Thanks for the review. There are following log level defined in log.h
> 
> 	....
> 
> 	#define CPU_LOG_TB_OUT_ASM (1u << 0)
> 	#define CPU_LOG_TB_IN_ASM  (1u << 1)
> 	#define CPU_LOG_TB_OP      (1u << 2)
> 	#define CPU_LOG_TB_OP_OPT  (1u << 3)
> 	#define CPU_LOG_INT        (1u << 4)
> 	#define CPU_LOG_EXEC       (1u << 5)
> 	#define CPU_LOG_PCALL      (1u << 6)
> 	#define CPU_LOG_TB_CPU     (1u << 8)
> 	#define CPU_LOG_RESET      (1u << 9)
> 	#define LOG_UNIMP          (1u << 10)
> 	#define LOG_GUEST_ERROR    (1u << 11)
> 	#define CPU_LOG_MMU        (1u << 12)
> 	#define CPU_LOG_TB_NOCHAIN (1u << 13)
> 	#define CPU_LOG_PAGE       (1u << 14)
> 	/* LOG_TRACE (1 << 15) is defined in log-for-trace.h */
> 	#define CPU_LOG_TB_OP_IND  (1u << 16)
> 	#define CPU_LOG_TB_FPU     (1u << 17)
> 	#define CPU_LOG_PLUGIN     (1u << 18)
> 	/* LOG_STRACE is used for user-mode strace logging. */
> 	#define LOG_STRACE         (1u << 19)
> 	#define LOG_PER_THREAD     (1u << 20)
> 	#define CPU_LOG_TB_VPU     (1u << 21)
> 	#define LOG_TB_OP_PLUGIN   (1u << 22)
> 	#define LOG_INVALID_MEM    (1u << 23)
> 
> 	....
> 
> Which one do you recommend we use? or May we introduce a `LOG_HOST_ERROR`,
> if that's more appropriate.

I think it would be better to have LOG_INSUFF_MEM for this case, but 
let's hear from Philippe and others for suggestions.

Since it's unlreated to the coverity fix and can be taken separately, so:

Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>

> 
> Thanks
> ~Shivang.
>>
>>>                "FADump: Failed allocating memory (size: %zu) for copying"
>>>                " reserved memory regions\n", FADUMP_CHUNK_SIZE);
>>> +        return false;
>>>        }
>>>        num_chunks = ceil((src_len * 1.0f) / FADUMP_CHUNK_SIZE);
>>

