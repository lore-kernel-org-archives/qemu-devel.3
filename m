Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E79FC83F1A
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 01:18:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubUJ4-0000j8-OU; Mon, 14 Jul 2025 21:18:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1ubUIr-0000ZB-Uu
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 21:17:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1ubUIp-0001hR-1c
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 21:17:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752542268;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/NTm9Hr72gL7PKYU2IeB3MF9Zqo8lCFkvy/pWG+vfaI=;
 b=aSIZniPY+Ca4Oe/WObURshkkFSiFdMPxeYCpyLUYyGsYRybwSqPwJVQZv0/BlB0QU/NFus
 gE11cN804X3U2XEN4ZffW01FmsWtzPO+tZUDse4QcdwIjbDWrZhopeIHj5+IPCADhLmSnE
 UNVUGuCQSLD4TU1QMr1okLOS6xPTGrk=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-327-ce9iRVbeOnKW2-7ykVGRRQ-1; Mon, 14 Jul 2025 21:17:47 -0400
X-MC-Unique: ce9iRVbeOnKW2-7ykVGRRQ-1
X-Mimecast-MFC-AGG-ID: ce9iRVbeOnKW2-7ykVGRRQ_1752542266
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-31218e2d5b0so8741579a91.2
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 18:17:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752542266; x=1753147066;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/NTm9Hr72gL7PKYU2IeB3MF9Zqo8lCFkvy/pWG+vfaI=;
 b=pi5HyFQg4CjfJYFy9K8fVCP1XJQH1P+sCM+79TXWViqOJtY/Y10zT8eNwBNP6D9UY6
 2qI50gAQu1oWYTosDh77ete9rVRPvz7j3nZ5wDRIv12ZkCwjjinDB8QGmc3mEXFUEBp7
 j7v3LZ+h2ya4DmQwvc4Gcq8jW+FGD2e43gAN3AeHCw+WD0DEfZA+mjzOiZPw0KBOpaKh
 Lf215hd0DJYYGKnrwbWBwXvDSPsYAn71V7Wk7p1+avgYsnl7h7NBmi/CNLmxtGhhKoIX
 zgrlJzXQnIZM+sutwsZBI3avcps/nN301dOglKDu5jmoPNEeXQue+IXOMmj2sOSuYn40
 Z29w==
X-Gm-Message-State: AOJu0YzjQRrBDgHv8oqlYrVbqJ1/aHKCHAt51kqh/47DIxERJ8RNuE+3
 auTv68p/brehH5Dkzbg3ZZX8zhsZd2cmPSPMYXB8eZHY4H1N25b/G15qeCrtmrgayJFdB2soozW
 NETSBvyO3amDmUu8SaI9LqWuK8ZC3CLkvUumZILuCJ0gXkH1DoK5Ic155Yp0lr3uent0F0W6rYT
 R3l71ofyCwTxm1XKgWMmjn4hnCAGFExn7CUVJTLb/Ylg==
X-Gm-Gg: ASbGnctp1fFWZzCKkFKpIXKde6HypDeQBv9LH4G60oY8zRUhPUOhgxvXF3kD+HDPDLF
 MjTSoJMR1cVDhp4RzzJiRtQ8Gjqg/+nT6Q2vFgzhvMAsl553CwANCtzNIjI67q81u8Cc8RggfPI
 BbxrLRHtPMiZdjDJjzGeRH
X-Received: by 2002:a17:90b:1651:b0:311:da03:3437 with SMTP id
 98e67ed59e1d1-31c4ccf0c7fmr22485167a91.27.1752542265815; 
 Mon, 14 Jul 2025 18:17:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFsgftE/OYotkk/KF2GkVdzT95J3RtTNONkhAAcVSpf39LbEFH55E2VAXxK2fiEwKkda0mcxN1uuF2b0Zw4FTk=
X-Received: by 2002:a17:90b:1651:b0:311:da03:3437 with SMTP id
 98e67ed59e1d1-31c4ccf0c7fmr22485136a91.27.1752542265282; Mon, 14 Jul 2025
 18:17:45 -0700 (PDT)
MIME-Version: 1.0
References: <20250714101156.30024-1-sgarzare@redhat.com>
In-Reply-To: <20250714101156.30024-1-sgarzare@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 15 Jul 2025 09:17:34 +0800
X-Gm-Features: Ac12FXz2CT4LKlifXOmwaHhb9Obv37OsjJuSuiAn2Z6paG_NXuwOPLx_JairxEY
Message-ID: <CACGkMEtqnm3FAdPjptB7DLTgWmP=rM9JPS+JgKnEHn+85uMvHA@mail.gmail.com>
Subject: Re: [PATCH] net/vdpa: fix potential fd leak in net_init_vhost_vdpa()
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
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

On Mon, Jul 14, 2025 at 6:12=E2=80=AFPM Stefano Garzarella <sgarzare@redhat=
.com> wrote:
>
> From: Stefano Garzarella <sgarzare@redhat.com>
>
> Coverity reported a file descriptor leak (CID 1490785) that happens if
> `vhost_vdpa_get_max_queue_pairs()` returns 0, since in that case
> net_host_vdpa_init(), which should take ownership of the fd, is never
> called.
>
> vhost_vdpa_get_max_queue_pairs() returns 1 if VIRTIO_NET_F_MQ is not
> negotiated, or a negative error if the ioctl() fails, or the maximum
> number of queue pairs exposed by the device in the config space in the
> `max_virtqueue_pairs` field. In the VIRTIO spec we have:
>      The device MUST set max_virtqueue_pairs to between 1 and 0x8000
>      inclusive, if it offers VIRTIO_NET_F_MQ.
>
> So, if `vhost_vdpa_get_max_queue_pairs()` returns 0, it's really an
> error since the device is violating the VIRTIO spec.
>
> Treat also `queue_pairs =3D=3D 0` as an error, and jump to the `err` labe=
l,
> to return a negative value to the caller in any case.
>
> Coverity: CID 1490785
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>  net/vhost-vdpa.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
> index 58d738945d..9dc7d2cb23 100644
> --- a/net/vhost-vdpa.c
> +++ b/net/vhost-vdpa.c
> @@ -1813,9 +1813,8 @@ int net_init_vhost_vdpa(const Netdev *netdev, const=
 char *name,
>
>      queue_pairs =3D vhost_vdpa_get_max_queue_pairs(vdpa_device_fd, featu=
res,
>                                                   &has_cvq, errp);
> -    if (queue_pairs < 0) {
> -        qemu_close(vdpa_device_fd);
> -        return queue_pairs;
> +    if (queue_pairs <=3D 0) {
> +        goto err;
>      }
>
>      r =3D vhost_vdpa_get_iova_range(vdpa_device_fd, &iova_range);
> --
> 2.50.1
>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


