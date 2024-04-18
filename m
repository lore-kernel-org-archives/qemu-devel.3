Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A198BC4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2024 20:09:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxY3o-0000qB-Lu; Thu, 18 Apr 2024 16:08:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rxY3k-0000pd-KV
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 16:08:42 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rxY3j-0006Is-3h
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 16:08:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+iz+jUQEjrZ/2uCpiyH8HVuRVVo++1XYCTMxdYHEJ7g=; b=r2k8MccsykcrqZBxfQf2inp+x1
 O32yqzih6ckUyGqUyuK8zgQ33/R69Lm4R9ZMlvYPzF0dpKLgKIi9HB6UmfPnEIEpAZWZW0tgRordQ
 EgYQms7Im+nX3nWq02r+xWWCYe6jiyYGnF+moQvL4gfF1mXdP6ZDgT2e6zj0FJORzs1OTfJESqmoS
 WL2lu9svy9KHk531IgR1bo91rD//4VPGSNlsjDGz4F3ApP8mjY0+0B+PWULOltBxUfzGyjv7cEY8z
 JD4CF9dTz3BREuZd346i3+oXJyqFijpsZPsRYsyNY6FG4muVoRDd9CeN1tiUdnHLmZ26zYlC08ode
 oFzZ4CkFy0h0a4/pJgcn1gBwhSYy8fBb+IiYTkDclMKhwFtx6RMiM4g48ncAMrBHrC0qFYiK3sli9
 WTDXJJrz2ItcLMGsNnRbEsF222m3uenwFMgjUO4rzC/02hr7wUjYrIlaWBfjkiF6Xz6jl8VHzjuVN
 hurGCfzrmpkScPnQ52P9BRYuqfjtjK9mN1v4G6nXVSnxmdpPnm/e6hbfQ+y1KR9WoNagmW8B2ZImf
 nIibK0GJNLl4ANPx0m0NVnn9zfUPF/5fU+u37qtYuWcY/AYMKInhiHDrKbVWTz15JuUMPjOl31icx
 Zvb4on8EwbY/9bTxYJ3EnrbkDTT1W3B1kqP+yE85o=;
Received: from [2a00:23c4:8bb4:4000:aae1:b0e7:6998:7ece]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rxY2i-0006Bz-MM; Thu, 18 Apr 2024 21:07:37 +0100
Message-ID: <df3d121a-b9cc-469e-ae7a-ded6b7705fe8@ilande.co.uk>
Date: Thu, 18 Apr 2024 21:08:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Artyom Tarasenko <atar4qemu@gmail.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20240307174334.130407-1-thuth@redhat.com>
 <bdd66aac-4de5-44a1-a1d1-86825d337d12@redhat.com>
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
In-Reply-To: <bdd66aac-4de5-44a1-a1d1-86825d337d12@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb4:4000:aae1:b0e7:6998:7ece
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH 0/5] Sparc CPU naming and help text improvements
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

On 15/04/2024 08:26, Thomas Huth wrote:

> On 07/03/2024 18.43, Thomas Huth wrote:
>> The Sparc CPU naming and the corresponding help text is somewhat
>> confusing for the users. We should avoid spaces in the Names and
>> provide clear information to the users what can be passed to the
>> "-cpu" option.
>> While we're at it, also remove the "+" from two of the CPU names
>> since this character is now not allowed in device names anymore
>> (and was worked around with an ugly hack in qom/object.c so far).
>>
>> Thomas Huth (5):
>>    target/sparc/cpu: Rename the CPU models with a "+" in their names
>>    target/sparc/cpu: Avoid spaces by default in the CPU names
>>    target/sparc/cpu: Improve the CPU help text
>>    docs/system/target-sparc: Improve the Sparc documentation
>>    docs/about: Deprecate the old "UltraSparc" CPU names that contain a
>>      "+"
> 
> Ping!
> 
> Mark, Aryom, could you please comment on this patch series, too?
> 
> Thanks,
>   Thomas

Done! I didn't realise that it was only patches 1 and 2 that were still outstanding 
until I tested the series, so I've replied to those separately.


ATB,

Mark.


