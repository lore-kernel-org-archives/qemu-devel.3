Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07832606A326
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 08:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Jk0YfDsw;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=Y+KHKh4v
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOWQv-00017h-9O; Wed, 04 Nov 2026 03:33:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1xOWQt-000175-9J
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 03:33:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1xOWQr-0003Q9-NG
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 03:33:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793781197;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SPW6N3vAW/vLKb5XBNunPrcDBuAievxt6DytZnkXanE=;
 b=Jk0YfDswHKvSOFAhYXuC2GjxoHAt4SWSP96a5xCGArgclmE6Na4DlKf462f9mwvAS2t+JW
 ADYrIx2dTb8atQdNz651wWsmp1R0dlbsGZ0ccBRJ+0d4sQ4tJI4W6mOk5aUwreI3jErX0X
 My8ctjfc+o9HaA44nf2HjZE0GdtVrtI=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-2iyuSuGsNHeqeUYmPJL2Kg-1; Wed, 04 Nov 2026 03:33:09 -0500
X-MC-Unique: 2iyuSuGsNHeqeUYmPJL2Kg-1
X-Mimecast-MFC-AGG-ID: 2iyuSuGsNHeqeUYmPJL2Kg_1793781186
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-8b0d36c1db7so7514987b3.0
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2026 00:33:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793781186; cv=none;
 d=google.com; s=arc-20260327;
 b=CA8ZY99q0ow7m6xIB2UWLk6puDvYJTgtjY3wrHLptaQ7U2ZKPozXApYz7pOvbinhYk
 Kb+lOBydOSLrqIPL6UZxdlQtEGqZJ/PwsSd6BTU9fubEVejlNuIJkom4IJa5LKytIVVA
 CYAW1ii73y/ycZ142TH1awXoEVY9wkUt9S2tGNCmF6t0ruIVmSvVBiODJvY1qatt2SgZ
 PVXFSHVmsXKTEF1PXykFXoq5GZ0HoClp4dqqOFETIvZfSxuAHCcs1T94yeSKXLeLkiH/
 /aireiV/skScyZHlxB93GR2Hoopy6DeP0dDueGNx4p1CghW3qomB/T2xrF+J+o1PzAL7
 zsyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=SPW6N3vAW/vLKb5XBNunPrcDBuAievxt6DytZnkXanE=;
 fh=W1YHxymAPX9qGgB5iBWDAQUq7X4IPXzTWEHAvi7bkzk=;
 b=i0o18ifI4sIjRBZYRr6bX4e3Bv+IgwjRpFuCJHiUnNRZ1+pa9zYXH9wZ/7DKEYE9DQ
 +ozMrKKudrf4yQKFiT72LpR4dt7Fi8RMYBJRkSi8KMlp8S6Hwnu/tEDs65JHILTsEnUS
 /sFSjFgmyLtb65cQJSim9f3CSA7edGOVHwZHED9hox5Fx2KppcCPhYJ3mzycqW77rPRP
 CYO93CsvbKz02Ce4yt0nW5C0Iv2ApbsJpjgQlw+V73cbrUlTWQnP/QJ0lmgm+Xfrntv1
 dxNxmBICqzI4eux09vius4apPaOows/2J3wJB+by+wyx8YhTNztGs82RqLCseOiRHr6P
 YeIw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793781186; x=1794385986; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=SPW6N3vAW/vLKb5XBNunPrcDBuAievxt6DytZnkXanE=;
 b=Y+KHKh4vr21gZiFj9+LVH9JGRXzU9vKugjgYs6pNjVGOr1f5c2+1NA3axSbe74+7gQ
 gbPJlynF5ILwiDndHuOpfERNHK+oQE0ax4cPyZlaXSwoSWiDyqWmkpOidWbLaK9b+inR
 mRINHFNDMqA/l3Csl57OPqpRbKacEcms/UyjXMp6u+Fv9vWvCjgYcTR9/IaPIHMMUg7Q
 60gMfhnoP8aWESMLiPBN+XVTw2dwOwCgPXGCDReUGLtDXW66BxoRHPweOJgazrXu1y4g
 0rvCb/VBYVLEY6g2LoibOnsyDdermCsgDPUvtL+irYnhgqOqlvJBMWevThy/5sUovBrG
 FzVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793781186; x=1794385986;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=SPW6N3vAW/vLKb5XBNunPrcDBuAievxt6DytZnkXanE=;
 b=jOveBj2rboHipO8Y4Ih9jIDC4pehWAHADCRz+WETuY0LOuwAr8L96WmU9nfv0gV/WK
 AbBOK1Am9uHeEf8yNbznKBkv9FsMwl3abs6snercJbrHaRQxJb2gmZ3F9Xq3c08k4kfO
 0oqO05AUwq7Ay5FytkIHE/7tKMaXeDSUfXK6ZdQgjcNoctXaJ91+MexQUs7NQWXLNqjG
 ulw3ttHt1PpCBeg1O0PaCe4AQHmEL9SOqamJbG5hfgGWQJDlD/YSM6angwTLByQcc8+s
 vg9BNcsXXmGI7zaA5eawecAxtpfr95syiG+sm+OP7SJzDIWDTDS1XgzP/+iOQeAJf8+5
 Zg+Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBx9O3ZlWmwxtlUQgNRuk9Ixkn7IOv0Tj8Yl1cnNG7ZOz/tP+4ALPZK5J9zDDmUUxHiZl1UiO4Qv5M4n@nongnu.org
X-Gm-Message-State: APuU4Z/XX7o8EcaYRXS+puE4dBfqiHe9i5svZe97gLLIYbYI24CvoDcq
 IBqYHM+6LZBl0TAxOrVl0YH5cRwrxzb/8OGhkBCxQE7iJ5Rk/e6loDjH5CJbohVKAjGFSJFKHw2
 Djr/uw6Sdb9kBTdHJ65UomW/48i/va9AyP985myGHX/hnFmMIvtbTuwFgadlnaV3+Ga5E4x9o8N
 8+eXCrZTiNX/QWHDFEE0ZDqH8sA3IUH1s=
X-Gm-Gg: AYBFou1XLkVJRM6LTSa/EvggE9aD/JfWZ++DHZKcE6DtGR9JwVrVAwQsFERjXzcetpy
 voAslYS2qG5kdt7OAoE/YC4vNYu2j5JAah3eHm8GZc0Yb+oQDWLokh+4i9tZ1PAjXJFh0zQoaHP
 mdgeCMm+lwKT1R8jjtV9wteJSTdenoqVlqXZWukV6Wmaur9qwBIyseXopGJc957HhzoVrAneyO1
 V7ZShvWsI8R/CE6L9vVX7bOW5uhCWqbL3Bdta5ju0KuwvFaCsND/Wmol94=
X-Received: by 2002:a05:690c:660c:b0:8b1:7054:a5b6 with SMTP id
 00721157ae682-8b2b6738e27mr132829927b3.27.1793781185626; 
 Wed, 04 Nov 2026 00:33:05 -0800 (PST)
X-Received: by 2002:a05:690c:660c:b0:8b1:7054:a5b6 with SMTP id
 00721157ae682-8b2b6738e27mr132829757b3.27.1793781185068; Wed, 04 Nov 2026
 00:33:05 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261104020053.2548-1-lirongqing@baidu.com>
In-Reply-To: <20261104020053.2548-1-lirongqing@baidu.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 4 Nov 2026 09:32:28 +0100
X-Gm-Features: AclHuK-YdT1Ib3TAVwCgdSX4Qq2ElR55FeK5z-VMfLHkOTSG9MLAKXfO7c4fnug
Message-ID: <CAJaqyWeqRMY50kr4_7VBvWfCo8xGgkRbYrua6TRe11TcpqgiAg@mail.gmail.com>
Subject: Re: [PATCH] virtio: Reset free_head on shadow virtqueue start
To: lirongqing <lirongqing@baidu.com>
Cc: mst@redhat.com, Stefano Garzarella <sgarzare@redhat.com>,
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Nov 4, 2026 at 3:01=E2=80=AFAM lirongqing <lirongqing@baidu.com> wr=
ote:
>
> From: Li RongQing <lirongqing@baidu.com>
>
> free_head tracks the index of the next free descriptor in the SVQ
> descriptor ring.  It is used by vhost_svq_vring_write_descs() to
> choose where to place new descriptors, and is updated as descriptors
> are allocated and recycled.
>
> free_head is zero-initialized when the SVQ is created through
> vhost_svq_new() (g_new0), but it is not reset in vhost_svq_start().
> The start function already resets the rest of the ring state
> (shadow_avail_idx, shadow_used_idx, last_used, last_used_idx and
> num_free), yet free_head is left untouched.
>
> Since an SVQ can be stopped and restarted on the same object, for
> example across vDPA device migration or control virtqueue processing,
> a stale free_head from the previous run survives into the new one.
> This causes new descriptors to be written at the wrong position of
> the SVQ descriptor ring, corrupting it.
>
> Reset free_head to 0 in vhost_svq_start() so that descriptor
> allocation always begins from the head of a fresh ring.
>
> Fixes: 100890f7cad5 ("vhost: Shadow virtqueue buffers forwarding")

Reviewed-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

Thanks!

> Signed-off-by: Li RongQing <lirongqing@baidu.com>
> ---
>  hw/virtio/vhost-shadow-virtqueue.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/hw/virtio/vhost-shadow-virtqueue.c b/hw/virtio/vhost-shadow-=
virtqueue.c
> index c97bd9f..462c86d 100644
> --- a/hw/virtio/vhost-shadow-virtqueue.c
> +++ b/hw/virtio/vhost-shadow-virtqueue.c
> @@ -857,6 +857,7 @@ void vhost_svq_start(VhostShadowVirtqueue *svq, VirtI=
ODevice *vdev,
>      svq->shadow_used_idx =3D 0;
>      memset(&svq->batch_last, 0, sizeof(svq->batch_last));
>      svq->last_used =3D 0;
> +    svq->free_head =3D 0;
>      svq->last_used_idx =3D 0;
>      svq->vdev =3D vdev;
>      svq->vq =3D vq;
> --
> 2.9.4
>


