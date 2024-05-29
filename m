Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 497E6C25B7C
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 06:36:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCCv3-0006TK-P1; Wed, 29 May 2024 02:36:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sCCv1-0006Sx-Rk
 for qemu-devel@nongnu.org; Wed, 29 May 2024 02:36:15 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sCCv0-0006uk-9J
 for qemu-devel@nongnu.org; Wed, 29 May 2024 02:36:15 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3550134ef25so1620031f8f.1
 for <qemu-devel@nongnu.org>; Tue, 28 May 2024 23:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716964572; x=1717569372; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZJAbDAw4q3dRautJP8wE3adwwy9gKeiUQpMYkZDROWw=;
 b=rRDxH6R3WUyJK22m7iHKwLEF1uFGQa883OjmbUofOeDSpLsjSPpEoi6XE8O/tuc9/f
 NY6yn7fXw4Aa5GAvFz1Qsto867vgUocRI3vKzPmk0ZY7YKxU+hAMN4gObocdYcphIV0m
 JQdbR6I14KTOvDupElRNJUlcf6R1FkxuU8/iwrYG1QhCipkwfYRNqnEE5gPzDtQN1jVe
 DupvxQaw+EqZQh4RiC6/n17uTvpZsJl7MgAIDqvxqq9jCM1WjdGFq0VwgfECa3G7OhnS
 5lAnwShho3F9+jxd5npyklwhV354gYe+8QKqMHhJ2Y92ybkEN7yL338rM1Iu7Hc0/c8T
 GpZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716964572; x=1717569372;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZJAbDAw4q3dRautJP8wE3adwwy9gKeiUQpMYkZDROWw=;
 b=vZBkCBUku0FMOp0gcz1lVlIGkcN8IyExYhdV9MnqzxhTQyIIjHOF8x8LqSude52/NV
 Gj2GWGLlCk5fv/CDWhyd2vfQ1Vo+ExHmfXc6TeFvmksftNvgk9SkH2ocL624L1Rt3sJD
 i2RZdPJEWp7jJRn0KerMt/Y5Jp09PMIemRAcYRkfX2owBw4r9ud7GZyuoiugucD6JEc5
 /ItRfWYx2nqoSBJuVIgmGpZE+12F/Lu5E8SufQdYdUAdz+Iv8KNtIzPBg3MgbIi20v4A
 8kKgLY7yYv6p6rPS1BruwxuusfBBCmWC9RmZRPfiutn+fEfOr4J4OhGt3i0gsZcGwktd
 jF1g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXxjZj1LDeObB/gdmdd61i5+L4kPXfHQeBEHx4edAsMlOoMKi4dZ7ajeC2S/PHSwInWn7+LQR9vGeZS80bG33yrYRnKsAY=
X-Gm-Message-State: AOJu0YxBv0VXG3FDwH6TP7P4lcmEo1uR49jlnEHfT8Ey5bThZLYnv0Hs
 TFSDz9K5AV64h8xzIPevsypcLeXUhyFabO1pILGK28YwKWkklOeGmu+CK1qWmyJbumS2NliHx/D
 K
X-Google-Smtp-Source: AGHT+IE8w81au34pNRPuJSFEXEtBYQDU97vQw6QpYrtZbm49T742cciK/MPv0iWSImrvTgi6yNNRzA==
X-Received: by 2002:a5d:5957:0:b0:355:79a:76f0 with SMTP id
 ffacd0b85a97d-35526c34563mr10654654f8f.22.1716964572369; 
 Tue, 28 May 2024 23:36:12 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.204.141])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35b1d7a496asm4059132f8f.87.2024.05.28.23.36.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 May 2024 23:36:12 -0700 (PDT)
Message-ID: <02e21685-2d61-4043-9ee9-819d9befd589@linaro.org>
Date: Wed, 29 May 2024 08:36:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/18] tcg/loongarch64: Use tcg_out_dup_vec in
 tcg_out_dupi_vec
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: git@xen0n.name, gaosong@loongson.cn
References: <20240527211912.14060-1-richard.henderson@linaro.org>
 <20240527211912.14060-10-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240527211912.14060-10-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

On 27/5/24 23:19, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/loongarch64/tcg-target.c.inc | 18 +-----------------
>   1 file changed, 1 insertion(+), 17 deletions(-)
> 
> diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
> index 1e721b8b20..9a8f67cf3e 100644
> --- a/tcg/loongarch64/tcg-target.c.inc
> +++ b/tcg/loongarch64/tcg-target.c.inc
> @@ -1749,24 +1749,8 @@ static void tcg_out_dupi_vec(TCGContext *s, TCGType type, unsigned vece,
>   
>       /* TODO: vldi patterns when imm 12 is set */
>   
> -    /* Fallback to vreplgr2vr */
>       tcg_out_movi(s, TCG_TYPE_I64, TCG_REG_TMP0, value);
> -    switch (vece) {
> -    case MO_8:
> -        tcg_out_opc_vreplgr2vr_b(s, rd, TCG_REG_TMP0);
> -        break;
> -    case MO_16:
> -        tcg_out_opc_vreplgr2vr_h(s, rd, TCG_REG_TMP0);
> -        break;
> -    case MO_32:
> -        tcg_out_opc_vreplgr2vr_w(s, rd, TCG_REG_TMP0);
> -        break;
> -    case MO_64:
> -        tcg_out_opc_vreplgr2vr_d(s, rd, TCG_REG_TMP0);
> -        break;
> -    default:
> -        g_assert_not_reached();
> -    }
> +    tcg_out_dup_vec(s, type, vece, rd, TCG_REG_TMP0);

Indeed, I noticed the same simplification :)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

>   }


