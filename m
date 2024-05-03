Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E740C4345F
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2024 07:21:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2nEy-0004l7-E0; Fri, 03 May 2024 03:21:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s2nEx-0004fr-23
 for qemu-devel@nongnu.org; Fri, 03 May 2024 03:21:55 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s2nEn-0001V9-9h
 for qemu-devel@nongnu.org; Fri, 03 May 2024 03:21:54 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-34e040ed031so1357270f8f.0
 for <qemu-devel@nongnu.org>; Fri, 03 May 2024 00:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714720903; x=1715325703; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gvyXMpq3KRl8b7A00MCBaNJOcm589IDAiFzYEzdYr/Y=;
 b=o86zksnYjwSLCXSpHDZ/MVKgvPm+/NSM8VDQ3nw3d+cU2WXG8+uZ+W9QWcVpe41yIN
 9YxnZnxFnvvSsL9NAcaeyNBsEUThOW+xkqxYVVTf735jyGSMhu4stGmmXJ38d7dkQyUe
 SWmXT5N37RGIoF6CCkwUozXwUA4cP8DfFdBTJO5rGv7QTJ/Zd5oEeSbXoGivMPdwWp0b
 m2IahqOEtJqPti6cjPzpQjYjaAhCsyZskzC9Vx7pbnUb+dWvRVK9wvd4HgrEj5ldijTU
 t52RdKjEHUwit/DXnZd6TTRwyhk7ucnXLKXCVQz1o8JV9ohoQnICP+cvJTuj/hMKFVdO
 LhuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714720903; x=1715325703;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gvyXMpq3KRl8b7A00MCBaNJOcm589IDAiFzYEzdYr/Y=;
 b=p4iY/+6d9jpMK0Y9vjQ3u9Uu/7GqFukHySdZugSEfOCbbNsINqBt+XqMKEFAe+i4K7
 MLCuD9l572urVIMxkPg+ZN9PEyEf8wKHWqUzMllz2uWj3zyfU1EoNvYF8NU44pxv3PjF
 H2+TJQg3mfmwTy/tEaPAhjHLfXgg6YEURRvedMNwrGRqc42fdo7a6gcCTPZnf2w7zzQb
 BmS+VArr09PFIaKcq63B4XaMMS3SPsrY//jQlPnn3JnsSH21blk0kkWeKfN7ZPKVJ4jx
 jlgYg+cJYiJuCSM5yTVwl9eTTOc9GQDfnDTDGH+4q7CW6YPbUhIWe0ymvLWRmwf1/1j4
 l9fA==
X-Gm-Message-State: AOJu0YwJouxLaMEfPjS9+pQfV754gCSNrvxtzzAlrX16b+FXkwHIxIW4
 HUZ0bt75x7IjGjRpfEJ5PDZnkPID/76R6jDVFXbMXskKwGPP5UjKhJvDTaXrDdLMuMdUNO9VOqS
 S
X-Google-Smtp-Source: AGHT+IHpqUm7+WFEkXY38gsjDFfTNacsS70XNKa31EL0QKKbm6PCzrSWaTK41cbjZeZhNW2Ue3bbzQ==
X-Received: by 2002:a5d:4690:0:b0:343:41ef:ab1e with SMTP id
 u16-20020a5d4690000000b0034341efab1emr1379601wrq.44.1714720903171; 
 Fri, 03 May 2024 00:21:43 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.179.187])
 by smtp.gmail.com with ESMTPSA id
 da11-20020a056000196b00b00349ff2e0345sm3061667wrb.70.2024.05.03.00.21.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 May 2024 00:21:42 -0700 (PDT)
Message-ID: <bef6029b-2198-401b-b832-18a45467818c@linaro.org>
Date: Fri, 3 May 2024 09:21:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/9] target/alpha: Split out gen_goto_tb
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
References: <20240503072014.24751-1-philmd@linaro.org>
 <20240503072014.24751-8-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240503072014.24751-8-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

On 3/5/24 09:20, Philippe Mathieu-Daudé wrote:
> From: Richard Henderson <richard.henderson@linaro.org>
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> Message-Id: <20240424234436.995410-4-richard.henderson@linaro.org>
> [PMD: Split bigger patch, part 5/5]
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/alpha/translate.c | 51 +++++++++++++---------------------------
>   1 file changed, 16 insertions(+), 35 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


