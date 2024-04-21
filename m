Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C78CAC4345F
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Apr 2024 10:19:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ryUH2-0005C4-F6; Sun, 21 Apr 2024 06:18:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1ryUGx-0005BU-NI; Sun, 21 Apr 2024 06:18:12 -0400
Received: from collins.uni-paderborn.de ([2001:638:502:c003::14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1ryUGv-0008Ah-0t; Sun, 21 Apr 2024 06:18:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=mail.uni-paderborn.de; s=20170601; h=In-Reply-To:Content-Transfer-Encoding:
 Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
 Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=MuXmqVNk9vriirjyGts6Av5MAaDQTHLX4oeBi0sv69E=; b=bSiK/XIwthDT/beAA/7xoSmu90
 956cRvEdQbTFomP5RCpec5KYk50JeOZ2eGLhzweAWlJ72v9eENGtBQm0z4WHQ7KLfSvuiLlW7Wj8o
 4AQOlgp6HLUqB41teXPMQPBFT3bJdZWbqjjQ3tlt0zj3SwS3Z7tuIfmu0douTr2B0MCE=;
Date: Sun, 21 Apr 2024 12:17:58 +0200
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
To: Sameer Kalliadan Poyil <sameer.kp.in@gmail.com>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 qemu-discuss@nongnu.org, qemu-devel@nongnu.org
Subject: Re: Qemu for TC377
Message-ID: <2dmeztro45uitfbbpjlpekwv6zai2wntvvyfbggx2ps5ds2ye3@ij7eygqpw4x7>
References: <CAAA2AK8p=RtqeNZXfnqprw+kqEBTvrQo1Va81+ctfYAT6k6jnA@mail.gmail.com>
 <07e79630-7171-4cb5-829d-a87a8165adc5@linaro.org>
 <gqzmd4roytmeq3hbtb4b4frhomqtcn4aje4wja7bwmbrvb5dfh@oumkvbg3uah3>
 <CAAA2AK-tMmG079EAuqmZ7QNWiP1yXNbCfk+4FW8ypgB4hmeDsw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAA2AK-tMmG079EAuqmZ7QNWiP1yXNbCfk+4FW8ypgB4hmeDsw@mail.gmail.com>
X-IMT-rspamd-score: -25
X-IMT-Spam-Score: 0.0 ()
X-Sophos-SenderHistory: ip=84.184.54.226, fs=512765, da=201303745, mc=1, sc=0,
 hc=1, sp=0, fso=512765, re=0, sd=0, hd=0
X-PMX-Version: 6.4.9.2830568, Antispam-Engine: 2.7.2.2107409,
 Antispam-Data: 2024.1.27.235115, AntiVirus-Engine: 6.0.2,
 AntiVirus-Data: 2024.1.26.602001
X-IMT-Authenticated-Sender: kbastian@UNI-PADERBORN.DE
Received-SPF: pass client-ip=2001:638:502:c003::14;
 envelope-from=kbastian@mail.uni-paderborn.de; helo=collins.uni-paderborn.de
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Sameer,

On Tue, Apr 16, 2024 at 02:26:10PM -0400, Sameer Kalliadan Poyil wrote:
> Hi Bastian,
>
> Thanks for the information. I thought that I can do some prototyping before the
> HW arrives. :)
>
>  Yes I am interested for your bare metal program boot_to_main run it on TSIM.  
> Is Infineon TSIM free? I searched it and I didn't find any download link. Could
> you please give a link for that if it is from Infineon?

I usually get it from the free entry toolchain [1]

>
> s it(TSIM)  trace32 simulator ? https://repo.lauterbach.com/download_demo.html
> ?
>
> This page https://wiki.qemu.org/Documentation/Platforms/TriCore shows SCU is
> under development.

I should change that on the wiki. I was experimenting with a QEMU model for the
SCU when I was still in University, but nothing usable resulted from that. Now
my time for such developments is unfortunately limited :(.

>
> Could you let me know who is developing it ? is  it possible to take an
> existing SCU and modify according to AURIX data sheet? I see that UART is
> possible to for Tricore like the one developed for ARM versatile platform
>
> Here is the link https://mail.gnu.org/archive/html/qemu-devel/2016-10/msg04514.html

Sure, you can add a model of the Aurix UART in QEMU. It's "just" a matter of
putting in the time to implement its registers and functionality.

>
> I have aurix development trial version and able to compile a UART project using
> Tasking compiler and tried to run it on qemu, but I don't see any logs in the
> qemu terminal as you said there is no peripherals implemented
>
> qemu-system-tricore -machine KIT_AURIX_TC277_TRB -cpu tc27x -m 6M -nographic
> -kernel ASCLIN_Shell_UART_1_KIT_TC277_TFT.elf  -serial stdio -append "console=
> ttyAMA0 console=ttyS0"

I usually add '-d exec,cpu,nochain -D /tmp/exec.log -accel tcg,one-insn-per-tb=on'
to get an execution trace to see if the binary is executing.

You can also try attaching gdb by adding '-s -S' to the CLI. And then run in
tricore-gdb 'target remote localhost:1234' see [2]

>
>
> Also do you know if there is a virtual UART framework to communicate between
> two Qemu instances or two TSIM instances running similar OS or different OS? I
> need to do prototype testing RPMSg communication between  MCU and SOC using
> external physical UART/SPI which can be tested using vritual UART using two
> qemu instances. 

No, I don't know of something like this.

Cheers,
Bastian

[1] https://free-entry-toolchain.hightec-rt.com/
[2] https://www.qemu.org/docs/master/system/gdb.html

