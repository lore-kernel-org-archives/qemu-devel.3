Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0F96C83030
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Jun 2025 21:04:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWLf4-0005Af-M4; Mon, 30 Jun 2025 17:03:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uWLes-00058y-Ly
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 17:03:23 -0400
Received: from mail-yb1-xb35.google.com ([2607:f8b0:4864:20::b35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uWLep-0004Bl-Di
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 17:03:20 -0400
Received: by mail-yb1-xb35.google.com with SMTP id
 3f1490d57ef6-e740a09eae0so4418612276.1
 for <qemu-devel@nongnu.org>; Mon, 30 Jun 2025 14:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751317398; x=1751922198; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=NmPND9wxci9DtmMrcq/WTTks2YO6OirLlpLmStV59AY=;
 b=JnJZ4ZpY6tUNOWCUU4E8tLqheacr2uWO9r31gkgzyqaVsV9lDX/QddVA3LUH/kZMnv
 rnurnUkCWLz/p0klNPeDrUxHftx5qMSFoLexJeeFgaAnZIxsblhRZqxnOwO83odMcasJ
 qhel92Lh0QKTGLM/Oe3CUsIRPA5ZIp2wACX3K8Y/obeecm4VHxPBJBJSFFssatxqG+BW
 5BMmrnuiTvkkokETeLqnE8uwUtgrTXoGbUP9wd8Yn4p883+c+npqr1bJ4SbrOW5d4Csr
 UDKY03eg3ahYIwq7ex997k0aRDIoAW6d1gvFEYFnJ4XiArjXAJlPEaUWYkjzMljF9TWk
 /eNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751317398; x=1751922198;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NmPND9wxci9DtmMrcq/WTTks2YO6OirLlpLmStV59AY=;
 b=mDSh2PLbmOATy5QD8IZYFe7rMixLJuazRlVMZFv+AXIVyIK57s/L3AdMQFHMDLu06f
 uzwoOMpqhLEz0FqznyvzzvWKAWgQMC1FwL2s7CYLipy9NTFW8SQkOTVgvmZ0HUAMcaWh
 W42bk4oKI8QlZ5x1bPjKt/M3/1rOeF6ypXVNsEFIoNaAkx1z1/q/Yzu7JO8NhVOlOUfz
 ey3dMz5S2p1ucx8mJdxNAbiHcR7UF9JiMgs0BdiKWwAJ23t5eJAhB4S/kccXTlVVV8WE
 DpYRMSMWKKem5lG02PuO0DV99KMxuwlkq71U4Ue1eCKHgpOIYdd5cat9yeoENljBvZs5
 q2uQ==
X-Gm-Message-State: AOJu0Ywj94bFNB5Bqixj7D47xX2ASyam6U8K96AcBciaU409MEeIdsPV
 gyyGRWhfYue4fd8Zd32iujZojmVk2Aab40ZzrTmU64vz+LJPGVRR6bTvKsomUzox6liYS++w0Jk
 /+IK9JqEjwPM/DfV8YTQ9+bTuiJjuteqSFb3ooHHR0g==
X-Gm-Gg: ASbGncsdksqMrEYsihVqjp3C41bCoqiO3+U1PUwdWbQcHQA1ubTntcIwCSyi7WDl8zy
 T+tfe0KmjL174ASIM8/oN5SGbjvMffFysy+fHWbJuMpece6mxpOYR0qy1D/l3GhZH/HHGyG+qHf
 WP2IWEhTlZgnhU0Ep4KZwRf4TKFL9tJZQ7l+LhtSBNSVfM
X-Google-Smtp-Source: AGHT+IECl4DFbOwoeMIHG0IB6MGWB5wMzLC6LaA6Hdnc39Et8vSr5r6lM6YFMG/YhGLQs1cqQLGiwOohN/rO71lWy58=
X-Received: by 2002:a05:690c:6b82:b0:70e:326:6aeb with SMTP id
 00721157ae682-71517160c29mr233568307b3.10.1751317397901; Mon, 30 Jun 2025
 14:03:17 -0700 (PDT)
MIME-Version: 1.0
References: <20250629204851.1778-1-shentey@gmail.com>
 <20250629204851.1778-3-shentey@gmail.com>
 <CAFEAcA-HaQwySM1j7Cy_R1z0fM1D9ykiBiMKLYNVYF+Tm_mrPA@mail.gmail.com>
 <78B2535C-38D8-4612-8958-49AC28482A8D@gmail.com>
In-Reply-To: <78B2535C-38D8-4612-8958-49AC28482A8D@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 30 Jun 2025 22:03:06 +0100
X-Gm-Features: Ac12FXy-ydrU040KxiliqQUefdv_6GYVq0EN1ZpAtNKvHvNcTBYSxfJAxb-sRsk
Message-ID: <CAFEAcA9b+1xx+Esnt80Ny1gWBOsh-QYYxuP6PwiPk-B20xv0Dw@mail.gmail.com>
Subject: Re: [PATCH 2/2] hw/arm/imx8mp-evk: Add KVM support
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b35;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb35.google.com
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

On Mon, 30 Jun 2025 at 21:22, Bernhard Beschow <shentey@gmail.com> wrote:
>
>
>
> Am 30. Juni 2025 09:09:31 UTC schrieb Peter Maydell <peter.maydell@linaro.org>:
> >On Sun, 29 Jun 2025 at 21:49, Bernhard Beschow <shentey@gmail.com> wrote:
> >>
> >> Allows the imx8mp-evk machine to be run with KVM acceleration as a guest.
> >>
> >> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> >> ---
> >>  docs/system/arm/imx8mp-evk.rst |  7 +++++++
> >>  hw/arm/fsl-imx8mp.c            | 33 ++++++++++++++++++++++++++++-----
> >>  hw/arm/imx8mp-evk.c            | 11 +++++++++++
> >>  hw/arm/Kconfig                 |  3 ++-
> >>  hw/arm/meson.build             |  2 +-
> >>  5 files changed, 49 insertions(+), 7 deletions(-)
> >
> >This puts a lot of IMX device models onto our security boundary,
> >which makes me a bit nervous -- that's a lot of code which
> >wasn't really written or reviewed carefully to ensure it
> >can't be exploited by a malicious guest.
>
> Hi Peter,
>
> Does KVM increase the attack surface compared to TCG?

Yes, because our security policy says that TCG is not considered
a security boundary, whereas KVM is:

https://qemu-project.gitlab.io/qemu/system/security.html

(It would move from "non-virtualization use case" to
"virtualization use case".)

thanks
-- PMM

