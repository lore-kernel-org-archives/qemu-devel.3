Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A95F6C54798
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 04:35:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhMVz-0007V3-Mo; Mon, 04 Mar 2024 23:34:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rhMVx-0007Uf-Lm
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 23:34:53 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rhMVt-0008J9-03
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 23:34:53 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1dc49b00bdbso47096445ad.3
 for <qemu-devel@nongnu.org>; Mon, 04 Mar 2024 20:34:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709613287; x=1710218087; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mut5NGRPt7l0FCSOAd3aZuon5MO5ElaFjceNk/2Pbus=;
 b=JEvZT7AFUdELQlN9+LlnAWhbk3GhO7YgEM3ZEGPgMn5/PrCOIRzOIER5enntetMjgT
 Ww5MKE1nHVIkY8Z94SAVpylSkIPq5EKYWwUTD1Sbms54Bw9UTOTp891ktYvBMdR5/8Mc
 Q36tScalsEh1U0gkWty1bIKDPKZWQkwYWXDCw5QSw0gLeISHv8m1/JU/R+tPg+WzU6QN
 c0IG331M0vtwJvXWxCQyKqXMQwXV+KvOHG3BEAYUg65G/ezngPORid2F86wr/xmRmuYc
 iA2Vxne5ikwlVeHptZExPCJiMwagfYEgDp8++wLcYEdYT+rqmQsuXE//Ly2Hl+2HycMZ
 NvBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709613287; x=1710218087;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mut5NGRPt7l0FCSOAd3aZuon5MO5ElaFjceNk/2Pbus=;
 b=K8BVWxjuISoe7NOSkfr6nUql2nvP7yl5maJHsFi4CQ2CUB65H4PMQtNV+3PQqLC+Of
 nOsPpYvF44vR5KXrFCeVKaZsKmS/2+euwGS58pR7s9wjchdKwovWA6c88lldPKxyITKL
 iACXGDwEYbDMXGu6Fn6I5KRoU6byjttmX2SV0NYXk92M1FB2ZTTjuIt7XzxijdadNTJY
 GOGlw4b9qxigKMThu0QxlFkn+vEBI+vfHUAEeTjBce9A4Ja0sKQpnLlUdrNmWqylvOyg
 u/ansJoHoI5Kx/uqJZDjIe49WJSr8B/ZzJ1bNe5gloPWnLCK8Sg8kZ4TULqD1OIAzsDn
 y5xg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWzIWQbCF0CLlDduck3Cs9Wdtn4gsiUowSZOLgumwy0s2Mg2zv13xJroMUOySeo+4jUOLpLvUCCbIZbqvUpCE+0yxQ5XAs=
X-Gm-Message-State: AOJu0YxDsS2Pi8dodaczGKKryB+50JI95ChVExFPj6xon1hA6jBlphgQ
 ODgIBXur2f945hBvflgbGEdf1KdaIRTxer4/EPzNHgk/3Hh2cLBuxmaf8GXZmhE=
X-Google-Smtp-Source: AGHT+IG2Jil+6x3O51ueIeq6dDF2puNOIAVI3koxY2bRDiJxKHJYczRVusm1qbXUfNDuylyOm+mNLw==
X-Received: by 2002:a17:902:d509:b0:1d9:4e4c:23d2 with SMTP id
 b9-20020a170902d50900b001d94e4c23d2mr869894plg.44.1709613287291; 
 Mon, 04 Mar 2024 20:34:47 -0800 (PST)
Received: from [192.168.6.128] (098-147-055-211.res.spectrum.com.
 [98.147.55.211]) by smtp.gmail.com with ESMTPSA id
 mp16-20020a170902fd1000b001db7e461d8asm9381989plb.130.2024.03.04.20.34.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Mar 2024 20:34:46 -0800 (PST)
Message-ID: <5d3c7aa7-16d2-4812-a72b-dae5e567b9b8@linaro.org>
Date: Mon, 4 Mar 2024 18:34:42 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 1/1] target/loongarch: Fixed tlb huge page loading issue
Content-Language: en-US
To: Xianglai Li <lixianglai@loongson.cn>, qemu-devel@nongnu.org
Cc: maobibo@loongson.cn, Song Gao <gaosong@loongson.cn>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>, zhaotianrui@loongson.cn
References: <cover.1709610311.git.lixianglai@loongson.cn>
 <5b23421ee1ebf59142c7d7a3bc1082fff910f2fa.1709610311.git.lixianglai@loongson.cn>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <5b23421ee1ebf59142c7d7a3bc1082fff910f2fa.1709610311.git.lixianglai@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

On 3/4/24 17:51, Xianglai Li wrote:
> When we use qemu tcg simulation, the page size of bios is 4KB.
> When using the level 2 super large page (page size is 1G) to create the page table,
> it is found that the content of the corresponding address space is abnormal,
> resulting in the bios can not start the operating system and graphical interface normally.
> 
> The lddir and ldpte instruction emulation has
> a problem with the use of super large page processing above level 2.
> The page size is not correctly calculated,
> resulting in the wrong page size of the table entry found by tlb.
> 
> Signed-off-by: Xianglai Li <lixianglai@loongson.cn>
> Cc: maobibo@loongson.cn
> Cc: Song Gao <gaosong@loongson.cn>
> Cc: Xiaojuan Yang <yangxiaojuan@loongson.cn>
> Cc: zhaotianrui@loongson.cn
> ---
>   target/loongarch/cpu.h            |  1 +
>   target/loongarch/tcg/tlb_helper.c | 21 ++++++++++++---------
>   2 files changed, 13 insertions(+), 9 deletions(-)
> 
> diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
> index ec37579fd6..eab3e41c71 100644
> --- a/target/loongarch/cpu.h
> +++ b/target/loongarch/cpu.h
> @@ -292,6 +292,7 @@ typedef struct CPUArchState {
>       uint32_t fcsr0_mask;
>   
>       uint32_t cpucfg[21];
> +    uint32_t lddir_ps;

This magical cpu state does not appear in the manual.
Are you sure that large pages above level 2 are really supported by LDDIR?

Some explanation from the hardware engineering side is required.


r~

