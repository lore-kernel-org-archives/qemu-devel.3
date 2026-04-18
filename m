Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB91DF99C95
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Apr 2026 22:18:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wEDzh-00021o-I5; Sat, 18 Apr 2026 18:18:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wEDzd-00020v-Gd
 for qemu-devel@nongnu.org; Sat, 18 Apr 2026 18:18:25 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wEDza-0000Ab-Lk
 for qemu-devel@nongnu.org; Sat, 18 Apr 2026 18:18:25 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-488b0046078so17400525e9.1
 for <qemu-devel@nongnu.org>; Sat, 18 Apr 2026 15:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776550700; x=1777155500; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=X4TMbocxv1DCai7TObvwSgJK/z7vFCjJ+F2oj9LEats=;
 b=SaczLxm1NvRkvuXoK+h5PjQ49MPYNsb/5c/mloQTDVB8TnRxgOkM8WbT+yG0jZk6p/
 tUy7jClLjOUuJW3azoAzqd4ZryQwJkiPelziHvxxHJDsOmfWkoiAnxKmZiTFjQ5Ult10
 NKTMx0iasDHdX3opyFFHFAXLoqRrrFPkxiN7Xw1uhkDtmpV/27RbVL72orWdPDUJ+H0T
 2oA8yVGfrPXtao07t3ZM4BW4Jk9VgoKH/SvVyhJhnRI9+TFLXLu/0X/VDw9eE8YUOj21
 HKm6nc356IAxZllr1f3lEQciVAYmgv8Zugp1Tm3Jf1n75I+0Prfr6ZZvhOOju891Yhmm
 bvfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776550700; x=1777155500;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=X4TMbocxv1DCai7TObvwSgJK/z7vFCjJ+F2oj9LEats=;
 b=ccAdLFqFWr54AO0ZUy3LtS7ULL6zl4jYh2kWG+lq9zW2gSMihiV8kUxwRaputh6Sx3
 qrYekzcO+lY/w7hr1Pv78TuoQnKfSH1sYo4ef810LYBRIz97gWq+DR1kKSmXqw+TGZ9f
 3Get2yRhbc2iFxl5vG1e563QD+Qg7naBOaqMvdvS6/5/cIbkLNZtAse9z8kg0M1PtHjO
 3rwJ+9n4NH0PSNQu6/3VCzqMUjQKuqqgiUOFXXjG1sPx77yVoKIzrU11BRPYb34Dp8/a
 d3YhzgVRgAWBBCm2hYvplwszSA7tdHjaWGQC4XmotdR0yMUfm02hwbhLXpE7Ex0xG9G1
 5AtQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/c/sOuP4EGSP+iobsJ22yG6T40UyXYoLDloSHY/Cg/KWSTpRVU5g1hn4Fy1x0dBtXnTRsDLYzjcgM4@nongnu.org
X-Gm-Message-State: AOJu0Ywnds6LBnFbbwJiRLXssH8lv04ApbAzT2tFfVoBXc8GN5WWlLjs
 j1bcjjKEjj6z0zYPrKT6l3T0U1foSILKR733QUJTkyr2I1urtCeYmAlV91kYHKuEJ0c=
X-Gm-Gg: AeBDievOGGLaJx4gUhFDT5ROicIST9ntoj3LKLSBg+YdQgsReeF6HLcG+jActQj9hlc
 nCTuKl68b9t2HF9rqM21mh3QEIDWfyE8JKCuPbNcX3+r1epDQwJlU2x1DG2Y9i5A8cLI+Wbm0nx
 pLxhGgFhF3KC61ezT+1Ru69aIA1nyRxoGi/xJZnmhTS7cySm2P14QlV062diFY9B6XYbjdbUL26
 2RSGwott6+HmhRCzvczUzXoj+VgJGGS1PQKGMFLIS72f+xGBrWkb7KNKKCHZZubl+Ybzk2kOCWO
 BmT+lDepkddaY/VyrymD21i5RMq+D9Qjb+Qhgm3xUH4Cr0njRHnUkwWsiRG8yvPc1Ph1solLgKD
 oWlNmfWkQyp+ENkAoNvNP1RyG75KxIWhsGuZbJ/GEVHIAdHgF4c5vqT2NwCcqk0gbilKZRRKtHZ
 21+yhI9JDtb7jT13rBuarzuBzGKJahdGyniPA2MXwbu4sqCqC3JEku/dh/fYvb2C3Xg638CMbJE
 XSS
X-Received: by 2002:a05:600c:b90:b0:488:b99b:4177 with SMTP id
 5b1f17b1804b1-488fb78ee4emr110541315e9.25.1776550700098; 
 Sat, 18 Apr 2026 15:18:20 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fc1393f5sm149401335e9.9.2026.04.18.15.18.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 18 Apr 2026 15:18:19 -0700 (PDT)
Message-ID: <4e66e367-7436-41d9-9297-c7f9edd4478d@linaro.org>
Date: Sun, 19 Apr 2026 00:18:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/17] target/microblaze: Make get_phys_page_attrs_debug
 handle non-page-aligned addrs
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
 <20260417173105.1648172-4-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260417173105.1648172-4-peter.maydell@linaro.org>
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

On 17/4/26 19:30, Peter Maydell wrote:
> Currently our implementations of SysemuCPUOps::get_phys_page_debug
> and SysemuCPUOps::get_phys_page_attrs_debug are a mix of "accepts a
> non-page-aligned virtual address and returns the corresponding
> non-page-aligned physical address" and "only returns a page-aligned
> physical address".  This is awkward for callsites, which in practice
> all want the physical address for an arbitrary virtual address and
> have to work around the possibility of getting a page-aligned
> address, and it doesn't account for protection being possibly on a
> sub-page-sized granularity.  We want to standardize on the
> implementation having to handle non-page-aligned addresses.
> 
> For microblaze, we just need to remove the explicit rounding down to
> the page boundary that we were doing in
> mb_cpu_get_phys_page_attrs_debug() when calculating the output
> physaddr from the results of the MMU lookup.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/microblaze/helper.c | 9 ++++-----
>   1 file changed, 4 insertions(+), 5 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

