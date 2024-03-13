Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0E44C54E66
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 21:41:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkWLj-0003zn-3D; Wed, 13 Mar 2024 17:41:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rkWLg-0003zO-KW
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 17:41:21 -0400
Received: from mail-lf1-x12a.google.com ([2a00:1450:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rkWLf-00013D-71
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 17:41:20 -0400
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-5131a9b3d5bso446604e87.0
 for <qemu-devel@nongnu.org>; Wed, 13 Mar 2024 14:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710366077; x=1710970877; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JyHIKVFnW4IAENh7a1NH3TNXnVQr2Vjt/G0GlwYn3qg=;
 b=ka06MIp4mh9VRBXuDcrq+DdLzGSDNQf6zj7+r47RrSWgJ0S9LoDU2KhbgWe4hy32RZ
 ujchEafPLF5WSHhFMYucbKfwkbXxFPsU+p76OG+aNotkJdjVsTkEt8J+RPFyFKBX56O5
 NSHYsaxc0AZhUa5huiUARWrttwTO0eo+JPZEnmswalVz+a+5svKFzoVERAPkCXeSxMhJ
 LQYKjQApJBcU6EavlWFHxYFx/oISYVR2P6RUPH8C4vAQJsjJdbaJ0AwJIypoYNnGeA5S
 /wGidf+pvjmLEI+vvzywOKZiWzqFQT0IJZoMtCToNhPNw6wmTLei8Bd9PUrfXcJ5+Sp6
 B1Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710366077; x=1710970877;
 h=content-transfer-encoding:in-reply-to:references:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JyHIKVFnW4IAENh7a1NH3TNXnVQr2Vjt/G0GlwYn3qg=;
 b=vxeK4lFDtNVARnBst5K+7z//3PGonxvmYYlOt6qtnXUvO36U6g4KEVdEpVXxx26evV
 Rljizp4450i4oeu04olhNruCm3i5newWWv6SQi0ZGZgbPA958nYkKZZtfZjHRwmIAR2b
 91BzqtskuipjTuK4da3P01xPk/bk7hs1qolrmOKUJfIzXk3FX17sNYJu2tQX1FNnY8Pd
 Y4OE9Zzf1tkz0kvtmsrQyXtj6GFoY+PenqRlB5Acnc8b05Sedfb4srA+t0eEKQ2dQKIW
 TZDvY6w8tVjccbJJP7Tbgb5UeQWMgGJ1KYrnvr2x16tSG/HboXLaj7cEiWRhJ4VyXHol
 wCYw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUDXX6vkGEKeNn0Z7l8AyCpXysSfpL/n5mmo2S4gOEPfcxBsX0ZIabD0R8TjSsu141N2RWnW3ddv/7YdKHwGvnEbbwLmmw=
X-Gm-Message-State: AOJu0YwCwrtbMkcqjKs62/JSELg0Iu0lYsQ6K/HD161awuMJIIxc4YHA
 oG8qnAVi2od8nVIkWzZTaCi5jUM9fAXlXW5xVeHn4yFgZDQZxiz1Mr1on/5krDI=
X-Google-Smtp-Source: AGHT+IHy2+c4rTgZrWSqpGWc0ZF42twxi2F4uuTX3VLSGtvOm4EditJ+v4Zs5m5MaEa6d0BKVoe38A==
X-Received: by 2002:a05:6512:46a:b0:513:c813:bdf1 with SMTP id
 x10-20020a056512046a00b00513c813bdf1mr1966390lfd.5.1710366077223; 
 Wed, 13 Mar 2024 14:41:17 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.182.179])
 by smtp.gmail.com with ESMTPSA id
 r8-20020a05600c458800b00413e8df267bsm276831wmo.48.2024.03.13.14.41.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Mar 2024 14:41:16 -0700 (PDT)
Message-ID: <e630b670-acec-4d6d-b89d-dafcdcbfee84@linaro.org>
Date: Wed, 13 Mar 2024 22:41:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/16] esp.c: replace cmdfifo use of esp_fifo_pop_buf()
 in do_message_phase()
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, pbonzini@redhat.com,
 fam@euphon.net, laurent@vivier.eu, qemu-devel@nongnu.org
References: <20240313085810.2655062-1-mark.cave-ayland@ilande.co.uk>
 <20240313085810.2655062-3-mark.cave-ayland@ilande.co.uk>
 <9c36ddab-59a9-47fa-ab2e-ab0e9cff5fb6@linaro.org>
In-Reply-To: <9c36ddab-59a9-47fa-ab2e-ab0e9cff5fb6@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12a;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 13/3/24 12:03, Philippe Mathieu-Daudé wrote:
> On 13/3/24 09:57, Mark Cave-Ayland wrote:
>> The aim is to restrict the esp_fifo_*() functions so that they only 
>> operate on
>> the hardware FIFO. When reading from cmdfifo in do_message_phase() use 
>> the
>> underlying Fifo8 functions directly.
>>
>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>> ---
>>   hw/scsi/esp.c | 7 ++++++-
>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
>> index f8230c74b3..100560244b 100644
>> --- a/hw/scsi/esp.c
>> +++ b/hw/scsi/esp.c
>> @@ -309,6 +309,8 @@ static void do_command_phase(ESPState *s)
>>   static void do_message_phase(ESPState *s)
>>   {
>> +    uint32_t n;
>> +
>>       if (s->cmdfifo_cdb_offset) {
>>           uint8_t message = esp_fifo_pop(&s->cmdfifo);
>> @@ -320,7 +322,10 @@ static void do_message_phase(ESPState *s)
>>       /* Ignore extended messages for now */
>>       if (s->cmdfifo_cdb_offset) {
>>           int len = MIN(s->cmdfifo_cdb_offset, 
>> fifo8_num_used(&s->cmdfifo));
>> -        esp_fifo_pop_buf(&s->cmdfifo, NULL, len);
>> +
>> +        if (len) {
>> +            fifo8_pop_buf(&s->cmdfifo, len, &n);
> 
> 'n' is unused, use NULL?

Using NULL:

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


