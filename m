Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F72CC52D70
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 07:35:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZmoQ-0005tB-9z; Fri, 02 Aug 2024 03:34:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuri.benditovich@daynix.com>)
 id 1sZmoN-0005s3-Uq
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 03:34:52 -0400
Received: from mail-qk1-x733.google.com ([2607:f8b0:4864:20::733])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yuri.benditovich@daynix.com>)
 id 1sZmoM-0006eM-60
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 03:34:51 -0400
Received: by mail-qk1-x733.google.com with SMTP id
 af79cd13be357-7a1d066a5daso526592685a.3
 for <qemu-devel@nongnu.org>; Fri, 02 Aug 2024 00:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1722584089; x=1723188889;
 darn=nongnu.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xSFvSek6plmZmrvCA1HG5Dg7LpMLl1vHSte3aCVpdlQ=;
 b=ENtCVu1UBPp5fGvjpUDHaJwTeGi3uY6MkBlZl8LmQol1HUFuW+Zuj7VWydxjGXeOf+
 RdQ5nm6lEUw/rnd+r8T0PX6wR7YLuyhKjSU+RhZdGUXfdx1NdZ9nJbMcyAtvLBgCTaPF
 Lhcx/h+OLI5sQzxEMnZw3vYnCgSVHPLip23ElID7gZRFZh8SEQf3agG9WgRFcagoM0Zy
 HXdtttbrMONpJf6Zp4hxHSkq/CbbqK6tJFNZD331xatnvVfMqdnEBBs5nU7+WAmfztmz
 9i8r4YR4Q+Fl4+XboXliDhQkuyDiuk22uOw80ns3/rm6TyotKrKviSzMMmv1rznHMfeC
 nWsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722584089; x=1723188889;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xSFvSek6plmZmrvCA1HG5Dg7LpMLl1vHSte3aCVpdlQ=;
 b=fGxkaL4y122CNvy1OGBXLSADWuDiSoEypYISH2LY8AXBP/aYcBLQQN1+QWNT61H4st
 en88TOe/x1SPB+p4gkWOHYTTmCQIOscvLf19T4kIGuooZGajSf4dZVAJhr5DKOZFTcjA
 sNoFAVd0GGTDU9ltOBW3le0aQEToIhVRAFJ3QRbhkSLmD4VmojFq2nmZfmIYAXgYiDri
 YYlEAC48g3+1aE+hfsUFUIPg1N7kke64E4o3wHZCeaXRT7JXVh1P3mIQfbEZzUnpDgaz
 9mC/TuAN4ppLXUBrJCxqW6WUiJCnn6XLlUGDhQxIFwys9cWT9PKMCJemLAGRszAcJALh
 C5Fw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVNZZsmReQbxaJo6YvQ77msQjBIb7D2VNe8vX9DUrGMVssWj6q/h2g+dcSlnJavO2zGQBvd813H7xN35Z9Z3h/ZsprJf/0=
X-Gm-Message-State: AOJu0Ywb0MMKq0KCDbjYWOwrPle+rnwZBKDTNF7PewjcHak7kO7LIDft
 L/yjc0ETb0yfVvVUywf759MH76aYEIWtrkz4WrwzOBaRYDcUZc6rIw162/l0Nd6yj5epegKROzM
 D1ncDvRxE/DgWgi/tYbHUnrcwMyA5oEwFMVjHGw==
X-Google-Smtp-Source: AGHT+IHaWgT6aVWYvLNLmqpklcoJE+6O1PmqeUYZYdNi+A7q8aO0e82DqepW6/6ufg+U0ygmns0hQ/qLkRH9M8LdBVg=
X-Received: by 2002:a05:620a:44c4:b0:7a2:ea4:d592 with SMTP id
 af79cd13be357-7a34efe2539mr303448285a.45.1722584088732; Fri, 02 Aug 2024
 00:34:48 -0700 (PDT)
MIME-Version: 1.0
References: <20240802-rsc-v1-1-2b607bd2f555@daynix.com>
In-Reply-To: <20240802-rsc-v1-1-2b607bd2f555@daynix.com>
From: Yuri Benditovich <yuri.benditovich@daynix.com>
Date: Fri, 2 Aug 2024 10:34:37 +0300
Message-ID: <CAOEp5OfRw9DAryCM+Yfe_WceHOfe=A_vxnvZWN2hZBybj5NAeA@mail.gmail.com>
Subject: Re: [PATCH] vhost: Add VIRTIO_NET_F_RSC_EXT to vhost feature bits
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, 
 Jason Wang <jasowang@redhat.com>, Peter Xu <peterx@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, eduardo@habkost.net, marcel.apfelbaum@gmail.com,
 philmd@linaro.org, wangyanan55@huawei.com, dmitry.fleytman@gmail.com, 
 sriram.yagnaraman@ericsson.com, sw@weilnetz.de, yan@daynix.com, 
 Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: none client-ip=2607:f8b0:4864:20::733;
 envelope-from=yuri.benditovich@daynix.com; helo=mail-qk1-x733.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

At the moment kernel (vhost) and vhost user backends do not support
this feature (and IMO they do not need to)
In order to support it they need to implement a) coalescing of
segmented TCP packets and b) population of respective fields in
host-to-guest packets (number of coalesced segments and counter of
duplicated acks)
Just to remind - this feature is intended to be used without vhost and
without migration

Thanks
Yuri

On Fri, Aug 2, 2024 at 8:38=E2=80=AFAM Akihiko Odaki <akihiko.odaki@daynix.=
com> wrote:
>
> VIRTIO_NET_F_RSC_EXT is implemented in the rx data path, which vhost
> implements, so vhost needs to support the feature if it is ever to be
> enabled with vhost. The feature must be disabled otherwise.
>
> Fixes: 2974e916df87 ("virtio-net: support RSC v4/v6 tcp traffic for Windo=
ws HCK")
> Reported-by: Jason Wang <jasowang@redhat.com>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>  hw/net/vhost_net.c | 2 ++
>  net/vhost-vdpa.c   | 1 +
>  2 files changed, 3 insertions(+)
>
> diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
> index a788e6937e03..dedf9ad7c242 100644
> --- a/hw/net/vhost_net.c
> +++ b/hw/net/vhost_net.c
> @@ -50,6 +50,7 @@ static const int kernel_feature_bits[] =3D {
>      VIRTIO_F_RING_RESET,
>      VIRTIO_F_IN_ORDER,
>      VIRTIO_F_NOTIFICATION_DATA,
> +    VIRTIO_NET_F_RSC_EXT,
>      VIRTIO_NET_F_HASH_REPORT,
>      VHOST_INVALID_FEATURE_BIT
>  };
> @@ -81,6 +82,7 @@ static const int user_feature_bits[] =3D {
>      VIRTIO_F_RING_RESET,
>      VIRTIO_F_IN_ORDER,
>      VIRTIO_NET_F_RSS,
> +    VIRTIO_NET_F_RSC_EXT,
>      VIRTIO_NET_F_HASH_REPORT,
>      VIRTIO_NET_F_GUEST_USO4,
>      VIRTIO_NET_F_GUEST_USO6,
> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
> index 03457ead663a..46b02c50be8c 100644
> --- a/net/vhost-vdpa.c
> +++ b/net/vhost-vdpa.c
> @@ -88,6 +88,7 @@ const int vdpa_feature_bits[] =3D {
>      VIRTIO_NET_F_MQ,
>      VIRTIO_NET_F_MRG_RXBUF,
>      VIRTIO_NET_F_MTU,
> +    VIRTIO_NET_F_RSC_EXT,
>      VIRTIO_NET_F_RSS,
>      VIRTIO_NET_F_STATUS,
>      VIRTIO_RING_F_EVENT_IDX,
>
> ---
> base-commit: 31669121a01a14732f57c49400bc239cf9fd505f
> change-id: 20240802-rsc-e90fb452bd7f
>
> Best regards,
> --
> Akihiko Odaki <akihiko.odaki@daynix.com>
>

