Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6057EC48BC3
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 18:47:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcV8u-0003t9-Gi; Tue, 20 Feb 2024 13:47:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rcV8d-0003rF-WD
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 13:46:47 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rcV8b-0007tu-I6
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 13:46:42 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-33d6bd39470so551106f8f.3
 for <qemu-devel@nongnu.org>; Tue, 20 Feb 2024 10:46:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708454800; x=1709059600; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MxS5Rkt40gEag+RyKbBvovXaF0IJy+SO3EAGeQnCZ1c=;
 b=JWoDmfbBmof3L21CjMjDzl0d5yGu71n/sui7N1tHxi5fC5VyA8pieKVYejpkEle3kx
 40l03b0cL62boZDG8fam50aDjYgMpxjvei43mgl2RbCkgjjeROWdd2wzwjTSldcm6F4k
 bYakdJwHI8IDDRHFNbAIhbLCXvqgP3a+bDaIai4Zed/mz6jQl8CYlR2t0lAAzcoCmok4
 i5xgM2ACm7M0Ro7+wm2zPz7IA5XUp8phvrsjZm1ogdVPsMcNisSHI8Lh7aGI3OuIv11+
 mQVwaCyposmcQd5cHESs23BWSZpfSuOx5ViNS+TEyu7xY0sVfK7Gft5LKFZKnV5rc0rd
 2Zaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708454800; x=1709059600;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MxS5Rkt40gEag+RyKbBvovXaF0IJy+SO3EAGeQnCZ1c=;
 b=M0RJV0kJeShsweqPuKlC/G2VwfB6pkSIQP8VFge1h1K4ZC8NxdoP3gRisd3Bazag8V
 gk8WX06Uy1xCJm2u6rmERFKhzBFWaAjMoFE7xO3blLx8U8FGkmNFCDNeiqzlIIAyuyON
 WeX7vpob55xjNAvdFfzKMWF0tw+8GTmiZwLXdYV5SFHaa7jkiWcUvT2XzsRcnmBhHFgv
 I5/ZMecKYL/JHrFLGeGKBCiwr2FYylNWzgjp7QnmKOOKxyZvu0HULPELrU57E30xDwRz
 sAB27NUMSlEU1htUqF9w3EqS8U2m9vgMkt8mKRe8x+sr3TxjZaDsSAs/UFjuz1rk22lX
 GVwQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXxqEyeG+WxG2HNeEKrjD4DxBjMq2e4KLBxRWx9UxvlH4NYkqphT08W8hZ6YY079zW9CH1v6zI+IdhDI2e74muMc9lJ/eY=
X-Gm-Message-State: AOJu0YziDcuJoWHo5+HFLFZkG3Ueh8Y6AHS80zGfVrg7EpDC6GhbSNfp
 R6/nCWetRHn3Q3WCyTXS/+ByWAPQDqMEYAJ0PWLuK7oh4SuZOA1f3S3CyiVtm9E=
X-Google-Smtp-Source: AGHT+IHMVPGDNwARxY3wCyI5fG/bprOatCpYHb6jaQkEQsHds5kc13XgvsUlA4wLtuNOfB1ZfNKO3g==
X-Received: by 2002:adf:e291:0:b0:33d:6558:e5f8 with SMTP id
 v17-20020adfe291000000b0033d6558e5f8mr823273wri.16.1708454799895; 
 Tue, 20 Feb 2024 10:46:39 -0800 (PST)
Received: from [192.168.69.100] (mek33-h02-176-184-23-7.dsl.sta.abo.bbox.fr.
 [176.184.23.7]) by smtp.gmail.com with ESMTPSA id
 x11-20020adff64b000000b0033d157bb26esm14315643wrp.32.2024.02.20.10.46.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Feb 2024 10:46:39 -0800 (PST)
Message-ID: <3a4a6505-662a-448e-9196-f3be819b51a0@linaro.org>
Date: Tue, 20 Feb 2024 19:46:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] .gitlab-ci.d: Drop cross-win32-system job
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Thomas Huth <thuth@redhat.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Yonggang Luo <luoyonggang@gmail.com>
References: <20240220174412.155885-1-peter.maydell@linaro.org>
 <20240220174412.155885-3-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240220174412.155885-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 20/2/24 18:44, Peter Maydell wrote:
> We don't support 32-bit Windows any more, so we don't need to defend it
> with this CI job.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   .gitlab-ci.d/container-cross.yml              |   5 -
>   .gitlab-ci.d/crossbuilds.yml                  |  14 ---
>   .../dockerfiles/fedora-win32-cross.docker     | 111 ------------------
>   tests/lcitool/refresh                         |   5 -
>   4 files changed, 135 deletions(-)
>   delete mode 100644 tests/docker/dockerfiles/fedora-win32-cross.docker


> diff --git a/.gitlab-ci.d/crossbuilds.yml b/.gitlab-ci.d/crossbuilds.yml
> index d19d98cde05..987ba9694ba 100644
> --- a/.gitlab-ci.d/crossbuilds.yml
> +++ b/.gitlab-ci.d/crossbuilds.yml
> @@ -159,20 +159,6 @@ cross-mips64el-kvm-only:
>       IMAGE: debian-mips64el-cross
>       EXTRA_CONFIGURE_OPTS: --disable-tcg --target-list=mips64el-softmmu
>   
> -cross-win32-system:
> -  extends: .cross_system_build_job
> -  needs:
> -    job: win32-fedora-cross-container
> -  variables:
> -    IMAGE: fedora-win32-cross
> -    EXTRA_CONFIGURE_OPTS: --enable-fdt=internal
> -    CROSS_SKIP_TARGETS: alpha-softmmu avr-softmmu hppa-softmmu m68k-softmmu
> -                        microblazeel-softmmu mips64el-softmmu nios2-softmmu

Thomas, is it possible to add mips64el-softmmu to the cross-win64-system
job or is it already at the timeout limit?

> -  artifacts:
> -    when: on_success
> -    paths:
> -      - build/qemu-setup*.exe
> -
>   cross-win64-system:
>     extends: .cross_system_build_job
>     needs:

