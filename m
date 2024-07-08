Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB8C1C3271E
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2024 12:20:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQnLS-0002rn-BQ; Mon, 08 Jul 2024 08:19:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sQnLQ-0002qz-PU
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 08:19:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sQnLA-0001Y3-AI
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 08:19:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720441169;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xTq5yVqCPZpdXGHaKk+gpskVcgIk8hdEn6rXQlWE1/I=;
 b=UXo2WHrjjOO+oM27+7OvKd+CaB4/KpXASjVjNKP+uoAQH/83l2z1WwleD6DNnTe3VzOtk/
 XSWJKpaaA+etBOjcqED6uaOBpttncP47y+F+hVCBgfOWphZBz/He3fw0gQ2IHtNQ7p97Lv
 Dyp+BbVB+HGxGn/AvZRMifMJdVcDIdc=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-171--Xz1ulRzP5y_QXbjGK5RDg-1; Mon, 08 Jul 2024 08:19:24 -0400
X-MC-Unique: -Xz1ulRzP5y_QXbjGK5RDg-1
Received: by mail-oi1-f200.google.com with SMTP id
 5614622812f47-3d847876c6aso819865b6e.0
 for <qemu-devel@nongnu.org>; Mon, 08 Jul 2024 05:19:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720441164; x=1721045964;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xTq5yVqCPZpdXGHaKk+gpskVcgIk8hdEn6rXQlWE1/I=;
 b=X+LXSxlpuOh11YbiA1uel9EX7b4w64MI5p8ORiPpJB6IRgf7qOX5HEIh3IMsFUj/vW
 meZiVtHIlTlQ4laslJ2MWmJBeKHWch8stM8wQUBHc+U3WsZGRZWzXcG9jfn907oRoOsV
 VdtNJK5S6+lwDtOHKPuu5Bw+NLzs+njYNAp9CnPlwoa+FqQn79TvotTPpwfpho85HJuy
 LgO5sdEe52FuD39YtsDIo+Ig1FcvqUsCNlQECoLyVc+rs7Zva8xsePnS4L0cinh4k7P0
 J5t53HIS6Q6ESIdU0wNSTlhp3wtreEa1z6pQ/M5hmXybcW94e6WCummHsQ9PQVjS7lMb
 NLEQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVhEX6hKSyH1NQqn7t2vyaAq3UG+mt5nZzjAytTI1+Hd+zr7rruVyurE87zMMiHNlVf8IvLE+ty102t7jLHHlc5bggJu74=
X-Gm-Message-State: AOJu0YzNvXzWzDbXHBRWceGfMpj1osmIHmjUZwl1XojQX6T0Cqi3m8+X
 1xdtex/jKPDGg8jeWAH4Hgkul7eI3ljkblLD3idBgTz8NhwzcWIRWKJSMz7rk/sXO4/7667ksVR
 6Zo06GdyIHpFFfecOntGDJ60dC8dHiIjCuScMzZuqYThP61m19ye8
X-Received: by 2002:a05:6871:24d7:b0:24f:e599:9168 with SMTP id
 586e51a60fabf-25e2b8d0139mr10961280fac.1.1720441163983; 
 Mon, 08 Jul 2024 05:19:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFp0vN4aYOGfXNtHyd+Lm2sILPqB3LDc9BWEmJ4Nd6Y8z6B8w377JqbcOtizHxUTEyK2iLF8A==
X-Received: by 2002:a05:6871:24d7:b0:24f:e599:9168 with SMTP id
 586e51a60fabf-25e2b8d0139mr10961267fac.1.1720441163569; 
 Mon, 08 Jul 2024 05:19:23 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-79d69264fc0sm1073361385a.1.2024.07.08.05.19.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jul 2024 05:19:23 -0700 (PDT)
Date: Mon, 8 Jul 2024 08:19:22 -0400
From: Peter Xu <peterx@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Yi Liu <yi.l.liu@intel.com>, mst@redhat.com, qemu-devel@nongnu.org
Subject: Re: [PATCH] MAINTAINERS: Add myself as a VT-d reviewer
Message-ID: <ZovZSuGwvkE5--Tc@x1n>
References: <20240708032112.796339-1-yi.l.liu@intel.com>
 <CACGkMEtZ7yDzvGQOj9txFiYzaHgTtmHeeZmLH+uoxEBwkN0NDg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEtZ7yDzvGQOj9txFiYzaHgTtmHeeZmLH+uoxEBwkN0NDg@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Mon, Jul 08, 2024 at 11:24:48AM +0800, Jason Wang wrote:
> On Mon, Jul 8, 2024 at 11:21 AM Yi Liu <yi.l.liu@intel.com> wrote:
> >
> > Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> > ---
> >  MAINTAINERS | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 6725913c8b..61724b91d8 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -3656,6 +3656,7 @@ F: tests/uefi-test-tools/
> >  VT-d Emulation
> >  M: Michael S. Tsirkin <mst@redhat.com>
> >  R: Jason Wang <jasowang@redhat.com>
> > +R: Yi Liu <yi.l.liu@intel.com>
> >  S: Supported
> >  F: hw/i386/intel_iommu.c
> >  F: hw/i386/intel_iommu_internal.h
> > --
> > 2.34.1
> >
> 
> Acked-by: Jason Wang <jasowang@redhat.com>
> 
> Thanks!

Acked-by: Peter Xu <peterx@redhat.com>

Thanks!!

-- 
Peter Xu


