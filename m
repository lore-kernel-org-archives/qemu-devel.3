Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 169FFC61DFD
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 18:01:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x16Ji-0002rk-6q; Mon, 31 Aug 2026 14:01:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x16JV-0002rE-P1
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 14:01:02 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x16JT-0001Nx-TQ
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 14:00:57 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67VFpt2t4152447
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 18:00:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 rJJyRV1Dm2vBToHD8nlNfttI+Ti40/liATLotz5RuTA=; b=hWg8qEGs9MLyjhm0
 QLhHHxkIAqf9UN2n0E82B7Iy9fjwetu+NRqiVk60st2Oavq2acc2Bp61omfKGQ2U
 mtGIIu4K5dS5qO8JhGGxFD46Qnuurp8X+T468Pzg3U7tcy/fIKrAs0zXAarsl2uB
 jJ3QuOXQ2ecSVwrXA6OY85JCrEskdWyXGMyW29rYtZu2Y7ABtOIStPC0TTd9i0x5
 MTmyAxBNZKRMZemeRuqi8z6zDV2pgwPPuiR3dAgxbuJWp8oi27J45FGDohN3T0S8
 223YhksvTQHKopCFYAgEfiaLDHbOxg5EfWaZnk2ZrYpFd0EmLyNo22Q7CYL0hlSm
 BnvS0A==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gd6h92f4x-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 18:00:54 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-38e54b6556aso5142623a91.2
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 11:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788199253; x=1788804053; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=rJJyRV1Dm2vBToHD8nlNfttI+Ti40/liATLotz5RuTA=;
 b=gTUIoyBlTva8p0p6fvmFmUnt0Y3JVSh1EharNCRhb6BoXWRlHULRbs4hXBxMU5j7R2
 SRI3r0S1W16LmTkECYqlGVlmZdMhZxWqROzbbtTFLvwJBmJpck+cjC3YKh8SuPjexMDx
 21KiUyM3pefjFLrSy79dZlsXQYKDWU6DwrJdyMmhRDm3f2Sg2c2zkgt5b9280+382rSx
 r1CVZDhmrWbg+KwMkmxsBCab9L6W8rIKsEwP00SjaUpOMa7CWJtDPKukWn0fcYlCLCXX
 qTHf4Aa0fHoC1NkNYYuqBy/bAZdLyfMzkKXrNI69LJVzNm20WdGVIdLXVHawWwSf9T44
 WulQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788199253; x=1788804053;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rJJyRV1Dm2vBToHD8nlNfttI+Ti40/liATLotz5RuTA=;
 b=WhxDEXQ7YMvO+DRJqoIk5kFeKvPXfjVLarsxq/U0WIf17uJR3nRO1xoO3w+XPmfnT2
 LMtYSOL91+GQfzU4qaXLSU0D7FYjPG+SKEoRCVKx/w3no59s0ej92spkyTvWUXVu+D41
 g/Ot/RsIoOnPO271eRvn0Q+7Ro3vKwsRyvkcLVobqKDoWymseZJEM/EKtd5gECNEh30K
 cdDGGoyID31mnvT/o/Br899KnB4OM0TrASWvKCjCS3XwGv1nPKYfWaWg3gRbbJP4rOBa
 4unB3UDCEsB5d1Ce6F2HBo8jaOGAHim3K8Alc6jKlBmvrYxXFegWOd0jwUaNPiOp3Eox
 hn7w==
X-Forwarded-Encrypted: i=1;
 AKwUvBwSKd/47QWH+2IpdLp1MAPJq7buTjzBU52WTLJRC1uqd5IKMfYKSsqkIS53FSl+b/ZHLTmFIRpgYja9@nongnu.org
X-Gm-Message-State: AFuF++lOaiqfUiSmBoEoDJTL4g/Lv/iT15F8EWqDut0fMVw4YqneSBxY
 xHjICDLoqp7X6fIywN+EC4uggSEsVOXd1sY1v45EwHEz6MsFNZGkj02XIKLjNJSsCXhw03Paqog
 G0arkLKZlCrqdLvr2uWNBgISMsfB7daU3ECjr8vyQoTpKRvIHcZ+nae07mg==
X-Gm-Gg: AYBFou2euf2I/G94HuZFfNFP+8YiIR3FdgcFkAABczv+M+dVZKpT9g6iy/o9iVFPD9K
 s+1QJU29VPh683O/nhpkmEutEW/RwalP1P1WwrwlxsVDVQfgj/9kXvA8PQzF7YzSJoSeO8DhGJu
 5C9zsUA7YJW9EU1MLOu2hS90sMqhFjAvjTDMnwTdxvDNCbMdWVZXlztg/UlLYDbEwxsePwC/vh7
 KYaB2OXqd5MTndipXyptPwzrBQfVbx+BXHZcPrmNKMJHAyoirW3phQdXobBTpUHJt0vKuYu3Ght
 2NQYUxLQs7c86CYQs89Tc5lG9PNvX13/w7R0b0H2O8YihG1RmosPu6gJDX8zUNzbxN8OC8uXruW
 1SXjdHYcM8nSooxs1HYZrKwsj0coN1257euYyR/QJKIBSgycqEqMrQDDECe3tId87Ucn7
X-Received: by 2002:a17:90a:d887:b0:398:9c0c:7c71 with SMTP id
 98e67ed59e1d1-3989c0c7fdcmr29604563a91.24.1788199252013; 
 Mon, 31 Aug 2026 11:00:52 -0700 (PDT)
X-Received: by 2002:a17:90a:d887:b0:398:9c0c:7c71 with SMTP id
 98e67ed59e1d1-3989c0c7fdcmr29604393a91.24.1788199251075; 
 Mon, 31 Aug 2026 11:00:51 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-142e0e0e67dsm27974259c88.15.2026.08.31.11.00.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 Aug 2026 11:00:50 -0700 (PDT)
Message-ID: <4d2fdd2f-a1c2-4353-b453-73ba99e65603@oss.qualcomm.com>
Date: Mon, 31 Aug 2026 11:00:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 23/47] target-info: add target_config_multiprocess
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: anjo@rev.ng, Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20260828225901.367438-1-pierrick.bouvier@oss.qualcomm.com>
 <20260828225901.367438-24-pierrick.bouvier@oss.qualcomm.com>
 <479920ab-cc83-474d-ba1a-89352cb0986c@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <479920ab-cc83-474d-ba1a-89352cb0986c@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=W6UIkxWk c=1 sm=1 tr=0 ts=6a95c156 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=lHAhBgMeLTbi0c3YXNwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: 3aWt6Q04ELraASnObOrvvnXXqxu8YRSG
X-Proofpoint-GUID: 3aWt6Q04ELraASnObOrvvnXXqxu8YRSG
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDE1NCBTYWx0ZWRfXxXUCb44qTXkH
 dICz5Stmq5vfTlRhRV2q/NhY7gk6mikUFA5ltNdu80kav5gcDji+SO0OQd51g3IaAHz7EEVVglr
 JyOwHW4TF+wxAlorzij5lPD010uZgus=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDE1NCBTYWx0ZWRfX+/E2nJD+nefC
 NDq7RJLUrtyMK/0mO/iqIR38RcqaZ4GtgIO6gqKwAOd5oVnT4ENwJCJqLi+G+mc2AaFyVwjstO1
 uERwgHfLq+jGVgqBFq89VgtESpAGx3NwfBdO2sgyo+JFqDDzIJ9eXXQhWI8JQBC5W49Da3VMbuP
 sBi+jjZK0xf9bGSfuDO53p5iGRfhZy6tdX1d5w0tCE/2gPOSxNb1Ht6UgftfVmJ/O/Ka2daZe+G
 ozyJ9ssAkgkvwqXw+57yXtec6WyoGUw9ifwgsnlO/oC5SjPZAeehbBR+5SN4RekDtuBZRQE5vH5
 F3NRyBZiI+ScJ8dWOLBFYS7QSDNhmtvqP0ExXm9A+pEyrVpETal2Q2szC2ay2MrM2Vcxjo8igle
 hSIlDrPsjgoCpp7rhXePiFvrV2b672k1Sl3QcQ8bfB6nI0MdU5LkWsYXACKHMvNyFCF7EsUlHn1
 cFM1uM3cSp/YDN75wEw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_05,2026-08-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 clxscore=1015 phishscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310154
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 8/31/2026 7:48 AM, Philippe Mathieu-Daudé wrote:
> On 2026-08-29 0:58, Pierrick Bouvier wrote:
>> For some devices/machines, we'll need to access target configuration,
>> but without relying to target headers. Thus, we add the needed
>> information in target-info.
>>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>> ---
>>   include/qemu/target-info-impl.h | 3 +++
>>   include/qemu/target-info.h      | 7 +++++++
>>   meson.build                     | 1 +
>>   target-info-def.c               | 7 +++++++
>>   target-info.c                   | 5 +++++
>>   5 files changed, 23 insertions(+)
>>
>> diff --git a/include/qemu/target-info-impl.h b/include/qemu/target-
>> info-impl.h
>> index cf42aabbc8b..dbd7a5a2071 100644
>> --- a/include/qemu/target-info-impl.h
>> +++ b/include/qemu/target-info-impl.h
>> @@ -30,6 +30,9 @@ typedef struct TargetInfo {
>>       unsigned page_bits_init;
>>       /* runtime equivalent of TARGET_PAGE_BITS_VARY definition */
>>       bool page_bits_vary;
>> +
>> +    /* CONFIG_MULTIPROCESS */
>> +    bool config_multiprocess;
>>   } TargetInfo;
>>     /**
>> diff --git a/include/qemu/target-info.h b/include/qemu/target-info.h
>> index b23e5bc5865..579c43332fb 100644
>> --- a/include/qemu/target-info.h
>> +++ b/include/qemu/target-info.h
>> @@ -42,6 +42,13 @@ const char *target_cpu_type(void);
>>    */
>>   bool target_big_endian(void);
>>   +/**
>> + * target_config_multiprocess:
>> + *
>> + * Returns true if target defines CONFIG_MULTIPROCESS.
>> + */
>> +bool target_config_multiprocess(void);
>> +
>>   /**
>>    * target_base_arm:
>>    *
>> diff --git a/meson.build b/meson.build
>> index 5da6c15551e..8023da4a147 100644
>> --- a/meson.build
>> +++ b/meson.build
>> @@ -4259,6 +4259,7 @@ foreach target : target_dirs
>>     arch_deps = []
>>     c_args = ['-DCOMPILING_PER_TARGET',
>>               '-DCONFIG_TARGET="@0@-config-target.h"'.format(target),
>> +            '-DCONFIG_DEVICES="@0@-config-devices.h"'.format(target),
>>     ]
>>     link_args = emulator_link_args
>>   diff --git a/target-info-def.c b/target-info-def.c
>> index d121b8c0170..9d51371f766 100644
>> --- a/target-info-def.c
>> +++ b/target-info-def.c
>> @@ -15,6 +15,10 @@
>>   #include "exec/cpu-defs.h"
>>   #include "exec/page-vary.h"
>>   +#ifndef CONFIG_USER_ONLY
>> +#include CONFIG_DEVICES
>> +#endif
>> +
>>   /* Validate correct placement of CPUArchState. */
>>   QEMU_BUILD_BUG_ON(offsetof(ArchCPU, parent_obj) != 0);
>>   QEMU_BUILD_BUG_ON(offsetof(ArchCPU, env) != sizeof(CPUState));
>> @@ -39,6 +43,9 @@ static const TargetInfo target_info_stub = {
>>       .page_bits_vary = false,
>>       .page_bits_init = TARGET_PAGE_BITS,
>>   #endif
>> +#ifdef CONFIG_MULTIPROCESS
>> +    .config_multiprocess = true,
>> +#endif
>>   };
>>     target_info_init(target_info_stub)
>> diff --git a/target-info.c b/target-info.c
>> index 012b384036d..5db2a6049ac 100644
>> --- a/target-info.c
>> +++ b/target-info.c
>> @@ -42,6 +42,11 @@ bool target_big_endian(void)
>>       return target_endian_mode() == ENDIAN_MODE_BIG;
>>   }
>>   +bool target_config_multiprocess(void)
>> +{
>> +    return target_info()->config_multiprocess;
>> +}
>> +
>>   bool target_base_arm(void)
>>   {
>>       switch (target_arch()) {
> 
> To avoid TargetInfo::config_multiprocess we can use:
> 
> -- >8 --
> diff --git a/include/hw/remote/mpqemu-link.h b/include/hw/remote/mpqemu-
> link.h
> index 4ec0915885..2dee94ac64 100644
> --- a/include/hw/remote/mpqemu-link.h
> +++ b/include/hw/remote/mpqemu-link.h
> @@ -98,2 +98,7 @@ bool mpqemu_msg_valid(MPQemuMsg *msg);
> 
> +static inline bool target_config_multiprocess(void)
> +{
> +    return IS_ENABLED(CONFIG_MULTIPROCESS_ALLOWED);
> +}
> +

We need to store the value of CONFIG_MULTIPROCESS somewhere per target,
so it can't be a common function.
Also, I tried using IS_ENABLED in target-info structure instead of
ifdef, but for some reason, it always returned false. Also, its
implementation is far from being easy to read.

>  #endif
> ---
> 
> 

Regards,
Pierrick

