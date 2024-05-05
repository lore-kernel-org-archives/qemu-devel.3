Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77247C4345F
	for <qemu-devel@archiver.kernel.org>; Sun,  5 May 2024 20:14:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3iEo-0000j7-RS; Sun, 05 May 2024 16:13:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1s3iEn-0000iw-3l
 for qemu-devel@nongnu.org; Sun, 05 May 2024 16:13:33 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1s3iEl-0000ys-0W
 for qemu-devel@nongnu.org; Sun, 05 May 2024 16:13:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:To:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+3xJGj2Eyzim+BK7xH2vKsN1UPaG/HI48LvDkqEskfM=; b=1T8LorKm1Z5tZ7ICbVJwhjk3Vj
 +2ImBmrU6UovABGPSohxrdgwzKnyING8/IiVAFq5dmufDFf4E/WhjRoDj/IlnmuZoGsURqwcmjdWT
 e3WQIVi7KA/cjgD0qQYjfMKnPEdMf9FULWEuwZtwSvFyJkfCwnv6DQLIRPWW+99Ke6vw8GAcF1jPP
 dUvcWtcM7OzGz/eTeLJUV0EYu8BYN371zaDiwpbiV2dVBp+iev/KGXSVJppj0k6OMkBWX5+2ZgOiP
 qQs0PPIi8Ujoh/rTFHdT0TFSvtoJ57UXhWx0Xi9mZYdVMxeV5TnbXp5lAB0fqIzunFExWCGXVtkli
 ChkAOo13LuBAdJaE07sHoRhZmK9m8bma3vbOGCfsQGJkVSDHoq+C+slMPuBwTw3u6VoJKrHZyH7Jf
 FMSVw++Rlk+qeHQ9IuHBd6gyIJNa7H1twxuS/JXi9aYJSLFV5SOMrPBTjzT/aw2UDf6QiT6+YiK4P
 sERYvwdzJyByfSAH8WBWzajmk3gwt0TsTpJYcaKmiXfco0F7MwT2JVQAWJDekJKHrtpEgwrnvtZjW
 igG7PQ/cA/X4OZpTAkeYxNEwz7AHsrKCdTtf6vEj5qs75bDekAoTr3LhH8hZutjhXlfB+OdB5gYyC
 UkSgsPdutmEP6D3VB3ux/xQ4MsR2Fk3kUyEfZQpGE=;
Received: from [2a00:23c4:8bb4:4000:b60d:a162:d698:c802]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1s3iDf-000B7J-CA; Sun, 05 May 2024 21:12:23 +0100
Message-ID: <be5ad8b7-46ac-47f8-91ae-6302f2fbb4dc@ilande.co.uk>
Date: Sun, 5 May 2024 21:13:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20240502165528.244004-1-richard.henderson@linaro.org>
 <d97b250e-0140-429f-81cc-357537c2a212@linaro.org>
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
In-Reply-To: <d97b250e-0140-429f-81cc-357537c2a212@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb4:4000:b60d:a162:d698:c802
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH v2 0/7] target/sparc: vis fixes
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

On 03/05/2024 19:18, Philippe Mathieu-Daudé wrote:

> On 2/5/24 18:55, Richard Henderson wrote:
>> Split out from my vis4 patch set, with just the bug fixes.
>> I've fixed the issue in patch 6, as noticed by Mark, but
>> include the follow-up that cleans up all of the macros by
>> removing them.
>>
>>
>> r~
>>
>>
>> Richard Henderson (7):
>>    linux-user/sparc: Add more hwcap bits for sparc64
>>    target/sparc: Fix FEXPAND
>>    target/sparc: Fix FMUL8x16
>>    target/sparc: Fix FMUL8x16A{U,L}
>>    target/sparc: Fix FMULD8*X16
>>    target/sparc: Fix FPMERGE
>>    target/sparc: Split out do_ms16b
> 
> I'm wondering about the coverage here, since various patches
> fix bugs since VIS intro in commit e9ebed4d41 from 2007, so
> being broken for 17 years.

I've definitely seen the VIS instructions in use in my test images, however I can't 
recall exactly whether it was the particular ones fixed in this series. I'm certainly 
keen for some more VIS instruction coverage though, especially for VIS2 and later 
which I'm unlikely to come across in my day-to-day testing.


ATB,

Mark.


