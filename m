Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35497FB5168
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2026 21:31:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w9rXR-0006gZ-QC; Mon, 06 Apr 2026 17:31:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w9rXO-0006fD-93
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 17:31:14 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w9rXM-00089m-DK
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 17:31:13 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-82ce0a9b41aso1581688b3a.0
 for <qemu-devel@nongnu.org>; Mon, 06 Apr 2026 14:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775511070; x=1776115870; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EIcnYQb5Pncbbl/RfKqnVG20nKP0TFCzAW8+hu83O7M=;
 b=CaSEPACgVrleoyGgJ5n8ngK+7bUUXrg2l1zf7vhuzB6SEFWtJ2HKGg48Bpo1Asg9qe
 mFWbR5FfZ6WhqEpBkbWKK5QT9Ekjqxyw+DU5R2TDljwaPN6rhRLzhXFggOFJ919SSJ/Z
 xT+IsLRIUlkw4VZ5NRfLzgdG9+CGhxiRCWebTKXU1s2qP5SH2sm+4IloIDYYj0QQfawa
 s9KerYfD7Acv38bAlqkg3M5Nn+VQCQH4cvD3/+Gx8+zGt01Rtsj1fYJk/SwgXNjS1Qv5
 JDqTu1BDjn9bl18qDGI719Wl2BCgs6wBPrcgugY+WAjR2MlqVtQZcE71GoJ5eYZR9sL7
 LPtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775511070; x=1776115870;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EIcnYQb5Pncbbl/RfKqnVG20nKP0TFCzAW8+hu83O7M=;
 b=mj0dKrOtsQlLQa68mjAIy7c3zs6QwCrqcbdnJsOHzA8H/W8UMbxTu0wEVfSJTrAVRb
 3sRdh9JaAY2TEoCUwcD0lG/BRvkCQVMWhTuhIH7t59f9iKv9L82dz9hO7U5SCx7OEuGC
 6Z5z1eXUohJOVo6ju+JQHdpgfMfd12Ixp4qT0MWVEeCnme7Yfoe+r5OTp0jcb7cHJhB7
 vNa8mKiEYPkne9+sGWxQLBA497TtAmELHocF4vC1pDQwE/QAG/h3dWBmOkbGSJLNohiu
 Gym8D5RTO90EusPUMF27qo6VBmz2uvOkJdBkYwPwDIdGE5DOfC37IDRWdK1NRpyUjhbw
 fzrg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJNJRxz2FqiT7w9KyfbC3MJQAL5kE6ssRoom1IEiiTsdPQeaQiNWGI53+LgflQpvQHVzgZADM0iZSt@nongnu.org
X-Gm-Message-State: AOJu0Ywk+bNS4xB1OQlyOw8Ne4KHlsooEm0rCvVF6kCHWVxMGjYc0LrY
 uorvW/VD2D+TbPNp37bykWQVczXQyDP7yf5NK2XuGsmd2FUz1q9uzNq7SWn2707O0yU=
X-Gm-Gg: AeBDietmnq7EX2sV+66BI2CVICwam2tQ374dAAbp3U3PFGdeIsZUlnlTmQ9tJGIS9rP
 2lwT/tqCBu24LRzGMi73C3jfVSFn34niTWXXPLHvEFPKF7Xb5B/v94EqG4tDHnSTypLTqU0N9as
 qkGgt/5opJvCETZCRQ9tSYQJ2uBQK1xIqoWZkYfdFtHbcktwYwpyroBbatrFvPnbnH2bLBMGwEi
 drjK5zgHMDl+090/Z4R6/XUdtU62NGNifphbfECHLD2itEkRtonyOOb+F0iY5saeHgKW5jyrukv
 6tqcudsIweBqg+8WiSGh74L0PIikMn5IiJ8MbEwD64N41rKB5jkQo2AqDJ2JH6cPcuzI6ynXPga
 4HCYPdnDKvjosXxPcw/l6Ml45g+6lHLZoGJPPEXyhp7kegdglEZlvfNZMp8M0FwV49pDRdZMLRd
 OSlGxFpi50sgqfr0DYzrTFZAQ0I43A0ytHCjk5mXO44+S88DckGoCBL1dSgyeJB8lYb3E=
X-Received: by 2002:a05:6a00:1405:b0:82a:fc5:fb81 with SMTP id
 d2e1a72fcca58-82d0da44b0fmr12988438b3a.5.1775511069914; 
 Mon, 06 Apr 2026 14:31:09 -0700 (PDT)
Received: from [192.168.1.105] (124-150-69-109.tpgi.com.au. [124.150.69.109])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82d11f76c09sm10881966b3a.55.2026.04.06.14.31.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Apr 2026 14:31:09 -0700 (PDT)
Message-ID: <c7a00ec3-2a75-4c90-ae7b-7ce16db05d85@linaro.org>
Date: Tue, 7 Apr 2026 07:31:03 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 14/20] target/arm/tcg/translate.c: replace TCGv with
 TCGv_va
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, jim.macarthur@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>, philmd@linaro.org, qemu-arm@nongnu.org
References: <20260406182609.193886-1-pierrick.bouvier@linaro.org>
 <20260406182609.193886-15-pierrick.bouvier@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260406182609.193886-15-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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

On 4/7/26 04:26, Pierrick Bouvier wrote:
> @@ -6881,6 +6882,7 @@ void arm_translate_code(CPUState *cpu, TranslationBlock *tb,
>       DisasContext dc = { };
>       const TranslatorOps *ops = &arm_translator_ops;
>       CPUARMTBFlags tb_flags = arm_tbflags_from_tb(tb);
> +    TCGType addr_type = is_a64(cpu_env(cpu)) ? TCG_TYPE_I64 : TCG_TYPE_I32;
>   
>       if (EX_TBFLAG_AM32(tb_flags, THUMB)) {
>           ops = &thumb_translator_ops;
> @@ -6891,6 +6893,5 @@ void arm_translate_code(CPUState *cpu, TranslationBlock *tb,
>       }
>   #endif
>   
> -    translator_loop(cpu, tb, max_insns, pc, host_pc, ops, &dc.base,
> -                    tcg_default_addr_type());
> +    translator_loop(cpu, tb, max_insns, pc, host_pc, ops, &dc.base, addr_type);
>   }

This is wrong.  You set TCG_ADDRESS_BITS to 32 in the first hunk.  You're generating 
32-bit addresses in gen_aa32_addr.  You cannot then set addr_type to TCG_TYPE_I64.


r~

