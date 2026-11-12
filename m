Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5817606A321
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 20:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=qmA+LK0B
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRbYY-0005dP-Is; Thu, 12 Nov 2026 15:38:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xRbYX-0005VW-3U
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 15:38:01 -0500
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xRbYV-0001qE-60
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 15:38:00 -0500
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-8b2382bf051so139442b3a.3
 for <qemu-devel@nongnu.org>; Thu, 12 Nov 2026 12:37:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794515877; x=1795120677; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=/0sk+R6pGTSv6Z3gxos4cASq0Uytw3qkKp4HMmDme6I=;
 b=qmA+LK0BRG1AuM+rtqB32ZnO8lToaMqbPH4Wxnryf8OYf3orWokx65nbXD5ESUmSdQ
 u4Eft5V80iKhXM3TtPPPGR3/bIgBvKnAEdQSG0qG8y3LD4pmt77QGjIibjironxEZ9It
 kQ8/67xhvV7hStXl4DbV3tqAOlS6fcTDYpbz5DCgoYcutg2AqrPXBJ6ROyH3DkRkxCGi
 ieHHvKnr+eWHL2ucHYZrc9jSuA4Tx//mvACWo1NQdnuLvm4kCQyp7LhySuNk64FvTSqu
 +U5ezYjj37HxPyg7R0b2xQW3AFkSuE6rcrRHYR067o6Wt6vDOxe1OjPJVA4TFPCFZJ4F
 C45g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794515877; x=1795120677;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=/0sk+R6pGTSv6Z3gxos4cASq0Uytw3qkKp4HMmDme6I=;
 b=zuprt7Dv3eqjvdeR5wiFY6E5ojGGw3a96MzNFfTYSkyUKZJt7Kkh8ny/3wtvnrmJ1a
 qNss5ixiD8iR+bVQz/BnLuJ+zEfU6EHhzWY4Ff6fWBDOzV21JwNOQHI/C+g1v9L+J6K9
 SZ3E5ryx7pHOTC+mNusEjYd/58EZTxpwDqI8X9aA3tNaEnrEN6yi8HKaQsBSQMpxjp2V
 HXEkzPBtT9nj48Okm3n9cLxwtiWeeVa15yVO2Bofzrzj66vZVjFS/BOyEi1i9SEMl39e
 UJQagkzjfmsHQjWMSRz7TGOjO9phzNQr/LC462qFaWll+uq6MDdQ6PDhvdQybjSKEzIH
 lNZg==
X-Forwarded-Encrypted: i=1;
 AL+hErFY7JN4x+lU/MrL1WkIOlRxfbyyXc69uUaSi/7rNpVmljMk91/d+bg/umYOeCNGJEeRWUWdK0nUU8LJ@nongnu.org
X-Gm-Message-State: APuU4Z8d9ZWcbUwBJpWjNwTbTZe4idZ6qs+SPcdtkt+6cc3MwYQn8B5J
 4OP2zHzpKJmkDBZU0zq0YjHcAZkLRZamwAOhwXOSmKZVHgs8BFmU0aTZc9OObfTCfPw=
X-Gm-Gg: AYBFou1xMiTeTOxQkKiOVDEkQjhWBbEBntSqPcZ1VfynWfJsmFstdyCqeEin27wwams
 uyvBBWP9dxgK3rPMrWMWfrxf15uKlirmO4QJZsDDLV19tWUXilxHOzFE0qYYjXHH5ifq0zvy/XH
 SqEU6HpX/SkEhEUvVHUybf7sAzWmAr8jDR2RcMZ1K+raaXbDunmGojejnuMkUsR4nGPbczKedhr
 LH42N3GDJsg90VYyJlp9rJGqCSJiROUtZMJQrvIj8n4r+/29Dvm7H8ePRhEYYpeZ8TNU1B/WexQ
 7IxDEa6SLKB7a6pOWJYrnL1jHvtgWGQulajAOQi3ISObVkk/uFT6P2R5kAaAeiPKSWa996IEYFH
 cW0YyDvvccq2IefBLtNIUoN5mbnOlu0N6MLlKla3AbmRiU5rf0ZZWugyhmEA3ob2rzrlMV8KNLL
 /6WptIhlqOO+NR7JZS4mVS/GsQwcQWPi+nu/PKdZawQDgZyJ8ylrBBxgkZeF7C9QPdTmHiKdX06
 GBOVFc5J4EjP5VsLEOCDQjxjH7rwATx8SrwM/60NbaWDbagNdpEmMPN4xDv8f0Q+xHsiRCxX2R0
 cADT98QvXwxontyPHZWgEnX6NzoNKtzu90QUEyIKdWM=
X-Received: by 2002:a05:6a00:bc04:b0:878:3538:8f7d with SMTP id
 d2e1a72fcca58-8beb89cfad5mr599022b3a.43.1794515877366; 
 Thu, 12 Nov 2026 12:37:57 -0800 (PST)
Received: from [172.31.6.238] ([69.196.88.181])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8bed2829dcdsm115005b3a.48.2026.11.12.12.37.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Nov 2026 12:37:56 -0800 (PST)
Message-ID: <52c8c9c5-e580-4042-8ce5-5ba52b9f9c26@linaro.org>
Date: Thu, 12 Nov 2026 13:37:54 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/6] virtio-snd fixes
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-devel@nongnu.org
References: <20261111115559.18557-1-manos.pitsidianakis@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261111115559.18557-1-manos.pitsidianakis@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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

On 11/11/26 03:55, Manos Pitsidianakis wrote:
> The following changes since commit
> 29760efaf96bbe5928f8111881eddbf5ac06439e:
> 
>    Update version for v11.2.0-rc0 release (2026-11-10 14:47:54 -0800)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/epilys/qemu.git tags/virtio-snd-fixes-pr1
> 
> for you to fetch changes up to 9a0f03f81575168283e56dab51bc0f0a13894092:
> 
>    virtio-snd: period_bytes divides buffer_bytes (2026-11-11 13:46:50 +0200)

Applied, thanks.

r~

