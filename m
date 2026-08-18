Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C2DCC5DF67
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 05:50:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwChl-00061w-R7; Tue, 18 Aug 2026 01:49:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1wwChj-00061U-Lm; Tue, 18 Aug 2026 01:49:43 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1wwChh-00046R-To; Tue, 18 Aug 2026 01:49:43 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67HM1l6b2625083; Tue, 18 Aug 2026 05:49:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=zCVovi
 K5YIgGmip3oxHQgmfXZ/TezidLTA2mD2TDQus=; b=EQhH0BEpliAhWG+eWFwd39
 Y3sRnZzNrigQ48D2TpoC2gIQsGkzfX6gcXQLvB/7AeeRd0h+/H2dqopkDTKQcsjk
 i1h9O75I6g1LXthObSkWeBw3kU3NHXtlW0a7BgdxIAxhm0lk+dl8taFgMh/6IEyI
 WaW0S+XxshduY8GGGwQg52z92hEQ8LoIvArrMk/pci+QJK9wfRbD1Jsc/1Z3XDeI
 VpAQhaV/z5bN8O9GB2g+jEWW5tz3IKIJqAGiPOZGEEEeDrcQZK/6++1yrAUdvIFz
 QvAOmJfTiT7Zd3uPmV/ks+bQvmVXSatl5AtPCMl/hT93BiJTbARXrfuCatGXgtUg
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2fu4pb2q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Aug 2026 05:49:39 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67I5fOao018123;
 Tue, 18 Aug 2026 05:49:38 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g33ek1m5r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Aug 2026 05:49:38 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67I5nYlA51970394
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 18 Aug 2026 05:49:34 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3596020040;
 Tue, 18 Aug 2026 05:49:34 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 364E32004B;
 Tue, 18 Aug 2026 05:49:32 +0000 (GMT)
Received: from [9.123.10.203] (unknown [9.123.10.203])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 18 Aug 2026 05:49:31 +0000 (GMT)
Message-ID: <6b7363f5-14c4-4c6b-a6a8-171235657a38@linux.ibm.com>
Date: Tue, 18 Aug 2026 11:19:31 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] MAINTAINERS: add self as reviewer for PowerPC RAS
To: Shivang Upadhyay <shivangu@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: hbathini@linux.ibm.com, sourabhjain@linux.ibm.com, harshpb@linux.ibm.com, 
 rathc@linux.ibm.com, npiggin@gmail.com, mahesh@linux.ibm.com
References: <20260714164745.573141-1-shivangu@linux.ibm.com>
 <20260714164745.573141-4-shivangu@linux.ibm.com>
Content-Language: en-US
From: Aditya Gupta <adityag@linux.ibm.com>
In-Reply-To: <20260714164745.573141-4-shivangu@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: Isny1I0m8Oo_a_19jxB8m326LI1X6m-i
X-Authority-Analysis: v=2.4 cv=NLLlPU6g c=1 sm=1 tr=0 ts=6a83f273 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=69wJf7TsAAAA:8 a=Un4lIAJwAGB7wmZNV9wA:9 a=QEXdDO2ut3YA:10
 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDAzOSBTYWx0ZWRfX+oX8tX5lrNWD
 CbLgOCM6i6EPWXxxUlmxGyt13gVPMRW88XE5OgOWXrcpR/YtkCNxfAGsVtonZWM2DI/wSKGPA7D
 1Va7jfkBwSdiuQJMbuDmb+NToZiMd5E=
X-Proofpoint-ORIG-GUID: rf9VEyE3J690fW4zfwmi6RWBd88yZcNa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDAzOSBTYWx0ZWRfXzWnpP2I0FX8q
 HyBxX0d2AX4uRfV6a2lHe5Fm3623arAyDRmqytxRIMWSE6CmtjW6C82JJFeRW7YDGkDoUkBUuIC
 9C+0ZKroP/dir93mtNmB4ucsdsVFcpRE5cTLOOk8Vlak8jhfeRTFNE2D/qq8YtL4CFPHJ6MWAS6
 nlbPGmIZDr4kDQ3vouxshf2Ecbx0SmFuadPauRejZQ5mKyubfbvTj9nhFPuUACltaGc11PZzfY7
 Bh8Qm8kJY9lL9yUAHtz2yM5szNF9eXWUOeR8a853HP2jJrGc2S4PYaWhmDJjC97dG1pmv31xFdB
 yvKFrJeVLPdfqc46GjV7T3slS29lOp4wB1WbB93xAWIxiPrvkG62V8R5W2O+f6q1RO9TGd6rWi1
 eQmha4D8zm8OdJ1An6lC2MOVtKQAv9kH7wrRdqe0ezwaHhFMHoCnfDw8rSaeXBteTZbzfwrfjzJ
 RvnxbYtoCWdWyeEnYkQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0
 malwarescore=0 suspectscore=0 clxscore=1015 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180039
Received-SPF: pass client-ip=148.163.156.1; envelope-from=adityag@linux.ibm.com;
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

On 14/07/26 22:17, Shivang Upadhyay wrote:

> I have been contributing to Fadump, MPIPL as well as PowerNV for quite
> some time, and my daily work responsibilities includes taking care of
> PowerPC RAS features. I, therefore would like to step up as a reviewer
> to get notified of incoming changes in this area and help reviewing
> them.
>
> Signed-off-by: Shivang Upadhyay <shivangu@linux.ibm.com>
> ---
>   MAINTAINERS | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 4a010d4807..6bbb725ec2 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1749,6 +1749,7 @@ PowerPC RAS (Reliability, Availability and Serviceability)
>   M: Aditya Gupta <adityag@linux.ibm.com>
>   R: Sourabh Jain <sourabhjain@linux.ibm.com>
>   R: Hari Bathini <hbathini@linux.ibm.com>
> +R: Shivang Upadhyay <shivangu@linux.ibm.com>
>   L: qemu-ppc@nongnu.org
>   S: Maintained
>   F: hw/ppc/spapr_events.c

Thanks for your helpful reviews Shivang !

Acked-by: Aditya Gupta <adityag@linux.ibm.com>


Thanks,

- Aditya G


