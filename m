Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C91DC27C4F
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2024 16:33:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKhCP-0006FY-5M; Fri, 21 Jun 2024 12:33:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sKhCG-0006EV-N9
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 12:33:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sKhCF-00065s-1b
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 12:33:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718987585;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=AN/hZ7ZEAr6G/U+HlwdP38fL5Bq468JQXd/pqAI6ed4=;
 b=QbiigHHtrYpjuSvqyOczXDJhQoAbNC4MUhsbcj4LZ4TXxZQWLm6BmrbLeASCOKEOClILYl
 kuphVK0py/gRYpRGo91R0m9RH0GBzUzJTi2tjbC1g4RLntq7sRJ3q3wixAxJxWbVrbJn7p
 +idfj6LR6ZjdKW1JW7Wmfrn9w06Db6M=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-490-qd2Qm52qN2-gw3xalIpyCw-1; Fri, 21 Jun 2024 12:33:02 -0400
X-MC-Unique: qd2Qm52qN2-gw3xalIpyCw-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a6f10ddb898so137215166b.1
 for <qemu-devel@nongnu.org>; Fri, 21 Jun 2024 09:33:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718987581; x=1719592381;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AN/hZ7ZEAr6G/U+HlwdP38fL5Bq468JQXd/pqAI6ed4=;
 b=UlY3AfvTjpaF9I3d3Cg/WZR50zQ/MCKLjUUDF4oHpZb8GDsc8+wqCnMP5KHfbvYbnl
 gw+uI38yjAHlSoX3Fukk0DFFrdFvLN5oGX1HLqFiIHEH3DnBWuehjkVU5NcHcMZLP4uo
 cSwAWm8eCo4p8lo7FvZNIZ2uSqrOINehk0X6J+/m121NAqAurVNqPtdGYi8/Ldb0D3GD
 u9qccvadkFVc4dluCP9KyTBT6OvGnYhGiea4a+RAXMkbB7UBYWvPXlW94UIm+GkPSfmN
 XJol5ga+qWwbc/bEsdDku+MlKgMY1CEJUd6r0wqLcTS6EMKBuX5Mc5CN5UX+faPXqIMD
 cPvw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQnvtX4D78Odx48eCOg22TWdhPqWB1XZXEpUzV3HVKLTjtwsIT8i2NhyMj6KKkoCZ2//9JwHGd4QjxnmmFQscKEN8ihG8=
X-Gm-Message-State: AOJu0YyqmUV7I8+9C/5OhsT588jQuo4+hz1fyCedVIe1rM57qkyMykv2
 3njIrLgThKzwUYNVLxoOltCA7Qxzvdmm1pLYFtGny11DGLJx0xRRz7tjDixzf0NFgGGV+pWv3Gr
 cv/03qcM4hfw7LC522jClsVKcA6Sqp/KD2JULQyWxUDNLqfAFNuJs
X-Received: by 2002:a17:906:2f91:b0:a6f:a008:7f66 with SMTP id
 a640c23a62f3a-a6fab61d3e3mr542818566b.26.1718987581398; 
 Fri, 21 Jun 2024 09:33:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGKhlYA26/lpFThdhF+vx24MQc6p8ttXZwhqGDm2qyBR1DTtrpsyMIK+JyUo0yta6ILmCY+Kw==
X-Received: by 2002:a17:906:2f91:b0:a6f:a008:7f66 with SMTP id
 a640c23a62f3a-a6fab61d3e3mr542817666b.26.1718987581024; 
 Fri, 21 Jun 2024 09:33:01 -0700 (PDT)
Received: from [192.168.10.47] ([151.62.196.71])
 by smtp.googlemail.com with ESMTPSA id
 a640c23a62f3a-a6fcf560668sm99335866b.167.2024.06.21.09.33.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Jun 2024 09:33:00 -0700 (PDT)
Message-ID: <f09cd7a7-948b-4a86-91ba-94bf4e9d3222@redhat.com>
Date: Fri, 21 Jun 2024 18:32:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] exec: don't use void* in pointer arithmetic in headers
To: Roman Kiryanov <rkir@google.com>, richard.henderson@linaro.org,
 peter.maydell@linaro.org, qemu-devel@nongnu.org
Cc: jansene@google.com, mett@google.com, jpcottin@google.com,
 alex.bennee@linaro.org, berrange@redhat.com
References: <20240620201654.598024-1-rkir@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20240620201654.598024-1-rkir@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 6/20/24 22:16, Roman Kiryanov wrote:
> void* pointer arithmetic is a GCC extentension
> which could not be available in other build
> tools (e.g. C++). This changes removes this
> assumption.
> 
> Google-Bug-Id: 331190993
> Change-Id: I5a064853429f627c17a9213910811dea4ced6174
> Signed-off-by: Roman Kiryanov <rkir@google.com>
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
> v2: renamed from "use char* for pointer arithmetic"
>      and removed all explicit extra cast with
>      one typedef in memory.h.
> 
>   include/exec/memory.h | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/include/exec/memory.h b/include/exec/memory.h
> index b1713f30b8..b616338f05 100644
> --- a/include/exec/memory.h
> +++ b/include/exec/memory.h
> @@ -2795,8 +2795,10 @@ MemTxResult address_space_write_rom(AddressSpace *as, hwaddr addr,
>   #define ARG1_DECL    AddressSpace *as
>   #include "exec/memory_ldst_phys.h.inc"
>   
> +typedef uint8_t *MemoryRegionCachePtr;
> +
>   struct MemoryRegionCache {
> -    void *ptr;
> +    MemoryRegionCachePtr ptr;

Just "uint8_t *ptr" is enough; thanks for testing that it's enough.

Queued for the next pull request, thanks.

Paolo


>       hwaddr xlat;
>       hwaddr len;
>       FlatView *fv;


