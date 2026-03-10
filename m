Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0B05EB1049
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 10:55:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzujh-00082F-BM; Tue, 10 Mar 2026 06:54:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzujd-00081h-6T
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 06:54:46 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzujZ-0002zy-Nj
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 06:54:43 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-439f5abc829so147881f8f.3
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 03:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773140080; x=1773744880; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Bo5b0kCSFpv5piIh9Osb+Tl/gwV3f3IFIuxtCUG9gD8=;
 b=U+oKP4V9eXNj5pz6i2W+JxxLNP8e9IMmlzl0uruO1b+7p8Waf8QzWDlFNcW/m0EAsR
 UDOkhSquIQUA4IcJgN2bJp+Lv5ggC0VFQjjfiYP4svVGJCpdG2bgvYK4NzVKrF+p7Gv7
 VEoKKUK4+JQgXZb2mcOkJ3AcyJ+b2SBtIaoJk7B8D46VhKXyws7AvrwbP2qS03XoZa8a
 cBOLzxzvoi8YC8xa1Mwn1B8JklnGxU54uEiRCdI93sV9w73FLfC2P71Ol6wz7QDGh+pt
 uofPxRTKll4IWcYIfTAJwvMpHVElh3tUc58VLt5K5/8i0kvablC1zIoQYHdQWW6A99Op
 ZU6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773140080; x=1773744880;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Bo5b0kCSFpv5piIh9Osb+Tl/gwV3f3IFIuxtCUG9gD8=;
 b=O0AaacCAf7UcglcCA6VdnIVj9p/qlSGdZp30Phkzt+blpMfL3aT21PIXi4HmY6sq4Q
 fO1YfGxyh7EHPzEt4NfawAUhE1JpG5aEOK0Uw6XmQYvp0LztkxDanjAR8tl5YrLUe6Kb
 3v4orqzvqyk0iSih/qwIxyHSUW85GWT/TTCnhU+dqveVzhPfUkEqDCGWjLii9CjhXvu/
 6ZzwTGvTGntSMiPvj500X5uqCQ8sdFgHnJ65YT/Fmr8pwqtypsg3//hkocmlW15pd/ru
 bVii8MgYJmNcr/hUgSpwLPfQd1IdUbV8wyCNvEW8/oVDxvMXQa/8HuAyxnnTPhEgEVUQ
 5e3w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVxa4FrMC1tbYahKQFEcv3+3LCmLiDmrOJ6pbq07pclMd45kvX1uhyXdpDCnxHw4iaHSukzPK1WmDox@nongnu.org
X-Gm-Message-State: AOJu0YxbsrMwu7ExxaSsl6QXQ0jXghDN42ifWTFY+GA68eadIN8B4wju
 nCnBPD9dRxyolajhD0Lrg6vjQL3KfTFwB0hGAdSkVomEZQuTgJlVqlAdn8t8fu10pr8=
X-Gm-Gg: ATEYQzxyaxH6beDeefb47RPzUVJ3ZzYarSquEGdl2U23TxrYPjUy+iOzEyIOtQDhHLe
 NI/xE7J+GYolW6veTW3Hq3sJ/qkhRx6pTy4ug6wIXzU9+j2lO8vgrMU5SKGvbtm4g4aTi2dPoM1
 z/ng/PtJJ5HA4KISxdMujeOYTsoH4pr/NzWumS3AMsqikve+2TUilO6IUTlEbDgUV8K/gl8E+BH
 Bi+7aDyiN++WPRG3dz7eLLpFKRpV4+ZmMmufLIK9sJR9iKxmppzTpPPgu9CZLDv21srjMm/MrfW
 toXvQn2DNgo0c0KR0KxvORkrIHwAPh9fp/lwMhKAyBvdH8iXZvJFEeJxtFN3mKqw+pLk7mmLKmd
 /lmJimNrOYPih8tzAba6/6kG2LCuUR9n8tgyq5IsYjfxUIx10hW6dZLloNraff6A/xMzKlj0s0c
 q/VgoopAvhEw3ulC/JigptqqXGcIig6Rt9psXFyxBAu/0lNEsBLXwZcciIjX3ygzt4AUPeSlzBD
 bBH
X-Received: by 2002:a05:6000:178b:b0:439:bce5:650b with SMTP id
 ffacd0b85a97d-439da662035mr26282212f8f.18.1773140080044; 
 Tue, 10 Mar 2026 03:54:40 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439dada9116sm32368600f8f.14.2026.03.10.03.54.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Mar 2026 03:54:39 -0700 (PDT)
Message-ID: <518117ad-777a-4bce-ab9e-cdfaf360d81d@linaro.org>
Date: Tue, 10 Mar 2026 11:54:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 12/12] target/hppa: add 64 bit support to gdbstub
Content-Language: en-US
To: Sven Schnelle <svens@stackframe.org>
Cc: deller@kernel.org, qemu-devel@nongnu.org,
 Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>, Fam Zheng <fam@euphon.net>
References: <20251223155031.7110-1-deller@kernel.org>
 <20251223155031.7110-13-deller@kernel.org>
 <52cbaf6d-f7a4-4984-9561-ca31418cdc0f@linaro.org>
 <87cy1cb2s8.fsf@stackframe.org> <878qc0b1uj.fsf@stackframe.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <878qc0b1uj.fsf@stackframe.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

Hi Sven!

On 10/3/26 08:06, Sven Schnelle wrote:
> Sven Schnelle <svens@stackframe.org> writes:
> 
>> Philippe Mathieu-Daudé <philmd@linaro.org> writes:
>>
>>> Hi,
>>>
>>> (now merged as commit b2c2d00f48cc5f4486cfba33b505ff86d79cb137)
>>>
>>> On 23/12/25 16:50, deller@kernel.org wrote:
>>>> From: Sven Schnelle <svens@stackframe.org>
>>>> Signed-off-by: Sven Schnelle <svens@stackframe.org>
>>>> Reviewed-by: Helge Deller <deller@gmx.de>
>>>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>> Signed-off-by: Helge Deller <deller@gmx.de>
>>>> ---
>>>> target/hppa/gdbstub.c | 62
>>> ++++++++++++++++++++++++++++---------------
>>>>    1 file changed, 41 insertions(+), 21 deletions(-)
>>>> diff --git a/target/hppa/gdbstub.c b/target/hppa/gdbstub.c
>>>> index 0daa52f7af..777f4a48b9 100644
>>>> --- a/target/hppa/gdbstub.c
>>>> +++ b/target/hppa/gdbstub.c
>>>> @@ -21,16 +21,25 @@
>>>> @@ -133,24 +142,35 @@ int hppa_cpu_gdb_read_register(CPUState *cs,
>>> GByteArray *mem_buf, int n)
>>>>            val = env->cr[30];
>>>>            break;
>>>>        case 64 ... 127:
>>>> - val = extract64(env->fr[(n - 64) / 2], (n & 1 ? 0 : 32), 32);
>>>> -        break;
>>>> -    default:
>>>> -        if (n < 128) {
>>>> -            val = 0;
>>>> +        if (hppa_is_pa20(env)) {
>>>> +            val = env->fr[n - 64];
>>>
>>> Coverity reports:
>>>
>>>>>>      CID 1645613:         Memory - illegal accesses  (OVERRUN)
>>>>>>      Overrunning array "env->fr" of 32 8-byte elements at element
>>>          index 32 (byte offset 263) using index "n - 64" (which
>>>         evaluates to 32).
>>
>> Yes, there's indeed a check missing wether n is < 96. I'll submit a patch later.
> 
> Looking again there is
> 
> if (n >= hppa_num_regs(env)) {
>          return 0;
> }
> 
> right at the beginning of both functions, which returns 96 for 64 bit
> mode as the limit so n should have proper bounds already if I'm not mistaken.

I thought the same but wasn't sure. Maybe adding a pair of assert()
are sufficient to fell safe and make Coverity happy?


