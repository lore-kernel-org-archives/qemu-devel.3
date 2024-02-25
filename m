Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0535AC54E49
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Feb 2024 23:29:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reNvO-0001RS-3r; Sun, 25 Feb 2024 18:28:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-christophe@blues-softwares.net>)
 id 1reNvD-0001R1-WE
 for qemu-devel@nongnu.org; Sun, 25 Feb 2024 18:28:40 -0500
Received: from mx.franceserv.fr ([62.4.19.99])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-christophe@blues-softwares.net>)
 id 1reNv9-0004Z7-AI
 for qemu-devel@nongnu.org; Sun, 25 Feb 2024 18:28:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=blues-softwares.net;
 s=fsh1; t=1708903713;
 bh=aNpkYosjk4eIhsCqJoWZGHg3jmLsFHv/j1UEpSsgWWc=;
 h=Subject:From:To:Date:From;
 b=tuxI51KPi4Pv7ujpDUcf4Girc22qJEQG276UfyOhuSQZkJLAYX6xzM/2TTJk3i5Pt
 pzyATUyB4vLVzW+3cq2KJdYDG8tzmbKzEkFopm2VG2svAE2Lc7tIZxjJ5ty2i2Oy3w
 Tou09faV8NK9+H7sV5GIQgDSEdVEh9AlPAtF7A2NEKOjTBfdPMMWyb1kovR+rx04sm
 Em9hfFrZOB6nEieIjvIIJifJetIyEjM7CTCnm6SU/pcl+JdYAZp39BcQfwRGEYto5D
 kNpJlkSBg4+GhzX4Bfq02PXPn7WYJk5Nfc9Vz2fczZlSkFl5mvNsGFzhpMC7WCKdz1
 iSNQbywa/1sEQ==
Message-ID: <03553894ee4f79b3f63979a9e9ac87e635c75933.camel@blues-softwares.net>
Subject: support on risc-v 128bits
From: Jean-Christophe =?ISO-8859-1?Q?=C9n=E9e?=
 <jean-christophe@blues-softwares.net>
To: qemu-devel@nongnu.org
Date: Mon, 26 Feb 2024 00:28:31 +0100
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.50.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Abuse-Reports-To: abuse@franceserv.fr
X-Spamd-Bar: /
Received-SPF: pass client-ip=62.4.19.99;
 envelope-from=jean-christophe@blues-softwares.net; helo=mx.franceserv.fr
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

hi,
i would like developpe my OS on risc-v 128 bits.
after search the support isn´t fully operational

how can i help, and in the same learn risc-v 128 bits

my coding skill is beginner, but i motivate and i learn spead. i'm
waiting the complete guide of C to delanoy

can you give me simple task for begin ? peraps document
best regard,
jean-christophe

P.S. why your ndd is nongnu.org ?

