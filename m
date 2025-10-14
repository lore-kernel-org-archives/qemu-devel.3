Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4020CCCD187
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 10:42:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8cSd-00025q-HY; Tue, 14 Oct 2025 06:40:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v8cSZ-00025c-SV
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 06:40:51 -0400
Received: from mail-yx1-xb12c.google.com ([2607:f8b0:4864:20::b12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v8cSR-0003Ns-G9
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 06:40:50 -0400
Received: by mail-yx1-xb12c.google.com with SMTP id
 956f58d0204a3-63d0692136bso1898784d50.1
 for <qemu-devel@nongnu.org>; Tue, 14 Oct 2025 03:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760438438; x=1761043238; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=fV7/jrMkBaJn6/SK6psmoZxBrmB/QuRq2mi1M4MJLDM=;
 b=xx6XgFymdx2Dm2V59cEsmnXahLbcpl2f3vOtiVcXDUkpl9HTvsQh367F4uuaxuXLAN
 EFxdE8vkAnGB3N7y6+WQxZklI8tPWAj1axQQkqsHjY0NdivFuErXeqA9KtWlhPW5s5TO
 KRmE5lZJpQ8zrFNO96JL8cOtZlnxL1CWTcdTHlfnCMfrQBDreDdsloDYrUrN0hVE9cYj
 CfhBjhaLzQxHRtZ9SadyveZEdNConrWpoSS/DaBU28CDKp6ulMEE/UgRZoNLTs3PSI/o
 TvqO4i+Sjlg0B8u+doDX2qC0+/MyrVaT6N/U1rVpA9QhfmRJCdgoOQ74JM6PyF1m6pp0
 kaMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760438438; x=1761043238;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fV7/jrMkBaJn6/SK6psmoZxBrmB/QuRq2mi1M4MJLDM=;
 b=LignF9rYInX72RYU5bbHlDn+IWqhOrHqoyH/lGCQqLG5b8/9UeAJyaoNvkDSA1csml
 LkjqGSYU0dq37YjTQyESOsVJE6PIb3ErFUgRT5VTb2pTDWvz9y+RSALuR44hspu939gz
 WRALBXpVSJDdsSZg65XSvf6UC4z9XUzczjZZtaddnHhGop7ywxGeaRnF0ammLnACzCkY
 w4HVOjDez1Tq1S3yqgRtXXov9wbyh3BTdWyzjK16U61A04wEOoD/lId7v/aDLcu8Jp1M
 QcLprffP6ehu4QU0vKsr657pp5KKsmyq0/MqfBUh8QrW7WY2dNPI4NoC4ZHwQe+AY9aC
 DpIw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVwTOdjspULSDPKyK6woHe4YEJgSVmENiWbDI3e3k5+N6q7G6kTDBiA1TCLzrgQYRFAJL1vRIUpAYZf@nongnu.org
X-Gm-Message-State: AOJu0YzZckQjv7TK40rDzswjjsELeov1U2XglrCiMdwKx4iJFVxpWk+D
 cYU6HudPbAzvMmVXYWA+mKvdl2l0FloLfQkPxHQozsb47pGioE8gLfn1anWvze3SaaWOC8PUb12
 N4t8LSG3vHWSE9S8Me0mJb8939si+otQxp+7o+VEZOg==
X-Gm-Gg: ASbGncvuHqmfxY+bGcE030l5OYbrM1mha22OG+st+ceGKFXgdkFXnU1s04+k8QihwoL
 3Ktx/EReoUWeXPV3Wo7mC/9iNRI1awuRDNO6vq5fFAtAB0Bfmg4LJKKJXgDiUTViZcPwmq9INgM
 xNVx9SHDDNmFQiuA5m4EyydP7I/vN/p//6fgT5LWmsvoa/sn0cZ+I2NEryDW7KSNnl4lE9xjcr9
 wsLUNl5yo2R5zfpku9MeH/9xX92Ja3r/awzVvSwLQ==
X-Google-Smtp-Source: AGHT+IHU25n+NhO/XEBsOpVv+Dv7mHjyhEKj989SEiZfz77ncLsJkxn7uC2b82nVld78ZQAkn2bckryrhV0afokk0ek=
X-Received: by 2002:a53:cec2:0:b0:62a:b545:54b6 with SMTP id
 956f58d0204a3-63ccb8f2f76mr15802555d50.35.1760438437741; Tue, 14 Oct 2025
 03:40:37 -0700 (PDT)
MIME-Version: 1.0
References: <20250708115238.667050-1-peter.maydell@linaro.org>
In-Reply-To: <20250708115238.667050-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 14 Oct 2025 11:40:26 +0100
X-Gm-Features: AS18NWBgEyajiYmPUV-neW3F_hyeBVXdjoo5-mhRmEe8VsCU4lpfFONRodvhii8
Message-ID: <CAFEAcA_MqNWHJ62sRCCK5s6-V6-qA4BWP5aFp0PZPeLDyXbYOw@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] hw/intc: handle GICD_TYPER2 for KVM GICv3
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: Eric Auger <eric.auger@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12c.google.com
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

On Tue, 8 Jul 2025 at 12:52, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> The GICD_TYPER2 GICv3 distributor register is one that is added
> for GICv4.1; previously this was architected as a RES0 location.
> Our TCG GIC doesn't implement GICv4.1, but for KVM the kernel
> might support it.
>
> This patchset:
>  * makes GICD_TYPER0 reads not trigger a bad-read trace
>    event on the TCG GICv3, for the benefit of GICv4.1-aware
>    guest code
>  * migrates the GICD_TYPER2 register value on a KVM GIC,
>    so that a mismatch between source and destination
>    can be caught by the destination kernel
>
> Note that I have only very lightly tested this, on a
> host which (I believe) doesn't have a GICv4.1.
>
> Changes v1->v2:
>  * fix comment missing bracket
>  * fix reset handling so this works on GICv4.1 hosts
>  * move get/put code to be with the other GICD regs
>  * new patch 3 to drop a barely-used debug printf macro

I never applied this, I think because I was concerned about
not having tested patch 2 very much. But patches 1 and 3
are definitely simple and safe, so I'm going to pick those
up. Patch 2 is still probably a good idea, but IDK if I'm
going to get round to testing it, especially since I don't
have a GICv4.1 host to hand...

-- PMM

