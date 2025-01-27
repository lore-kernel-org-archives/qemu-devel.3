Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93405C0218C
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2025 08:04:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcK5h-00067E-Bs; Mon, 27 Jan 2025 03:03:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tcK5b-00066p-NQ
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 03:03:23 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tcK5Z-0002As-Ej
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 03:03:22 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4361e89b6daso25962855e9.3
 for <qemu-devel@nongnu.org>; Mon, 27 Jan 2025 00:03:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737964999; x=1738569799; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oqH/2UccqE/MOQ+NxFoUmk0QRPM+fE/Q8MNlZykw8c0=;
 b=Bry5ZfXhHlU9AAcMNIJbaL/xLy/GH1VTiHTFpewZJWl1S+GNRx3miSbEMIaAEp29Pd
 4Fembd61Cdz9ubeEoR/nRWDjC4OJuh36pwSgNtfTHk1ndjfICXdgh9yQUQnNEYw/e7CZ
 HUI/HQz29SAqB9azJnjEWgefbLlRm0h6X2pwzdKUb33QJHsZ5P4xlVPNO8gigBkpTeGM
 LOLCCOliuhy+Z8LgrdYiTYA29Sx10avJacTKlMgrI9vxTr380ga0eetjS3AfjCbK1LEj
 /LeOy+9kZReX24+nZzaYJj8bpA2SN24LvJFV8AgB3LHxiEe0KuuXOWTGO1aQjXnVKRRu
 Po3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737964999; x=1738569799;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oqH/2UccqE/MOQ+NxFoUmk0QRPM+fE/Q8MNlZykw8c0=;
 b=napk4fVquiMkxvITleamPOU+5dG5C6oCAdzgrGjn7+s8MSsoZUN0n17YxhZWSjHLx7
 WMrjytZ05e20PHRlCTvUGfH3fObmU1BfAhMJH9B2pq0krQZRnPXDjRcfpqEux16W+Ni0
 QIQO76W1P+SmUAdh3PcU4jUIBzkShdetDNsSTLif2JCDU0xHDWJSL+whostb1gDP11qa
 iGcAef6zbT8CqNplURJrJmzZi5AhGLGG5x/+sIuoC7WB35fkm7A/arp+VamixujMdLQL
 a5iMWY21DulCFgPxZIF8C1w4XF+wdJIYvAMIfgBrQ1fJIm/RnrH5kn0B20aavMnQRQeR
 icrQ==
X-Gm-Message-State: AOJu0Yx+FxcyAvvDUdWqKe73MX/zy+Zl4sdEYdqo1yyQtMGrvTuVKI+g
 E3jyxfpgbcMhDo2ZGoT1xxG1icKXUexYDAcpTqM9QNfEhvvo1mYWbaCIDZ+a/gmmeW7uzBoRH3Y
 j8Dc=
X-Gm-Gg: ASbGncswhxZfLcilb/6GwC3/u2KegjfvCq1rvwIj2Aie6dXOOlXpR7BDKucU3kv/IG8
 UQj8avBClkJwLRi4GiL4ush5CpEGXwKhct1cf55EZFVaV1p6pDlqmfmh3kyg+9ugTWG4UbQBVUl
 iX8uF+7pcrjg62Kf9tb6rdrtfDL4rInvPfW+djfq+RRnvNgdCrv18PvPMIna6+P7mivRZceG8P0
 6XMxUT821rIYG9ob7s+EL5orQUatRdYVCi1AhQ4z0Qdt0My62SQ4DZnkgFMz3pvSCKfiPTbjI8s
 hKMSE5Qa2Uk+LfXD2modVNixVYL0DKnfgLChnfHQ77d6kA0D
X-Google-Smtp-Source: AGHT+IEJ+ox109EBn5aLshQLaw3guPO6t//d3GIcWRAw/mXfydzpv483qHLUwRzOdTtVm75l68Lkcg==
X-Received: by 2002:a05:6000:4008:b0:38a:624b:e37b with SMTP id
 ffacd0b85a97d-38bf57b642dmr33221955f8f.53.1737964999214; 
 Mon, 27 Jan 2025 00:03:19 -0800 (PST)
Received: from [192.168.69.181] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c2a1bad92sm10295436f8f.61.2025.01.27.00.03.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Jan 2025 00:03:18 -0800 (PST)
Message-ID: <67dbc202-7b6d-4bf4-8d18-2ba78f39a287@linaro.org>
Date: Mon, 27 Jan 2025 09:03:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm/cpu: revises cortex-r5
To: Yanfeng Liu <yfliu2008@qq.com>, qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 alistair.francis@wdc.com, Yanfeng Liu <p-liuyanfeng9@xiaomi.com>
References: <tencent_033217F7900714A999352724A7790C3F0007@qq.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <tencent_033217F7900714A999352724A7790C3F0007@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi,

On 26/1/25 12:43, Yanfeng Liu wrote:
> From: Yanfeng Liu <p-liuyanfeng9@xiaomi.com>
> 
> This enables generic timer feature for Cortex-R5 so that to support guests
> like NuttX RTOS.

QEMU aims to model CPU faithful to hardware, than the R5
doesn't has generic timer.

Maybe you want to use the Cortex-R52 instead? I see NuttX supports it:
https://nuttx.apache.org/docs/latest/platforms/arm/fvp-v8r-aarch32/boards/fvp-armv8r-aarch32/index.html

If it works for you, could you add a test for NuttX on Cortex-R52?
See for example tests/functional/test_avr_mega2560.py

Thanks!

Regards,

Phil.

> Signed-off-by: Yanfeng Liu <yfliu2008@qq.com>
> ---
>   target/arm/tcg/cpu32.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/target/arm/tcg/cpu32.c b/target/arm/tcg/cpu32.c
> index 2ad2182525..5d68d515b4 100644
> --- a/target/arm/tcg/cpu32.c
> +++ b/target/arm/tcg/cpu32.c
> @@ -590,9 +590,10 @@ static void cortex_r5_initfn(Object *obj)
>       set_feature(&cpu->env, ARM_FEATURE_V7MP);
>       set_feature(&cpu->env, ARM_FEATURE_PMSA);
>       set_feature(&cpu->env, ARM_FEATURE_PMU);
> +    set_feature(&cpu->env, ARM_FEATURE_GENERIC_TIMER);
>       cpu->midr = 0x411fc153; /* r1p3 */
>       cpu->isar.id_pfr0 = 0x0131;
> -    cpu->isar.id_pfr1 = 0x001;
> +    cpu->isar.id_pfr1 = 0x10001;
>       cpu->isar.id_dfr0 = 0x010400;
>       cpu->id_afr0 = 0x0;
>       cpu->isar.id_mmfr0 = 0x0210030;


