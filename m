Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64284C25B10
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 13:21:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6VcH-00015E-QA; Mon, 13 May 2024 09:21:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1s6VcD-00014j-Tc
 for qemu-devel@nongnu.org; Mon, 13 May 2024 09:21:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1s6VcC-0004X1-DL
 for qemu-devel@nongnu.org; Mon, 13 May 2024 09:21:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715606475;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nMPx9BYF/FXZkgPN5d3M2Z+jFC/FpE1YuelrHycI02M=;
 b=WV6Y97lvajE2140zwITdnykIWT6Pv/7hFeS6QkZI9KeLn0sN6PXcMmpH8XWOxvDBJGygcY
 vkt+s1erxwiYd89QmmyDmr3NGsYF+xJgkiVl5tViUJpmuTYzscPmZjcXVqWacgMir9Fxv7
 KLb7/k88g2i9kvqxbr9YSBTMD8IVtxk=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-pZue5JqyO4ud_OMS08oGxw-1; Mon, 13 May 2024 09:21:14 -0400
X-MC-Unique: pZue5JqyO4ud_OMS08oGxw-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-558aafe9bf2so3175156a12.1
 for <qemu-devel@nongnu.org>; Mon, 13 May 2024 06:21:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715606473; x=1716211273;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nMPx9BYF/FXZkgPN5d3M2Z+jFC/FpE1YuelrHycI02M=;
 b=KZvsffTUw5f5vN7anyMtWfa2fXIezOE/kPxXFDLg944qWwvh7zS6ZQQ1lBtQtHAJga
 ljzKkBnMnj04IbQIeXg8sQnU7rJexPbf4ASXPfKGzojHvHVhABqzUsNtGJk4Yb1rdAy2
 uJQazC0GVzoQc7OAY9kmI1U8LwSkIS8qZ4PB3CuLVhGtzBgn1Q7uhK6VO+01pCPW4Uo+
 gUZxLNoky10FjrK6yjCIdg5tYnQWCOAk7Bze3i1vaBEJoWNlQiV6Qdll4StiHil2jNxw
 x9YqWwdA41/2lixtmAvlIwJ/XW9wu9TVT4Ut7R2EYMyq4xSZFfumV3x6X40mfWpoXAyx
 5l/g==
X-Gm-Message-State: AOJu0YyUMEL78fY5d5VKEQ7bpEY7d3yJTTeCiX/RrD3Awztc/4stSsaF
 gKt5fjm1qBx3y2XvehkbD3uqwWlnv/KlhjaOFz66mi6X6RjYNfelYk2xZR24p+UghgVvXNLqG2E
 xQRW4ysCwNy+OG22uOha9q5X249dndE/PF+UAj/OGPS3gOlyMrJlzZQFJvZ827RU5ZbpbgX5etP
 3XEejwFx31hieQOMOvRrhEhRoO/wE=
X-Received: by 2002:a50:f699:0:b0:572:7c99:a280 with SMTP id
 4fb4d7f45d1cf-5734d5c0c28mr7146761a12.15.1715606473064; 
 Mon, 13 May 2024 06:21:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGmSivBygLwj6aEWyKUvfRFjUVko5ee8kxREWT212iRK3FsACdtE9SQDjFlhKjCo3g35hfx/XNZ4fXEb5DImoA=
X-Received: by 2002:a50:f699:0:b0:572:7c99:a280 with SMTP id
 4fb4d7f45d1cf-5734d5c0c28mr7146738a12.15.1715606472697; Mon, 13 May 2024
 06:21:12 -0700 (PDT)
MIME-Version: 1.0
References: <20240513071905.499143-1-marcandre.lureau@redhat.com>
 <fc9483ba-513d-4796-b5e3-68819125c4c7@proxmox.com>
In-Reply-To: <fc9483ba-513d-4796-b5e3-68819125c4c7@proxmox.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Mon, 13 May 2024 17:21:00 +0400
Message-ID: <CAMxuvawqFHU7EVhQAcyRq=OLB1+f9q90mdSsEZrv1C5AR_JzRg@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] Fix "virtio-gpu: fix scanout migration post-load"
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Eduardo Habkost <eduardo@habkost.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.974,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hi Fiona

On Mon, May 13, 2024 at 4:56=E2=80=AFPM Fiona Ebner <f.ebner@proxmox.com> w=
rote:
>
> Hi,
>
> Am 13.05.24 um 09:19 schrieb marcandre.lureau@redhat.com:
> > From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >
> > Hi,
> >
> > The aforementioned patch breaks virtio-gpu device migrations for versio=
ns
> > pre-9.0/9.0, both forwards and backwards. Versioning of `VMS_STRUCT` is=
 more
> > complex than it may initially appear, as evidenced in the problematic c=
ommit
> > dfcf74fa68c ("virtio-gpu: fix scanout migration post-load").
> >
> > v2:
> >  - use a manual version field test (instead of the more complex struct =
variant)
> >
>
> Unfortunately, when creating a snapshot with machine type pc-i440fx-9.0
> and trying to load it afterwards (both times with patches on top of
> current master), it'll fail with:
>
> > qemu-system-x86_64: virtio-gpu-scanouts: incoming version_id 2 is too n=
ew for local version_id 1
> > qemu-system-x86_64: Missing section footer for 0000:00:02.0/virtio-gpu
> > qemu-system-x86_64: Error -22 while loading VM state
>
> Is there a bump to virtio-gpu-scanouts' version_id missing?
>

Indeed, it needs:

diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 5de90bb62f..3a88eb5e3a 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -1201,7 +1201,7 @@ static const VMStateDescription
vmstate_virtio_gpu_scanout =3D {

 static const VMStateDescription vmstate_virtio_gpu_scanouts =3D {
     .name =3D "virtio-gpu-scanouts",
-    .version_id =3D 1,
+    .version_id =3D 2,


