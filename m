Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 146C9F99C63
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Apr 2026 00:11:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDtHf-0001Ic-OK; Fri, 17 Apr 2026 20:11:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wDtHe-0001IF-7l
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 20:11:38 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wDtHc-0006Zz-Oy
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 20:11:37 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-358e3cc5e7eso755674a91.0
 for <qemu-devel@nongnu.org>; Fri, 17 Apr 2026 17:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776471095; x=1777075895; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FmytiLro6yCbwNxhPk8tXSejQttcBTkk3ZF22/FW1oA=;
 b=y2LXAV/9pfb0O0qED3DLoNu1YcqvIQfYwJTS6E+cJv9TNP/wleB5bZ/BWycVv6dKAs
 PKRYDa7MMNpWAba5UdxKgA76MBbi+hR9xvoysESsJXh8uZ7OV1MAdF7y8F/X10sJMc72
 219wf0+7TP4yznJajKUYWdRKTDYT8sUtcfY3X3O2rdNyPVx30J3nt6QnlDA1n5mmxoce
 +B/M/hTGqM68saXVyZhBzuD9gwrkY4SRi4J1VeUOOwg6UqwyQCm+Pzv6tHWBATGzS6BH
 7a+poZU0+e8RjTYqNxY5Kuysp33mnsKGO279HrcZB+MbE23XDxl2vMp+zUDtpwNzQGZ4
 U4Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776471095; x=1777075895;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FmytiLro6yCbwNxhPk8tXSejQttcBTkk3ZF22/FW1oA=;
 b=nsfg1docNXhW6dMr8FdTeKtXt7nWO74itRbMNYXyUtoXaUij+CglNNtTKjDBpPSbf4
 Hv7ce/vCAnMuS/27g48PtTqb5Ch92Oe5WMQ8gnJIT0RslSgSs0Fx1z/+TXu487VBJn8G
 vozt2gRHojW4Z4rsYREc1bD2oEmJo0C4QmHFogz5qg3hL0CFdA28f3MnuGAy45fCr/7O
 BjCQroH6L5BiolTOh9uX5jFXUdzHvx4WDpYWeALskSccPwDXK5pypacMcih1lDLtMdBS
 mJqGORivEb3n6fZC6hcGRwMIG/eT+nYLUblRq8Xecve3Uxf2uR+wpBLJbJtVrv2wiF+x
 ueFg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/Wom9mO31b1X5CgcSOC9glIMmMsrPwk/TFHXjMYqQ+4lVcz6J9eHMmOybY//TUeIhBe38Z0V6a0QDX@nongnu.org
X-Gm-Message-State: AOJu0YzR5Z9SXL3vP4vSwSsZq4mcaZ42VP7JjPDEwFYpQeYXE4pc8LWt
 Bh03tExPh3PEb9WRRdVheGZs3z+oD1zqLZf7xR9RM98MA3ilknBwpVzJOcn/9/WmXFg=
X-Gm-Gg: AeBDiess0PEVMrRWKKc/BqTDrnNMkHZV7ip/RFimeqTQtlarguNIduY5geFn0yFr6gd
 jH/amHk+k5F/I8bABKlKZWkdvak5SBzE86UlAeDmJ+CVSBvo1mjrDzTNmbtXIf2D/q8eVzpCvgi
 sHUiifx5g5o+GcO8c6/zbBKHB2qXwMuV9nl8KHb45f3OsLU5OZOZxIwbOYP8RpNAX2aih6b7J+z
 4ytFZXKwuESbmLn7RkDpEVHkbN3xLcp3JnHhBVKc94qn0BGWosphi8QyZGhzUPEjD0wrZtmrZgJ
 nsbFu+MT8y4oHkoGyRuNmMwCJpBUhOOt7eqSOgkwlYTvNxQ7D44nZyvk+S64giMiOw+dycwVBAL
 xl26BkZl/VcdZ9uiIYRWwD1Aw/amhmcL47h4+bNJ3AptZpNaXgM0Ml+PIKVCFAY4CnuZ/AnpfoM
 DPVoTcnovXxPgDBwE1RGTsIHIgtiRN8PjuwhGi33UhAmQqnqbi4XBXNY6Sdd+WpnP9N9Y9esmoB
 pvCYxnd722Yg/wlqOb9WdGXEymiGgGbA6TW6vJF3JlTCyrgULmgGH9TuMtKOMlHiQ==
X-Received: by 2002:a17:90b:3c0f:b0:359:855f:ff96 with SMTP id
 98e67ed59e1d1-3614048b2f5mr4638489a91.17.1776471095026; 
 Fri, 17 Apr 2026 17:11:35 -0700 (PDT)
Received: from ?IPV6:2401:d002:dc0f:2100:742f:8dfc:5be0:dc23?
 (bg30dhzyct7sk57q2zln.ip6.superloop.au.
 [2401:d002:dc0f:2100:742f:8dfc:5be0:dc23])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36141868906sm3225291a91.3.2026.04.17.17.11.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Apr 2026 17:11:34 -0700 (PDT)
Message-ID: <05c44df1-d26a-4715-8e2a-d3f4f1de12fd@linaro.org>
Date: Sat, 18 Apr 2026 10:11:26 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] target/arm/ptw.c: Add GDI spaces to the granule
 protection case
To: Jim MacArthur <jim.macarthur@linaro.org>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
References: <20260417-jmac-feat_rme_gdi-v2-0-7cf5131aeb60@linaro.org>
 <20260417-jmac-feat_rme_gdi-v2-3-7cf5131aeb60@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260417-jmac-feat_rme_gdi-v2-3-7cf5131aeb60@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102a.google.com
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

On 4/17/26 21:02, Jim MacArthur wrote:
> System Agent, Non-secure Protected and two other GPI field encodings.
> 
> These are explicitly denied access for any processing element when
> the relevant GPCCR bit is set, and reserved values when the relevant
> GPCCR bit is zero.
> 
> Signed-off-by: Jim MacArthur <jim.macarthur@linaro.org>
> ---
>   target/arm/ptw.c | 20 ++++++++++++++++++++
>   1 file changed, 20 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

> 
> diff --git a/target/arm/ptw.c b/target/arm/ptw.c
> index 7b993bb5b3..316e201cfe 100644
> --- a/target/arm/ptw.c
> +++ b/target/arm/ptw.c
> @@ -510,6 +510,26 @@ bool arm_granule_protection_check(ARMGranuleProtectionConfig config,
>           break;
>       case 0b1111: /* all access */
>           return true;
> +    case 0b0100: /* system agent only */
> +        if (FIELD_EX64(gpccr, GPCCR, SA) == 0) {
> +            goto fault_walk;
> +        }
> +        break;
> +    case 0b0101: /* non-secure protected */
> +        if (FIELD_EX64(gpccr, GPCCR, NSP) == 0) {
> +            goto fault_walk;
> +        }
> +        break;
> +    case 0b0110: /* reserved if NA6==0, otherwise no access */
> +        if (FIELD_EX64(gpccr, GPCCR, NA6) == 0) {
> +            goto fault_walk;
> +        }
> +        break;
> +    case 0b0111: /* reserved if NA7==0, otherwise no access */
> +        if (FIELD_EX64(gpccr, GPCCR, NA7) == 0) {
> +            goto fault_walk;
> +        }
> +        break;
>       case 0b1000: /* secure */
>           if (!config.support_sel2) {
>               goto fault_walk;
> 


