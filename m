Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91BEB109C057
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2026 19:33:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5TyD-0006w4-1D; Wed, 25 Mar 2026 15:32:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1w5TyB-0006vJ-31; Wed, 25 Mar 2026 15:32:47 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1w5Ty7-0001S2-5S; Wed, 25 Mar 2026 15:32:46 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62PCNxPQ657656; Wed, 25 Mar 2026 19:32:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=34ydXR
 YqCLRwMno4Cnr0qkhnJ/dEOZhaVwXaLSC8in8=; b=ZhxN0q0gHdHY+iK8GS1NH5
 l3mjjYY0xyRdlIG/0S7oSkR6Gn+lPwW0IHx2xAuuAn5ztNggogUGDy7f6wDbb0Bb
 HGMFzBxvFQVvb3tAzE0bsXIEupqr+r1OOFesLtWpYmfzJzjGhyjw/Wr0y7Hkl1Fu
 TBOOAYDXrwaZrDeZV+kSShC3LNw/1CTpwdDGt9QpSaqxvA4gGeBnF8IXQ+giyyBD
 MuhMB2FiP4dKzpn/qAhqy1FTxL+kJpRm5LUTI9SPd1Kw0Px65Pb9kr6HxcVW3rhY
 uxVppClfm8WRxMGrlH7gltascLwcu+DppIA8Pj7yci9Q4FcMG51ettSN0Rus3/PA
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1kumsamk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 25 Mar 2026 19:32:40 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62PGYWKK004387;
 Wed, 25 Mar 2026 19:32:39 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d28c27qqy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 25 Mar 2026 19:32:39 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 62PJWdkO33358570
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 25 Mar 2026 19:32:39 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F090E58059;
 Wed, 25 Mar 2026 19:32:38 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0DE2558043;
 Wed, 25 Mar 2026 19:32:38 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 25 Mar 2026 19:32:37 +0000 (GMT)
Message-ID: <dbb28296-a94c-450e-9f8a-c24f47f051f2@linux.ibm.com>
Date: Wed, 25 Mar 2026 15:32:37 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] hw/acpi/tpm: parameterize PPI base address in
 tpm_build_ppi_acpi
To: Mohammadfaiz Bawa <mbawa@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20260324-tpm-tis-sysbus-ppi-v1-0-e59175210954@redhat.com>
 <20260324-tpm-tis-sysbus-ppi-v1-2-e59175210954@redhat.com>
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20260324-tpm-tis-sysbus-ppi-v1-2-e59175210954@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: 0heRIMSjjQzV2ns-f83UfdakE-zO5s7x
X-Proofpoint-ORIG-GUID: kEJdK7RxNywa1_u7BhWmcVjZzLQ_Vv72
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDE0MSBTYWx0ZWRfX23UTJ83OaSbS
 cyPps4HrKThI8Vpi8fbF7+Jbxi45LeNRMv/CEbOvK8gIC7JQuwGfrHmrfQ9g5LcmmI/y7/od/LE
 WR8Up3Fp8zZLduCHH0CmVjApLVohiCzlNdybWW9ceul8ydNK9uEqVh/wZy9VNOzASWqf5GHl61B
 ScGLVWv/mP921d5KRHt6y9GClJgs3ZPUDdmmaFx2gWjp+eOYBnVm9fHGGfa3KW9ZWMtIC2VPghg
 hQk/OWNOiDNhepwddlgbWxt99EQiJ/S58gGMfXo0wfrAW+h0agDebxdtplP/U7TNcmBmBvvhQ55
 4E/61EDrx1HxVnzireudyndscTcUoAVG3oUzd70BR6LnVe5R8iWJU9Jf/ajn4i+Z3gJxDIEfQkp
 9iGnYV+uyRRClSlbrRQTC6JsvZlIL84pFUsHqARFjwVx/MpQB/wXzrnhBJA7PURtY3O9aDTDicx
 YEwVismHohUjTqGXjNQ==
X-Authority-Analysis: v=2.4 cv=KbXfcAYD c=1 sm=1 tr=0 ts=69c43858 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=20KFwNOVAAAA:8
 a=VnNF1IyMAAAA:8 a=taaxXBm9TxYW6E4m07QA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-25_05,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 malwarescore=0 adultscore=0 clxscore=1015
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603250141
Received-SPF: pass client-ip=148.163.158.5; envelope-from=stefanb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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
> Add a ppi_base parameter to tpm_build_ppi_acpi() instead of
> hardcoding TPM_PPI_ADDR_BASE. This prepares for ARM64 support where
> PPI memory is dynamically allocated by the platform bus and the
> address is not known at compile time.
> 
> Update the x86 ISA TIS caller to pass TPM_PPI_ADDR_BASE explicitly.
> No behavioral change.
> 
> Signed-off-by: Mohammadfaiz Bawa <mbawa@redhat.com>
> ---
>   hw/acpi/tpm.c         | 8 ++++----
>   hw/tpm/tpm_tis_isa.c  | 2 +-
>   include/hw/acpi/tpm.h | 3 ++-
>   3 files changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/acpi/tpm.c b/hw/acpi/tpm.c
> index cdc022753659af102e56ea4148423b94de1531f6..c4ff2f8cb836c16b00f70865bf55781d5c402aa2 100644
> --- a/hw/acpi/tpm.c
> +++ b/hw/acpi/tpm.c
> @@ -20,7 +20,7 @@
>   #include "qapi/error.h"
>   #include "hw/acpi/tpm.h"
>   
> -void tpm_build_ppi_acpi(TPMIf *tpm, Aml *dev)
> +void tpm_build_ppi_acpi(TPMIf *tpm, Aml *dev, hwaddr ppi_base)
>   {
>       Aml *method, *field, *ifctx, *ifctx2, *ifctx3, *func_mask,
>           *not_implemented, *pak, *tpm2, *tpm3, *pprm, *pprq, *zero, *one;
> @@ -40,7 +40,7 @@ void tpm_build_ppi_acpi(TPMIf *tpm, Aml *dev)
>        */
>       aml_append(dev,
>                  aml_operation_region("TPP2", AML_SYSTEM_MEMORY,
> -                                    aml_int(TPM_PPI_ADDR_BASE + 0x100),
> +                                    aml_int(ppi_base + 0x100),
>                                       0x5A));
>       field = aml_field("TPP2", AML_ANY_ACC, AML_NOLOCK, AML_PRESERVE);
>       aml_append(field, aml_named_field("PPIN", 8));
> @@ -56,7 +56,7 @@ void tpm_build_ppi_acpi(TPMIf *tpm, Aml *dev)
>       aml_append(dev,
>                  aml_operation_region(
>                      "TPP3", AML_SYSTEM_MEMORY,
> -                   aml_int(TPM_PPI_ADDR_BASE +
> +                   aml_int(ppi_base +
>                              0x15a /* movv, docs/specs/tpm.rst */),
>                              0x1));
>       field = aml_field("TPP3", AML_BYTE_ACC, AML_NOLOCK, AML_PRESERVE);
> @@ -78,7 +78,7 @@ void tpm_build_ppi_acpi(TPMIf *tpm, Aml *dev)
>   
>           aml_append(method,
>               aml_operation_region("TPP1", AML_SYSTEM_MEMORY,
> -                aml_add(aml_int(TPM_PPI_ADDR_BASE), op, NULL), 0x1));
> +                aml_add(aml_int(ppi_base), op, NULL), 0x1));
>           field = aml_field("TPP1", AML_BYTE_ACC, AML_NOLOCK, AML_PRESERVE);
>           aml_append(field, aml_named_field("TPPF", 8));
>           aml_append(method, field);
> diff --git a/hw/tpm/tpm_tis_isa.c b/hw/tpm/tpm_tis_isa.c
> index 61e95434f5b824fa99f0a2aff7f151e87ea631ed..e30bef49558673f4c857c02dae059ce3361a1bc7 100644
> --- a/hw/tpm/tpm_tis_isa.c
> +++ b/hw/tpm/tpm_tis_isa.c
> @@ -162,7 +162,7 @@ static void build_tpm_tis_isa_aml(AcpiDevAmlIf *adev, Aml *scope)
>        */
>       /* aml_append(crs, aml_irq_no_flags(isadev->state.irq_num)); */
>       aml_append(dev, aml_name_decl("_CRS", crs));
> -    tpm_build_ppi_acpi(ti, dev);
> +    tpm_build_ppi_acpi(ti, dev, TPM_PPI_ADDR_BASE);
>       aml_append(scope, dev);
>   }
>   
> diff --git a/include/hw/acpi/tpm.h b/include/hw/acpi/tpm.h
> index d2bf6637c5424b92ad99f5baa938fd6cea3520bf..2ab186a7455593df205a7ffecbea2abdfdbd11d5 100644
> --- a/include/hw/acpi/tpm.h
> +++ b/include/hw/acpi/tpm.h
> @@ -20,6 +20,7 @@
>   #include "hw/core/registerfields.h"
>   #include "hw/acpi/aml-build.h"
>   #include "system/tpm.h"
> +#include "exec/hwaddr.h"
>   
>   #ifdef CONFIG_TPM
>   
> @@ -250,7 +251,7 @@ REG32(CRB_DATA_BUFFER, 0x80)
>    */
>   #define TPM_I2C_INT_ENABLE_MASK   0x0
>   
> -void tpm_build_ppi_acpi(TPMIf *tpm, Aml *dev);
> +void tpm_build_ppi_acpi(TPMIf *tpm, Aml *dev, hwaddr ppi_base);
>   
>   #endif /* CONFIG_TPM */
>   
> 


Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>


