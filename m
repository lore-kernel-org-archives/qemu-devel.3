Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0821CD1284
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Apr 2024 11:36:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrcRQ-0003sO-E5; Tue, 02 Apr 2024 07:36:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rrcRM-0003r6-1a
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 07:36:32 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rrcRE-0008Ne-K6
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 07:36:31 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-343620589easo250457f8f.3
 for <qemu-devel@nongnu.org>; Tue, 02 Apr 2024 04:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712057783; x=1712662583; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2eVMWygq8MoRCj1O4bukg5xnFNlPxmKB8kUJ1kXy9as=;
 b=d4fvToAerVOTjKjIRbvP0Dqrg2IQVwzo6f9V0OeYDuJHslPqIAd07GbtUO6M4yRPUm
 rXmIxtJ1V2X5CN4JUbc5qn8KZLqgBzh3BrPPPW3bYIiQKED3L0t55B885sBd3I7RSW5G
 mEtFP2eEoyn04fou6XLhMwgJtgXhiTTRXFD6F0POYV6yGiVVj6stBS+vEwBMl4JKHqq0
 YazqTt0dL1x7CY5bwaSeoZ/nnWs74An83MmNxtZt6xPVu9GDTBvmGuz6I2TZi/XDQCx1
 cvw3vTiBbwSsxK7yEjwftGnv+iqclSSImf9gFPPZ7TSzzenENsYtXtmYPVCbD7PhqWiG
 MmEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712057783; x=1712662583;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2eVMWygq8MoRCj1O4bukg5xnFNlPxmKB8kUJ1kXy9as=;
 b=Clcq5cD+7tiSpu/1piugpl3kmacAlAQQ2vutDniGWZODEhwGTUrSIZfx0YoO7RrIOq
 b1tfxJ6bmwiqfGkuKV93cdLwH6S+0KMW+UumXOHgNLfaV5AB6l1Fe5fhgCZsnShcIwTw
 Qps4tTPkww9M7AlQ4N5LVzHwDBysO7YazTDOF9bzkrRWASv9y/uUF6ptIecercobD20N
 gRAuhRwn9dxOpxIwkwou9v1jd5391ZwUc5nKc7eU9Iadg9t/ALaY7sdwpLoUGUNinloL
 TxfReOr/BfovKrbCKzMTC/v637ouSf0n4/RZsaGifmizghYYOKojwLwKNYjxG3wUV1tF
 HoFQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWsmooi2qjAWozujBHi3rpGCFLlc65Vi0g/HGbav+P202V/pfWQMSh7FfwZqQbMdIkrHe76vo0G0iCulAXJHPKxP8gjBrI=
X-Gm-Message-State: AOJu0YwJA9l+91phJQjHXqcDklhisD5OuciMnX0N5P3L8jivxMpO/lJ3
 p0pRXOjsttnAFzH26CMgTj7X0iVOFgsQdZ6O+J5rpBb1vbJjzKDUOZMJ1LzNxNZB5dQl8sHsxac
 KGgI=
X-Google-Smtp-Source: AGHT+IEySA8xedcc3Rf/ISM3sWx5kIQuwjLf/MfQq+2fGmg/4JldiWlKDgiKBzD7OiLaDSq8UGjzsA==
X-Received: by 2002:adf:fb06:0:b0:33e:d71b:cef0 with SMTP id
 c6-20020adffb06000000b0033ed71bcef0mr6881579wrr.17.1712057782966; 
 Tue, 02 Apr 2024 04:36:22 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.202.91])
 by smtp.gmail.com with ESMTPSA id
 o18-20020adfca12000000b0033ec81ec4aesm14030978wrh.78.2024.04.02.04.36.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Apr 2024 04:36:22 -0700 (PDT)
Message-ID: <2153d65c-9a33-4793-9c7c-0d8750f39040@linaro.org>
Date: Tue, 2 Apr 2024 13:36:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 12/17] esp.c: prevent cmdfifo overflow in
 esp_cdb_ready()
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, pbonzini@redhat.com,
 fam@euphon.net, laurent@vivier.eu, qemu-devel@nongnu.org
References: <20240324191707.623175-1-mark.cave-ayland@ilande.co.uk>
 <20240324191707.623175-13-mark.cave-ayland@ilande.co.uk>
 <aaaad221-9a88-4298-ac87-49d8a827ce9f@linaro.org>
 <2fe371b5-07a3-4322-8543-76b15244dbe1@ilande.co.uk>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <2fe371b5-07a3-4322-8543-76b15244dbe1@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

On 25/3/24 13:41, Mark Cave-Ayland wrote:
> On 25/03/2024 10:26, Philippe Mathieu-Daudé wrote:
> 
>> On 24/3/24 20:17, Mark Cave-Ayland wrote:
>>> During normal use the cmdfifo will never wrap internally and 
>>> cmdfifo_cdb_offset
>>> will always indicate the start of the SCSI CDB. However it is 
>>> possible that a
>>> malicious guest could issue an invalid ESP command sequence such that 
>>> cmdfifo
>>> wraps internally and cmdfifo_cdb_offset could point beyond the end of 
>>> the FIFO
>>> data buffer.
>>>
>>> Add an extra check to fifo8_peek_buf() to ensure that if the cmdfifo 
>>> has wrapped
>>> internally then esp_cdb_ready() will exit rather than allow 
>>> scsi_cdb_length() to
>>> access data outside the cmdfifo data buffer.
>>>
>>> Reported-by: Chuhong Yuan <hslester96@gmail.com>
>>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>>> ---
>>>   hw/scsi/esp.c | 12 +++++++++++-
>>>   1 file changed, 11 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
>>> index f47abc36d6..d8db33b921 100644
>>> --- a/hw/scsi/esp.c
>>> +++ b/hw/scsi/esp.c
>>> @@ -429,13 +429,23 @@ static bool esp_cdb_ready(ESPState *s)
>>>   {
>>>       int len = fifo8_num_used(&s->cmdfifo) - s->cmdfifo_cdb_offset;
>>>       const uint8_t *pbuf;
>>> +    uint32_t n;
>>>       int cdblen;
>>>       if (len <= 0) {
>>>           return false;
>>>       }
>>> -    pbuf = fifo8_peek_buf(&s->cmdfifo, len, NULL);
>>> +    pbuf = fifo8_peek_buf(&s->cmdfifo, len, &n);
>>> +    if (n < len) {
>>> +        /*
>>> +         * In normal use the cmdfifo should never wrap, but include 
>>> this check
>>> +         * to prevent a malicious guest from reading past the end of 
>>> the
>>> +         * cmdfifo data buffer below
>>> +         */
>>
>> Can we qemu_log_mask(LOG_GUEST_ERROR) something here?
> 
> I'm not sure that this makes sense here? The cmdfifo wrapping is 
> internal artifact of the Fifo8 implementation rather than being directly 
> affected by writes to the ESP hardware FIFO (i.e. this is not the same 
> as the ESP hardware FIFO overflow).

Still this check "prevent[s from] a malicious guest", but I don't
mind, better be safe here.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


