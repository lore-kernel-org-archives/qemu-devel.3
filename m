Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6BF7D6A224
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 17:57:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBe5Z-0005Kb-Lv; Thu, 14 Nov 2024 12:57:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tBe5X-0005KM-VP
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 12:57:03 -0500
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tBe5W-0001Xd-FY
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 12:57:03 -0500
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-7f46d5d1ad5so693752a12.3
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 09:57:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731607021; x=1732211821; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ar3fpz9zCrlyeaiN13paVfdE7M3ngx5f+hwq29rk7Yo=;
 b=Z6RBCp2kVD/ZQa6Kfk/kDoYRNveTcNL9n0VdyW331maw4NB2MCCWHP6hrz4Ri+tBiG
 SJhOtWskLAHEwLnmSLAfGb7lzICHBPXJn9yUEXAdc0Fn7bfIegXsYUB/QbpGRCY2mXNI
 DXQf9YQ2bXau7xitUUhKGJMXXIRJL4LGC87hMpVLMZpl/OVTl094clOtklqmL7hrs/Dp
 l53ZfZJRiKc8qw7zyrVJ+KoVC1XBTlnVmBCkbnv9vQ2Uv3Ort1Xz0h3yZY1MzQPAsedW
 tRpnnnmVTi+RDhYcmAXhcOhtgw11vXJD4xmzfWkQyfVtvxrIQXs3CK7MYAmkka0Qecdw
 MF3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731607021; x=1732211821;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ar3fpz9zCrlyeaiN13paVfdE7M3ngx5f+hwq29rk7Yo=;
 b=VU+1TQXn6WBswxx5uUkZqA4WpekVr7fRsn7cdopSHA2udZaOMtsT8cP/POf3etmU8r
 4N3CXDdhiS8U7jgRk2giRrmKulOLOFiJmxYR+qt6aJZjwXyyspPTuvSoLuL6TH7KV8qO
 7dUNO9GbNIyvyB6THGA/rYcke3jFrHwEgrfgr4KwkqsK3yKGbxXBQaJzWS3d6fvZU6l3
 p6mUF7bfod932K1M/lH7z3vsKW6H57XkhwKSoBu/f4VjXIWAoC3lsPYZ2UcF5IqHxYwd
 KEoOgpxDcvPiHlq4UDt4f4FL6wButTXTwjV4OaaDWRfi5Jkt7vkyJ1O+U+MO74JmEYcS
 9o5g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXYzea7/eNmrgizadHECBXe4KUGwMz5rPgiC6yigFE85q1aPo5cOSkf7NXWwDMKkqCA7gRxQFcsVWHM@nongnu.org
X-Gm-Message-State: AOJu0YziroIJ6vP9cjbO2/i6pn8AumlO0BxAxTW2d6B72NgEdf9EV8aY
 ObWsGpVLnN7CAAAmyBRjA8QaUuvI2TXzwQGAc/H4TpK8mpn3zVpLbSAexgLvbHE=
X-Google-Smtp-Source: AGHT+IGUh38W6/jxlebUMRT2mKRQ4cGfcWfuie9ADfJm55ndguzqTASINVHYEGFPOSvxN0rQZvWqHQ==
X-Received: by 2002:a05:6a20:9185:b0:1db:eb50:abb0 with SMTP id
 adf61e73a8af0-1dc832ecbbfmr4182589637.3.1731607020767; 
 Thu, 14 Nov 2024 09:57:00 -0800 (PST)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7246a9d40a2sm1519807b3a.193.2024.11.14.09.57.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Nov 2024 09:57:00 -0800 (PST)
Message-ID: <7b0e0cb8-0f71-43a4-b503-ab4e2298a561@linaro.org>
Date: Thu, 14 Nov 2024 09:56:59 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/54] accel/tcg: Assert bits in range in
 tlb_flush_range_by_mmuidx*
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20241114160131.48616-1-richard.henderson@linaro.org>
 <20241114160131.48616-8-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241114160131.48616-8-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x529.google.com
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
> The only target that does not use TARGET_LONG_BITS is Arm, which
> only reduces bits based on TBI.  There is no point in handling
> odd combinations of parameters.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   accel/tcg/cputlb.c | 16 ++++------------
>   1 file changed, 4 insertions(+), 12 deletions(-)
> 
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index 1346a26d90..5510f40333 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -792,20 +792,16 @@ void tlb_flush_range_by_mmuidx(CPUState *cpu, vaddr addr,
>   
>       assert_cpu_is_self(cpu);
>       assert(len != 0);
> +    assert(bits > TARGET_PAGE_BITS && bits <= TARGET_LONG_BITS);
>   
>       /*
>        * If all bits are significant, and len is small,
>        * this devolves to tlb_flush_page.
>        */
> -    if (bits >= TARGET_LONG_BITS && len <= TARGET_PAGE_SIZE) {
> +    if (bits == TARGET_LONG_BITS && len <= TARGET_PAGE_SIZE) {
>           tlb_flush_page_by_mmuidx(cpu, addr, idxmap);
>           return;
>       }
> -    /* If no page bits are significant, this devolves to tlb_flush. */
> -    if (bits < TARGET_PAGE_BITS) {
> -        tlb_flush_by_mmuidx(cpu, idxmap);
> -        return;
> -    }
>   
>       /* This should already be page aligned */
>       d.addr = addr & TARGET_PAGE_MASK;
> @@ -832,20 +828,16 @@ void tlb_flush_range_by_mmuidx_all_cpus_synced(CPUState *src_cpu,
>       CPUState *dst_cpu;
>   
>       assert(len != 0);
> +    assert(bits > TARGET_PAGE_BITS && bits <= TARGET_LONG_BITS);
>   
>       /*
>        * If all bits are significant, and len is small,
>        * this devolves to tlb_flush_page.
>        */
> -    if (bits >= TARGET_LONG_BITS && len <= TARGET_PAGE_SIZE) {
> +    if (bits == TARGET_LONG_BITS && len <= TARGET_PAGE_SIZE) {
>           tlb_flush_page_by_mmuidx_all_cpus_synced(src_cpu, addr, idxmap);
>           return;
>       }
> -    /* If no page bits are significant, this devolves to tlb_flush. */
> -    if (bits < TARGET_PAGE_BITS) {
> -        tlb_flush_by_mmuidx_all_cpus_synced(src_cpu, idxmap);
> -        return;
> -    }
>   
>       /* This should already be page aligned */
>       d.addr = addr & TARGET_PAGE_MASK;

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


