Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DE16D0BB70
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2024 08:31:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3tFp-0006uT-6H; Thu, 24 Oct 2024 04:31:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1t3tFn-0006uI-8R
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 04:31:35 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1t3tFl-0000ww-Hk
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 04:31:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:To:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID;
 bh=v+gEgdLNsBa4rPHUkjZop5D5rcFOSR0eid/5SoIMaOQ=; b=wntGWNyp3Aru1LcuGrgWWZPUVL
 2s4HDYBc6z8Gp/27YutBzcWfufxwXJKj6+S2NYg1DO7DDzpJCYFzqXX7qiQpUf7kNp1CrXRVAgy0i
 tYBKwuxy/FoQRKRO3L1kES6F8MTw+fksJsQ3IPYmrHgUvwYBe8u0YuYebzMoJJgSjd/9LdwqMJ5mY
 RJDfO681NeUxl+jBFoLp/vdCy4z5+PkfwtssGYH/hVxgvoTi+ksEydmvfupGHzG0ZYrSCihv1jor5
 QGgL01F2sDIJLWujgBB9uE7cynQd0ccOtv8DYWuDd3Dn0Y94E3aBMfBuYdHDemTl7VQ1Gyta10x3y
 mKPRR+MlzQGPYITeyk4omyiydLmzx7tD4pwdUVcWRCg36lJR8hwS1BlAQDGckBEnrQbLe5hJFxMfb
 arYxGnGRJA7g4z1q7WUhUUCUjvE2Y4X1f+jCO4LoLqvOVDpEviLxMQCs+cNSFAaXg3DIstaiJdLWR
 DfLSVV74aBeakFk32I96RhtYvTgBhkyu7dwOpHxBkhinbVialo/3fY8CGGjPalIKJYMvsjw32BmBx
 +ZWLHGtAly4FSH4twn+XOv71kYOQnfnAiTVQ/UC4zuENesGKoaxPCA37A0PRZHD8WhWPOnvgd65Tf
 +wiErl97QyMkY+9RCKhScOrkpd23XGmZbi6hV1OlQ=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1t3tFP-000CXR-Vs; Thu, 24 Oct 2024 09:31:16 +0100
Message-ID: <840e986f-f06f-405b-a008-e4de27d415a5@ilande.co.uk>
Date: Thu, 24 Oct 2024 09:31:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 huth@tuxfamily.org, qemu-devel@nongnu.org
References: <20241023085852.1061031-1-mark.cave-ayland@ilande.co.uk>
 <20241023085852.1061031-4-mark.cave-ayland@ilande.co.uk>
 <28ab5799-d096-4000-8806-0a30eeb10ba6@linaro.org>
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
In-Reply-To: <28ab5799-d096-4000-8806-0a30eeb10ba6@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH 03/36] next-cube: remove overlap between next.dma and
 next.mmio memory regions
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

On 24/10/2024 03:42, Philippe Mathieu-Daudé wrote:

> On 23/10/24 05:58, Mark Cave-Ayland wrote:
>> Change the start of the next.mmio memory region so that it follows on directly
>> after the next.dma memory region, adjusting the address offsets in
>> next_mmio_read() and next_mmio_write() accordingly.
>>
>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>> ---
>>   hw/m68k/next-cube.c | 28 ++++++++++++++--------------
>>   1 file changed, 14 insertions(+), 14 deletions(-)
> 
> 
>> @@ -897,7 +897,7 @@ static void next_pc_realize(DeviceState *dev, Error **errp)
>>       qdev_init_gpio_in(dev, next_irq, NEXT_NUM_IRQS);
>>       memory_region_init_io(&s->mmiomem, OBJECT(s), &next_mmio_ops, s,
>> -                          "next.mmio", 0xd0000);
>> +                          "next.mmio", 0x9000);
> 
> Please mention 0xd0000 was incorrect, otherwise:
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

This one is a little more fuzzy, since I'm not even sure that the new value 0x9000 is 
correct (there isn't much in the way of documentation to support this) - effectively 
the purpose of truncating this memory region is to remove the overlap with another so 
that MMIO accesses are consistently directed to the same handler.

I'll have a think about how I can re-word this better for a v2.


ATB,

Mark.


