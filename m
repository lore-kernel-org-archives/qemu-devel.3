Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBC23C3271E
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 16:35:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPltp-0002Bd-Lz; Fri, 05 Jul 2024 12:35:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sPlto-00028B-Fj
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 12:35:04 -0400
Received: from mail-lj1-x22a.google.com ([2a00:1450:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sPltm-0003JO-JV
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 12:35:04 -0400
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2ebe40673e8so24461761fa.3
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2024 09:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720197299; x=1720802099; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qVWSQG3CnDdkh7ckcl4qhpjIBkWTa9GUF45FvgsQbqY=;
 b=mv3sYLUUeseVqpoTzwIPoQ875m8phmzwwEIh97yJ02WOgLZmmnqDidzC2S+qQqnb0M
 hCMX9v+ftXdry4EWVt/dKPtHQBZZkKUUD4nUq64QU0siNm3kiO4nwp3/tAfyfDDWblXe
 IQX/Q7WdonmgtEzDUO8FT+dsQ/isFhVXER3y/ezulUBvBT1mM+hGuBNnXq58qsfEi6gD
 8sG55/aMQBvxORekgYVu6xS+5nA44pt70Fb571S3qBL3PGTXNzsvFvb4uBBud4imNyDE
 8G/5PncOQga5fvo+FzWHUaG2L9ch+bX0ZD9Nx2T3jwZVMOaR1PWfFuBg7knJIHiPXY+/
 tggA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720197299; x=1720802099;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qVWSQG3CnDdkh7ckcl4qhpjIBkWTa9GUF45FvgsQbqY=;
 b=eykdIbwIer8vGypkxRbshV8GYK0cnxHVaSddnB1whhtD9G7pbKduRod1hUVgpqafYu
 blhGH4ojJegX/Kab35YK7SWBtETSQfj714NmnA2j2CsdGyU0KH4mDcjPMzwqcgy1UI8Z
 FEgOQiKyx2TcVvJBHfHhRzRAhGz4pmDVg2qUOqcrND8xiOWj3kt20GDSNZeIcw92tJg7
 ZJQxcbzK2PaGHFqxSrMtATaTa4MHb/pa+WWTswyfjN9mxjnUF7bOJFwvWjylC0ZhPdy4
 b2C2VC5t3s1TvWqutmBlIGGMmZj7K+cJvtEBOCdkhm63MjXmREL7DSAzpNcg97HVP20o
 TIcg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX0XiAOvgK2CV6NcLddM6P29fc7cjjAVJlAfYGQIasmA7dU1JMGzt/arKRZ/kvhk4NUutDaPbuOJTTJdc4FLo3Wy/19Luc=
X-Gm-Message-State: AOJu0YxHmcTe0fSkhgdvFc0WTQJ92eUpOO2z2kpN/qSjamwdVAqgE9x5
 Wnz0gz5glWjLarQnce6we5LdmUj6vBp4NVNDfMcyxMiCl86wKnrsnwKVIyANRQo=
X-Google-Smtp-Source: AGHT+IHUAQOzxjkwADsbM89h2pY5ZVgjSGeHIYaqUtyyOARHfPnp7b9i1SuOz4qDshsT2fx/apQA/Q==
X-Received: by 2002:a2e:8e82:0:b0:2ec:617b:4757 with SMTP id
 38308e7fff4ca-2ee8ed8c869mr32639041fa.13.1720197299451; 
 Fri, 05 Jul 2024 09:34:59 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.163.129])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4264aa07a95sm66397295e9.1.2024.07.05.09.34.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Jul 2024 09:34:58 -0700 (PDT)
Message-ID: <07195265-2a54-4396-9724-2a63c98e45fb@linaro.org>
Date: Fri, 5 Jul 2024 18:34:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 20/40] gitlab: don't bother with KVM for TCI builds
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, David Hildenbrand <david@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Thomas Huth <thuth@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Aleksandar Rikalo <arikalo@gmail.com>, Mads Ynddal <mads@ynddal.dk>,
 Yanan Wang <wangyanan55@huawei.com>, Eduardo Habkost <eduardo@habkost.net>,
 Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paul Burton <paulburton@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>
References: <20240705084047.857176-1-alex.bennee@linaro.org>
 <20240705084047.857176-21-alex.bennee@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240705084047.857176-21-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22a;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22a.google.com
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

On 5/7/24 10:40, Alex Bennée wrote:
> In fact any other accelerator would be pointless as the point is to
> exercise the TCI accelerator anyway.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   .gitlab-ci.d/buildtest.yml   | 2 +-
>   .gitlab-ci.d/crossbuilds.yml | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
> index 425fc6479b..e3a0758bd9 100644
> --- a/.gitlab-ci.d/buildtest.yml
> +++ b/.gitlab-ci.d/buildtest.yml
> @@ -635,7 +635,7 @@ build-tci:
>       - TARGETS="aarch64 arm hppa m68k microblaze ppc64 s390x x86_64"
>       - mkdir build
>       - cd build
> -    - ../configure --enable-tcg-interpreter --disable-docs --disable-gtk --disable-vnc
> +    - ../configure --enable-tcg-interpreter --disable-kvm --disable-docs --disable-gtk --disable-vnc

Shouldn't we also disable the other accelerators for completeness?

>           --target-list="$(for tg in $TARGETS; do echo -n ${tg}'-softmmu '; done)"
>           || { cat config.log meson-logs/meson-log.txt && exit 1; }
>       - make -j"$JOBS"
> diff --git a/.gitlab-ci.d/crossbuilds.yml b/.gitlab-ci.d/crossbuilds.yml
> index 3de0341afe..cb499e4ee0 100644
> --- a/.gitlab-ci.d/crossbuilds.yml
> +++ b/.gitlab-ci.d/crossbuilds.yml
> @@ -68,7 +68,7 @@ cross-i686-tci:
>     variables:
>       IMAGE: debian-i686-cross
>       ACCEL: tcg-interpreter
> -    EXTRA_CONFIGURE_OPTS: --target-list=i386-softmmu,i386-linux-user,aarch64-softmmu,aarch64-linux-user,ppc-softmmu,ppc-linux-user --disable-plugins
> +    EXTRA_CONFIGURE_OPTS: --target-list=i386-softmmu,i386-linux-user,aarch64-softmmu,aarch64-linux-user,ppc-softmmu,ppc-linux-user --disable-plugins --disable-kvm
>       MAKE_CHECK_ARGS: check check-tcg
>   
>   cross-mipsel-system:


