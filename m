Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD26606A31C
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 11:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=jaxX/M0J
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM2Iv-0004tE-Fy; Wed, 28 Oct 2026 07:58:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xM2It-0004t0-N7
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 07:58:51 -0400
Received: from mail-oo1-xc36.google.com ([2607:f8b0:4864:20::c36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xM2Is-0006I9-4R
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 07:58:51 -0400
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-703be215729so480741eaf.1
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 04:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793188728; x=1793793528; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=v6kLLJUvqD/rp9MXtzKUk1zv+SVurE8PyQf9hgJ5o+w=;
 b=jaxX/M0JpogCcR77fHBX4ZmjqVZ5iup2kmeF2GhpfDzoYF8V3LPjhIaXsUkBglCICN
 fH7Z+MMqpJfB5uAFeNQZ1ssQcrXLWa/DqzS8FAaoBVPigiwq6hp6+3VrIRINayDX3CIr
 ufE8lB7E9mRRdnCFpj07hEwX9ee6KfE6tBFBfnS3QEhygcHxccMAWCL4AYUXYyV/97Ns
 FTaXs2qzLteq1A3Qj01TfYm7LaYka8sDTiAe6ziPgcvfTQC4easfseK/KQSOjx3Lwh8y
 0/fb80/FchzNVFpC0fs9DhLOFBnPDDKR8x0H3J29Fdq8C6E57wMyHg8u22eezZMDqIDf
 Vlqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793188728; x=1793793528;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=v6kLLJUvqD/rp9MXtzKUk1zv+SVurE8PyQf9hgJ5o+w=;
 b=HxwlSwElmaz7lOCISBTDxOKS61ZWMOWvQUpM457b5aSSd6uogae6UL3QWXLHXwHZ7A
 S56D0Of64nRL25/USbxQhsHuXX0eH8bQxL+GEJHba7Qxo/P6YYRexWF7oE+/Kq8aN/sh
 ZXyc91kg8o6b7u34llqr2FNOmHEd14BeNjAI4cgxvJbr63zU0ylB0iRP+Q3pjJ4NMF6u
 o60xyotrT6BBT7CWDSAH7b5PB7v6sIDLlGPnvaGY7qNCTWVuWDB+juCAAYTBaef2YIhl
 io1O92MI8sa08cwngtQCkGrjLuZfZPhNGQAD/If1/XQI1XP7wfMk9dyub7AemDs/pyX8
 ji9Q==
X-Forwarded-Encrypted: i=1;
 AKwUvByjRxEcfiBcbMa37Pro7eR25FOpcATKX0N8NWsGF49fMOn/+DFyoXoiKCrarqEw90OCI8duksWW2Fun@nongnu.org
X-Gm-Message-State: AFq9FYLVySV8+6A31B3syaQHph05a3XD5+V2FAubPOeKiMF8/NYBq3r/
 bwYLpQPMMvlN//R0tjFmBn2f0Sij26WcBT5Jby1+VARMBWb9WBKOTtLlObc99rBxAUo=
X-Gm-Gg: AYBFou3rUw7/V+Jr1zmKYJb80jPm7VlBHWe446OHvqjXxyBpEpeAkS2VyrTNuvzq0Ll
 YfVWvKpDWsxmv7eYo6z9CBrcE/lgvSPeOulq/aJVtHrR4ZoNngsEJ3z+s07wz9P1mhDjXfWNs3R
 +o4aMaKhdPsDMDELtRdpL/h/Rn0AaF1FsbjycOMrcH8zEwi72cXES6EjcN957lEeD4Nh7DKjFo3
 q+s63wve0qn6LmD/L2hKFC5DkrEKniSOnWF9s5faxBblaytLCk5AfBQKYqGy/DUnWrSIXeOm9VJ
 P6fahM0KHbco8C+KFzDw5276DOhOetd6WpYlP+ypMhLKwkZoNeXzD3iRAwiyjWiHktJk+3L0QtF
 NVDb+9cDz+4vM5WEhzE4892Byf7lIt3j73KMpOLntjRSPlsV4yJ51PxdfcIWTBiUiLBwlooUFMf
 eQO29SqZ1H93amzAq2W1F/tejAiI85YOJ6VgtjiZtHsyZKJEBKkYZ+Qsu7mik3XiXyGyFA+i+Cs
 FMUJkPRmlyx5tf7c0GyAmb8LBHAhBhDAX8bkXr4AVb+2by5sYpGJAxBc3iKkGpI/JJ/XBT++Fys
 zgIRFtTms61LCfO0trVaCI5me1hx+m3TmNbc8mDx7zZgauzyo2x2VF+7CiOU7dHMUA==
X-Received: by 2002:a05:6820:7098:10b0:6f8:a519:d930 with SMTP id
 006d021491bc7-713ee3789admr737663eaf.34.1793188728293; 
 Wed, 28 Oct 2026 04:58:48 -0700 (PDT)
Received: from [192.168.129.53] ([50.233.235.3])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4a8b77ac132sm2300136fac.6.2026.10.28.04.58.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Oct 2026 04:58:47 -0700 (PDT)
Message-ID: <5c4470bc-12c0-4052-9207-4a2c9500ac93@linaro.org>
Date: Wed, 28 Oct 2026 06:58:46 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] target/sparc: Model block-initializing stores
To: Stian Halseth <stian@itx.no>, qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Eric Biggers <ebiggers@kernel.org>
References: <20261028113816.1651212-1-stian@itx.no>
 <20261028113816.1651212-2-stian@itx.no>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261028113816.1651212-2-stian@itx.no>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c36;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc36.google.com
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

On 10/28/26 06:38, Stian Halseth wrote:
> On T4 and later, a block-initializing store to the first doubleword of
> a 32-byte block zeroes the rest of the block (measured on a T4).
> glibc's niagara4 memset and Linux's NG4memset rely on this, and
> OpenSSL's T4 AES code uses the FP form, stdfa.
> 
> QEMU only accepted the integer form, on HYPV CPUs, as a plain store, so
> with the crypto hwcap a multiarch glibc memset leaves stale data. Accept
> both forms when the CPU has the crypto feature, which implies T4 or
> later, and zero the 32-byte block as T4 does.
> 
> Signed-off-by: Stian Halseth<stian@itx.no>
> ---
>   target/sparc/translate.c | 43 ++++++++++++++++++++++++++++++++++++++--
>   1 file changed, 41 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

