Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D9E1CD1284
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Apr 2024 11:35:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrcPv-0007qD-LL; Tue, 02 Apr 2024 07:35:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rrcPt-0007mW-KW
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 07:35:01 -0400
Received: from mail-lj1-x236.google.com ([2a00:1450:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rrcPr-0006yL-K2
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 07:35:01 -0400
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2d4360ab3daso65371511fa.3
 for <qemu-devel@nongnu.org>; Tue, 02 Apr 2024 04:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712057697; x=1712662497; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dRDMHjHHTdjzgClWbihqpXhkVvoi9wkovv+XHUglS84=;
 b=vORGRsHnNYiAkpZo4LFIVho/KbbMw2OWhvoMKSAou0p5o2fy7fQPDGA86WV8lDzKTx
 YIGgEISnFpPNRkzHbPRGCjsq+e+iTsWt1B4A9KQcCpq7U7tktqIc+3W0wvECvGf69Qbn
 sKRHQmdcAh0xCiah0eZiu15wESoPGlIxSrNl2TSYLVKCaV6pOYdn7dbeNDR9PaVuAX08
 mjdm+mYQs7c5bVVG6Cmhai/X3vkSKVHeC+FCbGdCodrtvlLv6sNv02yT8G5qNM0snaBZ
 8I7z/7nSTO06nqa4wrld6sLT9OVLP+0bdlIZI4JRfltnNLPUI3LoCKVHLtpEJCD+rVSp
 8z+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712057697; x=1712662497;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dRDMHjHHTdjzgClWbihqpXhkVvoi9wkovv+XHUglS84=;
 b=Heehj0IoO5zHUhfUwB5dB47pc/WwRcAr/yUju3IN871sp67gVi8M4kw5zfrh7RIwrN
 kKuUpFmk9vQvMg61/vntWcz1Vp4JK3daL5+l4R7XpP7Qv3CdjIqZWDsU7zWNlWiiKeVY
 lYkhG3z5G8JJCxS2yIci+Gc7uwIGOeDKYqaXmxt7owrmIuWPx4LStoW1exwdDe0yolNp
 uSfpUo705Uamw6YW384J/AVdxqj7Y/3LS9RSwn86uNR7rUqfdvoOYNJH8B1mYsQciCyg
 5Tpe0FQMiAO++cb+4iR8vK9/wf0kocTJjtIC+mZung2Tqrq5Z/6JDujmnCvoj79KHlje
 P1zg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV3ModWODqEP6/FgZKazZIco/6RV6l3AKVNIztkOXRJXFa6cFm5s3laAxiSrDRC3AIJ4+VG7aEKTm6gEn6PMV6/ai1BpUs=
X-Gm-Message-State: AOJu0YzTI48GpWy6A9S9He9tWyS6oG6DGeEvuocVXrAtex2dXo+yHu6Z
 eFTLuDN0KBKOW7C/FkBW1eBu+54gTNQQJBm3PiDn2EJt+KJ1wsCCi+aJRVXNTPPqNUv5U6esnLD
 ZFmM=
X-Google-Smtp-Source: AGHT+IE1qVDdxsan8u0z9OTj+Gz08QAGTT4DAw3CLfCIlWPrb1PhkiA0Dl5L96Kzrkvyj4YtADJwyA==
X-Received: by 2002:a2e:2a03:0:b0:2d8:2710:f7dc with SMTP id
 q3-20020a2e2a03000000b002d82710f7dcmr1812948ljq.17.1712057696992; 
 Tue, 02 Apr 2024 04:34:56 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.202.91])
 by smtp.gmail.com with ESMTPSA id
 n38-20020a05600c3ba600b00415509b11c3sm13826049wms.22.2024.04.02.04.34.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Apr 2024 04:34:56 -0700 (PDT)
Message-ID: <df7525fc-1e0b-4e0a-86f0-c5cf8e2639b6@linaro.org>
Date: Tue, 2 Apr 2024 13:34:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/17] esp.c: don't assert() if FIFO empty when
 executing non-DMA SELATNS
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, pbonzini@redhat.com,
 fam@euphon.net, laurent@vivier.eu, qemu-devel@nongnu.org
References: <20240324191707.623175-1-mark.cave-ayland@ilande.co.uk>
 <20240324191707.623175-11-mark.cave-ayland@ilande.co.uk>
 <5f8511b6-225d-4197-8785-7fb69a1b1c13@linaro.org>
 <9f6064d0-cb77-47eb-a4c0-25eaf0d184f5@ilande.co.uk>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <9f6064d0-cb77-47eb-a4c0-25eaf0d184f5@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::236;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x236.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 25/3/24 13:57, Mark Cave-Ayland wrote:
> On 25/03/2024 10:49, Philippe Mathieu-Daudé wrote:
> 
>> On 24/3/24 20:16, Mark Cave-Ayland wrote:
>>> The current logic assumes that at least 1 byte is present in the FIFO 
>>> when
>>> executing a non-DMA SELATNS command, but this may not be the case if the
>>> guest executes an invalid ESP command sequence.
>>
>> What is real hardware behavior here?
> 
> I don't know for sure, but my guess is that if you ask to transfer a 
> single byte from the FIFO to the SCSI bus and the FIFO is empty, you'll 
> either end up with all zeros or a NOOP.
> 
>>> Reported-by: Chuhong Yuan <hslester96@gmail.com>
>>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>>> ---
>>>   hw/scsi/esp.c | 3 ++-
>>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
>>> index 1aac8f5564..f3aa5364cf 100644
>>> --- a/hw/scsi/esp.c
>>> +++ b/hw/scsi/esp.c
>>> @@ -762,7 +762,8 @@ static void esp_do_nodma(ESPState *s)
>>>           case CMD_SELATNS:
>>
>> Alternatively logging the guest abuse:
>>
>>                len = fifo8_num_used(&s->fifo);
>>                if (len < 1) {
>>                    qemu_log_mask(LOG_GUEST_ERROR, ...
>>                    break;
>>                }
>>
>>>               /* Copy one byte from FIFO into cmdfifo */
>>> -            len = esp_fifo_pop_buf(s, buf, 1);
>>> +            len = esp_fifo_pop_buf(s, buf,
>>> +                                   MIN(fifo8_num_used(&s->fifo), 1));
> 
> This is similar to your previous comment in that it's an artifact of the 
> implementation: when popping data using esp_fifo_pop_buf() I've always 
> allowed the internal Fifo8 assert() if too much data is requested. This 
> was a deliberate design choice that allowed me to catch several memory 
> issues when working on the ESP emulation: it just so happened I missed a 
> case in the last big ESP rework that was found by fuzzing.
> 
> It's also worth noting that it's a Fifo8 internal protective assert() 
> that fires here which is different from the previous case whereby an 
> overflow of the internal Fifo8 data buffer actually did occur.

Fine then.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


