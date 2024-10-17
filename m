Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84E68D21264
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2024 09:13:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1MYu-0004Ta-GY; Thu, 17 Oct 2024 05:12:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1t1MYs-0004S5-Eq
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 05:12:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1t1MYq-000270-I6
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 05:12:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729156366;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Icshfnw6+ATAJ4JHzy9zRwJy9xH2/3Mc8kETFIpWldk=;
 b=TOQt66E5PChLKtqNBYrqlE0oUeBz7M5+mhKkk1xX/aKkW2NbSc3Sj8NOPdCzzefU2awcPO
 00vhlRygz99lYkSlk9fp2n2SK2TUnc5WbN+UT6kYniDEpses2MAnD8/AdbbDY2d46JruGy
 gtC6CmRjeXh36ycfWyqKSvA7Y2Ab/yw=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-314-7hWzTWqsNYapBbHmgryIcQ-1; Thu, 17 Oct 2024 05:12:45 -0400
X-MC-Unique: 7hWzTWqsNYapBbHmgryIcQ-1
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-71e4eb311c1so702386b3a.0
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2024 02:12:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729156364; x=1729761164;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Icshfnw6+ATAJ4JHzy9zRwJy9xH2/3Mc8kETFIpWldk=;
 b=Nflh9rQwsUULvgtNPH6i2cuKmY0mDzHk/Zw2WVlczs/+TKStQ1zNrOq6as0iFaHlzX
 G32SxCSYrKjH5/MwFrPqZAC1XBrDLWNxk6ouTek6rZ5WmdM85ltVKemgH+uhKsPfYhf2
 LoF39XjIxoTZAAjFn6oVZT2iq15LagjCV301ktWfAauH+hArqxAZM1bAeCvxjA11PHJ4
 +pGhvmVDmmlPdFM/u4O+RJ5CxrJ5PzkbcKugrFSCl992zP/8e6m74YANVIOtVv6NW6l0
 ksa+3JxWgxkPzgQ7mnAXBzb/7Qpm3NNpZYsCd5/MUFQZUU+5Rdsg61z4ZgGj9YbJZ8DD
 5DNw==
X-Gm-Message-State: AOJu0YyhZ+1nVLrSpWLK3E7SidHpLoCb2JDKDLZhKAMC0ZvBsObFP2hw
 M1ZQGQ19LRHxTW1Kr3pJF7RAVfHNmfKLrb19+h+fcbe9Fwi8OVsuajUZN1wqKKPno0P311HlwmJ
 214FkL2zjMEhMtdYp6YG704A7lIpVo84CH3xlBBK6qpvN9kGI0RCK8GK5DJiSPMN50mLLZxGCK2
 CQgYiIfRtXIJe6JXDX0tzXMfnsx5I=
X-Received: by 2002:a05:6a20:d502:b0:1d9:2018:9e24 with SMTP id
 adf61e73a8af0-1d92018b707mr1803314637.10.1729156364358; 
 Thu, 17 Oct 2024 02:12:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGUhLUpzfiYPi6SqpL42j3NS+aP+4eu3Lc9YX6DnmxmQffEP0GWOwowKf6wh1CUA9oOIvSeMafiFV6QDCZvPLg=
X-Received: by 2002:a05:6a20:d502:b0:1d9:2018:9e24 with SMTP id
 adf61e73a8af0-1d92018b707mr1803303637.10.1729156364063; Thu, 17 Oct 2024
 02:12:44 -0700 (PDT)
MIME-Version: 1.0
References: <20241016090606.2358056-1-aesteve@redhat.com>
 <ZxDOZjIixsfvGuQT@redhat.com>
In-Reply-To: <ZxDOZjIixsfvGuQT@redhat.com>
From: Albert Esteve <aesteve@redhat.com>
Date: Thu, 17 Oct 2024 11:12:32 +0200
Message-ID: <CADSE00+ae2kQSM-d=m=ach=KOyH5ffKWRLcpCuyb0s35SED=vg@mail.gmail.com>
Subject: Re: [PATCH] vhost-user: fix shared object return values
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, dbassey@redhat.com, 
 Stefano Garzarella <sgarzare@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=aesteve@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.038,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Oct 17, 2024 at 10:44=E2=80=AFAM Daniel P. Berrang=C3=A9 <berrange@=
redhat.com> wrote:
>
> On Wed, Oct 16, 2024 at 11:06:06AM +0200, Albert Esteve wrote:
> > VHOST_USER_BACKEND_SHARED_OBJECT_ADD and
> > VHOST_USER_BACKEND_SHARED_OBJECT_REMOVE state
> > in the spec that they return 0 for successful
> > operations, non-zero otherwise. However,
> > implementation relies on the return types
> > of the virtio-dmabuf library, with opposite
> > semantics (true if everything is correct,
> > false otherwise). Therefore, current implementaion
> > violates the specification.
> >
> > Revert the logic so that the implementation
> > of the vhost-user handling methods matches
> > the specification.
> >
> > Fixes: 043e127a126bb3ceb5fc753deee27d261fd0c5ce
> > Fixes: 160947666276c5b7f6bca4d746bcac2966635d79
> > Signed-off-by: Albert Esteve <aesteve@redhat.com>
> > ---
> >  hw/virtio/vhost-user.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> > index 00561daa06..90917352a4 100644
> > --- a/hw/virtio/vhost-user.c
> > +++ b/hw/virtio/vhost-user.c
> > @@ -1607,7 +1607,7 @@ vhost_user_backend_handle_shared_object_add(struc=
t vhost_dev *dev,
> >      QemuUUID uuid;
> >
> >      memcpy(uuid.data, object->uuid, sizeof(object->uuid));
> > -    return virtio_add_vhost_device(&uuid, dev);
> > +    return !virtio_add_vhost_device(&uuid, dev);
> >  }
>
> This virtio_add_vhost_device() method returns a bool, but this
> vhost_user_backend_handle_shared_object_add() method returns
> an int, but fills that int with an inverted bool value. The
> caller then assigns the return value to an int, but then
> interprets the int as a bool, and assigns that bool result
> to an u64.
>
> This call chain is madness :-(

TBF most of the madness is part of the already existing
handling infrastructure.
vhost_user_backend_handle_shared_object_add()
returns an int to be consistent with other handling
functions.

>
> Change vhost_user_backend_handle_shared_object_add to return
> a bool to reduce the madness IMHO.

Changing it to bool would make it inconsistent
wrt other handlers, and the casting would happen nonetheless
on assignment. Not sure if that is an improvement.

>
> >
> >  static int
> > @@ -1623,16 +1623,16 @@ vhost_user_backend_handle_shared_object_remove(=
struct vhost_dev *dev,
> >          struct vhost_dev *owner =3D virtio_lookup_vhost_device(&uuid);
> >          if (dev !=3D owner) {
> >              /* Not allowed to remove non-owned entries */
> > -            return 0;
> > +            return -EPERM;
> >          }
> >          break;
> >      }
> >      default:
> >          /* Not allowed to remove non-owned entries */
> > -        return 0;
> > +        return -EPERM;
> >      }
> >
> > -    return virtio_remove_resource(&uuid);
> > +    return !virtio_remove_resource(&uuid);
> >  }
>
> These return values are inconsistent.
>
> In some places you're returning a negative errno, but in this
> last place you're returning true or false, by calling
> virtio_remove_resource which is a 'bool' method & inverting it.

Well, specification only distinguish between zero and non-zero values.
But for clarity, I guess I could do something like:
```
if (!virtio_remove_resource(&uuid)) {
    return -EINVAL;
}

return 0;
```

Same for the vhost_user_backend_handle_shared_object_add()
handler (in that case there is no inconsistency with positive or negative
return values, but still better to maintain similar strategy for all
handlers).

BR,
Albert.

>
> On top of this inconsistency, it has all the same madness mentioneed
> above.
>
> With regards,
> Daniel
> --
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
>


