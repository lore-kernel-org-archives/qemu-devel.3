Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EF8BC4828F
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Feb 2024 01:46:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWRZn-0005um-Ip; Sat, 03 Feb 2024 20:45:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1rWRZm-0005ud-LX
 for qemu-devel@nongnu.org; Sat, 03 Feb 2024 20:45:42 -0500
Received: from mail-io1-xd2b.google.com ([2607:f8b0:4864:20::d2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1rWRZl-0007Zm-B2
 for qemu-devel@nongnu.org; Sat, 03 Feb 2024 20:45:42 -0500
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-7c029beb8c9so134139639f.0
 for <qemu-devel@nongnu.org>; Sat, 03 Feb 2024 17:45:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707011140; x=1707615940; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b6FDF4MwiOLrIHXfEYGsqnRnC000w+RHWRdiMpxEoMU=;
 b=lZVVxuvQCyy97jujIMobupXxC2BYBQGMwmye/40zNdgQG90MvPx8gODfHVV67dUFSy
 Yoi7ZiB+zQMB6MMgpR51FJqL7ktE18tuelXv/Nqq2/ztIfUnz8xfx5nOzX/gf89B1bQh
 RtVl5tFFC3d1G0EJSyCUN/BCmzh82V+haODe5LiYyjy9rbjjDg3hat1NxkElHsbcoEk7
 QBBy/6IbyiQLHXVxv7yxPyT90J91hrOZ83WRj4uYKy90Rv75rsldJlr0V67siA60ISEg
 j6JLeOOI13oaBtBrV2kEiEhPn8y25KI4ugCmC5Fx+bAAbKo7sHCPf2HXhmLawx6jmV0O
 SRUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707011140; x=1707615940;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b6FDF4MwiOLrIHXfEYGsqnRnC000w+RHWRdiMpxEoMU=;
 b=df6YKQS+MSX23dCzod52JPH3bZpTTfi5o9lZChF+2Yqkth06z76n3/1shjUAwt1NI8
 eYPrtR11OhFSoQk8klSD0UN9V2L/D0P1kWLxEsDCGEKvzVks2hZm1r+UI2wxXDy4bJ19
 Z0lOykNBuWTZKCuFARkDt+UdcPx7yTndte16RJyF3lHo8vFLt98q9nURIAGScV/zwck6
 MHbFSBufBZ2UWrt7BmmV+xQGW4yQP/rlL7OQL7db4XhuKaqj834iZNvNmk6JHSxqSkBi
 PELoe6mSVT31Jp5TBzEh705iQTeGG3OGE2zgt4CLNP9d8nSPIANQvKH3M+y/e2nbIznt
 hxow==
X-Gm-Message-State: AOJu0YysmxLnRNBM4uVru3Gk9KuRWKYb2J6AdkbDpY4/fMfp6nVv9iwV
 Cb2l6JvX1t8sx8xZ+xb13gg63jvtDk394vSOppDYRD1wNTPXS1EesfvHfBg8wag51FpKkPwqvI8
 owwTG2+sYJ9SmSzcboPCjjQiHeRo=
X-Google-Smtp-Source: AGHT+IGA3sELd0rhNgOo33/IoteCLiasKw5c73gJqx8ycOaADPRJt/g2b3obE3ZbK7u1GYIDQHrYzkJCyZQei6bEnPI=
X-Received: by 2002:a5e:de4a:0:b0:7c0:2a38:d08a with SMTP id
 e10-20020a5ede4a000000b007c02a38d08amr7130744ioq.7.1707011140304; Sat, 03 Feb
 2024 17:45:40 -0800 (PST)
MIME-Version: 1.0
References: <20240202215332.118728-1-david@redhat.com>
 <20240202215332.118728-8-david@redhat.com>
In-Reply-To: <20240202215332.118728-8-david@redhat.com>
From: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Date: Sat, 3 Feb 2024 20:45:29 -0500
Message-ID: <CAFubqFuHc4MKQ1WXwRmmkJZZKxZhPQPR=mv9H_xsYGk4GSO_jw@mail.gmail.com>
Subject: Re: [PATCH v1 07/15] libvhost-user: No need to check for NULL when
 unmapping
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>,
 Germano Veit Michel <germano@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::d2b;
 envelope-from=raphael.s.norwitz@gmail.com; helo=mail-io1-xd2b.google.com
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

On Fri, Feb 2, 2024 at 4:55=E2=80=AFPM David Hildenbrand <david@redhat.com>=
 wrote:
>
> We never add a memory region if mmap() failed. Therefore, no need to chec=
k
> for NULL.
>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Raphael Norwitz <raphael@enfabrica.net>

> ---
>  subprojects/libvhost-user/libvhost-user.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
>
> diff --git a/subprojects/libvhost-user/libvhost-user.c b/subprojects/libv=
host-user/libvhost-user.c
> index a2baefe84b..f99c888b48 100644
> --- a/subprojects/libvhost-user/libvhost-user.c
> +++ b/subprojects/libvhost-user/libvhost-user.c
> @@ -247,11 +247,8 @@ vu_remove_all_mem_regs(VuDev *dev)
>
>      for (i =3D 0; i < dev->nregions; i++) {
>          VuDevRegion *r =3D &dev->regions[i];
> -        void *ma =3D (void *)(uintptr_t)r->mmap_addr;
>
> -        if (ma) {
> -            munmap(ma, r->size + r->mmap_offset);
> -        }
> +        munmap((void *)(uintptr_t)r->mmap_addr, r->size + r->mmap_offset=
);
>      }
>      dev->nregions =3D 0;
>  }
> @@ -888,11 +885,8 @@ vu_rem_mem_reg(VuDev *dev, VhostUserMsg *vmsg) {
>      for (i =3D 0; i < dev->nregions; i++) {
>          if (reg_equal(&dev->regions[i], msg_region)) {
>              VuDevRegion *r =3D &dev->regions[i];
> -            void *ma =3D (void *) (uintptr_t) r->mmap_addr;
>
> -            if (ma) {
> -                munmap(ma, r->size + r->mmap_offset);
> -            }
> +            munmap((void *)(uintptr_t)r->mmap_addr, r->size + r->mmap_of=
fset);
>
>              /*
>               * Shift all affected entries by 1 to close the hole at inde=
x i and
> --
> 2.43.0
>
>

