Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59166C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2024 20:43:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzMyc-0008TF-1V; Tue, 23 Apr 2024 16:42:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rzMyZ-0008T1-8m
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 16:42:52 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rzMyX-0002Ar-H3
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 16:42:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=/4B3YdRjJoexzojSJH5xGxeQEiSHaJXgiM8zu7my7N0=; b=Gs2IcPD+AxNsZbAa8oY7bnQbim
 AZkZllgimH0iTRkBAOtgs2EM1v65m/SRkJOA4TdwiPwGX0E5srfxGuMauTg3HVr9BPPQrgZDRdChW
 RKv6VZyhQIrv9y+GYblOEqUDs7DF954squ7vc4/JjXkudPqKDqG8NmJRgsCS7Kga3uxXcTIbrR7u4
 IcsK9yb4g1ldEOv/KAFK+/rLkEJugyjkALuLpn+St2yPofjnYR68P54RoYE3aaLRrhgzFnVxviOm5
 +R65FaDrMUjuDajRtWLPT8qkeUO91ZsWB7gkUUmnw0yOXt4rX67EXTJ+mnX46BbnE9h8c395Hhiv0
 tyEag3AT1dS/xF7cp3CPo4pJrEK76/Evl11TdvVHGV7DOlRKkkXAfYN7tY6Byh5bowQdrWBbIcqpZ
 3ZobTO+gPT4xOHtloSvm/5jB9epcDIC6SE2hLInrey3t+xFdaIa6YpEZHXr7N59ILzs6gopJdcU3q
 u+tj0LlRl5SRoL8Nr0EwQ/K+sIEhagY/7SdflXXDJGJh+5VQ776ZVnhx44PHq4R38VC7V3rAtZFv2
 5GYPz0ouohUvalEd8HY+TJbr0vB1omwjveuxBPKxNLWbDFO536F/jIWUIOijdh9u4yDwZd854fZ4H
 Yy2GoH3hqeORq8BZA0RmDXdo24XC95iO1Al1aYcs4=;
Received: from [2a00:23c4:8bb4:4000:a7b5:de4:dbb6:c9cb]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rzMxM-000846-Gq; Tue, 23 Apr 2024 21:41:40 +0100
Message-ID: <d2e11eb2-4a4a-4e23-b200-3995ea865052@ilande.co.uk>
Date: Tue, 23 Apr 2024 21:42:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Volker_R=C3=BCmelin?=
 <vr_qemu@t-online.de>
Cc: Richard Henderson <richard.henderson@linaro.org>, eduardo@habkost.net,
 qemu-devel@nongnu.org
References: <20240419195147.434894-1-mark.cave-ayland@ilande.co.uk>
 <fefb7b6b-29fc-42ee-b62e-059512e881e4@linaro.org>
 <3ff9df0d-6465-45a3-bb62-0db17ed9210c@ilande.co.uk>
 <d84e246a-fb43-4bb9-ad61-5ebfea4e323f@t-online.de>
 <CABgObfYsCO-fH1MZQ1=mRUJQHn9h2QBcCfytBnDhhM91iEd4sA@mail.gmail.com>
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
In-Reply-To: <CABgObfYsCO-fH1MZQ1=mRUJQHn9h2QBcCfytBnDhhM91iEd4sA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb4:4000:a7b5:de4:dbb6:c9cb
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH] target/i386/translate.c: always write 32-bits for SGDT
 and SIDT
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_SBL_A=0.1 autolearn=ham autolearn_force=no
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

On 23/04/2024 10:18, Paolo Bonzini wrote:

> On Mon, Apr 22, 2024 at 9:10 PM Volker Rümelin <vr_qemu@t-online.de> wrote:
>>
>> Am 20.04.24 um 07:40 schrieb Mark Cave-Ayland:
>>>> Current documentation agrees that all 32 bits are written, so I don't
>>>> think you need this comment:
>>>
>>> Ah that's good to know the docs are now correct. I added the comment
>>> as there was a lot of conflicting information around for older CPUs so
>>> I thought it was worth an explicit mention.
>>
>> Quote from the Intel® 64 and IA-32 Architectures Software Developer’s
>> Manual Volume 2B: Instruction Set Reference, M-U March 2024:
>>
>> IA-32 Architecture Compatibility
>> The 16-bit form of SGDT is compatible with the Intel 286 processor if
>> the upper 8 bits are not referenced. The Intel 286 processor fills these
>> bits with 1s; processor generations later than the Intel 286 processor
>> fill these bits with 0s.
>>
>> Intel still claims the upper 8 bits are filled with 0s, but the
>> Operation pseudo code below is correct. The same is true for SIDT.
> 
> I think the claim is that it fills with 0s when the software is
> compatible with the 286, i.e. never uses a 32-bit LIDT or LGDT
> instruction. Software written to target specifically older processors
> typically used the undocumented LOADALL instruction to exit protected
> mode or to set 4GB segment limits, so it won't run on QEMU. You can
> read about the usage here:
> 
> https://www.os2museum.com/wp/more-on-loadall-and-os2/ (286)
> https://www.os2museum.com/wp/386-loadall/ (386)
> 
> and about how it worked here:
> 
> https://www.pcjs.org/documents/manuals/intel/80286/loadall/
> https://www.pcjs.org/documents/manuals/intel/80386/loadall/
> 
> Interestingly, byte 3 of the GDTR or IDTR on the 286 are documented as
> "should be zeroes" for LOADALL, not all ones.
> 
> Let's change "Despite claims to the contrary" with "Despite a
> confusing description".

Thanks for sorting this, Paolo. I suspect that KVM needs a similar patch as per 
https://gitlab.com/qemu-project/qemu/-/issues/2198#note_1815726425 however the Win32s 
and OS/2 Warp 4 tests seem to work fine on KVM. Maybe it's because the SGDT and SIDT 
instructions run natively and don't need to be emulated for these cases?


ATB,

Mark.


