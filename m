Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43855E7716A
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Dec 2024 22:10:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMaKa-0006CN-RZ; Sat, 14 Dec 2024 17:09:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tMaKZ-0006CC-1F
 for qemu-devel@nongnu.org; Sat, 14 Dec 2024 17:09:47 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tMaKX-0001lB-Ao
 for qemu-devel@nongnu.org; Sat, 14 Dec 2024 17:09:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:To:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID;
 bh=KxKZmcn3kP8SU3gS4WPEtsX0n9HPWlLcZUcfBQ/Nch0=; b=VkuxAjrcHSn2640GYu8PA2MKb/
 seL14E3hSsDVFw5iPqr55mwQOx1TaGYJSRFjKxJtrrGMVDXbrm7vDIPS5QPgTZkS7p+ObKkFV3Ylv
 scTeGp2QC1f4KBl9ul0/qXuvRWK2iz/4Xdv901ZnLB7F6GSSYU6o8hHGPc0p9zHSKRLL3Ka9Q25D3
 7pgHHK8tSWnc/WC+whk0VKm+kT7sVcxitE/6Z888QWsGrsQChFqZjY2wuMUL3u0KCq2UpP/2ilIWP
 Q+g6YBoDVgGdfHxxGimEj9IPY16No7mT+gPW59unxZBmQzIAD5rQy82Cii34DZH+cSAyOQEWn+wBy
 9GbSnHwL5CtL9itYK9Ze3nfZwZ3Fg8UwiGFf0KAUeYXysQyi7vquRT6PBmoNx63b7UvToyNa93QA5
 8GVOD+d+J+qULdqQwfQdSrneyoh7XU4j3X5gBgFcyPiOSOT1hdlRbR/W/a1aLeSavswK3QLB1hWod
 q2BREBgp6pieXiMD46Hyi8G0UwaNwT9pg8PNlbX1K8iOpCQcrLKqwrasgtGXRCi0bn9BtgJ2ej4tP
 YBzaSxoh6qY2vyXGeum0EIdoVwk60oNRS40TMGUsl5TZsnzwER+Y9u/PvTNfr9P1jovHxDcQnj8Di
 dhNrHacD7yIGHhjVahNSfpZYA725csHYoj9mXCAms=;
Received: from [2a02:8012:2f01:0:839f:b883:9bde:613a]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tMaJu-0006Tp-3u; Sat, 14 Dec 2024 22:09:10 +0000
Message-ID: <d2fdd9cd-dade-4aae-ac5f-e6ad55c1e037@ilande.co.uk>
Date: Sat, 14 Dec 2024 22:09:37 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 huth@tuxfamily.org, qemu-devel@nongnu.org
References: <20241212114620.549285-1-mark.cave-ayland@ilande.co.uk>
 <20241212114620.549285-13-mark.cave-ayland@ilande.co.uk>
 <1c80c24a-547e-4212-a4fa-5b9665edf09a@linaro.org>
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
In-Reply-To: <1c80c24a-547e-4212-a4fa-5b9665edf09a@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:2f01:0:839f:b883:9bde:613a
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH v2 12/34] next-cube: move timer MMIO to separate memory
 region on next-pc device
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

On 14/12/2024 13:29, Philippe Mathieu-Daudé wrote:

> On 12/12/24 12:45, Mark Cave-Ayland wrote:
>> Move the timer MMIO accesses to a separate memory region on the next-pc device
>> instead of being part of the next.scr MMIO memory region.
>>
>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>> Reviewed-by: Thomas Huth <huth@tuxfamily.org>
>> ---
>>   hw/m68k/next-cube.c | 63 +++++++++++++++++++++++++++++++++++----------
>>   1 file changed, 50 insertions(+), 13 deletions(-)
> 
> 
>> +static uint64_t next_timer_read(void *opaque, hwaddr addr, unsigned size)
>> +{
>> +    uint64_t val;
>> +
>> +    switch (addr) {
>> +    case 0 ... 3:
>> +        /*
>> +         * These 4 registers are the hardware timer, not sure which register
>> +         * is the latch instead of data, but no problems so far.
>> +         *
>> +         * Hack: We need to have the LSB change consistently to make it work
>> +         */
>> +        val = extract32(clock(), (4 - addr - size) << 3,
>> +                        size << 3);
> 
> Does this mean ...
> 
>> +        break;
>> +
>> +    default:
>> +        g_assert_not_reached();
>> +    }
>> +
>> +    return val;
>> +}
>> +
>> +static const MemoryRegionOps next_timer_ops = {
>> +    .read = next_timer_read,
>> +    .write = next_timer_write,
>> +    .valid.min_access_size = 1,
>> +    .valid.max_access_size = 4,
>> +    .endianness = DEVICE_BIG_ENDIAN,
> 
> ... this should be in little endianness?
> 
> Anyhow,
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
>> +};

That's a good point re: endian. I don't have any documentation for the timer device, 
so the patch is focused to moving its registers to a separate memory region. It's 
definitely something to consider in the future though.


ATB,

Mark.


