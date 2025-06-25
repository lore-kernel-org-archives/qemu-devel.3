Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44347C7EE2A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Jun 2025 22:14:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUYMt-00025U-Ir; Wed, 25 Jun 2025 18:13:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uUYMr-00025A-MY
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 18:13:21 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uUYMp-00048M-J6
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 18:13:21 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3a6cd1a6fecso268627f8f.3
 for <qemu-devel@nongnu.org>; Wed, 25 Jun 2025 15:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750889596; x=1751494396; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LUOXioym4hwKio22fLgFukCThsmo0ikldcOeovMrDTI=;
 b=pGvLnMM62jw/C1YAiffJzc21wtzSM9KcylXTvWg6/fImB6BbfeLlKBFqPsTWOYc/jZ
 QwhA89tRxXCldT8HHuopYISmcGtAQENmyS3vtOs5AQw/24E6Ipty1lXY501hsfONvX6L
 nf9Ea3L8ZJF37opCf4DCcoF4sN2ifUIX3xJge6vhto6xytyFcQy0BfxpQayPSqjkAzK8
 MklF7I6+IFMqCBAE8RrPJG2yuUJOzP4+zKFql0nSaFwNd8hES9mU5HAirsFrWmLS5i7C
 lpd21SwKbtSuCAsnuIJGrrxbiYoVqvv+06ldthTbs8FL5TG1G3tfwdolL42zS+atGFpy
 f24w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750889596; x=1751494396;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LUOXioym4hwKio22fLgFukCThsmo0ikldcOeovMrDTI=;
 b=e4dGwDeKt+oXDhNctvKtezQHqANDjyyZo2Ln15mYfqddSBlA8ge8+2pCOFVW+NZ0dL
 8iZcY6+rVz7bOamg7fY4TLRE5772uO4xSb3If1A1RO6vpbjstZu68HMOXS7vZQpARNgy
 JBODmOvjBwoUGOoyMWgrPMTh4wyYl0R4fiE2o8q8/XUOqpsvMs4jK86xTkwv2BM5hAZW
 grRMloFcs3P0Z1IE7FT0XQncxNU54xnAtS7mRoHwkcZF/LCP94KeaoqOsb+rR5zIO/ia
 Boavvjwb7c5/ZR/BpVjRfcuxyMauVD8B8T4NgICcCN8WOEjdE1m+Z1x+Q2qqXggnTvQd
 eBGg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXpCi2in2x7MQ8BB8NdXSWs/EYvfa/8B18Puk+4M/3PSJC3B3+CVOXtEUuHxvtSjE3DGbqzB8wA1y0C@nongnu.org
X-Gm-Message-State: AOJu0Yynq5bF34kJrVw7ZL7iEmy8yt6YwP6IsQMExT7S20xZyEVyGRdc
 taQvA0joRnTb7zybNhTJsChNu3ckX+kS5c/63Kzc1MyNU0cnwX9B5DbpHr+W1X9SP5o=
X-Gm-Gg: ASbGncvCaYpi/Q2U2H3YLHs3eZ0SJFNUEWfP4WIaN4H0VMfOEbPdCzBQyLsoTlTBUc8
 x6nO1ejP3p/jPnamO/uo/ZDxlrz7ZTXSsDCcX0ioydi+AErBUdMqtrkwFVRfpHaselpsNpS6RSE
 2o/jlHhrPXmtZMChjA/IunadW026fMiGZhMpQDjtfZvo6ww8EkfckKsq/ye6AjIWlVLdeShVIir
 TeLhR3B69M6D2vAjYtzGQtmcb/lmoX4hp/DoCf0n7h3nqS6Q70KwMtCyUasFA86vPEl7fEevqiI
 eMQGtuLTe58KsQrZ/1dtezmwbK6SuwMiO3im0x3BEZ4KjttYSdsYpg5CyoOhcmRucyEXTPWCgNl
 Djck/hogaDMoovcCrJ111o1BqW3W7tQ==
X-Google-Smtp-Source: AGHT+IHGDHqqqtGZl50vr4QBUETvixvKjTTrIbekhDUVyCW1YjI9o/2rvGwA59hKTFbHnzbfOvZ48Q==
X-Received: by 2002:a05:6000:2d83:b0:3a4:f50a:bd5f with SMTP id
 ffacd0b85a97d-3a6ed6384c8mr2810503f8f.31.1750889596189; 
 Wed, 25 Jun 2025 15:13:16 -0700 (PDT)
Received: from [192.168.69.167] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-453823b6c21sm31392625e9.29.2025.06.25.15.13.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Jun 2025 15:13:15 -0700 (PDT)
Message-ID: <a072e4d1-9997-434d-848e-93b2251bd28e@linaro.org>
Date: Thu, 26 Jun 2025 00:13:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/1] Add support for emulation of CRC32 instructions
To: Aleksandar Rakic <aleksandar.rakic@htecgroup.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "arikalo@gmail.com" <arikalo@gmail.com>, "cfu@mips.com" <cfu@mips.com>,
 Djordje Todorovic <Djordje.Todorovic@htecgroup.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>
References: <20250625201005.1480421-1-aleksandar.rakic@htecgroup.com>
 <20250625201005.1480421-3-aleksandar.rakic@htecgroup.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250625201005.1480421-3-aleksandar.rakic@htecgroup.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

Hi Aleksandar,

On 25/6/25 22:10, Aleksandar Rakic wrote:
> From: Aleksandar Rakic <aleksandar.rakic@htecgroup.com>
> 
> Add emulation of MIPS' CRC32 (Cyclic Redundancy Check) instructions.
> Reuse zlib crc32() and Linux crc32c().
> 
> Enable CRC for mips64r6.
> 
> Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> Signed-off-by: Aleksandar Rakic <aleksandar.rakic@htecgroup.com>
> Reviewed-by: Aleksandar Rikalo <arikalo@gmail.com>
> ---
>   target/mips/cpu-defs.c.inc                    |  10 +-
>   target/mips/helper.h                          |   2 +
>   target/mips/meson.build                       |   1 +
>   target/mips/tcg/op_helper.c                   |  27 ++++
>   target/mips/tcg/translate.c                   |  37 +++++
>   target/mips/tcg/translate.h                   |   1 +
>   tests/tcg/mips/include/wrappers_mips64r6.h    |  35 +++++
>   tests/tcg/mips/user/isa/mips64r6/crc/Makefile |  42 ++++++


>   static void decode_opc_special3_r6(CPUMIPSState *env, DisasContext *ctx)
>   {
>       int rs, rt, rd, sa;
> @@ -13463,6 +13488,17 @@ static void decode_opc_special3_r6(CPUMIPSState *env, DisasContext *ctx)
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

You missed my comment from v2:
https://lore.kernel.org/qemu-devel/a79706ef-9c53-4fb8-857c-e49475a55405@linaro.org/

The decodetree change should look like:

-- >8 --
diff --git a/target/mips/tcg/rel6.decode b/target/mips/tcg/rel6.decode
index d6989cf56e8..5074338aa57 100644
--- a/target/mips/tcg/rel6.decode
+++ b/target/mips/tcg/rel6.decode
@@ -16,11 +16,16 @@

  &r                  rs rt rd sa

+&special3_crc       rs rt c sz
+
  @lsa                ...... rs:5 rt:5 rd:5 ... sa:2 ......   &r
+@crc32              ...... rs:5 rt:5 ..... c:3 sz:2 ......   &special3_crc

  LSA                 000000 ..... ..... ..... 000 .. 000101  @lsa
  DLSA                000000 ..... ..... ..... 000 .. 010101  @lsa

+CRC32               011111 ..... ..... 00000 ... .. 001111  @crc32
+
  REMOVED             010011 ----- ----- ----- ----- ------   # COP1X (COP3)

  REMOVED             011100 ----- ----- ----- ----- ------   # SPECIAL2
---

