Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF0BECCD193
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 05:29:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBntB-0005q7-66; Thu, 23 Oct 2025 01:29:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1vBnt5-0005nc-1T
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 01:29:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1vBnt1-0008NI-7o
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 01:29:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761197358;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fbmUiP24vmItDggaUgWvlUJsW1ZjEpUJ2OUsevgIUgY=;
 b=jQL07RY0wc7w8QqfPstJrp/b7HvQ3XnR6RlR64YF4S4KqPqujIix2iH3i4N3GPSI/eKzy0
 qOosepckfsY9mYfd4kn9NOn/L+lF7fy5zyRmcJNDIXat8b76219iVMFjoHAsG9yoH6j1F9
 kPPK8K/GYL+9GimfHX6RGMbCY3kHS0M=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-178-CUO-4Sb0PaicUBY1A8PjPQ-1; Thu, 23 Oct 2025 01:29:15 -0400
X-MC-Unique: CUO-4Sb0PaicUBY1A8PjPQ-1
X-Mimecast-MFC-AGG-ID: CUO-4Sb0PaicUBY1A8PjPQ_1761197355
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-785c67bec06so4577907b3.2
 for <qemu-devel@nongnu.org>; Wed, 22 Oct 2025 22:29:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761197355; x=1761802155;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fbmUiP24vmItDggaUgWvlUJsW1ZjEpUJ2OUsevgIUgY=;
 b=eUSFB3b3UW79HaZdmlmqsoWmkUh0O65YOURXZHzcRI9ZLlJBvaJBuBJL/oz94XFY1O
 iY7E/FUe0aoqZnZQ3tcsCs7FSDxDOFTwCrF4TFaNAihwKS6O1Bj1R7iRuiPvbQ8ReIGT
 FSrd+ONugRDIxyjI88sT6ni50abtBTZIEwH/FEEs6QpX7FVFQwNgUono1Oo8s0B3xMgK
 8ydWo5pkJkQlM5tM0GvsJPPfYngSlKnumFZgozGBPzFgY0pYjPUGd7HAueVmOK/kxhJZ
 XO/1tA0Mh7fVZo7UN5fou2YQh2JbGmKJisv2z4kIO1UgbnqoU/85nLeErmfOZXQcH+bc
 yxjA==
X-Gm-Message-State: AOJu0YzPlGz+w9U8M+Tc7BCgw1/t/5V5FfvWq/OZnAZI7AdAxf8sihrR
 C+GL1NhNnKa3Lp7O8HO27yWrzgUUrMJUVCYTburBDRSuXptp7+uWX+hK4n7cA+a6kATBYz6hQrm
 5uQnFeR6cMGc+6SNVoCZg/z568U5OfG5GTQbOfxzY3u+clUen/EDO8jdTD6z0/JKGN3TGAvSbC1
 sz+iDduKszX/TjxlOCd0K7GAvUcbDRRYA=
X-Gm-Gg: ASbGncuH4xlGf/xlCSK0FtwSpvzJEWiRMaPgMaA3wiSbkcaZHSVOUTNQ4yvnePvCvzf
 I7E5dOxjPpSYmenfM/RBQdcBR9bXLRfLcnDshe/eZY6qtuw+9zobKUS1wzQCAb6NsgncNuBLHdP
 mH6qY0MS6QtCqXgjAwfEdP2l9lJo5UcR5fCuva4P0mNkrW/4nhVAjF7B/YSqazPSP5tgZ4dUcvK
 7m4bQpXI+mfoeIXmCChZMCWOF6gVJORzFZ6/SVQerw=
X-Received: by 2002:a05:690e:1247:b0:63e:3ad2:ef0b with SMTP id
 956f58d0204a3-63e3ad2f3aamr9669334d50.27.1761197355323; 
 Wed, 22 Oct 2025 22:29:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGMNtQhgXOHw5JccfVN2dTPh+mFBbwneys20DcXXi2z4NE4jqtgqMlotZlFS9J9j5xCiN4EMdLYbomPje+4wqk=
X-Received: by 2002:a05:690e:1247:b0:63e:3ad2:ef0b with SMTP id
 956f58d0204a3-63e3ad2f3aamr9669316d50.27.1761197354934; Wed, 22 Oct 2025
 22:29:14 -0700 (PDT)
MIME-Version: 1.0
References: <20251022162405.318672-1-gmaglione@redhat.com>
In-Reply-To: <20251022162405.318672-1-gmaglione@redhat.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Thu, 23 Oct 2025 07:28:38 +0200
X-Gm-Features: AS18NWDvrcSA01l2mdO93F5TWwEHZFoRvdCVKRPZbJ2BP5JjZx0Q-6Nc655t5A4
Message-ID: <CAJaqyWf-VmK8w4d7Qn6ZHZRjVze0CatU01hNw5Db53RzE2G0-g@mail.gmail.com>
Subject: Re: [PATCH v2] vhost-user: make vhost_set_vring_file() synchronous
To: German Maglione <gmaglione@redhat.com>
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eperezma@redhat.com;
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

On Wed, Oct 22, 2025 at 6:24=E2=80=AFPM German Maglione <gmaglione@redhat.c=
om> wrote:
>
> QEMU sends all of VHOST_USER_SET_VRING_KICK, _CALL, and _ERR without
> setting the NEED_REPLY flag, i.e. by the time the respective
> vhost_user_set_vring_*() function returns, it is completely up to chance
> whether the back-end has already processed the request and switched over
> to the new FD for interrupts.
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
> We have a few reports of a virtiofs mount hanging:
> - https://gitlab.com/virtio-fs/virtiofsd/-/issues/101
> - https://gitlab.com/virtio-fs/virtiofsd/-/issues/133
> - https://gitlab.com/virtio-fs/virtiofsd/-/issues/213
>
> This is quite difficult bug to reproduce, even for the reporters.
> It only happens on production, every few weeks, and/or on 1 in 300 VMs.
> So, we are not 100% sure this fixes that issue. However, we think this
> is still a bug, and at least we have one report that claims this fixed
> the issue:
>
> https://gitlab.com/virtio-fs/virtiofsd/-/issues/133#note_2743209419
>

Reviewed-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

Thanks!

> Signed-off-by: German Maglione <gmaglione@redhat.com>
> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
> ---
>  hw/virtio/vhost-user.c | 24 +++++++++++++++++++++++-
>  1 file changed, 23 insertions(+), 1 deletion(-)
>
> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> index 36c9c2e04d..1605485396 100644
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
>      VhostUserMsg msg =3D {
>          .hdr.request =3D request,
>          .hdr.flags =3D VHOST_USER_VERSION,
> @@ -1336,13 +1339,32 @@ static int vhost_set_vring_file(struct vhost_dev =
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
> +        /*
> +         * wait for the back-end's confirmation that the new FD is activ=
e,
> +         * otherwise guest_notifier_mask() could check for pending inter=
rupts
> +         * while the back-end is still using the masked event FD, losing
> +         * interrupts that occur before the back-end installs the FD
> +         */
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


