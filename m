Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57054C52D6F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2024 23:45:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbqLE-0007f0-Q8; Wed, 07 Aug 2024 19:45:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sbqLC-0007cB-Jv
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 19:45:15 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sbqL8-0000jZ-Vt
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 19:45:13 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-7163489149eso268034a12.1
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2024 16:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723074308; x=1723679108; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qov+2DLJth+SpVJqhM5jB3KYlQXJAP67lEmC3DFAkSk=;
 b=e4CLo3s0fh0l9bwdNBD+wS5RpdfeY6Lz5ugQjPA0+rUYukEHDZ1PnZHSZgniOQk/at
 aAqmXmelk1PTT0I49W10nw5VsvwCId/+CISmo0eSZ7kK7IJd6F8W+mxMrfOsMtNwLaSx
 PuHnIkE7Y6u42VdtQFCcrF3C/LuDdvy5RNXP8CHrEEvlEJsFkRyCDT1pqD0AHntkm84R
 g1gLADjPkF5usLuFbSRB9MPnpXicFTjZnaN7bpl+CfVq+v8qDrkj6iyOnuBCydh66yp0
 8hTSEgr9MpZt5gWAs6DBxpAXse3BaA/5RkeTNRJHDQAOXJv4nfsR57pTBbyMEUhuH5/q
 nMjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723074308; x=1723679108;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qov+2DLJth+SpVJqhM5jB3KYlQXJAP67lEmC3DFAkSk=;
 b=UUzBQ+Q4nVC1sWwD+U+Ro2X6tOJAGV5fdgpvvNVPrxgdBymCH/oJmTnZy1M0jBkSD1
 wqrkvNVwJYvGXmjAVOgjYtdj9snDBTr0LuPBtR00fTbMrlSeT9UMHKGGOJMm9zSJowzq
 nEjBXZVnDDQoOT2RitqeZML7X3goGQhgyu4Zseu6fDGfXb/kMMQAC9aU9OyTR7OXq6qI
 /xqLTey0iP1OurMjBB0HR+ExJ2Zl5ziZkVS/Ack6y/BU6+VIAeQrNgEPb7GyGFMN3TEz
 hTWNu3Dpppt1Beid1Wp0jvLWdg6yNpTy5ySSMA3y4On2cZVxcWZR2Mua0goBNJCMnHhF
 LXMQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWfUdo2GOlTIpWrVOIHucBDZtGvEN6K0uMJKHfVkUa9RDqQ0gHmtSius4Mz+iu6shj1n0aUhzbRgVZhRw2TJthsdS5lmzU=
X-Gm-Message-State: AOJu0Yzmy4OccDeKUggf2JAzibhaVJTtlsPztRb+jWwEF5+jzWJgiFvC
 MMh3juif7SW7RGccFOCrvBoTQvtH/Rmhc7Tezb3Mf6AeOqDSLgKqjrmrEWotA6M=
X-Google-Smtp-Source: AGHT+IEfRRHPuinY6mkRyhg2PKuY9Tb4OqwSQ4H9a6//9bBo8Mje0LXcQekJ1V4u/dfr4/2wv20ZsA==
X-Received: by 2002:a17:90b:4b07:b0:2c9:8891:e12a with SMTP id
 98e67ed59e1d1-2d1c33e7d03mr244516a91.23.1723074308030; 
 Wed, 07 Aug 2024 16:45:08 -0700 (PDT)
Received: from [192.168.1.113] ([203.30.4.111])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2d1b3adaac6sm2179005a91.24.2024.08.07.16.45.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Aug 2024 16:45:07 -0700 (PDT)
Message-ID: <68f20670-d6a7-4b1c-b1a5-971391739055@linaro.org>
Date: Thu, 8 Aug 2024 09:44:58 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.1 v2 2/4] hw/ssi/pnv_spi: Match _xfer_buffer_free()
 with _xfer_buffer_new()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Glenn Miles <milesg@linux.ibm.com>,
 Caleb Schlossin <calebs@linux.vnet.ibm.com>, qemu-ppc@nongnu.org,
 =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?= <fbarrat@linux.ibm.com>,
 Alistair Francis <alistair@alistair23.me>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>
References: <20240807202804.56038-1-philmd@linaro.org>
 <20240807202804.56038-3-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240807202804.56038-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x535.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 8/8/24 06:28, Philippe Mathieu-Daudé wrote:
> pnv_spi_xfer_buffer_new() allocates %payload using g_malloc0(),
> and pnv_spi_xfer_buffer_write_ptr() allocates %payload->data
> using g_realloc(). Use the API equivalent g_free() to release
> the buffers.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/ssi/pnv_spi.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/ssi/pnv_spi.c b/hw/ssi/pnv_spi.c
> index c1297ab733..13a47f07e7 100644
> --- a/hw/ssi/pnv_spi.c
> +++ b/hw/ssi/pnv_spi.c
> @@ -53,8 +53,8 @@ static PnvXferBuffer *pnv_spi_xfer_buffer_new(void)
>   
>   static void pnv_spi_xfer_buffer_free(PnvXferBuffer *payload)
>   {
> -    free(payload->data);
> -    free(payload);
> +    g_free(payload->data);
> +    g_free(payload);
>   }
>   
>   static uint8_t *pnv_spi_xfer_buffer_write_ptr(PnvXferBuffer *payload,

g_free/free are supposed to be interchangeable in this epoch.

But
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

