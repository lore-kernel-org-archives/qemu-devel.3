Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9418C43458
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jul 2026 14:20:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiv2p-0000BE-63; Sun, 12 Jul 2026 10:20:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth+qemu@posteo.eu>)
 id 1wiv2m-0000Ar-Tz
 for qemu-devel@nongnu.org; Sun, 12 Jul 2026 10:20:32 -0400
Received: from mout01.posteo.de ([185.67.36.65])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth+qemu@posteo.eu>)
 id 1wiv2j-0000VB-PX
 for qemu-devel@nongnu.org; Sun, 12 Jul 2026 10:20:32 -0400
Received: from submission (posteo.de [185.67.36.169]) 
 by mout01.posteo.de (Postfix) with ESMTPS id 1EB68240027
 for <qemu-devel@nongnu.org>; Sun, 12 Jul 2026 16:20:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.eu;
 s=1984.8680eb; t=1783866027;
 bh=6KwDOECpo/0liihAJYga30ayba+aWphtaUbJh/2XdRY=;
 h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
 Content-Transfer-Encoding:From;
 b=V9vs/WwGGSXibXru0GsbSahU/R5WqY4Z0spyJg/i5CyXWDT28yMg9PtHBFyFw4eq6
 O6FdLhwKWj6pk8+xBazNXQ9imqG5azRSKDDfvqydQiAChVTRBTyf58K4LPm8caCG5a
 D4UMXimzOX6LHj8lgpqqSV0EIaWpe3EWv4ioWqRP7tEbO3cEhT/1PNrZg68FPDQe67
 n7YAkYGEyqh6+0GDj3HthyhIAZP3gowdeOoZAwpItXtrVqZxEomWlHXce35UXZPoh5
 Nqtlw++mLyesTq4PpzjrhKOgJ4oAkei7wrKSxqQVKJ/nk9VOHScqPpa2igph+7J+uL
 dqBzLntYD4E5A==
Received: from customer (localhost [127.0.0.1])
 by submission (posteo.de) with ESMTPSA id 4gynld1kGbz6tvm;
 Sun, 12 Jul 2026 16:20:13 +0200 (CEST)
Date: Sun, 12 Jul 2026 14:20:23 +0000
From: Thomas Huth <th.huth+qemu@posteo.eu>
To: Alexander Graf <graf@amazon.com>
Cc: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>, <qemu-ppc@nongnu.org>,
 <qemu-riscv@nongnu.org>, <qemu-s390x@nongnu.org>, Song Gao
 <17746591750@163.com>, Aditya Gupta <adityag@linux.ibm.com>, Alexey
 Kardashevskiy <aik@ozlabs.ru>, Farhan Ali <alifm@linux.ibm.com>, Alistair
 Francis <alistair.francis@wdc.com>, "Alistair Francis"
 <alistair@alistair23.me>, Antony Pavlov <antonynpavlov@gmail.com>, Markus
 Armbruster <armbru@redhat.com>, Artyom Tarasenko <atar4qemu@gmail.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, Felipe Balbi <balbi@kernel.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, "Brian Cain"
 <brian.cain@oss.qualcomm.com>, Hendrik Brueckner <brueckner@linux.ibm.com>,
 Chao Liu <chao.liu@processmission.com>, "Huacai Chen"
 <chenhuacai@kernel.org>, =?UTF-8?B?Q2zDqW1lbnQ=?= Chigot
 <chigot@adacore.com>, =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>,
 Helge Deller <deller@gmx.de>, Dorjoy Chowdhury <dorjoychy111@gmail.com>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>, Alexandre Iooss
 <erdnaxe@crans.org>, Eric Farman <farman@linux.ibm.com>, Francisco Iglesias
 <francisco.iglesias@amd.com>, Gaurav Sharma <gaurav.sharma_7@nxp.com>,
 "Gautam Gala" <ggala@linux.ibm.com>, Harsh Prateek Bora
 <harshpb@linux.ibm.com>, =?UTF-8?B?SGVydsOp?= Poussineau
 <hpoussin@reactos.org>, Jan Kiszka <jan.kiszka@web.de>, Max Filippov
 <jcmvbkbc@gmail.com>, Joel Stanley <joel@jms.id.au>, Jared Rossi
 <jrossi@linux.ibm.com>, Tyrone Ting <kfting@nuvoton.com>, Frederic Konrad
 <konrad.frederic@yahoo.fr>, "Laurent Vivier" <laurent@vivier.eu>, Manos
 Pitsidianakis <manos.pitsidianakis@linaro.org>, Bibo Mao
 <maobibo@loongson.cn>, "Mark Cave-Ayland" <mark.cave-ayland@ilande.co.uk>,
 Glenn Miles <milesg@linux.ibm.com>, Matthew Rosato
 <mjrosato@linux.ibm.com>, "Michael Rolnik" <mrolnik@gmail.com>, "Michael S
 . Tsirkin" <mst@redhat.com>, "Niek Linnenbank" <nieklinnenbank@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Halil Pasic <pasic@linux.ibm.com>, "Paolo Bonzini" <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Philippe =?UTF-8?B?TWF0aGlldS1E?=
 =?UTF-8?B?YXVkw6k=?= <philmd@mailo.com>, "Pierrick Bouvier"
 <pierrick.bouvier@oss.qualcomm.com>, Richard Henderson
 <richard.henderson@linaro.org>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>,
 Samuel Tardieu <sam@rfc1149.net>, Bernhard Beschow <shentey@gmail.com>,
 Stafford Horne <shorne@gmail.com>, Sergio Lopez <slp@redhat.com>,
 "Subbaraya Sundeep" <sundeep.lkml@gmail.com>, "Ran Wang"
 <wangran@bosc.ac.cn>, Hao Wu <wuhaotsh@google.com>, "Daniel P .
 =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>
Subject: Re: [RFC PATCH 097/134] hw/m68k: Give memory regions an explicit owner
Message-ID: <20260712162012.4c620021@tpx1>
In-Reply-To: <20260711223707.42139-98-graf@amazon.com>
References: <20260711223707.42139-1-graf@amazon.com>
 <20260711223707.42139-98-graf@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=185.67.36.65; envelope-from=th.huth+qemu@posteo.eu;
 helo=mout01.posteo.de
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Am Sat, 11 Jul 2026 22:36:30 +0000
schrieb Alexander Graf <graf@amazon.com>:

> Convert memory_region_init*() calls that pass NULL owner to pass
> the enclosing machine or device instead.
> 
> Thread Object *owner through the static mcf5208_sys_init() helper. mcf5206_mbar_realize() already has DeviceState *dev in scope.
> 
> No functional change intended.
> 
> Assisted-by: Kiro
> Signed-off-by: Alexander Graf <graf@amazon.com>
> ---
>  hw/m68k/an5206.c    |  2 +-
>  hw/m68k/mcf5206.c   |  2 +-
>  hw/m68k/mcf5208.c   | 15 ++++++++-------
>  hw/m68k/next-cube.c | 10 +++++-----
>  hw/m68k/q800.c      | 10 +++++-----
>  5 files changed, 20 insertions(+), 19 deletions(-)

For the coldfire and next-cube machine:

Reviewed-by: Thomas Huth <th.huth+qemu@posteo.eu>

q800 is a versioned machine type, though, so I hope Laurent can give some
guidance here whether it's ok to change the QOM tree here or not with
regards to migration.

 Thomas

