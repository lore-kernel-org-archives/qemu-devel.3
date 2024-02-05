Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EFFFC48295
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Feb 2024 12:58:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWyXn-0007tS-Eo; Mon, 05 Feb 2024 07:57:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rWyXl-0007tI-TV
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 07:57:49 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rWyXk-0001w0-7b
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 07:57:49 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-40fd2f7ef55so8448475e9.0
 for <qemu-devel@nongnu.org>; Mon, 05 Feb 2024 04:57:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707137866; x=1707742666; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4WVtlpee/s+afrtGz/gbgUlpRyHzxaEAIdxd7N+ZjyA=;
 b=Y/YHR0n31L0YTl/ya7XNme6Gg32xWEAz1pcueFRRhpalOn2Sl0/8vYw0Ibii74kJjN
 l+KKtV6HiWDR/yqZJkyGzqKZuGqy8gXtRbZaatRJr7SiVvEr1ol/dRPU7CoOYptyL7fZ
 8tun613XZsSgnK+GeP3XcqfUKhsVGmLq/QaWhFCBGQzJZmfnIaoSaZNKA9meMZWeKsAO
 3yVK6xDvS5Ho3qI9LTW2+WxrCNxyuOFI3ZFueD/KMbtP1Z4nlXLkNU6Kr+/qCXh9+6Cc
 FCPVm74SzBWZSsWtLudnhU4kWymBQ0Z+ywknrpum7oTGz1htXDlCCTGnFLwPgEzaqu4I
 FMkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707137866; x=1707742666;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4WVtlpee/s+afrtGz/gbgUlpRyHzxaEAIdxd7N+ZjyA=;
 b=qEKO2pTTx73m/wCOR4aJYY4k10NdHfku66JeyYNn4XBVoZBKQlUgay+eq0p20kXQ4F
 4rqbqznK2HP4MAhvb0py+X/FpXoX80xPO2i1mzDsiNVkt3FgxNU3+0xXb5WPdFBxfZaJ
 mLe6HU3EHiKn52SpPrIuzP4+aoNglPblcjkmNpYGSEpkQxhl3z/EziQ76XFknfTST+o2
 6PuiOMKcF/irFYggux40J7IW8bfuoy2uBZhOiRDS1nA6ZnMaO7Us/KI/PVOLgSHj/eJA
 fD7Nk+Fzgx1jP6lQIxr4r/b4w+xYhSNJx8CkqjlKThnSSt86MDvl+zHXmbWyDZ8EX5+6
 H9ew==
X-Gm-Message-State: AOJu0Yz8sXhtwqv08CTszCdoz8vkhbPPaK+OBGV4Kj2dW8/LZZJxJHuy
 yoTOjV0JsmA/NZgXod4NiGu6m2xE5KgZN47ZFdpZ9XLl06HRHmJWBNSUhhVKqlpfuMPfbPBxH6K
 E
X-Google-Smtp-Source: AGHT+IE90nzQ/yvBJJdnfze5oZadky1Buq+I+YhwKgOntVRjHLHJ96UoAd3b/bd33gJOYAR+y1rVFQ==
X-Received: by 2002:a05:600c:19cb:b0:40e:cca6:d82f with SMTP id
 u11-20020a05600c19cb00b0040ecca6d82fmr4184688wmq.16.1707137866036; 
 Mon, 05 Feb 2024 04:57:46 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCU7DLWZDkQRcEArcje8GcJf6TAfCJ43R2lvA/0IC6/Ol4dH1KiDpEJTyUftRzUR43zitko4drYcNl1vgKllusnPtMwVSSjGboeOgPRtVbOTDyXrq/A4Cr6ehk3rJoQvFOM5BayjPQsyPzhsaPOqXbnao5Kbv5F8KnbYtQLnCQD6zwK/IzDj5KINHSKmYptqQNnoEHLyLHQ=
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 dn23-20020a05600c655700b0040ef718cf81sm8458269wmb.28.2024.02.05.04.57.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Feb 2024 04:57:45 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 5C8DC5F888;
 Mon,  5 Feb 2024 12:57:45 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Albert Esteve <aesteve@redhat.com>
Cc: qemu-devel@nongnu.org,  stefanha@gmail.com,  "Michael S. Tsirkin"
 <mst@redhat.com>,  marcandre.lureau@gmail.com,  kraxel@redhat.com,  Stefan
 Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH v3 1/3] hw/virtio: check owner for removing objects
In-Reply-To: <20240109125614.220293-2-aesteve@redhat.com> (Albert Esteve's
 message of "Tue, 9 Jan 2024 13:56:12 +0100")
References: <20240109125614.220293-1-aesteve@redhat.com>
 <20240109125614.220293-2-aesteve@redhat.com>
User-Agent: mu4e 1.11.27; emacs 29.1
Date: Mon, 05 Feb 2024 12:57:45 +0000
Message-ID: <87a5off4qe.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Albert Esteve <aesteve@redhat.com> writes:

> Shared objects lack spoofing protection.
> For VHOST_USER_BACKEND_SHARED_OBJECT_REMOVE messages
> received by the vhost-user interface, any backend was
> allowed to remove entries from the shared table just
> by knowing the UUID. Only the owner of the entry
> shall be allowed to removed their resources
> from the table.

Was this buggy behaviour on the part of the vhost-user daemon?

> To fix that, add a check for all
> *SHARED_OBJECT_REMOVE messages received.
> A vhost device can only remove TYPE_VHOST_DEV
> entries that are owned by them, otherwise skip
> the removal, and inform the device that the entry
> has not been removed in the answer.
>
> Signed-off-by: Albert Esteve <aesteve@redhat.com>
> Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  docs/interop/vhost-user.rst |  4 +++-
>  hw/virtio/vhost-user.c      | 21 +++++++++++++++++++--
>  2 files changed, 22 insertions(+), 3 deletions(-)
>
> diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
> index 9f1103f85a..60ec2c9d48 100644
> --- a/docs/interop/vhost-user.rst
> +++ b/docs/interop/vhost-user.rst
> @@ -1839,7 +1839,9 @@ is sent by the front-end.
>    When the ``VHOST_USER_PROTOCOL_F_SHARED_OBJECT`` protocol
>    feature has been successfully negotiated, this message can be submitted
>    by the backend to remove themselves from to the virtio-dmabuf shared
> -  table API. The shared table will remove the back-end device associated=
 with
> +  table API. Only the back-end owning the entry (i.e., the one that firs=
t added
> +  it) will have permission to remove it. Otherwise, the message is ignor=
ed.
> +  The shared table will remove the back-end device associated with
>    the UUID. If ``VHOST_USER_PROTOCOL_F_REPLY_ACK`` is negotiated, and the
>    back-end sets the ``VHOST_USER_NEED_REPLY`` flag, the front-end must r=
espond
>    with zero when operation is successfully completed, or non-zero otherw=
ise.
> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> index f214df804b..1c3f2357be 100644
> --- a/hw/virtio/vhost-user.c
> +++ b/hw/virtio/vhost-user.c
> @@ -1611,11 +1611,27 @@ vhost_user_backend_handle_shared_object_add(struc=
t vhost_dev *dev,
>  }
>=20=20
>  static int
> -vhost_user_backend_handle_shared_object_remove(VhostUserShared *object)
> +vhost_user_backend_handle_shared_object_remove(struct vhost_dev *dev,
> +                                               VhostUserShared *object)
>  {
>      QemuUUID uuid;
>=20=20
>      memcpy(uuid.data, object->uuid, sizeof(object->uuid));
> +    switch (virtio_object_type(&uuid)) {
> +    case TYPE_VHOST_DEV:

It would be nice if we could add a kdoc annotation to SharedObjectType
describing what the various types mean.

> +    {
> +        struct vhost_dev *owner =3D virtio_lookup_vhost_device(&uuid);
> +        if (owner =3D=3D NULL || dev !=3D owner) {

I dev is always set dev !=3D owner should also cover the NULL case.
However will we see uuid's that aren't associated with anything?

> +            /* Not allowed to remove non-owned entries */
> +            return 0;
> +        }
> +        break;
> +    }
> +    default:
> +        /* Not allowed to remove non-owned entries */
> +        return 0;
> +    }
> +
>      return virtio_remove_resource(&uuid);
>  }
>=20=20
> @@ -1794,7 +1810,8 @@ static gboolean backend_read(QIOChannel *ioc, GIOCo=
ndition condition,
>          ret =3D vhost_user_backend_handle_shared_object_add(dev, &payloa=
d.object);
>          break;
>      case VHOST_USER_BACKEND_SHARED_OBJECT_REMOVE:
> -        ret =3D vhost_user_backend_handle_shared_object_remove(&payload.=
object);
> +        ret =3D vhost_user_backend_handle_shared_object_remove(dev,
> +                                                             &payload.ob=
ject);
>          break;
>      case VHOST_USER_BACKEND_SHARED_OBJECT_LOOKUP:
>          ret =3D vhost_user_backend_handle_shared_object_lookup(dev->opaq=
ue, ioc,

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

