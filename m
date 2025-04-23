Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18E8CC369CB
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 06:01:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7T9v-0007wX-Dg; Wed, 23 Apr 2025 02:00:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1u7T9t-0007w1-Dm
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 02:00:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1u7T9p-0008Uq-Vp
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 02:00:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745388027;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uTeRDoAyjzRy0zTc2c/mxCCdaA336u5TDKVMvQ/j+Lk=;
 b=FF7xBK+3NJrphll+x4h1yETULitijLt5cRZz8FSldSwSX/FXXGF4SV6P6jLsKN0AxSRG7v
 Wv0sKKbq5GYZTcl/TDsLG+a5EdRjVWUv9ndhP12bTYXwhaCEg6Sv39EuyJ16hVLGKREQF5
 dNFMdLoyaCwgMuH9fPFekrkDHiGgkm0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-336--a_0ra3lNvKO_G0hB7pqXQ-1; Wed, 23 Apr 2025 02:00:24 -0400
X-MC-Unique: -a_0ra3lNvKO_G0hB7pqXQ-1
X-Mimecast-MFC-AGG-ID: -a_0ra3lNvKO_G0hB7pqXQ_1745388023
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43d5ca7c86aso32797855e9.0
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 23:00:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745388023; x=1745992823;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uTeRDoAyjzRy0zTc2c/mxCCdaA336u5TDKVMvQ/j+Lk=;
 b=gfU5uB7OyEyy1dYn7tiHd0rhwK41nTyy0NRt2SIHFOsoqCZvy8omRoZgqRlR/f0U9u
 M+p9EJJ+iZLT1q9B7pdbQvkH6aPWyhwZWHJNH+im7695gDjau0Ca/ofVd+tQX+VGGP23
 7MH2ibmjMMBuHSQCFm7sRQOe23kvkx1O4S4lgvBJFc0qLLZ7c3E+3ooE2rLkfnCyZ1yV
 bHCE6ZaE4sC5UbSnH8/FRqLjGMOaevNn4e+VMYrKds7N1S8KvuJ8LiGOe/TC3HlXOhKT
 0ofIJMHseHhMkUv4ErmX+InqnM/i1Hm8QQf7WU7qqSs3wIL6X27+8VzDPKaru6fSnh4P
 Afug==
X-Gm-Message-State: AOJu0Ywhgsj3wRjJVT4leZgir5LCvblBFy6X0c5n2ZdeCrSffeDplBnQ
 yc+0Sy23edP//dbUsHT0VL3XvGidCnSU0VrhD6edeBjSF5rvfbxhum6CxS5R3S12kwqHE4zg5eU
 Ok/0HFLJGdgtq1Pflr4joqNZzbGbWMFFBchqWmM6JhS3xqnuaKYox
X-Gm-Gg: ASbGncuODL7njosAem1hiZHgWT9Qxb88mtQjGQzLxOfcgcPfDJDJAEGMZbRmn8QSlII
 AodeYn7A9FisdAeWibb9P9GJ7ae1jddUhVXaepHmfPJXPX7ThG0xZlrkCBAyqCAc2+MY9zmt74R
 G/xWyjD7lssdQ9rZghGVdO0KcDcgZWlJEPcKh9ihrcuSl7MTeNGaxA+raz07znrBXklJRp72sAQ
 9g687r5xkMk4XiXmM3tZ7sjW8FfdIvdVE7ij1SYNIF7E3dF4kU/edShBZI1/saflRybJSh1sRXt
 +HLa9g==
X-Received: by 2002:a05:600c:a403:b0:43d:2313:7b49 with SMTP id
 5b1f17b1804b1-4408a0f27d8mr57695545e9.12.1745388023005; 
 Tue, 22 Apr 2025 23:00:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGMnS5aOeaWe6BPNJ2e0sH88WhIPtAzCdNBcwmIIWODgPAF7pyeMs/bH6SWjM3MX7HFpNKIFA==
X-Received: by 2002:a05:600c:a403:b0:43d:2313:7b49 with SMTP id
 5b1f17b1804b1-4408a0f27d8mr57695245e9.12.1745388022622; 
 Tue, 22 Apr 2025 23:00:22 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-44092d29b73sm12763025e9.17.2025.04.22.23.00.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Apr 2025 23:00:21 -0700 (PDT)
Date: Wed, 23 Apr 2025 02:00:19 -0400
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
Message-ID: <20250423015815-mutt-send-email-mst@kernel.org>
References: <20250423053742.65401-1-clement.mathieu--drif@eviden.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250423053742.65401-1-clement.mathieu--drif@eviden.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
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

On Wed, Apr 23, 2025 at 05:38:20AM +0000, CLEMENT MATHIEU--DRIF wrote:
> Address space creation might end up being called without holding the
> bql as it is exposed through the IOMMU ops.
> 
> Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>
> ---
>  hw/i386/intel_iommu.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index dffd7ee885..cc8c9857e1 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -4238,6 +4238,12 @@ VTDAddressSpace *vtd_find_add_as(IntelIOMMUState *s, PCIBus *bus,
>          vtd_dev_as->context_cache_entry.context_cache_gen = 0;
>          vtd_dev_as->iova_tree = iova_tree_new();
>  
> +        /*
> +         * memory_region_add_subregion_overlap requires the bql,
> +         * make sure we own it.
> +         */
> +        BQL_LOCK_GUARD();
> +
>          memory_region_init(&vtd_dev_as->root, OBJECT(s), name, UINT64_MAX);
>          address_space_init(&vtd_dev_as->as, &vtd_dev_as->root, "vtd-root");

Does not look like this addresses all races here:
https://lore.kernel.org/all/8062d868-469f-4c1d-a071-099b8e18857c@redhat.com


while this can be a separate patch on top, I'd rather we just
address everything in a single patchset.


> -- 
> 2.49.0


