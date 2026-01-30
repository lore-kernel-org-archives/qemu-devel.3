Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81276E6BF0A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Jan 2026 19:25:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlu6z-00081j-LX; Fri, 30 Jan 2026 14:24:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1vlu6v-00080u-9P
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 14:24:53 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1vlu6t-00058i-AD
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 14:24:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID;
 bh=BQAOlpged64Y6qxlb55fuaYCrqoDYYNkRPoE+OnaPjg=; b=WhtdXJ6/iWMB6BOQdx8TntsmR4
 X2uPQo00J1fux2ii6d2XuSdLoDsmKuhhwaRjIj7ZrKUpkCu4//7+/OyJZvz7mnZTO+Xz6A2k8WEea
 XIofdDjbV0Bb3bJyMC+qgqBmVVfuF9P6vgaizmL3N71Bn/7Q7FK/6iTMwLg8SS/VIW9E06GDreLyW
 EJz6wUFudgCvVjLqtZytkv+sWT3nFTsMnEZnoyykpbVpX/XHR9En4YY8+LNxY3khqaziEXtRrrK6O
 QOycHD4sOPolgFpJBTPM16oZ61j6BUq6yxmRfGPR5rxRi6WVlMYJ9ntrIUaZ2hplTrLBGhZoXd1ZD
 MNwwZWQk6KUOUBljvmhUlg0S3dtZGk/sqH/l8+OI/Fi2csr5R/2kfxOUEpLp5qknBmuLzbtQizDno
 GsZTU1oLkK7oVcN0TM56Xe4y/AGi9wfsRoG0NLQLxp+PRllJvXsQY/dksHccQpMTG7QOLB0RXArav
 JUVQf7oWM2FUJymhqS5MybmNR8URTohA/OL6Ukb6xeXDcx8+E6bvQa8pPC3L9MIOFLV+prjpMx+7X
 SBLZkkm0zrikCv8Y6l9MnqayCkgQeA9yDa1L9ZGbScFbWxKH1tVZa91UGenEz/L2z3nwXbjTXKOKC
 n57/MDT/veUSTkrrTz7Ilk7ZjQDJBMG3azpoHgfj4=;
Received: from [2a02:8012:2f01:0:627e:3663:264b:92cd]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1vlu47-0007FS-C1; Fri, 30 Jan 2026 19:21:59 +0000
Message-ID: <a4344aef-8eb7-42f4-bb2e-ab87fbd21f97@ilande.co.uk>
Date: Fri, 30 Jan 2026 19:24:40 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Peter Maydell <peter.maydell@linaro.org>,
 BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Max Filippov <jcmvbkbc@gmail.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
References: <cover.1769703287.git.balaton@eik.bme.hu>
 <b530cf54609b853c6b34306fd4aa3ce2f8087d05.1769703287.git.balaton@eik.bme.hu>
 <CAFEAcA9+sKLXmzXz98rfnEqVBE4WwVcFsMqiXSx6KfK1=PDfKA@mail.gmail.com>
 <31362eca-9cd5-8b6b-a3a1-4ddb8dc3e762@eik.bme.hu>
 <CAFEAcA9htbxy0fHZAvdX6Rneina-r_a1ajN3w3FHUL=hykcyug@mail.gmail.com>
 <69ca374e-960f-89a7-0f74-b42977a51d3e@eik.bme.hu>
 <CAFEAcA_wdHO80SpoCNk6tgyKmN2s=Tk_hOVbcef8+v17H=xhFg@mail.gmail.com>
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
In-Reply-To: <CAFEAcA_wdHO80SpoCNk6tgyKmN2s=Tk_hOVbcef8+v17H=xhFg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a02:8012:2f01:0:627e:3663:264b:92cd
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH 2/4] hw/display/{cg3.tcx}: Do not use
 memory_region_init_rom_nomigrate()
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

On 29/01/2026 20:22, Peter Maydell wrote:

> On Thu, 29 Jan 2026 at 19:08, BALATON Zoltan <balaton@eik.bme.hu> wrote:
>>
>> On Thu, 29 Jan 2026, Peter Maydell wrote:
>>> On Thu, 29 Jan 2026 at 17:20, BALATON Zoltan <balaton@eik.bme.hu> wrote:
>>>> On Thu, 29 Jan 2026, Peter Maydell wrote:
>>>>> On Thu, 29 Jan 2026 at 16:21, BALATON Zoltan <balaton@eik.bme.hu> wrote:
>>>>> This is a migration compatibility break, because the
>>>>> memory_region_init_rom() function registers the MR
>>>>> for migration via vmstate_register_ram(), which picks
>>>>> an ID string for the memory that includes the path
>>>>> of the device, whereas vmstate_register_ram_global()
>>>>> picks an ID string for the memory that does not include
>>>>> the path of any device. It is this difference that is the
>>>>> reason why they're still using the _nomigrate functions.
>>>>
>>>> I thought it might be the case but wasn't sure. How was this handled in
>>>> all other machines where they were converted to not use _nomigrate? Only
>>>> some Sun machines still seem to use this and this may be a good
>>>> opportunity to bring them inline with all other machines.
>>>
>>> If I remember correctly, we converted all the machines where
>>> we were happy at the time to have a compat break. The remainder
>>> are not only Sun machines -- you can see in your patch 4 that xtensa
>>> and vga are also affected.
>>
>> Well, almost all of the usages are because of the Sun machines and those
>> could be easily converted accepting one time migration break. The VGA one
>> seems to be because of isa cards which may not have been QOM'ified so
>> could not be converted before but maybe could be now but I haven't checked
> 
> We can't change the the vga usage, because it's a migration compat
> break, and you can use vga on x86 PC machines, where we do care
> about not breaking migration.

Yeah. Whilst we don't necessarily guarantee Sun machine migration between QEMU 
versions, I'd still like to keep it if possible. If the Sun machines were the last 
holdout here then I'd say let's just accept the break: however given that it's 
impossible to remove these functions because of VGA then the reasons for breaking 
migration compatibility become much less compelling.


ATB,

Mark.


