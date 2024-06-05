Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CA88C27C52
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 07:11:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEknD-0003Tn-2o; Wed, 05 Jun 2024 03:10:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sEknB-0003Td-IH
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 03:10:41 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sEkn9-0000nu-Tf
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 03:10:41 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4214f803606so13299095e9.0
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 00:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717571438; x=1718176238; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8Xd62i8bDmrr39gpSsFl3i3SAhQsYR3xt5fnjgPsYqs=;
 b=x2SYMxN8gPPlHSGe413sN8lb4VXZ5Hmv/NtY0Cuga0tu1IMm2ZzmPdAmsNkQQd8d/a
 0qVrUns6bBaQnaK4SpDeACBSqs3Vaxdvay9ReUgTHwpFjaXG956tcfMAFnzymsHUeUVM
 c57qn6FErHgMsQJ3LJ9C6xFyNaUlAayNPVgFVWMerrrL9BQfsDWc2vcEBX8WOL4eD+OZ
 m7x+MAcArMBYl6pnGqfQjoeFCSV8d+JDDR3rpwwMY68kin15Zt2eKDuhNdlnQh+EUppL
 IJp/N2q1/2XxBlzhwZcSp9tguEGJ7NvnWWuZ4fyxNqQpS+WqSyrF269xRkn4XHT8XIfL
 pU1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717571438; x=1718176238;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8Xd62i8bDmrr39gpSsFl3i3SAhQsYR3xt5fnjgPsYqs=;
 b=gD2tSDWizTqRsNb7jNsElL0MXKabZ6VusSrZQa19flB/Xu0N6w2lE7uOjTfsGIEJSx
 t4uTOrT8p7qXsQtilRS8qWtwQhja3A2pL+hSCHlkxJVS2SBG5aGnky7q3YgzxrUfsRB4
 4zeYYoHIcjPDdrAN7XNwdPZyZ4rry/x9FLiQNsRJz81XEnWdPLu2IdSyTJpF5TQOoOqC
 Ib8kaJpvcJln7JCALsk/g0aomyMIwAC6YBV1Ktjf3FFQcMju3Wz7NEf7M6pUbTxOLdQV
 YyGsdj8OBAz4M61xqYP1OQsHyL04+8BqfF2fSfmzQNgxogHLdc1MLjwcvz7kVMW9vHHH
 Psvg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJmDrw9VvcjdTagNnLHJrEetfOeIx26nnGO3k7DvBIhFrFfNs//V+hw9AIgNx2JNvfzDxq52yHGb0d7W7rHaNp/aySR/Y=
X-Gm-Message-State: AOJu0YxYeKja2ZGs8CYl10CkNYZFHFCa9kyo2xDvMi/wD2UH+TWZKlTk
 ztBPrSN/2sa2gUYAKhQ7vPU01uUIsdoCyhKOHo6s7g4lMEBmnhVb/TYJZbnjHAg=
X-Google-Smtp-Source: AGHT+IF2lfq1g1mDC6lb0kjvbHybGIGzxUfi4kdn4UNke57GVKphjMB3QeEngXVM2IgWNF788di/tQ==
X-Received: by 2002:a05:600c:502a:b0:421:c8a:424e with SMTP id
 5b1f17b1804b1-421562cf387mr12831845e9.10.1717571437766; 
 Wed, 05 Jun 2024 00:10:37 -0700 (PDT)
Received: from [192.168.60.175] (144.red-88-29-107.staticip.rima-tde.net.
 [88.29.107.144]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42158149057sm9511375e9.36.2024.06.05.00.10.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Jun 2024 00:10:37 -0700 (PDT)
Message-ID: <b0278e40-5cef-4aa1-87b8-7450e988dc52@linaro.org>
Date: Wed, 5 Jun 2024 09:10:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 32/37] target/sparc: Implement VIS4 comparisons
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
References: <20240526194254.459395-1-richard.henderson@linaro.org>
 <20240526194254.459395-33-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240526194254.459395-33-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

On 26/5/24 21:42, Richard Henderson wrote:
> VIS4 completes the set, adding missing signed 8-bit ops
> and missing unsigned 16 and 32-bit ops.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/sparc/helper.h     |  12 +--
>   target/sparc/insns.decode |   6 ++
>   target/sparc/translate.c  |  12 +++
>   target/sparc/vis_helper.c | 170 +++++++++++++++++++++++++++++---------
>   4 files changed, 153 insertions(+), 47 deletions(-)


> +uint64_t helper_fcmpeq16(uint64_t src1, uint64_t src2)
> +{
> +    uint64_t a = src1 ^ src2;
> +    uint64_t m = 0x7fff7fff7fff7fffULL;
> +    uint64_t c = ~(((a & m) + m) | a | m);
> +
> +    /* a...............b...............c...............d............... */
> +    c |= c << 15;
> +    /* ab..............bc..............cd..............d............... */
> +    c |= c << 30;
> +    /* abcd............bcd.............cd..............d............... */
> +    return c >> 60;

Too optimized (or early) to process this :|

> +}

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


