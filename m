Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7A7DCAC5B0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 21:23:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3LJd-00065L-2U; Mon, 29 Sep 2025 17:21:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1v3LJW-00064Z-6J; Mon, 29 Sep 2025 17:21:42 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1v3LJT-0007Na-7n; Mon, 29 Sep 2025 17:21:41 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58TE4ZEu006384;
 Mon, 29 Sep 2025 21:21:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=DGVlbe
 autYPWxG4C817ApVoY9QFSpIhX2SS4eWjY7Go=; b=Uy0RgGV0kET2PqH7Pbp+hG
 eKr8m78g5kKKHLieHYd55lZHhLIlWYf+kDIJTtpS4SQhlKEBEG3M2fdLBhPvVliB
 MXPxfYQrvObAwTO5FVHFm7n4LJ65cJ2O+P05V/0ZzktOl2yCX6+ED3059tk6sfBS
 Box7y9LLN90EcOz29XYhkNTah1efc3bKmo0rAWXclH6bXzus19eSuwtKMdtwItdm
 2qbqRgei7PuqjzPdeMh8OM7/l9tLnkZKcFHOzZIQDzkJvD4H0fO4Ys8MPJjrQsGf
 5DcQ339KhaCDdkLN+M0pj0161eip/nEG4t2UGDegrwJyUWtMIXE9UHeFEOL1LSbQ
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49e7e74wd9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 29 Sep 2025 21:21:33 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58TKUUP5026746;
 Mon, 29 Sep 2025 21:21:32 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49eu8mr3sc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 29 Sep 2025 21:21:32 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 58TLLUML22610570
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 29 Sep 2025 21:21:31 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A97825805D;
 Mon, 29 Sep 2025 21:21:30 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 87C1B58055;
 Mon, 29 Sep 2025 21:21:29 +0000 (GMT)
Received: from [9.61.244.142] (unknown [9.61.244.142])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 29 Sep 2025 21:21:29 +0000 (GMT)
Message-ID: <6dd011fc-1ea3-4d43-9aa7-6e1fc5d57bbd@linux.ibm.com>
Date: Mon, 29 Sep 2025 14:21:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 15/28] hw/s390x/ipl: Add IPIB flags to IPL Parameter
 Block
To: Zhuoying Cai <zycai@linux.ibm.com>, thuth@redhat.com, berrange@redhat.com, 
 richard.henderson@linaro.org, david@redhat.com, jrossi@linux.ibm.com,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: walling@linux.ibm.com, jjherne@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com
References: <20250917232131.495848-1-zycai@linux.ibm.com>
 <20250917232131.495848-16-zycai@linux.ibm.com>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <20250917232131.495848-16-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ArS4BWEuSAYnFP3ZA0wDIxqJrvSNtqrH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAyMCBTYWx0ZWRfXxilha1FX+iHu
 7fqXAYBpTnAbq1cKa37z5yIZcj62luaLSh7i+Zfct8YapaX8TPQXl3z/QgBLFvRyMjznEZTtCFZ
 kDsFQCLrSaLQmu5gugFg9r9uuskx5egT3p/ynJiBUdm+6u/rJ51jqUsB4RHGwnAhlK44IC9iCew
 xHGPnIfiL+g5pO6UsaMPQPSl29FV7E4RG7MmcNzMXFuiaAvj/QOd7E4sWUfGwjWZ04C9u0bxIVK
 OhQrw1VFYG3bb8Uvtury9lu5XOrHThG6BYpFF75MenLJVJ3koWbxNhD6PXfinWEouwGGtLjREHS
 SYnjQOX/oTh0FjN26jVCVywAQNWMjHrm8eGx0KyY17viS4LeYWzIqRGnkMnIKaM7Pr+f3GlfNhn
 c1COaj2KTirVkG8iC6ZIImK+ZXpXNg==
X-Proofpoint-GUID: ArS4BWEuSAYnFP3ZA0wDIxqJrvSNtqrH
X-Authority-Analysis: v=2.4 cv=Jvj8bc4C c=1 sm=1 tr=0 ts=68daf85d cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=C9IQg14i1mWWDr6A2ooA:9
 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-29_06,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 impostorscore=0
 suspectscore=0 phishscore=0 bulkscore=0 clxscore=1015 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2509270020
Received-SPF: pass client-ip=148.163.156.1; envelope-from=alifm@linux.ibm.com;
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


On 9/17/2025 4:21 PM, Zhuoying Cai wrote:
> Add IPIB flags to IPL Parameter Block to determine if IPL needs to
> perform securely and if IPL Information Report Block (IIRB) exists.
>
> Move DIAG308 flags to a separated header file and add flags for secure IPL.
>
> Secure boot in audit mode will perform if certificate(s) exist in the
> key store. IIRB will exist and results of verification will be stored in
> IIRB.
>
> To ensure proper alignment of the IIRB and prevent overlap, set
> iplb->len to the maximum length of the IPLB, allowing alignment
> constraints to be determined based on its size.
>
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> ---
>   hw/s390x/ipl.c                 | 17 +++++++++++++++++
>   hw/s390x/ipl.h                 | 18 +-----------------
>   include/hw/s390x/ipl/diag308.h | 34 ++++++++++++++++++++++++++++++++++
>   include/hw/s390x/ipl/qipl.h    |  5 ++++-
>   4 files changed, 56 insertions(+), 18 deletions(-)
>   create mode 100644 include/hw/s390x/ipl/diag308.h
>
> diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
> index 917166ba31..c1360905c4 100644
> --- a/hw/s390x/ipl.c
> +++ b/hw/s390x/ipl.c
> @@ -494,6 +494,23 @@ static bool s390_build_iplb(DeviceState *dev_st, IplParameterBlock *iplb)
>           s390_ipl_convert_loadparm((char *)lp, iplb->loadparm);
>           iplb->flags |= DIAG308_FLAGS_LP_VALID;
>   
> +        /*
> +         * Secure boot in audit mode will perform
> +         * if certificate(s) exist in the key store.
> +         *
> +         * IPL Information Report Block (IIRB) will exist
> +         * for secure boot in audit mode.
> +         *
> +         * Results of secure boot will be stored in IIRB.
> +         */
> +        if (s390_has_certificate()) {
> +            iplb->hdr_flags |= DIAG308_IPIB_FLAGS_IPLIR;
> +        }
> +
> +        if (iplb->hdr_flags & DIAG308_IPIB_FLAGS_IPLIR) {
> +            iplb->len = cpu_to_be32(S390_IPLB_MAX_LEN);
> +        }
> +

Can we move the setting of iplb->len to if block that checks for 
certificates? I am not if we really need the if block as we only set the 
hdr_flags to DIAG308_IPIB_FLAGS_IPLIR only when we have certificates?

Thanks Farhan


