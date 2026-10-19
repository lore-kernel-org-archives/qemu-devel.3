Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2120606A31C
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 20:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=yVQ0lTpr
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIttn-0008VG-EW; Mon, 19 Oct 2026 16:23:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1xIttl-0008SZ-0K
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 16:23:57 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1xItti-0000lE-Qt
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 16:23:56 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-ccc6b11a19aso1003996a12.0
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 13:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792441433; x=1793046233; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=gAVvIbf3n7kTx1Uv7q3TSJJCpEWn7N4psAyYUl6HiU8=;
 b=yVQ0lTpr19t2WEI2AH9O7qSwVhnvpMGjv2LKoKBETTXQprL5C60feKl45iSSNLQU02
 dMfY/4vlAFanIGjjjKcH+K/4tBftWmCUMi7LkoxMQmsnIBI0aSr0IGC8aRg0sM7nc9Yy
 bulZFPKW8IOJdFgXqOIC7dxUEjthjmH0Uix6C5KOvHej1GPlikxN6/tU/DyrkW4Cfn4K
 8Ex+nxYzap6mdK2KxCF685QQbrEwudKVOYqezvEelbL4MSQLqiGOwv6dGeS/8cUYhi0X
 tbSe5NpyKVZNRaSAGCNuytSXO03HdQEXXNSI1UTjow8iK8viG7twCkZEgLMGkHKrx7ns
 QO4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792441433; x=1793046233;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=gAVvIbf3n7kTx1Uv7q3TSJJCpEWn7N4psAyYUl6HiU8=;
 b=xyYiARUXkhXrSWsqVDa3UDXVdATzEA6prurRugHDLnnP2B9EHlTX6OubD849Oih82i
 y3ggYIBSrwfgHIbqu1fFj31oXk0DKpbHFF6TEO85T3s2B4uK9EtoK/1ZdYDC9qUsmNbn
 HF4y+2YS5XJZ6Yd+yZklV7oeo4dvNVUa73Vz8r6koKZg2NctohyUQfpRiBGHqd3rXt4W
 vDdCBVmj6TW/GZ7uosbsmCwLPMtKgVpsphAbG5pclCsm+WcKl/u66CJJrU8kIxe6ENkz
 jkzPDYCslkSP+jmImhIrTBoveqo/8GVkj2J8uby0PAry02CPiXPHEooJgiJAop+VxILa
 m30g==
X-Forwarded-Encrypted: i=1;
 AKwUvBxPodg19JPhKjCCRZRoUIewyEKDbDcHF8WnX+DmnjWeEufG8IknwVDgev9f7/MwOPf5fygl+YAIVb7l@nongnu.org
X-Gm-Message-State: AFq9FYJ+rfmX5CCexjBxgBnL4PVKu6QDoAfi1EX83IFPvyjc81uuKeHY
 iS7Lk+LmUL18eJAyDl8OWrKiuUcQYR28iAuFF99lTcoM/mdHkHtIcqfjYrpdiiw+zzU=
X-Gm-Gg: AYBFou33U8+ECt3D9ZrEPsx2RfZnB8D004b3SW/7jBN9g+GiTfoKNq6Gf3eHTyARhSh
 /wZl8gZnhTKIhBRp142QHTWTVBt6P/xZzUF1/uclzMgs8SqcCTbLmLoUI14BchXMi+k1Bh0uGNt
 vsfG0uVtudPvHQZeVgT8fyTg+GrEVbrDrQvg5ko/8Oe+hd420A+MUOgrhRUgOt5XUSSr9L6F8M3
 /Vyy7nJ8CF7g4De/i6xxMn//RrmArM6hKMuwgY0KGWP1YFt1FbqyktqN6zzI7T557cH8hp1uwj0
 ghExdGGSKmFoqWtB190EAs6UTIr20RnayCAYPT6wFvTHU1IBSrrdKM6PKgqm4kIumh/bJmibMdU
 DJMOryuJlYwJMMXMo6Vrx9tj6uW4oZgPDihFmmU3g9COSl8Lxy6XQEzAZqK0rpeu9EvkHvv982X
 TfxwGF7DXRgzoE0lP63rL8s8qW/bE2+aaMSzYtHZ89yXzYMhjsMU7L2ZteejqY7qOOUKvBoeXH5
 0nDb9gzB0lfo3nFO5pL60moHN7uBYVfK7ivI4lCN2CxcWHLINwrlDJHKnk=
X-Received: by 2002:a05:6a21:b89:b0:3e1:29b:bb35 with SMTP id
 adf61e73a8af0-3e2260dacb7mr6272242637.88.1792441432136; 
 Mon, 19 Oct 2026 13:23:52 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:5410:6440:73bf:119f])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8a06a6407e0sm1511818b3a.5.2026.10.19.13.23.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 13:23:50 -0700 (PDT)
Date: Mon, 19 Oct 2026 14:23:46 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Gavin Shan <gshan@redhat.com>
Cc: berrange@redhat.com, kchamart@redhat.com,
 pierrick.bouvier@oss.qualcomm.com, peter.maydell@linaro.org,
 mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com,
 eblake@redhat.com, armbru@redhat.com, lorenzo.pieralisi@linaro.org,
 enju.kohei@fujitsu.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 kvm@vger.kernel.org
Subject: Re: [RFC v4 11/24] target/arm/kvm-rme: Populate Realm with runtime
 images
Message-ID: <atZ8Uiq1wfoyUVNT@p14s>
References: <20260903193611.1058589-1-mathieu.poirier@linaro.org>
 <20260903193611.1058589-12-mathieu.poirier@linaro.org>
 <3257a387-490f-44bb-bd44-dbe06036fd52@redhat.com>
 <atKEWmnXA-Gu1Y9T@p14s>
 <cbdab55e-8556-454d-ad66-37f035b57906@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cbdab55e-8556-454d-ad66-37f035b57906@redhat.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=mathieu.poirier@linaro.org; helo=mail-pg1-x536.google.com
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
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sat, Oct 17, 2026 at 11:06:49AM +1000, Gavin Shan wrote:
> On 10/17/26 6:08 AM, Mathieu Poirier wrote:
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
> > I refactored this function in V5 [1], along with the above declarations.
> > 
> > [1]. https://lore.kernel.org/kvm/20261002202026.1204110-10-mathieu.poirier@linaro.org/
> > 
> > > 
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
> > > I guess we probably just reject unaligned regions if they're not expected.
> > 
> > To make sure I understand your point, please expand on what would be an
> > unaligned regions.  In your example, [0 128KB] is aligned on 64KB boundries.
> > 
> > > 
> > > Even if the unaligned regions are allowed, they seem not well handled.
> > > 
> > > - @aligned_size is still 64KB instead of the 128KB ?
> > 
> > I'm confused.  ROUND_UP(64KB+4KB, 64KB) would be 128KB.  What am I missing?
> > 
> 
> ROUND_UP(64KB+4KB, 64KB) corresponds to ROUND_UP(size+base, 64KB) for local
> variable @end instead of @aligned_size. @aligned_size is calculated as
> ROUND_UP(64KB, 64KB) and the output is still 64KB.

Thanks for the explanation - that part was also addressed in V5.  I will
spin-off a proper V6 where we can continue the discussion on updated code.

> 
> > > - In "memcpy(buffer, region->data, region->size);", the blob data would be copied to
> > >    [4KB, 4KB+64KB]. However, we're copying the data to [0 64KB] now.
> > 
> > I agree with you.  That part was refactored in V5 [1]:
> > 
> >          memcpy(buffer + (base - start), region->data, region->size);
> > 
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
> 
> Thanks,
> Gavin
> 

