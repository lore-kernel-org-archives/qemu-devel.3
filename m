Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74430606A31E
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Nov 2026 08:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JD9v4C2l;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=pxpYGOPb
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xW8mc-00073o-GE; Wed, 25 Nov 2026 03:55:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1xW8mX-0006yU-4n
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 03:55:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1xW8mU-0001Fz-Ib
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 03:55:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795596908;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6ITolgLBIIctZ2NUq9yaPK+CyhctzGZfL9fEOIAiUuc=;
 b=JD9v4C2lmToxYTY/ugVsZzVMqmPr8ophVHUZUCMd+M7VyTU3r5jtXJ+JjxxUTpzdCcXaiA
 QWbVWg9s91665hvxJ0MWTWDEhyb9gZpt3KTe5e0dylxuvun9f1+TQSdAgSVTDRxs9dj27o
 OIq4oTSsx5il0OxNl0a4v1iuIhtHDrM=
Received: from mail-yx1-f70.google.com (mail-yx1-f70.google.com
 [74.125.224.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-581-hx9ubpxGMPKxsdAz8_YSdg-1; Wed, 25 Nov 2026 08:55:05 +0000
X-MC-Unique: hx9ubpxGMPKxsdAz8_YSdg-1
X-Mimecast-MFC-AGG-ID: hx9ubpxGMPKxsdAz8_YSdg_1795596905
Received: by mail-yx1-f70.google.com with SMTP id
 956f58d0204a3-67dabc6d5dfso9283267d50.2
 for <qemu-devel@nongnu.org>; Wed, 25 Nov 2026 00:55:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795596905; cv=none;
 d=google.com; s=arc-20260327;
 b=Op4Bcq18A/dt9uVlqIZjLzhNtp8UVl6VY+JczSZ8Dr+NF5q4g99bFpQFDhUkLEWpLz
 arQy9XPWyE3jDBvdi3XFmglzBJC45j24ug8yRQ94dp6mY9PTU/UI6LzAGhvrxb18+lDy
 m1sKUs9Gh8SAfU5l/vM8AEqnFKEG/wTqme/yMX3LtId14aJPF0KUvaXCls3jh2TI5dR7
 JNrrwMKW+VKZ+wbm3sbfD1lwON48DPRqlC8LmPSubTg+MovE4cN/WLhicJuSwGM8dLOd
 mjx5aw+LkNVx5C24yxIO/19hb6wICeoTTxdT1nV8ju+qfWSJZK1cN5wzx4G8DVL881bv
 XcSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=6ITolgLBIIctZ2NUq9yaPK+CyhctzGZfL9fEOIAiUuc=;
 fh=nH/VYr8r0mQPv8SgDse/WOGa/A0aWr4jlzczH4UxhOI=;
 b=gcOLUM9vXgkyFRu0v2xP/sghaZSlZ5oo8u/8VUd5zQlXzA6BRzNoMbGtP8ijqJat8u
 3GSG626qkOunBTq3d1aymKUKMFacvEtWXTQddMUBZr0195KUmfrjCvFAPj2XZv7AfwXR
 EXgL6511rctAlgXuykXwJNW8RO8tO/EICtnkUxEBSwkfz/PY3ghJAVfciHEG0u6k0t72
 /IY7YTgqF33sMeDyT1ViEEvogvF95GI4W/l1UAkulwYoN4b5m+FoW2GSlIixAscCbJLp
 Sr31GSsbVas4LzTo+MYDzLCLCe25anxLUD1q+bzSGqsv3SkmEljjnWcDZ+RFAPP+s77B
 bWrg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1795596905; x=1796201705; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=6ITolgLBIIctZ2NUq9yaPK+CyhctzGZfL9fEOIAiUuc=;
 b=pxpYGOPbvP/ixWZC/vjTz7o2tqlnldujkLIYjUzMxb41oS+ds2fezgwppPkCswgJSi
 NZ40ne4AzUgQ7OSaAmRcqfqP/+Cppe8pFyQu2c5u3ZPuYwzAFSiR5D/GloqGScnkiqkw
 Mv0B7Ry/bxvWLy1D8sozPQ5+bEI2w4v/9Mh4FEnzHfhsM/xG7KEJKds4lf9vdJMZ0rL5
 RUyXH5rrNEjbo39Y4NAOevYOaZ1l/e21Cj5Z+Q+nVeHjB2C/w1szqmxCIJskIk5iFJLl
 YyXCWnejMs/m9egK5dNQt1mLznETJJ6XUgXeVmx9S3o+pQurUyDFyefLbbK06IHuHaX6
 M2YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795596905; x=1796201705;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6ITolgLBIIctZ2NUq9yaPK+CyhctzGZfL9fEOIAiUuc=;
 b=halJQDtWDjrFcg7iB8JTVbjC3EiXNeLkwPnAIwfaf2iBreblWVWZllbjni8nJeWA3+
 g0knaeobkW9qEC+sZP3mAlfyXX5gy840ykmkgTQowI+6A5DgTiz9jNz7giAsVZ5XZrBo
 6ubyGIHr9fDrnSXpFPEnP+C7iNY2/718csJmOFJuN8zMZn5Kdkb5TDrjWlZ5sTMzxKEN
 A5Y/wq8y8s125LMP0USouGX29c4cAeCAd3t0NlEqLNvrMnEq1Gx9oXyAEHRArlapHdze
 GPFSrcoHH/bexRFXZXPIQJBKYn82MIhHXLsLS4LXIHpvAgHkDUmTEkO3ZDvZFhzpa2OO
 pEPQ==
X-Gm-Message-State: APuU4Z9kyS+T8M6yEv6O4JqvaFj7ao+3/VrXZBg9+N6ZwNvzqLdhtUQ4
 DmcAFkUw5Zz78gWtB3LhOzn7g6UweKcbC/Zzy8V/pLAljFeFythk4vDkUhMAMMQAeFYj7hWYRdj
 Xb5DSXionCReGU/3JJlJQjUr0r2vS9pH1vieekVW7RC63eYxDXflxGzBQjbN+UcINqROAUHaSrZ
 5+SDz31Bypg6g8r3OidY9ZAqTFAJwYhs8=
X-Gm-Gg: AZFdTZf6mMyKsjIb7X8N8nO+UrWSxN689oL6NwULlzRXvpoCBT7rfR57eLAt+31ZcZ2
 +XhuxRwwhKEDHhfAWGpRe7eU9KYBAb3UEIqDYIP0qq1/gzxRgzbx3Tmc2LwzrOkw94RBVGCtjU/
 JyLEjP+SSkCPGq+BXmKQfWlear4Ikeuorq8Vo6vqWZfzQy4SewMBcn9VWj5F9qgZxEHSlyYKQR+
 DDDbV3kdM4HrpQ6iz9HISCNMJSfuqioOmkaYzKbt4A6qW35ypzLTa7taGI=
X-Received: by 2002:a05:690e:1c1b:b0:67d:b425:fb83 with SMTP id
 956f58d0204a3-67df43ce37dmr7534334d50.33.1795596905128; 
 Wed, 25 Nov 2026 00:55:05 -0800 (PST)
X-Received: by 2002:a05:690e:1c1b:b0:67d:b425:fb83 with SMTP id
 956f58d0204a3-67df43ce37dmr7534325d50.33.1795596904682; Wed, 25 Nov 2026
 00:55:04 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261123231319.377104-1-connorkite@gmail.com>
In-Reply-To: <20261123231319.377104-1-connorkite@gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 25 Nov 2026 09:54:27 +0100
X-Gm-Features: Aa3M54qzpmY5m1WVpk3Fob42KmNGkhoGfG_FBkjURk-Mjn5eTMPHj5ruBaXDya8
Message-ID: <CAJaqyWcZEy40P3MXH74r66o7xgg+4WDNN9Os9y4HX67i49UcXg@mail.gmail.com>
Subject: Re: [PATCH] hw/virtio/vhost-shadow-virtqueue: clear ndescs after use
To: Connor Kite <connorkite@gmail.com>
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 24, 2026 at 12:13=E2=80=AFAM Connor Kite <connorkite@gmail.com>=
 wrote:
>
> When a shadow virtqueue detaches the buffer associated with a used elemen=
t,
> it adds the descriptor chain to the head of the free-elements list. Howev=
er,
> this currently happens after svq->desc_state[last_used].ndescs is set to =
0
> in vhost_svq_get_buf, introducing a bug.  Only the first element in the u=
sed
> descriptor chain is added back into the free-elements list, with subseque=
nt
> elements being potentially orphaned.
>
> Zero out ndescs only after the buffer is detached.
>
> Signed-off-by: Connor Kite <connorkite@gmail.com>

Good catch! I need to expand the tests to check for chains, as net
dataplane does not use them often.

Reviewed-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

Thanks!

> ---
>  hw/virtio/vhost-shadow-virtqueue.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/hw/virtio/vhost-shadow-virtqueue.c b/hw/virtio/vhost-shadow-=
virtqueue.c
> index 462c86dc1e..1afd3edf87 100644
> --- a/hw/virtio/vhost-shadow-virtqueue.c
> +++ b/hw/virtio/vhost-shadow-virtqueue.c
> @@ -604,6 +604,7 @@ static VirtQueueElement *vhost_svq_get_buf(VhostShado=
wVirtqueue *svq,
>                                             uint32_t *len)
>  {
>      uint16_t last_used;
> +    VirtQueueElement *detached_buf;
>
>      if (!vhost_svq_more_used(svq)) {
>          return NULL;
> @@ -637,9 +638,10 @@ static VirtQueueElement *vhost_svq_get_buf(VhostShad=
owVirtqueue *svq,
>          return NULL;
>      }
>
> +    detached_buf =3D vhost_svq_detach_buf(svq, last_used);
>      svq->num_free +=3D svq->desc_state[last_used].ndescs;
>      svq->desc_state[last_used].ndescs =3D 0;
> -    return vhost_svq_detach_buf(svq, last_used);
> +    return detached_buf;
>  }
>
>  /**
> --
> 2.43.0
>


