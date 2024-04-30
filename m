Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F6D2C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 16:52:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1qfa-0003z4-8e; Tue, 30 Apr 2024 12:49:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s1qfY-0003qU-GY
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 12:49:28 -0400
Received: from mail-oo1-xc2b.google.com ([2607:f8b0:4864:20::c2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s1qfW-0005hy-P8
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 12:49:28 -0400
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-5aa241232faso4319525eaf.0
 for <qemu-devel@nongnu.org>; Tue, 30 Apr 2024 09:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714495765; x=1715100565; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ff0KPF3ZIkyPDZf1ILo/pDe8qY1FeD4uNmY1vpTgzhc=;
 b=n1dyNTC3Yd857KH/mQ2iXn8flIubzndphkUBCXVQv3HuGDvgeAOmq4ctodJGjCariW
 It8kvaImBnCp/VZf0RfzYdKEnX64LYElFNpuyCRem42aNqgq5Dag82Ci6ShTxGvoIa/8
 ff/x9fwRYJpmlMihVBY+1adTdlmYYPMzdAQEpsZ3gaBiBhaC0pPOinHTEzilS3afytTH
 3xsz/+dM/EVRojC1Q6D6MCCh2TmO0DFALumDkpjhYjVDPhdkG3yamhb4st2q0AWl6rCo
 LgunEghKMolRurEk+ySaD27CVRY5yVIbBOVNKcuk30ouIK3Uk3tOGz3oi4xGZ9VKAu6/
 jfyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714495765; x=1715100565;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ff0KPF3ZIkyPDZf1ILo/pDe8qY1FeD4uNmY1vpTgzhc=;
 b=OAJfSci6djuCr3/6oGIMUVSVoFCzKn7rkKMFJG9vQNqjMAZkTh83Y9y7akwJCKTTfy
 P64JDx+4FMpty88YB/aGHHh3+LGD6uOoFxUvrHGTvRb0Lpjj7Y311TNsJxvO80Gx5OpI
 hjjyikmDyDg0GBImezjzCDyIEJ1dLmcYfyWvxbJ2XEAFWonjSsCuTWhp+l03h1Gf0ZJD
 5IJ3HfIIldgT8sPrAlcidld5f9Ojd3Lc09QVKxti6L6qd32QCHK6/zJvFpvX90MfazKq
 nFVwn6ff43I71HQqKUmFnwDL7gt+9+cpuVK8d6R64Pd+3Hh6ZmHppeMzOGaeHpKwflEq
 0R8Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVNBCv6UZTn9PHNozxXBgwwzBBmOAR0+YL/wdJRaieMNdQjdGxvB4HkXNRfcsqy6Hm4SdNwp1bL55Xpuy5aCq/Ixz9zuzU=
X-Gm-Message-State: AOJu0YyJM+w+OHEdGFlKqkHgvA2BlH0YTqZCxs4PD86UmUS8UBblBFle
 MKXbowhPgnY8ea38jt6SGYVi2PTJKO639/AfWBFi/Cz9lct02RV3kM/2EeGQYRuyBRDFNnsKcE2
 s
X-Google-Smtp-Source: AGHT+IFtK2XmTDiCSmcAyBqkE/5Vs3yiLGIx6I/9fvmnYm1+JkXwr5m1845MovzcgI+7Etd5rY5l8Q==
X-Received: by 2002:a05:6358:e49d:b0:18d:8172:60b6 with SMTP id
 by29-20020a056358e49d00b0018d817260b6mr460573rwb.11.1714495765248; 
 Tue, 30 Apr 2024 09:49:25 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 f4-20020a656284000000b005c6617b52e6sm18789500pgv.5.2024.04.30.09.49.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Apr 2024 09:49:24 -0700 (PDT)
Message-ID: <5a530f2c-a210-412e-af81-1fbca90d1855@linaro.org>
Date: Tue, 30 Apr 2024 09:49:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL v2 00/17] loongarch-to-apply queue
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
References: <20240429023043.2607982-1-gaosong@loongson.cn>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240429023043.2607982-1-gaosong@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2b;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2b.google.com
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

On 4/28/24 19:30, Song Gao wrote:
> The following changes since commit fd87be1dada5672f877e03c2ca8504458292c479:
> 
>    Merge tag 'accel-20240426' ofhttps://github.com/philmd/qemu  into staging (2024-04-26 15:28:13 -0700)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/gaosong/qemu.git  tags/pull-loongarch-20240429
> 
> for you to fetch changes up to 841ef2c9df5317e32de590424b0c5c36fbb4de78:
> 
>    hw/loongarch: Add cells missing from rtc node (2024-04-29 10:25:56 +0800)
> 
> ----------------------------------------------------------------
> Add boot LoongArch elf kernel with FDT
> 
> v2: Fix 'make check-tcg' failed.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

