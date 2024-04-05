Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54EC1C67861
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2024 17:09:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsn4C-0006xW-4Y; Fri, 05 Apr 2024 13:09:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rsn3w-0006uN-OI
 for qemu-devel@nongnu.org; Fri, 05 Apr 2024 13:09:12 -0400
Received: from mail-oo1-xc30.google.com ([2607:f8b0:4864:20::c30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rsn3s-00081Z-8X
 for qemu-devel@nongnu.org; Fri, 05 Apr 2024 13:09:11 -0400
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-5a529a1f69aso1277478eaf.3
 for <qemu-devel@nongnu.org>; Fri, 05 Apr 2024 10:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712336946; x=1712941746; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=o8vbCZadgD7aa0QkATV3N9iQ+1lljvzuEqBVXuz24pY=;
 b=av6sWq4AOOSiOwtepKQhMlszbrY000PQyysqv/+hmxaot+JYpaqVB0j/VB/BW9pXYx
 aP6ST9uGmefMqQMkZTXZ/XKUICU9BpIax3LRdclOVfrM4y44YsO1S5VHZVVM34oQQx4k
 HdjTzReJ5DsvYqaFg63YeSMT72AkQoXmwz6b3kN9j/Bqf3T8ftckPiYEDjWJr9Rl1JDM
 LtavfwJYwRmAfhAtCGgLX+SDCYdfiI4+gk15Y6Z2MVyocxwaOhmQImTiG5q3sXwmYyMq
 KoYE7pie4rQQhOLkNtEh3z6MSddPZMbZUGI63ogqjd8jauLcf36GzfcLEmwtrpK/t+ap
 jpsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712336946; x=1712941746;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=o8vbCZadgD7aa0QkATV3N9iQ+1lljvzuEqBVXuz24pY=;
 b=o0bRIwl2QxrzogvreNM4tM3iku3BMaeomVU3VUIvLHspslU46WcyB4poc/1qgJ+Iwt
 9+Hgu7+79wZy/NBkMN5KUPUFmFrvBvWcDLX9o1t8iPncsHVjLyb/9NYop6Epw7YEMQQA
 M4fERRFt8YoFV638hYXAtSBOunc/CR1Td6vTLNTpmUq7RHjpQJ1SERxPpOixG5V4cy9S
 tOgGa510xMC3tuchDfFErx5DSl6qFfuE4II7apMJHFQNyG0mOD5emClaOJXJ8p4vUU/l
 i77oSOrFUk468WnIdhiB3fXQcHZCp5NJXfBv15o/LQ041xcjGiv2D5bUin69fEYuuL0Y
 VUJQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWiYUkc+Nid999/yybZNfnDltwRQnWxBNSa0Uxk/PAacTs68yOiHtqVOiz4+jDOoA2UlBO315mDjBWFtLVhjOs8aoXr2Tc=
X-Gm-Message-State: AOJu0Yyn/hxAhPOT/Ckvv1fXTXk/M066TEAVfNyB4dslpOfNkeOzp/Wu
 /XD2Pb/awMk00UL/kzmZhV+p+aQDaQzydI95lFxB+7RK4enXiNBadlyjZf1or58=
X-Google-Smtp-Source: AGHT+IEQhd6J7xpnPVseRrslbn7ZUkiID1AckBjDXxaCpczyTO2m3DMcMGu0Gyuj9ck+QIpDu9xYZA==
X-Received: by 2002:a05:6358:9544:b0:183:f639:2415 with SMTP id
 d4-20020a056358954400b00183f6392415mr2009701rwl.27.1712336945820; 
 Fri, 05 Apr 2024 10:09:05 -0700 (PDT)
Received: from [172.20.1.19] (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 t16-20020a656090000000b005f0793db2ebsm1510433pgu.74.2024.04.05.10.09.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Apr 2024 10:09:05 -0700 (PDT)
Message-ID: <64f3f615-2eb6-4303-a96c-c9f1a5aad0f5@linaro.org>
Date: Fri, 5 Apr 2024 07:09:00 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] tcg/cputlb: remove other-cpu capability from TLB
 flushing
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-riscv@nongnu.org, qemu-s390x@nongnu.org
References: <20240405125340.380828-1-npiggin@gmail.com>
 <20240405125340.380828-4-npiggin@gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240405125340.380828-4-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c30;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc30.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 4/5/24 02:53, Nicholas Piggin wrote:
> Some TLB flush operations can flush other CPUs. The problem with this
> is they used non-synced variants of flushes (i.e., that return
> before the destination has completed the flush). Since all TLB flush
> users need the _synced variants, and that last user (ppc) of the
> non-synced flush was buggy, this is a footgun waiting to go off. There
> do not seem to be any callers that flush other CPUs, so remove the
> capability.
> 
> Signed-off-by: Nicholas Piggin<npiggin@gmail.com>
> ---
>   accel/tcg/cputlb.c | 42 +++++++++---------------------------------
>   1 file changed, 9 insertions(+), 33 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

