Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34DA3F013FA
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2026 21:46:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2Fkv-000678-DS; Mon, 16 Mar 2026 17:45:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1w2Fkh-00065v-Hr
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 17:45:40 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1w2Fke-0001M9-7x
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 17:45:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID;
 bh=1BEkOPf5/tMokctuJRdssUe/TqAVcjlVpD4T4hYDOCU=; b=bBI92yTl7/P8XP8MkBkA0PqkhT
 vav6VPJyV2HeFHR2dy3R563qUD67hSH4XWYZlAmiEMXlf/S6f1Li6mRnwshBf5pB4QeTyu7DUPgZU
 KzW9woPiRnQ03nHDrVSQo0DghBr1gwPCaMWL3FrqzIUr+zBOh9jqFRhwJYtR81klKLiUDbX004pc8
 FV6Uox1fdgiGs93Je0lY18GRdGCczbmqs+Qt/aMT6mZmT2RMX+1OZBHRAStQWO9zzF8A6wzMv3spu
 kasHXjfHchRuhwcIaPexSe5bk9C9CTbBKQ7dNbxhNeBTTGRxB8CYldmznK/LU/hj7vmYFDmerPbOp
 8+7iW7S6W+z2D+miSSh1UNchHO0PfYmdyJyV0+uLGhF6GXVWS5qhp47TpWMYfwBP7orXgGDIqW2BJ
 zmykShMubVRLZoFYTqb6KD6/dcEMS9g6QS51n9TnPki+HpfYHSNHSy1gos6Ocsrp71OxJk7nGENOE
 V3AAJbOLUKmlDRu8V2yXk/JNTMoRnh/n84H6xqg9WCgCJni+PIqj5Uu+Sk505QUqoQwCIlihxyCqG
 kfVSnaBdcqhbI5tD4xqC2BZ1HTvwN76cvC6jvcJD19GEz2tY6tw2kggWpGGgpyyTmSJb+grpOzrQT
 Ms/mg+L3XpK6Ck7Da0Yme7AgnW/DIUL1Ag3nQ8us8=;
Received: from [2a02:8012:2f01:0:2257:6c08:3a5:8e25]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1w2Fhf-000496-Ef; Mon, 16 Mar 2026 21:42:23 +0000
Message-ID: <d0aa8081-30df-4696-9281-b35c2b775a57@ilande.co.uk>
Date: Mon, 16 Mar 2026 21:45:23 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Thomas Huth <thuth@redhat.com>, Peter Xu <peterx@redhat.com>,
 BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20260316130651.5C8735968DE@zero.eik.bme.hu>
 <abgqjKVFHKxuKupP@x1.local> <e596bcf2-962b-4857-addc-1200702fe455@redhat.com>
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
In-Reply-To: <e596bcf2-962b-4857-addc-1200702fe455@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:2f01:0:2257:6c08:3a5:8e25
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH] hw/display/tcx: Init memory regions in realize
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

On 16/03/2026 16:23, Thomas Huth wrote:

> On 16/03/2026 17.06, Peter Xu wrote:
>> On Mon, Mar 16, 2026 at 02:06:51PM +0100, BALATON Zoltan wrote:
>>> Due to aux-ram-share property qemu_ram_alloc_internal dereferences
>>> current_machine which is not set during init when inspecting the
>>> device. This causes the qtest/device-introspect-test to fail since a
>>
>> Does it has anything to do with aux-ram-share?  I thought it's because the
>> qom introspect test will create yet another sun-tcx device, causing double
>> registration?
> 
> I think it happens because the test starts QEMU with the sun4m machine (or whichever 
> machine uses this device by default), and then creates another instance of the device 
> for introspection (without realizing it). You can easily recreate the bug manually 
> like this:
> 
>   $ ./qemu-system-sparc -M SS-20 -display none -monitor stdio
>   QEMU 10.2.50 monitor - type 'help' for more information
>   (qemu) device_add sun-tcx,help
>   RAMBlock "tcx.prom" already registered, abort!
>   Aborted (core dumped)
> 
> An instance_init() function should not change the global state of QEMU, so 
> registering memory regions this way is a no-go. This has to be done in realize() 
> instead.

Just to confirm that when you mention global state, you're talking about registering 
the ROM in this particular case?

> So for this patch here:
> Reviewed-by: Thomas Huth <thuth@redhat.com>


ATB,

Mark.


