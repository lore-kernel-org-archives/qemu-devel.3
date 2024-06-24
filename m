Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F4C6C2BD05
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 05:42:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLcSl-0003GW-V2; Mon, 24 Jun 2024 01:42:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1sLcSV-0003Fh-DT
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 01:41:43 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1sLcSS-00069U-Tw
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 01:41:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID;
 bh=g8ytKYvbEI1Y5cIvtHafGsoL97900+lDUC8TdBr/+NM=; b=DpE6/GIXpUeimAuVTlE9K9BAwR
 +esOjsegLKRsjMlKNgF0p77d6G/ikWxAM/4rA7btV88xxjeF53vd7/DHv/Fn2VCJUi6P41Kcl2jj6
 F5LfJYKFN0EDYPPOBEmz3iqGOKfw7aFEld5qO+I83ZkFxtkW3m4/TsvtUuPT6EOIvL4XAV+FlLBjm
 1DCRx/K5H/wguFzcZUQkFkl+27B55YLaBT+UbRDzNtajnix9ER9M+T7o0qE4+QBnBomZu0bl2+uyM
 x08ImRoCD3g/J1iQ29++L4lO53GS8C8s+wAj4lC7jc1NSm7tNCj2uB6Gu4Kb1PjaA4AMTdkSw2PD4
 sx6Ta0KS4mIuzSz6uwv5RrBAh2SMBRQNXgR5a9XgOzjxNdsYp2uC/51CQarvGsJsmW+axAWqy03RY
 SqRno0APxZU44EV6iC+GKgdCD06bC35DF3YHiJ/3au9OYmg9dRNjEsEm6Nft4i90ZfhKZUvieBcUP
 CIhfUe8mRXcqIjiljeZIQpzddjD/VMjvCiawUm6/0PjoyTBsR0OkA+Svei62TCPTC52iCB8WaY0in
 VQ2bvNpW+YSNSz/Vlml1fXSZdXygzL4EFPeHA1Vk72HXqoahVwgWza1IJyM4KYejcaDGyTkjl0lvo
 jaqsz+Hoeft53PgKFnkQiQJQigdaVQPedYmIRL1+Q=;
Received: from [2a00:23c4:8bb4:4000:aa92:227d:8a5b:45f1]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1sLcR1-0005cp-TK; Mon, 24 Jun 2024 06:40:16 +0100
Message-ID: <c062da2c-4303-45d9-861d-1732c8efb36c@ilande.co.uk>
Date: Mon, 24 Jun 2024 06:41:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, laurent@vivier.eu
References: <20240623115704.315645-1-mark.cave-ayland@ilande.co.uk>
 <20240623115704.315645-2-mark.cave-ayland@ilande.co.uk>
 <fa494396-c0a8-3799-92c4-b9832dc3445b@eik.bme.hu>
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
In-Reply-To: <fa494396-c0a8-3799-92c4-b9832dc3445b@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb4:4000:aa92:227d:8a5b:45f1
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH 1/2] target/m68k: implement do_unaligned_access callback
 for m68k CPUs
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

On 23/06/2024 16:11, BALATON Zoltan wrote:

> On Sun, 23 Jun 2024, Mark Cave-Ayland wrote:
>> For m68k CPUs that do not support unaligned accesses, any such access should
>> cause the CPU to raise an Address Error exception.
>>
>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>> ---
>> target/m68k/cpu.c       |  1 +
>> target/m68k/cpu.h       |  4 ++++
>> target/m68k/op_helper.c | 11 +++++++++++
>> 3 files changed, 16 insertions(+)
>>
>> diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
>> index efd6bbded8..25e95f9f68 100644
>> --- a/target/m68k/cpu.c
>> +++ b/target/m68k/cpu.c
>> @@ -538,6 +538,7 @@ static const TCGCPUOps m68k_tcg_ops = {
>>     .cpu_exec_interrupt = m68k_cpu_exec_interrupt,
>>     .do_interrupt = m68k_cpu_do_interrupt,
>>     .do_transaction_failed = m68k_cpu_transaction_failed,
>> +    .do_unaligned_access = m68k_cpu_do_unaligned_access,
>> #endif /* !CONFIG_USER_ONLY */
> 
> Why is it sysemu only? Shouldn't user mode cpu only emulation do the same? I also 
> don't get how this is restricted to pre 68020 CPUs or account for differences between 
> data and inst fetch on 20+ but I may be missing somerhing as I don't know this code 
> or 68k behaviour well. So this is just a question, I'm not saying it's wrong but I 
> don't understand why it's right.

I'm not exactly sure, but I'm guessing that this is handled by the host user code 
since all CPUs that implement do_unaligned_access do so in a block contained within 
#ifndef CONFIG_USER_ONLY ... #endif.


ATB,

Mark.


