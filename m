Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9851F4BB63
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 17:45:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuwTB-0001xx-9l; Tue, 24 Feb 2026 12:45:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vuwT8-0001x9-0L
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 12:45:10 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vuwT3-0004t5-1n
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 12:45:09 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 4000D596A0B;
 Tue, 24 Feb 2026 18:45:01 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id U4AiJ3dTDbQP; Tue, 24 Feb 2026 18:44:58 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id D11C25969F4; Tue, 24 Feb 2026 18:44:58 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id CF4165969F6;
 Tue, 24 Feb 2026 18:44:58 +0100 (CET)
Date: Tue, 24 Feb 2026 18:44:58 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Peter Xu <peterx@redhat.com>
cc: qemu-devel@nongnu.org, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 Gerd Hoffmann <kraxel@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH v4 0/8] memory: Remove most _nomigrate variants
In-Reply-To: <aZ3CQw2ad5cVc-Mm@x1.local>
Message-ID: <c8a789fa-8d16-709d-eb3f-8acd6c1d08e8@eik.bme.hu>
References: <cover.1770253186.git.balaton@eik.bme.hu>
 <aZ3CQw2ad5cVc-Mm@x1.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.358, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.659,
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

On Tue, 24 Feb 2026, Peter Xu wrote:
> On Thu, Feb 05, 2026 at 02:13:18AM +0100, BALATON Zoltan wrote:
>> v4:
>> - separate patch converting Sun machines from memory_region_init_ram_nomigrate
>> - split helper to init ram into two functions: setup and error_propagate
>> - also use memory_region_init_io in memory_region_init_ram_device_ptr
>>
>> v3:
>> - rebased on master after some patches were merged
>> - drop some more line from memory-region-housekeeping.cocci
>> - added comment to explain what factored out helper does
>> - some more clean ups included
>>
>> BALATON Zoltan (8):
>>   hw/display/{cg3,tcx}: Do not use memory_region_init_rom_nomigrate()
>>   memory: Remove memory_region_init_rom_nomigrate()
>>   sun4m,sun4u,tcx: Do not use memory_region_init_ram_nomigrate()
>>   memory: Remove memory_region_init_ram_nomigrate()
>
> Could you help explain why we need to remove the above two small helpers?

Ideally we should remove all of the nomigrate variants as there are only 
about 3 uses left, everything else is already moved to the init_{ram,rom} 
variants that register the memory region for migration. The is probably 
one legitimate use that is served by memory_region_init_flags_nomigrate 
and other 3 uses are the xtfpga which I think is just old code and does 
not support migration so it will be converted in the second series to 
memory_region_new as the maintainers did not say anyting to that so far. 
Then there's one in hw/display/vga but that's gated behind a compatibility 
switch that's only set in 2.12 (global-vmstate=true) and earlier. This is 
not active any more but cannot yet be removed as there are eariler compat 
props still need cleaning up but the last visible machine version is 5.1 
now so this is long deprecated and not used. And there are these Sun 
machines that I've converted in the first version but Mark said he'd like 
to keep the current behaviour until it's the last user left. See: 
https://patchew.org/QEMU/cover.1769703287.git.balaton@eik.bme.hu/b530cf54609b853c6b34306fd4aa3ce2f8087d05.1769703287.git.balaton@eik.bme.hu/

> Not saying that we can't remove them, but I don't yet see the point of
> open-code those readonly=true setup either, or any problem with having the
> smaller helpers when ram_flags=0.  Small helpers sometimes help readability.
>
> Some of them are going backwards againist what the cocci scripts were
> suggesting previously, like:
>
> - memory_region_init_ram_nomigrate(E1, E2, E3, E4, E5);
> + memory_region_init_rom_nomigrate(E1, E2, E3, E4, E5);
>  ... WHEN != E1
> - memory_region_set_readonly(E1, true);
>
> So you suggest open-code instead.  Why?

This is temporary until the usage in vga is gone with hw_compat_2_12 then 
the Sun machines will be the last users so they can also be converted to 
init_{ram,rom} (unless Mark changes his mind and agrees changing these 
now as was in the first version).

> Is it required for your follow up cleanups?

It makes those simpler as then we don't need to add memory_region_new 
variants for the nomigrate versions that we would remove later anyway.

Regards,
BALATON Zoltan

