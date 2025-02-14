Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24932C02198
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2025 17:00:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiz2c-0007za-V1; Fri, 14 Feb 2025 11:59:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mvaralar@redhat.com>)
 id 1tiz2c-0007zQ-18
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 11:59:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mvaralar@redhat.com>)
 id 1tiz2a-0006OO-14
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 11:59:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739552386;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FJWotqOrBzucrLQ6Z8AqPGvMTzVocaRJz8yN2kVcxx8=;
 b=Dkxc8JhLPgV+31BZsYMyjhEyU89yq8sMkmgM23AsEqrfU1ibh+yMceMtND/evMqt/oGVI6
 whJMF53Obcp6Vq3lYuwwqHyy+9fuvO3Zlxsb+1sKboB8LuMsnsjlrr+H4HhfxWJArUXNU4
 Hz8KZrfr6uaHBywPK6wsR6jDEkn6bBk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-75-UVSiKyrNOyWnM4JQk8vJjw-1; Fri, 14 Feb 2025 11:59:44 -0500
X-MC-Unique: UVSiKyrNOyWnM4JQk8vJjw-1
X-Mimecast-MFC-AGG-ID: UVSiKyrNOyWnM4JQk8vJjw_1739552384
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4396260f74fso14107235e9.1
 for <qemu-devel@nongnu.org>; Fri, 14 Feb 2025 08:59:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739552384; x=1740157184;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FJWotqOrBzucrLQ6Z8AqPGvMTzVocaRJz8yN2kVcxx8=;
 b=s4IDfrQwRrKOSY5I9pyRC9FCaZCKgC8R+4C2wFrSTSK1BRMCchhF8wlJREbA/svO0G
 qUbAKGP4vs1MYr5LmLB0LTyQsUfis+lkqZ5aeScmFEf0L24u9a+Px5KYbxt9xlz8xM4E
 nW0AR0n4eejRx3i3gafh1i5nJ058UtPquzZfdCwvt5ErMLz4pCJ5K2bna2wGnzCTKAwL
 vJMvsiRFrrIrxaY+Hx+TM55K6KJuLIWtT0CvHjxTxpfQqDp/HTKefKpEifieZOG3LOu1
 /GDj/yK2NuLZjd/uiLkzT64mfwEmvEQwzU131bhGSwdmlEctGBQCv5eYfrnRiFlESZA9
 Gtsg==
X-Gm-Message-State: AOJu0YycS41J8aiYt0eNdTVL1N4IRAuJhpVxI0eYUt3mPdvK7TkAON2U
 +3SQJlWNdLsZypoPOjac10SWpqQGv+TsAAXluJMJRJh4AFCLu81mTHTfQI/E4v7dlmr2zvHad/f
 Q2jv1HhoKTmRj1lNJej7Xc3PLKxS19D4MhcIO94rzX5yujUv6Y8bw
X-Gm-Gg: ASbGncvv2LMmEpubuu2WOak1KCZ1s4gHi8Y4ucNGJbUu/SikYfbDyLTBOEMR8Mpdcne
 FVTkOhLKFJtJb3+Y6Xd3Qm4VRW8P9z6eBgqXqhODjnmfUrcIalvm66wUseUpmDjsgeZ1OyQRO3J
 cHMhORhtabs2zFA5UjOB6O7BMS9QrN5dSyUbQrwLQ6/1BJmDLktpP+YaS8D+6LsZMNCGfGb6StH
 ZJbDO7URa37usi8Y9BmnJzLl3mdq9WVpUsJZ5U/SauPbZMiJELpe8cvx2BpqWzBU2kFJbMK
X-Received: by 2002:a05:600c:458b:b0:439:6dba:addb with SMTP id
 5b1f17b1804b1-4396dbaaffemr11856115e9.7.1739552383600; 
 Fri, 14 Feb 2025 08:59:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGF3YZerXaEnAZuBpalcgsXMOnzq8xj8fY+X2oELsiIje3WK6qco7Qguwt69JfIoCkSLhi2BQ==
X-Received: by 2002:a05:600c:458b:b0:439:6dba:addb with SMTP id
 5b1f17b1804b1-4396dbaaffemr11855765e9.7.1739552383236; 
 Fri, 14 Feb 2025 08:59:43 -0800 (PST)
Received: from fedora ([37.166.73.236]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4395a1aa779sm79614715e9.30.2025.02.14.08.59.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Feb 2025 08:59:42 -0800 (PST)
Date: Fri, 14 Feb 2025 17:59:02 +0100
From: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: Re: [PATCH] vhost-user-snd: Use virtio_get_config_size()
Message-ID: <Z692Vg6N3Hth3GyH@fedora>
References: <20250213132513.767709-1-mvaralar@redhat.com>
 <z2bfkwpwfohvmj6xesdm2zmatlcwxta4aexq6x543lpnt47333@ayqfx3yxs5eb>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <z2bfkwpwfohvmj6xesdm2zmatlcwxta4aexq6x543lpnt47333@ayqfx3yxs5eb>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mvaralar@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.732,
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

On Thu, Feb 13, 2025 at 04:31:41PM +0100, Stefano Garzarella wrote:
> For the title, what about this?
> 
>   vhost-user-snd: fix incorrect config_size computation
> 
> Or something like that, just to make clear that we are fixing a
> real issue.
> 
> On Thu, Feb 13, 2025 at 02:25:13PM +0100, Matias Ezequiel Vara Larsen wrote:
> > Use virtio_get_config_size() rather than sizeof(struct
> > virtio_snd_config) for the config_size in the vhost-user-snd frontend.
> > The frontend shall rely on device features for the size of the device
> > configuration space. This fixes an issue introduced by commit ab0c7fb2
> 
> When we refer to a commit it's a good practice to put both the sha1, but
> also the title, like this:
> This fixes an issue introduced by commit ab0c7fb22b ("linux-headers:
> update to current kvm/next") ...
> 
> > in which the optional field `control` is added to the virtio_snd_config
> 
> s/control/controls
> 
> I would also specify here that the presence of `controls` in the config
> space depends on VIRTIO_SND_F_CTLS, citing the specification:
> 
> 5.14.4 Device Configuration Layout
>  ...
>  controls
>     (driver-read-only) indicates a total number of all available control
>     elements if VIRTIO_SND_F_CTLS has been negotiated.
> 
> > structure. This breaks vhost-user-device backends that do not implement
> > the `controls` field.
> > 
> 
> I'd suggest to add the fixes tag:
> 
> Fixes: ab0c7fb22b ("linux-headers: update to current kvm/next")
> 
> And maybe also:
> 
> Cc: qemu-stable@nongnu.org
> 
> > Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2805
> > Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
> > Signed-off-by: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
> > ---
> > hw/virtio/vhost-user-snd.c | 18 +++++++++++++++++-
> > 1 file changed, 17 insertions(+), 1 deletion(-)
> > 
> > diff --git a/hw/virtio/vhost-user-snd.c b/hw/virtio/vhost-user-snd.c
> > index 8610370af8..8da4309470 100644
> > --- a/hw/virtio/vhost-user-snd.c
> > +++ b/hw/virtio/vhost-user-snd.c
> > @@ -16,6 +16,18 @@
> > #include "standard-headers/linux/virtio_ids.h"
> > #include "standard-headers/linux/virtio_snd.h"
> > 
> > +static const VirtIOFeature feature_sizes[] = {
> > +    {.flags = 1ULL << VIRTIO_SND_F_CTLS,
> > +    .end = endof(struct virtio_snd_config, controls)},
> > +    {}
> > +};
> > +
> > +static const VirtIOConfigSizeParams cfg_size_params = {
> > +    .min_size = endof(struct virtio_snd_config, chmaps),
> > +    .max_size = sizeof(struct virtio_snd_config),
> > +    .feature_sizes = feature_sizes
> > +};
> > +
> > static const VMStateDescription vu_snd_vmstate = {
> >     .name = "vhost-user-snd",
> >     .unmigratable = 1,
> > @@ -23,16 +35,20 @@ static const VMStateDescription vu_snd_vmstate = {
> > 
> > static const Property vsnd_properties[] = {
> >     DEFINE_PROP_CHR("chardev", VHostUserBase, chardev),
> > +    DEFINE_PROP_BIT64("config-controls", VHostUserBase,
> 
> In almost all other virtio/vhost-user devices, the property name does not
> have the prefix `config-`, but usually the thing after F_, in this case CTLS
> is cryptic, so IMO just `controls` should be fine.
> 
> The only example I found is `config-wce` for vhost-user-blk, but in that
> case the feature is actually called VIRTIO_BLK_F_CONFIG_WCE.
> 

Thanks for the review. I will address all the comments in the next
version.

Matias


