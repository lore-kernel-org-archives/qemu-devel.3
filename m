Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF22DC982D6
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 15:49:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7EMK-0008Ag-KV; Thu, 17 Sep 2026 11:49:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nnmlinux@linux.ibm.com>)
 id 1x7EM6-0008A2-Vu; Thu, 17 Sep 2026 11:48:59 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nnmlinux@linux.ibm.com>)
 id 1x7EM2-0002tE-EZ; Thu, 17 Sep 2026 11:48:55 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68HE1W4r1536295; Thu, 17 Sep 2026 15:48:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=9ahjCW
 gNk/CYaACrgqmDhL4lyhUoxIeAzi25RPldpCQ=; b=ZjSJrKNjsWgIuCUv1eQGbL
 ZNrNKuVsRlqCKISK8co2UhXk3e6lxAI2u5oM7AYowDTLrgpow0otN7Ynk0qFiON3
 d/gdEbYX50tNbMw5E9JdmXihG1yYUZtqVAEZ+EyEANggRJ/qInxAck5azlYVyAcy
 X27VkplkiMdLq1IuWklftUChNWlv3EQTbs/FomQ3XCSVzIgnqCuGr3usruBaEwae
 R0kYFrO6h1Y/8nK25PbUZNPRd2uzc+4K+ssheiQUibb64Tw9cwu7e7nqdEvXWXI9
 Fu1cxvCPjLAypqRSA9kX6J/KGulXABs9VfXsmXIiv+N+QUr6gVJ7Xc5MwgOG8W4w
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmw5eawns-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 17 Sep 2026 15:48:50 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68HDa2Pv4151495; Thu, 17 Sep 2026 15:48:49 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gr7gejp2v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 17 Sep 2026 15:48:49 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68HFmiE151904976
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 17 Sep 2026 15:48:45 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CFBE220049;
 Thu, 17 Sep 2026 15:48:44 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 62D1020040;
 Thu, 17 Sep 2026 15:48:41 +0000 (GMT)
Received: from [9.39.22.229] (unknown [9.39.22.229])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 17 Sep 2026 15:48:41 +0000 (GMT)
Message-ID: <87238b78-23ff-452a-8939-7ccc8d4cfa8e@linux.ibm.com>
Date: Thu, 17 Sep 2026 21:18:40 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/6] ppc/spapr: Add VFIO EEH error injection backend
To: Nikhil Kumar Singh <nikhilks@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, mahesh@linux.ibm.com, sbhat@linux.ibm.com,
 anushree.mathur@linux.vnet.ibm.com, clg@redhat.com,
 sourabhjain@linux.ibm.com, adityag@linux.ibm.com
Cc: pierrick.bouvier@oss.qualcomm.com, rathc@linux.ibm.com, npiggin@gmail.com, 
 harshpb@linux.ibm.com, amachhiw@linux.ibm.com, hbathini@linux.ibm.com,
 shivangu@linux.ibm.com
References: <20260901174110.45356-1-nnmlinux@linux.ibm.com>
 <20260901174110.45356-2-nnmlinux@linux.ibm.com>
 <97eda650-c75a-4342-96d6-d44c4780a1ad@linux.ibm.com>
Content-Language: en-US
From: Narayana Murty N <nnmlinux@linux.ibm.com>
In-Reply-To: <97eda650-c75a-4342-96d6-d44c4780a1ad@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDIyMCBTYWx0ZWRfX3QlhWaoXLQxx
 REjYNdUGAn85+bw2dMtnmyCX2YNUVFAvcILJGophK1My6WbcF0HsCH7+PYEn2KCSN8iyCEUiCu1
 vJ8Wyi5LGRtaQ0JuJSQMTBBz4GJaKSpLd9iF29Q2AoNnYZrkFl/87HPLfEZ/XR+dxWFLirl6dMy
 DRvPs/2D/tn4hJ4sHOU2NdENjUL4W2uJuy+dP+UTIC+1TjXArOPCUCoTaZykHo7xanUPRXrnxBI
 0ySVxN3Q71WSSDtD/imQse16Q6uF4niTRZp/m/RZP7Y9BTGtC/oPkr01HsYLhxniohosHRps2Ck
 HCH35kjBPpE8V7QDJhmJsbCN874jieGFAiEy8BzczSO+9cnIj+tEmAYgyV8RQMPjFxA4Yb3bd7c
 2BQLZtgL9/lbnDXxGuInGmVWvQIZ5PWCA49Is6oTn6h62IAnkuEOmEJvgQmM++uLikWd7yZ03xQ
 PeZhusGKHBjwrhiuSow==
X-Authority-Analysis: v=2.4 cv=E/NYNqdl c=1 sm=1 tr=0 ts=6aac0be3 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=Ps1BV3FplG9IjyAbGJwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: oHNt-wP_ObL7nNi_1zXtAJnIgFmlSpaP
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDIyMCBTYWx0ZWRfXx3ymimFz9KUd
 AZKWmQ3b4BDdZ0XWzT6NReqzBdQCTA863ED9Uli2u2Ul2kCJ+Ov6W9HEOCXPv5b0i0CKCFyDXiF
 JQQqO1V8BDlUdzrH4N1qky1lev8+/+U=
X-Proofpoint-GUID: JiL9-6KTuVphG6PdL-g7iPGoHF1LtDIx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-17_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0
 adultscore=0 clxscore=1015 bulkscore=0 malwarescore=0 suspectscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609170220
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=nnmlinux@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
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

Hi Nikhil,

Thanks for reviewing,

On 17/09/26 1:50 PM, Nikhil Kumar Singh wrote:
> 
> On 01/09/26 23:11, Narayana Murty N wrote:
> 
>> +    if (ioctl(container->fd, VFIO_EEH_PE_OP, &op) < 0) {
>> +        error_report("vfio/eeh errinjct: VFIO_EEH_PE_OP failed: %s",
>> +                     strerror(errno));
>> +        switch (errno) {
>> +        case EINVAL:
>> +            return RTAS_OUT_PARAM_ERROR;
>> +        case ENOTTY:
>> +        case EOPNOTSUPP:
>> +            return RTAS_OUT_NOT_SUPPORTED;
>> +        default:
>> +            return RTAS_OUT_HW_ERROR;
>> +        }
>> +    }
> 
> Hi Narayana,
> 
> In existing QEMU EEH code, I have seen that EEH operations call 
> vfio_eeh_container_ok(container) before EEH ioctl is issued. That part 
> is missing in this code. Can you please add it? And if that check is 
> intentionally skipped and not necessary here, could you clarify the 
> reasoning?
It got removed unintentionally the block
     /* Enforce exactly one group per container check matching other EEH 
ops */
     if (!vfio_eeh_container_ok(container)) {
         error_report("vfio/eeh errinjct: kernel requires a container 
with exactly one group");
         return RTAS_OUT_HW_ERROR;
     }
will correct it in next version.

Thanks,
Narayana Murty N
> 
> The rest of the patch looks fine to me. Once this concern is addressed, 
> feel free to add my tag:
> 
> Reviewed-by: Nikhil Kumar Singh <nikhilks@linux.ibm.com>
> 
> Thanks & Regards
> ~ Nikhil


