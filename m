Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77B64C27C5E
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2024 09:10:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGxVV-0005xs-HZ; Tue, 11 Jun 2024 05:09:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sGxVT-0005xH-AH
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 05:09:31 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sGxVR-0003dv-Ix
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 05:09:30 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a6266ffdba8so431092366b.1
 for <qemu-devel@nongnu.org>; Tue, 11 Jun 2024 02:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718096968; x=1718701768; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=I0tT55ivXV8dsYJgVDGsT3EHHBSvAqjD9bvaV9Fh9K4=;
 b=xoL4mGHpDgxkaz9vx1E2E8C4mmUbFZtkaBTNZWvw7lPI/DOKLiG1BgKGw+QV9ImwuW
 hQl67kIj5lo3ZZW+CxYd7LcZJ0xYV8h5mTaqWwHuNAVqlxgDV71uP1z0TmnM7La6pq22
 9CdHd4Yws3FlwnuWVKX7kRrcdyqXFF9yzpgL3k4a83GT9lhQy6ESjFBd6MHK0hDulolO
 dYSKAJSIHmwXyGCE2WTyXOxWovVgLuLS1Uz41crvhc7dwnVwgzMDL5+QNLb6P2ILjjGo
 WNlCzaXO5Kh96B8Ni+iMwiUn5obkf0hzNWqEqxBE1pcU7U9n80lLUoOzBkMLedWwItz5
 DUZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718096968; x=1718701768;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=I0tT55ivXV8dsYJgVDGsT3EHHBSvAqjD9bvaV9Fh9K4=;
 b=gsfpBS93TA13F7ES3yQRC6a5ub4IIuFODBKnyJJ0ExZ9ii/K/3W+E/yt/OwQ5UuG6J
 QUhcvcGD+pzhCul55DhTB3iNGZvGBEmzYRoDgyarZBHurFbvHgTSTDJ8T7rJnZCbGnqu
 MFOs2HdshQo7zouC9EqYpzG8RcsHn15wOUiHSeltFjPfKx32vmBDQOGDYSOdLbEoT6yd
 mXBGgqutiCVPddb1YplJUTMWWHRPjN2AzbiOh8a/XRVTWZqJOdLyiLIsegkMTEz4MZol
 HbxS9fW0kJtdSJcxI5i8mvBUYUL7spgsmV5V6YrL2cQkH4JqZxqwdRC01H37J+fIwtGA
 RPkw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXOMUvTYq65Hg3iy+ACj7LyT0gIYBdSzTWxOn6THJ1yCZZDCNSqXvl7eH7bNRL8wPtlQESmC6AE7yZiAoW9gc0AKWXllN0=
X-Gm-Message-State: AOJu0YxW9m7UONmyqI48tul6SMV9aKgeOSX8Bf4s6lJvM8CdOOfkcj1/
 wpjVKpuLyGeEETNZFo332lBt7P9DwPX6gKIpW46OsLmLqw0vki+iXaOHe1jDLio=
X-Google-Smtp-Source: AGHT+IHUfuJgi8//R89yBBsJ1AInovnA2u8iB2e9GV+IR4If02Y2xaZ0pcsHJBHdlZTCD/mXc4Bczw==
X-Received: by 2002:a17:906:fe49:b0:a5c:ec01:f0 with SMTP id
 a640c23a62f3a-a6cdc2d2488mr894869766b.70.1718096967705; 
 Tue, 11 Jun 2024 02:09:27 -0700 (PDT)
Received: from [192.168.69.100] (rsa59-h02-176-184-32-6.dsl.sta.abo.bbox.fr.
 [176.184.32.6]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57aae202396sm9064475a12.74.2024.06.11.02.09.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Jun 2024 02:09:27 -0700 (PDT)
Message-ID: <5d7981cf-6d18-4915-bb6b-985998a0c953@linaro.org>
Date: Tue, 11 Jun 2024 11:09:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] meson: Remove libumad dependence
To: zhenwei pi <pizhenwei@bytedance.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, marcandre.lureau@redhat.com, berrange@redhat.com,
 thuth@redhat.com
References: <20240611082407.57154-1-pizhenwei@bytedance.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240611082407.57154-1-pizhenwei@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x631.google.com
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

On 11/6/24 10:24, zhenwei pi wrote:
> RDMA based migration has no dependence on libumad, libibverbs and
> librdmacm are enough.
> libumad was used by rdmacm-mux which has been already removed. It's
> remained mistakenly.

Great!

Please also update tests/lcitool/projects/qemu.yml, with that:
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> Fixes: 1dfd42c4264b ("hw/rdma: Remove deprecated pvrdma device and rdmacm-mux helper")
> Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
> ---
>   meson.build | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/meson.build b/meson.build
> index ec59effca2..226b97ea26 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -1885,11 +1885,9 @@ endif
>   
>   rdma = not_found
>   if not get_option('rdma').auto() or have_system
> -  libumad = cc.find_library('ibumad', required: get_option('rdma'))
>     rdma_libs = [cc.find_library('rdmacm', has_headers: ['rdma/rdma_cma.h'],
>                                  required: get_option('rdma')),
> -               cc.find_library('ibverbs', required: get_option('rdma')),
> -               libumad]
> +               cc.find_library('ibverbs', required: get_option('rdma'))]
>     rdma = declare_dependency(dependencies: rdma_libs)
>     foreach lib: rdma_libs
>       if not lib.found()


