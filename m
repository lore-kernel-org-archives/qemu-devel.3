Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D269FC2BD05
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 05:44:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLcVM-0003zC-TC; Mon, 24 Jun 2024 01:44:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1sLcVL-0003yy-PZ
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 01:44:39 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1sLcV6-0006Jt-Hp
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 01:44:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID;
 bh=ZFWEIRYHwcTV3MoceeNiwcxaBL9+RmOnSIvFT7vA3e0=; b=MS69EhpkQZOQBlfUcRYnWpfqQd
 hsjbexY4mjYT7GBAx7tqn2GnJxkcE+LPkPFanLAE5CuItw1WvAdI72Squ0f7xo7TktgsglKqKty1X
 dRSG/pcVxU4c0cTZnR3XKhTvYyO6yrWBCUaX6ORfvAeGCDUWMv0CJlYpTfGJ8x1QXn0UmRU2LcBD4
 HetW1NcoYth3vgrEVZ363QfS6NUOIvay5W3DTJUXLfnDnIxOFV3s+QY7riMD81dgg+wX8kdoBIxNW
 ban1XqL16POV2AUazovjFAM4CilG7o7/yUz5DO9lO3PiOVJGdWxsPZJ2pqJ9tiK18fogASQe2uQNc
 f/Ao0cTGDc9JFinkg9ja5D8fwMMzr1Awz+0Ud79Va33HZmCR/Mrcsawmedm05lkkKF1Z1OAre+FYr
 X178iv+IPdmmFarG5/dv39PdG4j6A9KoB/vjaObMpL+mvnMAx1SbhXeQtoD7jBTGLzAO0x9eNpAJe
 3pHN0FCqeLvHfpvjl/uhOqBH7IVc/zDv38xkIfrLS84hZUiRqgMVbUPuCQ2fu+OuTWv6uP3GxJlBa
 4XfCUV5XlpMOWCHzTfCr9o1y2jYPGWj3J5YaHN3EN3xD1SIZwve+2+gJMJfmMSXB4h3/mUvVnyl9E
 Jy+wde2JownhI2pQZFlOmc4PsAKQSkemLBTaMD49E=;
Received: from [2a00:23c4:8bb4:4000:aa92:227d:8a5b:45f1]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1sLcTh-0005dj-7B; Mon, 24 Jun 2024 06:43:01 +0100
Message-ID: <da3ef608-8eff-485a-b831-9192c412858f@ilande.co.uk>
Date: Mon, 24 Jun 2024 06:44:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, laurent@vivier.eu
References: <20240623115704.315645-1-mark.cave-ayland@ilande.co.uk>
 <20240623115704.315645-3-mark.cave-ayland@ilande.co.uk>
 <9d74ba20-a17d-64fd-7203-e4d450f77472@eik.bme.hu>
Content-Language: en-US
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Autocrypt: addr=mark.cave-ayland@ilande.co.uk; keydata=
 xsBNBFQJuzwBCADAYvxrwUh1p/PvUlNFwKosVtVHHplgWi5p29t58QlOUkceZG0DBYSNqk93
 3JzBTbtd4JfFcSupo6MNNOrCzdCbCjZ64ik8ycaUOSzK2tKbeQLEXzXoaDL1Y7vuVO7nL9bG
 E5Ru3wkhCFc7SkoypIoAUqz8EtiB6T89/D9TDEyjdXUacc53R5gu8wEWiMg5MQQuGwzbQy9n
 PFI+mXC7AaEUqBVc2lBQVpAYXkN0EyqNNT12UfDLdxaxaFpUAE2pCa2LTyo5vn5hEW+i3VdN
 PkmjyPvL6DdY03fvC01PyY8zaw+UI94QqjlrDisHpUH40IUPpC/NB0LwzL2aQOMkzT2NABEB
 AAHNME1hcmsgQ2F2ZS1BeWxhbmQgPG1hcmsuY2F2ZS1heWxhbmRAaWxhbmRlLmNvLnVrPsLA
 eAQTAQIAIgUCVAm7PAIbAwYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQW8LFb64PMh9f
 NAgAuc3ObOEY8NbZko72AGrg2tWKdybcMVITxmcor4hb9155o/OWcA4IDbeATR6cfiDL/oxU
 mcmtXVgPqOwtW3NYAKr5g/FrZZ3uluQ2mtNYAyTFeALy8YF7N3yhs7LOcpbFP7tEbkSzoXNG
 z8iYMiYtKwttt40WaheWuRs0ZOLbs6yoczZBDhna3Nj0LA3GpeJKlaV03O4umjKJgACP1c/q
 T2Pkg+FCBHHFP454+waqojHp4OCBo6HyK+8I4wJRa9Z0EFqXIu8lTDYoggeX0Xd6bWeCFHK3
 DhD0/Xi/kegSW33unsp8oVcM4kcFxTkpBgj39dB4KwAUznhTJR0zUHf63M7ATQRUCbs8AQgA
 y7kyevA4bpetM/EjtuqQX4U05MBhEz/2SFkX6IaGtTG2NNw5wbcAfhOIuNNBYbw6ExuaJ3um
 2uLseHnudmvN4VSJ5Hfbd8rhqoMmmO71szgT/ZD9MEe2KHzBdmhmhxJdp+zQNivy215j6H27
 14mbC2dia7ktwP1rxPIX1OOfQwPuqlkmYPuVwZP19S4EYnCELOrnJ0m56tZLn5Zj+1jZX9Co
 YbNLMa28qsktYJ4oU4jtn6V79H+/zpERZAHmH40IRXdR3hA+Ye7iC/ZpWzT2VSDlPbGY9Yja
 Sp7w2347L5G+LLbAfaVoejHlfy/msPeehUcuKjAdBLoEhSPYzzdvEQARAQABwsBfBBgBAgAJ
 BQJUCbs8AhsMAAoJEFvCxW+uDzIfabYIAJXmBepHJpvCPiMNEQJNJ2ZSzSjhic84LTMWMbJ+
 opQgr5cb8SPQyyb508fc8b4uD8ejlF/cdbbBNktp3BXsHlO5BrmcABgxSP8HYYNsX0n9kERv
 NMToU0oiBuAaX7O/0K9+BW+3+PGMwiu5ml0cwDqljxfVN0dUBZnQ8kZpLsY+WDrIHmQWjtH+
 Ir6VauZs5Gp25XLrL6bh/SL8aK0BX6y79m5nhfKI1/6qtzHAjtMAjqy8ChPvOqVVVqmGUzFg
 KPsrrIoklWcYHXPyMLj9afispPVR8e0tMKvxzFBWzrWX1mzljbBlnV2n8BIwVXWNbgwpHSsj
 imgcU9TTGC5qd9g=
In-Reply-To: <9d74ba20-a17d-64fd-7203-e4d450f77472@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb4:4000:aa92:227d:8a5b:45f1
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH 2/2] target/m68k: pass alignment into TCG memory
 load/store routines
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 23/06/2024 16:23, BALATON Zoltan wrote:

> On Sun, 23 Jun 2024, Mark Cave-Ayland wrote:
>> Now that do_unaligned_access has been implemented for 68k CPUs, pass the required
>> alignment into the TCG memory load/store routines. This allows the TCG memory core
>> to generate an Address Error exception for unaligned memory accesses if required.
>>
>> Suggested-by: Laurent Vivier <laurent@vivier.eu>
>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2165
>> ---
>> target/m68k/translate.c | 18 +++++++++++++++---
>> 1 file changed, 15 insertions(+), 3 deletions(-)
>>
>> diff --git a/target/m68k/translate.c b/target/m68k/translate.c
>> index 445966fb6a..661a7b4def 100644
>> --- a/target/m68k/translate.c
>> +++ b/target/m68k/translate.c
>> @@ -303,13 +303,18 @@ static inline TCGv gen_load(DisasContext *s, int opsize, TCGv 
>> addr,
>>                             int sign, int index)
>> {
>>     TCGv tmp = tcg_temp_new_i32();
>> +    MemOp memop = opsize | (sign ? MO_SIGN : 0) | MO_TE;
>>
>>     switch (opsize) {
>>     case OS_BYTE:
>> +        tcg_gen_qemu_ld_tl(tmp, addr, index, memop);
>> +        break;
>>     case OS_WORD:
>>     case OS_LONG:
>> -        tcg_gen_qemu_ld_tl(tmp, addr, index,
>> -                           opsize | (sign ? MO_SIGN : 0) | MO_TE);
>> +        if (!m68k_feature(s->env, M68K_FEATURE_UNALIGNED_DATA)) {
>> +            memop |= MO_ALIGN_2;
>> +        }
>> +        tcg_gen_qemu_ld_tl(tmp, addr, index, memop);
> 
> You could swap the order of these so byte comes last and fall through to it from 
> word/long to avoid duplicated line.
> 
> Maybe this answers my question about where it's restriced by CPU type. I wonder if 
> this check for M68K_FEATURE_UNALIGNED_DATA could be avoded here and done by checking 
> it in init and only set the unaligned method for CPUs that need it to not add 
> overhead for most CPUs that don't need it.

I don't think that it matters too much if the method isn't implemented as the logic 
surrounding when to call do_unaligned_access is contained within the TCG core.

I'll have a go at updating the ordering and send a v2 if it looks good.


ATB,

Mark.


