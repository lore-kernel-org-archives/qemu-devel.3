Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77FFDC48260
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 06:52:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZmdJ-0004Nl-K7; Tue, 13 Feb 2024 01:51:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rZmdI-0004NO-D0
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 01:51:08 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rZmdF-0003bA-CA
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 01:51:08 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-33cda3dfa06so114445f8f.3
 for <qemu-devel@nongnu.org>; Mon, 12 Feb 2024 22:51:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707807063; x=1708411863; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Wo3bQjPU2wynG1/Vy9113QM0pV7z0RrwzJfI7wDZ2zo=;
 b=cE6p/W3hd7vl6FGTUpQuhY1S+mzeW8C1P2XKHKXvwRObamDqYFVp2wRTD0dVAKmGPW
 ThJ+I9pIEWOGUCS5s8P4wn/aMywPLOb0uzyRL6rmgoSCpqYyiuBOiHdZiNoff97DuFmh
 5g9PY97M+VPtVEQT4f8nw4FJrOFUjBpD/fMZDnmErLSIke+8UMUctkmVLgrXPNOSH3bv
 Q3Q2ab/t9HJmlI05V1GvnpJh78zR2j3dQAOz4rC6Uq9wxDy3a2Xp4F5dLoSnjZR/9nFO
 3IqY+Hx2Phyzas/tnKUCN2bRyhO5eTCR1Y00Kx4AWWQsIKX7mZy+6vb34YrdqJLw2rzf
 isug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707807063; x=1708411863;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Wo3bQjPU2wynG1/Vy9113QM0pV7z0RrwzJfI7wDZ2zo=;
 b=pS0Qv4nNFE9PkoS5VoKePVAeulxNlUft5tlELFrcdCI/t2Vdfvcq/PhFyEVZeV7hML
 BIJ15tdWO41XiLYpXuQ9gjl8i1mUaxKqE+HyVJMVP3NM0h1+6rUeoLnm8DLzJDX1BNiR
 po0Ekx8aVxIIXabICKE/OUmjbWYWW8t44z5Vdp1zyG4xu9aviQNLc0yuZ+kgeXKy90Na
 kuppopd6uct7W0lO5ucGCLVNVBYyGycJmX7/rGmEDlLgBdttnKaG/ZtNZNv7WIq7xBU9
 nga5XkW2aZhP/HkjLWi9YUUiDRmzF8QgbEvF6QrRCCvmAO4SphE21dEsPyiQ3noH4RA+
 RHpA==
X-Gm-Message-State: AOJu0YzR2HYiy0F8FoyPz0qTnEjl5Ag9FpUQR9Uywrkm9kh9Y7HPApDm
 H3Yr1R9n+9Hq1EyaR+gXwmg3RKCBHONhaf+2I7/kzo6KPuCne1xAKUpH32VHAlE=
X-Google-Smtp-Source: AGHT+IHoOqnyBcv5zvGdoOHUjDU+amJFVZkMJpW882nA4uaxWru8GcBDMMvtkGV3JffVOB3EWtAyBQ==
X-Received: by 2002:a5d:5f55:0:b0:33b:4d27:6303 with SMTP id
 cm21-20020a5d5f55000000b0033b4d276303mr7330562wrb.12.1707807063528; 
 Mon, 12 Feb 2024 22:51:03 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUcfaYg7TNqpzB6HuF/6liEBNBP9ufhYe2fst0sbQ/KhJUJlHlJ1NLzw67t1/efosrmtzlS1ADyMG27a9sRbeJ4royYyelzym0adw+HeutbD8TW6QCd4OSTeKARcypqoV3xbtQDicatfFrr8LvlMgJRTJOQOe5pENPRSA0HKL/Tm6Lcma/mjT7LyXG+mLEX/8a25tSRv2Pii1B+Mxs6chwvrrwR75VoQSxgJpeET+a6ZsJgGnQ=
Received: from [192.168.69.100] ([176.176.128.243])
 by smtp.gmail.com with ESMTPSA id
 bp9-20020a5d5a89000000b0033b4796641asm8772144wrb.22.2024.02.12.22.51.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Feb 2024 22:51:03 -0800 (PST)
Message-ID: <2afc8b53-5a35-482c-aa89-c61a882cedf0@linaro.org>
Date: Tue, 13 Feb 2024 07:51:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] linux-user: Map low priority rt signals
Content-Language: en-US
To: Ilya Leoshkevich <iii@linux.ibm.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>,
 Brian Cain <bcain@quicinc.com>,
 "ltaylorsimpson@gmail.com" <ltaylorsimpson@gmail.com>
References: <20240212205022.242968-1-iii@linux.ibm.com>
 <20240212205022.242968-2-iii@linux.ibm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240212205022.242968-2-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Cc'ing Brian & Taylor

On 12/2/24 21:45, Ilya Leoshkevich wrote:
> Some applications want to use low priority realtime signals (e.g.,
> SIGRTMAX). Currently QEMU cannot map all target realtime signals to
> host signals, and chooses to sacrifice the end of the target realtime
> signal range.
> 
> Change this to the middle of that range, hoping that fewer applications
> will need it.
> 
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>   linux-user/signal.c | 18 +++++++++++++-----
>   1 file changed, 13 insertions(+), 5 deletions(-)
> 
> diff --git a/linux-user/signal.c b/linux-user/signal.c
> index d3e62ab030f..a81533b563a 100644
> --- a/linux-user/signal.c
> +++ b/linux-user/signal.c
> @@ -511,13 +511,14 @@ static int core_dump_signal(int sig)
>   
>   static void signal_table_init(void)
>   {
> -    int hsig, tsig, count;
> +    int hsig, hsig_count, tsig, tsig_count, tsig_hole, tsig_hole_size, count;
>   
>       /*
> -     * Signals are supported starting from TARGET_SIGRTMIN and going up
> -     * until we run out of host realtime signals.  Glibc uses the lower 2
> -     * RT signals and (hopefully) nobody uses the upper ones.
> -     * This is why SIGRTMIN (34) is generally greater than __SIGRTMIN (32).
> +     * Signals are supported starting from TARGET_SIGRTMIN and up to
> +     * TARGET_SIGRTMAX, potentially with a hole in the middle of this
> +     * range, which, hopefully, nobody uses. Glibc uses the lower 2 RT
> +     * signals; this is why SIGRTMIN (34) is generally greater than
> +     * __SIGRTMIN (32).
>        * To fix this properly we would need to do manual signal delivery
>        * multiplexed over a single host signal.
>        * Attempts for configure "missing" signals via sigaction will be
> @@ -536,9 +537,16 @@ static void signal_table_init(void)
>       host_to_target_signal_table[SIGABRT] = 0;
>       host_to_target_signal_table[hsig++] = TARGET_SIGABRT;
>   
> +    hsig_count = SIGRTMAX - hsig + 1;
> +    tsig_count = TARGET_NSIG - TARGET_SIGRTMIN + 1;
> +    tsig_hole_size = tsig_count - MIN(hsig_count, tsig_count);
> +    tsig_hole = TARGET_SIGRTMIN + (tsig_count - tsig_hole_size) / 2;
>       for (tsig = TARGET_SIGRTMIN;
>            hsig <= SIGRTMAX && tsig <= TARGET_NSIG;
>            hsig++, tsig++) {
> +        if (tsig == tsig_hole) {
> +            tsig += tsig_hole_size;
> +        }
>           host_to_target_signal_table[hsig] = tsig;
>       }
>   


