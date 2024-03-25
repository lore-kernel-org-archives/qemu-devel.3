Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0440C54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Mar 2024 12:57:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rojt6-0000lo-3G; Mon, 25 Mar 2024 08:57:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rojt4-0000lI-Hw
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 08:57:14 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rojt2-00015B-1P
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 08:57:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:To:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=6vUWl5jHLRxIYOzySN2gOxGp5jGhu3yhZACyWaxVYTg=; b=bB5kIXF4r+pY/E1BE4k/dkNsY6
 tRDZGCVfrX5P+7PBLttRzTfKBxYcLw1CyYxxr9dJTiJYcnhLyi4puZcLqoVi6WW0V5/VkvHmo8Ri+
 YwGdyyY+kv+UOy31GuX9HvcjF+bSSUI31soXP4wfPzHUp/9331k1/eTBCLFXMqS92FbZMWdYEfAcx
 7SOqPVEC5I/SAGo6namjoCtcsh+3YDcfrtb23cwVOJXrN1h2ylL3m9yLrCr7c3l8TNeFboyjBMY0A
 t6j0yO5Q9hFlHkExygdloJrHWuJOvR6z13UCBzQgwugqqt0+rZSURHDUGqCQelsOxq/Bg/Fa2c3IS
 DhKzIUdPjeFw5pX8HEHI9dk/M91aHBPDm3kH81KjOshsCG5ngN3qr46TBRrehFgidBQz8l4hcItv7
 N+oEeMsjbsBMhm8b450E49PNgVhn+aEh8KxIGjCBK88dlce28q1M63G392mHiKdksA9Zs6coLCqQD
 tBJYm5NaU9oC723hOAbo9/pBC3XVg1BymJ/eGe3v9lQ/MrOkkamIIiG7V39LOyNGSbk0Z15rbvZPF
 JU8EJJt4277z+jV2BZto6xB9TOv7Om22lrAbH2Xe2SEt70bTOGCPIg8TRgdVCtrD7L9G74KiVtmPW
 b6IUzKJd+QCE9IR7NrzyOmqdKgAOCyx54z+aqt2ko=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rojs1-0008Sx-Bo; Mon, 25 Mar 2024 12:56:13 +0000
Message-ID: <9f6064d0-cb77-47eb-a4c0-25eaf0d184f5@ilande.co.uk>
Date: Mon, 25 Mar 2024 12:57:00 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 pbonzini@redhat.com, fam@euphon.net, laurent@vivier.eu, qemu-devel@nongnu.org
References: <20240324191707.623175-1-mark.cave-ayland@ilande.co.uk>
 <20240324191707.623175-11-mark.cave-ayland@ilande.co.uk>
 <5f8511b6-225d-4197-8785-7fb69a1b1c13@linaro.org>
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
In-Reply-To: <5f8511b6-225d-4197-8785-7fb69a1b1c13@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH v3 10/17] esp.c: don't assert() if FIFO empty when
 executing non-DMA SELATNS
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

On 25/03/2024 10:49, Philippe Mathieu-Daudé wrote:

> On 24/3/24 20:16, Mark Cave-Ayland wrote:
>> The current logic assumes that at least 1 byte is present in the FIFO when
>> executing a non-DMA SELATNS command, but this may not be the case if the
>> guest executes an invalid ESP command sequence.
> 
> What is real hardware behavior here?

I don't know for sure, but my guess is that if you ask to transfer a single byte from 
the FIFO to the SCSI bus and the FIFO is empty, you'll either end up with all zeros 
or a NOOP.

>> Reported-by: Chuhong Yuan <hslester96@gmail.com>
>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>> ---
>>   hw/scsi/esp.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
>> index 1aac8f5564..f3aa5364cf 100644
>> --- a/hw/scsi/esp.c
>> +++ b/hw/scsi/esp.c
>> @@ -762,7 +762,8 @@ static void esp_do_nodma(ESPState *s)
>>           case CMD_SELATNS:
> 
> Alternatively logging the guest abuse:
> 
>                len = fifo8_num_used(&s->fifo);
>                if (len < 1) {
>                    qemu_log_mask(LOG_GUEST_ERROR, ...
>                    break;
>                }
> 
>>               /* Copy one byte from FIFO into cmdfifo */
>> -            len = esp_fifo_pop_buf(s, buf, 1);
>> +            len = esp_fifo_pop_buf(s, buf,
>> +                                   MIN(fifo8_num_used(&s->fifo), 1));

This is similar to your previous comment in that it's an artifact of the 
implementation: when popping data using esp_fifo_pop_buf() I've always allowed the 
internal Fifo8 assert() if too much data is requested. This was a deliberate design 
choice that allowed me to catch several memory issues when working on the ESP 
emulation: it just so happened I missed a case in the last big ESP rework that was 
found by fuzzing.

It's also worth noting that it's a Fifo8 internal protective assert() that fires here 
which is different from the previous case whereby an overflow of the internal Fifo8 
data buffer actually did occur.

>>               len = MIN(fifo8_num_free(&s->cmdfifo), len);
>>               fifo8_push_all(&s->cmdfifo, buf, len);


ATB,

Mark.


