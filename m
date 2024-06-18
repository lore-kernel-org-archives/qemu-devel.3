Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A88AC27C4F
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 11:50:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJXLR-00078O-Sp; Tue, 18 Jun 2024 07:49:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJXLR-00078A-3q
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 07:49:49 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJXLP-0003YW-02
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 07:49:48 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-42281d8cd2dso37902055e9.3
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2024 04:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718711379; x=1719316179; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qwKD4AYkKNV/E6R1fSCmxpGNfT3bdl7hy82Ei5Zkg/4=;
 b=La/d3W/OMl/b8PvXjx33ONKcTIlwlJEe196MHfzx/E25m9loOSH8waR7shjhg5Tazn
 mNAJXRECuzrjBd0ovQ1PkKQQ+yae5xMfD3KWVZWW8vPj+f3uQmF/AvSEEjQxZKBlhEUW
 ju834e11NH9XPkOS+AoAbFjUe6ud32lzymU2M50zVHsZLu5KuDNKYotmHDHhPtGIRmfS
 h/NfhRH2K/7TlP5fJjVUzLBtH3QES2YMRJEeVQktmiXKIX+iKSbQG/UX8EN3RRQ+n5PK
 WJKjAUr/SPlnNkDBbCAc3/QPdkhyGdrbhmerMfsHMM8Erhflo1SgByDwxHSJzD0Yo7qN
 MoFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718711379; x=1719316179;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qwKD4AYkKNV/E6R1fSCmxpGNfT3bdl7hy82Ei5Zkg/4=;
 b=i4Ke7Kfzko9aVVqzUQthjfMIPdU0LnFxRzb4wDlPYnCEo7c9X5uM9+MFQyQuW+P12r
 jygzc1DDcG2MCTOmPLllxywy0M9tbjkGj3hUqjpJh85y2vVAXzoCzuSs3KBKzDvN0lxs
 /yODr+q4tW2vMlDpdvnItW5eyN1XxQdr1ax9LO7LHx6BUzEWvxIR+wMIB8dBb8HKaOj7
 Eq9Y+Cyd76bDka4yyn7qYdJuoNEpeuhGv/zWdQVWsc0S9RK69mk48kdhK7nrfDJfe8t2
 T8NsRdyXM8NcTF8bSwhCA58j2FfPeYMrP4gIrCgcCIm/QtNgyYiuySptNovlia1AQYkm
 rY5A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVT3YiYN3h7B1AQ3K19UmzX/bFq7VJjWlh9ftjSWKYmJgeYWb8JzaonavBKwhBg8sKlEuFOEGYbASbnTSQkYk6Bea9AkFY=
X-Gm-Message-State: AOJu0YwnNNKKxMsldS/NXFsh34g4wNXX+BBB9WYbyJDBXf2O1s95tU/V
 eVeEWQBX07Q4U5OCpX2ZO66/7gl/puVnZa8hhv1D5ZH9VNn/RSCldM/GA5fJFKc=
X-Google-Smtp-Source: AGHT+IF25Rbr0zgIR0FmHTbl/5SPTGI21BjDz/4P+4ac0CaZxS/i4HGC/ZSb87q0g2Wx8aYiRyzclg==
X-Received: by 2002:a05:600c:1f95:b0:421:819c:5d76 with SMTP id
 5b1f17b1804b1-42304823b14mr97015265e9.9.1718711378938; 
 Tue, 18 Jun 2024 04:49:38 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.212.55])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-422f6127c6fsm186533025e9.24.2024.06.18.04.49.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Jun 2024 04:49:38 -0700 (PDT)
Message-ID: <23f7dc0e-2032-4782-89d8-130ad2e334a7@linaro.org>
Date: Tue, 18 Jun 2024 13:49:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/4] hw/mips/loongson3_virt: Implement IPI support
To: Jiaxun Yang <jiaxun.yang@flygoat.com>, QEMU devel <qemu-devel@nongnu.org>
Cc: Huacai Chen <chenhuacai@kernel.org>, Song Gao <gaosong@loongson.cn>
References: <20240605-loongson3-ipi-v3-0-ddd2c0e03fa3@flygoat.com>
 <cb6f844c-1b63-423a-a821-03d9f0e4b9f5@app.fastmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <cb6f844c-1b63-423a-a821-03d9f0e4b9f5@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

On 12/6/24 14:09, Jiaxun Yang wrote:
> 在2024年6月5日六月 上午3:15，Jiaxun Yang写道：
>> Hi all,
>>
>> This series enabled IPI support for loongson3 virt board, loosely
>> based on my previous work[1].
>> It generalized loongarch_ipi device to share among both loongarch
>> and MIPS machines.
>>
>> Thanks
> 
> A genttle ping :-)

Series queued, thanks!

>> ---
>> Jiaxun Yang (4):
>>        hw/intc: Remove loongarch_ipi.c
>>        hw/intc/loongson_ipi: Provide per core MMIO address spaces
>>        hw/mips/loongson3_virt: Wire up loongson_ipi device
>>        hw/intc/loongson_ipi: Replace ipi_getcpu with cpu_by_arch_id


