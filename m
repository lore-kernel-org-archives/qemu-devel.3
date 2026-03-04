Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6791AEFCE22
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 23:40:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxvoZ-00013y-7S; Wed, 04 Mar 2026 18:39:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vxvoX-00013k-B4
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 18:39:37 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vxvoV-0004cz-2A
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 18:39:36 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 950D5596D98;
 Thu, 05 Mar 2026 00:39:30 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id OGOjeCctJBtj; Thu,  5 Mar 2026 00:39:28 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 7EF65596D9B; Thu, 05 Mar 2026 00:39:28 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 7D292596D9D;
 Thu, 05 Mar 2026 00:39:28 +0100 (CET)
Date: Thu, 5 Mar 2026 00:39:28 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Peter Xu <peterx@redhat.com>
cc: qemu-devel@nongnu.org, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 Gerd Hoffmann <kraxel@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH v6 0/8] memory: Remove most _nomigrate variants
In-Reply-To: <aaiCvPrtcIRK4NmX@x1.local>
Message-ID: <83e20c34-6bd6-4862-f079-0359d206a799@eik.bme.hu>
References: <cover.1772572714.git.balaton@eik.bme.hu>
 <aaiCvPrtcIRK4NmX@x1.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: 2
X-Spam_score: 0.2
X-Spam_bar: /
X-Spam_report: (0.2 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.703, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.386,
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

On Wed, 4 Mar 2026, Peter Xu wrote:
> On Tue, Mar 03, 2026 at 10:47:49PM +0100, BALATON Zoltan wrote:
>> BALATON Zoltan (8):
>>   hw/display/{cg3.tcx}: Do not use memory_region_init_rom_nomigrate()
>>   memory: Remove memory_region_init_rom_nomigrate()
>>   sun4m,sun4u,tcx: Do not use memory_region_init_ram_nomigrate()
>
> If no objections, I can queue these three patch (1-3) for 11.0-rc0 for now.

What about the rest of this series? These are all simple clean ups so 
should not be hard to review. Patches 4-5 and 7-8 need review. Anybody?

Regards,
BALATON Zoltan

