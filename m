Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40683CD3442
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 17:09:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wL2DB-0004FI-Ei; Thu, 07 May 2026 13:08:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wL2D9-00049x-Ow
 for qemu-devel@nongnu.org; Thu, 07 May 2026 13:08:31 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wL2D8-0006aa-73
 for qemu-devel@nongnu.org; Thu, 07 May 2026 13:08:31 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-44dd5cb0f81so1478688f8f.0
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 10:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778173708; x=1778778508; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SdMrkVJEIZJ6EdDgoIypD03wlpP3cwo1NorXgd8KTdc=;
 b=A5JbgcdIzMzU5PAnb/j1KRVqT7UWnLe9bE9T44mXDe2jIE8YH2hgoe+BCmaRKUA5Px
 vo+pDVj2YrLq7zIP2dkxZ+IrGREsC8UuphEhH/8IEfl2FIx465nAmG9snh3prZb0xiAz
 7qo1yCmK39YbxPqdrAn8nBgDkJTWMixCu4W1TbvbgPvT4H2+c7i/dIJlJNg7v3mAxesP
 3MALg5pF4252jA/ZEXqolsiIHhhWwllmir4/kdY3XkC6Y1P5Y7Qt01HwoC936Rsa6liO
 mFis4qxyYQ7H6LOKshIjAz/24Y2Jc2X3Hwt9lkx9d/+yuxIObXg7A1ugI05ql1D/43TH
 UsMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778173708; x=1778778508;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SdMrkVJEIZJ6EdDgoIypD03wlpP3cwo1NorXgd8KTdc=;
 b=Qo9lGpObgKpB9siP8jU41HYL7ZnS+CugIhlCnHrZr5xh08XyXYoGQ94Y/c5FVmWD0U
 2F9HYNqMpFDrljLBixe4+gWuVB+gfakEUYHv0TbAiKjPRtUpcI5C+6uRrUg95aRmZ2Xo
 19IEJ5X6bbflUqSt0UCfs86+U5SuSbaCKI9u7TOuvPOQ8Q78Ez/kBxwlXMbkAgPEvjsN
 Sbunza27RqQFIoyomnduFWLapoihDo8pjaRJNm5AhK9F6r9vywYLFywsZB5tOSJ6uwMa
 OkCRkhvsnAwTJMqHKV1Er/GBfE0vN3F3YZ469X2ZsNBSYtftKnXSU0DlMN67/tJdn722
 1StQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9tY2EEtaC5qwObaCPb4ydXBaytPXFhdJt7GkvZfFGU91vP/lT2hVaO0NXgO2TrnBYIbUNa3DfaPmlw@nongnu.org
X-Gm-Message-State: AOJu0YzpEpJqjd1uuj4J6B3WxlTrHb2j78pHZoYNaQEC+I2hW9SMDzlj
 PD0B/XWEpht9nwklBpsBjc13g2A5Zzl6gXiTrdLhtk2AmDWmu8jBuosqkiitEBiyb2A=
X-Gm-Gg: AeBDieuHEuzcgAKmzEyEI+tdCcsKq28NnhXrWeydqMEOng/MJSTt5DBwY2JKmt/Eav3
 sAKUR8EesMQvhi5/Ei3ewgeLyk8fV9/FoC7EUyx6VciLmpCCzHg89r0WOx8+6XIp1FIq/z5Xslu
 Ti1ldBtKdwGzitqBLFIv9oDgwkPUIzbs9benb7Ul61RWXx/DOiy93yWxq4xN3bUVRYVN/7KJg3n
 uB7hOyolKX5tCm9Sn1Cqa4QVQ9k+cmathtqY+ufcgH59KccTvaccB5g6xxej9XB6jUaYlWjeDtJ
 b3jjC7iWb9s0aGoFNb4r8Mjoysg+pQP4Ah9mU4r8+V8j2UjrMnnpOPTUpv7KcrVbXqd4kO6TBf3
 alicXjKxL/iQImqfist0/v5ilzN4JANQcZKhsMittmIh/17xbanx2SHMrBBf+RgBlVvcgbZvJkk
 O2+jTWYJl+x38oXvBWsIiHYGX95a2gstdL/MymAOoHqQz4MebTYvN3lJIcIf5r9vq24PmOfmJeD
 /GG
X-Received: by 2002:a05:6000:161a:b0:452:4f17:a514 with SMTP id
 ffacd0b85a97d-452e96d5335mr4431660f8f.16.1778173708336; 
 Thu, 07 May 2026 10:08:28 -0700 (PDT)
Received: from [192.168.69.200] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45412820303sm505249f8f.4.2026.05.07.10.08.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 May 2026 10:08:27 -0700 (PDT)
Message-ID: <1d588a70-a029-45a7-84cd-273caa460535@linaro.org>
Date: Thu, 7 May 2026 19:08:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/25] Handle sub-page granularity in
 cpu_memory_rw_debug()
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Mahmoud Mandour
 <ma.mandourr@gmail.com>, Peter Xu <peterx@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Chinmay Rath <rathc@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 David Hildenbrand <david@kernel.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>
References: <20260430093810.2762539-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260430093810.2762539-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

> Peter Maydell (25):
>    hw/i386/vapic: Cope with non-page-aligned return from
>      cpu_get_phys_page_debug()
>    target/riscv: Make get_phys_page_debug handle non-page-aligned addrs
>    target/alpha: Make get_phys_page_debug handle non-page-aligned addrs
>    target/microblaze: Make get_phys_page_attrs_debug handle
>      non-page-aligned addrs
>    target/sparc: Make get_phys_page_debug handle non-page-aligned addrs
>    target/x86: Make get_phys_page_attrs_debug handle non-page-aligned
>      addrs
>    target/s390x: Make get_phys_page_debug handle non-page-aligned addrs
>    target/ppc: Make get_phys_page_debug handle non-page-aligned addrs
>    target: Rename get_phys_page_debug to get_phys_addr_debug
>    target: Rename cpu_get_phys_page_{,attrs_}debug
>    hw/core: Update docs for get_phys_addr_{attrs_,}debug
>    target/arm: Rename arm_cpu_get_phys_page()
>    monitor: hmp_gva2gpa: Don't page-align cpu_get_phys_addr_debug() arg
>      and return
>    plugins/api.c: Trust cpu_get_phys_addr_debug() return address
>    hw/core: Implement new cpu_translate_for_debug()
>    hw/core: Implement cpu_get_phys_addr_attrs_debug() with
>      cpu_translate_for_debug()
>    target/arm: Implement translate_for_debug
>    system/physmem: Use translate_for_debug() in cpu_memory_rw_debug()
>    hw/i386/vapic.c: Use cpu_translate_for_debug()
>    target/sparc: Use cpu_translate_for_debug()
>    hw/xtensa: Use cpu_translate_for_debug()
>    target/xtensa/xtensa-semi: Use cpu_translate_for_debug()
>    monitor/hmp-cmds: Use cpu_translate_for_debug()
>    plugins/api.c: Use cpu_translate_for_debug()
>    Remove cpu_get_phys_addr_debug() and cpu_get_phys_addr_attrs_debug()

Series queued via hw-misc tree, thanks.

