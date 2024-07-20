Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 866C3C3DA49
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jul 2024 18:46:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVF64-0008Vx-Tj; Sat, 20 Jul 2024 14:46:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sVF63-0008RY-Pl
 for qemu-devel@nongnu.org; Sat, 20 Jul 2024 14:46:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sVF62-0004cp-Fc
 for qemu-devel@nongnu.org; Sat, 20 Jul 2024 14:46:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721501177;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PyeytJPuODY/UB/4Y0HYRvaRB3KQZ3FniCXudF+GnGw=;
 b=WJDm2CX68dVbmhiY1RyL6zVrno365dcGe5H1G71C76J3WjHMOP263TOJQBJMcL3yjQ9QC5
 8l5KsGaEsYYLOA/YmZntnEnmhaFyL5arBYKypPZkcoLu3iIqKoGp64+jBDC6fEi/zvhgSp
 F7p631afHiRsD4Zix+lAIBjK6brmYEI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-304-oLb3_MhzNt2Xxy0NdOLXOQ-1; Sat, 20 Jul 2024 14:46:16 -0400
X-MC-Unique: oLb3_MhzNt2Xxy0NdOLXOQ-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-426683d9c4bso19551305e9.3
 for <qemu-devel@nongnu.org>; Sat, 20 Jul 2024 11:46:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721501175; x=1722105975;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PyeytJPuODY/UB/4Y0HYRvaRB3KQZ3FniCXudF+GnGw=;
 b=wFN6DG8yOAQO4XAqcREdDN76agX5v81atLRKdvTGGecZUgHyVdMcUwjytWYLOZQ1Hj
 cHhLQ3qQxCL1Icse+s/mj+kaRamzRBSk7hPxJBgG/FwMwQgDRRK7ifYGJu/Z9io5pkk6
 aY0jUpZQmw8ufbvrB9cFmNNcpSzGJlFWoYEYLVqRswpddIgsIo//rON9/Jcq7GNSIi/j
 5Gc47a08KtIl+zUBTtxcETtNguet9iO95c/6B8HWu8/6SZPoHmX7+bQvQ5RT7AS5MxpY
 w6qj3eoNEs0rgb9FPiaJZP9xfE2aKeKrEBl5u+/d5HjiSgihPDL5UkQAyM6zdRKgQADS
 X42g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWluznUItXmhf9kU1g03kpClR36MqRq5yifVECGXdrav3+qx4X+shhV4hHo22wcHCKWT/KC56cIafC4ApYdnYlrph0xgHY=
X-Gm-Message-State: AOJu0YzjlOMw2jPHvhWqrSJ89rIwjkrkSDKiSCBwoJrTxZVFG80oJO7H
 SsXkNFeg3SXbJ/FNPDT9KhpwEHW/aHODGjYMYyfX48exUTpJGIbzKnPO1Yv0N7osDdplvPU0xKp
 ibD/1w89gOS5Ec25PfgUMNFYeRfgXjferFrDq5FvrQZAz6/MPSjTxyT88EgoQzL7lCQ==
X-Received: by 2002:a05:600c:cc6:b0:426:6f48:2dad with SMTP id
 5b1f17b1804b1-427daa67d53mr18282615e9.35.1721501174777; 
 Sat, 20 Jul 2024 11:46:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEu8mIK5QZk9FHDwxa5yvjF3BTLvUE9gOetVc+n1uc4qxOpTYdIw12/MtrmksAtnMDG3mbAdQ==
X-Received: by 2002:a05:600c:cc6:b0:426:6f48:2dad with SMTP id
 5b1f17b1804b1-427daa67d53mr18282505e9.35.1721501174234; 
 Sat, 20 Jul 2024 11:46:14 -0700 (PDT)
Received: from redhat.com (mob-5-90-113-158.net.vodafone.it. [5.90.113.158])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d68fa171sm66279965e9.1.2024.07.20.11.46.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Jul 2024 11:46:13 -0700 (PDT)
Date: Sat, 20 Jul 2024 14:46:11 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Yi Liu <yi.l.liu@intel.com>
Cc: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>,
 "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "peterx@redhat.com" <peterx@redhat.com>
Subject: Re: [PATCH v4 4/4] intel_iommu: make types match
Message-ID: <20240720144539-mutt-send-email-mst@kernel.org>
References: <20240705105937.1630829-1-clement.mathieu--drif@eviden.com>
 <20240705105937.1630829-5-clement.mathieu--drif@eviden.com>
 <c592cd1f-f007-42e3-9961-750122e7a6fc@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c592cd1f-f007-42e3-9961-750122e7a6fc@intel.com>
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

On Mon, Jul 08, 2024 at 03:20:45PM +0800, Yi Liu wrote:
> On 2024/7/5 19:01, CLEMENT MATHIEU--DRIF wrote:
> > From: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>
> > 
> > The 'level' field in vtd_iotlb_key is an unsigned integer.
> > We don't need to store level as an int in vtd_lookup_iotlb.
> > 
> > This is not an issue by itself, but using unsigned here seems cleaner.
> 
> a nit to the subject. s/"make types match"/"make type match"/

Hmm not sure I agree.
There are two variables, they have types. We make them match.


> > Signed-off-by: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>
> > ---
> >   hw/i386/intel_iommu.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> > index 37c21a0aec..be0cb39b5c 100644
> > --- a/hw/i386/intel_iommu.c
> > +++ b/hw/i386/intel_iommu.c
> > @@ -358,7 +358,7 @@ static VTDIOTLBEntry *vtd_lookup_iotlb(IntelIOMMUState *s, uint16_t source_id,
> >   {
> >       struct vtd_iotlb_key key;
> >       VTDIOTLBEntry *entry;
> > -    int level;
> > +    unsigned level;
> >       for (level = VTD_SL_PT_LEVEL; level < VTD_SL_PML4_LEVEL; level++) {
> >           key.gfn = vtd_get_iotlb_gfn(addr, level);
> 
> -- 
> Regards,
> Yi Liu


