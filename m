Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27E4EC369AB
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 12:26:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4fMO-0005uP-5t; Tue, 15 Apr 2025 08:25:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u4fML-0005ts-34
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 08:25:49 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u4fMC-0006zS-T7
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 08:25:45 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43cf034d4abso59775215e9.3
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 05:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744719937; x=1745324737; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jCED9PfDCF6SR58XhBnDj6xiTpMQCNZ6ehiZo2aXjxI=;
 b=ybIyFwyOy8OdPIoM0C+Klm7Rv2/WzOynLBcZ39TWuD1jtra0Wm3v1FUqh0oaS+O4b1
 JUqid4WOVv0AN79OCDKSmCdeaU0N4ylGroWvE2Y2YKn2DPd5WnPPe7PtRxhfkkEjcqwv
 sqrx/Gp7FmUYtqzpKC3QG4Hyxrjux+9oDdjvqZ3zxwmB/1L/9cXq0m19t16b4xDa4WVp
 0WLszrND+iErX4Asv9pQFeepTJsNh+e/0Mp7P1H/koCcSAxCG4fD+schylTXBf6TJMOb
 PZqaDwg1mVZOpewoCoLRP35riqRiJiIyzPF0oKZr4YUx6/0W092aWUcpM3W1YPhoXVXz
 VIRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744719937; x=1745324737;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jCED9PfDCF6SR58XhBnDj6xiTpMQCNZ6ehiZo2aXjxI=;
 b=XDtHdoDDGPuZZbHGxNUfVYdLgEM5hPH4j3yTHbnBAyDVkuZtYRplka64ZW0xK2ylba
 oPhuNHIJ9A0spVKscLm4+pc75Mc15TsIYTdTbt3nN6WtpF7ekqZeKSF1NRsPeY9G73z8
 qVlOoJVo6y3QyM6luQvtxj4zopOrSpqvwNxLv/D3mRXGWBcqeYHo+l8XwoHUGZ4xm4L5
 Nty2X+0ayI/k8NHlMmpML5liOoHwFAlZIonAKddtelgxtJIGfXerNN1ArEfWWnfOKA8z
 pqZQZdcns1crnX1Rfliy77lb89wk5s3Kz4tNoM/Bdm9JJtAdIII6qBJNn7i7rqAKrTaD
 ZujQ==
X-Gm-Message-State: AOJu0YwlPWerqgJbg9YlSP93aQcPww5TPGq5SOapO7W4vGSFgzQm6Spj
 l51HH28OjLNDNNaTMW2+/TERy6nbl8soO4DYaGLVnFShpDH7mKkLrt3B/7y34uboPkXjZ/B5fsd
 I
X-Gm-Gg: ASbGncvmrLbefdT8du75RzHPbgw9edzXwPxUJ7qIY21AdayGDkw6DfKiwtbDTm+JXVg
 UPdvn1ImajiTjCSRGzxuCNiZN2HRI1XF4Bt8zr+i+x0tMu6Nx1R1K/9Grr97YBE8xt14K3vjMhE
 OzMupjDfBfnFTqdvC8wv5dbtUHY0a/RtjWyDScwOkvAsvawRWIamU4Y8p+WYwLQPWpFsie1JrAG
 zCw+SIziITYI9FYX6/ovmdC2QRw04NVZkpXuAbEs8X+3k0WehjR71C3DH8AZVfbXlVA/ys9ShdD
 tNTFDEhT1n70KGqBYl1ufnQskIgwEE8AcFpfz7OcbhHzu3FNUvv5w+iIssmzVPGBtB7BG0KDdMO
 uwhKZVkphGlyqKA==
X-Google-Smtp-Source: AGHT+IH5PNd2PNSATqRIJ5bXr/C4uMeoSyYPmi6KsadpWaj9tFtQMJ9JHnkgTPExUSvlhMj6iXk/ag==
X-Received: by 2002:a05:600c:4f8a:b0:43c:f184:2e16 with SMTP id
 5b1f17b1804b1-43f3a925695mr119185815e9.5.1744719937539; 
 Tue, 15 Apr 2025 05:25:37 -0700 (PDT)
Received: from [192.168.69.238] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39eae9777a0sm14039759f8f.43.2025.04.15.05.25.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Apr 2025 05:25:37 -0700 (PDT)
Message-ID: <b47c8670-42ff-445f-b5bf-c1fed7299a73@linaro.org>
Date: Tue, 15 Apr 2025 14:25:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] target/loongarch: Restrict instruction execution based
 on CPU features
To: WANG Rui <wangrui@loongson.cn>, Gao Song <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org, qemu@hev.cc
References: <20250415120628.141261-1-wangrui@loongson.cn>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250415120628.141261-1-wangrui@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

Hi,

On 15/4/25 14:06, WANG Rui wrote:
> Previously, some instructions could be executed regardless of CPU mode or
> feature support. This patch enforces proper checks so that instructions are
> only allowed when the required CPU features are enabled.
> 
> Signed-off-by: WANG Rui <wangrui@loongson.cn>
> ---
>   target/loongarch/cpu.c                        |  4 +--
>   target/loongarch/cpu.h                        |  2 +-
>   .../tcg/insn_trans/trans_atomic.c.inc         | 36 +++++++++----------
>   .../tcg/insn_trans/trans_branch.c.inc         |  4 +--
>   .../tcg/insn_trans/trans_extra.c.inc          | 20 ++++++-----
>   .../tcg/insn_trans/trans_privileged.c.inc     |  4 +--
>   .../tcg/insn_trans/trans_shift.c.inc          |  4 +--
>   .../loongarch/tcg/insn_trans/trans_vec.c.inc  | 16 ++++-----
>   target/loongarch/translate.h                  |  6 ++++
>   9 files changed, 53 insertions(+), 43 deletions(-)


> diff --git a/target/loongarch/translate.h b/target/loongarch/translate.h
> index 195f53573a..cf6eecd7ab 100644
> --- a/target/loongarch/translate.h
> +++ b/target/loongarch/translate.h
> @@ -14,6 +14,11 @@
>       static bool trans_##NAME(DisasContext *ctx, arg_##NAME * a) \
>       { return avail_##AVAIL(ctx) && FUNC(ctx, a, __VA_ARGS__); }
>   
> +#define TRANS2(NAME, AVAIL1, AVAIL2, FUNC, ...) \
> +    static bool trans_##NAME(DisasContext *ctx, arg_##NAME * a) \
> +    { return avail_##AVAIL1(ctx) && avail_##AVAIL2(ctx) && \
> +             FUNC(ctx, a, __VA_ARGS__); }
> +

What about simply:

   #define TRANS64(NAME, AVAIL, FUNC, ...) \
       static bool trans_##NAME(DisasContext *ctx, arg_##NAME * a) \
       { return avail_64(ctx) \
                && avail_##AVAIL(ctx) \
                && FUNC(ctx, a, __VA_ARGS__); \
       }

?

>   #define avail_ALL(C)   true
>   #define avail_64(C)    (FIELD_EX32((C)->cpucfg1, CPUCFG1, ARCH) == \
>                           CPUCFG1_ARCH_LA64)

