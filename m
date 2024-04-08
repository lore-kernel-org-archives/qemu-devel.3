Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90B62CD128A
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 06:26:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtiRh-0007JE-Pe; Mon, 08 Apr 2024 02:25:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rtiRc-0007Il-5I
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 02:25:29 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rtiRa-00007o-AQ
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 02:25:27 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a51d0dda061so92056666b.1
 for <qemu-devel@nongnu.org>; Sun, 07 Apr 2024 23:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712557523; x=1713162323; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Mrm1/b5OpHMFSR2CNHhxxzPYHyFuhaTIqvcttXXJv/I=;
 b=mWI2IJPJg9cMcCmzrKYp0tnyL6Hf/H181r1iArt5BzdUZvB076LYq8hsMpxeG/vFpD
 GkSVvmQkPS1+I1viAWe+f+5F7I6UmfWZxdq7xxusXmTmSD+Aqfxmd1P8XEmGucWB9RFh
 7eiSX1YbYNHJf+Jw5hi4EhIin9MC9I7+VX/2Uxk3uMwcCSi3er3tl7hwZBXxQNiU5Qvz
 GWyuAXypir7N+QsNBiREdUu9P35aB7QOtWll9mfPoJUCVBySMdWsznlsWPngUeFKQ0sJ
 B4ee61fBBdVSPlfMxhkTDzPjCGF0GshM4Iw0Bz0kZwnyItvrp6ckM6kN/arziS5nQE45
 LJUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712557523; x=1713162323;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Mrm1/b5OpHMFSR2CNHhxxzPYHyFuhaTIqvcttXXJv/I=;
 b=WNi5BDnUh2VoH2IYvZ6cKU2utG3ChGcKwjeYEYTPuiODpObJHvb5wM3QNQEuQDQ65E
 YZDvVh2qpvLXUAALvwRCdmyvgwo2EUQ8W8jJNqZTXq5Kdlz6J2DYuKmAQT/dEime6f3V
 AyzlI2WprfVqVPTc0aaITOwPJcyxh8fipn9wmJxlsPYPaNkqSEUrpuLn18lsp7dRnK4x
 NdhZzCuwbjJdZENAT8JUN4huW+c61Dk47e4iq2HrQRcgDgeMh4b9Xkku7Yyl95sux74h
 0MOpE7iJ3969rT/+9QEpHB3j192uqvL0WnyTkb84ECYiwsfl/IiEiOedO061oFyliIQM
 IOZQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVEfejRtCkKJp46LfaFlpw6WXcNgaqGgjTh8aoUmeFS2I8waEWWjpSOPOu7Ael/ht2GFNzuunXrDco9N/yWEyuFDi0gV6Q=
X-Gm-Message-State: AOJu0Yzfdtv8ttEjd9wZlhuPF0KEsjum2ESUPes5kHoBA6XnhfmRfMUl
 RZOpGR9gYZREgMpHuCqxQof6hmOAhxIKfJWxkwEP67+fuY6jzkzedTlyvnLwbifaviFjtX/m9s8
 t
X-Google-Smtp-Source: AGHT+IF3NsEUS26WcV/epzRtzl13htGE4Akhfrtz7Hmh2RgQY4G1UjZ9PZvQHHJ+dlJhdG8vLpVRaQ==
X-Received: by 2002:a17:907:94c7:b0:a51:d4b1:cf56 with SMTP id
 dn7-20020a17090794c700b00a51d4b1cf56mr2040712ejc.10.1712557523471; 
 Sun, 07 Apr 2024 23:25:23 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.144.67])
 by smtp.gmail.com with ESMTPSA id
 sa10-20020a1709076d0a00b00a4e6582edf8sm3974219ejc.102.2024.04.07.23.25.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 07 Apr 2024 23:25:23 -0700 (PDT)
Message-ID: <086c539c-e2e2-4639-8baa-607225bc450f@linaro.org>
Date: Mon, 8 Apr 2024 08:25:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 9/9] accel/tcg: Improve can_do_io management
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Jorgen.Hansen@wdc.com,
 Jonathan.Cameron@huawei.com, linux-cxl@vger.kernel.org
References: <20240406223248.502699-1-richard.henderson@linaro.org>
 <20240406223248.502699-10-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240406223248.502699-10-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62c.google.com
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

On 7/4/24 00:32, Richard Henderson wrote:
> We already attempted to set and clear can_do_io before the first
> and last insns, but only used the initial value of max_insns and
> the call to translator_io_start to find those insns.
> 
> Now that we track insn_start in DisasContextBase, and now that
> we have emit_before_op, we can wait until we have finished
> translation to identify the true first and last insns and emit
> the sets of can_do_io at that time.
> 
> This fixes case of a translation block which crossed a page boundary,
> and for which the second page turned out to be mmio.  In this case we
> truncate the block, and the previous logic for can_do_io could leave
> a block with a single insn with can_do_io set to false, which would
> fail an assertion in cpu_io_recompile.
> 
> Reported-by: Jørgen Hansen <Jorgen.Hansen@wdc.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/exec/translator.h |  1 -
>   accel/tcg/translator.c    | 45 ++++++++++++++++++++-------------------
>   2 files changed, 23 insertions(+), 23 deletions(-)

Nice!

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


