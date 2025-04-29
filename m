Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 594A6C369DC
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 17:57:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9pC5-0005Ch-Ii; Tue, 29 Apr 2025 13:56:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisa.su887@gmail.com>)
 id 1u9pC1-0005CG-N8
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 13:56:30 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <anisa.su887@gmail.com>)
 id 1u9pBz-0001Ys-0D
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 13:56:28 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-227a8cdd241so87199215ad.3
 for <qemu-devel@nongnu.org>; Tue, 29 Apr 2025 10:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745949384; x=1746554184; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=yJuFu2T2uACt7lYPR7DK5aCYKnlqtxYEUsDvqs5aJGA=;
 b=V672B3AW3dALPvBcRTgU3O8jwhY4JSQik2zF+ypk50W8tF9tFfBgqEHT0CRF8AoCZU
 y7n0jSthGHBjC+3850nHKgTvEEnIrPxK8wKzIFbhEA0JCl6vytV5CNltjgj4rgjcT3et
 1Vv8rnNrlMjgl6Xs1UVyBBvRXXkaUCzhZQQEU6Vrc9mcgP3EgtiTUny7DZTdcJXd/NHb
 Rp1TeWS111fFg9D+glDa+Q98xf2iJSrBpuVqFLytPMpi9CEVxaF36LsfVkqp5tmGQKAC
 8SMEBhLtQ3V/iQje3X8jYh7RTwExaKv81i/7EgTs4vRETbAFqoiwOYZS71VhqeOcbIn0
 OCYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745949384; x=1746554184;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yJuFu2T2uACt7lYPR7DK5aCYKnlqtxYEUsDvqs5aJGA=;
 b=BaxyovhyAxU6kB0WfCRGTbge+nvfOOTavcfRVOXUcl4uSelYoLKM933d9wGldizZG6
 lutug65vGjIKrkfVtG4pxhXBGaNf74QqT4YwW6G9Ki/kLP4wj3BWvXuX4rOF2kOYBg52
 sHt4Us83n9ObauJV799vFk311g08WezMZsOOOIX3tz3FWWPQ8eOetNPDwpVBilSk7lqW
 gX1uUQ37uFSMayq2KkvDnjW9MFw9kp3+7RfFJtxvYzZCaU7XqkmvYqvnu3rcFuLY73qK
 qxjkfQH6H4xTzEIFMr46ERVpu9geFnnXEuCq/dTXIpKW+tg7LROI/nrO2VtycYmyFI46
 X6RQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW+kUng8/Vk815YOlXbZZUlNWrmJdnAzWvGH3/13kUYj6SY0qZz63bv7c+fAa9WN40+hL+JQvPGFbev@nongnu.org
X-Gm-Message-State: AOJu0Yw5HvAXc6EUqZtLGnU4TP9kLZRqCPcMSvPFsZbmqtuXsIpLdqtz
 LK9l1uSSylMDxU+QtQeRN6fClHyW4rhuf4hVeWSvrp7t11hw8CMu
X-Gm-Gg: ASbGnctXCjs3oTZcQuRJ/3BScvSx8aoBe6csobKikAhhUvEp4u6AajhPTc7LS8j0pIt
 zuy9VCgWalLm78ZFMP+uuW2IrjBxVVFRQTPSvSKQXIxT0E/V1L7JfxDpVmR/JSU1rTfMy5zwGK/
 PkvBDgGhuGbSSwQMC2trbrGznpd5Nln06lMWPtPWm0bro2bxN1sl7IMtEF3Udb5vrmR+yCnZFa1
 C3BmJ4DoaU6x68pI7N7k61jHyAv3hTAfkUPCVNog6TBxjculz1c/B6TO+mRa1SSwh65YhjIqjWz
 YpwHwaQJ/wDZ6FIkYm27Oad+oHG9txtZWzBr2kpd/iha+Qs0tQfyHQj3WzVGGEJoWsI=
X-Google-Smtp-Source: AGHT+IHh05EfYulLqBSbJTNmqSNuuxyR3fQUErngIO1EFAitJiPAP6+8QHeuDFL7PSyVG7VRZRbZ/A==
X-Received: by 2002:a17:903:1aa5:b0:223:635d:3e38 with SMTP id
 d9443c01a7336-22df34e7f64mr4824645ad.15.1745949384214; 
 Tue, 29 Apr 2025 10:56:24 -0700 (PDT)
Received: from deb-101020-bm01.eng.stellus.in ([149.97.161.244])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22db5100aa7sm105284405ad.161.2025.04.29.10.56.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Apr 2025 10:56:23 -0700 (PDT)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
Date: Tue, 29 Apr 2025 17:56:21 +0000
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: anisa.su887@gmail.com, qemu-devel@nongnu.org, nifan.cxl@gmail.com,
 dave@stgolabs.net, linux-cxl@vger.kernel.org
Subject: Re: [PATCH 1/9] cxl/type3: Add supported block sizes bitmask to
 CXLDCRegion struct
Message-ID: <aBESxXNTecIbPJPP@deb-101020-bm01.eng.stellus.in>
References: <20250317164204.2299371-1-anisa.su887@gmail.com>
 <20250317164204.2299371-2-anisa.su887@gmail.com>
 <20250424111131.00005ff2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250424111131.00005ff2@huawei.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=anisa.su887@gmail.com; helo=mail-pl1-x629.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Thu, Apr 24, 2025 at 11:11:31AM +0100, Jonathan Cameron wrote:
> On Mon, 17 Mar 2025 16:31:28 +0000
> anisa.su887@gmail.com wrote:
> 
> > From: Anisa Su <anisa.su@samsung.com>
> > 
> > Add supported_blk_size field to CXLDCRegion struct in preparation for
> > next patch. It is needed by command 0x5600 Get DC Region Config.
...
> > @@ -8,6 +8,7 @@
> >   *
> >   * SPDX-License-Identifier: GPL-v2-only
> >   */
> > +#include <math.h>
> >  
> >  #include "qemu/osdep.h"
> >  #include "qemu/units.h"
> > @@ -766,6 +767,7 @@ static bool cxl_create_dc_regions(CXLType3Dev *ct3d, Error **errp)
> >      uint64_t region_len;
> >      uint64_t decode_len;
> >      uint64_t blk_size = 2 * MiB;
> > +    uint64_t supported_blk_size_bitmask = BIT((int) log2(blk_size));
> 
> Isn't this going in circles?  I guess it sort of acts as documentation that it
> is a bitmap but then the name is already doing that. 
> Maybe set it to blk_size and add a comment that for now only a fixed block size
> is supported?
> 
> I'm a little confused on what this is for given you don't check it in patch 6
> which is changing the block size?
Good catch! It doesn't seem to specify this check in Section 7.6.7.6.3
Set DC Region Configuration (Opcode 5602h) in the 3.2 spec, but it would
make sense to me to fail with the same rc as when the region has not
been cleared, which is CXL_MBOX_UNSUPPORTED.

Will have the fix in v2.

> >      CXLDCRegion *region;
> >      MemoryRegion *mr;
> >      uint64_t dc_size;
> > @@ -811,6 +813,7 @@ static bool cxl_create_dc_regions(CXLType3Dev *ct3d, Error **errp)
> >              .block_size = blk_size,
> >              /* dsmad_handle set when creating CDAT table entries */
> >              .flags = 0,
> > +            .supported_blk_size_bitmask = supported_blk_size_bitmask,
> >          };
> >          ct3d->dc.total_capacity += region->len;
> >          region->blk_bitmap = bitmap_new(region->len / region->block_size);
> > diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> > index ca515cab13..bebed04085 100644
> > --- a/include/hw/cxl/cxl_device.h
> > +++ b/include/hw/cxl/cxl_device.h
> > @@ -608,6 +608,7 @@ typedef struct CXLDCRegion {
> >      uint32_t dsmadhandle;
> >      uint8_t flags;
> >      unsigned long *blk_bitmap;
> > +    uint64_t supported_blk_size_bitmask;
> >  } CXLDCRegion;
> >  
> >  typedef struct CXLSetFeatureInfo {
> 

