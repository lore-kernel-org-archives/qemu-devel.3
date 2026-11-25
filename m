Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED33606A327
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Nov 2026 16:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=vl6tcmCz
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWFox-0006uf-GC; Wed, 25 Nov 2026 11:26:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xWFow-0006tx-0R
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 11:26:10 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xWFou-0003SB-7V
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 11:26:09 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2f04f61282dso26793985ad.1
 for <qemu-devel@nongnu.org>; Wed, 25 Nov 2026 08:26:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795623966; x=1796228766; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=LoCKbRX5CM5VN/YMcsvAA+tKHcDiFIgculkImN7moaU=;
 b=vl6tcmCzre/mdYMkjBT93/ZKb2xz8VC3gxetrrGCixD15iDPvsPS8YdtXNnnwVY4xh
 TU07l1aJmZeUQXBIjcc7ZKmzaWNZszpSeeIrze9kFhMlonZJQAwAxYZK0ZICOpv0yDVR
 wZqhhZ13pT/izT0md4QlolynaBLKA4iuOgVps2fFrlXGmPKyhAEg+kBaDeSF1mr73oD1
 sILlkOKRNctg8aqndZFs97fAv72XGP1cyieRoIPskxQHyw0WuYZ3k/tJGXU4qG+Rgdf4
 SQsWxhN2H/Neh842j/Hh+Jjbh2g8RmALsMsmeiOUQlRiNDKl2+lcgNiLaRDQpYvCXOuY
 Rmow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795623966; x=1796228766;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LoCKbRX5CM5VN/YMcsvAA+tKHcDiFIgculkImN7moaU=;
 b=e/ZUpOqlyrfUsAwLcLCyq0GTrecVGwe84u1zaOdscT93Za3/v/PyS15cwqG64JCFzw
 xk+bUe/hv62sVAbu8MywxBmi5eguYttu+pzACRg06Rn7VaGxeToTYTZevhHGrpjTUutH
 nlsyG8Iu1JrCQzBso8rn/TuHDfq7UU6knEPdoIdqGJlPVMA2C2rk6bBNjz/VWJ5Bzm2A
 fsKcbQXtiA0xp1Dscp9l9AgwIpHRVNmf7SkAXVXVyYe9fpSbjRfs2BnUUC/7E1PngoKo
 PodNly4tMGD7hYET4qzks95YW/KbRNUC8nT/vMxCqxkEnxVhk6DT0KKc1Gyam9nkd4Ji
 OCPg==
X-Forwarded-Encrypted: i=1;
 AL+hErE8RmvNUy99SZfTdOdduMRfnkc4Q7hp/YJ6IMicNqGnmVNAVfQWx5IhKgR+f4K7cY4SaYr7n43aORa0@nongnu.org
X-Gm-Message-State: APuU4Z/7lytLfWm8XoOnHYCCvdIFBy9740aTIBFz6eAzgedKcmSThZZm
 EWChXfzu7GT3XCp2PhxSS2qP2v5POsJIqBoW2f+SsqdzMTJI0EOgul+27kgBwD4LyT0=
X-Gm-Gg: AZFdTZd8drD5hA6fDI9mJEtUzv2l/8DKtYVnSRSVhlYtdQ15lfNEayOp5QPpNom3N7u
 BKodBT4oqDDhI41wWJroqZN8izSi/phGgBh2HQWMbME8RDHrKiNPF0A7/PC8IrpHpcI3rFvOOvX
 jTiUGB+jHbgfOxCsnj8OUk1ShoVsZ3jqvNoLsClc85ZwgOdc0esehWt55PkVWaGQAYA1JEVP2kL
 IeCrCLPzxfhy0b8aX9arSpcax/3lZGm8V4bo48EWrrxXR3Ya6LVIB8Hub1xVZKOJBiv3ZgmqC9V
 o+WpJOvZBMpJg0fzxM5iBasiLG1ow1wpRXqKoa9Dik5FRcfINPvkWCwp99Y/A+WATMoF+SELjJk
 CzfBY/8XdX5FUeBec6b41uWO81w/hjLGMXiH+5uxnZ7BHTWjdTSvtPzzx5f6EpuCu58dI8XdJTr
 HNN8sZ7SzEXfQVa0skOA0afdEurQZf2mP1PQWKcin2Ow01k5/V7hG9YO+nYQuI3BDvNVUiD2nkn
 g6hjQl+86JpxQ9UxO2r0swZmS+FKj9Ro7jcorVmX3wjwJpcqRRz4vv1zBiNbUA2xeCX2nccl0Nx
 SicULBZQXRGQq5JVsg0I6/nX9qvsyQZDRPQ6aiYjM4M=
X-Received: by 2002:a17:903:b4b:b0:2e9:a090:dd69 with SMTP id
 d9443c01a7336-2f03f1c0a06mr186111615ad.39.1795623966403; 
 Wed, 25 Nov 2026 08:26:06 -0800 (PST)
Received: from [172.20.3.121] ([156.19.246.27])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2f03f0dbe86sm89106275ad.32.2026.11.25.08.26.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Nov 2026 08:26:06 -0800 (PST)
Message-ID: <ce7dcfb3-5c46-4f21-bf1a-53a61b5bf512@linaro.org>
Date: Wed, 25 Nov 2026 08:26:01 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL for-11.2 0/1] Block patches
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>, Fam Zheng <fam@euphon.net>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
References: <20261124211230.1944962-1-stefanha@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261124211230.1944962-1-stefanha@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 11/24/26 13:12, Stefan Hajnoczi wrote:
> The following changes since commit 6bf90d4fc5027567cb704d7888f5ec792b4ed75a:
> 
>    Merge tag 'pull-target-arm-20261124' ofhttps://gitlab.com/pm215/qemu into staging (2026-11-24 07:09:41 -0800)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/stefanha/qemu.git tags/block-pull-request
> 
> for you to fetch changes up to d8be4d3166ae991b28171fed3fd336632ba54d5e:
> 
>    fdmon-io_uring: avoid idle event loop being accounted as IO wait (2026-11-24 15:03:00 -0500)
> 
> ----------------------------------------------------------------
> Pull request
> 
> Thomas & Fiona's fix for io_uring IO wait accounting.

Applied, thanks.

r~

