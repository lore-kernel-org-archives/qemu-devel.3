Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14707E77188
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 12:55:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWEWo-0003Ym-V5; Fri, 10 Jan 2025 07:54:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tWEWn-0003YG-GQ
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 07:54:17 -0500
Received: from mail-yb1-xb2d.google.com ([2607:f8b0:4864:20::b2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tWEWk-0000w6-Kt
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 07:54:17 -0500
Received: by mail-yb1-xb2d.google.com with SMTP id
 3f1490d57ef6-e53a91756e5so3552346276.1
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 04:54:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736513649; x=1737118449; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U2Pwv5ix08ns8anJXREo7kPYoek+CuMGlSlbWb43ZZg=;
 b=nqUBFStdZHzexNvGBujj7mQYFEkdHbb2Tm+LC2hHIRfXOvJKIghV23B5DMa+iSx7Gv
 4SWqLyB9rbSWey588u27PyJTV7VohnOmBU4FHb2IzRrwSkXnltfbRL7mOos8zTZB2RGN
 YOTTnGOIrnQl1/M0crUTSuBrUKE1b2w8QQLEaFfA7ewrV/4CMuYIysJDfzjDALqrty0F
 IMiaQGtZReVFK3b7VaPhJBiofmqVOoapE04IEJyhZWrmBfdyRjHyb6ZfED0WUM/6zH2O
 zvqvkRjs9zd6LpsEvYJFXUHScNqpT5sv8bdc+9ev9DFoUtfNvoa5D82ixKDhLktiWeZz
 heCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736513649; x=1737118449;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=U2Pwv5ix08ns8anJXREo7kPYoek+CuMGlSlbWb43ZZg=;
 b=U23dJ1kDmqXFUzYZxomQOldK8r7UH3YVO9t9Qg8mcq/9q4h+0nIPwkCHMtsAOrEZNp
 w2ImnI9+ECZwPju1VkwwTIy6MEZMuv5LR9DOi/TE7Ipmfjxn6wnSaTJYQxXWf0G8gsW0
 pTyUq/Nd+b/qfMM+AdlZmdbGtIe+t+4Ir0Ih1D4GYcMd/YRqTx4hnGYd9s/C7NervSSt
 TlPSX/rQFEEzpFvcixUG9ep7zoXAZsX6m7SoLKcc7vStwOiwMfxbLAOi+kSlKzLgHrlr
 9uKo/4drvkDbUETtenPRVXI+CKpJ4BcV6k28liqmmauc3yUNr7yxKu7okz0YZ1rkUQv5
 VB1Q==
X-Gm-Message-State: AOJu0YyhNt7ygkK5EMUqLSCMlTDXIrTxENyIZ1vxePx37dccqV9a5Iho
 MlhuUx/2DbuPdsvD6lgOmUP0axDenF8DulhqTyWDgz16DdyJWW+HK9ZJu/fzeW3piZTxuGkrGxb
 Vtv+n8jR3KYM6JNfIkTQHc2CTHINsvc1P68zRiQ==
X-Gm-Gg: ASbGncvh1QAmNPVw4YI/oQVnV/i5dFDCYeqCJOJMaHTuIkdt7hekEQGEIVi35YrVUAL
 neaCliJyTOgXgG9b4J7MJfW2GOCJS23M3x3k0Qh4=
X-Google-Smtp-Source: AGHT+IFt+d03XrqZkhMQFpLqQChDPMK/VkmFwZgIMFoPc7Zkc4LuBh1EGCNwYk4Vo5J9paq1V5ypDyO2Jt7omVGQB1Q=
X-Received: by 2002:a05:690c:6b02:b0:6e5:9cb7:853c with SMTP id
 00721157ae682-6f5312a2e9cmr94025347b3.31.1736513648785; Fri, 10 Jan 2025
 04:54:08 -0800 (PST)
MIME-Version: 1.0
References: <20241218181511.3575613-1-alex.bennee@linaro.org>
 <20241218181511.3575613-6-alex.bennee@linaro.org>
In-Reply-To: <20241218181511.3575613-6-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 10 Jan 2025 12:53:57 +0000
X-Gm-Features: AbW1kvYBTCbgZxe0lauhdW7RhCOk5dnJDw2p2BNCmSxRLVT_iNaqD9Mh9sXpzcw
Message-ID: <CAFEAcA8aWRwwo_0j7P1YMr0Ez3H-1T132w6ygYYjHfnZMEugUg@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] hw/arm: enable secure EL2 timers for sbsa machine
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Leif Lindholm <quic_llindhol@quicinc.com>, 
 Leif Lindholm <leif.lindholm@oss.qualcomm.com>, 
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Radoslaw Biernacki <rad@semihalf.com>, qemu-arm@nongnu.org, 
 qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2d.google.com
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

On Wed, 18 Dec 2024 at 18:15, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Cc: qemu-stable@nongnu.org
> ---
>  hw/arm/sbsa-ref.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
> index e3195d5449..c02344004e 100644
> --- a/hw/arm/sbsa-ref.c
> +++ b/hw/arm/sbsa-ref.c
> @@ -484,6 +484,8 @@ static void create_gic(SBSAMachineState *sms, MemoryR=
egion *mem)
>              [GTIMER_HYP]  =3D ARCH_TIMER_NS_EL2_IRQ,
>              [GTIMER_SEC]  =3D ARCH_TIMER_S_EL1_IRQ,
>              [GTIMER_HYPVIRT] =3D ARCH_TIMER_NS_EL2_VIRT_IRQ,
> +            [GTIMER_SEC_PEL2] =3D ARCH_TIMER_S_EL2_IRQ,
> +            [GTIMER_SEC_VEL2] =3D ARCH_TIMER_S_EL2_VIRT_IRQ,
>          };
>
>          for (irq =3D 0; irq < ARRAY_SIZE(timer_irq); irq++) {
> --
> 2.39.5

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

