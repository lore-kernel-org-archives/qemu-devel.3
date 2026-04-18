Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A5AAF99C95
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Apr 2026 22:16:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wEDwN-0007Hv-U8; Sat, 18 Apr 2026 18:15:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wEDwK-0007Gc-Oe
 for qemu-devel@nongnu.org; Sat, 18 Apr 2026 18:15:00 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wEDwH-0007Zd-Kw
 for qemu-devel@nongnu.org; Sat, 18 Apr 2026 18:15:00 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4852a9c6309so15652125e9.0
 for <qemu-devel@nongnu.org>; Sat, 18 Apr 2026 15:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776550495; x=1777155295; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=J4HtccAD2MiFIn69rKjBApCAFk1yVNfdQzHBiQJrzDA=;
 b=Mre8Ws9o/MYtGtw4cXcIBKbxe9QimVHgnHGxKwCM484xdS+Sq28ITLLzgOa5S4l1Lf
 7domqiNHwG5pJxUL8gwHlzlIyz4Hb8dtuID1C06YWcs+Y4gCG80RuVrjhoWTUR/KV6iT
 k6fptm6GR2AVV7r+rj0arweAByZG2OOVOmn0v6tEr50Kcqj/IDAvMNRwJO+Q5S543Hdd
 2dxRgVL6dfVLDM+DkwQDFFHzkNRo9w9uPl6cR4e5DShgJeNcgEh0sUtImaHz3Kuflxi1
 QSfbNnYkq/U9x2kRjrsY1EmtgI3k5y4UnQCdDretW+5zf3uOlrohqr5q+LAoUimPCg9Z
 sPXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776550495; x=1777155295;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=J4HtccAD2MiFIn69rKjBApCAFk1yVNfdQzHBiQJrzDA=;
 b=YjXtUC94oA4sKj/JIvHaUpXbX43LZ5M6kJw0ArFqBGfBYYXo/bcPhS7XocpuiytB4z
 nL3Tt5EahXdneSzgFTqmiIbtBqFujxq5VwZUPEAwczSoo6fOtW2GrBwAxUDu6aaYVg8Y
 eIIy1Vx2w6ey/6TGPwWkGnMdo3V7ZlrbDyE80GESjU9VJFaerBQDCM6SeZn421SbbqQ/
 Q+O7aZHTKWXSutUmzo8XCAOAE4N6j1Hc1j3pGUVXHJqoJv95C//MemOuKsmlJ4luwrn4
 cdhpKGAmRcqLJcGIRbK1RCvXPlGCzK5BpEjTqakMctUQh/oJ5Cfu/AeZSd+gWyeuUZqu
 B5YQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8iV3g4oiMqkyPUGmJ+ndOYWEw9U0hzPcTXm7UNzpLHpM176Ik1w+uZ13zo/uOv5TnIaDjfQlPKQxGI@nongnu.org
X-Gm-Message-State: AOJu0YzJKXdap+QfPX6xALIEzzk5i34NOzOOYaYUgZjPJadJCzaEV0qq
 /Np29sLFeJDuO95DAFrApgLbYL3E1sOOH6g/Gtqqy5zK0GvAHN6u9GA+GEDX7G+xYw0=
X-Gm-Gg: AeBDievXHNG5PAdtjJrCcY1h1e/3Z9y/2c3yGBLV3Zkr+k7TpTYI1KBHm7704oTNEop
 nk17AlbjezWrR8XzWL6/g+w5jAct4GaL4WPk8s6lWJr65feSAV/GdxGkRzoSDKHkZwI3SNQw0N8
 3xnQ2HpOXfknPEbY/jrcTOGlyj1V2BHgv/iX5LOOAregMlTKontutFqSm6a3HsOvR6HltPods+z
 i8mgKr9w8Vj9smwSZJVSyAXDF89RLa9P9+M/HmejkW+5PN/YitI+o1c6JwzYOTsSef/JSE5QY0R
 BK2GXgo+uWz5g74Ga3x4SwKXExzHxCzKxpvmrpeWXHywGr2Kieutne991j6t08Zo4ZWSKUj1Rkn
 5m5F2xxJe6hKGlHK1Qw0v5mNfqo5I6VQz7dwaq29bP3daDnHwCQmLr1xPtUjjDbKNoUlkMGoxPY
 53pLsCNODmBJw20Nrxqd+1eg4slgjsSrWjrve3MMreRK+sQn/DfK4g1GRRMooFw3qKoHqjITmsH
 pzm
X-Received: by 2002:a05:600c:3b97:b0:488:af7f:7707 with SMTP id
 5b1f17b1804b1-488fb769dbfmr123970325e9.18.1776550495535; 
 Sat, 18 Apr 2026 15:14:55 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fb7b2716sm51884555e9.30.2026.04.18.15.14.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 18 Apr 2026 15:14:54 -0700 (PDT)
Message-ID: <00c97328-8011-4ed0-a96f-7dfef8f25295@linaro.org>
Date: Sun, 19 Apr 2026 00:14:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/17] target: Rename get_phys_page_debug to
 get_phys_addr_debug
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
 <20260417173105.1648172-9-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260417173105.1648172-9-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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
> Now that we have ensured that all implementations of the get_phys_page_debug
> method handle a non-page-aligned input and return the corresponding
> non-page-aligned output, the name of the method is somewhat misleading.
> Rename it to get_phys_addr_debug.
> 
> This commit was produced with the commands
> 
>   sed -i -e 's/_cpu_get_phys_page_debug/_cpu_get_phys_addr_debug/g;s/\<get_phys_page_debug\>/get_phys_addr_debug/g' $(git grep -l get_phys_page_debug)
>   sed -i -e 's/_cpu_get_phys_page_attrs_debug/_cpu_get_phys_addr_attrs_debug/g;s/\<get_phys_page_attrs_debug\>/get_phys_addr_attrs_debug/g' $(git grep -l get_phys_page_attrs_debug)
> 
> which catches all references to the method name itself plus
> the functions which each target uses as the method implementation,
> but (deliberately) not the cpu_phys_get_page_debug() and
> cpu_phys_get_page_attrs_debug() wrapper functions or their callers.
> (We'll deal with those in the next commit.)
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/core/cpu-system.c             |  6 +++---
>   include/hw/core/sysemu-cpu-ops.h | 10 +++++-----
>   target/alpha/cpu.c               |  2 +-
>   target/alpha/cpu.h               |  2 +-
>   target/alpha/helper.c            |  2 +-
>   target/arm/cpu.c                 |  2 +-
>   target/arm/cpu.h                 |  2 +-
>   target/arm/ptw.c                 |  2 +-
>   target/avr/cpu.c                 |  2 +-
>   target/avr/cpu.h                 |  2 +-
>   target/avr/helper.c              |  2 +-
>   target/hppa/cpu.c                |  2 +-
>   target/hppa/cpu.h                |  2 +-
>   target/hppa/mem_helper.c         |  2 +-
>   target/i386/cpu.c                |  2 +-
>   target/i386/cpu.h                |  2 +-
>   target/i386/helper.c             |  2 +-
>   target/i386/whpx/whpx-all.c      |  2 +-
>   target/loongarch/cpu-mmu.h       |  2 +-
>   target/loongarch/cpu.c           |  2 +-
>   target/loongarch/cpu_helper.c    |  2 +-
>   target/m68k/cpu.c                |  2 +-
>   target/m68k/cpu.h                |  2 +-
>   target/m68k/helper.c             |  2 +-
>   target/microblaze/cpu.c          |  2 +-
>   target/microblaze/cpu.h          |  2 +-
>   target/microblaze/helper.c       |  2 +-
>   target/mips/cpu.c                |  2 +-
>   target/mips/internal.h           |  2 +-
>   target/mips/system/physaddr.c    |  2 +-
>   target/or1k/cpu.c                |  2 +-
>   target/or1k/cpu.h                |  2 +-
>   target/or1k/mmu.c                |  2 +-
>   target/ppc/cpu.h                 |  2 +-
>   target/ppc/cpu_init.c            |  2 +-
>   target/ppc/mmu-hash32.c          |  2 +-
>   target/ppc/mmu_common.c          |  2 +-
>   target/riscv/cpu.c               |  2 +-
>   target/riscv/cpu.h               |  2 +-
>   target/riscv/cpu_helper.c        |  2 +-
>   target/rx/cpu.c                  |  2 +-
>   target/rx/cpu.h                  |  2 +-
>   target/rx/helper.c               |  2 +-
>   target/s390x/cpu-system.c        |  2 +-
>   target/sh4/cpu.c                 |  2 +-
>   target/sh4/cpu.h                 |  2 +-
>   target/sh4/helper.c              |  2 +-
>   target/sparc/cpu.c               |  2 +-
>   target/sparc/cpu.h               |  2 +-
>   target/sparc/mmu_helper.c        |  2 +-
>   target/tricore/cpu.c             |  2 +-
>   target/tricore/cpu.h             |  2 +-
>   target/tricore/helper.c          |  2 +-
>   target/xtensa/cpu.c              |  2 +-
>   target/xtensa/cpu.h              |  2 +-
>   target/xtensa/mmu_helper.c       |  2 +-
>   56 files changed, 62 insertions(+), 62 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

