Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 749E4E77198
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 09:06:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tV5X4-0001La-Hc; Tue, 07 Jan 2025 04:05:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tV5X0-0001KH-O8
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 04:05:47 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tV5Wz-0002oc-2v
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 04:05:46 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-38637614567so6929187f8f.3
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2025 01:05:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736240742; x=1736845542; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MDcW+xfLTJD/IB8Pbtb5vwtl2Z1T3HvRUsMWCOo7VOg=;
 b=YsxIGwt0FUjM8Ngmg9lD27DJBR4wlGC1ZGT2/w2a/JdZb8l2YJc2//1koAB0wiK7i0
 y5veJTx5Yhvmj35M5/FhPt1mYkilhIiDwBcDxZl4iKQze1VO2dlk99vJ80rvzrVHoHz7
 pWdhpF8SH+8x7v5OBqS4mKu9SByqV6wzK88gxgHddJVrFqN3rrRUIfrJ1iFDWQ5vYxsJ
 LoE9AOk4ySSbLopNu0i4cTIeNiEv2OHEVZQrplQoeNkBssuvMP+bvAAmN0I3fcITdrma
 iIKB3+JI7VFW2YyqQUMN3axgtQDG9rSfa2+Bk3SwxqIdLba5s/2BIxYuQkc+fZS2d9xv
 75Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736240742; x=1736845542;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MDcW+xfLTJD/IB8Pbtb5vwtl2Z1T3HvRUsMWCOo7VOg=;
 b=kWXfUZgTlH9TGqpl3mKAdcrWbN2/seqhUFElrG8J2+JuRduZlPoe6+X1LT5Om8Gocr
 ryey+JmCXU0sfKv7w0cyzOniBUekmHD7BBofKm9qXQ4jadoahH7Tb4mNuHN6erCZSO7D
 tetF6kyvNFM0YYmBaiZQ6BrbS+o9Js1YRGXDa/nwXxeTnnafMVZPRc/3/HhHOSsT5ZRr
 YxmyIZFddeMC0NmKFaV4oNNkMJI+7wv4eSydvLC89L2af8J2nMXKEX1KG/j/PgIA5dMG
 zm7RJ7l8lzyxa2Fpq5u2BkTnxRULaOmiu0jOp65S+vtH6HfvsO6OFtH+DAlL9CXfCGCi
 pCbg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWSlDisJoCpBz+KAOUTvEDpB5YfRFxySftF5wzT1YPKRGtQ2r5Hg8JNSXFTBcdCjqmLO19FIlNJL2tR@nongnu.org
X-Gm-Message-State: AOJu0Yyw8blJVXYw261qd/Oqe/wuIsJORYSpTqSGK3FOZRSBf1UB2Kt5
 KT5s0hCQexHvnvDapGWNL0uHUZaVMgU35DTxdr96tLJt9no0hF86HTs3rAMaUYc=
X-Gm-Gg: ASbGnct6W+PTo5bUPkrjQ0ZjueWs6jnp+2QEIgKB/bFxDg/S9aIIDmARLRrMG41XCyA
 HA4NjzL8m+8YzXhEODcU57NDXG4Vgpmjs0YZgKX9I8ZtCGUB0K9dvuJQOYA2hIyVOj0SPvi9E3Y
 LDj8BKAYpMvV8dLdHp0ZWR5Zmi59JypURepiNHI+c3JYx20nETZwPjQmbSjBF1B5KOShCoHkeiL
 GGsN6hyVo9ZHkRJbpJGT9Q9goeA6CoEEn0MMhJEjFpIUsSGlHJsl3ChUE7jBrJv4qnD4VZYclm/
 n9uCgsKjzoASZLnUhlIibhS1
X-Google-Smtp-Source: AGHT+IEf97TXzXfI5yE+aYcsMW5+AS94RPd/lJIJokCWAI8O70UbC4qsCs5OHNd19wrJ/09bWADCVA==
X-Received: by 2002:a05:6000:2a1:b0:385:f060:b7fc with SMTP id
 ffacd0b85a97d-38a221fee1amr49885812f8f.25.1736240742278; 
 Tue, 07 Jan 2025 01:05:42 -0800 (PST)
Received: from [192.168.69.132] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4367086e40esm557878575e9.30.2025.01.07.01.05.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jan 2025 01:05:41 -0800 (PST)
Message-ID: <a856d994-e6ca-4737-bd66-323c60a7d898@linaro.org>
Date: Tue, 7 Jan 2025 10:05:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] util/cpuinfo-riscv: Detect Zbs
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, Alistair.Francis@wdc.com
References: <20250102181601.1421059-1-richard.henderson@linaro.org>
 <20250102181601.1421059-2-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250102181601.1421059-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 2/1/25 19:16, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   host/include/riscv/host/cpuinfo.h |  5 +++--
>   util/cpuinfo-riscv.c              | 18 ++++++++++++++++--
>   2 files changed, 19 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


