Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37103C02185
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 07:06:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYgQl-0000Wk-Ed; Fri, 17 Jan 2025 02:06:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1tYgQk-0000WS-1u
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 02:06:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1tYgQf-0007TT-3o
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 02:06:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737097563;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y6Yesf3+j/k7hgOXyFBBoT9cNkww3rV6IdUuwKkJFrw=;
 b=SsYKOvI/6rTyMFs4RgUC0P0pDC2NSm9GLZDuILMUnx1yr2tVzNtuhuTR/o7gfZQwxuyOoQ
 coH5M0s2AeiIvHdMcJjk5XczaK5ATQAS8jt/LuEInhVA/F3yH0YTVc/n1sTUVaAvSZ3Ze1
 3pJqx9UmgZGWytMGZhg29dLcysoB+2g=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-428-3e4ac6VaO5-Wl9ZZqHQSXA-1; Fri, 17 Jan 2025 02:06:01 -0500
X-MC-Unique: 3e4ac6VaO5-Wl9ZZqHQSXA-1
X-Mimecast-MFC-AGG-ID: 3e4ac6VaO5-Wl9ZZqHQSXA
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-aa6b904a886so147680966b.0
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 23:06:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737097560; x=1737702360;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y6Yesf3+j/k7hgOXyFBBoT9cNkww3rV6IdUuwKkJFrw=;
 b=tOlkrXQKmB/e9cPHPMFiJ2BJ5DcyefpDeOwoE5MtbAQbC2d8UayH/CN6ZyRNSYPXxh
 QabWHE1/eMfVy6qyHuZI/pM76Q3tRom9gg6bfmy1irWxCXrViRgmo88wKQdmPyV8WFfJ
 KYGWG9EZbxtgG1ePkS8tsRLDSzFJxUGtRfB+MguxBqyYq/sKYla/q7QjN7e5r2Kx30Vs
 yadQGlvckPrHhx1G36W3XlEl5PH07Dv/z8gZzWzqlCPvfUloNPzgORAEl/TX8n/xbjM6
 cURH1t/P7bPhJCA0yJVA0wTUaf1A5w2tsRnTYXOzAK8zpu90s49zUiPRNRkdc7mshtcl
 pbgA==
X-Gm-Message-State: AOJu0YzvQPcZD05Z4wmZK1q3kYCbMNht8W2+avemICAWDAlvYiKctr59
 EZ0+wpYeW+5pmTMq1C0inXaV75Ds/XNMQPenyjkppVHpDM5KpHbAqL3naGuwMVecCzCIN4U2j1x
 rsVF5YqYm6hXsNZK0YqBzYwtQAvPxL8wYSqDrmo4lppxK73NrLL1V35RDkcNYLQpn0vvaxvq+3b
 4sfyLy60orlqHef+ZK6RVcoeP2www=
X-Gm-Gg: ASbGncs40BN1vCwziqr6pUoX2dr+NDoPtxtlbFhxpzk8q/TbMVT2FrrDPPokCzO5oVT
 dnUsskG+FXtlNYfELoM54Hc4WCAz1BsMufF6m
X-Received: by 2002:a17:907:1c11:b0:ab3:7720:d87c with SMTP id
 a640c23a62f3a-ab38b384218mr168132166b.35.1737097559783; 
 Thu, 16 Jan 2025 23:05:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHwETaH2rX9YsPRXWvj9jAvOVM9lqy1b9q/Qi6KKd2cb7qEfE2s8W9DvUw5wHii+Ifasw/rSG8+kbs8hrkVfvw=
X-Received: by 2002:a17:907:1c11:b0:ab3:7720:d87c with SMTP id
 a640c23a62f3a-ab38b384218mr168129566b.35.1737097559392; Thu, 16 Jan 2025
 23:05:59 -0800 (PST)
MIME-Version: 1.0
References: <20250115125342.3883374-1-imammedo@redhat.com>
 <20250115125342.3883374-3-imammedo@redhat.com>
In-Reply-To: <20250115125342.3883374-3-imammedo@redhat.com>
From: Ani Sinha <anisinha@redhat.com>
Date: Fri, 17 Jan 2025 12:35:47 +0530
X-Gm-Features: AbW1kvY4jlfdV69jkaVYrSanRjbf_2mqsxf63SArSTLaKOrEbSPmAg5XD32hSLs
Message-ID: <CAK3XEhNMFrvN4dkHj93fapCqCcAaHr5gp+TTbNfGF==YwJGR+A@mail.gmail.com>
Subject: Re: [PATCH 2/3] pci: acpi: Windows 'PCI Label Id' bug workaround
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.093,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.797,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Jan 15, 2025 at 6:23=E2=80=AFPM Igor Mammedov <imammedo@redhat.com>=
 wrote:
>
> Current versions of Windows call _DSM(func=3D7) regardless
> of whether it is supported or not. It leads to NICs having bogus
> 'PCI Label Id =3D 0', where none should be set at all.
>
> Also presence of 'PCI Label Id' triggers another Windows bug
> on localized versions that leads to hangs. The later bug is fixed
> in latest updates for 'Windows Server' but not in consumer
> versions of Windows (and there is no plans to fix it
> as far as I'm aware).
>
> Given it's easy, implement Microsoft suggested workaround
> (return invalid Package) so that affected Windows versions
> could boot on QEMU.
> This would effectvely remove bogus 'PCI Label Id's on NICs,
> but MS teem confirmed that flipping 'PCI Label Id' should not
> change 'Network Connection' ennumeration, so it should be safe
> for QEMU to change _DSM without any compat code.
>
> Smoke tested with WinXP and WS2022
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/774
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
>  hw/i386/acpi-build.c | 33 +++++++++++++++++++++++----------
>  1 file changed, 23 insertions(+), 10 deletions(-)
>
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index 733b8f0851..1311a0d4f3 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -654,6 +654,7 @@ static Aml *aml_pci_pdsm(void)
>      Aml *acpi_index =3D aml_local(2);
>      Aml *zero =3D aml_int(0);
>      Aml *one =3D aml_int(1);
> +    Aml *not_supp =3D aml_int(0xFFFFFFFF);
>      Aml *func =3D aml_arg(2);
>      Aml *params =3D aml_arg(4);
>      Aml *bnum =3D aml_derefof(aml_index(params, aml_int(0)));
> @@ -678,7 +679,7 @@ static Aml *aml_pci_pdsm(void)
>           */
>          ifctx1 =3D aml_if(aml_lnot(
>                       aml_or(aml_equal(acpi_index, zero),
> -                            aml_equal(acpi_index, aml_int(0xFFFFFFFF)), =
NULL)
> +                            aml_equal(acpi_index, not_supp), NULL)
>                   ));
>          {
>              /* have supported functions */
> @@ -704,18 +705,30 @@ static Aml *aml_pci_pdsm(void)
>      {
>         Aml *pkg =3D aml_package(2);
>
> -       aml_append(pkg, zero);
> -       /*
> -        * optional, if not impl. should return null string
> -        */
> -       aml_append(pkg, aml_string("%s", ""));
> -       aml_append(ifctx, aml_store(pkg, ret));
> -
>         aml_append(ifctx, aml_store(aml_call2("AIDX", bnum, sunum), acpi_=
index));
> +       aml_append(ifctx, aml_store(pkg, ret));
>         /*
> -        * update acpi-index to actual value
> +        * Windows calls func=3D7 without checking if it's available,
> +        * as workaround Microsoft has suggested to return invalid for fu=
nc7
> +        * Package, so return 2 elements package but only initialize elem=
ents
> +        * when acpi_index is supported and leave them uninitialized, whi=
ch
> +        * leads elements to being Uninitialized ObjectType and should tr=
ip
> +        * Windows into discarding result as an unexpected and prevent se=
tting
> +        * bogus 'PCI Label' on the device.

This comment is very confusing!

>          */
> -       aml_append(ifctx, aml_store(acpi_index, aml_index(ret, zero)));
> +       ifctx1 =3D aml_if(aml_lnot(aml_lor(
> +                    aml_equal(acpi_index, zero), aml_equal(acpi_index, n=
ot_supp)
> +                )));

So this conditional checks if the acpi index is supported (because its
aml_lnot()).

> +       {
> +           aml_append(ifctx1, aml_store(acpi_index, aml_index(ret, zero)=
));
> +           /*
> +            * optional, if not impl. should return null string
> +            */

I know this comes from the existing code but I am still confused. Why
is this appending "return null string" logic to "if acpi index is
supprted" conditional?

> +           aml_append(ifctx1, aml_store(aml_string("%s", ""),
> +                                        aml_index(ret, one)));
> +       }
> +       aml_append(ifctx, ifctx1);
> +
>         aml_append(ifctx, aml_return(ret));
>      }
>
> --
> 2.43.0
>


