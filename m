Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D513CCD4F3C
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 18:08:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPOrl-00057b-3n; Tue, 19 May 2026 14:08:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPOrZ-00055c-JZ
 for qemu-devel@nongnu.org; Tue, 19 May 2026 14:08:19 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPOrX-0005zb-1b
 for qemu-devel@nongnu.org; Tue, 19 May 2026 14:08:16 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-45e8a834cc2so881890f8f.1
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 11:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779214093; x=1779818893; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JiNTlDG6Krf+4KhEqO8QCMfyaJNaB9fJlmVf05Ir97I=;
 b=YjDEn+cThUUdbQC8uVBuHXdTNy/6MOgcXUt/UYqhVKKz5GSi7GK19xmxVIKN3QlzXw
 BbKn3CB3nxgxn7XkaGaL62OLt6IbmLddx4qKVBpiL5C0RsA4emdKSxlJV2JorsJiCtRd
 KREc0apBHW79ss1HVJsCP4zU+FUrWvSWnKDP5G6v/HF7VKTbc5JvZhVRoWd8hl7SptzR
 ultBZ9W/xbOHXl9zvyybxN/dv8qjjd2N34WB5vv3Tabk/ucKCaBoy5O4SxGD+jDPabgq
 JGgucSkux5IDed2BZGsQfbo1Cf2Ag0EqRxXafYDdn3qgrSe4RwW90oZGcV3hq/eU0j04
 PHlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779214093; x=1779818893;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JiNTlDG6Krf+4KhEqO8QCMfyaJNaB9fJlmVf05Ir97I=;
 b=ma8gQNN7bnG85ppJcA4Hyex+6mMW16TkbicNaCessx7Jl6izGPY1v36Tn49DD6zCb/
 R24JCq0p6UvqvoJP1n+uj69bWoekKhtp5FYvuWU+mrMHIPwqSAJ32RoKpCogUy2TJh1L
 UKkWas8vE2sm3jc2PkquibvGdq5Au+0p7HNFPwQyj39+Euo2j/2MYonLt8i1etvCstX8
 0xftfFL3igKYwy5yUBka/1+NNxk+BjDYP6fRHxzNyqIHKHfFhxo7eRE16E0bFoN3xh2Z
 tli0oXOIHtCd491PYPDCUh/lHwLGxrMtc0lXh6cHpvKDgwIOqq9vmp+SdhGQ7ACK3qTH
 TLGA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/YNuY5M+8jr0Hc1lFPDSSI66A/GqDJzIPMrDNF+8u2xf+V/UeGHhpRJ4kz01pzV+tk2lBrFnyPlcKy@nongnu.org
X-Gm-Message-State: AOJu0YyBxee6WVnmax+Fz9eSIhglvScgLMg0nFrqC5R90rz/fM4SU10J
 M8rXWY0n2/4/NvSXyjLSmQ9Bxn5i8SKec0Yc3FNCuzvZpHqJ9O9HkS+lGY5yxRbpGuIpVrmb7fR
 2tqewP+E=
X-Gm-Gg: Acq92OE+CbwF1DSHk8jqIxU9Cp/LsJ6V/x5LdF/vDM78X0z48zVRnA1RwC9cfZ9FvjI
 x1Wu/3qm5J3whBnszVbUMLnou7qa21/FQGCN69xSNHzEyEIMVTR8Z9aLCmJ8DUR49SD/6pJ9qp5
 Q4HaRNHoRfSh2aoAl2SAg6wcvEZvGiMrKL/Yg6JtO6QVTBul0X//Xwl54wxl1Ie8/gqYjiUzc67
 8CI5+DDI4mZrStvf6rIw+3/6S/aHCCrPsgSftr21bFKSsRfFAHwO94D0cbxrXEZ84lVCbZIsh4C
 F5SRr9VqhSbtVv05wBWLhzHAhNteS/Y3rFPu4wdczePyszhtwoOf+OL9Wsc5HGAs4FdU8Duo6xm
 KEH4LS6UuxEiuHqPc+ME2NfidBBadDCOOvXr6xCv7nGX3GGGZvN6tQQuX9FnBd3z8TZkOBLacdp
 uMYHbBYTh7ocnYkT7/V4vAIYNo4bS53Vde79pg6ODrP9Mzy2BEaUxvxhxYL80dhezvcGJ1C7jqH
 6rJ
X-Received: by 2002:a05:6000:40df:b0:456:f186:7af8 with SMTP id
 ffacd0b85a97d-45e5c35e4c5mr33893537f8f.4.1779214092895; 
 Tue, 19 May 2026 11:08:12 -0700 (PDT)
Received: from [192.168.69.200] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45d9ec3b18fsm43871721f8f.11.2026.05.19.11.08.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 May 2026 11:08:11 -0700 (PDT)
Message-ID: <6ab23735-dc5f-43f7-8ec4-c9af11f2af47@linaro.org>
Date: Tue, 19 May 2026 20:08:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 19/40] target/mips: add Octeon VMM0 instruction
Content-Language: en-US
To: James Hilliard <james.hilliard1@gmail.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Jiaxun Yang
 <jiaxun.yang@flygoat.com>, Aleksandar Rikalo <arikalo@gmail.com>,
 Huacai Chen <chenhuacai@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20260519-mips-octeon-missing-insns-v2-v9-0-d7dd735ecddd@gmail.com>
 <20260519-mips-octeon-missing-insns-v2-v9-19-d7dd735ecddd@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260519-mips-octeon-missing-insns-v2-v9-19-d7dd735ecddd@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

On 19/5/26 18:22, James Hilliard wrote:
> VMM0 multiplies MPL[0] by rs, adds rt and the queued P[0] partial
> product, returns the low result, and feeds that result back into MPL[0].
> It sets MPL[1] to zero and clears partial products.
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> 
> ---
> Changes v8 -> v9:
>    - Reuse octeon_zero_partial_product_state() for partial-product
>      clearing.
> 
> Changes v2 -> v3:
>    - Split VMM0 out of the combined Octeon arithmetic and memory
>      instruction patch.  (requested by Richard Henderson)
> 
> Changes v3 -> v4:
>    - Document the Octeon3 chain update behavior.
> 
> Changes v5 -> v6:
>    - Zero MPL1 after checking the CN71XX VMM0 definition and add
>      MPL1 smoke coverage.
> 
> Changes v7 -> v8:
>    - Use Richard Henderson's v7.5 inline TCG translator, which keeps
>      only the architecturally defined MPL1 and partial-product clearing.
> ---
>   target/mips/tcg/octeon.decode      |  1 +
>   target/mips/tcg/octeon_translate.c | 16 ++++++++++++++++
>   2 files changed, 17 insertions(+)

Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>

