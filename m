Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBD43C88E77
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 13:12:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6pPw-0004Yh-41; Wed, 16 Sep 2026 09:11:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1x6pPi-0004Il-Vd
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:11:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1x6pPe-0001vT-JO
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:11:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789564256;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P0dOW581eAqBMdlfQUHL+OW4hkCxXKK8mgfP7GhtHt4=;
 b=dqll7W2JARDgOcbIQ+TdaPxR0ulLhwoQqx8xSKZHQKbnQCjM704giQvx0C2CRRDAZoSTU0
 09+5bR3UGnLi2aim+V7PQbmqa3kbzYKD1vnZ3PDg6BBBgDUvOrJ7co1v3k3ZV8V9nBC8ua
 n/l9HWqMSuSa/pYw4GU3Bm9KhyW8RSw=
Received: from mail-yx1-f69.google.com (mail-yx1-f69.google.com
 [74.125.224.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-ECkTYXbKNxaTyjU7w5wUzQ-1; Wed, 16 Sep 2026 09:10:55 -0400
X-MC-Unique: ECkTYXbKNxaTyjU7w5wUzQ-1
X-Mimecast-MFC-AGG-ID: ECkTYXbKNxaTyjU7w5wUzQ_1789564254
Received: by mail-yx1-f69.google.com with SMTP id
 956f58d0204a3-66f8ab159abso6933904d50.3
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 06:10:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789564254; cv=none;
 d=google.com; s=arc-20260327;
 b=kdp3ml0/hZIBisvCheNt3lK+qy3wVGt37bffDCEJvlUA4ZmDdSvyvdxRvHB9b77Cic
 SQZqlGeauSIfcEiLHQK+atFykDVaPea/VHO4n8G4YVFvShaZM2TbeQcRI3tupUsmEBhY
 sUqe3o895u75IgBknsPLkmubqjr7+Lz3gbRRGW9UUveku2wTaWpjONeb038dkxtVH7M3
 9WoQujO84Gyv61fAm+8XCqijU5ZeMoTCEeI9cQ2dapig+FkeXKLBS384cvMQwAZqLxTu
 hTC1C4XtGpFWBlHrb1aB9hZvfc4zXyQQSJHs/buNmFVtGhkYHhdfytew2d+/n923Qbyh
 niIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=P0dOW581eAqBMdlfQUHL+OW4hkCxXKK8mgfP7GhtHt4=;
 fh=seomdN3Ghq8T0CkeQ9WEhuH1Z6cHbH+Ufev1mCr6vBA=;
 b=b+vsx2x6Wl0KjJCyjoWcp3emPlz8WNsLxNSNyBqU+vKCBRuiA+WFZvDf/I7vDHfGia
 LeLCioCZ8PQbzg14UDe9o325KU9SWHqralHj6Jt9Qnoke+f36fGPtlT5FcKb8lXmH3Ny
 74VGLSsxA1DI/1m1J6prvUrTutemfwcsgN6d8ibtr20pcI6P1SymnEBbpKv+l25Do0Rs
 8TGt+9F69OsHellkivI0oBjLzkjn9N1HO20SQ91aiRNmgijmpRjyArvq+2onwx5n7MwU
 45VO7+uj382c00jy/dbx+lSdWvXUg2Zc40Uw5VkqOAN6PbNsX37baf1NS1rwJiJp2FAG
 l7rw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789564254; x=1790169054; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=P0dOW581eAqBMdlfQUHL+OW4hkCxXKK8mgfP7GhtHt4=;
 b=Te5YAEjtewfHIJMPRw841cJPG3FwmmY/Yx5nMR4nwHNvBZnUPtZ1VCEu6Kk6r/U5Af
 dDuL1WDIXBr0qwxpQr25YZ3REQe3aCFvKt3xDdwxGzmh9HzYxxV3QDtSMsx7eJLa9pkl
 u+mhuwXDc+rRhIvpns0dzfTtX4waAcUTzfZI50aa/hgdMyTO5XyE2rTzIPYAgZJ6HaqR
 eGTusWpB0IYlTe7Cva0U2YRF7Zg3E8SetqVzJnNAbLA7zKFUo41fIfggDZYlJmlruv39
 ApnvsUEbLe/Swx5Lq67AtBuJY+KMvYH87uYGMOqyAG7a2x8+WbDZRqU0kGtMavnLvLMx
 ZKrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789564254; x=1790169054;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=P0dOW581eAqBMdlfQUHL+OW4hkCxXKK8mgfP7GhtHt4=;
 b=BPhqCFwtA4K21ZUOuHNsb4Qg7SyaNIso295B1RoplA8jsPVr/y/nAFAWWlfwkXB1yT
 uh+UwOn0bH4ny2VVt7tYpAQ1dKqaK8Vf0f62YeaQHc9t4MHP3NChwAv603477cELJAr5
 iC+nM/TyoqFXOAHHu8RJWTIj6QXJACERduksb1mN/wd8yhnUWHAiSebfTo95HC1Q7m2g
 PstYqV2f1B1AmGxhELl735Da1TuTEJq4xx1FofkIW/6qcveAlaMvjBip0ww6BrXKaK43
 U9fCzKwKcnuho6QnIc3Z1k9D+KSGaksULhMZbyBysNDt7vqhv+2lk55ZsTXZNB6+NSfI
 xrJg==
X-Gm-Message-State: AFuF++ksTsmJfRnHokoHS/dUF8wOOdvZjH4lNR6AoyVA/wdZa7m3lsy3
 xxzkEGoTZ12tcDC9xWW8SCufk046kfQiWQTkMe0FXK5adbCNqI4DOugzvrichHPoMESpifvyZBL
 oWNNYQQ8PYMuVaaSRVelm80B8InTPyLWZmcznQmsZSpUy9alf0t+M2TiCMO8pAM6QXdw4TxxEBm
 9cI3A0gcDH78WszGmnJrATSV8jKXSv/ao=
X-Gm-Gg: AYBFou1vha3dYpDelfxH/waGykAr7crC7pZsPmTUxObaarwEiUdWy5lHJgiJobK0FE1
 HHldG2jrPxl1LvSZSAOw83LcMgkMunrLyAGGOWS+cbGM/Z+/B4G1bay0NBvEiElBk7mn6s+A5sX
 eQ6nH/og6ttyADbxxRU3TsJPEjot1KTmILgL3gBkKgFZdJlfMgLF78p/tiLYW8pMCUx1MJeXJ9I
 KrbKBCA2gtuArLBOtrXTKhyps/WkMU/fW71PgX78/Z16VGDODuPNWUl+NX1FKEMuDjXFXA/hT6b
 ZCyhk9PcjIx603B2zQ==
X-Received: by 2002:a05:690e:d47:b0:671:5b87:31ae with SMTP id
 956f58d0204a3-671632d8a41mr668577d50.91.1789564254447; 
 Wed, 16 Sep 2026 06:10:54 -0700 (PDT)
X-Received: by 2002:a05:690e:d47:b0:671:5b87:31ae with SMTP id
 956f58d0204a3-671632d8a41mr668555d50.91.1789564253809; Wed, 16 Sep 2026
 06:10:53 -0700 (PDT)
MIME-Version: 1.0
References: <20260716134421.3765533-1-kdutta@redhat.com>
 <20260716134421.3765533-2-kdutta@redhat.com>
In-Reply-To: <20260716134421.3765533-2-kdutta@redhat.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 16 Sep 2026 15:10:17 +0200
X-Gm-Features: AcwNN1Vau-OmGW-xqxrZ2wTrTIOdL3Y-Ldk4F8NVIy2EK-xJinHVFdhLUhqYQ5k
Message-ID: <CAJaqyWfxTVbWQA87-1+Ca2S7FBoC4=jzYabt9mHBphFKcSV6EQ@mail.gmail.com>
Subject: Re: [PATCH v10 1/2] [PATCH 1/2] Introduce
 virtio_net_handle_tx_dispatch()
 to unify TX path handling. This dispatcher dynamically selects between
 timer-based and BH-based TX processing based on configuration.
To: Koushik Dutta <kdutta@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
 Zhao Liu <zhao1.liu@intel.com>, Jason Wang <jasowang@redhat.com>
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
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Jul 16, 2026 at 3:44=E2=80=AFPM Koushik Dutta <kdutta@redhat.com> w=
rote:
>
> Previously, the tx=3Dtimer selected between two completely separate
> code paths at queue creation time. This refactoring introduces a
> runtime dispatch mechanism while maintaining identical behavior.
>
> This is a preparatory patch with no functional changes, making it
> easier to add dynamic TX notification coalescing in a subsequent patch.
>
> Signed-off-by: Koushik Dutta <kdutta@redhat.com>
> ---
>  hw/net/virtio-net.c            | 41 ++++++++++++++++++++++------------
>  include/hw/virtio/virtio-net.h |  1 +
>  2 files changed, 28 insertions(+), 14 deletions(-)
>
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index 2a5d642a64..e7f05956a5 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -2973,6 +2973,22 @@ static void virtio_net_tx_bh(void *opaque)
>      }
>  }
>
> +static void virtio_net_handle_tx_dispatch(VirtIODevice *vdev, VirtQueue =
*vq)
> +{
> +    VirtIONet *n =3D VIRTIO_NET(vdev);
> +    VirtIONetQueue *q =3D &n->vqs[vq2q(virtio_get_queue_index(vq))];
> +
> +    if (n->tx_timer_activate) {
> +        if (q->tx_timer =3D=3D NULL) {
> +            q->tx_timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL,
> +                                       virtio_net_tx_timer, q);
> +        }

Let's keep the creation of the timer at virtio_net_add_queue, so the
code does not need to evaluate if the timer hsa been created every
time virtio_net_handle_tx_dispatch is called and reduce the number of
changes.

> +        virtio_net_handle_tx_timer(vdev, vq);
> +    } else {
> +        virtio_net_handle_tx_bh(vdev, vq);
> +    }
> +}
> +
>  static void virtio_net_add_queue(VirtIONet *n, int index)
>  {
>      VirtIODevice *vdev =3D VIRTIO_DEVICE(n);
> @@ -2980,20 +2996,13 @@ static void virtio_net_add_queue(VirtIONet *n, in=
t index)
>      n->vqs[index].rx_vq =3D virtio_add_queue(vdev, n->net_conf.rx_queue_=
size,
>                                             virtio_net_handle_rx);
>
> -    if (n->net_conf.tx && !strcmp(n->net_conf.tx, "timer")) {
> -        n->vqs[index].tx_vq =3D
> -            virtio_add_queue(vdev, n->net_conf.tx_queue_size,
> -                             virtio_net_handle_tx_timer);
> -        n->vqs[index].tx_timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL,
> -                                              virtio_net_tx_timer,
> -                                              &n->vqs[index]);
> -    } else {
> -        n->vqs[index].tx_vq =3D
> -            virtio_add_queue(vdev, n->net_conf.tx_queue_size,
> -                             virtio_net_handle_tx_bh);
> -        n->vqs[index].tx_bh =3D qemu_bh_new_guarded(virtio_net_tx_bh, &n=
->vqs[index],
> -                                                  &DEVICE(vdev)->mem_ree=
ntrancy_guard);
> -    }
> +    n->vqs[index].tx_vq =3D
> +        virtio_add_queue(vdev, n->net_conf.tx_queue_size,
> +                         virtio_net_handle_tx_dispatch);
> +
> +    n->vqs[index].tx_bh =3D
> +        qemu_bh_new_guarded(virtio_net_tx_bh, &n->vqs[index],
> +                            &DEVICE(vdev)->mem_reentrancy_guard);
>
>      n->vqs[index].tx_waiting =3D 0;
>      n->vqs[index].n =3D n;
> @@ -3970,6 +3979,10 @@ static void virtio_net_device_realize(DeviceState =
*dev, Error **errp)
>          error_printf("Defaulting to \"bh\"");
>      }
>
> +    if (n->net_conf.tx && strcmp(n->net_conf.tx, "timer") =3D=3D 0) {
> +        n->tx_timer_activate =3D true;
> +    }
> +
>      n->net_conf.tx_queue_size =3D MIN(virtio_net_max_tx_queue_size(n),
>                                      n->net_conf.tx_queue_size);
>
> diff --git a/include/hw/virtio/virtio-net.h b/include/hw/virtio/virtio-ne=
t.h
> index 371e376428..a4eb3f407e 100644
> --- a/include/hw/virtio/virtio-net.h
> +++ b/include/hw/virtio/virtio-net.h
> @@ -230,6 +230,7 @@ struct VirtIONet {
>      struct EBPFRSSContext ebpf_rss;
>      uint32_t nr_ebpf_rss_fds;
>      char **ebpf_rss_fds;
> +    bool tx_timer_activate;
>  };
>
>  size_t virtio_net_handle_ctrl_iov(VirtIODevice *vdev,
> --
> 2.53.0
>


