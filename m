Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C1F606A31E
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 20:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=KI+K+Wq3
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKLpx-0005NB-AQ; Fri, 23 Oct 2026 16:26:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1xKLpp-0005LM-9Y
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 16:25:53 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1xKLpl-00084A-4y
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 16:25:51 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-3acd21ba21aso1003410a91.1
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 13:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792787147; x=1793391947; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=HWEUe7jMIqDdmEz/IUXEovYVrzXcaS1CDzk92S0N4y0=;
 b=KI+K+Wq3rFz6HLRqD4Cu4FBl5wYivIQuiwcs2dB4nQQnBNBcJ1Z3XtY6Xu0iuYipbT
 0YFGtYfrcHvxOLhry5vZJb8ytI5eUT1PXqL7LZYQvh9huy0JchxosyVZnME8TnNIrH1r
 4mGeCeDdYiEXlhaJGUr2deddrGDfnmm7SA8TXst7/CCp9FUnNjmolSmk93v6YES9x3HT
 g67d6FYk4/v1kmKhjyAdwDHLT8adwc72NeCjV00MvtexV9pFqsZDaUGJQMsDZwW45fQx
 3Y0i9folvVjuqGuDfpGJ2dRQsVF4yBFzDgeLkxM+T5OpXp2GjL9tzBuABtcXAh1Iu7Jk
 KqJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792787147; x=1793391947;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=HWEUe7jMIqDdmEz/IUXEovYVrzXcaS1CDzk92S0N4y0=;
 b=O3Iwp8iXd2GIlbNO3KeqJcSW3KJcyvOc6rAdHI+yjw1okTloQC3F4YxFfH30NZ1ZrA
 IB+MCgVy65c07dOfiVEoEjlalhdoMEkBOPwxK5EjPaPJ31C6QuTfcHk5bZeAeO4TOFDk
 RJnOYNrPJvV17s4/ZpT2MP97Ypq9AbfQUdzf+/3DNrlP9oqC8EZmsY5t/qVRdd+qMAw5
 0LH2xNeVreNajtdGJkuRw/4gANjB6QIDVHrBG4LAG5omuFBCLROWghgGGGtN8vTdJq+f
 Zwq50J9aL4MaKgQYzGDQ21Gk0nL6uhAlWDigI4c7JI3msV2uxQBhYyaGeju1ucGipCvA
 3Zdg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwWmVMdneIP5nxhPIHwJsAEmEGlywwqkSTCQkcdGcH0KmlTbTi3jShn6jzqlWPj2xu4z3vAk2a3TBqt@nongnu.org
X-Gm-Message-State: AFq9FYIJzPqZ+Ezef7m8MtUjesEN4SLmBoy1ScC6WYDxRJe8qJFxSQBr
 P1bjcBqVV6aru4++8BTxPEtaCw2r6pVP8okkHg4Xwig8/qFCxVAmZUWwPp+dr9ycZ+M=
X-Gm-Gg: AYBFou3r2ol27SI+5Y/5j7atgGKKmDAcvsqtphz1i7R4hx3CR7cZ5JGZTZYUEXSpM/j
 H49XUQqhmT2VimEYL2qtw25VzRCFF6Y9eAZRXynMB5wtuIwowPrS9U3YPyqH8QnXzbuIfr/k9nf
 AcabybQ18egc8hDUwTlEGdk0AUt7afgL5E68E3zOZTMqafWf7Wm/bZe4BhvNd6vwsQ+JZl6AOqa
 2SxtGvkPyOGAFNjEiUNg6c0Ac2YntF9yF7XVzhXW5J2GfSvZI3mEfwizClvIKvAA5awJpiAJXs0
 HNNpPHVvaXSBXzoYZKnwh7/sQaI0rJXyIeDfLDcZvALQl6BwCr7e7Wg88oT6gpxdpeerzO9sVnU
 4oTNh0LtPs1rHUYY3vAVcnr9Skrh7Y2WWado46NDOUPon3Ug4qiU/SF2hFzTTKvQIP0fOBxOT6U
 F1Jfmvh3D+wwBQ0ik3XAp317PVDyqBaLpuBh4l6kpOVdCRHnmDjCiqFMS0yYLnoLVZlCVXTGA3H
 y32lf4HXiQBCOT1MGeyNAzN47iNAmkvhG/y8A1paqNWw74Bqe3+RHDvELA=
X-Received: by 2002:a17:90a:d2c7:b0:3ab:5832:727d with SMTP id
 98e67ed59e1d1-3adead5d229mr332494a91.35.1792787147293; 
 Fri, 23 Oct 2026 13:25:47 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:435b:3f0e:f3fe:d04e])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3adebb0639bsm313704a91.12.2026.10.23.13.25.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 13:25:46 -0700 (PDT)
Date: Fri, 23 Oct 2026 14:25:43 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Gavin Shan <gshan@redhat.com>, berrange@redhat.com, kchamart@redhat.com,
 pierrick.bouvier@oss.qualcomm.com, peter.maydell@linaro.org,
 mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com,
 eblake@redhat.com, armbru@redhat.com, lorenzo.pieralisi@linaro.org,
 enju.kohei@fujitsu.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 kvm@vger.kernel.org
Subject: Re: [RFC v4 11/24] target/arm/kvm-rme: Populate Realm with runtime
 images
Message-ID: <atvCx_Embi4sXAqG@p14s>
References: <20260903193611.1058589-1-mathieu.poirier@linaro.org>
 <20260903193611.1058589-12-mathieu.poirier@linaro.org>
 <3257a387-490f-44bb-bd44-dbe06036fd52@redhat.com>
 <atiKJ8-PyIHSRTKy@red-moon>
 <27fe3ba8-c8c8-4d5c-9d57-3cfb67142ac1@redhat.com>
 <atoe77pJ119cDcSF@red-moon>
 <ff029f82-07e2-469b-a758-6d27212a9227@redhat.com>
 <atsFnklBAg73Smes@red-moon>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <atsFnklBAg73Smes@red-moon>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=mathieu.poirier@linaro.org; helo=mail-pj1-x1030.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Oct 23, 2026 at 08:58:38AM +0200, Lorenzo Pieralisi wrote:
> On Fri, Oct 23, 2026 at 09:30:36AM +1000, Gavin Shan wrote:
> > On 10/23/26 12:34 AM, Lorenzo Pieralisi wrote:
> > > On Wed, Oct 21, 2026 at 10:24:56PM +1000, Gavin Shan wrote:
> > > > On 10/21/26 7:47 PM, Lorenzo Pieralisi wrote:
> > > > > On Fri, Oct 02, 2026 at 01:45:40PM +1000, Gavin Shan wrote:
> > > > > > On 9/4/26 5:35 AM, Mathieu Poirier wrote:
> > > > > > > From: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > > > > > > 
> > > > > > > Once the Realm descriptor has been created, tell KVM to transfer runtime
> > > > > > > images (kernel, DT, and rootfs) from guest memory to Realm memory.
> > > > > > > 
> > > > > > > Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > > > > > > Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@linaro.org>
> > > > > > > Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> > > > > > > ---
> > > > > > >     target/arm/kvm-rme.c | 76 ++++++++++++++++++++++++++++++++++++++++++++
> > > > > > >     1 file changed, 76 insertions(+)
> > > > > > > 
> > > > > > > diff --git a/target/arm/kvm-rme.c b/target/arm/kvm-rme.c
> > > > > > > index 9985f5daba89..c082a5d8f3d1 100644
> > > > > > > --- a/target/arm/kvm-rme.c
> > > > > > > +++ b/target/arm/kvm-rme.c
> > > > > > > @@ -15,6 +15,7 @@
> > > > > > >     #include "migration/blocker.h"
> > > > > > >     #include "qapi/error.h"
> > > > > > >     #include "qemu/error-report.h"
> > > > > > > +#include "qemu/memalign.h"
> > > > > > >     #include "qom/object_interfaces.h"
> > > > > > >     #include "system/confidential-guest-support.h"
> > > > > > >     #include "system/kvm.h"
> > > > > > > @@ -43,12 +44,87 @@ OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES(RmeGuest, rme_guest, RME_GUEST,
> > > > > > >     static RmeGuest *rme_guest;
> > > > > > > +static int rme_populate_range(const RmeRamRegion *region, bool measure,
> > > > > > > +                              Error **errp)
> > > > > > > +{
> > > > > > > +    int ret;
> > > > > > > +    void *buffer;
> > > > > > > +    hwaddr size = region->size;
> > > > > > > +    hwaddr base = region->base;
> > > > > > > +    hwaddr start = QEMU_ALIGN_DOWN(base, RME_PAGE_SIZE);
> > > > > > > +    hwaddr end = QEMU_ALIGN_UP(base + size, RME_PAGE_SIZE);
> > > > > > > +    struct kvm_arm_rmi_populate populate_args;
> > > > > > > +    size_t aligned_size = ROUND_UP(region->size, qemu_real_host_page_size());
> > > > > > 
> > > > > > s/qemu_real_host_page_size()/RME_PAGE_SIZE
> > > > > 
> > > > > It will always have to be qemu_real_host_page_size(), KVM configures it
> > > > > that way.
> > > > > 
> > > > > > > +
> > > > > > > +    if (!region->data) {
> > > > > > > +        return -ENODEV;
> > > > > > > +    }
> > > > > > > +
> > > > > > > +    ret = kvm_set_memory_attributes_private(start, end - start);
> > > > > > > +    if (ret) {
> > > > > > > +        error_report("RME: failed to configure initial"
> > > > > > > +                     "private guest memory");
> > > > > > > +        return ret;
> > > > > > > +    }
> > > > > > > +
> > > > > > > +    /* Allocate page-aligned memory */
> > > > > > > +    buffer = qemu_memalign(qemu_real_host_page_size(), aligned_size);
> > > > > > > +
> > > > > > > +    if (!buffer) {
> > > > > > > +        return -ENOMEM;
> > > > > > > +    }
> > > > > > > +
> > > > > > > +    memset(buffer, 0, aligned_size);
> > > > > > > +    memcpy(buffer, region->data, region->size);
> > > > > > > +
> > > > > > > +    populate_args = (struct kvm_arm_rmi_populate) {
> > > > > > > +        .base = start,
> > > > > > > +        .size = end - start,
> > > > > > > +        .source_uaddr = (uintptr_t)buffer,
> > > > > > > +        .flags = measure ? KVM_ARM_RMI_POPULATE_FLAGS_MEASURE : 0,
> > > > > > > +    };
> > > > > > > +
> > > > > > > +    while (populate_args.size > 0) {
> > > > > > > +        ret = kvm_vm_ioctl(kvm_state, KVM_ARM_RMI_POPULATE, &populate_args, 0);
> > > > > > > +        if (ret) {
> > > > > > > +            error_setg_errno(errp, -ret,
> > > > > > > +                "failed to populate realm [0x%"HWADDR_PRIx", 0x%"HWADDR_PRIx")",
> > > > > > > +                start, end);
> > > > > > > +            break;
> > > > > > > +        }
> > > > > > > +    }
> > > > > > > +
> > > > > > > +    qemu_vfree(buffer);
> > > > > > > +
> > > > > > > +    return ret;
> > > > > > > +}
> > > > > > > +
> > > > > > 
> > > > > > I doubt that the unaligned regions (RmeRamRegion) are allowed. For example,
> > > > > > the region [4KB 64KB+4KB] is turned to the aligned range [0 128KB] when RME_PAGE_SIZE
> > > > > > is 64KB. The question is how do we know the added regions due to the alignment
> > > > > > ([0 4KB] and [64KB+4KB 128KB]) are safe for kvm_vm_ioctl(KVM_ARM_RMI_POPULATE).
> > > > > 
> > > > > Getting back to this because it is important. Can you define "safe" here ?
> > > > > 
> > > > > I think it is VMM's role to load with the required alignment and make
> > > > > sure it does not double populate (that is anyway prevented by KVM), what was
> > > > > your concern here to make sure we are in agreement ?
> > > > > 
> > > > 
> > > > For example, there are two regions are populated: [0 4KB] and [4KB 64KB] on a 64KB
> > > > host. With the alignment considered, we're populating [0 64KB] for region [0 4KB],
> > > > and [0 64KB] for [4KB 64KB]. [0 64KB] are populated for twice. Is this allowed by
> > > > TF-RMM? If it's allowed by TF-RMM, the data populated in the first time is overwritten
> > > > by the second population.
> > > 
> > > It is not allowed by the RMM and it is a VMM bug that we have to prevent.
> > > 
> > 
> > Ok, thanks for your confirm. It's why I asked if we ever see an unaligned
> > Rom region. If all Rom regions are aligned to host page size, then we needn't
> > to handle the unaligned Rom regions in rme_populate_range(). Otherwise, we
> > need come up with a solution to address the issue.
> > 
> > The solution would be to generate a temporary region list based on the existing
> > Rom region list. For each region in the temporary list, its start/size are well
> > aligned to host page size, and the temporary buffer is allocated, and the data
> > is properly copied over from the original Rom region. The population is done
> > based on the temporary list. For example, we need to have [0 64kb], [128kb 192kb]
> > regions in the temporary list if we have Rom region [0 1kb], [4kb 5kb] [16kb 17kb],
> > [132kb 133kb], [136kb 140kb]. The host page size is assumed to be 64kb in the example.
> > 
> >    [0 64kb] covers [0 1kb], [4kb 5kb] [16kb 17kb]
> >    [128kb 192kb] covers [132kb 133kb], [136kb 140kb]
> 
> That's exactly what needs to be done.
>

That is also what I understood.  My goal is to present this enhancement in
RFCv6.
 
> Thanks,
> Lorenzo
> 
> > Thanks,
> > Gavin
> > 
> > > Thanks,
> > > Lorenzo
> > > 
> > > > Thanks,
> > > > Gavin
> > > > 
> > > > > Thanks,
> > > > > Lorenzo
> > > > > 
> > > > > > I guess we probably just reject unaligned regions if they're not expected.
> > > > > > 
> > > > > > Even if the unaligned regions are allowed, they seem not well handled.
> > > > > > 
> > > > > > - @aligned_size is still 64KB instead of the 128KB ?
> > > > > > - In "memcpy(buffer, region->data, region->size);", the blob data would be copied to
> > > > > >     [4KB, 4KB+64KB]. However, we're copying the data to [0 64KB] now.
> > > > > > 
> > > > > > > +static void rme_populate_ram_region(gpointer data, gpointer err)
> > > > > > > +{
> > > > > > > +    Error **errp = err;
> > > > > > > +    const RmeRamRegion *region = data;
> > > > > > > +
> > > > > > > +    if (*errp) {
> > > > > > > +        return;
> > > > > > > +    }
> > > > > > > +
> > > > > > > +    rme_populate_range(region, /* measure */ true, errp);
> > > > > > > +}
> > > > > > > +
> > > > > > >     static void rme_vm_state_change(void *opaque, bool running, RunState state)
> > > > > > >     {
> > > > > > > +    Error *errp = NULL;
> > > > > > > +
> > > > > > >         if (!running) {
> > > > > > >             return;
> > > > > > >         }
> > > > > > > +    g_slist_foreach(rme_guest->ram_regions, rme_populate_ram_region, &errp);
> > > > > > > +    g_slist_free_full(g_steal_pointer(&rme_guest->ram_regions), g_free);
> > > > > > > +    if (errp) {
> > > > > > > +        return;
> > > > > > > +    }
> > > > > > > +
> > > > > > >         kvm_mark_guest_state_protected();
> > > > > > >     }
> > > > > > 
> > > > > > Thanks,
> > > > > > Gavin
> > > > > > 
> > > > > 
> > > > 
> > > 
> > 

