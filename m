Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B004C54764
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 09:46:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rc0ED-0003hr-3R; Mon, 19 Feb 2024 04:46:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rc0EB-0003he-4L
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 04:46:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rc0E7-0007HF-5c
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 04:46:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708335977;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pMcHm6I0ZZNbfrBy0YGA7QZmf6YfURA5a09nYsH9Ih0=;
 b=SQA2rQbuPJniRq/iL2vvqTXWJ8l+aCGS4A99f457OMTTIZPsvu5Tp+w/3DbRSroMnkZ5qc
 aNjb2B0VZZ7kU9+fD7U7eWQIZ1AxO2ei98pJxvkBijwUfXTpdckQPMPId2ic6gRJVI+UgS
 S/ivwT7n/AhQhJi7SDgV37OolqmKq1I=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-NsbJ1dd1MPiMGY0pYxV4Ig-1; Mon, 19 Feb 2024 04:46:16 -0500
X-MC-Unique: NsbJ1dd1MPiMGY0pYxV4Ig-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-33cf68241c8so1380990f8f.1
 for <qemu-devel@nongnu.org>; Mon, 19 Feb 2024 01:46:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708335975; x=1708940775;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pMcHm6I0ZZNbfrBy0YGA7QZmf6YfURA5a09nYsH9Ih0=;
 b=CuOCPtYkNsDjCu/PF9YXJK8SwTOHPEQJZkZQUO0GD1yM2wFKU4ksNmFwj1WWpP+ty1
 vqyXoyx6utERGDZYyWnZx3k6rvykb7czlmBPUw/wzRw4EtGT4csMWyOScTUusmm7XqrJ
 YEEThlSPhE3PnuH6NlgOiGzbeah4wNS9c54wQ9dXWDbSrj0LuWRxmV1ARYZJmyLhY752
 nCZuqVXUBtELGWzKCWaEZ5zdjjim92QE+lcFRm6AjXH39MN98dZ1SWaIEwJgIbEFv0+e
 VgEB4rswQFgDlNKJVLX3VhHu9T5+eXnzOtQxaD1zJmryt4LmR/mSACoDlrMGAI9KuD6j
 Aobg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXsj2ZAIUdbVOKQ707D5mIQq0jFu+pUo6AibIXbK8MCa1jKI1Pu6oHs5vZbzwJi4ih0XegXfGhp++1R75LoGbZBufrLebo=
X-Gm-Message-State: AOJu0YwvAcy3ODPjogRHWUsJFF8Rbl0sFtlUFyGlXPrPEal7nznUm8Cm
 TXPT8/Q+6ARGfs6GCEGz8zezLklFE3DA+gxRuWLz7GC8STSRArYBe4IO7EqVUB0lowMd2xKr/Ee
 vtpLtwVqdg2jKw+NQGj4HbO5p2MrAeJtXdpdk0WYASxN7gETXDG4V
X-Received: by 2002:adf:fe0b:0:b0:33d:1d45:60a3 with SMTP id
 n11-20020adffe0b000000b0033d1d4560a3mr4371607wrr.44.1708335974921; 
 Mon, 19 Feb 2024 01:46:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFYiNVpKXS9I/yHFvj5OKto4kwQwA0OG/HV+W2oGbJSMrbGiU1Plc9SMlUHWNpnet5ZoSgCnw==
X-Received: by 2002:adf:fe0b:0:b0:33d:1d45:60a3 with SMTP id
 n11-20020adffe0b000000b0033d1d4560a3mr4371593wrr.44.1708335974561; 
 Mon, 19 Feb 2024 01:46:14 -0800 (PST)
Received: from redhat.com ([2.52.19.211]) by smtp.gmail.com with ESMTPSA id
 bs20-20020a056000071400b0033d449f5f65sm4056888wrb.4.2024.02.19.01.46.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Feb 2024 01:46:13 -0800 (PST)
Date: Mon, 19 Feb 2024 04:46:10 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Srujana Challa <schalla@marvell.com>
Cc: Vamsi Krishna Attunuru <vattunuru@marvell.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Jerin Jacob <jerinj@marvell.com>, Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH] vhost_net: add NOTIFICATION_DATA and IN_ORDER feature
 bits to vdpa_feature_bits
Message-ID: <20240219044542-mutt-send-email-mst@kernel.org>
References: <20240102111432.36817-1-schalla@marvell.com>
 <SJ0PR18MB52465C8395C6DE0A1BF557E4A67C2@SJ0PR18MB5246.namprd18.prod.outlook.com>
 <DS0PR18MB53687B6AEF7B64E24EE25911A0512@DS0PR18MB5368.namprd18.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DS0PR18MB53687B6AEF7B64E24EE25911A0512@DS0PR18MB5368.namprd18.prod.outlook.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.077,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Sorry this got tagged for Linux by mistake.
Replied now.

On Mon, Feb 19, 2024 at 09:38:46AM +0000, Srujana Challa wrote:
> Ping.
> 
> > Subject: RE: [PATCH] vhost_net: add NOTIFICATION_DATA and IN_ORDER
> > feature bits to vdpa_feature_bits
> > 
> > Hi Michael,
> > 
> > Can you review this feature support patch, appreciate your review and
> > comments.
> > 
> > Patch considers all feature bits supported by vhost net client type as part of
> > feature negotiation to address the concerns raised in below thread.
> > https://patchew.org/QEMU/1533833677-27512-1-git-send-email-
> > i.maximets@samsung.com/
> > 
> > Regards
> > Vamsi
> > 
> > > -----Original Message-----
> > > From: Srujana Challa <schalla@marvell.com>
> > > Sent: Tuesday, January 2, 2024 4:45 PM
> > > To: qemu-devel@nongnu.org
> > > Cc: mst@redhat.com; Vamsi Krishna Attunuru <vattunuru@marvell.com>;
> > > Jerin Jacob Kollanukkaran <jerinj@marvell.com>
> > > Subject: [PATCH] vhost_net: add NOTIFICATION_DATA and IN_ORDER
> > feature
> > > bits to vdpa_feature_bits
> > >
> > > Enables VIRTIO_F_NOTIFICATION_DATA and VIRTIO_F_IN_ORDER feature
> > bits
> > > for vhost vdpa backend. Also adds code to consider all feature bits
> > > supported by vhost net client type for feature negotiation, so that
> > > vhost backend device supported features can be negotiated with guest.
> > >
> > > Signed-off-by: Srujana Challa <schalla@marvell.com>
> > > ---
> > >  hw/net/vhost_net.c | 10 ++++++++++
> > >  net/vhost-vdpa.c   |  2 ++
> > >  2 files changed, 12 insertions(+)
> > >
> > > diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c index
> > > e8e1661646..65ae8bcece 100644
> > > --- a/hw/net/vhost_net.c
> > > +++ b/hw/net/vhost_net.c
> > > @@ -117,6 +117,16 @@ static const int
> > > *vhost_net_get_feature_bits(struct
> > > vhost_net *net)
> > >
> > >  uint64_t vhost_net_get_features(struct vhost_net *net, uint64_t
> > > features) {
> > > +    const int *bit = vhost_net_get_feature_bits(net);
> > > +
> > > +    /*
> > > +     * Consider all feature bits for feature negotiation with vhost backend,
> > > +     * so that all backend device supported features can be negotiated.
> > > +     */
> > > +    while (*bit != VHOST_INVALID_FEATURE_BIT) {
> > > +        features |= (1ULL << *bit);
> > > +        bit++;
> > > +    }
> > >      return vhost_get_features(&net->dev, vhost_net_get_feature_bits(net),
> > >              features);
> > >  }
> > > diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c index
> > > 3726ee5d67..51334fcfe2 100644
> > > --- a/net/vhost-vdpa.c
> > > +++ b/net/vhost-vdpa.c
> > > @@ -57,7 +57,9 @@ typedef struct VhostVDPAState {
> > >   */
> > >  const int vdpa_feature_bits[] = {
> > >      VIRTIO_F_ANY_LAYOUT,
> > > +    VIRTIO_F_IN_ORDER,
> > >      VIRTIO_F_IOMMU_PLATFORM,
> > > +    VIRTIO_F_NOTIFICATION_DATA,
> > >      VIRTIO_F_NOTIFY_ON_EMPTY,
> > >      VIRTIO_F_RING_PACKED,
> > >      VIRTIO_F_RING_RESET,
> > > --
> > > 2.25.1


