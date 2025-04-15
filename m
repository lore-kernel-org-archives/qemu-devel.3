Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF5C7C369B8
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 06:56:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4aDH-0007dg-Aw; Tue, 15 Apr 2025 02:56:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1u4aDE-0007dL-Dc
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 02:56:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1u4aDC-0008SN-Cv
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 02:56:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744700160;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sDhipnCahzydMj+9/begyBEBkCKSgxvwUUgTFEphbNY=;
 b=Lyfu3beAp7W8RbNZ25OrfILcgcxau225A32+3FguEKcxlccu1y0VGSJmnQe4YScfKrHzMN
 pacg3T9+dzK9nsi9WShYDjLxclRnR4ZdPY9CKUFopMwKMHGRM56DaXOD+yMqiNFj4Hf2rq
 N0eMCQG77/BJbCMWplefGwm2I6LdN/8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-vCqar-akNeWKp0grclIrHA-1; Tue, 15 Apr 2025 02:55:58 -0400
X-MC-Unique: vCqar-akNeWKp0grclIrHA-1
X-Mimecast-MFC-AGG-ID: vCqar-akNeWKp0grclIrHA_1744700157
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43cf3168b87so27120635e9.2
 for <qemu-devel@nongnu.org>; Mon, 14 Apr 2025 23:55:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744700157; x=1745304957;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sDhipnCahzydMj+9/begyBEBkCKSgxvwUUgTFEphbNY=;
 b=qh9huedkY9ieq3sguT9EOuXU4gdelFLG9CvVyGum2ajIE8vq8tt7SBBV6hB9l9QIlX
 zxaq8fOeowkcxu/V98NBDfgOdZY4RXZUCm9zV5xXklwwymZBka67tYEQtKCYJdIIA6YT
 gO/ERN1O1nGVGkd8mYWaNivy2qlT5VcxlrNvrxN6KsswPPMrk5o16NYgaFc6RKYcO0b9
 Es9vtNDTWB69/yZrNz3F2kYMqX+zsnTOfA0aAtEkgdTK1EumI5remQyQ5ulgG4O/GbWf
 9JVkbyIpTqdH/3B1tCUYoMOYUTMBeTfocv5ptk/v+gGmA9pwQDmwz+QpkS4MSzED5yk8
 oIpA==
X-Gm-Message-State: AOJu0YwyNdTwUMU9/icFAlKaqTTvlemVtqayxpiN4HAlgT3U52zUbFuu
 DmRQ0eEb2WW1lelwfMhpDqEsFERoBJUU6aTPPLsANG2F1aFi5bnmMAgMJ42I78Y1nhrK7m7jUNb
 fF//IwSEJD+5f0N0fRj+VdaZEnj0zuxZKNhuwza1DWspLSeaEZ52X
X-Gm-Gg: ASbGncuGQQO8Yx3oU0RD8LIqtnw6/A8b7WS72Tmr+gSouW9nUEzK1+6TDtHuFgoKo9I
 eIExpqHmMV/xKTMv2+Vqd3FUeK9ZnxZRiHY911OgxxyD4ShF4Xc08SZlIIm6xqHFYZI4I+w9XAJ
 khvYQSg9MEblzbNkj9bkrNt9hshz5/qsEJWbPBabF94/IGve7sFKz+IcBoCLe6vJbsYQ/UAnNtI
 OiH8282iRcaSxavlecPDvg7/VaN2YqDRI/h/ZR0re56p8/VKOkQ3KFeWaTQfZV5wzTpFu3AtdAu
 geyE4w==
X-Received: by 2002:a05:600c:502a:b0:43c:e6d1:efe7 with SMTP id
 5b1f17b1804b1-43f3a9a70famr113220595e9.26.1744700157210; 
 Mon, 14 Apr 2025 23:55:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGOlQeENayE70svZt9tSPw1f+TP9uymZnhf3oFSVJdSW2xqmwHqcwUEW1AFfJcUlhuZ1yfzjA==
X-Received: by 2002:a05:600c:502a:b0:43c:e6d1:efe7 with SMTP id
 5b1f17b1804b1-43f3a9a70famr113220425e9.26.1744700156911; 
 Mon, 14 Apr 2025 23:55:56 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43f233a2f71sm197775635e9.15.2025.04.14.23.55.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Apr 2025 23:55:56 -0700 (PDT)
Date: Tue, 15 Apr 2025 02:55:53 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>,
 "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>,
 "peterx@redhat.com" <peterx@redhat.com>,
 Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [PATCH] intel_iommu: Take the bql before registering a new
 address space
Message-ID: <20250415025138-mutt-send-email-mst@kernel.org>
References: <20250415061353.185589-1-clement.mathieu--drif@eviden.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250415061353.185589-1-clement.mathieu--drif@eviden.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Apr 15, 2025 at 06:18:08AM +0000, CLEMENT MATHIEU--DRIF wrote:
> Address space creation might end up being called without holding the
> bql as it is exposed through the IOMMU ops.
> 
> Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>


Indeed, and this can maybe explain some failures we are seeing ...
But is it just this part?
For example, is access to vtd_address_spaces safe?

> ---
>  hw/i386/intel_iommu.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index dffd7ee885..fea2220013 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -4216,6 +4216,7 @@ VTDAddressSpace *vtd_find_add_as(IntelIOMMUState *s, PCIBus *bus,
>      vtd_dev_as = g_hash_table_lookup(s->vtd_address_spaces, &key);
>      if (!vtd_dev_as) {
>          struct vtd_as_key *new_key = g_malloc(sizeof(*new_key));
> +        bool take_bql = !bql_locked();
>  
>          new_key->bus = bus;
>          new_key->devfn = devfn;
> @@ -4238,6 +4239,11 @@ VTDAddressSpace *vtd_find_add_as(IntelIOMMUState *s, PCIBus *bus,
>          vtd_dev_as->context_cache_entry.context_cache_gen = 0;
>          vtd_dev_as->iova_tree = iova_tree_new();
>  
> +        /* Some functions in this branch require the bql, make sure we own it */
> +        if (take_bql) {
> +            bql_lock();
> +        }
> +
>          memory_region_init(&vtd_dev_as->root, OBJECT(s), name, UINT64_MAX);
>          address_space_init(&vtd_dev_as->as, &vtd_dev_as->root, "vtd-root");
>  
> @@ -4305,6 +4311,10 @@ VTDAddressSpace *vtd_find_add_as(IntelIOMMUState *s, PCIBus *bus,
>  
>          vtd_switch_address_space(vtd_dev_as);
>  
> +        if (take_bql) {
> +            bql_unlock();
> +        }
> +
>          g_hash_table_insert(s->vtd_address_spaces, new_key, vtd_dev_as);
>      }
>      return vtd_dev_as;
> -- 
> 2.49.0


