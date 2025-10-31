Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3552DCCFA00
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 16:18:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vErnk-0000AF-5C; Fri, 31 Oct 2025 12:16:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1vErni-0000A4-Jg
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 12:16:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1vErnZ-0001Nr-3v
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 12:16:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761927367;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I0qGcI41MQGpc/ZDWlUg7suchTbxHTpifdeAUjNCiA0=;
 b=fvUBStUkQ+tV06wt1pyKas8ooJsuPihaAfhRffyXn0Ted7jTeVkGeM0tYIQQLsOTEie4cR
 o1ZJvIU8Zu/o44ZCemTjk2+RpmGEym8kjg41IiAiwxj3l8/0zthfKN94OvxcrIMZAPqZmG
 b3nEsKqfKYzBCPE+kHcEtT0qEiji4Ww=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-07aVd6myOYePZYHtHJeL4Q-1; Fri, 31 Oct 2025 12:16:05 -0400
X-MC-Unique: 07aVd6myOYePZYHtHJeL4Q-1
X-Mimecast-MFC-AGG-ID: 07aVd6myOYePZYHtHJeL4Q_1761927364
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-b62da7602a0so1926133a12.2
 for <qemu-devel@nongnu.org>; Fri, 31 Oct 2025 09:16:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761927364; x=1762532164;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I0qGcI41MQGpc/ZDWlUg7suchTbxHTpifdeAUjNCiA0=;
 b=SoGEVLZJg9tblS7UkhUVN5Qxe2yrSiivyiA0Avuf5CgNAugdkaF9dYOjslalxNLHMc
 nB1/fzT6J+geS2+sUSJMQIDADIGTTsBLeW99sTDnk2UH2gEW/G33oagN+z0MJLry7OXy
 7EAtefdPHD0g342XVB2v+StjzhTZNUeM29Q0O8xURwa/wWjZRgAL+Lv64SDIfcuKI3gP
 jmD2jKsxghAFxe7Isab6qAr81xE5Trs5hNYJr8M35eUGK4bzqJM0r2REhqwn295jCVqF
 M0iMV2+cEdtYMNwe2YOMbGF9HMrqVNbfa+pSbQEhK7YEOSmAVpnsly3eR9AQ4IvEDu9V
 lYWA==
X-Gm-Message-State: AOJu0YxaldL+/RQhu6jxIM58WNBfXXoC/ZgFTf3wZq+aKx9/hMkoZ55s
 kwlMR76bMK6MHJQ3bzllze4cYTGZiYI/EAXuSQbmO9weVJUf+IHOSirlxKNa36O2wrWROaBa0Z/
 o5mSc2m/4IOkGYmSmttiwFsp3GDNNYl7Y8J+HhjJWu/Ad3DH7w7DZtZ5lgaS8NLCgKSyrl+Dqbj
 u6eyGOA/z0kTNJSIZE6986d5MUwGm3e9qYse1gGc0=
X-Gm-Gg: ASbGncuZg5wSgmh8RAmkqUXrRco7kLncUqIutXZJ81vfoLGkcBbtUzOgveGE8NoaOBy
 x2TIJLctVNqlIUCAXBsg1onQiZtghaT37gKKE2Dc/PhdUSWMKwGNfx1ypF03Ap3H/5dvFNbk59c
 JLkYuhU5W1l/StbP7e9AQA9L4BVXqRcAxCO4+EiGy69aYx28xzGT8=
X-Received: by 2002:a17:902:e552:b0:294:f1fa:9097 with SMTP id
 d9443c01a7336-2951a55b71emr60726925ad.34.1761927363959; 
 Fri, 31 Oct 2025 09:16:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF6OuLSgvIAbYmDI+2gSAO5wqRaWXY5kC9RFWcmwj2brDLWTAnsLF0ldvaUGWvwSca4UqhOnNrhZ2Y3LELWjuo=
X-Received: by 2002:a17:902:e552:b0:294:f1fa:9097 with SMTP id
 d9443c01a7336-2951a55b71emr60726045ad.34.1761927363060; Fri, 31 Oct 2025
 09:16:03 -0700 (PDT)
MIME-Version: 1.0
References: <20251031155617.1223248-1-mvaralar@redhat.com>
In-Reply-To: <20251031155617.1223248-1-mvaralar@redhat.com>
From: Albert Esteve <aesteve@redhat.com>
Date: Fri, 31 Oct 2025 17:15:51 +0100
X-Gm-Features: AWmQ_bn5XMJBvTmjKBOsVRJlvKzBEq0z1d3JCxsiUv5ooeG0rAGaGc6vA06izSs
Message-ID: <CADSE00Kt673u5OngA+teDO3fKcc-uBOoFKyF==U0zv1JDqC4wA@mail.gmail.com>
Subject: Re: [RFC 1/2] linux-headers: add virtio_can.h
To: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 Vikram Garhwal <vikram.garhwal@bytedance.com>, Jason Wang <jasowang@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Francisco Iglesias <francisco.iglesias@amd.com>, 
 Cornelia Huck <cohuck@redhat.com>, Pavel Pisa <pisa@cmp.felk.cvut.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=aesteve@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Oct 31, 2025 at 5:00=E2=80=AFPM Matias Ezequiel Vara Larsen
<mvaralar@redhat.com> wrote:
>
> Signed-off-by: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
> ---
> Note that virtio_can.h is not merged yet and it is part of the series
> https://lore.kernel.org/all/aQJRnX7OpFRY%2F1+H@fedora/

Hi Matias,

As far as I know, standard-headers must be updated with
`./scripts/update-linux-headers.sh`, so unless exceptions can be it'll
have to wait until the kernel patch is merged for this to be accepted.


> ---
>  include/standard-headers/linux/virtio_can.h | 78 +++++++++++++++++++++
>  1 file changed, 78 insertions(+)
>  create mode 100644 include/standard-headers/linux/virtio_can.h
>
> diff --git a/include/standard-headers/linux/virtio_can.h b/include/standa=
rd-headers/linux/virtio_can.h
> new file mode 100644
> index 0000000000..6380ef7bce
> --- /dev/null
> +++ b/include/standard-headers/linux/virtio_can.h
> @@ -0,0 +1,78 @@
> +/* SPDX-License-Identifier: BSD-3-Clause */
> +/*
> + * Copyright (C) 2021-2023 OpenSynergy GmbH
> + * Copyright Red Hat, Inc. 2025
> + */
> +#ifndef _LINUX_VIRTIO_VIRTIO_CAN_H
> +#define _LINUX_VIRTIO_VIRTIO_CAN_H
> +
> +#include <standard-headers/linux/types.h>
> +#include <standard-headers/linux/virtio_types.h>
> +#include <standard-headers/linux/virtio_ids.h>
> +#include <standard-headers/linux/virtio_config.h>
> +
> +/* Feature bit numbers */
> +#define VIRTIO_CAN_F_CAN_CLASSIC        0
> +#define VIRTIO_CAN_F_CAN_FD             1
> +#define VIRTIO_CAN_F_RTR_FRAMES         2
> +#define VIRTIO_CAN_F_LATE_TX_ACK        3
> +
> +/* CAN Result Types */
> +#define VIRTIO_CAN_RESULT_OK            0
> +#define VIRTIO_CAN_RESULT_NOT_OK        1
> +
> +/* CAN flags to determine type of CAN Id */
> +#define VIRTIO_CAN_FLAGS_EXTENDED       0x8000
> +#define VIRTIO_CAN_FLAGS_FD             0x4000
> +#define VIRTIO_CAN_FLAGS_RTR            0x2000
> +
> +#define VIRTIO_CAN_MAX_DLEN    64 // this is like CANFD_MAX_DLEN
> +
> +struct virtio_can_config {
> +#define VIRTIO_CAN_S_CTRL_BUSOFF (1u << 0) /* Controller BusOff */
> +       /* CAN controller status */
> +       __le16 status;
> +};
> +
> +/* TX queue message types */
> +struct virtio_can_tx_out {
> +#define VIRTIO_CAN_TX                   0x0001
> +       __le16 msg_type;
> +       __le16 length; /* 0..8 CC, 0..64 CAN-FD, 0..2048 CAN-XL, 12 bits =
*/
> +       __u8 reserved_classic_dlc; /* If CAN classic length =3D 8 then DL=
C can be 8..15 */
> +       __u8 padding;
> +       __le16 reserved_xl_priority; /* May be needed for CAN XL priority=
 */
> +       __le32 flags;
> +       __le32 can_id;
> +       __u8 sdu[] __counted_by(length);
> +};
> +
> +struct virtio_can_tx_in {
> +       __u8 result;
> +};
> +
> +/* RX queue message types */
> +struct virtio_can_rx {
> +#define VIRTIO_CAN_RX                   0x0101
> +       __le16 msg_type;
> +       __le16 length; /* 0..8 CC, 0..64 CAN-FD, 0..2048 CAN-XL, 12 bits =
*/
> +       __u8 reserved_classic_dlc; /* If CAN classic length =3D 8 then DL=
C can be 8..15 */
> +       __u8 padding;
> +       __le16 reserved_xl_priority; /* May be needed for CAN XL priority=
 */
> +       __le32 flags;
> +       __le32 can_id;
> +       __u8 sdu[] __counted_by(length);
> +};
> +
> +/* Control queue message types */
> +struct virtio_can_control_out {
> +#define VIRTIO_CAN_SET_CTRL_MODE_START  0x0201
> +#define VIRTIO_CAN_SET_CTRL_MODE_STOP   0x0202
> +       __le16 msg_type;
> +};
> +
> +struct virtio_can_control_in {
> +       __u8 result;
> +};
> +
> +#endif /* #ifndef _LINUX_VIRTIO_VIRTIO_CAN_H */
> --
> 2.42.0
>
>


