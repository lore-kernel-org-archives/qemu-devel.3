Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C096EA8125
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Feb 2026 10:02:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vq72h-0000Yl-Sf; Wed, 11 Feb 2026 05:01:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vq72e-0000U3-VQ
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 05:01:53 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vq72c-0002v0-B9
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 05:01:52 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-43284ed32a0so4477954f8f.3
 for <qemu-devel@nongnu.org>; Wed, 11 Feb 2026 02:01:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770804108; x=1771408908; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YdaX87nfhFx2TkjX0IEkWUusdqHt1UqrUaA2Jx2HqGw=;
 b=ykgF7nznSVF0KilqfFlTxLBMn1GjcSBKphJGx0tB2UZk6YCoE3YID7NzDH0sLcvYGa
 YSuQJajUiNwZZh6lF1LMh4rqg46B98jGFTbgC3JEbBoguIWjhBEuyqNLYPEE1/wthIAl
 TWMKTwMbhNt+f5HSv9A0Ais/KPUuqPm3ozGd6n14QU9o2AtqHL9QUvRqE9gplHEo93mH
 oIF3qC0mVACnO37NKpoDUuv5PJoqNkx3T8iEvAIR04ra2BjxrZ/K1/dCE4Jdueuc1+N5
 QW6gtDKPx0CynNhs6IOEODaMU8Y13gvAxiEr85ygoY+mR9SK5dSNYOj+o5T6+0KWnC0/
 qOqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770804109; x=1771408909;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YdaX87nfhFx2TkjX0IEkWUusdqHt1UqrUaA2Jx2HqGw=;
 b=SNXZBwlw4xpdz7ndeS65YIIZI7QHqni+EAgolzk4fcWChdTzRjtuRRueQ+eyRo5lkJ
 PhU7R1n0inHp4oxUO4qFXJIGLjkM3tAP7M5kx1sE1ZaoVT3tbOcwlBjxsSOYtU/n8ZQT
 SRczcTsXaEq1AIz7YV1bB6HmWeDBe2eDc+zijFdjuG6Jpy/kCuH5F90nOvM/HwQxJ0Ee
 ltYASMNxjUEW8oMMtzUqhV2Wt00McDK1aLgPTJgBKLb3UghWQATBODs4Nki+LkPKdR9G
 35bwTvyajNBnGMxCcX06is8WPhgK9biOLXV54rEwXzeSGaiQSZqyN7K9v4mke3Eo4kX+
 4edA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUqQ4pKd5btfNcSZe7Ov0LF+kpSPo0wtBQDXGG8N9egaAIcpsp2jm4o4c1VewXrq45edC/scBDq3TnZ@nongnu.org
X-Gm-Message-State: AOJu0YxTVJBM2isddzG2YpwI6fbiuBnuIzGxc2e2kg/IiBOEdwmMt6Xn
 vRjYaWFRnF7fXgj6UxvudPbxFaJL9JLdfG/nQQNc4zPED81+01WoJAMBAOWO2tbcPYM=
X-Gm-Gg: AZuq6aIsS9n/sqGSXQZDglQ7CIFiwDgAVDlpeVCM7uMpwcJAlDZ5TNKzBn0NNV68bKh
 eI1PxNI2ylb/q2MwaNjvcZaBdJw/56tZGrhXou1OFsQP8bTVSfT6jhkiC3BE99uCoSBworIWCSd
 pEaQDQ/QIW/BT2Z997Jd/uHDSuPeWd6EEZZ0NW8ByQa+go0mC4zRfUDxtUzlWOU1ytdWw3PaQBC
 rYrXbcRLPZHBZHZ9ajS2W+LMulFXvQJDuMbRbDc9fDeHVsDyGDDZAv43eqKnTM7ztw+QbSN6wIQ
 LUNMNcNPuJqQ1Z9UgnX6i3cB4uuHwZSVexBGLUnPCSjmIeqLNeRPGjGHlQPpSMYiUwBS641VTlZ
 lKL/15EBuW0ybgfwEn8vecQ9IwPO/OTKY+M6kDGi1ryV7HfV2aMeBNisUcjDuTdHI9x3fPrdApP
 aL8lU4VIvxyjGMP4I97GdDS6B/g+K+US/LfRmDLFyY5D8do2499/0mOUXXT3jG8Llz8Q==
X-Received: by 2002:a05:6000:4014:b0:435:8f1b:bb32 with SMTP id
 ffacd0b85a97d-4378458f33amr2275625f8f.32.1770804108549; 
 Wed, 11 Feb 2026 02:01:48 -0800 (PST)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43783d30f6dsm3295998f8f.3.2026.02.11.02.01.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Feb 2026 02:01:47 -0800 (PST)
Message-ID: <0c097e5d-ac59-4043-92d6-95682ac0b05a@linaro.org>
Date: Wed, 11 Feb 2026 11:01:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/8] target/alpha: Introduce
 alpha_phys_addr_space_bits()
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, palmer@dabbelt.com,
 alistair.francis@wdc.com, pbonzini@redhat.com, gaosong@loongson.cn,
 maobibo@loongson.cn, deller@gmx.de
References: <20260210-phys_addr-v4-0-725a589e83c8@rev.ng>
 <20260210-phys_addr-v4-1-725a589e83c8@rev.ng>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Content-Language: en-US
In-Reply-To: <20260210-phys_addr-v4-1-725a589e83c8@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

On 10/2/26 12:33, Anton Johansson wrote:
> In preparation for dropping TARGET_PHYS_ADDR_SPACE_BITS, add a
> a runtime function to correctly represent the size of the physical
> address space for EV4-6 based on the current CPU version.
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>   linux-user/alpha/target_proc.h | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/linux-user/alpha/target_proc.h b/linux-user/alpha/target_proc.h
> index 71949d380d..6b491ffa3a 100644
> --- a/linux-user/alpha/target_proc.h
> +++ b/linux-user/alpha/target_proc.h
> @@ -6,6 +6,7 @@
>   #ifndef ALPHA_TARGET_PROC_H
>   #define ALPHA_TARGET_PROC_H
>   
> +#include "qemu/osdep.h"
>   #include "target/alpha/cpu.h"
>   
>   static uint8_t alpha_phys_addr_space_bits(CPUAlphaState *env)
> 

This patch can be discarded I suppose :)

