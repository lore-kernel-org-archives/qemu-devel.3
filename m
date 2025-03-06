Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DB20C282D1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 08:59:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tq74D-0007uU-K3; Thu, 06 Mar 2025 03:58:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tq74B-0007uG-F5
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 03:58:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tq747-00052e-UP
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 03:58:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741251527;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7q2Tv/7YczIE/QdnFeZHTj5srGGkYnJMOuifRsrHJ8k=;
 b=GUp89TY98oGHO9DGaLIMXo46g50EN0v1ak42nAnqVy52o4E4BrsUaWYzhZ1jzTe9UKCVTx
 h2NnL68rVwjyzjfJ5b4VTnHwR466hvB9Az6QjOjCIgqnR0XETcfK0AENDG5pgAGS09nG7V
 OrA0W9l+I5bRdFV/PWb/UcaPAjPIvzk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-591-SVHpoHPlMCKIztlAGBDZoQ-1; Thu,
 06 Mar 2025 03:58:46 -0500
X-MC-Unique: SVHpoHPlMCKIztlAGBDZoQ-1
X-Mimecast-MFC-AGG-ID: SVHpoHPlMCKIztlAGBDZoQ_1741251525
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0CD5419560B0; Thu,  6 Mar 2025 08:58:44 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.112])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 75A3E1955DCE; Thu,  6 Mar 2025 08:58:38 +0000 (UTC)
Date: Thu, 6 Mar 2025 08:58:35 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Yan Vugenfirer <yvugenfi@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 qemu-devel@nongnu.org, pbonzini@redhat.com, mtosatti@redhat.com,
 marcel.apfelbaum@gmail.com, jon.grimm@amd.com,
 santosh.shukla@amd.com, vasant.hegde@amd.com, Wei.Huang2@amd.com,
 kraxel@redhat.com, bsd@redhat.com, ddutile@redhat.com
Subject: Re: [PATCH] pci-ids.rst: Add Red Hat pci-id for AMD IOMMU device
Message-ID: <Z8ljpeR9qcW5fhKC@redhat.com>
References: <20250304183747.639382-1-suravee.suthikulpanit@amd.com>
 <20250305015122-mutt-send-email-mst@kernel.org>
 <CAGoVJZzWqJt-XCOq0GSCg68HYp1DYEEhEUgE-c6a+rd0m-d+cA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGoVJZzWqJt-XCOq0GSCg68HYp1DYEEhEUgE-c6a+rd0m-d+cA@mail.gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Thu, Mar 06, 2025 at 09:11:53AM +0200, Yan Vugenfirer wrote:
> On Wed, Mar 5, 2025 at 8:54 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> 
> > On Tue, Mar 04, 2025 at 06:37:47PM +0000, Suravee Suthikulpanit wrote:
> > > The QEMU-emulated AMD IOMMU PCI device is implemented based on the AMD
> > I/O
> > > Virtualization Technology (IOMMU) Specification [1]. The PCI id for this
> > > device is platform-specific.
> > >
> > > Currently, the QEMU-emulated AMD IOMMU device is using AMD vendor id and
> > > undefined device id.
> >
> > undefined?
> >
> > > Therefore, change the vendor id to Red Hat and request a new
> > QEMU-specific
> > > device id.
> >
> > Won't the drivers fail to load then?
> >
> 
> Windows will not identify the device (it is a dummy device, without driver)
> and SVVP certifications will fail as a result.
> I suggest using ID that is already present in Windows machine.inf:
> VEN_1002&DEV_5A23

 Ven:  Advanced Micro Devices, Inc. [AMD/ATI]
 Dev: RD890S/RD990 I/O Memory Management Unit (IOMMU) 

> VEN_1022&DEV_1419

 Vendor:  Advanced Micro Devices, Inc. [AMD]
 Dev: Family 15h (Models 10h-1fh) I/O Memory Management Unit

Is our implementation semantically a match for the functionality
in either of those real hardware devices ?

We shouldn't use an existing hardware dev ID unless we intend to
emulate its functionality as a precise match.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


