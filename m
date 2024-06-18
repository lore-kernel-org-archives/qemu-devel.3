Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1A3BC27C4F
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 23:06:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJhtX-0004XJ-Co; Tue, 18 Jun 2024 19:05:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sJhtW-0004X1-IL
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 19:05:42 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sJhtV-0004OB-3Z
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 19:05:42 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-70436048c25so4670730b3a.0
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2024 16:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718751939; x=1719356739; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xvowCEaLujG6ZWZ2Vu/HWToYuVOmCYeRwSq47hX+sdw=;
 b=TtBEjyDtI3PJ/Tis3UcLq9F4F/lUx5PYIsTIiUYUlWWZGPuIAhE3bcRNwuBjVsksA5
 l4AhANO30SHFULB0VXrCm1Qv5FYnX1m4YnUKyVTHq/RC0NV5VByeEzCig3VwLXat6/G3
 F0WmEVaIik/yNX9v4y9ny2B0kM8oa8TIuXJIrynfj8enaeXVQzNUlsx6uOaHe0D3/Lkq
 Y3uyDI/U1Ld84x5aOS8uYAwZyrn/UpaRxDvkjuFyNVrmwooD0cw7PrvYb3Dd0MxAib4O
 +ztw4X6HyVWzYy2+9ojbUe9ezW4PkZLcsdmooglXdUszow2jwfzvQ7xIuHxOJsBrwxAp
 70Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718751939; x=1719356739;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xvowCEaLujG6ZWZ2Vu/HWToYuVOmCYeRwSq47hX+sdw=;
 b=ugN3YFR0+jGXpAAMypLhXm0InijXiYV+lzG2+kluD1cKN0q/kqXvC2B2RHAOlB8uiy
 S+gkmJVik9NiU2me4euzY3Yok14KqZAOd6oSsr9A0xv0XRWQDTCbmRNbORwtG6b27qve
 j7GicJIefapovemVK0WKro8BIIqkxpS6cZTzW8xjd/MMbirpp5cNUkfJw7J0s/KL732c
 LEgHXwNyymEEFjerTKao7+olMHp3VX25VQzfn8W2WXG6kxgpLYjZs9ALuNVDJ5XIsuDO
 9KfL7Ids93zMaeTZ0xa1mJZ9NFHfjkzgM3PeJLDSuKBmb/3wvSCPV0WCU5cufbe6PF1m
 Drdw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJmnPP0/kl7fptaxa/QWKiW38lago1Qn3Ly8CEUkcUXob5F4hYV0fhJN/FqveVeYvAxImUkKj68+9VPFIoalTW7OxC4Ls=
X-Gm-Message-State: AOJu0YxizAHf7eJC0w3oAs0Cf5lzOjMw84krsojNJH2JKd/tKmr/4iMo
 N8ZWulcUVaYuKK/ciVlrA2W6MgQVnbp0O1ZOC512bNf5MibxVeCVLxmtc6snAc8=
X-Google-Smtp-Source: AGHT+IE3NkaklTiVsHtNY/+vt5jSPorW7tWo6PGffBY6U03FL1Y6vHoXkObQoXd/CbQrLjNGJfq2KQ==
X-Received: by 2002:a05:6a20:8ca3:b0:1b6:ed32:4613 with SMTP id
 adf61e73a8af0-1bcbb3dd1camr951172637.2.1718751938735; 
 Tue, 18 Jun 2024 16:05:38 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.132.216])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-6fede16af59sm8581030a12.30.2024.06.18.16.05.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Jun 2024 16:05:38 -0700 (PDT)
Message-ID: <495d3ddc-ce73-4ef5-badd-16ed61f9a5aa@linaro.org>
Date: Tue, 18 Jun 2024 16:05:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] exec: use char* for pointer arithmetic
To: Roman Kiryanov <rkir@google.com>, qemu-devel@nongnu.org
Cc: jansene@google.com, mett@google.com, jpcottin@google.com
References: <20240618224604.879275-1-rkir@google.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240618224604.879275-1-rkir@google.com>
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

On 6/18/24 15:46, Roman Kiryanov wrote:
> @@ -2839,7 +2839,7 @@ static inline uint8_t address_space_ldub_cached(MemoryRegionCache *cache,
>   {
>       assert(addr < cache->len);
>       if (likely(cache->ptr)) {
> -        return ldub_p(cache->ptr + addr);
> +        return ldub_p((char*)cache->ptr + addr);

We require "char *" with a space.

With all of those fixed,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


PS: I'm annoyed that standards never adopted arithmetic on void *.


