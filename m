Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 911EBC4828D
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Feb 2024 01:44:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWRY3-0004Ar-Ul; Sat, 03 Feb 2024 20:43:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1rWRY2-0004Ai-5W
 for qemu-devel@nongnu.org; Sat, 03 Feb 2024 20:43:54 -0500
Received: from mail-io1-xd30.google.com ([2607:f8b0:4864:20::d30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1rWRY0-0006wG-Q9
 for qemu-devel@nongnu.org; Sat, 03 Feb 2024 20:43:53 -0500
Received: by mail-io1-xd30.google.com with SMTP id
 ca18e2360f4ac-7c2c8606ef1so37523139f.2
 for <qemu-devel@nongnu.org>; Sat, 03 Feb 2024 17:43:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707011031; x=1707615831; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=slkPPw7lJWgVdK1ANbOuTV8yR6/1Y1TqdoELdMiusAQ=;
 b=S5bDgo8zTqTjFJumq+vEfH1lYsDB6/RNg/gyzkiWwUPa4Gp8Nfi8C2PwPfqHwmh8Fr
 iVRP5GsWlgJPjHn6H7KljrsTi6FtLeqFmSEuU8e08SZJ0V6q5MG+6fTkHcEF8LoUkNyw
 FZ/E+d6tdcVnCP3TSuowjHZ8uXY+DrBOcpIfukNIp1zOW/hvbojuzGFEtnauDQeWeHDG
 JWW9lt5ysFR5By3Q/QhdpW1J+fSy+bhJ9Hk7xIXBCd2D1oXDEtOjA5PAW5L8bfy/e0oq
 sfwm7uttFL14JYtx3aCTTgL8MhxYab6L/tsP7mIz+jaPwuyrx9s7QO4cXTGKqZCs73ew
 x7eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707011031; x=1707615831;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=slkPPw7lJWgVdK1ANbOuTV8yR6/1Y1TqdoELdMiusAQ=;
 b=cXdqMk10RUuYdFiyflLH0K5O8+5q7kMMaQWTBTcaFpendvFC6y+eIUryphaa4jlAte
 02INKK7mrOocv6q43ZyEkJnYT27GbkTCAbbl5HIEn5f42FayxXK6e4MruKIEE48sfuVs
 Yjq+ZGMAF+9sD7x2wHb6KnVVmbKuWE69wUMD7JiG7ouKCk3PMY/S6aFAyAb1UoY0bctM
 XWQdjfhAk28UmbS6Q2ScaH5B2BwtVVXyjlagz+o3cnAXfe+obzaoRNfO1KIhbrYwlPhH
 N8wNUJb+wiH2P/3wNIebzq2NwbuxDjsu075ca1o5T8+efi6FSbJcZ2PCUDxa26+xLHpp
 6new==
X-Gm-Message-State: AOJu0Yyn+L+Vlyo9W04navKtpwGtlY3lnkAlDdmEA2Vqj+EHSWEoyQq6
 GhQRjMwyLpRebKsyJPhH4XZYcxk9RqktTXfzOlnKNRnNTT7COgihQTv3c/binTtOWsX07DwvWc9
 /pdZp5f+2YiMAxiyw+ylx73EUNXA=
X-Google-Smtp-Source: AGHT+IF//DIMqdPKKaMrSqjHt7CVvxVpfqVWPNYDa8u8wpKQR3iNWj/zFG0xv79ohf/d8m0vMadDNF4z0k6mp/eyRx4=
X-Received: by 2002:a05:6e02:3881:b0:363:b2ea:5771 with SMTP id
 cn1-20020a056e02388100b00363b2ea5771mr7113358ilb.1.1707011031514; Sat, 03 Feb
 2024 17:43:51 -0800 (PST)
MIME-Version: 1.0
References: <20240202215332.118728-1-david@redhat.com>
 <20240202215332.118728-5-david@redhat.com>
In-Reply-To: <20240202215332.118728-5-david@redhat.com>
From: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Date: Sat, 3 Feb 2024 20:43:40 -0500
Message-ID: <CAFubqFveymknzSkDUVuYXE5a3vXbXYsaRJnyOpBDk2yGBND9Tw@mail.gmail.com>
Subject: Re: [PATCH v1 04/15] libvhost-user: Factor out removing all mem
 regions
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>,
 Germano Veit Michel <germano@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::d30;
 envelope-from=raphael.s.norwitz@gmail.com; helo=mail-io1-xd30.google.com
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

On Fri, Feb 2, 2024 at 4:54=E2=80=AFPM David Hildenbrand <david@redhat.com>=
 wrote:
>
> Let's factor it out. Note that the check for MAP_FAILED was wrong as
> we never set mmap_addr if mmap() failed. We'll remove the NULL check
> separately.
>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Raphael Norwitz <raphael@enfabrica.net>

> ---
>  subprojects/libvhost-user/libvhost-user.c | 34 ++++++++++++-----------
>  1 file changed, 18 insertions(+), 16 deletions(-)
>
> diff --git a/subprojects/libvhost-user/libvhost-user.c b/subprojects/libv=
host-user/libvhost-user.c
> index 8a5a7a2295..d5b3468e43 100644
> --- a/subprojects/libvhost-user/libvhost-user.c
> +++ b/subprojects/libvhost-user/libvhost-user.c
> @@ -240,6 +240,22 @@ qva_to_va(VuDev *dev, uint64_t qemu_addr)
>      return NULL;
>  }
>
> +static void
> +vu_remove_all_mem_regs(VuDev *dev)
> +{
> +    unsigned int i;
> +
> +    for (i =3D 0; i < dev->nregions; i++) {
> +        VuDevRegion *r =3D &dev->regions[i];
> +        void *ma =3D (void *)(uintptr_t)r->mmap_addr;
> +
> +        if (ma) {
> +            munmap(ma, r->size + r->mmap_offset);
> +        }
> +    }
> +    dev->nregions =3D 0;
> +}
> +
>  static void
>  vmsg_close_fds(VhostUserMsg *vmsg)
>  {
> @@ -1003,14 +1019,7 @@ vu_set_mem_table_exec(VuDev *dev, VhostUserMsg *vm=
sg)
>      unsigned int i;
>      VhostUserMemory m =3D vmsg->payload.memory, *memory =3D &m;
>
> -    for (i =3D 0; i < dev->nregions; i++) {
> -        VuDevRegion *r =3D &dev->regions[i];
> -        void *ma =3D (void *) (uintptr_t) r->mmap_addr;
> -
> -        if (ma) {
> -            munmap(ma, r->size + r->mmap_offset);
> -        }
> -    }
> +    vu_remove_all_mem_regs(dev);
>      dev->nregions =3D memory->nregions;
>
>      if (dev->postcopy_listening) {
> @@ -2112,14 +2121,7 @@ vu_deinit(VuDev *dev)
>  {
>      unsigned int i;
>
> -    for (i =3D 0; i < dev->nregions; i++) {
> -        VuDevRegion *r =3D &dev->regions[i];
> -        void *m =3D (void *) (uintptr_t) r->mmap_addr;
> -        if (m !=3D MAP_FAILED) {
> -            munmap(m, r->size + r->mmap_offset);
> -        }
> -    }
> -    dev->nregions =3D 0;
> +    vu_remove_all_mem_regs(dev);
>
>      for (i =3D 0; i < dev->max_queues; i++) {
>          VuVirtq *vq =3D &dev->vq[i];
> --
> 2.43.0
>
>

