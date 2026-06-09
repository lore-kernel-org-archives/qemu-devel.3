Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 669A1CD8CAA
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 03:48:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWnRT-00075t-Qi; Mon, 08 Jun 2026 23:47:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <munkhuu0825@gmail.com>)
 id 1wWnRS-00075h-Gf
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 23:47:54 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <munkhuu0825@gmail.com>)
 id 1wWnRQ-00005s-LL
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 23:47:54 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2c0c2d792c8so33641065ad.1
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2026 20:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780976871; x=1781581671; darn=nongnu.org;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kDIMqNNrM9DLGs+p1Y5szNhWe8CTdqjPSmIdNBd/tco=;
 b=ldi2/ImtyeTnpMSETd8pFnv53wzCE339yQs+qD6Rhy8ORe1qT5l0vYTZW9HOOpZQYL
 w8RSgPfI3vpgiZIzIxjB9CXqs2JYJ+vyJ3Cvxlx0lO5ehK0gEEGnZ3olK6pIysyQtYC1
 fz/kC3XSf47DM1sZA0QxxOY22oa4tzMa3lrJQu/sDfYeurGizvJlQccsH//ST4wdfbt0
 BswTLD1tXASk3WxH1wuS5jyqNz1Y+uuNVoXwoeKBDV/2SOduOjEdttXFN6ZGHoNYFoMJ
 AgPL0vA9YjKVifvZJMji9Pf5RQDznInvq+qjcY5UEIKcWS419OyMF8sEarDpQfe4tvPq
 e41A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780976871; x=1781581671;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kDIMqNNrM9DLGs+p1Y5szNhWe8CTdqjPSmIdNBd/tco=;
 b=lUlxKGfQsXv9cMWPhtvWEyBYXyQ4yk4kdUOwH2QCrAI5b8oUh2sdO4XvIOiYUMqQM3
 yB5KyeXoxpVQEUXvJbhlJLy5l7CwNmYJX66/WgriWe6X4Glry3dp9tb6E6uaERA32N9q
 x3KVcpA4QKApKok9roX2rAKh27Z2bNrg2YA6tCCdCqf7xfcI7Wg0HOhL8Rrp4R1nueAZ
 9NtavbeoP0bDSTUABsGr8e53iHpiRQWe5UnL5IjTXGy74ml9xM1fLIxV8eeDsgvPk14k
 kZ8DRjVR5a2ZszLey+druRtZE6vVn+hRYpe+wvZKCdXcu+hBVbXy8sPhCNJS0R58a5Ch
 AfpQ==
X-Gm-Message-State: AOJu0Yx5FJLZv50G65tJZF3y/BpSXgsk/bQ/VRV18tp/d6WOfgWR7jti
 Xh0so9mq1f6sSHv/IIGIE74el+7DnSLzgWvXn5feIzD3eOA/IaU5Qw0SxqLtNReugaY=
X-Gm-Gg: Acq92OEr7f1UTxG7EINqMAa4RLJZDn+QtYXzUNQoF4Tv1vEKrsA/i1T/uGrY4P3ZPrM
 8Ur0VE/1QBlwKWP5Q5tocPF8jVnPPL2z7w/gtMy906s3xT0SJm6JLjrO3EpelgMzMITClwOq6lk
 1rvHN4GXGjbeVN9OIamjRR2xWrZH11JDDJVyiDP4diqNBu+BIgVsaIEE9DD4IczpjW0lGb8quRr
 15sSIi61wTrkN9k0MGprwmPoJXSaFfTvVlcS/RTWEcaCjYc6KgpROBHyyGed4LmESamK7Q69s8X
 NDEaUseinnJj33MKdgSJGogQJEoO93K8WgbdPEGoEMDbzmfs37Ol5SAlgrLmVFYXrZ5y2RuacCe
 gBZYymIxGh279ewlkmYnEms6+IWEa7MNRsaeYmAonxbOB0aSiqHc86cbhLgr6ErvAB2kKWKA7bl
 MNiL14IVYT1+4pJdDZul97ZHcN5DSdsmsuuBFqoGXOBfdnBZJVEnGpOp6Wow==
X-Received: by 2002:a17:903:44cb:b0:2bc:b80f:677e with SMTP id
 d9443c01a7336-2c1e80cd382mr135291835ad.25.1780976870986; 
 Mon, 08 Jun 2026 20:47:50 -0700 (PDT)
Received: from smtpclient.apple ([202.55.186.124])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c164f6d389sm191551925ad.16.2026.06.08.20.47.49
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 08 Jun 2026 20:47:50 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: Re: [PATCH] hw/virtio/virtio: Rebuild vring caches when packed ring
 changes
From: Munkhbaatar Enkhbaatar <munkhuu0825@gmail.com>
In-Reply-To: <20260507145100.4861-1-munkhuu0825@gmail.com>
Date: Tue, 9 Jun 2026 11:47:37 +0800
Cc: mst@redhat.com,
 manos.pitsidianakis@linaro.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <3C7D6F09-F141-41F2-912B-E84C3A0887F2@gmail.com>
References: <20260507145100.4861-1-munkhuu0825@gmail.com>
To: qemu-devel@nongnu.org
X-Mailer: Apple Mail (2.3864.600.51.1.1)
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=munkhuu0825@gmail.com; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi,

Just a gentle ping on this patch.

It fixes a virtio-sound assertion with packed=3Don by rebuilding =
existing
vring caches when VIRTIO_F_RING_PACKED changes. The issue is tracked =
here:

https://gitlab.com/qemu-project/qemu/-/work_items/3466

Please let me know if any changes are needed.

Thanks,
Munkhbaatar

> On 7 May 2026, at 22:51, Munkhbaatar Enkhbaatar =
<munkhuu0825@gmail.com> wrote:
>=20
> A guest can enable a virtqueue before feature negotiation completes, =
so
> virtio_queue_set_rings() creates caches before VIRTIO_F_RING_PACKED is
> loaded into guest_features.
> Packed rings need a writable descriptor cache because used descriptors =
are
> written back into the descriptor ring. If the cache was created as a =
split
> ring cache, this can later trigger an assertion.
> Rebuild existing vring caches when VIRTIO_F_RING_PACKED changes, as =
already
> done for VIRTIO_RING_F_EVENT_IDX.
>=20
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3466
>=20
> Signed-off-by: Munkhbaatar Enkhbaatar <munkhuu0825@gmail.com>
> ---
> hw/virtio/virtio.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index 63e2faee99..14e7dd70be 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -3223,8 +3223,9 @@ int virtio_set_features_ex(VirtIODevice *vdev, =
const uint64_t *features)
>     }
>=20
>     ret =3D virtio_set_features_nocheck(vdev, features);
> -    if (virtio_vdev_has_feature(vdev, VIRTIO_RING_F_EVENT_IDX)) {
> +    if (virtio_vdev_has_feature(vdev, VIRTIO_RING_F_EVENT_IDX) || =
virtio_vdev_has_feature(vdev, VIRTIO_F_RING_PACKED)) {
>         /* VIRTIO_RING_F_EVENT_IDX changes the size of the caches.  */
> +        /* VIRTIO_F_RING_PACKED changes the cache->is_write value. */
>         int i;
>         for (i =3D 0; i < VIRTIO_QUEUE_MAX; i++) {
>             if (vdev->vq[i].vring.num !=3D 0) {
> --=20
> 2.50.1 (Apple Git-155)
>=20


