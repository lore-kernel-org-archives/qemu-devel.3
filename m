Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85BF4C54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 16:58:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmGJ6-0006xh-JA; Mon, 18 Mar 2024 12:57:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rmGJ4-0006vN-Kx
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 12:57:50 -0400
Received: from mail-oo1-xc30.google.com ([2607:f8b0:4864:20::c30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rmGJ2-0003Y9-HK
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 12:57:49 -0400
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-5a46abf093cso2519587eaf.2
 for <qemu-devel@nongnu.org>; Mon, 18 Mar 2024 09:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710781066; x=1711385866; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pxgCY7qfGzpJl2Z8fIrKhCpnuuDWFSELPvzHb/VKpFI=;
 b=QG5unwQaX8W0wPBocolk/8fnPHxb/o+gj2Bulwc1qn28kxNhdfpcKqfyOrG3Hp84PE
 FdgltbsHpM8Rbu40lPz5lHP7xtgA8x5OJZYkiz4Hk6jOEpQrckA52l7Xau4M2BsKwWlj
 YpuhCMxgHOtGMXNaSRAw44CmVVNvIiNBdDOXzNxsb3kiT/Cdqe5iCYgmI8dxurX81afi
 /4JZYXFLmV7vmeQjDlplZ5qsiMyXCCrOYqmxNSbC4pKyqogYPonjU5C404PqCWM8gfHk
 cYHTIULSrAu4U5/k/ozdv9I0hYxQPzIbCEPH1A0Mi8eN+FHtl8ROEZul0sKt7KPdkuNi
 +HQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710781066; x=1711385866;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pxgCY7qfGzpJl2Z8fIrKhCpnuuDWFSELPvzHb/VKpFI=;
 b=HukHDdTsaZlnL3hBZrp+siMM1F6GsZA4KS4hzgv+FHTU4KjyLnlxLHjuC2ylRFTbLI
 OzujmdcNuXreebeO9/g0Y1hAVluaOxwhaE4bNUtwEDZj1ufmauhAEWsJTr8OcV0bM3bP
 7wwwVHSRwu4OI0EuZ7cLQwMNcNEh5VC0xTahibUKTXc4N7HnqJeMMbVF8JXt/dfUrD0Q
 2RBERauWR0jeG26PO7Rrf3iS+Hrb9FUFRlh0N4uA3EJ/8d2FbUqqQSItjhZ2Fj/pxO8B
 lCqhVUzyFUugEleKbPIb8II1Oc8lQxQ5CBsgLY6OIjufIVv3nITp2HuUb0/LOPpOm+D6
 RR2w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUdgvnM/c0T39fQhxclXzWq9HydpPNs4jS1RBO8Hm6BfImuWluf0wwoNZRW/7emzbe4LO8EF5fZZEmUxH0hofhPiOsWVL4=
X-Gm-Message-State: AOJu0Yy5lPOARnEDVDs2IztvFTdL+NyhwtP7/2ib6xJZbqxbnYdWoNka
 76E4NGoy+p6Zc5SbFrcWd4wRtzLVr+PG17t2Bbv+KP7nOgaXfXOmUklcWm/i/hE=
X-Google-Smtp-Source: AGHT+IGXo9tIdwGHDy+0U4us4foL58/5k1KHTaXlwqF5zm3BZxsaNthKWPpgC/kZgNmr/7ObhgnkmQ==
X-Received: by 2002:a05:6358:7f02:b0:17e:6bfc:b31e with SMTP id
 p2-20020a0563587f0200b0017e6bfcb31emr12865917rwn.31.1710781066650; 
 Mon, 18 Mar 2024 09:57:46 -0700 (PDT)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 ks11-20020a056a004b8b00b006e647059cccsm8136181pfb.33.2024.03.18.09.57.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Mar 2024 09:57:46 -0700 (PDT)
Message-ID: <ada7d62a-6e40-4383-bc3c-33140cba2c84@linaro.org>
Date: Mon, 18 Mar 2024 06:57:42 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V6] target/loongarch: Fix tlb huge page loading issue
To: Xianglai Li <lixianglai@loongson.cn>, qemu-devel@nongnu.org,
 gaosong@loongson.cn
Cc: maobibo@loongson.cn, yangxiaojuan@loongson.cn, zhaotianrui@loongson.cn,
 yijun@loongson.cn, wuruiyang@loongson.cn, zltjiangshi@gmail.com
References: <20240318070332.1273939-1-lixianglai@loongson.cn>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240318070332.1273939-1-lixianglai@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c30;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc30.google.com
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

On 3/17/24 21:03, Xianglai Li wrote:
> When we use qemu tcg simulation, the page size of bios is 4KB.
> When using the level 2 super huge page (page size is 1G) to create the page table,
> it is found that the content of the corresponding address space is abnormal,
> resulting in the bios can not start the operating system and graphical interface normally.
> 
> The lddir and ldpte instruction emulation has
> a problem with the use of super huge page processing above level 2.
> The page size is not correctly calculated,
> resulting in the wrong page size of the table entry found by tlb.
> 
> Signed-off-by: Xianglai Li<lixianglai@loongson.cn>
> ---
>   target/loongarch/cpu-csr.h        |   3 +
>   target/loongarch/internals.h      |   5 --
>   target/loongarch/tcg/tlb_helper.c | 113 +++++++++++++++++++++---------
>   3 files changed, 82 insertions(+), 39 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

