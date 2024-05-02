Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B695C4345F
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2024 20:06:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2cgV-0000qF-GS; Thu, 02 May 2024 16:05:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s2cgU-0000pq-FR
 for qemu-devel@nongnu.org; Thu, 02 May 2024 16:05:38 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s2cgG-0008B2-Ri
 for qemu-devel@nongnu.org; Thu, 02 May 2024 16:05:38 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1e3ca546d40so72710755ad.3
 for <qemu-devel@nongnu.org>; Thu, 02 May 2024 13:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714680323; x=1715285123; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4LQnbNetM8k7K6dkSVCZq6Pz8ET4Z2YVTOu2jCEPVUQ=;
 b=ACmDC0QQNfqBcfCijfv7he77Xx6/CcRtP1n6F6xaclaGB8rE5YsXRJXADWQyW5jWx8
 r41AAkWCmHdpDAExDzOlnHZritYajem3xTrkidhk1Lfxr8qDmf3kRM318hubIKjI5zJy
 jiUf0IUynrQhJNFuOTOLEaJaReSnM+xAo+GsaJvMEmPnGEMXAAx+Vd8e9oBXVhbScgpd
 OptYED8SnITKGNGMfBWO0z+DMG2ua9eb14bMgrdCaKSR0OZnj1Yvrg6lUvXbsiIT9h4z
 7HLfYjOSpBCvY7rNu22/wUWD2SbolnJSWooRxRpH2tcGY7F9XMISOQ8fsTBec4cq5Q5s
 LsDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714680323; x=1715285123;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4LQnbNetM8k7K6dkSVCZq6Pz8ET4Z2YVTOu2jCEPVUQ=;
 b=qIbnhVszkoTx2YXMKtP1aYL1mscd+sX1hRWlNUclw1D+Q34r1NvGD22pgiIJy/7jxv
 bcAKhAAmvthkpmARS48jrEf0xdeDTMiVlYzScbHKHbPZ613CTUrEc1s1fQrwMJBinxVP
 cV4/UcjViKiNxR9lBDl3OpvbsjllOHyDVGpr0kxzoP1cH6rDkcausCsqp5PU1XeJ4p9D
 10iWp4zU9zHoPOxWYWoadPnbXKdFUfsXNAbWaDhwnaZjWFJNMzZB37gunv4AXz+WT4zn
 6n/M/I3kstt0JRFkajnF0Qyic24g6A1+KQYcdqym30h5xgf4wWIPuHDbikUWSSoAr1vN
 o8sQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVmNNwGIUzr6aORfEWnMcli+FhkRwZz8/aezn00kB/fUclmsDsiig0vLwiaN4KdlB7hAwa+MTHbjiR6aWM2jk7i6kGXZaU=
X-Gm-Message-State: AOJu0Yw18bjvnzjlJkubS26LRcXcnt4+iRQJR4zwD1GPdE/w8xQGiihB
 poaD5p5ys2NDsQsFz+25Xu95cnnUhOAutWIJ3lJOINP3DEkTctr9OAXSlOnHPlE=
X-Google-Smtp-Source: AGHT+IFmrVrxLjjkfti5gtrHJ4mqGqZNjBoeHvcbGTa/n0yKfphDXF72bxeTdgdA+eUCMUtRp/vSfw==
X-Received: by 2002:a17:903:32c9:b0:1e4:9ad5:7537 with SMTP id
 i9-20020a17090332c900b001e49ad57537mr866806plr.34.1714680323200; 
 Thu, 02 May 2024 13:05:23 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 kr12-20020a170903080c00b001e668c1060bsm1730111plb.122.2024.05.02.13.05.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 May 2024 13:05:22 -0700 (PDT)
Message-ID: <3ce937fb-afb9-4ea2-97ab-b8dc0952e9be@linaro.org>
Date: Thu, 2 May 2024 13:05:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Re-enable riscv64-debian-cross-container (debian riscv64
 is finally usable again!)
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20240502194046.830825-1-mjt@tls.msk.ru>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240502194046.830825-1-mjt@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 5/2/24 12:40, Michael Tokarev wrote:
> Revert "gitlab-ci: Disable the riscv64-debian-cross-container by default"
> This reverts commit f51f90c65ed7706c3c4f7a889ce3d6b7ab75ef6a.
> 
> Hopefully it wont be very unstable.
> 
> Since riscv64 is now a release architecture in debian, we can try switching
> to debian testing instead of debian sid.  Also, debian-ports part of the
> archive isn't needed anymore.

So... please update debian-riscv64-cross.docker.

> 
> Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
> ---
>   .gitlab-ci.d/container-cross.yml | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/.gitlab-ci.d/container-cross.yml b/.gitlab-ci.d/container-cross.yml
> index e3103940a0..dbffed3f21 100644
> --- a/.gitlab-ci.d/container-cross.yml
> +++ b/.gitlab-ci.d/container-cross.yml
> @@ -77,7 +77,6 @@ riscv64-debian-cross-container:
>     allow_failure: true
>     variables:
>       NAME: debian-riscv64-cross
> -    QEMU_JOB_OPTIONAL: 1

But you can't do this until the above is done.


r~

