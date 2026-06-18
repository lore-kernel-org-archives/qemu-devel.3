Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45C10CD98ED
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 12:49:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waCAi-00025c-LV; Thu, 18 Jun 2026 08:48:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fcallies@linux.ibm.com>)
 id 1wa697-0007UF-Bh; Thu, 18 Jun 2026 02:22:37 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fcallies@linux.ibm.com>)
 id 1wa695-0001ZQ-Vg; Thu, 18 Jun 2026 02:22:37 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65HHmLU51000465; Thu, 18 Jun 2026 06:22:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=gV//1P
 75ml38jIptNxNh5NONBRIzlZeGAsd1+h6GlHI=; b=o1jImDmQBJk/7dJyatcLSR
 WnJeNyG/N5WnZPMvSOY8lv6GTLCn4v3Wc+nRoE8ibFL8ukJBw+9uxA7W7z9sKrCv
 UpkZbQe6W7q3tLBJsOfG/4pBXZY3VuqJJEkNa2b3ygHROHJp61gBqQSOagItdqh7
 fLred9Q6aIoTGFQbduyPsNzNVjq2/4/j5QcS+5v0v9jyzK56mHXpaOqmH4FckTbj
 GRAQ9xVAR6tlxI6pvwUwIDEexObLLmIEBpE01s1tqpqE/qG3nhyZQ1OTDUquVAtu
 mplGr4ppJZXHh8iPslhcXlc+Mj0z3gssBGxHcjlrDThEu0FKISgNlzadIzQeaRPg
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eueqx6k1d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 Jun 2026 06:22:32 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65I6Jb2e029758;
 Thu, 18 Jun 2026 06:22:31 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ev1722bh3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 Jun 2026 06:22:31 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65I6MSYu30999034
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 18 Jun 2026 06:22:28 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 04A6A2004D;
 Thu, 18 Jun 2026 06:22:28 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C700C2004B;
 Thu, 18 Jun 2026 06:22:27 +0000 (GMT)
Received: from [9.224.89.241] (unknown [9.224.89.241])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 18 Jun 2026 06:22:27 +0000 (GMT)
Message-ID: <66653376-f6d7-4370-b963-201053d7e903@linux.ibm.com>
Date: Thu, 18 Jun 2026 08:22:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 14/17] target/s390x: Support protected key AES XTS for
 cpacf km instruction
Content-Language: en-GB
To: Harald Freudenberger <freude@linux.ibm.com>, richard.henderson@linaro.org, 
 iii@linux.ibm.com, david@kernel.org, thuth@redhat.com, berrange@redhat.com
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 linux390-list@tuxmaker.boeblingen.de.ibm.com,
 linux-s390@vger.kernel.org, dengler@linux.ibm.com,
 borntraeger@linux.ibm.com, cohuck@redhat.com
References: <20260617094820.34402-1-freude@linux.ibm.com>
 <20260617094820.34402-15-freude@linux.ibm.com>
From: Finn Callies <fcallies@linux.ibm.com>
In-Reply-To: <20260617094820.34402-15-freude@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDA1NSBTYWx0ZWRfX19xD6v7dZ7pb
 9SSU23ciCHMOJAVVA5JY58fT8TYdL57Uf0phcyUZ38REtn9zi0C0dkbAqeOb9KQb0UK1+h4m9+9
 1oCSs5ktSDGfgG0TXSEPMcQdBdIe9rC8j9hf+O0ukLC1e4PGcLJ0Q8vpNpa//i0Rao4sqQ7hcQA
 5uu83QlEos+y45g6WIaDg0unr79EJCTRbP73CXcwsy9T5wbd0Vtm9IKMxZoEGl0fxSql/CRrG3l
 OOgmq1p8iaBeFu0qSX98O8++p/hfO8km24Ir401yK3aATFQ+vfrsl7EreNTbGQZo40OKsx40mcL
 wMqrvNJakow+Kvvye/EubHVHiEamThFmIK8sJwnAUDeAqixkDkMn/h8LkNNKifXaWc/BHFssG70
 M/NRQWu6rPd3RZCTHGHZsjobjL6MHSrMVNTXy+YR3i/U7E3PjLAsZVXNKzXZUTo6vr0oFIRQz11
 djAHLhgKKh3P0AvxVqw==
X-Proofpoint-GUID: uZoQv_U0PZDcUSfNBVdM7Xe1c2BqSb-G
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDA1NSBTYWx0ZWRfX5ZPgLpqFbf44
 b2I8wOV6DYel3e07Y75m8ZH62rSXRjjNc4nFazDbkFEUzzFHVq4nmVAiZHO8Tp5ZqTs2SoZAWt8
 yyZQuhNlzqqdl0VcNA1ufa/ZVthgRzc=
X-Proofpoint-ORIG-GUID: uZoQv_U0PZDcUSfNBVdM7Xe1c2BqSb-G
X-Authority-Analysis: v=2.4 cv=auGCzyZV c=1 sm=1 tr=0 ts=6a338ea8 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=bjhKnsnRy4Y7tZLOtR4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_02,2026-06-17_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 priorityscore=1501 suspectscore=0 impostorscore=0
 spamscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606180055
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=fcallies@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 18 Jun 2026 08:48:01 -0400
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



On 17.06.26 11:48, Harald Freudenberger wrote:
> Support the subfunctions CPACF_KM_PXTS_128 and CPACF_KM_PAES_256
> for the cpacf km instruction.
> 
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
> Tested-by: Holger Dengler <dengler@linux.ibm.com>

With the suggestion:

Reviewed-by: Finn Callies <fcallies@linux.ibm.com>

> ---
>   target/s390x/gen-features.c      |   2 +
>   target/s390x/tcg/cpacf.h         |   4 ++
>   target/s390x/tcg/cpacf_aes.c     | 106 +++++++++++++++++++++++++++++++
>   target/s390x/tcg/crypto_helper.c |   6 ++
>   4 files changed, 118 insertions(+)
> 
> diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
> index 126bacb281..c4c59c3504 100644
> --- a/target/s390x/gen-features.c
> +++ b/target/s390x/gen-features.c
> @@ -929,6 +929,8 @@ static uint16_t qemu_MAX[] = {
>       S390_FEAT_KM_EAES_256,
>       S390_FEAT_KM_XTS_AES_128,
>       S390_FEAT_KM_XTS_AES_256,
> +    S390_FEAT_KM_XTS_EAES_128,
> +    S390_FEAT_KM_XTS_EAES_256,

PAES or ENCRYPTED_AES

>       S390_FEAT_KMC_AES_128,
>       S390_FEAT_KMC_AES_192,
>       S390_FEAT_KMC_AES_256,

[ snip ]


