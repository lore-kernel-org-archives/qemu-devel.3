Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF69F109C057
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2026 19:32:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5TxK-0006ip-Ol; Wed, 25 Mar 2026 15:31:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1w5TxJ-0006iY-Hq; Wed, 25 Mar 2026 15:31:53 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1w5TxH-0001Ko-UR; Wed, 25 Mar 2026 15:31:53 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62PDwp5I1479684; Wed, 25 Mar 2026 19:31:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=TD4dH3
 7L7akavWJ1r7yKmGTebYljhEwS99oZC5qxLIs=; b=Kvm8C1J9GS6OQvGfBa+q8L
 e3ZqDN5RF39sQ3w/EjONFDbSHovlo41qu3x/Y65djwHwe7mInZ0Atrxvd0YIfQ8t
 Xg4dSzAzqe0u+lgl3hH7auOMoNV9U17DBDnnmD8R/Cwso7/t2MJb/q3tmSoQSRZ5
 Ps+w+xt/F8EKCuzdHbqwgOQVU6IbtpNBzLGWZu1S8bNA/sVAH+/jEleJeTVUCFYV
 eQEzCsqDW3mXtDmDcsZB4nAmOeM8pxQEaNF+VP3VBtcgq/Ok9kDZRYg/HvzXRmxL
 oa4Zb4by2z9Pdp/+ZYMNcVB97nqft8yJectnyQLyjc+WjUBgajkVnfAbqg2iE07w
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1kxqj5sq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 25 Mar 2026 19:31:44 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62PFjeAR008745;
 Wed, 25 Mar 2026 19:31:43 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d26nnr0bf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 25 Mar 2026 19:31:43 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 62PJVgrr26280676
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 25 Mar 2026 19:31:42 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 217B358043;
 Wed, 25 Mar 2026 19:31:42 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3E7F35805D;
 Wed, 25 Mar 2026 19:31:41 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 25 Mar 2026 19:31:41 +0000 (GMT)
Message-ID: <c6830a19-c275-4a83-bb17-4430680b3d54@linux.ibm.com>
Date: Wed, 25 Mar 2026 15:31:40 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] docs/specs/tpm: document PPI support on ARM64 virt
To: Mohammadfaiz Bawa <mbawa@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20260324-tpm-tis-sysbus-ppi-v1-0-e59175210954@redhat.com>
 <20260324-tpm-tis-sysbus-ppi-v1-1-e59175210954@redhat.com>
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20260324-tpm-tis-sysbus-ppi-v1-1-e59175210954@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: 47YVcLOGHnp2JyQq7Vcf4FatECr5q9rG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDE0MSBTYWx0ZWRfXwweyqTsYRf3f
 RSLAeyVuxpmmHACdjZhFK6LifU4xDy2h3bGHI1MPKPs3LnRRTtkoMHKmUN07Ynkt74cfCNMB+JF
 yVWYf25VXCNmwSMXrPBb29YPLduS5EYxqF1ZKzCQoahbfAki6lK/WXxwTHFH1sGUYm8zt9C50oz
 18/yJZzkVeQHaeP+S/6ph0EkDBoaXj+b85HuGdhAwAhOgyldKX0zTz9rv6w5rAbI8D3y7uHBycW
 4JHmmRPE/NDipWX2Gfw2aYqIwkRv2gNpXO3tSAe3cxOF/yyiAwszErDFiMBYuut1qMIS+invcdU
 VPPWvYnHOylBMusQ5XMH9i27tt8dadr6AGTxtzmrfeND5MR5w9ugPceGdix+yrCE/s7pisTh3qT
 IevU3JqzjoS5RfFCFS/DvXWbPf2HIQyvfPfDuWCBgdhkiSgVNQWunVk9LGmVsW60Qm1r5uD6FEv
 yHjrV42CRKUXPqRbQog==
X-Authority-Analysis: v=2.4 cv=bLEb4f+Z c=1 sm=1 tr=0 ts=69c43820 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=20KFwNOVAAAA:8
 a=VnNF1IyMAAAA:8 a=EK3RDUQIZtOXZSihsbcA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: gt-jLwj4XFiEjvuKpUmq7fsX2mrlfF2c
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-25_05,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1011 phishscore=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603250141
Received-SPF: pass client-ip=148.163.156.1; envelope-from=stefanb@linux.ibm.com;
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



On 3/24/26 3:10 AM, Mohammadfaiz Bawa wrote:
> Document that tpm-tis-device on the ARM virt machine supports PPI
> with dynamically allocated MMIO via the platform bus, unlike x86
> where PPI is at the fixed address 0xFED45000.
> 
> Also add hw/arm/virt-acpi-build.c and hw/acpi/tpm.c to the list
> of files related to TPM ACPI tables.
> 
> Signed-off-by: Mohammadfaiz Bawa <mbawa@redhat.com>
> ---
>   docs/specs/tpm.rst | 22 ++++++++++++++++++++++
>   1 file changed, 22 insertions(+)
> 
> diff --git a/docs/specs/tpm.rst b/docs/specs/tpm.rst
> index b630a351b4f77a8d2512f22446d00a4d674c7777..63cc0b68cd79d64138d4dd05ae158430c6a74643 100644
> --- a/docs/specs/tpm.rst
> +++ b/docs/specs/tpm.rst
> @@ -187,8 +187,30 @@ The location of the table is given by the fw_cfg ``tpmppi_address``
>   field.  The PPI memory region size is 0x400 (``TPM_PPI_ADDR_SIZE``) to
>   leave enough room for future updates.
> 
> +PPI on ARM64 virt
> +-----------------
> +
> +The ARM virt machine supports PPI for ``tpm-tis-device`` as defined
> +in the `PPI specification`_.
> +
> +Unlike the x86 TIS device where the PPI memory region is mapped at
> +the fixed address ``0xFED45000`` (within the TIS MMIO range), the
> +ARM64 sysbus device registers PPI memory as a second MMIO region
> +on the platform bus. The platform bus assigns the guest physical
> +address dynamically at device plug time. The ACPI ``_DSM`` method
> +and PPI operation regions reference this dynamically resolved
> +address.
> +
> +PPI is enabled by default and can be controlled with the ``ppi``
> +property (e.g. ``-device tpm-tis-device,tpmdev=tpm0,ppi=on``).
> +Without PPI support, guest operating systems such as Windows 11
> +ARM64 will log errors when attempting to query TPM Physical
> +Presence capabilities via the ACPI ``_DSM`` method.

I remember having played around with TPM for QEMU on ARM64 (Raspberry 
5(?)) a while ago and had the impression that there was something 
related to caching that prevented the MMIO interface from working 
correctly and Peter may have confirmed this back then on IRC .. I am not 
sure what exactly it was that didn't work correctly when run natively on 
ARM hardware. It worked well when run in CPU emulation on x86_64 for 
example. So I am wondering whether there is a minimum requirement for an 
ARM CPU or ARM CPU features related to caching that someone needs to 
know about to be able to use TPM TIS successfully? If so, it would 
probably be good to mention it here as well. If you know.

Otherwise this looks good to me.

> +
>   QEMU files related to TPM ACPI tables:
>    - ``hw/i386/acpi-build.c``
> + - ``hw/arm/virt-acpi-build.c``
> + - ``hw/acpi/tpm.c``
>    - ``include/hw/acpi/tpm.h``
> 
>   TPM backend devices
> 

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>


