Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D58BC43458
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 12:28:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weu34-0000wV-Ca; Wed, 01 Jul 2026 08:28:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1weu2z-0000w8-2P
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 08:28:09 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1weu2w-0008BU-AH
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 08:28:08 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id F218D596707;
 Wed, 01 Jul 2026 14:27:57 +0200 (CEST)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id j7y9Z7FpBiix; Wed,  1 Jul 2026 14:27:55 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id D1CFE596702; Wed, 01 Jul 2026 14:27:55 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id D0B9D5966FB;
 Wed, 01 Jul 2026 14:27:55 +0200 (CEST)
Date: Wed, 1 Jul 2026 14:27:55 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Chad Jablonski <chad@jablonski.xyz>
cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v3 2/7] ati-vga: Chip-specific register handlers
In-Reply-To: <20260606195216.2524314-3-chad@jablonski.xyz>
Message-ID: <f90d7774-452f-6df0-1805-9ae32923151f@eik.bme.hu>
References: <20260606195216.2524314-1-chad@jablonski.xyz>
 <20260606195216.2524314-3-chad@jablonski.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
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

On Sat, 6 Jun 2026, Chad Jablonski wrote:
> Move read and write register handlers to chip-specific functions so that
> register differences are defined in one place for each chip. This prepares
> for differences that occur in CCE setup.
>
> The only behavioral change is that the Rage 128 will now return 0 when
> reading the HOST_PATH_CNTL register. This is technically more correct in
> that the Rage 128 doesn't have this register.

I guess this does the move of the ifs as I suggested so that's OK but I 
could not review it yet. I think the remaining common function should be 
named common then to make this clear that it only contains common 
registers.

Regards,
BALATON Zoltan

