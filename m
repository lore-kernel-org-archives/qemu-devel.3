Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4866FD4899E
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 12:56:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgjM9-0002Wb-Tv; Fri, 16 Jan 2026 07:55:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pisa@fel.cvut.cz>) id 1vgjM8-0002Vg-7M
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 07:55:12 -0500
Received: from smtpx.feld.cvut.cz ([147.32.210.153] helo=smtpx.fel.cvut.cz)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_CHACHA20_POLY1305:256)
 (Exim 4.90_1) (envelope-from <pisa@fel.cvut.cz>) id 1vgjM5-0007gV-N3
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 07:55:11 -0500
Received: from localhost (unknown [192.168.200.27])
 by smtpx.fel.cvut.cz (Postfix) with ESMTP id 2A36817555;
 Fri, 16 Jan 2026 13:55:00 +0100 (CET)
X-Virus-Scanned: IMAP STYX AMAVIS
Authentication-Results: cerokez-250.feld.cvut.cz (amavis);
 dkim=pass (2048-bit key) header.d=fel.cvut.cz
Received: from smtpx.fel.cvut.cz ([192.168.200.2])
 by localhost (cerokez-250.feld.cvut.cz [192.168.200.27]) (amavis, port 10060)
 with ESMTP id qgjJjWJeQbWI; Fri, 16 Jan 2026 13:54:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fel.cvut.cz;
 s=felmail; t=1768568098;
 bh=60pr++JoK1wwQqX6bIuJa/vQ3XwOsfgPp6nM5rP24g0=;
 h=From:To:Subject:Date:Cc:References:In-Reply-To:From;
 b=o25B046InVNNvWM73n6LsyxmzpGGfAFD8Mo7a2BfipQ8FfA+B4v97Nrhg3WbCftTy
 ZRU+DlCKY1SZS7axubmLylIXPdpDpgb3SCHiF1zaaXEnIAE5Luh4qlj5nmYz7Kwy64
 p8GFpQm8ST2d4FHQJHX8NhXdD2ZYiJiwdWF7+QZhSgn4mLket1+CpANGFqGLZI/xRP
 0nQ5KkEb7T6qty/7tUGk8GGZ3MKgsu+mZURKyD6AQ5xEZar07jKw12VhKEYvLcF1eD
 z3R9qSNWtIDgQLLGi6ZOUWLtCSHeC2CsYwrpFxHgHXaIpLTrEmbRQ52Hsds+a7AkKM
 giR7zW02uy3Fw==
Received: from baree.pikron.com (static-84-242-78-234.bb.vodafone.cz
 [84.242.78.234])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: pisa)
 by smtpx.fel.cvut.cz (Postfix) with ESMTPSA id 4B07817628;
 Fri, 16 Jan 2026 13:54:58 +0100 (CET)
From: Pavel Pisa <pisa@fel.cvut.cz>
To: Bernhard Beschow <shentey@gmail.com>
Subject: Re: [PATCH v1 3/6] hw/net/can/flexcan: NXP FlexCAN core emulation
Date: Fri, 16 Jan 2026 13:54:57 +0100
User-Agent: KMail/1.9.10
Cc: =?utf-8?q?Maty=C3=A1=C5=A1_Bobek?= <matyas.bobek@gmail.com>,
 qemu-devel@nongnu.org, Matyas Bobek <bobekmat@fel.cvut.cz>,
 "Marc Kleine-Budde" <mkl@pengutronix.de>,
 Oliver Hartkopp <socketcan@hartkopp.net>,
 Nikita Ostrenkov <n.ostrenkov@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <cover.1765826753.git.matyas.bobek@gmail.com>
 <f3cb3166-c3f8-4ed8-8c9a-cbf48b071d1e@gmail.com>
 <E5AC1F6B-EC35-4454-87BF-B95D162456C2@gmail.com>
In-Reply-To: <E5AC1F6B-EC35-4454-87BF-B95D162456C2@gmail.com>
X-KMail-QuotePrefix: > 
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <202601161354.57405.pisa@fel.cvut.cz>
Received-SPF: pass client-ip=147.32.210.153; envelope-from=pisa@fel.cvut.cz;
 helo=smtpx.fel.cvut.cz
X-Spam_score_int: -54
X-Spam_score: -5.5
X-Spam_bar: -----
X-Spam_report: (-5.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, NICE_REPLY_A=-1.229,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Dear Bernhard,

On Friday 16 of January 2026 10:53:24 Bernhard Beschow wrote:
> Am 2. Januar 2026 14:53:42 UTC schrieb Bernhard Beschow <shentey@gmail.co=
m>:
> >Am 15. Dezember 2025 20:03:12 UTC schrieb "Maty=C3=A1=C5=A1 Bobek"=20
<matyas.bobek@gmail.com>:
> >> This commit adds the FlexCAN2 emulator implementation and
> >> plugs it into Meson and Kconfig.
> >> FlexCAN2 version can be found in i.MX6 SoCs and others.
> >>
> >> More information about the implementation can be found in [1].
> >>
> >> [1]
> >> http://dspace.cvut.cz/bitstream/handle/10467/122654/F3-BP-2025-Bobek-M=
at
> >>yas-BP_Bobek_FlexCAN_final_4.pdf
> >>
> >> Signed-off-by: Maty=C3=A1=C5=A1 Bobek <matyas.bobek@gmail.com>
> >> ---
=2E..
> >Quite a lot of comments from my side, I hope you don'f feel intimidated!
> > I'm looking forward to seeing FlexCAN support upstreamed. If you have a=
ny
> > questions please feel free to ask.
>
> Ping
>
> Any help needed?
>
> Best regards,
> Bernhard

thanks for thorough review of the patches and suggestions.
We have discussed feedback with Matyas Bobek and he plans to follow
suggestions. But the courses final project reviews week and then
the exam period have started at our university after Christmas
and he needs to submit more projects and prepare and pass exams,
so this is the priority for now. He would inform you himself
soon.

The another topic, there will be Linux Plumbers Conference
and Open Source Summit in Prague in October 2026.
So if there is interrest there is option to meet and even
to negotiate some room for some collocated meeting
at the university. For me, embedded systems emulation in QEMU,
CAN, CAN FD, motion control, realtime and RISC-V in education
and real missions are of my interrest.
We can even try to submit something for conference when CfP
is open.

Best wishes,

                Pavel

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


=20

