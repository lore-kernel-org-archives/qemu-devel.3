Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 347ECC636F0
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2024 19:04:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjNxq-0004oq-56; Wed, 28 Aug 2024 15:04:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1sjNxn-0004gO-UJ
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 15:04:15 -0400
Received: from mail-oi1-x22f.google.com ([2607:f8b0:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1sjNxl-00056L-U1
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 15:04:15 -0400
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-3db51133978so1410284b6e.3
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2024 12:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724871852; x=1725476652; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YJx3bromeeT0ANlRcE2fK0l5Hfjpw4tXiJCHyiAGCNI=;
 b=AZeLZtA8tJSUkx/c+l5AjDzcbhNWS2tkcOO1VDCSXlFPQz+0vFFiOPUvyoIJIvKXQ8
 Uu5WQ3KXfODAPS1ucRFFBO2Efel48vipMVCahqX/PqUzGoFSb6qckBRv/Fi1yxSnLfyW
 2TdMY+jpqLEMycxHojEZLCYZn6eOj0aN9n36wI9WN2N6C8EfMIfFPL1wW5sse41foPcC
 +wc4r/JJMw5cuSsR3E0th2RVyJ+LTFIdF7C110A9waEV81MRGDjEcd34FPXgniIVHTvb
 dSjuhQtE9wBRaYVbDhp56xPsUI8R8rpycfhRiQLc9nE/edCyxFaFNr3tbuZ0RPtQbwMQ
 FMyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724871852; x=1725476652;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YJx3bromeeT0ANlRcE2fK0l5Hfjpw4tXiJCHyiAGCNI=;
 b=DEuAzcZAj3f3ceAPz4nLX5DtnMRzobRWkmUxcx8hf85ajI6TBJwTrbnowQgv55uyI4
 qlMkJnpqAgqsUN+Yq6oX5K3Ygry4xGq6WDldmHgYugjPb9/L6RjYMLj+ksHk8p2mr01L
 eMlJYTiJoXbyu0Akg1Z+HumNjukiXS6G3Lwi2UQlrRqhwJn5PSKTyjqBu4ccmo7VxqHx
 +xKE0HwpzUh27ic8FOaiemX8Bb+jwKCdOunh3XFsKJ4d8LEjqxKEtlbdB0pMZgBSWlGr
 7wF/1x+yOLvyN8MBXSuxOTXBcYAi5IcLKm5V1L20f6a89G1sx4wT4znDu00MxFABabdS
 Jedg==
X-Gm-Message-State: AOJu0YyPGgnvQzdZl2UYfA+NMVKdBO4ikmIZ0W9rrMYDsclFDH1bV0Gd
 Rk4EvYfuZLwce7XLTK3y7JCvRLC5L4SuhE0Tz7BK4JoLSkIhqjEIM6fvvKYhn8TvlbT/hcgmnmr
 tNavpUn5RWEIAMnCQqw75Z2sV1b4=
X-Google-Smtp-Source: AGHT+IEjBvYFntyR2/RuTk7kz9amBbb+OdUnLFTB/Cj2u5CHC2miLvJ07Bbg54r0FddGU/6wtsNg0kPVgbBCfc76siI=
X-Received: by 2002:a05:6808:14cf:b0:3d9:40c2:eb54 with SMTP id
 5614622812f47-3df05d91ffamr399161b6e.5.1724871851672; Wed, 28 Aug 2024
 12:04:11 -0700 (PDT)
MIME-Version: 1.0
References: <20240822150849.21759-1-dorjoychy111@gmail.com>
 <20240822150849.21759-6-dorjoychy111@gmail.com>
 <20240828122221-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240828122221-mutt-send-email-mst@kernel.org>
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Date: Thu, 29 Aug 2024 01:04:05 +0600
Message-ID: <CAFfO_h5URpD4qnC5Cqh9tG49ijzRGpWqezdPDeaSMAOHnzFF9g@mail.gmail.com>
Subject: Re: [PATCH v5 5/8] device/virtio-nsm: Support for Nitro Secure Module
 device
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, graf@amazon.com, agraf@csgraf.de, 
 stefanha@redhat.com, pbonzini@redhat.com, slp@redhat.com, 
 richard.henderson@linaro.org, eduardo@habkost.net, marcel.apfelbaum@gmail.com, 
 berrange@redhat.com, philmd@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::22f;
 envelope-from=dorjoychy111@gmail.com; helo=mail-oi1-x22f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Thu, Aug 29, 2024 at 12:28=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com=
> wrote:
>
> On Thu, Aug 22, 2024 at 09:08:46PM +0600, Dorjoy Chowdhury wrote:
> > Nitro Secure Module (NSM)[1] device is used in AWS Nitro Enclaves[2]
> > for stripped down TPM functionality like cryptographic attestation.
> > The requests to and responses from NSM device are CBOR[3] encoded.
> >
> > This commit adds support for NSM device in QEMU. Although related to
> > AWS Nitro Enclaves, the virito-nsm device is independent and can be
> > used in other machine types as well. The libcbor[4] library has been
> > used for the CBOR encoding and decoding functionalities.
> >
> > [1] https://lists.oasis-open.org/archives/virtio-comment/202310/msg0038=
7.html
> > [2] https://docs.aws.amazon.com/enclaves/latest/user/nitro-enclave.html
> > [3] http://cbor.io/
> > [4] https://libcbor.readthedocs.io/en/latest/
> >
> > Signed-off-by: Dorjoy Chowdhury <dorjoychy111@gmail.com>
> > ---
> >  MAINTAINERS                      |   10 +
> >  hw/virtio/Kconfig                |    5 +
> >  hw/virtio/cbor-helpers.c         |  326 ++++++
> >  hw/virtio/meson.build            |    6 +
> >  hw/virtio/virtio-nsm-pci.c       |   73 ++
> >  hw/virtio/virtio-nsm.c           | 1638 ++++++++++++++++++++++++++++++
> >  include/hw/virtio/cbor-helpers.h |   46 +
> >  include/hw/virtio/virtio-nsm.h   |   59 ++
> >  meson.build                      |    2 +
> >  9 files changed, 2165 insertions(+)

[...]

> > +static void handle_input(VirtIODevice *vdev, VirtQueue *vq)
> > +{
> > +    g_autofree VirtQueueElement *out_elem =3D NULL;
> > +    g_autofree VirtQueueElement *in_elem =3D NULL;
> > +    VirtIONSM *vnsm =3D VIRTIO_NSM(vdev);
> > +    Error *err =3D NULL;
> > +
> > +    out_elem =3D virtqueue_pop(vq, sizeof(VirtQueueElement));
> > +    if (!out_elem) {
> > +        /* nothing in virtqueue */
> > +        return;
> > +    }
> > +
> > +    if (out_elem->out_num !=3D 1) {
> > +        virtio_error(vdev, "Expected one request buffer first in virtq=
ueue");
> > +        goto cleanup;
> > +    }
>
> Seems to assume request in a single s/g element?
> We generally avoid this kind of thing.
>
> Applies equally elsewheree.
>

Thank you for reviewing. I think I did it this way (first virqueue_pop
gives out_elem with out_num =3D=3D 1 and the next virtqueue_pop gives
in_elem with in_num =3D=3D 1) after seeing what the virqueue contains
(using printfs) when running in a VM and sending some NSM requests and
I noticed the above. Can you give me a bit more details about what
this should be like? Is there any existing virtio device code I can
look at for example?
Thanks!

> > +
> > +    in_elem =3D virtqueue_pop(vq, sizeof(VirtQueueElement));
> > +    if (!in_elem) {
> > +        virtio_error(vdev, "Expected response buffer after request buf=
fer "
> > +                     "in virtqueue");
> > +        goto cleanup;
> > +    }
> > +    if (in_elem->in_num !=3D 1) {
> > +        virtio_error(vdev, "Expected one response buffer after request=
 buffer "
> > +                     "in virtqueue");
> > +        goto cleanup;
> > +    }
> > +
> > +    if (!get_nsm_request_response(vnsm, out_elem->out_sg, in_elem->in_=
sg,
> > +                                  &err)) {
> > +        error_report_err(err);
> > +        virtio_error(vdev, "Failed to get NSM request response");
> > +        goto cleanup;
> > +    }
> > +
> > +    virtqueue_push(vq, out_elem, 0);
> > +    virtqueue_push(vq, in_elem, in_elem->in_sg->iov_len);
> > +    virtio_notify(vdev, vq);
> > +    return;
> > +
> > + cleanup:
> > +    if (out_elem) {
> > +        virtqueue_detach_element(vq, out_elem, 0);
> > +    }
> > +    if (in_elem) {
> > +        virtqueue_detach_element(vq, in_elem, 0);
> > +    }
> > +    return;
> > +}
> > +
> > +static uint64_t get_features(VirtIODevice *vdev, uint64_t f, Error **e=
rrp)
> > +{
> > +    return f;
> > +}
> > +

[...]

Regards,
Dorjoy

