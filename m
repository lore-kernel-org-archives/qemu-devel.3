Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66023C48BF8
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 13:12:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rd8sC-0004mi-Lz; Thu, 22 Feb 2024 08:12:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rd8s9-0004kp-6t
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 08:12:21 -0500
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rd8s7-0000MA-M1
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 08:12:20 -0500
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a3d01a9a9a2so175962166b.1
 for <qemu-devel@nongnu.org>; Thu, 22 Feb 2024 05:12:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708607538; x=1709212338; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EqSjZC1nThH+60RpnyFAnx7cLLySr9VnI2qzBiwx1us=;
 b=arA9RRL4M35B/OJuzR9DL3V49x6aG8YbaC3V63ukxMV6xR8BIXdd7N3nGxIuOqYRiC
 /q4tCRBE0kNxoULGj7+ZqZQ7i6udRWVoZKDH0tw5ozK8wVfCFm300/GW7yof2AFEmOV3
 jsPzf4s9HDyCnso7RxYvnwdwNrG0I07cxVF+N5CaRkmBOGkhWDtNXh2djffslnQp/C69
 y+OSRYHEDsCImPSTu2NYHUxATRw/uqkobUfo/9vQNva5NiPv1xl7cvvHagahr5DCEAMO
 qzL4B3x+ZWB2vCRhxTsk3deqgrm69KKSfejnAZtLY6o2h5bxfxEmO7mB7yu5FQwYNvCT
 ReSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708607538; x=1709212338;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EqSjZC1nThH+60RpnyFAnx7cLLySr9VnI2qzBiwx1us=;
 b=KhgL5ELZcFhYO+eVXv6kWN3YJT45PKOL2YeNHNOumMiy/0TlGjSNheUIb3WHsugw6s
 iW0p3pQ6cYDmWBPD1QMwYhtOm9KscN32+ujUMGYwvksSVYqXxfLmyOlHKnhA2azWwB5o
 JEbbrlUInuntlaHBLo3q8DVR1XLIMBvPx5qOtB2Imo5fiCGxqu6YABA1ne2yzCxrsTy1
 YmAOw8T2LP/a2KSF1KQgXwVGIZO97CZfaljf9/Qph1YTaVxLMoOMi9PXqPZGTbRDEKMR
 3B5Dc+tVG9pV8uQZI5X7u7CL76qVorEUly9/S1kZghEft1Wyv7nA51GTsDLEh6U8L5EV
 hEXw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUSMhT/E/AXJCVkm9X6+0SVA7SS4Ri68WjSVxzDqEcjs1DzZYzuq9CPqZFTlmklPj2imLVmeQHvxHT+Wy/QlCLTpeZK5Ms=
X-Gm-Message-State: AOJu0YyZSKCxm2Gzyu/mXMKQJ87FcJ6ieqSa1vVvjdhmsQx/deUZldSH
 o+KEYG2giiKhYyTN50ouR/l4kRE2UDY6uZ+UCk4/ZO9ZNbJQxCr9DR2pIog8pYQ=
X-Google-Smtp-Source: AGHT+IGT8FogQWHjTt9aLOi0iRHkG7DSnZo2vb1ZQzgPB4SPy7czrtn1cLMVDdXpGksaKGVV7ccb2A==
X-Received: by 2002:a17:906:b150:b0:a3e:c8ca:7fc6 with SMTP id
 bt16-20020a170906b15000b00a3ec8ca7fc6mr7127935ejb.25.1708607538066; 
 Thu, 22 Feb 2024 05:12:18 -0800 (PST)
Received: from [192.168.69.100] ([176.187.211.34])
 by smtp.gmail.com with ESMTPSA id
 g23-20020a17090670d700b00a3d80d7f986sm5901907ejk.82.2024.02.22.05.12.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Feb 2024 05:12:17 -0800 (PST)
Message-ID: <d8163be5-9812-433d-a140-7fc21e4c778c@linaro.org>
Date: Thu, 22 Feb 2024 14:12:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] .gitlab-ci.d/windows.yml: Remove shared-msys2
 abstraction
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>
References: <20240222130920.362517-1-peter.maydell@linaro.org>
 <20240222130920.362517-4-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240222130920.362517-4-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x632.google.com
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

On 22/2/24 14:09, Peter Maydell wrote:
> Now we don't build msys2-32bit we don't need the abstraction out of the
> common msys2 handling from the 32-vs-64-bit specifics. Collapse it
> down into the msys2-64bit job definition.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> v2:
>   - drop now-unused MINGW_TARGET variable
>   - document why we need to set MSYSTEM
>   - restore comment text truncated in commit 11961d08fcbddf
> ---
>   .gitlab-ci.d/windows.yml | 85 +++++++++++++++++++---------------------
>   1 file changed, 41 insertions(+), 44 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


