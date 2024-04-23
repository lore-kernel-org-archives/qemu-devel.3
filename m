Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F3C5C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2024 21:19:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzNXc-0004AX-Sf; Tue, 23 Apr 2024 17:19:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rzNXa-00049y-My
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 17:19:02 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rzNXV-0000Ze-Sk
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 17:19:01 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-57225322312so1144202a12.1
 for <qemu-devel@nongnu.org>; Tue, 23 Apr 2024 14:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713907133; x=1714511933; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HFw+OdKdBqF7hH7LaA4LY0DEgVmFb8k1himgrIYg2oc=;
 b=PTsFOLP22+cV4S9Uds9sfAnY28h3BhvPFR9B07qZnac+5G60W5msJ5xA2al5kZYZS/
 ikcBEVhBnGSDJy7V0IDyhVOiQuxr2qo8k6+MlbOayX+pzp/LKwxKETXugyoXcL8ncxwg
 fe1cQWsxpsXhxhR15jqcS77H9MRtkMp+6y14E6Zyn1YOHNey9pnMSi/Wxndbgq5wMFUe
 Tp0rczK5UTzSqPHxMGBpBU8lwKiBrCqt7/vP+bLSFAmUV6OQ/4/oy5CNYijetP5qKN3O
 Eq+KeX3T75lv86E1uJtb7MD2ZDvERBu9rUDKIKkU7NvEA5PC87hwkfOkGFlknnxTPCZa
 DOUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713907133; x=1714511933;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HFw+OdKdBqF7hH7LaA4LY0DEgVmFb8k1himgrIYg2oc=;
 b=HbeM8ICEF5Wt6ML7l8UBDUUIjPRXhTfDQu7EPHiXuh+z1vv2O6x7oEcnKOX77bAgNM
 QUdTLK26zPEmgYmkS6JG+W4dThXydjz2v60iAQ4R7wj2E2m6DHmbDhbwfnq2xmAu+km6
 HaORMnliEspDvn/vTEIbaC+DOD/g1DcLKTrQkX2Fxd4aRTNTX20aoVxFI4CDh825C++/
 HAK6RRu8Fcux6CanlYAREyLSGgbhQ8E/a60p37ZSnQKDxsXl6dOPAp2YbfLUZWnCpbwC
 AsKjBludyhdKEbamhjVzU9Gvuwq6HY0ibMi2liS8sM2UT/8Zkn6HtCmc9pdqdzlj8JD8
 bBzg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUwT7STyzddZRr+SbSKueLgwU2S1SpYWEExhUV+/s+wTzRSvL7bkhyR74+10NpsSo9NG05T/HFezzifeJRfquW7FImEeDg=
X-Gm-Message-State: AOJu0YwtRUMtI0F0FWuRwNgyKWkYdwpc9iI97P5KPTQL27PMDs8AauIC
 skSQx1MGMBAtyZ7qCZL3CRhTy1U1/pBnbGf/ZyBDL21hfmhwZeKBzNBA8h3g9vc=
X-Google-Smtp-Source: AGHT+IFDcAJS5e0sRuvEi5Voub82bN+wKAwDz2Gp9qHWkijgG7FzMMBfqnQiVPPfLh1gP7XLBhyx2w==
X-Received: by 2002:a50:cd0f:0:b0:56e:2493:e3c2 with SMTP id
 z15-20020a50cd0f000000b0056e2493e3c2mr319795edi.37.1713907132878; 
 Tue, 23 Apr 2024 14:18:52 -0700 (PDT)
Received: from [192.168.69.100] (pas38-h02-176-184-5-107.dsl.sta.abo.bbox.fr.
 [176.184.5.107]) by smtp.gmail.com with ESMTPSA id
 u15-20020aa7d0cf000000b005704b18ed2fsm7029329edo.83.2024.04.23.14.18.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Apr 2024 14:18:52 -0700 (PDT)
Message-ID: <169a6afc-2dde-414e-a88b-04587722a530@linaro.org>
Date: Tue, 23 Apr 2024 23:18:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/5] hw/display : Add device DM163
To: =?UTF-8?Q?In=C3=A8s_Varhol?= <ines.varhol@telecom-paris.fr>,
 qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>, Samuel Tardieu <sam@rfc1149.net>,
 Arnaud Minier <arnaud.minier@telecom-paris.fr>, qemu-arm@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>
References: <20240421140604.111262-1-ines.varhol@telecom-paris.fr>
 <20240421140604.111262-2-ines.varhol@telecom-paris.fr>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240421140604.111262-2-ines.varhol@telecom-paris.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52c.google.com
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

Hi Inès,

On 21/4/24 16:02, Inès Varhol wrote:
> This device implements the IM120417002 colors shield v1.1 for Arduino
> (which relies on the DM163 8x3-channel led driving logic) and features
> a simple display of an 8x8 RGB matrix. The columns of the matrix are
> driven by the DM163 and the rows are driven externally.
> 
> Acked-by: Alistair Francis <alistair.francis@wdc.com>
> Signed-off-by: Arnaud Minier <arnaud.minier@telecom-paris.fr>
> Signed-off-by: Inès Varhol <ines.varhol@telecom-paris.fr>
> ---
>   docs/system/arm/b-l475e-iot01a.rst |   3 +-
>   include/hw/display/dm163.h         |  59 +++++
>   hw/display/dm163.c                 | 334 +++++++++++++++++++++++++++++
>   hw/display/Kconfig                 |   3 +
>   hw/display/meson.build             |   1 +
>   hw/display/trace-events            |  14 ++
>   6 files changed, 413 insertions(+), 1 deletion(-)
>   create mode 100644 include/hw/display/dm163.h
>   create mode 100644 hw/display/dm163.c


> +static void dm163_propagate_outputs(DM163State *s)
> +{
> +    s->last_buffer_idx = (s->last_buffer_idx + 1) % RGB_MATRIX_NUM_ROWS;
> +    /* Values are output when reset is high and enable is low. */
> +    if (s->rst_b && !s->en_b) {
> +        memcpy(s->outputs, s->latched_outputs, sizeof(s->outputs));
> +    } else {
> +        memset(s->outputs, 0, sizeof(s->outputs));
> +    }
> +    for (unsigned x = 0; x < RGB_MATRIX_NUM_COLS; x++) {
> +        trace_dm163_channels(3 * x, (uint8_t)(s->outputs[3 * x] >> 6));
> +        trace_dm163_channels(3 * x + 1, (uint8_t)(s->outputs[3 * x + 1] >> 6));
> +        trace_dm163_channels(3 * x + 2, (uint8_t)(s->outputs[3 * x + 2] >> 6));
> +        s->buffer[s->last_buffer_idx][x] =
> +            (s->outputs[3 * x + 2] >> 6) |
> +            ((s->outputs[3 * x + 1] << 2) & 0xFF00) |
> +            (((uint32_t)s->outputs[3 * x] << 10) & 0xFF0000);

Alternatively easier to review as:

           uint16_t x0 = extract16(s->outputs[3 * x + 0], 6, 8);
           uint16_t x1 = extract16(s->outputs[3 * x + 1], 6, 8);
           uint16_t x2 = extract16(s->outputs[3 * x + 2], 6, 8);
           uint32_t val = 0;

           trace_dm163_channels(3 * x + 0, x0);
           trace_dm163_channels(3 * x + 1, x1);
           trace_dm163_channels(3 * x + 2, x2);

           val = deposit32(val,  0, 8, x2);
           val = deposit32(val,  8, 8, x1);
           val = deposit32(val, 16, 8, x0);

           s->buffer[s->last_buffer_idx][x] = val;

> +    }
> +    for (unsigned row = 0; row < RGB_MATRIX_NUM_ROWS; row++) {
> +        if (s->activated_rows & (1 << row)) {
> +            s->buffer_idx_of_row[row] = s->last_buffer_idx;
> +            s->redraw |= (1 << row);
> +            trace_dm163_redraw(s->redraw);
> +        }
> +    }
> +}

> +static uint8_t dm163_bank0(const DM163State *s, uint8_t led)
> +{
> +    /*
> +     * Bank 1 uses 6 bits per led, so a value may be stored accross
> +     * two uint64_t entries.
> +     */
> +    const uint8_t low_bit = 6 * led;
> +    const uint8_t low_word = low_bit / 64;
> +    const uint8_t high_word = (low_bit + 5) / 64;
> +    const uint8_t low_shift = low_bit % 64;

FYI note the BIT* macros in "qemu/bitops.h" (but you'd need to
use arrays of unsigned long instead of uint64_t).

> +
> +    if (low_word == high_word) {
> +        /* Simple case: the value belongs to one entry. */
> +        return (s->bank0_shift_register[low_word] &
> +                MAKE_64BIT_MASK(low_shift, 6)) >> low_shift;
> +    }
> +
> +    const uint8_t bits_in_low_word = 64 - low_shift;
> +    const uint8_t bits_in_high_word = 6 - bits_in_low_word;
> +    return ((s->bank0_shift_register[low_word] &
> +             MAKE_64BIT_MASK(low_shift, bits_in_low_word)) >>
> +            low_shift) |
> +           ((s->bank0_shift_register[high_word] &
> +             MAKE_64BIT_MASK(0, bits_in_high_word))
> +         << bits_in_low_word);

Splitting this (assigning intermediate variables) could benefit
code review (see earlier suggestion).

> +}
> +
> +static uint8_t dm163_bank1(const DM163State *s, uint8_t led)
> +{
> +    const uint64_t entry = s->bank1_shift_register[led / RGB_MATRIX_NUM_COLS];
> +    const unsigned shift = 8 * (led % RGB_MATRIX_NUM_COLS);
> +    return (entry & MAKE_64BIT_MASK(shift, 8)) >> shift;

Or simply:

       return extract64(entry, 8 * (led % RGB_MATRIX_NUM_COLS), 8);

> +}

Anyhow, I only gave nitpicking comments to improve readability,
model LGTM! :)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Regards,

Phil.

