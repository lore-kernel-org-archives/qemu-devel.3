Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3BF6C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 18:44:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wdBXP-0005Bk-NO; Fri, 26 Jun 2026 14:44:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wdBXD-0004xc-KM
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 14:44:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wdBXA-0003Et-GT
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 14:44:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782499451;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ghj/xOg/E0yHFDgkCHpp4r2601tf0dBSnaAs4XEnKzE=;
 b=SxhC8ziC3THz1iQFTy3E1CayYJv5CweHT2IuPxOapeYbwX0Fqhbder/u8i/eFWlvRsM6gL
 90ErBZD/xefAMsqRXptK9Ak4bczzAxLq9nk6k+XYs57wRh6okn1DCtjam5lgOb2w0Wk7SZ
 EzxYAQ6eELJ9khZ5xhCJsW1zGVrf1l0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-534-dSjL_oLPM5OKrcB-kzR1HA-1; Fri, 26 Jun 2026 14:44:10 -0400
X-MC-Unique: dSjL_oLPM5OKrcB-kzR1HA-1
X-Mimecast-MFC-AGG-ID: dSjL_oLPM5OKrcB-kzR1HA_1782499449
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-46f48f2d9cbso571014f8f.2
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 11:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782499449; x=1783104249; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=ghj/xOg/E0yHFDgkCHpp4r2601tf0dBSnaAs4XEnKzE=;
 b=MF6NOgrKQvefcTwwpDXCI0RPzA9alEW6w5gMym7PFnmVz5qUnPuVeUB0loXE5/TIqX
 Cr6yHRVkrDVbl4nHjH3CJuXCp6Xpea7JfqDDPekZ2Fb/Eqj+JjwhpF1oIub+mMURXYNX
 H52uzLE5LmCTUb5eDj4VsfXLkZ8t88K1cTtq96Pcpj0sU/pOlu33x0JQZZKzUt/BCv8S
 ltHZAMApR9q567kGPd4nN7Iuou3/hFkZP7c3b/sDtKd252QLAUmN29Nmh2lj4BmtlgG/
 JgJl+AN5y9MyodqHxmlI5pve06xhdXYBDAp1V0W59IPSD2kJsvjFc2iKIcYQXbAS8w3k
 VwyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782499449; x=1783104249;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ghj/xOg/E0yHFDgkCHpp4r2601tf0dBSnaAs4XEnKzE=;
 b=G/aFZ6UawLgasyKE+yc+Vuzt3vV73OvQtiV6xSgVW1Hnyv5yk7kkNCZw8I71zXcMyS
 KlaleGr3j1Z0/ysc0N/HV0lDyoEel+6KdKsja0bLZrCVGL8qCFsVZKJ4I3i/rnMxf/M7
 rG1UmHHtX89PhF46uhnnZ9J7/rk58FvkrYJChuUqZ4M/C0g+zlGX19Ts+5fsMCWaWUeI
 dn/TJSPnLU0EWKmEhEngVDk7RiEH64crpGXQKSipdbdR8tWOfoxaPH58FMc6ILO0i08c
 sQHKdkf93Gb0e6STf5zjl/oOsMx7Y3QL86lSA8K1RjyEcDYfQpcZZchzN1JC+EPnr8jA
 42VA==
X-Gm-Message-State: AOJu0YzQzSCgWyfCQHtun8isoNEdBV5VgVdjxsoA3fbg8oMgsoqLFz78
 blIYXkD6XaNBVQPQyQfJwXMyJjYb1Sf0X1OrBdjv8v66m2+7qy30vvJdvzUWNb+/veqfA6C4qwh
 Rds1mxa9NuoG9Meh0a7DzDNiA/ioLX6E2riN2Es+TOD91gFDgyuBr1zAQAbUSOsdkSD7Fe0xwpP
 uciges2JGCwJW5oKUm1O4fWEu5uSH8EEDgmA==
X-Gm-Gg: AfdE7ckfoB/i8cM81E8utOcWLqYLuBAmMe3E/I4DJlRsKl9fZ0wZKxmCkMxNH90wNig
 OILwN4+QjvrwTyZtGgykvVCGgb5Rwfr0xLXa0RhYN6b0xYKDolNRVOnX1WZn/fCH1lK1nLZrlAJ
 zyuxBhNQt8ACxeviGI5SjKL3QpVLXRjkbFs3WeoVSbez0NZ/wR49U19veHELFOtn24eHhO31i+L
 AfKYk0RQnMxvR5encQISDSBbDd0m0VYuDaoUvt3REiSaQG2ygSiWcdx7tIkuSr79OmSD6SLnnP8
 F7oziXzQRpbj720EkOwoDDUP8Mx1grg1NkCQz04eNiL/ZK3TE/bdHQoR9OXdh4sOJPZ7iFhLq/a
 R6ap8n/qjZXpJAofnGImvkbr+CYE7b8FigUHPhiW2yLHxM8yEqRxB
X-Received: by 2002:a05:6000:460d:b0:462:e086:35f with SMTP id
 ffacd0b85a97d-46dc2075df6mr12576844f8f.21.1782499448856; 
 Fri, 26 Jun 2026 11:44:08 -0700 (PDT)
X-Received: by 2002:a05:6000:460d:b0:462:e086:35f with SMTP id
 ffacd0b85a97d-46dc2075df6mr12576805f8f.21.1782499448248; 
 Fri, 26 Jun 2026 11:44:08 -0700 (PDT)
Received: from ?IPV6:2a01:cb19:8426:ae00:a924:b4e0:1ee:f5c5?
 ([2a01:cb19:8426:ae00:a924:b4e0:1ee:f5c5])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46c1ee0189esm28102155f8f.9.2026.06.26.11.44.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Jun 2026 11:44:07 -0700 (PDT)
Message-ID: <bdd7da0a-27e3-432d-935e-e3f435f19b4c@redhat.com>
Date: Fri, 26 Jun 2026 20:44:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vfio/listener: Fix translated_addr for
 non-identity-mapped RAM sections
To: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>,
 Giovannio Cabiddu <giovanni.cabiddu@intel.com>,
 Alex Williamson <alex@shazbot.org>, Zhenzhong Duan <zhenzhong.duan@intel.com>
References: <20260625134352.3122572-1-clg@redhat.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260625134352.3122572-1-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 6/25/26 15:43, Cédric Le Goater wrote:
> In vfio_listener_region_del(), when dirty tracking is active and a
> writable RAM section is deleted, a synthetic IOMMUTLBEntry is built to
> flush dirty pages. Setting translated_addr to the IOVA (GPA) is only
> correct for identity-mapped regions where GPA == ram_addr_t.
> 
> For RAM sections with GPA far above main RAM (e.g., nested VT-d interrupt
> remapping table at 58 TB), translated_addr is too large, causing a crash
> in physical_memory_set_dirty_lebitmap() when indexing beyond the allocated
> dirty memory blocks array :
> 
>    bitmap_set_atomic(map=NULL, start=1, nr=1)
>    physical_memory_set_dirty_range(start=0x380004040000, length=4096)
>    physical_memory_set_dirty_lebitmap(start=0x380004040000, pages=3)
>    vfio_container_query_dirty_bitmap(translated_addr=0x380004040000)
>    vfio_legacy_dma_unmap_one(iova=0x380004040000, size=12288)
>    vfio_listener_region_del()
> 
> Fix this by setting translated_addr to the ram_addr_t of the section, which
> is consistent with other vfio dirty tracking code:
> 
>    translated_addr = memory_region_get_ram_addr(section->mr) +
>                      section->offset_within_region;
> 
> Cc: Zhenzhong Duan <zhenzhong.duan@intel.com>
> Fixes: 6e360c06176c ("vfio/listener: Add missing dirty tracking in region_del")
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>   hw/vfio/listener.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/vfio/listener.c b/hw/vfio/listener.c
> index 14cca678aea788c23ea5c6ed4a3aceec5fe21484..785a6eef8d812123fcecf82e3716f5577d7c61e1 100644
> --- a/hw/vfio/listener.c
> +++ b/hw/vfio/listener.c
> @@ -731,7 +731,7 @@ static void vfio_listener_region_del(MemoryListener *listener,
>           }
>   
>           /*
> -         * Fake an IOTLB entry for writable identity mapping which is needed
> +         * Fake an IOTLB entry for writable RAM sections which is needed
>            * by dirty tracking when switch out of PT domain. In fact, in
>            * unmap_bitmap, only translated_addr field is used to set dirty
>            * bitmap.
> @@ -746,7 +746,8 @@ static void vfio_listener_region_del(MemoryListener *listener,
>           if (global_dirty_tracking && memory_region_is_ram(section->mr) &&
>               !section->readonly) {
>               entry.iova = iova;
> -            entry.translated_addr = iova;
> +            entry.translated_addr = memory_region_get_ram_addr(section->mr) +
> +                                    section->offset_within_region;
>               iotlb = &entry;
>           }
>   


Applied to

     https://github.com/legoater/qemu vfio-next

Thanks,

C.


