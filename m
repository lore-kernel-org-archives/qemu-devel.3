Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 988C6C47DDF
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Feb 2024 11:27:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVVDc-0002Fz-T8; Thu, 01 Feb 2024 06:26:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rVVCj-0002Af-N5
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 06:26:02 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rVVCf-0006Uw-N6
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 06:26:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=BeRfOlIw54xAPE/2khQQBp9/Crb/L3Pa/Gc34x3XJbs=; b=TPjI+NRk2cIhAO/AKINlJEOeWG
 yxv/0AX6A55+P0jR84gnCxhGZdgdl+91nySfZs0lHnqESoIsPmtiykwy47nf8f8cYVo95z3hJbpVE
 oc13dVZB3oS3cnEvviiafx8lGjelMh+9CLVWxVcpI5QEL9IcRcQA9LyRqqPDBd+I1J4yJ5Fg6aqGJ
 DJSIpFObTCH61s85W7EsA4bfCfLdZnyonhv1TS1ZSH6kvlZbwnBO5OdEXuBE0LIongYRU+xGh9dTs
 ilF5Q9vjdMf/vOoCwPdTugDgA71eKT96KjZsvKPjYLy2z+MTXz4aJrysLe20EnZv1BeNTcFpxW/j4
 hGue+H7S/jSUyLtU9YkfyWkD+hgW5YOHwd1X8nOu2PbXyfgyfK2NH/3w0AlhQR54uNyQOawU93fR6
 h+CIca/y+1rCXPZZ12n3dIdLrkZPCdAezvAbtKdhxyugW9y6udoQCwDeHS39SMhXk5bpdzUIYNsev
 t/4oJIhts47iLHv6PsM5ZbdQJa4Vd4yZjkwtC4ILLnH/18Kf3ZlS8Sbgq2gvj7Qj7cl1zi9K+GH3Y
 DmrU8DtBxQEFtudSApSyMcBhSCpdlbiFmSDkNv2o6izJ1h6oeHx/GaL5OvVEuy6gN5Xrjwr1Yxz9L
 d2JCj+w5fzdtdDOsUjXw0Z7nkMV4xxKouNLaDzb7E=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rVVBn-0004fK-Jl; Thu, 01 Feb 2024 11:25:07 +0000
Message-ID: <c9dfd1d3-c784-456f-ba6e-dc56388fd79e@ilande.co.uk>
Date: Thu, 1 Feb 2024 11:25:34 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: fam@euphon.net, hpoussin@reactos.org, laurent@vivier.eu,
 thuth@redhat.com, qemu-devel@nongnu.org
References: <20240112125420.514425-1-mark.cave-ayland@ilande.co.uk>
 <20240112125420.514425-10-mark.cave-ayland@ilande.co.uk>
 <CABgObfZ3VY84p8A=+3nOnkttQk=64vQAyNk76VRHqzURwHrYww@mail.gmail.com>
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
In-Reply-To: <CABgObfZ3VY84p8A=+3nOnkttQk=64vQAyNk76VRHqzURwHrYww@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH 09/88] esp: update TC check logic in do_dma_pdma_cb() to
 check for TC == 0
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

On 01/02/2024 10:46, Paolo Bonzini wrote:

> On Fri, Jan 12, 2024 at 1:55 PM Mark Cave-Ayland
> <mark.cave-ayland@ilande.co.uk> wrote:
>>
>> Invert the logic so that the end of DMA transfer check becomes one that checks
>> for TC == 0 in the from device path in do_dma_pdma_cb().
>>
>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>> ---
>>   hw/scsi/esp.c | 24 +++++++++++-------------
>>   1 file changed, 11 insertions(+), 13 deletions(-)
>>
>> diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
>> index fecfef7c89..63c828c1b2 100644
>> --- a/hw/scsi/esp.c
>> +++ b/hw/scsi/esp.c
>> @@ -602,21 +602,19 @@ static void do_dma_pdma_cb(ESPState *s)
>>               return;
>>           }
>>
>> -        if (esp_get_tc(s) != 0) {
>> -            /* Copy device data to FIFO */
>> -            len = MIN(s->async_len, esp_get_tc(s));
>> -            len = MIN(len, fifo8_num_free(&s->fifo));
>> -            fifo8_push_all(&s->fifo, s->async_buf, len);
>> -            s->async_buf += len;
>> -            s->async_len -= len;
>> -            s->ti_size -= len;
>> -            esp_set_tc(s, esp_get_tc(s) - len);
>> -            return;
>> +        if (esp_get_tc(s) == 0) {
>> +            esp_lower_drq(s);
>> +            esp_dma_done(s);
>>           }
> 
> I'm only doing a cursory review, but shouldn't there be a return here?
> 
> Paolo

(goes and looks)

Possibly there should, but my guess is that adding the return at that particular 
point in time at the series broke one of my reference images. In particular MacOS is 
notorious for requesting data transfers of X len, and setting the TC either too high 
or too low and let the in-built OS recovery logic handle these cases.

The tricky part is that as per the cover note, making expected changes at an earlier 
point in the series tends to cause things to break. Another thing to bear in mind is 
that one of the main objectives of the series to completely remove all the 
PDMA-specific callbacks including do_dma_pdma_cb(), so you'll see this function 
disappear completely in a later patch.

It probably helps to compare the existing code at 
https://gitlab.com/qemu-project/qemu/-/blob/master/hw/scsi/esp.c against the version 
from this series at 
https://gitlab.com/mcayland/qemu/-/blob/esp-rework-v2/hw/scsi/esp.c to get a feeling 
where the series is going, as in order to keep my reference images bisectable the 
journey from start to finish occurs in a fairly roundabout way.

>> -        /* Partially filled a scsi buffer. Complete immediately.  */
>> -        esp_lower_drq(s);
>> -        esp_dma_done(s);
>> +        /* Copy device data to FIFO */
>> +        len = MIN(s->async_len, esp_get_tc(s));
>> +        len = MIN(len, fifo8_num_free(&s->fifo));
>> +        fifo8_push_all(&s->fifo, s->async_buf, len);
>> +        s->async_buf += len;
>> +        s->async_len -= len;
>> +        s->ti_size -= len;
>> +        esp_set_tc(s, esp_get_tc(s) - len);
>>       }
>>   }
>>
>> --
>> 2.39.2


ATB,

Mark.


