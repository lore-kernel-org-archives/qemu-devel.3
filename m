Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9A2EE77188
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2025 21:45:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tUuuU-000770-Qy; Mon, 06 Jan 2025 16:45:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tUuuT-000748-I4
 for qemu-devel@nongnu.org; Mon, 06 Jan 2025 16:45:17 -0500
Received: from mail-yb1-xb33.google.com ([2607:f8b0:4864:20::b33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tUuuR-0005PG-5E
 for qemu-devel@nongnu.org; Mon, 06 Jan 2025 16:45:17 -0500
Received: by mail-yb1-xb33.google.com with SMTP id
 3f1490d57ef6-e549be93d5eso4922490276.1
 for <qemu-devel@nongnu.org>; Mon, 06 Jan 2025 13:45:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736199913; x=1736804713; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q1fK9bXE7L4EjYg2zKsnZZ1K2teUmx39u5sxbf95Jis=;
 b=uX5UrFurxOdBRURURwWZgR/uRa9bSZTYos9d4Tr5wSWTEaiA9rQX1X/UrIeQpVOoSN
 CaXEpRkqTnhxcpsEx41kHNy0uyQZxoAwWOOQGlLjgt1noTrXKaSKhVoC7f0H49d7hfWd
 puMQdJ4X1OSkJMG4vsc30DCVVBLRx60TYSw0unsnQ93chrfeJHv8ZcKiv6sR3niOC1f8
 wrSuldH54so7/vWqhYOIrGtMqklKUukBeFahoaaivosOJ/Ysz3JXiNgfDi7EJjXwYUx9
 HDeCVbE6v7jZkEbhh3qnvY1zV2l3G9vTBoVsCUjUecIS55k6v9hPIAqKV5VewQcRYVvf
 Y9Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736199913; x=1736804713;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q1fK9bXE7L4EjYg2zKsnZZ1K2teUmx39u5sxbf95Jis=;
 b=FNpsN2P2qswcgW3AV/PAvivoeWkCDPlARRsBzh9f3z0SvEBYs3QRv/KJXPousnWSy0
 5GzuL/HNOHYyRzMU+QVoHN8Ao5ECfwXKxwfyH9+qhCF4J3Y0jOQ8bbjKBNhCIOWlLh+o
 BXiIGfcYzApJ6GhT/uXcFwnbuzjAC0jAvF4pzYQv2jnmtYtFevY7piOg/x+RxkaIdjgp
 4NEX2drEf6EFfMqsEzmX1y9hvhTc3ete872XYw6743XAZJjyYVwIBKXbb3tm2jy/OYdR
 m73QKkq0s0J8cJ+uixoZJeVEG17UxYXymDNIt4qQJzPJP/9tHPf/CP374mnnqcEdvp9C
 TQzw==
X-Gm-Message-State: AOJu0YxLTe1dGDmQ/IeDPQm03n6tfdf5nYcAib2TxAKYND4mL0ERO0Eh
 w5StgBbsaxudY+r+2m6Vq3/EdWKMv314LPYYl/DTXGcGQW1gsmw99wTCHcqfxZoW7tN09TQDocF
 7M8jpErOmhNQXkA9jzDSeef927i06CJ+HKobP+g==
X-Gm-Gg: ASbGncuOqjj6zjNky+6fXv3+2k8rPHpuY28DDW/VQsBdlKwVX2IbFA282wjk4Jfpaqp
 UbUhcD2GEtDvEF9IYmYg3v1NLH6Jd1EXJn5J4xGM=
X-Google-Smtp-Source: AGHT+IE7BafNTBM1zGWS5pdfLc2LVAgp9SZzBbs9+dM8oKD4l3xs5b59A3eAjRBYsgTl1oPuGfjRMQUSj3aAU5rYLFs=
X-Received: by 2002:a05:6902:1683:b0:e39:8558:d9c5 with SMTP id
 3f1490d57ef6-e538c25ca62mr43210270276.18.1736199912829; Mon, 06 Jan 2025
 13:45:12 -0800 (PST)
MIME-Version: 1.0
References: <20250106182343.35859-1-philmd@linaro.org>
In-Reply-To: <20250106182343.35859-1-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 6 Jan 2025 21:45:01 +0000
Message-ID: <CAFEAcA8mxMP=aSrd1=dL0dMzWzHZAF4B5TC=READYiDRLuURQQ@mail.gmail.com>
Subject: Re: [RFC PATCH] target/arm/arm-powerctl: Restrict to ARM cores
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, Alistair Francis <alistair.francis@wdc.com>,
 qemu-arm@nongnu.org, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>, 
 Eduardo Habkost <eduardo@habkost.net>, Anton Johansson <anjo@rev.ng>
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

On Mon, 6 Jan 2025 at 18:23, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org=
> wrote:
>
> When running on a heterogeneous setup, the CPU_FOREACH()
> macro in arm_get_cpu_by_id() iterates on all vCPUs,
> regardless they are ARM or not. Check the CPU class type
> and skip the non-ARM instances.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  target/arm/arm-powerctl.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/target/arm/arm-powerctl.c b/target/arm/arm-powerctl.c
> index 20c70c7d6bb..a080a6ab79f 100644
> --- a/target/arm/arm-powerctl.c
> +++ b/target/arm/arm-powerctl.c
> @@ -36,9 +36,11 @@ CPUState *arm_get_cpu_by_id(uint64_t id)
>      DPRINTF("cpu %" PRId64 "\n", id);
>
>      CPU_FOREACH(cpu) {
> -        ARMCPU *armcpu =3D ARM_CPU(cpu);
> +        if (!object_class_dynamic_cast((ObjectClass *)cpu->cc, TYPE_ARM_=
CPU)) {
> +            continue;
> +        }
>
> -        if (arm_cpu_mp_affinity(armcpu) =3D=3D id) {
> +        if (arm_cpu_mp_affinity((ARMCPU *)cpu) =3D=3D id) {
>              return cpu;
>          }
>      }
> --

Makes sense -- the function is "get me a CPU with this MPIDR",
so in a heterogenous system we can happily scan all the Arm CPUs
(even if they're in some other SoC) and trust that the caller
passed us a MPIDR that makes sense. (The callsites might need
some work if we wanted to use those SoC models in a heterogenous
setup where they're not the only SoC -- eg the imx6_src devices
assume the CPUs in the SoC are numbered 0,1,2,3 -- but we don't
need to do that now.)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

