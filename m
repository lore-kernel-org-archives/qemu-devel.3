Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A171BCD5BB3
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 15:40:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQRyy-0004Fe-D6; Fri, 22 May 2026 11:40:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQRyr-00048h-8P
 for qemu-devel@nongnu.org; Fri, 22 May 2026 11:40:09 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQRyp-0001BW-Cn
 for qemu-devel@nongnu.org; Fri, 22 May 2026 11:40:08 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-837b39eb078so5072238b3a.2
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 08:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779464406; x=1780069206; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2LaXVEhwCWMkiQ9jdiv4Auz/q6bxegL64Z0LEH1CJ08=;
 b=FwztEKX1oBvZmWOEP++JTg/uC3ST8NQLg6S/44pT4hiYue/T2Qgq4n3bth3DrYwRH2
 c12CZzOllyl8NymrqyG5Y4Z/PV181CT9zo4kqvx+KOJOTATa1LzUQOoQ49vFNUIibV2m
 4o+cC/ryS6D8G2wwcNrTR/6PdkG0d2NJQE+CCKPY2aqclc9qjZ42MPHkyfWJs8DN8Aa0
 T9nwnw24HP7o6XwjryxGqKWsR8ThfgcPeyejrNJQwZcm1/VCgc8d7SDvuVxlE+leChUY
 uw9LQ8EjUNvWT2k8aPixrTK0gX9bSwdzTjGZh+rl6lky4p90VGz4lVgboOfncVSyzpgq
 93Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779464406; x=1780069206;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2LaXVEhwCWMkiQ9jdiv4Auz/q6bxegL64Z0LEH1CJ08=;
 b=ry1CO6PpXTV03J2T4eHmjCkhbjoLy/13RqVQu3aSg99bmL0pYO4y4R6O4XNjN2v2GC
 T58uZt6OwguH0GWUJ5YIXsCblBH34hv5EW12fQSoDOEPd9Z1LFXywp1usjVEmIP2n+O+
 IqXlGkdeyWDZPv3N29ZOpOZyzhfKbeu4tTcsOamchcOsPnBg5W44QwDqTEnCAo90xnyF
 +7gEjOQ27LqnXU8o09c4GoOLyLO8TLofwaL01HgyxQr37Yjte0TBbIiT4zcKSl7pMoe0
 CwzvUs2a1P97vuWff4s77CN9KYy9q3mDf/c9e1nIvIrCgc9PIV71cbE8knV/B7E6/pSU
 EjHg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/htWCGCsKFGqetpuPkPIUmSOzNXzv4+FoAVk2IeTV6QBr37HNBQ+MS9u0iSIVuOMBBqPHyebEZCUye@nongnu.org
X-Gm-Message-State: AOJu0YyqT0WQwOWVok9fL4RgGHeTqCRG94I6MonmsLOIvn0JYDMDe4rS
 hKEkHSipJbhpX048eWJs7ROJQfo5C8hlwE2epIVduwym097YcHICpmXNmkhviTivt9o=
X-Gm-Gg: Acq92OGXXEQOM++xaWV0Lf9Cro7xJjd82YG4uf1FMZ+IALJTejYDLF2u2yOND57Gx8j
 +5ACvHwjgxqPvtWDm6w0X+MUdh06kaaexJPh9ULb7EcxO0y6bgHBsiPe/W81T9EXzGqG31huzJc
 dqW8gwSNU4n4SuitC2IgyqWI2mn9XccZGLnldq0u4wZmp9Ju5euoTRuf2rQW9ZHKT5wyh+SrHM5
 qymRxXAK/w3TY4UTOzC40ov0VF/BWrDcZ3E1508/DLrAZ2+9GiwomLQAWch3g2eWEbAgoC+pid5
 RfWNvjS5UBGJbjBQDkuDs2Em9ztPKzOq151IxfqK4RaWi9CqP6u81OO8itwC6XQ/O1SNDokKe/A
 zms+jVsoYgnGB7bJz99LzlT6U/R8cWpK3mYeXAJ8qwq42K7r9Jay+fEV4Hjw8HFZxCqNYOH/4Df
 StSNNePY/8xSEGL9c0aoc8XGaIX1sZNy56zkP4NXnY
X-Received: by 2002:a05:6a00:39a6:b0:82c:e83d:a9b0 with SMTP id
 d2e1a72fcca58-8415f552ce6mr4141099b3a.21.1779464405805; 
 Fri, 22 May 2026 08:40:05 -0700 (PDT)
Received: from [192.168.64.111] ([50.78.183.177])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84164ad2ca6sm2312710b3a.5.2026.05.22.08.40.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 May 2026 08:40:05 -0700 (PDT)
Message-ID: <942c3ac5-9e27-4dca-9d56-02a19f9edd00@linaro.org>
Date: Fri, 22 May 2026 08:40:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 20/22] target/mips: decode Octeon CHORD and LLM COP2
 selectors
To: James Hilliard <james.hilliard1@gmail.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Aurelien Jarno
 <aurelien@aurel32.net>, Aleksandar Rikalo <arikalo@gmail.com>,
 Huacai Chen <chenhuacai@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>
References: <20260521-mips-octeon-missing-insns-v2-v14-0-fbf08e164830@gmail.com>
 <20260521-mips-octeon-missing-insns-v2-v14-20-fbf08e164830@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260521-mips-octeon-missing-insns-v2-v14-20-fbf08e164830@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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

On 5/21/26 22:20, James Hilliard wrote:
> Add explicit decodetree entries and translator bindings for the Octeon
> CHORD and sparse LLM COP2 selectors.  CHORD and LLM use their own COP2
> selector window rather than the crypto engine windows covered by the
> preceding decode patches.
> 
> This completes the explicit COP2 selector coverage by adding the
> remaining CHORD and LLM register and operation selectors.
> 
> Signed-off-by: James Hilliard<james.hilliard1@gmail.com>
> 
> ---
> Changes v13 -> v14:
>    - Leave the CP2_Undef fallback in the register-selector patch and keep
>      this patch limited to CHORD/LLM selector additions.
> 
> Changes v9 -> v10:
>    - Split CHORD/LLM selector decode out of the monolithic Octeon COP2
>      selector decode patch.
>    - Kept sparse LLM operations helper-backed.
> ---
>   target/mips/tcg/octeon.decode      | 13 +++++++++++++
>   target/mips/tcg/octeon_translate.c | 13 +++++++++++++
>   2 files changed, 26 insertions(+)

Not present in the documentation I have, but it looks ok.

Acked-by: Richard Henderson <richard.henderson@linaro.org>

r~

