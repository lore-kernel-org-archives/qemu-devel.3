Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31A3EC48BC4
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Feb 2024 19:22:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rbQGC-0000dn-Ad; Sat, 17 Feb 2024 14:22:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rbQG9-0000dR-7G
 for qemu-devel@nongnu.org; Sat, 17 Feb 2024 14:22:02 -0500
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rbQG4-0003qs-FI
 for qemu-devel@nongnu.org; Sat, 17 Feb 2024 14:22:00 -0500
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-6e09493eb8eso3266063b3a.1
 for <qemu-devel@nongnu.org>; Sat, 17 Feb 2024 11:21:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708197714; x=1708802514; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=eczxQgv+wMObP9nnFw7Pxw9/NkNNXGOMAeQZ/VT3Rk0=;
 b=TlJr29cyVyuo9h9O7ydgWIxTk+qO2vIxoeSOeIHZM+8wR+Bk/4AnEuehLmUhkRQL9Y
 aRWtaE+4cdgx9Hgo33SP/n5hekaI9fZMY82Jy/uROFLqAdK2u7iJv+RgMr0498828bqt
 AhW2gkWy7E0aPQgHBaeqSlt+DJkBts2lYKSIuoJ5dvX0fIAI2K8bDiTy1B3jmmKS+p25
 KLx/w40hj4AfvgFAXuCm7B9tl/CGUUbHHOcLoekHhrWYNr+p+V8az0DN5dBMsNZDIQzO
 wlAxuQx8656UTp5eqrNzrO6zbx03TuPOAlemgiSsiAwSEl5QBnNtjZIiwZjhMx1y+n13
 nv8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708197714; x=1708802514;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eczxQgv+wMObP9nnFw7Pxw9/NkNNXGOMAeQZ/VT3Rk0=;
 b=dGmK+f/fJeeO4RNSd9VADtEFjNHHXb6wh+quYEPVa+C+zyBdaFBlB8+WojDUzzsw5q
 rdtI6+rRJYCATVdxs2zT0PBvBS6HBZZ7u6TicnSF7KVMlcGgTzuRKZbjaaQjQwHOk/Ne
 hHkGwJr56aRSnrAoioI+ojkpy3jcD6g3S3sbpgBditD4tD3LZeKb0rRsKOXkMz3cn7og
 l2jAmyWcWFh4LlOjOeYO3hFiL0u1+rgeiCy+8P6IuqtDev4XHLLP38L1SIF1EyvQxdWT
 MOAElx+HqGpni/ANg3yeIdx8ye+mEu5y10OUADXBM3HHQdhZbLtp1Z2uAbS7eW5bVnib
 /ckg==
X-Gm-Message-State: AOJu0YxkHGTB+Jbt0m3/KvUPEje+TxTDC9RQ5DuWq5rwtdgCGSb1ljlY
 EtyahzgpPOCTZmqFxKHkFJC5iAMQHxvmEzY0rmMmhsuWJyghYmSE6FNznnAy1gvpkKYFDfXsgfA
 R
X-Google-Smtp-Source: AGHT+IGYwT8gE9Pj4nAfgEJ3e/hAtzSXIGjFurWTt7QFey6s0FwABy4cJJLe9gjuF3yW+XmJfORXYg==
X-Received: by 2002:a05:6a20:9592:b0:19e:5e0c:3bb8 with SMTP id
 iu18-20020a056a20959200b0019e5e0c3bb8mr12141028pzb.7.1708197714198; 
 Sat, 17 Feb 2024 11:21:54 -0800 (PST)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 b9-20020aa78109000000b006e08da9c29csm1998147pfi.54.2024.02.17.11.21.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 17 Feb 2024 11:21:53 -0800 (PST)
Message-ID: <ba0548c4-d47c-4bf0-8f27-1f753b41b603@linaro.org>
Date: Sat, 17 Feb 2024 09:21:50 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 10/10] tests/bench: Add bufferiszero-bench
Content-Language: en-US
To: Alexander Monakov <amonakov@ispras.ru>
Cc: qemu-devel@nongnu.org, mmromanov@ispras.ru
References: <20240217003918.52229-1-richard.henderson@linaro.org>
 <20240217003918.52229-11-richard.henderson@linaro.org>
 <2abd887c-c99c-437c-f0bc-e06f3a13fd33@ispras.ru>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <2abd887c-c99c-437c-f0bc-e06f3a13fd33@ispras.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 2/16/24 23:49, Alexander Monakov wrote:
> 
> On Fri, 16 Feb 2024, Richard Henderson wrote:
> 
>> Benchmark each acceleration function vs an aligned buffer of zeros.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>> +
>> +static void test(const void *opaque)
>> +{
>> +    size_t len = 64 * KiB;
> 
> This exceeds L1 cache capacity, so the performance ceiling of L2 cache
> throughput is easier to hit with a suboptimal implementation. It also
> seems to vastly exceed typical buffer sizes in Qemu.
> 
> When preparing the patch we mostly tested at 8 KiB. The size decides
> whether the branch exiting the loop becomes perfectly predictable in
> the microbenchmark, e.g. at 128 bytes per iteration it exits on the
> 63'rd iteration, which Intel predictors cannot track, so we get
> one mispredict per call.
> 
> (so perhaps smaller sizes like 2 or 4 KiB are better)

Fair.  I've adjusted to loop over 1, 4, 16, 64 KiB.

# Start of bufferiszero tests
# buffer_is_zero #0: 1KB 49227.29 MB/sec
# buffer_is_zero #0: 4KB 137461.28 MB/sec
# buffer_is_zero #0: 16KB 224220.41 MB/sec
# buffer_is_zero #0: 64KB 142461.00 MB/sec
# buffer_is_zero #1: 1KB 45423.59 MB/sec
# buffer_is_zero #1: 4KB 91409.69 MB/sec
# buffer_is_zero #1: 16KB 123819.94 MB/sec
# buffer_is_zero #1: 64KB 71173.75 MB/sec
# buffer_is_zero #2: 1KB 35465.03 MB/sec
# buffer_is_zero #2: 4KB 56110.46 MB/sec
# buffer_is_zero #2: 16KB 68852.28 MB/sec
# buffer_is_zero #2: 64KB 39043.80 MB/sec


r~

