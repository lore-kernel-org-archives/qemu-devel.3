Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0A3BC83F1D
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Jul 2025 10:58:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZoyx-00005L-VI; Thu, 10 Jul 2025 06:58:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pisa@fel.cvut.cz>) id 1uZoyo-0008V7-SA
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 06:58:18 -0400
Received: from smtpx1.feld.cvut.cz ([147.32.210.191])
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_CHACHA20_POLY1305:256)
 (Exim 4.90_1) (envelope-from <pisa@fel.cvut.cz>) id 1uZoyk-0001Js-V7
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 06:58:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fel.cvut.cz;
 s=felmail; t=1752145085;
 bh=KHaMv2A82P8hXXcxeUGG0boA7OJbF2ER1x9Qhwb2VCk=;
 h=From:To:Subject:Date:Cc:From;
 b=kIbb5sVo8ucIIs5FSPjh3iESTeFJo2MGKJqrgeseZl/PSo1R2411Vnndo6UrZLCz6
 7iDik6mdqFWq7YA71gQlzWx7t1hscY8N0b8AVI6Xgzh+tjz5mkPhNIoulZQ901g0Ck
 tE8kK50q6WaEJHj1DVkly9sxvNIZBP/j05LO0GBNMsPVf0AqQ65sT0HNPX9f+/OR3+
 3BJcb2GW1QEAhXnxuyPu2WaOeUNZ5ZN73IySSs/NnZWxq8LxV+xBOBwdD9vn0YQRcW
 6y1kMz8w5ltDLipdet9IqTm7kKclNRLIVbVDZzqpD6rx88G4lDKTWs3lj0r6hSyiEs
 qqWL1y+xc9aOA==
Received: from smtpx.fel.cvut.cz (smtpx.feld.cvut.cz [147.32.210.153])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtpx1.feld.cvut.cz (Postfix) with ESMTPS id F18D826897;
 Thu, 10 Jul 2025 12:58:04 +0200 (CEST)
Received: from localhost (unknown [192.168.200.27])
 by smtpx.fel.cvut.cz (Postfix) with ESMTP id EE67817506;
 Thu, 10 Jul 2025 12:58:04 +0200 (CEST)
X-Virus-Scanned: IMAP STYX AMAVIS
Authentication-Results: cerokez-250.feld.cvut.cz (amavis);
 dkim=pass (2048-bit key) header.d=fel.cvut.cz
Received: from smtpx.fel.cvut.cz ([192.168.200.2])
 by localhost (cerokez-250.feld.cvut.cz [192.168.200.27]) (amavis, port 10060)
 with ESMTP id Dkda87WogQc5; Thu, 10 Jul 2025 12:58:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fel.cvut.cz;
 s=felmail; t=1752145082;
 bh=KHaMv2A82P8hXXcxeUGG0boA7OJbF2ER1x9Qhwb2VCk=;
 h=From:To:Subject:Date:Cc:From;
 b=Wox0yKR2hWUdv6vy3LXEE07j3pb4mfJmePMxaKsFpbdgjFM+G70l2RyMZJHWtnZtX
 be8aCjLygrJQiJ+yY/69ijG4k/wW5sgO5xw3+nWUxhQiFSXt46kPWF2RaT5OyuD78L
 jqWL7pvOSXlkhWMhX5AHQ0/hIMy7YObkdg85BtYwQCaAam6TxqJyXfASrgZTRdNo0V
 roBsMAgUGYqH9LnWHb2jjbgIAku1IDltNQWmtiy1hih7o/x6jFurVy+bpNdYZOKAm3
 e6m9X+Lq1vS7UgtYsiOKkescUZPKXSry50AmsqrD+cXalUJij0uKcxTpN2pZsSCruA
 vqcTEgas7Slgw==
Received: from baree.pikron.com (static-84-242-78-234.bb.vodafone.cz
 [84.242.78.234])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: pisa)
 by smtpx.fel.cvut.cz (Postfix) with ESMTPSA id 8E0D317423;
 Thu, 10 Jul 2025 12:58:01 +0200 (CEST)
From: Pavel Pisa <pisa@fel.cvut.cz>
To: "Marc Kleine-Budde" <mkl@pengutronix.de>
Subject: i.MX6 SabreLite FlexCAN emulation for QEMU progress/working
Date: Thu, 10 Jul 2025 12:58:05 +0200
User-Agent: KMail/1.9.10
Cc: Matyas Bobek <bobekmat@fel.cvut.cz>,
 Oliver Hartkopp <socketcan@hartkopp.net>, qemu-devel@nongnu.org,
 Nikita Ostrenkov <n.ostrenkov@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <202507101258.05760.pisa@fel.cvut.cz>
Received-SPF: pass client-ip=147.32.210.191; envelope-from=pisa@fel.cvut.cz;
 helo=smtpx1.feld.cvut.cz
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Hello Marc and others,

Matyas Bobek has implemented FlexCAN emulation for i.MX6
targets in the frame of his bachelor thesis

  https://dspace.cvut.cz/bitstream/handle/10467/122654/F3-BP-2025-Bobek-Matyas-BP_Bobek_FlexCAN_final_4.pdf

with reviews there

  https://dspace.cvut.cz/handle/10467/122779

Please, if you have problems to access documents, try that later,
our large archive with theses and publications is under
"AI" scrape-bots attacks almost permanently... or send me note
and I send the document directly.

The project continues and on base of Marc Kleine-Budde
review, Matyas Bobek has implemented timestamping
which should ensure correct messages ordering
even if FIFO mode is not used in the drivers,
Linux driver default case. There is even workaround
to advance timestamp if the the QEMU virtual time
is too coarse to provide unique values for for
too fast delivered messages through virtual bus
without real bits serialization.

The actual code is available on the "flexcan"
branch of the repository

  https://gitlab.fel.cvut.cz/bobekmat/qemu-flexcan

The clean, minimal patches sequence will be prepared
for review for the proposal for inclusion into QEMU
mainline, hopefully soon.

In longer term perspective, I have interrest in i.MX8
and other FlexCAN variants with FD support, etc.
I do not know if Mr. Bobek will have time and interest
to continue in this direction. I can offer that as the
another thesis or can offer that as summer job
etc. But latter would need some funding for students
motivation and their time compensation and I have had
never and do not have any QEMU related project for such
funding now and even minimal chance is even in future
for other than CTU CAN FD IP core where we support
silicon and FPGA products. So no timing, chances,
estimates for something beyond i.MX6 FlexCAN. 

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

