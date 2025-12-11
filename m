Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72109D3E79D
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Dec 2025 08:06:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTbgW-00077N-DR; Thu, 11 Dec 2025 03:06:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shorne@gmail.com>) id 1vTbgV-00077E-BN
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 03:05:59 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shorne@gmail.com>) id 1vTbgT-0008Ij-S0
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 03:05:59 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-47795f6f5c0so3520415e9.1
 for <qemu-devel@nongnu.org>; Thu, 11 Dec 2025 00:05:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1765440356; x=1766045156; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=B8m6sfT8Y34wE7X1bn90nJA3HwQEycqThNxoee8UPp0=;
 b=l6XWkNd4xYQfFg8g+zA1OdgQdsqzysv5/TUWzRKCvj82ZaBgwz//9r2X0lBrZW3uOJ
 bO7i3Sh1cqg0sJpHZk/HMi/s1BzjaMuY7FvfLL/YLrmOKkdlp9Bo6Bhxv4UPrZYwvyty
 9BwmFB2K4tcMoUAORflUK6M592Iag91mS4XEFfrQmS0+/XT46lni2KULrIIH99s2qf16
 5hHeGKL7mYA9snuILkLxrbHzH91nqnV6Qz9tvt5vhNOsAqzaex8WMVIByzVdtUAz+WQh
 cgbeUOvERb32srK/oFzW2wugg0T99ZiYu4A2Kheqig/BLbnCsKZH92jDVJE7Rho3dyXM
 Ti1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765440356; x=1766045156;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=B8m6sfT8Y34wE7X1bn90nJA3HwQEycqThNxoee8UPp0=;
 b=Zvro8zT4JM1liD4qIB92LXwuXKYho0CGy9N7yG2xZX32NVSksa+C6drAZwzRsnc7Nu
 d7P66LzmfrWCu7CqCXlU0AA9szuiJmz3l3tyiiA2j0kPSv8GQit4ZYBOyHUsYoiAlY5I
 Wc8aAdzLjlw7Nd3rhPMLEr1ImSS7Q72BR67qkQ6f+j3EWpKeJ4wbzygyuORSWD0u0UgZ
 Fu8oCSRj9+JTzl2RDXnCro+F4sAW+XYgFShMLBFtRBHd2N0+aHpJFm8JAM+Tp9c1yx2Q
 Q4fdcTccieZtd9AVgfs4dntma2FCGdxxPL46y5vkOTu1IZbT4RiqfZWb7/2heGj2e+Z4
 Hh1A==
X-Forwarded-Encrypted: i=1;
 AJvYcCU79uE/zBq9eTmXaDdIPW4oMPJONI53xd3e6bUEb3BIiDhTCjxQXxC07s/O8kITNNuhiFi1ybfj68yZ@nongnu.org
X-Gm-Message-State: AOJu0Yxc1zoSt3S34qKyD9PST+gx394D/x/2WUD8KZdKNPcAtLmtmU+r
 zDnvbhgZ/9D4gVtlKAOb/G81r79TZbAOdiC2x5DW4VDVmiOS85OWX21n
X-Gm-Gg: AY/fxX7ELYv5l4iFp76LuAPmnanLWJHpXlzHfFLINxu1yp8EiwYUkPlQGtMgAS+usV6
 39hOPHdfA8nYaF12CNRFW7rl/6EK4Z1Edt1wI2OqDA4aX2pg63m2rjAaKhOuEg0xWSMgks3JsPd
 RwYlXfzKNcNhq8kDJK7SVXlv+Z0Mc9VyF0eCQicYf2ZYNE23MH1OkLWVAHaeZLT23bbadyg5zbZ
 pyuATK5qQyD4s/WqcHNC9VNyrzQHApmeeGz4dres3MIxC5oQmmAlmAxI+t8iaugLQNII2Q2uOzh
 mEGU9ifpNcA/yLjPVQxbekBNE1lyu6PsjFG3TpKHqOrpsykCWOlgrNMkwDFMT/pWFJEfDIFKUIT
 lQyE+5MKcqnkuBmHTDAngubDROEZigPDrKnUUrME+zrxskwxsGF8pDQD6fujvNtGQ2uT+jO+4BA
 U4jJv91nPTlsdBjtCwpg4+0ZrgbVu5Mh0hzToAsUqEo8TmQyiQzm/FW//2ssDjWLoD
X-Google-Smtp-Source: AGHT+IHtyvpYdjGeaj4eP9WAy8IKtpydyzT5+91nSXnqhNLLKcXigLTCzFBDhmRhS5AbqDwJVdqk2w==
X-Received: by 2002:a05:6000:1889:b0:429:bc68:6c95 with SMTP id
 ffacd0b85a97d-42fa3b060eamr5180523f8f.47.1765440355334; 
 Thu, 11 Dec 2025 00:05:55 -0800 (PST)
Received: from localhost
 (brnt-04-b2-v4wan-170138-cust2432.vm7.cable.virginm.net. [94.175.9.129])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42fa8a66b97sm4235640f8f.7.2025.12.11.00.05.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Dec 2025 00:05:54 -0800 (PST)
Date: Thu, 11 Dec 2025 08:05:53 +0000
From: Stafford Horne <shorne@gmail.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Joel Stanley <joel@jms.id.au>, QEMU Development <qemu-devel@nongnu.org>,
 "Jason A. Donenfeld" <Jason@zx2c4.com>,
 Openrisc <openrisc@lists.librecores.org>
Subject: Re: [RFC PATCH 3/3] hw/openrisc: Add the OpenRISC virtual machine
Message-ID: <aTp7YW43nxdqDOAT@antec>
References: <20220527172731.1742837-1-shorne@gmail.com>
 <20220527172731.1742837-4-shorne@gmail.com>
 <CACPK8XexaTREY3Y-jp8urTAE+UmQWgygFx1MAss9KcJw5tGMtw@mail.gmail.com>
 <8c34270f-9fdc-3e94-0984-29d9a5e5542f@linaro.org>
 <36365615-9e43-4ce5-a1ba-e495eacb1f24@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <36365615-9e43-4ce5-a1ba-e495eacb1f24@linaro.org>
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=shorne@gmail.com; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Wed, Dec 10, 2025 at 06:22:58AM +0100, Philippe Mathieu-Daudé wrote:
> On 2/6/22 17:49, Richard Henderson wrote:
> > On 6/2/22 04:42, Joel Stanley wrote:
> > > Hi Stafford,
> > > 
> > > On Fri, 27 May 2022 at 17:27, Stafford Horne <shorne@gmail.com> wrote:
> > > > 
> > > > This patch add the OpenRISC virtual machine 'virt' for OpenRISC.  This
> > > > platform allows for a convenient CI platform for toolchain, software
> > > > ports and the OpenRISC linux kernel port.
> > > > 
> > > > Much of this has been sourced from the m68k and riscv virt platforms.
> > > 
> > > It's a good idea! I did some playing around with your patch today.
> > > 
> > > I'd suggest adding something to docs/system/target-openrsic.rst,
> > > including an example command lines.
> > > 
> > > > 
> > > > The platform provides:
> > > >   - OpenRISC SMP with up to 8 cpus
> > > 
> > > You have this:
> > > 
> > > #define VIRT_CPUS_MAX 4
> > > 
> > > I tried booting with -smp 4 and it locked up when starting userspace
> > > (or I stopped getting serial output?):
> > > 
> > > [    0.060000] smp: Brought up 1 node, 4 CPUs
> > > ...
> > > [    0.960000] Run /init as init process
> > > 
> > > Running with -smp 2 and 3 worked. It does make booting much much slower.
> > 
> > target/openrisc/cpu.h is missing
> > 
> > #define TCG_GUEST_DEFAULT_MO      (0)
> > 
> > 
> > to tell the JIT about the weakly ordered guest memory model, and to
> > enable MTTCG by default.
> > 
> > > I enabled the options:
> > > 
> > > CONFIG_RTC_CLASS=y
> > > # CONFIG_RTC_SYSTOHC is not set
> > > # CONFIG_RTC_NVMEM is not set
> > > CONFIG_RTC_DRV_GOLDFISH=y
> > > 
> > > But it didn't work. It seems the goldfish rtc model doesn't handle a
> > > big endian guest running on my little endian host.
> > > 
> > > Doing this fixes it:
> > > 
> > > -    .endianness = DEVICE_NATIVE_ENDIAN,
> > > +    .endianness = DEVICE_HOST_ENDIAN,
> > > 
> > > [    0.190000] goldfish_rtc 96005000.rtc: registered as rtc0
> > > [    0.190000] goldfish_rtc 96005000.rtc: setting system clock to
> > > 2022-06-02T11:16:04 UTC (1654168564)
> > > 
> > > But literally no other model in the tree does this, so I suspect it's
> > > not the right fix.
> > 
> > Correct.  The model might require
> > 
> >      .endianness = DEVICE_LITTLE_ENDIAN,
> > 
> > if that is the actual specification, or it may simply require fixes to
> > handle a big-endian guest.
> > 
> > All that said, if we're going to make up a new virt platform, it should
> > use PCI not virtio.  See the recent discussion about RISC-V virtual
> > machines, where they made exactly this mistake several years ago.
> 
> Unfortunately this precious remark was missed :(

Which part of it?  I think I took this comment into consideration and switched
OpenRISC virt from virtio to PCI.  But regarding endianness I did what I could.

-Stafford

