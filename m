Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 613A7C54FDF
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2026 07:51:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpLXd-0001r6-Hm; Thu, 30 Jul 2026 03:50:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wpLXa-0001qg-4w
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 03:50:55 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wpLXY-0005cC-8o
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 03:50:53 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66U7kxjx4169773
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2026 07:50:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 XsPm93Mcb8n16N9/aCbkPqPVS3mrus5bdcfysefqdeQ=; b=MsD9yWR60ahIpP4v
 KiUzPNz9QZfhmKVmIi93cDLqJc88TG0i74XaBJrMjFUO2dMSTEPWKLJIwshPi4fs
 OmGs2LmoFfPKdU4Jh28OnaFEnEgsx+P3hJhttrhDDr6VSKv2p2QbFZuUkUaxsEIq
 Y9e8OXlmqcdFW+wpH2eNgxcuEn8jmelrMRyauIODkpQ1ukd0MFJYeDElMLfzMl/2
 xCfkvbQgA2/95yH273LJ9BM8pywpORIFOq1BuJOSjPl8VlC+EkmZCsIaXQHrND2Z
 sFFlQPC2T+h5JWlb+q07m/rtcs9e4g5G6fdUYfB+yf878Zw1M9qCQTOiAnrNjDFo
 wEzcqg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fr2hbg0h0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2026 07:50:50 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51c1d7886cdso35422071cf.1
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2026 00:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785397849; x=1786002649; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=XsPm93Mcb8n16N9/aCbkPqPVS3mrus5bdcfysefqdeQ=;
 b=ZBfMGyjlxTzbgy0hYn/FeKG1UKGQ669wkfTIokFPLzJ5N/YylhTqpFoDixERwDTR19
 LxHjIBr15O4ju6M7TzU5wkdmoH4c2mOAUwOHWJ9+WcNSQNhQO5SONG25qAf68HJP4EUx
 cH3fPkbx3OkoaifKHKy2zqkjQi2Ui8SVhhiIEvsfyLUvQ+4ZU8VXdCTX/3vFsHnH7nMz
 yKsMfKJ2Nh9GA4z8h+hhvpIoN4AfuXpJqejBZwHtbv3AYEKBKVhSWn5LmqxejcO+X2eY
 aBmMg5/sQUtQt0tlnjI1Q5EAQoN8NyxFyoyP96Z4Tcv9lxzUemyaWeKwW2eKgBZy88qO
 hhDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785397849; x=1786002649;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XsPm93Mcb8n16N9/aCbkPqPVS3mrus5bdcfysefqdeQ=;
 b=a4CLJguCaWMucXzlB37sGRJYsB5hesAWtQYCja/0C9rNV1w3xuPofUESK08LMCuXmn
 QmuGQDyUNWyMKwSPLRX3s96R8f8sLYVK0dtiFclCzGurOLRtEtAerF55cj3DUZ8/Jnx3
 ZhM+bhd5ZeipcGRjTSnRSiGmY1c/8MtA/hS9Yps6Y1jXyg3OK1x/RS1EjFr8oRfxPiyc
 nNz+Kw3sjAhdFbDWr74vugbnqNucANTgQSkOH3SkZWf7U6WlpBVEpotSGcjNP2b/q5df
 c6IVcS+BBieHvTHbqgleAKwgL62d7Jb8tKa+99LEzcrPjgU36aSCYTBxGOWqEBDEcZ7M
 tdYQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpwdS+8+xqBxwvLZDPElJ+/xT1fJqLyYLBrmAhiXvbvJyXOyGS6bj1kn1RS/sn0dZ3hXpDgT229+Dcn@nongnu.org
X-Gm-Message-State: AOJu0Yyi7qkPX8dEvwmREIH9d/msx8fGxl8RbC9N5xpgXPww3+xcsagP
 2PlF99tP6WA40BDJR8zTZiUUyM3P0FMytBiuTv0rTQuP3i/lVDyiy4DBAYnSXKEsMaJpVHCyDmj
 45A88lp6SdQdJHS/Y5YjG5BjIRTejHNYlpRvMTiV7/IB+XtvGaIgcCJFhMg==
X-Gm-Gg: AR+sD10Oq+jV13lVRjcVzFKQC2SPp6i41kJME5bgGKbj9uXWQhW0h5kCJWtEaEMCioP
 HYvnUkWWobJK0Uv3HUggdVaqZVEizUsgNKmMLv4+9LQ5e+X94yIo8tHMm2GkTEyGcmB1CW+N58W
 6tKNzJ8rjGbc8NrRzCUUpDbOm3UhWEgpOU2cl849oUZy1bRT1ZHVszo/Q6iMC/1GxqyVFKv9sfj
 61zTAHXZmFK7F6vIAboe2e8c+AW5q18eDfF35VYncO80tw0k3juQArddv+d970JoQmHlbPlYzww
 L124OYHFDkzRml6Im7qtyGeyB+yx3tRudc+L8GXCD2ohSf3eEskaqDbg6AZnyxyYsZbtj5eSjeC
 bPvuFvaX9YvZE/CYKrF5RvpcY4N0NwxfHHxOoepJtR13C6tvY2Js=
X-Received: by 2002:ac8:5a92:0:b0:51c:981:94a6 with SMTP id
 d75a77b69052e-52b384a6f9amr17640591cf.23.1785397849007; 
 Thu, 30 Jul 2026 00:50:49 -0700 (PDT)
X-Received: by 2002:ac8:5a92:0:b0:51c:981:94a6 with SMTP id
 d75a77b69052e-52b384a6f9amr17640451cf.23.1785397848648; 
 Thu, 30 Jul 2026 00:50:48 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fc88d6f18sm3821262f8f.4.2026.07.30.00.50.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Jul 2026 00:50:47 -0700 (PDT)
Message-ID: <979ca64d-9ada-43db-b5ef-e5eaded7a237@oss.qualcomm.com>
Date: Thu, 30 Jul 2026 09:50:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 46/50] target/hexagon: Split probe_and_commit helper
Content-Language: en-US
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: ale@rev.ng, brian.cain@oss.qualcomm.com, pierrick.bouvier@oss.qualcomm.com,
 philmd@mailo.com
References: <20260730031025.12926-1-anjo@rev.ng>
 <20260730031025.12926-47-anjo@rev.ng>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260730031025.12926-47-anjo@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDA1NSBTYWx0ZWRfXznRPxuSum0kD
 +2yD2bmWjvuJ8DFkDhOizYQkCRsqovIhDo8k3xVibwZJ+6gFyeAoYbaZ3PQdEAKY21tJyPcD+jD
 E/euYU/DF7vByWJ0YKYO5OUnRq8Khic=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDA1NSBTYWx0ZWRfXxPu2W11U68cd
 voQwXyvF6mtAID4jJHzkLotdUHHnnvyB6cqxXccKS1zzojkbS5ifafHpvha8rkwWB6PdiE96gfv
 P7z08wTH7Hc2lBNt7prPnajKykUl0tpC6HOQdPYV5HvvHO4IdgVnx9nvX3n3zNqUAntSqYaxo9Z
 QwwTz1dE+harkGFa9wXVqs0V/oHa3O8hNbo9yQXWUd2ucd2zR6hXZgpR5ChxxtnYMr+Li5M47Gx
 z4IBsypAmBlNpW6SAi9Y7zA1dSPuf8uShwHTnyPEUyYwFNcYIb0plkCZ1eJ7DemtRV1hHT90aFs
 97EUft1Tamn8whknUch7fseuLIacrak6/xx10en9ZP+FE0sVQTUbUCsUN7MpHC/Bc6IoIxeviHi
 P7gEMZKnw2MHHnulyWMHGdSizcE2uW62UcOcX0F7pXvTG1ZSVRUR1y7UkbpEBWXgUO5sVpUXvs9
 u8QvzQtbydNSuuVPW9w==
X-Authority-Analysis: v=2.4 cv=OJMXGyaB c=1 sm=1 tr=0 ts=6a6b025a cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=e3DRgicxoDJ0vTz8VzgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: 5Bbkm8RenVbfA6F7-hFHa13ENn0JwmPm
X-Proofpoint-ORIG-GUID: 5Bbkm8RenVbfA6F7-hFHa13ENn0JwmPm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_02,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 malwarescore=0 adultscore=0 phishscore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607300055
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

On 30/7/26 05:10, Anton Johansson via qemu development wrote:
> Split function into a slowpath such that the faster function can be
> translated by helper-to-tcg.
> 
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>   target/hexagon/helper.h    |  1 +
>   target/hexagon/op_helper.c | 17 ++++++++++++++---
>   2 files changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/target/hexagon/helper.h b/target/hexagon/helper.h
> index 033e5619d6..74d5b7ffe8 100644
> --- a/target/hexagon/helper.h
> +++ b/target/hexagon/helper.h
> @@ -107,6 +107,7 @@ DEF_HELPER_4(probe_noshuf_load, void, env, i32, int, int)
>   DEF_HELPER_2(probe_pkt_scalar_store_s0, void, env, int)
>   DEF_HELPER_2(probe_hvx_stores, void, env, int)
>   DEF_HELPER_2(probe_pkt_scalar_hvx_stores, void, env, int)
> +DEF_HELPER_4(probe_and_commit, void, env, i32, s32, i64)
>   
>   #if !defined(CONFIG_USER_ONLY)
>   DEF_HELPER_3(raise_stack_overflow, void, env, i32, i32)
> diff --git a/target/hexagon/op_helper.c b/target/hexagon/op_helper.c
> index 1a067cd1ce..c175cecb71 100644
> --- a/target/hexagon/op_helper.c
> +++ b/target/hexagon/op_helper.c
> @@ -488,7 +488,8 @@ void HELPER(probe_pkt_scalar_hvx_stores)(CPUHexagonState *env, int mask)
>       }
>   }
>   
> -#if !defined(CONFIG_HEXAGON_IDEF_PARSER) || defined(CONFIG_HELPER_TO_TCG)
> +#if !defined(CONFIG_HEXAGON_IDEF_PARSER) || defined(TARGET_HELPER_TO_TCG)
> +
>   /*
>    * mem_noshuf
>    * Section 5.5 of the Hexagon V67 Programmer's Reference Manual
> @@ -500,8 +501,18 @@ static void check_noshuf(CPUHexagonState *env, bool pkt_has_scalar_store_s1,
>                            uint32_t slot, target_ulong vaddr, int size,
>                            uintptr_t ra)
>   {
> -    if (slot == 0 && pkt_has_scalar_store_s1 &&
> -        ((env->slot_cancelled & (1 << 1)) == 0)) {
> +    if (slot == 0 && pkt_has_scalar_store_s1) {
> +        helper_probe_and_commit(env, vaddr, size, ra);
> +    }
> +}
> +
> +/*
> + *
> + */

Either fill the comment block, or drop it :) Otherwise:
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

> +void HELPER(probe_and_commit)(CPUHexagonState *env, target_ulong vaddr,
> +                              int size, uintptr_t ra)
> +{
> +    if ((env->slot_cancelled & (1 << 1)) == 0) {
>           probe_read(env, vaddr, size, MMU_USER_IDX, ra);
>           commit_store(env, 1, ra);
>       }


