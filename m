Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8A16CD4840
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 18:41:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMVYo-0005yj-3J; Mon, 11 May 2026 14:40:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wMVYm-0005yX-Rr
 for qemu-devel@nongnu.org; Mon, 11 May 2026 14:40:56 -0400
Received: from mail-oa1-x2d.google.com ([2001:4860:4864:20::2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wMVYl-0008Qf-Cn
 for qemu-devel@nongnu.org; Mon, 11 May 2026 14:40:56 -0400
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-4350cd5b97fso2788837fac.0
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 11:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778524854; x=1779129654; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jtG3foV3RgelOTLNAdbD1fNP4fO+C49Ya4sJvG4H6hE=;
 b=UPg3Ltg/dTmlSKg1Sc2C9fNe+ojdois3RMaM8Hjl1IZxFTn+8cceEE+NxqC4yg2LVL
 0ShUjYA7iRFfxokT1cD68fGKynAi6wkfalWzbVoIo22lWS2sQF91hOIrsgophB5qa1Np
 rbMa0yT/PQ3nPRnnlLuX94CM27KjhPGtHqb8uncp0bmDqalLXZgkbVKQPCxQNIfjCmcE
 O8msn38i84VyVO4KwelLGmWuO7QoQuWfM9yXrwpsZ5+okLOrZ6ce98U6oKux0lri7tC4
 P8amCOX7vdTXx4lZDCX3bnSnXDwnxvrexZzBZHGp2/S/NvLr4Q9lgp1WH9Q8smMgz1gH
 RZPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778524854; x=1779129654;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jtG3foV3RgelOTLNAdbD1fNP4fO+C49Ya4sJvG4H6hE=;
 b=f/4nFgmBM9J/1XWDtycehCem2jpU5yHJPhIq3adEbc23xc4/o5bz+tRitsAQAAhvJ4
 X+nckbhnADfgVgq34ia27D1mObLkKxmzh8DlvxjWEzHobEMgnyNuP9tpN6I7PjfvBKj9
 B2siktRv4QU6Ofh/mu02FWt81OBZGPVjWiea5f5kcq5ugu07hsXxU6SqM0vzYgcehd9U
 GIkgJeVrC0iUVofctsYf4R4bjr694rxeA0q1seLehGQB5Z0G3UMKwb3ByBr9L2i81PWa
 X6/VFGALh/Ako0cUO82N/sthehpzaWEomcAq98QzAHJN8eLrXV+DQ8PrRtNsozCClKdQ
 c63w==
X-Gm-Message-State: AOJu0Ywl0a4f4xenMRlambBuYdj8otoBPqZmpWpU9KcN0rtbsIuqbK6u
 EzmioFGaLSQ0FWJXKItHDfbCexfcoFqQXzv/54WyXeFZeJVreB1TLBVIDhbnhXPc4kmo8WAZO3F
 Py7z7
X-Gm-Gg: Acq92OHn+8/NZgccTXUBcfrF0o0km7DRltsyhcL83UMk26r0k8a2wGCM/q5PeqvxfgG
 UTychgU26wOMltOPGwEq312mvh3qPI6ZwcECWu0DBBZBx6FCbHxOFz6KbbPpBc9hvEul/7qu45u
 IKz6mW16qx4u/KRQtttWUHic7xt8DID4eyBDFaS15k1ubcEC2FDoicRVCZTODWRgZ6vPQFX1oeX
 QeTsf2rwvzfZu75hexmiYL5q6u/dnjYeBc1rr7Q5nHGxpPpkLfytlWH6UHCKNjmQCbYkvs4IsNF
 6l5dH6Cy+vlScw5Z+tVkCPz7BFCBLlyHbPzlcoSnGqNuthBfmK4d2RqQ1WrWPFZ1+oaMhpltwDF
 M9wJRQwNRWPglC5iZbCWtbSJWuKh0GHlL54BO/3PBLPMle1wOLH4yAkyiW1zbizyON0ZVOCK2K5
 QCkpg/TklM4jTzDwwt/2bnjXiHFf0g43MOgs9RQX8P3CJoW8IKRHXLlzt8mbHmykRDQ4VXLr4az
 Ab+DSzIQw==
X-Received: by 2002:a05:6808:350b:b0:467:3f4:907c with SMTP id
 5614622812f47-4804252f32cmr15529409b6e.47.1778524853917; 
 Mon, 11 May 2026 11:40:53 -0700 (PDT)
Received: from ?IPV6:2600:381:c938:6375:e3e5:757d:3cef:3491?
 ([2600:381:c938:6375:e3e5:757d:3cef:3491])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-47c76936271sm20671849b6e.9.2026.05.11.11.40.52
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 May 2026 11:40:53 -0700 (PDT)
Message-ID: <39cfd3f5-0c20-4246-8fe6-a0242029d88a@linaro.org>
Date: Mon, 11 May 2026 13:40:50 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 15/35] target/mips: add Octeon MTM0 instruction
To: qemu-devel@nongnu.org
References: <20260511-mips-octeon-missing-insns-v2-v6-0-5062889c4d3c@gmail.com>
 <20260511-mips-octeon-missing-insns-v2-v6-15-5062889c4d3c@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260511-mips-octeon-missing-insns-v2-v6-15-5062889c4d3c@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:4860:4864:20::2d;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2d.google.com
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

On 5/11/26 13:22, James Hilliard wrote:
> +static void octeon_reset_mtm0_mpl_state(void)
> +{
> +    TCGv_i64 zero = tcg_constant_i64(0);
> +
> +    /*
> +     * MTM0 defines MPL1 as zero; model the architecturally unpredictable
> +     * MPL2/MPL4/MPL5 lanes as zero for deterministic emulation.
> +     */
> +    octeon_store_mpl(1, zero);
> +    octeon_store_mpl(2, zero);
> +    octeon_store_mpl(4, zero);
> +    octeon_store_mpl(5, zero);

Where do you get that from?

The octeon2 documentation, which only has MPL[0-2], MTM0 does *not* modify either MPL1 or 
MPL2.  While I don't know what changed with octeon3, I really doubt this statement is 
true.  It just doesn't make any sense.


r~

