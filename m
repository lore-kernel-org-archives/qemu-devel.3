Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C0E8F3D31C
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 16:07:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyBEC-000436-Oc; Thu, 05 Mar 2026 11:07:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vyBE9-0003uH-KX
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 11:07:06 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vyBE5-0002nh-BI
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 11:07:05 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 61630596D94;
 Thu, 05 Mar 2026 17:06:57 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id PtQFvOEELyx6; Thu,  5 Mar 2026 17:06:55 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 55E7C5969F2; Thu, 05 Mar 2026 17:06:55 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 53C955966F5;
 Thu, 05 Mar 2026 17:06:55 +0100 (CET)
Date: Thu, 5 Mar 2026 17:06:55 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Peter Xu <peterx@redhat.com>
cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
 Max Filippov <jcmvbkbc@gmail.com>, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH v5 1/8] hw/display/{cg3.tcx}: Do not use
 memory_region_init_rom_nomigrate()
In-Reply-To: <aamhmXuvcPXPfWSJ@x1.local>
Message-ID: <1d73d26a-f700-a0af-2c58-06e6b6597506@eik.bme.hu>
References: <cover.1772397447.git.balaton@eik.bme.hu>
 <816075b4a7fe7d4234744b7bd29c03139e4c2f38.1772397447.git.balaton@eik.bme.hu>
 <CAFEAcA9tiLag6NHMajPH=caqECRw7DT5vmtX4EraTG8Xp5re3w@mail.gmail.com>
 <97bceb8f-4cdb-461d-9553-c39b18a61063@ilande.co.uk>
 <aamhmXuvcPXPfWSJ@x1.local>
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

On Thu, 5 Mar 2026, Peter Xu wrote:
> On Thu, Mar 05, 2026 at 11:15:59AM +0000, Mark Cave-Ayland wrote:
>> On 03/03/2026 09:51, Peter Maydell wrote:
>>
>>> On Sun, 1 Mar 2026 at 21:03, BALATON Zoltan <balaton@eik.bme.hu> wrote:
>>>>
>>>> Use memory_region_init_rom() instead which is what other devices do.
>>>> This is breaks migration but these devices are only used on sparc Sun
>>>> machines which have no migration compatibility guarantee.
>>>>
>>>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>>>> ---
>>>>   hw/display/cg3.c | 5 ++---
>>>>   hw/display/tcx.c | 5 ++---
>>>>   2 files changed, 4 insertions(+), 6 deletions(-)
>>>
>>> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
>>>
>>> I think the compat break on these machines is worth it
>>> to make progress on the cleanup of these functions.
>>
>> Hi Peter,
>
> Hi, Mark,
>
> [some pure thoughts before PeterM chimes in..]
>
>>
>> From what I can see there is still on-going discussion on this series,
>> however if the general consensus is that the removal of the last of these
>> legacy functions is now imminent then I won't object if you want to merge
>> this.
>
> In this case it's not easy to reach a consensus collecting "yes"s but
> "no"s, that who still prefer this ABI to be kept.
>
> Personally, I would respect your opinion, and I queued them because from
> what I read the impact seems under control, please correct me otherwise.
>
> There's indeed the dilemma that since sparc machines are not versioned,
> then it's easier to be treated as a system that may not demand the highest
> level of ABI guarantees.
>
> It's also harder to consider ABI compatibility for un-versioned machs
> comparing to versioned.
>
> It's because for other versioned machines, we have the ~6 years lifespan
> nowadays for them so we can drop old things over specific period of time.
> While when a machine is not versioned, it's almost impossible to mark the
> time of deprecation.
>
> We either need to choose to maintain ABI for those machines forever, or we
> allow ABI break to some degree.  When a machine is not versioned, it's
> harder to justify we maintain these machines' ABI even longer than
> versioned machines (which we deemed to be "relatively serious" users).
>
> So if we want to stick with that machine versioning plan, maybe we should
> start version machines that we may care on ABIs.  IIUC it doesn't need to
> introduce one machine type every release, however when versioned we will be
> able to follow the same ~6 years obsoletion phase at least.

Considering that this was intruduced in 2017 around commit 1cfe48c1ce2 and 
most other users were converted back then it's well over 6 years now even 
without versioning. Thanks to Mark for accepting changing it now.

I've dropped the debated part about errp from the v7 of the series so all 
remaining clean ups should be simple enough to review and merge before the 
freeze. Could you please have a look at those too?

Regards,
BALATON Zoltan

