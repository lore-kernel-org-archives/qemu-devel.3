Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5668C624CE
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 12:02:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1NBD-0001EN-Oz; Tue, 01 Sep 2026 08:01:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1x1NBB-0001DZ-Km
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 08:01:29 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1x1NB9-0006Xc-7B
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 08:01:29 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-396750cfee6so3731811a91.2
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 05:01:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788264084; cv=none;
 d=google.com; s=arc-20260327;
 b=prOvNmmCHymaRUWWwhUP8IVMuExBR4LVggImpR2nAM3SdsemE+or0IR8Q4ZIH4qpzG
 tsQm9nLWgI7jJpSP1CRLBFYQXONPC24BvTavhTedr2KISFV+Jh92s0IjaczrbDzr9bG8
 E+ENlh6LZ2MndC4ai8NI0qrYYs7l/eCjSP16OIxK+L4WrzMNFU2c8XCjFinIEUXD26tp
 cgW2s4NhYPs9LjuDHqtMwhqp673WuesNY1shMOWQNOmM/rT7s6WIKmNi3vROYYtahbvH
 NdYUbpzBLxbOoNHEZi4bRBlvJwTep6qITaCWDUGwwMuRE0mt77IVIbvyID4CybVx4V7C
 RhHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=BJlayv8TzzsP6t/5oSjA3C4KLl3KxhKHoafMM0UtWwA=;
 fh=oi2Mld0O2QacrCUo9w8TovT1IsUPfuNUHtYSbrEdoNE=;
 b=ije91tiNgCyAz7mOaXkxeyU5cb6YUxCAaVmIsalAKlkjvBMgGJGlAZ9wlV2zCeCZ8/
 qfsofBhVGZ2HlMaaMrMaCoS4VR5vCYSjpkeaztCwxawnyEdB3IQ0uj2iH/GfGIjL0hgq
 OkvMyltDj07WmH+AuqSFe/ZyIrTsynjC8uG0Dk8QVMkIcYNiBD/6g7y8TmNDyJHO36r0
 J3L3escogSVrxCXfSFMFgSW6aG4JaZWHsVWBQh2HrUBHx1q6Q11HvHZIcgxfKtnZUYVX
 8vYR/rlEXs9dsp/M4wOSn8NQeUUSkIWrmQKtEjzcVhjhqaEkrKC/gRnd8KeccruCyGKS
 Egvw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788264084; x=1788868884; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=BJlayv8TzzsP6t/5oSjA3C4KLl3KxhKHoafMM0UtWwA=;
 b=FDDX9xRvKTAtAxFqsXEKLGIp5DSaS/eHgIjjGPL4Z63n2I7dnszcyy1xtZybgGkJoX
 P6sxKqri9PgzIf2XKP8/xWKd5Ch6l5rVcn+bJRuDkqpWTwmCwY/3Je0l/C8Z/IRZDYKz
 fKVeXb09y3qA3YKII6cnVyn8licbRm+mElMMSnQVGo+2b53ooh20RRlS2ZqIDKQre8aT
 A3pWPi7DtNqS56csIm5MoKmjZrn3aNnQcS88KKfKFAnvJIQ0G3TWH6/ZFDlTx+RbshSg
 wpp4OB1DvMrZeXIFkTyLD/w9Wib3B6EJQdiXGMPQnq9gRlFp5cwJ9wN5kwjBolls6PxW
 E46A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788264084; x=1788868884;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=BJlayv8TzzsP6t/5oSjA3C4KLl3KxhKHoafMM0UtWwA=;
 b=m94rC+3U0kUGSM4XscsDrHDDILmYussjBMJ8GoDpX1irrYAp7jrNmvASQ0HvDQKYMo
 p53JxV9pd5K8JDP1jxedmr5hQiS0yp5/yRBTiKXrRYvsKrKVfO3n+Vrrwg/cxqO9wZDY
 l0Qj87eerZzRY8nY8blaQJVEZ7XP/pSAxDZQs3TF97dsb27YT0siLOdKIf3pK8aVunBs
 3i3N1W0dWsA//45tMIXYq/cAYt6KrgbmY8VDhSxDi8ZOGTEEOuoxK+wbQy2NxZ9HzVd/
 5FuFkqwbbGMcaVGdgKCANmnhO7DVNQ4BFRsobHrMcI0PzNZ0cf/3AQ6j18V/KqRio5ea
 uEfQ==
X-Gm-Message-State: AFuF++lbvRYquYR5si+9vNWXAxhO5ducV1firtukHWUGn6khS5kmPAwm
 /+hvmMVHh7gTQqA7FrkAeNii70l+VCeprhwYPoN/8gmdP8Lgpi+ZeG297o6UBDNlXUtfgqfpW9B
 u24X7B77m26xYXmH4US5aKd7CyA2DyOg=
X-Gm-Gg: AYBFou23mINW65LgTUB9iKIFpkRHAeoiyINLub2HekiE4gz0myujh6w4r64Oc2WKf2S
 qTdx6O7mvKdn89gFgJdAMSvXgaAyVB24xEaS+OxIpCYWw7+i6E7WTm39RwGOK//AArtYBpRIW5N
 uu/SkWzawmV1v8c9LWbJTBtPjOeuMaqc/oO7Ov4aZTNz5cq08vN5JBn0u5pbQhhP9wAoJsICeuq
 35XTvSznqBBldb5mCBnRZ6ejOdQ5JHAXkwcG+U8PYQQHe0XiAok5NlTnzfAuoHIjh+sM9xX4//p
 SL7VLOzBhmQ3E/KQWyYfBbFdstkmfDxlIqP8T8tnEQZDiYBh4GpUmVVDrotIaeXrUTLiKqwtbVv
 b
X-Received: by 2002:a17:90b:1e05:b0:398:9bd5:490c with SMTP id
 98e67ed59e1d1-3989bd54c4emr30388658a91.19.1788264083340; Tue, 01 Sep 2026
 05:01:23 -0700 (PDT)
MIME-Version: 1.0
References: <20260901-crosvm-v1-1-942fb87c5e43@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260901-crosvm-v1-1-942fb87c5e43@rsg.ci.i.u-tokyo.ac.jp>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 1 Sep 2026 16:01:11 +0400
X-Gm-Features: AcwNN1VJj6QiT5Z3DQGpb_D4uphUfDhxy2j0HgExzPftElyWkxTcTUxuG9oCoSA
Message-ID: <CAJ+F1CJ7sP8bPr+Ww-6+ZdrvvBxj4DU_MRp4EtC=fFfWuAF3GQ@mail.gmail.com>
Subject: Re: [PATCH] docs/system: virtio-gpu: Update Rutabaga link
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-pj1-x1034.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Sep 1, 2026 at 3:28=E2=80=AFPM Akihiko Odaki
<odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
>
> Rutabaga was externalized from crosvm:
> https://chromium.googlesource.com/crosvm/crosvm/+/481338d967d5c8b506e17b8=
e335798f5cb89d7ee
>
> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  docs/system/devices/virtio/virtio-gpu.rst | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/docs/system/devices/virtio/virtio-gpu.rst b/docs/system/devi=
ces/virtio/virtio-gpu.rst
> index d05f8cb8e3f9..8ce4da306acd 100644
> --- a/docs/system/devices/virtio/virtio-gpu.rst
> +++ b/docs/system/devices/virtio/virtio-gpu.rst
> @@ -185,8 +185,9 @@ rendering and `Wayland display passthrough`_.  With t=
he gfxstream rendering
>  mode, GLES and Vulkan calls are forwarded to the host with minimal
>  modification.
>
> -The crosvm book provides directions on how to build a `gfxstream-enabled
> -rutabaga`_ and launch a `guest Wayland proxy`_.
> +rutabaga_gfx's documentation provides directions on how to build a
> +`gfxstream-enabled rutabaga`_. The crosvm book provides directions on
> +how to launch a `guest Wayland proxy`_.
>
>  This device does require host blob support (``hostmem`` field below). Th=
e
>  ``hostmem`` field specifies the size of virtio-gpu host memory window.
> @@ -214,7 +215,7 @@ Surfaceless is the default if ``wsi`` is not specifie=
d.
>
>  .. _gfxstream: https://android.googlesource.com/platform/hardware/google=
/gfxstream/
>  .. _Wayland display passthrough: https://www.youtube.com/watch?v=3DOZJiH=
MtIQ2M
> -.. _gfxstream-enabled rutabaga: https://crosvm.dev/book/appendix/rutabag=
a_gfx.html
> +.. _gfxstream-enabled rutabaga: https://github.com/magma-gpu/rutabaga_gf=
x#rutabaga-c-api
>  .. _guest Wayland proxy: https://crosvm.dev/book/devices/wayland.html
>
>  .. list-table:: Linux Host Requirements
>
> ---
> base-commit: d2e570cc0f97b936902a5b1b86b73c0f5998b475
> change-id: 20260801-crosvm-658027011cb5
>
> Best regards,
> --
> Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
>
>


--=20
Marc-Andr=C3=A9 Lureau

