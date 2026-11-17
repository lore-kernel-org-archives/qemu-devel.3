Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D0E606A31C
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 01:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=WnL3P8zi
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT8TB-0004vX-Uz; Mon, 16 Nov 2026 20:58:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xT8TB-0004vP-17
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 20:58:49 -0500
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xT8T9-0001AP-C6
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 20:58:48 -0500
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-3b3a9a4a765so360248a91.0
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 17:58:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794880726; x=1795485526; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=fgdlV9YKjHqRJFBSKSXdmr/4dt9gfmPr/3jlO9pGvaQ=;
 b=WnL3P8ziLUf1yC3Rnx84ZHe4PubAqL2mtI/lGk69ElnV8g5sqjD0wNX0hO2fk/va7A
 L/k8E0oMd6WTlAvAtrqu0y/SCpFVmnYDoTyAlSqkeZpBJgGebg7tYmZ5NtujKFuOqCX9
 pbl1R+ZAMQVB2WiXh02dV9CLKm8q4NWN2vsFE8Q+u5F4BAt1QG2L250iKWxx29t4xOw6
 h4ksqbizdTWDOSDaqoMJ4mT2CJsteXQ4ETJAj5gztOQ3q8mluSGeuKMBACNFQs8o6LZE
 7etAMqugK/6st+NmO+LB1gd0dw90rqNTuvu0WWhOmFuu0of8kD46BTccS3zclyzYZpQl
 007g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794880726; x=1795485526;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=fgdlV9YKjHqRJFBSKSXdmr/4dt9gfmPr/3jlO9pGvaQ=;
 b=jV0zr+avxQmBmECA6HqLRMP8QBSKBKHha/PYQ5EzU2K/OO7CH6MJb/49eokp6DJEIc
 C1VYi1+a2sXTutRYF3tlULBNNIkf7Icwpkgc0i2KZ4/ej6FUM4wGGj9bTub7JgjFM+9/
 Glcqdg6nTjoi4srEl7dzdaz4Sx8vOYnwo+39xVebU4xReHx4dVrLqXismIK7SfoEEh/F
 2/ULJIgEkrnVXGMBWEiN2HKuZ1DeYBjZDJaA8o39/cfpgN4A7sjW3VkORelRa1BkUAGx
 1khdLpAo4VVdSN1VFtvKbjaDAvok3i/e1OS0xmTBtDg2gG27IJAsU/mr+GTGN4zqnDZ4
 KxOA==
X-Forwarded-Encrypted: i=1;
 AL+hErFFi5Nti2dlXz1lA8QfHMysG8PkKUWp5pTr4UPUM82/2eG/sQOYvNkjmyU9tfbtgCQ8NuiUUL1YdA2o@nongnu.org
X-Gm-Message-State: APuU4Z9JsgLnv/Xfn0vtDlyS0oi/qou6b4mBZzzECyqgkB0lah37uEES
 y4gUKNhNVW3ZI6d1L3wmLACTvjwGvQmwMEFnJnVk3ieKIFw8F9x0QEmOVY+TL7orbuw=
X-Gm-Gg: AZFdTZdvt+4XUEbAj2B/J1xAE2eA37ttD++wKDpG+y0eii2ICu82fSRk1/ebBhJ14q0
 E8dbtO2m/urH+jZcvbcO4k//3BjdhsxsRIruEdUT4Xwj3vKqFCG5Dq6wrWHltLUsKP9i2fPY7Xa
 dsX9DJn+Td8V7QJB5Fh/MsCfB9VabjCr5VoMTGG3L6B47NM7Xxo9+HVt3tc9OKrVd+aSnJobIKt
 IVygRhDmVCNZtm51AEj22gbGZtZ4ayyfOg/f0PSt2qzlwO5vqiHi4lkskB0yJNQzIEaiwLsLdLV
 MnsEdIdNEmkWmdvtFr5gZnf6yGud/6qtQdhYco6sphpoJJsUemxF2v8wrRJFQAJODNb4CzOKXiF
 XkqMRhCp/+XNgxNLvgqWnbZbz4Wt3bgt+kZ5acRAjLEy+RqAVlgKdn5cMt6JYN9BH23EzV+irzE
 IfzF/VUOMQhqqouJmn/XC4UsmY83GDSZHrnYUaeyyJypDs8DdXSMzbuYJDztWISOL+0Z6hUF9J0
 YVNI0xbvo5a6mvjoan1dxqGsqy6HFTulhGPXTtGEudVphzjNTdpG+9XAVXkRC7IYfjTDKEP8jdB
 MYagvY7GWesaq9kkWyqMskVJh6gGgZ377aRHq4D8JQexRMo3ENDN98tEfqiwzzpyG7a61SE=
X-Received: by 2002:a17:90a:c88b:b0:3ac:3588:b548 with SMTP id
 98e67ed59e1d1-3b1b09e69c6mr12731814a91.13.1794880725543; 
 Mon, 16 Nov 2026 17:58:45 -0800 (PST)
Received: from [192.168.0.4] (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b3abb786ecsm1478776a91.2.2026.11.16.17.58.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Nov 2026 17:58:45 -0800 (PST)
Message-ID: <35a15138-f1bc-4b2c-899f-745fc154be11@linaro.org>
Date: Mon, 16 Nov 2026 17:58:43 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/26] Device security tagging
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
References: <20261116222158.2840471-1-berrange@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261116222158.2840471-1-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1029.google.com
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

On 11/16/26 14:21, Daniel P. Berrangé wrote:
> The following changes since commit e9fa1f66f0d47c74b6766e1b8b87ad7c2a9394d5:
> 
>    Merge tag 'pull-nbd-2026-11-10-v2' ofhttps://gitlab.com/ebblake/qemu into staging (2026-11-13 08:44:16 -0700)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/berrange/qemu tags/docs-security-devices-pull-request
> 
> for you to fetch changes up to 277f11f3e474d03cdff03e541db5a2d731ccb439:
> 
>    hw/i386: mark vmmouse / vmport as secure (2026-11-16 18:08:38 +0000)
> 
> ----------------------------------------------------------------
> * Mark user creatable devices as secure where they are
>    intended for the virtualization use case and are
>    expected to provide security boundary

Applied, thanks.

r~

