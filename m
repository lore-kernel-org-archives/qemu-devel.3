Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27776C87FCF
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Jul 2025 20:28:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufP1F-0002RT-6i; Fri, 25 Jul 2025 16:27:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ufOxX-0002fO-VQ
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 16:24:04 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ufOxV-0001S9-UW
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 16:24:03 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-748fe69a7baso2310542b3a.3
 for <qemu-devel@nongnu.org>; Fri, 25 Jul 2025 13:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753475040; x=1754079840; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JTuumkgFOey9hX3vvE2OZMKLe9YWvrTZUKA/vxEnCkg=;
 b=c8AbbcXuQaKzruuaebWoA2RrI9cu0t+m/dWe/Xw2BTtGvsHeW84arX3q8yfYUmjlkt
 1Uojtv/27nmLQJkkTHBHzI4nzQSG/+bATlEt8ji+eHcyClgrRtE8H1wqHIO07RSJlbj8
 ntvsl37VnoJFPQQgIROVb2oqDkoo9XSwr2t3nuEiM+KolUzYWYvySl93ptY9KDhxY05a
 +i0HlsSXll9ZzaYtxSgdcETphOI+fzNfbdbtTjhn7f+H8WOwKi4wNvY2hRcboeM5pnG2
 wVETWQs/aBgKcyeYKrWBCu+3ZmAXTpdSCOQ1a0suuN8/PbXvsBAZdR/zQ3ZR2NTROq61
 A1Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753475040; x=1754079840;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JTuumkgFOey9hX3vvE2OZMKLe9YWvrTZUKA/vxEnCkg=;
 b=r40EKq2+Z24jc5y34san0AfGXzT/Vr9wQxj9t1bxftfRDwsfwqmnyz34UhMlyys8Eb
 j25xWeW9MnsgYuOk9WCIiDlutnYWrK+kwhPYTO+aa7zCHuLcz/CQ2AoF5Rn9V8lN+wX7
 nf/4Fzlo93/kYNK1gmkM0AsLuMbBbsYjxi8XkaSZanhxPaTYFJNMCG1vU2IpKR4zB+f9
 106d7zkCeEBSvCX4dcNm26cakZ1mvA+WybQ3VctZgpnT7TochY0bHe2b/lvk43qoJUW+
 pyasH47sG8K8lEwkqnqw1n9KeRE1ii4hF098dX6jXitjmCkRNPfte841kITgtK9oOr67
 /OJg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU1zZd5neFTonXm1L7mWN8SKNSg85hkSWY1uUlLymU3oVVeVbaQ7DD2QidptyfSOJAN030qPVsCM0iU@nongnu.org
X-Gm-Message-State: AOJu0YxMLbQiw7aFG5jJGjfrzDL0QZkXFxA+KAPZG2TY3gFHKdKF7g2S
 ncqNcBHxXkb9Le0j5q5yboMge6EZKQ8yvRlBht/sB2FyhEbtdICe4MQkeEpeO5hipL2lBGa5XDj
 +wCqQ
X-Gm-Gg: ASbGncs7lN2kdbWpskaGixGagFOE0T/i+c4JoEVeXal5NnujBRklNojUk47nbNFmHFN
 7QLNWXL11XFhaBtssLkWohXX2NLcvETbIHIwv8pdF/DJ3IHtHPSoDurPHtVqq1XY0qv8HGQTz27
 3AxGsoGHF8Sry4zAhJ7ejPvgPHy8vw6mFhmeGcYQT2nOU7V8bOGxfTGjXJmP83dx0wo8OnHmZ1W
 7PRR3hTvRW8+r3Eu7IsZju+zp2lfczUAO1sWj0HQOYzFgtVU1MDv3RLpvtTeJ8KJvi+mT4FCVW2
 zyvtJI765z+AqL14pUhGpup36I1fDP+cmKG3/iH9zoymarWqSknvuB5J9KqPKbp1lPvkEhSKuS0
 cfjhTOznwZ9Z+KtTlES7HhzuCtVzQFivzQxTuBfAU3NLEVQqdluVEUOYgQ+dbk/rX924rKyqTqP
 6zCg==
X-Google-Smtp-Source: AGHT+IEA6s0V2Ji7HqTc/du0kYggNoG2JNE8Mh+e7z1FMMNUg0fL4ugKRLwslHC0plSq/Dbhz/rqXw==
X-Received: by 2002:a05:6a00:1741:b0:736:4644:86ee with SMTP id
 d2e1a72fcca58-763343da65dmr4833278b3a.14.1753475040354; 
 Fri, 25 Jul 2025 13:24:00 -0700 (PDT)
Received: from [192.168.4.112] (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7640b8b0911sm342813b3a.124.2025.07.25.13.23.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Jul 2025 13:24:00 -0700 (PDT)
Message-ID: <91da16cb-45ee-446b-97df-95ef956d1386@linaro.org>
Date: Fri, 25 Jul 2025 10:23:57 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 for-10.1 3/3] linux-user/aarch64: Support ZT_MAGIC
 signal frame record
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20250725175510.3864231-1-peter.maydell@linaro.org>
 <20250725175510.3864231-4-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250725175510.3864231-4-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
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

On 7/25/25 07:55, Peter Maydell wrote:
> FEAT_SME2 adds the ZT0 register, whose contents may need to be
> preserved and restored on signal handler entry and exit.  This is
> done with a new ZT_MAGIC record.  We forgot to implement support for
> this in our linux-user code before enabling the SME2p1 emulation,
> which meant that a signal handler using SME would corrupt the ZT0
> register value, and code that attempted to unwind an exception from
> inside a signal handler would not work.
> 
> Add the missing record handling.
> 
> Fixes: 7b1613a1020d2942 ("target/arm: Enable FEAT_SME2p1 on -cpu max")
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   linux-user/aarch64/signal.c | 93 ++++++++++++++++++++++++++++++++++++-
>   1 file changed, 92 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

