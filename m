Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEA0FD0E6C1
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 07:36:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2mx9-0004Rr-Iy; Mon, 21 Oct 2024 03:35:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1t2mx8-0004Rh-DX
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 03:35:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1t2mx6-0006ue-NM
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 03:35:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729496141;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V0Ra0ntiSI6kkUOr7X6kGFb2b/KJFpRzsaEf4zh0j2E=;
 b=e9J/sgd68Al18gIcVBLOAJGlU0KC+jEV1OnWT0NcwrKlt0zmwxRX8jbhJd6CNM84eWEyd4
 uTFYp5PHQ6mX9ZKudPYXAjQaNFQPIscxwfQdg8W9JtCODJL9r1CSjT5WYDzbCF2T9VCt5V
 zsKMDUzvYuV1Ha3M5Xdl/L9/XhZaIOg=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-321-NHU5D2PcNS-nZJhm9lYsTg-1; Mon, 21 Oct 2024 03:35:40 -0400
X-MC-Unique: NHU5D2PcNS-nZJhm9lYsTg-1
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-7d1fe1dd173so3301755a12.0
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2024 00:35:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729496139; x=1730100939;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V0Ra0ntiSI6kkUOr7X6kGFb2b/KJFpRzsaEf4zh0j2E=;
 b=VjmGGI51o/EJkDO6O5IURt5fcj4Hu038Lzq5F1ktzMnG8+d4gikjcBy5xKB+mCgPG0
 P7bD0ddJLA4aXFY3wZV3a8Dc9E3dWaG9wuGqpIHosem8f8zMqW/mPKd2mhhpFy2wUu+O
 I2NLutE+ERQZ0JcizINLhjWWzblM3otVfn6hv3RXa7V1bn2+ycsHBCDC+tYpCsldQND5
 V3v16fN+r+AbwxOKRMVHOZfJToA6Xsie6KiKuYo4nTZadxXc+aDKDZw5s8fmW3nZ2lJC
 bfX6iQZY4grUHtDIS9TaEaXBBOR++GOAbi7uwER1pTT0YtfUW/f8z4NYg/O9affbTK+J
 yCRw==
X-Gm-Message-State: AOJu0Yz1mN5XfKPZNdJWFMgxiIXIuTbXJet0hbF5uwRj5xZuhoLdqV57
 Zg+rFkJSG7b5t1FxSUl00qTUfhVHFt55hHFcIvoGm4vUP6VtNPWZ6bGeDAQhCkvMYAcCdiPZm4m
 rjN4HI+fuGui+1GIRKBTRYHqlDn0ZU1HyrIkqvqZKbNTdIpCwvCQbrEiYNoquWo0q6sAomlR+tv
 rgUoAoxLbImx78kLcf4moTpRTw22o2dCNcdx+LNw==
X-Received: by 2002:a05:6a21:1707:b0:1d9:29c8:2d32 with SMTP id
 adf61e73a8af0-1d92c4a5339mr15892468637.5.1729496138999; 
 Mon, 21 Oct 2024 00:35:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGF+Y6JwQOXEfTvKlk6aPVc84ziSVAMlQNY0jhk5K6XqhHPD55rkYuE/G3UuUvEaul/h5OqbLKuvKyqlOFtAfU=
X-Received: by 2002:a05:6a21:1707:b0:1d9:29c8:2d32 with SMTP id
 adf61e73a8af0-1d92c4a5339mr15892456637.5.1729496138667; Mon, 21 Oct 2024
 00:35:38 -0700 (PDT)
MIME-Version: 1.0
References: <20241016090606.2358056-1-aesteve@redhat.com>
 <vmtm4zz6pkfcxr64wixa2wdjb7ujn2vaiapmziaqciiytcwe5v@7fh6zlfyf67l>
 <CADSE00+UFCHOLQHndGThOmXt3eXo4RsJZKC+FyXOuaiPwJbBmQ@mail.gmail.com>
 <cyf4qzsx56lwi6zbwlclzbhgg3xqhi3btrfwinfx7h6gn4equh@3vigo2wevqug>
In-Reply-To: <cyf4qzsx56lwi6zbwlclzbhgg3xqhi3btrfwinfx7h6gn4equh@3vigo2wevqug>
From: Albert Esteve <aesteve@redhat.com>
Date: Mon, 21 Oct 2024 09:35:27 +0200
Message-ID: <CADSE00Li9Zz8qJn=0WggbHVJ2ET0fDeB9TKCFVSFLKB3M8ah+A@mail.gmail.com>
Subject: Re: [PATCH] vhost-user: fix shared object return values
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: qemu-devel@nongnu.org, dbassey@redhat.com, 
 "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=aesteve@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.527,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.699,
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

On Thu, Oct 17, 2024 at 11:38=E2=80=AFAM Stefano Garzarella <sgarzare@redha=
t.com> wrote:
>
> On Thu, Oct 17, 2024 at 10:27:30AM +0200, Albert Esteve wrote:
> >Albert Esteve
> >
> >Senior Software Engineer
> >
> >Red Hat
> >
> >aesteve@redhat.com
> >
> >
> >
> >On Thu, Oct 17, 2024 at 9:38=E2=80=AFAM Stefano Garzarella <sgarzare@red=
hat.com> wrote:
> >>
> >> On Wed, Oct 16, 2024 at 11:06:06AM +0200, Albert Esteve wrote:
> >> >VHOST_USER_BACKEND_SHARED_OBJECT_ADD and
> >> >VHOST_USER_BACKEND_SHARED_OBJECT_REMOVE state
> >> >in the spec that they return 0 for successful
> >> >operations, non-zero otherwise. However,
> >> >implementation relies on the return types
> >> >of the virtio-dmabuf library, with opposite
> >> >semantics (true if everything is correct,
> >> >false otherwise). Therefore, current implementaion
> >>
> >> s/implementaion/implementation
> >>
> >> I hadn't seen it ;-P found with:
> >> ./scripts/checkpatch.pl --strict --branch master..HEAD --codespell
> >
> >Never used the checkpatch script for spelling. Thanks!
> >
> >>
> >> >violates the specification.
> >> >
> >> >Revert the logic so that the implementation
> >> >of the vhost-user handling methods matches
> >> >the specification.
> >> >
> >> >Fixes: 043e127a126bb3ceb5fc753deee27d261fd0c5ce
> >>
> >> This is in from 9.0 ...
> >>
> >> >Fixes: 160947666276c5b7f6bca4d746bcac2966635d79
> >>
> >> ... and this from 8.2, so should we consider stable branches?
> >
> >You mean in addition to the commits already reflected here?
>
> Nope, I just mean if we need to cc qemu-stable@nongnu.org in order to
> backport this patch on stable branches.
> See docs/devel/stable-process.rst

Got it, thanks!

>
> >
> >>
> >> I think it depends if the backends are checking that return value.
> >
> >The return value is optional (requires VHOST_USER_NEED_REPLY),
> >and I am not aware of any backend using this feature so far,
> >in general. So iiuc, that'd mean no need to include stable, right?
>
> Yep, if no one uses it, we can avoid it for now. On the other hand if
> the patch is simple, perhaps it might make sense to avoid future issues.

I will wait until tomorrow and post a new version of the patch fixing the t=
ypo
and changing the return as suggested by Daniel.
The patch is simple, so it could make sense to include stable. But in princ=
iple,
I understood that I can avoid stable for now. If we decide otherwise and I
have already sent v2, we can add them a posteriori I guess.

BR,
Albert.

>
> Michael WDYT?
>
> Thanks
> Stefano
>
> >
> >Best,
> >Albert.
> >
> >>
> >> >Signed-off-by: Albert Esteve <aesteve@redhat.com>
> >> >---
> >> > hw/virtio/vhost-user.c | 8 ++++----
> >> > 1 file changed, 4 insertions(+), 4 deletions(-)
> >>
> >> Thanks for the fix!
> >>
> >> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
> >>
> >> >
> >> >diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> >> >index 00561daa06..90917352a4 100644
> >> >--- a/hw/virtio/vhost-user.c
> >> >+++ b/hw/virtio/vhost-user.c
> >> >@@ -1607,7 +1607,7 @@ vhost_user_backend_handle_shared_object_add(str=
uct vhost_dev *dev,
> >> >     QemuUUID uuid;
> >> >
> >> >     memcpy(uuid.data, object->uuid, sizeof(object->uuid));
> >> >-    return virtio_add_vhost_device(&uuid, dev);
> >> >+    return !virtio_add_vhost_device(&uuid, dev);
> >> > }
> >> >
> >> > static int
> >> >@@ -1623,16 +1623,16 @@ vhost_user_backend_handle_shared_object_remov=
e(struct vhost_dev *dev,
> >> >         struct vhost_dev *owner =3D virtio_lookup_vhost_device(&uuid=
);
> >> >         if (dev !=3D owner) {
> >> >             /* Not allowed to remove non-owned entries */
> >> >-            return 0;
> >> >+            return -EPERM;
> >> >         }
> >> >         break;
> >> >     }
> >> >     default:
> >> >         /* Not allowed to remove non-owned entries */
> >> >-        return 0;
> >> >+        return -EPERM;
> >> >     }
> >> >
> >> >-    return virtio_remove_resource(&uuid);
> >> >+    return !virtio_remove_resource(&uuid);
> >> > }
> >> >
> >> > static bool vhost_user_send_resp(QIOChannel *ioc, VhostUserHeader *h=
dr,
> >> >--
> >> >2.46.1
> >> >
> >>
> >
>


