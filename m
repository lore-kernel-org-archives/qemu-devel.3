Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF9C5D58D69
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2024 17:03:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFcTo-0003Wy-Kt; Mon, 25 Nov 2024 12:02:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tFcTm-0003Vm-KP
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 12:02:30 -0500
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tFcTk-0000rn-SC
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 12:02:30 -0500
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5ceca0ec4e7so5821068a12.0
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2024 09:02:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732554147; x=1733158947; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=eqLkZhZ7p76k8PAt3meHFxaU003h0npuWguDuJNfBSw=;
 b=Wr3kYMDauL+UnfOlgLGAB0KKH1OpcqoltxOMgdl1GKXInCGZibZBMOBEKNkp8t7kHh
 HBd8HRsTnLLDBpu5IL5JwxQVV7AQFNsta/aNVThPWSq/alfj4zqSdy++x3iLnFIAaVv/
 ep3BE1X7+Fe5v1YlW4olBL/HBu6dqR1gxnA8dGftiE74gywkwGJLIq+rLCiIAL3+aDXL
 IKrqp42Z3ll+8Un6mu6KsYdKuCYqUGosJkETBl5gs0dT8I16OOgJ4lqcZWswpuQ47nF3
 6VCa4ECaF6oNeOtNH4Z3YQCCeW439dmVOzweR1X+VN7uNjsLGkSdXXeI/I1HREJD6Z6m
 balQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732554147; x=1733158947;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eqLkZhZ7p76k8PAt3meHFxaU003h0npuWguDuJNfBSw=;
 b=trtGtR5qH4Ws8g0HxgFsSJpxsEuvWIRmLvvRPtyNVdCTOKnnAgztKfBuQNJBFOmEdh
 bVArEYFGEJH/IchQDOIguu+eBID15bBwT026tgHlpWvJ3ccgdE06fs6LOgFUvr3vV5Tr
 sjuBs6ZpxC6GD0nxErgT5HcjreaNjiA5qGc/oOWvd4imUttAf9aZtlNy9U4nWOmMK7Or
 RKKhyb6tsJlbbZk41tShmPy0pGGQspOUl9VLHKK20Kma11hmRCYCHMvX8F+kdMU9IMok
 /X7189thaoaKOyQF6TJPwMm/G2v3aqcJ6pXo+NpGqoosjGQMwOo0pcaupf73tt7we9CU
 SlaA==
X-Gm-Message-State: AOJu0YxoaNYHH5UEVioJSto4V6EBcxGRIDAO5im5e9PfQ/7IyR45sfjz
 B9WJNJUTF1VAf8JwUWbKlmEJS0ypXt7WE7g+rwOUbWHkj3YpDB5sdBOY2Y0cj0dIiTVnDSWkgdK
 ivhZZDMYDkhh2QuaQ8fuN9sQfeY5yhqznUUupjA==
X-Gm-Gg: ASbGnctivfaDzndStmHdpUXe1BffRN10yC6NdJNVz5f8q8RJlGdTeX1kk2uoCwvs9Dp
 U5VMjOnpK09dgI9BVwKp/uPiyot5WtkWP
X-Google-Smtp-Source: AGHT+IGz/86ZqJMIYRap/sJ993dRDzOWvj+mJ7093Ami+8aSJ2bj+9kUBYiZcETg0KqO9rcJbZ9oxnDq8SknuVLC//0=
X-Received: by 2002:a05:6402:210e:b0:5cf:ba57:b213 with SMTP id
 4fb4d7f45d1cf-5d0205a805bmr11366382a12.2.1732554146874; Mon, 25 Nov 2024
 09:02:26 -0800 (PST)
MIME-Version: 1.0
References: <20241122225049.1617774-1-pierrick.bouvier@linaro.org>
 <20241122225049.1617774-12-pierrick.bouvier@linaro.org>
In-Reply-To: <20241122225049.1617774-12-pierrick.bouvier@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 25 Nov 2024 17:02:16 +0000
Message-ID: <CAFEAcA8BhxbGH7xD8rpwRq2yG-FCef2yiNc6DWVmPgTFXEbLKA@mail.gmail.com>
Subject: Re: [PATCH 11/12] docs/system/arm/virt: document missing properties
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 alex.bennee@linaro.org, Steven Lee <steven_lee@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm@nongnu.org, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Troy Lee <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, 
 Joel Stanley <joel@jms.id.au>, Alistair Francis <alistair@alistair23.me>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52e.google.com
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

On Fri, 22 Nov 2024 at 22:52, Pierrick Bouvier
<pierrick.bouvier@linaro.org> wrote:
>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>  docs/bypass-iommu.txt    |  2 ++
>  docs/system/arm/virt.rst | 15 +++++++++++++++
>  2 files changed, 17 insertions(+)
>
> diff --git a/docs/bypass-iommu.txt b/docs/bypass-iommu.txt
> index e6677bddd32..62818e44ed9 100644
> --- a/docs/bypass-iommu.txt
> +++ b/docs/bypass-iommu.txt
> @@ -1,3 +1,5 @@
> +.. _bypass_iommu:
> +

This is a .txt file -- adding rST markup to it won't do anything :-)

(It's one of the remaining legacy .txt files that we haven't
yet converted to .rst and moved to the right place in the
documentation. The .txt files in the /docs/ directory are
mostly the awkward ones to convert because they are a mishmash
of internal info about the implementation and stuff that is user
facing, that needs to be pulled apart by somebody with some
familiarity with the feature and moved into the right places,
or in some cases simply deleted as unnecessary.)

>  BYPASS IOMMU PROPERTY
>  =====================
>
> diff --git a/docs/system/arm/virt.rst b/docs/system/arm/virt.rst
> index 11ceb898264..d3d21499ff5 100644
> --- a/docs/system/arm/virt.rst
> +++ b/docs/system/arm/virt.rst
> @@ -169,10 +169,17 @@ iommu
>    ``smmuv3``
>      Create an SMMUv3
>
> +default-bus-bypass-iommu
> +  Set ``on``/``off`` to enable/disable `bypass_iommu <bypass_iommu>`_ for
> +  default root bus.
> +
>  ras
>    Set ``on``/``off`` to enable/disable reporting host memory errors to a guest
>    using ACPI and guest external abort exceptions. The default is off.
>
> +acpi
> +  Set ``on``/``off``/``auto`` to enable/disable ACPI.
> +
>  dtb-randomness
>    Set ``on``/``off`` to pass random seeds via the guest DTB
>    rng-seed and kaslr-seed nodes (in both "/chosen" and
> @@ -186,6 +193,14 @@ dtb-randomness
>  dtb-kaslr-seed
>    A deprecated synonym for dtb-randomness.
>
> +x-oem-id
> +  Set string (up to 6 bytes) to override the default value of field OEMID in ACPI
> +  table header.
> +
> +x-oem-table-id
> +  Set string (up to 8 bytes) to override the default value of field OEM Table ID
> +  in ACPI table header.

Do we have a policy about whether we should explicitly note that
x- options are not ABI-stable when we document them?

thanks
-- PMM

