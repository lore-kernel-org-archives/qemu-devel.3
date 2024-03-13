Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C30AC54E58
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 21:08:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkVps-0008BY-Tg; Wed, 13 Mar 2024 17:08:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rkVpr-0008BA-K1
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 17:08:27 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rkVpm-0003BO-GS
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 17:08:27 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-299b818d63aso264231a91.0
 for <qemu-devel@nongnu.org>; Wed, 13 Mar 2024 14:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710364100; x=1710968900; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kRVTvdCaiGIgC6WvWGjXMaDURgcR2zq5Ft7uiLQtzbs=;
 b=D+r2/1ku5ijjCy9liUv4KBC0vatTfd4XuUHHIucTKv5VQo45c6Pevk1PODfMBqooxn
 o0Tjc3QWJ2Aknfekmvadj6JE85bEhwUVV0ucoERGl1LxP7Pr/IvXl/nk+MQSzj1Ur/vL
 FaHdEthebRN3J7TTq1tRnqrScIEu+7N5LrQbqgoZJey+JKb5Ollu1eduUpcffKjBpL8q
 SJ2u/p7nSJQJjU3C00HKTQt9+eqjWZUrJknfIpI2AOt3chAB832P+PApxId0Qc25LHAU
 CKIZXv2FxrtVUiKBnYCf1aeXV6hitI+qQ8wsKM2dgmsm06atIeX0k6LMH4HF5RKCCF3U
 37Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710364100; x=1710968900;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kRVTvdCaiGIgC6WvWGjXMaDURgcR2zq5Ft7uiLQtzbs=;
 b=uj/6IP/391i6fqT8TyzoKmioTDjBBXm7yBNXZHbx4emQlFMu0Wxcq1YLBfdWWxfRm2
 9CaPYRP1mjXTzq6/6IG9LffHjQnJ7or2EcEF83wbi1FEnAx06lR2PSA/qCWFmM9CH7aI
 iXWhc/s7LDxttTpSR3mZePqEJD50/cznXelbclwh75spq2UoDr5hL8ij3AHTn4JjSGIt
 ns/z68p1/1Flj5NXwIn2HtvZm3PZPnOoUl25DpzatTp4EYpO7t52YCjcxoupmZiUbbw3
 EOPHJO/A3Emb5dNAXnP3iclllRVrxD3albA30Fyxv8cPe4CIIZvIa7ssqe3veA+JtBxE
 bfWg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU/Bq9f0noEYUmxlMj9z5KikYuIDggWciKC7hfnIlhyz/bxEC3EbWIwPD3OSVLC6MRe4yyOiUyBDcCz3PJ8AskAlmuXQ/8=
X-Gm-Message-State: AOJu0YxG/riwBbAYBj1uSvqCrfAdw8kbIf62GIh3rX3xK15GQysaKvxU
 d3q8nbubsqWwiy9L1McLHrpKHwJzB9d3asEFVa/Bg1n/qu4L1zUfYxqQgjCdOFEg5itiHlk2pWn
 V
X-Google-Smtp-Source: AGHT+IGMaDmdEefTdI1DymMbSR3d3dH69CLeYGEnqJIzSj7utKQNNxbR6rfyNR0owSi3VvEip1s7bA==
X-Received: by 2002:a17:90a:ead0:b0:29c:7873:dc25 with SMTP id
 ev16-20020a17090aead000b0029c7873dc25mr70731pjb.18.1710364100404; 
 Wed, 13 Mar 2024 14:08:20 -0700 (PDT)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 qc12-20020a17090b288c00b0029bad32fe5csm81470pjb.16.2024.03.13.14.08.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Mar 2024 14:08:20 -0700 (PDT)
Message-ID: <c9f141d1-cd0b-4b58-a0ae-a5065353db8c@linaro.org>
Date: Wed, 13 Mar 2024 11:08:16 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.0 1/4] hw/arm/smmu: Avoid using inlined functions
 with external linkage again
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20240313184954.42513-1-philmd@linaro.org>
 <20240313184954.42513-2-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240313184954.42513-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1035.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 3/13/24 08:49, Philippe Mathieu-Daudé wrote:
> Similarly to commit 9de9fa5cf2 ("hw/arm/smmu-common: Avoid using
> inlined functions with external linkage"):
> 
>    None of our code base require / use inlined functions with external
>    linkage. Some places use internal inlining in the hot path. These
>    two functions are certainly not in any hot path and don't justify
>    any inlining, so these are likely oversights rather than intentional.
> 
> Fix:
> 
>    C compiler for the host machine: clang (clang 15.0.0 "Apple clang version 15.0.0 (clang-1500.3.9.4)")
>    ...
>    hw/arm/smmu-common.c:203:43: error: static function 'smmu_hash_remove_by_vmid' is
>    used in an inline function with external linkage [-Werror,-Wstatic-in-inline]
>        g_hash_table_foreach_remove(s->iotlb, smmu_hash_remove_by_vmid, &vmid);
>                                              ^
>    include/hw/arm/smmu-common.h:197:1: note: use 'static' to give inline function 'smmu_iotlb_inv_vmid' internal linkage
>    void smmu_iotlb_inv_vmid(SMMUState *s, uint16_t vmid);
>    ^
>    static
>    hw/arm/smmu-common.c:139:17: note: 'smmu_hash_remove_by_vmid' declared here
>    static gboolean smmu_hash_remove_by_vmid(gpointer key, gpointer value,
>                  ^
> 
> Fixes: ccc3ee3871 ("hw/arm/smmuv3: Add CMDs related to stage-2")
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   hw/arm/smmu-common.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

