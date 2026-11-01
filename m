Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E015B606A324
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Nov 2026 15:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=p0BiF9ST
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNXda-000714-1r; Sun, 01 Nov 2026 10:38:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xNXd2-00070N-8g
 for qemu-devel@nongnu.org; Sun, 01 Nov 2026 10:37:53 -0500
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xNXd0-0005Af-AD
 for qemu-devel@nongnu.org; Sun, 01 Nov 2026 10:37:51 -0500
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-3ad787e0593so996278a91.3
 for <qemu-devel@nongnu.org>; Sun, 01 Nov 2026 07:37:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793547468; x=1794152268; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=7vZdb0A/dkwplGJA/TleQXAaF70N63fy4YPzjVQ1hJo=;
 b=p0BiF9STQjSK4QSJtBHwLjboN+EQ8zA1etmNSeSJ/fhUqYfIljBNPkWFuJE1RGqru+
 YJUiV4olsGTEFOZ+Hpx7DvVRdzVyXHEVyqcY5oQKA6vpHRfjYzmFynxo15kKpDEreHV8
 LwnyWRxbImanMc7kzQFYRAxE70VWapl5afRdL01KdGr+zQUYoFaYhOE6BAc04gk1RJJi
 ET/Oz5crZWBRG2mYmpl1DNnsB3HjAcGvnRClg9NhiD7GTLELp6lZW8s63R2ws80OzocU
 3o9APLIsZ0Siq6d/9WJkHC5qVEyacZ+SpkjuoL+xMnrQzZciFOu7LXo1NZUwcmbOZ0YI
 i3Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793547468; x=1794152268;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7vZdb0A/dkwplGJA/TleQXAaF70N63fy4YPzjVQ1hJo=;
 b=MdYoi4WSbBEa/eG5BmIImUMYUjafh9//hUUhu0w6uDRakC4jDWl4CeRBg8q3KWXyVY
 DXFvnpytujCZuyfuqyUqq7tkPtLM/U4rgeU0lMrvgMqO27aDCv+AIlqZpQEjzmPo0EOG
 dgL904acFPdjE6ss2ryR+LgptWnmpSw0+TJyp8wP+zUxgw7jDm2PTbvA2GiP9HBiAkAd
 0eHJqLOpy/bqo0PP03yd+3xdLYtLbY307kHN2NTh+cAoqdd7Lwaf1T6YzZPZL1YQmI8c
 DzwX3roF9QrCqt6ZhtfUbayyPftX7QZlqs45Rzeq8a87TyBopHB443KNbleZZW0DRI7S
 uX7w==
X-Forwarded-Encrypted: i=1;
 AKwUvBw3eEhamuWXrPVBsj62vtp20i/+hB2h/H0dQh/REuZg2glzfNeRWyE8tyOYKrl3GJHk74PkdsNM1rZb@nongnu.org
X-Gm-Message-State: APuU4Z9YXEO5m/Idy2OLerLJ1vOipEwVCJLnnJnZUYyQMXarA8fFvYHe
 Fgv6iIA05bgO7GWOkMbHsdI/O1PysgTd6xKMkyulhJ/xCPKzOUcXbR4oTmPYel3mY3c=
X-Gm-Gg: AYBFou0jdn+BM3rR9WR+hVpydgmnBZrNWluPAz8GEJoKqdrmuqCbsxL5d9yhTR3vWHa
 HgTLEOTWGXUm4kwN2lyG5ojrDSGpzBzPM8Et6qvs0YQ6fJWUnD9OEOIFXma09wIiOmnh2gugj0m
 cZTt3Sz/dKe7Wf3hMBiLj/eQ2IEdk58iuNbdeJyylxnCDawuwOsnEWAcMAJ2Q76m4UIvKycrKSt
 FrSS5X//B/Xigmk6nEOK/aS4lSLPUkr0jKKHf+QUXDRPxnWSwAuRYwllfd5zJWL+CcGmJsLJoxj
 Bp9jRN8aNlKLOqbt7yFTLobfisR0cZhFqr6WoM+J50eGXDmtrl48soXSQZh57jEEy274t+5UVex
 HwLqBx0+7Qrof7D9muxdA48ZU0KbYmv5NW9ytU7/QqYNUMxWCPqJvghVXYgHxgPqCJcPE3/z3q4
 KSwFuOw4lcEKondoQfJLHb43THswv4rlL9QgQIKjgBV39+6SgTb8l6l15j2q5tqpT2NDLoPAl5P
 Fu+si8jW5tazW2ESckGF8jioaVeOuEUdHKv5vGZPT5FT1AiQ/E6j7swAGKHz8N6a3gxmpI/WK5h
 0io4rKZgr28ScNPyQkZCIPRAbk5TyAimsiurCu0uNAdgl0Flv1NCwAISuqNIH7bTDqmZYw==
X-Received: by 2002:a17:90a:d603:b0:3ad:53a7:62d5 with SMTP id
 98e67ed59e1d1-3ae89773480mr6116527a91.12.1793547468412; 
 Sun, 01 Nov 2026 07:37:48 -0800 (PST)
Received: from [192.168.0.4] (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cdb096b6618sm2254049a12.7.2026.11.01.07.37.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 01 Nov 2026 07:37:47 -0800 (PST)
Message-ID: <401b355f-4b09-474f-b3e1-a52a7f48f6e3@linaro.org>
Date: Sun, 1 Nov 2026 07:37:45 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL v3 00/10] Hppa 715 2 patches
To: Helge Deller <deller@gmx.de>, qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, "Kirill A . Korinsky"
 <kirill@korins.ky>, Keith Monahan <keith@techtravels.org>
References: <20261031082850.439293-1-deller@gmx.de>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261031082850.439293-1-deller@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102d.google.com
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

On 10/31/26 01:28, Helge Deller wrote:
> The following changes since commit 73294d096cc591e122fde9e63db4739de6d84f2b:
> 
>    Merge tag 'qga-pull-2026-10-28' ofhttps://github.com/kostyanf14/qemu into staging (2026-10-28 06:21:59 -0500)
> 
> are available in the Git repository at:
> 
>    https://github.com/hdeller/qemu-hppa.git tags/hppa-715-2-pull-request
> 
> for you to fetch changes up to 98c37479afc7acac3a155eb541d1c3fdb4c1255a:
> 
>    target/hppa: Map CPUs at same addresses as on physical machines (2026-10-29 19:14:55 +0100)
> 
> ----------------------------------------------------------------
> Hppa 715 2 patches
> 
> HPPA architecture patches for HP-UX 9 and 715 machine
> 
> A series of patches which allow to boot HP-UX 9.05 on the 715/64 machine.
> Includes a graphics/artist fix, adjustment to 15 bits for protection IDs on
> the 32-bit CPUs and various other parts which were missing up to now.
> Included is also the FPU patch from Kirill A. Korinsky and a new patch from
> Keith which fixes the 32-bit load of PSW on big-endian machines.
> 
> To fully support HP-UX 9.05 an additional NCR710 patch series will follow soon.

Applied, thanks.

r~

