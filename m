Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D95F1D21262
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2024 09:30:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1Moo-0001dx-Tj; Thu, 17 Oct 2024 05:29:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1t1Mom-0001dc-98
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 05:29:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1t1Mok-0005lF-Dy
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 05:29:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729157352;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tSF/GaYPUD6t5KMzn2s6TJDU1Be1IqJ+maF9b9wwYAA=;
 b=ZD+BEU9W2EBh8JxCNVAVKU/TYCfC+nyDh3nc7IW1f9LofBcxmZyXo53znx7VE9DPmL85j1
 O98g6oycBbvbAWNrw8RCDXCRd2ZhU/AWzL+EpPSEUidZ8D12C3Tj0PTLZkTJ6+g4D9iEUO
 BLsEJafEiF/5q8RS8VsjCLMA+r0rHKM=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-82-ihRRmdAcPH6Z05oN8NJgSw-1; Thu, 17 Oct 2024 05:29:11 -0400
X-MC-Unique: ihRRmdAcPH6Z05oN8NJgSw-1
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-2e2cc47ce63so660547a91.3
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2024 02:29:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729157350; x=1729762150;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tSF/GaYPUD6t5KMzn2s6TJDU1Be1IqJ+maF9b9wwYAA=;
 b=gmxl3h5KBLHXydxy2mVGIOP9nmAJD5qXYFDSrBlseohNBMp/6kgE4ZUFMA1bMNhqiD
 w1bmIazgdGbEEISzqXQ8G09fq13B515RSP7/lr6byRuebb8tkKbejo3Tof7Iimtlyvjg
 i+FU/drgybKPXwDTJ7O7G/PWrDSNnTJlUwBmBSnHDW0vFiMJc/cxlz8URutiCm30CnSe
 K6Out3OimIvrLBwpesPQ6ReJIYpkFHv1F/NA8P4OYa4UnOhAb2BIecvuXz32GOfwYY6i
 aPnl2sZHAsHHmBmoSWCkD2Mwlq9wsRnBHPyo+u/udUdt76BT218kkoD1cu6126gBTjMS
 A62A==
X-Gm-Message-State: AOJu0YyvclsAt73uSkaruWvoo+dFdy75mT3CkD5eiDGA00sB9RxoCopL
 8EvYKZ4R467whXhwzeSBnN9jCp+jJmxKpbvvNXCvCf4DCcs5Tn5MLawV5UjuqPh2Bdw4Xl989qU
 BPwAyhsgKTq1e+TjCX2WXRPSyAFzVYnWR0KHL8DR3FKguYyKIz1a6QxZdo/lJi3T8kZLhPXQhZx
 ciVd5WaiRMQMR3D4PAQv6EHeZKvxAt09ddtOUs0DUu
X-Received: by 2002:a17:90b:1294:b0:2e2:e5d0:dabc with SMTP id
 98e67ed59e1d1-2e3ab7fdd63mr7959529a91.11.1729157348386; 
 Thu, 17 Oct 2024 02:29:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEjgnE2B98xL1Sf7gzpx7o2XD7EjPLlt2MaTiLZyzvaQ5YqQVwhEBl9HNuouBQEvvZpA51C6LgW3s2oNKXdSY4=
X-Received: by 2002:a17:90b:1294:b0:2e2:e5d0:dabc with SMTP id
 98e67ed59e1d1-2e3ab7fdd63mr7959512a91.11.1729157347993; Thu, 17 Oct 2024
 02:29:07 -0700 (PDT)
MIME-Version: 1.0
References: <20241016090606.2358056-1-aesteve@redhat.com>
 <ZxDOZjIixsfvGuQT@redhat.com>
 <CADSE00+ae2kQSM-d=m=ach=KOyH5ffKWRLcpCuyb0s35SED=vg@mail.gmail.com>
 <ZxDWQWpKfp7wJ_Nh@redhat.com>
In-Reply-To: <ZxDWQWpKfp7wJ_Nh@redhat.com>
From: Albert Esteve <aesteve@redhat.com>
Date: Thu, 17 Oct 2024 11:28:56 +0200
Message-ID: <CADSE00J32yA+A_tzp6eJxMoioUuQNEZvbyDoVCdqRErhORxFQg@mail.gmail.com>
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

On Thu, Oct 17, 2024 at 11:18=E2=80=AFAM Daniel P. Berrang=C3=A9 <berrange@=
redhat.com> wrote:
>
> On Thu, Oct 17, 2024 at 11:12:32AM +0200, Albert Esteve wrote:
> > On Thu, Oct 17, 2024 at 10:44=E2=80=AFAM Daniel P. Berrang=C3=A9 <berra=
nge@redhat.com> wrote:
> > >
> > > On Wed, Oct 16, 2024 at 11:06:06AM +0200, Albert Esteve wrote:
> > > > VHOST_USER_BACKEND_SHARED_OBJECT_ADD and
> > > > VHOST_USER_BACKEND_SHARED_OBJECT_REMOVE state
> > > > in the spec that they return 0 for successful
> > > > operations, non-zero otherwise. However,
> > > > implementation relies on the return types
> > > > of the virtio-dmabuf library, with opposite
> > > > semantics (true if everything is correct,
> > > > false otherwise). Therefore, current implementaion
> > > > violates the specification.
> > > >
> > > > Revert the logic so that the implementation
> > > > of the vhost-user handling methods matches
> > > > the specification.
> > > >
> > > > Fixes: 043e127a126bb3ceb5fc753deee27d261fd0c5ce
> > > > Fixes: 160947666276c5b7f6bca4d746bcac2966635d79
> > > > Signed-off-by: Albert Esteve <aesteve@redhat.com>
> > > > ---
> > > >  hw/virtio/vhost-user.c | 8 ++++----
> > > >  1 file changed, 4 insertions(+), 4 deletions(-)
> > > >
> > > > diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> > > > index 00561daa06..90917352a4 100644
> > > > --- a/hw/virtio/vhost-user.c
> > > > +++ b/hw/virtio/vhost-user.c
> > > > @@ -1607,7 +1607,7 @@ vhost_user_backend_handle_shared_object_add(s=
truct vhost_dev *dev,
> > > >      QemuUUID uuid;
> > > >
> > > >      memcpy(uuid.data, object->uuid, sizeof(object->uuid));
> > > > -    return virtio_add_vhost_device(&uuid, dev);
> > > > +    return !virtio_add_vhost_device(&uuid, dev);
> > > >  }
> > >
> > > This virtio_add_vhost_device() method returns a bool, but this
> > > vhost_user_backend_handle_shared_object_add() method returns
> > > an int, but fills that int with an inverted bool value. The
> > > caller then assigns the return value to an int, but then
> > > interprets the int as a bool, and assigns that bool result
> > > to an u64.
> > >
> > > This call chain is madness :-(
> >
> > TBF most of the madness is part of the already existing
> > handling infrastructure.
> > vhost_user_backend_handle_shared_object_add()
> > returns an int to be consistent with other handling
> > functions.
> >
> > >
> > > Change vhost_user_backend_handle_shared_object_add to return
> > > a bool to reduce the madness IMHO.
> >
> > Changing it to bool would make it inconsistent
> > wrt other handlers, and the casting would happen nonetheless
> > on assignment. Not sure if that is an improvement.
>
> Well when the caller does
>
>         payload.u64 =3D !!ret;
>
> it is saying that it only cares about the values
> being 0 or 1. So how about just making these
> methods return 0 or 1 then.

Ah, I see your point. I introduced negative error
values just because I saw other handlers doing
it (e.g., vhost_user_backend_handle_vring_host_notifier()).

>
> >
> > >
> > > >
> > > >  static int
> > > > @@ -1623,16 +1623,16 @@ vhost_user_backend_handle_shared_object_rem=
ove(struct vhost_dev *dev,
> > > >          struct vhost_dev *owner =3D virtio_lookup_vhost_device(&uu=
id);
> > > >          if (dev !=3D owner) {
> > > >              /* Not allowed to remove non-owned entries */
> > > > -            return 0;
> > > > +            return -EPERM;

So you are suggesting here it could be `return 1;` instead?
It does not look clear enough that it is an error value.

Maybe I could create a define like:

#define EVHOST_USER 1

and use it here (and probably a good idea to change other
handling functions in a different commit, to be consistent).
WDYT?

BR,
Albert.

> > > >          }
> > > >          break;
> > > >      }
> > > >      default:
> > > >          /* Not allowed to remove non-owned entries */
> > > > -        return 0;
> > > > +        return -EPERM;
> > > >      }
> > > >
> > > > -    return virtio_remove_resource(&uuid);
> > > > +    return !virtio_remove_resource(&uuid);
> > > >  }
> > >
> > > These return values are inconsistent.
> > >
> > > In some places you're returning a negative errno, but in this
> > > last place you're returning true or false, by calling
> > > virtio_remove_resource which is a 'bool' method & inverting it.
> >
> > Well, specification only distinguish between zero and non-zero values.
> > But for clarity, I guess I could do something like:
> > ```
> > if (!virtio_remove_resource(&uuid)) {
> >     return -EINVAL;
> > }
> >
> > return 0;
> > ```
> >
> > Same for the vhost_user_backend_handle_shared_object_add()
> > handler (in that case there is no inconsistency with positive or negati=
ve
> > return values, but still better to maintain similar strategy for all
> > handlers).
>
> Returning an errno value, when the caller only wants 0 or 1 is
> pointless.
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


