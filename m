Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABFEBC982C1
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 17:06:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6t59-0007sY-VZ; Wed, 16 Sep 2026 13:06:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x6t52-0007ry-Sb
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 13:05:58 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x6t50-0005oX-Ro
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 13:05:56 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68GG5Kp33597313
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 17:05:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 fb9P8lX6daSz/0lLb/ZG0I08hgcknV/o9ScgoJI+uF8=; b=nnrHG/sUwxC8I51Y
 M9tXwi/ntnDaGBfXpaH6+/YbfZjaaSuThPNfhnDPm3KmyilKkpYDiJl+MZ51jsP1
 +kCKVJXMuoJbTPnlgHIvGSZAdCUTh96QqTA3X/Pl7d8fOuK71XA1pbkDdhInwH1R
 QSVp2DaZXCHyYMhW2RMpbt623MShnSW1gYCuq/ZNIp9nXqGeoynliY3OXSUn7nhr
 B9ew1u2k/RVfR/0E0EgML8tVnfS6s83QzIov64bARhwzm4jf5PKPnDwV9Mh+52Fq
 vAoBRrq6Iqg1rrMgV5ZiOzMxRXbZp6hA4036Zu1YJMmL5ALUz6bzcywhfIvHbBIA
 F3kuzw==
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gqxay8bae-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 17:05:52 +0000 (GMT)
Received: by mail-oo1-f69.google.com with SMTP id
 006d021491bc7-6c1bb6ec882so6201692eaf.2
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 10:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789578352; x=1790183152; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=fb9P8lX6daSz/0lLb/ZG0I08hgcknV/o9ScgoJI+uF8=;
 b=Q5DbUr+nCFiDe2KneFbYaN9wvcjxSuqNMgpzwTDsK1lF3txTbXGALx53rsMYwKJFbz
 Xp8iY2Z81fKlPiYSvYhcdDV9h/at+ZPgc1aVFPs6gODoFQtzLolnHLG2NaFi2tut4Smh
 dpuBwqJIbxyrW6gl7WkxVrKQ+ftmd4cmEyZZGNDSWUPeHPJud50gCF1xiOTYp7Z6c5QA
 XxDtf2xK87BYIg9HT20RPsklK1wfCI/oo5Y4f3DLKuGIqiwhA5vM0arhZu91hKxvCcZM
 gmyws9q+vzvgHWOw1lQ9edf5B8Q4d4IWpw0WNaSk9/jKfASzFKc3AB3XYQdgpAxLC5dO
 +5bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789578352; x=1790183152;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fb9P8lX6daSz/0lLb/ZG0I08hgcknV/o9ScgoJI+uF8=;
 b=e9OUpVHXiqYQm8JjNBzUHh8odgbkwUtb27H35u8qmEqnn+xV7cnz3h6B2vgtlNx/2k
 cYdi5tXrzEU64p6MUf9JmgGjLYf6he0ZH+xq7fgOYWIyqRueT1DVEhOw1ZFk5XnZ2mBq
 ASaOZ+q3suWlZ5aCnT81TJpdZVoWrQO8JQR6PCdMwXFzn5Csj4mAUBIE1yq4Hb7Y6n1B
 3UYxRfG/lvcG3NVB6VD9zbCUindCE8N09yalOWJuxjwm4SRkwtmlIOc+v7cXsCPPvyrf
 OAQqPq1bS+YGuijUxhETokpC7EfShRiYsJ12g1k0plYCaIrL6CYV83CmG4DUGB85P/Zc
 Y7aQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxA4p6Mfye0l5wNOl+Kg4Ki6Z+Ja/g6xKBsRij4GtVcQYkL9P0ptrjV90e1pPnsp/4T/SSNIEJhpJvU@nongnu.org
X-Gm-Message-State: AFuF++kREDCpyQSchOz3sU0I9PZgTAYPuyzslDdX1/Riyx0TSrLazvsj
 F9khfDYLxyzznPSwYIWkEcJxXUL+SkpqmMX5vGQrMsL8t9BV3QY3gZzjt+BJF43VDVQJMCZ8rnR
 2CBh5Yz07vHf9x7sxkIlbQQC4P9NROn2X5W+Q2ND5+A//4xC2+16GJ+HUtw==
X-Gm-Gg: AYBFou0h1N5oE8RyDinPSBZOylHSXOXlTUTYzsBUQapKBmd5BxafvKAP9aoE7JkzF+p
 86iIjuZLnA2MW5bMM6zMCgeloUjyuE2nH898G1bkrwTTnQhRYrdkdOglU+MLJ4DzB0dfPDx7Znh
 +pwYuRNopeF/FEMGig5DQTdsq2C4heC0AB0JMi+Q3ClVmuaiWGx4Xz40PqoXSbkO100fyvEVMm8
 p8D96ScgUgzS9+j1y9gC9qBnjctYHGuqYezHMHivjmj5wLW38hitSU8tGN1erwocSVkcV4DQsVG
 WeQP8hPwx6NP1YHleNo2XjvveyyhRVcet4hXsrvBtNGOsXhO9h5CAOwGr2A3ANp/40VVjIXNMJG
 CKskUXl2qArS4zdZmYHTDOq3X+sT6vTlrehfe2PDqlVmu6X+AUhDdcGEKrtonWvDTZ4QR
X-Received: by 2002:a05:6820:2010:b0:6be:47ed:f3f8 with SMTP id
 006d021491bc7-6c7ce737ecdmr3350547eaf.0.1789578351633; 
 Wed, 16 Sep 2026 10:05:51 -0700 (PDT)
X-Received: by 2002:a05:6820:2010:b0:6be:47ed:f3f8 with SMTP id
 006d021491bc7-6c7ce737ecdmr3350527eaf.0.1789578351138; 
 Wed, 16 Sep 2026 10:05:51 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33bf5e40494sm8920867eec.15.2026.09.16.10.05.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Sep 2026 10:05:50 -0700 (PDT)
Message-ID: <29bb6431-5c1b-4324-bc7d-e1daa17a5b43@oss.qualcomm.com>
Date: Wed, 16 Sep 2026 10:05:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 11/12] hw/riscv: Filter for 32- or 64-bit machine types
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, daniel.barboza@oss.qualcomm.com,
 philmd@oss.qualcomm.com, palmer@dabbelt.com, alistair.francis@wdc.com
References: <20260916-hw-riscv-cpu-int-v4-0-babc367b60f5@rev.ng>
 <20260916-hw-riscv-cpu-int-v4-11-babc367b60f5@rev.ng>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260916-hw-riscv-cpu-int-v4-11-babc367b60f5@rev.ng>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDIzNCBTYWx0ZWRfX/8kgegy+3YKV
 EsfkBSna9EbviMZFLgfFYaadY8TLaU0fSRCj++Gf0YEQ2SRviUIvJ4fl0tTYhLHWpn7EjE7GoOP
 ib5buyOcq2Vg/v465Y1x0kQfDHoHpmu8rQzJnPFvk20OXt5ufMBseFfhd2D1nUle5CPR40pNa+w
 VxHMKEuc0+yPGj60EwCDO3/Aml5SbljtrzHaEh8F3EIR0vsHc0kKEKjNocaygKL9+8rmqKfciaS
 tTGbBbaOqw03hWHOHvc7HBMD9lLs42l9WMTMRQ+OWHqfWylNaVWtVq791YoaO1bmmI1co65D+3x
 796xxstlb39MYNh9LWBXEN6MFU561Sd9awVsuYmXi07vA3nbu+frNcfge2mBWL8hXoXih6LRoyu
 LPq0TPH8Oiwk4FIkj96DyIZL2JbXoVZib88pOvmUWba711YAdEn/NgCra2KZya6m+q11YXFXgkM
 2AkjMGpl64g/XscQcKw==
X-Proofpoint-GUID: 7UmFIqm0WdfL6RjQDh6ugQnanceYFqoU
X-Authority-Analysis: v=2.4 cv=EoJHPicA c=1 sm=1 tr=0 ts=6aaacc70 cx=c_pps
 a=lVi5GcDxkcJcfCmEjVJoaw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=sBAz_p5i3AJIOkoOCmUA:9 a=QEXdDO2ut3YA:10 a=rBiNkAWo9uy_4UTK5NWh:22
X-Proofpoint-ORIG-GUID: 7UmFIqm0WdfL6RjQDh6ugQnanceYFqoU
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDIzNCBTYWx0ZWRfXwBn0ZMSrdt5c
 XiSsG3qHaOH+RXZs79yrB85VbF4+/EPDTUD+QTBLOYHeUlGzWUoWirUKVpOV1OKLcTZlgiEpkPD
 LzI+S7jl9518quHwLrRFroQfzSbxJcc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-16_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0
 impostorscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609160234
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 9/16/2026 2:19 AM, Anton Johansson wrote:
> Filters for 32- or 64-bit machine types using TypeInfo::is_available,
> machines available for both 32-bit and 64-bit (amd-microblaze-v-generic,
> sifive-[e|u], spike, virt) leave the field unset.
> 
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>  hw/riscv/boston-aia.c      | 3 ++-
>  hw/riscv/k230.c            | 3 +++
>  hw/riscv/microchip_pfsoc.c | 3 +++
>  hw/riscv/opentitan.c       | 3 +++
>  hw/riscv/shakti_c.c        | 3 +++
>  hw/riscv/tt_atlantis.c     | 3 +++
>  hw/riscv/xiangshan_kmh.c   | 3 +++
>  7 files changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/riscv/boston-aia.c b/hw/riscv/boston-aia.c
> index b90da096ea..e8371ff1f1 100644
> --- a/hw/riscv/boston-aia.c
> +++ b/hw/riscv/boston-aia.c
> @@ -10,6 +10,7 @@
>   */
>  
>  #include "qemu/osdep.h"
> +#include "qemu/target-info.h"
>  #include "qemu/units.h"
>  
>  #include "hw/core/boards.h"
> @@ -473,4 +474,4 @@ static void boston_mach_class_init(MachineClass *mc)
>      mc->default_cpu_type = TYPE_RISCV_CPU_MIPS_P8700;
>  }
>  
> -DEFINE_MACHINE("boston-aia", boston_mach_class_init)
> +DEFINE_MACHINE_WITH_GUARD("boston-aia", boston_mach_class_init, target_riscv64)

Convert that to a "full" declaration, and add is_available on the way.

> diff --git a/hw/riscv/k230.c b/hw/riscv/k230.c
> index 1e4ca38579..43b6ae6d2f 100644
> --- a/hw/riscv/k230.c
> +++ b/hw/riscv/k230.c
> @@ -17,6 +17,7 @@
>  #include "cpu-qom.h"
>  #include "qemu/cutils.h"
>  #include "qemu/error-report.h"
> +#include "qemu/target-info.h"
>  #include "qapi/error.h"
>  #include "system/device_tree.h"
>  #include "system/system.h"
> @@ -420,6 +421,7 @@ static const TypeInfo k230_soc_type_info = {
>      .instance_size = sizeof(K230SoCState),
>      .instance_init = k230_soc_init,
>      .class_init = k230_soc_class_init,
> +    .is_available = target_riscv64,
>  };
>  
>  static void k230_soc_register_types(void)
> @@ -558,6 +560,7 @@ static const TypeInfo k230_machine_typeinfo = {
>      .class_init = k230_machine_class_init,
>      .instance_init = k230_machine_instance_init,
>      .instance_size = sizeof(K230MachineState),
> +    .is_available = target_riscv64,
>  };
>  
>  static void k230_machine_init_register_types(void)
> diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
> index edd29626fa..b2991e5a71 100644
> --- a/hw/riscv/microchip_pfsoc.c
> +++ b/hw/riscv/microchip_pfsoc.c
> @@ -38,6 +38,7 @@
>  #include "qemu/error-report.h"
>  #include "qemu/units.h"
>  #include "qemu/cutils.h"
> +#include "qemu/target-info.h"
>  #include "qapi/error.h"
>  #include "qapi/visitor.h"
>  #include "hw/core/boards.h"
> @@ -504,6 +505,7 @@ static const TypeInfo microchip_pfsoc_soc_type_info = {
>      .instance_size = sizeof(MicrochipPFSoCState),
>      .instance_init = microchip_pfsoc_soc_instance_init,
>      .class_init = microchip_pfsoc_soc_class_init,
> +    .is_available = target_riscv64,
>  };
>  
>  static void microchip_pfsoc_soc_register_types(void)
> @@ -757,6 +759,7 @@ static const TypeInfo microchip_icicle_kit_machine_typeinfo = {
>      .class_init = microchip_icicle_kit_machine_class_init,
>      .instance_init = microchip_icicle_kit_machine_instance_init,
>      .instance_size = sizeof(MicrochipIcicleKitState),
> +    .is_available = target_riscv64,
>  };
>  
>  static void microchip_icicle_kit_machine_init_register_types(void)
> diff --git a/hw/riscv/opentitan.c b/hw/riscv/opentitan.c
> index 8cd660dd41..c3a563db92 100644
> --- a/hw/riscv/opentitan.c
> +++ b/hw/riscv/opentitan.c
> @@ -20,6 +20,7 @@
>  
>  #include "qemu/osdep.h"
>  #include "qemu/cutils.h"
> +#include "qemu/target-info.h"
>  #include "hw/riscv/opentitan.h"
>  #include "qapi/error.h"
>  #include "qemu/error-report.h"
> @@ -332,11 +333,13 @@ static const TypeInfo open_titan_types[] = {
>          .instance_size  = sizeof(LowRISCIbexSoCState),
>          .instance_init  = lowrisc_ibex_soc_init,
>          .class_init     = lowrisc_ibex_soc_class_init,
> +        .is_available   = target_riscv32,
>      }, {
>          .name           = TYPE_OPENTITAN_MACHINE,
>          .parent         = TYPE_MACHINE,
>          .instance_size  = sizeof(OpenTitanState),
>          .class_init     = opentitan_machine_class_init,
> +        .is_available   = target_riscv32,
>      }
>  };
>  
> diff --git a/hw/riscv/shakti_c.c b/hw/riscv/shakti_c.c
> index 3b6efd25be..76cfe30918 100644
> --- a/hw/riscv/shakti_c.c
> +++ b/hw/riscv/shakti_c.c
> @@ -21,6 +21,7 @@
>  #include "hw/riscv/shakti_c.h"
>  #include "qapi/error.h"
>  #include "qemu/error-report.h"
> +#include "qemu/target-info.h"
>  #include "hw/intc/sifive_plic.h"
>  #include "hw/intc/riscv_aclint.h"
>  #include "system/system.h"
> @@ -97,6 +98,7 @@ static const TypeInfo shakti_c_machine_type_info = {
>      .class_init = shakti_c_machine_class_init,
>      .instance_init = shakti_c_machine_instance_init,
>      .instance_size = sizeof(ShaktiCMachineState),
> +    .is_available = target_riscv64,
>  };
>  
>  static void shakti_c_machine_type_info_register(void)
> @@ -186,6 +188,7 @@ static const TypeInfo shakti_c_type_info = {
>      .class_init = shakti_c_soc_class_init,
>      .instance_init = shakti_c_soc_instance_init,
>      .instance_size = sizeof(ShaktiCSoCState),
> +    .is_available = target_riscv64,
>  };
>  
>  static void shakti_c_type_info_register(void)
> diff --git a/hw/riscv/tt_atlantis.c b/hw/riscv/tt_atlantis.c
> index b2333e7f6a..f54eb942f3 100644
> --- a/hw/riscv/tt_atlantis.c
> +++ b/hw/riscv/tt_atlantis.c
> @@ -11,6 +11,7 @@
>  #include "qemu/cutils.h"
>  #include "qemu/error-report.h"
>  #include "qemu/guest-random.h"
> +#include "qemu/target-info.h"
>  #include "qemu/units.h"
>  
>  #include "hw/core/boards.h"
> @@ -694,11 +695,13 @@ static const TypeInfo tt_atlantis_types[] = {
>          .instance_size = sizeof(TTAtlantisSoCState),
>          .instance_init = tt_atlantis_soc_init,
>          .class_init = tt_atlantis_soc_class_init,
> +        .is_available = target_riscv64,
>      }, {
>          .name       = MACHINE_TYPE_NAME("tt-atlantis"),
>          .parent     = TYPE_MACHINE,
>          .class_init = tt_atlantis_machine_class_init,
>          .instance_size = sizeof(TTAtlantisState),
> +        .is_available = target_riscv64,
>      },
>  };
>  
> diff --git a/hw/riscv/xiangshan_kmh.c b/hw/riscv/xiangshan_kmh.c
> index a234c5f352..f2383c5399 100644
> --- a/hw/riscv/xiangshan_kmh.c
> +++ b/hw/riscv/xiangshan_kmh.c
> @@ -30,6 +30,7 @@
>   */
>  
>  #include "qemu/osdep.h"
> +#include "qemu/target-info.h"
>  #include "qapi/error.h"
>  #include "system/address-spaces.h"
>  #include "hw/core/boards.h"
> @@ -157,6 +158,7 @@ static const TypeInfo xiangshan_kmh_soc_info = {
>      .instance_size = sizeof(XiangshanKmhSoCState),
>      .instance_init = xiangshan_kmh_soc_instance_init,
>      .class_init = xiangshan_kmh_soc_class_init,
> +    .is_available = target_riscv64,
>  };
>  
>  static void xiangshan_kmh_soc_register_types(void)
> @@ -220,6 +222,7 @@ static const TypeInfo xiangshan_kmh_machine_info = {
>      .parent = TYPE_MACHINE,
>      .instance_size = sizeof(XiangshanKmhState),
>      .class_init = xiangshan_kmh_machine_class_init,
> +    .is_available = target_riscv64,
>  };
>  
>  static void xiangshan_kmh_machine_register_types(void)
> 


