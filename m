Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F902606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 21:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key, unprotected) header.d=ilande.co.uk header.i=@ilande.co.uk header.a=rsa-sha256 header.s=20220518 header.b=UYDk4hej
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xK0Bs-0005hw-RM; Thu, 22 Oct 2026 17:19:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1xK0Bq-0005hd-Pl
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 17:19:10 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1xK0Bp-0003rG-8r
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 17:19:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID;
 bh=j/z7gsStric8l8TGr6Rd+hz+VmM38/u2Mmc++lAL+jc=; b=UYDk4hejjCR8cJS407owfGzKfD
 QagnLWPhWAI4E+/vQ7fLMOb42cxDG7SWuV3levyS2B6xQsfLiYPcYbXzWlLCrmXqJ29Q1B6CPb/7D
 5FxunuYivHC12L0vpFU5ayLVywSwIoiClOsr0WchH+pjw0DL8tMcsfZriNuVoiufultLGScDIcZJF
 iHa3aISOwsttBrYAqwXNDdRxpEskNP7AoKATNUuWznxlHwOsy/LtPKCykAUIaAmIqGYLOyeR7L1KJ
 MS8msZkaSVWgHB97KRK9fMJh1MQb3slHz/3L9Jm1wYEoB2R7bfSWIUz7EQvlr42v2eohhkKIkqBYA
 GesIHI8pahMk+VR41mr8AUldtqR+i4+uliHaySTUmT+ElyFF8dkTbjrCoH9gqUhyBp/6OKE+3vQHZ
 icOEWojj5wxN4eHr93A9vwRrjmLuz/KNWoLULAZMjFnfa1DK4a4lt/qgKuQxx4cYABQ0Kc0Sl37IP
 Qx7hOsf09YmvsBMjWEoG0K9E+nSzoYGaKCGRkLIU2ChexAgJxuXIcUhwpAJzAWu7jVm8voAsmciKK
 2912Gc2hmKLU08mi0bqr9CuFWi47FYlug0idFy6asVw0C5Go2L7DRgmKfmJNSgZgu8dwnAZ60oUq4
 o5d6mYit8mK9pUuoPh7do5RcWBXd1zvKX0paXPQww=;
Received: from [2a02:8012:2f01:0:fe49:60b9:9856:b8ef]
 by mail.ilande.co.uk with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.94.2)
 (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1xK0B6-003FkG-8i; Thu, 22 Oct 2026 22:18:24 +0100
Message-ID: <9f0c2da9-9fa1-45a5-a470-388531fd33f3@ilande.co.uk>
Date: Thu, 22 Oct 2026 22:19:05 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Stian Halseth <stian@itx.no>, qemu-devel@nongnu.org
Cc: Artyom Tarasenko <atar4qemu@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Eric Biggers <ebiggers@kernel.org>
References: <20261022070059.3861291-1-stian@itx.no>
 <e3fc4bfa-4510-4d3d-9a24-77c17864e660@oss.qualcomm.com>
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
In-Reply-To: <e3fc4bfa-4510-4d3d-9a24-77c17864e660@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:2f01:0:fe49:60b9:9856:b8ef
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH v3 0/8] target/sparc: Add support for SPARC crypto
 instructions
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 22/10/2026 12:57, Philippe Mathieu-Daudé wrote:

> On 22/10/26 09:00, Stian Halseth wrote:
>> This series implements SPARC crypto instructions for QEMU. Most other
>> arches already support crypto instructions, but SPARC is lagging behind.
> 
> 
>> Changes in v2:
>> - 1/7: use suggested commit message (Philippe); R-b Philippe
>> - 2/7: start with an empty CFR. Bits set in each instruction patch
>> - 3/7: byte-order comment, rk half zeroed explicitly; T-b Philippe
>> - 4/7: sets CFR.aes; "3-operand"/"4-operand" wording.
>> - 5/7: sets CFR.crc32c; "3-operand" wording; explicit 64-bit return;
>>         R-b + T-b Philippe
>> - 6/7: sets the SHA bits; comment on the narrowing; R-b + T-b Philippe
>> - 7/7: -cpu TI-UltraSparc-II,+crypto mentioned; R-b Philippe
>> - Tests: Follow-up, as agreed (Philippe)
>>
>> v1: https://lore.kernel.org/qemu-devel/20261020145530.3385376-1-stian@itx.no/
>>
>> Stian Halseth (8):
>>    target/sparc: Add crypto feature
>>    target/sparc: Return CFR when crypto feature is enabled
>>    target/sparc: Add the eight AES round instructions
>>    target/sparc: Add the AES key expansion instructions
>>    target/sparc: Add the CRC32C instruction
>>    target/sparc: Add the SHA instructions
> 
> Mark, Artyom, if you Ack I can queue the first reviewed 6 patches
> via my mist-target tree. I'll let the rest which is unreviewed go
> via your or Helge's tree.

I think the series is basically good: I can test it tomorrow evening and send a PR if 
it passes a few local tests and CI.

Stian: if the only outstanding issue is the indentation, I can fix that when I merge 
it into my qemu-sparc branch.


ATB,

Mark.


