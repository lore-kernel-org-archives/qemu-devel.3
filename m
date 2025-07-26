Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7705BC87FCE
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Jul 2025 01:18:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufTXc-0007MP-0W; Fri, 25 Jul 2025 21:17:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ufTX6-00079X-VE
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 21:17:06 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ufTX4-0006qp-Uk
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 21:17:04 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-7600271f3e9so2443486b3a.0
 for <qemu-devel@nongnu.org>; Fri, 25 Jul 2025 18:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753492621; x=1754097421; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9ejGuEgT/fVxSnG98nwZxYJh7UrCzWphAHkA4+BEC1s=;
 b=IqS+8kciHdMB5ST2XCP/WKX7TSYQLH/v17lsnHV6m1IPd1hhXaB7GDF1+Uug+S9HMB
 ftLCRggm8Xf6UMFTZyVO19wi5GjFoRS6nIaMCDba7tx+D7Wh6pT4q0zw07yrqko2yi4i
 ceERp7gJwCNR0rCTN+UFunj2x51z0oocjgqqpd3EKu1JgnN/FDSHFkJPucWmtRAja3Al
 xfufv8lpUMtTePBkM2//ctbK34mROMpHod1HL0ZHCKve/bxWdJJzB5mZa8KPo0qkFQPB
 qbmNBhL60FVBXTtfDLMP3nsodscIZUx4cRqLkq/NnXaynRd1ZMsrazzCQ40XleXC6cAO
 MItQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753492621; x=1754097421;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9ejGuEgT/fVxSnG98nwZxYJh7UrCzWphAHkA4+BEC1s=;
 b=Fjxok7vCyl3UMkFJqR/hCIoNkfVp/JIBakUdNDlxjF4TmQJlYBNS4qgbDojX1AQixB
 jjIgUNBrZHKHbTYkO6vJLiPN/Ir2CjvQn9NYIAp2BjA5JoTa97Cf/6lyqL34trJDscCz
 q3cg+DGzLME91HiK/+kJGxSL93V4KvztRv18TbTHNDZiZv5qJjog0/X9XzTcy8p+WBvM
 rgoHtX1/UxxzSzzSTApBohR2ujkQ2RzsdIjK+JqzQP2l7vRnyg+NjYwtNIfgXN+afzp7
 e1sCXsO7do2kPjb8GilvkKTZY9DIDqqqSCXtolYXSS7MmTuVG1LXkCl0IaH2VcJdAT7f
 d/Xg==
X-Gm-Message-State: AOJu0Yy761tZ+7A4a4b1wFbqtQkD+QMQJubea/gnTfVC2PJUJFFJ8ob5
 lEx/n0P0UpZ1dvppGqWYnZ/4rjqZNE6BMYbsvwtNhpeO8rajptchz8dnYZ2MfeL9Wwd2zMjhfoV
 SRLtt
X-Gm-Gg: ASbGnctTIssO5scnV/hBzyi7ujCgEdbDfQC20ipcUWt0xOzdGA9VLm/6sHOQl3Q44oK
 oGiDztEjXnnt7d2n1noXU6OHZXwn3jjGJSIrHK87nRrfivNEFMCKZNeT/gwvChnj/aU5v8syn6R
 RWg3Cr2wSox5qt52XOyoUb0QmqeIEEpyweibJHarzUXdFnSYjvqE1rYszUcuZSklFlprCxeoZUp
 Wo7a0FUORTKRL24UMjGYEPDEMrd0w43TW/NLgbfT5SPEERNP5n4qM7Vo6z+FqU6OoUkBdhioyFx
 VNvLffXpBTIW9ugwF1sd7xKRENuvAKj+Inx8pW0EeQsaPYMPEMqcg3v4hMrHFRXMWH+VKH3vuQW
 7O0hEvu7vBUgWpdLmceof5eN7x8QZe3nvbPk0q1NLZz7IDwXtP/KqS6VWFL7qrCONdrayuW7S6v
 GlRA==
X-Google-Smtp-Source: AGHT+IEAbyrGMxN5W/oizPMI5xPCToNjPlpa7lwVF4ZE8+l+BZzAMRooz3yXMSa6x6jLT2pIXdPQDw==
X-Received: by 2002:a05:6a20:244e:b0:234:21aa:b538 with SMTP id
 adf61e73a8af0-23d6df76501mr6771558637.1.1753492620784; 
 Fri, 25 Jul 2025 18:17:00 -0700 (PDT)
Received: from [192.168.4.112] (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-76411ecc8acsm603321b3a.40.2025.07.25.18.16.59
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Jul 2025 18:17:00 -0700 (PDT)
Message-ID: <97316cdc-03c6-4f7f-aab9-d1064dcb77a7@linaro.org>
Date: Fri, 25 Jul 2025 15:16:57 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/17] target/loongarch: Add header file cpu-mmu.h
To: qemu-devel@nongnu.org
References: <20250725013739.994437-1-maobibo@loongson.cn>
 <20250725013739.994437-5-maobibo@loongson.cn>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250725013739.994437-5-maobibo@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
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

On 7/24/25 15:37, Bibo Mao wrote:
> +enum {
> +    TLBRET_MATCH = 0,
> +    TLBRET_BADADDR = 1,
> +    TLBRET_NOMATCH = 2,
> +    TLBRET_INVALID = 3,
> +    TLBRET_DIRTY = 4,
> +    TLBRET_RI = 5,
> +    TLBRET_XI = 6,
> +    TLBRET_PE = 7,
> +};

For a follow-up patch, name this enumeration and use it instead of 'int'.
It would make it self-documenting what a function is computing.


r~

