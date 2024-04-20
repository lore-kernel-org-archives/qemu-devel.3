Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AA08C4345F
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Apr 2024 05:45:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ry3Wj-00022T-3h; Sat, 20 Apr 2024 01:44:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1ry3We-000226-EU
 for qemu-devel@nongnu.org; Sat, 20 Apr 2024 01:44:36 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1ry3WX-0006kJ-Dt
 for qemu-devel@nongnu.org; Sat, 20 Apr 2024 01:44:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=XQpP0z0b/Q9IEMaUHkGQ/i8GmmgdTwzU+LBaEm+dNtg=; b=KRASrN21SL0bPoppuissr8TcA3
 QOSiZQWOGVaJ03/K6grB7qN3NkcncSC+gWYlqgV0Ys56b5O9gqcadZduigfvVzfHk9QLtpJfEVaok
 x7LxOMIrIbamUDJNagH0LeacoJKi0sUMUAH42ZfcTCtO/YaDIL1k4wN6ZBa/iBzPCSWrsrUCD1Q0M
 KxsvhKmXe52p56qTmQnCiLQdg7GQYES2JG8eCAlRz52XJEaCgwYR5unMcoXZzlxss8ksaACSityjd
 RcGdWkAMr6FsOiWajMRzPKsboR18viDsSGxesbl2dRuzp4LBtEcQrk3gdMKOyI/9On0OL6u0+lBtA
 b/AQbQ/1bOjz+Oy7JlPgN1irqznUnX90UaGAZVQTTdi0Un//VUYOQbDmcWFVc4a311BrhQf7oPcF0
 EwAPHG3fW6+GbRkMOQp56LJm5V9VXKVieeMz+DaOl5kxboRSbnmHOXhJVqMcltaRWrlcBIS/pebPb
 pMhwgu3fxFQlvuLjt+XV8Nsqx0SeGcEbGQMtjdEW0OApI9IDh7KFrdQJ2YVCk8H4ly/YgSpn+yX3e
 YU+UsT7XrU1cyTSHgjiv4ktnYzZxTgdBngmBEGwqqKIXr6yGefqbYD90QqxT4BO7bc4sk2GHK0AFa
 HwA5VijBbNmlNXBksRPR3BHJxAD60AQyTc+ShbVbg=;
Received: from [2a00:23c4:8bb4:4000:a36d:d178:601a:c356]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1ry3VU-000Aul-R8; Sat, 20 Apr 2024 06:43:25 +0100
Message-ID: <c9a9d060-a7e1-415f-a9a5-6b559d1fd32a@ilande.co.uk>
Date: Sat, 20 Apr 2024 06:44:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Brad Smith <brad@comstyle.com>, Thomas Huth <thuth@redhat.com>,
 qemu-devel@nongnu.org, Artyom Tarasenko <atar4qemu@gmail.com>
Cc: Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20240307174334.130407-1-thuth@redhat.com>
 <20240307174334.130407-5-thuth@redhat.com>
 <529ece4e-1de6-4941-bb75-c10997aad13c@ilande.co.uk>
 <59c90771-3bef-4f35-bd3f-0cbf9d7551c5@comstyle.com>
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
In-Reply-To: <59c90771-3bef-4f35-bd3f-0cbf9d7551c5@comstyle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb4:4000:a36d:d178:601a:c356
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH 4/5] docs/system/target-sparc: Improve the Sparc
 documentation
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

On 20/04/2024 00:14, Brad Smith wrote:

> On 2024-04-18 4:27 p.m., Mark Cave-Ayland wrote:
>> On 07/03/2024 17:43, Thomas Huth wrote:
>>
>>> Add some words about how to enable or disable boolean features,
>>> and remove the note about a Linux kernel being available on the
>>> QEMU website (they have been removed long ago already).
>>>
>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>> ---
>>>   docs/system/target-sparc.rst | 8 ++++++--
>>>   1 file changed, 6 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/docs/system/target-sparc.rst b/docs/system/target-sparc.rst
>>> index 9ec8c90c14..9f418b9d3e 100644
>>> --- a/docs/system/target-sparc.rst
>>> +++ b/docs/system/target-sparc.rst
>>> @@ -27,6 +27,11 @@ architecture machines:
>>>   The emulation is somewhat complete. SMP up to 16 CPUs is supported, but
>>>   Linux limits the number of usable CPUs to 4.
>>>   +The list of available CPUs can be viewed by starting QEMU with ``-cpu help``.
>>> +Optional boolean features can be added with a "+" in front of the feature name,
>>> +or disabled with a "-" in front of the name, for example
>>> +``-cpu TI-SuperSparc-II,+float128``.
>>> +
>>>   QEMU emulates the following sun4m peripherals:
>>>     -  IOMMU
>>> @@ -55,8 +60,7 @@ OpenBIOS is a free (GPL v2) portable firmware implementation. 
>>> The goal
>>>   is to implement a 100% IEEE 1275-1994 (referred to as Open Firmware)
>>>   compliant firmware.
>>>   -A sample Linux 2.6 series kernel and ram disk image are available on the
>>> -QEMU web site. There are still issues with NetBSD and OpenBSD, but most
>>> +There are still issues with NetBSD and OpenBSD, but most
>>>   kernel versions work. Please note that currently older Solaris kernels
>>>   don't work probably due to interface issues between OpenBIOS and
>>>   Solaris.
>>
>> Just curious as to what current issues exist with NetBSD and OpenBSD? At least both 
>> my NetBSD and OpenBSD test images survive a casual boot test here with latest git.
> 
> I was just trying OpenBSD/sparc64 with 8.2 recently and found hme(4) does
> not work. I tried with the NE2k driver as I remember adding the driver to the
> OpenBSD kernel before an hme driver existed and it sort of worked, but there
> were still issues.
> 
> I'll re-test with 9 now and see what happens.

Thanks for the update: my local tests for SPARC changes are boot tests, so it's 
entirely possible I could miss an issue with the hme device.

Feel free to open a GitLab issue with the relevant information and I'll take a look 
as time allows.


ATB,

Mark.


