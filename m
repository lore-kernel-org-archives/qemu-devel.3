Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EDAACDB475
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 19:45:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbka5-0005if-KY; Mon, 22 Jun 2026 15:45:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wbka4-0005iP-BC
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 15:45:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wbkZs-0004Ug-Ec
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 15:45:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782157502;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/r0zybNsLAP35GUJj9NU9qaV2oxViFxnkPWdhaAlQcU=;
 b=PLjjzhi5vceq15jiAbUrvs8HosoVJE/Hlgrt3s2x8A0yaHB2H+3YZo3ts/Cj6geMm37cwk
 CfQWJ9odSBNUpLS6DOcqiS+h7oKnVFyk5ekKXQ0L4qJErz0tpSXQ7R7VvFTaCybQDuslKZ
 ORmKMpCuAdBVOEdzGySLShd9scj08O0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-17-M6wF9TDVPPCtDU9Y-QJnqQ-1; Mon, 22 Jun 2026 15:45:00 -0400
X-MC-Unique: M6wF9TDVPPCtDU9Y-QJnqQ-1
X-Mimecast-MFC-AGG-ID: M6wF9TDVPPCtDU9Y-QJnqQ_1782157499
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-492488f8583so24626105e9.2
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 12:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782157499; x=1782762299; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=/r0zybNsLAP35GUJj9NU9qaV2oxViFxnkPWdhaAlQcU=;
 b=k9YM3FF5eUwfMfSkDciQm9M06H29JMzz+YobxRd8dgg3zDlpfIG7LTKzMrdbKFve9H
 8OfH68OPjD+SIq0dgzdTvobC2lkdxZylBMx+PXi07eLpBq+qLC70sP6am/Gp2DfnihsD
 hnJZv+zNESXk45DI3gRtzJ0+AG968fO02XDKd5Lbe7z8h6nBUhbPDhrHHv0DprUsaTjZ
 6Pk8tIhJNtS35bJ27XrlrG4CA/Z+dqc3bgaUnyW7iUOH5tZSmYgFco33iuCGcWBTuBS1
 A80vYq6/M0KjhwEzC16qRmE/CeM2MWJvAcIIaSDqHhCEXQoNb8IOKzzQkwaPiRTWB6Pm
 3oLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782157499; x=1782762299;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/r0zybNsLAP35GUJj9NU9qaV2oxViFxnkPWdhaAlQcU=;
 b=NmH+GjiXk+vlPQgIrEodmFEcS4b0cTMMyOT3YpDe05eHe8pH5QDoVc4H0y12aFmI11
 InDEBYoVj1lomcINElK4US9Vs6LVYXHZGV/vdFWt3QfoN6GC1L5CgdpOPo1Z9o6Pejwh
 xOpxA//yi7gH8epEhLKIboYx05LqS6G9+0GO82CFCqbFl9wlp3qiacRlWGtmnf9tFQ8T
 eZ5NA9+bXjSApBmcroQlYanuV8zC4+dz3p0PGMa4+CR3XZVYCdocXmL+Lzf7RiZ3ny1V
 OTv0fzRlSrprk0ppkvSwt4JRey3SwN8zGu6FPJfOP/wQBR+NUTVh5Mca10nroUjd+kF/
 iTFQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+lrWK7Qg5kJOExNCzTudXvfkBM64KprGcEGcZnsyRsBdefUPxRrcTtjR5u7NkvOegtOZgmVsSUjRNN@nongnu.org
X-Gm-Message-State: AOJu0YwbqUEbdnifv8ASoA45zF/fJqzgHerHnuA8wSIF7Opuxkfrb4uP
 qS+n/mUJp3j3yzKxRTIije0WddnGqoNA8oHlYyAdTlzY5wLHN/9CrWg5JeYpmtFB2lb8ffeMRMp
 xrI2C49BC6ZEUUN9J+3aOjMMNZhY20B0XF+RWg60KL6giZ+Sqoy932IVJDW/O8eAR
X-Gm-Gg: AfdE7cmzwDZBOjs0655qcFbE45Fbs8/FPYAX8kczFD75q111bvG7qK7jb4tyaQ84KIl
 bBYR2a3+0lG5dO6DIGQjK3HjDyrgs/Hy3XzxdqePM6Phb6vnk8PS0S0OM81BA9GDs+NoWl9j44I
 owWzJ8cSCm10HKpRWujYvRWBi1UKr8pG1CJ3/3u0Zpi/oGMe1jjScEjVqMMdOQQG4xxbEqF/kUW
 q1OmmhqgiUE3xCClsEQbL2aFWnHpBm3ASrvKisGp5YHZoUfuvuAmKB4oxDNYCnaN4EgDGB64XCZ
 Presr4AtYD3WjVlCHOnPISF/KdpvjL23hy4RR1rluDPSyrXGKRBdCGWydA7rbkladuasu9iaW3E
 adTJVPVnJkxdRvbRFq6qn+Rt281xUzE/J
X-Received: by 2002:a05:600c:a40f:b0:492:432b:d78b with SMTP id
 5b1f17b1804b1-492432bdad3mr193558475e9.15.1782157499300; 
 Mon, 22 Jun 2026 12:44:59 -0700 (PDT)
X-Received: by 2002:a05:600c:a40f:b0:492:432b:d78b with SMTP id
 5b1f17b1804b1-492432bdad3mr193558315e9.15.1782157498788; 
 Mon, 22 Jun 2026 12:44:58 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4666678828dsm28453274f8f.19.2026.06.22.12.44.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 12:44:58 -0700 (PDT)
Date: Mon, 22 Jun 2026 15:44:55 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: =?iso-8859-1?Q?Cl=E9ment?= MATHIEU--DRIF <clement.mathieu--drif@bull.com>
Cc: no92 <leo@managarm.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>,
 "qemu-stable@nongnu.org" <qemu-stable@nongnu.org>,
 Jason Wang <jasowang@redhat.com>, Yi Liu <yi.l.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH] hw/i386/x86-iommu: Correctly set pt bit in extended
 capability register
Message-ID: <20260622154210-mutt-send-email-mst@kernel.org>
References: <20260622162138.1045170-1-leo@managarm.org>
 <0b93c0b06c39f7dc6faa7ab21f57034081df83dd.camel@bull.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0b93c0b06c39f7dc6faa7ab21f57034081df83dd.camel@bull.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Jun 22, 2026 at 05:31:01PM +0000, Clément MATHIEU--DRIF wrote:
> Hi,
> 
> I think I have seen this patch at least twice in the list o.O
> 
> It seems it has not been merged into master yet (@Michael, do you want me to send a rebased version?).

rebased or not, I was not CC'd.


> https://patchew.org/QEMU/CAFFE2avrHDKZd5m7j3E3x5=F=pzn-3c9vzGWP3+9-AVPwQng7w@mail.gmail.com/
> 
> Thanks for the effort though ;)  
> 
> cmd

i can pick this one or wait for your patch.

> 
> On Mon, 2026-06-22 at 18:21 +0200, no92 wrote:
> > Caution: External email. Do not open attachments or click links, unless this email comes from a known sender and you know the content is safe.
> > 
> > 
> > With the changes in c7b2e22bd957, the `pt` bit was set in the (wrong)  
> > capability register, instead of the (correct) extended capability  
> > register.
> > 
> > Fixes: c7b2e22bd95710e404c393e9f563cfe7404220c1 ("hw/i386/x86-iommu: Remove X86IOMMUState::pt_supported field")  
> > Signed-off-by: no92 <[leo@managarm.org](mailto:leo@managarm.org)>  
> > ---  
> >  hw/i386/intel_iommu.c | 4 ++--  
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c  
> > index 744cdfd2e6..d1af7a3135 100644  
> > --- a/hw/i386/intel_iommu.c  
> > +++ b/hw/i386/intel_iommu.c  
> > @@ -4988,7 +4988,7 @@ static void vtd_cap_init(IntelIOMMUState *s)  
> >  {  
> >      X86IOMMUState *x86_iommu = X86_IOMMU_DEVICE(s);
> > 
> > -    s->cap = VTD_CAP_FRO | VTD_CAP_NFR | VTD_CAP_ND | VTD_ECAP_PT |  
> > +    s->cap = VTD_CAP_FRO | VTD_CAP_NFR | VTD_CAP_ND |  
> >               VTD_CAP_MAMV | VTD_CAP_PSI | VTD_CAP_SSLPS | VTD_CAP_DRAIN |  
> >               VTD_CAP_ESRTPS | VTD_CAP_MGAW(s->aw_bits);  
> >      if (x86_iommu->dma_translation) {  
> > @@ -4999,7 +4999,7 @@ static void vtd_cap_init(IntelIOMMUState *s)  
> >                      s->cap |= VTD_CAP_SAGAW_48bit;  
> >              }  
> >      }  
> > -    s->ecap = VTD_ECAP_QI | VTD_ECAP_IRO;  
> > +    s->ecap = VTD_ECAP_QI | VTD_ECAP_IRO | VTD_ECAP_PT;
> > 
> >      if (x86_iommu_ir_supported(x86_iommu)) {  
> >          s->ecap |= VTD_ECAP_IR | VTD_ECAP_MHMV;  
> > --  
> > 2.54.0
> > 


