Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ED7DC27C79
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 11:40:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJAhx-0007GL-FH; Mon, 17 Jun 2024 07:39:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sJAhu-0007GA-Tc
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 07:39:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sJAhr-0005aV-0V
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 07:39:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718624365;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6j8h4DMAExfmM24pdJZ3+dbVUQLXnADczzooquStYXQ=;
 b=eCuI5FxksTgTVJMAy+nmCaeicP3EzU1k3GNg8VQ+bBJG3IgGc/dzYcFSlfLHb86C9SpW8k
 tkqQ7+GbSCURqHxj4W654IqANnRDy08+emN+a/0V4XmQIG0pLiN1fbaN8WW3gxF5X4Kqgk
 TZ+/Iu4qnkYIa1TsokxvjC1JsI1KR5c=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-280-XRkbQLKsPkqOymE45vVccA-1; Mon, 17 Jun 2024 07:39:24 -0400
X-MC-Unique: XRkbQLKsPkqOymE45vVccA-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4227e29cd39so24048335e9.1
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2024 04:39:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718624363; x=1719229163;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6j8h4DMAExfmM24pdJZ3+dbVUQLXnADczzooquStYXQ=;
 b=cpEopMxwuuV9xZhoQ5pIvWKilyic5mFZRYdhl2sdP11PMCk54THCj4FmZ18/2I9CvV
 BsFyCsrKXKgSaoTnMEN1F12Szn8fwcq4Ht6QwJxiPDblD/DPyxxE021Y5BQnV3dt3o4g
 CFm5wek7mSV18quzc/rXKr7DSTHDv3wBZ7Zusi4nnQFU1jbubsky79Mg1OqqXojmgC0o
 lz08E/cRXhL4SbyATDgpUNzd72lUL3/7fkfreSQMKMVIquaY4yPoXvsGVbM40ThG43QL
 Xsb+628BF+Q1V6757xKWELcjVnSR/Cwe/dFQWDI+wlOAooEr3WULYXyj5/ds60IhlkOh
 rqVA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWqh/MrdISNqeQwuFJ6tnBb/VwNWpZipF7WJLZehuVXW7juSpMzrWK7zizy3XTi0eR4AbjykxGTGOtecaBlZGDUOxYXDfQ=
X-Gm-Message-State: AOJu0YwWGaKDqEfWygy2YXZjzYYVBznRl2ii59WSfier2gHExTfPX2PU
 LCVEWwNzYi9J1784DlvJiztCC6KQCHFdNl3xvl/X/uB5TI9ES2x0x//tUL4U4bS+9e3ZsHj6s5b
 NS2haMIb9O4bpcje3w2zu3oHLg8eqwIvWM/m7Km+lFvwtqLarN+D1
X-Received: by 2002:a05:600c:1c13:b0:421:f346:6b06 with SMTP id
 5b1f17b1804b1-42304848abfmr93783905e9.28.1718624363010; 
 Mon, 17 Jun 2024 04:39:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH70wIBH5GOnsZAiIzAWKOxjBSUl5IOWk+y22gARrlnaAsBwfANKWUCiSquUjZmfzQQPVk27A==
X-Received: by 2002:a05:600c:1c13:b0:421:f346:6b06 with SMTP id
 5b1f17b1804b1-42304848abfmr93783745e9.28.1718624362575; 
 Mon, 17 Jun 2024 04:39:22 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-422f5f33be5sm159162745e9.2.2024.06.17.04.39.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Jun 2024 04:39:21 -0700 (PDT)
Message-ID: <81fa58ce-a4e6-41f1-8d9a-75ad674fe472@redhat.com>
Date: Mon, 17 Jun 2024 13:39:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/17] vfio/common: Move dirty tracking ranges update
 to helper
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Joao Martins <joao.m.martins@oracle.com>
References: <20240617063409.34393-1-clg@redhat.com>
 <20240617063409.34393-4-clg@redhat.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20240617063409.34393-4-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.148,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi Cédric,
On 6/17/24 08:33, Cédric Le Goater wrote:
> From: Joao Martins <joao.m.martins@oracle.com>
>
> Separate the changes that updates the ranges from the listener, to
s/updates/update
> make it reusable in preparation to expand its use to vIOMMU support.
>
> [ clg: - Rebased on upstream
>        - Introduced vfio_dirty_tracking_update_range() ]
>
> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>  hw/vfio/common.c | 38 ++++++++++++++++++++++----------------
>  1 file changed, 22 insertions(+), 16 deletions(-)
>
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index d48cd9b9361a92d184e423ffc60aabaff40fb487..fe215918bdf66ddbe3c5db803e10ce1aa9756b90 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -839,20 +839,11 @@ static bool vfio_section_is_vfio_pci(MemoryRegionSection *section,
>      return false;
>  }
>  
> -static void vfio_dirty_tracking_update(MemoryListener *listener,
> -                                       MemoryRegionSection *section)
> +static void vfio_dirty_tracking_update_range(VFIODirtyRanges *range,
> +                                             hwaddr iova, hwaddr end,
> +                                             bool update_pci)
>  {
> -    VFIODirtyRangesListener *dirty = container_of(listener,
> -                                                  VFIODirtyRangesListener,
> -                                                  listener);
> -    VFIODirtyRanges *range = &dirty->ranges;
> -    hwaddr iova, end, *min, *max;
> -
> -    if (!vfio_listener_valid_section(section, "tracking_update") ||
> -        !vfio_get_section_iova_range(dirty->bcontainer, section,
> -                                     &iova, &end, NULL)) {
> -        return;
> -    }
> +    hwaddr *min, *max;
>  
>      /*
>       * The address space passed to the dirty tracker is reduced to three ranges:
> @@ -873,8 +864,7 @@ static void vfio_dirty_tracking_update(MemoryListener *listener,
>       * The alternative would be an IOVATree but that has a much bigger runtime
>       * overhead and unnecessary complexity.
>       */
> -    if (vfio_section_is_vfio_pci(section, dirty->bcontainer) &&
> -        iova >= UINT32_MAX) {
> +    if (update_pci && iova >= UINT32_MAX) {
>          min = &range->minpci64;
>          max = &range->maxpci64;
>      } else {
> @@ -889,7 +879,23 @@ static void vfio_dirty_tracking_update(MemoryListener *listener,
>      }
>  
>      trace_vfio_device_dirty_tracking_update(iova, end, *min, *max);
don't you want to update the name of the trace point?
> -    return;
> +}
> +
> +static void vfio_dirty_tracking_update(MemoryListener *listener,
> +                                       MemoryRegionSection *section)
> +{
> +    VFIODirtyRangesListener *dirty =
> +        container_of(listener, VFIODirtyRangesListener, listener);
> +    hwaddr iova, end;
> +
> +    if (!vfio_listener_valid_section(section, "tracking_update") ||
> +        !vfio_get_section_iova_range(dirty->bcontainer, section,
> +                                     &iova, &end, NULL)) {
> +        return;
> +    }
> +
> +    vfio_dirty_tracking_update_range(&dirty->ranges, iova, end,
> +                      vfio_section_is_vfio_pci(section, dirty->bcontainer));
>  }
>  
>  static const MemoryListener vfio_dirty_tracking_listener = {
Besides
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric


