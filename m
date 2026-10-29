Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AED2606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 11:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=vTMm2OOB
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMOXz-0003TG-5H; Thu, 29 Oct 2026 07:43:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xMOXu-0003Sr-B8
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 07:43:50 -0400
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xMOXs-0004w0-AV
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 07:43:49 -0400
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-854b6e2e41fso1014052a34.3
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 04:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793274226; x=1793879026; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=N/Wt725mlrfQGlAigQQC0hFEvmn9KAA9LZOM9yl+VLU=;
 b=vTMm2OOBGko15HTN3jw8zF0GNXR1FQGP6XSji57DeeC9Tb4l+Pa4NUfjPyEhw2QUXC
 co62lAW5ZQ2+ma4X9c5hfkTNJMER4+6mmtwDw4mWvfA0ISZCRZxUDOqV/FoeKMG2Z4lq
 QNekXpkiK+g0IhxTQc6eQncTptqIzCg6HNytsCCxtXmAnLBAG0fenaFj5TyDyhQwzeXU
 dFa1vtE26bJM33/w2fhp4z2FWTeZ/a4J/agw6rk6mKuMlJVX8hiiYzjT0VGXCx73jn3H
 NpkGXKXYXD3WOkeueOILWsCRP4zg4mdARKyrvv59ht/K16IZpAMr68UOsZvawBx6wKqr
 1eQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793274226; x=1793879026;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=N/Wt725mlrfQGlAigQQC0hFEvmn9KAA9LZOM9yl+VLU=;
 b=xwn/V/SxkY2WVr5gDHbZXGVuR1Y5KkVQjVfWwuAqvr5HL0YZALbgIjkQutlKpMlcam
 0GrAx0BaLuE/qXiiE8Yio2aIOjEWqBlTpFNs+ZwX2Ni9JZtWQGRWqi4GUDmvxR7DGqED
 fC9OFfb4YNmzjtGWkQ4LPAa89PnZFdIv2gVqK27x0eSlCZRO30TecjURG6bRLzR1QRQf
 UV83Mtjvv7rJNB3qEly28wPd+EsO4575i0+nQglW9PL8trjGf9BY7mVwBD6dkQR6E1+W
 Ko1LOlPQY18TlTX1Eg/106O+/Ir6nZvG4vJXz5vWNkycBvYdWoxJhpOWMxh/irTGSxyc
 1b0A==
X-Forwarded-Encrypted: i=1;
 AKwUvBwnDosHp5vkE43Crq/L/8b+1J9xTPFinjV+1RYpQ5FX64urmknYtrx4b/nOeAeMG8Prkk7NUh+C8Vzh@nongnu.org
X-Gm-Message-State: AFq9FYLd6tzSmpl0+ZtqXRW4FT5xCJzKiSVQdbOKqXfSSpEFnY8SlFZ5
 cjE4yiHXO4yQWrFr3X0hOqTYwYU1TwpR+snAIw1X1pZKw0J8MJPmo19ly24yoTgBWB4=
X-Gm-Gg: AYBFou2mFX3T48jVQaKdLehrdEKk0O38kpkyXRFmHZz0rmuZu5IDghabZff7HRRzhwj
 bWsDCf+GPrpB8wfdCPtF6v7xySvXAZo3KR8nKl/9v2PZl69ffoVHGidmM6be+H5WFftYbP3QPr5
 RTenn4FevXGiW/D1tlJCQk5PxysH1abDhjLQjgdeRUpGj3pxpro/baDb4H57A3c1IW5U2HPd88R
 Z+fQukus6oQ7zPGC/tHG9Nlh74ktIrAPx9J658LdALyWBKMO2Cfbw/V42h0wgJgXppa2iOmen62
 Lq2hVZ7f88OeWtMD/kKjkh8EexunGZ5gYoZsOzVbWxVSmBor2SivslLUWYJ85iz2nwamfFLc4np
 aNyX0AGJBt7Z3qbel/npVadR55HjJpOCCF0F3x1fAzb4rpYEKxUYaerWU08HpNXTlAiR1GT4GGM
 wAFMNAoAvahS6c9fgm0wih6/uUv2tjFhxgbNvfjgYLLTqClnfHK8WDDY+lLdkd860I2PA9SRthY
 KMoXoFYVv7O2DiqGB3SHqaCyiAcPSuyt10a0zFLK1n36hCeQTTbAXx8CJWSB1sEjzBw+gGJBV6N
 T8vfl+jw1Um12ifzKM1SsFmjdUF8jmEEsbhRUzIet52z
X-Received: by 2002:a05:6830:2b22:b0:84c:85e8:f922 with SMTP id
 46e09a7af769-85abe8bb899mr4745553a34.26.1793274226340; 
 Thu, 29 Oct 2026 04:43:46 -0700 (PDT)
Received: from [192.168.129.53] ([50.233.235.3])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-85b1f436687sm4262380a34.8.2026.10.29.04.43.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Oct 2026 04:43:45 -0700 (PDT)
Message-ID: <61c1cd23-8097-4356-8797-f270a79e68df@linaro.org>
Date: Thu, 29 Oct 2026 06:43:43 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL v2 0/9] Hppa 715 2 patches
To: Helge Deller <deller@kernel.org>, qemu-devel@nongnu.org
Cc: Keith Monahan <keith@techtravels.org>, Helge Deller <deller@gmx.de>,
 "Kirill A . Korinsky" <kirill@korins.ky>
References: <20261028190701.17272-1-deller@kernel.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261028190701.17272-1-deller@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32a;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32a.google.com
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
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/28/26 14:06, Helge Deller wrote:
> From: Helge Deller <deller@gmx.de>
> 
> The following changes since commit 73294d096cc591e122fde9e63db4739de6d84f2b:
> 
>    Merge tag 'qga-pull-2026-10-28' of https://github.com/kostyanf14/qemu into staging (2026-10-28 06:21:59 -0500)
> 
> are available in the Git repository at:
> 
>    https://github.com/hdeller/qemu-hppa.git tags/hppa-715-2-pull-request
> 
> for you to fetch changes up to 4d5bc20de77152cecb4acdf63afe0db761b2abcf:
> 
>    target/hppa: Update SeaBIOS-hppa to version 27 (2026-10-28 20:00:56 +0100)
> 
> ----------------------------------------------------------------
> HPPA architecture patches for HP-UX 9 and 715 machine
> 
> A series of patches which allow to boot HP-UX 9.05 on the 715/64 machine.
> Includes a graphics/artist fix, adjustment to 15 bits for protection IDs on
> the 32-bit CPUs and various other parts which were missing up to now.
> Included is also the FPU patche from Kirill A. Korinsky.

The new hppa-fpu-test fails on big-endian.


r~

