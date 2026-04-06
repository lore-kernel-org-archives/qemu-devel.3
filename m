Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BD77E9D827
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2026 00:09:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w9XWM-0006i5-Gk; Sun, 05 Apr 2026 20:08:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w9XWJ-0006ds-RA
 for qemu-devel@nongnu.org; Sun, 05 Apr 2026 20:08:48 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w9XWH-0008Kg-6L
 for qemu-devel@nongnu.org; Sun, 05 Apr 2026 20:08:46 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-354bc7c2c46so1930520a91.0
 for <qemu-devel@nongnu.org>; Sun, 05 Apr 2026 17:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775434123; x=1776038923; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YwncKEfhcUnL5AlYRNYKoLkLxHN79JxG7nv5fwhbiL8=;
 b=itwZ9fbjPb/pLuR7PrbMA/tU+BB/E4P882177+qAgDukGMxlxs2fbh177a+gneyrUp
 SeJNQaBrevhFaKB+8QWZAKkeG7pHZ/2WYK7CcMPk2mMbkJQHNkP1CjGDolWgIIx0K+8L
 7fUDCMq1YQ2rKRSThEFRNpNzbEsJwxGxTxFSsnidZFfHrH3vl4dH8xb4DqHBWiY8hr92
 QIW6YeTACrqSUFuI7ETpSV6RwCloYWbvkwF7xqfSLyqCT6aQYp5hM0oHa8wNl7g5XQR4
 4M5zrq/OcdrwhG2UN99jchnnm/u3H4+1+bxfZ69Ph9C1KVS09pITv7pHHpC5NtuXYdFt
 K4cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775434123; x=1776038923;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YwncKEfhcUnL5AlYRNYKoLkLxHN79JxG7nv5fwhbiL8=;
 b=qXeqA6WapudHeiGbuqQoojG0JGaPk6zr0lF8rIbnVcRAYe+ccS2Fm9QPcRUcjzAIWI
 /upEi+40IjSgWXB2qa/y2udk8RSX//rxdgSUfqj57dTlgPxSVOKHjuR2YUeR62qGd+KQ
 5b4YibtDb464TiVYrtD6afxRgfXtrjiDpU5zGV5h8htauA/qIMjTjphXrG+Bss2RKvTp
 uLfB0sgO1MgmPghHyE9nQBBxYIA2+HClSyAgXhgQtvoHfeAtymLea2xDTQZyvrUOXsUj
 dA8kWlzpYHEWUoIga1FQddbywlj8CNsW7/fEEeWCwE+8quZeRIfqRAFMlnaQwEpxK8L9
 cJ/g==
X-Gm-Message-State: AOJu0YyqRAC7WiQr/IQjqE+17IvsQshQLfMNosxJNGB3lGDw1qdLi0oB
 Nzpg+90xBKFhRIW6EgH0LAVRUwDMYHXRKhwxo6Wm3SU2yxUAoIxLK10yK22eGXE+/SrTo8hnk4U
 Vi/TI
X-Gm-Gg: AeBDieuWVcPrGztccS23CsRtuCzHSiRWBap9is1+dzo1bkhi16W/plf/zslRp8eF/sY
 YykXnekJPmcHIVnRliQ08CLQLyiFPYtByz45GxobJSrjcHv2HAWLWxYQZ+VG4HvHmu6wbKBxv0N
 2CH6yTAi2Vnhe6tpKE4rxmeD5eSD19QHIBHtMIG1hDqQh+GhHvIdfAElH2tXA/35ffPafIzqSC/
 Zycl7FAE4QpcG9TeZzPe4Mk0GP5iLHE6nqxlhjCwvaP7kn01G1HAzIc4m5dj/rgyXDh0yw+JgUK
 I8Ntu+Y038xE1JUV2eUyvidxuwzV6guadmyDmEhjfuRCu+c1/CqRMjiar+PV+jtEKGxrmEB8JqP
 aCXdFk3Ll52SUWIeCBWi8u8maAcUD3Wrt0Lqokk3Tqsfa8UYsSLy4LiDaV46phSkKMMwhnEmMhe
 v4ICiTG51BaBgRlnBpS75HVKY6T1hi6CkadbUxVpL7ZSoeKzDXBr/Ov055K66U2G02VkY=
X-Received: by 2002:a17:90b:4ac7:b0:35d:a8d9:3b4 with SMTP id
 98e67ed59e1d1-35de678f7d7mr10029062a91.4.1775434123380; 
 Sun, 05 Apr 2026 17:08:43 -0700 (PDT)
Received: from [192.168.1.105] (124-150-69-109.tpgi.com.au. [124.150.69.109])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35dd35e360bsm11019903a91.3.2026.04.05.17.08.41
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 05 Apr 2026 17:08:43 -0700 (PDT)
Message-ID: <4287d4d0-32b9-4ac4-b105-7757ad39a42f@linaro.org>
Date: Mon, 6 Apr 2026 10:08:38 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 19/35] target/arm: make hvf use syndrome helpers for
 decode
To: qemu-devel@nongnu.org
References: <20260320130607.2071996-1-alex.bennee@linaro.org>
 <20260320130607.2071996-20-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260320130607.2071996-20-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 3/21/26 00:05, Alex Bennée wrote:
> Rather than open coding a bunch of shifts and masks we can use the
> syndrome definitions.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   target/arm/hvf/hvf.c | 14 +++++++-------
>   1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
> index 5fc8f6bbbd9..1c1c31f0b15 100644
> --- a/target/arm/hvf/hvf.c
> +++ b/target/arm/hvf/hvf.c
> @@ -2123,14 +2123,14 @@ static int hvf_handle_exception(CPUState *cpu, hv_vcpu_exit_exception_t *excp)
>           break;
>       }
>       case EC_DATAABORT: {
> -        bool isv = syndrome & ARM_EL_ISV;
> -        bool iswrite = (syndrome >> 6) & 1;
> -        bool s1ptw = (syndrome >> 7) & 1;
> -        bool sse = (syndrome >> 21) & 1;
> -        uint32_t sas = (syndrome >> 22) & 3;
> +        bool isv = FIELD_EX32(syndrome, DABORT_ISS, ISV);
> +        bool iswrite = FIELD_EX32(syndrome, DABORT_ISS, WNR);
> +        bool s1ptw = FIELD_EX32(syndrome, DABORT_ISS, S1PTW);
> +        bool sse = FIELD_EX32(syndrome, DABORT_ISS, SSE);
> +        uint32_t sas = FIELD_EX32(syndrome, DABORT_ISS, SAS);
>           uint32_t len = 1 << sas;
> -        uint32_t srt = (syndrome >> 16) & 0x1f;
> -        uint32_t cm = (syndrome >> 8) & 0x1;
> +        uint32_t srt = FIELD_EX32(syndrome, DABORT_ISS, SRT);
> +        uint32_t cm = FIELD_EX32(syndrome, DABORT_ISS, CM);
>           uint64_t val = 0;
>           uint64_t ipa = excp->physical_address;
>           AddressSpace *as = cpu_get_address_space(cpu, ARMASIdx_NS);

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

