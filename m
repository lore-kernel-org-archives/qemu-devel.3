Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3B1CC54798
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 21:32:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riLKp-0006mo-IX; Thu, 07 Mar 2024 16:31:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1riLKm-0006mZ-MR
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 16:31:26 -0500
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1riLKl-0007GL-0i
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 16:31:24 -0500
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-6e5d7f1f25fso157433b3a.0
 for <qemu-devel@nongnu.org>; Thu, 07 Mar 2024 13:31:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709847081; x=1710451881; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YutcmB2SuoGBo9GRtiubZ6yt+agU5S1HpNd46mXUpfs=;
 b=iUM7qa6wnyDipFxOisPtjc8f/gTEzbyDOaBzeU+l/XRvo1gTGzU145I49vrOfY2kTx
 QbDuldVXANbN2U9DB7CStzOSd9GifvAvbgM4D6vwwee2WwrMsZz7PPQ+s3C3opb5gpGN
 KWoILA/7meLGmpN3lFCYhDoOQ1BACUkHXWIsL8gQvkBou5zncpasjR0GgWuQ6PfXgWLc
 WTmcppTTtIS39wb4IfzUvYA7jdtRrr6rPq80uxfHOETKgheqSWxziM1X8tgjOg9YeOu8
 /yl16CfxkKEv0cjddjjoiFogic18109sh8neXqc7pxGQjTMcHKyUm2boHO0aOI2uxmFP
 uf5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709847081; x=1710451881;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YutcmB2SuoGBo9GRtiubZ6yt+agU5S1HpNd46mXUpfs=;
 b=DhEAvMMJfei9crZ2O47BeocVnAmSqqJjhkDotzA+g8K4FHxAbXh8ryXNTYiwX9tszP
 ygJu8ZMj3pFLfJ775SGujP+3qLxmZh+dvj9eDZ6yPrD3clhrNZPqtlQA9rMAnVkghrfu
 37E/b87uMC+ibqmYjAGuVp69TgnSiKfiXe6G2Jht/a0JFIctkFj4cnci2CeQgmlrXr+Q
 P9+3y1oVFiJ9IAVNP4Fd3qjgZKfdsQVzHRG2DSaYwh5mYqVI/iXxpWNbIQ1KUNENgMiZ
 9RB0kmh8aiNtPUxqYIyCHcmSETuQHo4gL2X6ZJbQ8fJoeH5lK6he7H7KGpxU/pArTFD9
 I2iw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXuTvLN04AKqwfhX2XY7qGTPCN7VYgveRqha6vi3l6h9JMCd5fN0tTA8IpyNQq4lp8l1HHj2hKum/DboR7bdtVmy51MFhw=
X-Gm-Message-State: AOJu0YyuUIrYyj/5zL1KiHQKvdQTOHihNASf7bV/bMAOaY0C/bpRydSY
 Sp7VuPBjFluLfQfQ16LonPgO5E6tly8rcJ2qvS90fMuGmA1i6b7WHOgmeDl6HQo=
X-Google-Smtp-Source: AGHT+IHbye9ahm0m2eV/ZYaXaIrqPrKUVIEAieA83A1Sds+rFrGgfvBsC8XTzPNZHvxxO2k4ju78ag==
X-Received: by 2002:a05:6a21:6d95:b0:1a1:4da9:8d76 with SMTP id
 wl21-20020a056a216d9500b001a14da98d76mr10468906pzb.13.1709847080926; 
 Thu, 07 Mar 2024 13:31:20 -0800 (PST)
Received: from [192.168.6.128] (098-147-055-211.res.spectrum.com.
 [98.147.55.211]) by smtp.gmail.com with ESMTPSA id
 j17-20020aa78d11000000b006e6454afe10sm4429120pfe.205.2024.03.07.13.31.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Mar 2024 13:31:20 -0800 (PST)
Message-ID: <7e7ded00-ece1-42d6-91f1-2bc2f34a1ee6@linaro.org>
Date: Thu, 7 Mar 2024 11:31:17 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] target/sparc/cpu: Improve the CPU help text
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20240307174334.130407-1-thuth@redhat.com>
 <20240307174334.130407-4-thuth@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240307174334.130407-4-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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

On 3/7/24 07:43, Thomas Huth wrote:
> Remove the unnecessary "Sparc" at the beginning of the line and
> put the chip information into parentheses so that it is clearer
> which part of the line have to be passed to "-cpu" to specify a
> different CPU.
> 
> Resolves:https://gitlab.com/qemu-project/qemu/-/issues/2141
> Signed-off-by: Thomas Huth<thuth@redhat.com>
> ---
>   target/sparc/cpu.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

