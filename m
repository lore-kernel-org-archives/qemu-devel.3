Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4D2AC4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 14:10:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1Rhr-0005SD-Hz; Mon, 29 Apr 2024 10:10:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1Rhp-0005Ro-Ti
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 10:10:09 -0400
Received: from mail-lj1-x229.google.com ([2a00:1450:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1Rho-0006zH-Bj
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 10:10:09 -0400
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2dd041acff1so51734991fa.1
 for <qemu-devel@nongnu.org>; Mon, 29 Apr 2024 07:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714399806; x=1715004606; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cIbV/iZyNG2zOjtFz2bOGDKWhz/zXGorU13vwUNvoj8=;
 b=k+zcdabpIWZPvy9fEd5zAauXARmR49wO+vb1zGGZPX7BIOZtfalK8wyP0kd5vaoOxI
 6V2yS/Evy0QnxvfFbNfz4JXgLmbCgW+gjXYWx6OJxm4aUTpE8CpWwvj8lYOp1DEghjIT
 CD6HAF0YPnEM9bR/j3izZYksFx7ub9h2h5EBo4WyFB38r/7iGgatFyg7IBEpPaglNLxN
 lOqmWnz17j8K/YU7+TdFSurEyxIFPtXC6lRghJr2au0haKY4EGKrlSId1wbUDGlNWy7W
 Xq2ntZHv+tHDEVbVlVlzGZsIwWlZm0ff35Yv4ubEkQC0J91XWh0+jCVBsr5kbvss/Ge2
 PPmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714399806; x=1715004606;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cIbV/iZyNG2zOjtFz2bOGDKWhz/zXGorU13vwUNvoj8=;
 b=PgutDAy7HSkWzkpfvAb8XBgy8+2FmOuLlf/lGmfaaGjUxDEpP96o+5lWB177DlmuIf
 RQtO28PPmES54k89heNOJ+wmTEUUh05kzyy7qn6ah2IJeTDO6yZnj5oryAXC2Z47f5bv
 W4HpEjnO0ilTHJK8vETSV1b7o3y0pqIbmnpVx1ZEOscvLFSkJ0aAXPgLvwKXJa/Z6oxE
 oRX3vdUoKEVe7apqoQglhF/92I2I8FMmVKvnvvhMB6aNiT+NeZSo8xLwqTCynDh3R33k
 q4CmA5hIeWMFho+QUr9RvXjXcvsciajHImP19lrJHrKHYPMyuCeo1O3a9KlZxK9g258W
 s+jQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUeglFSOAFuaqEoV4s2b7581iSVG9s/9/90oQ1TJR0ccaewG5O9juCz/bDDgY0nXE9Qz+KNBSQdXxi2p0PpVRhE9Xgn4mQ=
X-Gm-Message-State: AOJu0YzmTj4JqEaB0pe0MRjgezkCnc8YeTmCx5mptmPfttWRgUIE1LfC
 hVNoxvY1DTklevhaumf9xTiszSeH+/+8wYWJn0Ps0E5w30bOSvYDjtHbJPBJq+k=
X-Google-Smtp-Source: AGHT+IGmmDI9H7nMmOulpIUtpIY16kGFg2E3oL4iEsu0u/nRNJ/7kAb2AFeciZTZ4DyjMtCPLtSdig==
X-Received: by 2002:a2e:9003:0:b0:2df:c2b:8c84 with SMTP id
 h3-20020a2e9003000000b002df0c2b8c84mr6799244ljg.1.1714399806379; 
 Mon, 29 Apr 2024 07:10:06 -0700 (PDT)
Received: from [192.168.69.100] (bny92-h02-176-184-44-142.dsl.sta.abo.bbox.fr.
 [176.184.44.142]) by smtp.gmail.com with ESMTPSA id
 s8-20020a05600c45c800b0041be9cb540esm8511185wmo.18.2024.04.29.07.10.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Apr 2024 07:10:05 -0700 (PDT)
Message-ID: <de42d3e8-8ca2-45e2-b1f4-0a4b38af5725@linaro.org>
Date: Mon, 29 Apr 2024 16:10:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] target/alpha: Hoist branch shift to initial decode
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20240424234436.995410-1-richard.henderson@linaro.org>
 <20240424234436.995410-3-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240424234436.995410-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::229;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x229.google.com
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

On 25/4/24 01:44, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/alpha/translate.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


