Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0DE9C021BC
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 13:22:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmusS-0004wm-W3; Tue, 25 Feb 2025 08:21:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tmusK-0004wE-C4
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 08:21:29 -0500
Received: from mail-yw1-x112a.google.com ([2607:f8b0:4864:20::112a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tmusI-0008A8-2L
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 08:21:27 -0500
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-6f88509dad2so47717297b3.3
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2025 05:21:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740489684; x=1741094484; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=E+3iB3XJOtPYpfGAfownvWUccyqcJ7/zWZarts/yTyg=;
 b=uR31iVlzbBiNnq3gIEF61QrdWe4bF2vzvzqUAu1m9uG3HbOemQErnyL/lKrAIIRXim
 0h3FE2Nxe58O40AZ/RvPyJefury0OfmQDtnergYCzbueii7t7budRcjbz5n4Qz6E0P1N
 r5P+uhbNH83JZyZ1bSBFuI0+8lPTsiqJQtOpvNs3H3tO30QjX841RNQDJzTZIyDKStNj
 OymdH/FL3wNxDFarb+zkQKaVdd/yhF+NpVUHn5SK0HY9xid/6T+vCfXEB5QyqT9pwcY+
 03i/QrED1+oe8pQnfxK4vDLyILxsDw4LHhUhNgibhSa7rohi3s0XIQElF4eKjl7UxRLE
 TFag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740489684; x=1741094484;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=E+3iB3XJOtPYpfGAfownvWUccyqcJ7/zWZarts/yTyg=;
 b=PY+aU3v8bazHDXrOTm6BhNgU50CN/3zgYRKMzBVMHpXabrVcAPQ/zIT/C6x4qbSPW8
 KmU61mPSrainr43ZfM8H/8sHSqH6BfbtW9Z0uArVE/swbwNyiDJY4x+5MskG+ZpdHVAq
 Jr7bEawUdDLW41KT0p+orplO1fLNGsBxm5fxnxkASbJXxBgmfwDPQ3j8++/RE3Cnkd0F
 OOCRfg2RYEKhOsGDYJd0OIRbfYwHgxmZsvMV/oQI3Ess2Xcm+k2xjmSuvsNF/NWoVK2r
 YE08ptDdLwvyPZsPx030ZsYK8+p5jfImYWkl5rM3g9dQkKxa4JEm3fr76iPtG1tTAZvU
 kpmw==
X-Gm-Message-State: AOJu0YyHBRd5Eh+1PrGBrS/Bj/pPeBREoehqvz45z76Ugf0T4sI5dgdG
 k/dvqpTUCPmVPmP+mAe4rLON8V987rec/mBz7wHfhZ8MPHmxVrlgMVDiTTxIrWKZV7Jac+fJGkJ
 6JNx22UqReT4FqtxyW3Xw3P3bSRpvntloh3Pz9EecBPAW68Zj
X-Gm-Gg: ASbGnctyhyuSIRfC7wSVveR7yo73aZOfz3tB9LG2EvoddZ7wuCKC0iK4j+7F2wCH1Jk
 nzDpaUr7ngLkknyI0BtYxZv0Xz0i6kHnEt4i80jH/kc9v/K3TSmTi3tOGDkrs1PUyUa7fjdg9B4
 7gQagRLSNz
X-Google-Smtp-Source: AGHT+IFFco/YFihtoGg3zEtcOthmPEMXCQstlvWxWYyG81sXowMYomDR1gOfOl0iwz4eEMRuu8smwurO9mNhjqNIDb8=
X-Received: by 2002:a05:690c:380a:b0:6f9:48c6:6a17 with SMTP id
 00721157ae682-6fbcc81795cmr157191287b3.26.1740489683714; Tue, 25 Feb 2025
 05:21:23 -0800 (PST)
MIME-Version: 1.0
References: <20250224165735.36792-1-j@getutm.app>
In-Reply-To: <20250224165735.36792-1-j@getutm.app>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 25 Feb 2025 13:21:12 +0000
X-Gm-Features: AWEUYZn7SAm1Vo3HUxb-ECBKPy0F35l9KkEn49pYoqpEb7I1hG1rRdGbmb3lOi0
Message-ID: <CAFEAcA9uO+r7m6wEtpWjcJcR3VUzhaKnaogALzOHvnLH-aGk-A@mail.gmail.com>
Subject: Re: [PATCH] hvf: arm: disable SME feature
To: Joelle van Dyne <j@getutm.app>
Cc: qemu-devel@nongnu.org, Alexander Graf <agraf@csgraf.de>, 
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112a.google.com
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

On Mon, 24 Feb 2025 at 16:57, Joelle van Dyne <j@getutm.app> wrote:
>
> macOS 15.2's Hypervisor.framework exposes SME feature on M4 Macs.
> However, HVF does not properly support it yet causing QEMU to
> fail to start when HVF accelerator is used on these systems.
>
> Signed-off-by: Joelle van Dyne <j@getutm.app>
> ---
>  target/arm/hvf/hvf.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
> index 0afd96018e..261db2d227 100644
> --- a/target/arm/hvf/hvf.c
> +++ b/target/arm/hvf/hvf.c
> @@ -899,6 +899,11 @@ static bool hvf_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
>
>      clamp_id_aa64mmfr0_parange_to_ipa_size(&host_isar.id_aa64mmfr0);
>
> +    /*
> +     * Disable SME which is not properly handled by QEMU yet
> +     */
> +    host_isar.id_aa64pfr1 &= ~R_ID_AA64PFR1_SME_MASK;
> +
>      ahcf->isar = host_isar;

Thanks for sending in this patch; I've applied it to
target-arm.next. I expanded the comment a bit to add my
understanding of what pieces are missing in QEMU to support
this, and threw in a cc:stable so we can get this backported
to the stable release branches.

-- PMM

