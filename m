Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73AEEC021B2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 15:43:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmx4t-0001Fb-7H; Tue, 25 Feb 2025 10:42:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tmx4r-0001FI-VJ
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 10:42:34 -0500
Received: from mail-yw1-x1132.google.com ([2607:f8b0:4864:20::1132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tmx4p-0007yy-Pl
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 10:42:33 -0500
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-6ef60e500d7so46625757b3.0
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2025 07:42:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740498150; x=1741102950; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XhLtDZFjIsdXqAUO49Dsl2m2rH6wYl5FqeMpQfMxamQ=;
 b=S/QeatSxzgYlkNnpO8ijoYnRheosR8K5mvhXqC2U9Taxl7dbxCnY/nJS/wocxTkDJo
 7aM/kq//Oc3e+XlHbu7oFvkOpFEjahFMKCFkMByaDpVswn70raJS+OJW8IF+2qFiDNB9
 dVMRPG4yUzyMYo/t/3c1q2Odyxx0trd8eoCs7K3dPW/00oYxirfYLLt+Y8LcwrcSSYnx
 0l9pFEIYg7+mKDnw8enhaCqTkPlAOqPVAlbhDpM9agN2cJLAIYiRH0IQYwvXjcx43iXW
 MGkDtOwSazA/uApUUEccAm2N8KpbyA4BZyM1XdGb68BkVcw3enPUCZXTSsWXFzHtXT97
 JVXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740498150; x=1741102950;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XhLtDZFjIsdXqAUO49Dsl2m2rH6wYl5FqeMpQfMxamQ=;
 b=peKYtQ5CkH6cm24kzO6Ez1vzN69WitkrxR9c6vyMwR+FIL0XYYF0XV9XrLDx2g4xwe
 ZMIZc9bxi0M8HPeaVlpFdHnS9ZziZyBJi21oeWXmTPs+bTSU4u7JlEk+e5hjvxiqN5Rv
 WJKgg8W4nrLL6otGMkhfI5c6Qk7a9Ai/amLPQbgYHFT/tqd6fg/By/ssevtAjS5EthCf
 QqUSyDzaUcqOhCF85/mwzn8yK+q36bMlZtlxWL4XYtaIaU5lORyXYM1IZzEqpJfEkwav
 sGllKRk6Il5RBQS9MKyJj/Wb47AJzhyM90AwuyZx+V2FYlwBdyFMNfojb5wrj6tr0hBk
 dUbA==
X-Gm-Message-State: AOJu0Yx7zhNMPHCeG67UBX60fLifSiWTdB2Iaylcl6xqnMMPShUuoXqi
 OL8+UHNO2XpemRc3d1PlQdOKp2lBUoKFBrIqcXgVqcuaAeP84FI5T0iisgLm/GC91bZmtqKCIJ7
 7eTNS2mk38axzDtPj5KnH0jCTBSbwLGLNcBQ1iQ==
X-Gm-Gg: ASbGncv+IfUOYd1XIqBi72D/sBKuCZpz4XgIOhwBMZkKsWDsC8stITcV4jbQFsVUB25
 jqw0nDweISXV1YQ6TtsDRfHNMqjxgGRdKeF0EKZLmWTFtuJCRVMAiTuXcRYRNQlQ1NRguCRWWaX
 IvXk454Wmj
X-Google-Smtp-Source: AGHT+IEqYHCBXbBIggQhDAil9NV1+NJ9zcdYzVH7ADYbLOeQFD03aoI30KNiiCJlQGE74KIMeX+CaNTG2ejAE7XoJvI=
X-Received: by 2002:a05:690c:2b90:b0:6fb:a4e6:7d35 with SMTP id
 00721157ae682-6fc19dedc59mr99189807b3.9.1740498150315; Tue, 25 Feb 2025
 07:42:30 -0800 (PST)
MIME-Version: 1.0
References: <20250223114708.1780-1-shentey@gmail.com>
 <20250223114708.1780-5-shentey@gmail.com>
In-Reply-To: <20250223114708.1780-5-shentey@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 25 Feb 2025 15:42:19 +0000
X-Gm-Features: AWEUYZkE_IKGHM3oZ8mJHOPz2fqfDzkFe4ZYvoduiJsoaBeEv03XlwJGhbjIPuk
Message-ID: <CAFEAcA_XJfAVEe3cgHiXgcewTL3kF3SEevrnMh-Edvfk56G6sQ@mail.gmail.com>
Subject: Re: [PATCH v2 04/18] hw/arm: Add i.MX 8M Plus EVK board
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-arm@nongnu.org, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Laurent Vivier <lvivier@redhat.com>, Andrey Smirnov <andrew.smirnov@gmail.com>,
 Fabiano Rosas <farosas@suse.de>, Alistair Francis <alistair@alistair23.me>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1132;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1132.google.com
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

On Sun, 23 Feb 2025 at 11:47, Bernhard Beschow <shentey@gmail.com> wrote:
>
> As a first step, implement the bare minimum: CPUs, RAM, interrupt control=
ler,
> serial. All other devices of the A53 memory map are represented as
> TYPE_UNIMPLEMENTED_DEVICE, i.e. the whole memory map is provided. This al=
lows
> for running Linux without it crashing due to invalid memory accesses.

> +static const struct {
> +    hwaddr addr;
> +    size_t size;
> +    const char *name;
> +} fsl_imx8mp_memmap[] =3D {


> +    [FSL_IMX8MP_UART2] =3D { 0x30890000, 64 * KiB, "uart2" },
> +    [FSL_IMX8MP_UART3] =3D { 0x30880000, 64 * KiB, "uart3" },
> +    [FSL_IMX8MP_UART1] =3D { 0x30860000, 64 * KiB, "uart1" },


> +    /* UARTs */
> +    for (i =3D 0; i < FSL_IMX8MP_NUM_UARTS; i++) {
> +        static const struct {
> +            hwaddr addr;
> +            unsigned int irq;
> +        } serial_table[FSL_IMX8MP_NUM_UARTS] =3D {
> +            { fsl_imx8mp_memmap[FSL_IMX8MP_UART1].addr, FSL_IMX8MP_UART1=
_IRQ },
> +            { fsl_imx8mp_memmap[FSL_IMX8MP_UART2].addr, FSL_IMX8MP_UART2=
_IRQ },
> +            { fsl_imx8mp_memmap[FSL_IMX8MP_UART3].addr, FSL_IMX8MP_UART3=
_IRQ },
> +            { fsl_imx8mp_memmap[FSL_IMX8MP_UART4].addr, FSL_IMX8MP_UART4=
_IRQ },
> +        };

The C compiler for the OpenSUSE CI job doesn't seem to like this:
https://gitlab.com/pm215/qemu/-/jobs/9239416833

../hw/arm/fsl-imx8mp.c: In function =E2=80=98fsl_imx8mp_realize=E2=80=99:
../hw/arm/fsl-imx8mp.c:382:15: error: initializer element is not constant
             { fsl_imx8mp_memmap[FSL_IMX8MP_UART1].addr, FSL_IMX8MP_UART1_I=
RQ },
               ^~~~~~~~~~~~~~~~~
../hw/arm/fsl-imx8mp.c:382:15: note: (near initialization for
=E2=80=98serial_table[0].addr=E2=80=99)
../hw/arm/fsl-imx8mp.c:383:15: error: initializer element is not constant
             { fsl_imx8mp_memmap[FSL_IMX8MP_UART2].addr, FSL_IMX8MP_UART2_I=
RQ },
               ^~~~~~~~~~~~~~~~~

This is (gcc 7.5.0 "cc (SUSE Linux) 7.5.0") apparently. That's
a pretty old compiler, only just within the bounds of our
version requirements (which are 7.4 or better), so I'm guessing
it's just not as smart about figuring out that the
initializer here really is a constant value.

I'll fix this up by dropping the "const" from the serial_table[]
etc definitions.

-- PMM

