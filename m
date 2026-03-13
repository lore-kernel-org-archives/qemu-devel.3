Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EE39107BCD6
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 18:28:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w17EU-0006vR-4k; Fri, 13 Mar 2026 14:27:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1w17EK-0006tb-Uh; Fri, 13 Mar 2026 14:27:26 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1w17EI-0004vs-SD; Fri, 13 Mar 2026 14:27:24 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62D6qEqB2306511; Fri, 13 Mar 2026 18:27:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=/DGCwN
 O6y/E74VqUghSj8nzM7AJmDHrucgEWVzAPrlw=; b=TuM4g2kVQyQGDmdt/9imlg
 rjcxmU26rmaXke7HVotKQK8UhMv0OIDLXMrT8mSZSAj9E9Bz+sBVo3lxfOSNfAIa
 5P+01RDVViO4oLiK6njGcK4rA0lHQH4WomjaJH9I/TD5P1Hdxd6zpTgyshDoJFHe
 pyHnwaHV5yn4o8GTS1d3mobixbG1Ab0tY1gB0LP6sxctdP0KyWacm75X7x1TeOef
 JXgfgYxSAIB6GDbF1aBeLpkNl9jyHmeINYN5wWhjbOxPwhlUJl2Kri1rqgp/mRHL
 XfwQ25ftSu4WOk0SaLuFnWdRZ9H81hkVS6MMzQKBkHod847laYQsHq0tGcws6MYg
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cuh96gxs1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 13 Mar 2026 18:27:18 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62DF7C9v020823;
 Fri, 13 Mar 2026 18:27:18 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cuha9qv83-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 13 Mar 2026 18:27:18 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 62DIRGSm30736944
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 13 Mar 2026 18:27:16 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D52505805A;
 Fri, 13 Mar 2026 18:27:16 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6031558056;
 Fri, 13 Mar 2026 18:27:16 +0000 (GMT)
Received: from [9.61.92.76] (unknown [9.61.92.76])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 13 Mar 2026 18:27:16 +0000 (GMT)
Message-ID: <d8371b67-7a4f-438d-9a9d-339e4fc22f49@linux.ibm.com>
Date: Fri, 13 Mar 2026 14:27:15 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] MAINTAINERS: Update the s390x maintainers
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Cornelia Huck <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-s390x@nongnu.org
References: <20260313113424.15583-1-thuth@redhat.com>
 <20260313113424.15583-3-thuth@redhat.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20260313113424.15583-3-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEzMDE0MyBTYWx0ZWRfX5elggGlwoqUl
 uQ+18zCanKezhtJw6S8f9S+msJM97kskva4lZftcoS+o76JH9omLO1JaM2AuiMqeHDNZx2WjgGt
 zjEJCHhDxB+MZhzQzzsTKKaTNNVrFF3WcI9X7i5NTIVKNzaA9zayqkEFYVWqS9/+Z1stoj/oUit
 rXzVgsu7pgAFLuWGkyWGxPjZuR0uqm1H46A/XIeTIKfiZiBElSfLTdTYxDW+FudrMW4IX0fNKl3
 UBuopQXhH58D6cQfCyoQQLsZMNuIB5fXs4MEkQWASwshGsocqAlNrDjmAUnczPcKw7Gyofqja4V
 VZqgjJslBtqKuyP9jtUSXBjKX4at6ISZn2IhvTW/O1P2Bctw2WbNYSi+PN8Wh6B5moNtfIH9e4W
 pPPjpD/sA0VwivcFLgtK7g/Nhwp1DgqnSMAhRFSd9SbRVnKAhmX8FJEwVNKdZdsAn7TW7FoCagC
 rMgwTQdIlAZIIvFxZkQ==
X-Proofpoint-ORIG-GUID: hkMZKdrnp814MCj5Ob9Zmy223ihxPI-1
X-Authority-Analysis: v=2.4 cv=RLO+3oi+ c=1 sm=1 tr=0 ts=69b45706 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=NEAV23lmAAAA:8
 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8 a=69wJf7TsAAAA:8 a=LZu0NBD1WcyN9yPbgcEA:9
 a=NqO74GWdXPXpGKcKHaDJD/ajO6k=:19 a=QEXdDO2ut3YA:10 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-GUID: hkMZKdrnp814MCj5Ob9Zmy223ihxPI-1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-13_03,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 clxscore=1015 impostorscore=0 bulkscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603130143
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 3/13/26 7:34 AM, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> I'm going to move to another project next month, so I will not have
> enough time to take care of s390x patches anymore. Fortunately,
> Cornelia volunteered to take over the job of collecting s390x patches,
> and Eric and Matthew offered help to back her up, so we can keep
> the "S390 general architecture support" section in the "supported"
> state. Thanks for your help, Cornelia, Eric and Matthew!
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Hi Thomas,

I can only echo Eric's statements!  It's been great working with you over the years -- thank you for all you've done for s390x.  Wishing you the best in your next role.

Acked-by: Matthew Rosato <mjrosato@linux.ibm.com>

> ---
>  MAINTAINERS | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 49e9b7dccbb..9a859e4133a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -102,7 +102,9 @@ T: git https://github.com/vivier/qemu.git trivial-patches
>  Architecture support
>  --------------------
>  S390 general architecture support
> -M: Thomas Huth <thuth@redhat.com>
> +M: Cornelia Huck <cohuck@redhat.com>
> +M: Eric Farman <farman@linux.ibm.com>
> +M: Matthew Rosato <mjrosato@linux.ibm.com>
>  S: Supported
>  F: configs/devices/s390x-softmmu/default.mak
>  F: configs/targets/s390x-softmmu.mak
> @@ -1862,7 +1864,6 @@ T: git https://github.com/borntraeger/qemu.git s390-next
>  L: qemu-s390x@nongnu.org
>  
>  S390-ccw boot
> -M: Thomas Huth <thuth@redhat.com>
>  M: Jared Rossi <jrossi@linux.ibm.com>
>  R: Zhuoying Cai <zycai@linux.ibm.com>
>  R: Christian Borntraeger <borntraeger@linux.ibm.com>


