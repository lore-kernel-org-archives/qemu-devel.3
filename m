Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFA79C54E64
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Mar 2024 19:20:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ropra-0004lE-1g; Mon, 25 Mar 2024 15:20:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1roprX-0004kr-UN
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 15:20:03 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1roprP-00070I-EI
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 15:19:56 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1e0511a4383so33617635ad.2
 for <qemu-devel@nongnu.org>; Mon, 25 Mar 2024 12:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711394392; x=1711999192; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+WFDjnn9LJc0k0JFw5DQ94bVjAEQt/dukoC94eLnnag=;
 b=RGAixrVtA762+ewZ5WlamqGipNgIJn7K/PCkKjFBa0ErhCqr7YnSK7CnjdKgMNejAb
 HHtn9Gp6ErxGvyBRzGfEGu6bO6JdaBnQlqtu8nKALXCrgTOLTEwuALBibDhNRGucdAeO
 NGcOPwxI1kur++RM2jxW5xd+ixyipYU/hCUfvbAGL6fmFpnecfeEDiqsnm7GKpKBwHnu
 SKbCsZFvw7aLrNQJi7ecU00RNFOjqJkVAf6UDtOyvaidmT/V1Zd3mVLVMEue5pXK9Fsy
 z+HUxpRBpHQGCSYWP2X8sNiw9QxMR2o8h4YZhhrKmuwCgobY4P1iHcTvSTSpM1VL1TF5
 kTHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711394392; x=1711999192;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+WFDjnn9LJc0k0JFw5DQ94bVjAEQt/dukoC94eLnnag=;
 b=ju3PdBpzg6ag0vYhJbUc7JhgM+/Tu+kDHhD9kFPjWQ1KNfjlhDhlvvRn28msGKsi34
 S8jG5giTMZlWLYK4QNQw6ZDM4SZlb8N5evmckbe8Zlw+IQQh7NkPvHHUSYVO8P6YPXWt
 BMaV3P8QlmcljOzxJyc0ZJ6rQMXl4fZPFG1ON0O060ZGeeZcOmUXdWebj5UHYM44E6f0
 kMfWMcJZGr6/6d3OdzBoWYOg3YWwr9wxCgEzHaG7bhmNaW/6D+Cir+UtwFdB6L4fNvZO
 KKvAlXqivul5NjFFdIvlCF6z5YePTif/usEoLpzmmWnF8tXkY1f1YI4l+jNoanqozKkR
 Atbg==
X-Forwarded-Encrypted: i=1;
 AJvYcCULdRvqV933y8PhQaS+VMfpjgQDYP5GzSBsc2jYYM4RKRIDLfRMD3ctD6mekvm6nFQlbD3UXNxH+K20smtdtThVK5yC5KM=
X-Gm-Message-State: AOJu0YxFWrjpYe6d+9CmKFAfHhKpykKL9ZU7FapYGjgSh8aV2VUg4N3M
 nYMT9zehNqPrHGDK/Q7QtTQZOy1kXgECob33A+e4WkeLiFDLCg85DQ0Nl4ImMj4=
X-Google-Smtp-Source: AGHT+IE5I84dE8rJCEXnOyP0G5OCmeS/AaFPgj2ISVKCZKI01jyy+Q7M5lUQM2bwmHoQLdHCMM+lZw==
X-Received: by 2002:a17:903:2308:b0:1e0:b8df:1083 with SMTP id
 d8-20020a170903230800b001e0b8df1083mr4345918plh.0.1711394392454; 
 Mon, 25 Mar 2024 12:19:52 -0700 (PDT)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 c4-20020a170902aa4400b001e0d9dcae91sm628644plr.279.2024.03.25.12.19.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 Mar 2024 12:19:52 -0700 (PDT)
Message-ID: <21b5d745-5c6e-42e1-97ef-17587f31a304@linaro.org>
Date: Mon, 25 Mar 2024 09:19:49 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 8/8] plugins: extract cpu_index generate
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
References: <20240325124151.336003-1-pierrick.bouvier@linaro.org>
 <20240325124151.336003-9-pierrick.bouvier@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240325124151.336003-9-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

On 3/25/24 02:41, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier<pierrick.bouvier@linaro.org>
> ---
>   accel/tcg/plugin-gen.c | 28 +++++++++++++---------------
>   1 file changed, 13 insertions(+), 15 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

