Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9580F99C95
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Apr 2026 22:29:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wEEAV-0004ss-6X; Sat, 18 Apr 2026 18:29:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wEEAT-0004rD-A1
 for qemu-devel@nongnu.org; Sat, 18 Apr 2026 18:29:37 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wEEAQ-0003uJ-JV
 for qemu-devel@nongnu.org; Sat, 18 Apr 2026 18:29:37 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-488b8efed61so18677305e9.1
 for <qemu-devel@nongnu.org>; Sat, 18 Apr 2026 15:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776551373; x=1777156173; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=I7n/2zBWju1wYJ9AKQZf6kE8OWa3AHp2i/hzpSAHj5U=;
 b=zbaCsD9titq7e+JvZ17UafxitvGVX58LPOpxigEG3pWfeFAQJfqY/h21K53wcKqhcM
 kBgV9MSupieSVu+c6SDnNga7P3s50kbTA0ma8zjrn4H6PIt3gXVq89Y2ovUtZtAtrs5t
 sNIc5zMayR9RZTFUaNJeqq+L6kmF6IY295NNAlkYhhAcJp+ACqqRGw/pGUPIlNXrdRmT
 tdI/pL5bfelwVXZqtchQ/8M4ip3oFkKYT7AMoBu/liupItt8lkZpS5ELdWQQlsr/BDNf
 1ubBBqV5In+MoUmVQAQ9eP6Ma41YWgIvQqzYzVdXA5r/aUP6F1yqafBodZK6qisC52V2
 5KIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776551373; x=1777156173;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=I7n/2zBWju1wYJ9AKQZf6kE8OWa3AHp2i/hzpSAHj5U=;
 b=bCCmwsh14awkmhG75G7NivrQu3gKhthnGpay+TZFVc1+gg/Cwg1QvhSL1ZjwPrxkea
 RW9xFLHVNnEgw/InsaH28Me8jmw+P2UDRbE5u4XzNU4XeuFFZiz2lLBS8PcH0376wRI0
 DOSOLxvMnmnOdsYongCcF5ZwMHq6CE6HsarmgZ58TYP23bPw5luQN0th9PbgVbEqkFD+
 l249nhmGn/sKIk0KJTAGTxyVPDlY0ZbF0CCxbWZQvgK2/tbBXisBGiXXuWOolVS/8K8r
 pOGWRzGJzOa5vPr9alRa4q8tkyaas26R4hihF8U0s6/c5SPUaegDlPiTtEO3AKqNgTf5
 a+Bw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+/3zpzwihaC8CbZ0BPQFwz8YhtJWv2PyR5SbGFo4Lp2exjMBzVcpZFymVzPD9I51ulgblB9+t3uIss@nongnu.org
X-Gm-Message-State: AOJu0Yx4Wz1Qgc89vOta4RQTuMoUw6ATb58vv7ds+7zEyRV4MoWxXyb7
 p23mG/CCGT7JXel/PUiZuUo3n4d1pWjuLfFVqeMhGBnXPgo4pC9HNTuscBjyi0zY7fE=
X-Gm-Gg: AeBDievPfSNrxniRkLIj2hZ8XWmXlCP8E4iiWhbJ7FuXO2z99UhB1ca45tQskDL5N9K
 JGqFDeTkdMTNrDnWx9qw6gvHipjoHPcRwhLdPtFK91wd3wCn3ylIEDWZz9oa/gHjGPjDetDy81+
 yvPWMg39s3ISegYVqmHKL4T4UfNbvDrqnOC/AdgMdaYVe4tAxNoAm+VkIY7FnSxhwKyQYJNQzMA
 yR8AJqpq3hP+Vs0lOGSebq+cfvgddACNMkvUUOkeGic6FYt4U7VMPvbomziZdHu2tK3ebpIfrsK
 IUrnYdv+zfdtobofhUfQ5qh/ohaB8uCAocyNQwZ1Sj5/g1Z41uFbz8TJYHTwy3/z0Q+/AyAdCiJ
 U8PROJZR235X+t5RRPLPwQ3lw+/m6NOk0N9deSwjVRKkdDwDSJ8TwvKUh36wW/0/I33+hTi3J2D
 a7gM2lTZnm96NP1mK4a8ZhcxkFFRQMw019latNMBZrxzcCFSkFLIEjHecTuXba10P/4xKsZgcOt
 2AS
X-Received: by 2002:a05:600c:321a:b0:488:fbf6:ea59 with SMTP id
 5b1f17b1804b1-488fbf6ed4amr71233705e9.12.1776551372906; 
 Sat, 18 Apr 2026 15:29:32 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4cc0f31sm16054054f8f.12.2026.04.18.15.29.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 18 Apr 2026 15:29:32 -0700 (PDT)
Message-ID: <08f50eb3-c050-48f7-aa4f-1366e434bfb0@linaro.org>
Date: Sun, 19 Apr 2026 00:29:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/17] target/arm: Implement translate_for_debug
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-riscv@nongnu.org, qemu-s390x@nongnu.org,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
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
 Artyom Tarasenko <atar4qemu@gmail.com>
References: <20260417173105.1648172-1-peter.maydell@linaro.org>
 <20260417173105.1648172-17-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260417173105.1648172-17-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

On 17/4/26 19:31, Peter Maydell wrote:
> Implement the translate_for_debug method instead of the
> get_phys_addr_attrs_debug one.  This allows us to pass the caller the
> lg_page_size from our internal GetPhysAddrResult struct.
> 
> Awkwardly, translate_for_debug's "true on success" convention
> is the opposite of the one we use internally in ptw.c, so
> we have to be careful about the sense of the return values.
> This corresponds to the way that arm_cpu_tlb_fill_align()
> also has to return true when get_phys_addr() returns false.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/arm/cpu.c       |  2 +-
>   target/arm/cpu.h       |  3 ---
>   target/arm/internals.h |  4 ++++
>   target/arm/ptw.c       | 37 ++++++++++++++++++++++---------------
>   4 files changed, 27 insertions(+), 19 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

