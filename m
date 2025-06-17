Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEBD2C71136
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Jun 2025 17:17:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRZvh-0002uW-SI; Tue, 17 Jun 2025 13:17:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uRZvd-0002tl-5z
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 13:16:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uRZvZ-0006G8-Nv
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 13:16:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750180611;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=El0DT+dl7MPqBNcxlgAK6GXO0ciJKCV3tWhSUtWJa2k=;
 b=Vk6goWwR7EeBPjtZOFD67vJl3YoC0JNO8SQzM7Tl9C5vmVYiyfVuOoujq6X9+wvjV9QEPE
 jMj7cnEUnvCrQXOxj/ui6k7S9CIPOMKyeCE8HyzOSGM9ff3b5Y15KZyYugCcw+b63VNzdA
 Ng0kKwK5UaRFmzVP/q7XGgLA7qFz2lA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518-ciUCT00aMaWBcfNwNOTNcg-1; Tue, 17 Jun 2025 13:16:48 -0400
X-MC-Unique: ciUCT00aMaWBcfNwNOTNcg-1
X-Mimecast-MFC-AGG-ID: ciUCT00aMaWBcfNwNOTNcg_1750180607
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-45311704cdbso31031635e9.1
 for <qemu-devel@nongnu.org>; Tue, 17 Jun 2025 10:16:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750180607; x=1750785407;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=El0DT+dl7MPqBNcxlgAK6GXO0ciJKCV3tWhSUtWJa2k=;
 b=IbwFHLES9mkbr8gcgwJCdJzj/6SMzIWcgBV4B1llz0xEemeWYDaaTdUbuRXEZffYU6
 aTAYMvf3LxRLXfyUYWD+H3mCJ24DwDuHaAhclaTAZI52LQt06iLkwSPjiuJQ0W9ScvI7
 A/OoufSZw5qmGIsDzITENWA/EU8GnFZSHxTl4JlNyft8MyqUlLD3A/dqp0V1Uhwzf2sh
 fCbX46pb8MFQONZJIm1U+qfRXvfCHfUZI7DZs2avQlEivNcunC/ebaujG1zXSGnCRW+/
 81g7Jc5yITynHXhylPIM4oOhRXm+qYVDC+/JX7Ki+jC2zfYl2eKVnhOAIE5BpVQ68BDg
 +j/A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUbV/13R9WFfvj7vGyk8B29ddmzQMUMW+82xXwbAQW5hAu9JM7HoYOQrU1dxTa+950hD35nhYwWNw6J@nongnu.org
X-Gm-Message-State: AOJu0Yx3a3O7iVv41vKE+Wwbh6WL3Ip6/VTnMCHeq5A2me6nQrQ9XMPt
 XQpGAD2EkhqyVVG6shenFpKSLvFtSgzglK1cmsa4t2iuy2nb+sYVDOuD1CNZ3x1YDJVa3njmo0R
 xySjNoI5wjXJYTxtPojUz0sOpLUIdb7Cs8QjS0RBhF4p+jVghp+jdAPON
X-Gm-Gg: ASbGncvJg7wzqYygotc9e86IIRorOHLwIcoAo8ZxZ1XcPffgQHitiP0vGVX68MIbOsi
 7DxcKHnBQc1RGD8slpavoeNC9eEvXfmASxxajSbiu5RBXX4KSa6n9TSshznHt/ru3sqZuTQgGAF
 i8+QK9BXlXi9Zhv04r5FZ0f4KMlAMYNWSmowJAPjB3oFRzhChmHKcSDw7Zx1HhfZaOwamWkiwu7
 RgXWNqPHscbm/CN95jM13OJ40pkd/GRrKF/HTTM6scEbn5YoiJUQUlbz7saxRl3/nEKP4FWMAlR
 uW/OfwPAdscA573LUeGWZsLKUHl/PCuYX77uYRg7+Jtx4/QP4/q9wrznWipz/5G+je3GEg==
X-Received: by 2002:a5d:5847:0:b0:3a5:1c0d:85e8 with SMTP id
 ffacd0b85a97d-3a57237797bmr10610500f8f.22.1750180606688; 
 Tue, 17 Jun 2025 10:16:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFIVZksIC7akd6deFUDxtijQ+M4gobFXhi9pf1J5SLAEGZSpGsAqNmu2+yeFxJ/YwCI9aNIVg==
X-Received: by 2002:a5d:5847:0:b0:3a5:1c0d:85e8 with SMTP id
 ffacd0b85a97d-3a57237797bmr10610461f8f.22.1750180606228; 
 Tue, 17 Jun 2025 10:16:46 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4532e256b95sm186554325e9.30.2025.06.17.10.16.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Jun 2025 10:16:45 -0700 (PDT)
Message-ID: <2c414fe2-d74c-463e-b1ca-93953a5c5643@redhat.com>
Date: Tue, 17 Jun 2025 19:16:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 01/15] intel_iommu: Rename vtd_ce_get_rid2pasid_entry
 to vtd_ce_get_pasid_entry
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
 <20250606100416.346132-2-zhenzhong.duan@intel.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250606100416.346132-2-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
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
> In early days vtd_ce_get_rid2pasid_entry() was used to get pasid entry
> of rid2pasid, then it was extended to get any pasid entry. So a new name
> vtd_ce_get_pasid_entry is better to match what it actually does.
>
> No functional change intended.
>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> Reviewed-by: Clément Mathieu--Drif<clement.mathieu--drif@eviden.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Cheers

Eric
> ---
>  hw/i386/intel_iommu.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 69d72ad35c..f0b1f90eff 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -944,7 +944,7 @@ static int vtd_get_pe_from_pasid_table(IntelIOMMUState *s,
>      return 0;
>  }
>  
> -static int vtd_ce_get_rid2pasid_entry(IntelIOMMUState *s,
> +static int vtd_ce_get_pasid_entry(IntelIOMMUState *s,
>                                        VTDContextEntry *ce,
>                                        VTDPASIDEntry *pe,
>                                        uint32_t pasid)
> @@ -1025,7 +1025,7 @@ static uint32_t vtd_get_iova_level(IntelIOMMUState *s,
>      VTDPASIDEntry pe;
>  
>      if (s->root_scalable) {
> -        vtd_ce_get_rid2pasid_entry(s, ce, &pe, pasid);
> +        vtd_ce_get_pasid_entry(s, ce, &pe, pasid);
>          if (s->flts) {
>              return VTD_PE_GET_FL_LEVEL(&pe);
>          } else {
> @@ -1048,7 +1048,7 @@ static uint32_t vtd_get_iova_agaw(IntelIOMMUState *s,
>      VTDPASIDEntry pe;
>  
>      if (s->root_scalable) {
> -        vtd_ce_get_rid2pasid_entry(s, ce, &pe, pasid);
> +        vtd_ce_get_pasid_entry(s, ce, &pe, pasid);
>          return 30 + ((pe.val[0] >> 2) & VTD_SM_PASID_ENTRY_AW) * 9;
>      }
>  
> @@ -1116,7 +1116,7 @@ static dma_addr_t vtd_get_iova_pgtbl_base(IntelIOMMUState *s,
>      VTDPASIDEntry pe;
>  
>      if (s->root_scalable) {
> -        vtd_ce_get_rid2pasid_entry(s, ce, &pe, pasid);
> +        vtd_ce_get_pasid_entry(s, ce, &pe, pasid);
>          if (s->flts) {
>              return pe.val[2] & VTD_SM_PASID_ENTRY_FLPTPTR;
>          } else {
> @@ -1522,7 +1522,7 @@ static int vtd_ce_rid2pasid_check(IntelIOMMUState *s,
>       * has valid rid2pasid setting, which includes valid
>       * rid2pasid field and corresponding pasid entry setting
>       */
> -    return vtd_ce_get_rid2pasid_entry(s, ce, &pe, PCI_NO_PASID);
> +    return vtd_ce_get_pasid_entry(s, ce, &pe, PCI_NO_PASID);
>  }
>  
>  /* Map a device to its corresponding domain (context-entry) */
> @@ -1611,7 +1611,7 @@ static uint16_t vtd_get_domain_id(IntelIOMMUState *s,
>      VTDPASIDEntry pe;
>  
>      if (s->root_scalable) {
> -        vtd_ce_get_rid2pasid_entry(s, ce, &pe, pasid);
> +        vtd_ce_get_pasid_entry(s, ce, &pe, pasid);
>          return VTD_SM_PASID_ENTRY_DID(pe.val[1]);
>      }
>  
> @@ -1687,7 +1687,7 @@ static bool vtd_dev_pt_enabled(IntelIOMMUState *s, VTDContextEntry *ce,
>      int ret;
>  
>      if (s->root_scalable) {
> -        ret = vtd_ce_get_rid2pasid_entry(s, ce, &pe, pasid);
> +        ret = vtd_ce_get_pasid_entry(s, ce, &pe, pasid);
>          if (ret) {
>              /*
>               * This error is guest triggerable. We should assumt PT


