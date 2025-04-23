Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2927DC369CB
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 10:06:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7Wzh-0003Ra-4F; Wed, 23 Apr 2025 06:06:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1u7Wzf-0003MM-66
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 06:06:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1u7Wzd-0002fV-2a
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 06:06:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745402771;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aXKslqPwHwpGTS/ujDh9S0miCu7qrwjcIZoeliGWIGQ=;
 b=NFbQ/cQmSzGHWJyPolVX7x3aa9jttcGRxQRGVDUxAQDGSbhShhvZoDq4ftmGkeK/IcTWcx
 YfwiDTcBwD1iq4f+J+Zr7O7GW4USQjiScZvExZRxQPYWPB7ic8KQXiVj6CpFjsRIzqKZqo
 RYADc8SnuiIJEKofFWZcb++sbKNv6y0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-401-LJ9xFoF5MuKxKMeVWK9R0g-1; Wed, 23 Apr 2025 06:06:10 -0400
X-MC-Unique: LJ9xFoF5MuKxKMeVWK9R0g-1
X-Mimecast-MFC-AGG-ID: LJ9xFoF5MuKxKMeVWK9R0g_1745402769
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-39d8e5ca9c2so3849083f8f.0
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 03:06:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745402769; x=1746007569;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aXKslqPwHwpGTS/ujDh9S0miCu7qrwjcIZoeliGWIGQ=;
 b=o3gKb78pDyCRkA5tG9fNnj24ZeX3HwH3A4T6szOTi7rL1IOaO1s+3TAJfkUYDn3r++
 F5P2nqAwjf9F342lojKzg9UMPY1+dBDgLaBf8SjIG2DZfl9DyOXJdN7E3oOTv9Xf3ww7
 nwRjTK5ddDHl02zMO53Jovn1CeRT/2rWZHBBMJQFxOC1Km4/1DebiM+yROMxq4pgtKwS
 GJKYCxo+1+0ZVQQkwjwV7JLfP/0Qnq+RDABGfgMkBN9ya20Z7QVki3E8LwXzosSiaz9H
 UG/edo+yvY+ubKxw4OWiOb9JLHAkVRCbeIvKUym/qr8PCJ92EIIL9cw0ZgU72e3GsRBR
 8YUA==
X-Gm-Message-State: AOJu0YzNUJFDyUBrgsIlzmptS8TwqANLLHEQiGkR4iKHlxixcMfyiM34
 laDRFu176HsDZyh8fzLygKeN2n/bzcjjLaTNORetNH3Z1SKFHyyJPBySXbRB+n2pzMl8kFnVw9X
 gIwQurTN2uL7it4bn0dRreUqYjs0IT7LktlHt4KfZmwSRA8WI5Swf
X-Gm-Gg: ASbGnct1IsSko85kBMgx9TBuyplL2qCxYJz5MiBHoK6e2ARAXEj2Njyo3b5tYquQKZM
 sAgrfBbhR+AlvJ9QxbRC0xdFwos31+HfeCAZ9/oiSupWYfmHhkCeiJtkWcsHQxgaBhH/ggFrV/h
 GURg5JMYdJwSqIAG6R3co3HKE3sFaahvTRWi4g+7wDW1BeLgorgCaM9LLYOPidUVFzxuO67AMnD
 ZIoC+moFkiKMq+aSlnIHQvyrvQMSpjr1Uhuxqq0qdY4eQNQ/LJXEbVQFcikz0Z3AcdMUSOi1Pd8
 Dovnuw==
X-Received: by 2002:a05:6000:2912:b0:39c:cc7:3db6 with SMTP id
 ffacd0b85a97d-39efba43d7amr13982752f8f.19.1745402769284; 
 Wed, 23 Apr 2025 03:06:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGN+THGKXbo/WIAYyJqsCwDsGOBza3UC5evsMknCnK0ePGXvUJDtAC/raFngcWY5Lr52swZEg==
X-Received: by 2002:a05:6000:2912:b0:39c:cc7:3db6 with SMTP id
 ffacd0b85a97d-39efba43d7amr13982726f8f.19.1745402768915; 
 Wed, 23 Apr 2025 03:06:08 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39efa4a4f2dsm18407443f8f.95.2025.04.23.03.06.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 03:06:08 -0700 (PDT)
Date: Wed, 23 Apr 2025 06:06:05 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>,
 "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>,
 "peterx@redhat.com" <peterx@redhat.com>
Subject: Re: [PATCH v3 1/2] intel_iommu: Take the bql before registering a
 new address space
Message-ID: <20250423060502-mutt-send-email-mst@kernel.org>
References: <20250423053742.65401-1-clement.mathieu--drif@eviden.com>
 <20250423015815-mutt-send-email-mst@kernel.org>
 <b848eddb-8c5c-4e25-a88c-36583a485d31@eviden.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b848eddb-8c5c-4e25-a88c-36583a485d31@eviden.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.411,
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

On Wed, Apr 23, 2025 at 09:15:36AM +0000, CLEMENT MATHIEU--DRIF wrote:
> 
> 
> On 23/04/2025 8:00 am, Michael S. Tsirkin wrote:
> > Caution: External email. Do not open attachments or click links, unless this email comes from a known sender and you know the content is safe.
> >
> >
> > On Wed, Apr 23, 2025 at 05:38:20AM +0000, CLEMENT MATHIEU--DRIF wrote:
> >> Address space creation might end up being called without holding the
> >> bql as it is exposed through the IOMMU ops.
> >>
> >> Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>
> >> ---
> >>   hw/i386/intel_iommu.c | 6 ++++++
> >>   1 file changed, 6 insertions(+)
> >>
> >> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> >> index dffd7ee885..cc8c9857e1 100644
> >> --- a/hw/i386/intel_iommu.c
> >> +++ b/hw/i386/intel_iommu.c
> >> @@ -4238,6 +4238,12 @@ VTDAddressSpace *vtd_find_add_as(IntelIOMMUState *s, PCIBus *bus,
> >>           vtd_dev_as->context_cache_entry.context_cache_gen = 0;
> >>           vtd_dev_as->iova_tree = iova_tree_new();
> >>
> >> +        /*
> >> +         * memory_region_add_subregion_overlap requires the bql,
> >> +         * make sure we own it.
> >> +         */
> >> +        BQL_LOCK_GUARD();
> >> +
> >>           memory_region_init(&vtd_dev_as->root, OBJECT(s), name, UINT64_MAX);
> >>           address_space_init(&vtd_dev_as->as, &vtd_dev_as->root, "vtd-root");
> >
> > Does not look like this addresses all races here:
> > https://lore.kernel.org/all/8062d868-469f-4c1d-a071-099b8e18857c@redhat.com
> >
> >
> > while this can be a separate patch on top, I'd rather we just
> > address everything in a single patchset.
> 
> Hi Michael,
> 
> We only aim to fix the potential crash here.
> I saw Paolo's response and I know the race exists. I will send a patch
> set to fix it soon but are you sure both fixes must be in the same
> series? I think the nature is different.
> 
> cmd

If you have two races in the same function, fixing one can easily
make another one occur more. Let's just fix it all please,
I don't see any rush to apply a partial fix.

-- 
MST


