Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406D3606A324
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2026 16:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=D+l8Deqq
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOHGg-0006Cf-J4; Tue, 03 Nov 2026 11:21:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xOHGe-0006CX-H0
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 11:21:48 -0500
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xOHGc-0000CA-Ka
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 11:21:47 -0500
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-89f639ba307so1611696b3a.3
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2026 08:21:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793722904; x=1794327704; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Nvtdpa3Hbb+9S2EzhQVhychkoZ8J9CucOmbWfP67IGw=;
 b=D+l8DeqqIX8MobFRr3F7IoK8nvzBb7EtpD9k3UvaY5BIoVEtdgoqONCMMgYA3yMAbr
 6wk9XkCEtW//O6pZ8qV4U8TqkXy9JiIdh5NWqHn+Ty30WOwHjf1hBWTYooan5/82Vh40
 LxHbj1nyqwNbi4g1QFYxghscNI7o7Zhb0uBA6KQhGtcgGdR9TGgL/G8XdkvJg/VP/tfb
 9mvzGpQ3lEFRsZDOjp/eLiY+nyOKFzpiPbsb8fLWdWYD2VtTz7fkfQEsnOrGLzrqVVv8
 KUalJjXChoprFCR0drbut27sEvnPbHJIT1LaxI/WCDua/L0JN+M7642Sbul/0ndGOa1x
 Nr5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793722904; x=1794327704;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Nvtdpa3Hbb+9S2EzhQVhychkoZ8J9CucOmbWfP67IGw=;
 b=FLFmb5IsSdORli9MuWMbscIO0Rfa3qxVfcK55EWgaAtocSVgw2AEJRZHUC3J/b8/CF
 rWl52PmDJydD10XbGKx3TEA8vsd7wSt9oxUyFaHS6e19suskRL/NbPyWuZ2GAd9uQovf
 o6bvwi0leB2b9z1c/3TZhR4+hyrcG2T54B5yrxCNrL2cClxmt8t8wiuAfhz9n0Xwaq2Q
 YUSv0G7AtNCDNomB30fJrYrMpnkBCD2VGpPgmr4sPbm4X/T+xX2rrbFrBVfk+i3BoAfX
 xLuPLB+HRbJEJ/VWf0FOBsVaz3DqPcHv1LApjPeSzyg5zmALD3ha05x+m55MrlK6kFrj
 ztjQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxWTG9YlC3ov5YWbjOOFU35LEPSsjlgVi5EmDEckX5FeN603PF4OU274oCBXZQBEHtMUdz/mhrSFQ3g@nongnu.org
X-Gm-Message-State: APuU4Z+TWfyGEwXDFXS7Ar2q5DNVEfVT4dhdNKjZNwkdUTa1V+NG9uzA
 8Dep8CroP8FzgpvOnthN/2ydMo96f8yq4Wn6WjoqSLuaVne/73l3MiLbmbg5idY/eIk=
X-Gm-Gg: AYBFou3TMJj4luxspmB88mSTIF2S+syQfT3pCynsmc1g5AouzF6/I5+gnD2dsJqk+0m
 KEVqvWKfXxcFfl2CuiYDk4pyJk4LoybIAWkraNxQjtC3wCN75+kTT8PV2J2E7ICIhAxDi6tHxLF
 r8slf/JQjqMDW2+nSnYjP1bI7whuKyjP5jhleYUh2z4BOfzxOP8M+Fmme0sv+TYdAyUxlHF39i9
 FH2ffMhuCSg1D/+GXgmrMpfv1dphxD/k1/qES4jwKudO9G0bPnghYUJnB69TCB8Yh19JiiiPUjX
 6Hh+mvF/ZGn4zuEPpi3eWvix1YW3pu+SVRIT5E9b8iHBnp5suE7kJ/UEgpgjvmKKeTplZc11cvR
 IYMwTTJG4uXyh3e5w3v9BoI+sXE5b67u5vEYnKVCxKmeM/q23cY+yBkWdvDOBIPfvuaDzFR9xc+
 rAEvnAnqp65+8se6sNpU+nJefU80ZfV+/BYyxQa/6FrTjNR2wyRDhbZaybtHyi/yAThWkDkg6+v
 kUk02VdlbZ+qATbjyLhQusupNy/SLknj/1uU1U7wReFTFitTlD0SK1QhUrQTi7g0SKeOBw28+OK
 s/3fFViaD4YmMgP7LZMh8R353GMXh2G6SXLsnwSzk1RY3QJAkDgr1zvkBKc6pRW8dTRipQ==
X-Received: by 2002:a05:6a00:2409:b0:8a0:2b8f:ba7a with SMTP id
 d2e1a72fcca58-8a9bed5d364mr11011026b3a.33.1793722903445; 
 Tue, 03 Nov 2026 08:21:43 -0800 (PST)
Received: from [192.168.0.4] (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8aad77fda1asm3450765b3a.6.2026.11.03.08.21.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Nov 2026 08:21:42 -0800 (PST)
Message-ID: <4f78e055-0ab3-4e21-857d-24a38b309e48@linaro.org>
Date: Tue, 3 Nov 2026 08:21:40 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/tcg: fix load/restore for test-avx and test-mmx
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20261103152111.2393800-1-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261103152111.2393800-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/3/26 07:21, Paolo Bonzini wrote:
> If "r"(&result) used %rsp, which GCC16 seems eager to do,
> the comparison fails because run_test()'s assembly block
> moves %rsp below the red zone.  Use fixed registers instead.
> 
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   tests/tcg/i386/test-avx.c | 22 ++++++++++++----------
>   tests/tcg/i386/test-mmx.c | 22 ++++++++++++----------
>   2 files changed, 24 insertions(+), 20 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

