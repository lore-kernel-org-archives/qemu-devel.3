Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F39D606D801
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 15:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=W39yz6Gx
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOzJr-0003UN-4n; Thu, 05 Nov 2026 10:24:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xOzJl-0003TL-8Z
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 10:23:58 -0500
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xOzJi-0000Yf-BM
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 10:23:56 -0500
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-8b271e573adso307693b3a.2
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 07:23:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793892232; x=1794497032; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Mcj2uVBctlGM4Q78LCis/HWW7PQmqr/jj9xsfQ1khEo=;
 b=W39yz6GxG7JKD9dz0xKA8RokkICfhhSSdqwC7Ytxcwguh8yqU89qo4JvWNRBQ+ZHly
 FTe3oSo8fpBPUQL6xjjC5Rsz8KLDoIPWBlT4zF+oNqjrHP8wttMKExvqSosftnrsSWPj
 l4KslYs1zZG0Inal0G6wuuUclkNP8aAFhJZLT0vBX1UG1AeCSuluBajeE81xwTIYRz4i
 RPATZqS4rh/ocN48n48Oj+6RpcLovA+5BW7hJFa4nKtMhWtMWeGz+m8FepZL0K3VAYGm
 pJsutVVvdFMcj54NXLXkFs1adVhiIh4MKb//0eb/iN96+jJXbwDJNlyee21yettzJ3iz
 kBHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793892232; x=1794497032;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Mcj2uVBctlGM4Q78LCis/HWW7PQmqr/jj9xsfQ1khEo=;
 b=nt7ssAoPTtMSC2jEqAnmANgVIAohudzxGkZtn1z+7jy1mKJ4HNQlMsaCSx34sUdxzo
 +7uDNC3EkHAVqOo+U3mF7nuCVId7VFIjaSios78Z2w+QNXHQEulz2zceZhYoTNrvtG2m
 fwBPIc7l2kwxPGdqU2vStgBujkzFwyh7xJ6RObFuS08ICVIP4EAsnAYFXD3KsAd3owkq
 nQ7a9zJutw30RhfWm55GvZxwRN9+Lgg9p6OD3pGkfsIvRymlBpMiWvLCB/NzdiRZqFU4
 DI7imIaPsU/MbbQrfxv7XBbg8TPXAAqAxJUF+DdcaUGMDUvTt51UC1hiyO/yowC17Vc5
 6y8Q==
X-Forwarded-Encrypted: i=1;
 AKwUvByFLPQ1lbqL/pBWnS/eMGgXoi5YdkFZ18sLJTUhn+IPsVa4CWNtgO8MqSscHitKNgv4Tjlj3csF/2pI@nongnu.org
X-Gm-Message-State: APuU4Z+qpfreBNEYyKjcBTWmZ7Wxxa5qBjbsTU5x6A3yg8v0PEIqnFuD
 gjoYVT0lwijuTe/tRlGx3g3ktbTjdoWx7f1NPv3y6eI8VWrVJNlSwdmnRtuR+lx0s7A=
X-Gm-Gg: AYBFou15DQ4wWNtLr3GDKEIfM99GvcWjOAULZnWao6ZtHP1MOlUN8TZ/aiBsHzzy2fo
 mInQjrWOFmr5KN2fX8yfqNr8j/IfSCDget0RdHH2Wtnl/e41fYfe8whopam6ezk4LX0NzXmXOMZ
 027p8QpSZGH3Alby7izDQKoRaZwxFfmI6s4qawX/Cbalp1YbpzZYHseOSaEl5qhY52QGVMskZAp
 +S7JVRtAe3oFNyaAc9rH+0RRgaXxZuNKyCsH7xS90yS+WX57ETE3Ji+w+H/wHwUPzxaooR4vOSV
 NRKjgZSRlbyBwF7YUYsobBD9jvOPFbgRZt9aAXTgVFxCXRcmgyjybgAyKcwgCpSqpts9ejCqLFu
 97DbBGVBiGiQnwsn6KrQt/WhoDKZ0NEhcqflzevchGIbPFxaqBQoPGbbluiXr7TmX3JAZvzGTgz
 egzQwBiIV1eDfZXDqCkQwIg8xeKKUJO0q45moY/MyEn1VRWkjtHrxC/J2wShYqUH2cXntzxfw90
 5s/nRkROsNGxGBGtnXm34TlHbanSxO7mFTM3rAHeTDOW9X0pgWgfflWjNxsSwzgMLScKxqIZe+5
 o47onj8K96zS380IWgrtihHBb9NYe92YvTgD0KX2GFUdquItNfiBfSV6L5GJjxCe208qXcM=
X-Received: by 2002:a05:6a00:4395:b0:89d:a947:9d58 with SMTP id
 d2e1a72fcca58-8a9beb64f99mr15120503b3a.25.1793892231504; 
 Thu, 05 Nov 2026 07:23:51 -0800 (PST)
Received: from [192.168.0.4] (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8b09b668748sm2115551b3a.43.2026.11.05.07.23.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Nov 2026 07:23:50 -0800 (PST)
Message-ID: <e521051e-146f-4992-a6b4-a75fe30b52be@linaro.org>
Date: Thu, 5 Nov 2026 07:23:48 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL v2 00/25] Tracing patches
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Gerd Hoffmann <kraxel@redhat.com>, xen-devel@lists.xenproject.org,
 qemu-ppc@nongnu.org, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Anthony PERARD <anthony@xenproject.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>,
 Alexey Kardashevskiy <aik@ozlabs.ru>, Helge Deller <deller@gmx.de>
References: <20261104201802.11556-1-stefanha@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261104201802.11556-1-stefanha@redhat.com>
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
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/4/26 12:17, Stefan Hajnoczi wrote:
> The following changes since commit f29ccc287a6cfdd51d3a4fd17fbe9af3310a0ac5:
> 
>    Merge tag 'pull-11.2-misc-fixes-031126-1' ofhttps://gitlab.com/stsquad/qemu into staging (2026-11-03 14:44:10 -0800)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/stefanha/qemu.git tags/tracing-pull-request
> 
> for you to fetch changes up to ddfa19c50616657cda4476260ce300c9463b09d3:
> 
>    trace: remove 'trace_event_get_state' wrapper (2026-11-04 13:19:12 -0500)
> 
> ----------------------------------------------------------------
> Pull request
> 
> v2:
> - Update "trace: include qemu_loglevel_mask(LOG_TRACE) in guard" so the Rust build succeeds [Daniel]

Applied, thanks.

r~

