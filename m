Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A7F8D6A224
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 18:03:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBeBs-0001o6-CR; Thu, 14 Nov 2024 13:03:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tBeBf-0001fz-VG
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 13:03:25 -0500
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tBeBe-0002ru-D6
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 13:03:23 -0500
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-71e52582cf8so779055b3a.2
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 10:03:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731607401; x=1732212201; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/OPghi9ksG3nXLruYBuKTlY2u+dSEONoVpeIxOAZwMg=;
 b=nVrgPTDFVevehpg7eO6RunOQGWyU3O3w25KnT0/8TQ6e2cK4HwXcWGB+PVLiNIEG9X
 h6VJ0Sb4hLD8YfX3oogUyL5w2IlRuhL6BlO6bthERhI+p6ecsz8oNDE6zCaGH6OVkvp9
 myN4cnUhQOAcQ4lmHUvdwsQQcxTONxWBKKJ9WP3eNMIXBhvMc41qe9gQjJiPbfF/tOkJ
 i2msdeb7yIZfd363VmY4TNtLHvN1CbVrrz7u13EQvrJ/gMHTlb0NALOKnBIz8TlqTwnF
 wF+P4U7HxrofDlwf6qRtXy8L2ESYjD0sUNXuzjLXpFhLzxZ/w3qsMhEQSRWvTRoj2gnA
 WS0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731607401; x=1732212201;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/OPghi9ksG3nXLruYBuKTlY2u+dSEONoVpeIxOAZwMg=;
 b=CP31lv2n+BCyYdHGtuTiXRewMZp7zQYmMovsKgKOQ1kgfQAvEFFTVQsCOP/FTTvyUs
 yWtWVqYzdoAJh3bKKmV48Y7a/WnmkTAN6EUqrc7SENdNIIzJz8sFemutTK/zQuOzCfBc
 EWtqOb3Z8p/gZERuIJNfrVbWEHngaqc1tmkXrzFh8XVEYLywKxXQJtggY3LndM9X9CAK
 44j3lFZFeqt6H8RwMxAZY8RvbOy9VBngGAMS5PjDMkHJgfaI71zQoZ1HhVU6MNt9bVIP
 U3cTOhTE378pa8bU2eNvY18By/Bovy3O3XTDsM6ETPZNrKNtQlYmDkvZdOZonhOH+caO
 HU8g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXdbvz7C7uD6mT9uVq1HQ55VcQjpy55v0TUgIZv+EadGmZtsCikbVQbcHq8T7N4UrwHublTD9Osoz6A@nongnu.org
X-Gm-Message-State: AOJu0Yy7R+1+w/mO9CVSVeeR5idHq1Ke8eqGAAyj4tFmcoeLfeSZ9iMn
 +dNcbeuR2o959mqBNy9XEvPzpI7SEFOvWgX2u61jUXC7ZJ5F6U9K5Kyf5cH3ctI=
X-Google-Smtp-Source: AGHT+IH9ix6BTdOkCjwutczv8gefsdc/wG6sQnuIcne+AUNUov09QdOBklhXyZwIHyaOrp6qa2YPAQ==
X-Received: by 2002:a05:6a00:178b:b0:71d:f821:1981 with SMTP id
 d2e1a72fcca58-72469c5e2e8mr3541576b3a.4.1731607401082; 
 Thu, 14 Nov 2024 10:03:21 -0800 (PST)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7246a81e04bsm1548014b3a.81.2024.11.14.10.03.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Nov 2024 10:03:20 -0800 (PST)
Message-ID: <a4d68b7d-8e78-4fce-bb54-3bf41d9c169e@linaro.org>
Date: Thu, 14 Nov 2024 10:03:20 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 15/54] accel/tcg: Use tlb_hit_page in victim_tlb_hit
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20241114160131.48616-1-richard.henderson@linaro.org>
 <20241114160131.48616-16-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241114160131.48616-16-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x433.google.com
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



On 11/14/24 08:00, Richard Henderson wrote:
> This is clearer than directly comparing the
> page address and the comparator.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   accel/tcg/cputlb.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index eb85e96ee2..7ecd327297 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -1394,9 +1394,8 @@ static bool victim_tlb_hit(CPUState *cpu, size_t mmu_idx, size_t index,
>       assert_cpu_is_self(cpu);
>       for (vidx = 0; vidx < CPU_VTLB_SIZE; ++vidx) {
>           CPUTLBEntry *vtlb = &cpu->neg.tlb.d[mmu_idx].vtable[vidx];
> -        uint64_t cmp = tlb_read_idx(vtlb, access_type);
>   
> -        if (cmp == page) {
> +        if (tlb_hit_page(tlb_read_idx(vtlb, access_type), page)) {
>               /* Found entry in victim tlb, swap tlb and iotlb.  */
>               CPUTLBEntry tmptlb, *tlb = &cpu->neg.tlb.f[mmu_idx].table[index];
>   

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


