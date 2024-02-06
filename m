Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5FEAC48297
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 22:24:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXTrQ-0001Ee-9j; Tue, 06 Feb 2024 17:24:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rXTrO-0001E8-8z
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 17:24:10 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rXTrM-0005Cl-Nc
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 17:24:10 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1d94b222a3aso198845ad.2
 for <qemu-devel@nongnu.org>; Tue, 06 Feb 2024 14:24:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707258247; x=1707863047; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VQm4iM8Y8TTo/LYNQU0P3GI9s+js+il+a9oDRQjmoPw=;
 b=Puun/ka13BFICjW3r//cvWFAnKlGSeJCJjyP//dd1CeetkD+5D0aSbvw80jfBs/90J
 1zKB9QRiPXpuelG5roaT4k5B+J6XpmIADRKbl19aNKt9WnFtj+nMseH5qHujVtkwyVVH
 /xIqqQ3CCE8eZPjIZjiRsPEOnvZ+ooQkPZRolM6lelhiStmePHFjHozopRySyXOfjmmi
 WcJkTA2fzbF4hFrGSJJYQnbT7TH+3Qv0nuo9WCtN0D5Oo8ixyvlwXqrwCiF0to8gufYX
 UXWcQ9/LJwxD7GTAcm5n/XpQbu/vmZ6rshFEmIE5fBtYhDrMG2/hYKqmbc2oA7ZIXPu+
 RK6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707258247; x=1707863047;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VQm4iM8Y8TTo/LYNQU0P3GI9s+js+il+a9oDRQjmoPw=;
 b=ozq917L4qAPjgQKqa2c6Mr15w5YTiXHZsvq7peD6/eIxhA9HYNEaUfLmX7YzZYJbgz
 uGRdMinWBHy+idebkI8yoP0uIMe9pLHv1sGqYhrqB4AJcHukySA/wtkEsoE6RWeD8HM5
 f8phbcnt0VPdm9qR+79DJIlz8BQEDbcCPBRp7FeE8RsTfZe7ApIfD0qdaLgffGNYApki
 v51IwukbqPkEPbZJPv/nTlYx2xx0HursTeJKBWt1hMWUE5/X+73Tf6du7mIS/eGj7kSb
 pLEEHFnGTzIIwFqFlllBMGbA5GT2/2/O4x1PnXbgHos2lfClK3u/ILAQcSnxuP1IMenS
 dC5A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUx8RC8KpsPjOAr2p3j9nw47gD1aajIh1fIRoSUwje0Ycf5bXcO87IJs0JL8mXw4vUF67QdGbv1nyuuLRM6cYMxDLzOaoc=
X-Gm-Message-State: AOJu0Yz2Dz2SIlWGlh3/JjOJDiIWfE88qmLr9LCeayGQ34enij66p00e
 4lhLi2RIpRInm69hnNOIZwR7wJ7CeNcfLAGfqGKv43+dbZIi/DMtAMOzNElWfKg=
X-Google-Smtp-Source: AGHT+IFvJHgOvqWQVRuRc/js0XJ+acTAXRzUiBkGmDmEbZLZE+ufcw8yRc1rZaG+vfw4n1gPrA0GMQ==
X-Received: by 2002:a17:902:da8f:b0:1d9:ec0e:2db2 with SMTP id
 j15-20020a170902da8f00b001d9ec0e2db2mr698689plx.3.1707258247164; 
 Tue, 06 Feb 2024 14:24:07 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCV6OaL13h4m5uVqWAeYxAz9Z+Yi5oBzczt7peV+nCnQVm59LZD4FDIDA7UiyQhDl82jis83nU1XJFZn26mb1CRiYxpF1AI2RXNnGs/l/imADHFDjuXu8RMhdM4=
Received: from [192.168.0.100] ([43.252.112.200])
 by smtp.gmail.com with ESMTPSA id
 l12-20020a170902d04c00b001d9c1d8a401sm17844pll.191.2024.02.06.14.24.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Feb 2024 14:24:06 -0800 (PST)
Message-ID: <d72cab41-2d18-4dae-8b2a-b03aa67c01a8@linaro.org>
Date: Wed, 7 Feb 2024 08:24:02 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/6] util/bufferiszero: remove SSE4.1 variant
Content-Language: en-US
To: Alexander Monakov <amonakov@ispras.ru>, qemu-devel@nongnu.org
Cc: Mikhail Romanov <mmromanov@ispras.ru>, Paolo Bonzini <pbonzini@redhat.com>
References: <20240206204809.9859-1-amonakov@ispras.ru>
 <20240206204809.9859-2-amonakov@ispras.ru>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240206204809.9859-2-amonakov@ispras.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

On 2/7/24 06:48, Alexander Monakov wrote:
> The SSE4.1 variant is virtually identical to the SSE2 variant, except
> for using 'PTEST+JNZ' in place of 'PCMPEQB+PMOVMSKB+CMP+JNE' for testing
> if an SSE register is all zeroes. The PTEST instruction decodes to two
> uops, so it can be handled only by the complex decoder, and since
> CMP+JNE are macro-fused, both sequences decode to three uops. The uops
> comprising the PTEST instruction dispatch to p0 and p5 on Intel CPUs, so
> PCMPEQB+PMOVMSKB is comparatively more flexible from dispatch
> standpoint.
> 
> Hence, the use of PTEST brings no benefit from throughput standpoint.
> Its latency is not important, since it feeds only a conditional jump,
> which terminates the dependency chain.
> 
> I never observed PTEST variants to be faster on real hardware.
> 
> Signed-off-by: Alexander Monakov<amonakov@ispras.ru>
> Signed-off-by: Mikhail Romanov<mmromanov@ispras.ru>
> ---
>   util/bufferiszero.c | 29 -----------------------------
>   1 file changed, 29 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

