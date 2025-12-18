Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1060CD6E2DC
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Dec 2025 19:39:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWJpy-0007uU-DD; Thu, 18 Dec 2025 14:38:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1vWJpw-0007u9-As; Thu, 18 Dec 2025 14:38:56 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1vWJpu-00080Q-Ne; Thu, 18 Dec 2025 14:38:56 -0500
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BIG4tSx025635;
 Thu, 18 Dec 2025 19:38:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=n9akDz
 TW2L3fc8uGLX4AiZ/WkzibskqN0ofa9L+/wjQ=; b=l3UMKo9t2vBIQORPbSloIn
 h1E1v6u/ScsiVQITJ/91/a5uLPNaKR8jw8kmtOS77/vufx9/v1FM7lv28vn8oK9x
 HlArulDVy4PDve3MdW8r3jghKIL4Tw5rQxmAmGEub4PZP1yTepKOkwPJI8Kt7yRH
 +0AV+2JdBAMwrnGbJIxnp6RrDT9t16Qh9EL5hkfA+nKnJzfEvf2ep6BX5Dt/hT3R
 IFrIOIBTUu6jRO+osXkHhmNPGycGiRgtbYaxK2FeaS27ONAnpvMc3mjaRVUGX6DF
 rF6lWR5+K7bUBv2p1tMxB3QmfmrY1+o0opJgzM0h1DdwCo5EpZ1ARZEHD7thB5zg
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b0ytvmh5r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 Dec 2025 19:38:51 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5BIJY8AE031521;
 Thu, 18 Dec 2025 19:38:50 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4b4qvu80kh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 Dec 2025 19:38:50 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5BIJcmHW13566500
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 18 Dec 2025 19:38:48 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7CD945805D;
 Thu, 18 Dec 2025 19:38:48 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2497A58052;
 Thu, 18 Dec 2025 19:38:48 +0000 (GMT)
Received: from [9.61.64.106] (unknown [9.61.64.106])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 18 Dec 2025 19:38:48 +0000 (GMT)
Message-ID: <198747e2-ffb1-4d0d-b886-4da71346f511@linux.ibm.com>
Date: Thu, 18 Dec 2025 14:38:47 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Add util/s390x_pci_mmio.c to the S390 PCI
 section
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Eric Farman <farman@linux.ibm.com>
References: <20251218193642.170968-1-thuth@redhat.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20251218193642.170968-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjEzMDAyMyBTYWx0ZWRfX16sExPKwQ8kz
 d7XOiaPO4hnxsGXrqCeMABPnMntOMQDPWFYPM1Ockd5EelihUaZeQcsGxKeE03aJCNg1CobMGIY
 GX2zwvCXrsgrppoc7MvEs4KnzutfqILdHAds0k3CxmRDyYBqzRfM/Q8YqDqUatDrr41kr8xJgm4
 bCOX1dj/hE/Pd1a0ZSd6sXVaQ1L2CtcWS4YkSn/nekpFUV0Tofg0uEt+w/L1ahWyImJ2ZnpPEOu
 mm2t9t2xVtz3s28oS4M2IaQrEOD4Xcf3vpsYo9ZLaYBg8cXHlMBeIJu6f2JxzynKiwOy4YiZoSi
 MxVWXMCssJoOBmeMNS+gT1Mioq7g604vYfF67K/3gA1mR5ycOxCTYeDo6wLiMOw5eeu2nf5ITCv
 FITh8nQ+NseayFwWb4qmgd8M9FzQsg==
X-Proofpoint-ORIG-GUID: YCLqlfznOgWjf0fSDsi73z1UpalAp7jF
X-Authority-Analysis: v=2.4 cv=QtRTHFyd c=1 sm=1 tr=0 ts=6944584b cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8 a=69wJf7TsAAAA:8 a=y1HG68m94I6UZcum19sA:9
 a=NqO74GWdXPXpGKcKHaDJD/ajO6k=:19 a=QEXdDO2ut3YA:10 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-GUID: YCLqlfznOgWjf0fSDsi73z1UpalAp7jF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-18_02,2025-12-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 impostorscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2512130023
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
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

On 12/18/25 2:36 PM, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> s390x_pci_mmio.c currently shows up as unmaintained. Add it to
> the S390 PCI section to make the right people aware of changes
> to this file.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>

> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c7faa5672a4..226bf64f68e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1843,6 +1843,7 @@ M: Eric Farman <farman@linux.ibm.com>
>  S: Supported
>  F: hw/s390x/s390-pci*
>  F: include/hw/s390x/s390-pci*
> +F: util/s390x_pci_mmio.c
>  L: qemu-s390x@nongnu.org
>  
>  S390 channel subsystem


