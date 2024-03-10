Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABB4EC54791
	for <qemu-devel@archiver.kernel.org>; Sun, 10 Mar 2024 08:03:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjE9L-00070Q-DA; Sun, 10 Mar 2024 04:03:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rjE9H-000708-EN
 for qemu-devel@nongnu.org; Sun, 10 Mar 2024 04:03:11 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rjE9F-0004CW-L6
 for qemu-devel@nongnu.org; Sun, 10 Mar 2024 04:03:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=wtItqWqqIsHKAUwsIdy91OnfF+c2OoPrLow0u/hcUxI=; b=e8xMppJyys8EWk7im77esniIvd
 AVON9FEUfSaMUvz16xoHrlmFPyleEU2ICY6ec8YNMXl9iMo7y4/Mt/apB/oK8Z96ffEruSIYzih2F
 /OeGzw3FdYaV6BE5dyvo43pdR1q1ekHfMy7LB1hNKJyVDnOQgHAF13w2kJWlQ5Hqxb8CKdt2a44hE
 igRlPeUXmjG4RneswhPvZ3LmfvjDdP4+WY6RN/esItbzXwEGfbpGyUEMQcs0O2C2/7MV80cf16vgJ
 poME81a84QYat5Efq6B//EB8XypbFY6UB/FIsldYlcB9Aa0LZnc47ijHnJ21YWM8HEnqQLEWm3v+E
 1JuL0lM8zWtxQfRE6znUe5KtYQqpqsXl2gtCZdU6Xw5rrKYY0uxq5KvKsUBF9Z4sEtNuW3Dm2NrB6
 ReiEN0I3m02hTP0sTk8uoGincLf7/i3brcqF1JfJMhzBKV6qchDCtM295eSf6aOTL5Y1gGxWOe4W6
 i7w8wnjeNXMBhNHZ71B1SlDbzuca7jU/Il7FFByajRlpHUgiX80AbcalxhNDHBJpi0tsuV4l3RrTL
 LnWYyqwdPeMFX2udNGcMebuMbeiYpo6if+dAzQX90f6u2RSSGGNEzj2GGBmAF8MOVSyXacOtgj6O4
 CzyANqeV3LEVlwe8YyxYu9b92HgWGg2TdVGrH0kFE=;
Received: from [2a00:23c4:8bb3:600:a8bc:9d94:f9b5:5308]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rjE8J-00068l-0X; Sun, 10 Mar 2024 08:02:15 +0000
Message-ID: <ad6b5691-5a9f-4c90-b0c4-5315cea40ecb@ilande.co.uk>
Date: Sun, 10 Mar 2024 08:02:54 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Stefan Weil <sw@weilnetz.de>, Bin Meng <bmeng.cn@gmail.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Bin Meng <bin.meng@windriver.com>, Cleber Rosa <crosa@redhat.com>,
 John Snow <jsnow@redhat.com>
References: <20220908132817.1831008-1-bmeng.cn@gmail.com>
 <20220908132817.1831008-4-bmeng.cn@gmail.com>
 <556496df-4362-6780-8379-e14bf4269e3f@ilande.co.uk>
 <CAEUhbmVmKhJJk0pQcVJKryie+V4uZEznZCu0dzjftYCycBtD8w@mail.gmail.com>
 <504673a3-d269-428d-876d-fd3dcc8fe680@weilnetz.de>
 <CAEUhbmUdvtbAZSOh_hQRLFmQtr8zeUadm6XBo+Ayg=CvidCOag@mail.gmail.com>
 <3b6e065d-c50f-4503-bcd1-f6f08e734d97@weilnetz.de>
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
In-Reply-To: <3b6e065d-c50f-4503-bcd1-f6f08e734d97@weilnetz.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb3:600:a8bc:9d94:f9b5:5308
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH 3/7] scripts/nsis.py: Automatically package required DLLs
 of QEMU executables
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

On 26/02/2024 06:30, Stefan Weil via wrote:

> Am 26.02.24 um 05:35 schrieb Bin Meng:
> 
>> On Mon, Feb 26, 2024 at 1:37 AM Stefan Weil<sw@weilnetz.de>  wrote:
>>> Am 10.09.22 um 02:37 schrieb Bin Meng:
>>>> On Sat, Sep 10, 2022 at 12:49 AM Mark Cave-Ayland
>>>> <mark.cave-ayland@ilande.co.uk>  wrote:
>>>>> On 08/09/2022 14:28, Bin Meng wrote:
>>>>>
>>>>>> From: Bin Meng<bin.meng@windriver.com>
>>>>>>
>>>>>> At present packaging the required DLLs of QEMU executables is a
>>>>>> manual process, and error prone.
>>>>>>
>>>>>> Actually build/config-host.mak contains a GLIB_BINDIR variable
>>>>>> which is the directory where glib and other DLLs reside. This
>>>>>> works for both Windows native build and cross-build on Linux.
>>>>>> We can use it as the search directory for DLLs and automate
>>>>>> the whole DLL packaging process.
>>>>>>
>>>>>> Signed-off-by: Bin Meng<bin.meng@windriver.com>
>>>>>> ---
>>>>>>
>>>>>>     meson.build     |  1 +
>>>>>>     scripts/nsis.py | 46 ++++++++++++++++++++++++++++++++++++++++++----
>>>>>>     2 files changed, 43 insertions(+), 4 deletions(-)
>>>>>>
>>> [...]>>> diff --git a/scripts/nsis.py b/scripts/nsis.py
>>>>>> index baa6ef9594..03ed7608a2 100644
>>>>>> --- a/scripts/nsis.py
>>>>>> +++ b/scripts/nsis.py
>>>>>> @@ -18,12 +18,36 @@ def signcode(path):
>>>>>>             return
>>>>>>         subprocess.run([cmd, path])
>>>>>>
>>>>>> +def find_deps(exe_or_dll, search_path, analyzed_deps):
>>>>>> +    deps = [exe_or_dll]
>>>>>> +    output = subprocess.check_output(["objdump", "-p", exe_or_dll], text=True)
>>> This fails on non x86 hosts where objdump does not know how to handle a
>>> Windows x86_64 exe file.
>> Does this command work in the MSYS2 environment on Windows Arm?
> 
> 
> I don't know and cannot test that, because I don't run Windows on ARM.
> 
>>>>>> +    output = output.split("\n")
>>>>>> +    for line in output:
>>>>>> +        if not line.startswith("\tDLL Name: "):
>>>>>> +            continue
>>>>>> +
>>>>>> +        dep = line.split("DLL Name: ")[1].strip()
>>>>>> +        if dep in analyzed_deps:
>>>>>> +            continue
>>>>>> +
>>>>>> +        dll = os.path.join(search_path, dep)
>>>>>> +        if not os.path.exists(dll):
>>>>>> +            # assume it's a Windows provided dll, skip it
>>>>>> +            continue
>>>>>> +
>>>>>> +        analyzed_deps.add(dep)
>>>>>> +        # locate the dll dependencies recursively
>>>>>> +        rdeps = find_deps(dll, search_path, analyzed_deps)
>>>>>> +        deps.extend(rdeps)
>>>>>> +
>>>>>> +    return deps
>>> [...]
>>>>> FWIW I wrote a similar script a while back to help package a custom Windows build for
>>>>> a client, however I used ldd instead of objdump since it provided the full paths for
>>>>> DLLs installed in the msys2/mingw-w64 environment via pacman which were outside the
>>>>> QEMU build tree.
>>>>>
>>>> Yep, ldd also works, but only on Windows native build. objdump can
>>>> work on both Windows native and Linux cross builds.
>>> objdump fails on Linux cross builds on any non x86 host, because objdump
>>> typically only supports the native host architecture.
>>>
>>> Therefore I get an error on an ARM64 host (podman on Mac M1):
>>>
>>>           objdump: /tmp/tmpvae5u0qm/qemu/qemu-system-aarch64.exe: file
>>> format not recognized
>>>
>>> I could use x86_64-w64-mingw32-objdump to fix the cross builds, but then
>>> native builds might fail because they don't have x86_64-w64-mingw32-objdump.
>>>
>>> Is there a simple way how we can get the information here whether
>>> objdump requires a cross build prefix?
>> For QEMU Windows, I believe the only supported architecture is x86_64,
>> correct? Do we want to support (cross) building QEMU for Windows Arm?
> 
> 
> Yes, I think we only support QEMU on Windows x86_64. I also don't know anyone who has 
> tried building for Windows ARM. And up to now I also was never asked for that, so 
> obviously there is still no need for it.
> 
> 
>> Based on your observation, objdump on Linux cross builds on any x86
>> host works, but not on non x86 host.
>> Maybe it's a hint to ask for binutils guys to include the PE format
>> support for objdump Arm by default.
> 
> 
> I am afraid that we'll have to find a solution on the QEMU side, not wait until all 
> binutils support the PE format for x86_64 (which would make the binaries or the 
> library much larger).

Another thought here: now that python is required to build QEMU, is it possible to 
use a python-based PE parser to extract the dependency information for both Windows 
native and cross builds? For example using something like 
https://github.com/erocarrera/pefile?


ATB,

Mark.


