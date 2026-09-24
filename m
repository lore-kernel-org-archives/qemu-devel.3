Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C4A8C982FD
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2026 05:49:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9cKa-0002lO-Ae; Thu, 24 Sep 2026 01:49:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1x9cKH-0002ka-Nl; Thu, 24 Sep 2026 01:48:57 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1x9cKE-0003d2-HW; Thu, 24 Sep 2026 01:48:57 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68O5bPTi1333887; Thu, 24 Sep 2026 05:48:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=otvIY+
 C0Fa5N1zDdhxjUtyzmXUiHnKr2d0iOyF18Ymg=; b=OIOyBYrzSc+nzlqIo5eY5q
 6JFkJ575ebZ74VjOnobz9kKQrT2pebl+PeAJFJrGQW8w8b3WomITz1JzeLP/jEkI
 lSImxyZ19NY9tx7JX9hh8r6u0Xa9FfF2AIsCpci1uMy+lSt0ziuPTmMPejQ+Vd1o
 dVTU4yxvhg4rq96ELcYPLAj9q43LhSDUjSvO3uL0gWbNUo4Qq7Tf3vMHUc5AHBrj
 Epkq804AS8QkryjfqjZjm5amLIM9vxqAvPdgB3bmZaeCkOQSkdZCZ7S76xjFBw0y
 PRDIjE0JDKMoOUoAuPv/RDY6087poVSM3jkT23e6uu9cCM2X2FuBXAbXky3BjaXw
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskgsf6s1-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 24 Sep 2026 05:48:44 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68O5lWwB212331; Thu, 24 Sep 2026 05:48:43 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gvu7e8g6r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 24 Sep 2026 05:48:43 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68O5lwh230147286
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 24 Sep 2026 05:47:58 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BC2CF58052;
 Thu, 24 Sep 2026 05:48:41 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 11C215805D;
 Thu, 24 Sep 2026 05:48:39 +0000 (GMT)
Received: from [9.123.9.22] (unknown [9.123.9.22])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 24 Sep 2026 05:48:38 +0000 (GMT)
Message-ID: <ad63521d-e541-4ec8-bb0f-0162187ed51b@linux.ibm.com>
Date: Thu, 24 Sep 2026 11:18:37 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] ppc: Raise decrementer IRQ on zero write
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 "Kirill A. Korinsky" <kirill@korins.ky>,
 Chinmay Rath <rathc@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Glenn Miles <milesg@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, Amit Machhiwal <amachhiw@linux.ibm.com>,
 Anushree Mathur <anushree.mathur@linux.ibm.com>
References: <20260903115229.95811-1-kirill@korins.ky>
 <20260903115229.95811-3-kirill@korins.ky>
 <3cc35c1e-febf-4ea7-94d2-e9191bc4acb8@ilande.co.uk>
 <a5355ab8-bafe-4c1e-989b-dcb05ec1fca3@linux.ibm.com>
 <e6f1816d-354d-445c-8658-cd76778bcd98@ilande.co.uk>
Content-Language: en-GB
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <e6f1816d-354d-445c-8658-cd76778bcd98@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=V/XoQuni c=1 sm=1 tr=0 ts=6ab4b9bc cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=f7IdgyKtn90A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22
 a=K9WV4dF8vl4Pk2ba5BIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: Ei9I4jEmrxzFm4BkGXr2vYYXN8I30ZHy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDAyNCBTYWx0ZWRfX5VW03bzY7Bjv
 Sv4GBXhh2SCiOYvRtmrP7VtwCIWTK+8bRqNoJHeZazyOpWX1c0QUjtI1mEP0DAgKJJOJh3uvUz6
 8dh80qL5+g9V/LmsgbBU9La9wLtUUy9Y/0axrPTpUNndPnfQeQUIlJUKT+hDVD2Csd+6GDnbLvs
 AX8kMbnXXuIkoNx3tmH3Bk8uS9awOfWw/LH03wdRdmu0gdP/5pNnbtsw1fpqYibGmEuOfVJFEiU
 mE/nWJoGQSzYc6slWsUvZ0S1NQ1ySmfCm0YwkCBcAMnM8skI53Mammt+BJ5JLg9rg0gKlXj8AQr
 Tb/75njySNa/3IWXNgbJiKiY6MHiSNPhJVR7ONnw+TUI8qLTSHlDo0OLkPKM2czpRCFYfyjujiM
 5wm6siyQeihvCRS0j33iDfM0/FABEurOjtJTZ04SXgdxeWXZQPBXzMEpopiPcgdpwr2rxctAOnl
 1dlFWrAFrX5GrbHBIhQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDAyNCBTYWx0ZWRfX9LXNcKzlTXVF
 VoEbvmVFVw+Tvqjv5ViZ5erxkUG+QfgtBk5hblSF41kGES/Bt3rzy2vWq2u7IpWcGzYNvferhzV
 gLnjZDofrgytneTZti7jHh9ZSzde8Cg=
X-Proofpoint-GUID: 50vt4bJZuwdMFrqWxaY45ZyA1OlGQoAZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 malwarescore=0 clxscore=1015 phishscore=0
 bulkscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609240024
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
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

Hi Mark,

On 24/09/26 10:47 am, Mark Cave-Ayland wrote:
> On 24/09/2026 05:19, Harsh Prateek Bora wrote:
> 
>> Hi Mark,
>>
>> On 18/09/26 6:49 pm, Mark Cave-Ayland wrote:
>>> On 03/09/2026 12:50, Kirill A. Korinsky wrote:
>>>
>>>> OpenBSD writes zero to an edge triggered decrementer, then enters idle
>>>> expecting its interrupt. QEMU defers the already due edge to a timer at
>>>> the current virtual time, leaving the guest stalled.
>>>>
>>>> Signed-off-by: Kirill A. Korinsky <kirill@korins.ky>
>>>> ---
>>>>   hw/ppc/ppc.c | 1 +
>>>>   1 file changed, 1 insertion(+)
>>>>
>>>> diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
>>>> index b123b4cc1c..d99e47d532 100644
>>>> --- a/hw/ppc/ppc.c
>>>> +++ b/hw/ppc/ppc.c
>>>> @@ -885,6 +885,7 @@ static void __cpu_ppc_store_decr(PowerPCCPU 
>>>> *cpu, int64_t now, uint64_t *nextp,
>>>>        * an edge interrupt, so raise it here too.
>>>>        */
>>>>       if (((flags & PPC_DECR_UNDERFLOW_LEVEL) && signed_value < 0) ||
>>>> +        ((flags & PPC_DECR_UNDERFLOW_TRIGGERED) && value == 0) ||
>>>>           ((flags & PPC_DECR_UNDERFLOW_TRIGGERED) && signed_value < 0
>>>>             && signed_decr >= 0)) {
>>>>           (*raise_excp)(cpu);
>>>
>>> LGTM, however since this is core PPC code I'd like a R-B tag from the 
>>> main PPC maintainers above. Chinmay/Harsh?
>>
>> Thanks for your review feedback on this series.
>> Chinmay is on vacation till next week and I had asked Amit and Anushree
>> offline to provide their review/test feedback on this (considering this
>> 2/5 generic change). I see Kirill has posted v2 based on Amit's review
>> feedback now. Since it is going to land in 11.2, I think we can give it
>> a little more time for review feedback (if any), before pulling it in
>> along with other PPC patches. Let me know if any other concerns? Thanks!
>>
>> regards,
>> Harsh
> 
> Hi Harsh,
> 
> I didn't realise we were still waiting for a response from Chinmay, no 
> problem to wait for their return. Assuming everyone is satisfied, I'm 
> still happy to take these through my qemu-macppc branch - let me know if 
> that works for you, or if you'd like to take this patch separately as 
> it's part of the core PPC code.
> 
Sure, provided we have acks from Amit and Anushree, you may include 
patch 2/5 as well. Thanks!

regards,
Harsh
> 
> ATB,
> 
> Mark.


