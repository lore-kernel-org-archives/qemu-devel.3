Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E365C606A31C
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 19:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=FwiMOTso
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTOPx-00058j-CX; Tue, 17 Nov 2026 14:00:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xTOPv-00058R-Gt
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 14:00:31 -0500
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xTOPt-0008ER-3X
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 14:00:31 -0500
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-8b5e5e64494so98337b3a.1
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 11:00:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794942027; x=1795546827; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=w4c/QPb4utayQ3whgwzidbIl77U8HPhYTrjoD8Hptfc=;
 b=FwiMOTsoeWib8C7PwRJJUpNRc4XmvvRQH+WcJvAwKBcAYQxV1frHl1NwO5b7tEXBfy
 NVO1E5TXYEKIgeo1z07A8gjI4wPlGu12jhq+cDzyY5RJnuI5f1lknNqj79ByqXnVUhVw
 drIP7RMpMkNKQiachyp1Jdr9GLG0cNl93zcYgIAP80MmOFVHWa3ROusBf1NPhJqJAW/5
 BaFVhB5e7EqABj+2J1g7oTHaGoQEjON05KE+Fc3Mm8F976RTlYfrP1fsLmrzIuKc4nY+
 NzvbUtoHBiouFgvrvX5ZjGW224iHgIlCiTxc4oYS6RsgOWXsrofBhvd+uws+DeGQgJik
 /6hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794942027; x=1795546827;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=w4c/QPb4utayQ3whgwzidbIl77U8HPhYTrjoD8Hptfc=;
 b=Pl7G4WCdubQLBqXj9jXDdo+4W1wVJlkxl01rC/mOhEL8quSn+igHuFpq9stZ/ud8+b
 sJ/600HA8p9mgW7FpYG716fhWDlJDlEmAqCPoVHViVHJb7VXmev3rTG2I6BpcOu3Tg1s
 y7XC1uJRR1GMtOQo164UisgxBk9DQ7MAI04wEPwfSwtiPHTAkxUBsmep6K/HlziBUtN5
 oI+vt+vryeXMeqKkqijbGf6DWKzIVUGUMBvbucomXD40gM/nBmsTinDa6U3p4WmHybQF
 94HEbM5UVbMMLDYVBp+EwwKbTbAYyrECOrr0QzsFIEBeOsUtniCOqy4+u2MSjxIqnxkA
 jJvg==
X-Forwarded-Encrypted: i=1;
 AL+hErEyXbKPQFyz9z1iOa3MTKD7z2BvJJX/f8d2nc7/Z+0nzJSY6vt50op3yvIFwxJZkRq2ALlbZ0M5d3w8@nongnu.org
X-Gm-Message-State: APuU4Z+4etLIiy3Ueuq5TY6f2fa8qT/oOg/qo37Y0kZxs6tPrQdCMDjc
 O/sX7ifmE/inzE6h52sE80felVmNKqX10waews1yoGgKAT1WfrRSBTaJxTauS5g8TuQ=
X-Gm-Gg: AYBFou1RkdPt5pZvFCnqSJFyrQgaD2d8qijOnpJmbcJAUc0BZQbtdzptkYo4EOf6fCP
 AHuAPshGmtLfmgm0lcbjiNmf6pPb/dshbWdEFmoc9HJMqAxDh/cHLoOSwENW4FaJglylGGXZjGZ
 YIDypMlnLrPcTxjgnvCdQWxYxslA8kV/JMQnUkl+7GvVGJ0PabivM7a+EQicBYCFV5aen9bIOBB
 KXgbdU3P2YHjQK3FufISa69czyk2OaSu8ELHJyao0faMazCQ/ObvYX2ZNndCpXKUyEMStm3Bylm
 Ib1ubcoQRm8dMvKMjNVFjc9zrGFb3y1C2iaTzOvFWo1FidVmcibcdHf4+IuNNa/1b0lAZfRauvQ
 hcG5MSEUHAA2rFLqAgBhS6KAPaaX4CrSBBmO23IhUGZ0FjJS8yvv8C2vWi7RDiUZsvEF5eOvRqw
 VbyBiAG61ovQS9KxeVH9im9OOvaMK3hfnk8WAGL63eIH4Bkfj5WC1icAyToYXdzn+rKoQ4wT6EP
 Mzvt2W39yP9gC7NRyB+NFfKtMlu4LstnWtqAE7lX8C7LySziVHrhXmyaOE+/LxAqpahduxJiw9w
 luPteDuB9t3mXwovX0+jZZfkEyqF6vg6L+BCM+vl0VZH83lSj+tU0KTjuN4hiOxe/BB6BgfQikR
 MaPPBWwus7TiDxMwL
X-Received: by 2002:aa7:9065:0:b0:8a0:7dc4:95c0 with SMTP id
 d2e1a72fcca58-8c5d3e0d522mr77225b3a.15.1794942027337; 
 Tue, 17 Nov 2026 11:00:27 -0800 (PST)
Received: from [192.168.0.4] (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8c5cb35c6a4sm55357b3a.37.2026.11.17.11.00.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Nov 2026 11:00:26 -0800 (PST)
Message-ID: <ec413b6f-23ff-42f6-8e21-52c565afb426@linaro.org>
Date: Tue, 17 Nov 2026 11:00:25 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/19] target/mips: Require the MT module for MFTR/MTTR
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Vince Del Vecchio <Vince.DelVecchio@mediatek.com>,
 Faraz Shahbazker <faraz.shahbazker@mediatek.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Milica Lazarevic <Milica.Lazarevic@Syrmia.com>,
 James Hilliard <james.hilliard1@gmail.com>,
 Aleksandar Rikalo <arikalo@gmail.com>
References: <20261113161158.25811-1-philmd@oss.qualcomm.com>
 <20261113161158.25811-4-philmd@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261113161158.25811-4-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/13/26 08:11, Philippe Mathieu-Daudé wrote:
> MFTR/MTTR must raise Reserved Instruction on processors not
> implementing the MT module (MD00378 pp.46/50, Config3.MT:
> table 6.21). Use check_cp0_mt(), as done for the other MT
> instructions, instead of only check_cp0_enabled().
> 
> Fixes: ead9360e2fbc ("Partial support for 34K multithreading")
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---
>   target/mips/tcg/translate.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Surely check_cp0_mt must be enabled for user-only,
not sit behind an ifdef.


r~

> 
> diff --git a/target/mips/tcg/translate.c b/target/mips/tcg/translate.c
> index 6e7e1a0f758e..c434da714b0c 100644
> --- a/target/mips/tcg/translate.c
> +++ b/target/mips/tcg/translate.c
> @@ -8588,7 +8588,7 @@ static void gen_cp0(CPUMIPSState *env, DisasContext *ctx, uint32_t opc,
>           opn = "mthc0";
>           break;
>       case OPC_MFTR:
> -        check_cp0_enabled(ctx);
> +        check_cp0_mt(ctx);
>           if (rd == 0) {
>               /* Treat as NOP. */
>               return;
> @@ -8598,7 +8598,7 @@ static void gen_cp0(CPUMIPSState *env, DisasContext *ctx, uint32_t opc,
>           opn = "mftr";
>           break;
>       case OPC_MTTR:
> -        check_cp0_enabled(ctx);
> +        check_cp0_mt(ctx);
>           gen_mttr(env, ctx, rd, rt, (ctx->opcode >> 5) & 1,
>                    ctx->opcode & 0x7, (ctx->opcode >> 4) & 1);
>           opn = "mttr";


