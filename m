Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F882C3ABCC
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 11:49:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFAbt-00050k-8R; Wed, 14 May 2025 07:49:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uFAbr-0004zb-Uu
 for qemu-devel@nongnu.org; Wed, 14 May 2025 07:49:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uFAbj-0005Nf-4x
 for qemu-devel@nongnu.org; Wed, 14 May 2025 07:49:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747223344;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dKDKP2CybvJwX5OWiss/TmLn/tGD0MYYzTlBPD2bEhg=;
 b=IFaQJDfq1PYPXbz/e9+K2f5akTV0OX1oakbrVNBxO4qmclDFazV+tXcbCcP+1/Me4NziYk
 UciCsTj6fB525Gajfdi89Z5qPelQdGbAaceONjzJWvH/vbjYnUPmXDSCyObqSPeGd2kjOZ
 hR2rN/fSEwixlMc1fgPBcFveWa3TXM0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-372-OwusI4pjPAusF_rhg_JIPA-1; Wed, 14 May 2025 07:49:03 -0400
X-MC-Unique: OwusI4pjPAusF_rhg_JIPA-1
X-Mimecast-MFC-AGG-ID: OwusI4pjPAusF_rhg_JIPA_1747223342
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3a206f05150so2220225f8f.0
 for <qemu-devel@nongnu.org>; Wed, 14 May 2025 04:49:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747223342; x=1747828142;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dKDKP2CybvJwX5OWiss/TmLn/tGD0MYYzTlBPD2bEhg=;
 b=jdhvNNEO48HxYKCLN6HtJB+z15cypUaK81PTxHPpF2E8JOMCvZ2cblg3mocc5lsxVz
 lJtL2pdBE/EzItXzfi77TQkD0LkmlLGLuisDqT2uh2LvaD5F2gqSYNp9EIAkAbEDl4cj
 KRBJ1MqWjipwaVKnujmkutmSaKGxK3BddkG67xLbCoE+k1Q5mTusI2johzBp02SYXDhD
 f2+Iax02MpOIEfvTv0zJcZ4F0sD1SAX4k6PihK52YoZ/m9YoQOmbvABD153KS0m7ybWC
 A2QPyB4z1Qs8gTLOLN4dvT8edWhspTJTNXIqthAOieZnh0A609J6QUUaa/khYiapWRAD
 maGA==
X-Gm-Message-State: AOJu0Yzv5fziacN0nUkbZW7iOAdgS8NNY6ce2cYRffA3D69TAv7XqgHB
 TkmwGoWkdUBtVnWZetzbWrrFh0iA0+vsuEnZ3v3pWAO5CBhhgHOUJtwBIAf7n2U6FYqWSxz5ygW
 dQjG8N7g92Iq8x+SPNJzYwzBZ4aStehP2CMk9DjgIGssvfmaSTqpS
X-Gm-Gg: ASbGncv+VM8jViYdV0y8rIxOLlzHyup9pmXu12GuywRClOdpO7LOtU0bwwJlEMFq3gy
 uhThq4kgsTHsPNF/9fW/YFV0mwVFCMRbJqIw/OZoXZbYgslmFtlRz91oBo4h5CVX/8wCsg5XGQI
 CiiYFbhAL4W1BF4mHI6WDIPT37qBcFAgoxZ9vEH0KkCFagVvuZ6tIPDn0KxvKUdTQbeiNvoPSed
 FTm2DeUUA4pWUDDuPftlvMj9uB21nf38zX+oo5ZmmuYoN8c0oJH4KMGrqAFUDmtPjuaJ6VRsS6S
 /EgH0w==
X-Received: by 2002:a05:6000:420e:b0:39e:e75b:5cc with SMTP id
 ffacd0b85a97d-3a3496a303bmr2814041f8f.16.1747223341993; 
 Wed, 14 May 2025 04:49:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IELVIZcUGrVHWRNylZ787AvqMdjL2Xxrc3mRcZqKJBjC3FEEO55OGrBcJ+nYxUIC4uW0phEiA==
X-Received: by 2002:a05:6000:420e:b0:39e:e75b:5cc with SMTP id
 ffacd0b85a97d-3a3496a303bmr2814016f8f.16.1747223341561; 
 Wed, 14 May 2025 04:49:01 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a1f58ebe00sm19804553f8f.38.2025.05.14.04.49.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 May 2025 04:49:00 -0700 (PDT)
Date: Wed, 14 May 2025 07:48:58 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>,
 "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>,
 "peterx@redhat.com" <peterx@redhat.com>
Subject: Re: [PATCH v5 2/2] intel_iommu: Take locks when looking for and
 creating address spaces
Message-ID: <20250514074821-mutt-send-email-mst@kernel.org>
References: <20250430124750.240412-1-clement.mathieu--drif@eviden.com>
 <20250430124750.240412-3-clement.mathieu--drif@eviden.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250430124750.240412-3-clement.mathieu--drif@eviden.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Wed, Apr 30, 2025 at 12:48:06PM +0000, CLEMENT MATHIEU--DRIF wrote:
> vtd_find_add_as can be called by multiple threads which leads to a race
> condition. Taking the IOMMU lock ensures we avoid such a race.
> Moreover we also need to take the bql to avoid an assert to fail in
> memory_region_add_subregion_overlap when actually allocating a new
> address space.
> 
> Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>
> ---
>  hw/i386/intel_iommu.c | 25 ++++++++++++++++++++++++-
>  1 file changed, 24 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index dad1d9f300..144e25622a 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -4205,9 +4205,30 @@ VTDAddressSpace *vtd_find_add_as(IntelIOMMUState *s, PCIBus *bus,
>      VTDAddressSpace *vtd_dev_as;
>      char name[128];
>  
> +    vtd_iommu_lock(s);
>      vtd_dev_as = g_hash_table_lookup(s->vtd_address_spaces, &key);
> +    vtd_iommu_unlock(s);
> +
>      if (!vtd_dev_as) {
> -        struct vtd_as_key *new_key = g_malloc(sizeof(*new_key));
> +        struct vtd_as_key *new_key;
> +        /* Slow path */
> +
> +        /*
> +        * memory_region_add_subregion_overlap requires the bql,
> +        * make sure we own it.
> +        */


not how comments should look

> +        BQL_LOCK_GUARD();
> +        vtd_iommu_lock(s);
> +
> +        /* Check again as we released the lock for a moment */
> +        vtd_dev_as = g_hash_table_lookup(s->vtd_address_spaces, &key);
> +        if (vtd_dev_as) {
> +            vtd_iommu_unlock(s);
> +            return vtd_dev_as;
> +        }
> +
> +        /* Still nothing, allocate a new address space */
> +        new_key = g_malloc(sizeof(*new_key));
>  
>          new_key->bus = bus;
>          new_key->devfn = devfn;
> @@ -4298,6 +4319,8 @@ VTDAddressSpace *vtd_find_add_as(IntelIOMMUState *s, PCIBus *bus,
>          vtd_switch_address_space(vtd_dev_as);
>  
>          g_hash_table_insert(s->vtd_address_spaces, new_key, vtd_dev_as);
> +    

trailing whitespace here

> +        vtd_iommu_unlock(s);
>      }
>      return vtd_dev_as;
>  }



I fixed these up but pls take care, Clement.

> -- 
> 2.49.0


