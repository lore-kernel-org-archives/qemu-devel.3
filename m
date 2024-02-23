Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AF76C5478C
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 12:25:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdUbj-0006rT-Ig; Fri, 23 Feb 2024 07:24:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pisa@cmp.felk.cvut.cz>)
 id 1rdUaX-0006L9-8k; Fri, 23 Feb 2024 07:23:37 -0500
Received: from smtpx.feld.cvut.cz ([147.32.210.153] helo=smtpx.fel.cvut.cz)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_CHACHA20_POLY1305:256)
 (Exim 4.90_1) (envelope-from <pisa@cmp.felk.cvut.cz>)
 id 1rdUaV-00006o-6J; Fri, 23 Feb 2024 07:23:37 -0500
Received: from localhost (unknown [192.168.200.27])
 by smtpx.fel.cvut.cz (Postfix) with ESMTP id 0C61D3AD52;
 Fri, 23 Feb 2024 13:23:23 +0100 (CET)
X-Virus-Scanned: IMAP STYX AMAVIS
Received: from smtpx.fel.cvut.cz ([192.168.200.2])
 by localhost (cerokez-250.feld.cvut.cz [192.168.200.27]) (amavis, port 10060)
 with ESMTP id nXzd0wcDCi4W; Fri, 23 Feb 2024 13:23:22 +0100 (CET)
Received: from baree.pikron.com (ip-78-102-109-231.bb.vodafone.cz
 [78.102.109.231])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: pisa)
 by smtpx.fel.cvut.cz (Postfix) with ESMTPSA id 959EB3ABD4;
 Fri, 23 Feb 2024 13:23:21 +0100 (CET)
To: Francisco Iglesias <francisco.iglesias@amd.com>
Subject: Re: [PATCH 16/21] hw/net/can/versal: Prefer object_initialize_child
 over object_initialize
Date: Fri, 23 Feb 2024 13:23:49 +0100
User-Agent: KMail/1.9.10
Cc: "Philippe =?utf-8?q?Mathieu-Daud=C3=A9?=" <philmd@linaro.org>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-s390x@nongnu.org,
 qemu-ppc@nongnu.org, qemu-block@nongnu.org,
 Vikram Garhwal <fnu.vikram@xilinx.com>, Jason Wang <jasowang@redhat.com>
References: <20240216110313.17039-1-philmd@linaro.org>
 <20240216110313.17039-17-philmd@linaro.org>
 <9f3cb497-d49c-4a35-b365-847ae1b60b08@amd.com>
In-Reply-To: <9f3cb497-d49c-4a35-b365-847ae1b60b08@amd.com>
X-KMail-QuotePrefix: > 
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <202402231323.49183.pisa@cmp.felk.cvut.cz>
Received-SPF: none client-ip=147.32.210.153;
 envelope-from=pisa@cmp.felk.cvut.cz; helo=smtpx.fel.cvut.cz
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, KHOP_HELO_FCRDNS=0.257,
 NICE_REPLY_A=-2.533, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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
Reply-to:  Pavel Pisa <pisa@cmp.felk.cvut.cz>
From:  Pavel Pisa via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Friday 23 of February 2024 12:06:34 Francisco Iglesias wrote:
> On 2024-02-16 12:03, Philippe Mathieu-Daud=C3=A9 wrote:
> > When the QOM parent is available, prefer object_initialize_child()
> > over object_initialize(), since it create the parent relationship.
> >
> > Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>
> Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>

Reviewed-by: Pavel Pisa <pisa@cmp.felk.cvut.cz>

