Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E164EC04FFE
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2024 21:10:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzNPC-0000B5-MK; Tue, 23 Apr 2024 17:10:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>) id 1rzNPA-0000Aw-PK
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 17:10:20 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>) id 1rzNP8-0007HZ-EN
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 17:10:20 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1e834159f40so45857265ad.2
 for <qemu-devel@nongnu.org>; Tue, 23 Apr 2024 14:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713906616; x=1714511416; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
 bh=249MlgqyuzBuGlmmyAn0wU6ZuUaezBL9K2jELzRaOig=;
 b=AuHUpwl7jTWVRVrvqsghxLQPzTtFEt1/Zy9AHYD5KOtEhBZJfMJxY+3WAgaUAlqOPR
 npRxkMF8We7r4W7pXglKcmLto5ngmExEg7MGGcz6FMtE8RxwiT8c516Fvxa1XzMRUZFs
 BpsYiSP4iW79CEGLTje4AcNot019X8cNVAFxS05Mk1UTPaRIjnfglkV8rMvUKw57TCFm
 OXoGZs1pZvXPo4VpAl/nKZXkvMVniGUSQO+iVwSg+eW8ir48k3q+o8DCXdFYmVHlYFgN
 LounUUlEQwFN/T+q+B2K6RmRotNi6sLRGcCDohRD+8UFStjz9FrlUEfw94/Ru5FkEGER
 0ktw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713906616; x=1714511416;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=249MlgqyuzBuGlmmyAn0wU6ZuUaezBL9K2jELzRaOig=;
 b=wRKjp1kScQREU9rBTtdCbQGkHxzRybWzLdezS/Q82BVpE14SnGvaarHsUXGwD3ZFvb
 QTGRedEw40GPnqLC660RTW/1qE+vgkenwyN5qwHr/8hGsSdAvrIiI0i0H8I8y8DO81v9
 wRehrMLVQP26SlIAPoC2QIfGyFUZgn6saBigyCS1JLpnbfNyuhY209JQsMQQ924bwBnN
 ShzvMas9UgquGLV7TrSqM0lSoWwVsiuwdQU5RgMoKog/3OTWR+6UJEkDU2fQqreHxTDN
 1PoJfABLTUnEkCencLPmM+JJG2tDgYgSoHopG0c3NOXhDSLL6h4/5y2/sartgIxRJv9J
 j8QQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXYHqQJU6n3nYIjR809Gjr5159yM06T0t++3TaxTCTU2RsJtOSYP/iCKXEPcRWJ4iC+Acag5XbrkTPvuR8iBcjDQSK9im0=
X-Gm-Message-State: AOJu0YyjcpPxrNTcqIqaWSdJ4ArOfLEyl0QjKJobK9cqyt+TlmPApVIL
 eex7tYbPcYEkeJ0XvPATS5ceezEopf4rW3Z5V2ajSeB3xiwn/GWo
X-Google-Smtp-Source: AGHT+IG/iYwdzLDL/p3fmBHc/L6USifMS1C4Lqng8hREkLbdy93Dz3c9XRzbzT/Ol4IKv8vWXg/xxQ==
X-Received: by 2002:a17:902:c20d:b0:1e9:9fd4:e62d with SMTP id
 13-20020a170902c20d00b001e99fd4e62dmr717357pll.11.1713906615990; 
 Tue, 23 Apr 2024 14:10:15 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c?
 ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 q4-20020a170902edc400b001e29c4b7bd2sm10506181plk.240.2024.04.23.14.10.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Apr 2024 14:10:14 -0700 (PDT)
Message-ID: <52bac533-6b22-49b0-8390-ded9c075e72b@roeck-us.net>
Date: Tue, 23 Apr 2024 14:10:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Problems (timeouts) when testing usb-ohci with qemu
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-usb@vger.kernel.org, Gerd Hoffmann <kraxel@redhat.com>,
 qemu-devel@nongnu.org
References: <4664cf39-5dfe-4557-959d-149640ca36e1@roeck-us.net>
 <10f44ba3-51a4-42a6-85c7-f8068b56fee1@rowland.harvard.edu>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <10f44ba3-51a4-42a6-85c7-f8068b56fee1@rowland.harvard.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=groeck7@gmail.com; helo=mail-pl1-x636.google.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Hi Alan,

On 4/23/24 10:30, Alan Stern wrote:
> On Tue, Apr 23, 2024 at 10:04:17AM -0700, Guenter Roeck wrote:
>> Hi,
>>
>> when testing usb-ohci
> 
> What is usb-ohci?  Do you mean ohci-hcd?
> 
>>   with qemu's pci-ohci emulation, I keep getting
>> random usb interface timeouts. Sometimes the usb_hub_wq times out.
> ...
> 
>> Sometimes there is an i/o scheduling timeout such as
> ...
> 
>> This is not a new problem; I have seen it forever. Recently I spent some
>> time trying to understand the problem and found that the linux driver does
>> not always handle all ohci interupts.
> 
> Please be more specific: _Which_ interrupts aren't being handled?  That
> is, which flags remain set in the intrstatus register when the handler
> returns?
> 
Sorry, I didn't think it was relevant.

Here is the result of repeating the test with the linux patch several times
and passing the log output through "sort | uniq".

       1 pending 0x2 mask 0x8000005a
       9 pending 0x4 mask 0x8000001e
     208 pending 0x4 mask 0x8000005e

So it is almost always OHCI_INTR_SF and rarely OHCI_INTR_WDH.
For reference, this is repeatedly running

CMDLINE="panic=-1 kunit.stats_enabled=2 kunit.filter=speed>slow root=/dev/sda rootwait console=ttyS0,115200 earlycon=uart8250,mmio,0x10000000,115200"
qemu-system-riscv32 -M virt -m 512M \
      -no-reboot -bios default -kernel arch/riscv/boot/Image -snapshot \
      -device virtio-net-device,netdev=net0 -netdev user,id=net0 -usb \
      -device pci-ohci,id=ohci -device usb-storage,bus=ohci.0,drive=d0 \
      -drive file=rootfs.ext2,if=none,id=d0,format=raw \
      -append "${CMDLINE}" \
      -nographic -monitor none \
      --trace 'usb*' -D "/tmp/usb-ohci.$$.${sequence}.trace.log"

Tracing isn't really necessary but it changes timing enough that
the problem is more likely to be seen if it is active. The problem
is seen with various emulations; I just picked one of them.

>>   Since the interrupt is shared and
>> thus level triggered, that means that interrupts are still pending when
>> ohci_irq() exits. The interrupt core in Linux does not re-enter the
>> interrupt handler, presumably because it is marked as shared interrupt
>> and returns that the interrupt has been handled.
> 
> Isn't that behavior mistaken?  A level-triggered IRQ that remains set when
> it is re-enabled (when the various shared handlers return) should cause
> another interrupt to occur right away.
> 
> Edged-triggered interrupts would be a different story, of course.
> 

Maybe I got it wrong; I thought that shared interrupts would have to be
level triggered. But then you are correct: one would think that level
triggered interrupts would keep executing interrupt handlers until the
interrupt is completely handled. I guess that means that I don't really
understand what is happening. Sorry for jumping to conclusions.

>> I found two possible fixes for the problem. One essentially mirrors the
>> code from ehci_irq(), the other adds a (bad) kludge into qemu. Both "fix"
>> or work around the problem.
>>
>> Question is: What is actually wrong ? Something in the generic interrupt
>> handling code in Linux, something in the Linux usb-ohci driver, or
>> something in qemu ? Any idea how a proper fix might look like ?
> 
> To answer these questions we need more information.
> 
What else would you need ?

Thanks,
Guenter


