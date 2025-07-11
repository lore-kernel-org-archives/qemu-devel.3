Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92311C83F1B
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 20:32:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaKPJ-0004zb-RZ; Fri, 11 Jul 2025 16:31:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1uaKDM-0007Tr-9i
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 16:19:24 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1uaKDI-0005pC-HQ
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 16:19:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:To:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID;
 bh=IHm5W+Kzfrrq6bQFYMWw8pNUYOTbF+Z7NAm/BkVUVkU=; b=Y7+grmHf/ZZKZMEoQ7qIsY+4jC
 ow3btHWDCyxSLHhIhEmk+/Ehb/5qVutbSyQtUzrzVIauPgsupaU8ynYsS+xnYw9/I79TMXMn18pIl
 XkH3LN14JO53vvRXbOXqeYWUuMpUD5iSHUlKVmi8WMsrGYkrdy3ldtUaY2L1mwmgYlET1WZ2TdfyE
 ODYiyOUf4iMK3FPyElkyls1QxB38TbHRZIqwFZUlQfp/MAyq0L25EhweKAu66Ew34JMDlPI2vKm18
 bNBRrzFB/aqTOyQ0GG+lQJDnF0Grav3v2HCY1PUOEYYF++SD1Lm9XczE4vQp/i6saSx9WVzBAnAMa
 pCIXaHvv36pDIzZZgz2QJlQgcnW1lf25Ei2dix62u+rFGD3jlqkHF6UD3wIjcT8nqny0j1EGhNUvu
 0t0Jlje4udurF2gXYSBs5ZSd4A8/AwPNXZ17OjCJs67BWBLni1itXTt4cPydp6ZJRM99glhYMdut4
 WWNNd6V4I0v6odFw69t7SKUli+LALzRr/3qMJxgZfm4mivRFwYVhAMhjUCCkqwvSQDiHk4q6Lc+fi
 TxeARXEccHhBLQ2bguFH7i7mKWU4q2x3KEh8fr8MR1b0sccNxH85uhqPyYZV0xQXuDlWxmGOiQrnB
 JseAn4mvxzxPd8DpPqsIY547kCxcaq5XgaUNTpGzY=;
Received: from [2a02:8012:2f01:0:d1ff:478a:c096:2d0c]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1uaKBa-000BZS-Q2; Fri, 11 Jul 2025 21:17:38 +0100
Message-ID: <66e0e799-d84d-470e-bf5f-e03f85cb3463@ilande.co.uk>
Date: Fri, 11 Jul 2025 21:19:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 pbonzini@redhat.com, fam@euphon.net, qemu-devel@nongnu.org
References: <20250618061249.743897-1-mark.cave-ayland@ilande.co.uk>
 <20250618061249.743897-6-mark.cave-ayland@ilande.co.uk>
 <a9d23dc1-60b8-4ad0-a666-ad3770051ec3@linaro.org>
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
In-Reply-To: <a9d23dc1-60b8-4ad0-a666-ad3770051ec3@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:2f01:0:d1ff:478a:c096:2d0c
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH v2 5/7] esp.c: only call dma_memory_write function if
 transfer length is non-zero
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

On 09/07/2025 12:14, Philippe Mathieu-Daudé wrote:

> On 18/6/25 08:12, Mark Cave-Ayland wrote:
>> In the cases where mixed DMA/non-DMA transfers are used or no data is
>> available, it is possible to for the calculated transfer length to be
>> zero. Only call the dma_memory_write function where the transfer length
>> is non-zero to avoid invoking the DMA engine for a zero length transfer
>> which can have side-effects (along with generating additional tracing
>> noise).
>>
>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>> ---
>>   hw/scsi/esp.c | 6 +++++-
>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
>> index ec9fcbeddf..1c7bad8fc0 100644
>> --- a/hw/scsi/esp.c
>> +++ b/hw/scsi/esp.c
>> @@ -631,7 +631,9 @@ static void esp_do_dma(ESPState *s)
>>           switch (s->rregs[ESP_CMD]) {
>>           case CMD_TI | CMD_DMA:
>>               if (s->dma_memory_write) {
>> -                s->dma_memory_write(s->dma_opaque, s->async_buf, len);
>> +                if (len) {
>> +                    s->dma_memory_write(s->dma_opaque, s->async_buf, len);
>> +                }
>>               } else {
>>                   /* Copy device data to FIFO */
>>                   len = MIN(len, fifo8_num_free(&s->fifo));
>> @@ -681,6 +683,7 @@ static void esp_do_dma(ESPState *s)
> 
> As future cleanup, indent could be simplified using 'if (!len) break;'.

I remember when I did the large rewrite of esp.c, I found the logic easier to follow 
with the indentation that way. But of course that is something that could always be 
revisited later if required.

> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
>>                   buf[0] = s->status;
>>                   if (s->dma_memory_write) {
>> +                    /* Length already non-zero */
>>                       s->dma_memory_write(s->dma_opaque, buf, len);
>>                   } else {
>>                       esp_fifo_push_buf(s, buf, len);
>> @@ -715,6 +718,7 @@ static void esp_do_dma(ESPState *s)
>>                   buf[0] = 0;
>>                   if (s->dma_memory_write) {
>> +                    /* Length already non-zero */
>>                       s->dma_memory_write(s->dma_opaque, buf, len);
>>                   } else {
>>                       esp_fifo_push_buf(s, buf, len);


ATB,

Mark.


