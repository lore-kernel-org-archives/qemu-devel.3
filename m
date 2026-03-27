Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 416A510F2865
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 18:15:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w6Bhs-0006gP-6c; Fri, 27 Mar 2026 14:14:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w6Bhn-0006fq-J2
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 14:14:47 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w6Bhk-0003cU-Ca
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 14:14:46 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-35c1a131946so1634623a91.0
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2026 11:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774635282; x=1775240082; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=UpUlpBMrO0Xp5fBIArcey0F2IowdIlSjZ1XWu7eFzrw=;
 b=hG/3krcs9frBBRKlAzyHlvo1RfyBpDIhuh9Gz9u8zX+nO0qWNPD5nqLdcLkaC9n2dF
 znZ4Z1E0xJ+cLqjUr8l/oJ/97iE6BNlcleR5LzbOMXpFntQf7oO8nRwy7h0hZD3124tI
 ++6fzRbpR9ZglPkRmJxEzCiLDxh4N76IHDYD+iVvlTT8pKcXuPz1OTneow/DcmIIvRsU
 UHTkWOw0/W4+zeq6QU65pNaAKhlRZXu1SdlypEej9hCjHCP0fMpiEat1Tfk0BOO1qlS/
 iCXvi5xyWRdvvQrDyKjrcFHLq4HPsAE2BMTDHPMyhmiXuZUJt/knwSHzlTBBJw300rm4
 nVGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774635282; x=1775240082;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UpUlpBMrO0Xp5fBIArcey0F2IowdIlSjZ1XWu7eFzrw=;
 b=Dke3E+lAD6nlRHxWcS08/bn/2zW35c3bKlGyYl3MePX5y1iVs52ah0EcXvpJ+NLbgF
 heyxJEgA09m7JfG34xyPa6JGLGEsLS0MN6U0NxZsbWNFwrU74nxkp7AIiHDpQYnIVLCo
 Fsi6kK1upMmG+e8z9GnRSZ0SsqiSDW6o0FyI/lMTAfUKl7+wDr11nNqgFfYw3HsA6064
 MNIchd5kmbUlgCUk980MRgsqEJ9VtwN/mImbyoTdJ+kT+DxIAc0h+vg52L/2NHACT2/G
 mzsUjR1gjIlbk3uz5zWZea7qTY/5RvrZJQj4GyDw9qL8B6prtsHu5EvClmWUck1gwYcd
 O2Ag==
X-Forwarded-Encrypted: i=1;
 AJvYcCWf1gaudD8yyVNsVTYFVfmthaTRI8WEnIDqkH85HZ2yt+vV4FMHkaQV7SifaTUcESxrmD3sae9Z+WRF@nongnu.org
X-Gm-Message-State: AOJu0YwBn7sft5C8jm143lEJxe2Xbd79o781muA8J4o/t2rPjYpHVvf3
 G38Yshuerv8arHs86io9JILJ5Y65ysGwjh3b3jct/eF7XZ9+KcHVP1h1WP0t0xOaw4k=
X-Gm-Gg: ATEYQzw91WsUMHoTggbHZFaGsew4MSQDICjnmte2YNTOCIBi+7BVk45bZsKvkQyWXPl
 fh615xQm3IVkGYlSR8TyfrTCGdab/F/hnI00iV2SuG0hcpGH4lXQ9kGpUf12Y3cSVe+aXRrpp6c
 5yiIpwVNOwxPTRDuTdYXBBEHqzduYBY33ZQ7A15kYWUr0BR7AxWTUP0M0VZVOpX1yod74i6/aq6
 VZMSchvwFjVAcI1SFO9xMB0NB3PleEoZcIpJbbGecGx48vFf5ubGG3xlQ+GC9zz4QHby3mujDB7
 f/n9vlMF6GkSNi4irbcOBtX8lFxOUnhwFqI7KCJQ6t1hzBkNB/U5k4Con0MJnluel5fCJPjCa8O
 tsyzAxbpHb+OXbph8Bx5nI5P05QPEbjhSuZ9GBw5oNonGh0gP4JTWE98NjI89HxaoATUy6jWmur
 Nu05eu7F3dIPqOQHpTK525T0diBsP6fH4OpNd6vzgZjNnBoR4zoxwneqSDwJ0hYcmU2FTJ
X-Received: by 2002:a17:90b:3d81:b0:35b:952c:43ab with SMTP id
 98e67ed59e1d1-35c30bb5f2amr2655461a91.4.1774635282483; 
 Fri, 27 Mar 2026 11:14:42 -0700 (PDT)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35c22d09573sm5485994a91.16.2026.03.27.11.14.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Mar 2026 11:14:42 -0700 (PDT)
Message-ID: <086310e3-2d6e-4b9e-86f6-75b7fe936d81@linaro.org>
Date: Fri, 27 Mar 2026 11:14:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 12/12] target/arm/tcg/translate.c: replace target_ulong
 with uint32_t
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, jim.macarthur@linaro.org
References: <20260327165042.604105-1-pierrick.bouvier@linaro.org>
 <20260327165042.604105-13-pierrick.bouvier@linaro.org>
 <9a7be223-0b30-44e0-b6da-fcf614a1a052@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Language: en-US
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <9a7be223-0b30-44e0-b6da-fcf614a1a052@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102f.google.com
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

On 3/27/26 10:30 AM, Philippe Mathieu-Daudé wrote:
> On 27/3/26 17:50, Pierrick Bouvier wrote:
>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> ---
>>    target/arm/tcg/translate.c | 4 ++--
>>    1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
>> index 4546bbeeeff..204f9657993 100644
>> --- a/target/arm/tcg/translate.c
>> +++ b/target/arm/tcg/translate.c
>> @@ -6450,7 +6450,7 @@ static void arm_tr_insn_start(DisasContextBase *dcbase, CPUState *cpu)
>>         * fields here.
>>         */
>>        uint32_t condexec_bits;
>> -    target_ulong pc_arg = dc->base.pc_next;
>> +    uint32_t pc_arg = dc->base.pc_next;
>>    
>>        if (tb_cflags(dcbase->tb) & CF_PCREL) {
>>            pc_arg &= ~TARGET_PAGE_MASK;
>> @@ -6612,7 +6612,7 @@ static void thumb_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
>>        bool is_16bit;
>>        /* TCG op to rewind to if this turns out to be an invalid ECI state */
>>        TCGOp *insn_eci_rewind = NULL;
>> -    target_ulong insn_eci_pc_save = -1;
>> +    uint32_t insn_eci_pc_save = -1;
>>    
>>        /* Misaligned thumb PC is architecturally impossible. */
>>        assert((dc->base.pc_next & 1) == 0);
> 
> I'd have expected vaddr, but uint32_t is correct enough.
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 

While it works, semantically, in this case, we know this addr is 32-bit 
only, even when compiling for aarch64-softmmu target.

