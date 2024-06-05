Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8623C41513
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 07:50:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sElOa-0001Fy-SY; Wed, 05 Jun 2024 03:49:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sElOZ-0001Fo-AP
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 03:49:19 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sElOX-0002lr-2N
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 03:49:19 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-42133f8432aso29147135e9.3
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 00:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717573755; x=1718178555; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=usOjHncLBLD8KS2IJCdtVOHkj+4nsfnbmIcZZPO6GK4=;
 b=bBT9OXqVfyvVSRbG0yCF1K0EgenXSG9IWbqP3JB6TqZpndY6eLxetv6d7Zkr5myzWK
 FvYwDidGhpVZNXZFLWFVS/uWR8vz2bzb5WDOgxu6BxPUACbtuUrFMSg5C1X7GEYPQLRA
 QJ4q6U9zNmKqs4RutA+6l3TlF1TsL2ytRrLcyGh4vsxcMnHyLyzg9/Hassn0+UbpHJP7
 k9/e6KbfHsFaztQ2cMJy2li7RodGtvekZGS87pCAprYpzCT5f+pzbn+4Ar0ZEF/p0u//
 n7QiyaELxUnMYN53tXiIOzuk9o+Dx6n+YAPxX90L6dJrnuzTEe1bUzcQ1Rw5p8LO5M44
 burQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717573755; x=1718178555;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=usOjHncLBLD8KS2IJCdtVOHkj+4nsfnbmIcZZPO6GK4=;
 b=pWuRqrXmyYogASML7pKx7T2MIQ3H3D93dTd3iqYq54w2M2Gbv8QJUFWtZFc/qF3fQp
 Ugm8XdRdAfOlB78wug+oSYlRWqb+6urtRXf6HyUE/f8fSfT9zqd7lbI+E/K5Pg+w4GUg
 eel+J+byMpZ/pMTnJkt4G5PQA4tOc0My3WDzf4T4UJSCT0Mg5ux+zl5ekm+rsDaE3C33
 6kYe2nDD63EjpdDHO3amGg2ZsMxgxBV+0Mwi7Bq26Liwh30KJlFbVLmNiXd8esJNmuE2
 IXgFl61G8QkNhBDBcQhze8k4yd8scLc5Q9E+XDtIB1OeL41N7+3npaoDjxmJHfQvL08M
 6B2A==
X-Forwarded-Encrypted: i=1;
 AJvYcCV/uFkJxBp/gPhYqimWI0SeFiAeGfVUFWbr7jC2nB8jKSxViT+WUT1AaOQMissOL/laoFaav+HahKw5mmT6/7SD0en/eSU=
X-Gm-Message-State: AOJu0YzoDQXEiHGoZCWyLUhY4rVjxiAw2MHKRa6svLygJtTAvmCA6CFD
 yb8CJtNWniPpGbYVh9rnowKJ3YZ6sdN7IgahGzFmsiTZq/XnOYkv0tIFMmLZxns=
X-Google-Smtp-Source: AGHT+IEBFHJriGuOcz+8/1OdbJJViYEjOvOKKUaYIWKwDH9UYXbgLiAWM6w21U1YdAbI8+PXaqcaZA==
X-Received: by 2002:a05:600c:a47:b0:421:28e6:990b with SMTP id
 5b1f17b1804b1-42156338a1emr14453715e9.25.1717573755120; 
 Wed, 05 Jun 2024 00:49:15 -0700 (PDT)
Received: from [192.168.60.175] (144.red-88-29-107.staticip.rima-tde.net.
 [88.29.107.144]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4215811cfc1sm10474555e9.22.2024.06.05.00.49.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Jun 2024 00:49:14 -0700 (PDT)
Message-ID: <221890d6-e5f9-44fc-aee9-6444953450c8@linaro.org>
Date: Wed, 5 Jun 2024 09:49:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 23/37] target/sparc: Implement MOVsTOw, MOVdTOx,
 MOVwTOs, MOVxTOd
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
References: <20240526194254.459395-1-richard.henderson@linaro.org>
 <20240526194254.459395-24-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240526194254.459395-24-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

On 26/5/24 21:42, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/sparc/insns.decode |  6 ++++++
>   target/sparc/translate.c  | 36 ++++++++++++++++++++++++++++++++++++
>   2 files changed, 42 insertions(+)


> +    MOVsTOuw    10 ..... 110110 00000 1 0001 0001 .....    @r_r2
> +    MOVsTOsw    10 ..... 110110 00000 1 0001 0011 .....    @r_r2

OK.

> +    MOVwTOs     10 ..... 110110 00000 1 0001 1001 .....    @r_r2

OK.

> +    MOVdTOx     10 ..... 110110 00000 1 0001 0000 .....    @r_d2

OK.

> +    MOVxTOd     10 ..... 110110 00000 1 0001 1000 .....    @d_r2

OK.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


