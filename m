Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39071C3600B
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Mar 2025 14:53:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twjAV-0001f1-Ti; Mon, 24 Mar 2025 10:52:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leiyang@redhat.com>)
 id 1twjAL-0001cc-NP
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 10:52:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leiyang@redhat.com>)
 id 1twjAI-0003pI-8W
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 10:52:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742827952;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=scHuMrrammwDrpr0UNVUNgia4poQ1e2qN9kG/HKONdk=;
 b=QhVlE+ueL2paxqM0PH8nVK3Xyxs4PtV4sKicReFC/i/Cd82+XbrAYvVPYQQXxkUH4I2OhB
 0bZUKhOX5bO6wmmez1LpoibxIQD/fHWc2UHRrdKxGpMh8Tpd45OwihQ7HAld2OGK7NiwaH
 mF/mvOK6LrBd/u1E5PGbcwGCwDY9Pqw=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-9-e63j7S7TOqSEUjMR4F3Imw-1; Mon, 24 Mar 2025 10:52:30 -0400
X-MC-Unique: e63j7S7TOqSEUjMR4F3Imw-1
X-Mimecast-MFC-AGG-ID: e63j7S7TOqSEUjMR4F3Imw_1742827949
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-5e5bde483cdso3531655a12.1
 for <qemu-devel@nongnu.org>; Mon, 24 Mar 2025 07:52:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742827948; x=1743432748;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=scHuMrrammwDrpr0UNVUNgia4poQ1e2qN9kG/HKONdk=;
 b=lhwwDJwI9XPqQZqtYMw/VhS5NedQP9A1gWyMWXqPNUQks7std8WlOQkLjJ0P/6/bea
 iu5ohZcKusRJsdqy4fdbGkCSM6sqlcfqXd0Q0djGTSSeSX3vCblsrpJYl81cOjNHfnvs
 8iq59s7E+8hIaS7SYZD2j7fcApTRZLbRAMJC6b9mU0wuTAx0CdF8K7fsXK2ahj2XRfYI
 5cK0tTpCXkHzKx9vuUHt7/se8moPhKlR02R80fh572vnCbtwS5GxqEYrPtIPxdwSFSLB
 AVebCbQTJtwl00EDinh/a17xRhBYNWmrzmaMsfK1Tx4qfcsYjW0xPtSMfcswe2fmmRFH
 X2IQ==
X-Gm-Message-State: AOJu0YyX/EobiAqopq1FYOJfQYHAsSkPO9KFI5dCGQcmP5JD/q6yglXg
 puZL1xoup6V0jo266LM76Cvn5toQ9edm/+2ncOgM8bNJYbKgw9AIZvwpU4aJ0yLxV8memq3jU9t
 FwF7sfZA5/534bCdyRILSRgM0PAZuBmynYknqSBrK7rssThNIu9Hlb1RV1JF1z7FYAh0xatvzav
 /bM/6ojTometJ18Gb2ZUsxWCXzuQtBlq6g1PoY6S5y
X-Gm-Gg: ASbGncvdFXafrbF8sefyQfeNvJ8nMr+boL2zvluG9ZeDNAOVItDsruAFZv7YK2qR0Ed
 H8YJmfKwHh7pecUfCrrdfFjW2IgBg/gjOqFiFZCB196snbQDVfkQ7U1eXBODDsMrMd8Ntimb63A
 ==
X-Received: by 2002:a05:6402:1e91:b0:5e6:17d7:9a32 with SMTP id
 4fb4d7f45d1cf-5ebcd46a367mr11412230a12.18.1742827948327; 
 Mon, 24 Mar 2025 07:52:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG70bX1bes7Ji3VQKaZeRXUEDmQqULVr+OiECMZMV0WcFmbiHc30LsijRlBj5joAyGO7CtyoeVw2wZ03UVWEJE=
X-Received: by 2002:a05:6402:1e91:b0:5e6:17d7:9a32 with SMTP id
 4fb4d7f45d1cf-5ebcd46a367mr11412200a12.18.1742827947829; Mon, 24 Mar 2025
 07:52:27 -0700 (PDT)
MIME-Version: 1.0
References: <20250322-vq-v2-1-cee0aafe6404@daynix.com>
In-Reply-To: <20250322-vq-v2-1-cee0aafe6404@daynix.com>
From: Lei Yang <leiyang@redhat.com>
Date: Mon, 24 Mar 2025 22:51:49 +0800
X-Gm-Features: AQ5f1JrL8FglIYPH8yiNaYmOCSRN-VbbqSFhBe5lorZTkVj2P5ICSHdGKmzO2Ds
Message-ID: <CAPpAL=w6taU7WLBEAOx6ocQzQJ5HZCHd_hg5Ra-pbp3s1SbsJg@mail.gmail.com>
Subject: Re: [PATCH v2] virtio-net: Fix the interpretation of max_tx_vq
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, 
 Yuri Benditovich <yuri.benditovich@daynix.com>, devel@daynix.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=leiyang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

QE tested this patch with virtio-net regression tests, everything works fin=
e.

Tested-by: Lei Yang <leiyang@redhat.com>

On Sat, Mar 22, 2025 at 2:48=E2=80=AFPM Akihiko Odaki <akihiko.odaki@daynix=
.com> wrote:
>
> virtio-net uses the max_tx_vq field of struct virtio_net_rss_config to
> determine the number of queue pairs and emits an error message saying
> "Can't get queue_pairs". However, the field tells only about tx.
>
> Examine unclassified_queue and indirection_table to determine the number
> of queues required for rx, and correct the name of field in the error
> message, clarifying its correct semantics.
>
> Fixes: 590790297c0d ("virtio-net: implement RSS configuration command")
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
> Changes in v2:
> - Handled unclassified_queue too.
> - Added a Fixes: tag.
> - Link to v1: https://lore.kernel.org/qemu-devel/20250321-vq-v1-1-6d6d285=
e5cbc@daynix.com
> ---
>  hw/net/virtio-net.c | 26 ++++++++++++++++----------
>  1 file changed, 16 insertions(+), 10 deletions(-)
>
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index de87cfadffe1..afc6b82f13c9 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -1450,23 +1450,29 @@ static uint16_t virtio_net_handle_rss(VirtIONet *=
n,
>          err_value =3D (uint32_t)s;
>          goto error;
>      }
> -    for (i =3D 0; i < n->rss_data.indirections_len; ++i) {
> -        uint16_t val =3D n->rss_data.indirections_table[i];
> -        n->rss_data.indirections_table[i] =3D virtio_lduw_p(vdev, &val);
> -    }
>      offset +=3D size_get;
>      size_get =3D sizeof(temp);
>      s =3D iov_to_buf(iov, iov_cnt, offset, &temp, size_get);
>      if (s !=3D size_get) {
> -        err_msg =3D "Can't get queue_pairs";
> +        err_msg =3D "Can't get max_tx_vq";
>          err_value =3D (uint32_t)s;
>          goto error;
>      }
> -    queue_pairs =3D do_rss ? virtio_lduw_p(vdev, &temp.us) : n->curr_que=
ue_pairs;
> -    if (queue_pairs =3D=3D 0 || queue_pairs > n->max_queue_pairs) {
> -        err_msg =3D "Invalid number of queue_pairs";
> -        err_value =3D queue_pairs;
> -        goto error;
> +    if (do_rss) {
> +        queue_pairs =3D MAX(virtio_lduw_p(vdev, &temp.us),
> +                          n->rss_data.default_queue);
> +        for (i =3D 0; i < n->rss_data.indirections_len; ++i) {
> +            uint16_t val =3D n->rss_data.indirections_table[i];
> +            n->rss_data.indirections_table[i] =3D virtio_lduw_p(vdev, &v=
al);
> +            queue_pairs =3D MAX(queue_pairs, n->rss_data.indirections_ta=
ble[i]);
> +        }
> +        if (queue_pairs =3D=3D 0 || queue_pairs > n->max_queue_pairs) {
> +            err_msg =3D "Invalid number of queue_pairs";
> +            err_value =3D queue_pairs;
> +            goto error;
> +        }
> +    } else {
> +        queue_pairs =3D n->curr_queue_pairs;
>      }
>      if (temp.b > VIRTIO_NET_RSS_MAX_KEY_SIZE) {
>          err_msg =3D "Invalid key size";
>
> ---
> base-commit: 825b96dbcee23d134b691fc75618b59c5f53da32
> change-id: 20250321-vq-87aff4f531bf
>
> Best regards,
> --
> Akihiko Odaki <akihiko.odaki@daynix.com>
>
>


