Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C35F7606A326
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Nov 2026 20:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=rkPHwzrV
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWK2N-0007vw-0z; Wed, 25 Nov 2026 15:56:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xWK2K-0007uC-IO
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 15:56:16 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xWK2H-0004aO-HL
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 15:56:16 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2efddf749e5so29424005ad.1
 for <qemu-devel@nongnu.org>; Wed, 25 Nov 2026 12:56:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795640170; x=1796244970; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=jo6IH4LAyxDDFcfHgqOWUUN353YKtP4HBEU/3BWXMgE=;
 b=rkPHwzrV266cT0i/DMRQ+ZFg4hxcVpGPTUcUC85pRzx6y6DDYk0JpFFNerY/uj29hk
 ZG49l2UXYiYeibL/uSNU5MqRRQmoxNtPSk1/a0DMHjlxAZPKvG/rG26AOzLkgA4isSJR
 3aIx18zUL4xWFFu+oDQsKI9q8fO/2z9nqX+yco8+9e635w+nf3riRKtm+Mnc0lHdY4iV
 oKctWCKJ4pp3NNKBJSQ1XntVJThGGi1kkkMWe1vqQKEuZZPNg9/I2iLxgG12avZoaBoP
 dPJRr+ezX/OegfYFiHTbavaafJZ+UWp4688q8g+j5tfbJ3YQ4FOihqLfmCt2ZlCLhX2f
 2sCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795640170; x=1796244970;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jo6IH4LAyxDDFcfHgqOWUUN353YKtP4HBEU/3BWXMgE=;
 b=UCOvz3zLO5Yjj7FHI7bYEBcoh2txum1SG4WaQriKI5TKAHKNEo0hzVlVudmGlr5g0j
 rBfFHFpul19L3pVJhqdstfXtQKf132aCyi+U38YF6sfqPQBuIYxMY0RFoLdQdaIBh1S0
 GDrFnCQbFM2hTo8f5p1kcORxqa8C9TItuc1A+ESwiFRxrTjednU1t9piCWVbpqYXj7uP
 1/4B8MNn6qLHKPv0r9S1WMTGoxMwTufw0e6Bbvj3rAtADpijw8Dt+4PxNQi0fmcwwEzx
 MyrFYWN4JNFDAlaG6omKbd5p1h5JEWCelE5746L9dsQVIkHfbYhiP0AhF1o7a81gBpci
 0gLw==
X-Forwarded-Encrypted: i=1;
 AL+hErHGOD9qWKgvigtjraOzZzFbhcrQttPbMaZBNtEJ8av9yGMjyXupYEmDm20sn61eNeXilwrYhFCi4uBR@nongnu.org
X-Gm-Message-State: APuU4Z+ZUPCPNaxeb5lGtMfXdUktZzyeGQq5w1pEPvXNW0o1ArA+iVu2
 trlflg8WX5HF10xuGqbg05J3m7EfT9yJdIeBjM/L8lEMtmhs9zntcKD6Do4bpny7Zy8=
X-Gm-Gg: AZFdTZf3Z6rqGng6VWaCUBmKGad1H+LDRj9+A0Y0YtXANwH41tt15MiX8V2hu9atZ9g
 mQjOQjwtqnxNoE+MUcxB5gk4jTzNqsByk9o8tODanFdOYYHiHuM30uvnrPufFFJULyhXpT9FItP
 5L2U+Zj1FNggfE28gC5gKJqbev76IXDDGMiJKaa6u5khjS/jw3GBHHrnL8ffF5uiy3MFKzqSZIY
 eXFPbcs7am2CVd2utx8Ad5VSOv+2AjcXfrZLW+gJR3FwZBGwsIj18AiFsYPfZfVG4M7EA8fXcz2
 m6xfy4SNQwWvn0R2M/1Iv5Dga0Tcg+/3DoYpXy+eAnvYyjrfROJLPj9i4matBLhNEE2ULr2DCe5
 r0FgCA7E2A28gf9OYVRMakJQq+5ocfbFSV5PcjGN9+cVPvPoUw5Tf58WZ6KtZFMglcEHRhmJN7Z
 bM9ufHQ8bKamsZL6+OZ6Sa5MTYp2OmrlYQoYewqoGcU9sEoJtPiToepmlnkoifuK/FWSVJ9T5+b
 FelmMmPL5M4PE0kSuGmg4AJCz0b5VVbto+R7mvFZuZtgrbOUwEuXmupbDfTnmDWD0D5blc49Lgc
 jox1I0fNYCTQWoPXE4wvpZDBj5ulDcOjevtTInA4KH7a
X-Received: by 2002:a17:90a:c10e:b0:3b4:1356:5c66 with SMTP id
 98e67ed59e1d1-3b41c8df703mr13138679a91.13.1795640170257; 
 Wed, 25 Nov 2026 12:56:10 -0800 (PST)
Received: from [172.20.3.121] ([156.19.246.27])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b50234fb25sm1317802a91.2.2026.11.25.12.56.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Nov 2026 12:56:09 -0800 (PST)
Message-ID: <d1c8970d-8ae6-496d-b08b-308ce3601090@linaro.org>
Date: Wed, 25 Nov 2026 12:55:09 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL for 11.2 0/3] hppa target fixes
To: Helge Deller <deller@kernel.org>, qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>, "Kirill A . Korinsky" <kirill@korins.ky>
References: <20261125025822.10813-1-deller@kernel.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261125025822.10813-1-deller@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

On 11/24/26 18:58, Helge Deller wrote:
> From: Helge Deller<deller@gmx.de>
> 
> The following changes since commit 2bfbe39d0fff8af881cffe2bab9b615e77807c35:
> 
>    gitlab-ci: Switch the msys2 job to use ucrt (2026-11-23 09:13:18 -0800)
> 
> are available in the Git repository at:
> 
>    https://github.com/hdeller/qemu-hppa.git tags/hppa-fixes-pull-request
> 
> for you to fetch changes up to b6a03b864508c24226d83b06d5a6f0439fcf3fd4:
> 
>    hw/hppa: adjust CPU HPA on 715 to avoid broadcast address (2026-11-24 22:15:23 +0100)
> 
> ----------------------------------------------------------------
> target/hppa patches
> 
> Two small patches to adjust the CPU HPA on the 715 and B160L machines
> to avoid boot hangs, e.g. with OpenBSD.
> Add one new test to check if OpenBSD starts.

Applied, thanks.

r~

