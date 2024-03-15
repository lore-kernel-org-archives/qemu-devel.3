Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F14FAC54E58
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Mar 2024 21:32:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rlF9s-00023N-VG; Fri, 15 Mar 2024 17:32:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rlF9r-00022p-EU
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 17:32:07 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rlF9q-0006Z1-0L
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 17:32:07 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-6e6aa5c5a6fso2665524b3a.0
 for <qemu-devel@nongnu.org>; Fri, 15 Mar 2024 14:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710538324; x=1711143124; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IXh5m6E+ZhuHfn/lF3iLLRLPMxIt+5/OZWLPgtJ7Ujo=;
 b=DHZAYDhMKc6aPtgMFzwokTHHGdDeupp2uluwe/aC769JUMJlkbVId/NIo0C4H2CkFp
 qQvUtglktHiQBoTpB97NnENmH94O+4v44TbFzldtcDex/12fDiDHN3R326EOJcec1qI6
 VOOSfFpSIijjsjFFVqMrs/CtY5OQj04vpHtW0o1J2wPP0RNZp0BDtAinKYQaqgP2LtRe
 KKvQh/nxZuS7Tne+FN1bEY2dn61NR5eabtcJ8+sk3jx6uMh0BTK3RvMmHXWnQ8MJP7QP
 QocrEVO653wBRyWlmKD5arclvR1yPcVcsei36MQq7zV2jlmMHU2dnZX/jZr5GrxhyxQm
 jXZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710538324; x=1711143124;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IXh5m6E+ZhuHfn/lF3iLLRLPMxIt+5/OZWLPgtJ7Ujo=;
 b=qR4NcMh6T2DktTLpRylcLj8OLJcWTmCWJoVcbTvYbIGISk0bM2yr/XpYuZd6nsU+zO
 oyFwBOiF1ldcrlOh2TnMVHX2M3R4+HBkFcQ7AkrNElGZA+uy5Qih4zS4V96P55aEFKZr
 HkjX97rIa9rI+A0Socke9Q4Q1JA81WQ8nmBM6nyzvPJLwWn0dPyqbO6AcVRz9CseUXbR
 qyWNMiJC9Vb+ynCy44Bf7MDutnjBiWHwONmcnA7xeT4KWIW/l2ec1xP4KoxtUWKu8Chh
 a/eYCKVDfmAq2vnJeGJC51/7HHNmIeDyxR0o8vvtV8GbVTPrQ4LPhsPmAjjc9UypY51J
 7+Sw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW9ap9ntrMAm0fDmpWln9ObbhcBnADbTSoVVFZIwCWVeqKIEk5tJ64VShVI9cooRIE2Ye6y8Zyivu1+B+Hp9D4k4GFOU9M=
X-Gm-Message-State: AOJu0YzSKxl7jrKDRW87XEcwkgPK1TG9XCxTLuHwzrZ2BD4RPOO4dygK
 AA9+8hx85d63LpDLTsEmgdg9OHMiVxspxYsTtiUcc6F+XZ4SoY1BQEBbJ2bNeis=
X-Google-Smtp-Source: AGHT+IE7SLqK5ZNZjFS/v6k+1maDq1nY2ELiQUlr2xmM14xzC39A5LcRep/V7rKrwOTKZ31U7Rb2Yw==
X-Received: by 2002:a05:6a20:a109:b0:1a3:5322:a86f with SMTP id
 q9-20020a056a20a10900b001a35322a86fmr1661736pzk.38.1710538324479; 
 Fri, 15 Mar 2024 14:32:04 -0700 (PDT)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 r8-20020a62e408000000b006e64c9bc2b3sm3962473pfh.11.2024.03.15.14.32.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 Mar 2024 14:32:03 -0700 (PDT)
Message-ID: <63cf3b97-1637-40e7-9956-461b215f944f@linaro.org>
Date: Fri, 15 Mar 2024 11:32:00 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.1 12/12] exec/poison: Poison CONFIG_SOFTMMU again
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-ppc@nongnu.org
References: <20240313213339.82071-1-philmd@linaro.org>
 <20240313213339.82071-13-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240313213339.82071-13-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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

On 3/13/24 11:33, Philippe Mathieu-Daudé wrote:
> Now that the confusion around SOFTMMU vs SYSTEM emulation
> was clarified, we can restore the CONFIG_SOFTMMU poison
> pragma.
> 
> This reverts commit d31b84041d4353ef310ffde23c87b78c2aa32ead
> ("exec/poison: Do not poison CONFIG_SOFTMMU").
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/exec/poison.h         | 1 +
>   scripts/make-config-poison.sh | 1 -
>   2 files changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/exec/poison.h b/include/exec/poison.h
> index 1ea5633eb3..fbec710f6c 100644
> --- a/include/exec/poison.h
> +++ b/include/exec/poison.h
> @@ -84,6 +84,7 @@
>   #pragma GCC poison CONFIG_HVF
>   #pragma GCC poison CONFIG_LINUX_USER
>   #pragma GCC poison CONFIG_KVM
> +#pragma GCC poison CONFIG_SOFTMMU
>   #pragma GCC poison CONFIG_WHPX
>   #pragma GCC poison CONFIG_XEN
>   
> diff --git a/scripts/make-config-poison.sh b/scripts/make-config-poison.sh
> index 2b36907e23..6ef5580f84 100755
> --- a/scripts/make-config-poison.sh
> +++ b/scripts/make-config-poison.sh
> @@ -9,7 +9,6 @@ fi
>   exec sed -n \
>     -e' /CONFIG_TCG/d' \
>     -e '/CONFIG_USER_ONLY/d' \
> -  -e '/CONFIG_SOFTMMU/d' \
>     -e '/^#define / {' \
>     -e    's///' \
>     -e    's/ .*//' \

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

