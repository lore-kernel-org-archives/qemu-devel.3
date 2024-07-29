Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D65CAC3DA61
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2024 08:43:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYLxW-0007uI-Vd; Mon, 29 Jul 2024 04:42:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sYLxV-0007tV-Fc
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 04:42:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sYLxS-0002Qz-FH
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 04:42:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722242536;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6cjvOU+S7hHm9/cVDlwHff02jVoqdJeW9+6Bu9nr8SI=;
 b=FdUSQgir73wyzJ4O1/M+oOQ6LD7mx30mV8z1L4kXWMhAbBlGIcSCzqwEoE5UHgeD1Dc0V/
 AHXPs/78LVvxhpAWQT9/VPB3F4K7pIDYJ6aCmIQp0BZggVWTC8n80VJKkCe4/aix2hrOPA
 LjNNgeSBNmqjss46sAIB9Gh63Z93wOM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-286-PyrC-AeYM4WaDsyzNyfAWA-1; Mon, 29 Jul 2024 04:42:14 -0400
X-MC-Unique: PyrC-AeYM4WaDsyzNyfAWA-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4280b119a74so16652745e9.3
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2024 01:42:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722242533; x=1722847333;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6cjvOU+S7hHm9/cVDlwHff02jVoqdJeW9+6Bu9nr8SI=;
 b=BBoXHq3ozW4KKq9dS0khGS2gFDy5J+h6ElrOUlhD9Y2Ov1d7xcBmgedv5A6RIeOF+2
 6Cvn31+fPBw5X1hkWQm7gPILEmvzb5hN34AmewpwaTOTE36dOobcjmmEaguJdDvl4di6
 evGpziPrL6HvA25CsK7m6DfdqfuWElyr3oJ252es5Dalrv5J0alch7Vsbl2+Tc0WOiul
 hktBPssNZVgz8EZM3pdycfeOdJqa/5h94R9s5FEbyDWfeat6XnUT459kamOzei8xEtO5
 mQ2y2t43HOS8PusNxhYAXMWYrv3UePCW/ucIW1rDfeqpYIiTiE0XWZxB/cfn8Adbup37
 GBhw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWcQz+Ye81TmfWk0qGg3+HyjPgey/Cobi1ShTVWTU2ihEoyZqjHt2M8G8zxbzseqA8LOT4cz03khAYBKVwTEDP5Hw+6DIU=
X-Gm-Message-State: AOJu0YwOhNbtDoXlrrdVr7IwyKTVC1/Q+fKHglm+Gf6oofF/7sn/tcyR
 AQJdr7FkarjxperdXpYeYvZICYtJW4KZ13UmQK6RQ+rI6Nd14l0BSsCL+uyT3LE5lZU2cV+D3jE
 FEkICSqn5zxANEpRz5AxDQmg5OKGGdTyyKiYlh6NoKA3GhOGJdqac
X-Received: by 2002:a05:600c:1da8:b0:426:6ead:5709 with SMTP id
 5b1f17b1804b1-42811d8893fmr54353215e9.9.1722242532918; 
 Mon, 29 Jul 2024 01:42:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHmD5m/Zv6WrhOcCn87EVOEa8CCPINvUhFNYLO+KO68TrH3IVnVgTJRO/u3B04W+vhPG0WsIQ==
X-Received: by 2002:a05:600c:1da8:b0:426:6ead:5709 with SMTP id
 5b1f17b1804b1-42811d8893fmr54352735e9.9.1722242532270; 
 Mon, 29 Jul 2024 01:42:12 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1ee:e604:6fb3:bf7d:9d11:b793])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42805730d5bsm174533845e9.8.2024.07.29.01.42.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jul 2024 01:42:11 -0700 (PDT)
Date: Mon, 29 Jul 2024 04:42:05 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Yi Liu <yi.l.liu@intel.com>
Cc: jasowang@redhat.com, alex.williamson@redhat.com, clg@redhat.com,
 eric.auger@redhat.com, peterx@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com,
 chao.p.peng@intel.com, Yu Zhang <yu.c.zhang@linux.intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v1 01/17] intel_iommu: Use the latest fault reasons
 defined by spec
Message-ID: <20240729043610-mutt-send-email-mst@kernel.org>
References: <20240718081636.879544-1-zhenzhong.duan@intel.com>
 <20240718081636.879544-2-zhenzhong.duan@intel.com>
 <db972177-851c-4aa9-bd4c-777fe2b01ae3@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <db972177-851c-4aa9-bd4c-777fe2b01ae3@intel.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Jul 29, 2024 at 03:39:03PM +0800, Yi Liu wrote:
> On 2024/7/18 16:16, Zhenzhong Duan wrote:
> > From: Yu Zhang <yu.c.zhang@linux.intel.com>
> > 
> > Spec revision 3.0 or above defines more detailed fault reasons for
> > scalable mode. So introduce them into emulation code, see spec
> > section 7.1.2 for details.
> > 
> > Note spec revision has no relation with VERSION register, Guest
> > kernel should not use that register to judge what features are
> > supported. Instead cap/ecap bits should be checked.
> > 
> > Signed-off-by: Yu Zhang <yu.c.zhang@linux.intel.com>
> > Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> > ---
> >   hw/i386/intel_iommu_internal.h |  9 ++++++++-
> >   hw/i386/intel_iommu.c          | 25 ++++++++++++++++---------
> >   2 files changed, 24 insertions(+), 10 deletions(-)
> > 
> > diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
> > index f8cf99bddf..c0ca7b372f 100644
> > --- a/hw/i386/intel_iommu_internal.h
> > +++ b/hw/i386/intel_iommu_internal.h
> > @@ -311,7 +311,14 @@ typedef enum VTDFaultReason {
> >                                     * request while disabled */
> >       VTD_FR_IR_SID_ERR = 0x26,   /* Invalid Source-ID */
> > -    VTD_FR_PASID_TABLE_INV = 0x58,  /*Invalid PASID table entry */
> > +    /* PASID directory entry access failure */
> > +    VTD_FR_PASID_DIR_ACCESS_ERR = 0x50,
> > +    /* The Present(P) field of pasid directory entry is 0 */
> > +    VTD_FR_PASID_DIR_ENTRY_P = 0x51,
> > +    VTD_FR_PASID_TABLE_ACCESS_ERR = 0x58, /* PASID table entry access failure */
> > +    /* The Present(P) field of pasid table entry is 0 */
> > +    VTD_FR_PASID_ENTRY_P = 0x59,
> > +    VTD_FR_PASID_TABLE_ENTRY_INV = 0x5b,  /*Invalid PASID table entry */
> >       /* Output address in the interrupt address range for scalable mode */
> >       VTD_FR_SM_INTERRUPT_ADDR = 0x87,
> > diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> > index 37c21a0aec..e65f5b29a5 100644
> > --- a/hw/i386/intel_iommu.c
> > +++ b/hw/i386/intel_iommu.c
> > @@ -796,7 +796,7 @@ static int vtd_get_pdire_from_pdir_table(dma_addr_t pasid_dir_base,
> >       addr = pasid_dir_base + index * entry_size;
> >       if (dma_memory_read(&address_space_memory, addr,
> >                           pdire, entry_size, MEMTXATTRS_UNSPECIFIED)) {
> > -        return -VTD_FR_PASID_TABLE_INV;
> > +        return -VTD_FR_PASID_DIR_ACCESS_ERR;
> >       }
> >       pdire->val = le64_to_cpu(pdire->val);
> > @@ -814,6 +814,7 @@ static int vtd_get_pe_in_pasid_leaf_table(IntelIOMMUState *s,
> >                                             dma_addr_t addr,
> >                                             VTDPASIDEntry *pe)
> >   {
> > +    uint8_t pgtt;
> >       uint32_t index;
> >       dma_addr_t entry_size;
> >       X86IOMMUState *x86_iommu = X86_IOMMU_DEVICE(s);
> > @@ -823,7 +824,7 @@ static int vtd_get_pe_in_pasid_leaf_table(IntelIOMMUState *s,
> >       addr = addr + index * entry_size;
> >       if (dma_memory_read(&address_space_memory, addr,
> >                           pe, entry_size, MEMTXATTRS_UNSPECIFIED)) {
> > -        return -VTD_FR_PASID_TABLE_INV;
> > +        return -VTD_FR_PASID_TABLE_ACCESS_ERR;
> >       }
> >       for (size_t i = 0; i < ARRAY_SIZE(pe->val); i++) {
> >           pe->val[i] = le64_to_cpu(pe->val[i]);
> > @@ -831,11 +832,13 @@ static int vtd_get_pe_in_pasid_leaf_table(IntelIOMMUState *s,
> >       /* Do translation type check */
> >       if (!vtd_pe_type_check(x86_iommu, pe)) {
> > -        return -VTD_FR_PASID_TABLE_INV;
> > +        return -VTD_FR_PASID_TABLE_ENTRY_INV;
> >       }
> > -    if (!vtd_is_level_supported(s, VTD_PE_GET_LEVEL(pe))) {
> > -        return -VTD_FR_PASID_TABLE_INV;
> > +    pgtt = VTD_PE_GET_TYPE(pe);
> > +    if (pgtt == VTD_SM_PASID_ENTRY_SLT &&
> > +        !vtd_is_level_supported(s, VTD_PE_GET_LEVEL(pe))) {
> > +            return -VTD_FR_PASID_TABLE_ENTRY_INV;
> >       }
> >       return 0;
> > @@ -876,7 +879,7 @@ static int vtd_get_pe_from_pasid_table(IntelIOMMUState *s,
> >       }
> >       if (!vtd_pdire_present(&pdire)) {
> > -        return -VTD_FR_PASID_TABLE_INV;
> > +        return -VTD_FR_PASID_DIR_ENTRY_P;
> >       }
> >       ret = vtd_get_pe_from_pdire(s, pasid, &pdire, pe);
> > @@ -885,7 +888,7 @@ static int vtd_get_pe_from_pasid_table(IntelIOMMUState *s,
> >       }
> >       if (!vtd_pe_present(pe)) {
> > -        return -VTD_FR_PASID_TABLE_INV;
> > +        return -VTD_FR_PASID_ENTRY_P;
> >       }
> >       return 0;
> > @@ -938,7 +941,7 @@ static int vtd_ce_get_pasid_fpd(IntelIOMMUState *s,
> >       }
> >       if (!vtd_pdire_present(&pdire)) {
> > -        return -VTD_FR_PASID_TABLE_INV;
> > +        return -VTD_FR_PASID_DIR_ENTRY_P;
> >       }
> >       /*
> > @@ -1795,7 +1798,11 @@ static const bool vtd_qualified_faults[] = {
> >       [VTD_FR_ROOT_ENTRY_RSVD] = false,
> >       [VTD_FR_PAGING_ENTRY_RSVD] = true,
> >       [VTD_FR_CONTEXT_ENTRY_TT] = true,
> > -    [VTD_FR_PASID_TABLE_INV] = false,
> > +    [VTD_FR_PASID_DIR_ACCESS_ERR] = false,
> > +    [VTD_FR_PASID_DIR_ENTRY_P] = true,
> > +    [VTD_FR_PASID_TABLE_ACCESS_ERR] = false,
> > +    [VTD_FR_PASID_ENTRY_P] = true,
> > +    [VTD_FR_PASID_TABLE_ENTRY_INV] = true,
> >       [VTD_FR_SM_INTERRUPT_ADDR] = true,
> >       [VTD_FR_MAX] = false,
> >   };
> 
> @Jason, @Michael,
> 
> Do you know the rule of setting this table? I noticed it was introduced
> since day-1[1]. I didn't see any history discussion on it on lore. So not
> quite sure about the purpose of it. Per the usage of this table, it is used
> as a filter when the iommu driver has set the FPD bit. If FPD is set, some
> errors need not to trigger a trace which is mostly for debug purpose.
> 
> I noticed Peter had asked it as well[2]. But I don't think it was clarified
> clearly. May we have a clarification for it here? BTW. I didn't see VT-d
> spec has any definition on it. So it should just be a software trick. :)
> 
> [1] https://lore.kernel.org/qemu-devel/1408168544-28605-3-git-send-email-tamlokveer@gmail.com/
> [2] https://lore.kernel.org/qemu-devel/20190301065219.GA22229@xz-x1/
> 
> -- 
> Regards,
> Yi Liu

Are you asking for a definition of qualified fault conditions?


7.1.1 Non-Recoverable Address Translation Faults
Non-recoverable address translation faults can be detected by remapping hardware for many different
kinds of requests as shown by Table 26. A non-recoverable fault condition is considered “qualified” if
software can suppress reporting of the fault by setting one of the Fault Processing Disable (FPD) bits
available in one or more of the address translation structures (i.e., the context-entry, scalable-mode
context-entry, scalable-mode PASID-directory entry, scalable-mode PASID-table entry). For a request
that encounters a “qualified” non-recoverable fault condition, if the remapping hardware encountered
any translation structure entry with an FPD field value of 1, the remapping hardware must not report
the fault to software. For example, when processing a request that encounters an FPD field with a value
of 1 in the scalable-mode context-entry and encounters any “qualified” fault such as SCT.*, SPD.*, SPT.*,
SFS.*, SSS.*, or SGN.*, the remapping hardware will not report the fault to software. Memory requests
that result in non-recoverable address translation faults are blocked by hardware


-- 
MST


