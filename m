Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42A76C4345F
	for <qemu-devel@archiver.kernel.org>; Sun,  5 May 2024 00:40:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3PuV-0001Jb-PF; Sat, 04 May 2024 20:39:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s3PuU-0001JM-9Q
 for qemu-devel@nongnu.org; Sat, 04 May 2024 20:39:22 -0400
Received: from mail-oo1-xc34.google.com ([2607:f8b0:4864:20::c34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s3PuS-0004Bg-Jl
 for qemu-devel@nongnu.org; Sat, 04 May 2024 20:39:22 -0400
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-5aa362cc2ccso696761eaf.3
 for <qemu-devel@nongnu.org>; Sat, 04 May 2024 17:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714869558; x=1715474358; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RNMXCqRtwS6Ls77ayO6uQk8IbXmRFiEtaw7b9iYKI0g=;
 b=SlypAQORlCmo5yGPiOEeet2lFpllun9rWnAWcJ9MU9P4OREXNUWlJbWKBZFFUD267C
 lQ93A8ZsyBBnP9CxxPykcxFG2YJy8e+fU7RlUcIDD7RUWfJu/JE2stEGReewyWHCUcQa
 eBBHd8YixIvj/kEggjagOWvSM6eIAkrxWCvdSuNgMoc1exPAsuJpnMD4hp0URAsf1xjq
 2EwPdWDcgrc68mh4Por8NRIgoxUhx3n4t8bFV3B+opK/OMUmaYkR0fN7uYNRQt4CwPOs
 JXRBGBNGAo/VH5SJ+mzhcDuCtLDLxAVNmUCfF71mFqZU4vxgCDDj5UVaydWrm+O/VKTj
 9D/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714869558; x=1715474358;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RNMXCqRtwS6Ls77ayO6uQk8IbXmRFiEtaw7b9iYKI0g=;
 b=KR0lWK/gbstQmg+HNa486fttBJlpydY9OXdiDuCSHPlNwHCm7OghjgqXUMAu9HoEM7
 7L9ArT63TQwfzAmfZGRWlYGSlDRgXSGMpGpqRPpMzSIgQWXVax7CnqP3lnDJBCmcYWac
 9jwEgKleAGoFB9F8nXrYoTRlrxIkaD/OHTbRK/K8ESDa5j4VUoRvfmk02J2MxSGht++A
 mmaA+9tPV/0r7/LccfBlBxD5ViD2siX89IUo6y9+B7WmzQwlKAa8vVyGkfcVdsx3gA5p
 4NwvEBDk4FwwYdP5aJgoLxcH1iKW7cHT9TylYyujF49YkZjRYfeZAIx6rEcJYXstbHTS
 ExlQ==
X-Gm-Message-State: AOJu0YxiAd707xUJjx2/oLI4BFkZZTxmkbpdznqEfcmZJIPgOsX+GlVz
 XMUTGMr8LwkfBGpdwDfYOqLO4NF8+kU1poJv95nOqrnqCtaIkbIiM+PZ3aIdh76TPl2ZNWwty3c
 X
X-Google-Smtp-Source: AGHT+IE5OonZpDykYE79uwV3q2u+oSRtegpc8WjOyhuef8SYJZ8JQsmvfABQTo61gr4cT7IebAormg==
X-Received: by 2002:a05:6359:4582:b0:18d:715e:1e17 with SMTP id
 no2-20020a056359458200b0018d715e1e17mr7551899rwb.2.1714869558138; 
 Sat, 04 May 2024 17:39:18 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 l9-20020a17090add8900b002b269962606sm5495608pjv.30.2024.05.04.17.39.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 04 May 2024 17:39:17 -0700 (PDT)
Message-ID: <ab8c4ba2-60d4-4d5e-a473-bf34c9972ade@linaro.org>
Date: Sat, 4 May 2024 17:39:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/9] target/alpha: Implement CF_PCREL
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
References: <20240504153926.357845-1-richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20240504153926.357845-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c34;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc34.google.com
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

On 5/4/24 08:39, Richard Henderson wrote:
> The following changes since commit 97c872276d147c882296f5da245bd8432f1582f6:
> 
>    Merge tag 'accel-sh4-ui-20240503' ofhttps://github.com/philmd/qemu  into staging (2024-05-03 14:42:50 -0700)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/rth7680/qemu.git  tags/pull-axp-20240504
> 
> for you to fetch changes up to 23bb086350c0de390f77dd034d775742314cabd7:
> 
>    target/alpha: Implement CF_PCREL (2024-05-04 08:05:51 -0700)
> 
> ----------------------------------------------------------------
> target/alpha: Implement CF_PCREL

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/9.1 as appropriate.


r~


