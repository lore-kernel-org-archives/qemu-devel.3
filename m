Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18B27C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 21:12:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjNw4-0007cl-Np; Mon, 13 Jul 2026 17:11:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1wjNw2-0007cI-Nq
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 17:11:30 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1wjNw0-0007Ee-Ng
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 17:11:30 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-84a2c90e383so249882b3a.0
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 14:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783977086; x=1784581886; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=GW/F3qWXwwX4AhwH+nP/rLsXsp8Fz7nEuN27rGBIfgo=;
 b=ShnBRCFQpwg8cERKsNeiK6G+M5I4EAtDoAHDW3su5bMIQxE6VDVYYkk2QaLtm6u5yB
 5ggQ6Vj3YCJaPJJmFNO/YbMFlu1BONsAtpoNxBYDBpcD4tvXcadIgqKC7Hsd2UnfPxSB
 t37L1grY4LPToNFUgN0RF+Tt3aFfjO7+GMRXIrwmmk+n4AEmpWVWsf4gw8J3MU6mIIeK
 sCrUtiVelV++Dy3Gs4U08otGCRjcX280yMt/ndQF3tDl7BU0JpaoK2+/oGoR3AapuBNt
 Ky3Hez7oJ0ns2jnOxwwv1Axm3ti5RW2sqJNe7hbfPDCq+YEI+rhLww6m1YpBB6t3g6Gm
 tLOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783977086; x=1784581886;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=GW/F3qWXwwX4AhwH+nP/rLsXsp8Fz7nEuN27rGBIfgo=;
 b=OICWil9aZgWx5z9EwZPxEUHx80Mwf2Od30NoZ13CCuxN0CC+wuWPtemyyuSymIb7H5
 6wH/T2QI8aPwdzq1XtHLEd2dKpFI17HmuGkkWNoQ2GiYyanALeut4+V9I8hda/8yCC0T
 j5Uv7C45Nv6DJiq7/Hlm4mQJU598XX34Q5DAvB117ePFFBqCQRxSXLK/lwT6ofEjsTHN
 hrAHy0BTevLLCRstOwIYqy6tzyTe151X1bi9kyKh4jrTX17x1Bd50kJymrZrWisOCrI6
 bdmZ5yPhQiYiz7G1iv8llgoKhADnRVEKi49nQwdHcv02EzymE2W9pPI9aTvyjdnm56Ry
 TVrA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqvBSQu9bstfFtRUfLNCGKRYNDxCzFR/ri/qoj0B+Qp/IVePpHMM3WEf3p+bk/KG7Gj4TQ2FwL2Dws5@nongnu.org
X-Gm-Message-State: AOJu0YzDiEhH+VNnDEMx6ij8a1K2lll1N/Fto2TYL0QmQ4lX5CVePnDN
 9bQJ0gutaD0vWq96eqRLCawxHqnhkcjdZAljhk/iYr4wIU+ZCiRLMKdjqGxH5fXd5Po=
X-Gm-Gg: AfdE7clx/Wf33OG8lp0DKssLldZsJgTRCIQ+qow9g8FETbJqW0HPvyACm3C2UNU1vC4
 tgYieqUkdFX+Ghd+NssTBk/kbO9NuYohFmTL3ZdF/jIeZnusd3ZHiwMQcz9iuAp1Ds7bl77BUji
 wsISPNtsV66f6O9CCZi63jnmazpdRzbww6QzpfnuO7yfob/0T4dPA6f8cAWOE1RQRiCPmkS4vuk
 FYOiqH+kzcTrAmqu3p6Qpic2TaynFtvrMckDclSRhNrFhZWmzrIhRVeR8krQdB/uJmRPs9feEnX
 xymrPFQRGJhs5+OLrpjdmVAsUnnudUyK81IplxDMCN6TM/soFGe4NTtz83O2t8w6sUk9YJVkyEO
 PAvahiDF7IJ4N07PiZZ1qsVgwa9hlAFI+vbnlAB7/zl9xk+TDGmClobOAmCxj4K2yXb/s+05oHU
 lpNEJpHJXtHEZIdsU5
X-Received: by 2002:a05:6a21:9210:b0:3bf:8de9:c64e with SMTP id
 adf61e73a8af0-3c112b9c1d2mr10234471637.2.1783977086349; 
 Mon, 13 Jul 2026 14:11:26 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:3ead:2a56:27bf:77cb])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-ca5b3a2bf6bsm9108149a12.27.2026.07.13.14.11.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 14:11:25 -0700 (PDT)
Date: Mon, 13 Jul 2026 15:11:23 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Gavin Shan <gshan@redhat.com>
Cc: berrange@redhat.com, kchamart@redhat.com,
 pierrick.bouvier@oss.qualcomm.com, peter.maydell@linaro.org,
 mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com,
 eblake@redhat.com, armbru@redhat.com, jpb@kernel.org,
 lorenzo.pieralisi@linaro.org, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, kvm@vger.kernel.org
Subject: Re: [RFC v1 01/25] linux-headers: Add RME related definitions
Message-ID: <alVUewIPbsAClmau@p14s>
References: <20260707224306.1202330-1-mathieu.poirier@linaro.org>
 <20260707224306.1202330-2-mathieu.poirier@linaro.org>
 <03a39e32-3b15-49a3-a23a-782f8ba25466@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <03a39e32-3b15-49a3-a23a-782f8ba25466@redhat.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=mathieu.poirier@linaro.org; helo=mail-pf1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Fri, Jul 10, 2026 at 11:09:43AM +1000, Gavin Shan wrote:
> On 7/8/26 8:42 AM, Mathieu Poirier wrote:
> > From: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > 
> > This is a temporary patch intended for testing purposes only. It provides
> > definitions related to supporting Realms by the QEMU-VMM.
> > 
> > Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> > ---
> >   linux-headers/asm-arm64/kvm.h |  9 +++++++++
> >   linux-headers/linux/kvm.h     | 21 +++++++++++++++++----
> >   2 files changed, 26 insertions(+), 4 deletions(-)
> > 
> > diff --git a/linux-headers/asm-arm64/kvm.h b/linux-headers/asm-arm64/kvm.h
> > index 6aefe7973814..4c08631ec7d2 100644
> > --- a/linux-headers/asm-arm64/kvm.h
> > +++ b/linux-headers/asm-arm64/kvm.h
> > @@ -208,6 +208,15 @@ struct kvm_arm_counter_offset {
> >   	__u64 reserved;
> >   };
> > +#define KVM_ARM_RMI_POPULATE_FLAGS_MEASURE     (1 << 0)
> > +struct kvm_arm_rmi_populate {
> > +	__u64 base;
> > +	__u64 size;
> > +	__u64 source_uaddr;
> > +	__u32 flags;
> > +	__u32 reserved;
> > +};
> > +
> >   #define KVM_ARM_TAGS_TO_GUEST		0
> >   #define KVM_ARM_TAGS_FROM_GUEST		1
> > diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
> > index 50e87ed72c20..dae6e5ba8457 100644
> > --- a/linux-headers/linux/kvm.h
> > +++ b/linux-headers/linux/kvm.h
> > @@ -685,11 +685,21 @@ struct kvm_enable_cap {
> >   #define KVM_S390_SIE_PAGE_OFFSET 1
> >   /*
> > - * On arm64, machine type can be used to request the physical
> > - * address size for the VM. Bits[7-0] are reserved for the guest
> > - * PA size shift (i.e, log2(PA_Size)). For backward compatibility,
> > - * value 0 implies the default IPA size, 40bits.
> > + * On arm64, machine type can be used to request both the machine type and
> > + * the physical address size for the VM.
> > + *
> > + * Bits[31-30] are reserved for the ARM specific machine type.
> > + *
> > + * Bits[7-0] are reserved for the guest PA size shift (i.e, log2(PA_Size)).
> > + * For backward compatibility, value 0 implies the default IPA size, 40bits.
> >    */
> > +#define KVM_VM_TYPE_ARM_SHIFT		30
> > +#define KVM_VM_TYPE_ARM_MASK		(0x3ULL << KVM_VM_TYPE_ARM_SHIFT)
> > +#define KVM_VM_TYPE_ARM(_type)		\
> > +	(((_type) << KVM_VM_TYPE_ARM_SHIFT) & KVM_VM_TYPE_ARM_MASK)
> > +#define KVM_VM_TYPE_ARM_NORMAL		KVM_VM_TYPE_ARM(0)
> > +#define KVM_VM_TYPE_ARM_REALM		KVM_VM_TYPE_ARM(1)
> > +
> >   #define KVM_VM_TYPE_ARM_IPA_SIZE_MASK	0xffULL
> >   #define KVM_VM_TYPE_ARM_IPA_SIZE(x)		\
> >   	((x) & KVM_VM_TYPE_ARM_IPA_SIZE_MASK)
> 
> The definitions in this section aren't exactly same to that in (v14) host series,
> leading to KVM_VM_TYPE_ARM_REALM = 0 in my environment and the realm guest can't
> be started with the following error message. At least, KVM_VM_TYPE_ARM_MASK has
> been redefined with different values.
> 
>   qemu-system-aarch64: KVM does not support guest_memfd

I agree with you.  Although outdated the above should work - left shifting
0x3ULL by 30 seems to be causing issues.  

> 
>   ----> linux-headers/linux/kvm.h
> 
>   #define KVM_VM_TYPE_ARM_SHIFT          30
>   #define KVM_VM_TYPE_ARM_MASK           (0x3ULL << KVM_VM_TYPE_ARM_SHIFT)
> 
>   #define KVM_VM_TYPE_ARM_MASK           (KVM_VM_TYPE_ARM_IPA_SIZE_MASK | \
>                                           KVM_VM_TYPE_ARM_PROTECTED)
> 
> After syncing the definitions with those in (v14) host series, I'm able to boot
> a simple realm guest (no virtio devices) with one warning.
> 
>   qemu-system-aarch64: Failed to enable KVM_CAP_ARM_NISV_TO_USER cap

Right, that one is useless.

Both issues reported here will be addressed in the next revision.

> 
> Thanks,
> Gavin
> 
> > @@ -719,6 +729,8 @@ struct kvm_enable_cap {
> >   #define KVM_GET_EMULATED_CPUID	  _IOWR(KVMIO, 0x09, struct kvm_cpuid2)
> >   #define KVM_GET_MSR_FEATURE_INDEX_LIST    _IOWR(KVMIO, 0x0a, struct kvm_msr_list)
> > +#define KVM_ARM_RMI_POPULATE	  _IOWR(KVMIO, 0xd7, struct kvm_arm_rmi_populate)
> > +
> >   /*
> >    * Extension capability list.
> >    */
> > @@ -985,6 +997,7 @@ struct kvm_enable_cap {
> >   #define KVM_CAP_S390_USER_OPEREXEC 246
> >   #define KVM_CAP_S390_KEYOP 247
> >   #define KVM_CAP_S390_VSIE_ESAMODE 248
> > +#define KVM_CAP_ARM_RMI 249
> >   struct kvm_irq_routing_irqchip {
> >   	__u32 irqchip;
> 

