Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E92C606A33B
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Nov 2026 16:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=ccpr5KCt
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUoND-0007nO-Vk; Sat, 21 Nov 2026 11:55:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xUoNB-0007lI-AE
 for qemu-devel@nongnu.org; Sat, 21 Nov 2026 11:55:34 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xUoN9-0000oB-I8
 for qemu-devel@nongnu.org; Sat, 21 Nov 2026 11:55:33 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2f06ff94acfso1505165ad.0
 for <qemu-devel@nongnu.org>; Sat, 21 Nov 2026 08:55:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795280130; x=1795884930; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:to:from:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Bagqczuuyp3Qr32vQtJyRb5XD5AdRgE7p82m+nSsMgA=;
 b=ccpr5KCtSvyK8G6Ss75nCCLemycs2rfyCjWxwwXcEAJwazakQTCGcYlae2nmqxtih7
 96aI5571HOcufnThRG1MNjIymcjkCVCdiVSylW70JicizM2Y9LP6IcRsHN2DWtDy08pF
 bve2RbzuB+y3Y56ovFBTaiNw7SJveAuWciDRbCKJIKfHDjqwg2SHJTQuSdxtbXu5jhNe
 JQMkNVwIK6snqQu5QJydrnn2RwivDe7w1K+bedHxRo0I+1IjpWtZDw8hmud4RIYKefAN
 0XkDGNhvGS/csSrFb3j/V1yhYMDA/49bf4xYgU5HMJglGH/VrQUr2PNPe9fiNBRiVeJd
 Gxvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795280130; x=1795884930;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Bagqczuuyp3Qr32vQtJyRb5XD5AdRgE7p82m+nSsMgA=;
 b=IfpNlGNW+T61fxfUuzC0+OnMQM+jZPbcIemm0g57qH2Aqr1j6qU1HBXABVO9XRJ0SK
 nVNuHqXpgJboMf+eQbMtvdt0lRRVMcfYQN60Lvs0M/h1EyG9iTkSrHuv4zF9/hgWsbRG
 Afla0e//ySQIeaCJCGr7glJ8rlbtX9ou1SHChr7TVWSGamLgqkwL2YTq18zgqpmffxmx
 LGECTOAjw9vItYU70BDHEJmzp1s1iyOvjfgPxp8qqfzxtaLfZ84zP4qLlTa0TDoNCU7g
 sC52z1aa3goQHLOorYohfRL4jptajEZun8uwUZmNzO0anMoQ9Cry6EtOeXTqTyPyjbFX
 +hIA==
X-Gm-Message-State: APuU4Z+NYy7sa3M325b/+KpqlIXRERPqu2s0+i7UCm4eVapBXVo9A7Di
 OUTsDwZMhTY5Jj4x5pXy4kKF/B0QQFkVC2DC1MS88ZpqHSwrh8ziM1p1mXjMBTqEhTzyMa8TAGY
 nUYGo
X-Gm-Gg: AZFdTZe7GHiLmvLF6fKMFrU+Okwia9S+PJvhSQofjIoMkrpHFRP3MtYua9Aof3pHk7k
 Jruj/X3db85Vf79OSdzPgRDsR6HiS9+DwCThWXnxMFqBdsF25llDC399Vhou9N1RbJTT6tVKeeu
 Ny53LJg42dSAGldX/tXL0Lo5bOmfCbm6S6bWNXR01hmePpQx7qlURDOSKg8LCRNcR63P0/B0vmH
 eNbL1uYaMPzZkxT2UOeW6ujmUOr65RK4zp2N2uU/wcahgIvAKedEUqq4H//jnSGXSTGEUeXmrtC
 gQJraE8CD0uHjXd/49PkzALFOXvb06Gin1ZW22pG5vWiIRDUpAJ5uhwjJDfloLf9vKE8t7z2thr
 RehO6K3YlPA/AstULxFrup5lC2B2GTMQqRTZ3TCdArzv64Dj8n6+btbdyKJymZz/v0Xn7d/YqKL
 x1RQ4C4I2b5MRheuzrDo223R8zS2DMLnCQ+nFqsezEQymdgW4gJ22p3KrHQgbLaG8XYgu7gSxhd
 8wkVbeJB5XrrNemaly8gfnUB+HZuGVYxpUaNjl9so1EJBGC/g6xV3uZo643+8mW8/n/7GESaQKf
 jyVbUn2rceoSUIqGLcGrOODLrs/2kf9sFj6svRT3XFJi0oSITLXfYDLXfiJYXmoA3qSVXvc=
X-Received: by 2002:a17:903:26c8:b0:2df:b250:ad9a with SMTP id
 d9443c01a7336-2f03f1722c4mr59385255ad.48.1795280129425; 
 Sat, 21 Nov 2026 08:55:29 -0800 (PST)
Received: from [192.168.0.4] (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2f03ee84294sm28015785ad.9.2026.11.21.08.55.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 21 Nov 2026 08:55:28 -0800 (PST)
Message-ID: <b8601f47-cc5d-44bc-9455-28b994787985@linaro.org>
Date: Sat, 21 Nov 2026 08:55:25 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/5] tcg patch queue 20261120
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
References: <20261120225138.7198-1-richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261120225138.7198-1-richard.henderson@linaro.org>
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

On 11/20/26 14:51, Richard Henderson wrote:
> The following changes since commit 08c9bbb825148dec9669f5184ecf18823bb6d631:
> 
>    Update version for v11.2.0-rc1 release (2026-11-18 12:57:24 -0800)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/rth7680/qemu.git tags/pull-tcg-20261120
> 
> for you to fetch changes up to 3b89d474910fe8a8e70d83639f5bd26de37ccb77:
> 
>    docs/tcg-ops: Rename cpu_env to tcg_env (2026-11-19 11:56:49 -0800)
> 
> ----------------------------------------------------------------
> docs/tcg-ops: Rename cpu_env to tcg_env
> accel/tcg: Fix jump cache flush after large page flush
> host/include/loongarch64: Fix build with 128-bit LL/SC enabled

Applied, thanks.

r~

