Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B956D1D48C
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 20:10:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdwKX-0001Jt-66; Thu, 08 Jan 2026 15:10:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vdwKV-0001Jh-LT
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 15:09:59 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vdwKU-0008N9-5r
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 15:09:59 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-29f0f875bc5so32077215ad.3
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 12:09:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767902996; x=1768507796; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=glgd198IHOY9fDavoyv8VTQTXXmTaRrEfkfN6XtmF/0=;
 b=a4LBIchcHrGZmNk4ToSZeQOKhZry1xDPPcGWOHnKcizKu2cQHP1uTeYxyfnDHt8r1C
 /UYogIISvD6toXw3a5B2bfrIuJ07Mtq2dAJtfr5inWC9Iib6+vxr9M+sFYENhBeAg2TM
 iPtqlt/vWajDPaqa3KFtk1Sd0tJBvdwgOhb80orQuQnF3vIRJX10xVrfxVoBix/IK7Cg
 DyxBg3S1EGFbkFupRo8MD5OppTSP8O16DsAURptBx33c9F872tXlcIWhKktlfciP8J8E
 YllU9WI14XrUVoyK8kenPyebzpnCSI+ZMiqdwNzMfjIxhhvv9VbTPppkk8lewWa1Zw6a
 kLrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767902996; x=1768507796;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=glgd198IHOY9fDavoyv8VTQTXXmTaRrEfkfN6XtmF/0=;
 b=gfjHPv7AFdyhdbmgfoQn+N8Pm2Hz6evoeLLOx3jZ9+KGwyTZ9Sxvl8WUa1N1S/5/9X
 HXfHnZkWubvLY1t/2ffto0AGxtLRyZdqvtfz1qQFZBYnJmp1RGaZrKxyB01/QEBSojfj
 Uvq1HVKUMAR1rOfrrBZDXCj3OJ5Bu6H240KoQM4s97xPSYEF7GIvL+W35rgh0P8iCaC+
 npeQgxhRqX2BPxLOrEvftfu/A2lRAoSfmUQJGDPyxEp/Rk2zr4oPq+hCYtEmZKpSNWT8
 3V9vYm1MQIUX7AtbgWnTI3KU8mm+wDV+CqUT8uofZPC+YsgoyhrKLsSsRRN3R+y/v14k
 Ipxg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUgs9g1SJrRU5oNM7Or/c5eBBlKzLZPYjBZ8hRwozzK8qaL1YxSlBC94czs+4XBgX0S5fLh2UgfyOiL@nongnu.org
X-Gm-Message-State: AOJu0YxnWfkyavDFNmUh0h5s4dHuKxw9yx3RBJWcRO4IfO5SJqd24wWg
 PbCHFVJe9RHlC8PqqGNvmPu7w1ZkwEUtQVG0KGSgspY6jFBuvHKZDqgezZmPSuP0LNA=
X-Gm-Gg: AY/fxX7bhdoblHZDP3puqgm1R11v/LuETpkVoJMt0/mw2oFhRU5wtqqa/s80K2efcVQ
 pyS8sHrJfljsozD3COJkFneHt1z3BNODEbpOnTCKVW+gbc057Bym62OtDzj1gokNFmxkZNnmO3Z
 1GgyTuUWkxInCUHa129hycu+vDy39SosrlcYBdZLKLTDoYtxS6X5ZnWouD/g+Askar3qeyp6TXD
 E1b1hI8QZptXxV0hN5xsmSkddloA1AQlKPRrIEw3tB8Oj3d+ew05P/F2+7IAqdEBoTu81Y78sgv
 cw2aDtWBAJEycE2x8LPsNnH1uGulNGH5S0yMmfkkCQDmdHQlLcEnK6yLHEHjB4xjl7MwF6Ycu9i
 OlQA4i9J8K86+Z4bYUa9SceO1qXgOIXT9FqWwieuTVLBE+yeYPwkoZrQUs0WKy6OnG9nF9r/kXT
 NcL4fR5qSun2Sna/zTfDSYtXVNnsaxqhvZ/H9V1/1VIGsSXdNOwXYqThDc
X-Google-Smtp-Source: AGHT+IG2N3J5N1Cs6xNWoTJROJDlk4Ab6hhz2JO8XAvtZwDfk3W5qnQ/fy1Vn7FY40x95SDRgZ07Vg==
X-Received: by 2002:a17:903:3806:b0:2a1:3dae:8f22 with SMTP id
 d9443c01a7336-2a3ee5211demr67541875ad.61.1767902996366; 
 Thu, 08 Jan 2026 12:09:56 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a3e3cc8dd2sm85394355ad.82.2026.01.08.12.09.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Jan 2026 12:09:55 -0800 (PST)
Message-ID: <1928a9b9-aa81-49a8-844b-18617cc966ce@linaro.org>
Date: Thu, 8 Jan 2026 12:09:55 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/50] host/include/x86_64/bufferiszero: Remove no SSE2
 fallback
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20260108053018.626690-1-richard.henderson@linaro.org>
 <20260108053018.626690-8-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20260108053018.626690-8-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62c.google.com
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

On 1/7/26 9:29 PM, Richard Henderson wrote:
> Since x86_64 always has SSE2, we can remove the fallback
> that was present for i686.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   host/include/x86_64/host/bufferiszero.c.inc | 5 -----
>   1 file changed, 5 deletions(-)
> 
> diff --git a/host/include/x86_64/host/bufferiszero.c.inc b/host/include/x86_64/host/bufferiszero.c.inc
> index 74ae98580f..7e9d896a8d 100644
> --- a/host/include/x86_64/host/bufferiszero.c.inc
> +++ b/host/include/x86_64/host/bufferiszero.c.inc
> @@ -3,7 +3,6 @@
>    * buffer_is_zero acceleration, x86 version.
>    */
>   
> -#if defined(CONFIG_AVX2_OPT) || defined(__SSE2__)
>   #include <immintrin.h>
>   
>   /* Helper for preventing the compiler from reassociating
> @@ -119,7 +118,3 @@ static unsigned best_accel(void)
>   #endif
>       return info & CPUINFO_SSE2 ? 1 : 0;
>   }
> -
> -#else
> -# include "host/include/generic/host/bufferiszero.c.inc"
> -#endif

The only other user for this file is now
host/include/aarch64/host/bufferiszero.c.inc.

Code could be directly moved there instead, so 
host/include/generic/host/bufferiszero.c.inc can be removed.

It can be done in another commit though.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


