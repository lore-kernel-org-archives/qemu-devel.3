Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D879CD11C2
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2024 12:57:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsj8G-00022a-Vl; Fri, 05 Apr 2024 08:57:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rsj8F-000221-Kz
 for qemu-devel@nongnu.org; Fri, 05 Apr 2024 08:57:23 -0400
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rsj8D-0001Zo-Ge
 for qemu-devel@nongnu.org; Fri, 05 Apr 2024 08:57:23 -0400
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-516b6e75dc3so2759336e87.3
 for <qemu-devel@nongnu.org>; Fri, 05 Apr 2024 05:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712321839; x=1712926639; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=diZlk5ZCU4Vk5PQBATS854iIQezLmybAAv0x6JwkefI=;
 b=arOuXu1kHMYeeu8oy7W9242JQCLxt4Yh0FCiFe1tgiAOaR7vY9hpiAOVjv4rkH3un2
 +ZzLRF1Izwzs1OAZ8VG8vVds5nLRcjBRYZs462CGi59NVAScewKiRWTEvNHDslgURA74
 fDKYP5Batm8+i4Qo0xsTKBiagOHxMm5rFvKIPLolE8GaM55g+U8nOk5/l6Zp665T6F+p
 tOIogsUDA28N/8kJM2ItztxMVn7r4vF6EGZfogZthTKSOv2pmYHhv2xi6aGrtDXV08dL
 Orul6LmkDufdwg2AspFEZOFH2wSJOWl+74OpTaVN1aIUGnnDEp+9xDvQU9YdDKbawb51
 Ej8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712321839; x=1712926639;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=diZlk5ZCU4Vk5PQBATS854iIQezLmybAAv0x6JwkefI=;
 b=SNSUZQAerFIVqdK75fwnPp8mCwt/6Bsq5qRjvKSUlFt4ecPMdDWQS+1kVGScr9Znt8
 yt/nSEyV5vJ+DVxIarAJ52QFc5/hMAGbgYJ6QNfV7F28Smttl5uluKtXkbbktTr3Lsf0
 5z5hWWCpaebY5QGmVI+G7WoGh6grJ0rHtQsuD7V4hQAWvZDm2QXI1k4DDHa3B4vW/TDn
 VYOIowSynT45muBhVH3t/PhKiR70xz8eE5BnhaU/IP9lJoGs152rQfBAEw6VAfzK0oxv
 uqTqFS4kIPi80geFQvDixHS8WskbwYTI7Ovls9YX3p9xFqlX/kvdHfu7Ul7bCHmDM9fV
 DBDQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWCERyDhAWa9INyLL0PKkzxTS83i/JxBgVFag1Ez9f+ALc9hXWSYUIvuv/9SA9B+KKvcuDOkyhVxCV0yDYW0Rk+QOgaCxw=
X-Gm-Message-State: AOJu0YzMK3NDCLjec3iY+PwPk/viIb1oSJFTEOBJUHsAI6uElAPgRFlG
 VywZbgnU34YLC593wYL8PzJsYf2m1ooeca8nXH1SU/RsQ/3egJ4W8IoUyvq1yyc=
X-Google-Smtp-Source: AGHT+IGL9T9mdxErx493HSlRgMwqniCH9ZP8Vwqa3jJYcHZBPAXWxhYpbaudAWR3dZlvGu+Rlgnilw==
X-Received: by 2002:ac2:5111:0:b0:516:d16f:29d0 with SMTP id
 q17-20020ac25111000000b00516d16f29d0mr922415lfb.1.1712321839141; 
 Fri, 05 Apr 2024 05:57:19 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.216.34])
 by smtp.gmail.com with ESMTPSA id
 p9-20020adff209000000b003432d61d6b7sm1971685wro.51.2024.04.05.05.57.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Apr 2024 05:57:18 -0700 (PDT)
Message-ID: <609789b6-1b8b-497d-9995-4f595638a5e3@linaro.org>
Date: Fri, 5 Apr 2024 14:57:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 25/32] target/i386: Use translator_ldub for everything
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20240405102459.462551-1-richard.henderson@linaro.org>
 <20240405102459.462551-26-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240405102459.462551-26-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12c;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12c.google.com
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

On 5/4/24 12:24, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/i386/tcg/translate.c | 8 +++-----
>   1 file changed, 3 insertions(+), 5 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


