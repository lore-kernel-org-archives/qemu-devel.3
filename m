Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A200A606A31E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 14:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=CDSLPED7
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJXfC-0006vn-2i; Wed, 21 Oct 2026 10:51:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJXer-0006tR-Aj
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:51:20 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJXep-0004tb-Ok
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:51:13 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4a1df146015so6759435e9.0
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 07:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792594270; x=1793199070; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=eS/6zVuIuwV85/nCFw/ERTaRJHrRp1Uw95UEvFP9xEg=;
 b=CDSLPED70690V3AP5N0D6s3PdJag1KRT5bQqJtDcYt9WTacDv8oOKUlpoOi45IW5Oj
 Fdjy13uXYlYtDeTz0Ru9vyWWrlI/mvJ/RHKh850qsnrqbZjEfpgmaIlQdB4DDmerNeZn
 LItpOn/KeQU7RrAUoMTObPskVyYzf1JUGXKWgZlVXhISc78ByNz1Z+/Ap+hzvcXkSATw
 vimj9ziHaAoWnhQSzBMdMP3EXAzUeCTKz8Ta4/e/vtmbPouesZAJ7ANnyPQ7VNObS3Eb
 vyFza9Bf22monQ4bVTa2YYrWL1cXnULUzPBKQRGfk7flkSGhMXQ2+FOO077WwuUTh8AH
 1bwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792594270; x=1793199070;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=eS/6zVuIuwV85/nCFw/ERTaRJHrRp1Uw95UEvFP9xEg=;
 b=zH630BqiuD6kCESzSvMuxiYzicSr/qQXFoD3TfmaF9N9Fxf5UkxEW02XDCz/+IjLCw
 68oqq2uiR5VjKxWrksqu1JSOXahnt0Sldq4M9ZuJCx9Ft7EohFzt5A+c8jNRMIJ6QGaV
 w7FU4o08CTbgZYLz1eVHK5V6NFT7faEchIr0xe7DWUFHyHqN7Ogjtt+o7fUOOtzZVKKB
 F6BZEr+2J50Y3zpec9pHqdtew091kwaDo8JPDqekXQWUNE2gijukiUX8txo212rv8hrK
 pfc9Y8hPUudX8IALOaeaiHwAz/wYZ6GFf0k0ISvuScMgMaA1L2p1PEki1kH7lqAqFnJK
 Hfhw==
X-Gm-Message-State: AFq9FYK46kS7GkMwZg9cn3ZBoNq4j76ic+yzk6tCoM03IxJV5KRgwovM
 zb7/R/czxk9cUrjKuIER6zhJSBBimek+F0z3hPvIN/8zTyRHm+0vS2z7cHqqTDtpfmm5HZxXetr
 lljTXar0=
X-Gm-Gg: AYBFou0kp1gq9U4LE0+7bTZG4ZAXCmoiEJQidYbsnwBqZ/+/cJf0RsBcJO4yrgu0nyL
 Vs0RvnR6+4LImz0xzaAILC0BDp3sjo5IVPKOUiGsBWTpvlvYm7ljHwyfpTb2S36AZsj6gcjO30T
 fhpee1qSsoZzMYsJKgD6oMCvbH4wvkp5tMJ6jObpNmWwGKFELo9l8D5r8ufJDFOyIL/WICbyCP8
 3X185L5wTbvV3aeYFSADnBkQcwIvXEjJkoOBKQTKZyjHZ1X8gQR8XR5yw6GCJ80N3J2SowlvlBq
 sK8F1DqSyJ+7i32BnSV9fVo9EDgi7yNS549pr31SPn63Y+ThYyoCx4Marqec1g6ecrEMMqSJfZP
 Xh2eg62DOzBpH9rEKKPqy8zgJlWAJ1ALo7hFGi0uWMXWCu5IAG8HqpYotKDYsJtx4G+jDjz1DGK
 q20oqNGOhhpPUOg9e5OFvCWoi7QmctAcsoSURzy2SzYFupnwU26O/DTEKwQjNZ4PY9Odadz3uIq
 l55AKvhNORaKJSVHFw82wY+C52aVbC9RGy+1sRX+GGqrX/RIZBfAUVu7fOXniMu/rvAC/azerkU
 7QoX87y1Yg/DA7C3pSwhYUYgvvU=
X-Received: by 2002:a05:600c:3b24:b0:4a1:f736:79d1 with SMTP id
 5b1f17b1804b1-4a1fdb20d04mr53324765e9.16.1792594270190; 
 Wed, 21 Oct 2026 07:51:10 -0700 (PDT)
Received: from [192.168.2.121] (pd95f64ec.dip0.t-ipconnect.de.
 [217.95.100.236]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e25828e3bsm5868372f8f.31.2026.10.21.07.51.09
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Oct 2026 07:51:09 -0700 (PDT)
Message-ID: <dbe41dfd-bc07-41ea-a2ca-8e9adc6261a0@linaro.org>
Date: Wed, 21 Oct 2026 16:51:07 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/9] hw/intc/arm_gicv5: Ignore low bits in
 IRS_IST_BASER.ADDR
To: qemu-devel@nongnu.org
References: <20260914160020.327787-1-peter.maydell@linaro.org>
 <20260914160020.327787-2-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260914160020.327787-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x333.google.com
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

On 9/14/26 18:00, Peter Maydell wrote:
> The IRS_IST_BASER.ADDR documentation says:
> 
> For IRS_IST_CFGR.STRUCTURE = 0:
>   Bits[N:0] of the resulting address are 0 where N depends on the ISTSZ
>   and LPI_ID_BITS fields in IRS_IST_CFGR as follows:
>      N = Max(5, (ISTSZ + 1) + LPI_ID_BITS)
> For IRS_IST_CFGR.STRUCTURE = 1:
> 
>   Bits[N:0] of the resulting address are 0 where N depends on L2SZ,
>   ISTSZ, and LPI_ID_BITS in IRS_IST_CFGR as follows:
>      N = Max(5, LPI_ID_BITS - ((10 - ISTSZ) + (2 * L2SZ)) + 2)
> 
> This enforces that the IST is aligned to the size of the IST table,
> or to a 64-byte boundary if the table is smaller than 64 bytes, even
> if the guest programs the low bits in the ADDR field to specify an
> insufficiently aligned address.
> 
> We were missing this check, and instead trusted the guest-provided
> address to be sufficiently aligned already; add the alignment
> enforcement.
> 
> The GICv5 spec defines the masking to be used with the expressions
> quoted above, which work with the raw field values from the
> IRS_IST_CFGR register; these simplify down to some straightforward
> expressions based on the sanitized values we've already extracted
> form those fields.  You can get to the expressions we use here either
> by working through the simplification of the GIC spec expressions, or
> from first principles (the number of bits needed for the size of the
> table in bytes is the number of bits that index it plus the number of
> bits specifying the size of an individual table entry).
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   hw/intc/arm_gicv5.c | 28 ++++++++++++++++++++++++++++
>   1 file changed, 28 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

