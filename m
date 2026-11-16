Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE1AC606A322
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 21:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=XFnDIaG9;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=VolxQmQV
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT43w-0000Lu-2w; Mon, 16 Nov 2026 16:16:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xT43t-0000LP-K9
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 16:16:25 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xT43r-0000Rk-Lb
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 16:16:25 -0500
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AGJfkeD3249423
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 21:16:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 dfMeY4cL+lvlMAr0dVna0aD9Wb9mOdBrg7fIRWppBmU=; b=XFnDIaG9HvuXAk4N
 Y1PxxrnFD7e+iRa2kEVaaGJvT8qfvaf4qe0h8BlViZ3PV1Uq/ZUC0umHgSv7Gh0W
 OycRB3QaJXnnh+s32iLP1htM+bVnITtRm2YEQtCj72tPAyNVfOh64o3pUiIuCYLW
 2Q5+8sL/o9A+wE0QwKOEA505/ohQIMWu9moeJncuaVF5dQ90uLXMJtLHP2F2nqvS
 OIyn/xl6P3yKDEOaLVwlIgHDxC7cam6KRntoVzCDNq92Mozs3OuSmqi6LUbzP4vP
 kMFJf5MfSPB6Rvch+p5BDxVUNd+ELdnJjsR0PQ9IPbVVK2pdN/KcDyz2+nSTlfTs
 eMKg/w==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j00nfjca5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 21:16:20 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-1aa0fb7f157so4713978c88.0
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 13:16:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794863780; x=1795468580; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=dfMeY4cL+lvlMAr0dVna0aD9Wb9mOdBrg7fIRWppBmU=;
 b=VolxQmQV1doXqnOf2hnbh0s2X9UNv0TT13ScE9JNQx6GTFWDCm8lqNoWlVB4jI/V3+
 KZ7qQ+AJD1/852ieEMW04GlMaI+iTBeAWfaRY+bdpP3p3mjYusQfk/zTM8KOhKd78GY/
 Is/GcF0KyckbfgKG2NaR5kocVfSgfhpjk9jcDytY7cyIdXR8AbY6Y41qwAFfek8O5heE
 88x3Gqy0l0DUCRN/SxIFv9rkFxlzk/pMNWHGSbRuIoDOyMtNb8H2M8ZOfCbRKxfMyFl2
 M2A0vupoIHvn+wH+MhLiC1UFGlg8x33PIqQusktNK1+woDAPNf8yUvebSWAlrNZgzkZJ
 GqAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794863780; x=1795468580;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dfMeY4cL+lvlMAr0dVna0aD9Wb9mOdBrg7fIRWppBmU=;
 b=tTR9ESxHSxHekPTP3GL8KRnL++eW+UoXEtlpjwUbKDBhHQUIMn7dNc1s1Th2/wmr+b
 vDPtRaC4pu9octyhQjwLCnShfSJlBaislaGywNHRy5LHau9eXOKPOadyKjPnDzJZTy5Q
 bIc85Ndz5mqOotoXfutamMEiszltsXv1ITz7Wi0PFMbxJoRZ9GqIn+wsj5zAwZLFDZk3
 6P7N3a/B4TcQEToS1SEeu5Lw4CGkjfRa6m7oLbNhxdObpewfhDnJlXMD1+NOHC2uiM3a
 9zzHj1DE0fR/tQNsL03JA+ygB8R0graSpKh87bA8KnYqFFSh2Y0MgYio4vNBLHCfZgG2
 JSiw==
X-Forwarded-Encrypted: i=1;
 AL+hErGgaVNFK0A2lvpdqYy4PQMIqwOZwBE45Kf7SGDDYfVvTLLyXKTu2tL0OwUcWrNlzkPtZhR1GIf02vx0@nongnu.org
X-Gm-Message-State: APuU4Z/vu1YroFuaeK8tg2p5esFT/xfwXApDtyml59q/5CKsF6zevwD3
 vQzZcmpYLMwU6NbKLGFTMhl2N7HqxbjkbRyyxN3TxAR5SjVwyNXb/fpbzGjHBUSm9gYfzBlrQ9x
 n+XsCtNmI0TZUQ9ni2SKApWeK7aJdGONWnnuO8orHYvzDzBT7ZjgjROoAdw==
X-Gm-Gg: AYBFou2tHKMbqfO7IHS/gt/UzgcNVJ8IpVXSlnthurec03J1EFfNZ0urSeciy185+U/
 j3RP6ziVPrcDHtOBibzUx0R06dilQLgvZ9qP+LVlAMJWlc3h97YPptdpmL6z6C9GM6/e1xqWL6n
 ZP1axC11l7ZKaH6qvfCcx/3ENLlsc7QVJ7FyBfqRgCCf525bYfc+syQ3GegU8ALz0imZIQgHdGP
 /hyst3EqMTCNvJIzTNMgbmJFF+OEaDZrSrRlWXYuzd4oH4yMiHKsCnbe9pdBkdJbU+2Sylh03uc
 wE3shJ/ss5K0GjXz7RSQRkrP5GmAQtoXjZQRB1ujINLI3szM010iW/HYHJzfoUwDXbuSV91RhE1
 7Kka/thUXKR0aWKWRipJMGXcGsclvjks6uTXbGv4OafwJRTHPmXCjmMnTATLZOSEUElIO3I5pG2
 HO8Fj0rFx/pXz9E1lGzPdnOXJXntHgPe04qqSH50zP/Fo=
X-Received: by 2002:a05:7023:90b:b0:1b5:b04:139 with SMTP id
 a92af1059eb24-1b50b0419f8mr13263698c88.0.1794863779928; 
 Mon, 16 Nov 2026 13:16:19 -0800 (PST)
X-Received: by 2002:a05:7023:90b:b0:1b5:b04:139 with SMTP id
 a92af1059eb24-1b50b0419f8mr13263673c88.0.1794863779365; 
 Mon, 16 Nov 2026 13:16:19 -0800 (PST)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b5031bc518sm32796139c88.15.2026.11.16.13.16.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Nov 2026 13:16:18 -0800 (PST)
Message-ID: <b15fa7e0-5e48-4992-88f7-f8167f942cf7@oss.qualcomm.com>
Date: Mon, 16 Nov 2026 13:16:16 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/48] hw/arm: convert machines to use AliasedClass
 interface
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Markus Armbruster <armbru@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>
References: <20261112133054.1977618-1-berrange@redhat.com>
 <20261112133054.1977618-13-berrange@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261112133054.1977618-13-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=BrEIUoX5 c=1 sm=1 tr=0 ts=6afb72a4 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=yNSreW8TG5WmXjoduUQA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA4NCBTYWx0ZWRfX/Xc7buu6JhPu
 +x/WjFSfLJEalDvhYqeqCny7qaYbIcY0bwh5OgBrgkvRnPlmxpDJpj2nrSjuhZmBnfo/IUaynom
 SVnG+ZqY7RAPhoIZUHoEOrYFZEaYc5Y=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA4NCBTYWx0ZWRfX56cdZ9g1ms33
 i0ntcQOMzXbJ41ZqgU9c0Ct6QUjFb59HhhepUNxnEZSVOO9JvkbzWWv4XoFHRBnfakFHr8m/gFI
 gMRHGwWqYY5VhTd5KSixjEkT+WMr02BuXDxO1CxSGvy1JuxiSZXu6j2qMy8ew3YU/7KhgpSsxbz
 p95oEeu/Q3iwSg73WeBrB5PCaLwnPFkiZS4OOdOKcGWkTXfy7DPgCcWoNizOShVUxCUNLkDFoX1
 OtZWNkXZYvNgjVojxMWUUoYRWB/vDocCdBacNbrUTelGXajJnHzhWS1l6JFJ4vHfMqTWETgriRO
 ceWbxb4CXf+aOe91DHSnw8JpOhZzOT4K5hnLtdinLCZ8+tR/vmb5FhN3lGwmCjWdMiSTo9hlivr
 AhWQk0hdsk6r1FKi6TcJeprfp94m3U6yccQNefnXStYnzGsaKAI6RU9mfuC0dooY/5foqlfxf2k
 Pb9aVseoLdOBkgVotqg==
X-Proofpoint-ORIG-GUID: gmCIZPK8Aio7TfHTbiE8I-wcI8zET82x
X-Proofpoint-GUID: gmCIZPK8Aio7TfHTbiE8I-wcI8zET82x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_06,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 spamscore=0 phishscore=0 priorityscore=1501
 suspectscore=0 adultscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611160084
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/12/2026 5:30 AM, Daniel P. Berrangé wrote:
> Stop setting 'alias' in the MachineClass and instead set
> 'aliases' in the AliasedClass.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  hw/arm/aspeed_ast27x0_evb.c |  7 ++++++-
>  hw/arm/virt.c               | 12 +++++++++++-
>  hw/arm/xlnx-versal-virt.c   |  7 ++++++-
>  3 files changed, 23 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/arm/aspeed_ast27x0_evb.c b/hw/arm/aspeed_ast27x0_evb.c
> index 460c9ff0d2e..9f7d4395114 100644
> --- a/hw/arm/aspeed_ast27x0_evb.c
> +++ b/hw/arm/aspeed_ast27x0_evb.c
> @@ -11,6 +11,7 @@
>  #include "hw/arm/aspeed.h"
>  #include "hw/arm/aspeed_soc.h"
>  #include "hw/sensor/tmp105.h"
> +#include "qom/object_interfaces.h"
>  
>  /* AST2700 evb hardware value */
>  /* SCU HW Strap1 */
> @@ -53,8 +54,12 @@ static void aspeed_machine_ast2700a2_evb_class_init(ObjectClass *oc,
>  {
>      MachineClass *mc = MACHINE_CLASS(oc);
>      AspeedMachineClass *amc = ASPEED_MACHINE_CLASS(oc);
> +    AliasedClass *alc = ALIASED_CLASS(oc);
> +    static const char *const aliases[] = {
> +        MACHINE_TYPE_NAME("ast2700-evb"), NULL,
> +    };
>  
> -    mc->alias = "ast2700-evb";
> +    alc->aliases = aliases;
>      mc->desc = "Aspeed AST2700 A2 EVB (Cortex-A35)";
>      amc->soc_name  = "ast2700-a2";
>      amc->hw_strap1 = AST2700_EVB_HW_STRAP1;
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index e481d0e548b..60385971b6a 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -94,6 +94,7 @@
>  #include "hw/cxl/cxl_host.h"
>  #include "qemu/guest-random.h"
>  #include "hw/watchdog/sbsa_gwdt.h"
> +#include "qom/object_interfaces.h"
>  
>  static GlobalProperty arm_virt_compat_defaults[] = {
>      { TYPE_VIRTIO_IOMMU_PCI, "aw-bits", "48" },
> @@ -139,9 +140,18 @@ static void arm_virt_compat_default_set(MachineClass *mc)
>      } \
>      type_init(MACHINE_VER_SYM(register, virt, __VA_ARGS__));
>  
> +#define DEFINE_VIRT_MACHINE_ALIASES_LATEST(...) \
> +    AliasedClass *alc = ALIASED_CLASS(oc); \
> +    static const char *const MACHINE_VER_SYM(aliases, virt, __VA_ARGS__)[] = \
> +    { \
> +        MACHINE_TYPE_NAME("virt"), \
> +        NULL, \
> +    }; \
> +    alc->aliases = MACHINE_VER_SYM(aliases, virt, __VA_ARGS__)
> +
>  #define DEFINE_VIRT_MACHINE_AS_LATEST(major, minor) \
>      DEFINE_VIRT_MACHINE_IMPL({ \
> -            mc->alias = "virt"; \
> +            DEFINE_VIRT_MACHINE_ALIASES_LATEST(major, minor); \
>          }, major, minor)
>  #define DEFINE_VIRT_MACHINE(major, minor) \
>      DEFINE_VIRT_MACHINE_IMPL({}, major, minor)
> diff --git a/hw/arm/xlnx-versal-virt.c b/hw/arm/xlnx-versal-virt.c
> index 4018f2bf7d1..309063d38d8 100644
> --- a/hw/arm/xlnx-versal-virt.c
> +++ b/hw/arm/xlnx-versal-virt.c
> @@ -23,6 +23,7 @@
>  #include "hw/arm/boot.h"
>  #include "qom/object.h"
>  #include "target/arm/cpu.h"
> +#include "qom/object_interfaces.h"
>  
>  #define TYPE_XLNX_VERSAL_VIRT_BASE_MACHINE \
>      MACHINE_TYPE_NAME("amd-versal-virt-base")
> @@ -368,9 +369,13 @@ static void versal_virt_machine_class_init(ObjectClass *oc, const void *data)
>  {
>      MachineClass *mc = MACHINE_CLASS(oc);
>      VersalVirtClass *vvc = XLNX_VERSAL_VIRT_BASE_MACHINE_CLASS(oc);
> +    AliasedClass *alc = ALIASED_CLASS(oc);
> +    static const char *const aliases[] = {
> +        MACHINE_TYPE_NAME("xlnx-versal-virt"), NULL,
> +    };
>  
>      mc->desc = "AMD Versal Virtual development board";
> -    mc->alias = "xlnx-versal-virt";
> +    alc->aliases = aliases;
>      vvc->version = VERSAL_VER_VERSAL;
>  
>      versal_virt_machine_class_init_common(oc);

Looks good overall, even though a bit verbose. I'm not sure we can
really get anything better in C with static variables unfortunately.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>


