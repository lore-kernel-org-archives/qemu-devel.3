Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CBBCC54ED1
	for <qemu-devel@archiver.kernel.org>; Tue, 27 May 2025 20:00:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uK0SN-0005sM-F7; Tue, 27 May 2025 15:59:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1uK0SK-0005qE-4l; Tue, 27 May 2025 15:59:24 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1uK0SI-0008ID-Hp; Tue, 27 May 2025 15:59:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID;
 bh=EYv02Ky4PXRW5O2EteWhHjZhVhM+4bZnTHcaxsZhGGg=; b=z36UkeFubvixjW2P3PnCltdZKW
 7HVL2e5r5AfNLR6d+S3Ix7jQ57OAVuLFzMoEjMwvy1eKkx7zcAUjbHJi/lRebeI7BSiVUJxcbHoTn
 l9gnMfFRxHoiODWwoB9G3YyDrZm2/u+iU02d1H/31bZUpbTSs+dmdStwBqDDa7HdXRn8pbSVYUB9o
 aghgx/SYZ8oUSFJ8h1iUPs6qiJ9Iw4cxtQRW7OehMWEcnjMSDpBC2sc/K0yPtWmRZo+0fR3DG/OlG
 jTFI1BKFAzQgNehumQjVb+iKueJkMl1EQvblwDU2Yb1lER3qGl/WVCMvYIDUM4Je9hUc2PLd4tAYZ
 jiUer2o9qofz4CGJ1UKPMR4bunQcPX1KjQUf14KoCEEcdKd0HGJOH64XUnATYgnzqCwlxvkHIdVnx
 7PK5mFV/NTrAdUzxqqlnZLI37MVpHnSiTu75sD3vu0/96BMVWox7BJjS3GBPFEaJjwuOiy5HjxY6d
 u1KCurWDNsNQRUYFAZhh2R/mWQSinPWzJV77Bp76r4tebCW1ukiESJYFoNuOcQ6xxKfA0/2dlF/W/
 o3an6Vqp59OY+qVH3K81tIka4DLNzEbz4dYDBOFVo+WG5+uNBmKoA/NUKxoXGw44M+Y20POOH8BdU
 LeJ5DDArdPkRHXo4UZ3uxV4Kw0svdcqByFfj1fLos=;
Received: from [2a02:8012:2f01:0:7607:4cc5:5176:1da8]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1uK0Qg-0002Au-U9; Tue, 27 May 2025 20:57:43 +0100
Message-ID: <3e1c9618-35ce-46f5-ad35-afc26449a935@ilande.co.uk>
Date: Tue, 27 May 2025 20:59:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>, Yanan Wang <wangyanan55@huawei.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, qemu-ppc@nongnu.org,
 Eduardo Habkost <eduardo@habkost.net>, Alexander Graf <agraf@csgraf.de>,
 Markus Armbruster <armbru@redhat.com>
References: <20250526130006.49817-1-philmd@linaro.org>
 <1c9f8e9d-1ee6-b2d9-98d6-5640f59f0e4a@eik.bme.hu>
 <649e4c91-fb4c-4cb2-9810-b1ee885ffea3@linaro.org>
 <0af36d26-5509-4601-8e16-e420b0e4c53e@redhat.com>
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
In-Reply-To: <0af36d26-5509-4601-8e16-e420b0e4c53e@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:2f01:0:7607:4cc5:5176:1da8
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH 0/3] hw/boards: Remove field
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

On 27/05/2025 18:19, Paolo Bonzini wrote:

> On 5/26/25 16:20, Philippe Mathieu-Daudé wrote:
>> On 26/5/25 15:18, BALATON Zoltan wrote:
>>> On Mon, 26 May 2025, Philippe Mathieu-Daudé wrote:
>>>> Only add default devices checking defaults_enabled().
>>>> Remove the unused usb_disabled field in MachineState.
>>>
>>> At least for Mac machines this may be more complex. I think there is a - usb 
>>> switch to enable/disable USB independently of defaults and due to some bugs some 
>>> MacOS versions may need this to boot so maybe it's used.
>>
>> If the user asks -usb off, we shouldn't re-enable it in the shadow.
> 
> And if the user asks -usb on, you shouldn't disable it.  My
> understanding is that adding
> 
> -        if (!has_adb || machine_arch == ARCH_MAC99_U3) {
> +        if ((!has_adb || machine_arch == ARCH_MAC99_U3) && defaults_enabled()) {
> 
> disables USB completely when -nodefaults.
> 
> If you want to remove usb_disabled, change machine->usb to ON_OFF_AUTO
> and query
> 
> static inline bool machine_usb_enabled(MachineState *ms)
> {
>          return (defaults_enabled()
>                  ? machine->usb != ON_OFF_AUTO_OFF
>                  : machine->usb == ON_OFF_AUTO_ON);
> }
> 
> instead of machine->usb (even better, change the name of the field so that
> it causes a compilation error).

I have a feeling that this logic was added a while back to allow a build 
--without-default-devices to work? However disabling USB doesn't actually make sense 
for New World Macs, since the presence of USB ports is one of the ways of 
guaranteeing we have a New World Mac. I'm fairly sure I've seen (BSD?) kernel crashes 
if the USB ports are not present on the mac99 machine.

If MachineState::usb_disabled is removed completely, is it still possible to always 
have the USB ports enabled and the keyboard/mouse plugged into the mac99 machine?


ATB,

Mark.


