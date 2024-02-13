Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2FCFC48260
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 11:40:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZr93-0000h8-Nh; Tue, 13 Feb 2024 06:40:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rZr90-0000gU-SK
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 06:40:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rZr8w-00059Q-8J
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 06:40:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707824405;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=f3zGg6I8zSOUsFZlLIUFWXMj4kAtc/F6l/Dsos6/JZY=;
 b=LBjdnnpE4Ld52n6/esyRjyRLGSkbYNZPVUfjsRXab4R8YzZg0sa5ewY0fofWKlm7XO/DLE
 n3ry1Zv06uU4pymPtGT91gm21pi0zf6yYAom3UpulGqLdHSiDin0pOn+Z4kjLA5XHCEr7Y
 6lo6jgbGun4Pvu6BBYVVjwYxkzaSLOU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-34-wZhpWBqVPuWVCEvK9cvczQ-1; Tue, 13 Feb 2024 06:40:03 -0500
X-MC-Unique: wZhpWBqVPuWVCEvK9cvczQ-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-40fb486573fso26522025e9.1
 for <qemu-devel@nongnu.org>; Tue, 13 Feb 2024 03:40:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707824403; x=1708429203;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f3zGg6I8zSOUsFZlLIUFWXMj4kAtc/F6l/Dsos6/JZY=;
 b=k7YecR4jVnPOKNIoIMxUcYBSpdxYL1LS6uhNl/ReaQX5ZUwdPVmFxj2mZ8szFrS6eA
 KPj523wCRxCD22RjDemHInGDpqiif43ThLqECNLnXZGYMiizku2xWJjeGLGzDDlK0SB+
 bB+jcU5/f5ECtAsZnPRC0s7RL/37C1LIXjpaxuxdACNBoS5zDerC+1xNKGzhqNQd8rmg
 4a+zMjH2hbFugNJX+OWTZZzucRdXI8YQY9QhWRsnqUDR8H23SRnt06YPKmzw39xf4FVY
 2Gvv1Y7A/DcWwKZMN/6RvWUKkbDCvDKJrPwGcBLleua6qjuif+did3vQcYr+rG7ZMGDG
 JOEA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWYK4To9AuZDLyxSjKVWeAErC6JKoa3tnwNDL/UCxCTMSSSHgqMCvvQrrySO7Y7VHgcFXQ2fSmykHJlt8xMGvdniNjL4No=
X-Gm-Message-State: AOJu0YyszyGylN0bsNkoJ3gEDy8oRE2s9iuf+I4G8MimcfNHL1h2V5wa
 LZIWkYKgKePY9OLrCiNrc0agLRNKc5JNc59vGdwnwjvQxdPWueXG9F8bTXrnQaZRg0VFORC4oX8
 eCEXVjmS8qIUMlmF5lsB/zGql/6Ucn075z3iECQ9iWaUzeCvvqVrp
X-Received: by 2002:a5d:540d:0:b0:33c:ddc9:6926 with SMTP id
 g13-20020a5d540d000000b0033cddc96926mr665135wrv.4.1707824402755; 
 Tue, 13 Feb 2024 03:40:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF+N7dhwUnjW3SxNTefxnHiBDhWnSANWxK1ZQmxBjhP1LS5QnymiHzX8peFe7IAv5PgWZ5h0g==
X-Received: by 2002:a5d:540d:0:b0:33c:ddc9:6926 with SMTP id
 g13-20020a5d540d000000b0033cddc96926mr665116wrv.4.1707824402412; 
 Tue, 13 Feb 2024 03:40:02 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCW0HM9OySlhu8pZ9de4ZGLtu/SAnlKU001tF11zg8ilzuk64Pqrm3gJv/OV14M+zgoJ1crWv7oSIPwDOCgpE7n1ucig3cTsv1MBUC59/Pm0oVDm8hz0iO1D0dSiaHA0J2PxtQ3ssFRGUfa+b/BIHR1UK8tT3KZm4rO4Ybn4WmKGR9S99M8pdXYmldCygMBMQMuYote+XOIV+T01dlHzpyEQhcjDetMaV+t6mW1m9moR62iAqC6qpXwwBgk=
Received: from redhat.com ([2a02:14f:17d:5d88:37b3:ce51:18b:36d9])
 by smtp.gmail.com with ESMTPSA id
 ce9-20020a5d5e09000000b0033cddadde6esm1061554wrb.80.2024.02.13.03.39.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Feb 2024 03:40:01 -0800 (PST)
Date: Tue, 13 Feb 2024 06:39:57 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 jean-philippe@linaro.org, alex.williamson@redhat.com,
 clg@redhat.com, peter.maydell@linaro.org
Subject: Re: [PATCH v2] virtio-iommu: Use qemu_real_host_page_mask as default
 page_size_mask
Message-ID: <20240213063755-mutt-send-email-mst@kernel.org>
References: <20240117132039.332273-1-eric.auger@redhat.com>
 <20240213044312-mutt-send-email-mst@kernel.org>
 <6d4b5766-f8e2-4889-827d-01d3509239f7@redhat.com>
 <20240213060544-mutt-send-email-mst@kernel.org>
 <91f1b2d8-da88-43c3-871f-7c47ef0d9439@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <91f1b2d8-da88-43c3-871f-7c47ef0d9439@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.504,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Tue, Feb 13, 2024 at 12:19:16PM +0100, Eric Auger wrote:
> 
> 
> On 2/13/24 12:07, Michael S. Tsirkin wrote:
> > On Tue, Feb 13, 2024 at 11:32:13AM +0100, Eric Auger wrote:
> >> Hi Michael,
> >>
> >> On 2/13/24 10:43, Michael S. Tsirkin wrote:
> >>> On Wed, Jan 17, 2024 at 02:20:39PM +0100, Eric Auger wrote:
> >>>> We used to set default page_size_mask to qemu_target_page_mask() but
> >>>> with VFIO assignment it makes more sense to use the actual host page mask
> >>>> instead.
> >>>>
> >>>> So from now on qemu_real_host_page_mask() will be used as a default.
> >>>> To be able to migrate older code, we increase the vmstat version_id
> >>>> to 3 and if an older incoming v2 stream is detected we set the previous
> >>>> default value.
> >>>>
> >>>> The new default is well adapted to configs where host and guest have
> >>>> the same page size. This allows to fix hotplugging VFIO devices on a
> >>>> 64kB guest and a 64kB host. This test case has been failing before
> >>>> and even crashing qemu with hw_error("vfio: DMA mapping failed,
> >>>> unable to continue") in VFIO common). Indeed the hot-attached VFIO
> >>>> device would call memory_region_iommu_set_page_size_mask with 64kB
> >>>> mask whereas after the granule was frozen to 4kB on machine init done.
> >>>> Now this works. However the new default will prevent 4kB guest on
> >>>> 64kB host because the granule will be set to 64kB which would be
> >>>> larger than the guest page size. In that situation, the virtio-iommu
> >>>> driver fails on viommu_domain_finalise() with
> >>>> "granule 0x10000 larger than system page size 0x1000".
> >>>>
> >>>> The current limitation of global granule in the virtio-iommu
> >>>> should be removed and turned into per domain granule. But
> >>>> until we get this upgraded, this new default is probably
> >>>> better because I don't think anyone is currently interested in
> >>>> running a 4kB page size guest with virtio-iommu on a 64kB host.
> >>>> However supporting 64kB guest on 64kB host with virtio-iommu and
> >>>> VFIO looks a more important feature.
> >>>>
> >>>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> >>>> Tested-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> >>>> Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> >>> What about migration compatibility? In particular, cross-version one?
> >>> Don't we need compat machinery for this?
> >> See below
> >>>> ---
> >>>>
> >>>> v1 -> v2:
> >>>> - fixed 2 typos in the commit msg and added Jean's R-b and T-b
> >>>> ---
> >>>>  hw/virtio/virtio-iommu.c | 7 +++++--
> >>>>  1 file changed, 5 insertions(+), 2 deletions(-)
> >>>>
> >>>> diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
> >>>> index 8a4bd933c6..ec2ba11d1d 100644
> >>>> --- a/hw/virtio/virtio-iommu.c
> >>>> +++ b/hw/virtio/virtio-iommu.c
> >>>> @@ -1313,7 +1313,7 @@ static void virtio_iommu_device_realize(DeviceState *dev, Error **errp)
> >>>>       * in vfio realize
> >>>>       */
> >>>>      s->config.bypass = s->boot_bypass;
> >>>> -    s->config.page_size_mask = qemu_target_page_mask();
> >>>> +    s->config.page_size_mask = qemu_real_host_page_mask();
> >>>>      s->config.input_range.end = UINT64_MAX;
> >>>>      s->config.domain_range.end = UINT32_MAX;
> >>>>      s->config.probe_size = VIOMMU_PROBE_SIZE;
> >>>> @@ -1491,13 +1491,16 @@ static int iommu_post_load(void *opaque, int version_id)
> >>>>       * still correct.
> >>>>       */
> >>>>      virtio_iommu_switch_address_space_all(s);
> >>>> +    if (version_id <= 2) {
> >>>> +        s->config.page_size_mask = qemu_target_page_mask();
> >> I tested migration from v2 -> v3 and the above code is overriding the
> >> new default by the older one.
> >>
> >> Do you have an other concern?
> >>
> >> Thanks
> >>
> >> Eric
> >
> >
> >>>> +    }
> >>>>      return 0;
> >>>>  }
> >>>>  
> >>>>  static const VMStateDescription vmstate_virtio_iommu_device = {
> >>>>      .name = "virtio-iommu-device",
> >>>>      .minimum_version_id = 2,
> >>>> -    .version_id = 2,
> >>>> +    .version_id = 3,
> >>>>      .post_load = iommu_post_load,
> >>>>      .fields = (const VMStateField[]) {
> >>>>          VMSTATE_GTREE_DIRECT_KEY_V(domains, VirtIOIOMMU, 2,
> > Oh I missed the version change. But then migration  to older version
> > is completely broken isn't it? Old qemu can not handle version_id 3 at
> > all.
> Indeed, I considered migrating backyard was not that much important. Do
> you consider this is mandated?
> 
> Eric

Generally yes. We only ship downstream but e.g. any RHEL major version
migrates to same major version in any direction as people have clusters
mixing different versions. It's easier to maintain that guarantee
upstream than break it upstream and try to fix it downstream.


> >
> > Generally, compat machinery is nicer than the old version hacks.
> >
> >
> >>>> -- 
> >>>> 2.41.0
> >


