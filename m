Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D22DC982CD
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 23:16:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6yrM-0008TP-9k; Wed, 16 Sep 2026 19:16:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1x6yrK-0008QQ-1B; Wed, 16 Sep 2026 19:16:10 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1x6yrI-0002io-CN; Wed, 16 Sep 2026 19:16:09 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68GG1cgf2330021; Wed, 16 Sep 2026 23:16:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=4RodAs
 ifnt/lrJCu4d0iQPafnt0QJgPGI/h5tln/sBU=; b=R8p57gZ/dqStlfq7NXsHGc
 56HB+qMIEkQZSzUsDgSGGRxGYhkWlIMRig58MDoIVa/M3+lHEvbgdx0kzTMeltzh
 JxQ8Xq+jK4x+Vf0nkE7R1jnS/5hUV9P3xJeRY4o3fFho8MQYvrlTdhQ7kM6+0qrK
 bz6U7ot/CYLoIVTJvlB0X/zgesS0103NvgYZiDGrOP929tTI/EHJRoE3TQXR1JJK
 bhv7ACog/cgy/D47/79OjhhBBPyHtJYGacwRbGqOiS3ZtDqhewOJGKKKQGdX6nZQ
 7wiVgXDhpqDC6J7wOER0O1NtYxpm9osqLqBpanVOgF6klHnILZHMYTcZMzAVDtZQ
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmxdqfdtd-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 16 Sep 2026 23:16:05 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68GMnhr81663474; Wed, 16 Sep 2026 23:16:05 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gq089ru83-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 16 Sep 2026 23:16:05 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68GNG3lK32899692
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 16 Sep 2026 23:16:03 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C9B4258052;
 Wed, 16 Sep 2026 23:16:03 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1BA6358045;
 Wed, 16 Sep 2026 23:16:03 +0000 (GMT)
Received: from [9.61.177.109] (unknown [9.61.177.109])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 16 Sep 2026 23:16:02 +0000 (GMT)
Message-ID: <d1d3c6bb-0475-4153-af6b-5428f1df5385@linux.ibm.com>
Date: Wed, 16 Sep 2026 19:16:02 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/9] hw/intc/s390x: Fix check after g_try_realloc
To: Eric Farman <farman@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Cornelia Huck <cohuck@redhat.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, qemu-stable@nongnu.org
References: <20260916203242.2509787-1-farman@linux.ibm.com>
 <20260916203242.2509787-8-farman@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20260916203242.2509787-8-farman@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDMyMiBTYWx0ZWRfXxa0d1GsOpDrt
 jHYtJWmKIN5zfun5SDsPY7kjmj1y4MsqLpUzdj87hUQUb82PYzVAJKSwGI1h4jM5jMcwv/5JeuJ
 cc571iOGLBPdLsyPfVAE9PRDzWpJ+lF0f8xUMu+E+iTv0gGSMhyASJiLRZL7tPUrFQFB1WSZrfY
 qY6Cl6n1PuaIdeY0g8Co1Ep82ddGbnvsBeWGXRci8KAvqfXrF2pjxOY2FI+kGp8Aorb7kOkqKur
 fmtEDP0gKrg1MuyWcxBNkcfz0eloTM2IWodwbFi6R7faYgGxzRMVTXs3q2cDTvYTtfJhpEgr3kd
 7OhTSeurWEcQxt+yhl20I8thPe23FmmJXzHpjg3GkTtBVBB+pxnaqFmwl8O5fixTeHnE7hXBhvZ
 JK+v3itoftTIAsoSTFLmNrsrtpspXnuoGlmHKJvnjwRDs/8i3XbFaX0AqhxlVbOd+qfM6+Mcs9M
 tiEcqZIu05KBZJhPwxA==
X-Proofpoint-GUID: CcHqggKNj8JV6qOel0XRlwZu2TdGk4rL
X-Authority-Analysis: v=2.4 cv=DobDa2/+ c=1 sm=1 tr=0 ts=6aab2335 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=69wJf7TsAAAA:8
 a=VnNF1IyMAAAA:8 a=MxaWCA7tdMJ2F43s-cMA:9 a=QEXdDO2ut3YA:10
 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-ORIG-GUID: CcHqggKNj8JV6qOel0XRlwZu2TdGk4rL
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDMyMiBTYWx0ZWRfXx1d4nZqE+n5g
 4VWBtXvsX6SvDhux9WOD1EFsewAuAjSTNTW/S8+oo6jDiAEveRwkhgghdFudytJmfnmXycH+ONh
 k2k6JkkvHsw0BNF1ggvEK6bDtvO/Ix0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-16_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 spamscore=0 clxscore=1015 adultscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609160322
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
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

On 9/16/26 4:32 PM, Eric Farman wrote:
> The loop to store pending IRQs uses g_try_realloc() to expand the
> buffer being used, but the returned address is stored in a
> pointer-to-pointer. Thus, the check needs to examine its contents
> and not the pointer itself.
> 
> Cc: qemu-stable@nongnu.org
> Fixes: 3a553fc658 ("s390x/kvm: implement floating-interrupt controller device")
> Signed-off-by: Eric Farman <farman@linux.ibm.com>
> ---
>  hw/intc/s390_flic_kvm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/intc/s390_flic_kvm.c b/hw/intc/s390_flic_kvm.c
> index 5e6d422fba..ce9c720512 100644
> --- a/hw/intc/s390_flic_kvm.c
> +++ b/hw/intc/s390_flic_kvm.c
> @@ -264,7 +264,7 @@ static int __get_all_irqs(KVMS390FLICState *flic,
>          }
>          len *= 2;
>          *buf = g_try_realloc(*buf, len);

Aren't we also leaking the old *buf if this fails?

I think you need a local void *foo here to catch the return..

> -        if (!buf) {
> +        if (!*buf) {
>              return -ENOMEM;
>          }

And then here a *buf = foo; to only overwrite *buf in the success case.

>      } while (r == -ENOMEM && len <= KVM_S390_FLIC_MAX_BUFFER);


