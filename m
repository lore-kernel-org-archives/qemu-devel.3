Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E320FCCD1BB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 13:52:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBZFI-0005Hy-7r; Wed, 22 Oct 2025 09:51:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1vBZFF-0005Hg-MN
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 09:51:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1vBZFC-0000VH-OJ
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 09:51:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761141072;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sCOE43jrAQGF0ApN3jsdlQ0HIe5rpMy4t+KFZLsBjGE=;
 b=Y9nLxEZwU0Oib36xN46b1Xst9+ie6YqPvP1QiM3xSJwzj2KbK8ol2wZmrfukGypEji/sAh
 H7ZGz7XQ8rrw8jsrdQvH7LPAcqdR9SFBWRqgKnWToS95LHAa77FXxHRA0s0h35I88eakEl
 qR+jCQkZRCIfCnBAb689eCjQa+ev4yA=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-43-iEAlRYkPOkuH2JGK7e393g-1; Wed, 22 Oct 2025 09:50:02 -0400
X-MC-Unique: iEAlRYkPOkuH2JGK7e393g-1
X-Mimecast-MFC-AGG-ID: iEAlRYkPOkuH2JGK7e393g_1761141002
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-783bceedeb8so57052567b3.3
 for <qemu-devel@nongnu.org>; Wed, 22 Oct 2025 06:50:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761141002; x=1761745802;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sCOE43jrAQGF0ApN3jsdlQ0HIe5rpMy4t+KFZLsBjGE=;
 b=DjYVc458ht7Ihg8EhHu+WdreT1v8P5IgCgcFelyo61CXbEDdv9WUnk/Xe0Pwueym8+
 2oXMwRu0FYWtancncM5/AO8jov1H59TLmGwFR8hNk7U51J8R1y1hNBT74bgsxBD35tIy
 Nq50hDVxtaO7xJ3vsIG4PydJsRNiCVq5tdadEH7pL1uWizD0Jf1R8OFTj9+QQAOi/VUd
 H8cEAgHa6fR1SyL2QvfQn0xhGSzPmAetFoaVulnwa5Jv4yTzQ31c9MCp5CbcCBZsTDRD
 Fv1oO9EGvYtOlgK+kGiw7cO/HCitdu8xQ67o5zojIHqvh9IUZehuuXd3UXDq7sqisI/S
 2Ivg==
X-Gm-Message-State: AOJu0YzMkG6gTe7LLdi55ciER68s6SCqKD2VvA4AXPvEzmYOS7r71FRm
 GUgOIE7ou46fsw6lSeoCe6t7DRV13DMJ/ng4M/I4LqVtp7334L+wsxMqur9GM272xf69993YV3I
 uMq6cKdEgZ/rMhWncJ8iCiu3GGT7jyElqjijRIFUkh42qdpdlHW4zibfTkq+Az3axcNe3wfWpvz
 Ego+BFG8LZz+CuJ5QF+kNt5VQNjp65b8A=
X-Gm-Gg: ASbGncsKLwCx6G/LVI+HcvUZTtzZSTaO43mzsuBsvgyljCLXydLA86gQv3RooTVyiUV
 cB/4JND1wFfhnD76grNvahy+RMe57bOZEE5NdUByja0YF9+JK4jdohimdDszKGy/fmp8AhhOwij
 7cpHIW5VPlxCRL0WURmi/nkPcB0MOyiegGu5p+fGcnpvm8juTYDXzxQKG2YRzqrQjGhE3mg0SUS
 a9sJWP84i0dfeueSW1f+kQ8mk/mOc31Q45yLSvd0fY=
X-Received: by 2002:a05:690e:1c07:b0:63e:1e21:7aef with SMTP id
 956f58d0204a3-63e1e217b9fmr14725943d50.55.1761141002204; 
 Wed, 22 Oct 2025 06:50:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH/vmIOdjVEMptyHCS2ijtrfdlVkowtldqK2asn9AtO/zDf26It4e/ct4x+yNjcu6uDD37KQFz3Cth0g6YZjgQ=
X-Received: by 2002:a05:690e:1c07:b0:63e:1e21:7aef with SMTP id
 956f58d0204a3-63e1e217b9fmr14725919d50.55.1761141001777; Wed, 22 Oct 2025
 06:50:01 -0700 (PDT)
MIME-Version: 1.0
References: <20251022133228.301365-1-gmaglione@redhat.com>
In-Reply-To: <20251022133228.301365-1-gmaglione@redhat.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 22 Oct 2025 15:49:25 +0200
X-Gm-Features: AS18NWB4pGaIpQTX8ZC9Wb-u3HZADz9PXD--5zA8DRKTfHCzTcjmkhBcBK9FYRA
Message-ID: <CAJaqyWccaCUfQLzQXdX+3+sQNz+-AjSvqmCignXR+URfz7FHww@mail.gmail.com>
Subject: Re: [PATCH] Make vhost_set_vring_file() synchronous
To: gmaglione@redhat.com
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Oct 22, 2025 at 3:32=E2=80=AFPM <gmaglione@redhat.com> wrote:
>
> From: German Maglione <gmaglione@redhat.com>
>
> QEMU sends all of VHOST_USER_SET_VRING_KICK, _CALL, and _ERR without
> setting the NEED_REPLY flag, i.e. by the time the respective
> vhost_user_set_vring_*() function returns, it is completely up to chance
> whether whether the back-end has already processed the request and
> switched over to the new FD for interrupts.
>
> At least for vhost_user_set_vring_call(), that is a problem: It is
> called through vhost_virtqueue_mask(), which is generally used in the
> VirtioDeviceClass.guest_notifier_mask() implementation, which is in turn
> called by virtio_pci_one_vector_unmask().  The fact that we do not wait
> for the back-end to install the FD leads to a race there:
>
> Masking interrupts is implemented by redirecting interrupts to an
> internal event FD that is not connected to the guest.  Unmasking then
> re-installs the guest-connected IRQ FD, then checks if there are pending
> interrupts left on the masked event FD, and if so, issues an interrupt
> to the guest.
>
> Because guest_notifier_mask() (through vhost_user_set_vring_call())
> doesn't wait for the back-end to switch over to the actual IRQ FD, it's
> possible we check for pending interrupts while the back-end is still
> using the masked event FD, and then we will lose interrupts that occur
> before the back-end finally does switch over.
>
> Fix this by setting NEED_REPLY on those VHOST_USER_SET_VRING_* messages,
> so when we get that reply, we know that the back-end is now using the
> new FD.
>

Fixes: 5f6f6664bf24 ("Add vhost-user as a vhost backend.") ?

> Signed-off-by: German Maglione <gmaglione@redhat.com>
> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
> ---
>  hw/virtio/vhost-user.c | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
>
> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> index 36c9c2e04d..641960293b 100644
> --- a/hw/virtio/vhost-user.c
> +++ b/hw/virtio/vhost-user.c
> @@ -1327,8 +1327,11 @@ static int vhost_set_vring_file(struct vhost_dev *=
dev,
>                                  VhostUserRequest request,
>                                  struct vhost_vring_file *file)
>  {
> +    int ret;
>      int fds[VHOST_USER_MAX_RAM_SLOTS];
>      size_t fd_num =3D 0;
> +    bool reply_supported =3D virtio_has_feature(dev->protocol_features,
> +                                              VHOST_USER_PROTOCOL_F_REPL=
Y_ACK);

Why not use vhost_user_write_sync directly?

>      VhostUserMsg msg =3D {
>          .hdr.request =3D request,
>          .hdr.flags =3D VHOST_USER_VERSION,
> @@ -1336,13 +1339,26 @@ static int vhost_set_vring_file(struct vhost_dev =
*dev,
>          .hdr.size =3D sizeof(msg.payload.u64),
>      };
>
> +    if (reply_supported) {
> +        msg.hdr.flags |=3D VHOST_USER_NEED_REPLY_MASK;
> +    }
> +
>      if (file->fd > 0) {
>          fds[fd_num++] =3D file->fd;
>      } else {
>          msg.payload.u64 |=3D VHOST_USER_VRING_NOFD_MASK;
>      }
>
> -    return vhost_user_write(dev, &msg, fds, fd_num);
> +    ret =3D vhost_user_write(dev, &msg, fds, fd_num);
> +    if (ret < 0) {
> +        return ret;
> +    }
> +
> +    if (reply_supported) {
> +        return process_message_reply(dev, &msg);
> +    }
> +
> +    return 0;
>  }
>
>  static int vhost_user_set_vring_kick(struct vhost_dev *dev,
> --
> 2.49.0
>


