Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48285C48BEB
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 15:20:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcoJi-00013p-Fn; Wed, 21 Feb 2024 10:15:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1rcoJN-0000nB-5y
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 10:15:05 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1rckox-0005VD-V9
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 06:31:34 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-41279203064so1023795e9.1
 for <qemu-devel@nongnu.org>; Wed, 21 Feb 2024 03:31:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708515086; x=1709119886; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=sqfUr4dMwYAsT0YG3h8hwDI+ww1/IMBVd8BBieSxI3Q=;
 b=AXy9JgcdbTv89FgrKqLvi0pG9kqZmvsfL0GwiIOWGfWZSkc+KibNts7Yl72ownnxAo
 x+Ng9nwgfmdOQb63/RBrwZExEUMGJcxQZFW2mFTq+QUWb1nnlsedQbHQF2Lw6oqRfy9q
 jkkcS7auJFFAXf6nrmLuw7YO74hKos2P/lzE8lYrfy7f03OFQc1Px1xHGrZDA1ll37b/
 vhzFMtdb+CQlfQwaJNBXH3jgYCYDWOZ47bDPx9mz38+6LG+s33GyLmRAIZSNUpzw23Z6
 vxjMWJPeVIZsmI4ZsgmzHjOJxd36fySci2vEzRe+yRkNoqnrlA45uQb65pR7L2Pn7TA5
 pAvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708515086; x=1709119886;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sqfUr4dMwYAsT0YG3h8hwDI+ww1/IMBVd8BBieSxI3Q=;
 b=O4XsPCQ0wHTySf4EiV8i1q3u9L77N/MupUluJqqLTThobaYBOsdUbK5kWiONivYrE2
 2BwsK7jCG0sipaPVzCypAtZ3KXCHKQ3zbUZgT+LTbAxB9PjFXdlFOSQas39TtLuhI/U0
 xnwEitMO5ZmQjzW6b/RfQzKuxC4bSbgxUjJKEBiOXmG/Axk1RGTBhtKTnyye2Afcb5yN
 a7jFqFwY1wmhWBIQuSHXNA7CYLQ41wPHrYLS++Lvc/bbq//xDQQ/vBqmTmn/R/l7hVoE
 D9uFpW9up21KD2euocaiIqUoozwVWjC92b0sP4HrmvVPGIobn9KDPtlMq4xyq6SdtONv
 LiPw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWe1q8YKuPlTEgUZNVeOkJMR/eVGVVbYyh4Tm6XX9IcDwV5CbORTsIgCtvgt0kC1x5wN1RYXiQSGAhN7tnW8jobyIQ9eGw=
X-Gm-Message-State: AOJu0Yw1vjp3RG9dlwS8aBJRWegp0fWGB3KPs1pWGLVATqmDk2dhm/aH
 mpLxH5GaSaLL7u0fdLiSgcJ5UDhgtmZNV6ajMQE3c3O4kMHpw7RQ33trRNp9YZU=
X-Google-Smtp-Source: AGHT+IGVm7EVAcSs7oI5wD5vAzyzLBXC8o2+iwqcHuXvEJPT4GveXIFnjJ4FdK3XPUBUTqUtOw+Wzg==
X-Received: by 2002:a05:600c:3c9b:b0:410:5876:63bf with SMTP id
 bg27-20020a05600c3c9b00b00410587663bfmr13396528wmb.17.1708515086043; 
 Wed, 21 Feb 2024 03:31:26 -0800 (PST)
Received: from myrica ([2.221.137.100]) by smtp.gmail.com with ESMTPSA id
 26-20020a05600c025a00b0041273fc463csm2195003wmj.17.2024.02.21.03.31.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Feb 2024 03:31:25 -0800 (PST)
Date: Wed, 21 Feb 2024 11:31:06 +0000
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Eric Auger <eric.auger@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 alex.williamson@redhat.com, clg@redhat.com,
 peter.maydell@linaro.org, Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH v2] virtio-iommu: Use qemu_real_host_page_mask as default
 page_size_mask
Message-ID: <20240221113106.GA4121556@myrica>
References: <20240117132039.332273-1-eric.auger@redhat.com>
 <20240213044312-mutt-send-email-mst@kernel.org>
 <6d4b5766-f8e2-4889-827d-01d3509239f7@redhat.com>
 <20240213060731-mutt-send-email-mst@kernel.org>
 <417ea71e-fb45-4e1d-b8e5-9d54d93dba3b@redhat.com>
 <20240213064017-mutt-send-email-mst@kernel.org>
 <8c0f6a91-7ae2-46c6-a8ad-18ca096a6115@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c0f6a91-7ae2-46c6-a8ad-18ca096a6115@redhat.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=jean-philippe@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Wed, Feb 21, 2024 at 11:41:57AM +0100, Eric Auger wrote:
> Hi,
> 
> On 2/13/24 13:00, Michael S. Tsirkin wrote:
> > On Tue, Feb 13, 2024 at 12:24:22PM +0100, Eric Auger wrote:
> >> Hi Michael,
> >> On 2/13/24 12:09, Michael S. Tsirkin wrote:
> >>> On Tue, Feb 13, 2024 at 11:32:13AM +0100, Eric Auger wrote:
> >>>> Do you have an other concern?
> >>> I also worry a bit about migrating between hosts with different
> >>> page sizes. Not with kvm I am guessing but with tcg it does work I think?
> >> I have never tried but is it a valid use case? Adding Peter in CC.
> >>> Is this just for vfio and vdpa? Can we limit this to these setups
> >>> maybe?
> >> I am afraid we know the actual use case too later. If the VFIO device is
> >> hotplugged we have started working with 4kB granule.
> >>
> >> The other way is to introduce a min_granule option as done for aw-bits.
> >> But it is heavier.
> >>
> >> Thanks
> >>
> >> Eric
> > Let's say, if you are changing the default then we definitely want
> > a way to get the cmpatible behaviour for tcg.
> > So the compat machinery should be user-accessible too and documented.
> 
> I guess I need to add a new option to guarantee the machine compat.
> 
> I was thinking about an enum GranuleMode property taking the following
> values, 4KB, 64KB, host
> Jean, do you think there is a rationale offering something richer?

16KB seems to be gaining popularity, we should include that (I think it's
the only granule supported by Apple IOMMU?). Hopefully that will be
enough.

Thanks,
Jean

> 
> Obviously being able to set the exact page_size_mask + host mode would
> be better but this does not really fit into any std property type.
> 
> Thanks
> 
> Eric
> >
> 

