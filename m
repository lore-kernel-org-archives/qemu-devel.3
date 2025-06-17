Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BC88C71157
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Jun 2025 17:24:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRa2s-0005Uh-Cg; Tue, 17 Jun 2025 13:24:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uRa2p-0005UQ-HA
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 13:24:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uRa2n-0006ty-ES
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 13:24:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750181056;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eCSIK9sJf1TbKzoLzHg7nTCu7TbZE2JoQkVPWqiOVmQ=;
 b=XfwuuSzkgMeI0VlSFgnxhb0RPrxclRcs2btg7eCWvTr0xsGffglYH+fPkchHtSmJ9a2t7J
 fEYKcMdNISIrSzVxYYMpshLk8YjXiYxvu9VPaC/410O5PuTAiLN74//PnOuSKh5k6BT/k8
 9rl7jt/MRULc8RArqmRi2LY3wL/3o5o=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-1-S3MJyLTTNsysmdqda8yjqg-1; Tue, 17 Jun 2025 13:24:15 -0400
X-MC-Unique: S3MJyLTTNsysmdqda8yjqg-1
X-Mimecast-MFC-AGG-ID: S3MJyLTTNsysmdqda8yjqg_1750181054
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-451d7de4ae3so39302715e9.2
 for <qemu-devel@nongnu.org>; Tue, 17 Jun 2025 10:24:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750181054; x=1750785854;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eCSIK9sJf1TbKzoLzHg7nTCu7TbZE2JoQkVPWqiOVmQ=;
 b=QIt6cTD7ZSY3d3KLAdrRVYeLOWvYCVfuxEJ+hRQvIv/MCxgecH/QNFvqKO1+4EizS/
 2vgdfM5vaDsSfVGNjWcsM1dhOdpeJokRzyRPfLem+/3nm2w8qAF2arvEA4NMDRYlGvVq
 ciGlKppQbo5o4saD7YYjCilCiH/eYkHHzguUZBVn5IvrtzsZr5U8L+wEZP9uBXQ28PD+
 6c7+gho1nnvPGefdkXlwQE0569alIcLbQmS/wKpCG8mY5KGrWb4G7JK64p+4YpmZ+npZ
 AMZjoTafwUhGH4NRDqIC6zMlgzZzRZYfjYgl9PU1vrgQQMCL26rMZv0cTGo+vfWI9E9/
 tQ0w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVrHbinOhLGAmThCcS7U9O+soszpLZVyubUZE2cWw+AOi3Ddw2rE4NqIAtK8wuLK0Aqzjcrlgx9vSs1@nongnu.org
X-Gm-Message-State: AOJu0Yy4U3+K+xLoSWbRMsClQkrjdJhgNcArHI6RH+fiuJYZZxFhOtGI
 q9zDCL5n85AFOCldrvd3aGGNKkAonnBmVp2JYSPFsZfSz7bX55r9oAZr6bjhrtk2NvI1H/PMlTe
 5toq+YJfoz5L8gAGMed1Lza8UuaDyqaShTr3Zm7nQeUcXxMf/3Pqli+cg
X-Gm-Gg: ASbGncsyIg3bf0mRnl2C1KSwYimxuhZmYSTImnqO+86Snd2bXT1C0aeM8sQBeINvhwy
 ISrC0yvkwAPv5mj/gwvzTGgohvQ1Ow5+elG1mqVueQOrICsEskQuzZenx/B3XyH/9zIaP7qYEYb
 JGya+fCBfNjqpX3YqihXJiDPQap2BAKSHF0MQ7NRFyvIomGPXHwbfWe9oXeLoOdV5tLd5bs5VNL
 1ttkDzIlr1d5ulRIZp8DE9blgBbKce0Zj2BTVwcllfSfXkUaQRBgUhl/kbqcBEBYBvTaDUGgtWI
 dKsXFjMnaFZTjxrYmQFXpVcdOuNRhpfKpPzJMuCBQIP5PH8ipPt5KfuXz2oxw3qGN/QuAQ==
X-Received: by 2002:a05:600c:5025:b0:43c:fd27:a216 with SMTP id
 5b1f17b1804b1-4533caed7ccmr127942825e9.23.1750181053725; 
 Tue, 17 Jun 2025 10:24:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEn8U8HHk7oyIJDFHpr6XPxVbDKN1yp99R7A0+ZF3783X3qF8pDLLxQL8hmMprE01vOi3ANYg==
X-Received: by 2002:a05:600c:5025:b0:43c:fd27:a216 with SMTP id
 5b1f17b1804b1-4533caed7ccmr127942415e9.23.1750181053266; 
 Tue, 17 Jun 2025 10:24:13 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4532e14fc8bsm182059505e9.28.2025.06.17.10.24.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Jun 2025 10:24:12 -0700 (PDT)
Message-ID: <e75d6344-9858-400a-9c73-1359789e15a9@redhat.com>
Date: Tue, 17 Jun 2025 19:24:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 02/15] intel_iommu: Optimize context entry cache
 utilization
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, mst@redhat.com,
 jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, shameerali.kolothum.thodi@huawei.com,
 joao.m.martins@oracle.com, clement.mathieu--drif@eviden.com,
 kevin.tian@intel.com, yi.l.liu@intel.com, chao.p.peng@intel.com,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
References: <20250606100416.346132-1-zhenzhong.duan@intel.com>
 <20250606100416.346132-3-zhenzhong.duan@intel.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250606100416.346132-3-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.89,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Zhenzhong,

On 6/6/25 12:04 PM, Zhenzhong Duan wrote:
> There are many call sites referencing context entry by calling
> vtd_dev_to_context_entry() which will traverse the DMAR table.
>
> In most cases we can use cached context entry in vtd_as->context_cache_entry
> except when its entry is stale. Currently only global and domain context
> invalidation stale it.
>
> So introduce a helper function vtd_as_to_context_entry() to fetch from cache
> before trying with vtd_dev_to_context_entry().
>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>  hw/i386/intel_iommu.c | 36 +++++++++++++++++++++++-------------
>  1 file changed, 23 insertions(+), 13 deletions(-)
>
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index f0b1f90eff..a2f3250724 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -1597,6 +1597,22 @@ static int vtd_dev_to_context_entry(IntelIOMMUState *s, uint8_t bus_num,
>      return 0;
>  }
>  
> +static int vtd_as_to_context_entry(VTDAddressSpace *vtd_as, VTDContextEntry *ce)
> +{
> +    IntelIOMMUState *s = vtd_as->iommu_state;
> +    uint8_t bus_num = pci_bus_num(vtd_as->bus);
> +    uint8_t devfn = vtd_as->devfn;
> +    VTDContextCacheEntry *cc_entry = &vtd_as->context_cache_entry;
> +
> +    /* Try to fetch context-entry from cache first */
> +    if (cc_entry->context_cache_gen == s->context_cache_gen) {
> +        *ce = cc_entry->context_entry;
> +        return 0;
> +    } else {
> +        return vtd_dev_to_context_entry(s, bus_num, devfn, ce);
> +    }
> +}
> +
While the patch looks good to me can't you use the helper also in
vtd_do_iommu_translate()?
See " /* Try to fetch context-entry from cache first */"

If not you may add a comment in the commit desc while it can't be
applied there.

Thanks

Eric
>  static int vtd_sync_shadow_page_hook(const IOMMUTLBEvent *event,
>                                       void *private)
>  {
> @@ -1649,9 +1665,7 @@ static int vtd_address_space_sync(VTDAddressSpace *vtd_as)
>          return 0;
>      }
>  
> -    ret = vtd_dev_to_context_entry(vtd_as->iommu_state,
> -                                   pci_bus_num(vtd_as->bus),
> -                                   vtd_as->devfn, &ce);
> +    ret = vtd_as_to_context_entry(vtd_as, &ce);
>      if (ret) {
>          if (ret == -VTD_FR_CONTEXT_ENTRY_P) {
>              /*
> @@ -1710,8 +1724,7 @@ static bool vtd_as_pt_enabled(VTDAddressSpace *as)
>      assert(as);
>  
>      s = as->iommu_state;
> -    if (vtd_dev_to_context_entry(s, pci_bus_num(as->bus), as->devfn,
> -                                 &ce)) {
> +    if (vtd_as_to_context_entry(as, &ce)) {
>          /*
>           * Possibly failed to parse the context entry for some reason
>           * (e.g., during init, or any guest configuration errors on
> @@ -2435,8 +2448,7 @@ static void vtd_iotlb_domain_invalidate(IntelIOMMUState *s, uint16_t domain_id)
>      vtd_iommu_unlock(s);
>  
>      QLIST_FOREACH(vtd_as, &s->vtd_as_with_notifiers, next) {
> -        if (!vtd_dev_to_context_entry(s, pci_bus_num(vtd_as->bus),
> -                                      vtd_as->devfn, &ce) &&
> +        if (!vtd_as_to_context_entry(vtd_as, &ce) &&
>              domain_id == vtd_get_domain_id(s, &ce, vtd_as->pasid)) {
>              vtd_address_space_sync(vtd_as);
>          }
> @@ -2458,8 +2470,7 @@ static void vtd_iotlb_page_invalidate_notify(IntelIOMMUState *s,
>      hwaddr size = (1 << am) * VTD_PAGE_SIZE;
>  
>      QLIST_FOREACH(vtd_as, &(s->vtd_as_with_notifiers), next) {
> -        ret = vtd_dev_to_context_entry(s, pci_bus_num(vtd_as->bus),
> -                                       vtd_as->devfn, &ce);
> +        ret = vtd_as_to_context_entry(vtd_as, &ce);
>          if (!ret && domain_id == vtd_get_domain_id(s, &ce, vtd_as->pasid)) {
>              uint32_t rid2pasid = PCI_NO_PASID;
>  
> @@ -2966,8 +2977,7 @@ static void vtd_piotlb_pasid_invalidate(IntelIOMMUState *s,
>      vtd_iommu_unlock(s);
>  
>      QLIST_FOREACH(vtd_as, &s->vtd_as_with_notifiers, next) {
> -        if (!vtd_dev_to_context_entry(s, pci_bus_num(vtd_as->bus),
> -                                      vtd_as->devfn, &ce) &&
> +        if (!vtd_as_to_context_entry(vtd_as, &ce) &&
>              domain_id == vtd_get_domain_id(s, &ce, vtd_as->pasid)) {
>              uint32_t rid2pasid = VTD_CE_GET_RID2PASID(&ce);
>  
> @@ -4146,7 +4156,7 @@ static void vtd_report_ir_illegal_access(VTDAddressSpace *vtd_as,
>      assert(vtd_as->pasid != PCI_NO_PASID);
>  
>      /* Try out best to fetch FPD, we can't do anything more */
> -    if (vtd_dev_to_context_entry(s, bus_n, vtd_as->devfn, &ce) == 0) {
> +    if (vtd_as_to_context_entry(vtd_as, &ce) == 0) {
>          is_fpd_set = ce.lo & VTD_CONTEXT_ENTRY_FPD;
>          if (!is_fpd_set && s->root_scalable) {
>              vtd_ce_get_pasid_fpd(s, &ce, &is_fpd_set, vtd_as->pasid);
> @@ -4506,7 +4516,7 @@ static void vtd_iommu_replay(IOMMUMemoryRegion *iommu_mr, IOMMUNotifier *n)
>      /* replay is protected by BQL, page walk will re-setup it safely */
>      iova_tree_remove(vtd_as->iova_tree, map);
>  
> -    if (vtd_dev_to_context_entry(s, bus_n, vtd_as->devfn, &ce) == 0) {
> +    if (vtd_as_to_context_entry(vtd_as, &ce) == 0) {
>          trace_vtd_replay_ce_valid(s->root_scalable ? "scalable mode" :
>                                    "legacy mode",
>                                    bus_n, PCI_SLOT(vtd_as->devfn),


