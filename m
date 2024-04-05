Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AA78CD11C2
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2024 12:55:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsj6W-0007nB-Sh; Fri, 05 Apr 2024 08:55:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rsj6U-0007kC-EC
 for qemu-devel@nongnu.org; Fri, 05 Apr 2024 08:55:34 -0400
Received: from mail-lj1-x236.google.com ([2a00:1450:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rsj6S-0001Ju-C6
 for qemu-devel@nongnu.org; Fri, 05 Apr 2024 08:55:33 -0400
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2d68c6a4630so25115511fa.3
 for <qemu-devel@nongnu.org>; Fri, 05 Apr 2024 05:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712321730; x=1712926530; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BubfJP9zd8RoL0HhpEk2K5XqJmva/oCm3FQwUS/XnlQ=;
 b=UrC9cNOoDG6Xx5Sp7uDOvB5pXmgUqp1r6X9396T23QG5MeWeh8SB16zB0iJw+9ZRCm
 lm4V9VYDYuM6/0hlYc4t3rwdwWum1himQ+WyCEY2pIYEjGM9wwJxKGD+uMHYXvEbWWg3
 xaBKqQ6FMe+fSBQP+W+JzzhhzDim3wQpXpnmHHcVAUY8PyyeMtOtUzFFywiK9zPzvgJ1
 3ed6eGxD9boJ2n+o018NTYEUYwefWkey9G+RvQOThFkix0pRbRbliB1xLwuRpdetV3g9
 A2Z+blyvR6h6GH6QcP65DxH9tMtBn07V9C7AmgFhSAeDm+DsMUBSESh19zkdu0OJn34n
 4wTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712321730; x=1712926530;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BubfJP9zd8RoL0HhpEk2K5XqJmva/oCm3FQwUS/XnlQ=;
 b=h7W2pRllg1XpG9GEZ9gjO7iq52iOmjeQ3Fb0X9NwfN7XBapqwzKsHIPFoFZjklS0Hy
 KK0RzhVAS2ojmZuG8RUE6/ytAenmOsJMOOeybGUjW1icqRAsvym4VSda1qQpDwjJk6Sv
 5x3lMWwd70EqSM4YrS+xzHjctoJK1AGRVCqG2Uqk8R9qzZX4CPkc1DkjUObjB9FcoEn0
 Ult4Xe1KTEL3ukcbng9ETFagYNcRQxW6lgTekDVb8GfaIdMA84bqhA/q90hV58FYbhdz
 9z+Pb0r2mKRG9NEU+FuGs5kWAnboQSybtbOyDAPQlUkpydJbrAuAh7CgefxofDg698dq
 8JUg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXr+upkz7DsqIepoOlCYRpaHK3qaxVZZLbTGXiPlE8xrKgLg2/ZXIMwvVrBohTP5bn3EU18eUiZA6LAtC+13xb3+EQtAxc=
X-Gm-Message-State: AOJu0YxMBrnIxt4b9rheatt+YzBzs9/RyJ7UMWuKzuF02yyp8XYLojNc
 rgN9aYQEMZDzZKOKsJFAAiwa5IXaNG+XXw+rdHEtX+bsqCAiQ6PMkEEVVwanDLcXU9Fo0DN/ZSu
 3
X-Google-Smtp-Source: AGHT+IGaywxCnLxnoIjFNDfhCzzlyyWIlLVrjdxvI2ZGfOnjGeb7PUoxPKZhXNMCcq9SWQ4zc3BA9Q==
X-Received: by 2002:a2e:a36b:0:b0:2d6:c5c6:f5b1 with SMTP id
 i11-20020a2ea36b000000b002d6c5c6f5b1mr1213110ljn.23.1712321730408; 
 Fri, 05 Apr 2024 05:55:30 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.216.34])
 by smtp.gmail.com with ESMTPSA id
 y10-20020a1c4b0a000000b004162061c704sm6176254wma.29.2024.04.05.05.55.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Apr 2024 05:55:30 -0700 (PDT)
Message-ID: <54ee63a3-5af5-4406-93b5-e3753d3a811d@linaro.org>
Date: Fri, 5 Apr 2024 14:55:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 30/32] target/rx: Use translator_ld*
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
References: <20240405102459.462551-1-richard.henderson@linaro.org>
 <20240405102459.462551-31-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240405102459.462551-31-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::236;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x236.google.com
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
> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/rx/translate.c | 27 ++++++++++++++-------------
>   1 file changed, 14 insertions(+), 13 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


