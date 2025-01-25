Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2FD5C0218C
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jan 2025 15:19:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbhwk-0004oO-3x; Sat, 25 Jan 2025 10:19:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tbhwi-0004nl-IQ
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 10:19:40 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tbhwh-00031Z-4P
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 10:19:40 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-21661be2c2dso52742055ad.1
 for <qemu-devel@nongnu.org>; Sat, 25 Jan 2025 07:19:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737818378; x=1738423178; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=E2ptI/5eQzrZNZv9Iiq8c8cmZMiwTAsbCAyI84Vs9W4=;
 b=Yc/VEtmxiSpKf9RQLsOJP6tl9QD+vsPvr0fXPpRs70RQVlEcTjvg3PZreh03JmU1/+
 O+NL1f9QgS4ehU35+711j6Sgj3yaubx/1On4Vp0z1i0gNn5LO+qhsekH1qFWbd0zfjLa
 k4z8micIq6xmBeQBBMq807LHcjT2wDJM7dcn0fAv09otTVqUTGMtfdnHIJKREZTgtLvT
 EgGh6WC0e25FR3vIV4+C/55ugeIG0W3ZOYg3IwZPEDH+4WtnlKmWUtBOzgebnT2v5uW6
 jImN28LpBlCdDcGo6/1UqbGXgtbrzEjBO3N400zwTMn8pxVldL/KtN+n9PyxeKy7Q3ZW
 5ycw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737818378; x=1738423178;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=E2ptI/5eQzrZNZv9Iiq8c8cmZMiwTAsbCAyI84Vs9W4=;
 b=OwWgBPERzEaTW0NESWSFTYJtyOza9KNl0EEeyhJSpsP2HSqvIR8LHPW7WPiqm7RJa2
 sh+/UnHS9ywGGl7WDD0CDsq2X3Pzg9jBOJ9rCgcuwk/bBDMVZoZYi4Cmt2VFZZ6aU6Nj
 pSWyCz9e0GG+siXJMjSdNnvqMwBk2Ohrj9f+CPlYeCYQefiJi0CDjKhQJOVsFpH57pv/
 AWd0bZtcyViQ2BPQxx+flmwBScWFrchUr/yAPqIjrhztREyoA/JuSoLWGaIOdlN4ndaY
 jYLyi7RS//2DvYQXMl3snhgLVooGMF03nY+LF5EFxJL1occAx9T1dkkWUCCeAwKAsplG
 snow==
X-Gm-Message-State: AOJu0YyHqMteW+capBIxVfxSZLSNzM9QCcLeqNFp0sYQMhg0j+XtYcqk
 ExJYCshhDU2Vfv0mL0RtGd4axC6CqOYdf+EcyBtyQRubxeo0hGyf1TyPM90tL1ywlxFHcHOJvOw
 S
X-Gm-Gg: ASbGncuV5Ap3Fop8/A07iBe8wd5GzQsr9mPF9iDmLgVYlMQi71pdM5N6ddPm3IZpzuj
 S1WQekZU4Ps8NsF9EZrJbJmXnQc0SQyV+ARZrtIhU4g7QlV7QyRpsk3eCaGc4to6r7yEaapxKy5
 1N8ktYgcZN7u88Soitn900u13zRTUcLOZXeOV/op1t6PswBgGNcGbS8omC6DVA30Nnq+lSJuOea
 GLK/DGgYBE7DBQwJNHWQgtm77J3YaSo8jAGptD6crwbDx21RcJ4wwsdVot029cJhY73zmZMb6rt
 KBdlERU5aqJcpesBhFM3Pg==
X-Google-Smtp-Source: AGHT+IHc5iDkEvdJU1x/t88z6LEqXlCKtcbh8XR2lzaHf15uvbGgIdti/ux8K+CS7KVXkWcZ20lpXw==
X-Received: by 2002:a05:6a21:789a:b0:1e6:51d2:c8e3 with SMTP id
 adf61e73a8af0-1eb215f52a7mr65169577637.35.1737818377783; 
 Sat, 25 Jan 2025 07:19:37 -0800 (PST)
Received: from [192.168.74.94] ([50.200.230.211])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-ac490ad0024sm3367119a12.43.2025.01.25.07.19.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 25 Jan 2025 07:19:37 -0800 (PST)
Message-ID: <c1ae2277-de99-4565-b89b-5e14241d439f@linaro.org>
Date: Sat, 25 Jan 2025 07:19:35 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/76] target/arm: Use FPST_FPCR_A64 in A64 decoder
To: qemu-devel@nongnu.org
References: <20250124162836.2332150-1-peter.maydell@linaro.org>
 <20250124162836.2332150-12-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250124162836.2332150-12-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

On 1/24/25 08:27, Peter Maydell wrote:
> In the A64 decoder, use FPST_FPCR_A32 rather than FPST_FPCR.  By
> doing an automated conversion of the whole file we avoid possibly
> using more than one fpst value in a set_rmode/op/restore_rmode
> sequence.
> 
> Patch created with
> 
>    perl -p -i -e 's/FPST_FPCR(?!_)/FPST_FPCR_A64/g' target/arm/tcg/translate-{a64,sve,sme}.c
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/tcg/translate-a64.c |  70 +++++++++++-----------
>   target/arm/tcg/translate-sme.c |   4 +-
>   target/arm/tcg/translate-sve.c | 106 ++++++++++++++++-----------------
>   3 files changed, 90 insertions(+), 90 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

