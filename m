Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DB0EC25B4F
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 16:32:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4kCP-0001dW-Sl; Wed, 08 May 2024 12:31:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4kCO-0001cy-3b
 for qemu-devel@nongnu.org; Wed, 08 May 2024 12:31:20 -0400
Received: from mail-lj1-x22d.google.com ([2a00:1450:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4kCM-000158-2T
 for qemu-devel@nongnu.org; Wed, 08 May 2024 12:31:19 -0400
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2e3b1b6e9d1so33677821fa.2
 for <qemu-devel@nongnu.org>; Wed, 08 May 2024 09:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715185876; x=1715790676; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gtXS2FFJVYDrU4QGpca4zyqJJG3C52e8suS9Bf2oxrY=;
 b=WnDcj+hHRkVoR5EDTIyFc5gFAYmEqnvpSEAY7iibPFHy68bj6usI+/PTY4bDR4PMt4
 dFF++j2451wnmk1GXwA0sGpj5LX4z6ZQk/vGb0/74BMMwSerh9wcIN/YB15VdLM8pbVp
 Y9Atjmw1FyE4N6QJtCqk+c8FxOkRk3vuLNmpj4QShJhxDce7mFCLbeWSca7GOoLt/pX2
 ypaX5U6G7sK22WJt2XluCMCoWsrmy9EEZoZsTQ0Vhig7BCZ7J8m1asS743w5xl46GBEy
 sVDm3hMbj5YJ0nf5UALym/ZYF98OC6tOpN6wMdnpFCioMtjbUdlUjtrYoiwmrsvtp7pO
 mqyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715185876; x=1715790676;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gtXS2FFJVYDrU4QGpca4zyqJJG3C52e8suS9Bf2oxrY=;
 b=FqCZ78o4gA0IJMmMI1RIpadlijkE5SPXv5SBz2QPdu78Z9O58peo7dL9chwjrgo8D7
 EtXEd+PYaprx0oVB3ehoGm7bdNHutOiNvn+TRuaHvQFnEGX5KwfSsqNwHBoarpA47qbg
 g+UUDMKx0yA9W2b8wc0ZUHMk3ePK2WdI+yYvrDp6zxWfMTSvJdPGziyd5XwhWirVLRvN
 9TVFP9/lq1ue5105KuRjTpropWsAnVppu96JQq1o/5FMqtvZ3EKc09maf81LzuZ5iFPA
 uTp7J2cL9ZWitNJ2XKmOX8/+lj1YtHFIMl92g2OsH8F3KmT+x7e5WzmdGCiEsgkVS/uX
 tGwQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVU+PbotrYFePF38eMeWadzXNh0ZljtU4dlabus5s5IO8GdX+OpM/jZKCXCeQ/Qkc7lxRyrpK7V8AVvbi7QpmkcDc2rSwo=
X-Gm-Message-State: AOJu0YzOjYd6wjpESSQ9+mVzv41DTH+HYNcxouihc9bKZT0GST7E7Au/
 J85+XN8est1O/nP560KG/Uus4kUN+ftxCvR4TooKTF+K06ngFMBdX4RLOQoAgXU=
X-Google-Smtp-Source: AGHT+IEPSc1Ai1wrtaztfV2LiklhhC/lYJul+a615lDABIxzhPrGBeJkzj+F/C7tTvzR5LaGlYka4g==
X-Received: by 2002:a2e:8088:0:b0:2d8:3e60:b9c9 with SMTP id
 38308e7fff4ca-2e4476ad097mr18787661fa.33.1715185876019; 
 Wed, 08 May 2024 09:31:16 -0700 (PDT)
Received: from [192.168.69.100] (sar95-h02-176-184-10-250.dsl.sta.abo.bbox.fr.
 [176.184.10.250]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-41f87c254bfsm28578735e9.17.2024.05.08.09.31.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 May 2024 09:31:15 -0700 (PDT)
Message-ID: <9023fb60-a88d-4f1f-a896-8da2fef27292@linaro.org>
Date: Wed, 8 May 2024 18:31:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 29/33] target/riscv: Use translator_ld* for everything
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20240424233131.988727-1-richard.henderson@linaro.org>
 <20240424233131.988727-30-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240424233131.988727-30-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22d;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22d.google.com
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

On 25/4/24 01:31, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/riscv/translate.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


