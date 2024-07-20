Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40322C3DA49
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jul 2024 18:45:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVF5Q-0005Uh-6S; Sat, 20 Jul 2024 14:45:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sVF5N-0005KY-Ku
 for qemu-devel@nongnu.org; Sat, 20 Jul 2024 14:45:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sVF5J-0004aH-VH
 for qemu-devel@nongnu.org; Sat, 20 Jul 2024 14:45:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721501133;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TAIQGExcip2Z2WhqyIuFSdQ0+n7Xo/iZdFyAsVgJEgg=;
 b=Twww5+K6QQsB+B0QJJinSsghfUc6BWwiKn9Ddf5J3tiQIm8eSn70D/+WaPej9R7go5Tspj
 jsfYLQ7APYxtvwedNbePqaKSj10i4nLc7K4HMTndDlnW4TuRS/nYfcvQTKr9ZULtfE0lvt
 /mva20qrlAFqNWHzXExzmQc1Y1c3bNI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-508-sBNM0pFvN7O5MsxmHAYH0A-1; Sat, 20 Jul 2024 14:45:30 -0400
X-MC-Unique: sBNM0pFvN7O5MsxmHAYH0A-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-36873ed688dso1447632f8f.1
 for <qemu-devel@nongnu.org>; Sat, 20 Jul 2024 11:45:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721501129; x=1722105929;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TAIQGExcip2Z2WhqyIuFSdQ0+n7Xo/iZdFyAsVgJEgg=;
 b=vqMK6/U/YQ8twgj0KJG0B5MGKfIy/h4ylAJShwsq4L5BUFlZ/Z43sPyIHeyg/pdEcf
 RSx3RNABPlfsmBTYYaXwmHuC1Yddw7gM2s/EQufyHIVatemOZTtKljvy88dZpvhOLefF
 17NlYV8o41f0nJTYvvnw3+K5Mi0w1QYMm3NFARf1bmdDMPcueGqObkgDp7/LIcPJhTfK
 8kBMoZw1YMilbTtq82aIrv367X5y20RDFR2VOxQ7J+9Nr6fLvqjYKcd3KG3jCvIIC2OW
 aP20c2L9n2u675LCV0uGojgNi2QgzEemtvdWRCNGARdW1BWdTuwRd1K/LhOxY77/UpJp
 mpSg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVnYF8s2s/s9qqszrUFt4bZzCSV21A5ycYH62ViG/FWvC5fQJ5vaV9+ZB9aZOYI1TqzdbL4HSZxo3A82ajlNOl/P7MgkzA=
X-Gm-Message-State: AOJu0Ywpbf2j9sDh7kTrZcQHBhdkvD/vMKQRsXzCTJI0metpkmLO9Aul
 2TFbJmOaaIVhVMvBybFdxpWRnJ7/E6J51AGz040NGFsnqBA3pQOrHeetOSS7FCn8mdik2044ZNq
 o6TJEAazT5MOAvD1VjQMCp56agEpb97DSvJ5opnDfBleefnAAoHOH
X-Received: by 2002:a5d:6a10:0:b0:368:4226:4084 with SMTP id
 ffacd0b85a97d-369bbbb4c6bmr1420538f8f.6.1721501129738; 
 Sat, 20 Jul 2024 11:45:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGGaNPT70r6ZYySIO9LTrbXuWOEnZld/MTvbY72bf6wtiANIA9rfx31mr/+jcAAMpH/z60Cmg==
X-Received: by 2002:a5d:6a10:0:b0:368:4226:4084 with SMTP id
 ffacd0b85a97d-369bbbb4c6bmr1420526f8f.6.1721501129173; 
 Sat, 20 Jul 2024 11:45:29 -0700 (PDT)
Received: from redhat.com (mob-5-90-113-158.net.vodafone.it. [5.90.113.158])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-368786848basm4414295f8f.15.2024.07.20.11.45.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Jul 2024 11:45:28 -0700 (PDT)
Date: Sat, 20 Jul 2024 14:45:26 -0400
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
Message-ID: <20240720144423-mutt-send-email-mst@kernel.org>
References: <20240705105937.1630829-1-clement.mathieu--drif@eviden.com>
 <20240705105937.1630829-4-clement.mathieu--drif@eviden.com>
 <2c2590ea-a761-4617-8b1f-0d99abeca586@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2c2590ea-a761-4617-8b1f-0d99abeca586@intel.com>
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

On Mon, Jul 08, 2024 at 03:12:27PM +0800, Yi Liu wrote:
> On 2024/7/5 19:01, CLEMENT MATHIEU--DRIF wrote:
> > From: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>
> > 
> > The mask we are trying to store into VTDIOTLBPageInvInfo.mask might not
> > fit in an uint8_t. Use uint64_t to avoid overflows
> 
> Per the below code, it can overflow as am can be larger than 8 according
> to the CH 6.5.2.3 IOTLB Invalidate.

I don't understand what you are saying. What can overflow?
Are you suggesting text for commit log here?

> And you may want a fix tag as well.

why not.

> info.mask = ~((1 << am) - 1);
> 
> CH 6.5.2.3 IOTLB Invalidate
> 
> Address Mask (AM): For page-selective-within-domain invalidations, the
> Address Mask specifies
> the number of low order bits of the ADDR field that must be masked for the
> invalidation operation.
> This field enables software to request invalidation of contiguous mappings
> for size-aligned
> regions. Refer to Table 19 for encodings of this field. When invalidating a
> large-page translation,
> software must use the appropriate Address Mask value (0 for 4KByte page, 9
> for 2-MByte page,
> and 18 for 1-GByte page). Hardware implementations report the maximum
> supported address
> mask value through the Capability register
> 
> > Signed-off-by: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>
> > ---
> >   hw/i386/intel_iommu_internal.h | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
> > index faea23e8d6..5f32c36943 100644
> > --- a/hw/i386/intel_iommu_internal.h
> > +++ b/hw/i386/intel_iommu_internal.h
> > @@ -436,7 +436,7 @@ struct VTDIOTLBPageInvInfo {
> >       uint16_t domain_id;
> >       uint32_t pasid;
> >       uint64_t addr;
> > -    uint8_t mask;
> > +    uint64_t mask;
> >   };
> >   typedef struct VTDIOTLBPageInvInfo VTDIOTLBPageInvInfo;
> 
> -- 
> Regards,
> Yi Liu


