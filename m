Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9453C4345F
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Apr 2024 05:42:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ry3TG-0000Zm-CC; Sat, 20 Apr 2024 01:41:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1ry3TD-0000ZN-Ny
 for qemu-devel@nongnu.org; Sat, 20 Apr 2024 01:41:03 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1ry3TB-0006DH-Ak
 for qemu-devel@nongnu.org; Sat, 20 Apr 2024 01:41:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:To:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=RXUypNSkmuM02VRjuGXGQo976lIsAavvkoiHouJ2WRM=; b=1cJV/DM+Nmk7Cuj8UtZl6XLDFe
 LMZ1d0mAyRu1svGB8vkDlCWP0BeH76H4FgwckyG+AtJILXGDnWE3e0XDPdryr029oFGoD+YC7SJxB
 zl4f3nse7laCjdrlUqqsWytXXWD/bVTDkXUj5BNCH2W+AImkeTYDm456SQgx6hskxtXG7cHpw8/oX
 my56Xj6GiokrPctGOCutqTbLuLDWFpwLQyKV++yxZgTEsNL9RLw66Lx342f8l8nGThNCV3Q6cQk0E
 c/qXePEtFizA5NUi5lIKxkM69kl2BTB2On7gEf7zdtkti5F0S4OCr66yqx5VYPLOm2ev+KbIod1cv
 JXPTe113U7yygLlIOgTsgQhiiscPONNe+fWUqWtJl+Op/KO2TEZOIK56AgxTY+5VZzzIOQO0B0sOI
 yduc/ymQNtZz1xYaHEWO6XwnS9wnzoRFrjaTrK1eSloiz0h4xGoDFiHlxLAqhSNrgG9JAf2kNh8oQ
 51WdxuqE1YfRpW4FeWKsPv8inbJCjHTGjUzuhwHrbMg49IJEsefYg+4rwjIGkwyTadqn1xSW060+J
 5A876lscawNL182gl1DnLMcnOJ9zdINbMawqdt5NBO1qQAAAxsuTzN7qLK3+T3l1Dh5J8MFujRpRe
 AVDvEH5d2wAFGoijzYWXGCTdL0Gh8NRjFWRSiZhb0=;
Received: from [2a00:23c4:8bb4:4000:a36d:d178:601a:c356]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1ry3S2-000Atp-Rt; Sat, 20 Apr 2024 06:39:54 +0100
Message-ID: <3ff9df0d-6465-45a3-bb62-0db17ed9210c@ilande.co.uk>
Date: Sat, 20 Apr 2024 06:40:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Richard Henderson <richard.henderson@linaro.org>, pbonzini@redhat.com,
 eduardo@habkost.net, qemu-devel@nongnu.org
References: <20240419195147.434894-1-mark.cave-ayland@ilande.co.uk>
 <fefb7b6b-29fc-42ee-b62e-059512e881e4@linaro.org>
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
In-Reply-To: <fefb7b6b-29fc-42ee-b62e-059512e881e4@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb4:4000:a36d:d178:601a:c356
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH] target/i386/translate.c: always write 32-bits for SGDT
 and SIDT
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 20/04/2024 02:21, Richard Henderson wrote:

> On 4/19/24 12:51, Mark Cave-Ayland wrote:
>> The various Intel CPU manuals claim that SGDT and SIDT can write either 24-bits
>> or 32-bits depending upon the operand size, but this is incorrect. Not only do
>> the Intel CPU manuals give contradictory information between processor
>> revisions, but this information doesn't even match real-life behaviour.
>>
>> In fact, tests on real hardware show that the CPU always writes 32-bits for SGDT
>> and SIDT, and this behaviour is required for at least OS/2 Warp and WFW 3.11 with
>> Win32s to function correctly. Remove the masking applied due to the operand size
>> for SGDT and SIDT so that the TCG behaviour matches the behaviour on real
>> hardware.
>>
>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2198
>>
>> -- 
>> MCA: Whilst I don't have a copy of OS/2 Warp handy, I've confirmed that this
>> patch fixes the issue in WFW 3.11 with Win32s. For more technical information I
>> highly recommend the excellent write-up at
>> https://www.os2museum.com/wp/sgdtsidt-fiction-and-reality/.
>> ---
>>   target/i386/tcg/translate.c | 14 ++++++++------
>>   1 file changed, 8 insertions(+), 6 deletions(-)
>>
>> diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
>> index 76a42c679c..3026eb6774 100644
>> --- a/target/i386/tcg/translate.c
>> +++ b/target/i386/tcg/translate.c
>> @@ -5846,9 +5846,10 @@ static bool disas_insn(DisasContext *s, CPUState *cpu)
>>               gen_op_st_v(s, MO_16, s->T0, s->A0);
>>               gen_add_A0_im(s, 2);
>>               tcg_gen_ld_tl(s->T0, tcg_env, offsetof(CPUX86State, gdt.base));
>> -            if (dflag == MO_16) {
>> -                tcg_gen_andi_tl(s->T0, s->T0, 0xffffff);
>> -            }
>> +            /*
>> +             * NB: Despite claims to the contrary in Intel CPU documentation,
>> +             *     all 32-bits are written regardless of operand size.
>> +             */
> 
> Current documentation agrees that all 32 bits are written, so I don't think you need 
> this comment:

Ah that's good to know the docs are now correct. I added the comment as there was a 
lot of conflicting information around for older CPUs so I thought it was worth an 
explicit mention.

If everyone agrees a version without comments is preferable, I can re-send an updated 
version without them included.

>    IF OperandSize =16 or OperandSize = 32 (* Legacy or Compatibility Mode *)
>      THEN
>        DEST[0:15] := GDTR(Limit);
>        DEST[16:47] := GDTR(Base); (* Full 32-bit base address stored *)
>    FI;
> 
> 
> Anyway,
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Thanks!


ATB,

Mark.


