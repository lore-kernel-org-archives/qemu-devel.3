Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71B83C54FB3
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Jun 2025 10:19:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uM2FO-0004m9-Fe; Mon, 02 Jun 2025 06:18:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uM2FM-0004la-Rg
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 06:18:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uM2FK-0005M2-US
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 06:18:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748859497;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MelZ/UKf7Sf6tZkePSBf9ugkdI2MHE2OHWmwLvm1iwI=;
 b=AO1vG6fC+aMWhdCnDjWgLC5QoEj+L4FdkQT7ixgJ04K1pRYLHDH3CbrTSuumARNOUNgIvK
 IQbcbhlvJcxfsP6elDK8xi9l1EmhTizoF04iYkcK7xslkM3KneuhDa8UrGBtF//sVjiSJj
 PgeZua7du++raSD6w7WiF/9uURyEGY0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-225-4ZEXcAAjN3KnOk9vegmIuw-1; Mon, 02 Jun 2025 06:18:16 -0400
X-MC-Unique: 4ZEXcAAjN3KnOk9vegmIuw-1
X-Mimecast-MFC-AGG-ID: 4ZEXcAAjN3KnOk9vegmIuw_1748859495
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3a4f8fd1856so1298020f8f.2
 for <qemu-devel@nongnu.org>; Mon, 02 Jun 2025 03:18:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748859495; x=1749464295;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MelZ/UKf7Sf6tZkePSBf9ugkdI2MHE2OHWmwLvm1iwI=;
 b=ZXqAcmPCuPQCj3IDnypJxgdOgmr9zBNRsJVCeVwbOzpTgHUGnEMfg6TQJ1bdFRTFhV
 gmEriYHAohKyx7GSS8e6tudgY2862GhyGlW9VF9hTGYVkTyXYdJgSRpXGJmqIiqmHFcb
 6RLzLN+LA8v9bN5q/eqGFnhRFuV8DniArZAuC2oDEF2ZbR5j+4EE25x/FkuWUp4s9ah/
 fipkqfdXfr+yKP3BVtTYvdNKb6YqtcOGbLFO9AkUjHVSFEK2xuV5aqdQm3rFFTIGmZgU
 ZRM8QNEv8urVX17mqPMbJtQDSorDyVsLJ5QwNLYWOztTIig4Jl9jKUgErmwhJZRfqGqR
 CMHQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUgMQGRrU+JrZLyQe1Ok0X94mOubwJMwBj2rHyo145648JVTBqYo4d5PUPcO/dIuJgC3hQr4rwVOS1N@nongnu.org
X-Gm-Message-State: AOJu0YzNYsl8MVxRSox/eGPhdrn6sUAHxO6exVEaYtwgkyHJ56dtPY+X
 2LndZo/NoMONuJxZPMV9PDyWZTQLQOpbqrVYeSP9AQLaRXQFvcxgmlSDnfgLIFh5wiBg0XoyImT
 Lo9vwADBzHNdlV3kYdmjFjHE8IjRVKc/ktlysiCtTOXhH1Uo4oiv1Cfyw
X-Gm-Gg: ASbGncuOdCsdQap4DKdf86y5UnaBPcBvXZEpSu0iJQy+aoVfTcPKlVTEBHDL5Pjvp2X
 uQAB8ticaBQCgF0dM2N1S8hV3fGiRIvFUkOTg51E2l21KBxPbk3wBNkVY7Pt/XzkXk3zedM4wc0
 YGC7L95MiAUK9Laat6RTj3bqGZjCMOKzedgfu0wO1bh4FrXp+KJLaE4h4qH/hi2M/A96wcRZyXd
 c367ztzerH3S9Tt4tQBVVGv4lP746L/epmJsazNLTmzoAo4ixK31sP2OpcrFQ7bKVp98d43Y3Ri
 ogGKS5uG6DX0j5Aa4VPzj007jcMOpXtBnP8xjBjBzfc=
X-Received: by 2002:a05:6000:250e:b0:3a3:7cbd:39b1 with SMTP id
 ffacd0b85a97d-3a4fe17c35emr6329275f8f.24.1748859495322; 
 Mon, 02 Jun 2025 03:18:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGFOZTLbRohg+R6GvDT/JPmv8dafLWrT4JIkj4D8Tc67CSXqCV5HYdlSebUF+SKSW+9TIufkg==
X-Received: by 2002:a05:6000:250e:b0:3a3:7cbd:39b1 with SMTP id
 ffacd0b85a97d-3a4fe17c35emr6329239f8f.24.1748859494824; 
 Mon, 02 Jun 2025 03:18:14 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com ([85.93.96.130])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4f009ff11sm14127324f8f.86.2025.06.02.03.18.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Jun 2025 03:18:14 -0700 (PDT)
Date: Mon, 2 Jun 2025 12:18:10 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Eric Auger <eric.auger@redhat.com>, <eric.auger.pro@gmail.com>,
 <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>, <peter.maydell@linaro.org>,
 <gustavo.romero@linaro.org>, <anisinha@redhat.com>, <mst@redhat.com>,
 <shannon.zhaosl@gmail.com>, <pbonzini@redhat.com>, <philmd@linaro.org>,
 <alex.bennee@linaro.org>
Subject: Re: [PATCH v2 05/25] hw/pci-host/gpex-acpi: Split host bridge OSC
 and DSM generation
Message-ID: <20250602121810.649d82ce@imammedo.users.ipa.redhat.com>
In-Reply-To: <20250530160019.000061d1@huawei.com>
References: <20250527074224.1197793-1-eric.auger@redhat.com>
 <20250527074224.1197793-6-eric.auger@redhat.com>
 <20250530110227.00003341@huawei.com>
 <20250530140516.35db4d52@imammedo.users.ipa.redhat.com>
 <20250530160019.000061d1@huawei.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.071,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Fri, 30 May 2025 16:00:19 +0100
Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:

> On Fri, 30 May 2025 14:05:16 +0200
> Igor Mammedov <imammedo@redhat.com> wrote:
> 
> > On Fri, 30 May 2025 11:02:27 +0100
> > Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:
> >   
> > > On Tue, 27 May 2025 09:40:07 +0200
> > > Eric Auger <eric.auger@redhat.com> wrote:
> > >     
> > > > acpi_dsdt_add_pci_osc() name is confusing as it gives the impression
> > > > it appends the _OSC method but in fact it also appends the _DSM method
> > > > for the host bridge. Let's split the function into two separate ones
> > > > and let them return the method Aml pointer instead. This matches the
> > > > way it is done on x86 (build_q35_osc_method). In a subsequent patch
> > > > we will replace the gpex method by the q35 implementation that will
> > > > become shared between ARM and x86.
> > > > 
> > > > acpi_dsdt_add_host_bridge_methods is a new top helper that generates
> > > > both the _OSC and _DSM methods.
> > > > 
> > > > Signed-off-by: Eric Auger <eric.auger@redhat.com>
> > > > Reviewed-by: Gustavo Romero <gustavo.romero@linaro.org>      
> > > 
> > > Makes complete sense. I've had local equivalent of this on the CXL
> > > tree for a while as without it we don't register the _DSM for the
> > > CXL path (and we should).  However, can you modify it a little to
> > > make that easier for me?  Basically make sure the _DSM is registered
> > > for the CXL path as well.
> > >     
> > [...]
> > unless CXL is root host bridge, current _DSM shouldn't be added to it.
> > read on comment below.  
> 
> I'm not clear how this is different from pxb-pcie where we do have
> the _DSM. Both are pretending to be real host bridges.

there is some space for _OSC consolidation, but it's not realy related to pcihp,
so I'd rather do it as a separate series on top. 

current PCI _DSM and _CXL one (build_cxl_dsm_method) are implementing
different namespaces, there is not much to consolidate there.

If later on CXL would need E5C937D0-3553-4D7A-9117-EA4D19C3434D,
then, I'd say do it at that time and use that moment as an opportunity
to consolidate.

> >   
> > > > @@ -124,7 +125,17 @@ static void acpi_dsdt_add_pci_osc(Aml *dev, bool enable_native_pcie_hotplug)
> > > >      byte_list[0] = 0;
> > > >      buf = aml_buffer(1, byte_list);
> > > >      aml_append(method, aml_return(buf));
> > > > -    aml_append(dev, method);
> > > > +    return method;
> > > > +}
> > > > +
> > > > +static void acpi_dsdt_add_host_bridge_methods(Aml *dev,
> > > > +                                              bool enable_native_pcie_hotplug)
> > > > +{
> > > > +    aml_append(dev, aml_name_decl("SUPP", aml_int(0)));
> > > > +    aml_append(dev, aml_name_decl("CTRL", aml_int(0)));      
> > > 
> > > These two declarations seem to be very much part of the _OSC build though not
> > > within the the method.  I 'think' you get left with them later with no users.
> > > So move them into the osc build here and they will naturally go away when
> > > you move to the generic code.
> > > 
> > > They end up unused in the DSDT at the end of the series.
> > > 
> > > I ran a quick GPEX + pxb-pcie test and we do get the odd mix that the OSC for
> > > the GPEX say no native hotplug but the OSC for the PXB allows it.    
> > 
> > It's fine for each PXB to have it's own _OSC.
> > Also current incarnation of ACPI pcihp doesn't support PXBs at all,
> > it would be wrong to enable the on PXBs.
> > 
> > Thus I'd avoid touching CXL related code paths from this series.
> > 
> > I'm working on extending ACPI pcihp to PXBs
> > (for the same reason as Eric does for arm/virt, i.e. enable acpi-index support there).
> > I can add CXL bits then if there is a need/demand for that in CXL land.  
> 
> Ok.  My original motivation for _DSM on CXL was function 5 to stop Linux messing up
> the reenumeration which I know has been rejected upstream for a bunch of
> compatibility reasons.  Anyhow, that's a future problem.

yep, let's worry about merging _DSMs when that future comes.

> 
> Thanks,
> 
> Jonathan
> 
> > 
> > [...]
> > 
> >   
> 


