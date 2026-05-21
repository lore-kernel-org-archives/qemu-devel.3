Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61424CD5BAC
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 13:42:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQ3eh-0004Oe-H9; Thu, 21 May 2026 09:41:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wQ3eI-0004NY-7u
 for qemu-devel@nongnu.org; Thu, 21 May 2026 09:41:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wQ3eF-00086W-9x
 for qemu-devel@nongnu.org; Thu, 21 May 2026 09:41:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779370873;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L4KGJrXj3SXaE3N62YywG9MlT51swrnaT8KGmGeD2vk=;
 b=b4PfUZcaibp6qA5CmMh1ysSvfiA++lgL963U9x/zpU4Dl92oI2gF8Tj6F0rBquBFuMJZgw
 j05F4FyT+hnwtrCLZBrmCP1kmkhF83O8yUm//5aCIVHkIKefJjVtwJpfpfQ1WX5sln8O7j
 /h6zS5Z+XggeiDckbRIS1M/Urx4Yjeo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-47-XG1-Om6KMYuJl05DPmq6pw-1; Thu, 21 May 2026 09:41:11 -0400
X-MC-Unique: XG1-Om6KMYuJl05DPmq6pw-1
X-Mimecast-MFC-AGG-ID: XG1-Om6KMYuJl05DPmq6pw_1779370869
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-48a589c7879so46384285e9.1
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 06:41:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779370869; x=1779975669;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L4KGJrXj3SXaE3N62YywG9MlT51swrnaT8KGmGeD2vk=;
 b=Tq7EePkp+2iN7iAiyqfSErMrhL8BW0yksKycPwH1+dI6Ljukejwf4U+dQX8Vld4F2+
 WuaqhTByWmnUYxhNr7RivFeHoSjCtgAhdkUTuCUwbTKqm5PrtkdRjmCJcYRWc5qSl/Mr
 c/aAAdXzyl/GVJ4/mPrU862jBAegPp+dZaC2Qg6+mUU5VjpaLX2LvlvV44JxFIcS3xQc
 uZkQZccev4B7ti6sPGIZZ0fhx2AXyanIuxQ8GKS1ObHb5mjuDS2q2s5yhwDpgcnoQnJT
 YcCjeQmKV/hqLpRwnBGl6bKFyj9Pz38hvdlCMcyy4j/SxPcppSOq2OD9CX6ArTDBMq7D
 unNg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9DIY0L9jtmUhZvwb1AsGpohy7HxLTWCkeJPvN7zKoauTek97scPdXodrQQn6RT/Vre8zr/uUYMRymL@nongnu.org
X-Gm-Message-State: AOJu0YyYkLX52ZZVyBPwbK3inZT7AAamo7W4aUhsf0nbyvSpUqnQgNIi
 NlsHNmZgXIFP3OFoAfn5iVP0uk97aE8CnpcjwYr+fCOMLlsTTAhpesjA+Utop0rUxn3fZbOv7DM
 HZ3NZU1OkusgdLZJfxKBU8ftKBrLXFs8o3a9xCvufrdUJJJYxTIzLM4Yw
X-Gm-Gg: Acq92OFAsibTUPk/vVLj/81nDDOOUHHVBqftb6AgEeQ3xykqzLUF5Wx9pGmOalmeC+b
 jAKDnsUYe/9KhGkKdxpnv2GVh+jKmAmfJEvYobBVnSzMeTFr4YzGsl9r8e3Sp1srdSCZfP9zFXV
 ua2QukbFaBrW+vv6Q4wgCSTBDA6GKmixqfzicYaakU41d+RluuPumMH/6ZhSzY+9N2vhGmU/GEY
 Pw95LDh+NnlN/+1fI9w5QVJd8owdpn98XCArOd4yOpIbfgq2Xh9wwXHQDvoyrAF2YtC+uqsgJZa
 Xo+jeazNRBNaFnjHLA8TMYhDHoHWqmNoeksF1KsEdKzsDZXzu1vaRbINbaDQFkOoL8OGOs4IRa+
 vWQV9cvT23YIk6k8En5PCzuyJvqr0DaqCzPAwTzRIJ90Y5dl26mRwPBGDgOwktaMxwsoKeg==
X-Received: by 2002:a05:600c:1c1d:b0:48a:79d8:a8d6 with SMTP id
 5b1f17b1804b1-4903607fd1emr38205045e9.7.1779370868693; 
 Thu, 21 May 2026 06:41:08 -0700 (PDT)
X-Received: by 2002:a05:600c:1c1d:b0:48a:79d8:a8d6 with SMTP id
 5b1f17b1804b1-4903607fd1emr38204495e9.7.1779370868163; 
 Thu, 21 May 2026 06:41:08 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49033cdcc01sm74597325e9.0.2026.05.21.06.41.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 May 2026 06:41:07 -0700 (PDT)
Message-ID: <2a4edb3b-064b-4c46-8737-1bd74d5f22e9@redhat.com>
Date: Thu, 21 May 2026 15:41:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 20/32] hw/arm/tegra241-cmdqv: Use mmap'd VINTF page0 as
 VCMDQ backing
Content-Language: en-US
To: Shameer Kolothum <skolothumtho@nvidia.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, clg@redhat.com, alex@shazbot.org,
 nicolinc@nvidia.com, nathanc@nvidia.com, mochs@nvidia.com, jan@nvidia.com,
 jgg@nvidia.com, zhenzhong.duan@intel.com, kjaju@nvidia.com,
 phrdina@redhat.com
References: <20260519103727.899332-1-skolothumtho@nvidia.com>
 <20260519103727.899332-21-skolothumtho@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20260519103727.899332-21-skolothumtho@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Shameer,

On 5/19/26 12:36 PM, Shameer Kolothum wrote:
> Introduce tegra241_cmdqv_vintf_ptr() to route VCMDQ Page0 register
> accesses through the mmap'd VINTF page0 backing once a hardware
> queue has been allocated.
>
> There are two QEMU trapped MMIO apertures for VCMDQ Page0 registers:
>
>   - Direct VCMDQ Page0 aperture (offset 0x10000)
>   - VINTF Page0 (offset 0x30000)
>
> These are hardware aliases: they address the same underlying
> registers. A subsequent patch maps the VINTF aperture as a
> guest-direct RAM region; in this patch both remain QEMU-trapped.
>
> VCMDQ Page0 accesses operate in one of two mutually exclusive modes,
> depending on whether a hardware queue (IOMMU_HW_QUEUE_ALLOC) has
> been allocated for the VCMDQ:
>
>   Pre-alloc:  vintf_ptr is NULL. Both apertures use QEMU's register
do you mean vintf_page0 instead of vintf_ptr.

vintf_page0 is set on mmap, right? and not on hwqueue_alloc

Besides pre/post-alloc sounds a bit confusing to me since it can mean
queue_alloc or mmap.
If I understand correctly vintf_page0 can be set while hwqueue_alloc has
not been done yet and conversely, hence the double check below:

+    if (!cmdqv->vcmdq[index] || !cmdqv->vintf_page0) {


>               cache. Hardware is not yet engaged.
>
>   Post-alloc: vintf_ptr is valid. Both QEMU trapped apertures access
>               registers directly via the mmap'd vintf_page0 pointer,
>               bypassing the cache. Hardware is the single source of
>               truth.
>
> The pre-to-post-alloc transition is triggered by the IOMMUFD hardware
so here you mean alloc is hw queue alloc
> queue allocation. The tegra241_cmdqv_sync_vcmdq() copies any pre-alloc
> cached writes (CONS_INDX, PROD_INDX, CONFIG, GERRORN) into the mmap'd
> page so the guest's view survives the transition.
>
> CMDQV acceleration only becomes active once the guest enables VINTF
> and the corresponding HW QUEUE is allocated through IOMMUFD. Until
> then, all VCMDQ accesses are served from the emulated register cache
> with no real hardware command processing. This matches the CMDQV
> hardware specification: if the logical CMDQ index does not map to any
> allocated Virtual CMDQ, "the access is dropped with no Fault/Interrupt".

I still does not realy understand what would be the problem of directly
mapping the direct cmdqv page0 too - I understand that theoretically the
direct view is larger than the VINTF one though -. I still think a
proper explanation is missed in this patch of 22/32

Assuming the guest tries to set up some unmapped vcmdqs in the direct
cmdqv page and this eventually ends up writing into the VINTF view, what
would happen and in which terms does it violate the spec?
>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
> ---
>  hw/arm/tegra241-cmdqv.c | 72 +++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 70 insertions(+), 2 deletions(-)
>
> diff --git a/hw/arm/tegra241-cmdqv.c b/hw/arm/tegra241-cmdqv.c
> index f4968520f3..a7e89905df 100644
> --- a/hw/arm/tegra241-cmdqv.c
> +++ b/hw/arm/tegra241-cmdqv.c
> @@ -39,6 +39,39 @@ static void tegra241_cmdqv_free_all_vcmdq(Tegra241CMDQV *cmdqv)
>      }
>  }
>  
> +/* Pointer into the mmap'd VINTF page0 slot for @index, or NULL. */
@index: index of the vcmdq
@offset0, offset within vcmdq page0
> +static inline uint32_t *tegra241_cmdqv_vintf_ptr(Tegra241CMDQV *cmdqv,
> +                                                 int index, hwaddr offset0)
> +{
> +    if (!cmdqv->vcmdq[index] || !cmdqv->vintf_page0) {
> +        return NULL;
> +    }
> +    return (uint32_t *)(cmdqv->vintf_page0 +
> +                        (index * CMDQV_VCMDQ_STRIDE) +
> +                        (offset0 - CMDQV_VCMDQ_PAGE0_BASE));
> +}
> +
> +/* Flush cached pre-alloc writes into the mmap'd VINTF page0 slot. */
> +static void tegra241_cmdqv_sync_vcmdq(Tegra241CMDQV *cmdqv, int index)
> +{
> +    uint32_t *ptr;
> +
> +    ptr = tegra241_cmdqv_vintf_ptr(cmdqv, index, A_VCMDQ0_CONS_INDX);
> +    if (!ptr) {
> +        return;
> +    }
> +    *ptr = cmdqv->vcmdq_cons_indx[index];
> +
> +    ptr = tegra241_cmdqv_vintf_ptr(cmdqv, index, A_VCMDQ0_PROD_INDX);
> +    *ptr = cmdqv->vcmdq_prod_indx[index];
> +
> +    ptr = tegra241_cmdqv_vintf_ptr(cmdqv, index, A_VCMDQ0_CONFIG);
> +    *ptr = cmdqv->vcmdq_config[index];
> +
> +    ptr = tegra241_cmdqv_vintf_ptr(cmdqv, index, A_VCMDQ0_GERRORN);
> +    *ptr = cmdqv->vcmdq_gerrorn[index];
> +}
> +
>  /*
>   * Allocate a host HW VCMDQ from the current cached BASE / size for @index.
>   *
> @@ -94,6 +127,9 @@ static bool tegra241_cmdqv_setup_vcmdq(Tegra241CMDQV *cmdqv, int index,
>      hw_queue->viommu = viommu;
>      cmdqv->vcmdq[index] = hw_queue;
>  
> +    /* Pre-alloc cached writes survive the cache-to-hardware transition. */
> +    tegra241_cmdqv_sync_vcmdq(cmdqv, index);
> +
>      return true;
>  }
>  
> @@ -108,11 +144,14 @@ static void tegra241_cmdqv_setup_all_vcmdq(Tegra241CMDQV *cmdqv,
>  }
>  
>  /*
> - * Returns true if the per-VCMDQ CMDQ_EN_OK bit is set.
> + * Returns true if the per-VCMDQ CMDQ_EN_OK bit is set. Reads from the
> + * mmap'd VINTF page0 when the VCMDQ is allocated (HW is the source of
> + * truth post-alloc); otherwise reads from the register cache.
>   */
>  static bool tegra241_vcmdq_enabled(Tegra241CMDQV *cmdqv, int index)
>  {
> -    uint32_t status = cmdqv->vcmdq_status[index];
> +    uint32_t *ptr = tegra241_cmdqv_vintf_ptr(cmdqv, index, A_VCMDQ0_STATUS);
> +    uint32_t status = ptr ? *ptr : cmdqv->vcmdq_status[index];
>  
>      return status & R_VCMDQ0_STATUS_CMDQ_EN_OK_MASK;
>  }
> @@ -122,12 +161,21 @@ static bool tegra241_vcmdq_enabled(Tegra241CMDQV *cmdqv, int index)
>   *
>   * The caller normalizes the MMIO offset such that @offset0 always refers
>   * to a VCMDQ0_* register, while @index selects the VCMDQ instance.
> + *
> + * If the VCMDQ is allocated and VINTF page0 is mmap'd, read directly
> + * from the VINTF page0 backing. Otherwise, fall back to the cache.
>   */
>  static uint64_t tegra241_cmdqv_read_vcmdq_page0(Tegra241CMDQV *cmdqv,
>                                                  hwaddr offset0, int index)
>  {
> +    uint32_t *ptr = tegra241_cmdqv_vintf_ptr(cmdqv, index, offset0);
>      uint64_t val = 0;
>  
> +    if (ptr) {
> +        val = *ptr;
> +        goto out;
> +    }
> +
>      switch (offset0) {
>      case A_VCMDQ0_CONS_INDX:
>          val = cmdqv->vcmdq_cons_indx[index];
> @@ -152,6 +200,7 @@ static uint64_t tegra241_cmdqv_read_vcmdq_page0(Tegra241CMDQV *cmdqv,
>                        "%s unhandled read access at 0x%" PRIx64 "\n",
>                        __func__, offset0);
>      }
> +out:
>      trace_tegra241_cmdqv_read_vcmdq_page0(index, offset0, val);
>      return val;
>  }
> @@ -225,11 +274,29 @@ static uint64_t tegra241_cmdqv_config_vintf_read(Tegra241CMDQV *cmdqv,
>   *
>   * Page 0 registers are all 32-bit; this helper is only called for 4-byte
>   * writes.
> + *
> + * If the VCMDQ is allocated and VINTF page0 is mmap'd, write directly
> + * to the VINTF page0 backing. Otherwise, update the cache.
>   */
>  static void tegra241_cmdqv_write_vcmdq_page0(Tegra241CMDQV *cmdqv,
>                                               hwaddr offset0, int index,
>                                               uint32_t value)
>  {
> +    uint32_t *ptr = tegra241_cmdqv_vintf_ptr(cmdqv, index, offset0);
> +
> +    if (ptr) {
> +        switch (offset0) {
> +        case A_VCMDQ0_CONS_INDX:
> +        case A_VCMDQ0_PROD_INDX:
> +        case A_VCMDQ0_CONFIG:
> +        case A_VCMDQ0_GERRORN:
> +            *ptr = value;
> +            goto out;
> +        default:
> +            break;
> +        }
> +    }
> +
>      switch (offset0) {
>      case A_VCMDQ0_CONS_INDX:
>          cmdqv->vcmdq_cons_indx[index] = value;
> @@ -253,6 +320,7 @@ static void tegra241_cmdqv_write_vcmdq_page0(Tegra241CMDQV *cmdqv,
>                        "%s unhandled write access at 0x%" PRIx64 "\n",
>                        __func__, offset0);
>      }
> +out:
>      trace_tegra241_cmdqv_write_vcmdq_page0(index, offset0, value);
>  }
>  
Thanks

Eric


