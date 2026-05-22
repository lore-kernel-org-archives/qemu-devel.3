Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51315CD5BB3
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 15:35:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQRuJ-0002HP-K9; Fri, 22 May 2026 11:35:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQRu7-000223-NV
 for qemu-devel@nongnu.org; Fri, 22 May 2026 11:35:19 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQRu5-0006fB-QA
 for qemu-devel@nongnu.org; Fri, 22 May 2026 11:35:15 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-c6dd5b01e14so3496510a12.0
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 08:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779464112; x=1780068912; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IzTfCEdFBiY7OpvLoQsbZ7exj4IZizj/+J3IwTRyHgw=;
 b=nwGd5yNt+9T3+YrVQZK4Q9SOCFT67Q6WUN31T6G6w+BpOuGVFQ0PNT6z83MJdHMNM9
 SRI7dHT6DWntIBUO7me584OA1Lcs3tW5NYkluAFeY87O1mlTnlGI5NHuCTKA/huH2cyY
 eWDxh8+DIgtU67xeU3jnONxLySwHB6ZbjThwRwFIBDEtPbPeuERHdmQMOEYTYcH4q1+Y
 ikxhMCpbN7odNEYHk5rMhHU9Uyge0m/bfTqg60uq+w8m5jVV79fdy/Vgwj7PsLG7F5eF
 cXKchlnBkYqIlwTnazNUgqEvGtsze933+zsxqmHP9vaENNIN2YVNbOkq+v5ShRq2E53H
 u/ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779464112; x=1780068912;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IzTfCEdFBiY7OpvLoQsbZ7exj4IZizj/+J3IwTRyHgw=;
 b=NTQmM1YyvnCREH3Lslrcdp1bb9oPqv2KJpUfaxvU6IyAdrpRTxQA4d+hKfJ+WtC3H7
 MgV8nldGQvrpqrL9b4Mz9WqW49hr46808l2/rzxjI6/0K4KM3Jm7lrNAee1W15lvEiR2
 mHh041oJU889kO9q86KlAjkOyJHyA9whe+vkte8fQegy+7TFK9sW6XXQsqGVr239lcjb
 4z5VPnqpJtfeUOSXXh+ed+VS5hozi2FY/NMNpyS4N5ZWe9FbLChf8Yg2uqyZCkiY13iv
 71SbvuoNqkBnVfVqjykcOYb5i3D1hUccOgCyJ8AO/ZRDK6pVLWdtAR2hFaOEA0kzIbkS
 HJDQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+T3q5SV4G0skq614rK4Jr7JgmTsiIt/dDtCKRobAIU34Gcew0Lp/gkGiC2CKfQGvov3OMH+IzXOZ3O@nongnu.org
X-Gm-Message-State: AOJu0Yy6TYgY1is3ttTb8JKgnrHJRYGXnaTBKbDwO0l6cka0UWvpdsxS
 txcy0dSUAGXb1e4weRifN3SKJSyQKQUIvXLyy2AtZRn+lWOolmFJ+/puX1WQT93NJ6Y=
X-Gm-Gg: Acq92OE4bGy4K8RideRTPT7rHKpP1dJTkZ6T6FEfQnefGUY5pYeclummhlb7fCIvu5N
 sFv0NejT0qbtfCu9zMVmK5MRS2yJY6C7ha5hV33BbzlZmalSPsEVlbXtOg754+oVMyeZtI/uh9H
 l9JRxVI5oEBEjCRZk1V4rcmalMjVFtlO20nOrCku26Xvbd3PHXCJus0V8WVJr/hg6sVX2tHbE+o
 XzK9AZgsWKZCP8LRT1b6Jp6AV8ezxJdIM9xHbL4N6+tNlYYNohdD0D5yq5FK5wZNoDgMiS6jWkC
 jhYv3B74RPpf4Jk0y2mG5Pw+rwYAE9S/DbPwx6b6J7EwmGAlEhbTnEzmmMmL3iQMqIEVeekWKRn
 mVquI7S2cwljePZBCaLMuS9aaTfGLDf0w9JvEfaVmuGBJPll3siBBkdED/nKO7UlO1Gxw5G405W
 z/b3jzEaE2WO2vNc8eNKDALorvWSmXSXqLQoYL1fyLh4H8KDyDKBA=
X-Received: by 2002:a05:6a21:9087:b0:39c:4af6:4309 with SMTP id
 adf61e73a8af0-3b328c988d2mr4601645637.12.1779464112087; 
 Fri, 22 May 2026 08:35:12 -0700 (PDT)
Received: from [192.168.64.111] ([50.78.183.177])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c8520576972sm2018560a12.29.2026.05.22.08.35.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 May 2026 08:35:11 -0700 (PDT)
Message-ID: <87e9bee4-f596-4058-87ab-8e20c0462133@linaro.org>
Date: Fri, 22 May 2026 08:35:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 16/22] target/mips: decode Octeon CRC and GFM COP2
 selectors
To: James Hilliard <james.hilliard1@gmail.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Aurelien Jarno
 <aurelien@aurel32.net>, Aleksandar Rikalo <arikalo@gmail.com>,
 Huacai Chen <chenhuacai@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>
References: <20260521-mips-octeon-missing-insns-v2-v14-0-fbf08e164830@gmail.com>
 <20260521-mips-octeon-missing-insns-v2-v14-16-fbf08e164830@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260521-mips-octeon-missing-insns-v2-v14-16-fbf08e164830@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52f.google.com
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

On 5/21/26 22:19, James Hilliard wrote:
> Add explicit decodetree entries and translator bindings for the Octeon
> CRC and GFM COP2 operation selectors. Unlike simple register moves,
> these selectors update CRC or Galois-field state and therefore remain
> per-operation helper calls.
> 
> Keep CRC/GFM decode next to the helpers that implement these side
> effects while avoiding a monolithic selector-dispatch helper.
> 
> Signed-off-by: James Hilliard<james.hilliard1@gmail.com>
> ---
> Changes v10 -> v13:
>    - Split simple register-transfer selectors into a separate COP2 register
>      selector patch.
>    - Use final CRC selector names in this patch instead of renaming them
>      later in the series.
>    - Route reflected GFM selectors through helpers immediately so no
>      non-architectural reflected GFM state is introduced.
>    - Add the reflected CRC polynomial helper with the selector decode that
>      uses it.
> ---
>   target/mips/helper.h                          |  1 +
>   target/mips/tcg/octeon.decode                 | 22 +++++++++
>   target/mips/tcg/octeon_crypto.c               |  7 +++
>   target/mips/tcg/octeon_translate.c            | 50 +++++++++++++++++++
>   tests/tcg/mips/user/isa/octeon/octeon-insns.c | 70 +++++++++++++++++++++++++++
>   5 files changed, 150 insertions(+)


Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

