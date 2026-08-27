Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E202C61DB9
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 20:29:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzgiB-0001nD-AT; Thu, 27 Aug 2026 16:28:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1wzgi9-0001mU-T8
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 16:28:33 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1wzgi8-00075a-3l
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 16:28:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID;
 bh=yfJ6yvtwQYldEjty/NbHsb5SlOHZYqq5fc3nAy6yICU=; b=cIyjGEwcGDQTqHi2Oygo+97zHL
 zjIA+Prg5/unOGcX+4oOJ+jQTcWd7DqB4onFIZhboMadXbauaxcbBZrwl3CiwI6bl+WtywG1Pm7i2
 c0/vyVcIQLRUaTSQD/LllS9eNZ6tQMkc31ElPEgwVXXZ2SFoCtB0DBYbqsPNTmV6gLiNQgU0jiqxB
 /YWYFvVEF6QDQ2xfKzWMscxgq+xypSBZUbVueAEQTFfi/BverXz1fldRXBjw1Od/vlLahk8K3ugXi
 KnWbE1h2Rz19l9i35GtLwXqPNZ7weOWCYfPgmM0j7+d7gaZzN7vs2pmpIYSCSr0i+/1eYXY502JAV
 Dk30RFv6N8VN8WrzJhLYmR6hBwbWtfcwLjef5/20Kwxts1OUZ4TqKe7XyC1TVSLmxmGgIJ7yug2tJ
 fAaxoy6EcrfSX4XWtMz0ybUnGxXiQ5qpoxvsxZ9y9cz48E1YmYw/xvjz45D9kMcNJEaSoH2kfRPhS
 1pQ8pylDc5X3ElVbL0uQvkaJXNtSxbjOj1H3r8RnvJCZAq9BSPI/hJhUKdyK8amFPseNCQfWqr0V/
 kKrqPXacmYui9B9BFLmpCZ3NR6wKxcfUquyzvtQALxzTZa7ERUbNn2UnsO6S9e02d7XWp7+YsZZkj
 XxmHDUQ/lVD3JYXw0WY9YaQbnagNocXiR5TL9fYDw=;
Received: from [2a02:8012:2f01:0:fe49:60b9:9856:b8ef]
 by mail.ilande.co.uk with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.94.2)
 (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1wzghd-00AQAN-Sw; Thu, 27 Aug 2026 21:28:02 +0100
Message-ID: <e36d50ca-b484-4ccf-8317-347d4817b804@ilande.co.uk>
Date: Thu, 27 Aug 2026 21:28:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: Thomas Huth <thuth@redhat.com>, Thomas Huth <huth@tuxfamily.org>,
 qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>,
 Natalia Portillo <claunia@claunia.com>
References: <20231007072313.22108-1-huth@tuxfamily.org>
 <1826b106-2b9a-41e2-81a4-8a3439f9c511@ilande.co.uk>
 <bf3036ba-0259-4757-a249-68e2a15af1ea@redhat.com>
 <74883723-8f58-404c-9bab-ddb9a4aef4a8@oss.qualcomm.com>
 <CAFEAcA_ALPTQLQwA_XzqOr=Zuc4_K9=LPNXN9jN_i0fyouqwxQ@mail.gmail.com>
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
In-Reply-To: <CAFEAcA_ALPTQLQwA_XzqOr=Zuc4_K9=LPNXN9jN_i0fyouqwxQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:2f01:0:fe49:60b9:9856:b8ef
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH] docs/about: Deprecate the 'next-cube' m68k machine
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 27/08/2026 18:32, Peter Maydell wrote:

> On Thu, 27 Aug 2026 at 17:09, Philippe Mathieu-Daudé
> <philmd@oss.qualcomm.com> wrote:
>>
>> Hi Thomas,
>>
>> On 27/8/26 14:54, Thomas Huth wrote:
>>> On 09/10/2023 21.39, Mark Cave-Ayland wrote:
>>>> On 07/10/2023 08:23, Thomas Huth wrote:
>>>>
>>>> (added Natalia who was the GSoC mentor for the NeXT cube work)
>>>>
>>>>> The machine is incomplete, and unfortunately the hoped-for improvements
>>>>> never happened. So it's maybe best if we mark this machine as deprecated
>>>>> and finally remove it again in case it gets into the way of a code
>>>>> refactoring or other reasons.
> 
>>>> I'm torn a bit by this one - on the one hand the NeXT code could do
>>>> with some love, but then given that the code already uses qdev/QOM
>>>> then there isn't really much in the way of maintenance burden. The
>>>> main concern for me at the moment is the use of the old-style memory
>>>> accessors that pre-date the memory API.
>>>>
>>>> With my latest ESP patches I think it shouldn't be too hard to update
>>>> the NeXT DMA controller to get SCSI working, so perhaps we can leave
>>>> it for now if it doesn't cause too many problems?
> 
>>> Almost three years later, the world changed quite a bit. We're getting
>>> flooded with AI-generated bug reports now, and of course people are
>>> discovering problems in this old and neglected code, e.g.:
>>>
>>>    https://gitlab.com/qemu-project/qemu/-/work_items/4303
>>>    https://gitlab.com/qemu-project/qemu/-/work_items/4304
>>>    https://gitlab.com/qemu-project/qemu/-/work_items/4305
>>
>> Hobbyist motivated machine emulations never committed to be
>> secure. While I appreciate these bug reports for the overall
>> quality of the project, I'm taking these one as lowest priority.
>> I wouldn't even mind of closing them as WONTFIX "Thanks ...".
> 
> I agree, but also they can prompt us to look and say "actually
> this machine is no longer used / never got sufficiently
> implemented to be useful / has no maintainer" (cf musicpal).
> So the questions here are:
>   * is the machine's functionality better than it was in 2023:
>     can we boot something beyond just the firmware now?
>   * is anybody planning to actively work on it?
>   * is anybody using it?

The ESP rewrite solved a number of problems and it is possible to load a kernel from 
a disk image and start executing it. I do have a series that further tidies up the 
machine (with fixes for the DMA controller) but it needs a bit more work to finish: I 
believe that should be able to get a pre-installed disk image to userspace.

The assert()s are really there to catch unhandled accesses during boot and they 
aren't considered a security boundary so I think it's fine to close these as WONTFIX 
with a comment that the device is currently unimplemented and not within our security 
boundary.

Certainly booting NeXTstep was useful in figuring out parts of the ESP rewrite and 
also for helping test the 68040 emulation so it's not completely useless...


ATB,

Mark.


