Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BE6FC4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2024 17:38:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxsAz-0003ej-Ix; Fri, 19 Apr 2024 13:37:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rxsAy-0003eA-8K
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 13:37:28 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rxsAw-0003oX-L4
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 13:37:27 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-56e477db7fbso3837932a12.3
 for <qemu-devel@nongnu.org>; Fri, 19 Apr 2024 10:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713548244; x=1714153044; darn=nongnu.org;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xI9shwFKRsiVt360abO99mGfeOn4kepQF/rcjZ6h/wI=;
 b=jgwGbem57FI8D8Hd9uh6HSM8bCQEu3OMsKFWaGdEhMBODlsMksCge75HkXipCcfqwl
 Pmr9jXPl58Ga+EoDBHoSUEqveaDj4HelnnBW4V6M4wBkBe5SrK3trMG6/iPuoPZ/GI8b
 SQvbbFcUTYftNKKcMKmpvxTzS3kfdzUstU0dhUTgQjQk45vLSdqO+M6O6lLAxyhP/j/Q
 hYLqnij+Wpy+2zX0q+3OgdXNJDG0XOKfXFzyzsKap2zK1WUgnoLgwqZrDj/ZRBFiqVB/
 Z/tOjgc9CiNzFFjRgjwn5qxRKOUJIPaq4cF9QCECooIs+z/6jqlSwkCGfO9GlemhudT+
 Fcpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713548244; x=1714153044;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xI9shwFKRsiVt360abO99mGfeOn4kepQF/rcjZ6h/wI=;
 b=VS/ZUy4OcFcu5yHHsrTeM/gc/kEYcSWqdFGTfHPEKMrreXQNhTyL+4SSmQtk04cgfP
 1tZQQxvVpJ+n2/0ZssFvk2CNLj4QjlejzU/tiURmPxS+oM28onMCx+1mzXzJ18jLguc/
 GxVxanBxCWQsad/gEbuuVOhlEwEfn6pwO0dwhg8Tm/NWNynZ7unlF3yVsq2dpo3N532e
 D4nTw1UN+t4sDK0iXWc3Bah3olngUOfIyClEHbbOFQfOkIrPh5+h2BAsINMmzofPw1Ol
 g11ZHl8K5wB3hkMbGiFE5XWNMtJhjaUfKpfs5hZ7dQwR1xCElTfHYodiizXPs1s6UQGu
 8Cgw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV5xe+qYx6VbjKOUrRTu62e+M2AEcvYyWMpxPfoxEX0hL4JW6YGblQ7yAuGLyMRjld9mCUiNG1bzX3pSERogQ2f6UA7mss=
X-Gm-Message-State: AOJu0YypeBb41N3dIDS02h1K0qCmZN8bHD9tHANszRO+GP4xzO6ko+k9
 M+OPQ0MrfmU1kYWQ+NHQlKcc5hpfcrTclPdkmGcGhTqxUG+v6vVFbTyzAoqqAQBVLRSW2o+skDE
 vdI3Lif7/sXuD/wE4mLPXr3QU7oKD9p8ZlElTCFs0sllUSdCj
X-Google-Smtp-Source: AGHT+IGhQzcy3ajLzg7oQrDCSHpMivsgYLV4Cuqt/A8VD6IuXX4ToUObRnxVkclO6OQGwIaQvQlXQ8kMgbiY2cfqleg=
X-Received: by 2002:a50:bb48:0:b0:56e:238e:372c with SMTP id
 y66-20020a50bb48000000b0056e238e372cmr1764521ede.26.1713548244277; Fri, 19
 Apr 2024 10:37:24 -0700 (PDT)
MIME-Version: 1.0
References: <20240418152004.2106516-1-peter.maydell@linaro.org>
 <20240418152004.2106516-2-peter.maydell@linaro.org>
In-Reply-To: <20240418152004.2106516-2-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 19 Apr 2024 18:37:13 +0100
Message-ID: <CAFEAcA92B8C1tRpm53kjnrskbuSyJa7ss9BEKZ+uNsMiAAbeGA@mail.gmail.com>
Subject: Re: [PATCH 1/5] docs/system/arm/emulation.rst: Add missing
 implemented features
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52c.google.com
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

On Thu, 18 Apr 2024 at 16:20, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> As of version DDI0487K.a of the Arm ARM, some architectural features
> which previously didn't have official names have been named.  Add
> these to the list of features which QEMU's TCG emulation supports.
> Mostly these are features which we thought of as part of baseline 8.0
> support.  For SVE and SVE2, the names have been brought into line
> with the FEAT_* naming convention of other extensions, and some
> sub-components split into separate FEAT_ items.  In a few cases (eg
> FEAT_CCIDX, FEAT_DPB2) the omission from our list was just an oversight.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  docs/system/arm/emulation.rst | 37 +++++++++++++++++++++++++++++++++--
>  1 file changed, 35 insertions(+), 2 deletions(-)
>
> diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
> index 2a7bbb82dc4..9388c7dd553 100644
> --- a/docs/system/arm/emulation.rst
> +++ b/docs/system/arm/emulation.rst
> @@ -8,13 +8,25 @@ Armv8 versions of the A-profile architecture. It also has support for
>  the following architecture extensions:
>
>  - FEAT_AA32BF16 (AArch32 BFloat16 instructions)
> +- FEAT_AA32EL0 (Support for AArch32 at EL0)
> +- FEAT_AA32EL1 (Support for AArch32 at EL1)
> +- FEAT_AA32EL2 (Support for AArch32 at EL2)
> +- FEAT_AA32EL3 (Support for AArch32 at EL3)
>  - FEAT_AA32HPD (AArch32 hierarchical permission disables)
>  - FEAT_AA32I8MM (AArch32 Int8 matrix multiplication instructions)
> +- FEAT_AA64EL0 (Support for AArch64 at EL0)
> +- FEAT_AA64EL1 (Support for AArch64 at EL1)
> +- FEAT_AA64EL2 (Support for AArch64 at EL2)
> +- FEAT_AA64EL3 (Support for AArch64 at EL3)
> +- FEAT_AdvSIMD (Advanced SIMD Extension)
>  - FEAT_AES (AESD and AESE instructions)
> +- FEAT_ASID16 (16 bit ASID)
>  - FEAT_BBM at level 2 (Translation table break-before-make levels)
>  - FEAT_BF16 (AArch64 BFloat16 instructions)
>  - FEAT_BTI (Branch Target Identification)
> +- FEAT_CCIDX (Extended cache index)
>  - FEAT_CRC32 (CRC32 instructions)
> +- FEAT_Crypto (Cryptographic Extension)

I missed one here: we can also add
FEAT_Armv9_Crypto (Armv9 Cryptographic Extension)

(Like FEAT_Crypto, this is an "umbrella" feature naming the
combination of various other crypto related features, all of which
we already implement.)

-- PMM

