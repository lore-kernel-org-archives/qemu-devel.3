Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E9ACC4829A
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 09:45:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZpKr-00023F-EH; Tue, 13 Feb 2024 04:44:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rZpKh-0001s0-2E
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 04:44:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rZpKf-0000k6-48
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 04:44:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707817444;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9kHVkDwBtC5IG302WkC9sPitZi9ffNJvND+yCp6Ty80=;
 b=cvCHlIEgpGDhFB+g5CPvrB3C7v9CzrUix7kCSL4Poy9UQB4SUoKmMNjrbFsP3kvU199GMV
 9gxvmqp0E53FDMcsVLUTXT18ZqoQjwvK6v51kyONr9FZr5KRaX90n00XP4APam6dFefh+x
 1Moja8t6b0RODBbYOi5Hc+oXsHZNjB0=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-20-k6_2pkoHO_KEQs6uRZJMag-1; Tue, 13 Feb 2024 04:44:02 -0500
X-MC-Unique: k6_2pkoHO_KEQs6uRZJMag-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-50e91f9d422so2928993e87.2
 for <qemu-devel@nongnu.org>; Tue, 13 Feb 2024 01:44:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707817441; x=1708422241;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9kHVkDwBtC5IG302WkC9sPitZi9ffNJvND+yCp6Ty80=;
 b=rviyup9MQifmyH6G0o5Z1C41nC9+GOCSpwMIvEaDVRUf30HO6mrfVtiRPNVEZWfdX8
 fKYjXXWzgzCWA7Tg97gLHcopJvf947gbUpoDFc44Xox4M7Od86cR67q5wTY0/VIFI4fL
 MANr5KpfhEfc3Y29+LeiYzQi0VwJYUfQc6HhDZZ0S2DvDwOms50WTYsm1fZSRGws8Clf
 w+nlFju3JmS2019M8G0EaCsUeq9QaDjEPFdR6vPqn07VCKoSagdRVX16qJIpWIbt/CAo
 RG/p9mtbKb3e0USGozkSMmTEqRSBHHs/63w1PLhL53My2/QZ+u+yMKXXfS1ux3moNC4J
 wIdg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXwxBRyzKjhEBwBWSKcbkquamQXGR3WVWR/EJ62LZgg1DA14I1gj9UL6IDnMpVT7IFzF+nUU9qRjzZ5nsRvRefe7aHndlI=
X-Gm-Message-State: AOJu0Yw52udiU6vrqVJ39UfMIL+fDV3U4Sd3Gu2wtP4tZ+7vIrd8ZuQK
 VBlFinP/xunQwnyp+eychM8oiZzqZWetMV/ycuLTxKVGjxV546ryVqBwVkWjCy2P04EN92rCdXZ
 nApQffx+hbVr80CGXB65EzkGlnxPnPz2m7vrMDhcwKt7qVPcPWgx2
X-Received: by 2002:ac2:410a:0:b0:511:5494:dd53 with SMTP id
 b10-20020ac2410a000000b005115494dd53mr6032344lfi.19.1707817441405; 
 Tue, 13 Feb 2024 01:44:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IENnVxBeyRI13BAT8jU9chn94+J4HbBs5af/7Md9fZVlFBTAqO3UXqunc4WmPa17LqiBn12MA==
X-Received: by 2002:ac2:410a:0:b0:511:5494:dd53 with SMTP id
 b10-20020ac2410a000000b005115494dd53mr6032333lfi.19.1707817441035; 
 Tue, 13 Feb 2024 01:44:01 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCWMRUtjXopPbZ4JDJ2c4QUq79feUFwhGcnRFmyLQ+wqdlaNyU4MBwp38kSHtdoEqAQ1INt8w07GYv7kNUkAJyA0SIh8ngPZJW7shPUkxluZ0A9zVaFPopb7iQrrtHUZbDZRQXKzvcSRlNB0LWHYpbFIk7KEZYRBHWnb70jpGoihnqp4GAVILkvXZ/oq1fxl93yEXXZktc58oqXO8MbJD8NFFkZZQ728CoTWqBLvS/NcJ0pcDUxLIQ3sp5M=
Received: from redhat.com ([2.52.146.238]) by smtp.gmail.com with ESMTPSA id
 i10-20020a056512318a00b005118bbf458fsm833779lfe.143.2024.02.13.01.43.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Feb 2024 01:44:00 -0800 (PST)
Date: Tue, 13 Feb 2024 04:43:55 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 jean-philippe@linaro.org, alex.williamson@redhat.com,
 clg@redhat.com, peter.maydell@linaro.org
Subject: Re: [PATCH v2] virtio-iommu: Use qemu_real_host_page_mask as default
 page_size_mask
Message-ID: <20240213044312-mutt-send-email-mst@kernel.org>
References: <20240117132039.332273-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240117132039.332273-1-eric.auger@redhat.com>
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

On Wed, Jan 17, 2024 at 02:20:39PM +0100, Eric Auger wrote:
> We used to set default page_size_mask to qemu_target_page_mask() but
> with VFIO assignment it makes more sense to use the actual host page mask
> instead.
> 
> So from now on qemu_real_host_page_mask() will be used as a default.
> To be able to migrate older code, we increase the vmstat version_id
> to 3 and if an older incoming v2 stream is detected we set the previous
> default value.
> 
> The new default is well adapted to configs where host and guest have
> the same page size. This allows to fix hotplugging VFIO devices on a
> 64kB guest and a 64kB host. This test case has been failing before
> and even crashing qemu with hw_error("vfio: DMA mapping failed,
> unable to continue") in VFIO common). Indeed the hot-attached VFIO
> device would call memory_region_iommu_set_page_size_mask with 64kB
> mask whereas after the granule was frozen to 4kB on machine init done.
> Now this works. However the new default will prevent 4kB guest on
> 64kB host because the granule will be set to 64kB which would be
> larger than the guest page size. In that situation, the virtio-iommu
> driver fails on viommu_domain_finalise() with
> "granule 0x10000 larger than system page size 0x1000".
> 
> The current limitation of global granule in the virtio-iommu
> should be removed and turned into per domain granule. But
> until we get this upgraded, this new default is probably
> better because I don't think anyone is currently interested in
> running a 4kB page size guest with virtio-iommu on a 64kB host.
> However supporting 64kB guest on 64kB host with virtio-iommu and
> VFIO looks a more important feature.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Tested-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

What about migration compatibility? In particular, cross-version one?
Don't we need compat machinery for this?

> ---
> 
> v1 -> v2:
> - fixed 2 typos in the commit msg and added Jean's R-b and T-b
> ---
>  hw/virtio/virtio-iommu.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
> index 8a4bd933c6..ec2ba11d1d 100644
> --- a/hw/virtio/virtio-iommu.c
> +++ b/hw/virtio/virtio-iommu.c
> @@ -1313,7 +1313,7 @@ static void virtio_iommu_device_realize(DeviceState *dev, Error **errp)
>       * in vfio realize
>       */
>      s->config.bypass = s->boot_bypass;
> -    s->config.page_size_mask = qemu_target_page_mask();
> +    s->config.page_size_mask = qemu_real_host_page_mask();
>      s->config.input_range.end = UINT64_MAX;
>      s->config.domain_range.end = UINT32_MAX;
>      s->config.probe_size = VIOMMU_PROBE_SIZE;
> @@ -1491,13 +1491,16 @@ static int iommu_post_load(void *opaque, int version_id)
>       * still correct.
>       */
>      virtio_iommu_switch_address_space_all(s);
> +    if (version_id <= 2) {
> +        s->config.page_size_mask = qemu_target_page_mask();
> +    }
>      return 0;
>  }
>  
>  static const VMStateDescription vmstate_virtio_iommu_device = {
>      .name = "virtio-iommu-device",
>      .minimum_version_id = 2,
> -    .version_id = 2,
> +    .version_id = 3,
>      .post_load = iommu_post_load,
>      .fields = (const VMStateField[]) {
>          VMSTATE_GTREE_DIRECT_KEY_V(domains, VirtIOIOMMU, 2,
> -- 
> 2.41.0


