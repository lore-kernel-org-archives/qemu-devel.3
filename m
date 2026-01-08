Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF4D5D185C0
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 10:35:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdnMW-0005GL-E4; Thu, 08 Jan 2026 05:35:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vdnMU-0005EH-U8
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 05:35:26 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vdnMT-0004KJ-BZ
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 05:35:26 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2a09d981507so14584305ad.1
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 02:35:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767868524; x=1768473324; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sVKuaB0eJyj9RF6Q3YqtGhwJutdZsC2H2sheNvi2Ngw=;
 b=ZCZHkCFwNoLqVpRUCJ/lvpS8BDGZ7pp8Ql9SSzvTvS0GtJJMvRVuBXlqKCAKTH9VSK
 /t5AcVo7EAFwBkufDH8ns/Uy6ILxRiZXoIAksiKEgCzOQ/F7qaT0yHRIuMMwCuYURXpB
 f/erbvJNNapNMHMVUari3XLePxnVyoBx35nqhHdUvyj6/exvxdYkJalHGHztKcXKvSXd
 YNgb2DS6TG4udKYAcXXh3OAWN86iV0Lbs509np1WpgWYWzV5/4mi8TFZTT6i/R/UBbXE
 SN5pZcdLLIXlQuT0mIXQGr1quxVRjkTOIeuGb4Vw+kC/gV0pqWT3r5iW9+KIdAH4lO1W
 mWmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767868524; x=1768473324;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sVKuaB0eJyj9RF6Q3YqtGhwJutdZsC2H2sheNvi2Ngw=;
 b=h6jsVzWlOShCJpa2gw9lK0BAZR3SXZoZSDwhAsvMNkLjMZQ+20kBqmMgThm4NcIhlQ
 nMGWr19TJV6p1IYKWV23JJVdHzWGGbfVCvJF+VvufBu+AZy+Gc28EfAYNnP75UOl2h3e
 dfR69+yhea2lTpkATynHhOhe+dNNsDs9DMwh0N6KudbRbi3e8LZh2ImmnZvQOOvzM/sn
 q6f0mTM4EikCY0ITd6HIpoc/kXByax1uRXNXxu0qsq+Ul9jRTo/hs0hCbnuo6SKRTSRt
 SPSArmzoTkoL8p1nnGCloHDrOmiVJtGKM8FQyqGvPzUIsGAYp8/vXjnw9Nj+Af2c580C
 t0Ng==
X-Gm-Message-State: AOJu0Yzsws3UyhYaBtnswQl7z9rn83QMs+Fgq1nL5ybuERyJkXIEQYW/
 oIxKqKjc1Fh8jMTw/pQBGaU0aPoXUe6Jqabu2YtKyY766crjPWHynyqgtM38G2WK/RI=
X-Gm-Gg: AY/fxX6LU+PZ528jFFUF2puXCGhPDrWYPD4CM1N02QxKkfNYNpVr6AprywTp/1qN6cc
 d9A/dkYUY5PzgOzH1lR9hs7jegUaiVVtGLO8OfLusZ/urQZsL/bvRPNk28Brv46UbeClpqfe9v4
 GhRhtN1B+7qDS9Z2G9DgI/6bSCQp5uVzC6ZPj2qIK59LYhtz6iR4qnZg7gCUUD2qlD3nJNwIwvG
 wbYeLs5Tz6MyHZRdlR+wW42Os5W0/mUwa8/vaOApqprmDsRIWMHXdhDBVEFojeHHrAD9GoBejit
 9fYU6bJem7gg36mOiHRxLMLYZ577FwJO+hmyBHXbhgD4j4/UzOXC2p1V9QPYKY4LgmA4sLin/DE
 e2JGgcsSQGsY6d3blV8+Z2NUzmBuopcLruxS231K8t9ur28zdgQHuXrhU/l7UqAyp0MnyDqndUG
 sgXL5tS0IafPcs7Q2ncqZHEKZDigylCAcQO1EUkwkW
X-Google-Smtp-Source: AGHT+IFS6QZi50cDgYmkvY6AD6gm1Z8xed1bc3rcwZrIrESSYnrk5qtEBWvY71DwyfXmSZPIyWAT8g==
X-Received: by 2002:a17:902:d511:b0:295:50f5:c0e3 with SMTP id
 d9443c01a7336-2a3edb775b6mr57995795ad.14.1767868523730; 
 Thu, 08 Jan 2026 02:35:23 -0800 (PST)
Received: from [192.168.10.140] ([180.233.125.201])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-819bab0da0bsm7259019b3a.13.2026.01.08.02.35.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Jan 2026 02:35:23 -0800 (PST)
Message-ID: <4df07fa5-f12d-4df5-9b59-0a2fce44b236@linaro.org>
Date: Thu, 8 Jan 2026 21:35:18 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/50] gitlab: Remove 32-bit host testing
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Kohei Tokunaga <ktokunaga.mail@gmail.com>
Cc: qemu-devel@nongnu.org
References: <20260108053018.626690-1-richard.henderson@linaro.org>
 <20260108053018.626690-2-richard.henderson@linaro.org>
 <aV9y9b2-XRvNOYTG@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <aV9y9b2-XRvNOYTG@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

On 1/8/26 20:03, Daniel P. Berrangé wrote:
> On Thu, Jan 08, 2026 at 04:29:29PM +1100, Richard Henderson wrote:
>> These deprecated builds will be disabled.
>> Remove testing of armhf, i686, and wasm32.
> 
> CC'ing the wasm maintainer.
> 
> This patch is removing our only CI testing of wasm.  Is there any
> 64-bit container image that can be used to test wasm instead ?

Ah, right.  Yesterday I remembered that I should include this in the cover letter, but 
then today when I actually posted it I forgot.

There are two sets of wasm64 patches; the simple one uses TCI, just like the existing 
wasm32 code:

https://lore.kernel.org/qemu-devel/cover.1754494089.git.ktokunaga.mail@gmail.com/

I attempted to incorporate these patches, but there were too many conflicts.

The complex wasm64 patch set includes a complete tcg backend:

https://lore.kernel.org/qemu-devel/cover.1756724464.git.ktokunaga.mail@gmail.com/

I really need to study that more before I'm willing to accept the core tcg changes required.

Anyway, I meant to cc Kohei about this, to see if he would revive the TCI patch set in the 
short term.


r~

