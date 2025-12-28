Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDAA0E784BE
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Dec 2025 16:01:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZtCk-0006ja-5G; Sun, 28 Dec 2025 11:01:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vZtCj-0006jE-BB
 for qemu-devel@nongnu.org; Sun, 28 Dec 2025 11:01:13 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vZtCh-0002ki-Uy
 for qemu-devel@nongnu.org; Sun, 28 Dec 2025 11:01:13 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4779ce2a624so63829045e9.2
 for <qemu-devel@nongnu.org>; Sun, 28 Dec 2025 08:01:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766937670; x=1767542470; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/H15o4kfx6hgKkgLlbhbtG4JmrSZCiBDC5hYoo8K7ps=;
 b=ezQ05CiMfPC1/LBh/dTFzHLbNI0uBFt7yUBYalhrQPUlnu0a2XDkLFZhja2Lzf+LZv
 cmCnkEScqzQCRB7HsAm0aovXvDGUHp1zbVU+UskfUUl62GfpadqysoSfSYf6htZ6gZTe
 36Xn/rtTgrKEdFBYPaghOR1FHpWXIVuBWgow9ZllBV4/4qywR2kcw11EuaSBaNlqZ9+t
 9gY4kHiOxiHGyeP9NcWJW3TDat5MtZAV0TJa1vgKBeoz3ShY4GqYqlnNcyZ5WQ5fkZ0i
 c2d39lpVFaarnJYeHysnYxFPs/VSwthqV+CJvLGmhM2J9j0t26F3sJhBUBe7wm8VwkZ2
 qgbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766937670; x=1767542470;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/H15o4kfx6hgKkgLlbhbtG4JmrSZCiBDC5hYoo8K7ps=;
 b=nqYTKMgmieaEcoHetnGSp3Hf9XRKfUfQGw5XKJENR8ouywsBlYreVn0cA+raNYbuab
 XnH8C9KYQAJQooUtifpW/3w0yxiVlcYTxI5IgzfO3TvGH4XTrnY6xzC9pFr2JG8AEXHV
 aVVM5zZnhl14tP8x/EW/SAmhn03VTT2XiKmwUd4UT95GYobvr85Vj0BQ4PkNhxG1tSH4
 UdEarj4+zTYR3fP4qEk8cqxXYdGeH0HaryqAOBrOEd1l8JhyZmfKYmMw6rdAJcUXit8R
 NouYeRj9iixZUBMzPeDdwt57l8/fJ1H6v0Xms8mmF2JHJ6FVYUI7yWEtXBNwJwVaEp/s
 ggeQ==
X-Gm-Message-State: AOJu0Yz778YRUMnrFbKs8fYvrFiLHn60xFYZjOQUMErho9e+XA6SCl8n
 krGKMKsyziOHuOvbf2QpYuz4UNg2V/LIQ/09FHp//nADgRstLkbzpWx4i28/4iv7X4M=
X-Gm-Gg: AY/fxX5EcnrBIIG4yD56W7+BEleGnJjAq+xTqRa66xoZw+LQh/2ad4N13Y9OPoAXcx5
 giEash4Pm5zcrPv0AuIFIC9VVhb3Ia+0GGvvpLxf5Hpx6k2lkmzlsFTpGe8/rVLkuxFi8OKtdFd
 VkldQCc5CX64i8TO44QHrbV0hHbwYH457UyfBi6kox/6TARA1ZESmvFLLUSHQr2HSVGTMVUg477
 E6Gmnmy9Eg2K+/qyLa7R1bAJto33wqxLC0PYe1pYaKNaeqTDAfwT6RFHE8gfHN8Fe1VQqBacybV
 dKapEgL0KCcQ2+kRR/zxnJKuc8FsJow/wMtTod2GKWSfZHT6LL4ZQFCbMu/imijkGn9/Wi64KoY
 QVylmJnj9leoaB0V9uEeMo4G75ugXWMxjmJHriieujkFFhpxs12OfejGOfKWUvkgyAO9MyoJj+t
 hSASx9D9eEMjah8mUxUQhoXj8Nf4SNhSbE8U2oxLgVsQSOdmFuxUmfR71Z0ExrbQ==
X-Google-Smtp-Source: AGHT+IGkKQEIm7bxnUHnezwzfJL9lG8k6xsRc6NmKQcWc9WckFKQC+1Cn6oPALjqvHhRrB7/3HnoJA==
X-Received: by 2002:a05:600c:1d0a:b0:477:79c7:8994 with SMTP id
 5b1f17b1804b1-47d1959f72amr328275725e9.30.1766937670271; 
 Sun, 28 Dec 2025 08:01:10 -0800 (PST)
Received: from [192.168.1.15] (alyon-655-1-564-32.w80-9.abo.wanadoo.fr.
 [80.9.105.32]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324eaa0908sm57017488f8f.31.2025.12.28.08.01.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 28 Dec 2025 08:01:09 -0800 (PST)
Message-ID: <40f36e06-de73-435c-b219-f950b546037e@linaro.org>
Date: Sun, 28 Dec 2025 17:01:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 14/25] system/memory: Use explicit endianness in
 ram_device::read/write()
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, Peter Xu
 <peterx@redhat.com>, Richard Henderson <richard.henderson@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Anton Johansson <anjo@rev.ng>, David Hildenbrand <david@kernel.org>
References: <20251224152210.87880-1-philmd@linaro.org>
 <20251224152210.87880-15-philmd@linaro.org>
 <CABgObfbcsao=NdVN0tg-m5ZCNB3soCq-nwyFkarLVYdEGV_NAA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CABgObfbcsao=NdVN0tg-m5ZCNB3soCq-nwyFkarLVYdEGV_NAA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

On 28/12/25 12:12, Paolo Bonzini wrote:
> 
> 
> Il mer 24 dic 2025, 16:24 Philippe Mathieu-Daudé <philmd@linaro.org 
> <mailto:philmd@linaro.org>> ha scritto:
> 
>     Replace the ldn_he_p/stn_he_p() calls by their explicit endianness
>     variants. Duplicate the MemoryRegionOps, using one entry for BIG
>     and another for LITTLE endianness. Select the proper MemoryRegionOps
>     in memory_region_init_ram_device_ptr().
> 
> 
> This extra complication makes no sense to me. You're introducing dead 
> code and dead data, because only one of the MemoryRegionOps will be ever 
> used on a given host.
> 
> Given this example and the ATI one, I would really prefer to keep _he_ 
> functions around and use them whenever you're reading from host memory 
> as in this case.

Ack, patch dropped.

