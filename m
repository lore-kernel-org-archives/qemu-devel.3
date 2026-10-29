Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1643B606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 13:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=j//nqIL3
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMQAf-0003HF-Fk; Thu, 29 Oct 2026 09:27:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xMQAc-0003Gs-QH
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 09:27:55 -0400
Received: from mail-oa1-x31.google.com ([2001:4860:4864:20::31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xMQAb-0000AR-3J
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 09:27:54 -0400
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-4a89b4a59a1so584987fac.1
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 06:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793280472; x=1793885272; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=wHOLNxsrKaAXrGZ+VEDd/EI2zN79FieEmK6HX0Aii2U=;
 b=j//nqIL3NxzILt5tuLCnVPHrtYQSH7jsSAL4AwGHmMS8WLzpvI3z3jkbljhgdn7AgH
 VfdW+guMU+quCKnVcullFSgQkMBcG8l+r9tV/h+DBcPTAQ3jngunquiX3MQR4y0OOqdi
 o1npn2HTig637lZmp5MCRWNZBteN49OnspJ0vvL5CbXaQ20+LxeRiDlvdD7KEn6QNA2z
 Cv7x8DKxGL4Vh/yzPJNaAWL1anZIAecXJeYLhuDI90Cvuu9lUkBbNtgkzbuTzsWcm4sR
 kp5RpxxiKKOg8US34S9S5XL/NglQnTvRkcwl1jbsVez2MGXFmCs3A2jZ35vZnknFS1gT
 u9zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793280472; x=1793885272;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=wHOLNxsrKaAXrGZ+VEDd/EI2zN79FieEmK6HX0Aii2U=;
 b=tdmvscttu6lnvsn6GedQk6VjGJQGO7+HPWgDvP036qjrOVJXYd4AKY/w/EA0ZvS1ff
 QCaPvTco/KlHVXSJhYk4AJB0Pbi/4FIluzsPvTvOap5qblVVfz+vX71P6FH3t2TDWzCW
 v+8foNWmFGY4F9P8C7GdCFa0HCYb6TXMWfvu4QEIJoxP8qbvPRydAaage5vlGrdJVwvH
 bfc7PDlpVmJYdAkjGzlNigayggrMqAwCvkquQhowtyzxpuLFZN3ENNQrGLKxYQHU35LN
 AlRYj4OHFWKUlH1ljSJyAZBskITz25UV8rSW0UFSzQa9xX9E/J4nRd9P17cHy7vxpE20
 BPZA==
X-Gm-Message-State: AFq9FYIvyKPhYADSHJQ4Vk8PxFSmcXB41C8TpYmjXayy53iuI6fFHAqL
 5KKFRVkJYV2xaTdCNgKsYqi+esUYizsARKgtojmt9OO1rbxIommu//JLxCBJFojAhw9KcFP34g8
 HyPga
X-Gm-Gg: AYBFou1kNVG50AljpHp0CQFD/rrk9O/IArd7NhBUrh6AYejsCqXLlXbukqrdx59QJAX
 7Hj1i8xsO+rc6MkLPYHQEbHsUBvbjwPXNYS8yYETw8dunPQK+fPPHnsnOwxqBRJNACiK881vkBV
 KyKTtzzGhlINef/hK9kJIFKpVEOQjvk6V26tak7Hpg+9bJWQ2fyUBklB8EYIhHSY3MI9fdpOnjU
 FAijjVSmO4oiyrL+yL/Iw/GgkYV+7X1nHAHmdY81o7ChpExv1WOIm8Ff9ow+rmbQGyxZ91uoxAX
 +D2J5NJANg9iS8LF1aUVlExmR9Ex/cHMk7VyrBipmaLcn4JP1NyU55r8DytJSyQa64Aymhil91j
 bg6w++ouFB6vlVMY5MDmDBuOA5KDeN+R7fDGgfrGMJRauldEQGTySpQf6VHMxEvYtVDJnvMOcnK
 IJ8rtVxndv0RphoC+dPKrYZwIhEF0qMnDuw0K5iy47z3qwAmvh4Bvl+mOMtWhAVNmRYInme6u+n
 z7/yBicMihNnWHUb4ju3Zx1gvDm9TGacS2uLoT/ADoMSLSU8Et4fPloij448LycWj/1dY2iqUAv
 j85U8M5/OHTO0CnjxjqJSpkmyQajBwr9AYYkK7CTKjkdQQKRqLHr9WISmUkhYsr2DA==
X-Received: by 2002:a05:6808:6413:b0:4f4:e6eb:1283 with SMTP id
 5614622812f47-563ef85367bmr1423572b6e.28.1793280471466; 
 Thu, 29 Oct 2026 06:27:51 -0700 (PDT)
Received: from [192.168.129.53] ([50.233.235.3])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-563c654a22bsm3939408b6e.14.2026.10.29.06.27.50
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Oct 2026 06:27:51 -0700 (PDT)
Message-ID: <d176c186-bcc8-4a6a-b3da-88d40b0e143d@linaro.org>
Date: Thu, 29 Oct 2026 08:27:49 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/33] target/arm: Register CPUClass::exception_name()
 handler
To: qemu-devel@nongnu.org
References: <20261022215115.19680-1-philmd@oss.qualcomm.com>
 <20261022215115.19680-8-philmd@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261022215115.19680-8-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::31;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x31.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/22/26 16:50, Philippe Mathieu-Daudé wrote:
> Factor arm_exception_name() out of arm_log_exception() and
> register it as the CPUClass::exception_name() handler, so
> the common exception logging can resolve ARM exception codes
> to names.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@oss.qualcomm.com>
> Reviewed-by: Pierrick Bouvier<pierrick.bouvier@oss.qualcomm.com>
> ---
>   target/arm/cpu.h    |  4 ++-
>   target/arm/cpu.c    |  1 +
>   target/arm/helper.c | 77 ++++++++++++++++++++++-----------------------
>   3 files changed, 42 insertions(+), 40 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

