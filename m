Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0851EC2BD09
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jul 2024 19:05:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQAhk-0007X5-Rr; Sat, 06 Jul 2024 15:04:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sQAhj-0007WW-1o
 for qemu-devel@nongnu.org; Sat, 06 Jul 2024 15:04:15 -0400
Received: from mail-oo1-xc30.google.com ([2607:f8b0:4864:20::c30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sQAhh-0008HD-Gn
 for qemu-devel@nongnu.org; Sat, 06 Jul 2024 15:04:14 -0400
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-5c661df5db4so615985eaf.1
 for <qemu-devel@nongnu.org>; Sat, 06 Jul 2024 12:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720292652; x=1720897452; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QrGb8XRgBHudkMS89kxEbg5rnDc+Z71DAKsEagOp1tM=;
 b=p1Neg9zrmd+1y/HK6MHJPC0HkSIjz1SV8eMgWVM3Bufxi+2UVnqruU3A7zgYzRlmoV
 PH6zEEcQfglyhXqxr0xBfHw9gVIUtYXmFM18G/ExbkKrVtH2Fx0Zo1Dy7NVwht1jmp44
 DOCuJx90j9hO5vso8+YKc/e2v+cjiaD6wdwQG+8bygHwIO8vvgJWuZblB+ITwt9Ql/w3
 sCAc4EhGVGBqpJgRdZm/uR543RHlFhBkCs8Q10ofsCvR3DKF+hxFEAb3kABowTO1vQLV
 oQfhIwiUsjjFQiQ4pPk+gPCYzGcXn3D07cMGLgFc3u6NgiuRyES0to/rMsw9+0EptCJG
 i7bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720292652; x=1720897452;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QrGb8XRgBHudkMS89kxEbg5rnDc+Z71DAKsEagOp1tM=;
 b=f2aCk850jvFbZ+TwkxjySO4z95MEmrsCaEtMiLPJv0SoT+jE54m0o8bwQnatUTN5IJ
 +/tTgXU33roox/Mliq/uUzmCr5MuBc8nYBvY/uCK0oBX4wbN+bUV4HOFvfym96UDcwRe
 6taj7KpBXj9G/q31eGIyxfL1T60ArDlVVzZVZgTd3wYsgvmQMlPE+aYGSXLuccWbozgH
 QoFBLu5nJHveBvhGpTMLAjJ2Y/yofOdBuKEtWDwZmsLSnIKWBo5ixTfzDq3NlDXrWicO
 2GXrgtuKwcYDktoyrY9PXS9q5XK7FJdGrmlEIdohTsaqWjmoMfgSjNz+stxoT/VHdeV9
 5Cxw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU9Jmc5QTzoignxO6Xs/nKXoU/KTk79khIogJdY58Ek60ObAR+G6M+Qokgfn+ElwkYOt4aI1iSDsKjJIb1CabTXuK0wtKI=
X-Gm-Message-State: AOJu0YxYc37cmePwCB9saGzt9+9i8xKUuyTael9uzMYeeJh41+5Mt75q
 Ke7iC9bLdD8ReFW5Pw/6+9KMHccQJp/bgmUqXuvKa6A7zXsRFXteukplrXXNLjIMa48cOAMT9cC
 hXvA=
X-Google-Smtp-Source: AGHT+IGNLToUdHoZ4sc/grjXIfgjy6EYRBDoxd2tiznjbn2xxtyZK5pN2btc0r7QshLLyWBH+QL9lQ==
X-Received: by 2002:a05:6870:e2cf:b0:25e:1c7c:3df8 with SMTP id
 586e51a60fabf-25e2b8d9c0amr7135852fac.10.1720292651780; 
 Sat, 06 Jul 2024 12:04:11 -0700 (PDT)
Received: from ?IPV6:2604:3d08:9384:1d00::2193? ([2604:3d08:9384:1d00::2193])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70b1b40b12dsm1793676b3a.185.2024.07.06.12.04.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 06 Jul 2024 12:04:11 -0700 (PDT)
Message-ID: <99f95fee-5633-4fba-8695-4cb6cee4b477@linaro.org>
Date: Sat, 6 Jul 2024 12:04:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/7] plugins: save value during memory accesses
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Alexandre Iooss <erdnaxe@crans.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20240705003421.750895-1-pierrick.bouvier@linaro.org>
 <20240705003421.750895-3-pierrick.bouvier@linaro.org>
 <e8613098-74e2-4c14-9f47-24cc7a6b0b62@linaro.org>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <e8613098-74e2-4c14-9f47-24cc7a6b0b62@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c30;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-oo1-xc30.google.com
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

On 7/5/24 09:34, Richard Henderson wrote:
> On 7/4/24 17:34, Pierrick Bouvier wrote:
>> +static void
>> +plugin_gen_mem_callbacks_i32(TCGv_i32 val,
>> +                             TCGv_i64 copy_addr, TCGTemp *orig_addr,
>> +                             MemOpIdx oi, enum qemu_plugin_mem_rw rw)
>> +{
>> +#ifdef CONFIG_PLUGIN
>> +    if (tcg_ctx->plugin_insn != NULL) {
>> +        tcg_gen_st_i32(val, tcg_env,
>> +                       offsetof(CPUState, neg.plugin_mem_value_low) -
>> +                       sizeof(CPUState));
>> +        plugin_gen_mem_callbacks(copy_addr, orig_addr, oi, rw);
>> +    }
>> +#endif
>> +}
> 
> You need the big-endian offset for the low half of the uint64_t:
> 
>     HOST_BIG_ENDIAN * 4.
> 

Oh right, thanks. Will fix in v6.

> 
> r~

