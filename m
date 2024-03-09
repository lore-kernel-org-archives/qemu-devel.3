Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91AC7C54E41
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Mar 2024 18:00:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rj0yv-0001T4-2l; Sat, 09 Mar 2024 12:59:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rj0ys-0001SR-K6
 for qemu-devel@nongnu.org; Sat, 09 Mar 2024 12:59:34 -0500
Received: from mail-lj1-x235.google.com ([2a00:1450:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rj0yr-00068y-7g
 for qemu-devel@nongnu.org; Sat, 09 Mar 2024 12:59:34 -0500
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2d2505352e6so43030391fa.3
 for <qemu-devel@nongnu.org>; Sat, 09 Mar 2024 09:59:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710007171; x=1710611971; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NPY/kp1KD4PWUiMeEGufFpV/JodNacd7BSTG4rKE+vA=;
 b=w08wzqU13y29wFGnX+kuv4RZMyvxo7J85w8MHA5GyVVxM9GiJU9ucZVK5fzSdGZlhy
 c4uM7HJ0a8Xbgc16vbFzsRqAK0RiCsSiIJguucGHI3qtDSFHwVSMWQLvmAbdbGFvDoEP
 GOKs36Gg9xQ6p1ynk1+90JEN+70zSO0eLUfb/ZHLEd6YwdybiEWr8+iO8DS0mcx9xY+H
 w+7dKHTCzpnCFruUb9AG7xSd2tkuh14j2/rd9/ngTIis+AY1wu/w0RbAaqI2s/vmxCJE
 TpjWUQN64dHHTHjO08tQIg/qXoAPeA/NK4gFdM4i1X9jXJjufO6Z4xRXmtYASVFhMkLf
 8glA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710007171; x=1710611971;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NPY/kp1KD4PWUiMeEGufFpV/JodNacd7BSTG4rKE+vA=;
 b=lw1mQlfKX68a1fczfypZ8+SeS+nnzEtHp8mIO+AADOw0Z4un/v20nfLRKktdYdH87Y
 qsQNZMB6Usp2r9ZPl1XEy3MikGmS7gTmR2EjNh7fKN5K1CkxHDDY6BIV5QBnjpPTZXPu
 2kopz9sL+lSoQRTGX77UCP3H3nEJjE4fXmFc8tMzYacpD5FJkYw2/9Zk9Ke0hh1AOByI
 SY/jts4joQhM5WoXht/HNizzqL5u8fPjA9o9rxUhOInnFlfO3F8qg7Qmd4n0WIXWW3t9
 kwz0WBPRLkxZwBvJKqv/omCzNljgyzPHN/2+Hu6O6t8smRmzt/d7/NwmcHG/qtdM4ebw
 fmmg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWeHF1PHC6N9ZZy3yGNg8S/0WdsZnH4KMboB7EWTlUeNYSw08lH0sN8XlT9jLDPTLkByBCukp3i/Uq7XB4NUuTzJjU6I6Y=
X-Gm-Message-State: AOJu0YxkiTDSBglckTgBIj1Bwh4vGhIKEX+1B+17tz27Adk57tsc0grM
 7lvKoqR7l9B6mIjq+0DhPqBjeS54dkIpk0bP1zUy88s2nWLsoG9PxHsqSDZCbXztIUeLLo4QyfI
 g
X-Google-Smtp-Source: AGHT+IGvnQJftMDyeG/KK7S9WkVEo6qx4K2/iXlIb762xufSuCh5SLz+lZ5PU8FLt/l5+nTuTrxFgQ==
X-Received: by 2002:ac2:4ac1:0:b0:512:bf43:d786 with SMTP id
 m1-20020ac24ac1000000b00512bf43d786mr1482493lfp.10.1710007171060; 
 Sat, 09 Mar 2024 09:59:31 -0800 (PST)
Received: from [192.168.69.100] ([176.176.181.237])
 by smtp.gmail.com with ESMTPSA id
 fm18-20020a05600c0c1200b00413216d67f3sm2228569wmb.46.2024.03.09.09.59.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 09 Mar 2024 09:59:30 -0800 (PST)
Message-ID: <0e5f803f-f4ce-4b25-86c1-cd10c024f4a6@linaro.org>
Date: Sat, 9 Mar 2024 18:59:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] tcg/aarch64: Fix tcg_out_brcond for test comparisons
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, peter.maydell@linaro.org, qemu-stable@nongnu.org
References: <20240309175102.726332-1-richard.henderson@linaro.org>
 <20240309175102.726332-3-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240309175102.726332-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::235;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x235.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 9/3/24 18:51, Richard Henderson wrote:
> When converting test vs UINT32_MAX to compare vs 0, we need to
> adjust the condition to match.
> 
> Cc: qemu-stable@nongnu.org
> Fixes: 34aff3c2e06 ("tcg/aarch64: Generate CBNZ for TSTNE of UINT32_MAX")
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/aarch64/tcg-target.c.inc | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



