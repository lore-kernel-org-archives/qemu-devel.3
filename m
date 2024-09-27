Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C30A4CDD1A4
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2024 13:06:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1suAfL-0002il-Jy; Fri, 27 Sep 2024 09:05:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1suAf9-0002h1-Ic
 for qemu-devel@nongnu.org; Fri, 27 Sep 2024 09:05:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1suAf5-0002ls-7P
 for qemu-devel@nongnu.org; Fri, 27 Sep 2024 09:05:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727442328;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oGzWdE/vsmIlgPj6crdxLyzox8j9GoYUSTFvWFf4zec=;
 b=ftu/XyqfEbE/1KzvNNDFpaX2TacfunjKQFCpeWohigH6y+dWUWvcyq98VaOjbgLdzOFOvw
 XOpimA9t3KJsvlcNrq9kn/5mzoh7cV68/RqNMAp8prWwT1RBurP8a7sPSs2L0tw5iQLQFe
 imtvkJtJ585cpzgUeYGJDzTifDDAgzM=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-217-G8Z1lVT7N9aeVDZ-deBKww-1; Fri, 27 Sep 2024 09:05:27 -0400
X-MC-Unique: G8Z1lVT7N9aeVDZ-deBKww-1
Received: by mail-yw1-f199.google.com with SMTP id
 00721157ae682-6ddbcc96984so31674137b3.2
 for <qemu-devel@nongnu.org>; Fri, 27 Sep 2024 06:05:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727442326; x=1728047126;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oGzWdE/vsmIlgPj6crdxLyzox8j9GoYUSTFvWFf4zec=;
 b=ExExtnBlNXjpxHCjCgLFfYLdoXxuGYi1trOW6SFrDrOIxXagyJ9ORg4eOzFCvt5aIf
 iCHhbrzn3EXoQiSzVK7V+F8Tpvknln7nVzTb4OWrkud84AwkQjT83X95tI1f32I1n7h5
 tSOJ0HfXdPdDlqxjhSwkyfZeU71OyCINZxO19on6GmZNt1Q5lHR3N80hdrEib07ez/nH
 3lKcH1Btwv4VQKYN0fsj4/py4xc6j+/B7gaMLGyvRXUy+EW0wH765aOfauVc4/7dBL3Q
 r4fx+z06zSaYR+qXIJtpzsAnr7KRYZkRl5wFZgkf9QHl2X7CHKOWIb0dBD7TrtnAQ8At
 LO6A==
X-Gm-Message-State: AOJu0Ywfk4E7DbOr1cig5fLS1VJ8CNblCdYVqdxLRR/0/L+Yk7lGn9mT
 sBYql7OXSA5Ptj9xkSyUtteu5Ci8nqupBppuXTDUe8JPhI31/wusszCj51ZU363QLJ0HI5vqZFm
 Ez8tPEIiyVYOVGyS6LZiX5JhZ8gYdvg8dzvwvA+5xVGSseRqhjxcpjDq+9SqtF7tui5Uw4OTHhB
 klkadzJG/HjY4aY0Yv6Utu24D/rK4=
X-Received: by 2002:a05:690c:f0e:b0:6e2:bcc:bccc with SMTP id
 00721157ae682-6e2474e1f36mr25597757b3.4.1727442326238; 
 Fri, 27 Sep 2024 06:05:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGhj+Qd3Jb+pbxiGfzJ8jSWye04jd/Vpuw4ZcfqYlmg64Ggg85aS7mzoz/t71cwQ+VXUCZqKPZUWH/K1yOu0xU=
X-Received: by 2002:a05:690c:f0e:b0:6e2:bcc:bccc with SMTP id
 00721157ae682-6e2474e1f36mr25597257b3.4.1727442325773; Fri, 27 Sep 2024
 06:05:25 -0700 (PDT)
MIME-Version: 1.0
References: <20240924130554.749278-1-marcandre.lureau@redhat.com>
 <20240924130554.749278-19-marcandre.lureau@redhat.com>
In-Reply-To: <20240924130554.749278-19-marcandre.lureau@redhat.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Fri, 27 Sep 2024 15:04:49 +0200
Message-ID: <CAJaqyWegTNj7dBjueoV_-WVUSKYZQ=ELesmE_7PPiuWeNwoFJA@mail.gmail.com>
Subject: Re: [PATCH v2 18/22] hw/virtio: fix -Werror=maybe-uninitialized
 false-positive
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, Song Gao <gaosong@loongson.cn>, 
 Peter Xu <peterx@redhat.com>, Bin Meng <bmeng.cn@gmail.com>, 
 Mahmoud Mandour <ma.mandourr@gmail.com>, Hyman Huang <yong.huang@smartx.com>, 
 Klaus Jensen <its@irrelevant.dk>, Alexandre Iooss <erdnaxe@crans.org>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 John Snow <jsnow@redhat.com>, Jesper Devantier <foss@defmacro.it>,
 Bin Meng <bin.meng@windriver.com>, 
 Greg Kurz <groug@kaod.org>, Stefan Hajnoczi <stefanha@redhat.com>, 
 Yuval Shaia <yuval.shaia.ml@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, Fabiano Rosas <farosas@suse.de>,
 Keith Busch <kbusch@kernel.org>, Eric Blake <eblake@redhat.com>,
 qemu-block@nongnu.org, 
 Kevin Wolf <kwolf@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Gerd Hoffmann <kraxel@redhat.com>, 
 Fam Zheng <fam@euphon.net>, Eduardo Habkost <eduardo@habkost.net>, 
 Stefano Garzarella <sgarzare@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.15,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Tue, Sep 24, 2024 at 3:07=E2=80=AFPM <marcandre.lureau@redhat.com> wrote=
:
>
> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> ../hw/virtio/vhost-shadow-virtqueue.c:545:13: error: =E2=80=98r=E2=80=99 =
may be used uninitialized [-Werror=3Dmaybe-uninitialized]
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  hw/virtio/vhost-shadow-virtqueue.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/virtio/vhost-shadow-virtqueue.c b/hw/virtio/vhost-shadow-=
virtqueue.c
> index fc5f408f77..cd29cc795b 100644
> --- a/hw/virtio/vhost-shadow-virtqueue.c
> +++ b/hw/virtio/vhost-shadow-virtqueue.c
> @@ -526,7 +526,7 @@ static void vhost_svq_flush(VhostShadowVirtqueue *svq=
,
>  size_t vhost_svq_poll(VhostShadowVirtqueue *svq, size_t num)
>  {
>      size_t len =3D 0;
> -    uint32_t r;
> +    uint32_t r =3D 0;
>

I understand this is a bulk changeset to avoid the warning, but does
this mean we cannot use pointer arguments to just return information
anymore? vhost_svq_get_buf just write to it, it never reads it.

If you post a second version and it is convenient for you, it would be
useful to move it inside of the while.

Any way we solve it,

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

>      while (num--) {
>          int64_t start_us =3D g_get_monotonic_time();
> --
> 2.45.2.827.g557ae147e6
>


