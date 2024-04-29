Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E1F8C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 12:32:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1QAX-0001tB-Px; Mon, 29 Apr 2024 08:31:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s1QAN-0001sf-LL
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 08:31:31 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s1QAJ-0002t4-Ni
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 08:31:29 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-6f3f6aa1437so1133232b3a.3
 for <qemu-devel@nongnu.org>; Mon, 29 Apr 2024 05:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714393886; x=1714998686; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+Q3Tc43IPIJv5dgze7w7SFGQ7PbkQK3NILa0QzinepU=;
 b=SRKeHpCNakcavg8VuZZqHcVNdjcNuL+Q584LI4pHMgh23hm37Gn3z2dC/jzXfVx77a
 6bkgovfwLiIq+qUVaKEj6vIyRarikdXMb9s+x0lIjDEchYmdQ38BH1TKp6iobUBN0OTC
 dViIoamPDNGG3T+bVbcdgtIQog9d00d6j91UKxp0enF6ymCVtqJ1uVFj8Pec2aBYaMQn
 j73DKLZYSqipS6I5/EbHFTjeLn24UsTOqK71/iFAInpCafS4DSC7KFwarr3RassZSuPo
 hahP1RDHL2zCAV6Qtko5PCKFyoFXs2Y+A6mqa38d6ZEL1mRrXnd6kV7dwMLnlcobKCu0
 t+3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714393886; x=1714998686;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+Q3Tc43IPIJv5dgze7w7SFGQ7PbkQK3NILa0QzinepU=;
 b=tFvikcUtFxgMJVzAUmkCcjy2L68/OjCv9Mt6p2j9YrQHK5Izq+4rqlUug8YmddzWKR
 nA00aZsrTWr+KdIgwMYqdaW0Sr+n06trMJK8cWqW68hMEZFWh9bCwQoZF5/dvCr6k+y7
 oanldq3G0RsdewutT/avw3wKUpIW3u4axzLNlJJnun9ITHlUIZrYjShR73id/nQ9md7i
 Ml1yDQZlSmXrwXOlaLErBTdk6I/fzUfuE3c2vk38KAFKNvbpzzBDGb29crRj+Jk2JJnD
 kxhkEPWa9q7VH89eCxvzxOVdoL4jFNyw1N+gCaVup+zYd0Md4UzvB40Iqlq42Ord+p+W
 LOyw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWuzhAIjg22vmRAjtYbwhyT1Vte7z/vzSufCZ7kP27Qp83U46CRydloh2YOFQUsog/VbC5NnYAlhjpKJ/dCu6WT6P9Vzs4=
X-Gm-Message-State: AOJu0YwS4TVvKBtF6pJGd6GHDHd2aZqfSvi8xwT+tE9Pd+1LB1YqwOdi
 JU+wTxr7yzPvrjikDfIFH53v3bI8Uou/+oAkdorbzDMSCsG254TkA3lwBAtAUE4=
X-Google-Smtp-Source: AGHT+IGJ1FYSWhVWJ2SBcd4kC9CPFTH0Q2vXnajzNw3JyY1J9N8XC/VnnjfYagm4V9A/sA9IB6ctjw==
X-Received: by 2002:a17:902:9693:b0:1e8:ef23:80f6 with SMTP id
 n19-20020a170902969300b001e8ef2380f6mr9198813plp.37.1714393885830; 
 Mon, 29 Apr 2024 05:31:25 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 h8-20020a170902704800b001e868e29fabsm20147597plt.251.2024.04.29.05.31.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Apr 2024 05:31:25 -0700 (PDT)
Message-ID: <80f07930-e5e5-496b-ba08-6091ebe55c1e@linaro.org>
Date: Mon, 29 Apr 2024 05:31:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 06/10] util/bufferiszero: Improve scalar variant
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20240424225705.929812-1-richard.henderson@linaro.org>
 <20240424225705.929812-7-richard.henderson@linaro.org>
 <400f20e7-3c33-4916-897a-0d6b21d572c4@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <400f20e7-3c33-4916-897a-0d6b21d572c4@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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

On 4/29/24 05:18, Philippe Mathieu-Daudé wrote:
>> +
>> +    t = ldq_he_p(buf) | ldq_he_p(buf + len - 8);
> 
> Here we read #0 and #31, ...
> 
>> +    p = QEMU_ALIGN_PTR_DOWN(buf + 8, 8);
>> +    e = QEMU_ALIGN_PTR_DOWN(buf + len - 1, 8);
>> +
>> +    /* Read 0 to 31 aligned words from the middle. */
> 
> ... so here is #1 to #30?

Not indexes, but count.  There may be zero words remaining in the middle, etc.


r~

