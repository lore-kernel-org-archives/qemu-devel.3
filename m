Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6AB5C02194
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 14:04:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfJWp-0006Vk-O8; Tue, 04 Feb 2025 09:03:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tfJWh-0006Tx-1Z
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 09:03:43 -0500
Received: from mail-yb1-xb33.google.com ([2607:f8b0:4864:20::b33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tfJWf-0007q4-8t
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 09:03:42 -0500
Received: by mail-yb1-xb33.google.com with SMTP id
 3f1490d57ef6-e5b1c7c31b2so394390276.1
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2025 06:03:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738677820; x=1739282620; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TGEcgwdOq63SM+XpAFJuAZbtcoHs6MQceTH+qYFSB5c=;
 b=IjIwQN0d3k4cq/J0WdnPSWTnxqIl5W9+KDXMKFKka1vaNRZvnXk/q2LdxhusTtwPdI
 bA+96PlMaAw042XcmGV1nK/4YIqoC8LU8ItLZxGdwFPUGbNrcuRty039vauDsg4h/P1l
 rkJPWo6q2nJGKWQNDccbVsLF4DQv6x/vyO9wTTwuTr+wlBJJ5pMUFTLNI47nR3zVZ6Wk
 b/izphE7AAXhIszugAycfOUU9vexnkTmwk3bJlGyikS0rNLnhDA6vvCOmNwou8ilowoO
 UZVqZA9ziVgII1U4R352BONAhUdqcK/OR7KjDtft9tKGJ+Oiv1LIVZdwWOeKDY3Fixy1
 NFBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738677820; x=1739282620;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TGEcgwdOq63SM+XpAFJuAZbtcoHs6MQceTH+qYFSB5c=;
 b=mfXnzv6SQKXP+i9GpDl/5PVjkgsZJky0v0Zuw8C80A/3JacKnLHTqIa/FJzO4BBO44
 ie9ESzXiELK97HTfdPs+sCfOAf1eCES377bYEHXBK7EyGAY/nfH9pPNZDEjR1noGDOBS
 XHJ5BhzLTih6CiH0eggRKTiUwX+R1GBYjR0C/ZMug9eGLMonzhdKKbh4DlG4o4F/vgBl
 w3N3DLGBccUP14/EJbt9FHO+2s+uKBwbB2Vz2+uRnorgjoLZLO26kfssmPNQmAaWc819
 17r1DyljNo1xM8u4I0M9v/H+Z1ad2ge5QR5DponhOR9ZuLS7zMrHYs74XqgQ5VBh4IdY
 CtYg==
X-Gm-Message-State: AOJu0YyZypc/C5aKNVESndgvrfYXrHp5KM4SryUzeHuNfT5eW00FDaZt
 VEQCBGDOTLSx8deMdnBUmHuBJd2sI4ZMQyMp6kzBA/uax6B+GS++GI7BtpWsir0fSHSVEIndyBN
 pnEkXTaPeHbCKQcsfVxw941nV5GqAdR/rjCboZ4X9ME1opyAM
X-Gm-Gg: ASbGncuDXHlIKXu9m4/ATZE78wzUJ/XOy4pnuzOeg5mTC3XwiWGZucVZHIKiCiQipG6
 PVu0/o8whisGzYr4MYf7zshxzlSDvA2rgxdohOQ7NQQ7QWO7xDkDxTpTn8/zXpkcKgpvMtaazIQ
 ==
X-Google-Smtp-Source: AGHT+IHshpdClxv3n/Oaqc/y1vK7LEpBaDDzVh3qYfytF+2SGtlGALhgRn7keRQZKUAk4I9LipoIGkqfFxSsIVi6ltw=
X-Received: by 2002:a05:6902:e05:b0:e5a:e7eb:280b with SMTP id
 3f1490d57ef6-e5b135ed77dmr3457761276.17.1738677819946; Tue, 04 Feb 2025
 06:03:39 -0800 (PST)
MIME-Version: 1.0
References: <20250130112615.3219-1-philmd@linaro.org>
In-Reply-To: <20250130112615.3219-1-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 4 Feb 2025 14:03:28 +0000
X-Gm-Features: AWEUYZntVqFRNM-9_6pImvMyLeQrhcdCtPME3sOhuUwZlQ9i0TSonCMq4dKYgjw
Message-ID: <CAFEAcA_UkvLU2erFMY0G9H5G-GnYEJuUP-Ox8kqtSNF=LOOEHw@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] hw/arm: Minor cleanups around MPCore code
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b33;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb33.google.com
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

On Thu, 30 Jan 2025 at 11:26, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> (series fully reviewed)
>
> Hi,
>
> This series contains the non-controversial and already
> reviewed patches (rebased) from this previous series:
> "Remove one use of qemu_get_cpu() in A7/A15 MPCore priv"
> https://lore.kernel.org/qemu-devel/20231212162935.42910-1-philmd@linaro.o=
rg/
>
> Posted separately to avoid keeping rebasing.
>
> Regards,
>
> Phil.
>
> Philippe Mathieu-Daud=C3=A9 (6):
>   hw/arm/boot: Propagate vCPU to arm_load_dtb()
>   hw/arm/fsl-imx6: Add local 'mpcore/gic' variables
>   hw/arm/fsl-imx6ul: Add local 'mpcore/gic' variables
>   hw/arm/fsl-imx7: Add local 'mpcore/gic' variables
>   hw/cpu/arm: Alias 'num-cpu' property on TYPE_REALVIEW_MPCORE
>   hw/cpu/arm: Declare CPU QOM types using DEFINE_TYPES() macro
>


Applied to target-arm.next, thanks.

-- PMM

