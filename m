Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7933EC3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2024 11:55:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWx4L-0006we-0W; Thu, 25 Jul 2024 07:55:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sWx4G-0006tR-Cq
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 07:55:33 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sWx4D-0005gd-S4
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 07:55:32 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-427ffae0b91so8501815e9.0
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2024 04:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721908528; x=1722513328; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7cCESP5JeZ2kHt8lDaLGJAB8/MkMiOSoef+y4UUI4TQ=;
 b=PsYYD8KVLKhpRkhsU/prcJaw1S8gAlA8OQGwud2qsEVP3VUC9KTxG4+LnqRg7gJGOx
 O75BnURtaiQ/DEW5He2OOc9ScqiK4zkTkxkH+0KcI51EmvoVNWmcNQtoYUhAn67suhhF
 1fA3Uk4EzBHPZoifU+XRBTieoCJecnvy2qSgIDcneUNiM1ng8LOtjnOlIk3k9dmWEHmz
 DtEx9Bm7lHof0yEwD26akkueYYO7iHlOWPOjsonVwdmHIxP2R0floEw5wYav0N2eOLMU
 MiGI5A/an1LQSYFRRKrN16AO3RBUJXpq0zOqjmRXO3uPw+2zpbR0nK/3xtn7pxyr9Qtr
 rMtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721908528; x=1722513328;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7cCESP5JeZ2kHt8lDaLGJAB8/MkMiOSoef+y4UUI4TQ=;
 b=taaE+IhBlODwUlUg0FvN+bMLVnrf08qpKSnOv/6x4F6Zzt2sixhpOZR7Q24Q2t5cAL
 V+5ab5QUGybzkN+dpgQ5IxvPJzBvUvwSs2p84rGT1cTVpDOBCwcCpRux5p29yocRi1lW
 YdCdIQjvfWvDPeJVzwv1b/A5mM/HHxw6Wu4k8c5/nEX1o32R7OOnOdTLp0gHUcIQ9ZOO
 d03pMGt8uEhsZyVPXQo2ZAsA/fuvNXMyRcolzE1AlLL05dc8EdfCQbv3XzRssAj8kAGD
 MbczdGJFS9SkuLufDWUKz7O5uv84ngGNQ88CWc0ESXiwGZcNaJqes0p+QoV/6cJgSch8
 7UKg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWQk2eDIz8QjeSBeOWob6jK7WC0Ove7gqVLcC2gcyqmKmyHe/h1UsORaF28HSCInWL2YPsBQpgz2JuFYmsLkZjUUyCO2BM=
X-Gm-Message-State: AOJu0Yw/gvpKYvkoQ0Hm6bXvJXFWlIDagQZJplZzey2XRvgf4kl0cPVc
 q5ZchNW5c+nfvBma/d+v9k7jw7rwL3hmzv8w47lvcQN+K4Oc5QKJ3c8HfEO9wOc=
X-Google-Smtp-Source: AGHT+IELfbdRh2q4I8c0OyxQVxhtRSYMnqKBLFy5QQeQLFrde9jDrC1rfzUBn51UTAIgZr5EFf18Xw==
X-Received: by 2002:a05:600c:1392:b0:426:5f09:cf53 with SMTP id
 5b1f17b1804b1-42806b8f816mr17001825e9.15.1721908527890; 
 Thu, 25 Jul 2024 04:55:27 -0700 (PDT)
Received: from [192.168.1.102] ([176.187.216.35])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36b36857c39sm1948475f8f.79.2024.07.25.04.55.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Jul 2024 04:55:27 -0700 (PDT)
Message-ID: <21dcdff1-d720-4205-af98-0fbd6de6ad59@linaro.org>
Date: Thu, 25 Jul 2024 13:55:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 17/23] tests/functional: Convert most ppc avocado tests
 into standalone tests
To: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-ppc@nongnu.org, Fabiano Rosas <farosas@suse.de>
References: <20240724175248.1389201-1-thuth@redhat.com>
 <20240724175248.1389201-18-thuth@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240724175248.1389201-18-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 24/7/24 19:52, Thomas Huth wrote:
> Nothing thrilling in here, just straight forward conversions.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   MAINTAINERS                                   |  8 ++--
>   tests/functional/meson.build                  | 10 +++++
>   .../test_ppc64_powernv.py}                    | 45 +++++--------------
>   .../test_ppc64_pseries.py}                    | 45 +++++--------------
>   .../test_ppc_40p.py}                          | 37 ++++++---------
>   .../test_ppc_mpc8544ds.py}                    | 19 ++++----
>   .../test_ppc_virtex_ml507.py}                 | 19 ++++----
>   7 files changed, 71 insertions(+), 112 deletions(-)
>   rename tests/{avocado/ppc_powernv.py => functional/test_ppc64_powernv.py} (80%)
>   mode change 100644 => 100755
>   rename tests/{avocado/ppc_pseries.py => functional/test_ppc64_pseries.py} (83%)
>   mode change 100644 => 100755
>   rename tests/{avocado/ppc_prep_40p.py => functional/test_ppc_40p.py} (78%)
>   mode change 100644 => 100755
>   rename tests/{avocado/ppc_mpc8544ds.py => functional/test_ppc_mpc8544ds.py} (75%)
>   mode change 100644 => 100755
>   rename tests/{avocado/ppc_virtex_ml507.py => functional/test_ppc_virtex_ml507.py} (78%)
>   mode change 100644 => 100755

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


