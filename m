Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8903DD3C92D
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Oct 2024 18:42:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2asH-0007dI-SA; Sun, 20 Oct 2024 14:41:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t2asF-0007cu-JQ
 for qemu-devel@nongnu.org; Sun, 20 Oct 2024 14:41:55 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t2asD-0004eO-TP
 for qemu-devel@nongnu.org; Sun, 20 Oct 2024 14:41:55 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2e56750bb0dso1446230a91.0
 for <qemu-devel@nongnu.org>; Sun, 20 Oct 2024 11:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729449712; x=1730054512; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qbigL00Vzz8+yu/Kuji5fZH3h3ETffg0XrlbJJzPBpg=;
 b=izsTomSCMBbRYox65S/qAsqAWRj7CIyqv1c6VnI/yf6dYDPjrE7LQdzqmlL+5MCMw2
 7ibS/Wl/a1kLogW1HufUut6pQ1h0W/j56zIg2s4Mikxy33VundS+WkwRgAWICbopWaWF
 Sbi8tyTFTF3FukXZeBSjK2UHp14CZTzL7//J1q7kmFurXcQxCzyYJ9H3HjP0D/YbAcF/
 CDGsjEq7i54syPKC4r023pcQE/pbkAMwmEezu1GFsNyhuy+A0ZcoKfrhHnIiLNZzw1KH
 mTMsQVq+xZ2/dZAJG3c28zyChgsrkpnrv5y9fJQGCFS+zVZVMvupug0Px8Bt8kP0Lndx
 WxPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729449712; x=1730054512;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qbigL00Vzz8+yu/Kuji5fZH3h3ETffg0XrlbJJzPBpg=;
 b=rU0yPSKBcPachRdQfJFe7pBss8PO4nFYVYTHTMxpk2ygderJ2kATxn6DGjdeCbO3tD
 1Zquu54jRQTAoyX2y177JWhYKZU/6lfbTE1AoiejCnnXsyxIE7bS71Y+16WCalskrFjy
 5TQQFzPeM9LLDdm/eh+t66KxePKe98ehgXemHP9N1AekOG6tPnX6Sw3AT3bq9iCg1KAJ
 tuoYB5uFRusR9P2l9flKKq7TPaz6/tVpBbRHAMW299Nq5p84anRu5PvxIqHpn3l9/sj4
 QiBzMJRoig51EJws2nQGoIk/jvEUSBsH8EpcpyHvs4qGt1HTGxdG656TJanMelROmnv1
 MKfA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWa/lruB4szC4Ix7PMkux1Qr92fXIPHkW6/xeCKy7c4mNOjvRAAuAzlZX2Ps0/tq5jdijX7DIahSLtV@nongnu.org
X-Gm-Message-State: AOJu0YwIWS9PkH2elAnvAHHdoyN9WMGcsiA1HreamVAnJ5w53TG24dtT
 OXB7oGofks+hiGlIQLhGGYitZ1uZeTA0ZMHI225q/RprzGTljRuHGCMoeVGYFA4=
X-Google-Smtp-Source: AGHT+IEOQekqMCnQzkAvVTLqoqdr0aDr6RyWYXrDRPd4qiXmKQCS9MY6hwJADbAMiIha5baYUsn7zw==
X-Received: by 2002:a17:90b:68e:b0:2e2:d175:5f8d with SMTP id
 98e67ed59e1d1-2e5616de96fmr11147626a91.10.1729449711632; 
 Sun, 20 Oct 2024 11:41:51 -0700 (PDT)
Received: from [192.168.100.35] ([45.176.88.162])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e5ad38837csm1859680a91.29.2024.10.20.11.41.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 20 Oct 2024 11:41:50 -0700 (PDT)
Message-ID: <a79706ef-9c53-4fb8-857c-e49475a55405@linaro.org>
Date: Sun, 20 Oct 2024 15:41:47 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/8] Add support for emulation of CRC32 instructions
To: Aleksandar Rakic <aleksandar.rakic@htecgroup.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>,
 "cfu@mips.com" <cfu@mips.com>, "arikalo@gmail.com" <arikalo@gmail.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>
References: <AM9PR09MB4851159EEED6EFB71176524684402@AM9PR09MB4851.eurprd09.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <AM9PR09MB4851159EEED6EFB71176524684402@AM9PR09MB4851.eurprd09.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=philmd@linaro.org; helo=mail-pj1-x1030.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Hi Aleksandar,

On 18/10/24 10:19, Aleksandar Rakic wrote:
> Add emulation of MIPS' CRC32 (Cyclic Redundancy Check) instructions.
> Reuse zlib crc32() and Linux crc32c().
> 
> Cherry-picked 4cc974938aee1588f852590509004e340c072940
> from https://github.com/MIPS/gnutools-qemu
> 
> Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> Signed-off-by: Aleksandar Rakic <aleksandar.rakic@htecgroup.com>
> ---
>   target/mips/helper.h        |  2 ++
>   target/mips/meson.build     |  1 +
>   target/mips/tcg/op_helper.c | 26 ++++++++++++++++++++++++++
>   target/mips/tcg/translate.c | 37 +++++++++++++++++++++++++++++++++++++
>   target/mips/tcg/translate.h |  1 +
>   5 files changed, 67 insertions(+)


> diff --git a/target/mips/tcg/translate.c b/target/mips/tcg/translate.c
> index 333469b268..256fa0893e 100644
> --- a/target/mips/tcg/translate.c
> +++ b/target/mips/tcg/translate.c
> @@ -430,6 +430,7 @@ enum {
>       OPC_LWE            = 0x2F | OPC_SPECIAL3,
>   
>       /* R6 */
> +    OPC_CRC32          = 0x0F | OPC_SPECIAL3,
>       R6_OPC_PREF        = 0x35 | OPC_SPECIAL3,
>       R6_OPC_CACHE       = 0x25 | OPC_SPECIAL3,
>       R6_OPC_LL          = 0x36 | OPC_SPECIAL3,


> @@ -13705,6 +13730,17 @@ static void decode_opc_special3_r6(CPUMIPSState *env, DisasContext *ctx)
>   
>       op1 = MASK_SPECIAL3(ctx->opcode);
>       switch (op1) {
> +    case OPC_CRC32:
> +        if (unlikely(!ctx->crcp) ||
> +            unlikely((extract32(ctx->opcode, 6, 2) == 3) &&
> +                     (!(ctx->hflags & MIPS_HFLAG_64))) ||
> +            unlikely((extract32(ctx->opcode, 8, 3) >= 2))) {
> +            gen_reserved_instruction(ctx);
> +        }
> +        gen_crc32(ctx, rt, rs, rt,
> +                  extract32(ctx->opcode, 6, 2),
> +                  extract32(ctx->opcode, 8, 3));
> +        break;

New opcode must be implemented in decodetree format, please
add these in target/mips/tcg/rel6* files (the change should be
trivial and should only involve modifying few lines -- see for
example commit 675bf34a6fe and around).

Thanks,

Phil.


