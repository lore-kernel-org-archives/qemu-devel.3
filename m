Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D155EC54E60
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 11:35:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk0Pm-00060D-SP; Tue, 12 Mar 2024 07:35:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rk0Pj-0005x4-MD
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 07:35:23 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rk0PX-0002Y3-Co
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 07:35:22 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5683093ffbbso6060903a12.1
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 04:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710243308; x=1710848108; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q6oa53FNojiU7XVQUGsskhkskziips1uYf6wI+pnEcI=;
 b=GTr44k7E1Iy7m08AZeWt82ZqQA9hMPMXo4cayyNWAvWY/nCrWhf1o5brYEmSTZcaAt
 3og/ErTc7boF9l8MnrDCLEURVKWP90MySKhqjnQlNIDAer9ei4CYjygtLuX38yRmCg13
 EXkCz7e1D/htatnpctzBz5CwdOKG6F4SFlYSOmiUssP8h3sYiEbdWGRMTwrcs0CtXgv7
 7BJnSDYRoQLLDvQEKatVNuhwRCFJBRUaSHtakZebmuqSu+VX1lcfemAieHrYT16UYU8Z
 3/c1KCcSmHmTKFtTGWRV6mGkZvCkkW63cvs/OEedykBDcafR88lg9JWgEtZIs1T8WJvu
 T6cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710243308; x=1710848108;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q6oa53FNojiU7XVQUGsskhkskziips1uYf6wI+pnEcI=;
 b=fm2BWmQWR6eKMhj5aur7f7gBUTRosyDKK4ZFkfTILSW4GCGRAZ2EU7EEKyVu86JNZU
 anzgjP3urAmufGoA4xDL61pQ7N7rQ7QxAuptdko/MEanetCISc9A9Mybh7EveJmkHlFh
 U9rdrNZq3+KxPEJguqIyOR5HCOqN647A4sCKzQ0AM67lceLsDaNGrEQuKsycn0eLZEaK
 7XO5HS/0WbXoi9GPr9EUw1MQoVSuv8n+mAniaa1KAE7TC+2+CIrFQ41a7MnsY14dtCBC
 6lSCPEbzXIMVBbd7+ZlD6Ujac640c6c83ngkp3sNt+IcSZEMVH26TSCPnV/QPj1sc5nl
 n8AA==
X-Gm-Message-State: AOJu0YwcYUsTFbJUSso7XkSRHeQg3rGpqnaVbtXmP4RqZ/AD19CsiMWx
 hdC5DENtL3DzMLhcZda4i9JIg032zemcWLQqYjs6RLoTZs8FvciLcNFnpy7MyopW/ahFrOKEJ5Q
 SLKueyIIgvO3Qx+Jj/fwQyf4gjzjVdQOwknrlFQ==
X-Google-Smtp-Source: AGHT+IFnAzlUuVw2vJtvyji5GO9b/YfCU3yaRbqRGy2sADFCFC72qbwF0yJ0ClHD+GQsx/R0gxpE5/b28ajlozbrCyo=
X-Received: by 2002:a50:cd18:0:b0:566:ef8:93f6 with SMTP id
 z24-20020a50cd18000000b005660ef893f6mr7191167edi.0.1710243308269; Tue, 12 Mar
 2024 04:35:08 -0700 (PDT)
MIME-Version: 1.0
References: <20240311191105.35224-8-its@irrelevant.dk>
In-Reply-To: <20240311191105.35224-8-its@irrelevant.dk>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 12 Mar 2024 11:34:57 +0000
Message-ID: <CAFEAcA_FC+FtfLHVy7=ekBH2SJCYpuPrg8rVg45XFZwO6r1+Lw@mail.gmail.com>
Subject: Re: [PULL 0/6] hw/nvme updates
To: Klaus Jensen <its@irrelevant.dk>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-block@nongnu.org, Jesper Devantier <foss@defmacro.it>, 
 Yanan Wang <wangyanan55@huawei.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Eduardo Habkost <eduardo@habkost.net>, Keith Busch <kbusch@kernel.org>, 
 Klaus Jensen <k.jensen@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Mon, 11 Mar 2024 at 19:11, Klaus Jensen <its@irrelevant.dk> wrote:
>
> From: Klaus Jensen <k.jensen@samsung.com>
>
> Hi,
>
> The following changes since commit 7489f7f3f81dcb776df8c1b9a9db281fc21bf0=
5f:
>
>   Merge tag 'hw-misc-20240309' of https://github.com/philmd/qemu into sta=
ging (2024-03-09 20:12:21 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/birkelund/qemu.git tags/nvme-next-pull-request
>
> for you to fetch changes up to a1505d799232939bf90c1b3e1fc20e81cd398404:
>
>   hw/nvme: add machine compatibility parameter to enable msix exclusive b=
ar (2024-03-11 20:07:41 +0100)
>
> ----------------------------------------------------------------
> hw/nvme updates
> -----BEGIN PGP SIGNATURE-----
>
> iQEzBAABCgAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmXvVsYACgkQTeGvMW1P
> DemWtwf9HU3cjtvCp8AeHGoPFTwp8/Vx3cQlQ6ilADKSDm44up2+M504xE/Mdviv
> 6y3PTPe1yiEpg/MbjWTX/df5lo+VdNoCuCyjph9mea0s1QAjCfVpl+KLMUVF/Oj5
> y1Iz9PQqOVDJ3O4xlgmPTfd8NXE/frNJaiXAjFuBxF2+4lilD5kMxpyu7DXbLiy2
> Szd1I3DhFAEOLEbrSSRDI3Fpy0KBdRzdKuUfmRdrHzbmhzHJefW7wnZ3aAiDboaD
> Ny7y/aovmjGymMp9GrBKWhUFPfSUtJ8l8j4Z7acQs+VDxg8lcAHCJKOyqCBTspUL
> PSnDe6E/CRyjrG2fUVXTLb6YW1eibQ=3D=3D
> =3DLd7a
> -----END PGP SIGNATURE-----

Hi; I'm afraid this fails to build for some jobs, eg
https://gitlab.com/qemu-project/qemu/-/jobs/6373091994
https://gitlab.com/qemu-project/qemu/-/jobs/6373091978
https://gitlab.com/qemu-project/qemu/-/jobs/6373091975

../hw/nvme/ctrl.c: In function =E2=80=98nvme_realize=E2=80=99:
../hw/nvme/ctrl.c:8146:15: error: =E2=80=98msix_pba_offset=E2=80=99 may be =
used
uninitialized in this function [-Werror=3Dmaybe-uninitialized]
8146 | ret =3D msix_init(pci_dev, n->params.msix_qsize,
     | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
8147 | &n->bar0, 0, msix_table_offset,
     | ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
8148 | &n->bar0, 0, msix_pba_offset, 0, errp);
     | ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
../hw/nvme/ctrl.c:8099:33: note: =E2=80=98msix_pba_offset=E2=80=99 was decl=
ared here
8099 | unsigned msix_table_offset, msix_pba_offset;
     | ^~~~~~~~~~~~~~~
../hw/nvme/ctrl.c:8135:9: error: =E2=80=98msix_table_offset=E2=80=99 may be=
 used
uninitialized in this function [-Werror=3Dmaybe-uninitialized]
8135 | memory_region_init_io(&n->iomem, OBJECT(n), &nvme_mmio_ops, n, "nvme=
",
     | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~
8136 | msix_table_offset);
     | ~~~~~~~~~~~~~~~~~~
../hw/nvme/ctrl.c:8099:14: note: =E2=80=98msix_table_offset=E2=80=99 was de=
clared here
8099 | unsigned msix_table_offset, msix_pba_offset;
     | ^~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors


I think this is because the compiler notices that nvme_mbar_size() has
an early-exit code path which never initializes *msix_table_offset
and *msix-pba_offset.

thanks
-- PMM

