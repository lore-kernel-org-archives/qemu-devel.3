Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E87B01125857
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 17:57:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0NoM-0007Bh-SB; Wed, 11 Mar 2026 13:57:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w0NoL-0007BR-5g
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 13:57:33 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w0NoI-000774-2e
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 13:57:32 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-439b97a8a8cso151524f8f.1
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 10:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773251848; x=1773856648; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UzBF831quJCO+x/LZKN/uVYM71kTJPysflvE4o3Jf3w=;
 b=b6ZMIcCK0Yb7VAyqiQcOJ86rdrsd8zS6SW72feS4yBjpPEJlPmRjbdqZx7+QJDhd5y
 Ke06wZIACGsp7mOApEjjaLm9V7m2bn7WyT16QCfey2x1wYqWOtY9epeTOXqunTzI+5Hc
 Sngpj7n82Nw+Vien3AFtpMIACLo9E35l0UKzmnAawvnqzBCBEb9kWV+AK5RUVeY0FsQs
 tZNxRqWO+SydEU2mkOyBEAGbdAkELVx8AWMUlafvLTuDiVRkC6leIIEE16Df+mLvOpy4
 S3JseMrixhRRP6WuHIgs5PDL6oUuB0MoRRFjsjAeKQQS6gqmSr11QqSIgYAErRFy4qPc
 MLTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773251848; x=1773856648;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UzBF831quJCO+x/LZKN/uVYM71kTJPysflvE4o3Jf3w=;
 b=Cytve/1LvAVCo1tit88aokMdgdKU7DjxNUm3bR+gnrCRC2JsKc5DwEJfUSgRRC5Q31
 0gck5qHUZEYye+fTeESHgR5MKrMU2OjnYPn7ap4vy2b0Gl9fqhgbTP2FFgJMziBImaJK
 X17Ri2Oy7O7Fsh44PjJ54ElhW5eBOdPIJwpVaFZm/7rv2Q/3VshMH92ZKjNSLbjEO3b2
 7lS3HYz3HZS7jtgIxpURNkhlW0xRfnhLHufYyhCdaZcy6jKRQqkRKGoRGPZtl69fTCiD
 OfCnC4TcSE1pYnfvQFo78A7GFRIyrfvBECltNyAYek1JBY6u6IUmbatUzzSRkD84STcV
 aacA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVUdTRcFTnzoAYNlhrNRNOAwoPNqE3Y/XMvCqL0TZuRYcd/OW1CfVb43EuJeRPcOTWfJMNK7f4jERhd@nongnu.org
X-Gm-Message-State: AOJu0YyX90oOZhUoY2N5x0aCK1N3DAnNkMmyT81gI8zfijL4jHknQS3F
 uXSvUINuSHXK2qy4uleYLF92MZW2RGHB4Z51cUPzDAhphpFUsdzIzvBfQw1oZIVruRk=
X-Gm-Gg: ATEYQzwDqowb1DNyIwvwgPghCHLH07jvq7cWFooyBG8xpj35bPlzP1Cm1JiaLLQgGBv
 i1GP3rDtZUUtrnnCzx7Y3tHhPsQITo5+dtRgrQBuGp6Et6SqUyy++tvEsTSo2mviWVHj2EcYlwZ
 dAg5DGLF8eL16T7LXWijkEFxfppIf4kdkKhvimOw1IZ8lOUXr6Va3KlP94ZrsIAc1oNyMewy4ol
 7M9kUFbUeJNR4Ok9L7gzvV5L0ReeKTaP+O91un2ggydMVOThEq630qGeZ5cYmemje86GoJpLB6u
 72k2RSAJNn/JfNxAiB6Xk4BkPXx8y9mvOCaWshzD2Rc9aG6weREZOyXU2O353clnwItv4aLvElu
 anwDXxZR/eBYmZDRAGC07YnxAoX3QKZa12TjCvxzRo0c2leoMg52jc/FUT90P7PEkaq5u3cVK7A
 uPu5fGOoWh/pExR8nlUva4t39iSUqpwB9ko9kfTiZBtBRMWdfC7F5dB7uRIUdrlzX/W9M3/RjKh
 ivA
X-Received: by 2002:a05:6000:310f:b0:439:bc79:9f8f with SMTP id
 ffacd0b85a97d-439f816d588mr7253309f8f.0.1773251847990; 
 Wed, 11 Mar 2026 10:57:27 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439fe1b287dsm991208f8f.17.2026.03.11.10.57.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Mar 2026 10:57:27 -0700 (PDT)
Message-ID: <991086d4-5850-490f-9ab5-af5caa07303e@linaro.org>
Date: Wed, 11 Mar 2026 18:57:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/9] target/hexagon: add build config for softmmu
Content-Language: en-US
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: ltaylorsimpson@gmail.com, matheus.bernardino@oss.qualcomm.com,
 marco.liebel@oss.qualcomm.com, quic_mburton@quicinc.com,
 sid.manning@oss.qualcomm.com, ale@rev.ng, anjo@rev.ng,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20260311042019.1085030-1-brian.cain@oss.qualcomm.com>
 <20260311042019.1085030-8-brian.cain@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260311042019.1085030-8-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 11/3/26 05:20, Brian Cain wrote:
> Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>   MAINTAINERS                                 |  1 +
>   configs/devices/hexagon-softmmu/default.mak |  7 +++++++
>   configs/targets/hexagon-softmmu.mak         |  6 ++++++
>   target/hexagon/cpu.h                        |  4 ----
>   target/Kconfig                              |  1 +
>   target/hexagon/Kconfig                      |  2 ++
>   target/hexagon/meson.build                  | 13 ++++++++++++-
>   7 files changed, 29 insertions(+), 5 deletions(-)
>   create mode 100644 configs/devices/hexagon-softmmu/default.mak
>   create mode 100644 configs/targets/hexagon-softmmu.mak
>   create mode 100644 target/hexagon/Kconfig


> diff --git a/configs/devices/hexagon-softmmu/default.mak b/configs/devices/hexagon-softmmu/default.mak
> new file mode 100644
> index 00000000000..08e709aea72
> --- /dev/null
> +++ b/configs/devices/hexagon-softmmu/default.mak
> @@ -0,0 +1,7 @@
> +# Default configuration for hexagon-softmmu
> +
> +# Uncomment the following lines to disable these optional devices:
> +
> +# Boards are selected by default, uncomment to keep out of the build.
> +# CONFIG_HEX_DSP=y
> +# CONFIG_L2VIC=y
> diff --git a/configs/targets/hexagon-softmmu.mak b/configs/targets/hexagon-softmmu.mak
> new file mode 100644
> index 00000000000..42e1e5c4f83
> --- /dev/null
> +++ b/configs/targets/hexagon-softmmu.mak
> @@ -0,0 +1,6 @@
> +# Default configuration for hexagon-softmmu
> +
> +TARGET_ARCH=hexagon
> +TARGET_SUPPORTS_MTTCG=y

See commit a3d40b5effa ("tcg: Convert TARGET_SUPPORTS_MTTCG
to TCGCPUOps::mttcg_supported field") from almost 1 year ago.

> +TARGET_XML_FILES=gdb-xml/hexagon-core.xml gdb-xml/hexagon-hvx.xml
> +TARGET_LONG_BITS=32


