Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C845DCAC5A5
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 23:58:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1Cte-0002WV-Kt; Tue, 23 Sep 2025 19:58:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v1Ctd-0002Vu-59
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 19:58:09 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v1Ctb-0002Qo-1X
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 19:58:08 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-77f198bd8eeso2739554b3a.3
 for <qemu-devel@nongnu.org>; Tue, 23 Sep 2025 16:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758671885; x=1759276685; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ohYkDz3ePYZGBAisxRgaxuKZJqcSul3RB+ZPtKB6yYc=;
 b=Kp+zBSXrtzEGIERgMrJDDxWkpVREEN2OazDOOG/iAYsoXbXVS7wESo+9d/5x1nwVLz
 6t0zPkfmMSq26MlyKlC7IcEGbDdHu5L9GuRZqhzkrj98x9MlQ9VTCni1hK3v4Gt4VdbA
 2XVcOuQ9HFZ92juKJ6dqdLo80PDH54H4KGOm1SkqTtZMQMWP72j4WRLA0ZAlWPtwQWkx
 X+SV7gSCXilh5JYIIfWDoJSmp7hJwab110rPWctT9rIZc7FOxSauIGgLTg+bjSSb49LW
 j5ofdyRHqeloM7koYgISKIagt38BNOts33dooT0QX8n3xxRCt75oGVmnJK8PxYYAK8Jz
 /i6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758671885; x=1759276685;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ohYkDz3ePYZGBAisxRgaxuKZJqcSul3RB+ZPtKB6yYc=;
 b=umnJ/So/zzCQSZiwNzzkHkYdQsz4KnSJIXxNOu07o2sbMwUPs9pqjRD/SDuy6C+sOp
 XEDSKhrv8huIBzcJdZcF9TtHHVTCDcZAfxQxS3VJPjudWSG7blO8MXrYGQdIj472sJQW
 dI4HLRIzE4k6sqj154zZABsh816EmYNB7FVc44EeRJIfed3Ml2WOVkZpzqfbHMhN5HfN
 FUIvpEJ8gzwvAHHwY9GhgqiZuSPqJ2599cahHTKLVOieCKNoAq8NcFqfd3VP4qtafKPH
 lboJrm/NlkWIxRm5sSoapJgf09+UIA3RoPDhK1gcXDQFOdDgkHJiO/JqnN692LVqIlx8
 1ZXg==
X-Gm-Message-State: AOJu0YxtwbdjJSI1igUXihVZ3rd72bVGV7mROFsf70otfeS8Yid3kwKB
 kOhEfMjZig8s0AftFzvaiIoPitKJzBKKDr1aTzSYdxJnTvG2p+poN4/uZgRXD5OdXH7noHK8gtX
 h+3Sw
X-Gm-Gg: ASbGncuRmeJI+G13n7IOd3d4pol6BvfcVP36IKPTwuZuVGm1ERVlicPR7GhGMOf3B4C
 9YQlUP66eSRUulgM6pgWBf4QT39ReDEiayhSwrvG8fI++VAbnIEW/j9UNRe8vIAVqGu3QOagj8z
 Ayh8l/TZ7YHXHVBN4+nuH9S5BDD3bxr6k/Zd+Qg9rMf+S1yxMMXdLaGYHFW9btn/ecoj7hOIdxi
 2fo6a2KZLwLfAv7kvW10/4zH0aC8ukMFuv/B7OIjKfIybQOzFDZIJc7n1e1ZY+R9TxjDnXKEm6Y
 chWU0QC5mUqAHNOWfdviDTRATF9GH0bKmDCtda27oJG7wMFKhz+x92msoF7DdwITUNlK3LXYcmS
 ldgUXO7v2CfXYmuBIsY/fkzKpGJQXz5yTHne9
X-Google-Smtp-Source: AGHT+IHhU/WZzi9es2uLhUoHWYlPI2f7LvkuJY7ALiLiJUbFKGN6fVQFi6wfsUxa6yIYuZb0jCdAPg==
X-Received: by 2002:a05:6a00:a1f:b0:77f:3a99:77b1 with SMTP id
 d2e1a72fcca58-77f538c0394mr4827880b3a.9.1758671884893; 
 Tue, 23 Sep 2025 16:58:04 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-77f68e38c44sm325036b3a.25.2025.09.23.16.58.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Sep 2025 16:58:04 -0700 (PDT)
Message-ID: <ecb5a63b-dec4-440e-9e55-570c8bcd4b5a@linaro.org>
Date: Tue, 23 Sep 2025 16:58:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/76] target/arm: Implement FEAT_GCS
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20250922184924.2754205-1-richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250922184924.2754205-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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

On 9/22/25 11:48, Richard Henderson wrote:
> Based-on: 20250916142238.664316-1-richard.henderson@linaro.org
> ("[PATCH v2 00/36] target/arm: Reorg VHE redirection")
> 
> Changes from v4:
>    - Master now includes FEAT_ATS1A.
>    - Rebase on VHE reorg
>      - Trivial adjustments to S1PIE and GCS regs for REG12 redirect.
>      - Simplifies EXLOCK access test.
>    - Migration fixes based on review.
> 
> Note that tests/functional/aarch64/test_rme_* will fail.
> The TF-A images need updating again for at least FEAT_S1PIE
> (EL1 accessing PIRE0_EL1 trapping to EL3 is the fatal fault).
> 
> I'm toying with updating the QEMU build to match the FVP build,
> so that all features are runtime enabled.
> 
> 
> r~
> 
> 
> Richard Henderson (76):
...>    include/hw/core/cpu: Introduce MMUIdxMap
>    include/hw/core/cpu: Introduce cpu_tlb_fast
>    include/hw/core/cpu: Invert the indexing into CPUTLBDescFast
>    target/hppa: Adjust mmu indexes to begin with 0

I'm cherry-picking these 4 into tcg-next.


r~

