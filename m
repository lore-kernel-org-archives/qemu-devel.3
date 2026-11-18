Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63409606A325
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Nov 2026 08:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ErwTjrPm
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTbRF-0006fg-Kz; Wed, 18 Nov 2026 03:54:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1xTbRA-0006fD-JS; Wed, 18 Nov 2026 03:54:41 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1xTbR8-00069K-DW; Wed, 18 Nov 2026 03:54:39 -0500
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AI2RrFZ030940; Wed, 18 Nov 2026 08:54:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=a400Ez
 VjpZoFWY17lwWIDoHJv8p++JQUF8y3JspEzGo=; b=ErwTjrPmepnoEEDkyL/11C
 hCVKCrDujF5sczFEKRE1pfEpkN7gFzbFOgfQHgZSOrVH5R7F0Gd3Brae4jwoHp69
 jmHtwGWIaQtaUTY3yUFt7CDMgFoyW2zre/PxiceUibNM+fIj6aF8T5lNUwopV26J
 IkkrWc/Df74FwtIA1Zyt3iWeD1Ue1/z92gWqe9o1zrxtwlI5dWPhNIMehAOOicZz
 m1vpEPokmy/TaO1okBrMoQh1o1Qs8a54VhoPi1Mbgarb5iDlsPlM5UcDhNEBYYI2
 AdjgvuK/XFyNY2C3lCYYpvThau1ZrNMnfsxOwx77lOf/67h+pkOq7VaDxb1Hvhwg
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j105n9my4-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 18 Nov 2026 08:54:31 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AI8AiA52766460; Wed, 18 Nov 2026 08:54:30 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hyxwt7tdp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 18 Nov 2026 08:54:30 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6AI8sT6u13632102
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 18 Nov 2026 08:54:29 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 412105805A;
 Wed, 18 Nov 2026 08:54:29 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BEB1658062;
 Wed, 18 Nov 2026 08:54:25 +0000 (GMT)
Received: from [9.43.64.164] (unknown [9.43.64.164])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 18 Nov 2026 08:54:25 +0000 (GMT)
Message-ID: <eb25be0f-6743-4050-89d8-cafdaa53b2f4@linux.ibm.com>
Date: Wed, 18 Nov 2026 14:24:24 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 6/6] spapr-vscsi: clamp adapter info DMA write length to
 struct size
To: Chinmay Rath <rathc@linux.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-stable@nongnu.org, qemu-devel@nongnu.org,
 Guthrie McAfee Armstrong <git@gmarmstrong.dev>,
 Gautam Menghani <gautam@linux.ibm.com>
References: <20261028052024.38377-1-harshpb@linux.ibm.com>
 <20261028052024.38377-7-harshpb@linux.ibm.com>
 <CAFEAcA-CML7CFxn7WC0d2uuE6cHJbM2-p2Lv-wcAXWU9kpsRWw@mail.gmail.com>
 <e2e9c608-f139-447f-887f-8fb4909470a3@linux.ibm.com>
 <CAFEAcA8M6PhCQV6EtKSp9VtqroA2Ah82y1--q_8Argg686_YwA@mail.gmail.com>
 <639f0cf2-f637-4fd4-bfb8-645c584a9377@linux.ibm.com>
Content-Language: en-GB
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <639f0cf2-f637-4fd4-bfb8-645c584a9377@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDAzMyBTYWx0ZWRfX6nj3K5bkwGOO
 ECB0MjmEn5x0XvzffD2aYZIOAa9A4BCOI31cLeKk6iGFXWnAEnl4PWm9ko5XwQDKOhYEXCFj3N1
 U0EzpBi+nNsEF9AtTp5zJ4GJ05JQ2kStVxs5berLwLGvZitpxKxhYnw65O8vgXbEBqw4PfzkuPb
 9EjqGatlvyDJ7cS81MhkmaBBuhc54ijVEjrsZV201wyzZ47zcj5JcMZpdBsh8h2O41LSyje6Ocs
 9DDRxm5gPxhefhz8+DEcZsBS75s41oPKHiElLLjPYctnQdo7utuRVjBG4NnV+iX2yE+n7EY5ujQ
 pECwDzqARiK245rNOg2zhv9kO7Phqtlkze7sw6yHiQoOmXuQL0xkOfeSFf1klrxoAOjbRWFrO3M
 pMFlO6xJZMbRAloGjDo6+uiqfjXPGw7d2ySmwcNvnONfefZGNdtXBXUgBG5Jgi8UQ6tAx00Jxik
 JSsC43nxrZiGVuS8b0A==
X-Authority-Analysis: v=2.4 cv=HN9WhYtv c=1 sm=1 tr=0 ts=6afd67c7 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=f7IdgyKtn90A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22
 a=p0WdMEafAAAA:8 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=69wJf7TsAAAA:8
 a=8Ozg99iFAvaLT1V3WKIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-GUID: Ch5SIqZueiG0W7G0MM4png8gMbqZJ8Uw
X-Proofpoint-ORIG-GUID: Ch5SIqZueiG0W7G0MM4png8gMbqZJ8Uw
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDAzMyBTYWx0ZWRfXxB1HiM8x+r0y
 NgDHCNy5CRuUvFXyW9lN8NpUuVypUN7IyQef9g7LoWoZVenSpRVwtSDSJt6p27MvGOIMwXRktRE
 i6jjSKm2AQh/hGhb0ol1AbrdxHjIbEQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-18_01,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 impostorscore=0 suspectscore=0 malwarescore=0
 adultscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611180033
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

+ Danpb

Hi Peter,

On 18/11/26 1:57 pm, Chinmay Rath wrote:
> 
> On 11/17/26 20:47, Peter Maydell wrote:
>> On Tue, 10 Nov 2026 at 06:54, Harsh Prateek Bora 
>> <harshpb@linux.ibm.com> wrote:
>>> + qemu-stable
>>>
>>> Hi Peter,
>>>
>>> On 05/11/26 8:57 pm, Peter Maydell wrote:
>>>> On Wed, 28 Oct 2026 at 05:21, Harsh Prateek Bora 
>>>> <harshpb@linux.ibm.com> wrote:
>>>>> From: Chinmay Rath <rathc@linux.ibm.com>
>>>>>
>>>>> vscsi_send_adapter_info() used the guest-supplied common.length
>>>>> field directly as the size argument to spapr_vio_dma_write().
>>>>> Since common.length is controlled by the guest, a value larger
>>>>> than sizeof(struct mad_adapter_info_data) (148 bytes) caused
>>>>> dma_memory_write() to read past the end of the stack-allocated info
>>>>> struct, leaking arbitrary host stack contents into guest memory.
>>>>>
>>>>> Fix this by clamping the write length to sizeof(info), then using
>>>>> spapr_vio_dma_set() to zero-fill any remaining bytes the guest
>>>>> requested beyond that size. This mirrors the existing pattern in
>>>>> vscsi_send_capabilities().
>>>>>
>>>>> Closes: https://gitlab.com/qemu-project/qemu/-/work_items/4626
>>>>> Reported-by: Guthrie McAfee Armstrong <git@gmarmstrong.dev>
>>>>> Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
>>>>> Reviewed-by: Gautam Menghani <gautam@linux.ibm.com>
>>>>> Tested-by: Gautam Menghani <gautam@linux.ibm.com>
>>>>> Link: https://lore.kernel.org/qemu-devel/20261007144434.374749-1- 
>>>>> rathc@linux.ibm.com
>>>>> Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
>>>> Shouldn't this be Cc: qemu-stable@nongnu.org ?
>>> Yes, should have been marked for stable. I have CCed it now though.>
>>>> Given that spapr-vscsi is supposed to be covered by the "virtualization
>>>> use case", have we deliberately decided we didn't want to give this
>>>> a CVE, or did that step in the process get missed ?
>>> I think it got missed, can we still request for a CVE to be assigned on
>>> the gitlab issue?
>> I asked Dan on IRC, and he said:
>>
>> "depends how far in the past it is - if we've not released the fix
>>   in a major release, I'd jsut temporarily re-open the bug and add the
>>   CVE::Required tag, and close it again once assigned
>>   that way we at least get a record of the CVE in the issue tracker, even
>>   though its missnig from the merged commit message
>>   if it was already fixed in a previous major release, I'd just accept
>>   that we dropped the ball and move on without a CVE"
>>
>> which sounds like a good idea to me.

Sounds good to me too, thanks!

>>
>> Speaking of things that got missed, what about
>> https://lore.kernel.org/qemu-devel/20260819095855.115823-1- 
>> rathc@linux.ibm.com/
>> ("hw/scsi: validate IU buffer bounds in vscsi_preprocess_desc()")
>> which is another one from Chinmay for this device that got posted
>> back in August and never applied ?
> Hey Peter,
> 
> I have responded on the original thread now, and shall take care going 
> forward.

Thanks Chinmay for addressing this.

regards,
Harsh
> 
> Regards,
> Chinmay
>>
>> thanks
>> -- PMM


