Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 127EEF99C9B
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Apr 2026 22:16:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wEDwo-0007Vj-CO; Sat, 18 Apr 2026 18:15:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wEDwn-0007US-37
 for qemu-devel@nongnu.org; Sat, 18 Apr 2026 18:15:29 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wEDwk-0007vF-Hg
 for qemu-devel@nongnu.org; Sat, 18 Apr 2026 18:15:28 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-488a29e6110so16066265e9.3
 for <qemu-devel@nongnu.org>; Sat, 18 Apr 2026 15:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776550525; x=1777155325; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WXMY94dCqMOHOzrMoTrJrkjU0/9AwmWK8Mg4e8KOnjw=;
 b=jnC8ZkZ9AvJ4L9CBoG7zY78/Xkbva0vK/5qwpV8kUMCAylfxqzknek27ke8qo2sJlT
 pbQQk20KM5hJ4KrwWEsSnn2aB+30UMjv9geucdvURFtQ1fK56i6C9OKD2ByUGUsOycTI
 odHE0HEcYScwKGINZLPJ6fQiJoNsro8yguM7HF8hWmm6BJqMU2c7bLQE654nH4gvUEy1
 WvAAeBDMYrqHn7tEcU9mXU+Nk6eH9/JD5IA7rveuiJw91jo0vxR4Z43Gucnzrm7SCG5h
 kYmki5QYc5Pi4UrCnApwIonO1ttJmhaJHNFc81HIhziNRO4Ah7T2dUDMRP1YCQ/YRd0y
 keDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776550525; x=1777155325;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WXMY94dCqMOHOzrMoTrJrkjU0/9AwmWK8Mg4e8KOnjw=;
 b=XYFDhJJfQLUYA0XfqC6R+/cNzACQsVK2TngIngGiGrvUUZPfbKERGCWvP4dPue5ucw
 EPlKG4Ze/LMmkOVGmBu+5el2lNp1wAoiZqZ5OiuI2pRvbzCodlLuLOb6mqIVJEIJ9mHC
 03FYCNdypK6EY3UAU/tVfmpBmzWXHg2ymGbw5bOZ2A4FomYhizfy5RAIu7PlIUl/8e5Q
 rPTrA8R5orCFA51YMCxrqpy8sd+VD9EBuVOXcIDeQj94aqh9dXVLLVsd+9TM5GY2bCNW
 DyLzgZzoi/DHqhd7btUdE56sOgtpGZFuIc/oSThEDVV7cMeZXascXQ2t0iej0v6PXWJ2
 lbeA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+qmqf6ZkXq/ezQvtSNAakmv8pI94FsXX1e8Ds8CJVaZxj8Rvul17q1AtdwMzR4U/r1b/Te0RajUtPy@nongnu.org
X-Gm-Message-State: AOJu0YwTbCOMrdpDmSG14URemlE6eS9iJNmJiRAD7BH7sQjOdq/LD7YS
 w09Fsk5MK3wqnkhQ1uPwqIT+WgPa5TFIs56qc8rpHE9Jac5lxSejLSOqEd5uTgDKdNA=
X-Gm-Gg: AeBDieu1fl+CTB0OEhvjo3QF3sDpIymXT89tUSBx1RzfXhjnHT3sExRJilEYXBtmnwu
 k8fNRESEXHL7E9gRaFmDkLrnIsFSIwxDybnyNNuy0myYw0gNHyGx01AV+I8cRLiEtMYOHmIurWu
 yEFc+Xr/shcHGy6s+FK2TqjeBQKhW9agFsHezAiB2OTbbr8+nkffHvBKK0YkdfWdhHMGbIzmFZa
 kPWTdX3iotroLYHBmTeIUQ8/3fynwDJSKu1WMPoBw0wcOknE4ueyfqob+k4MSoKdfaS4hSnXbEB
 1ug3vSRCseiTz4oY0iUOJhUdUWqlDtzGtuoOZ7yw/g4DCJGbPDEVL/X7VIjsoAhtALtqkEBYh9v
 2vlYsugKOWe18HhUj7vswa+67sCv7xuqrUSVjn1kwjRI0+IArAI1Kb6CWC8dmXJ6hcrj9nprhia
 BmEuEL59BTR4h/0WANYv5O2nxaF1QUVQJM/qxzP8Dfzdx0MMMvSN/XjijPWbTf9MCMEd27qlBnO
 E0FVYEHqwMGIKI=
X-Received: by 2002:a05:600c:8183:b0:486:fe39:28b7 with SMTP id
 5b1f17b1804b1-488fb752e3cmr97206495e9.9.1776550524870; 
 Sat, 18 Apr 2026 15:15:24 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fc1c01cfsm166680665e9.10.2026.04.18.15.15.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 18 Apr 2026 15:15:24 -0700 (PDT)
Message-ID: <f9be05f5-d08d-4e31-9705-9d48e93761e8@linaro.org>
Date: Sun, 19 Apr 2026 00:15:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/17] target: Rename cpu_get_phys_page_{,attrs_}debug
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
 <20260417173105.1648172-10-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260417173105.1648172-10-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

On 17/4/26 19:30, Peter Maydell wrote:
> Rename cpu_phys_page_debug() and cpu_phys_page_attrs_debug() to
> cpu_phys_addr_debug() and cpu_phys_addr_attrs_debug().
> 
> Commit created with:
>   sed -i -e 's/cpu_get_phys_page_debug/cpu_get_phys_addr_debug/g;s/cpu_get_phys_page_attrs_debug/cpu_get_phys_addr_attrs_debug/g' $(git grep -l cpu_get_phys_page)
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/core/cpu-system.c        | 6 +++---
>   hw/i386/vapic.c             | 4 ++--
>   hw/xtensa/sim.c             | 2 +-
>   hw/xtensa/xtfpga.c          | 2 +-
>   include/hw/core/cpu.h       | 8 ++++----
>   monitor/hmp-cmds.c          | 2 +-
>   plugins/api.c               | 2 +-
>   system/physmem.c            | 2 +-
>   target/sparc/mmu_helper.c   | 6 +++---
>   target/xtensa/xtensa-semi.c | 2 +-
>   10 files changed, 18 insertions(+), 18 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

