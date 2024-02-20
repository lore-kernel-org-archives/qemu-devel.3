Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C13DC5475B
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 18:51:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcVCb-00065W-5n; Tue, 20 Feb 2024 13:50:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rcVCY-000658-Vs
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 13:50:47 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rcVCX-0000GP-9k
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 13:50:46 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4127109694aso4929005e9.3
 for <qemu-devel@nongnu.org>; Tue, 20 Feb 2024 10:50:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708455044; x=1709059844; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=50us755/NbBPTEkZqWuSUvSVfTzxG7Z56CsHKPyJ9PQ=;
 b=ecP+aN2Kb4+aHWRmoXoj0a1XCQX1OBd/S8SPwBFSXatnFjTuvyAu+SoFzQ/ne6lOtF
 TOfr2U/4ff5Pgx+fSh5bna1DeBLOqWKHSGgroPJksFsFCND0JDI5pCmWLBdrjpw+t3Fd
 MdkhASURiQzmIONiWpHYnhAe+IgUWFh7+Owi+18Yj8P7muCscki+tVZCC0bEqCWMYpMz
 8vZ29bf7HPO7bt6Iyixd/6KLyrm49/5zJmywRrBKvWOTTD0vIhiC6nQYsCRXXBDSaVTO
 r3qMHFd3w1Bf5aPYRMGniPsr4Q+c1pDReEjsrg4HF8uwQzOrR1Jx3swBxejTKWC/GJSz
 3Ohg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708455044; x=1709059844;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=50us755/NbBPTEkZqWuSUvSVfTzxG7Z56CsHKPyJ9PQ=;
 b=IVIuxpunBzPdf6st9HMJml0CZTeF2hISjRM68Srmtn8xTw60/AT+j//2gj6/njTe2J
 JNtHdlg3uMyttYvgoORyFX5copM5J1HAgq2G3yrM2WH/PZ0nWaHrUgHq8DY4bAFz3fKF
 5Hd2UYcqMBjTD3eVHQDROlfOldWf4k17lFiPgD54HIS2DfDDVl/xIVm5Mo2HedOYHSdk
 1lP+NMBy7VV24xDscvBmI5m1hO66okOftJdADjipXRk8srkS2ZzF6GzTHHPGfpUEtmOh
 mJ/sP69uQ3OUudjTUI1+iOaoc0FByjLOZA26PwQ9+cmVjXmN5Knvq5svcv2JCNMl4waJ
 5nrg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUNlJa3btv6s0pvVOZ+dnTyfWWbTN6DZyH4p7eDFHpKIHMemE/kMc1QIVl0FUi/I1j4w1FXVy2APC0RpVv/ASS3c1IPlIk=
X-Gm-Message-State: AOJu0Yxc17wDraxrgEevq9B4N9Um27NdLE9wHotE+EGd7FjTlpSWriHL
 o2+SpLBvOx04hAR+pBP9YI+Hw6gVIpJ5nn8dTXe8vXoE0KebjV5aZR5LwOzqjs2rR39O20zx9PY
 A
X-Google-Smtp-Source: AGHT+IFx7GfClFTcszQYdc5abq0d0RjgHokUFWVKJ26XDMzUD61aOp94iBCmJN50/2xh3vaZ0tAuQQ==
X-Received: by 2002:a05:600c:1c87:b0:412:171a:f9a4 with SMTP id
 k7-20020a05600c1c8700b00412171af9a4mr11187881wms.16.1708455043707; 
 Tue, 20 Feb 2024 10:50:43 -0800 (PST)
Received: from [192.168.69.100] (mek33-h02-176-184-23-7.dsl.sta.abo.bbox.fr.
 [176.184.23.7]) by smtp.gmail.com with ESMTPSA id
 o20-20020a05600c4fd400b00412590eee7csm12495402wmq.10.2024.02.20.10.50.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Feb 2024 10:50:42 -0800 (PST)
Message-ID: <e434d7fc-d215-4537-b594-784155ebadfb@linaro.org>
Date: Tue, 20 Feb 2024 19:50:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] .gitlab-ci.d/windows.yml: Remove shared-msys2
 abstraction
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Yonggang Luo <luoyonggang@gmail.com>
References: <20240220174412.155885-1-peter.maydell@linaro.org>
 <20240220174412.155885-4-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240220174412.155885-4-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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
> Now we don't build msys2-32bit we don't need the abstraction out of the
> common msys2 handling from the 32-vs-64-bit specifics. Collapse it
> down into the msys2-64bit job definition.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   .gitlab-ci.d/windows.yml | 84 +++++++++++++++++++---------------------
>   1 file changed, 40 insertions(+), 44 deletions(-)
> 
> diff --git a/.gitlab-ci.d/windows.yml b/.gitlab-ci.d/windows.yml
> index 8fc08218d28..e784d5a68cd 100644
> --- a/.gitlab-ci.d/windows.yml
> +++ b/.gitlab-ci.d/windows.yml
> @@ -1,4 +1,4 @@
> -.shared_msys2_builder:
> +msys2-64bit:
>     extends: .base_job_template
>     tags:
>     - shared-windows
> @@ -14,9 +14,19 @@
>     stage: build
>     timeout: 100m
>     variables:
> +    MINGW_TARGET: mingw-w64-x86_64

You expanded $MINGW_TARGET so we can remove it.

> +    MSYSTEM: MINGW64
>       # This feature doesn't (currently) work with PowerShell, it stops
>       # the echo'ing of commands being run and doesn't show any timing
>       FF_SCRIPT_SECTIONS: 0
> +    # do not remove "--without-default-devices"!
> +    # commit 9f8e6cad65a6 ("gitlab-ci: Speed up the msys2-64bit job by using --without-default-devices"
> +    # changed to compile QEMU with the --without-default-devices switch
> +    # for the msys2 64-bit job, due to the build could not complete within

s/the msys2 64-bit/this/, although it seems this sentence got truncated.

> +    CONFIGURE_ARGS:  --target-list=x86_64-softmmu --without-default-devices -Ddebug=false -Doptimization=0
> +    # qTests don't run successfully with "--without-default-devices",
> +    # so let's exclude the qtests from CI for now.
> +    TEST_ARGS: --no-suite qtest
>     artifacts:
>       name: "$CI_JOB_NAME-$CI_COMMIT_REF_SLUG"
>       expire_in: 7 days

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


