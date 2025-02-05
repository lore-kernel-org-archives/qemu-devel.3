Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C901C02192
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2025 18:06:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfjmH-0006Ji-8A; Wed, 05 Feb 2025 13:05:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tfjmE-0006Iv-Mc
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 13:05:30 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tfjmC-00061I-Lj
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 13:05:30 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4361b6f9faeso143465e9.1
 for <qemu-devel@nongnu.org>; Wed, 05 Feb 2025 10:05:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738778726; x=1739383526; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zo9/m3xCEAnKO4BT4XNjB0k3jHWQwkUwoQ6UogUx5iA=;
 b=N49C8RPnzmq3J71peROqw6lLqxsUjX9c+eqO5tJC9tk5Eaibl1+BFA1FGFqIs2bZ/w
 ocbHaV33hYTXpTCGxNwwmUlZipMGuDr5dyDOTViAa0LgVsiHGBvBYO49Lh3Poeb/Zdha
 00oiFGGH4Ak0cWxnWXOy/8tOAiOPcv6hmLSKWQ0cMiQrIwklBk6E80Alg3OMFEeObDU2
 7rMFZ+R4qepSEdBnQpSsDQf4WiLVoQDHXByv7v0+P5hFd/xhUzO1N5LqEYWSrnIF/L6n
 lvDKUS5Io4mTlZz/HZH9JvPSqMpX64E2oNXwFUDlV0IpYefIHY3BSCxa4qTVIGo43xIm
 vjhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738778726; x=1739383526;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zo9/m3xCEAnKO4BT4XNjB0k3jHWQwkUwoQ6UogUx5iA=;
 b=hM0AJv1Zynd2J3AZPi2T1hogcby62GRElfjN+UQ4UYDiAIvusCpEqa7n1iyU7Tt89E
 LZod1QhrdVF9bgEkJ4bP/2nuNX+bOpR7F7yAq4ty5aCI42q8QtUiLgO1R+F++tVCNr0U
 uyNIjMzyie5gajZc/qgoAiBB8hBA6WUX9EW/YP/cfOaY0NWTDEN3Tcc9HDTQqmqb+19/
 ItCCm7CeKqRGQxgFiZTK+82tKo9PcD+tkhcmmzvuuOe6g0WjGOfKRb1k0uqvC0y+ICEG
 zvgnwgls0cdlKp7CB6X/cdMoJRRGXghThfhdAkI3njyQuTfU8fzHvNqzN8PYGGMzPqec
 /tgw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVA44qFrRxWi5+JOalt/N/ITqureXj35TnNZCm5hJScZjJG4MY63n+C9SVOHd1H7o2lZiP32OU32ZFn@nongnu.org
X-Gm-Message-State: AOJu0YzfDg/GpYLSXqcSkM1V+1u/Fz0YmHx4oOAfeYnTeItO9FzlgJkf
 YV0DJobMn4CRbrZxZTCBpJi+gmdZpiHR1y7Y949+5NUoKwhcxW/X3ucyMf248JuqO7zpnOj31Dg
 tzx8=
X-Gm-Gg: ASbGnct3UnDYHM3xM1tC0JW4RBTcQ6C8BYaUhwSvgXTt25le8SzWgHimijAe1SLcjoJ
 nIsSNrW2iRP9HZmpBpSUPCsZ01EfZTZ9+3LjOu5lTRmGrfYJjIdzYCULGr3eDVNNckjzC2ZXfPo
 5dtn7fMb9WnfuszXiiyEbeQvxWvTwIhle56mz1TzRPJAqC1bilnWQjwdjj1ggmCpRJwl/verZtS
 EtU1XOSTIJJWWdoJ9RKjaEuMBb5FXHdSgywWOwGMh9KTW43pIYZgRgv0Xf1Z3s1BkFcWO29NxGN
 rdoSXh2cWmq54zXl8IPA4srlQ8JOEJVXh/1k4ng7f/PrIkFBbHLUivP5M5s=
X-Google-Smtp-Source: AGHT+IFhUgxX7tufinqtLSA7XT13ZmZrW5xE1Pi3Aee4vCmtpfO/Z2bCEXzcSjduNtOx9cpDltga5A==
X-Received: by 2002:a05:600c:5249:b0:434:fddf:5c06 with SMTP id
 5b1f17b1804b1-43912d10a71mr2598995e9.1.1738778726075; 
 Wed, 05 Feb 2025 10:05:26 -0800 (PST)
Received: from [192.168.69.198] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4390db110dfsm29635305e9.36.2025.02.05.10.05.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Feb 2025 10:05:25 -0800 (PST)
Message-ID: <adce8772-d473-4b1d-b0f4-1f921ce89932@linaro.org>
Date: Wed, 5 Feb 2025 19:05:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 11/12] meson: Deprecate 32-bit host support
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 berrange@redhat.com
Cc: pbonzini@redhat.com, mark.cave-ayland@ilande.co.uk, thuth@redhat.com,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20250204215359.1238808-1-richard.henderson@linaro.org>
 <20250204215359.1238808-12-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250204215359.1238808-12-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

On 4/2/25 22:53, Richard Henderson wrote:
> We deprecated i686 system mode support for qemu 8.0.  However, to
> make real cleanups to TCG we need to deprecate all 32-bit hosts.
> 
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   docs/about/deprecated.rst | 7 +++++++
>   meson.build               | 8 +++-----
>   2 files changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> index 4a3c302962..7c61d0ba16 100644
> --- a/docs/about/deprecated.rst
> +++ b/docs/about/deprecated.rst
> @@ -204,6 +204,13 @@ is going to be so much slower it wouldn't make sense for any serious
>   instrumentation. Due to implementation differences there will also be
>   anomalies in things like memory instrumentation.
>   
> +32-bit host operating systems (since 10.0)
> +''''''''''''''''''''''''''''''''''''''''''
> +
> +Keeping 32-bit host support alive is a substantial burden for the
> +QEMU project.  Thus QEMU will in future drop the support for all
> +32-bit host systems.
> +
>   System emulator CPUs
>   --------------------
>   
> diff --git a/meson.build b/meson.build
> index aa1ca8355d..3347b0a553 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -4843,14 +4843,12 @@ if host_arch == 'unknown'
>       message('configure has succeeded and you can continue to build, but')
>       message('QEMU will use a slow interpreter to emulate the target CPU.')
>     endif
> -elif host_arch == 'mips'
> +elif host_long_bits < 64
>     message()
>     warning('DEPRECATED HOST CPU')
>     message()
> -  message('Support for CPU host architecture ' + cpu + ' is going to be')
> -  message('dropped as soon as the QEMU project stops supporting Debian 12')
> -  message('("Bookworm"). Going forward, the QEMU project will not guarantee')
> -  message('that QEMU will compile or work on this host CPU.')
> +  message('Support for 32-bit CPU host architecture ' + cpu + ' is going')
> +  message('to be dropped in a future QEMU release.')

This change still allows us to remove 32-bit mips host support before
the other architectures, right?


