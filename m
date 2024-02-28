Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69349C47DD9
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 22:29:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfSQE-0005Ws-DX; Wed, 28 Feb 2024 17:29:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rfSQC-0005Wf-D2
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 17:29:04 -0500
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rfSQA-0000Pc-VZ
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 17:29:04 -0500
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-6e46dcd8feaso160634b3a.2
 for <qemu-devel@nongnu.org>; Wed, 28 Feb 2024 14:29:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709159341; x=1709764141; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mSZRp6ZYFW3adLjFr8vHmZC2WD3kg6IsfBK6xb7gAzg=;
 b=VhMP/nxfMO8T+EbgLXRknC0A6tEWG8znpPLrBzkZk1z4Ag/XhQVB0stosqSRrG/vF7
 7BvDiAXLOD7C7U55vrZQfskbl35VBaY8qFtN595cawQIJB1SswIAnh262dPAY6t+vQdq
 pBE0iOx2DsLStzO0a0e8Sq55v+Fp8qxyvW90PtYmi3fL/8mp5LBUDgHose0AVsDziHSt
 5+AI21GOmOwQ8yYBgayUv4M83eRry8KV7EKqBgztf9/Unf9IL1K6rXhSyI84cSISk5Yz
 dYQH3icrk+Ndy4kFIrCSZHZqeJQSAGzOxHrlcqDmUdCx40fHtu3LGKdFoam5apwwdK48
 ncLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709159341; x=1709764141;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mSZRp6ZYFW3adLjFr8vHmZC2WD3kg6IsfBK6xb7gAzg=;
 b=gHrC/3NflunfNpveiNuRb20cVXRtflqiPKIa/Y7h5D8hz80RSridWgc67qOz0/pJHO
 EOV4dUZuCv1HUP20LVXqx9RTiDmtMaxkF5pJvwgzezQjyJLvqYpSKi+7TYHoiSudZifr
 woBPi4dQZQaZpsYdUo38CWwJRw+GeTZcHYrGuht++xXTcH2vFbVcuU9DCOpLDu2YdbxQ
 SZXhuIrmBXsJtj541oXGj2XteVI+cJpQRz9+/VqIRd7JR1SzzuIEPygMHX4KSBeT7fAy
 gjObiwmsq2XyOqGGd5EtQntDgtcoebZONzif1QcEeTO6OHq4/wWWBbs4YN8P+WGqJ/vZ
 vbDg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU2SqZPAc2Bc8dtJQ9WprC20BKKwLfdirpULqRawvFoLEf2ARZ2Tan+ITipD32mTcOdV/ZSzowIi5MNEgZdGMxXDThHmpM=
X-Gm-Message-State: AOJu0YwxR2TmVFGu0GUMPtszqptNo6fq4LkBHQ+92RN7IprnBg68DC0T
 8r7DE/vd0sIy9CxgSOkreikD08OzvRQe5lsicxDqnlddkFJVlwxtUM06bGJvHqGUwCeT1MAORF5
 d
X-Google-Smtp-Source: AGHT+IEHnBsvwsYdytbzREgSPtAZax2NU2y3WcuosZz5bxM9p1FGIwkCvk9EoKHUahldPW5lnp8jTA==
X-Received: by 2002:a17:903:249:b0:1dc:a8aa:3c80 with SMTP id
 j9-20020a170903024900b001dca8aa3c80mr350391plh.43.1709159341387; 
 Wed, 28 Feb 2024 14:29:01 -0800 (PST)
Received: from [192.168.6.128] (098-147-055-211.res.spectrum.com.
 [98.147.55.211]) by smtp.gmail.com with ESMTPSA id
 h23-20020a170902ac9700b001dc6f7e794dsm3780506plr.16.2024.02.28.14.29.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Feb 2024 14:29:00 -0800 (PST)
Message-ID: <b4d8cebd-6ad3-4a21-9ee0-207b6bd2fde5@linaro.org>
Date: Wed, 28 Feb 2024 12:28:57 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] target/i386: use TSTEQ/TSTNE to test low bits
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20240228111151.287738-1-pbonzini@redhat.com>
 <20240228111151.287738-2-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240228111151.287738-2-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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

On 2/28/24 01:11, Paolo Bonzini wrote:
> When testing the sign bit or equality to zero of a partial register, it
> is useful to use a single TSTEQ or TSTNE operation.  It can also be used
> to test the parity flag, using bit 0 of the population count.
> 
> Do not do this for 32- and 64-bit values however, to avoid
> large immediates.
> 
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   target/i386/tcg/translate.c | 28 ++++++++++++++++++++--------
>   target/i386/tcg/emit.c.inc  |  5 ++---
>   2 files changed, 22 insertions(+), 11 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

