Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B5ABC48BEB
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 15:41:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcoWE-0006Mb-E5; Wed, 21 Feb 2024 10:28:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rcoNq-0008S0-32
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 10:19:42 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rcle9-0005Sh-Sg
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 07:24:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=AYdgUMZHknnV+FxBg4HElH/WjGl/NLq3YIoh5lh6UB4=; b=HE7iGEiKzbEb7Ym2MR/cD3CVrM
 KXhiXfYTly6+8NBM9QcfeTW0iNNzjpq0zT6cuCFS41j1Z6RnLvSXi38O+F/0w48gSyfBAg+GvcmUV
 nINDsVP5zG8d8XXLd2iWYhn4aa2/5qYBnYz9hMifPmfqFCzbT70KDlZenO8ikeAUa6sAyleTY7VB5
 p1sfcH/6/F3BAKJw2RYrT2rlEZKm73eI3805wJ/pH/mMN+9/s6lsRQZN8BR/I4dAqWLRYSmjlX74a
 G0n4fpBeLgsPE1w3A9rLTjjh9znmb1xLatrp46K2k3iq+N+PAhRJ4lhAMhtQldDQmgCb7/VmjLDOy
 JG65qBRxMNyIRqMRGBjd3QJUETE0lXTBGvPoKfugMZNRTKRGPlYRs2D/zFQ5sDX3LURz4cjeqGhCv
 NDtbGfPQEx01wv0ne34oUbcLWHCwk2miqRJhhqvq0BLYFRQfbMRyPPZNgqEClBLGsNg14K7JfsicD
 IF6jOpOxTM+huOid1OgYNkkhi/TbQJbjQEKKi4corWWmOpUmGQxvOXxka7lpbNqGZWomWhBTTm0/u
 BYrX7nwc0bw+57Mu5+z81D/fEJbxI9fcv4oHPV86hZZaEBReyFCS9JcRmY+Ej2KnKSyCE5wttAFxO
 pnA8dmRP89z8ioglbxZYKPEFC8x+aR2P+zh1WIniQ=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rcldQ-0008Yv-S1; Wed, 21 Feb 2024 12:23:37 +0000
Message-ID: <0d0387a4-e6d2-49ef-8bf1-72e09ae8527f@ilande.co.uk>
Date: Wed, 21 Feb 2024 12:24:17 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Alexander Graf <agraf@csgraf.de>,
 Anton Johansson <anjo@rev.ng>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>
References: <20240220192625.17944-1-philmd@linaro.org>
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
In-Reply-To: <20240220192625.17944-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [RFC PATCH 0/2] hw: Replace cpu_interrupt() calls by
 qemu_irq(QDev GPIO)
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

On 20/02/2024 19:26, Philippe Mathieu-Daudé wrote:

> Hi,
> 
> cpu_interrupt() doesn't scale well with heterogenous machines
> because its mask is target specific (defined in target/ARCH/cpu.h).
> 
> While it is (often...) used by target-specific hw to notify cpu,
> there is no restriction to use such target-specific hw in a
> heterogeneous setup, where it'd still target the same kind of
> target cpus.
> 
> The Alpha Typhoon HW is unlikely to be used heterogeneously,
> but it is the simplest case I found to illustrate how I plan
> to remove cpu_interrupt() calls from hw/: use the QDev GPIO API.
> 
> Does that sound good enough?

I think the basic mechanism of setting/resetting the interrupt using qdev GPIOs 
should work, but I wonder if there isn't a better way of defining them to avoid more 
#ifdeffery.

Is it possible to come up with some declarative syntax in either CPUClass or 
CPUClass::sysemu_ops that would avoid the developer manually having to call 
qdev_init_gpio_in_named() manually during CPU init() and/or create the various _irq() 
callback functions by hand?

> Thanks,
> 
> Phil.
> 
> Philippe Mathieu-Daudé (2):
>    target/alpha: Expose TMR and SMP IRQ lines via QDev
>    hw/alpha/typhoon: Set CPU IRQs using QDev API
> 
>   hw/alpha/typhoon.c | 15 +++++++++------
>   target/alpha/cpu.c | 30 ++++++++++++++++++++++++++++++
>   2 files changed, 39 insertions(+), 6 deletions(-)


ATB,

Mark.


