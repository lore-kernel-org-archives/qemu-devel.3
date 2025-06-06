Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED723C5B555
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Jun 2025 13:34:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNXCV-00036q-CZ; Fri, 06 Jun 2025 09:33:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uNXCS-00032P-KJ
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 09:33:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uNXCL-00043t-8q
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 09:33:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749216805;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0keCZ9QPpmhiB8UXi8ytnZY3tXCCSEg46DvrrRqB83E=;
 b=i1tdSMAzNlJsGV0uKRqB931K0UkTOip52mU+k8JV3SH4hpTkQ3sXnWxX4lMNIX+naw+1Ba
 karbmjfPnVMJ/tToz9QqzV0XqnhK6s/YFzsYNedQqtWbvcPDMIUog/pp90KAQenISTyPtM
 83Q+gaLs+ylQ/GLVoAFYQEx2j/ThB5Q=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-252-eeos0e9DNUOV_l8AX0fBWA-1; Fri, 06 Jun 2025 09:33:23 -0400
X-MC-Unique: eeos0e9DNUOV_l8AX0fBWA-1
X-Mimecast-MFC-AGG-ID: eeos0e9DNUOV_l8AX0fBWA_1749216802
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-451d7de4ae3so13788805e9.2
 for <qemu-devel@nongnu.org>; Fri, 06 Jun 2025 06:33:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749216802; x=1749821602;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0keCZ9QPpmhiB8UXi8ytnZY3tXCCSEg46DvrrRqB83E=;
 b=vcFW/Nbg1PwbBvh/bUTxcZIrh4UrtGlZzGGOjmKRU+02AtfDq+z7Ze8c/bvN6gtrh2
 6jaLPZIrpi4Eg1ZxM7czS1VXNGylfRpWT6SFFG1Mo7M+aTixsvb7clMCpVGU6LG0Zvje
 UL9WY0lBodHAAXiYtgmPN0I0QkkD4YvzREcYyY31BM40JqZ/hcUDNMmSLBBgrUnpmlrs
 q1s6r8Ulmi6071ow5m/o1SBTKVn8+92Wgh4n84yV+OQponfy80trArSqOAf/aTREP5EF
 BkutSwyRQTq1cqdCk6JKugVpDsLM1NAENC+TVkpiK4pfFN4bHtuuVS2Zhr1XFUTGvhYH
 S1EA==
X-Gm-Message-State: AOJu0Yygs/2SP/7z/Hi9LhOOV2AroSZynaHDjYVhr+qZ/PegNZURzZkN
 C3+g8HZjFbX28tAbh/qBwcuI0jjHQwpwFqH8DgvCZTBRZqyezSD3RSPOrq0dCfXxBwh9189rZov
 yep4KvsbK0MkXHQTHNFX70QU8LTdOuny76Z8EWNQKQWHpg4j2JpSA1tLo
X-Gm-Gg: ASbGncs2kqKUdeTrc6PENFCxVDTTbZ/ZUpKuMfJ1w5drgAC3kcgVxAAYJQ61efQLl8k
 g+87RSMvi8RLvH7gyc2Yz0mAuHboxNGhPrWH9JQAZM8Ci1UT5j0AbWO2SbaRQmuvgEvsrC58uha
 ERR2Hh8w0yyqu4svZICKMITRpSZZBNKf7LiLApePS/7ePps/jB4GzrnwWEKzD3Q125FqW5DM4ie
 D7Vxqxz7ewl4JhxX7bLMkJkwmHnmGrqcmJOYI3yvZl535AZgwyWes1hDP5HaTfFSYzvQ6oGKY/I
 TmbXoSCf6aTaiCP3TiSg+unW33JJDGHA
X-Received: by 2002:a05:600c:c163:b0:43c:fd27:a216 with SMTP id
 5b1f17b1804b1-452fa7ed515mr15929255e9.23.1749216802098; 
 Fri, 06 Jun 2025 06:33:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFjxOX6WigG+14PIXGGAlvOp/hOqUJNdprun6Lc6UkRpgJMNqt013y+hPA/GDAYkEXrgzZaRA==
X-Received: by 2002:a05:600c:c163:b0:43c:fd27:a216 with SMTP id
 5b1f17b1804b1-452fa7ed515mr15928945e9.23.1749216801646; 
 Fri, 06 Jun 2025 06:33:21 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com ([85.93.96.130])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-452730b9beasm21266245e9.22.2025.06.06.06.33.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Jun 2025 06:33:21 -0700 (PDT)
Date: Fri, 6 Jun 2025 15:33:20 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, =?UTF-8?B?Q2zDqW1lbnQ=?= Mathieu--Drif
 <clement.mathieu--drif@eviden.com>, Zhao Liu <zhao1.liu@intel.com>, Hanna
 Reitz <hreitz@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 qemu-block@nongnu.org, Jason Wang <jasowang@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, Yanan Wang <wangyanan55@huawei.com>, Ani
 Sinha <anisinha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Thomas
 Huth <thuth@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Kevin Wolf
 <kwolf@redhat.com>, Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH 16/18] hw/net/virtio-net: Remove
 VirtIONet::mtu_bypass_backend field
Message-ID: <20250606153320.0ea64de4@imammedo.users.ipa.redhat.com>
In-Reply-To: <20250501210456.89071-17-philmd@linaro.org>
References: <20250501210456.89071-1-philmd@linaro.org>
 <20250501210456.89071-17-philmd@linaro.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.104,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu,  1 May 2025 23:04:54 +0200
Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> wrote:

> The VirtIONet::mtu_bypass_backend boolean was only set in
> the hw_compat_2_9[] array, via the 'x-mtu-bypass-backend=3Doff'
> property. We removed all machines using that array, lets remove
> that property and all the code around it.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

>  include/hw/virtio/virtio-net.h | 1 -
>  hw/net/virtio-net.c            | 8 ++------
>  2 files changed, 2 insertions(+), 7 deletions(-)
>=20
> diff --git a/include/hw/virtio/virtio-net.h b/include/hw/virtio/virtio-ne=
t.h
> index b9ea9e824e3..353e872f677 100644
> --- a/include/hw/virtio/virtio-net.h
> +++ b/include/hw/virtio/virtio-net.h
> @@ -214,7 +214,6 @@ struct VirtIONet {
>      uint64_t saved_guest_offloads;
>      AnnounceTimer announce_timer;
>      bool needs_vnet_hdr_swap;
> -    bool mtu_bypass_backend;
>      /* primary failover device is hidden*/
>      bool failover_primary_hidden;
>      bool failover;
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index 2de037c2736..a8a43ffa242 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -801,8 +801,7 @@ static uint64_t virtio_net_get_features(VirtIODevice =
*vdev, uint64_t features,
>      features =3D vhost_net_get_features(get_vhost_net(nc->peer), feature=
s);
>      vdev->backend_features =3D features;
> =20
> -    if (n->mtu_bypass_backend &&
> -            (n->host_features & 1ULL << VIRTIO_NET_F_MTU)) {
> +    if (n->host_features & (1ULL << VIRTIO_NET_F_MTU)) {
>          features |=3D (1ULL << VIRTIO_NET_F_MTU);
>      }
> =20
> @@ -953,8 +952,7 @@ static void virtio_net_set_features(VirtIODevice *vde=
v, uint64_t features)
>      Error *err =3D NULL;
>      int i;
> =20
> -    if (n->mtu_bypass_backend &&
> -            !virtio_has_feature(vdev->backend_features, VIRTIO_NET_F_MTU=
)) {
> +    if (!virtio_has_feature(vdev->backend_features, VIRTIO_NET_F_MTU)) {
>          features &=3D ~(1ULL << VIRTIO_NET_F_MTU);
>      }
> =20
> @@ -4121,8 +4119,6 @@ static const Property virtio_net_properties[] =3D {
>      DEFINE_PROP_UINT16("tx_queue_size", VirtIONet, net_conf.tx_queue_siz=
e,
>                         VIRTIO_NET_TX_QUEUE_DEFAULT_SIZE),
>      DEFINE_PROP_UINT16("host_mtu", VirtIONet, net_conf.mtu, 0),
> -    DEFINE_PROP_BOOL("x-mtu-bypass-backend", VirtIONet, mtu_bypass_backe=
nd,
> -                     true),
>      DEFINE_PROP_INT32("speed", VirtIONet, net_conf.speed, SPEED_UNKNOWN),
>      DEFINE_PROP_STRING("duplex", VirtIONet, net_conf.duplex_str),
>      DEFINE_PROP_BOOL("failover", VirtIONet, failover, false),


