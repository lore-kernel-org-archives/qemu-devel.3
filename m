Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C9ABFCA19A
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 22:27:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzj3x-0000Ln-Ip; Mon, 09 Mar 2026 18:26:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzj3u-0000LL-Oj
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 18:26:55 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzj3s-0008VB-2c
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 18:26:54 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-485392de558so9004885e9.1
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 15:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773095210; x=1773700010; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BKVbZJem/hUSA7L10vTSDi18JF5aF6+AcYe/UyTETfc=;
 b=viV1+T+iDLxvn/L0VKfUInP4816ed/kgARo8ETLUp6TUkuWTa7niShF4wHN9yb3kwo
 RRwISHtGq9fBxp/28Awd6Yyl1KfQmazQPtamvVkPiGP2mZoTA36NfdhqtSHsGGgVW1JF
 mfIi1A+SpWntNwDnUY/4Bgh1eU5MSEDXuQUDpPoMC+ez5nRrqAiHJ8JGQ9HGSyFtNISq
 tWqxBbbIgLGGl5RmSJr56QwHOTn0T1L6P12cNW/CunJ4yz3r9BotbWAsEqx9hCYd0ari
 PsbsPA2KJJufPfJWg/7y+l65tVPLx/l/0X0T5I4aqYdiNwW0eZ/SpVmLvECD9sEmtsCp
 plJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773095210; x=1773700010;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BKVbZJem/hUSA7L10vTSDi18JF5aF6+AcYe/UyTETfc=;
 b=kXd6OaHJ5jz+cjLROmBsz1X3GmUTJ9iFEJcq7YrgLJGWJW/mA/fiTgRAdKQMhIyhGA
 JjqAZzW5298RULFMFZQoysbB3xQehgQAWAZdFOYpT1iJ5jsvybWpd5S8q4h9Nx51ZRZw
 dqVRaELt17EsFT2abtNU+bOpxDPgJH8EH2b5UgzWmnNQof0EmYFd5/Tyy7FDA5/c9COe
 riHyQcHgAgLtKofPXyDzpZN5vkFtObmLqNSsvPS7lkY9DApcj59lML0I1+fHjJVkLHt6
 n0dS/b88XzkJ6zvs0rRamioT8DeyA3Umd8d0/ssY9JTVslhNGj18C/jk0tgTpBWL2boZ
 nSbg==
X-Gm-Message-State: AOJu0YyuvzG10qnWq4PmH7Qk1yUrmiW/3OYkqGvRpQXMpILX2i3wZpvN
 ATdN81vD/pK1Oiwx1OFJV0KmZMjplJtVETQkG8iLMvQ34QNqVyO6/86rNjP+1P1yU08=
X-Gm-Gg: ATEYQzx9o33J4nSOTU0mj1jfA002T0HW3ka8GFOtTfVLXsD/Wyj6ZjTvzpY+BqduDy4
 3AkQY47ecMd40CpmCpuhHU3Q0cYt63iOkHh8xMf/QTLKKxZiU9AkG1gyLQHZ5h2INHViP2SXPNc
 1Fgfwg5kyh3niYWzqTogqpN+23IiFyuIv1cLbRg4E4qREbXt1Yv4kniJu+xqxnVE+FA0mZDOgCr
 DvC2Uj6hRCdJV3U6b84sQj02/NeB+wQ3ak/Xzypp1B3MGYZ199tgEuWZfkf6qNSa4JU+Pv6ICTV
 rDhAzFC0lnqPK/oKgnR14qRnv8xdPC5Ghrj01Jmoq259mSDyY/R/WChmYfkv6Rx8KTzPOD9g8N5
 1893w9yYSyPl1zh4Q7g8OoTr9fZWjXV67IxKTtgreCT9gqX3y96RBqJFIMjoP59xv0bA9l0zMAP
 NlfcThww5VQ67FY465CWHyumlUe1vv6ASzu+ER/o1pYWXn5FYZ5tYlRdPFZygoQl+nuw==
X-Received: by 2002:a05:600c:138a:b0:47e:e2eb:bc22 with SMTP id
 5b1f17b1804b1-4852691c5bamr234287005e9.5.1773095210046; 
 Mon, 09 Mar 2026 15:26:50 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48541a8f610sm39746065e9.7.2026.03.09.15.26.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Mar 2026 15:26:49 -0700 (PDT)
Message-ID: <e2824e5c-4d1d-4d08-ba24-a8c3056c2edc@linaro.org>
Date: Mon, 9 Mar 2026 23:26:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ati-vga: Fix sign extension in DEFAULT_SC_BOTTOM_RIGHT
 read
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>, Chad Jablonski <chad@jablonski.xyz>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
References: <20260309212206.2457691-1-chad@jablonski.xyz>
 <1931a6d0-d351-cc43-1b3d-fa3b3b0809a9@eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <1931a6d0-d351-cc43-1b3d-fa3b3b0809a9@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

On 9/3/26 22:41, BALATON Zoltan wrote:
> On Mon, 9 Mar 2026, Chad Jablonski wrote:
>> Cast default_sc_bottom to uint32_t before shifting left to prevent
>> sign extension when assigning to uint64_t.
>>
>> Fixes: CID 1645615
>> Signed-off-by: Chad Jablonski <chad@jablonski.xyz>
>> ---
>> hw/display/ati.c | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/hw/display/ati.c b/hw/display/ati.c
>> index 6cf243bcf9..f9773e1154 100644
>> --- a/hw/display/ati.c
>> +++ b/hw/display/ati.c
>> @@ -514,7 +514,7 @@ static uint64_t ati_mm_read(void *opaque, hwaddr 
>> addr, unsigned int size)
>>         val |= s->regs.default_tile << 16;
>>         break;
>>     case DEFAULT_SC_BOTTOM_RIGHT:
>> -        val = (s->regs.default_sc_bottom << 16) |
>> +        val = ((uint32_t)s->regs.default_sc_bottom << 16) |
>>               s->regs.default_sc_right;

What about using deposit64() which is uncontroversial?

             val = deposit64(s->regs.default_sc_right, 16,
                             13, s->regs.default_sc_bottom);

>>         break;
>>     case SC_TOP:
> 
> I think this is not needed. This is likely a false positive from 
> Coverity because the valid bits for sc regs are bits 13:0 which we 
> enforce on write so you should not get sign extension here. We typically 
> don't do such fixes for these but mark them in Coverity but cc'd Peter 
> Maydell who knows this better.
> 
> Regards,
> BALATON Zoltan


