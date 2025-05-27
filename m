Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B825EC54ED1
	for <qemu-devel@archiver.kernel.org>; Tue, 27 May 2025 19:41:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uK0AP-0003qw-6v; Tue, 27 May 2025 15:40:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1uK0AI-0003qY-B6
 for qemu-devel@nongnu.org; Tue, 27 May 2025 15:40:48 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1uK0AC-0005uk-N9
 for qemu-devel@nongnu.org; Tue, 27 May 2025 15:40:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID;
 bh=T6LyI4TzEvSkrgJBEh5vI8/4Kw/PzlaKOSSmSvlQxOE=; b=T+y7swfxuT0dofGKDbPHxgZBjB
 3ZUxm57qd7crXVG67QbIeah6nzhOl4ly8xKwAT5zbrMJIyD2DnSE0jLR2kfPRDVc0+b5X8De/gDDm
 jWGd5PsyD80B1CuMJEMjl91BESqRd5jwytC+OZG4myG1w9Rde9kMJPpMZeNcemjBfDS0Gq0IgAi0N
 XgKFW2C4NpNE7p87rcAKg0oXRMZD1MtAZegkluRL4LSfFqY4E351XnI2e1LCYEaWrN9swSu17Illn
 IewHOG7TGl15CAxVvIg063L9hHedKnbsN8eiueOo3m7hVFdGjBIfk41KNcyJ2HGdmfd/Eld4Kf+/x
 7XTajC7OvtQZ6qjJ2oXzVFILMyYmAj7VSgzdF/7qIPrSIYEUasnHGChpvzgv+jrghdT7wCyzoWLwD
 3Umq5MxLCtMUpsFKZP5FZg4xtmBcRWLtqjyhymZHYPJhbNnbkfJx2XeK/R5uz6Scu2M+NVHYcmBEZ
 aKnED+BGH/DdUToUTl0nB2V8Frn/LwVZwL8VmkapPOyC77K+LzqHn7U/mhYKLsRhpA2a+283KWIjB
 F1yhq/0BydDtUUDhpysIvHz0MD0U1ghIxNFsnpuJbehuXtstYk7CuX8E/97FQJRTYY1K2tUD5mDzX
 yS043hkxMQCFH4JW5D0WMu0ipCxbL4DnDYPIR4eTk=;
Received: from [2a02:8012:2f01:0:7607:4cc5:5176:1da8]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1uK08o-00027g-7U; Tue, 27 May 2025 20:39:14 +0100
Message-ID: <6dd914b1-2a2f-4a4c-bd2b-54e8302d1a75@ilande.co.uk>
Date: Tue, 27 May 2025 20:40:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zheng Huang <hz1624917200@gmail.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
References: <37889706-8576-476c-8fea-c1a3a2858b1e@gmail.com>
 <684885a4-0022-4de8-98aa-07c9fe4a11c7@linaro.org>
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
In-Reply-To: <684885a4-0022-4de8-98aa-07c9fe4a11c7@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:2f01:0:7607:4cc5:5176:1da8
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH] hw/scsi/esp: fix assertion error in fifo8_push
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

On 27/05/2025 14:59, Philippe Mathieu-Daudé wrote:

> Hi,
> 
> Cc'ing maintainers:
> 
> $ ./scripts/get_maintainer.pl -f hw/scsi/esp.c
> Paolo Bonzini <pbonzini@redhat.com> (supporter:SCSI)
> Fam Zheng <fam@euphon.net> (reviewer:SCSI)
> $ ./scripts/get_maintainer.pl -f migration/
> Peter Xu <peterx@redhat.com> (maintainer:Migration)
> Fabiano Rosas <farosas@suse.de> (maintainer:Migration)
> 
> On 27/5/25 15:12, Zheng Huang wrote:
>> This patch add validation checks on FIFO structures in esp_post_load() to
>> avoid assertion error `assert(fifo->num < fifo->capacity);` in fifo8_push(),
>> which can occur if the inbound migration stream is malformed. By performing
>> these checks during post-load, we can catch and handle such issues earlier,
>> avoiding crashes due to corrupted state.
> 
> How can that happen? Can you share a reproducer?
> 
>>
>> Signed-off-by: Zheng Huang <hz1624917200@gmail.com>
>> ---
>>   hw/scsi/esp.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
>> index ac841dc32e..ba77017087 100644
>> --- a/hw/scsi/esp.c
>> +++ b/hw/scsi/esp.c
>> @@ -1350,11 +1350,17 @@ static int esp_post_load(void *opaque, int version_id)
>>           /* Migrate ti_buf to fifo */
>>           len = s->mig_ti_wptr - s->mig_ti_rptr;
>>           for (i = 0; i < len; i++) {
>> +            if (&s->fifo.num >= &s->fifo.capacity) {
>> +                return -1;
>> +            }
>>               fifo8_push(&s->fifo, s->mig_ti_buf[i]);
>>           }
>>           /* Migrate cmdbuf to cmdfifo */
>>           for (i = 0; i < s->mig_cmdlen; i++) {
>> +            if (&s->cmdfifo.num >= &s->cmdfifo.capacity) {
>> +                return -1;
>> +            }
>>               fifo8_push(&s->cmdfifo, s->mig_cmdbuf[i]);
>>           }
>>       }

This seems odd: this logic in esp_post_load() is for converting from pre-Fifo8 code 
to the current Fifo8 code, so why wouldn't we want to assert() for the case when the 
migration stream is intentionally malformed? Is there a case whereby the old code 
could generate an invalid migration stream like this?


ATB,

Mark.


