Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69359C3271E
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2024 02:51:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sR0xB-00027X-Ry; Mon, 08 Jul 2024 22:51:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1sR0xA-00022E-ED
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 22:51:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1sR0x8-0004zi-UE
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 22:51:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720493498;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OA8bFMklEuyOjtQBEPuHdk0sWxOcKI40ostgyJ61G9g=;
 b=IfgoyuGLtjy/kKjCJjClHxS7XJqcP6R7LlVt70P1YDimX+mDmtQwjfw3fPNyC+MjnA3Mqf
 lally7WiS4o5jfqYubJHxyPZ6h9mbfqaYrS7xssURoJ8Oxcot7YKCHWn39l8NF+p5krQfL
 ridGUABuhj9DLe2NtwP0mzM1f1rT+Gs=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-j2Y4Kz74O3qI2dzg6Z276w-1; Mon, 08 Jul 2024 22:51:36 -0400
X-MC-Unique: j2Y4Kz74O3qI2dzg6Z276w-1
Received: by mail-ot1-f71.google.com with SMTP id
 46e09a7af769-7036e5add8dso1312470a34.2
 for <qemu-devel@nongnu.org>; Mon, 08 Jul 2024 19:51:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720493496; x=1721098296;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OA8bFMklEuyOjtQBEPuHdk0sWxOcKI40ostgyJ61G9g=;
 b=iO3UdWj7kWM8UTqVjswFdcYtOOFJwOhBziPXLyY1eeSyQauESws53jhPjhkCvFpjZh
 pHCPX/fwFKciJ0+fW9zKECxsmBEvs1hEurr986HMGGD9b2qYgw3ij/L996rHTaSz8Ot3
 ebCPgK+TnlLRIU5XIXhR37/jObRu56qafN54VRoldiUZZ05z3kK1VMRQCIP0ZlTS+bIM
 cHY701BavhxbYGsTFY+PyFcnQIa239cWH6G5rb3jk0V0rJTuvkC3B5zz48qvtixdiHDR
 q5I0Xkcl5vk8A6BFYdV7xenFH2aDMp1QyJ4QCJR21PqbT8TMysf/9TzfepG/5WB9RTnQ
 s4cg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUg7ZIe88sg1OWV1mG9abgQ7yPabI/TcJufc1Cdftu8L2AbBzrXXvBgo1jtXK+h6srfCnTfqvqMAQeKSwMgwUXTGZyYMCQ=
X-Gm-Message-State: AOJu0YxPMzf4u4A0FWfc/Mzbpd8P/usUt5SBhUPEgrliBoMT7fBy9Ytx
 5dBCwTFMadZNR7qteRQYU9qcBNvG1WWMV8X4GLA2bMlfYrfFF4Ig8ZQ/9YN3Ix+PNRgY209ltYu
 cP+xZuZUa5vgGXKBQGh6XNKIawFzpIcqN5fVA+Wq5UD3Czm4xMB5p967+8SEz1RI/rrgaq2fGGG
 rIqtXOZOXr7GMwSJSeGOI3N/cy8IU=
X-Received: by 2002:a05:6870:1728:b0:25e:ff1:8314 with SMTP id
 586e51a60fabf-25eae88a814mr670145fac.33.1720493496027; 
 Mon, 08 Jul 2024 19:51:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFm3jWcRiJExUB1Lmo7e1k/13jDtySth6pSXUJc5m4mqhgTn2nKPzl0o/jPZnSi3OcbRbc6M2xpTpInF4TNSg4=
X-Received: by 2002:a05:6870:1728:b0:25e:ff1:8314 with SMTP id
 586e51a60fabf-25eae88a814mr670132fac.33.1720493495583; Mon, 08 Jul 2024
 19:51:35 -0700 (PDT)
MIME-Version: 1.0
References: <20240705105937.1630829-1-clement.mathieu--drif@eviden.com>
 <20240705105937.1630829-2-clement.mathieu--drif@eviden.com>
 <c8bd5b18-9e49-44f1-a1d3-05bd02a91bc5@intel.com>
In-Reply-To: <c8bd5b18-9e49-44f1-a1d3-05bd02a91bc5@intel.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 9 Jul 2024 10:51:24 +0800
Message-ID: <CACGkMEvwBvjRQ5tpJLCHRfL6FRQHEGrT+FD2v1GpAmt5EGJzhQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] intel_iommu: fix FRCD construction macro
To: Yi Liu <yi.l.liu@intel.com>
Cc: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>, 
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, 
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>,
 "kevin.tian@intel.com" <kevin.tian@intel.com>, 
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "peterx@redhat.com" <peterx@redhat.com>, "mst@redhat.com" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
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

On Mon, Jul 8, 2024 at 3:04=E2=80=AFPM Yi Liu <yi.l.liu@intel.com> wrote:
>
> On 2024/7/5 19:01, CLEMENT MATHIEU--DRIF wrote:
> > From: Cl=C3=A9ment Mathieu--Drif <clement.mathieu--drif@eviden.com>
> >
> > The constant must be unsigned, otherwise the two's complement
> > overrides the other fields when a PASID is present.
> >
> > Fixes: 1b2b12376c8a ("intel-iommu: PASID support")
> >
>
> The extra line behind the "Fixes tag" is not needed.
>
> > Signed-off-by: Cl=C3=A9ment Mathieu--Drif <clement.mathieu--drif@eviden=
.com>
> > Reviewed-by: Yi Liu <yi.l.liu@intel.com>
> > Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> > ---
> >   hw/i386/intel_iommu_internal.h | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_inter=
nal.h
> > index f8cf99bddf..cbc4030031 100644
> > --- a/hw/i386/intel_iommu_internal.h
> > +++ b/hw/i386/intel_iommu_internal.h
> > @@ -267,7 +267,7 @@
> >   /* For the low 64-bit of 128-bit */
> >   #define VTD_FRCD_FI(val)        ((val) & ~0xfffULL)
> >   #define VTD_FRCD_PV(val)        (((val) & 0xffffULL) << 40)
> > -#define VTD_FRCD_PP(val)        (((val) & 0x1) << 31)
> > +#define VTD_FRCD_PP(val)        (((val) & 0x1ULL) << 31)
> >   #define VTD_FRCD_IR_IDX(val)    (((val) & 0xffffULL) << 48)
> >
> >   /* DMA Remapping Fault Conditions */
>
> It might be fine to squash patch 02 of this series into this one. @Jason?

Not sure, we may need this for -stable. So having a standalone patch
doesn't hurt.

Thanks

>
> --
> Regards,
> Yi Liu
>


