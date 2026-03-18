Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DD291088E50
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 23:19:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w309W-000649-J9; Wed, 18 Mar 2026 19:18:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1w309U-000640-Qp
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 19:18:12 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1w309S-0004Ix-GU
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 19:18:12 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 5861F596A13;
 Thu, 19 Mar 2026 00:18:07 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id EoGlfMW_Xgcx; Thu, 19 Mar 2026 00:18:05 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 02102596A42; Thu, 19 Mar 2026 00:18:05 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 0044A5969F3;
 Thu, 19 Mar 2026 00:18:04 +0100 (CET)
Date: Thu, 19 Mar 2026 00:18:04 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Michael Roth <michael.roth@amd.com>
cc: qemu-devel@nongnu.org, peter.maydell@linaro.org
Subject: Re: [ANNOUNCE] QEMU 11.0.0-rc0 is now available
In-Reply-To: <mqiddietxtens5beqoev3dekswknitwtrsggyb6jj4a7h6qzkk@kpbhzzl2mq6b>
Message-ID: <a45225b9-4116-70cc-b08a-adc60d6f9ce1@eik.bme.hu>
References: <mqiddietxtens5beqoev3dekswknitwtrsggyb6jj4a7h6qzkk@kpbhzzl2mq6b>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Wed, 18 Mar 2026, Michael Roth wrote:
> Please add entries to the ChangeLog for the 11.0 release below:
>
>  http://wiki.qemu.org/ChangeLog/11.0

I don't know if this was updated already but it says:

"The pc-i440fx-2.6, pc-q35-2.6, pc-i440fx-2.7 and pc-q35-2.7 machines have 
been removed."

$ qemu-system-x86_64 -M help
Supported machines are:
microvm              microvm (i386)
pc-i440fx-9.2        Standard PC (i440FX + PIIX, 1996)
pc-i440fx-9.1        Standard PC (i440FX + PIIX, 1996)
pc-i440fx-9.0        Standard PC (i440FX + PIIX, 1996)
pc-i440fx-8.2        Standard PC (i440FX + PIIX, 1996)
pc-i440fx-8.1        Standard PC (i440FX + PIIX, 1996)
pc-i440fx-8.0        Standard PC (i440FX + PIIX, 1996) (deprecated)
pc-i440fx-7.2        Standard PC (i440FX + PIIX, 1996) (deprecated)
pc-i440fx-7.1        Standard PC (i440FX + PIIX, 1996) (deprecated)
pc-i440fx-7.0        Standard PC (i440FX + PIIX, 1996) (deprecated)
pc-i440fx-6.2        Standard PC (i440FX + PIIX, 1996) (deprecated)
pc-i440fx-6.1        Standard PC (i440FX + PIIX, 1996) (deprecated)
pc-i440fx-6.0        Standard PC (i440FX + PIIX, 1996) (deprecated)
pc-i440fx-5.2        Standard PC (i440FX + PIIX, 1996) (deprecated)
pc-i440fx-5.1        Standard PC (i440FX + PIIX, 1996) (deprecated)
pc                   Standard PC (i440FX + PIIX, 1996) (alias of pc-i440fx-11.0)
pc-i440fx-11.0       Standard PC (i440FX + PIIX, 1996) (default)
pc-i440fx-10.2       Standard PC (i440FX + PIIX, 1996)
pc-i440fx-10.1       Standard PC (i440FX + PIIX, 1996)
pc-i440fx-10.0       Standard PC (i440FX + PIIX, 1996)
[...]

so from the user's point of view much more was already removed due to 
auto deprecation.

Heading says:
"New deprecated options and features"
content talks about new featurs not newly deprecated ones.

Regards,
BALATON Zoltan

