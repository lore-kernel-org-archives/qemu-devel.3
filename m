Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F44AC52D71
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2024 09:14:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1scLhB-00057U-Oc; Fri, 09 Aug 2024 05:14:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1scLhA-00056F-NF
 for qemu-devel@nongnu.org; Fri, 09 Aug 2024 05:14:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1scLh8-0006H7-Mb
 for qemu-devel@nongnu.org; Fri, 09 Aug 2024 05:14:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723194837;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uFrra4R8yOLqWRrGK3eT9VFxFEpTpBMMZdWcI907WFU=;
 b=fBH6DVyYqd1UTBlfwokAWa+MjLZ6OYlvwqAp6F03wJ6l+/CXdxuWGqJ07P+56uoyjJM512
 pgUVKqqDSvN+0j0L3XfG7x+SrxOTKmJysXSQcJHrjmnGPo6RGuvfj3f18u2c1t3p9sPEo7
 0fDPFxR2oHn5Lng6NJZ8uqmHDzsvkw4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-557-9d2e-TY0PSmn2hkXj1ZTKA-1; Fri,
 09 Aug 2024 05:13:54 -0400
X-MC-Unique: 9d2e-TY0PSmn2hkXj1ZTKA-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 287F719560B6; Fri,  9 Aug 2024 09:13:53 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.27])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9F51519560AE; Fri,  9 Aug 2024 09:13:47 +0000 (UTC)
Date: Fri, 9 Aug 2024 10:13:44 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Octavian Purdila <tavip@google.com>
Cc: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, stefanst@google.com,
 pbonzini@redhat.com, thuth@redhat.com, peter.maydell@linaro.org,
 marcandre.lureau@redhat.com, alistair@alistair23.me,
 philmd@linaro.org, jsnow@redhat.com, crosa@redhat.com, bleal@redhat.com
Subject: Re: [RFC PATCH 04/23] hw/arm: add SVD file for NXP i.MX RT595
Message-ID: <ZrXdyEIFLulMN-gE@redhat.com>
References: <20240805201719.2345596-1-tavip@google.com>
 <20240805201719.2345596-5-tavip@google.com>
 <87sevhrbjm.fsf@draig.linaro.org>
 <CAGWr4cTPqtzEvbd5s7xfMOzid90Gje6NSTGw1qR7r=Ao0xeAcw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGWr4cTPqtzEvbd5s7xfMOzid90Gje6NSTGw1qR7r=Ao0xeAcw@mail.gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Aug 06, 2024 at 01:31:51PM -0700, Octavian Purdila wrote:
> On Tue, Aug 6, 2024 at 7:06 AM Alex Bennée <alex.bennee@linaro.org> wrote:
> >
> > Octavian Purdila <tavip@google.com> writes:
> >
> > > Picked from:
> > >
> > > https://github.com/nxp-mcuxpresso/mcux-soc-svd/blob/main/MIMXRT595S/MIMXRT595S_cm33.xml
> > >
> > > NOTE: the file is truncated to keep the email size reasonable. Please
> > > use the link above and download the full file if you want to try out
> > > the patch.

"the file is truncated" wins understatement of the week.

The full XML file that would need to be in QEMU git for this is 8.6 MB in
size.

The overall generated headers that we get from it are ~16k lines,
or ~0.5 MB

$ wc -l build/hw/arm/svd/*.h
   135 build/hw/arm/svd/flexcomm.h
  1227 build/hw/arm/svd/flexcomm_i2c.h
  1161 build/hw/arm/svd/flexcomm_spi.h
  1231 build/hw/arm/svd/flexcomm_usart.h
  2243 build/hw/arm/svd/flexspi.h
  3100 build/hw/arm/svd/rt500_clkctl0.h
  4022 build/hw/arm/svd/rt500_clkctl1.h
    64 build/hw/arm/svd/rt500.h
  1073 build/hw/arm/svd/rt500_rstctl0.h
  1697 build/hw/arm/svd/rt500_rstctl1.h
 15953 total

$ wc -c build/hw/arm/svd/*.h
  4349 build/hw/arm/svd/flexcomm.h
 51135 build/hw/arm/svd/flexcomm_i2c.h
 43822 build/hw/arm/svd/flexcomm_spi.h
 46331 build/hw/arm/svd/flexcomm_usart.h
 89224 build/hw/arm/svd/flexspi.h
113952 build/hw/arm/svd/rt500_clkctl0.h
141885 build/hw/arm/svd/rt500_clkctl1.h
  1881 build/hw/arm/svd/rt500.h
 38881 build/hw/arm/svd/rt500_rstctl0.h
 61449 build/hw/arm/svd/rt500_rstctl1.h
592909 total



> > >
> > > Signed-off-by: Octavian Purdila <tavip@google.com>
> > > ---
> > >  hw/arm/svd/MIMXRT595S_cm33.xml | 224052
> > > ++++++++++++++++++++++++++++++
> >
> > I guess one thing we need to decide is if the source XML should live in
> > the repository as the preferred method of making changes or just the
> > translations generated by the tool.
> >
> 
> I think we might want to store the XML in the qemu repo, even if we
> don't use it to generate the header files at compile time. This avoids
> issues with the original XML moving, going away, changed in
> incompatible ways, etc.
>
> As for generating the headers at compile time, I don't have a strong
> preference. I like it because there is slightly less work to do and it
> avoids dealing with resolving changes on both the SVD and the
> generated headers. For example, the initial headers are committed,
> then some changes are done directly to the headers and then we want to
> pick up a new SVD from the vendor to support a new hardware revision.

IIUC the structs/enums/etc are defining guest ABI. So if we want to
preserve guest ABI for these devices across QEMU releases, we don't
want the generated output to be arbitrarily changing. If there are
different revisions of a device, we might need separate structs for
each maintained in parallel.



> 
> There are disadvantages as well: pysvd dependency for building qemu,
> hard to review if the vendor dumps a new version with lots of changes
> and we want to update to it for a new hardware revision, slight
> increase in build time.
> 
> > >  1 file changed, 224052 insertions(+)
> > >  create mode 100644 hw/arm/svd/MIMXRT595S_cm33.xml
> > >
> > > diff --git a/hw/arm/svd/MIMXRT595S_cm33.xml b/hw/arm/svd/MIMXRT595S_cm33.xml
> > > new file mode 100644
> > > index 0000000000..8943aa3555
> > > --- /dev/null
> > > +++ b/hw/arm/svd/MIMXRT595S_cm33.xml
> > > @@ -0,0 +1,1725 @@
> > > +<?xml version="1.0" encoding="UTF-8"?>
> > > +<device schemaVersion="1.3" xmlns:xs="http://www.w3.org/2001/XMLSchema-instance" xs:noNamespaceSchemaLocation="CMSIS-SVD.xsd">
> > > +  <vendor>nxp.com</vendor>
> > > +  <name>MIMXRT595S_cm33</name>
> > > +  <version>1.0</version>
> > > +  <description>MIMXRT595SFAWC,MIMXRT595SFFOC</description>
> > > +  <licenseText>
> > > +Copyright 2016-2023 NXP
> > > +SPDX-License-Identifier: BSD-3-Clause
> > > +  </licenseText>
> >
> > This certainly seems compatible. XML is not the medium I personally
> > would have chosen as a register specification language but I guess there
> > are no other alternatives?
> >
> 
> I agree that the choice of XML is unfortunate but I am not aware of
> alternatives, this is what vendors will provide.

Given the size of the XML I'm inclined to say that we should just be
committing the generated header files to qemu.git

Then add https://github.com/nxp-mcuxpresso/mcux-soc-svd as a git
submodule, and provide some meson rules for triggering re-generation
that are off-by-default.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


