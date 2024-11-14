Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B36F6D6A255
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 22:44:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBiYx-00063z-7g; Thu, 14 Nov 2024 17:43:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tBiYw-00063g-54
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 17:43:42 -0500
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tBiYu-00081D-2o
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 17:43:41 -0500
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a9a0c7abaa6so141180866b.2
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 14:43:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731624217; x=1732229017; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3dmN4K+AXFCuWdm/78nDnzAE0l1Q+L1Whi+FzalH3pI=;
 b=OXZW4aYt1Sncna3s4zt3X3l/+1L8qixXaXXMl1uoou5cvF0vFlCs70L3ewxdCwsO4F
 WdTdchNqhrFKrT61XoxyEJgwRlKXDD2k52Q3mQC6FDPy05hIG0gHfd9PCpYbEvJaNxs7
 0JAYbjJxjjG48syPcvRvyhqVCvyutTn7NplTIWrd3wH3KGPEFxpWvHI6cqwqEDtmHKdN
 FE4/KRmUIgtwzo7N4SJZEEfy1BPfE+4z3rHdrWn+wQjo8xNLaotGMIrAIcsl+1FAe9ax
 w7cUj7XNhPX5nAcIEx4NYOEOV5CTwuX3sp9CHPHRHtcdDjL45UNOevF5qfs/Hd1WwEkQ
 WDAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731624217; x=1732229017;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3dmN4K+AXFCuWdm/78nDnzAE0l1Q+L1Whi+FzalH3pI=;
 b=OL8Zcz1cAADa4BvzmlT4Oj39Rd5SYr1Ue6D9etsHomaHUopRr8+Xzg8jPzYsFk2IDS
 CJlmxX3XTTfRmTZUAJejk4DgVEuALTKG5ZbX71pCVlJUqtuQjjPqGc3FoIq95lpR0ekn
 VSjPquENYW44abcjBf9qkY/qKqAuGXkflZiKKybdEEj3zfwDNW6ZCL9H63I7ACJQ5HQ9
 uHjTEPIf4BR30872GYuUp7QTrHRVWmSH2aXEJ/TlleFQ+N4en4j3Zmtgpz9CaQZ6iUs4
 rBvRbvTH0o0lW1jEpukLytiTM1NiPLk5FFIypQrwqmwXCsezzUSoxXY4AnHow61fEEGv
 SAyg==
X-Gm-Message-State: AOJu0YxfsDDoaChXhVnNzjkMU7M7Q6y34Dm6gmcyW0Y4L0whx/Cqk3Hi
 hbubeljl9dHqiGVQhAKZP4IETWsZd4DGvkEpKWo7rB8baa9xQGlUr46inrSBb9g=
X-Google-Smtp-Source: AGHT+IHTcw94hOcbXFWf8FK7Y3VEoJ4AQ9SaQal8xODUQ83l1MWQGglBSQrJVBnjNuJRqT/OrcFaEQ==
X-Received: by 2002:a17:907:1c8e:b0:a9a:c57f:964f with SMTP id
 a640c23a62f3a-aa483421690mr30343866b.16.1731624217001; 
 Thu, 14 Nov 2024 14:43:37 -0800 (PST)
Received: from [192.168.69.126] ([176.187.209.228])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa20df26fc4sm109472466b.12.2024.11.14.14.43.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Nov 2024 14:43:36 -0800 (PST)
Message-ID: <1625bc6b-8951-414c-88c0-62061289fdb5@linaro.org>
Date: Thu, 14 Nov 2024 23:43:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/19] hw/intc/xilinx_intc: Only expect big-endian accesses
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Cc: qemu-devel@nongnu.org, Anton Johansson <anjo@rev.ng>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>, Thomas Huth <thuth@redhat.com>,
 qemu-arm@nongnu.org, devel@lists.libvirt.org,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michal Simek <michal.simek@amd.com>, Luc Michel <luc@lmichel.fr>
References: <20241105130431.22564-1-philmd@linaro.org>
 <20241105130431.22564-10-philmd@linaro.org> <ZyqletOJvt3nD_L4@zapote>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <ZyqletOJvt3nD_L4@zapote>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

+Michal for Linux driver

On 5/11/24 23:08, Edgar E. Iglesias wrote:
> On Tue, Nov 05, 2024 at 02:04:21PM +0100, Philippe Mathieu-Daudé wrote:
>> Per the datasheet (reference added in file header, p.9)
>> 'Programming Model' -> 'Register Data Types and Organization':
>>
>>      "The XPS INTC registers are read as big-endian data"
> 
> Hi Phil,
> 
> Some of these devices exist in both big and little endian versions.
> So far we've reused the same model by using DEVICE_NATIVE_ENDIAN.
> 
> Here's the little endian version:
> https://docs.amd.com/v/u/en-US/ds747_axi_intc

This model is specified as:

- https://docs.amd.com/v/u/en-US/xps_intc
   LogiCORE IP XPS Interrupt Controller (v2.01a)
   DS572 April 19, 2010

Spec is from 2010, you added it in 2009:

   commit 17628bc642260df3a07b9df8b8a9ca7da2e7e87c
   Author: Edgar E. Iglesias <edgar.iglesias@gmail.com>
   Date:   Wed May 20 20:11:30 2009 +0200

       xilinx: Add interrupt controller.

The spec is explicit:

   "The XPS INTC registers are read as big-endian data"


The other model you mention is:

- https://docs.amd.com/v/u/en-US/ds747_axi_intc
   LogiCORE IP AXI INTC (v1.04a)
   DS747 June 19, 2013

The spec is more recent than your addition, and contains
the Interrupt Vector Address Register (IVAR) which is not
present in our model.


Indeed the latter seems to extend the former, but they are
not the same and we need some work to model the latter.

The endianness explicit for each model (and is not listed
in the "IP Configurable Design Parameters" tables).


That said, let's look at Linux use. Driver was added in:

   commit eedbdab99fffb8ed71cac75a722088b8ace2583c
   Author: Michal Simek <monstr@monstr.eu>
   Date:   Fri Mar 27 14:25:49 2009 +0100

       microblaze_v8: Interrupt handling and timer support

Using explicit big-endian API:

   +void __init init_IRQ(void)
   +{
   ...
   +       /*
   +        * Disable all external interrupts until they are
   +        * explicity requested.
   +        */
   +       out_be32(intc_baseaddr + IER, 0);
   +
   +       /* Acknowledge any pending interrupts just in case. */
   +       out_be32(intc_baseaddr + IAR, 0xffffffff);
   +
   +       /* Turn on the Master Enable. */
   +       out_be32(intc_baseaddr + MER, MER_HIE | MER_ME);

Then the driver became clever in:

   commit 1aa1243c339d4c902c0f9c1ced45742729a86e6a
   Author: Michal Simek <michal.simek@amd.com>
   Date:   Mon Feb 24 14:56:32 2014 +0100

       microblaze: Make intc driver endian aware

       Detect endianess directly on the hardware and use
       ioread/iowrite functions.

   +static void intc_write32(u32 val, void __iomem *addr)
   +{
   +       iowrite32(val, addr);
   +}
   +
   +static void intc_write32_be(u32 val, void __iomem *addr)
   +{
   +       iowrite32be(val, addr);
   +}

@@ -140,17 +163,25 @@ static int __init xilinx_intc_of_init(struct 
device_node *intc,

   +       write_fn = intc_write32;
   +       read_fn = intc_read32;
   +
           /*
            * Disable all external interrupts until they are
            * explicity requested.
            */
   -       out_be32(intc_baseaddr + IER, 0);
   +       write_fn(0, intc_baseaddr + IER);

           /* Acknowledge any pending interrupts just in case. */
   -       out_be32(intc_baseaddr + IAR, 0xffffffff);
   +       write_fn(0xffffffff, intc_baseaddr + IAR);

           /* Turn on the Master Enable. */
   -       out_be32(intc_baseaddr + MER, MER_HIE | MER_ME);
   +       write_fn(MER_HIE | MER_ME, intc_baseaddr + MER);
   +       if (!(read_fn(intc_baseaddr + MER) & (MER_HIE | MER_ME))) {
   +               write_fn = intc_write32_be;
   +               read_fn = intc_read32_be;
   +               write_fn(MER_HIE | MER_ME, intc_baseaddr + MER);
   +       }

Interestingly little endianness became the default, although
the driver detect it on init.

This is from 2014, maybe to work with the "LogiCORE IP AXI INTC"
you mentioned, which spec date is 2013.


Indeed when forcing different endianness [*], the Linux kernel used
in our tests (tests/functional/test_microblaze*) does the check
and ends up using the correct INTC endianness:

LE CPU, LE INTC model
pic_write addr=8 val=0
pic_write addr=c val=ffffffff
pic_write addr=1c val=3           <- LE
pic_read 1c=3
pic_write addr=c val=1
pic_write addr=10 val=1
pic_read 18=0

LE CPU, BE INTC model
pic_write addr=8 val=0
pic_write addr=c val=ffffffff
pic_write addr=1c val=3000000     <- LE test
pic_read 1c=0
pic_write addr=1c val=3           <- BE
pic_write addr=c val=1
pic_write addr=10 val=1
pic_read 18=0

BE CPU, BE INTC model
pic_write addr=8 val=0
pic_write addr=c val=ffffffff
pic_write addr=1c val=3000000     <- LE test
pic_read 1c=0
pic_write addr=1c val=3           <- BE
pic_write addr=c val=1
pic_write addr=10 val=1
pic_read 18=0

BE CPU, LE INTC model
pic_write addr=8 val=0
pic_write addr=c val=ffffffff
pic_write addr=1c val=3           <- LE
pic_read 1c=3
pic_write addr=c val=1
pic_write addr=10 val=1
pic_read 18=0


IMHO this patch behavior is correct. Besides, I don't expect
firmwares to be as clever as Linux.

> Can we have add property to select the endianess?
> For the Xilinx use-cases I think it may be a good idea to default it
> to little endian and have the big-endian machines explicitly set it.

What you suggested is implemented in v3:
https://lore.kernel.org/qemu-devel/20241108154317.12129-4-philmd@linaro.org/
but after the analysis, I wonder if it isn't safer to not
make the endianness configurable, but expose as 2 models:
- xlnx,xps_intc (2010) in BE
- xlnx,axi_intc (2013) in LE

> 
> Cheers,
> Edgar
> 
> 
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   hw/intc/xilinx_intc.c | 13 ++++++++++++-
>>   1 file changed, 12 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/intc/xilinx_intc.c b/hw/intc/xilinx_intc.c
>> index 1762b34564e..71f743a1f14 100644
>> --- a/hw/intc/xilinx_intc.c
>> +++ b/hw/intc/xilinx_intc.c
>> @@ -3,6 +3,9 @@
>>    *
>>    * Copyright (c) 2009 Edgar E. Iglesias.
>>    *
>> + * https://docs.amd.com/v/u/en-US/xps_intc
>> + * DS572: LogiCORE IP XPS Interrupt Controller (v2.01a)
>> + *
>>    * Permission is hereby granted, free of charge, to any person obtaining a copy
>>    * of this software and associated documentation files (the "Software"), to deal
>>    * in the Software without restriction, including without limitation the rights
>> @@ -143,12 +146,20 @@ static void pic_write(void *opaque, hwaddr addr,
>>   static const MemoryRegionOps pic_ops = {
>>       .read = pic_read,
>>       .write = pic_write,
>> -    .endianness = DEVICE_NATIVE_ENDIAN,
>> +    /* The XPS INTC registers are read as big-endian data. */
>> +    .endianness = DEVICE_BIG_ENDIAN,
>>       .impl = {
>>           .min_access_size = 4,
>>           .max_access_size = 4,
>>       },
>>       .valid = {
>> +        /*
>> +         * All XPS INTC registers are accessed through the PLB interface.
>> +         * The base address for these registers is provided by the
>> +         * configuration parameter, C_BASEADDR. Each register is 32 bits
>> +         * although some bits may be unused and is accessed on a 4-byte
>> +         * boundary offset from the base address.
>> +         */
>>           .min_access_size = 4,
>>           .max_access_size = 4,
>>       },
>> -- 
>> 2.45.2
>>

[*] diff used:

-- >8 --
@@ -32,7 +45,7 @@
diff --git a/hw/intc/xilinx_intc.c b/hw/intc/xilinx_intc.c
index fc55c8afca..883ec685f4 100644
--- a/hw/intc/xilinx_intc.c
+++ b/hw/intc/xilinx_intc.c
  #include "hw/qdev-properties.h"
  #include "qom/object.h"

-#define D(x)
+#define D(x) x

  #define R_ISR       0
  #define R_IPR       1
@@ -105,7 +122,7 @@ static uint64_t pic_read(void *opaque, hwaddr addr, 
unsigned int size)
              break;

      }
-    D(printf("%s %x=%x\n", __func__, addr * 4, r));
+    D(printf("%s %llx=%x\n", __func__, addr * 4, r));
      return r;
  }

@@ -116,7 +133,7 @@ static void pic_write(void *opaque, hwaddr addr,
      uint32_t value = val64;

      addr >>= 2;
-    D(qemu_log("%s addr=%x val=%x\n", __func__, addr * 4, value));
+    D(printf("%s addr=%llx val=%x\n", __func__, addr * 4, value));
      switch (addr)
      {
          case R_IAR:
---

