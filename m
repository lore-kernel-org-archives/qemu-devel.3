Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51041FD376A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 16:34:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvHq7-0000N2-7C; Wed, 25 Feb 2026 11:34:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vvHq5-0000Ks-7v
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 11:34:17 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vvHq3-0007xz-P6
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 11:34:16 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-43992e3f9b8so594074f8f.3
 for <qemu-devel@nongnu.org>; Wed, 25 Feb 2026 08:34:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772037254; x=1772642054; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ErNFB4fWo3erpLz6CQwnamsPRtYALrLm1VQrrV4Tt64=;
 b=v5uXjqH1UZ4f77KD/i42pafkVXNkM0hemFKWK5/yktDNmGILGr6KcUCNYaHW7nLFpb
 3z3zpx73jcomCc6IW/QL3l05/ieyC6Ouppu6TZqd9JbMlHDbBSOX7O1zRhe5xkYAE8zW
 brGUhAYhh5vJHj8Uz+8J6t7WYlhQxsCyMDY9mr7jPVvC51C3K01k/yRQExn4y+TgrzBf
 irjJ78YmqHJBkQS+Z6/NikYx6zkLi7zX4kn7nO0rPtzEJO7nn7xNi2s/Apf8o3YAIOb2
 TO7ken2xICzh9BwBui4YRJd3ewBjZAH97EnrR5uytuqXCvnoI9jHNHKsTFLH0VPylCRW
 f6mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772037254; x=1772642054;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ErNFB4fWo3erpLz6CQwnamsPRtYALrLm1VQrrV4Tt64=;
 b=onZhV3ONIJhh1SZaoC0iX+acpFM58nSd/N5cKHy6BS/cnKV4/rWD+DfsiRjR3sW9rZ
 6W66igQNe48doJm83TdFOCqEk+1MIFZMkNfSZJjB9M9o8aCEYzAAWmtNjwqqUT7Ag6T3
 Y43MA5r0L5a21X0feL/YW+OFJU2kNIvqxl8r6xZ3iUB9UTxwLeJSFNKjClfApQsqtsdp
 zUfp4qnCiKheudGt4kqXKu5ZJWGk0AZclYKVVkFGJdRlIJLKBEvjLluyEtWfaMQ6msNT
 XxN39dOTH9kEWVdBKU2hw3bGohuBcMobgyOHfK/+38DR+qxIeuKsP8riU08U6OPjSgRS
 +47w==
X-Gm-Message-State: AOJu0Yw0I250wn492EQyTb/tan9DjHLV2wG7mtYvlBZOhb4Znv2YlBTl
 ou5wRt7P9X2mjw1EKnANLSDvwvOb9QfhkwM5nIaqxG2R97bAbPNb+xhXbx2DuilyXDHizkMw1xY
 z1ECJhZ0=
X-Gm-Gg: ATEYQzytWyHKF08mXKFo/1rpZT5v0hzVnExfYkFPaDfpvvOwafHZxaYVIwUlWHXobhw
 lErraVZHtQ1zLN0iGgnY/b++cQ0Oll8bYxd4SgDYsYHhZbs2x92F7eOlDfm9H8XJiAXADB9Bd0x
 Vas4b9yQT/8NLC5QNH1QeDMjyPp1Y2nZIlKTDq9ZhbqhjSFKX7rtRX6N/t4AXQCe5RGjtV3Yl2M
 1YKUrG6L6AIL1LCdCzx5qAeR9rOz4E/QHNt43u8s0ZftKLI9G94p2mt9/j2RwN6QwWKvADc3qbG
 zVoHH0CcsiLboCg3iKHtk/AnD1ARzVVQ4ja08sSSR0ADLG6k3SySG+HDLGk7U9qalSv20XACwaH
 N8+Gr62mBq8SQolsQKsPzQZYoXXtggG2OqM5R3Bre3ms+hrU7OnwKBuUDOonn3rL92RpeOt61sp
 4JK9FM9La0a6sD3S3uCMnZJLoJO4Vos2oS1DRdqAJEavOZ89CKN7WTGjd1ihJN4jzZRg==
X-Received: by 2002:a05:6000:2511:b0:435:e440:f518 with SMTP id
 ffacd0b85a97d-439942fddd2mr2165857f8f.54.1772037253543; 
 Wed, 25 Feb 2026 08:34:13 -0800 (PST)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4398bb96b90sm10671635f8f.9.2026.02.25.08.34.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Feb 2026 08:34:12 -0800 (PST)
Message-ID: <0cf4a5e6-0e29-48e9-8e99-e86b4de42996@linaro.org>
Date: Wed, 25 Feb 2026 17:34:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] accel/hvf: Build without target-specific knowledge
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, xen-devel@lists.xenproject.org,
 Cameron Esfahani <dirty@apple.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>
References: <20260225051303.91614-1-philmd@linaro.org>
 <20260225051303.91614-5-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260225051303.91614-5-philmd@linaro.org>
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

On 25/2/26 06:13, Philippe Mathieu-Daudé wrote:
> Code in accel/ aims to be target-agnostic. Enforce that
> by moving the MSHV file units to system_ss[], which is

s/MSHV/HVF/

> target-agnostic.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   accel/hvf/meson.build | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/accel/hvf/meson.build b/accel/hvf/meson.build
> index fc52cb78433..6e2dcc4a5f0 100644
> --- a/accel/hvf/meson.build
> +++ b/accel/hvf/meson.build
> @@ -1,7 +1,4 @@
> -hvf_ss = ss.source_set()
> -hvf_ss.add(files(
> +system_ss.add(when: 'CONFIG_HVF', if_true: files(
>     'hvf-all.c',
>     'hvf-accel-ops.c',
>   ))
> -
> -specific_ss.add_all(when: 'CONFIG_HVF', if_true: hvf_ss)


