Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86101C83F1D
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Jul 2025 12:41:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZqZx-00084I-Hu; Thu, 10 Jul 2025 08:40:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.savini@embecosm.com>)
 id 1uZqZg-0007ub-G6
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 08:40:33 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.savini@embecosm.com>)
 id 1uZqZT-0002y7-FU
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 08:40:25 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-453634d8609so5615245e9.3
 for <qemu-devel@nongnu.org>; Thu, 10 Jul 2025 05:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=embecosm.com; s=google; t=1752151212; x=1752756012; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=fFAixc2IVhct2f5FPT8hD4WHQxFkfeRsELFBXN6maqo=;
 b=TmdTaOnPDkvWRA7MEKPTznP9SPCcBwslTknwmiFD3icKsCcq7cIC3+rIYOY7VkOxxb
 Ilz059sK5/7Lq897IpIgQze6GSmUxX7J4gWIYK4Nw9VBpRS2C+EeBavoB3wowSEY1QhY
 8idc+eJHksCWqjWqibinvGESbzs4uQeS+VtneOs+gg6ty1C87dWbq7YP1Co2LYM+XVrX
 MFBA3tBIujZFAZW5EnIelgZYHo/9MRM0FmghozJurTPwPRbErijiTmH7iVY4hC/VaELh
 J4YX78tv0qljYTno8Eu3AFOLId7yrv84NF5tHQYoB7zNA4P5i8+u8aI+i18qY7ZWaTI/
 EB3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752151212; x=1752756012;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fFAixc2IVhct2f5FPT8hD4WHQxFkfeRsELFBXN6maqo=;
 b=nEelXEIs+yRl8kZmlp7Np3dGKK1ABLF1gd7XGulfuU9N/165oGIwah69bXhRrc0+zB
 It1fqgo2ZxqdqWjzvbZUa7f+R8oc9X6yKYvdedDOADo/zL72w76yzjfpXQYr6RFEydZH
 PeP7UhaKZ56AMys4CtnLR7p1yypk02agGvAWcG7bBIQ3FnM159sAPNuSg1689spS3mB8
 dlzPgouLB1fG8BVYMXYpfu7DVty2kVj+BNI9mX6lkmBXQO9+Vv9oxyKMIz7JauhuWXwz
 45AuuHgcCjU7BW7bXZRaca64ItNqlgRzyFPoyimHq24Mi9CAjs+S+TCXjWyyxW5nJB4u
 m3Ww==
X-Gm-Message-State: AOJu0Yy06gSI7gZgOxz1E6Py6mpDRyoaej0qAeXuKwsyd8FNAkuNjQ8+
 XUze6EmSC/WeFsVDDjZZU+iKQ3mitKVlabMuRxIefeUkqS/IIoniSECKdAN1urlbdMg=
X-Gm-Gg: ASbGnctZExrtM7SSdIVsbBs9Re7wGh0n4qFDCKDs0naq1qd6HEaLA25k7/1+I99T+i/
 sqGhPFmXY9A0fBZn8oC/GsEPX44i1CGc9hzOYOefQZL1SIE5PAtD7erEPwFV452CKI7NGc9/rVN
 tMEPobBSJN5ccP/Mf6WzX0nyUVd/NAhTRDJXo6A3bZDNt8cHiICkvdH1KLSd2A7ZT3YsU00Dlhq
 In3qZIkdV3GeABkaPTmNBm7YMhQh8llsmAtofXpdjQeIclVD2D4QrSyBhm2L8KrNh6yKpZSuYrQ
 vFqT5PmbEc/7+ShkwH4pWh2mEjVIPMr8uvMb+MjS01M7gUYCeMx7BiFADyeOpRxHui6cJ8Ur
X-Google-Smtp-Source: AGHT+IF9SY4zgzx1mugWC/GwsZRo5m7O4yiC85ZyKgXt3NK/MYnsqUVOiUzfvb9o9iy3Y4pS/C6S0g==
X-Received: by 2002:a05:600c:6209:b0:442:d9fc:7de with SMTP id
 5b1f17b1804b1-454d536ca04mr58322035e9.22.1752151211884; 
 Thu, 10 Jul 2025 05:40:11 -0700 (PDT)
Received: from [192.168.0.172] ([212.69.42.53])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454cdb549absm62803745e9.1.2025.07.10.05.40.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Jul 2025 05:40:11 -0700 (PDT)
Message-ID: <613da8e2-f443-48b0-8686-d79855685d7f@embecosm.com>
Date: Thu, 10 Jul 2025 13:40:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1 v2] [RISC-V/RVV] Generate strided vector loads/stores
 with tcg nodes.
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Eric Biggers <ebiggers@kernel.org>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 Richard Handerson <richard.henderson@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Helene Chelin <helene.chelin@embecosm.com>, Nathan Egge <negge@google.com>,
 Max Chou <max.chou@sifive.com>, Jeremy Bennett
 <jeremy.bennett@embecosm.com>, Craig Blackmore
 <craig.blackmore@embecosm.com>, Ard Biesheuvel <ardb@kernel.org>,
 "Jason A. Donenfeld" <Jason@zx2c4.com>
References: <20250312155547.289642-1-paolo.savini@embecosm.com>
 <20250312155547.289642-2-paolo.savini@embecosm.com>
 <20250710052824.GA608727@sol>
 <9ded37cf-cf57-4b6a-aeb7-6edf8ea1d7f2@ventanamicro.com>
Content-Language: en-US
From: Paolo Savini <paolo.savini@embecosm.com>
Autocrypt: addr=paolo.savini@embecosm.com; keydata=
 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
 WO+4yYga5w4c1oauMgX/IccT3awBnCU=
In-Reply-To: <9ded37cf-cf57-4b6a-aeb7-6edf8ea1d7f2@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=paolo.savini@embecosm.com; helo=mail-wm1-x32f.google.com
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

Hi Eric, Daniel,

Thanks for bringing this up and for the reproducer Eric. I agree we need 
to revert. Thanks Daniel for taking care of this. I should have time 
this month to fix this and send a new version.


Best wishes,

Paolo

On 7/10/25 10:54, Daniel Henrique Barboza wrote:
> Hi Eric,
>
>
> Thanks for the bug report and the simple reproducer.
>
> Paolo, I'll send a revert since we don't want to keep Linux broken and 
> to give
> you more time to adequately fix the patch. You can then re-send it as 
> a v3 in
> the ML.
>
>
> Thanks,
>
> Daniel
>
>
> On 7/10/25 2:28 AM, Eric Biggers wrote:
>> Hi,
>>
>> On Wed, Mar 12, 2025 at 03:55:47PM +0000, Paolo Savini wrote:
>>> This commit improves the performance of QEMU when emulating strided 
>>> vector
>>> loads and stores by substituting the call for the helper function 
>>> with the
>>> generation of equivalent TCG operations.
>>>
>>> Signed-off-by: Paolo Savini <paolo.savini@embecosm.com>
>>> Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
>>> ---
>>>   target/riscv/insn_trans/trans_rvv.c.inc | 323 
>>> ++++++++++++++++++++----
>>>   1 file changed, 273 insertions(+), 50 deletions(-)
>>
>> This recent QEMU patch broke the RISC-V vector optimized ChaCha20 code
>> in the Linux kernel.  I simplified the reproducer to the following,
>> which had its behavior changed:
>>
>> rvv_test_func:
>>     vsetivli    zero, 1, e32, m1, ta, ma
>>     li        t0, 64
>>
>>     vlsseg8e32.v    v0, (a0), t0
>>     addi        a0, a0, 32
>>     vlsseg8e32.v    v8, (a0), t0
>>
>>     vssseg8e32.v    v0, (a1), t0
>>     addi        a1, a1, 32
>>     vssseg8e32.v    v8, (a1), t0
>>     ret
>>
>> Before this patch, it copied 64 bytes from a0 to a1.  After this patch,
>> the bytes at 32..47 also incorrectly get copied to 16..31.
>>
>> Please fix this, or else revert the patch.
>>
>> - Eric
>

