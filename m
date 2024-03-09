Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37294C54E49
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Mar 2024 03:36:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rinV0-0000vq-0a; Fri, 08 Mar 2024 22:35:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jandryuk@gmail.com>)
 id 1rinUz-0000vU-5i
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 22:35:49 -0500
Received: from mail-lj1-x22a.google.com ([2a00:1450:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jandryuk@gmail.com>)
 id 1rinUx-0000ss-GS
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 22:35:48 -0500
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2d33986dbc0so28874601fa.2
 for <qemu-devel@nongnu.org>; Fri, 08 Mar 2024 19:35:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709955345; x=1710560145; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ytsxnHtpmEBKqqWctGKiw7/Ms2x8N2LrUmUr2AL0+wY=;
 b=EXYSmYyQVlSx8slxOoYlxUISjfFriGDOyybwaPMlAuke6l+2zBU3d50rNP9l5tDd/F
 CpER+0RPYEPx+Du95+6tw1s143zW4RBrJzxxYxyy/6yidptK2XcmrRaj1U862FTwNjvN
 RvmjqJnivMfDPQ7/sRQEX1Ix7Eb2sl7sYG7Ap9KHa1ZrAJe1r7+YC+ghKtoBgFUQuMn+
 wLoxd9obD3ncSfExcUFUXaVZoFaaWFz9+7aygfqwq++uYqJ6NrUTcbbD/58LD5bdah5x
 BhAX3O40JAQ4HE3hnUS3CUGWi+66ucvVmVLwJngmzNMR4UeD7mqfE5XpnQfUijZLBm9s
 W6Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709955345; x=1710560145;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ytsxnHtpmEBKqqWctGKiw7/Ms2x8N2LrUmUr2AL0+wY=;
 b=lrSUNM7f+0iotHLQSecbttfx0BBFFr/GaXI+XT6CDybyQXBGZISLvuSPHNM1zN5cta
 9Hajma9l0ydLuvGDZBd3a7V3YTx2DpZuhNQJMM0Um50DzJdKMpXHkBcbRLBM/IzBKais
 FiccpT5ZlVPQjryffunxWk9u9HFfj9X4yyM9MzKlDR819CUMlJy4ivX9eAj39mlO5RzQ
 +n2MQmQg3zs1IPtB2qHqX7UPTfZOKyKVikBIGMaAzxUD3GmrKs9bLImI9o5KlkhK9Y60
 bXouCE79FRR6bC7/oi1gOlDUkEdRSaQDYh73pFDQMQI2T7GBBh/muasizxcnbZneXEOT
 pRWg==
X-Gm-Message-State: AOJu0YwEzJQWBEN0wqMS5q3M/4ywPKJU23/o8h1cRyVLK2kBfP/DCnWW
 INxBi1VJRQE1eBTSm9o9uRBThpi1Fpa6yvtfqArKkIZvK1KSQUIIno/ZOvCAZw2YFqF69FACJbI
 /4ip0jVqUd2+oNms1ygA5c2Y+5kk=
X-Google-Smtp-Source: AGHT+IEyJOtEREPXpZYtaMDNs4rOhx8WJyezwfQ1NA7tbhObr8lAboMBnMFazQ7OWymEHbqP1y5Qx8WpLPp7ieRlQsg=
X-Received: by 2002:a2e:8ec5:0:b0:2d4:21d6:b05e with SMTP id
 e5-20020a2e8ec5000000b002d421d6b05emr513293ljl.52.1709955344857; Fri, 08 Mar
 2024 19:35:44 -0800 (PST)
MIME-Version: 1.0
References: <20240305191312.321127-1-marmarek@invisiblethingslab.com>
 <20240305191312.321127-2-marmarek@invisiblethingslab.com>
In-Reply-To: <20240305191312.321127-2-marmarek@invisiblethingslab.com>
From: Jason Andryuk <jandryuk@gmail.com>
Date: Fri, 8 Mar 2024 22:35:33 -0500
Message-ID: <CAKf6xpuMzuAgjyVsFYgtnKFc4obx9cf4XB132qZVGpkMVDGEgg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] xen: fix stubdom PCI addr
To: =?UTF-8?Q?Marek_Marczykowski=2DG=C3=B3recki?=
 <marmarek@invisiblethingslab.com>
Cc: qemu-devel@nongnu.org, 
 =?UTF-8?B?RnLDqWTDqXJpYyBQaWVycmV0IChmZXBpdHJlKQ==?=
 <frederic.pierret@qubes-os.org>, 
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>,
 "open list:X86 Xen CPUs" <xen-devel@lists.xenproject.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::22a;
 envelope-from=jandryuk@gmail.com; helo=mail-lj1-x22a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, Mar 5, 2024 at 2:13=E2=80=AFPM Marek Marczykowski-G=C3=B3recki
<marmarek@invisiblethingslab.com> wrote:
>
> From: Fr=C3=A9d=C3=A9ric Pierret (fepitre) <frederic.pierret@qubes-os.org=
>

Needs to be changed to Marek.

> When running in a stubdomain, the config space access via sysfs needs to
> use BDF as seen inside stubdomain (connected via xen-pcifront), which is
> different from the real BDF. For other purposes (hypercall parameters
> etc), the real BDF needs to be used.
> Get the in-stubdomain BDF by looking up relevant PV PCI xenstore
> entries.
>
> Signed-off-by: Marek Marczykowski-G=C3=B3recki <marmarek@invisiblethingsl=
ab.com>
> ---
> Changes in v2:
> - use xs_node_scanf
> - use %d instead of %u to read values written as %d
> - add a comment from another iteration of this patch by Jason Andryuk
> ---
>  hw/xen/xen-host-pci-device.c | 69 +++++++++++++++++++++++++++++++++++-
>  hw/xen/xen-host-pci-device.h |  6 ++++
>  2 files changed, 74 insertions(+), 1 deletion(-)
>
> diff --git a/hw/xen/xen-host-pci-device.c b/hw/xen/xen-host-pci-device.c
> index 8c6e9a1716..8ea2a5a4af 100644
> --- a/hw/xen/xen-host-pci-device.c
> +++ b/hw/xen/xen-host-pci-device.c
> @@ -9,6 +9,8 @@
>  #include "qemu/osdep.h"
>  #include "qapi/error.h"
>  #include "qemu/cutils.h"
> +#include "hw/xen/xen-legacy-backend.h"
> +#include "hw/xen/xen-bus-helper.h"
>  #include "xen-host-pci-device.h"
>
>  #define XEN_HOST_PCI_MAX_EXT_CAP \
> @@ -33,13 +35,67 @@
>  #define IORESOURCE_PREFETCH     0x00001000      /* No side effects */
>  #define IORESOURCE_MEM_64       0x00100000
>
> +/*
> + * Non-passthrough (dom0) accesses are local PCI devices and use the giv=
en BDF
> + * Passthough (stubdom) accesses are through PV frontend PCI device.  Th=
ose
> + * either have a BDF identical to the backend's BDF (xen-backend.passthr=
ough=3D1)
> + * or a local virtual BDF (xen-backend.passthrough=3D0)
> + *
> + * We are always given the backend's BDF and need to lookup the appropri=
ate
> + * local BDF for sysfs access.
> + */
> +static void xen_host_pci_fill_local_addr(XenHostPCIDevice *d, Error **er=
rp)
> +{
> +    unsigned int num_devs, len, i;
> +    unsigned int domain, bus, dev, func;
> +    char *be_path =3D NULL;
> +    char path[80];

path is now only used for dev/vdev-%d, so 80 could be reduced.

> +
> +    be_path =3D qemu_xen_xs_read(xenstore, 0, "device/pci/0/backend", &l=
en);
> +    if (!be_path)

error_setg() here?

> +        goto out;
> +
> +    if (xs_node_scanf(xenstore, 0, be_path, "num_devs", NULL, "%d", &num=
_devs) !=3D 1) {
> +        error_setg(errp, "Failed to read or parse %s/num_devs\n", be_pat=
h);
> +        goto out;
> +    }
> +
> +    for (i =3D 0; i < num_devs; i++) {
> +        snprintf(path, sizeof(path), "dev-%d", i);
> +        if (xs_node_scanf(xenstore, 0, be_path, path, NULL,
> +                          "%x:%x:%x.%x", &domain, &bus, &dev, &func) !=
=3D 4) {
> +            error_setg(errp, "Failed to read or parse %s/%s\n", be_path,=
 path);
> +            goto out;
> +        }
> +        if (domain !=3D d->domain ||
> +                bus !=3D d->bus ||
> +                dev !=3D d->dev ||
> +                func!=3D d->func)
> +            continue;
> +        snprintf(path, sizeof(path), "vdev-%d", i);
> +        if (xs_node_scanf(xenstore, 0, be_path, path, NULL,
> +                          "%x:%x:%x.%x", &domain, &bus, &dev, &func) !=
=3D 4) {
> +            error_setg(errp, "Failed to read or parse %s/%s\n", be_path,=
 path);
> +            goto out;
> +        }
> +        d->local_domain =3D domain;
> +        d->local_bus =3D bus;
> +        d->local_dev =3D dev;
> +        d->local_func =3D func;
> +        goto out;
> +    }

error_setg here in case we exited the loop without finding a match?

Thanks,
Jason

> +
> +out:
> +    free(be_path);
> +}
> +

