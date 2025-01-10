Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FD06E77188
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 18:28:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWJjm-0001p5-7A; Fri, 10 Jan 2025 13:28:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tWJjg-0001n3-7b
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 13:27:56 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tWJje-0007HQ-G4
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 13:27:56 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-436ce2ab251so17913035e9.1
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 10:27:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736533672; x=1737138472; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Io4AqysyFjfAJGqhmMgH/s7Uq02PXFmlJ9QlWqXWNVo=;
 b=GpOlClsSE+Dnj8lcznJlvpHzdSBsoMcXghh0SHqgRCMpiLaJ0OboSmfgpT64uBXxlp
 aiUvx5wCsAjkhZuuGPTAWuoI3IFmufnhy7BMMUZvPHGITVKREf7XrGWncNIlKIW3uSHF
 QIC2Fvl6+xiJEQLkzlRkcqWMnODBcJojeAavLQ/o/TR0A8epP3aS/fs5nF+eTZbqOtCX
 22XJS5ZWfrFQ+HaZA1FIAzFmYCet3z9kZf1YLi0cCHoAtM1cr7xc4kgeWMeblZ/d7G8J
 s2JixcIGiBxOc/1ankbKeQ9p9gCx8xxS5lK2cPtiG6LvNWEOaDsv6LVv4XaTD6G002hZ
 K3tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736533672; x=1737138472;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Io4AqysyFjfAJGqhmMgH/s7Uq02PXFmlJ9QlWqXWNVo=;
 b=j6bG4jhLuebtmt4EZIRu3jaUn7dyQHIyUO1TxXPzVRDp1+60dTWT3616wv8G9ZBogc
 P7B+KL+8zYIEnTEsHpehICNd9oUiINnOpYB32DyAfwtUWZ84KwYuPXF+ELmLpztq3J3N
 lWEYXYpMlr56tNGrJNvgd3tJUZCPk3e3Zs/iki9lbKHng6e968dm03Q4ySBvCnpi1dRX
 JxRncwrjBzcaxRQV0NfXIFz7JovRFcu+r4RMIiNhgZXR392zmVOtbXeMGeJHVlnFmHL0
 qVkaUkZ9+sARQQHGRHOypNOrplGK0Kz0hxRw6Mb0aNthYsnxvvq06g3KvGeZziyelglW
 fiFQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU1mPn5MveeZo7a04BwE5VE3odyjIRWbfJQY/L3uvJdwXrltgS0vSn813Hryy14na6wXBAsdyfLUmCZ@nongnu.org
X-Gm-Message-State: AOJu0YysGRZqpTZvB/543KJX71uAN4E3wTMzPU6sqzyydnByRCnu4ts3
 dJi5jgRhUX3gwDk6aMdl/vMDTNDvDjzMNxIJ3iJEe3Wj8p/fDhhzl5bkunsZpaI=
X-Gm-Gg: ASbGncuoryUq4lwC0+Ah7QXsAhAIfmsY/diEyTKfNbYaEAufQUfeHXgTNAsWDP9OxsI
 3COxkF3/yrZaczf6THvlmP4uxu62OrN4+M7y+w9vmou3NA8/LsfPE9JtOVEI/HIDJFSDp6H8YSk
 C+MvL7O+S58FowKGfq28P2wFyEENeAmjmmUHdAFtYACfwfnjDUJhBv+ziJv7te2s8NyCOt3Z2Bs
 oU3Vkc4cO83c0SeNbwKUadBuWb5qqCV1ayJkZ3AzWHbqE/7EI8dduG4HriFHbll+t79bNKfyAsl
 g+mugCn7X+kHjxzVpkfuZ1v5
X-Google-Smtp-Source: AGHT+IHIbS1BKXFlIORte7h9men2xGA27qkNgXbIB+RJXPhs8DpsukyawHjwq/HA4xBzqS5teXiY1Q==
X-Received: by 2002:a05:600c:138d:b0:434:9936:c823 with SMTP id
 5b1f17b1804b1-436e26a85acmr17039125e9.18.1736533672119; 
 Fri, 10 Jan 2025 10:27:52 -0800 (PST)
Received: from [192.168.69.181] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e3834a6sm5113914f8f.28.2025.01.10.10.27.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Jan 2025 10:27:51 -0800 (PST)
Message-ID: <acaed2f3-e3ba-4ce1-8282-ed4dedeb30a4@linaro.org>
Date: Fri, 10 Jan 2025 19:27:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/char/serial: Convert to three-phase reset
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20250110175707.82097-1-philmd@linaro.org>
 <798b6e65-8aaf-44cf-bab7-a145d6ea87f3@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <798b6e65-8aaf-44cf-bab7-a145d6ea87f3@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

On 10/1/25 19:12, Paolo Bonzini wrote:
> On 1/10/25 18:57, Philippe Mathieu-Daudé wrote:
>> Convert the TYPE_SERIAL (16550A UART) to three-phase reset.
>>
>> Local states are reset in the ResetHold handler.
>> Move the IRQ lowering to ResetExit, since it an external
>> object is accessed.
> 
> Accessing external objects is fine for hold; only "enter" cannot do so.
> 
>> ---
>> That said, externally creating IRQ like that is odd, see:
>>
>>    serial_pci_realize()
>>    {
>>      SerialState *s = &pci->state;
>>      qdev_realize(DEVICE(s), NULL, ...);
>>      s->irq = pci_allocate_irq(&pci->dev);
>>
>> But too much cleanup for now, one step at a time.
>> ---
> 
> serial_realize cannot fail.  Just move qdev_realize after the assignment 
> and pass &error_abort?  Same for serial_mm_realize and 
> multi_serial_pci_realize; serial_isa_realizefn instead is doing the 
> right thing.

OK, v2 coming (without &error_abort, can be done later).

