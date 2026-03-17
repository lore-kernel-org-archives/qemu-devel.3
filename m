Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7301FFD8769
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 13:22:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2UN1-0001Aw-1y; Tue, 17 Mar 2026 09:22:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1w2UMz-0001AN-3j; Tue, 17 Mar 2026 09:22:01 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1w2UMx-0005IS-Mx; Tue, 17 Mar 2026 09:22:00 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62H30f5j646456; Tue, 17 Mar 2026 13:21:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=fLfKG6
 Gc5zOmS3nZ8oTxuQtInUCh/4IxOlVG9Tt0LqQ=; b=CV/xpRwDHmIYtjTtq6W58p
 QzrBYpGnreKGCEzExLuosP4zXqy0qFNTeQ/0NQzsTg+TITO4UA2oHz8aAs2F5e1Y
 4oZYN+f/GzVGY5yZkcfsj3LEwYtMD1cwGCtOBI6mg6aQ9c9jVA+9T9I4DtBw7dpO
 CJE5rJ4QQ5TZGMG1v1J27ZpJ60m6uMSsqOKnz4ZyX/wnVi8aXl63569FXivuPkTP
 Qg49e4X4GrXRj/Zb04dLVlTNt+keHpY4czsJAxahdsjCz2fcmLVXSEvMZKv6ZY/d
 yMImhqClnIkHfh/35qOXe6zK/nJkTly2kqxWDMHg7wE884sQvH58lMuRloz9gn1A
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvw3hvjw8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 17 Mar 2026 13:21:56 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62HB8ZXS004575;
 Tue, 17 Mar 2026 13:21:56 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cwj0s9eat-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 17 Mar 2026 13:21:56 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 62HDLt0L27853366
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 17 Mar 2026 13:21:55 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 155B258059;
 Tue, 17 Mar 2026 13:21:55 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6C68058055;
 Tue, 17 Mar 2026 13:21:54 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 17 Mar 2026 13:21:54 +0000 (GMT)
Message-ID: <3bbaa555-bc16-4626-ac3b-338f8c9fa858@linux.ibm.com>
Date: Tue, 17 Mar 2026 09:21:53 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/5] hw/tpm: Simplify tpm_ppi_enabled()
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
 <20260317120241.16320-6-philmd@linaro.org>
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20260317120241.16320-6-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: d74H3H9Szxjry9WeGswN1sHUp9y_XzTi
X-Proofpoint-ORIG-GUID: JMkp0cIm-W8UgZT7Tx_kFHokzOEaTxlS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE3MDExNyBTYWx0ZWRfX/ivXyeuJS/VC
 IT9Tl8ywo2zioCnU0DyDn7LSwduQB/8VubQBOqB5Cgaqb0bHI6wuCU41sDH68Qkq+XTquGhxD+P
 fZ/0v9SUXOm9OYiFVs7Qi4vDCHlUIbIozoxWAOPDl6+sxOWAt8uJ36qjhS+ciYDCNsvHMJ2U2KN
 6BK+gj0g5HTyhcm2cL8mGavcjnuU6tTbV+jyjbg0F6nz6i+65UzDBUcLsz807jAOyRJ+N7YqOLs
 oHJnP/4rL+KogPdJlEzqoLcXKZj3SG1524y2NyLKa0vXEVqDAaLuHanIwSKbQqZw2oBh5AB5FAw
 5vz7fMjcaLACiIq356tdZzGFf9Mh/hw+gOlIBFYNtY7K8o4S4+9ilmj58V4VTg3fwyfcusfFx7h
 sI6VLnCTVuEbFnocLaaIYevNEMNb1yo4zQoJHHHuYmOegHLQfYw38sC0pQ+JlyQV2tdKmOy2V3X
 KWLZzo088qMOhTOWlaA==
X-Authority-Analysis: v=2.4 cv=Hf8ZjyE8 c=1 sm=1 tr=0 ts=69b95575 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=KKAkSRfTAAAA:8
 a=VnNF1IyMAAAA:8 a=MXA9hOrzMfHG-bSZS98A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-17_01,2026-03-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603170117
Received-SPF: pass client-ip=148.163.158.5; envelope-from=stefanb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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
> TPM instances don't expose any "ppi" property anymore,
> remove that dead code.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/system/tpm.h | 6 +-----
>   1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/include/system/tpm.h b/include/system/tpm.h
> index 9458ad6668a..874068d19a9 100644
> --- a/include/system/tpm.h
> +++ b/include/system/tpm.h
> @@ -13,7 +13,6 @@
>   #define QEMU_TPM_H
>   
>   #include "qapi/qapi-types-tpm.h"
> -#include "qapi/error.h"
>   #include "qom/object.h"
>   
>   #ifdef CONFIG_TPM
> @@ -85,10 +84,7 @@ static inline bool tpm_ppi_enabled(TPMIf *ti)
>       if (!ti) {
>           return false;
>       }
> -    if (TPM_IF_GET_CLASS(ti)->ppi_enabled) {
> -        return true;
> -    }
> -    return object_property_get_bool(OBJECT(ti), "ppi", &error_abort);
> +    return TPM_IF_GET_CLASS(ti)->ppi_enabled;
>   }
>   
>   #else /* CONFIG_TPM */

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>


