Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCE2ED44D54
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2024 13:10:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8fnv-0002PI-Eo; Wed, 06 Nov 2024 08:10:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t8fnr-0002Oj-N7
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 08:10:32 -0500
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t8fnp-0001na-3g
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 08:10:30 -0500
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5ceb03aaddeso7284103a12.2
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2024 05:10:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730898625; x=1731503425; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=kCnNWRod8P+9gKWLOJGBeCEs1Ck5V+5mFSXMviBpl2U=;
 b=lXtX77FIMq2vA88yXHo24g42AkisuBoCMHCrVSw3BfyfkmsLB+oPYf6WiwlIHDcHfN
 yUyXiAzx7Ym3WhofEif+NDWxbdfuPSrx3zBdip9M61EJ9WNvQhG15hWnGVFKGQ6t8/38
 P+LWOzhLK+0uHo+r8u0AOx6FccTZ4r2rxQrF54RHv0cHMWmnJN0zhc6kFnah9hVErVrb
 0sVDUcRa/UY38kyXZpZN4ZSb4Mx9khj3yKvf14PRS9kZGeh9aobcIBGHQr5991yz69+p
 LrmqgLxQo5LUiHXnMlh2g6El2MvFcOa4jkWBxxmtev+zAFtA/ZLZXxubUCp/0aYJf+aL
 lO2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730898625; x=1731503425;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kCnNWRod8P+9gKWLOJGBeCEs1Ck5V+5mFSXMviBpl2U=;
 b=gX4lEdJh0Vj/EJ5m+MYOmYb5TiBykTjZ8Rx1t6/gOCgNMdubPWCY42C4OIUVmZNY6J
 xi2YXvDy5+6gkYlQ9gp1vS746Ezpn08d2A/k8fPd8rLtSN0+IEFXjscGkljs38XbSRTb
 krrEU0NgfCC83TRRA8poUOftVH9df2tX5uOo6nPW23YECUhT1+E2m/aPfDQIdmbQkFQc
 knyiIFDiPk9LzUWi0Ze5W2sZRWXz1CRNApSuD9p4C06f8HCa/NuHyWaBcJgn/d1LOfzx
 R3X7OyEXshg/GaEwlG7XUWHXHZrqi6gR9F1N/OxzZrhbEBD6CTn9FVpmL+gdwER7sTwV
 Pd1A==
X-Gm-Message-State: AOJu0YwlwITM7Hn1H1pMxOFnr19JS/n1ypimL5OkRvBeVEX1HP/JpMbb
 yq2aB6Tp0M1JX3MQMN7p5AQtKTIti7jc7ov9F4VmEATxUbZHTSBY2VmSqCyNWI73+e3eDovX/qk
 Ed6dlaiQOAagcvUjMiMsVQwCR0ekkReBgfqlbjw==
X-Google-Smtp-Source: AGHT+IHL2Jx5OQGuin1wGbNFKVrdcjVu6X3vl7+ICzgHZkEJCVuTEdpiRUZl+dgQmsn39su34GEtaWiyzxclvc1vklM=
X-Received: by 2002:a05:6402:4316:b0:5ce:b82f:c4eb with SMTP id
 4fb4d7f45d1cf-5ceb82fcb42mr19222665a12.8.1730898625439; Wed, 06 Nov 2024
 05:10:25 -0800 (PST)
MIME-Version: 1.0
References: <20241104172721.180255-1-pbonzini@redhat.com>
In-Reply-To: <20241104172721.180255-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 6 Nov 2024 13:10:14 +0000
Message-ID: <CAFEAcA8JoYxokZxcf66ivkCAMXuVFvDdrC7tCguNvQ43aAr_kg@mail.gmail.com>
Subject: Re: [PULL 00/40] Rust changes for QEMU 9.2 soft freeze
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Junjie Mao <junjie.mao@hotmail.com>, Kevin Wolf <kwolf@redhat.com>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, Zhao Liu <zhao1.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x530.google.com
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

On Mon, 4 Nov 2024 at 17:35, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> The following changes since commit 15195de6a93438be99fdf9a90992c4228527130d:
>
>   ci: enable rust in the Fedora system build job (2024-10-30 16:30:56 +0100)
>
> are available in the Git repository at:
>
>   https://gitlab.com/bonzini/qemu.git tags/for-upstream-rust
>
> for you to fetch changes up to d20feaa9a5af597bd20630d041e5dc7808612be1:
>
>   ci: enable rust in the Debian and Ubuntu system build job (2024-10-31 18:39:52 +0100)
>
> ----------------------------------------------------------------
> * rust: cleanups
> * rust: integration tests
> * rust/pl011: add support for migration
> * rust/pl011: add TYPE_PL011_LUMINARY device
> * rust: add support for older compilers and bindgen
> * rust: enable rust in the Debian, Fedora and Ubuntu system build job
>
> ----------------------------------------------------------------

This probably isn't something worth not merging this for, but I
noticed while testing (via vm-build-openbsd) that Meson complains:

Compiler for language rust for the host machine not found.
Program bindgen skipped: feature rust disabled
../meson.build:111: WARNING: bindgen not found, disabling Rust compilation.
Message: To use Rust you can install a new version with "cargo install
bindgen-cli"

Rust is still disabled-by-default, so why is meson probing for bindgen?
It would be nice if we could avoid printing WARNING messages for
the normal case.

(I'm continuing with the CI test run.)

thanks
-- PMM

