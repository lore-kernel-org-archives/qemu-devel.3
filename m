Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 917881093168
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2026 21:44:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5W17-0005yx-MZ; Wed, 25 Mar 2026 17:43:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w5W16-0005xx-4A
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 17:43:56 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w5W13-0001VM-Q3
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 17:43:55 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-829ac4670c4so251023b3a.0
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2026 14:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774475032; x=1775079832; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=809JX76yFRucAkT1pe5PiS2+CHvIuHQOo1wJQUdn3Qg=;
 b=hbZPyCjU0X8YgEn71huW+bQuC3AMvr8zTdK5ERXssgcFA5pFISyJiyMuS8OgwbmpHS
 UELz+VssCeei863aTtTQEOVJDrMvpaHA9elxXKCmMPQ/dv8aoWtpYW08SIuwFKFKhnTp
 fR/Tw3I2sRhxCRBOFpCthsuDoqHRKW3SA9QjRmYsM3kSQVu8LFcosUfv+nQxfrZxC8LJ
 M10ZLKQ+gKe+d6EDpJmibrAzI/U+to8hQnZlKCwsd2/456/J+DVCX+QWd2FzsuhfELez
 gum3mDEOOeqwoGoB7Wj5zMEme9doe/xjbBi6kFEzf0Q2Aw1SIf/rwmmbeu7qrg7MqyTi
 4rNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774475032; x=1775079832;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=809JX76yFRucAkT1pe5PiS2+CHvIuHQOo1wJQUdn3Qg=;
 b=EfYAMHO7oA086PrCa7zMQP++puZSALb62jKh0iaxwrFz1/8itdjCA1ch35A6Kb86cf
 21puezMdt5gcCr+oqeHbYv12Ktfzek572GBKXtVGhnaU9MTR6P3puIKeKpT6uUFv48GM
 kafYkxiav6RMkc6UJDp/9KjkwiqYKlkj3/DiMBt/Ec56chYlj2GeMgGiuQRHo+ZS8TiQ
 rrFkJGguo2YbZMayDxjy67/KLR8Lj9rx93nSGqylDbxaVNt3cQolwvgaQhTPgUYtXDOn
 qaezLSRn2VvxaT9XR70scpzr3UX4EcnyWUdqYpBQ/0+3dJUzwubDvmIhBNtL0xPmtCb+
 vzyQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVqDy049xSp/673OeI36N9kHH0cgIywkJMeEO1R5bqMehF0WltXUjRl5CrUOoiw4iyGqjlBye1sRkhV@nongnu.org
X-Gm-Message-State: AOJu0Yw4fQUTKn+W3L6GJNR+LvNRMy5dFNZBaeX+JMmlC2E7PkfJUKmo
 1C5yMebKeMBgGiMxzy+zbfCPPxiHN1H+tI4BrabqiERMa9bXkkEK/KGxLhpscHVNIuM=
X-Gm-Gg: ATEYQzwxkoMF5kD1042YP+HriyOpMvcRUzxwQOLK3X+VXbdDAv8QIIMBHYRx06U6M6J
 pF7pulckPSGElgA9KcXrizntSEX6HZP7dQ9IBYC8ibOapg+Hqhn1jgCOsf8nRXngPV2eVimUGxW
 FDCCvJveLjZU65zGW1/HCGdMcdZtDYVVyq9seuJlfy2vlQ+D6u4+eAN5y/Bk+fDrCBcpeGu1V3/
 vM5I/V/8Wo+Fh07QWWDY5kr0b5Z42+A7JBe+Ponl8HvnJwIIvlxs1lXadimVoCuUE53T5FlVg4o
 YH6yZ3RCegkVB/3WyOf3Y5TCww07USWUM6XVKdNuE6pD3eRFaILe57riBGDoo2Vdg4gFmMvrBfF
 3TPgphG4hqEwoVFvxEqz/vkF1G++aFlW6YMxw9p/7eJ9B0UGO//6pvhruZrV8i7Gd9HNlaexUAA
 BLwN1F6NUmzw5lGwGzajpTB+uhrZbZ2wjCb2L96Rjddmm2xhrS+dZAvtnSBkQoQfudhZAr
X-Received: by 2002:a05:6a20:9143:b0:39c:787:f188 with SMTP id
 adf61e73a8af0-39c4ae08a53mr5761498637.39.1774475031789; 
 Wed, 25 Mar 2026 14:43:51 -0700 (PDT)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c767382bcecsm379326a12.13.2026.03.25.14.43.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Mar 2026 14:43:51 -0700 (PDT)
Message-ID: <c450e74d-e5f9-40c2-9e29-274a0d51631f@linaro.org>
Date: Wed, 25 Mar 2026 14:43:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-11.1 08/10] target/i386: Inline
 VMSTATE_UINTTL_SUB_ARRAY() macro
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Glenn Miles <milesg@linux.ibm.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>, Alistair Francis
 <alistair.francis@wdc.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, qemu-riscv@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Artyom Tarasenko <atar4qemu@gmail.com>,
 Anton Johansson <anjo@rev.ng>, Peter Xu <peterx@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>
References: <20260325211728.89204-1-philmd@linaro.org>
 <20260325211728.89204-9-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260325211728.89204-9-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 3/25/26 2:17 PM, Philippe Mathieu-Daudé wrote:
> The x86 target is the single one using the VMSTATE_UINTTL_SUB_ARRAY
> macro. Inline it to avoid further uses of this legacy macro on other
> targets.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/migration/cpu.h | 4 ----
>   target/i386/machine.c   | 6 +++++-
>   2 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/include/migration/cpu.h b/include/migration/cpu.h
> index 82a81b5d895..ea411d863ad 100644
> --- a/include/migration/cpu.h
> +++ b/include/migration/cpu.h
> @@ -12,16 +12,12 @@
>       VMSTATE_UINT64_V(_f, _s, _v)
>   #define VMSTATE_UINTTL_ARRAY_V(_f, _s, _n, _v)                        \
>       VMSTATE_UINT64_ARRAY_V(_f, _s, _n, _v)
> -#define VMSTATE_UINTTL_SUB_ARRAY(_f, _s, _start, _num)                \
> -    VMSTATE_UINT64_SUB_ARRAY(_f, _s, _start, _num)
>   #define vmstate_info_uinttl vmstate_info_uint64
>   #else
>   #define VMSTATE_UINTTL_V(_f, _s, _v)                                  \
>       VMSTATE_UINT32_V(_f, _s, _v)
>   #define VMSTATE_UINTTL_ARRAY_V(_f, _s, _n, _v)                        \
>       VMSTATE_UINT32_ARRAY_V(_f, _s, _n, _v)
> -#define VMSTATE_UINTTL_SUB_ARRAY(_f, _s, _start, _num)                \
> -    VMSTATE_UINT32_SUB_ARRAY(_f, _s, _start, _num)
>   #define vmstate_info_uinttl vmstate_info_uint32
>   #endif
>   
> diff --git a/target/i386/machine.c b/target/i386/machine.c
> index 1f5c517e562..16b65bddcdd 100644
> --- a/target/i386/machine.c
> +++ b/target/i386/machine.c
> @@ -1770,7 +1770,11 @@ const VMStateDescription vmstate_x86_cpu = {
>       .pre_save = cpu_pre_save,
>       .post_load = cpu_post_load,
>       .fields = (const VMStateField[]) {
> -        VMSTATE_UINTTL_SUB_ARRAY(env.regs, X86CPU, 0, CPU_NB_REGS),
> +#if TARGET_LONG_BITS == 64
> +        VMSTATE_UINT64_SUB_ARRAY(env.regs, X86CPU, 0, CPU_NB_REGS),
> +#else
> +        VMSTATE_UINT32_SUB_ARRAY(env.regs, X86CPU, 0, CPU_NB_REGS),
> +#endif
>           VMSTATE_UINTTL(env.eip, X86CPU),
>           VMSTATE_UINTTL(env.eflags, X86CPU),
>           VMSTATE_UINT32(env.hflags, X86CPU),

I think it would be better to exclude this patch, and treat 
VMSTATE_UINTTL_SUB_ARRAY with a generic approach, similar to what we 
talked about VMSTATE_UINTTL*.

In short, to add a field to VMStateField, with .target_long = true, that 
indicates to migration code that size should be read from .size / 
target_long_bits().

Regards,
Pierrick

