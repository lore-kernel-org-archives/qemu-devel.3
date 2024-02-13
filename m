Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 461F2C4829A
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 11:07:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZqdM-00019I-Ja; Tue, 13 Feb 2024 06:07:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rZqdL-00011f-9X
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 06:07:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rZqdJ-0007ZH-M3
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 06:07:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707822444;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ASyIKhSA4StI4MoNK8wEtVUg822eLHNPBDgnBO1FArQ=;
 b=h87yuZzw4dlQqctiVbmL5viGWA0S8hnFUrfyrplSuVW1ZQZw144cmvsyjL/Mf7cla5Gful
 OhJ/QES5PG32UikfXauuVVIux7oWNq7VdrWyPzmWktkGCiYUKEMMmEwL6nIqPoiIRxCXuo
 /n2JdCbSN0LCoXu501Ev88uYlEwWg5Y=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-8-kV_vhKHJMGWiEFlvY25n6g-1; Tue, 13 Feb 2024 06:07:23 -0500
X-MC-Unique: kV_vhKHJMGWiEFlvY25n6g-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-560127ce17fso2146294a12.0
 for <qemu-devel@nongnu.org>; Tue, 13 Feb 2024 03:07:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707822442; x=1708427242;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ASyIKhSA4StI4MoNK8wEtVUg822eLHNPBDgnBO1FArQ=;
 b=IQQaNdL/KCW39HoiyM7gVhBqMPsnDsD8J6lX2Zi5Zl18WpTscMVs1Nz6XjZC8Bniff
 cLS+q2lJxzHbVsviCFeh73eVjrE5ZOsm4YAg3vj2CrpV0o7gfnUFRP1AbC0NUjQHIGl8
 GWHNOXg3qQSvamrAj4YEnh6B1s8XZndBmfDS3uR24qMGGiFo/rJLvzFyeXcxAzd390dK
 x0seJKBEZsuZQnDdXHc1oEpkv2sHvCOdEgBWeTGOuDRexTVPlhlsgNP74+Cmpfa/Mc+l
 DDLokjHdzaEohvgX4TXqmPfhMgkox5RPeA6xWWLrJM5MkCVh9/iC16aBtU4JR5Yg5jXm
 FCNQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV+lk7dHGPu7vWJ7M4dIJ6cyBWLOiphIBAAyuyQUIgHVRv4Q9fyyHxvVTTozwjgSEx7RULb0SylGwv78FQJOjJgh92wmCI=
X-Gm-Message-State: AOJu0YzWqFr4cxtyFdBpZ5XYT1Tvv43OTi8UDbHjV6bj5fog7d25JXd0
 w1DvJ9s3kRtKTD5BSk7lzEjHzZ9Ga6RZv+HZIMpXdBTekqA6t0aqIep/VWSq7QX+xwcsQoBWBQi
 jfM4cT7MpbvUoT/3eUkZxxFPqbAuGi5/Po4ycl/fXzeEjct1LLNHe
X-Received: by 2002:aa7:c1d9:0:b0:55d:30b2:983e with SMTP id
 d25-20020aa7c1d9000000b0055d30b2983emr7068115edp.4.1707822442415; 
 Tue, 13 Feb 2024 03:07:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHpL9J72Zpyo1EqmFuRcAPVp895qd1/WbsE1dBiYDua5TMlRGOxJeRl7OvybDDBDeIGeHU7iA==
X-Received: by 2002:aa7:c1d9:0:b0:55d:30b2:983e with SMTP id
 d25-20020aa7c1d9000000b0055d30b2983emr7068099edp.4.1707822442046; 
 Tue, 13 Feb 2024 03:07:22 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUuCy+uNoYo+2JbvOtWGmmBrZepaql9N90vm/DAV0zBOWikdoXUU6f106PBe1Edc18bZglqYY1Ci+R0C4KZbdV5qaCVFq6kcPaiw+gPcO74qB+mBzWZaYck9PuEBid7MXrG3RCDVYFXsShr4GZFNRh8qzNZ2b1UQcvfDc7F3bSNhMriaHPGiwbiVQ5w6HLNbFrVYsptqlCUVCpoeoKRL+d5PVGCRzJNQTCMP9lpgwPnhgdN9ktMwCTAdwU=
Received: from redhat.com ([2.52.146.238]) by smtp.gmail.com with ESMTPSA id
 c16-20020a056402121000b0056183062ef9sm3011247edw.91.2024.02.13.03.07.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Feb 2024 03:07:21 -0800 (PST)
Date: Tue, 13 Feb 2024 06:07:15 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 jean-philippe@linaro.org, alex.williamson@redhat.com,
 clg@redhat.com, peter.maydell@linaro.org
Subject: Re: [PATCH v2] virtio-iommu: Use qemu_real_host_page_mask as default
 page_size_mask
Message-ID: <20240213060544-mutt-send-email-mst@kernel.org>
References: <20240117132039.332273-1-eric.auger@redhat.com>
 <20240213044312-mutt-send-email-mst@kernel.org>
 <6d4b5766-f8e2-4889-827d-01d3509239f7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6d4b5766-f8e2-4889-827d-01d3509239f7@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.774,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Feb 13, 2024 at 11:32:13AM +0100, Eric Auger wrote:
> Hi Michael,
> 
> On 2/13/24 10:43, Michael S. Tsirkin wrote:
> > On Wed, Jan 17, 2024 at 02:20:39PM +0100, Eric Auger wrote:
> >> We used to set default page_size_mask to qemu_target_page_mask() but
> >> with VFIO assignment it makes more sense to use the actual host page mask
> >> instead.
> >>
> >> So from now on qemu_real_host_page_mask() will be used as a default.
> >> To be able to migrate older code, we increase the vmstat version_id
> >> to 3 and if an older incoming v2 stream is detected we set the previous
> >> default value.
> >>
> >> The new default is well adapted to configs where host and guest have
> >> the same page size. This allows to fix hotplugging VFIO devices on a
> >> 64kB guest and a 64kB host. This test case has been failing before
> >> and even crashing qemu with hw_error("vfio: DMA mapping failed,
> >> unable to continue") in VFIO common). Indeed the hot-attached VFIO
> >> device would call memory_region_iommu_set_page_size_mask with 64kB
> >> mask whereas after the granule was frozen to 4kB on machine init done.
> >> Now this works. However the new default will prevent 4kB guest on
> >> 64kB host because the granule will be set to 64kB which would be
> >> larger than the guest page size. In that situation, the virtio-iommu
> >> driver fails on viommu_domain_finalise() with
> >> "granule 0x10000 larger than system page size 0x1000".
> >>
> >> The current limitation of global granule in the virtio-iommu
> >> should be removed and turned into per domain granule. But
> >> until we get this upgraded, this new default is probably
> >> better because I don't think anyone is currently interested in
> >> running a 4kB page size guest with virtio-iommu on a 64kB host.
> >> However supporting 64kB guest on 64kB host with virtio-iommu and
> >> VFIO looks a more important feature.
> >>
> >> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> >> Tested-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> >> Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > What about migration compatibility? In particular, cross-version one?
> > Don't we need compat machinery for this?
> See below
> >
> >> ---
> >>
> >> v1 -> v2:
> >> - fixed 2 typos in the commit msg and added Jean's R-b and T-b
> >> ---
> >>  hw/virtio/virtio-iommu.c | 7 +++++--
> >>  1 file changed, 5 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
> >> index 8a4bd933c6..ec2ba11d1d 100644
> >> --- a/hw/virtio/virtio-iommu.c
> >> +++ b/hw/virtio/virtio-iommu.c
> >> @@ -1313,7 +1313,7 @@ static void virtio_iommu_device_realize(DeviceState *dev, Error **errp)
> >>       * in vfio realize
> >>       */
> >>      s->config.bypass = s->boot_bypass;
> >> -    s->config.page_size_mask = qemu_target_page_mask();
> >> +    s->config.page_size_mask = qemu_real_host_page_mask();
> >>      s->config.input_range.end = UINT64_MAX;
> >>      s->config.domain_range.end = UINT32_MAX;
> >>      s->config.probe_size = VIOMMU_PROBE_SIZE;
> >> @@ -1491,13 +1491,16 @@ static int iommu_post_load(void *opaque, int version_id)
> >>       * still correct.
> >>       */
> >>      virtio_iommu_switch_address_space_all(s);
> >> +    if (version_id <= 2) {
> >> +        s->config.page_size_mask = qemu_target_page_mask();
> I tested migration from v2 -> v3 and the above code is overriding the
> new default by the older one.
> 
> Do you have an other concern?
> 
> Thanks
> 
> Eric



> >> +    }
> >>      return 0;
> >>  }
> >>  
> >>  static const VMStateDescription vmstate_virtio_iommu_device = {
> >>      .name = "virtio-iommu-device",
> >>      .minimum_version_id = 2,
> >> -    .version_id = 2,
> >> +    .version_id = 3,
> >>      .post_load = iommu_post_load,
> >>      .fields = (const VMStateField[]) {
> >>          VMSTATE_GTREE_DIRECT_KEY_V(domains, VirtIOIOMMU, 2,

Oh I missed the version change. But then migration  to older version
is completely broken isn't it? Old qemu can not handle version_id 3 at
all.


Generally, compat machinery is nicer than the old version hacks.


> >> -- 
> >> 2.41.0


