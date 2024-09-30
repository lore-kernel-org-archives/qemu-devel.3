Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95E4BCF6491
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2024 08:08:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svBSS-0000a2-RE; Mon, 30 Sep 2024 04:08:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1svBSO-0000Mb-IK
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 04:08:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1svBSM-0004hS-RQ
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 04:08:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727683713;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gLcrxA89quyj9PBJmO6u8kraN+hv3PjIw3p//FZwKrE=;
 b=DGPuIVpmLJgpk4pSHT3agUkdLBwMAufxG65jqNbB+/ckW8q7Fc+HmANQtJPnR0YeVKhMsG
 ZRgZgkrhdPhdvuJh394TK/Ys2uhptOj9J+f3FbX023x2AjLNi7OsYLy92Z4JspSc7pXDq2
 02GtIP9kEjJbqrVKW/oLipTeCvozs9c=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-7fojj74eMDuZn6o33oQx-A-1; Mon, 30 Sep 2024 04:08:32 -0400
X-MC-Unique: 7fojj74eMDuZn6o33oQx-A-1
Received: by mail-yb1-f199.google.com with SMTP id
 3f1490d57ef6-e25d62bfe12so5786796276.0
 for <qemu-devel@nongnu.org>; Mon, 30 Sep 2024 01:08:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727683711; x=1728288511;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gLcrxA89quyj9PBJmO6u8kraN+hv3PjIw3p//FZwKrE=;
 b=mM2fKQtXL87C3I1Qng2otFawUvDxeScrHvJ2jH865U6ruLRXUHUeqwMswj7dXdVDFx
 tIKb+Kx4IliR4zDmbCrcNf3wG2E4AaspKmuxqzmdpzs59lHnJ/2JSIlurfW8H75Qb246
 8FP8Flicu0uU56Au8E7s61Wjx1VkEmMDotmMiX0Lqk5Rm24EJKBh1ksh2kAJIvgGhEBD
 XZR18rYp4VmLOuZr+PXmC+uv8ZbG+rkLxPOa1U3LLSGOewge5na0fi0Lx8fzpy6HNOmC
 bR22CcGn8baQEW9c8A3QFck3yFkf4tOGs9OwxPrE1N8lWHypglV894RlQBJlP1z+HD/u
 DXnQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWSbKZIoOHZkwt79CAjvyrRUJ8uIfRZUpBIgU+9kgjmjz4yZSBNsIb+EqD07Vz4CmWPC/U4DcVxQKj4@nongnu.org
X-Gm-Message-State: AOJu0YydHA8jxq2DQyVu8/gD8hUBeBUVx0B3DqPp/NiSDJbBxzzMqKgO
 amwCgXRQxrp1ev0kHYfBTkT1zBejyGzgBxr00hsi+EsDRKj/ObEBhfptwUO1Sedcac1EaG7m6gn
 ZUhlBD3yP3MRokUHn+agPZQm202q9rlVZDV2VY661OQ0wYBYI8lxpKQq7qIv/TJxibJi9Y/9qyI
 oTLKmDLRNG3hH1+3lVZkDnUgxAt7Y=
X-Received: by 2002:a05:6902:f85:b0:e25:dace:d4a8 with SMTP id
 3f1490d57ef6-e2604c7b5bbmr6888059276.41.1727683711453; 
 Mon, 30 Sep 2024 01:08:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHRflEfSbdkEu8iRCF5fXida0/ho3N+UK72uEp4JsuhGeW5kZlgKMq9AMetxBZVQTR32oj11R/wLwm7ze3ievU=
X-Received: by 2002:a05:6902:f85:b0:e25:dace:d4a8 with SMTP id
 3f1490d57ef6-e2604c7b5bbmr6888053276.41.1727683711006; Mon, 30 Sep 2024
 01:08:31 -0700 (PDT)
MIME-Version: 1.0
References: <20240924130554.749278-1-marcandre.lureau@redhat.com>
 <20240924130554.749278-19-marcandre.lureau@redhat.com>
 <CAJaqyWegTNj7dBjueoV_-WVUSKYZQ=ELesmE_7PPiuWeNwoFJA@mail.gmail.com>
In-Reply-To: <CAJaqyWegTNj7dBjueoV_-WVUSKYZQ=ELesmE_7PPiuWeNwoFJA@mail.gmail.com>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Mon, 30 Sep 2024 10:08:19 +0200
Message-ID: <CAGxU2F67P0rJLgXz-UowDgPVsE-6uyemvcefoej40qpAL97N5w@mail.gmail.com>
Subject: Re: [PATCH v2 18/22] hw/virtio: fix -Werror=maybe-uninitialized
 false-positive
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: marcandre.lureau@redhat.com, qemu-devel@nongnu.org, 
 Song Gao <gaosong@loongson.cn>, Peter Xu <peterx@redhat.com>,
 Bin Meng <bmeng.cn@gmail.com>, 
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
 Hanna Reitz <hreitz@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.095,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Sep 27, 2024 at 3:05=E2=80=AFPM Eugenio Perez Martin
<eperezma@redhat.com> wrote:
>
> On Tue, Sep 24, 2024 at 3:07=E2=80=AFPM <marcandre.lureau@redhat.com> wro=
te:
> >
> > From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >
> > ../hw/virtio/vhost-shadow-virtqueue.c:545:13: error: =E2=80=98r=E2=80=
=99 may be used uninitialized [-Werror=3Dmaybe-uninitialized]
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  hw/virtio/vhost-shadow-virtqueue.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/hw/virtio/vhost-shadow-virtqueue.c b/hw/virtio/vhost-shado=
w-virtqueue.c
> > index fc5f408f77..cd29cc795b 100644
> > --- a/hw/virtio/vhost-shadow-virtqueue.c
> > +++ b/hw/virtio/vhost-shadow-virtqueue.c
> > @@ -526,7 +526,7 @@ static void vhost_svq_flush(VhostShadowVirtqueue *s=
vq,
> >  size_t vhost_svq_poll(VhostShadowVirtqueue *svq, size_t num)
> >  {
> >      size_t len =3D 0;
> > -    uint32_t r;
> > +    uint32_t r =3D 0;
> >
>
> I understand this is a bulk changeset to avoid the warning, but does
> this mean we cannot use pointer arguments to just return information
> anymore? vhost_svq_get_buf just write to it, it never reads it.

Sure we can, the problem here is that vhost_svq_get_buf() might return
without having written there (in the error path).

>
> If you post a second version and it is convenient for you, it would be
> useful to move it inside of the while.

I think it is the only way, if we keep it out we have the problem from
the second loop on (always in the error path).

>
> Any way we solve it,
>
> Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
>
> >      while (num--) {
> >          int64_t start_us =3D g_get_monotonic_time();
> > --
> > 2.45.2.827.g557ae147e6
> >
>


