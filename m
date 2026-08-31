Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57AB6C624C6
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 14:22:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x12tx-0000Ud-2F; Mon, 31 Aug 2026 10:22:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nnmlinux@linux.ibm.com>)
 id 1x12tw-0000UO-06; Mon, 31 Aug 2026 10:22:20 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nnmlinux@linux.ibm.com>)
 id 1x12tu-0008Ii-DE; Mon, 31 Aug 2026 10:22:19 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67VBVdfK2083851; Mon, 31 Aug 2026 14:22:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=yyXFCx
 7M3VJTJojM9XxDHIqFhk9lbL29SkkRqxSX+Dw=; b=rh5bpLjKDTK7Soh4pOPU68
 A2k1rRZ/DI5coVL6SdOxfkL8TZZ/9TM6F8clo8bPI5CsglXPaGZEKGIm+fH9sevI
 rrCz50h+JppJ0scMCdthplMNiTWdFWNH311IJLRlCohUUKsVrVqzWVk7wBZIRvz6
 h1R3RbvmHtVyMwiO60rYm9LPToxjKmKHwMoMbHVBDwZrk07Gc93gGHtrKl5rPqzo
 ZeVDb8EGF8LlbiAJXtiD1m9AtKdT0NPmyKlPHc78dPgHqrZrq12GDM2g45CpHblS
 NgXb+EHnEBeLSLi22rZDbU+gJ2+Yf6rlf4gz1hf0uUV9RJmpntCFO2hESeYqAKcQ
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbq54ht0k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 31 Aug 2026 14:22:16 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67VEBKVa027531;
 Mon, 31 Aug 2026 14:22:15 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gcarjxaxe-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 31 Aug 2026 14:22:14 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67VEM8Oi52494798
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 31 Aug 2026 14:22:08 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0548B20040;
 Mon, 31 Aug 2026 14:22:08 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8679220043;
 Mon, 31 Aug 2026 14:22:04 +0000 (GMT)
Received: from [9.124.217.83] (unknown [9.124.217.83])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 31 Aug 2026 14:22:04 +0000 (GMT)
Message-ID: <37d82601-68c0-49e6-b707-0954d56ceccb@linux.ibm.com>
Date: Mon, 31 Aug 2026 19:52:03 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/6] MAINTAINERS: Add self as sPAPR EEH reviewer under
 PPC RAS
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org, 
 qemu-ppc@nongnu.org, mahesh@linux.ibm.com, sbhat@linux.ibm.com,
 anushree.mathur@linux.vnet.ibm.com, sourabhjain@linux.ibm.com,
 adityag@linux.ibm.com, nikhilks@linux.ibm.com
Cc: pierrick.bouvier@oss.qualcomm.com, rathc@linux.ibm.com, npiggin@gmail.com, 
 harshpb@linux.ibm.com, amachhiw@linux.ibm.com, hbathini@linux.ibm.com,
 shivangu@linux.ibm.com
References: <20260831071958.58824-1-nnmlinux@linux.ibm.com>
 <20260831071958.58824-7-nnmlinux@linux.ibm.com>
 <b8cc9490-6716-4eb9-b330-728ebe87ae99@redhat.com>
Content-Language: en-US
From: Narayana Murty N <nnmlinux@linux.ibm.com>
In-Reply-To: <b8cc9490-6716-4eb9-b330-728ebe87ae99@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDEyMSBTYWx0ZWRfX7fF9wBSLfpMp
 KwmarsQq9w4hyJ3ZbXHJrl1F6YbFJs3KFfxtKacjuSMjKU3DuqestYgP0PQsnGgN4GfPzBtulSd
 OMAF3CZ1CalIgXUTcEYVLxZ+LA8+F8xfZaZq4XjxbKUlp8rqemlZ7psdEKjCdFRBlFXKPLXpmBn
 5gUSBZlOghvPzBmNcfCdwhiISHEX4yJDr+6HAhmhJ9cnYMxKhEUtKFrK88raOJ+HOyXrFCNEm44
 jSO7cGVfyF2a0GQVfZnDVHRTT0ypkaXBxZqyyRZs7vDfI7XsfgHOKmaI7haD9RSNH5jEVdjU+pJ
 GpqmciB7UqIPziJHUMNpRUMy5XLa95nxrywT5RtSSO9MW0prmKsvcbRjIJH+sZkHssmxUSAX8cg
 DcWE5h+gfLFOLXtLIvwOwGHDq9uZ1xdd7AeipddroE+zbh/V0fsBsnyGH1F0gIfUvQbg5aaB1JB
 +uHPipZ9X//l14OqOhQ==
X-Proofpoint-ORIG-GUID: Bvcl5DkNFhQMpD0tvG9p-x9QtUSO6GTe
X-Authority-Analysis: v=2.4 cv=CNgamxrD c=1 sm=1 tr=0 ts=6a958e18 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=69wJf7TsAAAA:8 a=Z0eqF2fs3n5ewGZ0-vIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-GUID: RJ3P0RSSzsV5zpKV22NlVXMbjbagxeDL
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDEyMSBTYWx0ZWRfX+rG7cAZiNfIW
 8FXKzJ+BpLsoINmmYNxoxHkVt1ury3GirqRIdbKeCb6+tcT84afFpWsA19AZ9DhEI9jaiHfbf3B
 N6Vm6KYwjkeKheJKe7Q5PVF7c23fUnc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_04,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 clxscore=1015 impostorscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310121
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=nnmlinux@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
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

Hi Cedric,

On 31/08/26 5:26 PM, Cédric Le Goater wrote:
> On 8/31/26 09:19, Narayana Murty N wrote:
>> Adding self as reviewer for the sPAPR EEH under PPC RAS.
>> Updating the EEH specific file name as got updated in previous patches.
>>
>> Signed-off-by: Narayana Murty N <nnmlinux@linux.ibm.com>
>> ---
>>   MAINTAINERS | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 4a49a40294..9271d849b0 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -1770,11 +1770,12 @@ M: Aditya Gupta <adityag@linux.ibm.com>
>>   R: Sourabh Jain <sourabhjain@linux.ibm.com>
>>   R: Hari Bathini <hbathini@linux.ibm.com>
>>   R: Shivang Upadhyay <shivangu@linux.ibm.com>
>> +R: Narayana Murty N <nnmlinux@linux.ibm.com>
>>   L: qemu-ppc@nongnu.org
>>   S: Maintained
>>   F: hw/ppc/spapr_events.c
>>   F: hw/ppc/spapr_fadump.c
>> -F: hw/ppc/spapr_pci_vfio.c
> 
> Nothing is left in hw/ppc/spapr_pci_vfio.c ?
> 
The spapr_pci_vfio.c is now covered by the regex under sPAPR machine 
entry. It is supposed to contain generic vfio code only now.
I think I need to send a V5 as I see some changes got missed in this 
series. I shall post V5 soon.

Thanks & regards,
Narayana
>> +F: hw/ppc/spapr_eeh.c
>>   F: hw/ppc/spapr_rtas.c
>>   F: hw/ppc/pnv_mpipl.c
>>   F: include/hw/ppc/spapr_fadump.h
> 


