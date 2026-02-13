Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E188EF99C5
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 18:38:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqy3D-0002hA-2U; Fri, 13 Feb 2026 13:37:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vqy3B-0002gm-6o
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 13:37:57 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vqy39-0001Ti-Lr
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 13:37:56 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2aad9b03745so6472715ad.0
 for <qemu-devel@nongnu.org>; Fri, 13 Feb 2026 10:37:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771007874; x=1771612674; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=R4fqLm3wB6WLIRUTDAfDHLIq8ohv18bj70Glhmn3kYc=;
 b=Vduhat7oybniwlvn8QbMIV/AmI1DEmOGlb/qZw/qFtOlVLgd0LxheavzgsXyNhI749
 B6EhNwCJyM3CtV7ltN748Ryc6DaCHqd2l3P3jWG68pTkF3hE6B4P9yIPTZImdHpvXMXI
 +W+rcHhoiBbkDdcUqGVguvxByd0f0ZaGrNa4pHNuil6VWbqxY13QgL8XpIOG98xry4Vd
 fwiXDGypi4/UnYtB/O2ettfPKDGov9z93q5h5AqY7B7tPBpJt7+dMeQsSJp41QUUCbNV
 6E2y10h1rIyIl8q6m+c89B4x8DArxKu44dYZnSL/W986OBMe7UcvtEnQGiR6gRN0S4DE
 g08A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771007874; x=1771612674;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=R4fqLm3wB6WLIRUTDAfDHLIq8ohv18bj70Glhmn3kYc=;
 b=OFtGTvDbgvF7WDRfDyNKNem2dmRRjD1VtuN5El0raoa/uwmjkT0ffM36S9D2bGhNZ5
 YycWI+qmlCKvd8isLislgf2it/Z5NoELO4bVzB2A5iYHRcIBRYIuqzqSumekBTWhPHuA
 fndcyaewnB60B9STrsoW7vQJsOitrLuRUVcwjjkr/qNyJpV197YqzNdo+u7pOZ/ZR5B+
 aBsKOYe/LXctRAy/xix9OSwTq4KhvLZ9BS1Jbvm/Nfz3sHdD1o9rtrtMRhTYcaXVxw8r
 VYvXW5jVk5FrEohwyoYRj+kI0qYyNkvXKQrHfIrjvhnbWsZkz3RAu0zhDrH3MaHT5DgF
 tf7w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJjkS4hXcbLQD+UEUttmmHLoMT78FDmVXQ5XhSszL7P7fYs5i9jXH3KOzZgwamsJOyEQ6fUQ5VP8qK@nongnu.org
X-Gm-Message-State: AOJu0YwHMzL2QiyFMPoZJmxDyj3v4Zx14Kjhz5/Wh0UELCbAx/tEB+hF
 ceugLExl9LEx5TbdYQrPKqDXR7C7P1izpOyYNHDAsozF6fOMIjqEMM9Sz+9vgaiWjRc=
X-Gm-Gg: AZuq6aKFvp+HtAMC1J1g1s5LKblQTnB2GFphg1GANtEhMOrAVQFGj4pLmD847axfzJe
 zy7nh+wRtLQXzRVtzkOtiCzQfiDbjtQyDFjNSrU+MwpXSjZUzT7MeirrpTTn7V03PtUVMqhmHeL
 n6x92D9NrfJwY1N2NTow4BBt3DJWXqy0GD9f1ERFNEs4K516VbV63K/EZu5UmVMZHQ8BctuZ2yy
 FarRO90jBaKVL125mOf+Z85soUJMUfyUyPZuH4swlVh9siysvnHFAEZRkaXlGfDmKi/X5gbtC0G
 3a21cGBsqVAw68qydKkuspnN1Nn6MaDquuI8JI+YaWDBmnPCoShVnyA/12v0rW7s3/0uT5qlyOh
 jxvsAwyALpTGvSBe/orK2NOIOH67gSlcUxlUI1IOZuAn2w0z+gA0SJlvX1XoyahqHoFNnJPqcWD
 xm7lsT3HJ821/wE9H+KKIE1wJKEdPefzKVB0MS0RHRU8+ovI6ie6qgazROXQDs4SgrCGYV
X-Received: by 2002:a17:902:d484:b0:2a0:c92e:a378 with SMTP id
 d9443c01a7336-2ac97426f62mr10227155ad.7.1771007874098; 
 Fri, 13 Feb 2026 10:37:54 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ab2997ac92sm86159805ad.69.2026.02.13.10.37.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Feb 2026 10:37:53 -0800 (PST)
Message-ID: <e0edcf60-c331-4856-80ad-6394b1d5ab96@linaro.org>
Date: Fri, 13 Feb 2026 10:37:53 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] qemu/target_info: Add target_page_bits_vary() helper
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20260213182713.44924-1-philmd@linaro.org>
 <20260213182713.44924-2-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260213182713.44924-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x636.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 2/13/26 10:27 AM, Philippe Mathieu-Daudé wrote:
> Add a helper returning whether a target support variable
> page sizes (only ARM targets so far).
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/qemu/target-info-impl.h   | 2 ++
>   include/qemu/target-info.h        | 7 +++++++
>   configs/targets/aarch64-softmmu.c | 1 +
>   configs/targets/arm-softmmu.c     | 1 +
>   target-info-stub.c                | 5 +++++
>   target-info.c                     | 5 +++++
>   6 files changed, 21 insertions(+)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

