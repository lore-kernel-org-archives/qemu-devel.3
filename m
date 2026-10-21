Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459AC606A319
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 09:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iMK5xies
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJSvL-0002c1-AV; Wed, 21 Oct 2026 05:47:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lpieralisi@kernel.org>)
 id 1xJSuw-0002aV-4e; Wed, 21 Oct 2026 05:47:31 -0400
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lpieralisi@kernel.org>)
 id 1xJSuu-00079H-3B; Wed, 21 Oct 2026 05:47:29 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9DB4142B93;
 Wed, 21 Oct 2026 09:47:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9AA11F000CA;
 Wed, 21 Oct 2026 09:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792576045;
 bh=dnUnDjOFjw0ANux3in/sgLvd/qDmG3wkK317g+Mf5Fo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=iMK5xiesQuJPx3FWVla20YDT/MBk57uKKqrH0LyZ/iO3VebalD42OvSM7F7xWVWwF
 E1qVsX8cgh1QFHWE6joX6qO6011c1UrNGJ8Gowfmr4WpqtDqfNV1ZGqBOjBmJISO0u
 r2aYoEbXsuf1Nt82LfAL36yga5Jt45FvM+9t1N1f2pLyb1ecSDUHdkl/Ba88Agrl3I
 ypaVhxRh3gwa8KSNennWxxCsCrMounid0cs5LdizNRWpuq9n2T8F/QBh+VGFmpyFYb
 p97/kH7iIihpGyHcpiwavSdhudXUDRsuEFbm86fTf+kbZMP+gAQq9RcgFneysjwGzt
 MnrnuYN/WlzIQ==
Date: Wed, 21 Oct 2026 11:47:19 +0200
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: Gavin Shan <gshan@redhat.com>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>, berrange@redhat.com,
 kchamart@redhat.com, pierrick.bouvier@oss.qualcomm.com,
 peter.maydell@linaro.org, mst@redhat.com, cohuck@redhat.com,
 pbonzini@redhat.com, eblake@redhat.com, armbru@redhat.com,
 lorenzo.pieralisi@linaro.org, enju.kohei@fujitsu.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, kvm@vger.kernel.org
Subject: Re: [RFC v4 11/24] target/arm/kvm-rme: Populate Realm with runtime
 images
Message-ID: <atiKJ8-PyIHSRTKy@red-moon>
References: <20260903193611.1058589-1-mathieu.poirier@linaro.org>
 <20260903193611.1058589-12-mathieu.poirier@linaro.org>
 <3257a387-490f-44bb-bd44-dbe06036fd52@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3257a387-490f-44bb-bd44-dbe06036fd52@redhat.com>
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=lpieralisi@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.329,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Oct 02, 2026 at 01:45:40PM +1000, Gavin Shan wrote:
> On 9/4/26 5:35 AM, Mathieu Poirier wrote:
> > From: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > 
> > Once the Realm descriptor has been created, tell KVM to transfer runtime
> > images (kernel, DT, and rootfs) from guest memory to Realm memory.
> > 
> > Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@linaro.org>
> > Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> > ---
> >   target/arm/kvm-rme.c | 76 ++++++++++++++++++++++++++++++++++++++++++++
> >   1 file changed, 76 insertions(+)
> > 
> > diff --git a/target/arm/kvm-rme.c b/target/arm/kvm-rme.c
> > index 9985f5daba89..c082a5d8f3d1 100644
> > --- a/target/arm/kvm-rme.c
> > +++ b/target/arm/kvm-rme.c
> > @@ -15,6 +15,7 @@
> >   #include "migration/blocker.h"
> >   #include "qapi/error.h"
> >   #include "qemu/error-report.h"
> > +#include "qemu/memalign.h"
> >   #include "qom/object_interfaces.h"
> >   #include "system/confidential-guest-support.h"
> >   #include "system/kvm.h"
> > @@ -43,12 +44,87 @@ OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES(RmeGuest, rme_guest, RME_GUEST,
> >   static RmeGuest *rme_guest;
> > +static int rme_populate_range(const RmeRamRegion *region, bool measure,
> > +                              Error **errp)
> > +{
> > +    int ret;
> > +    void *buffer;
> > +    hwaddr size = region->size;
> > +    hwaddr base = region->base;
> > +    hwaddr start = QEMU_ALIGN_DOWN(base, RME_PAGE_SIZE);
> > +    hwaddr end = QEMU_ALIGN_UP(base + size, RME_PAGE_SIZE);
> > +    struct kvm_arm_rmi_populate populate_args;
> > +    size_t aligned_size = ROUND_UP(region->size, qemu_real_host_page_size());
> 
> s/qemu_real_host_page_size()/RME_PAGE_SIZE

It will always have to be qemu_real_host_page_size(), KVM configures it
that way.

> > +
> > +    if (!region->data) {
> > +        return -ENODEV;
> > +    }
> > +
> > +    ret = kvm_set_memory_attributes_private(start, end - start);
> > +    if (ret) {
> > +        error_report("RME: failed to configure initial"
> > +                     "private guest memory");
> > +        return ret;
> > +    }
> > +
> > +    /* Allocate page-aligned memory */
> > +    buffer = qemu_memalign(qemu_real_host_page_size(), aligned_size);
> > +
> > +    if (!buffer) {
> > +        return -ENOMEM;
> > +    }
> > +
> > +    memset(buffer, 0, aligned_size);
> > +    memcpy(buffer, region->data, region->size);
> > +
> > +    populate_args = (struct kvm_arm_rmi_populate) {
> > +        .base = start,
> > +        .size = end - start,
> > +        .source_uaddr = (uintptr_t)buffer,
> > +        .flags = measure ? KVM_ARM_RMI_POPULATE_FLAGS_MEASURE : 0,
> > +    };
> > +
> > +    while (populate_args.size > 0) {
> > +        ret = kvm_vm_ioctl(kvm_state, KVM_ARM_RMI_POPULATE, &populate_args, 0);
> > +        if (ret) {
> > +            error_setg_errno(errp, -ret,
> > +                "failed to populate realm [0x%"HWADDR_PRIx", 0x%"HWADDR_PRIx")",
> > +                start, end);
> > +            break;
> > +        }
> > +    }
> > +
> > +    qemu_vfree(buffer);
> > +
> > +    return ret;
> > +}
> > +
> 
> I doubt that the unaligned regions (RmeRamRegion) are allowed. For example,
> the region [4KB 64KB+4KB] is turned to the aligned range [0 128KB] when RME_PAGE_SIZE
> is 64KB. The question is how do we know the added regions due to the alignment
> ([0 4KB] and [64KB+4KB 128KB]) are safe for kvm_vm_ioctl(KVM_ARM_RMI_POPULATE).

Getting back to this because it is important. Can you define "safe" here ?

I think it is VMM's role to load with the required alignment and make
sure it does not double populate (that is anyway prevented by KVM), what was
your concern here to make sure we are in agreement ?

Thanks,
Lorenzo

> I guess we probably just reject unaligned regions if they're not expected.
> 
> Even if the unaligned regions are allowed, they seem not well handled.
> 
> - @aligned_size is still 64KB instead of the 128KB ?
> - In "memcpy(buffer, region->data, region->size);", the blob data would be copied to
>   [4KB, 4KB+64KB]. However, we're copying the data to [0 64KB] now.
> 
> > +static void rme_populate_ram_region(gpointer data, gpointer err)
> > +{
> > +    Error **errp = err;
> > +    const RmeRamRegion *region = data;
> > +
> > +    if (*errp) {
> > +        return;
> > +    }
> > +
> > +    rme_populate_range(region, /* measure */ true, errp);
> > +}
> > +
> >   static void rme_vm_state_change(void *opaque, bool running, RunState state)
> >   {
> > +    Error *errp = NULL;
> > +
> >       if (!running) {
> >           return;
> >       }
> > +    g_slist_foreach(rme_guest->ram_regions, rme_populate_ram_region, &errp);
> > +    g_slist_free_full(g_steal_pointer(&rme_guest->ram_regions), g_free);
> > +    if (errp) {
> > +        return;
> > +    }
> > +
> >       kvm_mark_guest_state_protected();
> >   }
> 
> Thanks,
> Gavin
> 

