Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7471BF513E1
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 22:17:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyGzo-0000YY-0R; Thu, 05 Mar 2026 17:16:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vyGzi-0000XA-1l
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 17:16:36 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vyGzg-0003Q4-JL
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 17:16:33 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-439aeed8a5bso5624721f8f.3
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2026 14:16:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772748989; x=1773353789; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ebZOB/cgjse70HqkBuSh7UhPJC61LIbOScMXnZGf/78=;
 b=bN7JXtqsE+siV0pCKzGuFSzUjBysAJ+OQXkCbvEQxYqD50SGS8siMIhkBgoj6gBmbA
 mG4skZWmRQZxV9LBDXKtzfDZRYmlS/rVvBSFwWfkwbUlY37J7UApm2j9nv6i2+O9tbZq
 OnWhZa8eCUoY8Vv0d5NxiCVHoE5d+bh2DZQmtzl+z5Oa/4CIVrZkWFP4VpH9oMWSHl6P
 aYs0lxXFQWhGJFFUtz333VoE1oevHd3iV2fJxNOVztLgzY3Fc0KGun4gV3ghqfEy5mUM
 9dd/ugLedpgQ34Ar9v8hF2dxrleLXRLsnyknlP4x2Z1tmFkdDrwKM1/iz6mH7r4WzLwi
 eeuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772748989; x=1773353789;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ebZOB/cgjse70HqkBuSh7UhPJC61LIbOScMXnZGf/78=;
 b=W1NkOlNcdBD9dsnLboDZOAr1TMzoOE3xHXjkZE9TqdggxqZM4XU5FQj3thGEw044tL
 JT3KX/n8YX5IlEBjplQRFPKl4PltUKwAKTjC3L7uP+zo4YJIwdLtI3g8e4/b6gzP4lh9
 o5PohAkLIKFfnJdEKr9J8T0NV+UEG68kzrN1116imnPP1tMOxourhv43zdCd/asCF9JU
 4T/ISbzmxuBOlfzQcib3vPvGexXRbcJf0Bj1s/HFwOBjRS/k6+njQ7Inu9zAd1aVhDZE
 uLrBBmFMZdSlKJLBYcIU1J0+9ZbGwJ6hSNiG0XeaKSydSUIPI6xwDL66IYDtioEsKrMf
 Oa/Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVz016cRM9yKy6g+T8lZ6g2a71FGq8F2xgr4r6TvF+BpjiiB4Meq+ZUKh/sHpzkQc+h9RLSic8xJPso@nongnu.org
X-Gm-Message-State: AOJu0Yy8FwQeVBhQuqDQ1veAL0LdRMJdS2iYe0sKnuGnXE1y5HSJ/JzS
 OWBKk9DdPYGlln5dW+rWqCXbMlOgrhiay57p5/lPz7b68cMaLoiQF4yQlzzFR91TTKbn1TlsaQE
 FXfDUPdY=
X-Gm-Gg: ATEYQzwxoKU0MaOrz5zvJvF3/s+JAu9bF36ee+zDBPP6/u4M3oF24E75q0rqlArV9+u
 g6xgCCHty05RO9y8xGLpWanV+2C2nU1n2Ot8jiSF4NgryZJIQpw9CtTO2Dj4213QxHYCl5pZj89
 lGF6zD6M1ZKNc78UA+MJeHStG0O+h3nu5RYZaLSETTBIUWsvrM4QUBhcQgXaQrezX/9VhKR9b/z
 LI6366G6AqA2rIdEsaxpMGqdk9c+clS9pMWLKX3uzYjZz786UgBWkBPSHrv0rGRomHdTPxUkXty
 UzttSia6rSQ4D63LJkL1dJS9SAERvvbxSztaUoBT1p/7SfsRpaA8YoDgiXLGlT3E9U1Qm0tL6Ll
 sKI8WWNBbzjB38ceR6mTK0cFfHecomryGvwEUJvN6VK3zehn5AR9AYreq6M3gslaFHWsj+cvZ9Q
 +aXIatv/imQjX1f9T8pkKb2h0YsOrqF0GLIv08R85XD4K8CgKBJmd85lIYNuJeoUofUw==
X-Received: by 2002:a5d:5f50:0:b0:439:c157:2577 with SMTP id
 ffacd0b85a97d-439d7247e84mr2620092f8f.34.1772748989115; 
 Thu, 05 Mar 2026 14:16:29 -0800 (PST)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439abdf5430sm42495137f8f.5.2026.03.05.14.16.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Mar 2026 14:16:28 -0800 (PST)
Message-ID: <e864dcac-2b91-45a2-937b-8762620937ba@linaro.org>
Date: Thu, 5 Mar 2026 23:16:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/14] util/fifo8: Make all read-only methods
 const-correct
Content-Language: en-US
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>, Troy Lee
 <leetroy@gmail.com>, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Steven Lee <steven_lee@aspeedtech.com>, Jamin Lin
 <jamin_lin@aspeedtech.com>, qemu-arm@nongnu.org, Helge Deller <deller@gmx.de>
References: <20260305220911.131508-1-shentey@gmail.com>
 <20260305220911.131508-5-shentey@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260305220911.131508-5-shentey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

On 5/3/26 23:09, Bernhard Beschow wrote:
> Allows these methods to be used in const contexts, i.e. where the parent
> of the fifo itself is const. This is in particular useful for Rust code.
> 
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   include/qemu/fifo8.h | 10 +++++-----
>   util/fifo8.c         | 10 +++++-----
>   2 files changed, 10 insertions(+), 10 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

