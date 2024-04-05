Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76D04CD11C2
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2024 12:35:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsimW-0002XN-5t; Fri, 05 Apr 2024 08:34:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rsimR-0002X1-1u
 for qemu-devel@nongnu.org; Fri, 05 Apr 2024 08:34:51 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rsimM-0000Bj-Go
 for qemu-devel@nongnu.org; Fri, 05 Apr 2024 08:34:49 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a51a20a6041so80508866b.0
 for <qemu-devel@nongnu.org>; Fri, 05 Apr 2024 05:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712320483; x=1712925283; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Q+SpSWBTwfDmRqCvl0oOGUSH/rbbQFMF0JFkWBZOalI=;
 b=XlTc4xj4BS0l+8c5oGAikGRuWx5V7cunOc5AdDqb5SxYniaNhRjeHDTEhJQvMrWRpW
 0hYAESahEuClNolzs1qjduFrXJ3bZZRUWAitpFe8s/heb+bIi7XbM8rdRXzREKEnhuGh
 DpEMZYcaRYGg0ibtWpxrFskrITSaJqiuWn0OaegwVZ+83RYG6Xiy0C9C9eVn3of73JQe
 CqqyhfQRM+0nl6wgIGtzqMLktsjWe/f4LzAmpH0RbHw46oLWrDwtHn7APXre6NzcjDIK
 jVTX9R02EvKgnEhVMWVuPb2kSsxOt8s2Uf0kve63f/i1NM1nFlR940m9jFLW27+i/Na6
 QL4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712320483; x=1712925283;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Q+SpSWBTwfDmRqCvl0oOGUSH/rbbQFMF0JFkWBZOalI=;
 b=X+YTQRt/Nm7idWCoEsUUIf92O9y4fRrO1GGoY/K142kZtRF5YPQztLSryH7J79X2eI
 MEScHOaAd3arntbM9yuRSeouAXIR25z+0IpHylkBNIVWBVRtsSdskik/HNFdK4yruubt
 oeFBIl/dT2lQSj5ay+fYtKjExEkII3B5uM392o6QIJxLznt3zBq9Z34Z3YcwiTCwy4WF
 1p4R8uKsoffLlTE/aOeJk1XjGo+4F25K/i8adPzO7ClBs8hqDkktJiF5QyhQwuMhXMbK
 AySvnw/wZ0CpJyxGaPzXgkNH7Vs6H7DJpi9dIiDFvXBjCJFyXsWmPEYHyHZ7FuSXs+Gv
 d3ZQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX7Rm6nMUYJRBS6yQHxrbV6ZjMiA6P38PWtlAB+wIlKt1h9D5ZSRtcAtj6fmu1gNVWtofl1teM9au+jS3+qrI47LL1bz68=
X-Gm-Message-State: AOJu0YwIaGT3LlENPH1BHdpWOWR/ec7Td52Zepn3/4dgd4DmD8QO4mDN
 3XarP8fkryHji54FAgg+cpjZUgmrVMTpn1r2WW5zVTt1EZ1vF75mmjfykcgHyRw=
X-Google-Smtp-Source: AGHT+IGMyAl7IMj6OMxBrHJa1Wmk4wn6XSax18bmoYcjIsgjVtcKwQsL2INQg+sz0D2Q79O9wfPG7g==
X-Received: by 2002:a17:906:f58d:b0:a51:9f5b:b659 with SMTP id
 cm13-20020a170906f58d00b00a519f5bb659mr1276365ejd.34.1712320482998; 
 Fri, 05 Apr 2024 05:34:42 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.216.34])
 by smtp.gmail.com with ESMTPSA id
 dr19-20020a170907721300b00a4a33cfe593sm788878ejc.39.2024.04.05.05.34.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Apr 2024 05:34:42 -0700 (PDT)
Message-ID: <d726c941-de31-412a-bbba-0b1d950ecc23@linaro.org>
Date: Fri, 5 Apr 2024 14:34:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/32] accel/tcg: Use vaddr in translator_ld*
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20240405102459.462551-1-richard.henderson@linaro.org>
 <20240405102459.462551-2-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240405102459.462551-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x632.google.com
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

On 5/4/24 12:24, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/exec/translator.h     | 18 +++++++++---------
>   accel/tcg/translator.c        | 15 ++++++++-------
>   target/hexagon/translate.c    |  1 +
>   target/microblaze/translate.c |  1 +
>   target/nios2/translate.c      |  1 +
>   5 files changed, 20 insertions(+), 16 deletions(-)

Ouch, this diverges from my current work, but it might
eventually simplify it.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


