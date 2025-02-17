Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEEE5C02198
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 01:07:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjpao-0003k4-Ve; Sun, 16 Feb 2025 20:06:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pisa@fel.cvut.cz>) id 1tjpal-0003jW-8I
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 20:06:35 -0500
Received: from smtpx.feld.cvut.cz ([2001:718:2:1516::210:153]
 helo=smtpx.fel.cvut.cz)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_CHACHA20_POLY1305:256)
 (Exim 4.90_1) (envelope-from <pisa@fel.cvut.cz>) id 1tjpai-0007ot-Cs
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 20:06:34 -0500
Received: from localhost (unknown [192.168.200.27])
 by smtpx.fel.cvut.cz (Postfix) with ESMTP id 85461453B7;
 Mon, 17 Feb 2025 02:06:23 +0100 (CET)
X-Virus-Scanned: IMAP STYX AMAVIS
Received: from smtpx.fel.cvut.cz ([192.168.200.2])
 by localhost (cerokez-250.feld.cvut.cz [192.168.200.27]) (amavis, port 10060)
 with ESMTP id kyB4IIHV3tgN; Mon, 17 Feb 2025 02:06:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fel.cvut.cz;
 s=felmail; t=1739754170;
 bh=yi4STwWmcp44Wbln4NZOAd/RduLnEbwCM5Tsm5+qJZ0=;
 h=From:To:Subject:Date:Cc:References:In-Reply-To:From;
 b=FQdmRlroAQH7HAlFCq+84ZFMKTV/iIbD1fZqS0sFJAWmwUk5x2R5c7E27FCCW7m+J
 WMbY5k4CUtGYybSWeC/99D53YCUqtirCnRNrdD+igPEGJPkcD0tfJwb/TrTwCmRiuo
 VhksnGcSpKGL5uELvdleODaPU4STgIghusJ5T3qARzNdeuJWIFlXtlTefNZvmxdJCm
 w7Y6mExeSVuckOwzZq8UaAdYhmHpeyuthUdT6iDqJhp1We+KtMSzwjy23pvIdHsf18
 irg4m8h9YdAl/p9paql0VgDPQALISDPK/cszJn4VQVuf2qFwjorT8Y3g+ChK3VVuxc
 TOIN+Gp4nyNnw==
Received: from baree.pikron.com (static-84-242-78-234.bb.vodafone.cz
 [84.242.78.234])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: pisa)
 by smtpx.fel.cvut.cz (Postfix) with ESMTPSA id E33A0452DB;
 Mon, 17 Feb 2025 02:02:49 +0100 (CET)
From: Pavel Pisa <pisa@fel.cvut.cz>
To: Deniz Eren <deniz.eren@icloud.com>
Subject: Re: hw/net/can: PCI MSI suport for SJA1000 based addon card Was:
 [PATCH] hw/net/can: ... to meson build.
Date: Mon, 17 Feb 2025 02:03:01 +0100
User-Agent: KMail/1.9.10
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Marek Vasut <marex@denx.de>, Vikram Garhwal <vikram.garhwal@bytedance.com>,
 Jiri Novak <jnovak@fel.cvut.cz>, Stefan Hajnoczi <stefanha@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 Oleksij Rempel <o.rempel@pengutronix.de>,
 Frederic Konrad <frederic.konrad@adacore.com>,
 Jan Kiszka <jan.kiszka@siemens.com>,
 Jan Charvat <jancharvat.charvat@gmail.com>,
 Oliver Hartkopp <socketcan@hartkopp.net>,
 Ondrej Ille <ondrej.ille@gmail.com>,
 Francisco Iglesias <francisco.iglesias@amd.com>
References: <202009232013.52889.pisa@cmp.felk.cvut.cz>
 <3A8C14E4-3709-4866-B547-7AC621F5C368@icloud.com>
In-Reply-To: <3A8C14E4-3709-4866-B547-7AC621F5C368@icloud.com>
X-KMail-QuotePrefix: > 
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <202502170203.01317.pisa@fel.cvut.cz>
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2001:718:2:1516::210:153;
 envelope-from=pisa@fel.cvut.cz; helo=smtpx.fel.cvut.cz
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, NICE_REPLY_A=-2.533, SPF_HELO_NONE=0.001,
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

Hello Deniz,

On Saturday 15 of February 2025 14:30:58 Deniz Eren wrote:
> I have implemented support for PCI MSI capability CANbus card support;
> fully tested using QNX operating system guest image. How can I go about
> contributing this to the main repo:
>
> https://github.com/Deniz-Eren/qemu/blob/feature/can-sja100-pci-msi-suppor=
t/
>hw/net/can/can_pcm26d2ca_pci.c

the first thanks for information and work done.

I am replying to all addressees of your e-mail but if the others
do not respond, I suggest to limit and would limit the recipients
list only to me, other QEMU CAN subsystem maintainers:

  Francisco Iglesias <francisco.iglesias@amd.com>
  Vikram Garhwal <vikram.garhwal@bytedance.com>

QEMU list

  qemu-devel@nongnu.org

and some QEMU core developers who could accept the code
for mainline, my previous changes have been accepted
for mainline by one of the following developers

  Peter Maydell <peter.maydell@linaro.org>
  Michael Tokarev<mjt@tls.msk.ru>
  Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
  Paolo Bonzini <pbonzini@redhat.com>

The patches should be send in plain text format (git format-patch)
to qemu-devel@nongnu.org and me and other QEMU CAN maintainers.

As for the format and other details, look at=20

  https://www.qemu.org/docs/master/devel/submitting-a-patch.html

Check the source formating and basic requirements by

  scripts/checkpatch.pl

As for the actual changes you propose, I have looked
into your repository. I would like to discuss a little
changes to generic SJA1000 code

 =20
https://github.com/Deniz-Eren/qemu/commit/a2f593f21946328821f8456274c9c688d=
5f1c4de

Because my understanding is that the emulated board is some
Advantech board PCM-26D2CA

 =20
https://www.advantech.com/en/products/14263729-aaa3-4552-b990-99d16cdfee24/=
pcm-26d2ca/mod_9a1e9dbf-e22d-4770-a896-cecf40607084

which has PCIe MSI capable interface. The datasheet states
NXP SJA-1000 used as the controller. But I do not expect
that this chip allows distinguish interrupt source directly
to map it to PCIe MSI signal. So one option is complete controller
logic in FPGA, another is somehow read and map interrupt PeliCAN
register to MSI messages. But that mapping can be specific
to different boards and SJA1000 compatible controllers
implementations.

I am not sure if your code is prepared to make mapping
so generic.

In the fact, I am not sure if whole PCIe MSI details
should be pushed to the bare SJA1000 controller implementation.

I would suggest to think about option to register callback
for interrupt state update which would receive interrupt
register state as argument and move actual mapping to PCIe
MSI writes outside of the core SJA1000 implementation.

This way it could be mapped even to other bus technologies
which allows multiple even boxes per single addon
card/controller source. I can imagine VME for example
even that it probably not common today but even some
SoC with SJA1000 compatible CAN controller which maps
it to multiple interrupts.

We should discuse this probably within smaller group, me
and Francisco Iglesias and Vikram Garhwal with CC to
qemu-devel@nongnu.org and when we agree on the patche
series in the review process we should ask some
other QEMU developers to accept result for mainline.=20


Best wishes,

                Pavel
=2D-
                Pavel Pisa
    phone:      +420 603531357
    e-mail:     pisa@cmp.felk.cvut.cz
    Department of Control Engineering FEE CVUT
    Karlovo namesti 13, 121 35, Prague 2
    university: http://control.fel.cvut.cz/
    personal:   http://cmp.felk.cvut.cz/~pisa
    social:     https://social.kernel.org/ppisa
    projects:   https://www.openhub.net/accounts/ppisa
    CAN related:http://canbus.pages.fel.cvut.cz/
    RISC-V education: https://comparch.edu.cvut.cz/
    Open Technologies Research Education and Exchange Services
    https://gitlab.fel.cvut.cz/otrees/org/-/wikis/home

