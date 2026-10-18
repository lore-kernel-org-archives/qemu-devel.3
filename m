Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5C90CCA490
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Oct 2026 09:17:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIN0f-0002BL-Ir; Sun, 18 Oct 2026 05:16:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1xIN0T-0002B2-Mi
 for qemu-devel@nongnu.org; Sun, 18 Oct 2026 05:16:44 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1xIN0R-0002oI-Np
 for qemu-devel@nongnu.org; Sun, 18 Oct 2026 05:16:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID;
 bh=/jDOfMv3a5IgY91m0+AcPBXsgSHXQRHtTLgaKuub0NA=; b=gwPQs3qDpBRvn5F/H5uoJlMq6b
 wzmr68UvTL3hMIgGq+gZV5AYN0ULB1EN+gvjZQDzIWxP62S/snVXkL7YGs+lWKxn8p0hwcFs4cnxe
 2m549/UmMArSzvrseCIwwSPI3DZ21mN+RUTJeWJvUKjeRN5hkyXuYyydrxGtpULM/dllVOZDbkses
 3ypen6FconEl/TmICziONspX5SIC9cIUkrp2YV0h5x7CDBs2ceTx/VG4rw1KaQf5zAN/ubrLcGcje
 TNiFaT6aJYh7Mkb9QpbmA3vowjBbzI+k9RIv0AJ37B/POwVL31lb2tisaeTL9RZK07kWc/YTKgg4n
 ClTg53CRVeDhm3HvMIsTQpGF03bZHJUTQLWXTLD7x5CF/NlUoA7eRwslw7rLpo/gjGu+7d/lU5m54
 Y+J879mkLpaagYlxfRYG9hb4JlPtuf/Xp/Em07hl6WGb/yPV2XTkBNPogC+a0OYm2aeWAnNohgxAD
 KdR4eafW/mFtV+Jkv4HqAu87+4XKG1SWOCJ41mgtibWzj1kotFmY3VWASr636yi6Ugcz3DaS4A3xA
 jB0c9qWjwTTzyRG7ZX/K1o0nAZm+54JB7T+sVlwyY1JOlSL/BLvAkK6E+KpJlmrspBdnPfRiq8Ivn
 +m3NiNZAzecdFpwBthrXRh3VZCo6j+R+PRjGqbW/Q=;
Received: from [2a02:8012:2f01:0:7620:997c:c9a4:6fba]
 by mail.ilande.co.uk with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.94.2)
 (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1xIMzf-002N1F-G7; Sun, 18 Oct 2026 10:15:51 +0100
Message-ID: <1c31ff8b-4a61-434e-9c85-ca70194040fb@ilande.co.uk>
Date: Sun, 18 Oct 2026 10:16:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Stian Halseth <stian@itx.no>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Artyom Tarasenko <atar4qemu@gmail.com>, Eric Biggers <ebiggers@kernel.org>
References: <63d84da88caec4176900e535116d64b1c4cffffb.camel@itx.no>
 <764a9ecd-6856-4309-9ae3-8f878a9b1d8a@linaro.org>
 <0fe42d81618fc6e7a229c9c3efcbf9310987f89d.camel@itx.no>
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
In-Reply-To: <0fe42d81618fc6e7a229c9c3efcbf9310987f89d.camel@itx.no>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:2f01:0:7620:997c:c9a4:6fba
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [RFC] target/sparc: crypto instructions for Linux kernel testing
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

On 10/10/2026 09:30, Stian Halseth wrote:

> Hi Richard,
> 
> On Sat, 2026-10-10 at 09:30 +0200, Richard Henderson wrote:
>>
>> When I implemented the VIS{3,4} stuff a couple of years ago, I tried
>> to add a newer cpu (though I forget which model).  I couldn't get a
>> kernel to boot with that and sun4u, so in the end I left the cpu out
>> and left the extensions as plain cpu features.
>>
>> The biggest problem with sun4v is that it's incomplete.  It has the
>> most promise as an emulation platform because it is explicitly a
>> hyper<v<isor platform.  In the ideal case, QEMU would not faithfully
>> model the hardware, but would instead model the hypervisor
>> interface.  Which would make lots of stuff far easier and quicker to
>> emulate -- most notably the TLB.
> 
> 
> I agree. I looked into the sun4v hypervisor first, as that sounded like
> the ideal approach. I did however come to realize, as you say, that it
> would be a lot of work. Also there is the requirement for bundling the
> OpenSPARC firmware and building a boot image (no -kernel), which is a
> bit overkill for kernel testing.
> 
> Based on that reasoning I've already done some experimenting, by
> writing the crypto code for sun4u. Much of the code would be shared
> either way, so if the sun4u approach was rejected, I would still be
> able to use much of it.
> I've managed to get it working well enough to exercise the crypto
> tests. It's not in a upstreamable state yet, still work in progress. I
> took some shortcuts just to get to a proof of concept, and I wasn't
> sure it would every be finished with this approach.
> 
>>
>> But it's a big packet of work and no one has done it.
>>
> 
> Indeed, and much more than what is needed to achieve the goal of
> getting the crypto tests running, so would be out of scope for me, at
> least.
> 
> If you would be willing to accept a contribution based on my described
> sun4u approach, I could spend some time cleaning it up and run more
> thorough tests to iron out any remaining issues (which I'm sure there
> are).
> 
> Mark, for this to work Linux needs a hwcap-list property on the cpu
> node before it uses the instructions.  What are your thougts about QEMU
> passing the list in a fw_cfg file, with OpenBIOS adding the property in
> cpu_generic_init()?

Sure, I think this seems a reasonable approach to allow people to exercise various 
parts of the instruction set until someone manages to come up with a full sun4v 
implementation.


ATB,

Mark.


