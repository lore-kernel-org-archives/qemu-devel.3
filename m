Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15A73C02180
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 20:14:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tY9ld-0006KV-Q8; Wed, 15 Jan 2025 15:13:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tY9lc-0006KN-6n
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 15:13:32 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tY9lZ-0006mP-2w
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 15:13:30 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-436345cc17bso740755e9.0
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 12:13:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736972007; x=1737576807; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dxDb9RZA3Z5syos/shJdG/JwpY6RfzLG69YY6b2Vp2M=;
 b=imym/sgvJHN0yTwPye/e2QLBIr2msqJsn7WgxJoioihfj56Kc2T8dYC185DLTdztuF
 JGD33gzgRETjAPL0p1XvgbfVHeqVzT6tDJll4Ux3UyX6aEIiNXI0T8sIUPEKkQoLu8vF
 gOm3oVhh6HW5UoSp7SBrKOIS7Ui44YWPTzqH1at7nRwPD7rQ8Gq8muAr5o891Za3MNoW
 G55vT0OLeZicsZVkSS7/Co8W/VKH1ZkeDInDvcRfmZSJdPg8Qn5RNEUylrDapZOiooYP
 UWmHZlWPAZItXisWKwnQvf+GEJl0IFRILbQWalvrvNumNwUPrsOLIr92dJN/Kj9e1wR5
 cS7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736972007; x=1737576807;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dxDb9RZA3Z5syos/shJdG/JwpY6RfzLG69YY6b2Vp2M=;
 b=dSG3TQo8GOXqszos8Cw/Z9/s93LM5PPK4sBqZPXo8JDaKBwot5akJcqHEWIyFYZYBu
 y/DwCqL2jCS/IwRPgEVvIXvj5Xky9PIOQ4I3iQO7b09ypcR0prZrlGxuK2CqQEZNuEyh
 zOijWYiASQScZAE5u/ejYGd8qH1O81BPebwKCE0hyw1tcLIKFK+5OFZvLCW6F4G64KuG
 XDJIRDSRR8Ri8nBqmZLm5FylENDYMDW9wnR5GDZwbAhA8rEN9/HiVLMtg1GRzbol5npO
 OoJaVivj7NB2tIP6/gztkDMYX9uTrg+Rm2gx30pa3NDmADi9hK/hJtdankHi64tiEP/C
 xdRA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU0nXH6nv3s/NP+6ySbIe1EL/FmUSFcrzLFPcekGEDpBceyTTbisJNL84u9vNy+gXUiP2vYVxU1qma9@nongnu.org
X-Gm-Message-State: AOJu0YwQ6HdmOakVUaEh2J4NUGD815dG1ejL/wL190TKOGQO3E04IiN2
 Q0npjDELvBhQ2Z6HoxfaOQRU1tdFj+Uo9PLnPrOU3LK4M2bXQLtGzc5DR4RNDiw=
X-Gm-Gg: ASbGncs1Ck6WhwyBPK5Erxh/DMxrCXkbyzP2hUKK9OPus0kBOvijl+u9dNGhJHdEeNi
 gcapw4WYrZXaP+yVnsBOQHqgkjf7tnzmpNio+gQV/oIMHWCk2E3tvLxrkbodM2z1JeJDaSiofFo
 j36vEYF3ldxdivbukpJ2ftbpMPMOd0ediFEMzWit7t9Y3s4TK4KEUB/lOH/0h82SA2YOtnjitiT
 CF4/XgL8YluqE//hK2NavN9mZASFnWisC8CdqOJTFv/6sErl0m3OufVwXEePMbJH55W02iRKJUG
 EBtFA/P3bfeGOVQjxArIZQk2
X-Google-Smtp-Source: AGHT+IFDUZTmxjRZ8aeLZXyhVckbRiXNxqzXPB3aDc8EiMhurUh9uczPqAzatwpWBnqhJS8BKFw8Lg==
X-Received: by 2002:a05:600c:3b2a:b0:434:f623:9ff3 with SMTP id
 5b1f17b1804b1-436e26a8c3cmr299564435e9.15.1736972007113; 
 Wed, 15 Jan 2025 12:13:27 -0800 (PST)
Received: from [192.168.69.181] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-437c75298adsm34756535e9.30.2025.01.15.12.13.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Jan 2025 12:13:26 -0800 (PST)
Message-ID: <25f1c979-55aa-40ce-ac26-b82d739bf2df@linaro.org>
Date: Wed, 15 Jan 2025 21:13:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 33/81] tcg/i386: Handle all 8-bit extensions for i686
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org, Paolo Bonzini <pbonzini@redhat.com>
References: <20250107080112.1175095-1-richard.henderson@linaro.org>
 <20250107080112.1175095-34-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250107080112.1175095-34-richard.henderson@linaro.org>
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

On 7/1/25 09:00, Richard Henderson wrote:
> When we generalize {s}extract_i32, we'll lose the
> specific register constraints on ext8u and ext8s.
> It's just as easy to emit a couple of insns instead.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/i386/tcg-target.c.inc | 23 +++++++++++++++++++----
>   1 file changed, 19 insertions(+), 4 deletions(-)
> 
> diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
> index e51269f81d..047c5da81c 100644
> --- a/tcg/i386/tcg-target.c.inc
> +++ b/tcg/i386/tcg-target.c.inc
> @@ -1329,16 +1329,31 @@ static inline void tcg_out_rolw_8(TCGContext *s, int reg)
>   
>   static void tcg_out_ext8u(TCGContext *s, TCGReg dest, TCGReg src)
>   {
> -    /* movzbl */
> -    tcg_debug_assert(src < 4 || TCG_TARGET_REG_BITS == 64);
> +    if (TCG_TARGET_REG_BITS == 32 && src >= 4) {
> +        tcg_out_mov(s, TCG_TYPE_I32, dest, src);
> +        if (dest >= 4) {
> +            tcg_out_modrm(s, OPC_ARITH_EvIz, ARITH_AND, dest);
> +            tcg_out32(s, 0xff);
> +            return;
> +        }
> +        src = dest;
> +    }
>       tcg_out_modrm(s, OPC_MOVZBL + P_REXB_RM, dest, src);
>   }
>   
>   static void tcg_out_ext8s(TCGContext *s, TCGType type, TCGReg dest, TCGReg src)
>   {
>       int rexw = type == TCG_TYPE_I32 ? 0 : P_REXW;
> -    /* movsbl */
> -    tcg_debug_assert(src < 4 || TCG_TARGET_REG_BITS == 64);
> +
> +    if (TCG_TARGET_REG_BITS == 32 && src >= 4) {
> +        tcg_out_mov(s, TCG_TYPE_I32, dest, src);
> +        if (dest >= 4) {
> +            tcg_out_shifti(s, SHIFT_SHL, dest, 24);
> +            tcg_out_shifti(s, SHIFT_SAR, dest, 24);
> +            return;
> +        }
> +        src = dest;
> +    }
>       tcg_out_modrm(s, OPC_MOVSBL + P_REXB_RM + rexw, dest, src);
>   }
>   

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


