Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 195EEFD875E
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 13:18:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2UJU-0007Ce-RX; Tue, 17 Mar 2026 09:18:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1w2UJT-0007Au-78; Tue, 17 Mar 2026 09:18:23 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1w2UJR-0002bF-4B; Tue, 17 Mar 2026 09:18:22 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62H6EaN5935245; Tue, 17 Mar 2026 13:18:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=f2pkwI
 Cei8ihQBpjgwhy0//qZZcea3XK4yVrk85wsu4=; b=tAO6bPx3tRrqKW/+3uc+mI
 Gnf44npVUChotCReWaSVgwTe3BBp2XVtMOXZfMglwZ2c/l65CMu3XapAD+7oOIzk
 s61DaJGp8PU4IbcA9X1RYnBeXiwjDvG1l46M2dePgMxVtLa69jImm1LstolQBRkv
 zx4qRKch+5H8jvs0t710Jg9O96KFXCqEtvYpiWcGnea8aPEUZv+zUkxZd5+QRLqt
 TIbhuq1/QHBMgi/ZbvSSs63IlrQhmz/frhtqB8ef/afaX4Np3YZxZNRe2ww/fG0q
 a0+Zh4x744uHLJExRXOLZKtMf0U4L+Js9G35KMdBGPh6e0c8HTWiljkbhx6cXiSg
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvy64mxhe-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 17 Mar 2026 13:18:14 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62HC04Of015676;
 Tue, 17 Mar 2026 13:18:13 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cwk0n99n0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 17 Mar 2026 13:18:13 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 62HDIDP849676688
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 17 Mar 2026 13:18:13 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 01AE758056;
 Tue, 17 Mar 2026 13:18:13 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6B48858052;
 Tue, 17 Mar 2026 13:18:12 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 17 Mar 2026 13:18:12 +0000 (GMT)
Message-ID: <61c47abc-d314-47a3-b595-88c6ac51e77f@linux.ibm.com>
Date: Tue, 17 Mar 2026 09:18:11 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/5] hw/tpm: Factor tpm_ppi_enabled() out
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20260317120241.16320-1-philmd@linaro.org>
 <20260317120241.16320-2-philmd@linaro.org>
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20260317120241.16320-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: qHLp6B8XuFfmMFGmoHFnQsDOxHoZ03LD
X-Proofpoint-GUID: ocfbbJveag6pUswRjLTiNXP-LqmkhrGo
X-Authority-Analysis: v=2.4 cv=KYnfcAYD c=1 sm=1 tr=0 ts=69b95497 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=KKAkSRfTAAAA:8
 a=VnNF1IyMAAAA:8 a=xDE3yReFXdl_idrlB1cA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE3MDExNyBTYWx0ZWRfXzAQMQG90wfqy
 +f+H8R5pcpwPSjK2WntfhhJ7cdGF255LOb/m76c+zrXvxvY9A4ZQ1BTC6cOLqNUZThomIGUuoH7
 PQWrWWgdi9iMDmDzVuhqx/n8gK+P8TNyWkjmxZid7Y+YVf3at7HCsfKPppsHx36n6uUAioTmbCu
 sxme4LNIlOi7QMe4ZZ2mv1Gw8DSYqmqwlQ9NDN1j0fCkaVroo+P8Whf6qSwkQUdOy4tqnVBG2jk
 TSuVQ25G/wyWYMWvFEE9qcd85EHl2Y09tF2yusp7DSFKwQ1vkv6sYWFY21qfhP35hZomwihXj3L
 f0eCooaMlKo49as0eE+RKobbQY4KY2wtJ7EL0uNVOh0w1J5/yx0uDp9HIxqlJ+dHhCTIyfUZWfJ
 sau4lMEb7pxUG/SwtEPpC6HJIwNu1sb8tWPuAdyxOJn8Zcr9JVkYK/jXpPdjzI47EzEqvmibinE
 FgkvIUwITJeBSXmQStg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-17_01,2026-03-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 spamscore=0 impostorscore=0 malwarescore=0 adultscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603170117
Received-SPF: pass client-ip=148.163.156.1; envelope-from=stefanb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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



On 3/17/26 8:02 AM, Philippe Mathieu-Daudé wrote:
> Factor tpm_ppi_enabled() out before modifying it in a unique place.

Factor-out ...

> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/system/tpm.h | 9 +++++++++
>   hw/acpi/tpm.c        | 2 +-
>   hw/i386/acpi-build.c | 2 +-
>   3 files changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/include/system/tpm.h b/include/system/tpm.h
> index 1ee568b3b62..b90dd4e8cb0 100644
> --- a/include/system/tpm.h
> +++ b/include/system/tpm.h
> @@ -13,6 +13,7 @@
>   #define QEMU_TPM_H
> 
>   #include "qapi/qapi-types-tpm.h"
> +#include "qapi/error.h"
>   #include "qom/object.h"
> 
>   #ifdef CONFIG_TPM
> @@ -78,6 +79,14 @@ static inline TPMVersion tpm_get_version(TPMIf *ti)
>       return TPM_IF_GET_CLASS(ti)->get_version(ti);
>   }
> 
> +static inline bool tpm_ppi_enabled(TPMIf *ti)
> +{
> +    if (!ti) {
> +        return false;
> +    }
> +    return object_property_get_bool(OBJECT(ti), "ppi", &error_abort);
> +}
> +
>   #else /* CONFIG_TPM */
> 
>   #define tpm_init()  (0)
> diff --git a/hw/acpi/tpm.c b/hw/acpi/tpm.c
> index cdc02275365..5fe95f2e3f1 100644
> --- a/hw/acpi/tpm.c
> +++ b/hw/acpi/tpm.c
> @@ -25,7 +25,7 @@ void tpm_build_ppi_acpi(TPMIf *tpm, Aml *dev)
>       Aml *method, *field, *ifctx, *ifctx2, *ifctx3, *func_mask,
>           *not_implemented, *pak, *tpm2, *tpm3, *pprm, *pprq, *zero, *one;
> 
> -    if (!object_property_get_bool(OBJECT(tpm), "ppi", &error_abort)) {
> +    if (!tpm_ppi_enabled(tpm)) {
>           return;
>       }
> 
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index f622b91b76a..4f01e2c476e 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -2218,7 +2218,7 @@ void acpi_setup(void)
>                       tables.tcpalog->data, acpi_data_len(tables.tcpalog));
> 
>       tpm = tpm_find();
> -    if (tpm && object_property_get_bool(OBJECT(tpm), "ppi", &error_abort)) {
> +    if (tpm_ppi_enabled(tpm)) {
>           tpm_config = (FwCfgTPMConfig) {
>               .tpmppi_address = cpu_to_le32(TPM_PPI_ADDR_BASE),
>               .tpm_version = tpm_get_version(tpm),

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>


