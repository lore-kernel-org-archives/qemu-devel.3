Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EB47CD5BC9
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2026 16:59:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRYdP-00048e-91; Mon, 25 May 2026 12:58:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1wRYdN-00047l-7N
 for qemu-devel@nongnu.org; Mon, 25 May 2026 12:58:33 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1wRYdK-0007iD-2C
 for qemu-devel@nongnu.org; Mon, 25 May 2026 12:58:32 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id BD089596948;
 Mon, 25 May 2026 18:58:26 +0200 (CEST)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id AVd1tPclcvYZ; Mon, 25 May 2026 18:58:24 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id B3E9C596945; Mon, 25 May 2026 18:58:24 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id B1E10596946;
 Mon, 25 May 2026 18:58:24 +0200 (CEST)
Date: Mon, 25 May 2026 18:58:24 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Paolo Bonzini <pbonzini@redhat.com>
cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Max Filippov <jcmvbkbc@gmail.com>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH v5 0/7] Implement memory_region_new_* functions
In-Reply-To: <f77b6bf5-3e92-4ef6-a396-7132a212e16b@redhat.com>
Message-ID: <e36d6d5a-ab02-5a79-9d5a-733837e34a54@eik.bme.hu>
References: <cover.1779723483.git.balaton@eik.bme.hu>
 <f77b6bf5-3e92-4ef6-a396-7132a212e16b@redhat.com>
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

On Mon, 25 May 2026, Paolo Bonzini wrote:
> On 5/25/26 17:47, BALATON Zoltan wrote:
>> Allow creating memory regions that are managed by QOM and freed with
>> their owner as it is already documented and implemented but there was
>> no way to use it.
>
> It was already explained that this will not be merged.

Please explain again why because I did not get a reason for refusing it. 
If this won't be merged how should the issues handled here be fixed and 
why is that better than this way? (The patches seem to have been mangled 
on sending so I'd resend but I at least need the first patch for further 
ati-vga patches.)

Regards,
BALATON Zoltan

> Paolo
>
>> v5:
>> - rebase on master
>> - add patch to export memory_region_set_ops (needed for ati-vga endian
>> switch)
>> 
>> v4:
>> - rebase on latest version of clean up series:
>> Based-on: cover.1772924151.git.balaton@eik.bme.hu
>> 
>> v3:
>> - based on split off clean up series
>> - convert xtfpga from nomigrate as this has no migration compatibility
>> issue
>> 
>> v2:
>> - rebase on master
>> - update documentation
>> - use these function to fix some leaks (there may be more, e.g. in
>> hw/pci-host/bonito but I leave that for later and/or others)
>> 
>> BALATON Zoltan (7):
>>    memory: Export memory_region_set_ops()
>>    memory: Add memory_region_new* functions
>>    memory: Update documentation for memory_region_new*()
>>    hw/ide/sii3112: Use memory_region_new to avoid leaking regions
>>    hw/pci-host/articia: Map PCI memory windows in realize
>>    hw/pci-host/articia: Add variable for common type cast
>>    hw/xtensa/xtfpga: Fix leaking memory region
>>
>>   docs/devel/memory.rst   |  21 ++---
>>   hw/ide/sii3112.c        |  30 +++----
>>   hw/pci-host/articia.c   |  22 +++--
>>   hw/ppc/amigaone.c       |  28 ++----
>>   hw/ppc/pegasos.c        |  13 ---
>>   hw/xtensa/xtfpga.c      |   5 +-
>>   include/system/memory.h | 192 ++++++++++++++++++++++++++++++++++++++++
>>   system/memory.c         | 186 +++++++++++++++++++++++++++++++++++++-
>>   8 files changed, 421 insertions(+), 76 deletions(-)
>> 
>
>

