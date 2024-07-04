Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E18AFC30653
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 22:14:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPUhy-0006ra-GS; Thu, 04 Jul 2024 18:13:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sPUhw-0006pa-S2
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 18:13:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sPUhv-0002cv-8e
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 18:13:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720131217;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9OE/lCa1eWOoyrj/uPkjPeSxwnhOczxfGBs4QALPKT0=;
 b=f/bjzpA2AT6gNGpmfrx9aAUhiQBp9a9GFwdTLDs2RcXBo/c+Sb7zNVjiOtSHthROs+qQv1
 YdIaqRI7SzKZgEehYXd+lkmzvkKUDvEYFwQSn2IPhMG9tBE3u3AeDkFxUwEKdRsF4sPazG
 Nu6Skbs0aK1xssOjHA0TdGTIp9kqCxI=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-418-sgK8JTPsMEiomcugzeMGLw-1; Thu, 04 Jul 2024 18:13:32 -0400
X-MC-Unique: sgK8JTPsMEiomcugzeMGLw-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-52e9763468aso1399900e87.1
 for <qemu-devel@nongnu.org>; Thu, 04 Jul 2024 15:13:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720131210; x=1720736010;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9OE/lCa1eWOoyrj/uPkjPeSxwnhOczxfGBs4QALPKT0=;
 b=mFJ83f0iWqvLIPFEeDgQ8J3MklHsUhNi9tOhFZXWq9XT1YBZcF0za3MPk0i+iYDMW5
 pOW3vr/L6DbBPVQnrOftLopkggmW8qeGNZDM5VFhlmsmZg1T+hhLs7ZqjGMz8beiGH4A
 f6Yb56dgB+LN3Y5cp5iLqQJDekymD1kD97486894JxH48aVDbEHV7PfVoUKoaIOebAoy
 dSORITBeiIaHr/F6DAY5yytPv2HEbWBpfqFIUSWCttFUguybtYBdxCUZeXc38JCsk5Ce
 kCqcH89YZArkw3W8tZ5QEJM6eQ+cerLq6MhIF4cpYA8+R3oXmLpbKErfhLY7nXzp/c2m
 jz4w==
X-Gm-Message-State: AOJu0Yzh0wWVJ07vlcHsPsXKL/8kqt8tEwdFeTEO64Z59kKJdaPE3I2a
 WAQF4nXlzmSgNbGPx5WPDyFndL0ikyPV3G/Qm2Yk1mMtGTVAk5hv2yw+wmsaf1TWFHti/VKEi19
 T78/Z3VDCH0Dlm4Z3CuMlhh9Eb3lHrUnvDIL3fc1dN0Y8oi6bDRn5
X-Received: by 2002:ac2:5f99:0:b0:52e:976a:b34b with SMTP id
 2adb3069b0e04-52ea062063dmr2382154e87.15.1720131210313; 
 Thu, 04 Jul 2024 15:13:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEe3cDN3dXQLX1pXzSOP7VaGvHfKFDreC+mb8ABp8pxaIhzfu7h644Shy9dOoRaA4zxYovD9g==
X-Received: by 2002:ac2:5f99:0:b0:52e:976a:b34b with SMTP id
 2adb3069b0e04-52ea062063dmr2382138e87.15.1720131209660; 
 Thu, 04 Jul 2024 15:13:29 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:441:1b5b:ac5c:b82e:a18c:2c6e])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a77affca606sm118445766b.170.2024.07.04.15.13.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jul 2024 15:13:29 -0700 (PDT)
Date: Thu, 4 Jul 2024 18:13:23 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>,
 "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "peterx@redhat.com" <peterx@redhat.com>
Subject: Re: [PATCH  v2 2/3] intel_iommu: make types match
Message-ID: <20240704180821-mutt-send-email-mst@kernel.org>
References: <20240704151220.1018104-1-clement.mathieu--drif@eviden.com>
 <20240704151220.1018104-3-clement.mathieu--drif@eviden.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240704151220.1018104-3-clement.mathieu--drif@eviden.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Jul 04, 2024 at 03:12:48PM +0000, CLEMENT MATHIEU--DRIF wrote:
> From: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>
> 
> The 'level' field in vtd_iotlb_key is an unsigned integer.
> We don't need to store level as an int in vtd_lookup_iotlb.
> 
> VTDIOTLBPageInvInfo.mask is used in binary operations with addresses.

this last sentence is a bit opaque. is there a bug ? E.g.
can mask ever get so big it does not fit in u8?

> Signed-off-by: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>
> ---
>  hw/i386/intel_iommu.c          | 2 +-
>  hw/i386/intel_iommu_internal.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 37c21a0aec..be0cb39b5c 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -358,7 +358,7 @@ static VTDIOTLBEntry *vtd_lookup_iotlb(IntelIOMMUState *s, uint16_t source_id,
>  {
>      struct vtd_iotlb_key key;
>      VTDIOTLBEntry *entry;
> -    int level;
> +    unsigned level;
>  
>      for (level = VTD_SL_PT_LEVEL; level < VTD_SL_PML4_LEVEL; level++) {
>          key.gfn = vtd_get_iotlb_gfn(addr, level);
> diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
> index cbc4030031..5fcbe2744f 100644
> --- a/hw/i386/intel_iommu_internal.h
> +++ b/hw/i386/intel_iommu_internal.h
> @@ -436,7 +436,7 @@ struct VTDIOTLBPageInvInfo {
>      uint16_t domain_id;
>      uint32_t pasid;
>      uint64_t addr;
> -    uint8_t mask;
> +    uint64_t mask;
>  };
>  typedef struct VTDIOTLBPageInvInfo VTDIOTLBPageInvInfo;
>  
> -- 
> 2.45.2


