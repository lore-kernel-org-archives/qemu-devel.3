Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D53C0D29FF8
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Jan 2026 12:27:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfzxO-000300-KT; Wed, 14 Jan 2026 07:26:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vfzxH-0002v8-P9
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 07:26:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vfzxG-0000iW-5y
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 07:26:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768393589;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3W1TBgpVWgkAGfz0fTl0gxUhHHatXchW+EtU/acZiK8=;
 b=HAI43HiPoIVs7IjsfWaBzEVyYJd94FMdQRRb6YZ7E98LjpNv36OEqAmaVtr8vND7Tb2v5D
 4ty0/qLvtolxUY1MQa4YzNkDIG8wS56Tg5WKpnqlpS/LgtcMTBPhNDCJxhGYzEJD63conu
 ncyEiAYDHSeCHdwfXaGYQGlRsj2C7uE=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-269-CGgum6RrMOi9PzcqodwbBw-1; Wed, 14 Jan 2026 07:26:28 -0500
X-MC-Unique: CGgum6RrMOi9PzcqodwbBw-1
X-Mimecast-MFC-AGG-ID: CGgum6RrMOi9PzcqodwbBw_1768393587
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-8c530da0691so135281385a.3
 for <qemu-devel@nongnu.org>; Wed, 14 Jan 2026 04:26:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768393587; x=1768998387; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=3W1TBgpVWgkAGfz0fTl0gxUhHHatXchW+EtU/acZiK8=;
 b=cNSAh6/Ik5mW5CxsMEJLIob+FsllirvhbSCutgKXalFLAEEWJzpZiERuOui6L4Kcau
 TlrUsvndmW1/OA3mujVJKsFNmmEwwB+yvmxCiR65q8vlY6GysaEq5MbSyAAppSdGLux9
 8uibLkPjIWRaUdVmhF25UUtD8Kq9KXelXsZ2aADqaIOYxMym2KT/4Mtduep7TzCC7sNS
 vOtbYydKbrL1rA4eAWfu5/sylIEeqbCLgD8dwqc6fa69LcEAWROivU6QjKAvfgmyq0J4
 d7DZNQ50hkXxvZPEepQSvzbHxJy0GtXbZWvDQek2RdEcrhdcYpMdyRgjy3s4AUJkeHsA
 IvaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768393587; x=1768998387;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3W1TBgpVWgkAGfz0fTl0gxUhHHatXchW+EtU/acZiK8=;
 b=QNnA+1A6qJ5P2gqlNEasRQcVIdtfLctVciz1T9yTapa+5C3+2/utNOCnQcZb2Yk9+a
 7Kh0cyUbVNhA4CspJfqhF3S/PM7Vv8Evz2eGHOrxUrL9d8kh2s7Jz4wg8f+3Irf5kTLD
 EOfoyA+5qC6IJeBhSCkhuJtepLfb2P6uwSMPdCJBaBPeah0OJkaFDVUlvA1nTWr/rKU4
 6IGKBgSC59Jb89C++kLacta98p8i3ahwGT4SwVetytqze2POMyL4fA+4PN5yVDCwNAkP
 bT4bZFte+GqefRluGQGYR6gq6/1kMFGPpj365L0ZOwFNgk655ozNOV5i4OEk6NIhj6lX
 f9eg==
X-Gm-Message-State: AOJu0YzStWIek1U9MJTRA0ylxBXuWgZLMwVym9v3OAx+kRmSMLLL+FA4
 PNoFRmbRr1Fsm+RqkfgVBANCfFj/PnEJNTfNBB1qNfrOyCdwatQu2Kl3yzZdzX0Fro7PHLYybYP
 VQmlGNuIRLeZPHlAcJrRmGHj7ocnCAuHPe6oE7Epb3AXhfX+gDZTANLaD
X-Gm-Gg: AY/fxX4PezdiXMR511jNQ3hBcucKW+MpqjPstnKZ/1l/geJHAsfxzKExAwS6eE6SXkT
 Gb5YsR2VG7ydncs7c36Tbm7emEaKHbxIe/DKGASKMWTeUSzzhhlJnHk/ABU0vfeOSK338F0uhhL
 hjW4jQpe98DvmZP0kDDnRUWd+9Kc1dL1px+AWvCl4WwOHxzVBmBTmlh22LTt3sysBk/z8SuX370
 PlnzToQpMJeMLq7wnOkmmVSGmJnwcix24WVaN4H1mF4QTpCD0vr5AA/GbJZ+QURf52GjdBNu4hq
 vOU7NnrUYBuDTORP467Ar/j+HTdYCDMkJWJ0Kf1Tjt0EXOxcUBDQUTJzivmEkNaRG0Gz+3DSGGW
 Qxhs=
X-Received: by 2002:a05:620a:400d:b0:8b2:f145:7f28 with SMTP id
 af79cd13be357-8c52fb1d058mr307023385a.33.1768393587406; 
 Wed, 14 Jan 2026 04:26:27 -0800 (PST)
X-Received: by 2002:a05:620a:400d:b0:8b2:f145:7f28 with SMTP id
 af79cd13be357-8c52fb1d058mr307019485a.33.1768393586882; 
 Wed, 14 Jan 2026 04:26:26 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8c530ba54b8sm152072785a.42.2026.01.14.04.26.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Jan 2026 04:26:26 -0800 (PST)
Date: Wed, 14 Jan 2026 07:26:24 -0500
From: Peter Xu <peterx@redhat.com>
To: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
Cc: qemu-devel@nongnu.org, "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 Zhenwei Pi <pizhenwei@bytedance.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Raphael Norwitz <raphael@enfabrica.net>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, mzamazal@redhat.com,
 Fabiano Rosas <farosas@suse.de>, qemu-block@nongnu.org,
 virtio-fs@lists.linux.dev,
 "yc-core@yandex-team.ru" <yc-core@yandex-team.ru>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v6 5/5] vhost-user-blk: support inter-host inflight
 migration
Message-ID: <aWeLcDtZyRpk81W6@x1.local>
References: <20260113095813.134810-1-dtalexundeer@yandex-team.ru>
 <20260113095813.134810-6-dtalexundeer@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260113095813.134810-6-dtalexundeer@yandex-team.ru>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Tue, Jan 13, 2026 at 02:58:19PM +0500, Alexandr Moshkov wrote:
> During inter-host migration, waiting for disk requests to be drained
> in the vhost-user backend can incur significant downtime.
> 
> This can be avoided if QEMU migrates the inflight region in
> vhost-user-blk.
> Thus, during the qemu migration, with feature flag the vhost-user
> back-end can immediately stop vrings, so all in-flight requests will be
> migrated to another host.
> 
> Signed-off-by: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
> ---
>  hw/block/vhost-user-blk.c          | 28 ++++++++++++++++++++++++++++
>  include/hw/virtio/vhost-user-blk.h |  1 +
>  2 files changed, 29 insertions(+)
> 
> diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
> index a8fd90480a..9093e98841 100644
> --- a/hw/block/vhost-user-blk.c
> +++ b/hw/block/vhost-user-blk.c
> @@ -377,6 +377,7 @@ static int vhost_user_blk_init(DeviceState *dev, bool connect, Error **errp)
>      vhost_dev_set_config_notifier(&s->dev, &blk_ops);
>  
>      s->vhost_user.supports_config = true;
> +    s->vhost_user.supports_inflight_migration = s->inflight_migration;
>      ret = vhost_dev_init(&s->dev, &s->vhost_user, VHOST_BACKEND_TYPE_USER, 0,
>                           false, errp);
>      if (ret < 0) {
> @@ -656,6 +657,27 @@ static struct vhost_dev *vhost_user_blk_get_vhost(VirtIODevice *vdev)
>      return &s->dev;
>  }
>  
> +static bool vhost_user_blk_inflight_needed(void *opaque)
> +{
> +    struct VHostUserBlk *s = opaque;
> +
> +    bool inflight_migration = vhost_dev_has_feature(&s->dev,
> +                        VHOST_USER_PROTOCOL_F_GET_VRING_BASE_INFLIGHT);
> +
> +    return inflight_migration &&
> +           !migrate_local_vhost_user_blk();

Here's the spot that should depend on migrate_local_vhost_user_blk() from
Vladimilr's RFC patch (again, likely to be renamed..).

Btw, is this check correct against "!migrate_local_vhost_user_blk()"?  I
was expecting the feature off only if local=on, so I expect it to be:

       return inflight_migration && migrate_local_vhost_user_blk();

?

> +}
> +
> +static const VMStateDescription vmstate_vhost_user_blk_inflight = {
> +    .name = "vhost-user-blk/inflight",
> +    .version_id = 1,
> +    .needed = vhost_user_blk_inflight_needed,
> +    .fields = (const VMStateField[]) {
> +        VMSTATE_VHOST_INFLIGHT_REGION(inflight, VHostUserBlk),

One other trivial nitpick while glimpsing over the patch: should we move
the macro definition from previous patch to this one, where it is used?

> +        VMSTATE_END_OF_LIST()
> +    },
> +};
> +
>  static bool vhost_user_blk_pre_incoming(void *opaque, Error **errp)
>  {
>      VHostUserBlk *s = VHOST_USER_BLK(opaque);
> @@ -678,6 +700,10 @@ static const VMStateDescription vmstate_vhost_user_blk = {
>          VMSTATE_VIRTIO_DEVICE,
>          VMSTATE_END_OF_LIST()
>      },
> +    .subsections = (const VMStateDescription * const []) {
> +        &vmstate_vhost_user_blk_inflight,
> +        NULL
> +    }
>  };
>  
>  static bool vhost_user_needed(void *opaque)
> @@ -751,6 +777,8 @@ static const Property vhost_user_blk_properties[] = {
>                        VIRTIO_BLK_F_WRITE_ZEROES, true),
>      DEFINE_PROP_BOOL("skip-get-vring-base-on-force-shutdown", VHostUserBlk,
>                       skip_get_vring_base_on_force_shutdown, false),
> +    DEFINE_PROP_BOOL("inflight-migration", VHostUserBlk,
> +                     inflight_migration, false),
>  };
>  
>  static void vhost_user_blk_class_init(ObjectClass *klass, const void *data)
> diff --git a/include/hw/virtio/vhost-user-blk.h b/include/hw/virtio/vhost-user-blk.h
> index b06f55fd6f..e1466e5cf6 100644
> --- a/include/hw/virtio/vhost-user-blk.h
> +++ b/include/hw/virtio/vhost-user-blk.h
> @@ -52,6 +52,7 @@ struct VHostUserBlk {
>      bool started_vu;
>  
>      bool skip_get_vring_base_on_force_shutdown;
> +    bool inflight_migration;
>  
>      bool incoming_backend;
>  };
> -- 
> 2.34.1
> 

-- 
Peter Xu


