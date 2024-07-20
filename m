Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40963C3DA59
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jul 2024 19:09:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVFS0-0002vJ-N2; Sat, 20 Jul 2024 15:09:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sVFRx-0002kC-RY
 for qemu-devel@nongnu.org; Sat, 20 Jul 2024 15:08:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sVFRu-0008Ht-T6
 for qemu-devel@nongnu.org; Sat, 20 Jul 2024 15:08:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721502534;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6neNTbyjOoA33Bej9A0UUnbt/tK4nqbRqeBuIjXuUhM=;
 b=WnKfI0rSEHGd2VsPRLBvLR1a/hZPtKt/qV1nUwZlnD5eKjba2aIbrmRL+xqFjAKC0V4UHC
 sjnKMAqgOtODdjCsgYmOjPwjJHYqBWj3MEcqD5cw4TZG2viGtkajOgmiCjDF1RewpH6R5v
 4u8+sOp2VNu67SLxENdAaAx5/yjvo90=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-182-24lpOUCIMF6KNWoT5NzAFA-1; Sat, 20 Jul 2024 15:08:52 -0400
X-MC-Unique: 24lpOUCIMF6KNWoT5NzAFA-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-36857dd6913so1262660f8f.2
 for <qemu-devel@nongnu.org>; Sat, 20 Jul 2024 12:08:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721502531; x=1722107331;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6neNTbyjOoA33Bej9A0UUnbt/tK4nqbRqeBuIjXuUhM=;
 b=py83HlrqiPg79D+87cOMSsM/bx3P/grHP+CtVHGCis8MLYy4UrGkqzvFY19UVaXGyZ
 +YpiFlMMAFaNFfaT8puWo86Znyiv4L/YtaGSV20lvQvQPwSGnkGA85v1BegwrA5nzuiO
 nBVr0uVUPSTHl6u2W5y6Ay9526ayhsZ/XgZIJjzEM1N9dpt+h7kx/LJlUGkH/C6tpLy+
 8G2jiNDc/C0q2geBTp2eVyI9AY9rM32ndaJ5yoeMnYt5P3qJhR37ZYRySP88cFHBLbvU
 o4Ru+pKKh2iqjXY99WeP9Cmz9lXKNn4twhZsx2OXp7xM9Hs9ptrdm+9TvQ9op4NXIGWi
 bKxg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWyw37GFYnVogum1aWS2GEV2fY/GFVMYxvJP+V2JHnItxYJw9FOP3dFfATlVpJUiZQQGes068wlMMmFf2TSXosUn0rB6xM=
X-Gm-Message-State: AOJu0YzM1OLvfDYq5LUK1kU+YRHLeTIkKIxyNPNGCqXtd1HibyACYjtj
 gL1kAQLy+gzzBAYVJ1n+6kn0Jp4zumAn3NLUKYh5+Ip3ukjY9ZMEjj4cDmT55qIEptlZyipO3NK
 OQCBupm+H93a41K/vFT1HmRx7/3ooa0i8wCqH+n1Bfyko/1Dl/9gv
X-Received: by 2002:a05:6000:1ac8:b0:369:c6d7:7b93 with SMTP id
 ffacd0b85a97d-369c6d78197mr816097f8f.28.1721502531316; 
 Sat, 20 Jul 2024 12:08:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGghXNP2oxLauANfMlIjuxK8/mR6CJ2ed7nzu/ZDlpCP84tpkUt4X4OZoY+Rtqon8pZZ4HUpw==
X-Received: by 2002:a05:6000:1ac8:b0:369:c6d7:7b93 with SMTP id
 ffacd0b85a97d-369c6d78197mr816075f8f.28.1721502530433; 
 Sat, 20 Jul 2024 12:08:50 -0700 (PDT)
Received: from redhat.com (mob-5-90-113-158.net.vodafone.it. [5.90.113.158])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36878684204sm4422266f8f.2.2024.07.20.12.08.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Jul 2024 12:08:49 -0700 (PDT)
Date: Sat, 20 Jul 2024 15:08:47 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Yi Liu <yi.l.liu@intel.com>
Cc: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>,
 "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "peterx@redhat.com" <peterx@redhat.com>
Subject: Re: [PATCH v4 3/4] intel_iommu: fix type of the mask field in
 VTDIOTLBPageInvInfo
Message-ID: <20240720150831-mutt-send-email-mst@kernel.org>
References: <20240705105937.1630829-1-clement.mathieu--drif@eviden.com>
 <20240705105937.1630829-4-clement.mathieu--drif@eviden.com>
 <2c2590ea-a761-4617-8b1f-0d99abeca586@intel.com>
 <20240720144423-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240720144423-mutt-send-email-mst@kernel.org>
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

On Sat, Jul 20, 2024 at 02:45:29PM -0400, Michael S. Tsirkin wrote:
> On Mon, Jul 08, 2024 at 03:12:27PM +0800, Yi Liu wrote:
> > On 2024/7/5 19:01, CLEMENT MATHIEU--DRIF wrote:
> > > From: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>
> > > 
> > > The mask we are trying to store into VTDIOTLBPageInvInfo.mask might not
> > > fit in an uint8_t. Use uint64_t to avoid overflows
> > 
> > Per the below code, it can overflow as am can be larger than 8 according
> > to the CH 6.5.2.3 IOTLB Invalidate.
> 
> I don't understand what you are saying. What can overflow?
> Are you suggesting text for commit log here?
> 
> > And you may want a fix tag as well.
> 
> why not.

ignore pls this is on old version.

> > info.mask = ~((1 << am) - 1);
> > 
> > CH 6.5.2.3 IOTLB Invalidate
> > 
> > Address Mask (AM): For page-selective-within-domain invalidations, the
> > Address Mask specifies
> > the number of low order bits of the ADDR field that must be masked for the
> > invalidation operation.
> > This field enables software to request invalidation of contiguous mappings
> > for size-aligned
> > regions. Refer to Table 19 for encodings of this field. When invalidating a
> > large-page translation,
> > software must use the appropriate Address Mask value (0 for 4KByte page, 9
> > for 2-MByte page,
> > and 18 for 1-GByte page). Hardware implementations report the maximum
> > supported address
> > mask value through the Capability register
> > 
> > > Signed-off-by: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>
> > > ---
> > >   hw/i386/intel_iommu_internal.h | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
> > > index faea23e8d6..5f32c36943 100644
> > > --- a/hw/i386/intel_iommu_internal.h
> > > +++ b/hw/i386/intel_iommu_internal.h
> > > @@ -436,7 +436,7 @@ struct VTDIOTLBPageInvInfo {
> > >       uint16_t domain_id;
> > >       uint32_t pasid;
> > >       uint64_t addr;
> > > -    uint8_t mask;
> > > +    uint64_t mask;
> > >   };
> > >   typedef struct VTDIOTLBPageInvInfo VTDIOTLBPageInvInfo;
> > 
> > -- 
> > Regards,
> > Yi Liu


