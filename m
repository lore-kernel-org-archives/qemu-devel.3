Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC1CFCD3445
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 18:18:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLPlK-0002E8-5t; Fri, 08 May 2026 14:17:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wLPlH-0002Dr-5V
 for qemu-devel@nongnu.org; Fri, 08 May 2026 14:17:19 -0400
Received: from mail-oi1-x22c.google.com ([2607:f8b0:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wLPlE-0003m3-7p
 for qemu-devel@nongnu.org; Fri, 08 May 2026 14:17:18 -0400
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-479eb8bcacbso1454039b6e.1
 for <qemu-devel@nongnu.org>; Fri, 08 May 2026 11:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778264233; x=1778869033; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Dxdv/jKRXhwISNYNxOvsvli7kzmYuX4/OTweKshkIgQ=;
 b=dMR4b0jw+NqUv3ZntvkYOyEyeBxnLIhp5FpQkko9zSTDa7fDwPtAYe4oUquuTQFLhj
 pDElADiR5z00Xh350ry7fyqzXVkEapt7nSjK/TxPgyPaFNCnXSS4cqD72A/N6SI6RUYQ
 +kercXvW82Wj8cZOHWMjpBnysMeyw1j0++6z02ZJmN3Rg2cUh+QuLyUYOLJQjrRdi8Y4
 2qQ+Swgqut5c4iCE9mKOV+04w3YfAvn+9xDqpbOamfrcTVgaXeY+9S5zwaT7afX6HxU4
 IUtvaQBgi+IJcIe3SKboP0f6Ne2gXot4Jr8RcUNCe6OWR/2HW0B+eyuYKjpbebeaeOgu
 3LYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778264233; x=1778869033;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Dxdv/jKRXhwISNYNxOvsvli7kzmYuX4/OTweKshkIgQ=;
 b=kfIi5PpD5pN5SYBkxNJxIeIGX3ncNGc0iUN/5GCynmI1Vc2cO4K5NFDO0YEHIdzCSp
 gAogmPeRaraTShR8E7mI/h2vAeYQ/0xzxKSzb2nho5lQ3k00rNpNJIC9YdJLWQi/DzTb
 3G64nYN8G8zjj2cjymBzondBLOOdtmxn0B7F4nrXLreW2qi82j1j9NXQrxyBizTasXcg
 D2E8td4zvMWwnsAyklUjmPHSsFvRNdLmC5N0kuY7OuFB0PtQJ09QEk5fq1wSjrZk7+49
 U7I29QWib5tG1HznsewnnG3vEeeYuhs4CjYUqDWGKm/kzR8dV5zigqHZiMhYfSBSr647
 SxUg==
X-Gm-Message-State: AOJu0YzYc1cbuwwUqqEIShgpcGnPdinQO8JMgJlwIq5x1FKQOvinK650
 8529GyYdv4OfUcj/T34DaYzwazgiG6Eu76E7La837JOtxAoTUYt7KN9kPPZC2ONOvqaunHr0aGM
 78CcI
X-Gm-Gg: AeBDieuMh+rIxTQqE1ePhM+ucLUYFWC/DtAOLrVfUy6LAuz2VqoTBbcqpawexy3WeA3
 bR0p2Ui++m2VPSQppDfYflijU7hyaMBfgK5Z52f9KxBq2MRvfrrRypUY2T3bNnBnfqoLvxyPnWD
 QqZPWAUPRhBLzOb8uo8Gwoq0w7N+YWOILGhrF4uyssTyI5bAq1WEuea0oj/g4GxeA5YzKZfXw/w
 iuK1lxlPItLE8au9OxhiuZ1FpLsMq7oE75sU8oQj4YMTHYRHmU3jAy4T6T0x0JwfZ2QJoxzUAYS
 3oVRI5QCGPKg1s5O0y9lZHqdbUZUd1nfuG+gFXNpaTrNVTpve74+rLriSKEnJZtDuYItWk0b6j+
 qtbIhpKRqo1cA4DVOUwqHZ856nKPcNsGFz+GHWNxID86tudOYj+ItxcP/ug4Z+EEK4JNil3M4Au
 o1Z2hJ1oLPxP7imPcrD/0DZUeJ+fl+7+DMrCVI7qs4U249YW3KzlPRWeTaYtMfv69h7yWmGOKEJ
 Kz3qmYXog==
X-Received: by 2002:a05:6808:3028:b0:467:baa:ed5c with SMTP id
 5614622812f47-480420bfa98mr8444506b6e.12.1778264232684; 
 Fri, 08 May 2026 11:17:12 -0700 (PDT)
Received: from ?IPV6:2600:381:c938:6375:4b0a:aabe:cbe1:bd0c?
 ([2600:381:c938:6375:4b0a:aabe:cbe1:bd0c])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-48061e6eb84sm3819825b6e.0.2026.05.08.11.17.11
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 May 2026 11:17:12 -0700 (PDT)
Message-ID: <9dc3ea46-ddee-45b3-ad1a-c6d00dd98dc7@linaro.org>
Date: Fri, 8 May 2026 13:17:10 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/32] target/mips: add Octeon multiplier state
To: qemu-devel@nongnu.org
References: <20260508-mips-octeon-missing-insns-v2-v3-0-bcbec96357d9@gmail.com>
 <20260508-mips-octeon-missing-insns-v2-v3-7-bcbec96357d9@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260508-mips-octeon-missing-insns-v2-v3-7-bcbec96357d9@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22c;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22c.google.com
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

On 5/8/26 10:12, James Hilliard wrote:
> Add per-thread Octeon multiplier state for the MPL and P limb banks used
> by the VMULU/VMM0/V3MULU instruction family.
> 
> Keep the storage in uint64_t arrays and migrate it as an Octeon-only
> subsection, so later instruction patches can update the architectural
> multiplier state without mixing state layout changes with decode support.
> 
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> ---
> Changes v2 -> v3:
>    - Split the multiplier state out of the combined Octeon arithmetic and
>      memory instruction patch.  (requested by Richard Henderson)
> ---
>   target/mips/cpu.h            |  4 ++++
>   target/mips/system/machine.c | 33 +++++++++++++++++++++++++++++++++
>   2 files changed, 37 insertions(+)
> 
> diff --git a/target/mips/cpu.h b/target/mips/cpu.h
> index 84d12b77f9..c6d75c67ab 100644
> --- a/target/mips/cpu.h
> +++ b/target/mips/cpu.h
> @@ -497,6 +497,10 @@ struct TCState {
>       target_ulong CP0_TCScheFBack;
>       int32_t CP0_Debug_tcstatus;
>       target_ulong CP0_UserLocal;
> +    struct {
> +        uint64_t MPL[2 * 3];
> +        uint64_t P[2 * 3];
> +    } octeon;

Why are there 6 elements here?
My octeon documentation only says

P0-P2 are 64-bit product registers. MPL0-MPL2 are 64-bit multiplier registers.  Which 
makes sense in the context of v3mulu "192-bit x 64-bit unsigned multiply and add yielding 
a 256-bit result".

Did this get copied from something that used uint32_t?


r~

