Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA638C77B7F
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Jun 2025 12:03:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTfsp-0005jL-Lj; Mon, 23 Jun 2025 08:02:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uTfso-0005j1-1t
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 08:02:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uTfsk-0006KY-5z
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 08:02:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750680155;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jwdyUuYR25FH/OlQ5jng/xhrlZO+UEtAbzlMGZtpmA4=;
 b=grz7S5pT0XJh8UiEBs9L4pT++zCQwWQ5vtcq8CCOl8X3ttjcYM8sA8jL/oU2SAM1gmyAYI
 rh7vcMt+IpOpFHdljY5Pg3O3/1sddqCwlkaKD5nsYlP2RsR1dcZFZfg7vx4juwcfsszCZu
 Yi2KYo0lF6zLoNFnNQ3OjRVNfYtabzQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-373-BmkGSA2ROcW57UhmFCVC8A-1; Mon, 23 Jun 2025 08:02:26 -0400
X-MC-Unique: BmkGSA2ROcW57UhmFCVC8A-1
X-Mimecast-MFC-AGG-ID: BmkGSA2ROcW57UhmFCVC8A_1750680144
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-450eaae2934so35286315e9.2
 for <qemu-devel@nongnu.org>; Mon, 23 Jun 2025 05:02:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750680144; x=1751284944;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jwdyUuYR25FH/OlQ5jng/xhrlZO+UEtAbzlMGZtpmA4=;
 b=BvrYo895wZy3EIkfUSQyuYfN7Bwk/fFnZlkJXY6iaHGIVgeFpxPsbdAVR+56WEckw4
 RVqcr0okGJQa3imozskSiwEMOGKzkIuXxo5gX0WZ5IMPeLPQE+3yHBV/15B358DfOIBc
 qCbOLhFQMB8VWnP+xi646vQtHVEaCH7cmSgya8Aws54beVe1QJnA1SlP2ze+Deu838Ee
 EcHgtrtupjuVs8QS0uOvdIuz0xUfAgnibcaIFp1PVjJXXVwL0zvufziwGP15EDoQoo6U
 yCeGu2BT5BD4lL/JmHJJkNKu+P6WVvqUjb5RakLnWlKx0SAxb4tmjHYHsvOEL2EA7Hax
 3HSg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU+RPqO1oIpTGvkidkJ1QVeS5eZeaG1ve7M7MjVct0gE//LSCrjwcHAVtTW/1QAjyzgSmkJJYB73K9Z@nongnu.org
X-Gm-Message-State: AOJu0Yy+4+p2Q2rfW1SCPgsgW5PyH+iBveZVKKKoUgH6AZHovYmUNRr4
 uwNNo+EMMPk+ROZs1harGbflGO0WqaqWZholbfqWJEFLckw8ql20oMDoPNcW/FDAGG61rs2X7vS
 c8Tozp3uqGUrfune+cBwW+WeaxiifPXzi/mfER0xtr49FvoBSuVxPf+3s
X-Gm-Gg: ASbGncsY95LwailhmvAVxoi6EDOP877urR/0baWs9NWtliuPuI8fRwXSUlAo6kk9tIY
 IzQ878dUsfgOgPE+XdvxxuiNw0wa6/3/BFhf/d/XYZrsvrj/mT+MX2dQGEQMFkOkRTx/T1zaA78
 fpyRgOPN9Z18gWFJi42q0AeJIYhgkUrGvXnF/tCea8dWWi76W1g8GvOpHTxCJC3lkwXAwvlLu4z
 7Td5DMlpFzIcGZhksoU5ECIYvwy6GXylXXnVRyVTk0ScDqHiBPADdwFJu//51EU6hlEYDEsZmz1
 P+MJ42eeeAPyComEl/cOFakPPJqTEe+c13PCVDcMi5Ug+geWIneukyoWeEgge6k6YyzZhQ==
X-Received: by 2002:a05:600c:3b14:b0:43d:fa59:be39 with SMTP id
 5b1f17b1804b1-45365a0acfdmr102616135e9.33.1750680142242; 
 Mon, 23 Jun 2025 05:02:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFXEfu3WCw9jTRkJDr8ZrXOpnkbJKkx3NonOwf/INPm2dagjFwaF3Ovpz+YncrVuiUVVsNOWQ==
X-Received: by 2002:a05:600c:3b14:b0:43d:fa59:be39 with SMTP id
 5b1f17b1804b1-45365a0acfdmr102615235e9.33.1750680141461; 
 Mon, 23 Jun 2025 05:02:21 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45365af83easm102734225e9.25.2025.06.23.05.02.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Jun 2025 05:02:20 -0700 (PDT)
Message-ID: <275e56ed-940b-4ebe-a1bb-37c556ea909f@redhat.com>
Date: Mon, 23 Jun 2025 14:02:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 13/19] intel_iommu: Stick to system MR for IOMMUFD
 backed host device when x-fls=on
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, mst@redhat.com,
 jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, shameerali.kolothum.thodi@huawei.com,
 joao.m.martins@oracle.com, clement.mathieu--drif@eviden.com,
 kevin.tian@intel.com, yi.l.liu@intel.com, chao.p.peng@intel.com,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
References: <20250620071813.55571-1-zhenzhong.duan@intel.com>
 <20250620071813.55571-14-zhenzhong.duan@intel.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250620071813.55571-14-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 6/20/25 9:18 AM, Zhenzhong Duan wrote:
> When guest in scalable mode and x-flts=on, we stick to system MR for IOMMUFD
when guest works in scalable mode ?
> backed host device. Then its default hwpt contains GPA->HPA mappings which is
> used directly if PGTT=PT and used as nested parent if PGTT=FLT. Otherwise
> fallback to original processing.
>
> Suggested-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>  hw/i386/intel_iommu.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index ed71bb8ec7..be01f8885f 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -1779,6 +1779,7 @@ static bool vtd_dev_pt_enabled(IntelIOMMUState *s, VTDContextEntry *ce,
>               */
>              return false;
>          }
> +
spurious new line
>          return (VTD_PE_GET_TYPE(&pe) == VTD_SM_PASID_ENTRY_PT);
>      }
>  
> @@ -1790,10 +1791,33 @@ static bool vtd_as_pt_enabled(VTDAddressSpace *as)
>  {
>      IntelIOMMUState *s;
>      VTDContextEntry ce;
> +    struct vtd_as_key key = {
> +        .bus = as->bus,
> +        .devfn = as->devfn,
> +    };
>  
>      assert(as);
>  
>      s = as->iommu_state;
> +
> +    /*
> +     * When guest in scalable mode and x-flts=on, we stick to system MR
ditto
> +     * for IOMMUFD backed host device. Then its default hwpt contains
> +     * GPA->HPA mappings which is used directly if PGTT=PT and used as
> +     * nested parent if PGTT=FLT. Otherwise fallback to original
fall back here and above

This comment sounds a little bit unrelated to the below implementation
which does not refer to system MR. how does the search for the hiod
relate to that. I would refocus the comment.
> +     * processing.
> +     */
> +     if (s->root_scalable && s->flts) {
> +        VTDHostIOMMUDevice *vtd_hiod;
> +
> +        vtd_hiod = g_hash_table_lookup(s->vtd_host_iommu_dev, &key);
> +        if (vtd_hiod && vtd_hiod->hiod &&
> +            object_dynamic_cast(OBJECT(vtd_hiod->hiod),
> +                                TYPE_HOST_IOMMU_DEVICE_IOMMUFD)) {
> +            return true;
> +        }
> +    }
> +
>      if (vtd_dev_to_context_entry(s, pci_bus_num(as->bus), as->devfn,
>                                   &ce)) {
>          /*
Eric


