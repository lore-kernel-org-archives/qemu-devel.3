Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86CFECD3427
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2026 16:21:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wM6tn-0001Qv-2g; Sun, 10 May 2026 12:21:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wM6tl-0001Qg-HO
 for qemu-devel@nongnu.org; Sun, 10 May 2026 12:20:58 -0400
Received: from mail-oi1-x231.google.com ([2607:f8b0:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wM6tj-0005MG-RF
 for qemu-devel@nongnu.org; Sun, 10 May 2026 12:20:57 -0400
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-479d68a9063so1265501b6e.0
 for <qemu-devel@nongnu.org>; Sun, 10 May 2026 09:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778430054; x=1779034854; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+DsZG5wnD/fjJCgNAV9jM2okGfnLsCHm9V4kWRflOO0=;
 b=sLq+4334SS9wL8caxpRuFeM0QvTcAsbFpk/Qy1CUrLMczMVoFK1B+Lmdm22HKB9s5B
 AA/UUTBJhamKRP7vIy+5QUemd0ovRjkpfY4IPn5RRNF0kz7GSWYSb1KNCe1qBsp95AoV
 dkBDIzfIfCBEvKqfIg8ZQm7fujvIOZa0F4sgHo8yI1CEDtVw6XIOaYOZ+hoWfuKi4pHa
 3vt5dFOArt6ev/FgpQe/TfU5yz0Yop05TNDC6trPGtvrFn8f3iYhNkevsr2eBlh+JwR/
 7KzFUJ1gcHM3v9sht5wTUVDEtK2HWglwEJrqwwjiJUOwLQ+RBsQT5iOMOwURfbdCBbEL
 xltA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778430054; x=1779034854;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+DsZG5wnD/fjJCgNAV9jM2okGfnLsCHm9V4kWRflOO0=;
 b=TTltZcDO9dYuPQAQPenik48h7trTBLDv9Qe2CfubbsH9mYVVhvFt2LVhlRWZ0Z0Wu8
 HAtoMuHaK3ta+1YcQGuA8QreTgXHw+a9PWAceD2a7FtsH/RwFpgic7JHsp7BBCHkHPIw
 IIt/ttzDT3NCJRRkIn7ljTgHDkvWkOJhuiVaO+dT3KMTJDpjLqYAKR65WG0O1BA2HuWh
 8T98bYsEoKY87Nl9SgZ1FjJOAWfpUtcZddbL8eMJGIvgxktOTlYN7b5v7g+RS9MYaD5S
 ymDGooQVc/wMcrPoI7PBlAYg6p9It0gE3rQtGl1nM06+NIdNIkvD5wgpuZ79k6STONNX
 cUNA==
X-Gm-Message-State: AOJu0YxakttzncwV1uOiO4SlNDu+YRBdQXrUhvAX5kfxIMVTIaS1alZA
 prptAPaYHZio7PMcfoxPm6wctmy653usiMfHGBiK0mD+lMDbjTazZF85OkCWcZlh5mpbFji+dTo
 X40hB
X-Gm-Gg: Acq92OEduyNKKoxG937sOGXnAb7UpJJi04ZRlnw9LXIMHwXHcWvgXv8ztx4/rEqgL/k
 iAljm0u6Je/eHZGgF9NLne8ue2yK5/kKHhYDHdFgj+fh8Dn2augKJLe1dDpVcc+hKV9O6vYHfsR
 2XNtHvBzzyuRhNPtULEt9MERlTn5cixXdnMhz7JqoiqAx9MScSncbTtJk/dy7+UF0pJEuqvqsM6
 k0/0mJ7Z6k4dWmSrWLHYBlTmCSg3p8rdLgJzJ0JH6qS5h3EIBw5ecsyqzOfpa+SURrJmv/uhpG7
 6KzVVtVs44v/vJ/CjWuC2ohN6g4GWnqCdX+D0+kPjW4gldUY0IQZwsbHhoj2qPaMViKsiYNAcSM
 X/0t1CqJ17+9+AEzm8uFX5w9Yywa/1uN7K5rv45CviFdXsdhvsY81DBHt9CRcnfj21xNggIqDwW
 GZUNsD4Wc1LnLY9MLbdKITq7kPB3AMQUZr0khTYAQcSCZ2j1sKE1XnvGWmV10v31PViIPjo4mgd
 JQ1wQZMUA==
X-Received: by 2002:a05:6808:3010:b0:467:2652:b29d with SMTP id
 5614622812f47-4824a568d39mr3699169b6e.8.1778430054457; 
 Sun, 10 May 2026 09:20:54 -0700 (PDT)
Received: from ?IPV6:2600:381:c938:6375:32c5:6ccf:a676:6508?
 ([2600:381:c938:6375:32c5:6ccf:a676:6508])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-435571099a4sm7200781fac.7.2026.05.10.09.20.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 10 May 2026 09:20:54 -0700 (PDT)
Message-ID: <6f3fe92f-5e69-4942-ba6e-ea59f36825a5@linaro.org>
Date: Sun, 10 May 2026 11:20:52 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 14/32] target/mips: add Octeon ZCBT instruction
To: qemu-devel@nongnu.org
References: <20260509-mips-octeon-missing-insns-v2-v4-0-d669dcd05c2f@gmail.com>
 <20260509-mips-octeon-missing-insns-v2-v4-14-d669dcd05c2f@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260509-mips-octeon-missing-insns-v2-v4-14-d669dcd05c2f@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::231;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x231.google.com
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

On 5/9/26 21:13, James Hilliard wrote:
> ZCBT has the same user-mode memory effect as ZCB for QEMU's purposes.
> 
> Reuse the ZCB translator so both cache-block-zero forms clear the
> containing 128-byte line.
> 
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> ---
> Changes v2 -> v3:
>    - Split ZCBT out of the combined Octeon arithmetic and memory
>      instruction patch.  (requested by Richard Henderson)
> ---
>   target/mips/tcg/octeon.decode      | 1 +
>   target/mips/tcg/octeon_translate.c | 5 +++++
>   2 files changed, 6 insertions(+)
> 
> diff --git a/target/mips/tcg/octeon.decode b/target/mips/tcg/octeon.decode
> index d8a1bfce77..56c54e0973 100644
> --- a/target/mips/tcg/octeon.decode
> +++ b/target/mips/tcg/octeon.decode
> @@ -51,6 +51,7 @@ SAAD         011100 ..... ..... 00000 00000 011001 @saa
>   
>   &zcb         base
>   ZCB          011100 base:5 00000 00000 11100 011111 &zcb
> +ZCBT         011100 base:5 00000 00000 11101 011111 &zcb
>   
>   &lx          base index rd
>   @lx          ...... base:5 index:5 rd:5 ...... ..... &lx
> diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
> index 794c8f033b..477f681f9e 100644
> --- a/target/mips/tcg/octeon_translate.c
> +++ b/target/mips/tcg/octeon_translate.c
> @@ -203,6 +203,11 @@ static bool trans_ZCB(DisasContext *ctx, arg_zcb *a)
>       return true;
>   }
>   
> +static bool trans_ZCBT(DisasContext *ctx, arg_zcb *a)
> +{
> +    return trans_ZCB(ctx, a);
> +}

In other places I've avoided such thunks for a mere comment in decodetree, like

ZCB   011100 base:5 00000 00000 11101 011111 &zcb  # ZCBT

But as you prefer...
Acked-by: Richard Henderson <richard.henderson@linaro.org>


r~

