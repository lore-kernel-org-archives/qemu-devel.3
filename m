Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 499E2D0BB70
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2024 08:42:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3tPb-000895-Sf; Thu, 24 Oct 2024 04:41:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1t3tPa-00088t-2G
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 04:41:42 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1t3tPX-0002Jf-4Y
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 04:41:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:To:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID;
 bh=0PTWFwqPHVBCZfiNnDFmM41gRJS14UYrCHwf+jgtQ20=; b=WSPMijgnzjT87PwAOqJzPoZWSg
 dxxmVLXWLvEXMTt998A1uMnIfBmZfeCrPtnAUFrV2kI97Lr0GcKkBR0npxkuOu2lJGrqEQKb9ZqU5
 CK9PUh5ZKMF/ZiCbY68vXK0D6i6usYYu+mj0kNXqvscc/DoNILG5Fkb5NSsx2/X71opkJlIZYCSCa
 HLzFhTdFoXOYfaqzvWgOgS/WhqMTvGsk/FnxFLPnB7LWS7sjsuofG21E56XfXRDu/HqmhEkf/oi/8
 1zfmA62bOra8c3K8QqXP5os9DpvrDAwGfsVKqDRU3Bhn6OzBv7rgz/W1VciYMMqUY5qGwugqY60/5
 NjxPF/r1yg+5zuOeBt/i4HyqX/o6iAUy6kelDPed7u80HnhS5DLSw7+GdUhQI5DSrMzHS1ipli+I0
 EpEDe2Nogq+dOsm4EkRIbvGW6F5sPig5OdKgUe01Ht4UfEpeMU+cnI7vfJZOn1WRx9HSpjZt4fdm4
 V3sbYH255ef0qrTX/tq2q0D0kS7rpgjJNJHirsRLMOzzbHjwmPk/w36l9RCZUUsOdcxnlUhdpQiCZ
 NhKrPDfJE0UkfRYUmllAgbHh7WycEjvI12JcmzDw/nrl6SxR198uHqqxukuExbEcw7gn7YSV7to/O
 /F/xc01PXkpbf7pxnz8cLOM1oLDcK0OwVfrk5wDZo=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1t3tPA-000Cdw-Rd; Thu, 24 Oct 2024 09:41:20 +0100
Message-ID: <e67d9e2a-d616-47ff-92a2-f4c7ea9eb70f@ilande.co.uk>
Date: Thu, 24 Oct 2024 09:41:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 huth@tuxfamily.org, qemu-devel@nongnu.org
References: <20241023085852.1061031-1-mark.cave-ayland@ilande.co.uk>
 <20241023085852.1061031-28-mark.cave-ayland@ilande.co.uk>
 <ff126981-ddd6-41a7-bcd4-f27083a0445a@linaro.org>
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
In-Reply-To: <ff126981-ddd6-41a7-bcd4-f27083a0445a@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH 27/36] next-cube: QOMify NeXTRTC
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

On 24/10/2024 03:44, Philippe Mathieu-Daudé wrote:

> Hi Mark,
> 
> On 23/10/24 05:58, Mark Cave-Ayland wrote:
>> This is to allow the RTC functionality to be maintained within its own separate
>> device.
>>
>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>> ---
>>   hw/m68k/next-cube.c | 66 ++++++++++++++++++++++++++++++++-------------
>>   1 file changed, 48 insertions(+), 18 deletions(-)
>>
>> diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
>> index e4d0083eb0..6b574d39cf 100644
>> --- a/hw/m68k/next-cube.c
>> +++ b/hw/m68k/next-cube.c
>> @@ -42,7 +42,13 @@
>>   #define RAM_SIZE    0x4000000
>>   #define ROM_FILE    "Rev_2.5_v66.bin"
>> -typedef struct NeXTRTC {
>> +
>> +#define TYPE_NEXT_RTC "next-rtc"
>> +OBJECT_DECLARE_SIMPLE_TYPE(NeXTRTC, NEXT_RTC)
>> +
>> +struct NeXTRTC {
>> +    SysBusDevice parent_obj;
> 
> Since it was not explicitly reset, maybe QDev parent is enough?

Hi Phil,

This is deliberate, since the next-pc device resets a couple of fields directly in 
the NeXTRTC struct in next_pc_reset_hold(), and these are moved to a separate 
next_rtc_reset_hold() in the next patch.

>>       int8_t phase;
>>       uint8_t ram[32];
>>       uint8_t command;
>> @@ -50,7 +56,7 @@ typedef struct NeXTRTC {
>>       uint8_t status;
>>       uint8_t control;
>>       uint8_t retval;
>> -} NeXTRTC;
>> +};


ATB,

Mark.


