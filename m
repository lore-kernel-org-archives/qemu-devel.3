Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDB28E9D827
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Apr 2026 23:23:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w9Woc-0003y7-Bv; Sun, 05 Apr 2026 19:23:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w9Woa-0003xO-B0
 for qemu-devel@nongnu.org; Sun, 05 Apr 2026 19:23:36 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w9WoY-0002yO-CH
 for qemu-devel@nongnu.org; Sun, 05 Apr 2026 19:23:35 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-824c9da9928so2482187b3a.3
 for <qemu-devel@nongnu.org>; Sun, 05 Apr 2026 16:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775431413; x=1776036213; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ddrBnai6+zqLQ99iRQc5aMZYHErVPD4mUwosAjSpJZg=;
 b=luB4sQaW2k2Th/cKpT3CbPVS5GOPLtIKZoeHMb5P1D2PRQ8QYNJOvtdu1/iYFen2r8
 42uhBT6wucutUwOiXSmF9dVj414PmvU9aLCNcIMIikQf95tYQalBJP7kDJk5bfGYhfKX
 nTHna8Zy1gK88u0WRf5v5kb1NAq8nvrpalB+cYDDfqHm7zRFcIBMHgnTWugyYU+lkTP+
 WlfTzz8KsaGAEANXQ5yA5S/O4Wt2onAB/TGwUxmNHiKIU7l8Eo+YDAAScfKqk8O1+1F/
 lG1bxfIt5Y9k5DtcJ/ZUeGVaWX9ea2UsAJMGlotGCHynNrt2oMjpPPMYJ/uqq2MCj3CN
 68KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775431413; x=1776036213;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ddrBnai6+zqLQ99iRQc5aMZYHErVPD4mUwosAjSpJZg=;
 b=Xzx/a9+/ReufuzGyWtZvw2+bn6s2FOObZpvIJ2ui2VQBypdXr7dm6VVROlDiEZ1Gt0
 EafLmDON5IX5RI8nyGhCeYSYPBjQD54DlVwYb42fnAonrHTpOPa4vXKg0PMc+E0D7xCm
 B/MKoBNRQm0yMQ3AjyR3+/hja30L9VZ61WI+EPsJmcoHiJrY8wM9HfEG3C8jrqATzzUq
 5WVkAB2Jswo3zJmwAWdYMBuN0fYEgUhBkDwNImhoZhmtT4Zcf4bDtVlvetb1MoKE7X29
 h5Ga1CFaH4zwyjPaelokBYjv+MdrZAgWt9tSjDhF0PRYs5jKbTjL19WTKLHzlbUyCadK
 XtEw==
X-Gm-Message-State: AOJu0Yw9iknh8HChoJVO/SDWZjbaIU+zRc9pD5x1Hrx0Z9ki6NcHoOe8
 3AdMU5ZXvzPss7QyLVqnnIo0tD5NivqdKZMAXH4y4kqCjhvGV/hzzpNd80HzvfU+QcfftJQyAwi
 v12j1
X-Gm-Gg: AeBDiesg+Wen6poM1+XhVrFxeB+GXIvJH4M56oh6+rrDU4swHT4xKkbs7nE86Eupknf
 YvbNTB2bbUETuR2duTpyGuy670gZHvT9XO5pjGB+AtNGiWK2T5h0tt4LMWG9EGHnn1tJkHfprcf
 7bJeDMvvaRZyCdCj+Nhv/3DTHSNcdBMIk0yvYbWr5Op4absC/2Mv1CFJojLGEleOdXYx/AvFt/P
 Hny3o5aJoJK++vP7tgcXaAfQpTMZAv/YvmzljXy2IHwGN1uoz988UVwxcPUPHBtCEqjKLlzE1WE
 Zp/uq7iC876wnhtm+Gq7oafq1+FBLt2ze+io3mWcO4W4LUVnE4yGcwrwt0CYPRsZLptAoFa9g7W
 wi3re8+i8DYHzJF+rMjwW5c0quXf/a/Xe0mbv0tZwcJYKGpsk8F4/k2mWAGZ3+SHs3HX/BwizD/
 BUlFQ7Flu5rOeiVpNfraK+oaJm8ZkPksFPGvbm82P8vtvpUZnL8GifzJ1cmfDtm7aeqyE=
X-Received: by 2002:a05:6a00:3cd5:b0:829:9ea2:3e17 with SMTP id
 d2e1a72fcca58-82d0da33ed3mr10861311b3a.9.1775431412712; 
 Sun, 05 Apr 2026 16:23:32 -0700 (PDT)
Received: from [192.168.1.105] (124-150-69-109.tpgi.com.au. [124.150.69.109])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82cf9cf065asm11437164b3a.8.2026.04.05.16.23.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 05 Apr 2026 16:23:31 -0700 (PDT)
Message-ID: <d44fc02f-b0e7-42b6-8b62-8b153f36f63e@linaro.org>
Date: Mon, 6 Apr 2026 09:23:27 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 06/35] target/arm: migrate PAC trap syndromes to
 registerfields
To: qemu-devel@nongnu.org
References: <20260320130607.2071996-1-alex.bennee@linaro.org>
 <20260320130607.2071996-7-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260320130607.2071996-7-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 3/21/26 00:05, Alex Bennée wrote:
> syn_pactrap is fairly simple as the ISS is all RES0.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   target/arm/syndrome.h | 23 ++++++++++++++++++++---
>   1 file changed, 20 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


