Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5820EE67818
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Nov 2024 23:09:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7NEQ-0006aG-Ca; Sat, 02 Nov 2024 19:08:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1t7NEO-0006ZF-GT; Sat, 02 Nov 2024 19:08:32 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1t7NEM-0004Im-8m; Sat, 02 Nov 2024 19:08:32 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id D4FC54E6013;
 Sun, 03 Nov 2024 00:08:24 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id BP9atBylY8Od; Sun,  3 Nov 2024 00:08:22 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id DFAC34E6001; Sun, 03 Nov 2024 00:08:22 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id DD310757B1C;
 Sun, 03 Nov 2024 00:08:22 +0100 (CET)
Date: Sun, 3 Nov 2024 00:08:22 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Corey Minyard <corey@minyard.net>
cc: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org, 
 Nicholas Piggin <npiggin@gmail.com>, qemu-block@nongnu.org, 
 Bin Meng <bmeng.cn@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, 
 Jason Wang <jasowang@redhat.com>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 =?ISO-8859-15?Q?C=E9dric_Le_Goater?= <clg@redhat.com>, 
 Alex Williamson <alex.williamson@redhat.com>, qemu-ppc@nongnu.org, 
 Corey Minyard <cminyard@mvista.com>
Subject: Re: [PATCH v3 11/26] hw/i2c/mpc_i2c: Convert DPRINTF to trace events
 for register access
In-Reply-To: <ZyZgjZMmqy2WHqip@mail.minyard.net>
Message-ID: <f8a83ecd-a768-c648-d790-feb1e0b112a4@eik.bme.hu>
References: <20241102131715.548849-1-shentey@gmail.com>
 <20241102131715.548849-12-shentey@gmail.com>
 <ZyZgjZMmqy2WHqip@mail.minyard.net>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="3866299591-244082438-1730588902=:3552"
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-244082438-1730588902=:3552
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Sat, 2 Nov 2024, Corey Minyard wrote:
> On Sat, Nov 02, 2024 at 02:17:00PM +0100, Bernhard Beschow wrote:
>> Reviewed-by: Cédric Le Goater <clg@redhat.com>
>> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
>
> Signed-off-by: Corey Minyard <cminyard@mvista.com>

Did you mean Reviewed-by or was it your patch that Bernhard picked up?

Regards,
BALATON Zoltan
--3866299591-244082438-1730588902=:3552--

