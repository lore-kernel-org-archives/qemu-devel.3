Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53335C3ABC9
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 01:35:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uF11Q-0006O8-Er; Tue, 13 May 2025 21:35:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leiyang@redhat.com>)
 id 1uF11P-0006O0-Bq
 for qemu-devel@nongnu.org; Tue, 13 May 2025 21:34:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leiyang@redhat.com>)
 id 1uF11N-00037r-GC
 for qemu-devel@nongnu.org; Tue, 13 May 2025 21:34:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747186495;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GM6jv9Z8Z1xPmzt9V+7hcPY3IJmHNtAWLIfsf5DPhrA=;
 b=e/B1GWSDkQHMV+kqv1EciocgBMpNSyfzw8Tu/wMgo+FgKjj53dzNJjiSXf9lgmdivSvByE
 HHasEZAGWJluxTdyu0qaMMDD3si7tpXdc0Y9WhM0SF6QmPRDbs0c5McLObjNcBK6fIcOxg
 4BPhd0U59q32AuTHtXEJ/9ttVSwZ2go=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-199-QPJvEDa_OgmZAp4RyCbLBg-1; Tue, 13 May 2025 21:34:51 -0400
X-MC-Unique: QPJvEDa_OgmZAp4RyCbLBg-1
X-Mimecast-MFC-AGG-ID: QPJvEDa_OgmZAp4RyCbLBg_1747186490
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-ad2363a3949so445637666b.0
 for <qemu-devel@nongnu.org>; Tue, 13 May 2025 18:34:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747186490; x=1747791290;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GM6jv9Z8Z1xPmzt9V+7hcPY3IJmHNtAWLIfsf5DPhrA=;
 b=h8GdiOUqiec9ndzZB/Cx6wI0vJK4NSRa8QRE5tfCm9cWM3JJ9HGzRQNA7Mn0YMWNub
 Ts8E338Y10HMMoLiLFRoJI/J/pTy1HNn2hTGGI9aZPW6mZ0Bk7Msox/+uXlAr14ixZPw
 pbP3ok861f7XBk872sn7D23QByt7g0FhlfoR7/5E/pEzPIcdXavVlQlwcWToOCg4UZI0
 QIuUJJvUMvKCy+phXZi5fs3NVwWVzbghz5pl0eWRlHGRKYVyhOz64hqwmSdZiSKHBmA+
 wlMk4n0ArBzvkk4+iDtYC6RhiNjEn9OJ5ur4MjTED0dXUcklNMpO6bBcrZvOoYExoNvd
 OwiQ==
X-Gm-Message-State: AOJu0YxzOroLqYwlrBPXJn+ejSmVmWJLc5eSKxk/goFCZwd2NramTA8s
 22YuGRyx2lDfxh0/TpXT8Dtnrj2TChkuXGhTs+wKOccfr8tnPW3e8umF1iATjDitZFJjXhFLROO
 5aHx7+la3RyF+0bopDs7EL4EMMv5TdsJTexW65JgV4T0epcHnJST9BjIyZp6MwWhfj9DPF0fuqv
 +DfrhkrdPoZOEIaxriax6e3LmegBI=
X-Gm-Gg: ASbGnctRfOguVrrASbEaUIPO8wpYu+Un8J5t47iEJe4+B74i76B5AQsWe39xudco1gt
 bH1dsoMmjSF7iBy1etNBwwB8uGFAA92UKob0OSDwfODyrd9LA2I+CfDR7JNmqJnfFaAfFlA==
X-Received: by 2002:a17:907:c290:b0:acb:5f9a:72f4 with SMTP id
 a640c23a62f3a-ad4f71547a2mr150634366b.30.1747186489859; 
 Tue, 13 May 2025 18:34:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IERpITjt8HEa/cnhCLPKUu/jGOPxAZqjN9TZqnShsershQ+oTWB5zbdq7YcbQbg26Te+VxOXXzvmUYml5+go8I=
X-Received: by 2002:a17:907:c290:b0:acb:5f9a:72f4 with SMTP id
 a640c23a62f3a-ad4f71547a2mr150633166b.30.1747186489474; Tue, 13 May 2025
 18:34:49 -0700 (PDT)
MIME-Version: 1.0
References: <20250510-n-v1-1-19ee26ac3ca6@daynix.com>
In-Reply-To: <20250510-n-v1-1-19ee26ac3ca6@daynix.com>
From: Lei Yang <leiyang@redhat.com>
Date: Wed, 14 May 2025 09:34:12 +0800
X-Gm-Features: AX0GCFuyBW7yIVYFJ0rAOQbFb96HQbNWVrijmS4KcOMpBaTMcaOuUiR3bxYTIQo
Message-ID: <CAPpAL=w_C5JCM64c=nfn+1B2_twHN4s6RoEYKFRG8AaO=LuOeg@mail.gmail.com>
Subject: Re: [PATCH] virtio-net: Add queues for RSS during migration
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, devel@daynix.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=leiyang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.549,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

I tested this patch with virtio-net regression tests, everything works fine=
.

Tested-by: Lei Yang <leiyang@redhat.com>


On Sat, May 10, 2025 at 3:25=E2=80=AFPM Akihiko Odaki <akihiko.odaki@daynix=
.com> wrote:
>
> virtio_net_pre_load_queues() inspects vdev->guest_features to tell if
> VIRTIO_NET_F_RSS or VIRTIO_NET_F_MQ is enabled to infer the required
> number of queues. This works for VIRTIO_NET_F_MQ but it doesn't for
> VIRTIO_NET_F_RSS because only the lowest 32 bits of vdev->guest_features
> is set at the point and VIRTIO_NET_F_RSS uses bit 60 while
> VIRTIO_NET_F_MQ uses bit 22.
>
> Instead of inferring the required number of queues from
> vdev->guest_features, use the number loaded from the vm state.
>
> Fixes: 8c49756825da ("virtio-net: Add only one queue pair when realizing"=
)
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>  include/hw/virtio/virtio.h |  2 +-
>  hw/net/virtio-net.c        | 11 ++++-------
>  hw/virtio/virtio.c         | 14 +++++++-------
>  3 files changed, 12 insertions(+), 15 deletions(-)
>
> diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
> index 638691028050..af52580c1e63 100644
> --- a/include/hw/virtio/virtio.h
> +++ b/include/hw/virtio/virtio.h
> @@ -211,7 +211,7 @@ struct VirtioDeviceClass {
>      int (*start_ioeventfd)(VirtIODevice *vdev);
>      void (*stop_ioeventfd)(VirtIODevice *vdev);
>      /* Called before loading queues. Useful to add queues before loading=
. */
> -    int (*pre_load_queues)(VirtIODevice *vdev);
> +    int (*pre_load_queues)(VirtIODevice *vdev, uint32_t n);
>      /* Saving and loading of a device; trying to deprecate save/load
>       * use vmsd for new devices.
>       */
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index de87cfadffe1..c25c6cf54183 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -3026,11 +3026,10 @@ static void virtio_net_del_queue(VirtIONet *n, in=
t index)
>      virtio_del_queue(vdev, index * 2 + 1);
>  }
>
> -static void virtio_net_change_num_queue_pairs(VirtIONet *n, int new_max_=
queue_pairs)
> +static void virtio_net_change_num_queues(VirtIONet *n, int new_num_queue=
s)
>  {
>      VirtIODevice *vdev =3D VIRTIO_DEVICE(n);
>      int old_num_queues =3D virtio_get_num_queues(vdev);
> -    int new_num_queues =3D new_max_queue_pairs * 2 + 1;
>      int i;
>
>      assert(old_num_queues >=3D 3);
> @@ -3066,16 +3065,14 @@ static void virtio_net_set_multiqueue(VirtIONet *=
n, int multiqueue)
>      int max =3D multiqueue ? n->max_queue_pairs : 1;
>
>      n->multiqueue =3D multiqueue;
> -    virtio_net_change_num_queue_pairs(n, max);
> +    virtio_net_change_num_queues(n, max * 2 + 1);
>
>      virtio_net_set_queue_pairs(n);
>  }
>
> -static int virtio_net_pre_load_queues(VirtIODevice *vdev)
> +static int virtio_net_pre_load_queues(VirtIODevice *vdev, uint32_t n)
>  {
> -    virtio_net_set_multiqueue(VIRTIO_NET(vdev),
> -                              virtio_has_feature(vdev->guest_features, V=
IRTIO_NET_F_RSS) ||
> -                              virtio_has_feature(vdev->guest_features, V=
IRTIO_NET_F_MQ));
> +    virtio_net_change_num_queues(VIRTIO_NET(vdev), n);
>
>      return 0;
>  }
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index 85110bce3744..286648fe9b60 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -3255,13 +3255,6 @@ virtio_load(VirtIODevice *vdev, QEMUFile *f, int v=
ersion_id)
>          config_len--;
>      }
>
> -    if (vdc->pre_load_queues) {
> -        ret =3D vdc->pre_load_queues(vdev);
> -        if (ret) {
> -            return ret;
> -        }
> -    }
> -
>      num =3D qemu_get_be32(f);
>
>      if (num > VIRTIO_QUEUE_MAX) {
> @@ -3269,6 +3262,13 @@ virtio_load(VirtIODevice *vdev, QEMUFile *f, int v=
ersion_id)
>          return -1;
>      }
>
> +    if (vdc->pre_load_queues) {
> +        ret =3D vdc->pre_load_queues(vdev, num);
> +        if (ret) {
> +            return ret;
> +        }
> +    }
> +
>      for (i =3D 0; i < num; i++) {
>          vdev->vq[i].vring.num =3D qemu_get_be32(f);
>          if (k->has_variable_vring_alignment) {
>
> ---
> base-commit: 825b96dbcee23d134b691fc75618b59c5f53da32
> change-id: 20250406-n-ae7be0389382
>
> Best regards,
> --
> Akihiko Odaki <akihiko.odaki@daynix.com>
>
>


