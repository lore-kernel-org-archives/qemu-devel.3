Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A629CC3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2024 09:31:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1setI7-00080N-3S; Fri, 16 Aug 2024 05:30:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1setI3-0007zR-Fs
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 05:30:35 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1setHl-0004qJ-4O
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 05:30:33 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-371941bbfb0so354666f8f.0
 for <qemu-devel@nongnu.org>; Fri, 16 Aug 2024 02:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723800605; x=1724405405; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=muKjfOsb+GD8Nk49J+v8C+E1AqHZzThyokLLBX+rjaQ=;
 b=PLxDeKmXSkQUQMNVZwHWfNYSH2Mqlnhse3ZKfx3xJDz+aa07ETp0LhZ1EOme4I15dp
 0Qpk8fULUKbvPhYkMIvQbwpETXR3+G0QWS/cu6Y3bjJD3dVVw2gv4m+eKdc46bX0MlG+
 8EnfThi9EYbwZRkJXrFr8YmQQ07xaJ5NWh51CvTxzNQGpZXcj+LaMsDVHf2xP64pHUmJ
 6FsIx/AtPWOkG03yV7/v46WbTAY9vYb03g+LOHhzj9h4qm/zMB87sOjePg/CIU3aH2kd
 OYhWgjXjQt5MA2xuEnQ2VKo+QUhsahk3PFfKwoouLiuq/yJRfA25Shx/qHs7iXdk8mwc
 me4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723800605; x=1724405405;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=muKjfOsb+GD8Nk49J+v8C+E1AqHZzThyokLLBX+rjaQ=;
 b=aVQnPP/MI8v6Gj8s9cJ8fDpg/ENb+oP4zc7ULNR7lBIz87RHc+5RVrjfNEGqM2i8KI
 s88L3gY8eOweB6RrGtxtL5PNRaxU/3NccLyk/r6OxWPS7fQ3dh52+iDzRlc91kDGO5T1
 jhVTScyNiGxcncMI6fIljuNX3RRHfjVgY6fHDFxx2a2X1Hk/yniSx5gc8gf4U96GyHH6
 jciLMXnSxYCE46ESK2qo6SyZu//+olWxthUuckWnEYBY9OijFk6Yptd2VHbAavAGOz8d
 FGTyAt87J6TUTsVhMWZy24vT3CA8bsEhzQjelrun7TNYhiSbc8zFvgWvRuUbAbU76tCU
 mSnQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWt9q4hK774zl0NsEn0Bhreo6JpjJig1DKA3ajzQjrWxQspt64Vy4CQ/mcRrHfEhHkoycVjxEmQGd8JITiw+WdCWlEAgTI=
X-Gm-Message-State: AOJu0YxyVsSpKG91hEjSiCtSfphwfb2W+vQU1CZ1IYBbC0QNW36gk0Qr
 IXCPjmQBnQm+HUC/Yl0re+YhgYLoggklMBhBln2SevcXWjALYlWFxOe0hMWx2Wo=
X-Google-Smtp-Source: AGHT+IGdG6tpDdi5kK07LfPcNk4v3jiW8AfARJQtVuNegzSLgDPc4ynUYQSjXW52KSJF7BSBs2QVoA==
X-Received: by 2002:a5d:490d:0:b0:368:2f01:3053 with SMTP id
 ffacd0b85a97d-3719468e61bmr1403022f8f.55.1723800604764; 
 Fri, 16 Aug 2024 02:30:04 -0700 (PDT)
Received: from [192.168.220.175] (143.red-88-28-5.dynamicip.rima-tde.net.
 [88.28.5.143]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-371898bb588sm3204144f8f.115.2024.08.16.02.30.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Aug 2024 02:30:04 -0700 (PDT)
Message-ID: <f6091ce8-0107-49cd-bf0f-05377711e493@linaro.org>
Date: Fri, 16 Aug 2024 11:30:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] target/i386: Fix carry flag for BLSI
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
References: <20240801075845.573075-1-richard.henderson@linaro.org>
 <20240801075845.573075-3-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240801075845.573075-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 1/8/24 09:58, Richard Henderson wrote:
> BLSI has inverted semantics for C as compared to the other two
> BMI1 instructions, BLSMSK and BLSR.  Introduce CC_OP_BLSI* for
> this purpose.

Fixes: 1d0b926150 ("target/i386: move scalar 0F 38 and 0F 3A instruction 
to new decoder")

or even older?

> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2175
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/i386/cpu.h                        |  5 +++++
>   target/i386/tcg/cc_helper.c              | 18 ++++++++++++++++++
>   target/i386/tcg/translate.c              |  5 +++++
>   tests/tcg/x86_64/test-2175.c             | 24 ++++++++++++++++++++++++
>   target/i386/tcg/cc_helper_template.h.inc | 18 ++++++++++++++++++
>   target/i386/tcg/emit.c.inc               |  2 +-
>   tests/tcg/x86_64/Makefile.target         |  1 +
>   7 files changed, 72 insertions(+), 1 deletion(-)
>   create mode 100644 tests/tcg/x86_64/test-2175.c


> +static int glue(compute_all_blsi, SUFFIX)(DATA_TYPE dst, DATA_TYPE src1)
> +{
> +    int cf, pf, af, zf, sf, of;
> +
> +    cf = (src1 != 0);
> +    pf = 0; /* undefined */
> +    af = 0; /* undefined */
> +    zf = (dst == 0) * CC_Z;
> +    sf = lshift(dst, 8 - DATA_BITS) & CC_S;
> +    of = 0;
> +    return cf | pf | af | zf | sf | of;
> +}

Except this function which I'm not reviewing, for the rest
to the best of my x86 knowledge:
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


