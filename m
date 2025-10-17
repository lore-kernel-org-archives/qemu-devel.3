Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64BE7CCD195
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 13:57:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9kxN-0006s1-4v; Fri, 17 Oct 2025 09:57:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v9kxK-0006qv-R8
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 09:57:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v9kxC-0003dP-Jf
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 09:57:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760709428;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=I1XKrx3UUVIcLHqpoT6WCUCQAu8YBqnwbsM7NSR+cyk=;
 b=RPnRcrEvp7XKUywX6u3dMxlQuDKJwU/MXxUaXU1+4OP90vMZfZ0HtlX38YP1aLi650iKye
 /RZQbKYADEPv/k493jWb+VNK56QJ7DU0p/ueO8AJ33N3xKT2IFV3pmO3UpsNM9xRSvZoDx
 8bnALnCAY3c4WoVJ5m2jED9HqRCkNys=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-226-W87Jw2A6Pce0rjpUvBqo2w-1; Fri, 17 Oct 2025 09:57:07 -0400
X-MC-Unique: W87Jw2A6Pce0rjpUvBqo2w-1
X-Mimecast-MFC-AGG-ID: W87Jw2A6Pce0rjpUvBqo2w_1760709427
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-8906059f6b2so776290385a.2
 for <qemu-devel@nongnu.org>; Fri, 17 Oct 2025 06:57:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760709427; x=1761314227;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I1XKrx3UUVIcLHqpoT6WCUCQAu8YBqnwbsM7NSR+cyk=;
 b=IIHfvQb+vKNk8QqEwINWLFnlmsU95NrM+/9Naem/yPx62H97/m0AAdeR/tIYE8QrqD
 ubsWZhgiEkGK5vqdllSYMe9ORQRSOovktNpLQjley3oSXXH+RHd7Ngrsv5eeZrPC5jnk
 OENGm3V53YSZbEmQB8gnEMwjr+FWrfsqp6EbgXNK31N75I2+8GrATWvVT9tipBOpAK1u
 IuWBG5tg1+j/vq5FpYLtO1zHuZnMpeA971oEsQI0oRHlBwh9Vp8CDBYLl+KAlK2og9Pq
 fi7tfI219qKM8GuCwW4Ni5a0/ZXYaljuXeJjvzuUanMRgu2/73IteiWhi92OiOuqEy45
 c2Xw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWjiA+aD5FOiM71knpUr9gwrB1OAZ+hOR2vNiAPuAjWLKtBUVXrJnhAJrorZsyfGWcTIwljUM4v53Nf@nongnu.org
X-Gm-Message-State: AOJu0YxAH2ffChBaFjhlZLwHVEXLbYmFK9+Y0QEx6ztGewFIiP5aCJA0
 TvCZdMoPDkDGH5oVb3hSVQYLycyFpdZmiVDy1LrRLjRxfCNhyJiXH/8I6S0i+40Xl+Ek1VNcaiI
 RrakSOeoHaqb/FPb0Y96ZjGBfr+UV7SahZkZvVCZtcpiu+YMpMj0smL/z
X-Gm-Gg: ASbGncsx05JNjlUkBFD+GNHDBDCulYWACsSSmwMAOQ2jdlUeq4IC3IEnM4HZ9rhCjyZ
 GPpG1RFsakmAWIEs/ZHfO9Xv3glm+LNFVswGuF+HUVRa6frgX7t4c/li0DqYylm5bJCpqfRgj+T
 tEjlHISR0KETi8i+6svbBgnawwrTSx5sKpRPjwbEwIkxfIlPqcfZZ0cLF9ZMfEeaT1z8qbNZzWB
 BUcDYMsRJI90Xrpj/W0EXsAnPGw2/laadJLcUt62obxSbGDT85Lu5l6cFQnABRMpPpx+MeYGNwG
 QNwqDqvjGRA4VyTZHp52U5LS6oKa1whI+wJ/1pB9eMLs9lZU0gK3ApZAoaOu8IHtbls=
X-Received: by 2002:a05:622a:1998:b0:4e4:2006:b00a with SMTP id
 d75a77b69052e-4e89d262f67mr49937871cf.23.1760709426434; 
 Fri, 17 Oct 2025 06:57:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGDbTTfW72V3EHTT6dXPzMm+0fYqM0p7SYEX8ZTpaUfjMVWEVml7MEz2Kq9xsTUhMWE3UQVgg==
X-Received: by 2002:a05:622a:1998:b0:4e4:2006:b00a with SMTP id
 d75a77b69052e-4e89d262f67mr49937551cf.23.1760709426015; 
 Fri, 17 Oct 2025 06:57:06 -0700 (PDT)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-87c1a49b690sm31669226d6.13.2025.10.17.06.57.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Oct 2025 06:57:04 -0700 (PDT)
Date: Fri, 17 Oct 2025 09:57:01 -0400
From: Peter Xu <peterx@redhat.com>
To: Chenyi Qiang <chenyi.qiang@intel.com>
Cc: David Hildenbrand <david@redhat.com>, Alexey Kardashevskiy <aik@amd.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Gao Chao <chao.gao@intel.com>,
 Li Xiaoyao <xiaoyao.li@intel.com>
Subject: Re: [PATCH] ram-block-attributes: Avoid the overkill of shared
 memory with hugetlbfs backend
Message-ID: <aPJLLQmL9W1nMIi7@x1.local>
References: <20251017081445.175342-1-chenyi.qiang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251017081445.175342-1-chenyi.qiang@intel.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Oct 17, 2025 at 04:14:23PM +0800, Chenyi Qiang wrote:
> Currently, private memory and shared memory have different backend in
> CoCo VMs. It is possible for users to specify the shared memory with
> hugetlbfs backend while private memory with guest_memfd backend only
> supports 4K page size. In this case, ram_block->page_size is different
> from the host page size which will trigger the assertion when getting
> block size. Relax the restriction to allow shared memory to use
> hugetlbfs backend.

Is it proper I add this into the commit message too, when queue it?

  This patch fixes a regression of using hugetlbfs memory backends with
  CoCo VMs, with or without VFIO devices' presence.

Thanks,

> 
> Fixes: 5d6483edaa92 ("ram-block-attributes: Introduce RamBlockAttributes to manage RAMBlock with guest_memfd")
> Signed-off-by: Chenyi Qiang <chenyi.qiang@intel.com>
> ---
>  system/ram-block-attributes.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/system/ram-block-attributes.c b/system/ram-block-attributes.c
> index 68e8a027032..0f39ccf9090 100644
> --- a/system/ram-block-attributes.c
> +++ b/system/ram-block-attributes.c
> @@ -28,10 +28,11 @@ ram_block_attributes_get_block_size(const RamBlockAttributes *attr)
>       * Because page conversion could be manipulated in the size of at least 4K
>       * or 4K aligned, Use the host page size as the granularity to track the
>       * memory attribute.
> +     * When hugetlbfs is used as backend of shared memory, ram_block->page_size
> +     * is different from host page size. So it is not appropriate to use
> +     * ram_block->page_size here.
>       */
> -    g_assert(attr && attr->ram_block);
> -    g_assert(attr->ram_block->page_size == qemu_real_host_page_size());
> -    return attr->ram_block->page_size;
> +    return qemu_real_host_page_size();
>  }
>  
>  
> -- 
> 2.43.5
> 

-- 
Peter Xu


