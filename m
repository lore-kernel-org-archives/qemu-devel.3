Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA8E606A31C
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 19:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Yj6B6o+h
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTOe9-0002Cr-Ep; Tue, 17 Nov 2026 14:15:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xTOe3-00026K-Ge
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 14:15:07 -0500
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xTOe1-0002Xv-So
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 14:15:07 -0500
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-cdb9f760337so797217a12.0
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 11:15:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794942903; x=1795547703; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=gnSNt4uMLabSYXqDYHRvl7r/OXoXmrHDwaH/8ayaypg=;
 b=Yj6B6o+h/c/2+7+xTnhRd3HWv15wXS90q4r5sZ3QJ/WQs5IwUaAxrqB4XZvWAFY0St
 6G1jVjTK/ioV1YuaExySbN3AqyTCbBfAN1RdgfcLTYNBiHHxMwi5u07hfGS0Sk7boIj4
 rvyhH2GL8JwVZV3U+HBKMyZPQSFlECiMi1r8QRI9YL1w8YLhxnUAPIGDy5iFcn3eHCvT
 Bnf5VlyVXq4WQsmNDfa/zshp5kKxLwChXP0jLNvzk02dbvHYj5lhAN57RPZZA4hUcsX1
 blQ+hyHG9yvOtq4E7lkESOaOqhAgllLTuvtts1jk/AiDnXyFrBH3HuFgNym9AY6m0iGn
 +z9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794942903; x=1795547703;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gnSNt4uMLabSYXqDYHRvl7r/OXoXmrHDwaH/8ayaypg=;
 b=yLSroeTASxmFQjMGld7pxl36xU/7mWABx0eUBy9HRUTi61ohbt1/Gn5Mp56qmKKwTq
 GkbZYp8kfbZqIuJzbAQRVya1Wh7KRFP1CMS2WEVkW5JLgOxSowEIg80kOyofkoYDAUce
 hgeSriFUxobP9VTANhr5RJd6OFXPsBzaU0f3Rpe1lI+Vf/sP65piZzYNuK64vsJEAwcK
 8LcJ5nRtJVUbNfZUus4fpu0rMP9JQvFhGRs/IHaL+5R9/pyMn5GXsjgHDER+MyOEMWvo
 Xyb0njpFB9dZp+Rr/RYVpRF9/GdGMlFzSixyEwzIC0nyYiuJpSkLlIOxbEgqXLn417Yp
 kzOw==
X-Forwarded-Encrypted: i=1;
 AL+hErFsi1qEg5i66fspL90u1yl8LZ2Ad2z47fQaWtoJ8WlMQcwxN0Pu8FWVgfCNatcxM3FTP2j/T4JmhO0t@nongnu.org
X-Gm-Message-State: APuU4Z8yBLaeAE9x7aYUvQ26f173Mc31Zka8p2OHF3QtYmpJ8mDIEuWW
 fd6LU0uxbD7rjh7D6mcRJHACjZ5KSpr6JD0/dsL474/rm/7jnMqQ2H+bRolCjZ0FsMI=
X-Gm-Gg: AZFdTZckj7ummAlfwjkiLn8r9UBJXNqeUa0bdUAFA9tJf4dsPHg/G+St2E4xfa1L2Ef
 YJeMJWahV7J2qJFlDaMk+Z2Ek5VoSuQfV6/EYeAmTndqmDCcO4yS8qN1iVWWbSOElLcBfmjX96J
 242wuh35mA3EXFXLR+sTjVyhclXW38BSO7ALdT8FGa4VNwocM0p4OV5me6OzI2LcuFiGvVfk582
 Wx0R1brj9PRZAhyOKoVowulUxjhohbORhvNdV2Q0gPgInnukzcgCrjOZY9HT33balrj3aUe2yVI
 0wADitaJ94eg6TszVj2iIlrMC5+BA2tgbt2cNBC2YctEto3Fojib0MHjZX+bdu4UdI1GbeB0GQH
 JTFwR9xqH8YbA7jBoXOEdMm6eMPOcHJuRHhaiICo39KXkwSkQhySb09Zaw5x+HxZz7rbAfkqk3I
 IKQndhL+osFZ4v74EKfcsRObM9LT3H7GuyxdhInwPyqF2uxhqCpVaO7YqVT0NSWGH98W5bbEl7q
 sgcoV9Oz8rOf2jvKxMISyl+2vKpK45wMX3Pc76Rc9Xp3vVOh/z93ExzyDDgNgzt3HBH3oSuyxq7
 X1Oh8IKoPncLiRoUJqjt6I9GrGIZ8YMaKzl8NYxUmJkpyfhAYZwlWeaB7goxeHZzAtCiN7nZ+S6
 Q+6lui3EsS+eIPraYBQ==
X-Received: by 2002:a17:90b:574b:b0:3ac:b3c7:de04 with SMTP id
 98e67ed59e1d1-3b3d0856cebmr217709a91.34.1794942903421; 
 Tue, 17 Nov 2026 11:15:03 -0800 (PST)
Received: from [192.168.0.4] (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b3ac254ba6sm5288023a91.4.2026.11.17.11.15.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Nov 2026 11:15:03 -0800 (PST)
Message-ID: <6dd06b3d-ad5f-432b-8d4a-950d13411b4d@linaro.org>
Date: Tue, 17 Nov 2026 11:15:01 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/19] target/mips: Fix nanoMIPS BPOSGE32C branch offset
 sign extension
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
 <20261113161158.25811-11-philmd@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261113161158.25811-11-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52d.google.com
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
> The BPOSGE32C offset is a signed value s[14:1], with s[14] stored in
> instruction bit 0 (MD01249 rev 0.04, "BPOSGE32C", printed page 88).
> The decoder zero-extended it, so backward branches went to the wrong
> target.
> 
> Reuse the sign-extended offset already computed by the P.BR3A pool.
> 
> Fixes: 6d033ca7513d ("target/mips: Add emulation of DSP ASE for nanoMIPS")
> Signed-off-by: Philippe Mathieu-Daudé<philmd@oss.qualcomm.com>
> ---
>   target/mips/tcg/nanomips_translate.c.inc | 8 +-------
>   1 file changed, 1 insertion(+), 7 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

