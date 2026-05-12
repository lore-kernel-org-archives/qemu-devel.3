Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A1E7CD343F
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 22:30:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMvc6-0006iS-0F; Tue, 12 May 2026 18:30:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1wMvc3-0006gd-EN; Tue, 12 May 2026 18:30:03 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1wMvc0-0006QC-Sy; Tue, 12 May 2026 18:30:03 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 8796A596968;
 Wed, 13 May 2026 00:29:53 +0200 (CEST)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id 7whA131R2ZnL; Wed, 13 May 2026 00:29:48 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 6804A596964; Wed, 13 May 2026 00:29:48 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 62C265968DC;
 Wed, 13 May 2026 00:29:48 +0200 (CEST)
Date: Wed, 13 May 2026 00:29:48 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Michael Tokarev <mjt@tls.msk.ru>
cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org
Subject: Re: [Stable-11.0.1 00/58] Patch Round-up for stable 11.0.1, freeze
 on 2026-05-22
In-Reply-To: <qemu-stable-11.0.1-20260512235518@cover.tls.msk.ru>
Message-ID: <b9c4df60-8b75-cf1a-7cb5-c32a31dbf5b8@eik.bme.hu>
References: <qemu-stable-11.0.1-20260512235518@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
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

On Tue, 12 May 2026, Michael Tokarev wrote:
> The following patches are queued for QEMU stable v11.0.1:
>
>  https://gitlab.com/qemu-project/qemu/-/commits/staging-11.0
>
> Patch freeze is 2026-05-22, and the release is planned for 2026-05-24:
>
>  https://wiki.qemu.org/Planning/11.0
>
> Please respond here or CC qemu-stable@nongnu.org on any additional patches
> you think should (or shouldn't) be included in the release.

I also hoped to include the ati-vga: fix ati_set_dirty address calculation 
patch that is currently in the v2 Misc HW patches for 2026-05-12 PULL 
request from Philippe that will hopefully be merged in master in time for 
11.0.1 too.

Regards,
BALATON Zoltan

