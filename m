Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2F6BC54E58
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 21:09:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkVq4-0008EJ-0X; Wed, 13 Mar 2024 17:08:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rkVq2-0008Dw-Kt
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 17:08:38 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rkVq1-0003F2-7K
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 17:08:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:To:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Y5T+B0LDftCCFMBLHVxgwXBqVKlSC3GGk4osgUE9qk0=; b=QYcQ5RGx9XB45bV/rLT9QAgT+6
 HnnqiMjaGPrJ7OgCkhzEtZKsWo8J6/ETv6stpCww/xL3PZsR3K/gYljkD+GCGs2KyeB0XTxrakO28
 GbMZbvLjXVhFhcEwAm6cXIGDp7+EOhCC135gdjNhbbfxl3UzuG4dpn7NorPnozqz2VEP4MFVdvQEJ
 wDYblylyNMca7UCSpxKiOHuSiUStQLHZlWfZ695QnjLb55SwJpvIBaQWGnYq3ZNt/UQpfa62Sb8Aq
 NVbFkWgKiLuxstZaXv7F96nb7fHzpZ2p+mppHEu3dQQIDI1vskN6x+ypgQmOheS10nh1gNqfyS6cJ
 FB5NRSl+H2QuRaSl/NXtTY2Q/ySUXyxf+2+uN/6U+fgw/q8UYiT6NOcneLVUAuZ9UXqGkY8Wljhy+
 JZAr4baDv059bJM4jwQtfcB9rRc31YFLiMMQ0T3eGVAisqv2eGB01GWvwLkokyU1Z6i2xu13SaA4C
 2yRqJiHMxhC2lcpwEIoevh9YkqY4knqcwjvBhP9mftJENemVH7ARNeglZvtQ9HQ2e88T+BwGYZ9O9
 TudTxlNtFNIJV6EzV3+fjm/OeAChF2q/XlmUsQb5+aOrU5ky5Nr3EbD6NPkah8aTTcpOkvjQpCONA
 VcOCvaiPzaHtwWJ/wJk/q64gNjeAV4nYsfAMOQE/U=;
Received: from [2a00:23c4:8bb3:1000:723d:e490:d7:f9b]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rkVp2-00063h-Iu; Wed, 13 Mar 2024 21:07:40 +0000
Message-ID: <bcd010a7-c09c-483c-9ebb-0e75be578545@ilande.co.uk>
Date: Wed, 13 Mar 2024 21:08:20 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 pbonzini@redhat.com, fam@euphon.net, laurent@vivier.eu, qemu-devel@nongnu.org
References: <20240313085810.2655062-1-mark.cave-ayland@ilande.co.uk>
 <20240313085810.2655062-2-mark.cave-ayland@ilande.co.uk>
 <c0a5a1cc-a6bb-4856-a708-d19195aacb9f@linaro.org>
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
In-Reply-To: <c0a5a1cc-a6bb-4856-a708-d19195aacb9f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb3:1000:723d:e490:d7:f9b
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH v2 01/16] esp.c: replace cmdfifo use of esp_fifo_pop_buf()
 in do_command_phase()
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

On 13/03/2024 11:03, Philippe Mathieu-Daudé wrote:

> On 13/3/24 09:57, Mark Cave-Ayland wrote:
>> The aim is to restrict the esp_fifo_*() functions so that they only operate on
>> the hardware FIFO. When reading from cmdfifo in do_command_phase() use the
>> underlying Fifo8 functions directly.
>>
>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>> ---
>>   hw/scsi/esp.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
>> index 590ff99744..f8230c74b3 100644
>> --- a/hw/scsi/esp.c
>> +++ b/hw/scsi/esp.c
>> @@ -265,7 +265,7 @@ static void esp_do_nodma(ESPState *s);
>>   static void do_command_phase(ESPState *s)
>>   {
>> -    uint32_t cmdlen;
>> +    uint32_t cmdlen, n;
>>       int32_t datalen;
>>       SCSIDevice *current_lun;
>>       uint8_t buf[ESP_CMDFIFO_SZ];
>> @@ -275,7 +275,7 @@ static void do_command_phase(ESPState *s)
>>       if (!cmdlen || !s->current_dev) {
>>           return;
>>       }
>> -    esp_fifo_pop_buf(&s->cmdfifo, buf, cmdlen);
>> +    memcpy(buf, fifo8_pop_buf(&s->cmdfifo, cmdlen, &n), cmdlen);
> 
> 'n' is unused, use NULL?

I was sure I had tried that before and it had failed, but I see that you made it work 
with NULL in commit cd04033dbe ("util/fifo8: Allow fifo8_pop_buf() to not populate 
popped length") - thanks!

I'll make the change for v3, but I'll wait a couple of days first to see if there are 
any further comments, in particular R-B tags for patches 10 and 11.

>>       current_lun = scsi_device_find(&s->bus, 0, s->current_dev->id, s->lun);
>>       if (!current_lun) {


ATB,

Mark.


