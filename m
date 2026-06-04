Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B72C0CD6E57
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2026 10:11:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wV51z-0005l1-M1; Thu, 04 Jun 2026 06:10:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wV51y-0005kO-5S
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 06:10:30 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wV51w-0002OI-6J
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 06:10:29 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6543aK3K3234759
 for <qemu-devel@nongnu.org>; Thu, 4 Jun 2026 10:10:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 pJrIDcyNveHXQQdDOKsJH34DZmo65dKBbxfMNwQmK1M=; b=lMDyRyjybHyOXtRK
 JVWHEekzrT/VKFXwzAfpzJYRqDknm00buLBlR9sZQzWAM+6GgQlMbee6sjPkKElY
 RMyhi9NABG9zFRfP1+j+w4OuBtvLhIClwDj5ZIUkQXniZRhOkETM/5rTecBzRnta
 rv+qHwnYC426pl0PiNUytX51Zj12G6PfRpxQYClyUK7w+hmM6W4lAyxW9U41eH3H
 /FxTSXlx6mFqmpZWjNDpEdpU6AVRVgq5f5n3808f6z/WPZi+HCY5RqtZlQKj7vFl
 HnFkIYLK4YkVuAF3DjSMVD9Nk9dvlsRJniswyM+sMz+6MWQxdhhQeeiMi7KFTTA/
 6kxY6g==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ejs4s361v-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2026 10:10:25 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id
 71dfb90a1353d-59ebabec151so897414e0c.1
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2026 03:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780567825; x=1781172625; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pJrIDcyNveHXQQdDOKsJH34DZmo65dKBbxfMNwQmK1M=;
 b=RzbNkg8hCi1EL8y4/ZaPcftQjR5GGZGEAlMBNVZUi9JkH53oIbPtFelbp5UBxy6SRq
 UYtNri7wSu9pAGPqMJLMqKojFyyrO8KpB1BuoppQH9pJIyM2mFViRFg0UJby2B6oQpim
 IGhlj+nBBcU5Jag2UYMkCnGn6KPQo/tnA7k9GAtfdkwLhhMUKjpoM2k3LUhfgXyfzgb7
 vORCfETI6lJ79trgMiH7i+0RDtk2p1FQ8VKO5WNpS+orW5QcMA4aj44i7i3DIrBsuCw8
 CshmsOTuIR1nYUYJdZZwu4yiWoM38vGNQr2em1RnZ1KgC0tWtEY+mLCAFWK5rR7Xq8QY
 FyKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780567825; x=1781172625;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pJrIDcyNveHXQQdDOKsJH34DZmo65dKBbxfMNwQmK1M=;
 b=TSpPeK4zlF9M9xR21ur+73Qjg0m1A13CmQYFKxb0/ParKbGN7LS2wLW+FI8ytQiJfT
 +LaoE2VuGiCnS6TwJl8TQ83roQDL3ux5HSMupZRiPPUBPG8pedr2SdBRdOxdSioJDe4X
 92jOi5i5AaFEM/20ecEaOe6YAWQjSpm5IceEltzIiBW5w9q3w1h4xBAaWQBt4QqksMcU
 3s0Nh8ORkoS6I+YphO0ZzaT60lJAOeOUhAZXfFf9Fz4UayPxMIFztkoASWy1O9Q0mzYQ
 XrPAO4c0WZGwkEIsyh+KmLoWe35P6XqMl7adEEn2Bq4UtD1hPZURk9lfYPuKu0BmZ/8p
 QeLA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8bXqIdDuzk0eeOawaunmJeLOm+d/EsRjf4ven212TT9Q5hmAzO4W6DT9sr7P3wrqKTXVxUk4e8XCrH@nongnu.org
X-Gm-Message-State: AOJu0Yzlq2Qu38KVhzFtNCJSifkWtdAnqyevL+MLQT7iqAhUchEnmjVf
 GSSJriiwXB9cP2zIyg4E8IFOUA8YcKfAFg+6FGG8GqksMNEuw+GnsAottMI0PDrbOLzg/NqJJuV
 HBC/T/rnxpohCE6YiVamghPU65CASFKr6GK5G5btom6mBVwHu3bgy917THQ==
X-Gm-Gg: Acq92OFz4bwmwYEm9CZRi1BuRECH1CpRo3fEyNSg6LQYCwvIfKHRZshvd7PP5a/ZH9f
 ROhhdXN5i5+YjljfgqR6p5F/ZZaufowL2dLV83ri56fAapqukekxz76osL1Hl7aJ6OGjG12q2mw
 9MYBdW4Zp3J/OKwfV43mua1HMOsSuzaaDPdIeeYOMvhEu19vyFX7wl8ghsA7FGkXw4fics09223
 QtHjzkn6OZAVahqtTgjHjagFrdmMSevhuy42aQ0BfWRTM981XeKQZ7p2uaXZziRDV4auv4w+umg
 9HJI/WUwlb0O6FfyKhKbmhWp+4KwNSfL/u6X9grlnp4Plyg2t/7MPb4bXSlo193/QcTgDFuwd/4
 rSM+b+OzkeiMi0R2EDd6RIs7J+mYzck0D6uJxdHtCMQ9n0+7IyT28oJ9DgbykxfrPc13M
X-Received: by 2002:a05:6122:3c4c:b0:56d:451b:e4dd with SMTP id
 71dfb90a1353d-5a6e93cc2cemr4173610e0c.12.1780567825187; 
 Thu, 04 Jun 2026 03:10:25 -0700 (PDT)
X-Received: by 2002:a05:6122:3c4c:b0:56d:451b:e4dd with SMTP id
 71dfb90a1353d-5a6e93cc2cemr4173601e0c.12.1780567824678; 
 Thu, 04 Jun 2026 03:10:24 -0700 (PDT)
Received: from [192.168.68.106] ([177.170.117.62])
 by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-5a6d6413cc1sm4748297e0c.3.2026.06.04.03.10.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Jun 2026 03:10:23 -0700 (PDT)
Message-ID: <7a487bf7-6357-4e67-9b84-6ee92878eca8@oss.qualcomm.com>
Date: Thu, 4 Jun 2026 07:10:17 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 03/25] target/riscv/debug: Implement permissive type
 unavailable trigger
To: Nicholas Piggin <npiggin@gmail.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, bin.meng@windriver.com,
 vivahavey@gmail.com, Alvin Chang <alvinga@andestech.com>,
 Yu-Ming Chang <yumin686@andestech.com>, Joel Stanley <joel@jms.id.au>
References: <20260114044701.1173347-1-npiggin@gmail.com>
 <20260114044701.1173347-4-npiggin@gmail.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260114044701.1173347-4-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: bPqVn77oFm37g0mYQKUOiCzNmVHGNXcD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA0MDA5NiBTYWx0ZWRfX4KLypMEPf42M
 /kC/4sWTKfICcVy5AXeT0rqaQnyXCgbDSAHzSfG9KBcsJpSwdWvJwyxxrJCCfwK9L271rSygE+R
 34908HMHIHvMNHkdPYQkgLJY6yKFYL8AX0zpi/fFpEon0PbBHXvSFyPcSYpEQBKJexbvJzSmgwB
 n7WHFZ1rRM6GMAzyjuLTKQfNoI6IjNNzTfnCamUTBLR4qziRacBXgVwkplLHoUVb8qEowf5qQ6O
 Eeb3Rlb5R0TX0sn72pBvgLUihVJOgMMKqIaF/2tLAsqo6KeFhUfaEof0yExFh9y2FpodpOpSY2g
 i2kwZyHazT213SX6uhyRlN/g94gkcBEasfQzntBbCzRpqxYRRIy7M/C3ZDfFIOjUAfvT5dkXpMK
 6l2kBueFzGpGWQye9Iqg1y3ewPs697i5Lprswc01f8/Ai2jT51daaAZGk4K3MSz3aotWUj/8kXj
 saPYuNyqvy04WZUZoqQ==
X-Authority-Analysis: v=2.4 cv=afRRWxot c=1 sm=1 tr=0 ts=6a214f11 cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=gdiugJE53z4H+vvYeRBHqw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=KZvdDlZKb8VGcrK-DIkA:9 a=QEXdDO2ut3YA:10
 a=tNoRWFLymzeba-QzToBc:22
X-Proofpoint-GUID: bPqVn77oFm37g0mYQKUOiCzNmVHGNXcD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_03,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 bulkscore=0 phishscore=0 clxscore=1015
 adultscore=0 lowpriorityscore=0 spamscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606040096
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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



On 1/14/2026 1:46 AM, Nicholas Piggin wrote:
> When a trigger type is "disabled", tdata2 and tdata3 must accept values
> that are valid for some supported trigger type. Additionally, writing 0
> to tdata1 must result in the type becoming "disabled". This is important
> for the prescribed sequences for updating triggers.
> 
> Implement write tdata=0 -> disabled behaviour and permissive accepting
> of tdata2/3 values in disabled state. This implementation could be
> improved by checking tdata2/3 values against supported trigger types,
> but it is good enough to be usable by software.
> 
>  From the RISC-V Debug Specification for tdata1:
> 
>    Writing 0 to this register must result in a trigger that is disabled.
>    If this trigger supports multiple types, then the hardware should
>    disable it by changing type to 15.
> 
> and, when type=15:
> 
>    This trigger is disabled. In this state, tdata2 and tdata3 can be
>    written with any value that is supported for any of the types this
>    trigger implements.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   target/riscv/debug.c | 30 +++++++++++++++++++++++++++++-
>   1 file changed, 29 insertions(+), 1 deletion(-)
> 
> diff --git a/target/riscv/debug.c b/target/riscv/debug.c
> index 2190c25f23..c92bd9860e 100644
> --- a/target/riscv/debug.c
> +++ b/target/riscv/debug.c
> @@ -827,6 +827,28 @@ static void itrigger_reg_write(CPURISCVState *env, target_ulong index,
>       }
>   }
>   
> +static void anytype_reg_write(CPURISCVState *env, target_ulong index,
> +                              int tdata_index, target_ulong val)
> +{
> +    /*
> +     * This should check the value is valid for at least one of the supported
> +     * trigger types.
> +     */
> +    switch (tdata_index) {
> +    case TDATA1:
> +        env->tdata1[env->trigger_cur] = val;
> +        break;
> +    case TDATA2:
> +        env->tdata2[env->trigger_cur] = val;
> +        break;
> +    case TDATA3:
> +        env->tdata3[env->trigger_cur] = val;
> +        break;
> +    default:
> +        g_assert_not_reached();
> +    }
> +}
> +
>   static int itrigger_get_adjust_count(CPURISCVState *env)
>   {
>       int count = itrigger_get_count(env, env->trigger_cur), executed;
> @@ -883,6 +905,10 @@ void tdata_csr_write(CPURISCVState *env, int tdata_index, target_ulong val)
>       }
>   
>       if (tdata_index == TDATA1) {
> +        if (val == 0) {
> +            /* special case, writing 0 results in disabled trigger */
> +            val = build_tdata1(env, TRIGGER_TYPE_UNAVAIL, 0, 0);
> +        }
>           trigger_type = extract_trigger_type(env, val);
>       }
>   
> @@ -897,6 +923,9 @@ void tdata_csr_write(CPURISCVState *env, int tdata_index, target_ulong val)
>           itrigger_reg_write(env, env->trigger_cur, tdata_index, val);
>           check_itrigger = true;
>           break;
> +    case TRIGGER_TYPE_UNAVAIL:
> +        anytype_reg_write(env, env->trigger_cur, tdata_index, val);
> +        break;
>       case TRIGGER_TYPE_INT:
>       case TRIGGER_TYPE_EXCP:
>       case TRIGGER_TYPE_EXT_SRC:
> @@ -904,7 +933,6 @@ void tdata_csr_write(CPURISCVState *env, int tdata_index, target_ulong val)
>                         trigger_type);
>           break;
>       case TRIGGER_TYPE_NO_EXIST:
> -    case TRIGGER_TYPE_UNAVAIL:
>           qemu_log_mask(LOG_GUEST_ERROR, "trigger type: %d does not exit\n",
>                         trigger_type);
>           break;


