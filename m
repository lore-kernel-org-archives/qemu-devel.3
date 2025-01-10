Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C4AEE77188
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 12:54:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWEWG-0003VQ-BE; Fri, 10 Jan 2025 07:54:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tWEW6-0003UP-0R
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 07:53:35 -0500
Received: from mail-yb1-xb34.google.com ([2607:f8b0:4864:20::b34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tWEW3-0000td-1g
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 07:53:33 -0500
Received: by mail-yb1-xb34.google.com with SMTP id
 3f1490d57ef6-e455bf1f4d3so2629990276.2
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 04:53:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736513609; x=1737118409; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kWegaTGjGYYZdIDVVNgoD88AutCLkQYnxatFZ5TUBgo=;
 b=IHx4ybX+bdQmHLkfJEtT6qwZTXqUE4yXm23ODX5fZrKJWB0LtT6PljSt2RvXj3Ga0a
 qK5BkTjJsJAk44juSiEZ1MpDmrZAlbQ0bKMe/UaiZGfZqf9Cs/yYtSoDxbcDAmMR9UQe
 vgIPlvABf7DZmVT/M0FLfO6iggLv9FvfA4SaV7Pgm5/T3rP+3b9G9EF0TcUKE1xDOkM2
 Xh9FoFCD3C+M/k0ah28szXck1OkCnQYuMDdaXj4JK0YRPdLes0+hJ3umbYQzTyJ+PFF5
 Yb9Qkf+akzTnxAUH9eRJ+30NPKzcuKPBLygLTr/hrPGSUgKQvIyuZsE55HB8SdebArte
 SdEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736513609; x=1737118409;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kWegaTGjGYYZdIDVVNgoD88AutCLkQYnxatFZ5TUBgo=;
 b=tzQekGNOOoqji10W7zqQQsK1uELz78Bbzo1+s7903oZBROpDnTGBJCWtBVsuE4w1ou
 h+2bhPDx5ynW6KNQ0CWwXFb7zdz0DdT4Z7aFzzo3px4UHSNga4Z8I8s81EeJmAqD2lfD
 HVWX8CfmVqob7TEsVSmpQTegwtjFKsX2Sv73tIHGZiE5B30evD1CE27iHf/bUL6nhvex
 xuwEA1tIuBSBzCdRh/rPai1l6OKuN5fOaiPi9aJ7/tSY8SkcD6M+AmvLttBHYZyJl8UY
 m8L93wFR68x5iyGplJKTiQK7b/dNcf6YRsg8M4E5zZRki8sIsksS6hvNAOJcmBYx1V1e
 B6ng==
X-Gm-Message-State: AOJu0Yw1RWzp5dWcg9Hcm+veAo0ImoClT6wBB4qlc439HxQm1qbTnEtn
 2AXjj0vTQbD4sFrh8uPCOkofp1Fw6mjFRGoypSSFFUgrcNOz3csM4ateOcyxhfehVj4MoOkWcH1
 Ecc6lR+18fVlc8uCWTMvAlx2Xf5sA2zTRpVkFvQ==
X-Gm-Gg: ASbGncveDJVWadTsUN8qsx2Up4foW9b3a5Z+7cu7cpcBHS5fPyRJvrJaloSprz8Q8q9
 53lFU/RId5Ew7QaJjbvHBnOfATYNkoKSMjV8gLf0=
X-Google-Smtp-Source: AGHT+IELVji2idLYe2nhfhTZuG3Le1/4nA74O7PSpXkG4lcOo3MhkV4Rq2r6cRnpaBLukdxm1T4JzJco6XfELTZbKUw=
X-Received: by 2002:a05:690c:6707:b0:6ef:6edb:fab2 with SMTP id
 00721157ae682-6f5312d3fdamr84293377b3.37.1736513609553; Fri, 10 Jan 2025
 04:53:29 -0800 (PST)
MIME-Version: 1.0
References: <20241218181511.3575613-1-alex.bennee@linaro.org>
 <20241218181511.3575613-5-alex.bennee@linaro.org>
In-Reply-To: <20241218181511.3575613-5-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 10 Jan 2025 12:53:18 +0000
X-Gm-Features: AbW1kva2apTDuTAPBwwn8gcJVFVpyAT4uoeSNDEdmmFIVrCjtAZcwESwZ9k-g5E
Message-ID: <CAFEAcA_yqw2DJ_iPpwYXjsR_h1gAZdOs29b-2ar0QOg4k4D0hQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] hw/arm: enable secure EL2 timers for virt machine
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Leif Lindholm <quic_llindhol@quicinc.com>, 
 Leif Lindholm <leif.lindholm@oss.qualcomm.com>, 
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Radoslaw Biernacki <rad@semihalf.com>, qemu-arm@nongnu.org, 
 qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b34;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb34.google.com
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
>  hw/arm/virt.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 333eaf67ea..5e3589dc6a 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -873,6 +873,8 @@ static void create_gic(VirtMachineState *vms, MemoryR=
egion *mem)
>              [GTIMER_HYP]  =3D ARCH_TIMER_NS_EL2_IRQ,
>              [GTIMER_SEC]  =3D ARCH_TIMER_S_EL1_IRQ,
>              [GTIMER_HYPVIRT] =3D ARCH_TIMER_NS_EL2_VIRT_IRQ,
> +            [GTIMER_SEC_PEL2] =3D ARCH_TIMER_S_EL2_IRQ,
> +            [GTIMER_SEC_VEL2] =3D ARCH_TIMER_S_EL2_VIRT_IRQ,
>          };
>
>          for (unsigned irq =3D 0; irq < ARRAY_SIZE(timer_irq); irq++) {

Do these timer interrupts have a defined devicetree binding that
we need to set up in fdt_add_timer_nodes()? How about ACPI?

thanks
-- PMM

