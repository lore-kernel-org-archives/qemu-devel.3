Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DB64CCF9FF
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 09:26:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vElOK-0008Sk-U4; Fri, 31 Oct 2025 05:25:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vElOH-0008Rp-CR
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 05:25:50 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vElOA-00034f-7d
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 05:25:49 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-b403bb7843eso438646166b.3
 for <qemu-devel@nongnu.org>; Fri, 31 Oct 2025 02:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761902732; x=1762507532; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hA76brBIBOWePLJ/qyt2c923qtHZ55l46MKZBmq6Wvc=;
 b=O0tZ7chB2bKYTYNWOgsMlr4ldJlxdE5MVDDJwJoRreD0cpp+dur2yq5n9UMKfRdKsO
 rnUWFCTazTXYk4CGA75YNduBRHJ4tXGeHsZwaQBzhjuM1eGcllz/mdmHsJ5fkLPrSdIK
 sz86kIYddTJaePSf0z5yh2aDWWil6PrE9bZLei9Y/5CPi1sGzy9qidv4uG1GXTV0e8uD
 AWn5QRSKg/pNDpI/LRCVMfE7V8ONYlA/TCpxnw6lv9iUJypFSYd3kPok3ylA6lTCNywA
 AJmxDGJs5VXmHH/uMtzT0lHv/626o93Yd/BPjuJJOPX+1Rc/hG5Z9iuTecUBgm59DAQq
 2Rog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761902732; x=1762507532;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hA76brBIBOWePLJ/qyt2c923qtHZ55l46MKZBmq6Wvc=;
 b=O22uUwqfYN8mBQcPUaAJUs1rGtKksvAR2T6s0aCtki42QzOi7R+zfSqxqE/EADmx1U
 ZCP5HmSVhJQ1OTwF7wkYYMSywrE1AznXKzre7P3mBNX8BbNDN4wwowBrxFbjkF4TAlcO
 MYFGjaEnaz6vi5x9rvTjtA3NJPJQkaV/BnPUA1acZcxxOTm8Iho359D2uNmecpqP7+1E
 qI57/CC3xvFHyDdRYuUqHVu5ICoAjUD3xAIMpaF3rhh31IrKmFJIvsi2Y7d1wLVVpwUk
 D3ipmAs3Di8h+4WXJVXLpy8TcngJEGoJrFDedMqMOweyRLPLsuGeLRQqPapXo4r7OxAU
 syEg==
X-Gm-Message-State: AOJu0YxHmcBaQni4NHYNsu2kPIOIrbLG7y4tg7r71s+u2KlUS/yp8wR2
 +cer6C14qdnLKyForpYEvxB4RwZfZcj7lbvHp4vDuy4ETxBDxcW5fCMsQoPAcbbtOwAsX9eSbvo
 5kf6dZ2Ikzg==
X-Gm-Gg: ASbGncvVHT4YtWloeMZKenxi+AmGv899mjTZuzhAti7zYb1J4P1dYueDr8emXXxSUNe
 L52xeIfr7qHJI9ixyTn/nvJFZu/79bh6ghfwOjZhsvRwnOsnJ7FJBt0ZRYXW+io8hRER+spHqxX
 hTPWn+bbOtFpHEpe4q6G6HCXWhfr0xqI2BZyEAz8D4nPi6p9UXG8F3KY95FFTHvIgQVdlhxf3Lr
 pqW2pqG4ilY0fCmGQ0+XsX2VRBodiYUs101WVosc2lojDwUSctWcAOD85g8roEcITp9uYAVtgaB
 TeFeXL1M2/L3hkDs5dtf9M5P1EQmZWfYTZAwdxDLtU3Okclsv+3khwSW/lHJB0k06DQwwMETMdF
 mlfScTJ4G9Dil7lQUyagBgdxhaDHK83Cc2uotw87zVyZQAPshLqTwvfRODynkIh1kDt3/UMC+m7
 Vrp9HirNY+X3AB3ayiH6N4GfLXFfLSg4hB7O5q2PJ32MmFeNSLU9PG+8+4ytgFFg==
X-Google-Smtp-Source: AGHT+IHoUfO+Ftp+MV2fB9KQjJfhcwn3TKYrRntObVVgEBbItIO/MIguHDZ0SbtaVZmK/bpcXNWVmg==
X-Received: by 2002:a17:907:3e8d:b0:b6d:3660:421a with SMTP id
 a640c23a62f3a-b707060cb65mr289182466b.44.1761902732215; 
 Fri, 31 Oct 2025 02:25:32 -0700 (PDT)
Received: from [10.240.88.227] (C3239BBB.static.ziggozakelijk.nl.
 [195.35.155.187]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b707bf79e72sm86002366b.51.2025.10.31.02.25.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 Oct 2025 02:25:31 -0700 (PDT)
Message-ID: <39684a98-aeb4-4266-b97d-6a23d5f94450@linaro.org>
Date: Fri, 31 Oct 2025 10:25:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/35] maintainer updates (ci, plugins, semihosting)
To: qemu-devel@nongnu.org
References: <20251029155045.257802-1-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251029155045.257802-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x62f.google.com
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

On 10/29/25 16:50, Alex Bennée wrote:
> The following changes since commit e090e0312dc9030d94e38e3d98a88718d3561e4e:
> 
>    Merge tag 'pull-trivial-patches' ofhttps://gitlab.com/mjt0k/qemu into staging (2025-10-29 10:44:15 +0100)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/stsquad/qemu.git tags/pull-10.2-maintainer-291025-1
> 
> for you to fetch changes up to 4f45b2c352bb72c13a8801805061b31979e3f048:
> 
>    semihosting: Fix GDB File-I/O FLEN (2025-10-29 14:13:40 +0000)
> 
> ----------------------------------------------------------------
> maintainer updates for 10.2
> 
>    - clean-up remaining 32 bit armhf bits in ci
>    - rationalise build-environment.yml for Debian and Ubuntu
>    - generate a Debian ppc64 package list
>    - rationalise gitlab-runner.yml for Debian and Ubuntu
>    - new TCG plugin feature to track discontinuities
>    - add missing CFI annotation to plugin callbacks
>    - drop SBSA_REF from minimal Arm build
>    - format string fix for gdbstub syscall response
>    - simplify the gdbstub flen handling for semihosting

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/10.2 as appropriate.

r~

