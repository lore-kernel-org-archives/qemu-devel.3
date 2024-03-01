Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04769C5478C
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 05:45:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfvh6-0004yJ-RX; Fri, 01 Mar 2024 00:44:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rfvgw-0004xY-Aw
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 00:44:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rfvgt-0006Cs-Un
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 00:44:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709271854;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=22ydgyJHkQofMDuduHI8B3Kxexnqdv74gxI6xgrCQv8=;
 b=dDjlPxbR4qzN86NvDHWfwL+LC4Oi0BW4z/RXMIagbfQ5R8aGecfQhn/GV7B/11fC11ypK8
 RO896xQ5iSk79TllcFG8aMik4TjCbmE5XWBPrGP4DEx8ivzSHjdQYiR8seJUBSJn13OdJ8
 oPTgRsDVsLp1YNBCtCPuRWKmup0+BFY=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-298-0aVPaOCXOqKkh4Qiz7G1aQ-1; Fri, 01 Mar 2024 00:44:13 -0500
X-MC-Unique: 0aVPaOCXOqKkh4Qiz7G1aQ-1
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-563de65ac5dso548213a12.1
 for <qemu-devel@nongnu.org>; Thu, 29 Feb 2024 21:44:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709271852; x=1709876652;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=22ydgyJHkQofMDuduHI8B3Kxexnqdv74gxI6xgrCQv8=;
 b=pWJfdYAK8+U/cdWQweZrU8+xhdvKgXYf6ELv1YunaHK4QXKT5HdTu7cCwsKjoNjQIx
 ArG5bdY0oEELGrgSgCzKACe2NMVn6JB2w4Tz/g52GnNAsJ7h3tswlu/jJ49W+ikGaLUt
 VEovkzp3qs4ULIsefnl70ATb6UQmwLUBModLBCIP2WiSTcRKUi3NZcMOZct2HcpKD+eP
 zDdxkjmUgmvTGtuKC6xdkshPfIzbYpEM/aK//oFTytCD3DI2vuCTYV4Kg71Mllkvo5bi
 vLLbiD5w/Dv5WjHBdyYYhAjFezrho5FqaefA+F7fqY2bffa6eXs5Z62oNT98EY6oPkmd
 KfCA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWAbT/TqSynOUr2ouKaP1/07S/IV7bGr0s3v1xaD1r/hV5PzdBUEoEFBfMvgjBW6iz2CXC6/7xrw7JKaelL+zw5y+66SOw=
X-Gm-Message-State: AOJu0Yz4WXLwkgWrRJ8Gegd5THvGgX60iL/J7MOOSlW9Hfvb1kdmQ36V
 oXOh+iOyoy3r76Wk6ypQP2++Gec/CyKRu9VsbjzvU0aQxbvW5j+pueTYSkVfEixcVM2DQstrhlm
 ld7h0oy1pl5rgEpQ3z5jBfdjUY8OCV8fwDTRPZi8N9vcMRnBYpR7t
X-Received: by 2002:a17:90a:9e3:b0:29b:f79:2ec3 with SMTP id
 90-20020a17090a09e300b0029b0f792ec3mr717007pjo.3.1709271852298; 
 Thu, 29 Feb 2024 21:44:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGSaPctf0q9L419OBcxjEAHyUqyVefUwgyqneMPyVAy2Z9dxM0Mwy7nPC+fLjlaPzijy+2jVQ==
X-Received: by 2002:a17:90a:9e3:b0:29b:f79:2ec3 with SMTP id
 90-20020a17090a09e300b0029b0f792ec3mr716999pjo.3.1709271851973; 
 Thu, 29 Feb 2024 21:44:11 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 1-20020a17090a0f0100b0029981c0d5c5sm2668662pjy.19.2024.02.29.21.44.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Feb 2024 21:44:11 -0800 (PST)
Date: Fri, 1 Mar 2024 13:44:01 +0800
From: Peter Xu <peterx@redhat.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, linuxarm@huawei.com
Subject: Re: [PATCH 3/3] physmem: Fix wrong MR in large
 address_space_read/write_cached_slow()
Message-ID: <ZeFrIY6exon32X0s@x1n>
References: <20240215142817.1904-1-Jonathan.Cameron@huawei.com>
 <20240215142817.1904-4-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240215142817.1904-4-Jonathan.Cameron@huawei.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.096,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Feb 15, 2024 at 02:28:17PM +0000, Jonathan Cameron wrote:

Can we rename the subject?

  physmem: Fix wrong MR in large address_space_read/write_cached_slow()

IMHO "wrong MR" is misleading, as the MR was wrong only because the address
passed over is wrong at the first place.  Perhaps s/MR/addr/?

> If the access is bigger than the MemoryRegion supports,
> flatview_read/write_continue() will attempt to update the Memory Region.
> but the address passed to flatview_translate() is relative to the cache, not
> to the FlatView.
> 
> On arm/virt with interleaved CXL memory emulation and virtio-blk-pci this
> lead to the first part of descriptor being read from the CXL memory and the
> second part from PA 0x8 which happens to be a blank region
> of a flash chip and all ffs on this particular configuration.
> Note this test requires the out of tree ARM support for CXL, but
> the problem is more general.
> 
> Avoid this by adding new address_space_read_continue_cached()
> and address_space_write_continue_cached() which share all the logic
> with the flatview versions except for the MemoryRegion lookup.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  system/physmem.c | 78 ++++++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 72 insertions(+), 6 deletions(-)
> 

[...]

> +/* Called within RCU critical section.  */
> +static MemTxResult address_space_read_continue_cached(MemoryRegionCache *cache,
> +                                                      hwaddr addr,
> +                                                      MemTxAttrs attrs,
> +                                                      void *ptr, hwaddr len,
> +                                                      hwaddr addr1, hwaddr l,
> +                                                      MemoryRegion *mr)

It looks like "addr" (of flatview AS) is not needed for a cached RW (see
below), because we should have a stable (cached) MR to operate anyway?

How about we also use "mr_addr" as the single addr of the MR, then drop
addr1?

> +{
> +    MemTxResult result = MEMTX_OK;
> +    uint8_t *buf = ptr;
> +
> +    fuzz_dma_read_cb(addr, len, mr);
> +    for (;;) {
> +

Remove empty line?

> +        result |= flatview_read_continue_step(addr, attrs, buf, len, addr1,
> +                                              &l, mr);
> +        len -= l;
> +        buf += l;
> +        addr += l;
> +
> +        if (!len) {
> +            break;
> +        }
> +        l = len;
> +
> +        mr = address_space_translate_cached(cache, addr, &addr1, &l, false,
> +                                            attrs);

Here IIUC the mr will always be the same as before?  If so, maybe "mr_addr
+= l" should be enough?

(similar comment applies to the writer side too)

> +    }
> +
> +    return result;
> +}
> +
>  /* Called from RCU critical section. address_space_read_cached uses this
>   * out of line function when the target is an MMIO or IOMMU region.
>   */
> @@ -3390,9 +3456,9 @@ address_space_read_cached_slow(MemoryRegionCache *cache, hwaddr addr,
>      l = len;
>      mr = address_space_translate_cached(cache, addr, &addr1, &l, false,
>                                          MEMTXATTRS_UNSPECIFIED);
> -    return flatview_read_continue(cache->fv,
> -                                  addr, MEMTXATTRS_UNSPECIFIED, buf, len,
> -                                  addr1, l, mr);
> +    return address_space_read_continue_cached(cache, addr,
> +                                              MEMTXATTRS_UNSPECIFIED, buf, len,
> +                                              addr1, l, mr);
>  }
>  
>  /* Called from RCU critical section. address_space_write_cached uses this
> @@ -3408,9 +3474,9 @@ address_space_write_cached_slow(MemoryRegionCache *cache, hwaddr addr,
>      l = len;
>      mr = address_space_translate_cached(cache, addr, &addr1, &l, true,
>                                          MEMTXATTRS_UNSPECIFIED);
> -    return flatview_write_continue(cache->fv,
> -                                   addr, MEMTXATTRS_UNSPECIFIED, buf, len,
> -                                   addr1, l, mr);
> +    return address_space_write_continue_cached(cache, addr,
> +                                               MEMTXATTRS_UNSPECIFIED,
> +                                               buf, len, addr1, l, mr);
>  }
>  
>  #define ARG1_DECL                MemoryRegionCache *cache
> -- 
> 2.39.2
> 

-- 
Peter Xu


