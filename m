Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CA1AC54E55
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 20:38:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfQgo-0001Vo-GL; Wed, 28 Feb 2024 15:38:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rfQgf-0001C1-0d
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 15:37:57 -0500
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rfQgT-0003e6-4T
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 15:37:56 -0500
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-6e4a803c72aso67662a34.3
 for <qemu-devel@nongnu.org>; Wed, 28 Feb 2024 12:37:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709152663; x=1709757463; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=734VRFAtk9Y4gpXSq/ySW6oX2l2zgK2V0Of4TOS5X38=;
 b=adUr1iu81N0xUIBrNBeR6ASOsIbbn8N79SUaqc8X97dwVX8QNHGpDKX89pHQlukXRK
 Lp9jR4qlUtN5S2u6c+u9Q7vP9JO78BSRUe1PniStrzv9pf37eXT6a1N+UDUHCpdptCZv
 IE97YUlLXhPfqmxGtzzzR1gA3tpEoGuUCUKNO+9WYJzQWhgkzbufablKAYSj14wmUNDT
 XzIk2rq1qSsT7lcvkdWtctveMsxnuSdUMPMZ/E7OFULqWHJFEOTg30xLXR39a1kBJLTq
 h4tX383Ha2syoTf+vWoAFeBvUYjooKIsOKIqLD8nOUrzTp0jNrBndJH1acUGX3tJMsH9
 wg0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709152663; x=1709757463;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=734VRFAtk9Y4gpXSq/ySW6oX2l2zgK2V0Of4TOS5X38=;
 b=Rz4mTeF6A+2MrrWxoKoZ9zEdWvK/dQW3EXZFtIhixuqH9xz2dacyB1+iVuMP1QbJnR
 bPcdyr73yVoPowItQgVbmM2Eafnk4VlrYQGIEpUdzwiHSJfT8Pn+7Qpd6IIIYfIKryhP
 r3Wyn35rs+N4Oovpwq3o0WGehSQhXGalso9UFQ5WtlWGmz7zwV4Bei5tUa6yWiwGFWBz
 AF5HxYgfF6b9KQlTfXSpHKJKMpQQWUpeenZPknjJaUp5hJj0IlECZdNXNk2foNJxkwru
 6uznOtmuV/EITACZLzM9esfExIkXqiSK1XB+JVtIZ0R4irbIicUs0N1+STU24ThPbFD7
 sIRg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQZ8POxRUtIUmsvivHKv7ca2aGFxmxfK33zu/Mp4u3anLmWNYOX77JJT7hXRQ9Cz0R7NIXXJDCFfXQXUy0ChkR8iTfkzk=
X-Gm-Message-State: AOJu0YzjdaMauIr3ou166zc+DchycA5k+/0fig5ftGH7dDh7mFIukqyw
 s5CsyMlMZ0K3C2SwfHdw6YPWk1rXlnlNaJdBDVnD4uWh1wEYfuzpTNbAAXK04iE=
X-Google-Smtp-Source: AGHT+IE/e3qiZM3UpR6hiEgqZLO9tYCzJB1KjUvulX9d7ZF/MXE5gl/S5hh3OoJgj1Rsf5HTPJmBXw==
X-Received: by 2002:a9d:69ce:0:b0:6e4:94a5:980f with SMTP id
 v14-20020a9d69ce000000b006e494a5980fmr11826oto.23.1709152662762; 
 Wed, 28 Feb 2024 12:37:42 -0800 (PST)
Received: from [192.168.6.128] (098-147-055-211.res.spectrum.com.
 [98.147.55.211]) by smtp.gmail.com with ESMTPSA id
 t124-20020a628182000000b006e52ce4ee2fsm127203pfd.20.2024.02.28.12.37.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Feb 2024 12:37:42 -0800 (PST)
Message-ID: <4675310d-8c66-4c06-81d2-28c36fcbbdbb@linaro.org>
Date: Wed, 28 Feb 2024 10:37:38 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 02/22] target/arm: Add PSTATE.ALLINT
Content-Language: en-US
To: Jinjie Ruan <ruanjinjie@huawei.com>, peter.maydell@linaro.org,
 eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20240228092946.1768728-1-ruanjinjie@huawei.com>
 <20240228092946.1768728-3-ruanjinjie@huawei.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240228092946.1768728-3-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::336;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
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

On 2/27/24 23:29, Jinjie Ruan via wrote:
> When PSTATE.ALLINT is set, an IRQ or FIQ interrupt that is targeted to
> ELx, with or without superpriority is masked.
> 
> As Richard suggested, place ALLINT bit in PSTATE in env->pstate.
> 
> With the change to pstate_read/write, exception entry
> and return are automatically handled.
> 
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
> v4:
> - Keep PSTATE.ALLINT in env->pstate but not env->allint.
> - Update the commit message.
> v3:
> - Remove ALLINT dump in aarch64_cpu_dump_state().
> - Update the commit message.
> ---
>   target/arm/cpu.h | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 63f31e0d98..d6c3f8a935 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -224,6 +224,7 @@ typedef struct CPUArchState {
>        *    semantics as for AArch32, as described in the comments on each field)
>        *  nRW (also known as M[4]) is kept, inverted, in env->aarch64
>        *  DAIF (exception masks) are kept in env->daif
> +     *  ALLINT (all IRQ or FIQ interrupts masks) are kept in env->pstate

No need for this comment addition, because it is covered by...

>        *  BTYPE is kept in env->btype
>        *  SM and ZA are kept in env->svcr
>        *  all other bits are stored in their correct places in env->pstate

... this existing line.

With that,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

