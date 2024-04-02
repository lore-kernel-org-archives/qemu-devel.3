Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE1DBCD1284
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Apr 2024 13:27:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rre9o-0007AJ-UZ; Tue, 02 Apr 2024 09:26:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rre9n-0007A5-IB
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 09:26:31 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rre9l-0005mk-Pt
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 09:26:31 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-415584360c0so19323305e9.1
 for <qemu-devel@nongnu.org>; Tue, 02 Apr 2024 06:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712064388; x=1712669188; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:cc:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jvh3lFDKjxKup6KjSLf4pNYzpRZV6jHaU5FQzFg3rEA=;
 b=AQu408imQlT+VNZYFN+VhjN2rt6N4ZYqsTrHJZyN0rtZdJleW0FDXDC6vMyoBoAO7Q
 5ugdn6LgcZFM1cuwtnxOCnSLoO3N921Z/RP0UfP+V0Kg1qhDhPg6XDgnBerXZbpJt4cN
 l3/pmFVQJ2tvLjodoPHq/kCmp0Q0i6H9/c1aXArmWZbiGC29d3H4AcT3gK0X5LG1ge1/
 fHyo8GoalAZmd2JoMI1M0icZhNEcf0m7MtirRqfsWq+z7jonMHecwfIZ0LGScpSgSPb6
 ZZLJW3z30lcL0cLNTj+i3538vqemUZuaTy1sh7FGUIxuheA33POUfpkdPhLPJNaXUwCJ
 XRAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712064388; x=1712669188;
 h=content-transfer-encoding:in-reply-to:from:cc:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jvh3lFDKjxKup6KjSLf4pNYzpRZV6jHaU5FQzFg3rEA=;
 b=KTZUZxR7UWLviPp4PKBdAFmtexDMFK/5eQqdmWZ44RFT83Tq7RlgLD5zsigAQzK0X4
 1vjSYJQHa/DtbyUW5NXE368irzLMGiRx9pEoBeao63CSeMfZWCctRHwig1BIxYqGAJtI
 eo690fJN70/E1Z0TjujqvLnQvdBjdmE+tzwdvswS1miW2CRRxK67ThFB949B6w836gLf
 HvBtIZNGkvMOxMbAyFp0n+28K3AcUpK2yEob1JEjQxqK1lWZIklU4IhJpwd85qrabvRO
 OvW76hk2czzcFJS88JjZTp6RPUbXpyjvFI9ZapLqAyJhRKhz48GC1dy1qCejfF6kj2IS
 enHw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUTD7xSa/ebGaqy6EDy2JSqVe3qjZNHu6fKnNJhfiNXJSx60sIstHoh9WOBSJh5Xs2AR8QiDwFFK5hpH/ukkisx1qgX79E=
X-Gm-Message-State: AOJu0YwCl/XNhYDx9ToG9oh1fDf1Ng+xjBxhHCHmRadSBQypmdwTYlYk
 vUkBarKxxCXcIJvgWUYJ2EtntWHNvKWtsva7JZNFmpBFYl0/Q14e9zlaEig3IyE=
X-Google-Smtp-Source: AGHT+IGXxbjqPVjiuwK4eEgA4lgSW1wQ4KyqNyo3fsXU+gUGn9dV1sOM+Ca5lZxvfk15qD20cAG9yA==
X-Received: by 2002:a05:600c:3d87:b0:415:6d52:5489 with SMTP id
 bi7-20020a05600c3d8700b004156d525489mr2444136wmb.13.1712064387965; 
 Tue, 02 Apr 2024 06:26:27 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.202.91])
 by smtp.gmail.com with ESMTPSA id
 i5-20020a05600c354500b00414924f307csm18014059wmq.26.2024.04.02.06.26.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Apr 2024 06:26:27 -0700 (PDT)
Message-ID: <16cb6ac0-818b-4393-8b27-20879a150a79@linaro.org>
Date: Tue, 2 Apr 2024 15:26:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sh4: mac.w: memory accesses are 16-bit words
To: Zack Buhman <zack@buhman.org>, qemu-devel@nongnu.org
References: <20240402093756.27466-1-zack@buhman.org>
Content-Language: en-US
Cc: Samuel Tardieu <sam@rfc1149.net>, Aurelien Jarno <aurelien@aurel32.net>,
 Yoshinori Sato <ysato@users.sourceforge.jp>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240402093756.27466-1-zack@buhman.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

On 2/4/24 11:37, Zack Buhman wrote:
> Before this change, executing a code sequence such as:
> 
>             mova   tblm,r0
>             mov    r0,r1
>             mova   tbln,r0
>             clrs
>             clrmac
>             mac.w  @r0+,@r1+
>             mac.w  @r0+,@r1+
> 
>             .align 4
>    tblm:    .word  0x1234
>             .word  0x5678
>    tbln:    .word  0x9abc
>             .word  0xdefg
> 
> Does not result in correct behavior:
> 
> Expected behavior:
>    first macw : macl = 0x1234 * 0x9abc + 0x0
>                 mach = 0x0
> 
>    second macw: macl = 0x5678 * 0xdefg + 0xb00a630
>                 mach = 0x0
> 
> Observed behavior (qemu-sh4eb, prior to this commit):
> 
>    first macw : macl = 0x5678 * 0xdefg + 0x0
>                 mach = 0x0
> 
>    second macw: (unaligned longword memory access, SIGBUS)
> 
> Various SH-4 ISA manuals also confirm that `mac.w` is a 16-bit word memory
> access, not a 32-bit longword memory access.
> 
> Signed-off-by: Zack Buhman <zack@buhman.org>
> ---
>   target/sh4/translate.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/target/sh4/translate.c b/target/sh4/translate.c
> index a9b1bc7524..6643c14dde 100644
> --- a/target/sh4/translate.c
> +++ b/target/sh4/translate.c
> @@ -816,10 +816,10 @@ static void _decode_opc(DisasContext * ctx)
>               TCGv arg0, arg1;
>               arg0 = tcg_temp_new();
>               tcg_gen_qemu_ld_i32(arg0, REG(B7_4), ctx->memidx,
> -                                MO_TESL | MO_ALIGN);
> +                                MO_TESW | MO_ALIGN);
>               arg1 = tcg_temp_new();
>               tcg_gen_qemu_ld_i32(arg1, REG(B11_8), ctx->memidx,
> -                                MO_TESL | MO_ALIGN);
> +                                MO_TESW | MO_ALIGN);

Apparently invalid since its introduction in commit fdf9b3e831.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

>               gen_helper_macw(tcg_env, arg0, arg1);
>               tcg_gen_addi_i32(REG(B11_8), REG(B11_8), 2);
>               tcg_gen_addi_i32(REG(B7_4), REG(B7_4), 2);


