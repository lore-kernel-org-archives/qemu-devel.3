Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EE47C83F0A
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 22:34:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXoxq-0001iZ-2B; Fri, 04 Jul 2025 18:33:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jackson88044@gmail.com>)
 id 1uXoxb-0001fG-1T
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 18:32:47 -0400
Received: from mail-qt1-x82e.google.com ([2607:f8b0:4864:20::82e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jackson88044@gmail.com>)
 id 1uXoxX-00074k-Oo
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 18:32:45 -0400
Received: by mail-qt1-x82e.google.com with SMTP id
 d75a77b69052e-4a77ffcb795so12828781cf.0
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 15:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751668361; x=1752273161; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=j+Ownk7GFW8gbQSE9HvOKZTrPADqXWBpP4K2vmJam5s=;
 b=NbbZ3QZJWHBsinS80lB8D6PEk/be6GUzAMXdw/ZmBEESXzuy/9NusOc5BOdWjh2Ic3
 CCFncpgQ4kXSlbIXzKr0RPsx92qIxweQgHzASQ7SaGLdF3s9EjdY5DKw/9TdxvEYKVsd
 WaBBR8h0FBe/Hh/iAEm6+oLJ9SvABpzvRH8oWC4cvSxxzEYPb4e7YS7YpT5qin+1EbgY
 6aLmmhXCdReexROfiKZXHxx8492hAReo1EEekytC7taY0ekrc5oO4dsnYAIi11LCLYsT
 QQwT8kbPPyqWS3ts2nsBBFhhsDYqnrYhmejmt7HSEsiS0kF12hxhl21jUh2sFNKU1RZ9
 Ipkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751668361; x=1752273161;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=j+Ownk7GFW8gbQSE9HvOKZTrPADqXWBpP4K2vmJam5s=;
 b=Dl06tMGRvqUJEASytw3ifE/pDhlHB8cfM41HyNH7QjiocfBoUb2+/C+xZ3Qf95k5mb
 A7Q2bOSs/vFWcn/XOmSH75C56pQoCaXInNok8Piaqc2mp7mNTB+49yDIhMdSBYv2bH7d
 c+Wz/g4mzQA4rHMiEyFZHk0OPCYFPDyqXcINeTqq70tfY2ZVxkQY2TrDZRt+Ljk1U1Xf
 H4dkyb+Osp4AkrQHHm8Bjnj/uEGmXTCqYXlpNPlJdLrLOYP3bZAmWUkhtJRz8jftg4W5
 Y6AXV2BbTu1BWdpVwZW5anAiw8Ay7p7d44l6nkJQXovwjMLiN/3rApq00JC//AOzIws3
 t9/g==
X-Gm-Message-State: AOJu0YzQ8kxKvk29GIkkElumdlJbqzOHbMgX3qT1ebt8g+6jVm0Wv9ER
 8DL7fnFBvjK/8W/9URuBANor3fox9GJ0fbc2sGZL4LgxwfnufACkV4xoNa2PCQ==
X-Gm-Gg: ASbGncsCfuJprdUve+oWuBjE2mI9QjqrsazMNIOLa3Ru7T+uN4+lhpN89hYBfmLYNnl
 hX5rgyjn18hJTTkQpvH/bOk+r6IwxzWsolZh7bdDj4o/pskFZ2NE5KXinFBRt1M4Io5LaokIwhw
 gcrctyHITRnSvtxxq4pd6QmXZRnepNxo4HHHtGhl5ONCEjv+2CNAXwenQJkVd18OMxKgXWjwAs3
 Fz2d0q9MoEDRXvNC4ZLlYpUGgkXoXDTmul1vCuANd20cVDzl/97mzdSSU55yDlC2lfzh9sjAnNf
 XK2R0Lftj9Eh7eNcKZvZSSliHqBabMG6CeJlAa1F0Wc19JHgrZ4qHsZpLNOVQvurlnYLN259QR6
 lC4ipmw==
X-Google-Smtp-Source: AGHT+IEu20/noF989Lr6vSaR92ZZsKzVd6J/gpmttk86k6rarjUTdkckfsj2hhxASNxsnY5BN7tzWg==
X-Received: by 2002:a05:620a:1aa1:b0:7d4:3d6d:b8bd with SMTP id
 af79cd13be357-7d5f2f3fe85mr66223385a.45.1751668361016; 
 Fri, 04 Jul 2025 15:32:41 -0700 (PDT)
Received: from user-jcksn.myfiosgateway.com
 ([2600:4040:2bcd:3800:7cf4:c69f:10f5:f5b9])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4a994a3093asm21528851cf.36.2025.07.04.15.32.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 15:32:40 -0700 (PDT)
From: Jackson Donaldson <jackson88044@gmail.com>
X-Google-Original-From: Jackson Donaldson <jcksn@duck.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH v4 00/11] MAX78000FTHR Implementation
Date: Fri,  4 Jul 2025 18:32:28 -0400
Message-Id: <20250704223239.248781-1-jcksn@duck.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::82e;
 envelope-from=jackson88044@gmail.com; helo=mail-qt1-x82e.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

v4:

Spacing and style standard changes in GCR SOC, TRNG SOC, and AES SOC

v3:

Addresses a few more comments by Peter. Really appreciate the review, thank you.

ICC SOC:
Gave each device a unique name

UART SOC:
Removed references to DeviceState and gave each device a unique name

GCR SOC:
Set object property links statically, instead of by reference to device id

TRNG:
Added comments explaining interrupt generation logic. See further rationale under v2.
It's certainly possible I'm missing something here, but I think what I have is correct.

TRNG SOC:
Removed reference to DeviceState

AES:
Simplified integer load & stores, added assertion before writing to memory_region_init_ram

AES SOC:
Removed reference to DeviceState

v2:

Addresses comments by Peter.
For each device:
- Switched soc to use sysbus_realize
- Standardized switch case bracing, indentation, and error case
- Added valid min and max access size
- Changed endianness to DEVICE_LITTLE_ENDIAN
- Added reset method, if not already implemented
- Added migration support
- Split soc integration into separate commit

Machine Implementation:
Added user guide URL
Removed refclk. According to https://developer.arm.com/documentation/ddi0403/d/System-Level-Architecture/System-Address-Map/The-system-timer--SysTick/SysTick-Control-and-Status-Register--SYST-CSR the systick clock can be either the processor clock or an implementation defined external reference clock. As far as I can tell based on the user guide, the MAX78000 does not define an external reference clock. I have not confirmed this in hardware.
Changed IRQ count to 120 and noted that the user guide is unclear on this number
Fixed unimplemented device lengths and names

ICC:
Removed ICC_Invalidate
Added number to device names

UART:
Fixed interrupts, allowing async UART
Added number to device names

GCR:
Changed string-based device search to prop links for device reset
Changed cpu_physical_memory_write to address_space_write

TRNG:
Changed source of randomness to qemu_guest_getrandom_nofail
Did not change interrupt generation
> Your interrupt generation code in this device doesn't look
> right: the interrupt is supposed to be generated when each
> new random number is ready, so in our "generation takes
> zero time" model a read from DATA should provoke a new
> interrupt immediately (assuming the interrupt is enabled):
> you need to simulate the ready status bit going low and
> then high again.

I believe the interrupt generation is fine in this case;
by latching it high so long as the interrupt is enabled,
the interrupt handler gets called repeatedly until it
receives the desired amount of data and disables the interrupt.
I've tested this and it works with the maxim sdk's
implementation of asynchronous trng.

> See also my comments on an earlier patch about the usual
> logic being to have an update function which does
> "set interrupt to (condition && enabled)".

In this case there is only one possible interrupt condition
(is there random data ready), which is always true when enabled.
As such I don't think a handler function is really necessary

v1:
This patch series implements basic support for the MAX78000FTHR machine

https://github.com/JacksonDonaldson/max78000Test
Contains instructions for building a test program against the MAX78000FTHR
as well as results of the test suite run on QEMU and hardware.

Jackson Donaldson (11):
  MAX78000: Add MAX78000FTHR Machine
  MAX78000: ICC Implementation
  MAX78000: Add ICC to SOC
  MAX78000: UART Implementation
  MAX78000: Add UART to SOC
  MAX78000: GCR Implementation
  MAX78000: Add GCR to SOC
  MAX78000: TRNG Implementation
  MAX78000: Add TRNG to SOC
  MAX78000: AES implementation
  MAX78000: Add AES to SOC

 hw/arm/Kconfig                  |  15 ++
 hw/arm/max78000_soc.c           | 232 +++++++++++++++++++++
 hw/arm/max78000fthr.c           |  50 +++++
 hw/arm/meson.build              |   2 +
 hw/char/Kconfig                 |   3 +
 hw/char/max78000_uart.c         | 285 ++++++++++++++++++++++++++
 hw/char/meson.build             |   1 +
 hw/misc/Kconfig                 |  12 ++
 hw/misc/max78000_aes.c          | 223 ++++++++++++++++++++
 hw/misc/max78000_gcr.c          | 351 ++++++++++++++++++++++++++++++++
 hw/misc/max78000_icc.c          | 120 +++++++++++
 hw/misc/max78000_trng.c         | 139 +++++++++++++
 hw/misc/meson.build             |   4 +
 include/hw/arm/max78000_soc.h   |  50 +++++
 include/hw/char/max78000_uart.h |  78 +++++++
 include/hw/misc/max78000_aes.h  |  68 +++++++
 include/hw/misc/max78000_gcr.h  | 131 ++++++++++++
 include/hw/misc/max78000_icc.h  |  33 +++
 include/hw/misc/max78000_trng.h |  35 ++++
 19 files changed, 1832 insertions(+)
 create mode 100644 hw/arm/max78000_soc.c
 create mode 100644 hw/arm/max78000fthr.c
 create mode 100644 hw/char/max78000_uart.c
 create mode 100644 hw/misc/max78000_aes.c
 create mode 100644 hw/misc/max78000_gcr.c
 create mode 100644 hw/misc/max78000_icc.c
 create mode 100644 hw/misc/max78000_trng.c
 create mode 100644 include/hw/arm/max78000_soc.h
 create mode 100644 include/hw/char/max78000_uart.h
 create mode 100644 include/hw/misc/max78000_aes.h
 create mode 100644 include/hw/misc/max78000_gcr.h
 create mode 100644 include/hw/misc/max78000_icc.h
 create mode 100644 include/hw/misc/max78000_trng.h

-- 
2.34.1


