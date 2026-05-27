Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE180CD6E44
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 15:42:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSGO9-0002CI-Ag; Wed, 27 May 2026 11:41:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wSGO8-0002Bu-21
 for qemu-devel@nongnu.org; Wed, 27 May 2026 11:41:44 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wSGO6-0003ji-E2
 for qemu-devel@nongnu.org; Wed, 27 May 2026 11:41:43 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2b941cd869cso77075925ad.1
 for <qemu-devel@nongnu.org>; Wed, 27 May 2026 08:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779896501; x=1780501301; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=weccqS38U/kU3XMqFaR3YzJ3Ax26/kYDWWB5I9bEjEk=;
 b=FEnIPIPO/CdBc83vlQkw2hs6VLujFw2K0mogiu/ZQ0+rfOTpfNtMAZfVShljiU2x2i
 zVHb++HIdIuZQzPO3MU8HhFYTy8tIRw2xvWZP1g1gIjoy2M83KRj3LCSIsYjgZVDWrv8
 hsMvm4c4EtVDwGdongYLyKTWA8DQwt7YfKx9T+tExCcupda4uJXAapAonNZezAvOnGLh
 fmxz7W8pIloKNvE/owpoFvo4SC2Z3+cSQ1+77XXMEeLsQm7DDOOAhRi+jsO/atz14mml
 9q3oTjx3RVG8OGosgdZWFrcUJ4lZ6TYChWOxCUfrLqvdgXN+NMasB3gxW38b7rs/31gy
 l3oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779896501; x=1780501301;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=weccqS38U/kU3XMqFaR3YzJ3Ax26/kYDWWB5I9bEjEk=;
 b=q4z9++7vzgBAVd8IbvumKDir4CTSn2q/pcKvB6zaqfaGTGCRa6xgM6Szh9+1T1gE6I
 MuG/R7ofwi5oPHqbZUCQW4F1+VPirUNSEqChPVO2mLiCOj2jOu+iwznxkAUM4I1R7zme
 1RgccjmWJUlC7ygn/pGZ27jnv9QogbCWJfzYE6ZVC8rogJ2YfTNJ5JN9uv4s13rejISP
 tlZ4pQnuTDphyiTrE2PZVqJoBGkkvcvV/A/cYpjgyh+2CEv81p9YY/NoZKWlcBBUppZ1
 Hn4UcZ3LMXhfn1Zcpms9GHV3qL2Qw2PkUKfyW+efk5PcsR24Itzyc0yBc71WoHEpDyhP
 iBHQ==
X-Gm-Message-State: AOJu0YzuQBphYpRsvkguMYVmKiA/eWYknDzQMrJMnOW/gthGGQF9qSRu
 qAwYchrIZTT4isx6ISxhFePUpfVQyMJmLd8p/DnJvB2Nu39TZe3l14Ek8p4jZPOAmzx3hGS7Ycb
 o0TW3kwo=
X-Gm-Gg: Acq92OEePteXY8ohootLU3GN/eINzQc2c0qe7qSqHC+GV9Go6MSmZHsIAtkJpMp2xpI
 QLaIX4GCImp93fPWfYQqCMMSFpdaeB0E7QxuF32so+E93xoKm/Ks4mRMWoBQ8N0K5baIM5W9/F/
 A2bKCzS6AfnQUG3yOaaG86ZGTQgh6tIu5RTLaSGIkUOHV49kaVka5xNAqm19tYoZT8/6B9ss6wz
 p86tNHiibD5GnAEh0vGSb94StLlm6J6umQn1AsWahNDNaaC4ZAMmkFMwJj2bvItnhCE0PTVgLrf
 Oj6G+sWfDdIr3X2hJDhj8z+sMf66TUnhdVRZJPCPmRAUDfN7PGcVOhRL25iUn1te3KYsgkXMMKB
 aYi1bMDWLHSW6WoGykz2bBqBSuv/bhp29n6wUirKE1+4Re0l6moq9uwPs64PBikBeAfuik8NHoS
 E3Kcfe1RYIhcFE1cdYvC3kTb7becMhnexhZWjxr9UiaLk8d8c=
X-Received: by 2002:a17:903:24c:b0:2bd:9067:58f with SMTP id
 d9443c01a7336-2beb067480emr251963525ad.22.1779896500541; 
 Wed, 27 May 2026 08:41:40 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.142.33])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2beb5695b3csm153774925ad.3.2026.05.27.08.41.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 May 2026 08:41:40 -0700 (PDT)
Message-ID: <00cbde94-39fa-44d3-9db0-1ddafd66656c@linaro.org>
Date: Wed, 27 May 2026 08:41:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux-user: Fix loading static ARM cortex-m55 binaries
To: qemu-devel@nongnu.org
References: <20260525230308.137009-1-deller@kernel.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260525230308.137009-1-deller@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

On 5/25/26 16:03, Helge Deller wrote:
> From: Helge Deller <deller@gmx.de>
> 
> Static built ARM binaries for Cortex-m55 may have been linked to have
> their load address at address 0.

This is a problem.  We also use 0 for "unassigned" a-la ET_DYN.

Perhaps ideally we'd pass around a separate flag for ET_EXEC vs ET_DYN, but ET_EXEC with 0 
is not a valid binary precisely because it attempts to map at the zero page.

Honestly, I think this is user error.  While we support some m-profile binaries in 
linux-user mode which the Linux kernel does not, for the explicit benefit of the GCC 
testsuite, there are limits.


r~

