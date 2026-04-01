Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD20C10F6FBF
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 15:25:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7xRL-0007j1-BG; Wed, 01 Apr 2026 11:25:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w7xRJ-0007gw-JU
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 11:25:05 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w7xRH-0007No-R8
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 11:25:05 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-48540d21f7dso85459265e9.0
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2026 08:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775057102; x=1775661902; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EbFhyfU24SxFuFtara/3rsYp43hZ3HHEhhRVjtlVTpE=;
 b=LXLxo1+e9hrSmb28oUDa0yu3/pMhyNXKmxD/xQhplaiFpjnNzjQ5uDU5WEDHq+oTaX
 NXYaJzhMw7bedzXSRDNx1ciZmTSFKoUNeNXxi9fZsctPtHfx4QaI4nVi2IRQ1TTDmV+T
 IfzFPXiK3l90HFMXX/SLl7QgkgHKQkWpnDLchzKBtCOaAr3qx6Wt/w1r+XIqObRKEanR
 04bH8nm8h8hkQzyGlt68lgJLqh5RZnlH53BH+saMyRSkFsOZm+8BBIWZ1ZKEq9TW5thV
 cjSgqQlmEYpmYe+Gx+vTqIkX0HGW9kU0QfA+7QWv5E/QwyrGe2OPqpJm9Tfb19OLPCrF
 02UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775057102; x=1775661902;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EbFhyfU24SxFuFtara/3rsYp43hZ3HHEhhRVjtlVTpE=;
 b=VfkjXXCpnihqRjMDV1rdUDz3UkyJxuaeG3W45THW3UszgNMS/ovcM7KGT6oNDmF7zh
 VaWnUL4FrlpNMuUriqIv32Z4OOfYRkZOF80mIGqC2C28+tkwypFABkUSPQyiFUS3KHSo
 ubca5LZHiodkApFOr2qSQBzpz67DKmAqA81DcjULz3omWV0ih32q8k8+oTMzCwr8kELw
 8Q4wz7lEqMP4pXeZ7UShcEGmYrx8LX/xNLrgNaGWF4/L+KMenBl7BMfORBexD5Aay/98
 WqjKDuKYfHPNFmX/7/FaofPs+xKPVrWEyySmHmbt+x+zg5ZkQcZul/f3g5K7aFAsa/Pg
 tYcg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUM+1DY0PZzwYmSJTh5O8CYtTWqxImTZyibXt/mIhqxXtnlw+j8oAHUCD5I0QTG0ow5DgH2Z7Nzeo7k@nongnu.org
X-Gm-Message-State: AOJu0YwzePEUILG3P5Z6bINDFS+ckPGSR6MTQwt8WG7xKq0NAo9teShC
 soXEaDz/jIk7KOcf/TtmQrhBGsSUYV+m7JQnfC3TzQwYYaa8asEpbypBHOjsyD/xmxs=
X-Gm-Gg: ATEYQzzvCOwT2OLTbDwY8zEAqX9JRO5WBq6sFsi+fO/9b+kEEOt3ZNLoZvryLWUiBvP
 ZiBqW++2DOe8Kb2YXKkPxemaBB/Aa4eBMp0hKCp3CuQozCNUoJrMaTQ3OqypHWJ5jn/aCY1TwSz
 Q8thHmCnEyc/aMgpJy1EDotE1BVDrk31OEjC3t+d5oniDEAKqFHGufMkge2jTWMlgnHW/Gse5fO
 zaQ/f+ICynV2zjDWDUTFhohMvBP5WTqZzsrhUYR3nDyLrkZZUki1b3Ki9eMJuE6gHuAi2w5F+/k
 JEOutPNXNI3RCAD/pUACrnQtsreJY/38Q4Q8i5wmRVSlgYgophed1za9yjk5WsC+tG52S2MCJRg
 CTbX/XFvkDc71FeQcH7udCZ4Isyc/cf0PREpewXs0TMLCSyKlyMTXP60nLvyICBskCaswpsMJNI
 FcQ14lF/Tw/H2WNSkZ5814Ku/cAwklO1akPdjqculVxBn5AUJexJSzk80Ht4SLnUox0g==
X-Received: by 2002:a05:600c:8b55:b0:485:4526:ee06 with SMTP id
 5b1f17b1804b1-4888356755amr72738015e9.11.1775057102056; 
 Wed, 01 Apr 2026 08:25:02 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4887aecf6e6sm45750335e9.13.2026.04.01.08.25.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Apr 2026 08:25:01 -0700 (PDT)
Message-ID: <ef60b37d-b9ef-47c1-b641-fee37d257cef@linaro.org>
Date: Wed, 1 Apr 2026 17:25:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-11.1 1/2] target/mips: Expand TCGv type as 32-bit for
 XBurst MXU
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Aleksandar Rikalo
 <arikalo@gmail.com>, Anton Johansson <anjo@rev.ng>,
 Siarhei Volkau <lis8215@gmail.com>
References: <20260401144503.80510-1-philmd@linaro.org>
 <20260401144503.80510-2-philmd@linaro.org>
 <03df34f1-674a-4e52-bd22-ad77e7884b6b@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <03df34f1-674a-4e52-bd22-ad77e7884b6b@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

On 1/4/26 17:00, Pierrick Bouvier wrote:
> On 4/1/26 7:45 AM, Philippe Mathieu-Daudé wrote:
>> The MXU extension is only built as 32-bit, so TCGv expands
>> to TCGv_i32. Use the latter which is more explicit.
>>
>> In gen_mxu_s32madd_sub() directly expand:
>>
>>   - tcg_gen_ext[u]_tl_i64 -> tcg_gen_ext[u]_i32_i64
>>   - tcg_gen_concat_tl_i64 -> tcg_gen_concat_i32_i64
>>
>> the rest being mechanical changes.
>>
>> Cc: Siarhei Volkau <lis8215@gmail.com>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   target/mips/tcg/mxu_translate.c | 1954 +++++++++++++++----------------
>>   1 file changed, 977 insertions(+), 977 deletions(-)
>>
> 
> Yes, it's the kind of changes we should do, but as you see, it's quite 
> invasive and produce massive patches that can be hard to review.

I just mechanically did s/_tl/_i32/ and s/TCGv/TCGv_i32/ and build /
test the result, not looking into the details myself. If I respin I'll
split this patch in 2, changing gen_mxu_s32madd_sub() first then
describing the sed command for the rest.

Such mechanical changes are expected to be done once for multi-wordsize
files.

Still a long way to go before moving these files to mips_common_ss[],
due to the various target-dependent uses in "cpu.h".

> That's why I'm more in favor to keep TCGv and all tcg_gen.*tl as it is, 
> and add magic in header to compile it as expected.
> 
> That said, there is nothing wrong with this patch, I'm just questioning 
> the approach for all other targets.

This target is very old. Maybe better would be to first convert
target_ulong -> uint64_t for 64-bit builds, adapting translation
code for 32-bit ones, then convert the remaining as uint32_t.

 >
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> 
> Regards,
> Pierrick


