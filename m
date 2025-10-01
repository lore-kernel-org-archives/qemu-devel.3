Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 228DCCCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 08:30:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3s9n-0005KN-FB; Wed, 01 Oct 2025 04:25:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3s9j-00059d-S7
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 04:25:49 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3s9U-0007nQ-AX
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 04:25:43 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-45b4d89217aso45583115e9.2
 for <qemu-devel@nongnu.org>; Wed, 01 Oct 2025 01:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759307126; x=1759911926; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3q5iaS9tln87d74VeEF3Gfdu85ykgDy7G0fLQJRBnqE=;
 b=Z9TrpVWOzHjPgSM1XnLnRZouDEcf4cqkSXnJ+w4zx9TrWSb7cXfFCVhykHxmhbGCxy
 GHxB/cHeOjBPS9hL7pYeWb0hxn/ZwreiJZytIf4etOwQH06d17ZkQ0gtVESaacjkhdMs
 bi9KRQbf0NsXGXJmGDLFAWf19IXNP6T9S/BtoUenFW79r16yV10sWhd+EQtFTMrml740
 a+UP9NMLBLa5VV/jg5zdbwBRQArXZvMnQo5SsEqrJbCRUQO1Hs2Qo+5fp3ME8AkQCnw+
 LXYa5Gtr4cn+TC8OSQ6UH5JCRspQlABUdE+3YYPwyq+vcDHy+1DCfrNW0GkSg04gAEvj
 d5yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759307126; x=1759911926;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3q5iaS9tln87d74VeEF3Gfdu85ykgDy7G0fLQJRBnqE=;
 b=KVFwbjKiwFf7t5lc+xKyJe3rH9eZRQSgMBQGzktYVeTkzR/3GBap5GAWbKuEPyGd1L
 t2Is1EjaJJQm7+y6jgOh7oTeCQ5K8uRgZl4EJVNavb2Ex/pLJpLIeZba/7vq85UJpaAl
 SStwSmntZMt81hIxtVbrCBFlJ/15dg7qXvG5N8fO0pkJUDo/5+E5tAOiAjsrGAtKo9zO
 fi2IwJpD4yYTYas2SxbfBOeQWK1qFXzrSVZr7ZZxaG2Nev7CtNfb24FyPN59VVATJZV2
 xLT2cdQ7LHq/HTcPnw+rrq4lWbmVrAlncYC1s8spupzeK3AV3AMwqO+ECozSocsWR+Yv
 tzNA==
X-Gm-Message-State: AOJu0YyjxN4cPgxJ2ZYuXxG0WcTJanL4dTHd3KWTMOXGtpFYjLtwxv6a
 /TNkWuzm4f1N3Lc2bYUW1kIAWYqpeVOYQb5tXaIFnAbVn++nFX6/cZz2KiyQBym7NwSnH+742kX
 95Q7o3AC+cA==
X-Gm-Gg: ASbGnctOSgPp6wZkN7B//ZHo0TVkV95bgEdYC2/HXjrrJFoo22GZdOoYnJPHkyzP8nu
 bVrks9ALry/AHq7YMnvOibflmS1cqqh7sBOrzAWOklgMJGpgBoQYpNnFV7B4byAeT1+MSSNxGwa
 ynWA9wPrAQK1fmpvgu/8tx+boHWaYcrbEENXRk59RW2EUjQtiQMsIyW1OrBVI0W86maJv9//ZRV
 IMdWmbLjCsshs1tTsCZWB1h5u0OsxRFFCVe0J4cXMzKKBqLGYeFcQD7yOxyAMVT4Ahkofhyd/90
 OskAth6Hf+NQNQxDgWdMk7UPCQBsldSLcKGG7/SRrbz8oTXMMgokWLIYNSQWFdk/FU5y9wWLkzc
 5GDe5fYEA+ouMqzbdYkThXvKHj8ifN+ltZO7HEjRR4E965zBmMWgnVb6MsZfeHa1gcDPA2fd1am
 ihIgo5iqFwI1O9Iw==
X-Google-Smtp-Source: AGHT+IEZAHf/wHARZpDbZ993bwutM8qvOrkRXrkInJUiDKq1+IE0zn6/NvpDfqgLgXAg/Kd3uTTtKA==
X-Received: by 2002:a05:600c:8b84:b0:46e:53cb:9e7f with SMTP id
 5b1f17b1804b1-46e6126a722mr20289285e9.18.1759307125709; 
 Wed, 01 Oct 2025 01:25:25 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e6199fc34sm31732475e9.8.2025.10.01.01.25.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Oct 2025 01:25:25 -0700 (PDT)
Message-ID: <ef4baceb-671f-4afe-8a41-cafb89ea1707@linaro.org>
Date: Wed, 1 Oct 2025 10:25:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/25] system/physmem: Extract API out of
 'system/ram_addr.h' header
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Nicholas Piggin
 <npiggin@gmail.com>, Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 qemu-arm@nongnu.org, Jagannathan Raman <jag.raman@oracle.com>,
 David Hildenbrand <david@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Jason Herne
 <jjherne@linux.ibm.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 kvm@vger.kernel.org, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-ppc@nongnu.org,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, Fabiano Rosas <farosas@suse.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-s390x@nongnu.org,
 Peter Xu <peterx@redhat.com>
References: <20251001082127.65741-1-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251001082127.65741-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 1/10/25 10:21, Philippe Mathieu-Daudé wrote:
> Following a previous comment from Richard in [*],
> reduce "system/ram_addr.h" size by un-inlining a
> lot of huge functions that aren't really justified,
> and extract the API to the hew "system/physmem.h"
> header, after renaming the functions (removing the
> confusing 'cpu_' prefix).

Based-on: <20250930082126.28618-1-philmd@linaro.org>
"system/physmem: Remove cpu_physical_memory _is_io() and _rw()"

> Philippe Mathieu-Daudé (25):
>    system/ram_addr: Remove unnecessary 'exec/cpu-common.h' header
>    accel/kvm: Include missing 'exec/target_page.h' header
>    hw/s390x/s390-stattrib: Include missing 'exec/target_page.h' header
>    hw/vfio/listener: Include missing 'exec/target_page.h' header
>    target/arm/tcg/mte: Include missing 'exec/target_page.h' header
>    hw: Remove unnecessary 'system/ram_addr.h' header
>    accel/tcg: Document rcu_read_lock is held when calling
>      tlb_reset_dirty()
>    accel/tcg: Rename @start argument of tlb_reset_dirty*()
>    system/physmem: Rename @start argument of physical_memory_get_dirty()
>    system/physmem: Un-inline cpu_physical_memory_get_dirty_flag()
>    system/physmem: Un-inline cpu_physical_memory_is_clean()
>    system/physmem: Rename @start argument of physical_memory_all_dirty()
>    system/physmem: Rename @start argument of physical_memory_range*()
>    system/physmem: Un-inline cpu_physical_memory_range_includes_clean()
>    system/physmem: Un-inline cpu_physical_memory_set_dirty_flag()
>    system/physmem: Rename @start argument of physical_memory_*range()
>    system/physmem: Un-inline cpu_physical_memory_set_dirty_range()
>    system/physmem: Un-inline cpu_physical_memory_set_dirty_lebitmap()
>    system/physmem: Rename @start argument of physmem_dirty_bits_cleared()
>    system/physmem: Un-inline cpu_physical_memory_dirty_bits_cleared()
>    system/physmem: Rename @start argument of
>      physmem_test_and_clear_dirty()
>    system/physmem: Reduce cpu_physical_memory_clear_dirty_range() scope
>    system/physmem: Reduce cpu_physical_memory_sync_dirty_bitmap() scope
>    system/physmem: Drop 'cpu_' prefix in Physical Memory API
>    system/physmem: Extract API out of 'system/ram_addr.h' header

>   include/system/physmem.h          |  56 ++++
>   include/system/ram_addr.h         | 413 ------------------------------
>   system/physmem.c                  | 342 +++++++++++++++++++++++--
(highlight on diff-stat)

