Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18B18CDB479
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 06:56:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcHWr-0000xT-BG; Wed, 24 Jun 2026 02:56:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wcHWg-0000wq-Nz
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 02:56:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wcHWc-0006m6-NE
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 02:55:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782284152;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pV7cKuIKokhabSrGCuPwKrJSqYceZzzh1MfVSPjvfkI=;
 b=LRjwDvnzQqBMacHkxC6ae0kKxEjQEULhfzMIvqdEQwcA3IZQK4zhxK5AR4g+LYGVb+pYZL
 1a3AvLWPBdKAB/zlTDLPXboIjwJlYr0M70GmY7r4PHmxIUB3JRFE51X0iKuchCOr70htir
 1eX4CpW97/npItZqDNxQBV3JeyyTbWc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-340-vb0Gp71oOquYjWc2vNyZHQ-1; Wed, 24 Jun 2026 02:55:50 -0400
X-MC-Unique: vb0Gp71oOquYjWc2vNyZHQ-1
X-Mimecast-MFC-AGG-ID: vb0Gp71oOquYjWc2vNyZHQ_1782284150
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-490b2f22ea2so5205205e9.1
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 23:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782284149; x=1782888949; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=pV7cKuIKokhabSrGCuPwKrJSqYceZzzh1MfVSPjvfkI=;
 b=ikhK1QuTc3fmGVlw+waUT7F/I+gkd/ACwArZNKyYk6V6Peev6nv83+1x1sSx1wJ6Mz
 +OzGzeO6310Oztnj6MxoLvRll/lZDPxkp7DsHa05MyVdTr6LL6AEgyO5Pu9dLo8eKCj+
 rD/YJRw5yorivXOmP1YhIBA5CiyXqGtaaXjlb/8aD9Y612dImhZcFVT+0jBkxJxOKumZ
 SmQghUS81nhVPBA2A/UAaJWZbxniTxyy6RFu196WSPyuPt2bt/Cmny2jQ4gjjNNM2I/h
 rmvGxm5oan/+yJwIx0LVhu7jrVTjSzqC8oyBFJ8CoWpbkHE9GGRDUDI2LBuHi66Y66RZ
 pICw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782284149; x=1782888949;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pV7cKuIKokhabSrGCuPwKrJSqYceZzzh1MfVSPjvfkI=;
 b=oRoF3Wwi3Ykhvou25r0461SfqWGHEJFFl1Dh3Kv9kX5JACQY/YW+dDd/rydUkFG/7L
 1Gzrn2fu03lFlcoVvmp+dVJPL4aEp08ydl2MMXvcnts9gF4478schI1wkF+JX2Qvnidp
 ssJXpdtnTQMjDyCw0ZCee2xcr+aWoMS0jSO1iFE+tfqWbdGQWqStvinZglxPMAGlDsc2
 Pql0nEOoN8rM85b5t3Vm1wUrLtzY+Eo+OkDw0Qlz20QXU2vrm9cCo981wlOdUwGdzE9X
 0YxPFvrJrkZzI9A38d9ffu14sCGAi5LyX5XdiDid3FwZtPiiXp+cgtp3hvHJehttW9k7
 G2XA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/vre5+Q89cUMiMaQsnFWLECiXRXJifIe42LSrhbrzzhNGhY/cKki7WILS90As3Xt1S6eKi4ksULUtt@nongnu.org
X-Gm-Message-State: AOJu0YwYzPLby37Mur0qG0XNBH7ceg8+wWP4/91uYlhvTXjm2+1dtU8U
 0SrMmsmQ0R6rxXb7RmdS7xyDgf4XtJd92A/imYLZlKql3aLgU1NzvEdvcu15lVDrzZPFL6o95rV
 iehopEvBkZp/MkPU6I/ZAWHmKuD4vdyuKqwCbsbOvSk66eobeEeTks6hm
X-Gm-Gg: AfdE7cme3jAzPmUrEoGjg3CkG5g14rymGVWv8UnNibZbYRy7E6lajwUpXXHQPQq7pcj
 Z5DAdUi/xFBXDu1dHT1TLgrqqjqzXTpdTwlAMQSDThTqofNfX01Bv/1jOEYEWTfXQIZnuSE72ht
 /5wopUMNcMVGneZEUWq/he/qosMkHSn9LTDE6tUZTfqEew51FnD2cgX1sYuxOBFRPW969hABa6Q
 1pwUL4NIVHSknnkXG7tcfO4CJiYVsy3aj3+fweWPYrB0HU3ln7+dR7M2XgYcjEDDNyxLSCMa12w
 uosGJD1dU1YwSO6leW6EIrICB9khLUG7P2btU3dXlwPhfhVMhS9gx27eQbNYeCJqVQL6vlXM0Mb
 MkSReRglotNkGmmOzhJHpDxCnW5VwXq5F
X-Received: by 2002:a05:600c:4453:b0:490:4ee0:82ff with SMTP id
 5b1f17b1804b1-492608794bbmr23456095e9.27.1782284149387; 
 Tue, 23 Jun 2026 23:55:49 -0700 (PDT)
X-Received: by 2002:a05:600c:4453:b0:490:4ee0:82ff with SMTP id
 5b1f17b1804b1-492608794bbmr23455685e9.27.1782284148800; 
 Tue, 23 Jun 2026 23:55:48 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4923fd1f886sm403950225e9.4.2026.06.23.23.55.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2026 23:55:48 -0700 (PDT)
Date: Wed, 24 Jun 2026 02:55:45 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 sarunkod@amd.com, pbonzini@redhat.com, richard.henderson@linaro.org
Subject: Re: [PATCH 2/2] amd_iommu: Fully initialize XT interrupt message state
Message-ID: <20260624025330-mutt-send-email-mst@kernel.org>
References: <20260623005813.984238-1-alejandro.j.jimenez@oracle.com>
 <20260623005813.984238-3-alejandro.j.jimenez@oracle.com>
 <CAFEAcA8NKB6Wg-Gsbv_NXp72PLADS=h7p7KyLCW1gRCbywESfQ@mail.gmail.com>
 <20260623143614-mutt-send-email-mst@kernel.org>
 <b4637fdb-c32a-4ca1-9348-3757ef93ea3e@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b4637fdb-c32a-4ca1-9348-3757ef93ea3e@oracle.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Jun 23, 2026 at 05:57:39PM -0400, Alejandro Jimenez wrote:
> 
> 
> On 6/23/26 2:37 PM, Michael S. Tsirkin wrote:
> > On Tue, Jun 23, 2026 at 09:44:10AM +0100, Peter Maydell wrote:
> >> On Tue, 23 Jun 2026 at 01:58, Alejandro Jimenez
> >> <alejandro.j.jimenez@oracle.com> wrote:
> >>>
> >>> When IOMMU x2APIC interrupts generation (IntCapXTEn) is enabled,
> >>> amdvi_build_xt_msi_msg() builds an MSI message using the relevant values in
> >>> the XT IOMMU General Interrupt Control Register.
> >>>
> >>> Initialize the local X86IOMMUIrq structure with zero for all fields. This
> >>> ensures that X86IOMMUIrq fields not set in the XT register (e.g.
> >>> msi_addr_last_bits) are initialized before x86_iommu_irq_to_msi_message()
> >>> consumes them.
> >>>
> >>> Remove the redundant 'struct' keyword in X86IOMMUIrq irq declaration.
> >>>
> >>> CID: 1660056
> >>> Fixes: cf0210df65aa ("amd_iommu: Generate XT interrupts when xt support is enabled")
> >>> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> >>> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> >>> Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
> >>> ---
> >>>  hw/i386/amd_iommu.c | 2 +-
> >>>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>>
> >>> diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
> >>> index 0d273fd33d..9005dc7aab 100644
> >>> --- a/hw/i386/amd_iommu.c
> >>> +++ b/hw/i386/amd_iommu.c
> >>> @@ -195,7 +195,7 @@ static void amdvi_assign_andq(AMDVIState *s, hwaddr addr, uint64_t val)
> >>>  static void amdvi_build_xt_msi_msg(AMDVIState *s, MSIMessage *msg)
> >>>  {
> >>>      union mmio_xt_intr xt_reg;
> >>> -    struct X86IOMMUIrq irq;
> >>> +    X86IOMMUIrq irq = { 0 };
> > 
> > Why don't we just initialize everything at the declaration site?
> > 
> > union mmio_xt_intr xt_reg = { .val = ... };
> > X86IOMMUIrq irq = { .... };
> > 
> 
> The above makes sense, but this commit is essentially moot because my
> follow up getting rid of the bitfield usage overrides the whole thing. i.e.
> an upcoming change in v2 will do:
> 
>  static void amdvi_build_xt_msi_msg(AMDVIState *s, MSIMessage *msg)
>  {
> -    union mmio_xt_intr xt_reg;
> -    X86IOMMUIrq irq = { 0 };
> +    uint64_t xt_reg = amdvi_readq(s, AMDVI_MMIO_XT_GEN_INTR);
> 
> -    xt_reg.val = amdvi_readq(s, AMDVI_MMIO_XT_GEN_INTR);
> -
> -    irq.vector = xt_reg.vector;
> -    irq.delivery_mode = xt_reg.delivery_mode;
> -    irq.dest_mode = xt_reg.destination_mode;
> -    irq.dest = (xt_reg.destination_hi << 24) | xt_reg.destination_lo;
> -    irq.trigger_mode = 0;
> -    irq.redir_hint = 0;
> +    X86IOMMUIrq irq = {
> +        .vector = FIELD_EX64(xt_reg, AMDVI_XT_GEN_INTR, VECTOR),
> +        .delivery_mode = FIELD_EX64(xt_reg, AMDVI_XT_GEN_INTR, DELIVERY_MODE),
> +        .dest_mode = FIELD_EX64(xt_reg, AMDVI_XT_GEN_INTR, DEST_MODE),
> +        .dest = (FIELD_EX64(xt_reg, AMDVI_XT_GEN_INTR, DEST_HI) << 24) |
> +                 FIELD_EX64(xt_reg, AMDVI_XT_GEN_INTR, DEST_LO),
> +        .trigger_mode = 0,
> +        .redir_hint = 0,
> +    };
> 
> which is in line with your request.
> 
> The one reason I would think to keep this current commit is that it is
> intended to close the Coverity issue (CID: 1660056). But I can always just
> add that trailer to the new patch that does all of the bitfield removal
> work, it would just be "less focused".
> 
> I am ready to send a v2 for this series that keeps the current two patches
> and adds 2 more removing all of the bitfield usage. Or I can just drop this
> current patch since it is folded into one of the new ones, and put the CID
> trailer on it.
> 
> Please let me know what is the preferred way to handle it.

Doesn't matter to me :)

> >> This is fine for the Coverity problem, but you do also need to
> >> get rid of the bitfield-union as a separate issue.
> > 
> > Ideal task for AI actually.
> > 
> 
> Yeah, it is pretty mechanical, but IIUC we are still not officially allowed
> to use it :).
> 
> Alejandro
> 
> >> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> >>
> >> thanks
> >> -- PMM
> > 
> > 


