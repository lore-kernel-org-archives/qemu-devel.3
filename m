Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4BD3CCD193
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 10:17:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBsNc-0003EU-GD; Thu, 23 Oct 2025 06:17:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1vBsNN-0003Di-Ru
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 06:16:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1vBsNJ-0004qT-Sa
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 06:16:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761214611;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=NACNEBvSgZpW2mk4FNsjRF6+gFRoCkATDeRGg4HRw14=;
 b=T0rBrGyzSrthF0rSXGMj2riB3AEgNoGnT67EUxg4755Q6a12iGX6lp1FHuZ0mxdViIIff3
 BBu0hZQIrB/LF5Jdg1/zYJYIbG2EKBfOS5XDKyj0ug6GukXsypvmpbvP6rvkHn72fy+3fY
 uMGt+UCXHf5rAsGqh3K/8GTQeiQ0rIQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-269-ymcgfrHAO1CZ2OZCx0ayTA-1; Thu, 23 Oct 2025 06:16:49 -0400
X-MC-Unique: ymcgfrHAO1CZ2OZCx0ayTA-1
X-Mimecast-MFC-AGG-ID: ymcgfrHAO1CZ2OZCx0ayTA_1761214608
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-426d4f59cbcso1055306f8f.1
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 03:16:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761214608; x=1761819408;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NACNEBvSgZpW2mk4FNsjRF6+gFRoCkATDeRGg4HRw14=;
 b=MkKAsMlRxq5sBWQwuOumOsxubUDQV5a8ReIUwFrA4uBBOi26YinfyBmc4fsHHIrpj0
 8C1kx/DDXCbLTrYudK2fRAVYLL9aN3cH/1c6HiFkNfR0HaK2URB9+YyAVJtUp9ILmQK6
 Tmn2mN3dm1yyMQJ6xwDCwDOC+eh/fWF+OQJWlKhE2CpcuwbLhuPoCpaK+zqARdnqkxBJ
 6ore9nYv4/NEACEb+S4bhj5Ja/kQjgSKp/saoFXgejzk4CQTpRHsWFAojZXOIUNZw0/d
 LoFJCRAbUwlQ9SXACVFKFPZuak2k+/0BYjWOi3xJzVbEPs5DxMFKfRSkwZ1acDyDoQhi
 1PyQ==
X-Gm-Message-State: AOJu0YwnX1VjN2+lD4PoI1jwoDYakC1cHLqyFeewCpeG70cVesmjKudE
 4RG5A8MYbzKYU8A26mW5Ve67OfI6xe4i1FAVTUF1Hq03fZ4IJMyInt1UjDK72S5FNq+p2ki4pDM
 YPcZKKH0OlENx/fWPxTWJnj43R0ybqauIt6fYb8c1ZexNN+C2J7hhtHU8
X-Gm-Gg: ASbGnctagFw54+tVJc4LAsX8Otgav+X16SQFuxuXdOlCrotRBNhnzoLS2MNa0v07t7X
 CWME7rH41vLewTRPNLNlrJQVMeYbF9lcI8uD7Fjs0xiAHBbBh0Wt9wY/7FdqN5kNab3+ugLjdNE
 3xJmrSWO7HYkQ9P88rGDxGAvTlrhMERuxDU6q7Z6tK/SNevG2XhU/6ikNzJYGXdfWFrc6JyJM90
 fCcIXkd+G8Q0+xEbqUEz/XAo1Jx2nqYoiHQUqI0aJvaVOJIjGXEPMSVKiG2pgJsFIUXJDkE5Fiw
 djxvYmtiKWOkYiXAF2ZzYLRUwqdHgG0Fl4+PO6E15K2ExpSXKmTGC+59bazaCcLvrvhZSesGIko
 SypHUCy/7iKVqv0Yyqv3+OKDghJNAZpNB5p7p0TTBDfYcodj/uWYLBjVB77Aq4MBYgF3FtX+Jfk
 Rzi9m7KQtfY05Hf5vYdHOev1LKDv8=
X-Received: by 2002:a05:6000:2081:b0:426:fff3:5d04 with SMTP id
 ffacd0b85a97d-428532779edmr4590162f8f.25.1761214608380; 
 Thu, 23 Oct 2025 03:16:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGk0+2QYmpMwZ0q9K7ByCPyiPeT1pBT4xdJ42NSUsdKxH7q8yNE+wnUTI4QWyUJCDjyR/D2Tg==
X-Received: by 2002:a05:6000:2081:b0:426:fff3:5d04 with SMTP id
 ffacd0b85a97d-428532779edmr4590127f8f.25.1761214607973; 
 Thu, 23 Oct 2025 03:16:47 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f4e:3200:c99d:a38b:3f3a:d4b3?
 (p200300d82f4e3200c99da38b3f3ad4b3.dip0.t-ipconnect.de.
 [2003:d8:2f4e:3200:c99d:a38b:3f3a:d4b3])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429898add96sm3100816f8f.30.2025.10.23.03.16.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Oct 2025 03:16:47 -0700 (PDT)
Message-ID: <3035c1a0-78b7-44a4-a9d8-4e84b9732262@redhat.com>
Date: Thu, 23 Oct 2025 12:16:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] ram-block-attributes: Avoid the overkill of shared
 memory with hugetlbfs backend
To: Chenyi Qiang <chenyi.qiang@intel.com>, Peter Xu <peterx@redhat.com>,
 Alexey Kardashevskiy <aik@amd.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Gao Chao <chao.gao@intel.com>,
 Li Xiaoyao <xiaoyao.li@intel.com>, Farrah Chen <farrah.chen@intel.com>
References: <20251023095526.48365-1-chenyi.qiang@intel.com>
 <20251023095526.48365-2-chenyi.qiang@intel.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20251023095526.48365-2-chenyi.qiang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 23.10.25 11:55, Chenyi Qiang wrote:

Subject should probably rather be:

"ram-block-attributes: fix interaction with hugetlb memory backends"

Maybe that can be fixed up when applying.

> Currently, CoCo VMs can perform conversion at the base page granularity,
> which is the granularity that has to be tracked. In relevant setups, the
> target page size is assumed to be equal to the host page size, thus
> fixing the block size to the host page size.
> 
> However, since private memory and shared memory have different backend
> at present, users can specify shared memory with a hugetlbfs backend
> while private memory with guest_memfd backend only supports 4K page
> size. In this scenario, ram_block->page_size is different from the host
> page size which will trigger an assertion when retrieving the block
> size.
> 
> To address this, return the host page size directly to relax the
> restriction. This changes fixes a regression of using hugetlbfs backend
> for shared memory within CoCo VMs, with or without VFIO devices' presence.
> 
> Acked-by: David Hildenbrand <david@redhat.com>
> Tested-by: Farrah Chen <farrah.chen@intel.com>
> Signed-off-by: Chenyi Qiang <chenyi.qiang@intel.com>
> ---


-- 
Cheers

David / dhildenb


