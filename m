Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E20CBC369D3
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 11:32:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9MiL-0000u4-4Z; Mon, 28 Apr 2025 07:31:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1u9Mhz-0000n1-MV
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 07:31:36 -0400
Received: from mail-qt1-x82b.google.com ([2607:f8b0:4864:20::82b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1u9Mhw-0006f6-Pg
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 07:31:35 -0400
Received: by mail-qt1-x82b.google.com with SMTP id
 d75a77b69052e-4766cb762b6so53569581cf.0
 for <qemu-devel@nongnu.org>; Mon, 28 Apr 2025 04:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745839891; x=1746444691; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vuBzn1Ze52/7QArs7NnQKw5uA8IXR5jlK2PsLxtap4c=;
 b=W3sKEL3WsOjrXqDV+eo25Oj66fh1EF3KZBPxAInLfmspv9SuBwFRDVlJ4rg6W+Dn1I
 d9YboJypxi4mBWvMXWSssoaut6qOK0ZJBmzzTiQYHB6VKSgndkkORd4v7jm5dOk4WtrI
 92//ZopFDOCD6WoO501u1GFuc5MSktYXQ0LnLWK8jkx9j6L4ubsWoAa8gVda//bzjxco
 ZQ9xwmoOqzTgwccznK/cBpS8e+i2+iEym3889S08TkfEZOWjWbXHz1Hc67lvuVoz5UDM
 5sU0pWZHq9206h+ma/g5RLkkSWTc+BIC7SkJ0Y0HkGud32WpFgPDzY88vwFAI8s9bHbf
 gArw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745839891; x=1746444691;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vuBzn1Ze52/7QArs7NnQKw5uA8IXR5jlK2PsLxtap4c=;
 b=cmkfUxJZ48/TsTf8/F2RJXRJB4FEC7751GdEw+748xFWiMGMsIorT+SkTGwV2bNDXg
 PUW4tvmtO4YN4giHEzexcO/E8LUtpYJgKb5KPFz0PTGpeMceSunMy3Y1c9MOKGumJ3Mb
 U0v56FsHWVZGSaki50UEq9wQo/pd2S7byTh2WiYTOm+i9qVxKa084wYsZ4uTY3YKigJN
 bw51K8R4UBBYAlN66FKT37vsbjnLWrV3no3n/kXSCIFiRO1K5kKdywgxQbDq9HsTg7Ii
 17WT0DLtv8PvsqmMEvomtsJToJENOdHl4IhGeWzXJH+m7+GqNFu8hU0MNUJdGeIOTDLp
 /kNg==
X-Gm-Message-State: AOJu0YwJ2ill0IquSOf4TNgW6Ol7R8s46ptGhvB5l/A8kb1QIxP5InMQ
 Eb+EmAIrKWgL73yCQxuNiscJqN4Fh3KkEaFrwG4stbwguBNxGWTavKZ/jMYrNZN/y4ojpUG3daC
 FSmkDOhdHI05CuUSALxFjau64xJU=
X-Gm-Gg: ASbGnct843bhLQmzMBPdkHx7ksFMqIgFnuuqWr2qS6cICjqLfTU6vRqdrBS+cIROki3
 thnujHIMytrsWNvaakmVHnVsJfzv3xACm0E2Er4MPwh0ra9RZNznA0HnKzYvrNVmemGMley+n5n
 Lt9P+B4rzLsbxFe47sESKztG3+Vg5hYU6aMfysHtgwj2HHEYubQhczdsU3OQ63qon8AA==
X-Google-Smtp-Source: AGHT+IEkt6YcnEkNGPbqdytLh2ravRwV5akVpP/f0U+QA6AewZJ66n+XGV+SDsmsNyK/NgTtJ8bUmFxAZr25VX/BNyI=
X-Received: by 2002:a05:622a:1490:b0:476:fd6e:df89 with SMTP id
 d75a77b69052e-4802f401555mr161688461cf.17.1745839891267; Mon, 28 Apr 2025
 04:31:31 -0700 (PDT)
MIME-Version: 1.0
References: <20250428080336.2574852-1-dietmar@proxmox.com>
 <20250428080336.2574852-3-dietmar@proxmox.com>
In-Reply-To: <20250428080336.2574852-3-dietmar@proxmox.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 28 Apr 2025 15:31:18 +0400
X-Gm-Features: ATxdqUFRlfgrtBiA9dyVJrGLp08LMxOMzPV6M7g7kejw9vwDkb8iwDCBRUbg2Qo
Message-ID: <CAJ+F1CLs3zy131Nkr97ve5LPVZJVfS_mJ26nS7p2vVhyeftD1Q@mail.gmail.com>
Subject: Re: [PATCH v4 2/8] vnc: initialize gst during argument processing
To: Dietmar Maurer <dietmar@proxmox.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::82b;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x82b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Hi

On Mon, Apr 28, 2025 at 12:04=E2=80=AFPM Dietmar Maurer <dietmar@proxmox.co=
m> wrote:
>
> So that we can set --gst- options on the qemu command line.
>
> Signed-off-by: Dietmar Maurer <dietmar@proxmox.com>

This breaks the build, because gstreamer may not be linked.

Maybe another reason to drop the gst_init(argc, argv) and do it in VNC
module only instead...

thanks

> ---
>  system/vl.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/system/vl.c b/system/vl.c
> index ec93988a03..c7fff02da2 100644
> --- a/system/vl.c
> +++ b/system/vl.c
> @@ -140,6 +140,10 @@
>  #include "qemu/guest-random.h"
>  #include "qemu/keyval.h"
>
> +#ifdef CONFIG_GSTREAMER
> +#include <gst/gst.h>
> +#endif
> +
>  #define MAX_VIRTIO_CONSOLES 1
>
>  typedef struct BlockdevOptionsQueueEntry {
> @@ -2848,6 +2852,10 @@ void qemu_init(int argc, char **argv)
>      bool userconfig =3D true;
>      FILE *vmstate_dump_file =3D NULL;
>
> +#ifdef CONFIG_GSTREAMER
> +    gst_init(&argc, &argv);
> +#endif
> +
>      qemu_add_opts(&qemu_drive_opts);
>      qemu_add_drive_opts(&qemu_legacy_drive_opts);
>      qemu_add_drive_opts(&qemu_common_drive_opts);
> --
> 2.39.5
>
>


--=20
Marc-Andr=C3=A9 Lureau

