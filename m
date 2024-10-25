Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5222CD149E8
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2024 18:56:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4PTF-0003wo-Fz; Fri, 25 Oct 2024 14:55:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t4PTB-0003wV-51
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 14:55:34 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t4PT9-00014g-MO
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 14:55:32 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-20c7ee8fe6bso20251415ad.2
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2024 11:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729882529; x=1730487329; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Fl3b6yRD9p98kucSnsM1xhm7ri/i6hNZvgHMS+3fr78=;
 b=k2pQi4axicZ1q74Z1JaI2eWH7aUdhdcXyRyMYJMLooIZf30r78WCVFxzlpI9LUfqNz
 HvemIlZcm3GaQh8fZAdmUPRaAtwyXeB9M5XUsyCpXoaGAOrhdObc8V3P2hQpldcLCFm/
 1w1Uc2T1Twt5I5a9zhnu2qJs1vg4LT9j0IdvkuFKN2umOUITvQ+XI2tDcmEYeQf5yMYb
 a9NSTPZRAiFlOBKLe+Hmrn3mb8nW/JOGNS6QuyiheHmo9av6fd5o43I3ZXrjWg9OxKCO
 HGgFtfetCYXBgAulu/R2fLatyU+GjZQCtizKFiu8P2KvfZQJoSEK9zwLKjtW/V506bv4
 6Kwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729882529; x=1730487329;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Fl3b6yRD9p98kucSnsM1xhm7ri/i6hNZvgHMS+3fr78=;
 b=QF69GZCQHuAH5C2Jd758XuiNJM3soX+23XKXoFgmmsC7Oz3NPxG7ZnuP+LtaqlVy3q
 b7q6uBgGLoHRWrWD3HB1tOCCtYZgDQq250oqB3Hiuiw0wis3VIiYnp9ROlgLyNGPsoL+
 6zwz81fV5XsOVNZNYtmQl0CsdozLvXhLteoHscDmVu/HDodg8QhonqyStbMsTUFfb/9p
 jmY+ySk6Ag3M5oR528JjWPsg4oEDXbTqp2LnsqitmNnhYcuqtQ79ee6sWSWDSS3BurAi
 rRHEAyEb4KEurRokodc/zhheU5CsghfKgeVICStvyynpRT9096eI+LghKBdbdKvmzoWX
 uwlA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQdhJ2ZcgkErpaDadeoMThbbBWzkuftL//G1hTMakv4jd1OSMNpLBADl6seel+ZiKLi38pqNsItvm/@nongnu.org
X-Gm-Message-State: AOJu0Yw3fDMVbfw6CUUch0Mfg5k5dWfx7jwZXIwsDar4kToGcup0NWAM
 SQCDR0dzEQ4Uqd8ozJ+CP2DQqPe58FvjUSl43A9vu5GhCYl9/y7aqhIoyTE5x04=
X-Google-Smtp-Source: AGHT+IH1SwENpX8/+Ceg8MFO7XK3wFFZSd/o4QoAEBQLITfvW8vAseuwjEAZ6eZedfW0Sve2yZCX3w==
X-Received: by 2002:a17:902:cecd:b0:20c:a97d:cc7f with SMTP id
 d9443c01a7336-210c6c3ec78mr1675755ad.41.1729882529181; 
 Fri, 25 Oct 2024 11:55:29 -0700 (PDT)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-210bc012ed2sm12324865ad.146.2024.10.25.11.55.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Oct 2024 11:55:28 -0700 (PDT)
Message-ID: <8b1fc9e7-7387-4386-b759-9c15873a1bd1@linaro.org>
Date: Fri, 25 Oct 2024 11:55:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 23/23] ci: enable rust in the Debian and Ubuntu system
 build job
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: manos.pitsidianakis@linaro.org, zhao1.liu@intel.com,
 junjie.mao@hotmail.com, berrange@redhat.com
References: <20241025160209.194307-1-pbonzini@redhat.com>
 <20241025160209.194307-24-pbonzini@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241025160209.194307-24-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62f.google.com
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

On 10/25/24 09:02, Paolo Bonzini wrote:
> We have fixed all incompatibilities with older versions of rustc
> and bindgen.  Enable Rust on Debian to check that the minimum
> supported version of Rust is indeed 1.63.0, and 0.60.x for bindgen.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   .gitlab-ci.d/buildtest.yml | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
> index aba65ff833a..8deaf9627cb 100644
> --- a/.gitlab-ci.d/buildtest.yml
> +++ b/.gitlab-ci.d/buildtest.yml
> @@ -40,7 +40,7 @@ build-system-ubuntu:
>       job: amd64-ubuntu2204-container
>     variables:
>       IMAGE: ubuntu2204
> -    CONFIGURE_ARGS: --enable-docs
> +    CONFIGURE_ARGS: --enable-docs --enable-rust
>       TARGETS: alpha-softmmu microblazeel-softmmu mips64el-softmmu
>       MAKE_CHECK_ARGS: check-build
>   
> @@ -71,7 +71,7 @@ build-system-debian:
>       job: amd64-debian-container
>     variables:
>       IMAGE: debian
> -    CONFIGURE_ARGS: --with-coroutine=sigaltstack
> +    CONFIGURE_ARGS: --with-coroutine=sigaltstack --enable-rust
>       TARGETS: arm-softmmu i386-softmmu riscv64-softmmu sh4-softmmu
>         sparc-softmmu xtensa-softmmu
>       MAKE_CHECK_ARGS: check-build

Do you think it could be valuable to have a third job for Rust with:
- ubuntu2204 or debian with latest rustc/cargo/bindgen, so we may detect 
regressions when those are updated.

This way, we would test (2204 + min, debian + min, latest), which should 
ensure Rust code will build correctly on older and newer systems.

Pierrick

