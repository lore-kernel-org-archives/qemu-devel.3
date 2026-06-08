Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FD2ACD8C9F
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 09:58:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWWk5-0003LT-IC; Mon, 08 Jun 2026 05:58:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wWWk4-0003LD-Of
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 05:58:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wWWk2-0003uy-To
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 05:58:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780912677;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iuBJaN/YtBUgwbFNdFlWpHosRwBoW5ttr/j+UgLeYyc=;
 b=B7/jWTRBcU4l/qaYNmrm1gr1uYAGvMqRTH9DVcTXVtRawglrEFTUtnDxwhaeSvh25riLun
 MARE9Uw2FuaGqdPmJ5WAAcg+xYRmG8SLC8LHdSF5H7FW62uG/1jWO9GjDNFMuWFzMZcVYz
 sBjiAhK99TI97dFfNnh6v/G+ros6DNI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-YXlgAsUDNbiheUs44J9CYg-1; Mon, 08 Jun 2026 05:57:56 -0400
X-MC-Unique: YXlgAsUDNbiheUs44J9CYg-1
X-Mimecast-MFC-AGG-ID: YXlgAsUDNbiheUs44J9CYg_1780912675
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-490c56e2576so23560945e9.3
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2026 02:57:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780912675; x=1781517475;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iuBJaN/YtBUgwbFNdFlWpHosRwBoW5ttr/j+UgLeYyc=;
 b=mN2FXIs4dOOqogSJ9i75kIC+hEyalz/HFJxa89PfeCibBwX2WvjOrMXaLRnG5i4K6J
 mUtsKm8VfkMsM3Xjsx1G67RQ0XAYdgFDp5ePrcArfQ5vA/Ys3f0+UDiflR/mGrxBVdTC
 pTT9qMk+CajGHTz0wjrSZPC4EdcJOxLgEtt1cb/Ab+O9ieiG/fID/81rY0c1+g8ntHv8
 MT835ufxbkdIinI68UZhAHQBZ5SvrpUPs9G3HqHz9RFRx51m5EHZFXKPwdUH/XB6o9Jh
 XbDh3z1pc0SFokGtO6N1uJE20vmDRVRzQEOTSv5ijO5wWaRH2IIqH9L5fZ+NAJ4YRr9W
 qceQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+oT971SA9jVraNIm/kH7PscfgzQ1S2JBbt5YFs92R0p7dMgHNqmXy5jf0AeGNzo1pNvYgivybZ6MVk@nongnu.org
X-Gm-Message-State: AOJu0YxMP4K6FzjJY2Aw4gfX6r4UaLC63w/IaFmo2Ox45LIfEgDRHFHC
 ig/KZ/44+pgBBG+5iDVMvcod2vTTLRSJ/k3xqiuoVs4R1mu43gCIpv8l4vgfD9hiX7RSI46sVRP
 MRhUu+AF93NVNg4kYfsPyktsJqEU/FHG6IENniUy7Yiu8cUTuysA53Gk1
X-Gm-Gg: Acq92OFGE6Xxrl/ykEHE+Mj9x14ykjPiZliRH19jbtrGFzrw2QrhOnWe0mLhrVoJdO7
 4NlgJHLIOOHtT2ht2yBGFBiV0ABamr1fg7o8XvksD1VIJ7RX9C/VpQOMFQEMRJ4/kxmn/Zcshq3
 WsMJXLhSNJL7DrcAx3eL0/K96zRdvnjmcmOwo/BthJcjJnotNQNiU2YuFkHEGX211cXwCodTai6
 +FKyY2VJ5bvfnfJ+oxB5rZbBLUZ6dtObWDEefc6CywhweOPgQBjiZPCeEnqyNzdBkMNDWhRBnQf
 Fg+tl7gwu064bFHu8fGmNz0GdTWIfRjqMK8SbgaeARc3tKh9DbfFdBAkf8o0mj9EAf4grUflqB4
 +gxwX9/QOyYWi3259mdn+ldSWVs/AtCtt8LfuqWIYOEv+dkf+7yySFwiphA8fycklcSyBeHX2YQ
 vYF9OS
X-Received: by 2002:a05:600c:34cb:b0:48e:6db3:ff3a with SMTP id
 5b1f17b1804b1-490c25b09a2mr248279535e9.16.1780912674931; 
 Mon, 08 Jun 2026 02:57:54 -0700 (PDT)
X-Received: by 2002:a05:600c:34cb:b0:48e:6db3:ff3a with SMTP id
 5b1f17b1804b1-490c25b09a2mr248279095e9.16.1780912674571; 
 Mon, 08 Jun 2026 02:57:54 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490bc4082c3sm366856915e9.13.2026.06.08.02.57.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Jun 2026 02:57:54 -0700 (PDT)
Message-ID: <c17dc055-405a-42ab-b028-b12ed8feefea@redhat.com>
Date: Mon, 8 Jun 2026 11:57:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH v5 0/9] hw/arm/smmuv3-accel: Resolve AUTO properties
To: Nathan Chen <nathanc@nvidia.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Zhao Liu <zhao1.liu@intel.com>, Matt Ochs <mochs@nvidia.com>,
 Nicolin Chen <nicolinc@nvidia.com>,
 Shameer Kolothum <skolothumtho@nvidia.com>
References: <20260605001712.1823737-1-nathanc@nvidia.com>
Content-Language: en-US
In-Reply-To: <20260605001712.1823737-1-nathanc@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hi Nathan,

On 6/5/26 2:17 AM, Nathan Chen wrote:
> Hi,
>
> This is a follow-up to the series [0] that introduces support for
> resolving 'auto' for arm-smmuv3 accelerated mode's ATS, RIL, SSIDSIZE,
> and OAS feature properties based on host IOMMU capabilities. This is
> dependent on the series [1] for changing these property types to accept
> 'auto' values.
>
> Accelerated SMMUv3 Address Translation Services support is derived from
> IDR0, Range Invalidation support is derived from IDR3, Substream ID
> size is derived from IDR1, and output address space is derived from
> IDR5.
>
> The default values are set to 'auto' for all properties. If accel=off
> and the values are set to 'auto' or are omitted and resolve to 'auto',
> the default property values defined in smmuv3_init_id_regs() for OAS
> and RIL will remain unchanged, while SSIDSIZE and ATS values will
> remain initialized at 0.
>
> A complete branch can be found here:
> https://github.com/NathanChenNVIDIA/qemu/tree/smmuv3-accel-auto-resolve-v5

I am afraid this requires a rebase on top of laterly landed

https://lore.kernel.org/all/20260601215410.517009-15-stefanb@linux.ibm.com/

Thanks

Eric

>
> Please take a look and let me know your feedback.
>
> Thanks,
> Nathan
>
> [0] https://lore.kernel.org/all/20260527221631.612026-1-nathanc@nvidia.com/
> [1] https://lore.kernel.org/qemu-arm/20260323182454.1416110-1-nathanc@nvidia.com/
>
> Changes from v4:
> - Added R-by tags, thanks all!
> - Re-word smmuv3_class_init() accel description to list nested
>   translation support as a pre-requisite
> - Fix typo in smmuv3_class_init() SubstreamID size description
>
> Changes from v3:
> - Added R-by tags, thanks all!
> - Include a fix patch for resolving ATS support in ATC invalidation
>   case
> - Update host requirements documented for accel=on, oas, and ssidsize
> - Fix style issue, update comments
> - Update function name for smmuv3_accel_machine_done
> - Remove unnecessary early return for smmuv3_accel_machine_done
> - Fix formatting in qemu-options.hx based on html render
>
> Changes from v2:
> - Added R-by tags, thanks Eric, Shameer, Cédric for the feedback!
> - Re-worded descriptions in qemu-options.hx and smmu_validate_property()
> - Emphasize accel=off auto behavior in a comment for smmuv3_properties[]
>
> Changes from v1:
> - Update qemu-options.hx to explicitly mention auto is supported
> - Update qemu-options.hx to mention auto as default
> - Simplify comments in smmuv3_accel_auto_finalise()
> - Update descriptions in smmuv3_class_init()
> - Consolidate all default value change patches into one patch
> - Implement and use smmuv3_pasid_supported() for setting PASID support
>   flag
> - Move smmuv3_machine_done() and qemu_add_machine_init_done_notifier()
>   to smmuv3-accel.c
> - Register machine done notifier only in case auto_mode is set
>
> Testing:
> Basic sanity testing was performed on an NVIDIA Grace platform with GPU
> device assignment and running CUDA test apps on the guest. Observed the
> feature properties being set based on host IOMMU capabilities.
> Verified that the VM boot will fail without a cold-plugged device, and
> that a hot-plugged device re-uses the resolved values from the initial
> cold-plug. Additional testing and feedback are welcome.
>
> Nathan Chen (9):
>   hw/arm/smmuv3: Update ATC invalidation check
>   hw/arm/smmuv3: Improve accel SMMUv3 usage documentation
>   hw/arm/smmuv3-accel: Add helper for resolving auto parameters
>   hw/arm/smmuv3-accel: Implement "auto" value for "ats"
>   hw/arm/smmuv3-accel: Implement "auto" value for "ril"
>   hw/arm/smmuv3-accel: Implement "auto" value for "ssidsize"
>   hw/arm/smmuv3-accel: Implement "auto" value for "oas"
>   hw/arm/smmuv3: Set default ats, ril, ssidsize, oas to auto
>   qemu-options.hx: Support "auto" for accel SMMUv3 properties
>
>  hw/arm/smmuv3-accel.c   | 77 ++++++++++++++++++++++++++++++++++++++-
>  hw/arm/smmuv3-accel.h   |  2 +
>  hw/arm/smmuv3.c         | 81 +++++++++++++++++++++++------------------
>  hw/core/machine.c       |  5 +++
>  include/hw/arm/smmuv3.h |  3 ++
>  qemu-options.hx         | 25 ++++++++++---
>  6 files changed, 150 insertions(+), 43 deletions(-)
>


