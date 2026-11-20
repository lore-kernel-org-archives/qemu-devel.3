Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F03606A6AC
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 22:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=GGSQ7rKj
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUWpg-0006Uh-I5; Fri, 20 Nov 2026 17:11:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xUWpX-0006UQ-Fd
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 17:11:40 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xUWpU-0007Yb-1T
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 17:11:38 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2f066274caeso375085ad.2
 for <qemu-devel@nongnu.org>; Fri, 20 Nov 2026 14:11:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795212694; x=1795817494; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=6UqOlNC/neDAfDwK9fsePuRnVWTQGmKFwtU3u4tdrLQ=;
 b=GGSQ7rKjA3QqbrF390fL5IrYclqnDMR6LPtkOyn18aF2ykdvV1sOfPn+Vo5DbYXV0x
 bfy5Mr5TL6ShG58oSGgwxGUk1hMUbS82FKCFscCYm6gWJ14JhkYTNnU7qbWTIGIq07ot
 KiOg74OrjoLCdpjIsOaaFvTIen9oC9eAcrmD/3nckxiE3P8B5fn43Li6k6xPw9MjBVqq
 aQh7hWmEwSOqAgKOcHtfAPHN1kztd5gLsXoKBknSVQIMOfozsI6B4Y9YzkqHP+Sdtujf
 dp/qNFDOl+91uTAF2EX0jaMExiUoiwZjDqio326sfRq4whAgUWZdjmcf83yRJDLy2cIp
 Nu/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795212694; x=1795817494;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=6UqOlNC/neDAfDwK9fsePuRnVWTQGmKFwtU3u4tdrLQ=;
 b=hiTRtqjrZJuHpG3+Av/5yIDUS4Es/rw0k0hGMZ1YSEJwAatuzL1OnsXdC7n463zfGA
 XEbJHl1Kdh2lzTz9cuSsLV40mG+jgzH2NwNwvkKoZb2uv5w7kzZpvZUjmU+jzIdcQKt6
 /CHqoGRJgGF02w1GqgzRRzcEHg0YETBvBpGtC+ILO+1Li04WY1NCbpTMtw8j+dRxAWC4
 xqXdKZWxpKrliCRaPmL3isk2MnEaGCErNgWCGZIVzdpcKPT832oORUXACMueVBpAm/Eh
 VoOI+2jG1jEushn3XHA1ItUms/qi5wvttNF+MkmeMxTnIc0+EI9X5kcOkGBQWLAmD0XE
 t3hw==
X-Forwarded-Encrypted: i=1;
 AL+hErGpJWdIV8fneXCfkldOauxZRYL9blAxZKCQ3v9+gJmoL13CDavYb04iDcXpLZJI357JP3v0AzWP70ob@nongnu.org
X-Gm-Message-State: APuU4Z/2v9e4H3k+vBMqrNf3gag78hF25LOr6k9qJ3K1w5Luyqyy9EG+
 Mjs5LTVgLqxRfSds0YusiokS/kHnEoidnw0L8J6tavMsiNgz5DH+L8yAYR/8D0kXu+M=
X-Gm-Gg: AZFdTZf0KzRJO5cwVlbTnRB+HazB8dnVD59wd11Ck5pBXYz8YfgAzQeJE4DsAm6id9h
 t8r2nnk2CM7xk/1edhpOUU/9TRALwUdkgS6kVKYPSUP/hZwyaexbyKdSFknk38Y5Gy8/uIQ9QB4
 zuNi0AVG6Knza8I/cG4s6Pac28K8+wG/CoUSwKWMxzoLV6tyFnKwuRPE7YOyDqwvxo31dHy6ZG4
 zE2o6KAUCT7JbUZHMnkkHgwjQRWJjHSDJZqldQ7xo8emijfMzjIpKsueDWPwqasEB4wvyYPGFXN
 uAyzoCoowIzqvCYBvQG6EennEVwvN6gmy1oEGuTQgjheKZTq7WYa9hJbnSMoE7Z7KR/N4n0c+ZR
 cKREgdH899+55fGKi5kpiLMwUSNxRZYOvhEcClh1RKrdgNruop/Ew0alPBZtENE17KOlfhlAI9q
 8xmiStwoHOJI38WxUsTNtrrKoc7fJZnEsRTqBiJYwA43jh7oCAXD3CImgv+fUbtTbrK1+X5ZI0A
 aJJavUfyuqSwbG8P704R8kZTnLAH5T0MjdSDtekx5D+hedephPkQXVyRr22kawBr+DU8tNRxW59
 Y/elv+iD1XOQxVxakEiiB6Da2P1L4Hcm8D1VnFdwttqLgPhS0soenva0Zibu58v2UzuYb2Y=
X-Received: by 2002:a17:903:19e7:b0:2e9:5714:608b with SMTP id
 d9443c01a7336-2f03f1aff8emr46417955ad.34.1795212694386; 
 Fri, 20 Nov 2026 14:11:34 -0800 (PST)
Received: from [192.168.0.4] (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2f03f120769sm19331635ad.57.2026.11.20.14.11.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Nov 2026 14:11:34 -0800 (PST)
Message-ID: <19fc0fe0-f484-4e49-8e20-c7db2ba9ca26@linaro.org>
Date: Fri, 20 Nov 2026 14:11:32 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/8] hex queue
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org,
 peter.maydell@linaro.org
References: <20261120035353.3215703-1-brian.cain@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261120035353.3215703-1-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 11/19/26 19:53, Brian Cain wrote:
> The following changes since commit 08ed97c33c3818ef51a7c852347a28e9f66807b5:
> 
>    tests/tcg/i386: compile test-i386-blendv.c with -msse4.1 (2026-11-19 13:54:13 -0800)
> 
> are available in the Git repository at:
> 
>    https://github.com/qualcomm/qemu tags/pull-hex-20261119
> 
> for you to fetch changes up to 2bf4854e7924883223fccfa139dbc87427c7f758:
> 
>    linux-user: copy nanosleep's remaining time on EINTR (2026-11-19 19:50:03 -0800)
> 
> ----------------------------------------------------------------
> hexagon: HLX fixes, h2 git, gprel
> 
> * Fixes for HLX
> * nanosleep() fix (impacted musl)
> * h2: don't depend on git
> * noidef fix for gp-rel instructions

Applied, thanks.

r~

