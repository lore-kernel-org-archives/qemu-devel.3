Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18BEEC4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2024 11:53:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwKsa-0004tB-GL; Mon, 15 Apr 2024 07:52:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1rwKsX-0004sv-VO; Mon, 15 Apr 2024 07:52:05 -0400
Received: from zuban.uni-paderborn.de ([2001:638:502:c003::17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1rwKsV-0007gR-JO; Mon, 15 Apr 2024 07:52:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=mail.uni-paderborn.de; s=20170601; h=In-Reply-To:Content-Transfer-Encoding:
 Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
 Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ZEv6pt2zfAJw5FAQ8hNxYKZOOXI6teIJ/abYr3+Tzho=; b=O78pVs8s6aGJfu3M1n86RvDEZu
 KFMgt0b+KDSI4hFejjqb1UpBhm7p2pSopswqBcHFfJkkzsWyfzWUgWf8uwuGQ8coM5Rruau0TGHc/
 wuNcfWxSXI2ijYv6UE9mI5oEDEeKFAmC1okLOeiQvQXNlW6pkXNd5OqC6yw2dixMdaNo=;
Date: Mon, 15 Apr 2024 13:51:54 +0200
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Sameer Kalliadan Poyil <sameer.kp.in@gmail.com>, 
 qemu-discuss@nongnu.org, qemu-devel@nongnu.org
Subject: Re: Qemu for TC377
Message-ID: <gqzmd4roytmeq3hbtb4b4frhomqtcn4aje4wja7bwmbrvb5dfh@oumkvbg3uah3>
References: <CAAA2AK8p=RtqeNZXfnqprw+kqEBTvrQo1Va81+ctfYAT6k6jnA@mail.gmail.com>
 <07e79630-7171-4cb5-829d-a87a8165adc5@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <07e79630-7171-4cb5-829d-a87a8165adc5@linaro.org>
X-IMT-rspamd-score: 8
X-IMT-Spam-Score: 0.0 ()
X-PMX-Version: 6.4.9.2830568, Antispam-Engine: 2.7.2.2107409,
 Antispam-Data: 2024.1.27.235115, AntiVirus-Engine: 6.0.2,
 AntiVirus-Data: 2024.1.26.602001
X-IMT-Authenticated-Sender: kbastian@UNI-PADERBORN.DE
Received-SPF: pass client-ip=2001:638:502:c003::17;
 envelope-from=kbastian@mail.uni-paderborn.de; helo=zuban.uni-paderborn.de
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
On Sun, Apr 14, 2024 at 06:15:56PM +0200, Philippe Mathieu-Daudé wrote:
> Hi Sameer,
> 
> On 13/4/24 14:52, Sameer Kalliadan Poyil wrote:
> > Hello All,
> > I see that Latest qemu supports for tricore TC277 and TC377
> > image.png
> > But when I downloaded source code and checked for TC377 related file , I
> > didn't find anything
> > 
> > I want to run RTOS/bare metal code on TC377 . could you please let me
> > know how to start qemu on TC377 ?
> > Here is the latest version of qemu i have , I didn't download 9.0
> 
> $ qemu-system-tricore -cpu help
> Available CPUs:
>   tc1796
>   tc1797
>   tc27x
>   tc37x
> $
> 
> Try 'qemu-system-tricore -machine KIT_AURIX_TC277_TRB -cpu tc37x',
> this should start a TC377 SoC on an AURIX board (~KIT_A2G_TC377_TRB).

This is the closest you will get to TC377 board. 

I'm not sure if QEMU is the best choice for you, if you want run a RTOS, as
qemu-system-tricore is lacking:

- peripherals like SCU, SystemTimer that are a bare minimum to run a RTOS

- Simulation of time: When your RTOS runs periodic tasks you might get wrong
  results, as QEMU does not simulate time accurately. The real CPU would
  see time pass differently than QEMU. We make a best guess using the wall time.

I think for now Infineons TSIM is a better choice, as it does not lack the
points above. However it has significantly less performance compared to QEMU.

If you are only interested in running bare metal software, check out my
'boot_to_main' test [1]. The Makefile [2] shows you how to build it using
tricore-gcc [3] and how to run it in QEMU. Also tricore-gdb [4] might be
interesting for you.

If you have further questions, feel free to ask me.

Cheers,
Bastian

[1] https://gitlab.com/qemu-project/qemu/-/blob/master/tests/tcg/tricore/c/test_boot_to_main.c?ref_type=heads
[2] https://gitlab.com/qemu-project/qemu/-/blob/master/tests/tcg/tricore/Makefile.softmmu-target?ref_type=heads
[3] https://github.com/bkoppelmann/package_494
[4] https://github.com/volumit/gdb-tricore

