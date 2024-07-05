Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3B8FC30658
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 09:43:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPfSq-0000SE-C7; Fri, 05 Jul 2024 05:42:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sPfSo-0000Rw-Mk
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 05:42:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sPfSm-0001R1-MN
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 05:42:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720172562;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8DDl39HI1d7txN/C1d+aLYYWuSgAVvXKgr1RPKhrYn4=;
 b=gDh/Ia0p2LFYuO3pIdCBIRL60Y8qhSXoOfJ4FY7kokak4xrCygOBppGGMvgv9GSEpPalZ6
 cMSomDK8qA5EQftPR6NyJVbnfXXJg/pPyH0WvGyCklgR1zfzvrm7gcTlMceV/9d+T1xTi2
 6gRVya0X1bCkZ03ghegxrDYY1RPKkmo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-vbgkPcWDNVSyKL7naDfpkg-1; Fri, 05 Jul 2024 05:42:39 -0400
X-MC-Unique: vbgkPcWDNVSyKL7naDfpkg-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4265b751469so20015e9.1
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2024 02:42:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720172558; x=1720777358;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8DDl39HI1d7txN/C1d+aLYYWuSgAVvXKgr1RPKhrYn4=;
 b=QFOHMnmpvpe6/McC9T5G9jcjM6WrdB9YO5BuF94D5/37WyNuZBlpvuBcDwLQ9ZAX2Y
 pOspOwPzmsk3FgdaabWSEcu1JBIRZHp9VnurFUtqWu9JlG/kkd5SxSzyJ1ZMQFS4tgOI
 oTyjhTorI/DMJcHQlWYSF9DSpqLzVPySBJgJkWmcy0JvGtREdUm3e9MQJb7QeX4yWhrl
 f2+UCke/TL6ac0y5NT4Rq8WC2sHeVMQemoSgek8t7e2l+pmoqEgKwEh3DO7HjS/eGN5O
 uFO9wu/t3ajWq/tHp+ArX6g926Gqve9EAX7Vkb4MLBOyPE4u3HqE/rnu9Usk3F0lRo5I
 p18g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVh91e4DaXGEeDFg1TC3zMi1eVb+Xjlm8D4DL/ffyTruBp5bIs00LPtb2smJ6ZsKHkEAcat4dhWDpjCALnnHtFdlMau8ZE=
X-Gm-Message-State: AOJu0YwkJYZtAtlaiYgGIQR2dV1tm06yrT6NDcb6alZEHAfi602H8o0V
 wrNtxlOFxpzm3ScpXeAqEMLn6EXHlk4l4MhoE7j3s4Cge6vDLNy4mpAkBspQhAQASqG043fyxAn
 4lrAn5n1X6cEDucPeSpBkVUfiIpT2TfuENiZ+bU2xxZGCSLph91XT
X-Received: by 2002:a05:600c:3b99:b0:421:b65d:2235 with SMTP id
 5b1f17b1804b1-4264b004191mr34240125e9.0.1720172558254; 
 Fri, 05 Jul 2024 02:42:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF7Hr/GOoi0MgtU3Gh+umMU5DKDmGgDDbrzAxy7FQpCT2sQEnBYVRhAMQB9uTUdSthd9q7tDg==
X-Received: by 2002:a05:600c:3b99:b0:421:b65d:2235 with SMTP id
 5b1f17b1804b1-4264b004191mr34239825e9.0.1720172557511; 
 Fri, 05 Jul 2024 02:42:37 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f0:a185:2de6:83fc:7632:9788])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4264a1f23c1sm54469005e9.28.2024.07.05.02.42.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jul 2024 02:42:36 -0700 (PDT)
Date: Fri, 5 Jul 2024 05:42:25 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Cc: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "peterx@redhat.com" <peterx@redhat.com>
Subject: Re: [PATCH v3 3/3] intel_iommu: make types match
Message-ID: <20240705054156-mutt-send-email-mst@kernel.org>
References: <20240705050213.1492515-1-clement.mathieu--drif@eviden.com>
 <20240705050213.1492515-4-clement.mathieu--drif@eviden.com>
 <SJ0PR11MB6744DDE438D094FEB4F8A29392DF2@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <d637bd99-11cb-4bbc-a8c4-06fae21b6c88@eviden.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d637bd99-11cb-4bbc-a8c4-06fae21b6c88@eviden.com>
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

On Fri, Jul 05, 2024 at 09:24:50AM +0000, CLEMENT MATHIEU--DRIF wrote:
> 
> 
> On 05/07/2024 10:51, Duan, Zhenzhong wrote:
> > Caution: External email. Do not open attachments or click links, unless this email comes from a known sender and you know the content is safe.
> >
> >
> >> -----Original Message-----
> >> From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
> >> Subject: [PATCH v3 3/3] intel_iommu: make types match
> >>
> >> From: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>
> >>
> >> The 'level' field in vtd_iotlb_key is an unsigned integer.
> >> We don't need to store level as an int in vtd_lookup_iotlb.
> >>
> >> Signed-off-by: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>
> >> ---
> >> hw/i386/intel_iommu.c | 2 +-
> >> 1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> >> index 37c21a0aec..be0cb39b5c 100644
> >> --- a/hw/i386/intel_iommu.c
> >> +++ b/hw/i386/intel_iommu.c
> >> @@ -358,7 +358,7 @@ static VTDIOTLBEntry
> >> *vtd_lookup_iotlb(IntelIOMMUState *s, uint16_t source_id,
> >> {
> >>      struct vtd_iotlb_key key;
> >>      VTDIOTLBEntry *entry;
> >> -    int level;
> >> +    unsigned level;
> > Will it bring any issue if int is used?
> It shouldn't, but it might trigger static analyzer warnings.
> Do you want me to drop the patch?


just write a better commit log.
"Not an issue by itself, but using unsigned here seems cleaner".


> >
> >>      for (level = VTD_SL_PT_LEVEL; level < VTD_SL_PML4_LEVEL; level++) {
> >>          key.gfn = vtd_get_iotlb_gfn(addr, level);
> >> --
> >> 2.45.2


