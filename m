Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57176C36010
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Apr 2025 20:33:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2FcQ-00029W-6d; Tue, 08 Apr 2025 16:32:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>) id 1u2Fc6-00028A-Dy
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 16:32:07 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>) id 1u2Fc3-0007Da-0Z
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 16:32:05 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-736bfa487c3so5142963b3a.1
 for <qemu-devel@nongnu.org>; Tue, 08 Apr 2025 13:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744144320; x=1744749120; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
 bh=tpjeV9JWJBx2nfT0UqWH8OZ0g6ePDq96Z4EAFlWYpv8=;
 b=cP939z5rvWK9C7Pem/5xjjFB9uEm2K4fU5A15FcYRLp0+9BZG1LYkFvpjX8gLEtt2X
 8Nk67IRJdj4ikpRQU39IOSAJr8oSzjHzNN6uQHY9arLmmRPupsBdVvCcWTCQz+WJtEJU
 g5v0wUw5mcaBm0y7iXGbnGp3Jf0gZScTmbMou/+cBOFIh8G0mCAo9MKcQEXFKAXmL4ls
 Fv1+3Edq1izBQ4rqu/FZWZe/sSnWm1FGT0ad9BH6m80o2phjQMbBwOkcjznBJo0KRfgv
 OGIg5JboILjFRHoiXZF6/G6th/dW7oA9I2Ouz4bV+BKc+hOeSyxgAdpvEDQKQSXkkLqX
 AcwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744144320; x=1744749120;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tpjeV9JWJBx2nfT0UqWH8OZ0g6ePDq96Z4EAFlWYpv8=;
 b=PSghgku62YIgK+L2UIVPBzPsKYTsLOPCe9VO1WoYBnRG0awSb09aJ01LFDzv1hdEHK
 S334msCp1pDOy5aK12RTyKC+xb9xbVizm36+6SshZwfhne393/GUphz4HqlNEWAg7GBo
 SW09RpeilskSFUrMKkgK3818xGnmIBpMXXgr62KCdjqcsHYQYD1kXjRT02/kgq4Sz/5q
 R6djGkc76BB6evBHWT/zh/K5LqScZas2p5lwVjd+sz6BRWaVesZpg6l6HhYRcEkghmU1
 /GB2MlOmtLpU1sXGUO1Nlcf3/UjMDMww9rk6Q7orj42FRrNGDb6y3s40TxgwTL0rOzJH
 DJNg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUWHD6OJpEzJJTCSJSLROvAWSjjKtU3KIUgDmxYRvCL7Ta4iuETowPfpI5Yd0hIvADX3/rnjzpvIY1u@nongnu.org
X-Gm-Message-State: AOJu0YxJ4mSSGh6sEsOMlnbbfc8le/joi4rQBHjjjPXToeS1LJY1U14v
 gQZCn5ySCOQaskZRqAYFMsa2zZ7i5VC6xkicPNqfbbdu/++VoMcGvGegFQ==
X-Gm-Gg: ASbGnctg0R4So/6sOwRYe7T8Ok2dcqhyElUxIiAqMgxXmboDgJLJpixElUjiScB4ZQi
 RcgnRIpJU5Q3KjsnE2DbLAvWn5jI8dFHrtwhSlJ+Ra5kl5lz5zclxxfbthQuxj0zYCg5r8jQawL
 ioPKu9zT8Mgd4oK60HBGmV8kosLExOwHTy52ZVy7wKJTqJDNY0G1dGvuSfWqpYGzP96fNW9L0xw
 zJqcsPOu7uAHNGX8aSBn7O/7TZLM5kr5/Jvn0HOij4ApOd30EuWq+vkro77Jiu1lUZ41XH8UM5G
 p0/kIwC35XeF2OXVBqfGEeKCOOW6wBIGSIIhFv/AQtXbfCTGV4KxYntlirY+g40I5a0lRH7Y46+
 /X3tZGeac4v1Na4+gEh4rB2N2lhro
X-Google-Smtp-Source: AGHT+IEnMzJ+40DgJ28N1JwUGgtp8HJiQewjP9XJITnvCTu2rDn+OWUFMihYyMSwFaqycGxOYur6Ag==
X-Received: by 2002:a17:90b:4ecf:b0:2ff:7031:e380 with SMTP id
 98e67ed59e1d1-306dbbb562cmr822225a91.10.1744144320484; 
 Tue, 08 Apr 2025 13:32:00 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5?
 ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-306d2341fc9sm1154477a91.0.2025.04.08.13.31.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Apr 2025 13:31:59 -0700 (PDT)
Message-ID: <3b0367ca-7242-4555-a6b2-ddf546374138@roeck-us.net>
Date: Tue, 8 Apr 2025 13:31:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Add property to support writing ERSTBA in high-low
 order
To: Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20250405140002.3537411-1-linux@roeck-us.net>
 <ae8cd367-8580-4476-9a75-3fa4f7aa2536@linaro.org>
 <7ed5d213-9429-45c8-bbf3-6f3f841a2299@roeck-us.net>
 <7C5A41A1-38EE-4D22-8F84-6A5A3A2BDD82@gmail.com>
 <42a82455-7fa1-4890-a9e8-690fec3433c3@roeck-us.net>
 <9239BBD2-DCB8-4B97-9EAA-FFB06CAB660C@gmail.com>
 <89b70bdd-00e3-46ee-8810-099da032f485@roeck-us.net>
 <C5389B31-E7B2-43E0-A10D-368571DAD081@gmail.com>
 <cd6dafe1-f291-46f4-8fb1-7555dc6a60db@roeck-us.net>
 <6A2167BC-910A-4801-8FB0-24C114EF5181@gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <6A2167BC-910A-4801-8FB0-24C114EF5181@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=groeck7@gmail.com; helo=mail-pf1-x42b.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
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

On 4/8/25 12:57, Bernhard Beschow wrote:
> 
> 
> Am 8. April 2025 16:09:58 UTC schrieb Guenter Roeck <linux@roeck-us.net>:
>> On 4/6/25 11:08, Bernhard Beschow wrote:
>> [ .. ]
>>
>>>>> Yeah, it works with Buildroot as described in the handbook. When I append `-netdev user,id=net0 -device virtio-net-pci,netdev=net0` on the cli I can `wget http://www.google.com` successfully. When I omit it there is no network connectivity. This is with a 6.6.23 vendor kernel.
>>>>>
>>>>
>>>> I had no luck with virtio-net-pci. virtio-pci works for me, but I can not get real PCI devices
>>>> (such as nvme or scsi adapters) to work.
>>>
>>> I now tested with the latest Buildroot recipe, changing to upstream kernel version 6.14 and using the defconfig. The `wget` command still works for me with virtio-net-pci. However, I can confirm that I need your xhci patches for the usb storage device to be detected.
>>>
>>
>> Following up on this, my problem is that adding "-netdev user,id=net0 -device virtio-net-pci,netdev=net0"
>> to the command line adds a _second_ Ethernet interface, in addition to the default one.
>> This results in
>> 	qemu-system-arm: warning: nic imx.enet.0 has no peer
>> reported when qemu starts.
> 
> I get this too when using virtio-net-pci successfully.
> 
>>
>> I can not get that second interface to work, probably because of some userspace issue.
>>
>> Anyway, I never see any interrupts on the virtual PCI interface. From /proc/interrupts:
>>
>> 277:          0  PCI-MSI 524288 Edge      virtio0-config
>> 278:          0  PCI-MSI 524289 Edge      virtio0-input.0
>> 279:          0  PCI-MSI 524290 Edge      virtio0-output.0
> 
> I get:
> 
> 206:          0          0          0          0  PCI-MSI 524288 Edge      virtio0-config
> 207:          3          0          0          0  PCI-MSI 524289 Edge      virtio0-input.0
> 208:          8          0          0          0  PCI-MSI 524290 Edge      virtio0-output.0
> 
> Note that I'm using four CPUs, i.e. `-smp 4`.
> 

I must be missing something. Can you send me your complete qemu command line ?
I'll also try building a buildroot image to see where it gets me.

>>
>> That may work for virtio-net-pci, but it doesn't work for other PCI(e) drivers.
>> If I try to attach any other PCIe devices, the device is reported with lspci but
>> then its initialization times out because it does not get any interrupts.
> 
> Indeed, trying with e1000e:
> 
> 205:          0          0          0          0  PCI-MSI   0 Edge      PCIe PME
> 206:         74          0          0          0  PCI-MSI 524288 Edge      eth1-rx-0
> 207:         20          0          0          0  PCI-MSI 524289 Edge      eth1-tx-0
> 208:         32          0          0          0  PCI-MSI 524290 Edge      eth1
> 
> But I get this repeatedly with varying CPUs:
> 
> [   14.657163] e1000e 0000:01:00.0 eth1: NIC Link is Up 1000 Mbps Full Duplex, Flow Control: Rx/Tx
> [   19.980452] e1000e 0000:01:00.0 eth1: NETDEV WATCHDOG: CPU: 0: transmit queue 0 timed out 5312 ms
> [   19.982491] e1000e 0000:01:00.0 eth1: Reset adapter unexpectedly
> 
>>
>> Tt turns out that sabrelite has the same problem.
> 
> Did it work with QEMU 9.2?
> 

No, the pcie interfaces on sabrelite don't instantiate for me with qemu 9.2 (9.2.3,
more specifically). I see the pcie root port, but nothing behind it.

Guenter


