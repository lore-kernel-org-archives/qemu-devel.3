Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65233C5AD49
	for <qemu-devel@archiver.kernel.org>; Mon, 26 May 2025 09:08:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJTon-0004Pb-6p; Mon, 26 May 2025 05:08:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1uJTom-0004PS-4T
 for qemu-devel@nongnu.org; Mon, 26 May 2025 05:08:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1uJTok-0000uM-7R
 for qemu-devel@nongnu.org; Mon, 26 May 2025 05:08:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748250501;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=LQxCWuutrhRX1ozeQ1hSnlARkYaLf5Pk8UUtSEwfD18=;
 b=gdqZEKJabMMR1OaLfOlLaDEuUdpThQXDdfg2/dlBS4+nz7uP5X28IcNi8XSuHQ03Mowo21
 ezS9233rUPP4o4ED0YVWYs7QMMDBgi0oN6seCIQX00zENMP94jOPhGLYVREDWOhvU8MZ0s
 wfr1HdNSR3orO/jymIbQY48U8KX4/Mg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-690-P7_9T8rqMB-UZaQ17YALdA-1; Mon, 26 May 2025 05:08:19 -0400
X-MC-Unique: P7_9T8rqMB-UZaQ17YALdA-1
X-Mimecast-MFC-AGG-ID: P7_9T8rqMB-UZaQ17YALdA_1748250498
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-442e0e6eb84so12196775e9.0
 for <qemu-devel@nongnu.org>; Mon, 26 May 2025 02:08:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748250498; x=1748855298;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=LQxCWuutrhRX1ozeQ1hSnlARkYaLf5Pk8UUtSEwfD18=;
 b=w7f8ItDiMaGhph/A2QsCfgJ3qrrV94GWnvJVc4xW560++wov+CyLXAUKySnXLKCF/D
 qu6lUxFPL8B0QHIIr27ytxHUwm+8ekKT05c/vAid0cGNiSjv4ZtL2rza/nHvvJTw/EiX
 pC/HceQkBavx3Wv2D/bKKa2oV7yqBjtMxpjHXFCc4A+LAAGP7QxV0aMQuk2SYMx39nem
 +KIJnB3zNod4b10Y5jIOxXzhqFWNWWTC4lu5iIOlq5x4qcPRPgbkoPifO2kqRwVEX3xU
 S43ST8SNsgflOzDsCag23P7CyJntRVoOyZGdkOIK7naYwrWbI1qlRzFH0wHsNiX8Gnwm
 /aXQ==
X-Gm-Message-State: AOJu0YwTW+PNIiQnI1filLX0vdfE8wwE2vRhhITN2vbs1e/qFH6gISWA
 xDsBfbp6x/8juKfcGd2ZwdFJbeP67ZuYoepyV2oT1v6ndNdL4ipw6VcLWz617ytnHYpI+qedwQg
 zY8NkRKeM840HkW4RWu1suzGRYzT8LrlkfnOoLBwcPWCP+KYG2BqFmmsS
X-Gm-Gg: ASbGncvVN9tiEKWHnq9kMfHPSwGVtelCCDABT5W9wOrR8b3lzEDDme4TP+Lp7KN+RpJ
 UV/WWQzCk7v1D5NkyB0/64a2/4QjCLJxElgPI8RIsO0Q9yk1+HNcoeOnoSQe9K3IgLL7GWWGQdK
 z9V0GpZFn4MFtdORwuT5BpCeS4fK4e7Lypa6BiK1P4zPjdZuFqqBuQLfih5FzgJCB4AnH36zSCh
 QyOQ6v1VeqNM334ZgZIIALQZhO/H+5uWL39TCu5vGhin56ecWaH7NEwWT1Wp8Q1ubmL79fn/i1Y
 3PBbaWWyC50TDL3s07Lmd5eGOwihQiuYJaiOJ9tXQf/5mmGmJpJviRTVlVipi0ifD2aEAw8Kd8h
 zys9acA7RoeqDzilQNFr6vCC/2L1MHI6eF60UZNI=
X-Received: by 2002:a05:600c:5286:b0:43b:c0fa:f9cd with SMTP id
 5b1f17b1804b1-44c91ad6c06mr67951075e9.7.1748250497717; 
 Mon, 26 May 2025 02:08:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEBNQlYC1hvLZSSmh6Jjv2kh2e5AJrTyiKyxY21nmxjLlkOjxliRfA3Bxef5aUzhLswspqfqQ==
X-Received: by 2002:a05:600c:5286:b0:43b:c0fa:f9cd with SMTP id
 5b1f17b1804b1-44c91ad6c06mr67950705e9.7.1748250497280; 
 Mon, 26 May 2025 02:08:17 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f19:6500:e1c1:8216:4c25:efe4?
 (p200300d82f196500e1c182164c25efe4.dip0.t-ipconnect.de.
 [2003:d8:2f19:6500:e1c1:8216:4c25:efe4])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-447f73d3edcsm236811905e9.20.2025.05.26.02.08.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 May 2025 02:08:16 -0700 (PDT)
Message-ID: <7af3f5c9-7385-432f-aad6-7c25db2fafe2@redhat.com>
Date: Mon, 26 May 2025 11:08:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 07/10] RAMBlock: Make guest_memfd require coordinate
 discard
To: Chenyi Qiang <chenyi.qiang@intel.com>, Alexey Kardashevskiy
 <aik@amd.com>, Peter Xu <peterx@redhat.com>,
 Gupta Pankaj <pankaj.gupta@amd.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Roth <michael.roth@amd.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Williams Dan J <dan.j.williams@intel.com>, Zhao Liu <zhao1.liu@intel.com>,
 Baolu Lu <baolu.lu@linux.intel.com>, Gao Chao <chao.gao@intel.com>,
 Xu Yilun <yilun.xu@intel.com>, Li Xiaoyao <xiaoyao.li@intel.com>
References: <20250520102856.132417-1-chenyi.qiang@intel.com>
 <20250520102856.132417-8-chenyi.qiang@intel.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250520102856.132417-8-chenyi.qiang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -59
X-Spam_score: -6.0
X-Spam_bar: ------
X-Spam_report: (-6.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.904,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 20.05.25 12:28, Chenyi Qiang wrote:
> As guest_memfd is now managed by RamBlockAttribute with
> RamDiscardManager, only block uncoordinated discard.
> 
> Signed-off-by: Chenyi Qiang <chenyi.qiang@intel.com>
> ---
> Changes in v5:
>      - Revert to use RamDiscardManager.
> 
> Changes in v4:
>      - Modify commit message (RamDiscardManager->PrivateSharedManager).
> 
> Changes in v3:
>      - No change.
> 
> Changes in v2:
>      - Change the ram_block_discard_require(false) to
>        ram_block_coordinated_discard_require(false).
> ---
>   system/physmem.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/system/physmem.c b/system/physmem.c
> index f05f7ff09a..58b7614660 100644
> --- a/system/physmem.c
> +++ b/system/physmem.c
> @@ -1916,7 +1916,7 @@ static void ram_block_add(RAMBlock *new_block, Error **errp)
>           }
>           assert(new_block->guest_memfd < 0);
>   
> -        ret = ram_block_discard_require(true);
> +        ret = ram_block_coordinated_discard_require(true);
>           if (ret < 0) {
>               error_setg_errno(errp, -ret,
>                                "cannot set up private guest memory: discard currently blocked");
> @@ -1939,7 +1939,7 @@ static void ram_block_add(RAMBlock *new_block, Error **errp)
>                * ever develops a need to check for errors.
>                */
>               close(new_block->guest_memfd);
> -            ram_block_discard_require(false);
> +            ram_block_coordinated_discard_require(false);
>               qemu_mutex_unlock_ramlist();
>               goto out_free;
>           }
> @@ -2302,7 +2302,7 @@ static void reclaim_ramblock(RAMBlock *block)
>       if (block->guest_memfd >= 0) {
>           ram_block_attribute_destroy(block->ram_shared);
>           close(block->guest_memfd);
> -        ram_block_discard_require(false);
> +        ram_block_coordinated_discard_require(false);
>       }
>   
>       g_free(block);


I think this patch should be squashed into the previous one, then the 
story in that single patch is consistent.

-- 
Cheers,

David / dhildenb


