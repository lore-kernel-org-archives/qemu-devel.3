Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9774C54751
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2024 08:44:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjEHN-0004Sj-U8; Wed, 28 Aug 2024 04:43:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1sjEHM-0004RL-Ow; Wed, 28 Aug 2024 04:43:48 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1sjEHK-0002mF-Vf; Wed, 28 Aug 2024 04:43:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID;
 bh=hYSXzKKTJiQl2reHDZ35uAsCW1EFe0QV6AyUrLko564=; b=q9VI+9glBdBcDd5H6aNDmp+IEh
 C/olAhSJNHyeF1uZWDwI7rIP3KD1T3kAZfJZTVA+mQ3YU3kavM5qiMumcj85gG423+I7Zbx+u/jlu
 KAxrbA/d+37rrnm6Dpr1GKOm11FuNjDVA3Zjz9wwsNnzj0s++bObMZNKeh/OpJFDXwjhe3c6+bmKA
 5ln7MP98iyYhkdRgS9qOY9Yd9IUlbeVQczb/XTC8i6Gz+U46nf0DWJ2EK+SYqFefKVs2tjh17NAcW
 3QceJnquieeZmK2zDYLR8Zn/nxTTlya/0OcpIfSfDGY+6lXBoyZDeZkZdZEO+PPoVakFMFDTRHRcB
 Q2BYjh6NSQ9sK5yz+G4adtolMfpWSwzvN/pkAwe9CVubeP9ErA0ZQw6KkRBCYe5QDos3qcdSqTTPt
 9oozsUR94G5Tl2v3FdGpxlSBCpmaMsrYk3yicSmN5WZadXtwiGB1YYUo62aPRQIMRXDX0/oJZVvxJ
 q0StdlTsVye+63GE4+XSON5HKQYAj0PgJ2OEKY/Q89hXbOaOsNkcIknCMUlqc8i9rlQ5JxxyahD4a
 AZtExQvcmNmpvkdY34PETQzfbuqUNDKSiP0UNUPOrfQY4H1V+jMzIc+l+OHLbp8E80jQTWWHui9u4
 FbFuLFNVSii8XM28h63jL0eVuKtb13S3u588fzfag=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1sjEGn-0009Am-6Z; Wed, 28 Aug 2024 09:43:17 +0100
Message-ID: <75a65917-1504-43dc-9726-45cb1403ae62@ilande.co.uk>
Date: Wed, 28 Aug 2024 09:43:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org
References: <20240827100207.3502764-1-mjt@tls.msk.ru>
 <0a691100-7c80-40bc-b02b-dccdad510e1c@ilande.co.uk>
 <d52cafbc-351c-41cd-8796-d10ea13b75c9@tls.msk.ru>
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
In-Reply-To: <d52cafbc-351c-41cd-8796-d10ea13b75c9@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH] mark <zlib.h> with for-crc32 in a consistent manner
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 27/08/2024 18:51, Michael Tokarev wrote:

> 27.08.2024 15:09, Mark Cave-Ayland wrote:
>> On 27/08/2024 11:02, Michael Tokarev wrote:
>>
>>> in many cases, <zlib.h> is only included for crc32 function,
>>> and in some of them, there's a comment saying that, but in
>>> a different way.  In one place (hw/net/rtl8139.c), there was
>>> another #include added between the comment and <zlib.h> include.
>>>
>>> Make all such comments to be on the same line as #include, make
>>> it consistent, and also add a few missing comments, including
>>> hw/nvram/mac_nvram.c which uses adler32 instead.
> ...
>>>   //#define DEBUG_STELLARIS_ENET 1
>>
>> For the hw/net devices there are separate net_crc32() and net_crc32_le() functions 
>> from net/net.c which are intended for (most) network devices where the "standard" 
>> polynomials are used.
> 
> In many hw/net files I touched in this patch, *both*
> plain crc32() and qemu's net_crc32() are used.
> 
> For now I just marked the #include, nothing more, we
> can finish the refactoring later if needs to be.
> 
> Speaking of crc32 from zlib, I don't really see a point
> in re-implementing it in this context (it is re-implemented
> in net/net.c:net_crc32(), with comment "XXX: optimize*).
> Implementation from zlib is quite a good one. Not the best
> possible but definitely not the worst and is better than
> net_crc32().
> 
> (See also https://create.stephan-brumme.com/crc32/)

Right, I was just wondering that since you were already changing the zlib.h includes 
if you were interested to update the net devices and switch net_crc32() to use the 
zlib implementation whilst you were working in that area ;)

> What we definitely *can* optimize is the two cases in
> tcg (arm and loong iirc) - they have hardware isns for
> crc32, but these operate in fixed 4 or 8-bytes integers,
> and there, implementing a function in qemu would be
> nice - not much code but significant speedup due to
> fixed size of the argument.
> 
> I don't see any isse with using crc32 from zlib, since
> zlib is used for other things anyway and is mandatory
> dependency.  In case of qemu-user binaries, even static
> link, it is tiny (since only crc32 stuff is linked to),
> but there it would be more interesting to have in-qemu
> implementation for static-size isns.

Agreed, I can certainly see the need for an implementation in the QEMU core. In which 
case the net_crc32_*() functions will then be simple wrappers onto those 
implementations...


ATB,

Mark.


