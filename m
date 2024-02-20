Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7D99C48BC4
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 12:18:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcP46-0007Bs-IW; Tue, 20 Feb 2024 07:17:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rcP45-0007BW-1o
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 07:17:37 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rcP43-0004GU-AG
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 07:17:36 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-33d38c9ca5bso1294271f8f.2
 for <qemu-devel@nongnu.org>; Tue, 20 Feb 2024 04:17:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708431453; x=1709036253; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=U1sgjxdp+gqDly3StkHne6g68Czi1k258A8i6UHN3j4=;
 b=veJDFFvsjFVtS5YMFhPcbxG+WrmZdeXP1togJV8/wDCRrblx9ftZIzLAW63LGO0KWe
 dnKrNilXi5Cg0bj1v4/bmNTYLolxLicGr/5mdcOpQe4qAtuAKLUUsicRlSHuJxXmTcAa
 upTISz4GwtrtwVuHwYh9ETp50omIuMGFNTHy7me/G136sgjA7Ib6s5rmfS+FaS/YTGEC
 RPDzc/e0uMUZYIdhMdvBKvjrnsJsv5caIc3aK/Q9+5O7gUEEHu/9w39Zmk8iOuLU5ap5
 TrbV5e/hG4J5dQ+WJkz5sb7XodzPqedRk/LF14TMGa/6RULNSKDCh7sAT36a4KctSQRd
 QDbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708431453; x=1709036253;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=U1sgjxdp+gqDly3StkHne6g68Czi1k258A8i6UHN3j4=;
 b=hZ4PXCV1phxLwmLjeLtBLFafsLxenMvMwFrhDVWbwern/9dxI+EcHq5PoAbsugCGL/
 mS28yS0hIN2lnXGYNjFD53etsZSe8qRTxBfcQNGYMZjpneitD5lrBuuC8KOTmtT3bbxe
 EVkOYhaeETVHPEhJBa2aoAS5AIFqlMU2LtRyFq1VIXSjkUr9fviINCsXjpdqR/1Q2S3u
 XRoEShYkOVyInTBmucfeWye35SzAIuA7vH7JD9kPMrnd7DJObgVDw9DTFr7ko0tWL0nj
 qFpVfp/CPZ4FwFKNoNJeQBLfgHR81GoRo0/o7WKiYZghx86looGx9zMPRhsLMrAZZdje
 XxWw==
X-Gm-Message-State: AOJu0YyK5DcURPqKg23bJjgKm/NoNcTfOjMdPwXCzbfS8QryHd2wvdEH
 eUApdSpHaJnUQpIStYHGmZD6tbBgxeNoR5jkqnZwraVpCyz5uf/kCcY+6SHsz4s=
X-Google-Smtp-Source: AGHT+IEHj6ucJ9seA0kkSsx7WH+3FZe11x5yevk+DmT5W0xpnsc6TjKevMbvPPpxKGMOSk5jx4vYgQ==
X-Received: by 2002:a5d:5645:0:b0:33d:3b82:ab2a with SMTP id
 j5-20020a5d5645000000b0033d3b82ab2amr5046236wrw.19.1708431453631; 
 Tue, 20 Feb 2024 04:17:33 -0800 (PST)
Received: from [192.168.69.100] (mek33-h02-176-184-23-7.dsl.sta.abo.bbox.fr.
 [176.184.23.7]) by smtp.gmail.com with ESMTPSA id
 a7-20020adfeec7000000b0033b483d1abcsm13193952wrp.53.2024.02.20.04.17.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Feb 2024 04:17:33 -0800 (PST)
Message-ID: <f2caa5fb-5443-474a-b042-f467e737bbc0@linaro.org>
Date: Tue, 20 Feb 2024 13:17:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 09/21] include/exec/plugin-gen.h: correct typos
Content-Language: en-US
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 qemu-trivial@nongnu.org
Cc: qemu-devel@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>
References: <cover.1708419115.git.manos.pitsidianakis@linaro.org>
 <d3a488b11917054cf4f13010e0f56d7b619a1257.1708419115.git.manos.pitsidianakis@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <d3a488b11917054cf4f13010e0f56d7b619a1257.1708419115.git.manos.pitsidianakis@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

On 20/2/24 09:52, Manos Pitsidianakis wrote:
> Correct typos automatically found with the `typos` tool
> <https://crates.io/crates/typos>
> 
> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> ---
>   include/exec/plugin-gen.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/exec/plugin-gen.h b/include/exec/plugin-gen.h
> index c4552b5061..b18edd6ab4 100644
> --- a/include/exec/plugin-gen.h
> +++ b/include/exec/plugin-gen.h
> @@ -19,7 +19,7 @@ struct DisasContextBase;
>   #ifdef CONFIG_PLUGIN
>   
>   bool plugin_gen_tb_start(CPUState *cpu, const struct DisasContextBase *db,
> -                         bool supress);
> +                         bool suppress);

Could we keep the definition in sync?

accel/tcg/plugin-gen.c:794:bool plugin_gen_tb_start(CPUState *cpu, const 
DisasContextBase *db,
accel/tcg/plugin-gen.c-795-                         bool mem_only)


