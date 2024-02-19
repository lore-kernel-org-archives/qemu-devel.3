Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EE92C48BF8
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 14:37:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rc4lp-0003fc-Ph; Mon, 19 Feb 2024 09:37:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rc4ll-0003e8-No
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 09:37:23 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rc4lj-0004dO-5m
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 09:37:21 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-33d60acfa73so297030f8f.0
 for <qemu-devel@nongnu.org>; Mon, 19 Feb 2024 06:37:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708353437; x=1708958237; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+amIv0IqAhLn8GDdgFDj51FVtcIHkKcEJOsxW7HYsRo=;
 b=LCExZgaud4pv2PWLoorLGWaNynpWC4+8X+IC8a+KhVDAoyLkUlKlUiJsKDaHZM7YkC
 kSvP6t3zceqsUChdH6b45Wfa6OTq1uJ4TGy+pJalFfX+LpXvD/b7OFaa1+QbJJag67TJ
 clZYxbOnjYaCCp+uQCJU07gB/jGIgKQaywWF/+yBjPIQ700+Hwuusuwu89z+jffYUdzJ
 3C0AXsUUNrjaIVxC+aWFuSIi7nsPxNIhc7Ugm9doHH9L6ROVaK0DCbZ19KRQWexPeIes
 y3rGvdLondB15e02FpseMvDrucYrc6qaqK60AXWgGUP4HBIFo8fbcsGRhHp0rQ8U2f0W
 Z4zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708353437; x=1708958237;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+amIv0IqAhLn8GDdgFDj51FVtcIHkKcEJOsxW7HYsRo=;
 b=feuoSxOYKXh6J99n3bSWFZbQqAcbS0Pac2lIF5EMv4iPB8ZWk8N0Xt3EdqKyuTZ9jb
 avfx02tSI17i35BySlucY/b4T7ZWz9bPM1t94ZIjBcBQSRBOobhOac1MTwriTc02RIkw
 eqN+GVYFimmOX8ixsHqoAEDtDBAufz8ROI8/btkbQiMsAN5hLRJ8MZ3jbzIfhc4qGuQ/
 E7HaiyCWPu0/7uk+lWUo/j8kCBYbMsGO7HGnSAS3ehTQKTb6DXt2AO5P7BhnlS2Sl/1G
 uLorGu0fwfEni/S8ejn1t0/9NkhXYWTCXJy69BCtxUOjFYyOMNlOwpgNwE/rAjXqAv/o
 EbUg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUjSL15FceBMOvkuYC+EiOglI7kkAKwjJ49X62UceadOS1xmrIzeIJx+LONY475h/ABhmjQ/R7ANasbGqdRTveBX0i0eX0=
X-Gm-Message-State: AOJu0YzeMt3GMqpqjme9CX5brvy8RLS66rMAjuU8ylfS4m1hYIdInhEN
 7YaV34Hgye9b9EHggHD7E8XFth97++1FVZLMj40oN0cotXNo4iLmKbr5OqUWB2A=
X-Google-Smtp-Source: AGHT+IG7ftUfhCJ7PTIdUUfIf7zUOWx3ePqo5rEUct9Th4cV+IJf/bmVRN4zmyeM4qj6vDev94fL0g==
X-Received: by 2002:adf:fd48:0:b0:33d:1f9f:afa with SMTP id
 h8-20020adffd48000000b0033d1f9f0afamr6202528wrs.30.1708353437456; 
 Mon, 19 Feb 2024 06:37:17 -0800 (PST)
Received: from [192.168.69.100] ([176.176.181.220])
 by smtp.gmail.com with ESMTPSA id
 t12-20020a5d460c000000b0033b48190e5esm10519226wrq.67.2024.02.19.06.37.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Feb 2024 06:37:16 -0800 (PST)
Message-ID: <aebd4e54-099e-4e52-9440-7bd68f2f881d@linaro.org>
Date: Mon, 19 Feb 2024 15:37:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 19/21] hw/s390x/zpci-bus: Add QOM parentship relation with
 zPCI devices
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org,
 qemu-block@nongnu.org, Matthew Rosato <mjrosato@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>
References: <20240216110313.17039-1-philmd@linaro.org>
 <20240216110313.17039-20-philmd@linaro.org>
 <84d0375c-b687-4e0a-b7c7-77f1891ea244@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <84d0375c-b687-4e0a-b7c7-77f1891ea244@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 19/2/24 14:38, Thomas Huth wrote:
> On 16/02/2024 12.03, Philippe Mathieu-Daudé wrote:
>> QDev objects created with qdev_*new() need to manually add
>> their parent relationship with object_property_add_child().
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   hw/s390x/s390-pci-bus.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
>> index 3e57d5faca..6d07a7b530 100644
>> --- a/hw/s390x/s390-pci-bus.c
>> +++ b/hw/s390x/s390-pci-bus.c
>> @@ -934,6 +934,7 @@ static S390PCIBusDevice 
>> *s390_pci_device_new(S390pciState *s,
>>                                   "zPCI device could not be created: ");
>>           return NULL;
>>       }
>> +    object_property_add_child(OBJECT(s), "zpci[*]", OBJECT(dev));
> 
> I think there can only be one zpci device per PCI device, so do we need 
> the "[*]" here?

Oh I missed that, I'll change, thanks.


