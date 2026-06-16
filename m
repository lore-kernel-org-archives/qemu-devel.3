Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B45EECD98D2
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 23:56:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZde5-00010j-Dx; Tue, 16 Jun 2026 19:56:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1wZde3-00010M-3j
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 19:56:39 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1wZde1-0007Ur-F6
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 19:56:38 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 65A195969AE;
 Wed, 17 Jun 2026 01:56:33 +0200 (CEST)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id SDFUDKtLyeei; Wed, 17 Jun 2026 01:56:31 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 424C8596944; Wed, 17 Jun 2026 01:56:31 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 409F459697F;
 Wed, 17 Jun 2026 01:56:31 +0200 (CEST)
Date: Wed, 17 Jun 2026 01:56:31 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
cc: Harry van Haaren | OPENCHIP <harry.vanhaaren@openchip.com>, 
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, 
 "alex.bennee@linaro.org" <alex.bennee@linaro.org>, 
 "erdnaxe@crans.org" <erdnaxe@crans.org>
Subject: Re: [PATCH 1/2] plugins/execlog: fix segfault/race-cond on per-vCPU
 structures
In-Reply-To: <ab967bbb-7961-4450-bdb9-06b9db905d2d@oss.qualcomm.com>
Message-ID: <d06786e4-d4b2-8acb-18f7-9273f59e1746@eik.bme.hu>
References: <20260616161242.267315-1-harry.vanhaaren@openchip.com>
 <ab967bbb-7961-4450-bdb9-06b9db905d2d@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
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

On Tue, 16 Jun 2026, Pierrick Bouvier wrote:
> On 6/16/2026 9:12 AM, Harry van Haaren | OPENCHIP wrote:
>> From: Harry van Haaren <harry.vanhaaren@openchip.com>
>>
>
> No needed for this From: tag since you are already the sender and have a
> signed-off-by.

But the message From: field has "| OPENCHIP" in the name which I think is 
intended to be removed by this tag so it's OK to have it. If it was the 
same as the From: field of the message it would not be needed indeed.

Regards,
BALATON Zoltan

