Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C18CC35FFF
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Mar 2025 11:23:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvaSU-0002qX-Qf; Fri, 21 Mar 2025 07:22:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tvaST-0002qL-SF
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 07:22:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tvaSR-0002FM-Ea
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 07:22:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742556152;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=mryd3SutKwiVa3y9Ot2rceS4u9u7M5av+N1P9Tz/xvQ=;
 b=U4ryFWcLqOlslY+pOiZO9nttKENtw2elTFqSVbGLHYIKt2PCxPXa/3WTr43qMU0XVmMF0S
 pi+bcCC0iWDSru0PSHqXFpVac1F2VlZBY7BD5bRK2yM2jlsmoGfwv0mIyBVj593GA3Gaif
 LqFkhRH05P2PCwAOmUD1jKhPU2xsZic=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-125-sseh59_ZPP-u9ymCqBWkjw-1; Fri, 21 Mar 2025 07:22:31 -0400
X-MC-Unique: sseh59_ZPP-u9ymCqBWkjw-1
X-Mimecast-MFC-AGG-ID: sseh59_ZPP-u9ymCqBWkjw_1742556150
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43d0a037f97so10388535e9.2
 for <qemu-devel@nongnu.org>; Fri, 21 Mar 2025 04:22:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742556150; x=1743160950;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mryd3SutKwiVa3y9Ot2rceS4u9u7M5av+N1P9Tz/xvQ=;
 b=C1GVe4MKoefGaYV/dNWyTdC0QDjSh37FvKEpA98m6olAv6JD0+nzKyKoXUANsnYw4N
 XizwijoKkC3AKKke6+1nC541RD8IdvduL7++7CQ0NdmbJ/0AN/sWMgUHM4tXZh7PX+H6
 Ju905xJwiPWu0keuA9YMywHiDeo+loeit8k93SQ/+uJKY4Ms5++Y/v4cjs8D/8YvtQHu
 Jn2G0fqkTPFaPo17yYaCa6Kgzz+c7cPYAV56OZURt5AqkHY18THCFDwctVOc9wyH+/WD
 JT1qGFDML5e/i2DgqdWUNYgY7UrmUeVAd6Nahtc8ZtJmIPTCkNjvSL9aog2zludXJ95O
 8TPw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVlVUl+gpbOaWK08sXCg9G9/iB33LwiNCRYu8XsiCEw29IFS5t5c6Okgsi9ckhGy+3Bg57AR5hX6Jb1@nongnu.org
X-Gm-Message-State: AOJu0YyUz1KjmWcKnIFNJrWMR4VI+KT++CrEfrsIUcTpJ/O1aw8AXX6O
 Os9VhWgdDRKHTn445IDNTcyczf/VXzq7Miu/roHfAcmbf/QLuwZIS9VMDJYZCU+3SgwFiR9okqc
 iWzO2A052FaB5+9fe+t1omYUxTJMKZnH7K7+hBc4U8uWbVZbGZ1/w
X-Gm-Gg: ASbGncvX4xcmQaf4cdPKtLJmURynmFPYkE5JxAIF1P4gQQSMiGsQjsrDTKldq642tPP
 1y6a7PF7Aba0ZNUDgBBpWd08CTWhBxkz4w8ofQMKgP/c/TsoZjN/eygn+rrXQFBkRmNHhJ4K1VA
 VD4MIvGbDoPS7L6M+DgZgApQ+ylZT02yVCw99MhYRPbSclxP4oKlM/QHfy8kOUtoSlnu1NbATLL
 /3J2fCfq5wHxiB3H1bC/Ij2D+eaVanXx6mXoWvn50Vjq7kyunIuT1C3udHDPX/TyieoL0sTm/LS
 6J5Q+gs5vroqBOpLmlYDTkdPhVptJR/EWqM3/Fg2ep6Kq9/020EWSw==
X-Received: by 2002:a5d:6d88:0:b0:391:2e6a:30fe with SMTP id
 ffacd0b85a97d-3997f92d305mr3815240f8f.39.1742556149918; 
 Fri, 21 Mar 2025 04:22:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEbWZf0mY9XDpviccpE6kga9MLAn/GcSRjXXJx4gnMGYDfWVKuULgpuJHigT3dGfaCBNYr8pQ==
X-Received: by 2002:a5d:6d88:0:b0:391:2e6a:30fe with SMTP id
 ffacd0b85a97d-3997f92d305mr3815199f8f.39.1742556149415; 
 Fri, 21 Mar 2025 04:22:29 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3997f9b409fsm2138878f8f.50.2025.03.21.04.22.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Mar 2025 04:22:28 -0700 (PDT)
Message-ID: <3bf1ab06-4411-4d19-afad-3da2e62cbd9d@redhat.com>
Date: Fri, 21 Mar 2025 12:22:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-10.1 30/32] vfio: Rename VFIO dirty tracking services
To: Joao Martins <joao.m.martins@oracle.com>
Cc: Avihai Horon <avihaih@nvidia.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org,
 Alex Williamson <alex.williamson@redhat.com>
References: <20250318095415.670319-1-clg@redhat.com>
 <20250318095415.670319-31-clg@redhat.com>
 <a6c46117-dc83-4a42-9a5f-0fcffb69b4f2@oracle.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <a6c46117-dc83-4a42-9a5f-0fcffb69b4f2@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.332,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 3/19/25 13:21, Joao Martins wrote:
> On 18/03/2025 09:54, Cédric Le Goater wrote:
>> Rename these routines :
>>
>>    vfio_devices_all_device_dirty_tracking_started -> vfio_dirty_tracking_devices_is_started_all
>>    vfio_devices_all_dirty_tracking_started        -> vfio_dirty_tracking_devices_is_started
>>    vfio_devices_all_device_dirty_tracking         -> vfio_dirty_tracking_devices_is_supported
>>    vfio_devices_dma_logging_start                 -> vfio_dirty_tracking_devices_dma_logging_start
>>    vfio_devices_dma_logging_stop                  -> vfio_dirty_tracking_devices_dma_logging_stop
>>    vfio_devices_query_dirty_bitmap                -> vfio_dirty_tracking_devices_query_dirty_bitmap
>>    vfio_get_dirty_bitmap                          -> vfio_dirty_tracking_query_dirty_bitmap
>>
>> to better reflect the namespace they belong to.
>>
>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> 
> The change itself is fine.
> 
> But on the other hand, it looks relatively long names, no? 

I agree.

> I am bit at two minds
> (as I generally prefer shorter code), but I can't find any alternatives if you
> really wanna have one namespaces associated with the subsystem:file as a C
> namespace.
> 
> Every once and a while me and Avihai use the acronym DPT (Dirty Page Tracking)
> when talking about this stuff, but it seems a detour from the code style to
> abbreviate namespaces into acronyms.

I am ok to use a TLA for Dirty Page Tracking. Would DPT statisfy everyone ?

> 
> Having said that:
> 
> 	Reviewed-by: Joao Martins <joao.m.martins@oracle.com>
> 
> P.S. We could also remove 'devices' as the prefix for VF dirty tracking after
> namespace, and thus drop 'dma logging'. That should put 'start/stop' a little
> shorter.

Could you please send your proposal as a list, like the commit log does
and let's discuss.


Thanks,

C.




