Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF82606A31B
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 14:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NIWL1n2p
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJtsd-0008Fl-Uz; Thu, 22 Oct 2026 10:34:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lpieralisi@kernel.org>)
 id 1xJtsP-0008DT-Db; Thu, 22 Oct 2026 10:34:41 -0400
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lpieralisi@kernel.org>)
 id 1xJtsN-00033l-0W; Thu, 22 Oct 2026 10:34:41 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 97B2F401DF;
 Thu, 22 Oct 2026 14:34:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4A711F000C1;
 Thu, 22 Oct 2026 14:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792679669;
 bh=NsTdAQ9klXtboyhfno6ZvDGK7HZPd3nbzvjibLiq8Qo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=NIWL1n2pokMbUr4xbCCNYp5wXYDC1oG8GrN5nYwJamodZBItmNCcIAV4GBaREARJj
 YKKYRAQRlR+Vm73PNixWQnLhFgbL1Pe85gG1qYUr50fm7OKRjxqryDfLMRlSFNLPEH
 R4OqayjXj+Ojr29ssuGLCfrH1P5MCJ0jmf0YNmQwpFfjmck/4PIdrs7wRGtSq+gKXy
 voyyBjiLDX2DtruPeMsNiyEXcnuyAh16/VTIl59TTljkYl8nJMtn6DLqOtSX3lCFFZ
 j+nkVoNJnhjVSLWWyxz7w+iur+8SkHPlnE8csi6tNIOsOH0kfmE2Qq25xh+463XWRd
 u6cqRpwSv8sTg==
Date: Thu, 22 Oct 2026 16:34:23 +0200
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
Message-ID: <atoe77pJ119cDcSF@red-moon>
References: <20260903193611.1058589-1-mathieu.poirier@linaro.org>
 <20260903193611.1058589-12-mathieu.poirier@linaro.org>
 <3257a387-490f-44bb-bd44-dbe06036fd52@redhat.com>
 <atiKJ8-PyIHSRTKy@red-moon>
 <27fe3ba8-c8c8-4d5c-9d57-3cfb67142ac1@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <27fe3ba8-c8c8-4d5c-9d57-3cfb67142ac1@redhat.com>
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=lpieralisi@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.339,
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Oct 21, 2026 at 10:24:56PM +1000, Gavin Shan wrote:
> On 10/21/26 7:47 PM, Lorenzo Pieralisi wrote:
> > On Fri, Oct 02, 2026 at 01:45:40PM +1000, Gavin Shan wrote:
> > > On 9/4/26 5:35 AM, Mathieu Poirier wrote:
> > > > From: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > > > 
> > > > Once the Realm descriptor has been created, tell KVM to transfer runtime
> > > > images (kernel, DT, and rootfs) from guest memory to Realm memory.
> > > > 
> > > > Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > > > Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@linaro.org>
> > > > Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> > > > ---
> > > >    target/arm/kvm-rme.c | 76 ++++++++++++++++++++++++++++++++++++++++++++
> > > >    1 file changed, 76 insertions(+)
> > > > 
> > > > diff --git a/target/arm/kvm-rme.c b/target/arm/kvm-rme.c
> > > > index 9985f5daba89..c082a5d8f3d1 100644
> > > > --- a/target/arm/kvm-rme.c
> > > > +++ b/target/arm/kvm-rme.c
> > > > @@ -15,6 +15,7 @@
> > > >    #include "migration/blocker.h"
> > > >    #include "qapi/error.h"
> > > >    #include "qemu/error-report.h"
> > > > +#include "qemu/memalign.h"
> > > >    #include "qom/object_interfaces.h"
> > > >    #include "system/confidential-guest-support.h"
> > > >    #include "system/kvm.h"
> > > > @@ -43,12 +44,87 @@ OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES(RmeGuest, rme_guest, RME_GUEST,
> > > >    static RmeGuest *rme_guest;
> > > > +static int rme_populate_range(const RmeRamRegion *region, bool measure,
> > > > +                              Error **errp)
> > > > +{
> > > > +    int ret;
> > > > +    void *buffer;
> > > > +    hwaddr size = region->size;
> > > > +    hwaddr base = region->base;
> > > > +    hwaddr start = QEMU_ALIGN_DOWN(base, RME_PAGE_SIZE);
> > > > +    hwaddr end = QEMU_ALIGN_UP(base + size, RME_PAGE_SIZE);
> > > > +    struct kvm_arm_rmi_populate populate_args;
> > > > +    size_t aligned_size = ROUND_UP(region->size, qemu_real_host_page_size());
> > > 
> > > s/qemu_real_host_page_size()/RME_PAGE_SIZE
> > 
> > It will always have to be qemu_real_host_page_size(), KVM configures it
> > that way.
> > 
> > > > +
> > > > +    if (!region->data) {
> > > > +        return -ENODEV;
> > > > +    }
> > > > +
> > > > +    ret = kvm_set_memory_attributes_private(start, end - start);
> > > > +    if (ret) {
> > > > +        error_report("RME: failed to configure initial"
> > > > +                     "private guest memory");
> > > > +        return ret;
> > > > +    }
> > > > +
> > > > +    /* Allocate page-aligned memory */
> > > > +    buffer = qemu_memalign(qemu_real_host_page_size(), aligned_size);
> > > > +
> > > > +    if (!buffer) {
> > > > +        return -ENOMEM;
> > > > +    }
> > > > +
> > > > +    memset(buffer, 0, aligned_size);
> > > > +    memcpy(buffer, region->data, region->size);
> > > > +
> > > > +    populate_args = (struct kvm_arm_rmi_populate) {
> > > > +        .base = start,
> > > > +        .size = end - start,
> > > > +        .source_uaddr = (uintptr_t)buffer,
> > > > +        .flags = measure ? KVM_ARM_RMI_POPULATE_FLAGS_MEASURE : 0,
> > > > +    };
> > > > +
> > > > +    while (populate_args.size > 0) {
> > > > +        ret = kvm_vm_ioctl(kvm_state, KVM_ARM_RMI_POPULATE, &populate_args, 0);
> > > > +        if (ret) {
> > > > +            error_setg_errno(errp, -ret,
> > > > +                "failed to populate realm [0x%"HWADDR_PRIx", 0x%"HWADDR_PRIx")",
> > > > +                start, end);
> > > > +            break;
> > > > +        }
> > > > +    }
> > > > +
> > > > +    qemu_vfree(buffer);
> > > > +
> > > > +    return ret;
> > > > +}
> > > > +
> > > 
> > > I doubt that the unaligned regions (RmeRamRegion) are allowed. For example,
> > > the region [4KB 64KB+4KB] is turned to the aligned range [0 128KB] when RME_PAGE_SIZE
> > > is 64KB. The question is how do we know the added regions due to the alignment
> > > ([0 4KB] and [64KB+4KB 128KB]) are safe for kvm_vm_ioctl(KVM_ARM_RMI_POPULATE).
> > 
> > Getting back to this because it is important. Can you define "safe" here ?
> > 
> > I think it is VMM's role to load with the required alignment and make
> > sure it does not double populate (that is anyway prevented by KVM), what was
> > your concern here to make sure we are in agreement ?
> > 
> 
> For example, there are two regions are populated: [0 4KB] and [4KB 64KB] on a 64KB
> host. With the alignment considered, we're populating [0 64KB] for region [0 4KB],
> and [0 64KB] for [4KB 64KB]. [0 64KB] are populated for twice. Is this allowed by
> TF-RMM? If it's allowed by TF-RMM, the data populated in the first time is overwritten
> by the second population.

It is not allowed by the RMM and it is a VMM bug that we have to prevent.

Thanks,
Lorenzo

> Thanks,
> Gavin
> 
> > Thanks,
> > Lorenzo
> > 
> > > I guess we probably just reject unaligned regions if they're not expected.
> > > 
> > > Even if the unaligned regions are allowed, they seem not well handled.
> > > 
> > > - @aligned_size is still 64KB instead of the 128KB ?
> > > - In "memcpy(buffer, region->data, region->size);", the blob data would be copied to
> > >    [4KB, 4KB+64KB]. However, we're copying the data to [0 64KB] now.
> > > 
> > > > +static void rme_populate_ram_region(gpointer data, gpointer err)
> > > > +{
> > > > +    Error **errp = err;
> > > > +    const RmeRamRegion *region = data;
> > > > +
> > > > +    if (*errp) {
> > > > +        return;
> > > > +    }
> > > > +
> > > > +    rme_populate_range(region, /* measure */ true, errp);
> > > > +}
> > > > +
> > > >    static void rme_vm_state_change(void *opaque, bool running, RunState state)
> > > >    {
> > > > +    Error *errp = NULL;
> > > > +
> > > >        if (!running) {
> > > >            return;
> > > >        }
> > > > +    g_slist_foreach(rme_guest->ram_regions, rme_populate_ram_region, &errp);
> > > > +    g_slist_free_full(g_steal_pointer(&rme_guest->ram_regions), g_free);
> > > > +    if (errp) {
> > > > +        return;
> > > > +    }
> > > > +
> > > >        kvm_mark_guest_state_protected();
> > > >    }
> > > 
> > > Thanks,
> > > Gavin
> > > 
> > 
> 

