Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D9EEC282EC
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Mar 2025 15:25:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tt6u2-0003bG-4x; Fri, 14 Mar 2025 11:24:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tt6u0-0003ai-6Q
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 11:24:48 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tt6tx-0006ka-QB
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 11:24:47 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43cf257158fso15358785e9.2
 for <qemu-devel@nongnu.org>; Fri, 14 Mar 2025 08:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741965881; x=1742570681; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VEE2Nvq9vB+i56gB+Yw73qdxRVaeeqnHNFiA+opEREY=;
 b=Y+MS1EtjqPuxPQ+x4bDmob3cq3h37OfPR7FvTIh4dWW/Qc5oSmV7+n+RZ1cmytVKQq
 zmX92rXfyOVm/02ayHj85SzPaP1vfUQSFYch92aBuAkfu3yIOnzkEuuWN8Yk9pxiZjNZ
 wIiokir8sGMHGIrwmNfFPeCWH7mPRz+QtI6ZOKpnGK7D59LygzNEln7eb5KF54V+Jpjb
 Auqgxxu3UySkpFmf4xP+TPCMi1Y8bedhoosuqbsK5xme29mit4xvD74Zfba4otScM0zW
 Z87EWjX/qwDvmMg0pp/7xKEE82ZsOVtWCs1hD+crOfbad5L7mnx5PZGDKlVMtVB3eezt
 ySvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741965881; x=1742570681;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VEE2Nvq9vB+i56gB+Yw73qdxRVaeeqnHNFiA+opEREY=;
 b=keen0Iomkoxv7rfy/NNv40uCuie7GPFYvXziF56Ac9UPYvNhBg4qkBb6Cdt0Uyk87Q
 wFrXrIq02iohgfmukjpjeWvfyxOERX/0JkWYOFXjyNuknOsgHYAJaRJ7Cc7VdiB8t5MS
 L/jfTfp9Wu9oPlqZinnOyADxhQ33XDDMEUyY52QpxHxUOLfZ6rDP1ruhWyWggGL2nwSW
 JczvgyL3D7lu6p8iPrTdYQSviu3wPd62ea3RjDDuYdSjcAEBdiJrfAIlX1omAPfFMCfV
 VtlsDVIEtQSl6V/qeXKxo7fo1f3nYegCS1Sx+U7d2dPoHVGZZJCqVZu24d2UjUSnubE8
 gn4A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUVyzvQVLblB1dy5PnuLbtgqt2N4tHVZeDR0fQE5jvQf+WNQu9hGQFFflyvO1Qr6XjXs1143DUeaAgi@nongnu.org
X-Gm-Message-State: AOJu0YwqGllMO3JDx52CCJE8KHr8Img7Rkx1soCSe3fhk+fr8gldSyLL
 GGYfCYS/xZ+V9QYowAEOvjC/jjHOt9iYdgKLttz9gkmoUlKaIGCPuQp1RBFh5ZI=
X-Gm-Gg: ASbGncsO8R5YewZjE47oO4BcE1Gd4VxUpiV7PVO18DP92f17t5lafTDdgR5aiVuDW46
 PnHGE7UBdPdUchTJMLpFulIg3gX6/fcnYgyyUDhKLl/wwZVDyxyYXmXfCD0K7AEUCMvQBTwk6Et
 GNfNurHZI1O1wnyh/nDwO7aqlVsqHFWCnX4iVyIUdmqtrBeFSv5gl6X2yE5q8F31WcuUNwp5RiC
 psvPO1UgIT2xap1FyZTEkSiQ9MWRmfiTp6thp3DIftELbsA6kkJiBVuF5Lzhon5bG5hahVDkFrf
 Y0WX7cgABoxcs/wqeFq43UowQ4enkrmm0Pg/6Px7dzzhqWauzsV9OilU8WtoYb+D1PpxmCub2oJ
 O0q/rDjn+Q9BpVGs=
X-Google-Smtp-Source: AGHT+IHk/efd3Ueuu3HvcXnLbFlT9LIvpKTEMqkzCLNqVWmcmBMPrW3cTUl2WTXb1jevB/K1KLVD5w==
X-Received: by 2002:a05:600c:3552:b0:43c:eeee:b706 with SMTP id
 5b1f17b1804b1-43d1ed0028cmr34887475e9.24.1741965880682; 
 Fri, 14 Mar 2025 08:24:40 -0700 (PDT)
Received: from [192.168.1.67] (88-178-97-237.subs.proxad.net. [88.178.97.237])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d200fae32sm20353825e9.31.2025.03.14.08.24.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Mar 2025 08:24:40 -0700 (PDT)
Message-ID: <b1bf1986-d034-471a-ab4d-3ee19f501940@linaro.org>
Date: Fri, 14 Mar 2025 16:24:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] memory: suppress INVALID_MEM logs caused by debug
 access
To: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>
References: <20250314074107.992163-1-npiggin@gmail.com>
 <20250314074107.992163-3-npiggin@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250314074107.992163-3-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 14/3/25 08:41, Nicholas Piggin wrote:
> Debugger-driven invalid memory accesses are not guest errors, so should
> not cause these error logs.
> 
> Debuggers can access memory wildly, including access to addresses not
> specified by the user (e.g., gdb it might try to walk the stack or load
> target addresses to display disassembly). Failure is reported
> synchronously by the GDB protcol so the user can be notified via the
> debugger client.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>   system/memory.c | 37 ++++++++++++++++++++++---------------
>   1 file changed, 22 insertions(+), 15 deletions(-)
> 
> diff --git a/system/memory.c b/system/memory.c
> index 4c829793a0a..960f66e8d7e 100644
> --- a/system/memory.c
> +++ b/system/memory.c
> @@ -1412,18 +1412,23 @@ bool memory_region_access_valid(MemoryRegion *mr,
>   {

Should we instead consider debug accesses as always valid? i.e.:

         if (attrs.debug) {
             return true;
         }

>       if (mr->ops->valid.accepts
>           && !mr->ops->valid.accepts(mr->opaque, addr, size, is_write, attrs)) {
> -        qemu_log_mask(LOG_INVALID_MEM, "Invalid %s at addr 0x%" HWADDR_PRIX
> -                      ", size %u, region '%s', reason: rejected\n",
> -                      is_write ? "write" : "read",
> -                      addr, size, memory_region_name(mr));
> +        if (attrs.debug) {
> +            /* Don't log memory errors due to debugger accesses */
> +            qemu_log_mask(LOG_INVALID_MEM, "Invalid %s at addr 0x%" HWADDR_PRIX
> +                          ", size %u, region '%s', reason: rejected\n",
> +                          is_write ? "write" : "read",
> +                          addr, size, memory_region_name(mr));
> +        }
>           return false;
>       }
>   
>       if (!mr->ops->valid.unaligned && (addr & (size - 1))) {
> -        qemu_log_mask(LOG_INVALID_MEM, "Invalid %s at addr 0x%" HWADDR_PRIX
> -                      ", size %u, region '%s', reason: unaligned\n",
> -                      is_write ? "write" : "read",
> -                      addr, size, memory_region_name(mr));
> +        if (attrs.debug) {
> +            qemu_log_mask(LOG_INVALID_MEM, "Invalid %s at addr 0x%" HWADDR_PRIX
> +                          ", size %u, region '%s', reason: unaligned\n",
> +                          is_write ? "write" : "read",
> +                          addr, size, memory_region_name(mr));
> +        }
>           return false;
>       }
>   
> @@ -1434,13 +1439,15 @@ bool memory_region_access_valid(MemoryRegion *mr,
>   
>       if (size > mr->ops->valid.max_access_size
>           || size < mr->ops->valid.min_access_size) {
> -        qemu_log_mask(LOG_INVALID_MEM, "Invalid %s at addr 0x%" HWADDR_PRIX
> -                      ", size %u, region '%s', reason: invalid size "
> -                      "(min:%u max:%u)\n",
> -                      is_write ? "write" : "read",
> -                      addr, size, memory_region_name(mr),
> -                      mr->ops->valid.min_access_size,
> -                      mr->ops->valid.max_access_size);
> +        if (attrs.debug) {
> +            qemu_log_mask(LOG_INVALID_MEM, "Invalid %s at addr 0x%" HWADDR_PRIX
> +                          ", size %u, region '%s', reason: invalid size "
> +                          "(min:%u max:%u)\n",
> +                          is_write ? "write" : "read",
> +                          addr, size, memory_region_name(mr),
> +                          mr->ops->valid.min_access_size,
> +                          mr->ops->valid.max_access_size);
> +        }
>           return false;
>       }
>       return true;


