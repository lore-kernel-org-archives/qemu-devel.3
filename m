Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E437AC48260
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Feb 2024 17:59:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYrcb-0004Im-7I; Sat, 10 Feb 2024 12:58:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rYrcX-0004HU-PD
 for qemu-devel@nongnu.org; Sat, 10 Feb 2024 12:58:33 -0500
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rYrcV-0001sI-M5
 for qemu-devel@nongnu.org; Sat, 10 Feb 2024 12:58:32 -0500
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-6e08dd0fa0bso1125629b3a.1
 for <qemu-devel@nongnu.org>; Sat, 10 Feb 2024 09:58:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707587910; x=1708192710; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XYf15tKUPsb3kcCtoOAKy2yGFOUnQ7MXkgJr6t1xRPQ=;
 b=NYPhmMMwIVppaPoyx42wue1a5uZ6/dY8oHVBBk4B8tTcl2nf78U+EQIuy8bSTI2EZb
 OeInTzGJqT+5sIgQma0q/bCtBk+t/xTZNdww4X52oCb5g/P6MbJVzpiDXxU4hr0vNVQI
 olq+nxXvQXLGawCHlWH4UhqQa+gZ59YFah7yjpILXJa+pxiU9Cm+NrWybb066Oxk8yT0
 Eu+wnOMy9p+Cwckpgyr8i4ot1TSuR1eN0FjIldfloQp0gJ3fgWy2alMv4nk+WzHBgTJI
 7kZ+eBstl9tdX4/eb9hlfnlk1whaG6vfIgBtpMR30l2WIqSi3kRGgUS31hefD9Yqi6Er
 kaSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707587910; x=1708192710;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XYf15tKUPsb3kcCtoOAKy2yGFOUnQ7MXkgJr6t1xRPQ=;
 b=CJldjUhNPCvOPri8N/wQ6XsfbbUpr2nSHE9l38TMWYeNibGEdywNLnvgkXJGgGAwdM
 WoQTmR38voXpysijfTg7YeH/hmW1h0hfw0wIGxNhyyWkD0VE3rQt9uEkfsKVEgKxau81
 rcY23DFsjK3ZDPS8dzatfJBIA1V++f8/ovodGeHZrUC+djeG3LWGDk/j1FGeCqrH3roM
 sP9nY4uQl7NWsGQXrAq5o+1QuT02chf5v8bV/vzMrJJ76d/aXOibVYA1dB7+35iS9jj0
 Y4Kb3lJronvUHxS+XrTLRwiKf+43sG1SIa7hcCzDoKyXyH81cKDEb8Q2NRXqFi6Og8Hx
 6s3A==
X-Gm-Message-State: AOJu0YzNiisEQbqPmgPfXWQ+kjMEEWmu4vW8UIbmLLDPu07REYZRApQl
 ZFnvzgxJFV7JWkYJIeFvTqRhT1mQ3Dav0rlwRx85iPBo2kjJHQkccvs4Nz+hpXQ=
X-Google-Smtp-Source: AGHT+IEBtUhjmNED4qwKZEzQxdaxyu96lK8ix8pPp6ly4ZjrATIgmrwSNX6fX+qgGZctsCqyrhEVcg==
X-Received: by 2002:a05:6a20:47dd:b0:19e:ad09:a571 with SMTP id
 ey29-20020a056a2047dd00b0019ead09a571mr2360022pzb.29.1707587910217; 
 Sat, 10 Feb 2024 09:58:30 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCWgndQwrzSeBqdQ7wRPJtWq7+bfMT5iv3KRBMJ8+kPV5hGqs6VyWu2JnkrH/eCjVFMBSP09O8uc43a5krRnk+T9Ikw0Yl8XoFcWhQ/8Vt0fTl5xaNuy3Bsg+R/GPhCr
Received: from [192.168.4.112] (066-027-223-101.inf.spectrum.com.
 [66.27.223.101]) by smtp.gmail.com with ESMTPSA id
 d9-20020a056a00198900b006e06b8548c3sm2558000pfl.139.2024.02.10.09.58.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 10 Feb 2024 09:58:29 -0800 (PST)
Message-ID: <ef6ddfd5-8928-42aa-9d8a-cab382b7ad37@linaro.org>
Date: Sat, 10 Feb 2024 07:58:26 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] system: Move memory_ldst.c.inc to system
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-trivial@nongnu.org
References: <20240209000505.B07D04E6049@zero.eik.bme.hu>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240209000505.B07D04E6049@zero.eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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

On 2/8/24 14:05, BALATON Zoltan wrote:
> This file is only used by system/physmem.c so move them together.
> 
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>   memory_ldst.c.inc => system/memory_ldst.c.inc | 0
>   1 file changed, 0 insertions(+), 0 deletions(-)
>   rename memory_ldst.c.inc => system/memory_ldst.c.inc (100%)
> 
> diff --git a/memory_ldst.c.inc b/system/memory_ldst.c.inc
> similarity index 100%
> rename from memory_ldst.c.inc
> rename to system/memory_ldst.c.inc

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

