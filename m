Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BCE7F3C241
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 12:58:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzaBR-0003L8-4i; Mon, 09 Mar 2026 08:58:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vzaBP-0003Ks-5N
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 08:58:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vzaBM-0006hz-Iw
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 08:58:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773061079;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Eki4EvHTGYoNeJiEUtTyjLXLtrxBK6SRB8WCEFmaoNI=;
 b=RRwkNkHH9iTi74vCrvC3hsfQeJRB6V2oZuhA8YVzGScwm/IgbpiKLZ6hGqNJol1lZEq+RG
 B3/aJFro1rbcDSgZtWXNx+jlbkt20OOKDvZr6nlQijuJI9OwCLH79Meedmte0tl9s3gJrN
 isjBe3dgUz1LqtZR0wFxHfjifysKSfM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-423-7FMtmn-NMnexCsZvOSmmNw-1; Mon,
 09 Mar 2026 08:57:55 -0400
X-MC-Unique: 7FMtmn-NMnexCsZvOSmmNw-1
X-Mimecast-MFC-AGG-ID: 7FMtmn-NMnexCsZvOSmmNw_1773061073
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9A4D81954236; Mon,  9 Mar 2026 12:57:47 +0000 (UTC)
Received: from redhat.com (unknown [10.44.33.95])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5926A18002A6; Mon,  9 Mar 2026 12:57:43 +0000 (UTC)
Date: Mon, 9 Mar 2026 12:57:39 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org,
 mst@redhat.com, jasowang@redhat.com, clg@redhat.com,
 nathanc@nvidia.com, Yi Liu <yi.l.liu@intel.com>,
 =?utf-8?Q?Cl=C3=A9ment?= Mathieu--Drif <clement.mathieu--drif@bull.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] intel_iommu: Remove 'x-' prefix from 'x-scalable-mode'
 and 'x-flts' properties
Message-ID: <aa7Dw5PBcqLpG5HC@redhat.com>
References: <20260309092027.404489-1-zhenzhong.duan@intel.com>
 <02d2312f-99a8-44b2-b55a-b9cbc72feb60@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <02d2312f-99a8-44b2-b55a-b9cbc72feb60@linaro.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Mar 09, 2026 at 01:44:15PM +0100, Philippe Mathieu-Daudé wrote:
> Hi,
> 
> On 9/3/26 10:20, Zhenzhong Duan wrote:
> > We had 'x-scalable-mode' for more than 5 years and 'x-flts' for more than 1
> > year, it's fine to remove 'x-' now.
> > 
> > This is a prerequisite to enable intel_iommu's scalable mode and first stage
> > translation support in libvirt.
> > 
> > Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> > ---
> >   docs/devel/vfio-iommufd.rst    | 10 +++++-----
> >   hw/i386/intel_iommu.c          |  8 ++++----
> >   hw/i386/intel_iommu_accel.c    |  4 ++--
> >   tests/qtest/intel-iommu-test.c |  2 +-
> >   4 files changed, 12 insertions(+), 12 deletions(-)
> > 
> > diff --git a/docs/devel/vfio-iommufd.rst b/docs/devel/vfio-iommufd.rst
> > index 78bcdffac7..5755532443 100644
> > --- a/docs/devel/vfio-iommufd.rst
> > +++ b/docs/devel/vfio-iommufd.rst
> > @@ -153,22 +153,22 @@ RAM discarding for mdev.
> >   ``vfio-ap`` and ``vfio-ccw`` devices don't have same issue as their backend
> >   devices are always mdev and RAM discarding is force enabled.
> > -Usage with intel_iommu featuring x-flts=on
> > +Usage with intel_iommu featuring flts=on
> >   ------------------------------------------
> >   Only IOMMUFD backed VFIO device is supported when intel_iommu is configured
> > -with x-flts=on, for legacy container backed VFIO device, below error shows:
> > +with flts=on, for legacy container backed VFIO device, below error shows:
> >   .. code-block:: none
> > -    qemu-system-x86_64: -device vfio-pci,host=0000:02:00.0: vfio 0000:02:00.0: Failed to set vIOMMU: Need IOMMUFD backend when x-flts=on
> > +    qemu-system-x86_64: -device vfio-pci,host=0000:02:00.0: vfio 0000:02:00.0: Failed to set vIOMMU: Need IOMMUFD backend when flts=on
> >   VFIO device under PCI bridge is unsupported, use PCIE bridge if necessary,
> >   otherwise below error shows:
> >   .. code-block:: none
> > -    qemu-system-x86_64: -device vfio-pci,host=0000:02:00.0,bus=bridge1,iommufd=iommufd0: vfio 0000:02:00.0: Failed to set vIOMMU: Host device downstream to a PCI bridge is unsupported when x-flts=on
> > +    qemu-system-x86_64: -device vfio-pci,host=0000:02:00.0,bus=bridge1,iommufd=iommufd0: vfio 0000:02:00.0: Failed to set vIOMMU: Host device downstream to a PCI bridge is unsupported when flts=on
> >   If host IOMMU has ERRATA_772415_SPR17, running guest with "intel_iommu=on,sm_off"
> >   is unsupported, kexec or reboot guest from "intel_iommu=on,sm_on" to
> > @@ -177,4 +177,4 @@ below if it's not needed by guest:
> >   .. code-block:: bash
> > -    -device intel-iommu,x-scalable-mode=off
> > +    -device intel-iommu,scalable-mode=off
> > diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> > index d24ba989bf..001847ad37 100644
> > --- a/hw/i386/intel_iommu.c
> > +++ b/hw/i386/intel_iommu.c
> > @@ -4200,8 +4200,8 @@ static const Property vtd_properties[] = {
> >       DEFINE_PROP_UINT8("aw-bits", IntelIOMMUState, aw_bits,
> >                         VTD_HOST_ADDRESS_WIDTH),
> >       DEFINE_PROP_BOOL("caching-mode", IntelIOMMUState, caching_mode, FALSE),
> > -    DEFINE_PROP_BOOL("x-scalable-mode", IntelIOMMUState, scalable_mode, FALSE),
> > -    DEFINE_PROP_BOOL("x-flts", IntelIOMMUState, fsts, FALSE),
> 
> IMHO safer would be to officially deprecate these in
> docs/about/deprecated.rst and keeping them aliased until deprecation
> period expires. Other changes LGTM.

The purpose of using an 'x-' prefix for properties in QEMU is to declare
that they are subject to change with no warning, so we are free to change
them without any deprecation IMHO.

> > +    DEFINE_PROP_BOOL("scalable-mode", IntelIOMMUState, scalable_mode, FALSE),
> > +    DEFINE_PROP_BOOL("flts", IntelIOMMUState, fsts, FALSE),
> >       DEFINE_PROP_BOOL("snoop-control", IntelIOMMUState, snoop_control, false),
> >       DEFINE_PROP_BOOL("x-pasid-mode", IntelIOMMUState, pasid, false),
> >       DEFINE_PROP_BOOL("svm", IntelIOMMUState, svm, false),
> 

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


