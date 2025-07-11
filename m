Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90572C83F1A
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 20:22:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaKFZ-0008ST-Gr; Fri, 11 Jul 2025 16:21:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1uaKA2-0005cY-Qk
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 16:15:59 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1uaKA1-0004xc-41
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 16:15:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:To:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID;
 bh=nzyUAJFFD019EpgHdpFYAlXl5dfE/9QZCkfexTr76S0=; b=Kud59mUi2C7MIfYxbHNe3AtS77
 Pwo+CaPSfidSzL65RC9bTonZmf1g1ACMhM5VPi5oLp0c/ftEBVSgTSECGJtVr/HqneKIMFybxVfZv
 Qx+X7+SuzR5a6TO3GNXksCMk70ZtbtKExIjxl5sUTrqXoZ2eVxnvRG0s0vl/CjzPuy/7LcolgsXTq
 CQI/XCKGoGOPRbTAiFB1hBJm1GDlsabt5QjLPhX8QLSvcC3FGpMFU0DRBUCs+4xlH6DYKJws2wTXf
 PAmu/24qr2XETQToJS89nqFcZrKIZo76mrcIkcjG+4fsur6pEJMVfNSPadgw19Emxb9tBZzYcdiu+
 jycPuBQiQhJCoNjaBFp3cK2OGobWeRq14rlAXUdh+r1sjluQDaZXpUblUvERjgNXyZDh6PRVEQV2g
 hQVzOSlyhexMQTkMR4a7HYSpZZSR6PlTaw/BMvNGfQxL6EigaMNWuk8yCmUqBcU/oZvRjXhI49bqM
 qo2gf5fVdZfA4nVndcXMLo5d5GBqxzoKnK/S1ClBvW5DBwuYpNK7qr2fMVYKDNW+icfUSJMCgbptf
 aVTWWOq3fOMQAYL9RpW7twAQo7KX4A7t9i3Mt6XeSNxrOtx8o1+PaEl16qyM7CQiHN26buwD1jiEB
 GLupZjfEQLoJNJRrWQ0Ok+EtsIKzx+8gHMg8NR2q0=;
Received: from [2a02:8012:2f01:0:d1ff:478a:c096:2d0c]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1uaK8J-000BUb-T3; Fri, 11 Jul 2025 21:14:12 +0100
Message-ID: <39a12d97-2b7d-4ef9-9fc4-89bdc293fb3e@ilande.co.uk>
Date: Fri, 11 Jul 2025 21:15:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 pbonzini@redhat.com, fam@euphon.net, qemu-devel@nongnu.org
References: <20250618061249.743897-1-mark.cave-ayland@ilande.co.uk>
 <20250618061249.743897-2-mark.cave-ayland@ilande.co.uk>
 <068ed887-f571-46e8-929a-9dc450624ee1@linaro.org>
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
In-Reply-To: <068ed887-f571-46e8-929a-9dc450624ee1@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:2f01:0:d1ff:478a:c096:2d0c
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH v2 1/7] esp.c: only raise IRQ in esp_transfer_data() for
 CMD_SEL, CMD_SELATN and CMD_TI commands
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

On 09/07/2025 12:09, Philippe Mathieu-Daudé wrote:

> On 18/6/25 08:12, Mark Cave-Ayland wrote:
>> Clarify the logic in esp_transfer_data() to ensure that the deferred interrupt code
>> can only be triggered for CMD_SEL, CMD_SELATN and CMD_TI commands. This should already
>> be the case, but make it explicit to ensure the logic isn't triggered unexpectedly.
>>
>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>> ---
>>   hw/scsi/esp.c | 5 +++--
>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
>> index f24991fd16..9181c8810f 100644
>> --- a/hw/scsi/esp.c
>> +++ b/hw/scsi/esp.c
>> @@ -1012,6 +1012,7 @@ void esp_transfer_data(SCSIRequest *req, uint32_t len)
>>                */
>>                s->rregs[ESP_RINTR] |= INTR_BS | INTR_FC;
>>                s->rregs[ESP_RSEQ] = SEQ_CD;
>> +             esp_raise_irq(s);
>>                break;
>>           case CMD_SELATNS | CMD_DMA:
>> @@ -1022,6 +1023,7 @@ void esp_transfer_data(SCSIRequest *req, uint32_t len)
>>                */
>>                s->rregs[ESP_RINTR] |= INTR_BS;
>>                s->rregs[ESP_RSEQ] = SEQ_MO;
>> +             esp_raise_irq(s);
>>                break;
>>           case CMD_TI | CMD_DMA:
>> @@ -1032,10 +1034,9 @@ void esp_transfer_data(SCSIRequest *req, uint32_t len)
>>                */
>>               s->rregs[ESP_CMD] = 0;
>>               s->rregs[ESP_RINTR] |= INTR_BS;
>> +            esp_raise_irq(s);
>>               break;
> 
> Should we log unexpected CMDs? Regardless,

All of the valid information transfer commands are included in the switch() statement 
above, and once patch 7 is applied any command issued in the wrong mode will generate 
an interrupt. So I think we're good.

> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Thanks!

>>           }
>> -
>> -        esp_raise_irq(s);
>>       }
>>       /*


ATB,

Mark.


