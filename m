Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47D25CD128A
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Apr 2024 17:52:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rs4m3-0003p4-O6; Wed, 03 Apr 2024 13:51:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rs4lp-0003nD-HC
 for qemu-devel@nongnu.org; Wed, 03 Apr 2024 13:51:33 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rs4lY-0000Ys-1S
 for qemu-devel@nongnu.org; Wed, 03 Apr 2024 13:51:30 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-6e7425a6714so61364b3a.0
 for <qemu-devel@nongnu.org>; Wed, 03 Apr 2024 10:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712166674; x=1712771474; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GewciuI2qGMoPtqx6ahsOAUe7kjes3R+WTIfpK7Qu20=;
 b=Xt+fIgDezUrEw68/lkVsJX4r2QzWD9KV85V8U8GE8fWuxqhFzR/MMGzYgkpBP0+4hw
 KpYhhDrZaFpc8sBZ32Kdrtmi9howINuUM2XTVAUTPLmzuWRBzssO5Kt3BTwbJkeavBPD
 +vkSsU4CJzUQoZWoQmDvKovAriqvs5OeHMsji13VqbQ9KJrPn95Lho364y/OanHJQWl+
 Ypj6V9IWAoG8qCWMD5uy/Zfa4I6dsuGR0L5YAYVxbN0HTo+Ek3vzJh/2REgyZFd8I7aU
 0uvP/mp+Rp3/2i1bsNfsYxrA0eeswoCUwG/QJggP8dHoP8IKt1xCiQIfP9l3wLYlVL42
 rlsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712166674; x=1712771474;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GewciuI2qGMoPtqx6ahsOAUe7kjes3R+WTIfpK7Qu20=;
 b=tJIt5K+6Ogm+xO4J/bV1ZC4fSxnyU9BAQpHfdyemmgVIDDkwR/vefOHjVEc75Z3Zal
 0QR1X+Mqg47siOxECsf58chos/U/BaSPpL5Zy/KbBsmDiAl9V0upLnGrtt9S12nR9vr5
 oeHEnRvIk5lHUDiRHk8oiLo93y5i07YILQfANq+lQ1pPe7k+axzGnCMoywMdMy+SKxpj
 FJDbRSNGfoLKmrzLx/FqSUe8c+Xbx/Xh8w9dtVQmwVXhKrcM3uulKp611uKUYeMa5rN6
 ZPQBdYuBrwMSa7vEYi/AACf2koSPOmZO77kcvoJNQ2eiZdOEfA6iOr96b5tEHzAtl6r/
 yw8Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUY4siAGNmh0MORw5r3zqOoUWjTELd0W7+dEjatyNddg/vCz7M7IbggxaF4BDkQbrxbJeIr1FcW7xJGcwwdrS8mq7jrNaQ=
X-Gm-Message-State: AOJu0YxrSfuWx0v00NiV6g1HH8omfBMGc/1fZesYP5KKU/Sdl0sWh+Yj
 iL3TaS9hGrIJoQQn2yMBhb338w929YA0w5R50jaFv6ZOeFDYFWNJ2JJqSudAR+E=
X-Google-Smtp-Source: AGHT+IF0uFzAXM0LWrbR4Ubej/lr3inal92qB7T+QW5yEdqIohLDxoNI0wRQ/zkVjzpR+ky73v116Q==
X-Received: by 2002:a05:6a20:244a:b0:1a7:e98:96e0 with SMTP id
 t10-20020a056a20244a00b001a70e9896e0mr504824pzc.5.1712166674348; 
 Wed, 03 Apr 2024 10:51:14 -0700 (PDT)
Received: from [172.20.1.19] (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 y13-20020a62b50d000000b006e6c6a50e5esm11999296pfe.34.2024.04.03.10.51.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Apr 2024 10:51:13 -0700 (PDT)
Message-ID: <fcb2c7c3-efc7-4700-9b9a-9151e0aa00ab@linaro.org>
Date: Wed, 3 Apr 2024 07:51:10 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] e1000: Convert debug macros into tracepoints.
To: Don Porter <porter@cs.unc.edu>, qemu-devel@nongnu.org
Cc: jasonwang@redhat.com, Austin Clements <aclements@csail.mit.edu>,
 Geoffrey Thomas <geofft@ldpreload.com>
References: <7e66f00d-cc69-458d-be56-266689757f68@linaro.org>
 <20240403134546.1361812-1-porter@cs.unc.edu>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240403134546.1361812-1-porter@cs.unc.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 4/3/24 03:45, Don Porter wrote:
> From: Austin Clements<aclements@csail.mit.edu>
> 
> The E1000 debug messages are very useful for developing drivers.
> Make these available to users without recompiling QEMU.
> 
> Signed-off-by: Austin Clements<aclements@csail.mit.edu>
> [geofft@ldpreload.com: Rebased on top of 2.9.0]
> Signed-off-by: Geoffrey Thomas<geofft@ldpreload.com>
> Signed-off-by: Don Porter<porter@cs.unc.edu>
> ---
>   hw/net/e1000.c      | 90 +++++++++++++++------------------------------
>   hw/net/trace-events | 25 ++++++++++++-
>   2 files changed, 54 insertions(+), 61 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

