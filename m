Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37157C54E60
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 12:57:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmZ1V-0001Td-VB; Tue, 19 Mar 2024 08:56:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rmZ1R-0001S0-Jb
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 08:56:54 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rmZ1P-0003YA-L5
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 08:56:53 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-41412411672so14334165e9.3
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 05:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710853007; x=1711457807; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=J5Sv9/suZ6LdYP7CJpL2Ej8ZarSFRVTKG+3v9aCGdOU=;
 b=kSSkCgwZPhGFpV4MD+gdKTVyKdALbCC7lAsRpmgaZo40KBRp6vNBwstG7IkRn6NNvY
 cbbNIyULp/1Dvwlkoih9eze6KtPp0x/zpOh/yLflUNAwfcnqiNruEaNUl5yyAhJhE0yL
 Sdx3cu2ux7//Sp/53PmJu33rJND2Y9rc2ep/Owrj7SR0tEYCcPlwZg6oduY5It7+Df5h
 9FvAHVd5jyrmWaM7DT+kaZvTjJTmHvgLrXfmaEevmqu170zFZ6o33WpSnRnD3RSWxtgQ
 F3rZjiCpNMzgpPToosMTisZM1vmXvQYCCArmLmgDv3y50Txryvu5Jaf/HPcqEMXy+t+7
 gDug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710853007; x=1711457807;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=J5Sv9/suZ6LdYP7CJpL2Ej8ZarSFRVTKG+3v9aCGdOU=;
 b=Mct1y27Uz1pNFt2Uw0lGboh1lkZi9YNKRgTOGHfeRZJYFsW8gT1jExWLn2Bku6lgBq
 P0hcwIeU0CmFwl/NFd1svzvUzIu1IMhrHyDqbmn77he+mzlpw78FsdwqQtaGFtyYGt5Q
 mv6Skka0HcxGfUjrS1P9N+GiUH/Ls5xKH7ZrSCEHl39eZycO61NgMOGjy1N1q92v0MfW
 HJkR3ynmdJ0KxKaFVPUZgiJv87hzJh4dW1m7DY09UoQfhb92bdhAYYvRL7dqL2KSgN/R
 y8QTBOAcrgtyvutueKcgMR9rJtBGVrHdymagspRY6cmd+iwEjv5G59FdFl8bqvAMEI2q
 Wt7g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWFBz47imHAfvbaJaZvIN/MmzRpcfhT21Eq+1/zJtrXxd5C0nNRD4bKe6AdD8QxsTdutMRuptDy+8598kF6nZz+uc/3UKc=
X-Gm-Message-State: AOJu0YxQySThFgKEQkCFkQyOV8Kubkys/EGf9h58k9gBVwKMuMnur0qN
 UFEFcUc8vq4rXRTN5jDuOR0MCkDGWhrmlajdAn4b/vPQtGNgYTdN0BniPsyHUPZ6XxpijLQNkJR
 j8PU=
X-Google-Smtp-Source: AGHT+IFRQ7LiRER+3OQu0TXcSYdgMWk893pBT3MjYKdFps9S647drLlpqNC9f3Unb8oKEHCgdCK9gA==
X-Received: by 2002:a05:600c:4594:b0:413:fc09:7b19 with SMTP id
 r20-20020a05600c459400b00413fc097b19mr9653128wmo.40.1710853007204; 
 Tue, 19 Mar 2024 05:56:47 -0700 (PDT)
Received: from [192.168.1.24] ([102.35.208.160])
 by smtp.gmail.com with ESMTPSA id
 u6-20020a05600c19c600b0041413546e5bsm5258854wmq.0.2024.03.19.05.56.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Mar 2024 05:56:46 -0700 (PDT)
Message-ID: <78dc8b48-cf8f-470b-96ba-ea39b699a8ba@linaro.org>
Date: Tue, 19 Mar 2024 16:56:43 +0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 22/22] plugins: Update the documentation block for
 plugin-gen.c
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org
References: <20240316015720.3661236-1-richard.henderson@linaro.org>
 <20240316015720.3661236-23-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20240316015720.3661236-23-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-wm1-x32b.google.com
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

On 3/16/24 05:57, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   accel/tcg/plugin-gen.c | 31 ++++---------------------------
>   1 file changed, 4 insertions(+), 27 deletions(-)
> 
> diff --git a/accel/tcg/plugin-gen.c b/accel/tcg/plugin-gen.c
> index fd52ea3987..c354825779 100644
> --- a/accel/tcg/plugin-gen.c
> +++ b/accel/tcg/plugin-gen.c
> @@ -14,33 +14,10 @@
>    * Injecting the desired instrumentation could be done with a second
>    * translation pass that combined the instrumentation requests, but that
>    * would be ugly and inefficient since we would decode the guest code twice.
> - * Instead, during TB translation we add "empty" instrumentation calls for all
> - * possible instrumentation events, and then once we collect the instrumentation
> - * requests from plugins, we either "fill in" those empty events or remove them
> - * if they have no requests.
> - *
> - * When "filling in" an event we first copy the empty callback's TCG ops. This
> - * might seem unnecessary, but it is done to support an arbitrary number
> - * of callbacks per event. Take for example a regular instruction callback.
> - * We first generate a callback to an empty helper function. Then, if two
> - * plugins register one callback each for this instruction, we make two copies
> - * of the TCG ops generated for the empty callback, substituting the function
> - * pointer that points to the empty helper function with the plugins' desired
> - * callback functions. After that we remove the empty callback's ops.
> - *
> - * Note that the location in TCGOp.args[] of the pointer to a helper function
> - * varies across different guest and host architectures. Instead of duplicating
> - * the logic that figures this out, we rely on the fact that the empty
> - * callbacks point to empty functions that are unique pointers in the program.
> - * Thus, to find the right location we just have to look for a match in
> - * TCGOp.args[]. This is the main reason why we first copy an empty callback's
> - * TCG ops and then fill them in; regardless of whether we have one or many
> - * callbacks for that event, the logic to add all of them is the same.
> - *
> - * When generating more than one callback per event, we make a small
> - * optimization to avoid generating redundant operations. For instance, for the
> - * second and all subsequent callbacks of an event, we do not need to reload the
> - * CPU's index into a TCG temp, since the first callback did it already.
> + * Instead, during TB translation we add "plugin_cb" marker opcodes
> + * for all possible instrumentation events, and then once we collect the
> + * instrumentation requests from plugins, we generate code for those markers
> + * or remove them if they have no requests.
>    */
>   #include "qemu/osdep.h"
>   #include "qemu/plugin.h"

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

