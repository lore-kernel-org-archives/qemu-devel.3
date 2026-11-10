Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0505C606A321
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Nov 2026 18:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=wgvFiGMi
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQqV0-0001M4-UU; Tue, 10 Nov 2026 13:23:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xQqUx-0001LT-2W
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 13:23:11 -0500
Received: from mail-yx1-xb135.google.com ([2607:f8b0:4864:20::b135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xQqUv-0002RC-B1
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 13:23:10 -0500
Received: by mail-yx1-xb135.google.com with SMTP id
 956f58d0204a3-677af43eed4so2724766d50.0
 for <qemu-devel@nongnu.org>; Tue, 10 Nov 2026 10:23:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794334988; cv=none;
 d=google.com; s=arc-20260327;
 b=pJZ+aOAobGd3wlw8vF4JkJs4b+iVWpUcR6GbCXLs3t0aNWezlT1gL+ZXG0PYthXoTa
 VgYDlL+r0sWA+VUBS4PTjxQeGCAHupAjoaT/YKZg7KdQpwbziZwa9uRvRj4P4w+LINil
 yU+M6ijN/Fngzgyp7oJFKlB/GVnpXi8dI1CzzdgsOII8juHcOsdG93Rdhqjz49BjxkAc
 x481vW2MfcVR5UWsQmz0zK3ZnwPLbH5FhrTnfPTNQd2GM2T+5dcrppLSSTbdEXrbGMRl
 FgWMpBVb/Vj5nt5Po4vn2nnw0TXzQIFKBPNBl96CLBchqMZho8hYw60N8bTBNaX/YSDq
 paJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=27ySAo2+dUimhu26CFpZ16PLYKjsmAwT7G8TLDAERKw=;
 fh=c5OmGvVdhFcqa/nz7J9xmfaK9ZIWZe82cOBD2bnDmcc=;
 b=CUH0QqRGx2mjqliN+tVulMSYJGnK+bGvTUNe2rgdilwbK/3F7df9hUQVQiOULNa2me
 K7z2aoy7PxjJ6EUWbFApQSmttf/JD9xBFfZR8szr1hX9YFG0G6YH5Gtb1X3m7djGnVHI
 q0rvROMLmVO1WN39Va+l/O32NtZWH6ewz6F5ENw6r4ANTUASg4w+pfKl2Dy7OJu0/iFX
 k2TETubkAOTYra6nem2CKOG3qTobfcqsn7bBa9A0JpnYz9pY6Dx7WEJ12zL1OFVEe9+F
 RvzBLcMXS7E/OtieNtZWpwidtXokGJCb41zHgdiA3Z6joqMMbbhIppJ9CGorsGDnNuMs
 xqSA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794334988; x=1794939788; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=27ySAo2+dUimhu26CFpZ16PLYKjsmAwT7G8TLDAERKw=;
 b=wgvFiGMik5+6h+sJ79De4gd0/HvMWKHEevM0NeaRgDB7KXwRH1fKBiE6GGc51KSoU3
 X+JG1kORQ5Zr1idHIVPmcb07Yr5zzGWQWn/3nSq0+KoURiolMP4Dl2nW7wDibOKpRWyG
 bu3/GOo7QzQVzDzQ1BubTy5Q9qYAO/qUNLxRG7zYXN2gG9ODVpEayFRE6BFlrblu3LQ2
 GmFBmx+ahomhkfUVw94T82NXbuP2+ap7zt1zJS9DnYkyHHu3FyWIK2ahz71j5D6vz6QZ
 zGd3J5aNwdpBG0m/OePIF7z+oM8d/H11bZ1AGB52yzF1IYnjMFlGXEJL0bqcyH5eRJ/S
 aWfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794334988; x=1794939788;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=27ySAo2+dUimhu26CFpZ16PLYKjsmAwT7G8TLDAERKw=;
 b=hHzAqEkCIeqsFA1nXN+0KwSBqn7tLQbyeGmpQ1b1O/Mn3jk+tGtxbgdFFmXhDovxDI
 Jh8/zfe+eEleGliTVMlsmFvJOEqdfPfL6heLw/lXYOW8XH96hgZRrBOolOhibgK37aZw
 WtaAGRC0saAYgdhByBn96vbhv75U+cZJeIzN3ZI73I9BEMUlrQD0itiuWmd2y/NFmLuO
 NxPUefV8eN17CdKJi6PXFRQzbrEs+Qizqp2cnYuNa4nM0a/6bil+9CGXKGK/DVS2dl4r
 tPebHxVSLNo3jiAqS6PV2mA5+R2h/mohgcj7t+aSUo9i2kL605ouF9YXuJ8wMYVKUmBF
 Kj2A==
X-Forwarded-Encrypted: i=1;
 AL+hErGI/5uG1SXkf4akySVEZsblA1KUYiX41yym9sUm12jhEKHpj/oSrjZjTC4WeewkhNBwFCOKpRYtxZNp@nongnu.org
X-Gm-Message-State: APuU4Z/k19j4LYtlMIYKL99DPanaloUQly7GEgljPyA7nNRlNg6PePCz
 wIjMUWH71EppZDY8Khqp2axIJ3ny4+x6tMsAt2dVtfK4oeZuA5f+2vBhstSTwAB5B+GlAbYvAOQ
 Nx0wWLC8GkTnylPXNJajDNR9wDSQK2pek2ytxQyH1FA==
X-Gm-Gg: AYBFou30M8EtapIw8bKKnDmm2YJJk3ClBgHmAQL0BLdUMxSdM4yKuqHJnNRJO0lOm1m
 vOuBvr7iYYa8RYoKJcxpLwZKRIoFTqOy250ZhV0JT/4zc9GX6vQiKECIQvknR6K2SPQqOP3rJ7D
 cVDtoXW2wNIWVyxVEkc6VcOW3EV9O8BkZeTHdPywwkhdJcmzqKc/PkZEwihMg9nRSCh/qZROnh5
 J3p+GSAJQtmzp7r1b8/9J0wOP5zNFbTMo46m5Yn2Uyax+1NEU/S5Ce7Z+ql5WNV0iIfEVFCWRCP
 YBYXSQD5P9iRYxf8htc2b4AcM3IUumFt6dqnS1gv6jCcQsDs8jUo01Ah9J8RR+g/h3Udww+esPt
 JSe778s7PxTjAMicFocAPX4g16IboBXshQWqGwhmKWvrWU4Ik4sOPgFEtDMoCMBOVGc62+RUJ0O
 KX3CnJSj75EfjnSmfyws3Vzza2WGkg5AyeGskkrDzyVw==
X-Received: by 2002:a05:690e:12cb:b0:67c:a2c:8214 with SMTP id
 956f58d0204a3-67c67fa8174mr88932d50.66.1794334987532; Tue, 10 Nov 2026
 10:23:07 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261030095731.581512-1-peter.maydell@linaro.org>
In-Reply-To: <20261030095731.581512-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 10 Nov 2026 18:22:55 +0000
X-Gm-Features: AclHuK8CB_vL-ujtoK9NibS5waOnqLhzVdYEdW9-BFBnMdXiEK--dFAILjW8yT4
Message-ID: <CAFEAcA_18rPM_zKO8daehxrPdXD4DWLhQ1gvuAy=9WEZejqPMw@mail.gmail.com>
Subject: Re: [PATCH] hw/arm: Deprecate Nuvoton quanta-gsj board model
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: Tyrone Ting <kfting@nuvoton.com>, Hao Wu <wuhaotsh@google.com>, 
 Bin Meng <bin.meng@processmission.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b135;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb135.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Last chance for anybody on the Nuvoton maintainers list to respond;
otherwise I'll throw this into target-arm to deprecate quanta-gsj
this week.

-- PMM

On Fri, 30 Oct 2026 at 09:57, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> The latest OpenBMC release as of June 2026 no longer supports the
> quanta-gsj board model (as noted in docs/system/arm/nuvoton.rst);
> support was removed by OpenBMC back in 2023:
> https://github.com/openbmc/openbmc/commit/ab5062cf6f562ad0c844570ba1ea0089961848ca
>
> If OpenBMC don't care about this model any more, it's unlikely to
> have many users.  Deprecate it, with the intention of deletion after
> the usual two-release period.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> I don't insist on deprecating this if the Nuvoton maintainers
> think it's still useful. But this is a "hello, are you paying
> attention" call, since you didn't respond when I asked in
> code review on a different patchset :-)
> ---
>  docs/about/deprecated.rst | 10 ++++++++++
>  hw/arm/npcm7xx_boards.c   |  1 +
>  2 files changed, 11 insertions(+)
>
> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> index dab47b6ca38..c579342b312 100644
> --- a/docs/about/deprecated.rst
> +++ b/docs/about/deprecated.rst
> @@ -287,6 +287,16 @@ The machine never got fully implemented and can only show the firmware prompt.
>  Given the incomplete state and slow progress on improvements, it might get
>  removed again without replacement.
>
> +``quanta-gsj`` Arm machine (since 11.2)
> +'''''''''''''''''''''''''''''''''''''''
> +
> +The ``quanta-gsj`` machine models a system with a Nuvoton SoC
> +intended for use as a baseband management controller in a server.
> +Support for this machine type was dropped from the OpenBMC project
> +in 2023. If OpenBMC no longer care about this hardware, the QEMU
> +model is unlikely to have many users, so we are deprecating it.
> +Users should consider one of the other Nuvoton-based board models.
> +
>
>  Backend options
>  ---------------
> diff --git a/hw/arm/npcm7xx_boards.c b/hw/arm/npcm7xx_boards.c
> index 9c526a26839..ec4b530986b 100644
> --- a/hw/arm/npcm7xx_boards.c
> +++ b/hw/arm/npcm7xx_boards.c
> @@ -496,6 +496,7 @@ static void gsj_machine_class_init(ObjectClass *oc, const void *data)
>      mc->init = quanta_gsj_init;
>      mc->auto_create_sdcard = true;
>      mc->default_ram_size = 512 * MiB;
> +    mc->deprecation_reason = "No longer supported by OpenBMC";
>  };
>
>  static void gbs_bmc_machine_class_init(ObjectClass *oc, const void *data)

