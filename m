Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EB09C10F1A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 16:39:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4NpF-00050D-DD; Tue, 07 May 2024 12:37:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s4NpA-0004zn-Bk
 for qemu-devel@nongnu.org; Tue, 07 May 2024 12:37:53 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s4Np8-0000lO-S3
 for qemu-devel@nongnu.org; Tue, 07 May 2024 12:37:52 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-6f45f1179c3so2446990b3a.3
 for <qemu-devel@nongnu.org>; Tue, 07 May 2024 09:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715099869; x=1715704669; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=eQFv0Wk8ImgEuJCfsBO9z5d9CF5lfGgL9FMKJYIkGbs=;
 b=GHEr3/1rzAGHp3dNOROGZrWAbw3v4rrBvvvOyKkYmenJACbIVuJvvEgkW5Nt75IGzF
 rd2kWRqd1fhKAVBWJyUH/1XV6wJ7S3Gxewt7KrQ4Zyl7kdXKFsebFBl6+UacftM9otNr
 OzgAdl2ZY6RToQmCSaq8WwMncmkiRi9Vr2CTBnVtqPIo2U2Gm5qLGJnRmZMX048S2/hb
 iWeSdFECAhoL0nR2YMnX3/fxJ6koUlthWm5jgbX17CL4RMJmhhzFIRgktQmXcmkyCw5s
 Qv2rmVA5aEbwrVJFD+Lzua6HGh/HnYZVx9GD0xhir40qiwJ2pmqp1PM4+sZ66yd+40JU
 Ot1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715099869; x=1715704669;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eQFv0Wk8ImgEuJCfsBO9z5d9CF5lfGgL9FMKJYIkGbs=;
 b=lLF7gQspB7XLfL8kd31HHjWY9AKjxjAnkbYeSTao0Y84B7oj+aBCdGL92Bcpg7LjhX
 O8PzMUTJWR7Z47mpORD/t20kBQD0urnqf2VL2K9djEOs1gKl/78MPBV7vKmJy8ercZtW
 Q+hSWjp+g/4UPHBsi9+xg8dCUG8bVifQG3Hu1a3knLYNMxBvt11WqkrSYjSWsuGkiYbU
 7EY5/nXCheW7Plm9iDiwRR9omQdG59ZX42XzYOWUgCiDH37QqRNQaS8v01IxGKQbzlLZ
 Xtu8Dhmu4FcGAuiWU3r8DP25EeNluBQVO0iLjp4KC3/2WvYYf+108vpjq7v2MMpOXxqi
 0jZw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVg6TZ4XPibDV8k8KhsldXzdkQAR3oJ3vioJsFGF+EpIhai/A+d/TWt2zJFOxT8LbZUZjk5+dV/1xa5O4YQAdpTCWrdjVI=
X-Gm-Message-State: AOJu0Yx33ypGuONtLe/nzyDZGzXHmE/3UaR9IdmibCNfGgxcPvbYVAu6
 Ru/ZsZ6kwhKsDOtWksiNFDP/0iDGx7k5rNAGRzu9t/i0iIPMEAfcS7JNRTDniobCz5d3ltlUDpS
 L
X-Google-Smtp-Source: AGHT+IG6SLQusb+e1wGumPGFYWqq4OJ1inu4pKGhTe2NuSPvTFnOQR7y1oJmsvFZCsa84Ozxyf8B4g==
X-Received: by 2002:a05:6a20:1589:b0:1a3:d60f:738f with SMTP id
 adf61e73a8af0-1afc8d3ce9cmr227397637.18.1715099869202; 
 Tue, 07 May 2024 09:37:49 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 h7-20020a056a00230700b006f46bc0999fsm4926826pfh.155.2024.05.07.09.37.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 May 2024 09:37:48 -0700 (PDT)
Message-ID: <865d24bc-c89d-4743-9c80-75d9289f0ff9@linaro.org>
Date: Tue, 7 May 2024 09:37:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] system/physmem: Replace qemu_mutex_lock() calls with
 QEMU_LOCK_GUARD
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mattias Nissler <mnissler@rivosinc.com>, qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Peter Xu <peterx@redhat.com>,
 john.levon@nutanix.com, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
References: <20240507123025.93391-1-philmd@linaro.org>
 <20240507123025.93391-2-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240507123025.93391-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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

On 5/7/24 05:30, Philippe Mathieu-Daudé wrote:
> Simplify cpu_[un]register_map_client() and cpu_notify_map_clients()
> by replacing the pair of qemu_mutex_lock/qemu_mutex_unlock calls by
> the WITH_QEMU_LOCK_GUARD() macro.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   system/physmem.c | 9 +++------
>   1 file changed, 3 insertions(+), 6 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

