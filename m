Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC131C54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Mar 2024 12:41:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rojdy-00088y-7x; Mon, 25 Mar 2024 08:41:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rojdw-00086f-SM
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 08:41:36 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rojdv-0006cY-8q
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 08:41:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:To:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=gOKa4y72xcwoBs0sNlWOnYmRNegrXWirYGsY/t6z2DM=; b=wXkHckPV7tKTA/lipWLDmzfXw/
 SGW6Vxa/SoGunRsTUZPnfj/3g4UehGvyYAwxupXulJut1C4bCt6M905BWgoFbqla7gq3/TNPSCcCM
 JkAevMgKZJt+RnGYPqTfYVHKXZCXjyHKJWqtz7NZVm9aqV1wwebDdTWtrpez7Ifwf0eoQscFZg585
 XaARHpMtxagLIdA6cC8FvKabW+Nmi3G+34olqMpIQXIJ19RZsvBh9PJqNlsDp0ZposDddWW05MQoI
 VxJCrLs/9KxRy7/+RZ8lgyBRaeDzEHiERh/4E9r7AemLu0P3law8nHluROfhutbBI6+wLGFDa+ts7
 QXySCCFfCXBDZ8/ZIarwL9bcvF4PUqie1ErEaqfSEqcU3o2MlVivFfVzp09dbipTRqzb+bPUUFVq5
 VhNYMiMpdM2yaZE3zWUEeFHRIPu4VyVoVU+f8MnAZebW0vqZQcCY1mtK+GYWiwnhVI92iX85Vw4EF
 mRWU7lYbDNo9ewGuVWwVNolW0SVVRMG/uR+7+3sjC7pX5ffcACMwCG3MMMC0hbK5mSqf/UALqdv5V
 fddYC+7OWpnHH2pepeXebNz7siHUGSBoXaPTp1MCc1JEk0wqKOc+HJo67yqct524LKlU2ryxJYP3U
 2/d82Ml1ZD3czlRW/hWq2mWcrw5xh/IMY0YLtDuck=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rojcu-0008KA-QA; Mon, 25 Mar 2024 12:40:36 +0000
Message-ID: <2fe371b5-07a3-4322-8543-76b15244dbe1@ilande.co.uk>
Date: Mon, 25 Mar 2024 12:41:18 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 pbonzini@redhat.com, fam@euphon.net, laurent@vivier.eu, qemu-devel@nongnu.org
References: <20240324191707.623175-1-mark.cave-ayland@ilande.co.uk>
 <20240324191707.623175-13-mark.cave-ayland@ilande.co.uk>
 <aaaad221-9a88-4298-ac87-49d8a827ce9f@linaro.org>
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
In-Reply-To: <aaaad221-9a88-4298-ac87-49d8a827ce9f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH v3 12/17] esp.c: prevent cmdfifo overflow in
 esp_cdb_ready()
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

On 25/03/2024 10:26, Philippe Mathieu-Daudé wrote:

> On 24/3/24 20:17, Mark Cave-Ayland wrote:
>> During normal use the cmdfifo will never wrap internally and cmdfifo_cdb_offset
>> will always indicate the start of the SCSI CDB. However it is possible that a
>> malicious guest could issue an invalid ESP command sequence such that cmdfifo
>> wraps internally and cmdfifo_cdb_offset could point beyond the end of the FIFO
>> data buffer.
>>
>> Add an extra check to fifo8_peek_buf() to ensure that if the cmdfifo has wrapped
>> internally then esp_cdb_ready() will exit rather than allow scsi_cdb_length() to
>> access data outside the cmdfifo data buffer.
>>
>> Reported-by: Chuhong Yuan <hslester96@gmail.com>
>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>> ---
>>   hw/scsi/esp.c | 12 +++++++++++-
>>   1 file changed, 11 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
>> index f47abc36d6..d8db33b921 100644
>> --- a/hw/scsi/esp.c
>> +++ b/hw/scsi/esp.c
>> @@ -429,13 +429,23 @@ static bool esp_cdb_ready(ESPState *s)
>>   {
>>       int len = fifo8_num_used(&s->cmdfifo) - s->cmdfifo_cdb_offset;
>>       const uint8_t *pbuf;
>> +    uint32_t n;
>>       int cdblen;
>>       if (len <= 0) {
>>           return false;
>>       }
>> -    pbuf = fifo8_peek_buf(&s->cmdfifo, len, NULL);
>> +    pbuf = fifo8_peek_buf(&s->cmdfifo, len, &n);
>> +    if (n < len) {
>> +        /*
>> +         * In normal use the cmdfifo should never wrap, but include this check
>> +         * to prevent a malicious guest from reading past the end of the
>> +         * cmdfifo data buffer below
>> +         */
> 
> Can we qemu_log_mask(LOG_GUEST_ERROR) something here?

I'm not sure that this makes sense here? The cmdfifo wrapping is internal artifact of 
the Fifo8 implementation rather than being directly affected by writes to the ESP 
hardware FIFO (i.e. this is not the same as the ESP hardware FIFO overflow).

>> +        return false;
>> +    }
>> +
>>       cdblen = scsi_cdb_length((uint8_t *)&pbuf[s->cmdfifo_cdb_offset]);
>>       return cdblen < 0 ? false : (len >= cdblen);
>  


ATB,

Mark.


