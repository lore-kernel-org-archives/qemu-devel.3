Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B009AE9B36D
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 12:27:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vx2Mm-0001ys-K7; Mon, 02 Mar 2026 07:27:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vx2Md-0001wj-HQ
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 07:27:09 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vx2MZ-0004qh-Fl
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 07:27:06 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 1BBDE5969FA;
 Mon, 02 Mar 2026 13:26:58 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id uiv4gwXMBhC5; Mon,  2 Mar 2026 13:26:55 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id A82D65969F2; Mon, 02 Mar 2026 13:26:55 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id A62845969F0;
 Mon, 02 Mar 2026 13:26:55 +0100 (CET)
Date: Mon, 2 Mar 2026 13:26:55 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
cc: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 Gerd Hoffmann <kraxel@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH v4 0/8] memory: Remove most _nomigrate variants
In-Reply-To: <997bf152-3982-490b-8450-06095ffad22b@rsg.ci.i.u-tokyo.ac.jp>
Message-ID: <01f28121-0306-39e9-6526-fef766388eab@eik.bme.hu>
References: <cover.1770253186.git.balaton@eik.bme.hu>
 <aZ3CQw2ad5cVc-Mm@x1.local> <c8a789fa-8d16-709d-eb3f-8acd6c1d08e8@eik.bme.hu>
 <aZ8jmaB-zuBSoQXH@x1.local>
 <997bf152-3982-490b-8450-06095ffad22b@rsg.ci.i.u-tokyo.ac.jp>
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

On Mon, 2 Mar 2026, Akihiko Odaki wrote:
> On 2026/02/26 1:30, Peter Xu wrote:
>> On Tue, Feb 24, 2026 at 06:44:58PM +0100, BALATON Zoltan wrote:
>>> On Tue, 24 Feb 2026, Peter Xu wrote:
>>>> On Thu, Feb 05, 2026 at 02:13:18AM +0100, BALATON Zoltan wrote:
>>>>> v4:
>>>>> - separate patch converting Sun machines from 
>>>>> memory_region_init_ram_nomigrate
>>>>> - split helper to init ram into two functions: setup and error_propagate
>>>>> - also use memory_region_init_io in memory_region_init_ram_device_ptr
>>>>> 
>>>>> v3:
>>>>> - rebased on master after some patches were merged
>>>>> - drop some more line from memory-region-housekeeping.cocci
>>>>> - added comment to explain what factored out helper does
>>>>> - some more clean ups included
>>>>> 
>>>>> BALATON Zoltan (8):
>>>>>    hw/display/{cg3,tcx}: Do not use memory_region_init_rom_nomigrate()
>>>>>    memory: Remove memory_region_init_rom_nomigrate()
>>>>>    sun4m,sun4u,tcx: Do not use memory_region_init_ram_nomigrate()
>>>>>    memory: Remove memory_region_init_ram_nomigrate()
>>>> 
>>>> Could you help explain why we need to remove the above two small helpers?
>>> 
>>> Ideally we should remove all of the nomigrate variants as there are only
>>> about 3 uses left, everything else is already moved to the init_{ram,rom}
>>> variants that register the memory region for migration. The is probably 
>>> one
>>> legitimate use that is served by memory_region_init_flags_nomigrate and
>>> other 3 uses are the xtfpga which I think is just old code and does not
>>> support migration so it will be converted in the second series to
>>> memory_region_new as the maintainers did not say anyting to that so far.
>>> Then there's one in hw/display/vga but that's gated behind a compatibility
>>> switch that's only set in 2.12 (global-vmstate=true) and earlier. This is
>>> not active any more but cannot yet be removed as there are eariler compat
>>> props still need cleaning up but the last visible machine version is 5.1 
>>> now
>>> so this is long deprecated and not used. And there are these Sun machines
>>> that I've converted in the first version but Mark said he'd like to keep 
>>> the
>>> current behaviour until it's the last user left. See: 
>>> https://patchew.org/QEMU/cover.1769703287.git.balaton@eik.bme.hu/b530cf54609b853c6b34306fd4aa3ce2f8087d05.1769703287.git.balaton@eik.bme.hu/
>>> 
>>>> Not saying that we can't remove them, but I don't yet see the point of
>>>> open-code those readonly=true setup either, or any problem with having 
>>>> the
>>>> smaller helpers when ram_flags=0.  Small helpers sometimes help 
>>>> readability.
>>>> 
>>>> Some of them are going backwards againist what the cocci scripts were
>>>> suggesting previously, like:
>>>> 
>>>> - memory_region_init_ram_nomigrate(E1, E2, E3, E4, E5);
>>>> + memory_region_init_rom_nomigrate(E1, E2, E3, E4, E5);
>>>>   ... WHEN != E1
>>>> - memory_region_set_readonly(E1, true);
>>>> 
>>>> So you suggest open-code instead.  Why?
>>> 
>>> This is temporary until the usage in vga is gone with hw_compat_2_12 then
>>> the Sun machines will be the last users so they can also be converted to
>>> init_{ram,rom} (unless Mark changes his mind and agrees changing these now
>>> as was in the first version).
>>> 
>>>> Is it required for your follow up cleanups?
>>> 
>>> It makes those simpler as then we don't need to add memory_region_new
>>> variants for the nomigrate versions that we would remove later anyway.
>> 
>> Personally I don't see the memory_region_new() whole thing solid yet, but
>> still during review.  I shared my thoughts.  So far, I'm not fully
>> convinced, but I also don't have the full picture to say no, either.  We
>> can wait for others to chime in with more thoughts.
>> 
>> For this series, I would prefer if we can discuss it separately from the
>> other work.
>> 
>> Removing _nomigrate() variances makes sense to me in general, it means we
>> want to by default suggest new devices only use RAM regions that is
>> migratable, with proper owner device specified along with the ramblock name
>> (as part of migration API).
>> 
>> However, we have two sets of these _nomigrate APIs:
>>
>>    (1) memory_region_init_r[ao]m_nomigrate
>>    (2) memory_region_init_r[ao]m_flags_nomigrate
>> 
>> What I am still confused about is why this series used (2) to replace (1)
>> rather than removing both.  I don't understand how this helps if we still
>> have (2) around: it means new devices at least can still use (2) to bypass
>> migration.
>> 
>> There's actually one way to enforce migratable RAMs, taking ROM as example,
>> it could be:
>>
>>    memory_region_init_rom_internal(..., global_vmstate=XXX)
>> 
>> Then memory_region_init_rom() should use that, setting global_vmstate=off.
>> 
>> Then we can unexport/remove memory_region_init_rom_[flag_]nomigrate() but
>> use that _internal() in relevant paths; we should also mark the _internal()
>> functions to say "new code is suggested to use the normal version".  But I
>> do not know if that is a slight overkill just for this..
>> 
>> If the other series (to avoid introducing new APIs) is the only reason for
>> this part, then IMHO this part of the series needs to be in the other
>> series, not this one.  The last cleanup patches look more self contained
>> OTOH to me, if the whole purpose of the latter half was code dedup, then it
>> makes more sense at least to me.
>
> +1 for what Peter Xu suggested. Most part of this series looks independently 
> useful, but I don't think the removal of memory_region_init_ram_nomigrate() 
> is.

But if there are no useful uses why keep it? This version shows that 
converting the Sun machines as Peter Maydell suggested only leaves very 
few uses that can be removed eventually too after some further clean up 
that I don't want to take up now. Do you have any usage in mind that needs 
these nomigrate variants?

Regards,
BALATON Zoltan

