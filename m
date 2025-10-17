Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 553C5CCD195
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 12:54:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9jxx-0005km-77; Fri, 17 Oct 2025 08:53:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1v9jxv-0005jy-Ls
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 08:53:51 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1v9jxm-0001xu-F0
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 08:53:50 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id A28035972E9;
 Fri, 17 Oct 2025 14:53:35 +0200 (CEST)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id BRamd7GTDZwJ; Fri, 17 Oct 2025 14:53:33 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 4A3975972E8; Fri, 17 Oct 2025 14:53:33 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 485F859703F;
 Fri, 17 Oct 2025 14:53:33 +0200 (CEST)
Date: Fri, 17 Oct 2025 14:53:33 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Peter Maydell <peter.maydell@linaro.org>
cc: QEMU Developers <qemu-devel@nongnu.org>
Subject: Re: QEMU Summit Minutes 2025
In-Reply-To: <CAFEAcA-OmqRTqwYZ2WCeqFu=zxG65t6WSfKR=NthfpazrjzpzA@mail.gmail.com>
Message-ID: <f4f426c0-7470-8764-9faf-abecf610b557@eik.bme.hu>
References: <CAFEAcA-OmqRTqwYZ2WCeqFu=zxG65t6WSfKR=NthfpazrjzpzA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, 17 Oct 2025, Peter Maydell wrote:
> Release tarballs
> ----------------
>
> - Our release tarballs are quite large, and 85% of them is just the
>  source of EDK2 which we include as the corresponding source for the
>  EDK2 ROM blobs. This seems a bit silly, since most consumers of the
>  tarball are either:
>   - downstream distros who will want to build their own ROM blobs
>     from the real upstream sources
>   - end users who don't want to build the ROM blobs at all
>
> - We could perhaps usefully split the tarballs so that the ROM sources
>  and the ROM blobs are in their own tarballs and only people who need
>  them download them.

Wouldn't this be solved by splitting off the EDK2 version QEMU needs into 
a separate project (something like qemu-edk2) and make that a separate 
dependency?

> - Relatedly, it would be nice for the ROM blobs to be trivially
>  regenerable by anybody, rather than the current ad-hoc "some
>  trusted person builds a binary locally and we commit it to git"
>  setup. This should be much easier in these days of containers than
>  it was when we first started committing compiled blobs to git.

Having blobs is a big conveniece that would be preferable to keep as most 
of the time people don't need to rebuild blobs if they just want to run a 
machine and even if changing a machine they don't need to touch the 
firmware so it's only a few people who may want to install cross compilers 
or a container to rebuild blobs and it would be nice to save others that 
hassle.

> - However, nothing is fundamentally broken with our current setup, so
>  unless anybody who really wants to do this work is going to step
>  up we probably won't do anything ;-)
>
> Shifting styles and incomplete API conversions
> ----------------------------------------------
>
> - The project has lots of ways of achieving similar things with qdev, QOM,
>  etc. This makes it hard for contributors and reviewers to know how
>  something should be written, or which style to recommend in review.
>  Being asked to change APIs/style is disheartening.
>  This is unlikely to be something we can address easily, but some
>  things to aim for that came up in the conversation:
>  - we should be clear which APIs are legacy and must not be used in
>    new code
>  - we should update the old "unfinished transition" wiki page

It should be clearly documented which is not always the case and in those 
cases existing examples are taken as documentation. So where there is a 
preferred API that should be in the documentation or if it's already there 
should somehow be more organised so it's easier to find and refer to in 
reviews.

> - In particular, there is no current consensus on QOM casts
>  - Using the cast macros looks the neatest stylistically
>  - But it has a runtime overhead, which is irksome in cases where
>    actually at compile time we can be certain the pointer is of
>    a valid type (e.g. cast to parent type)
>  - Different reviewers put different weight on these factors,
>    causing conflicts about what to prefer.

This may have been sparked by some of the debates we had with Mark. In one 
review 
[https://patchew.org/QEMU/cover.1758219840.git.balaton@eik.bme.hu/b5b4558125e2408ded29f7cdc306011358829044.1758219840.git.balaton@eik.bme.hu/] 
he proposed memory region callbacks to take device state as opaque data 
then QOM cast these to get the memory region, parent object or field the 
callbacks need. I argued that there's no such convention documented 
anywhere and what the opaque pointer should be is defined by the callbacks 
[https://en.wikipedia.org/wiki/Closure_(computer_programming)#Callbacks_(C)] 
so it makes sense to pass a the data it needs to the callback and not the 
whole device state. Also the opaque data is registered once typically in 
an init or realize function where it's already known it's the right type 
so within the callback (which can potentially be called often) there is no 
need to type check and cast it every time again. So opaque asignments in 
the callback can assume the right type without casting and I don't think 
it would bring any advantage to restrict the type to device state for 
callbacks that would only make them unnecessarily more complex. This isn't 
documented so can lead to different people following different views. Also 
sometimes new conventions are only agreed on the list but not documented 
so who missed the discussion won't know about it.

I would like to raise another point here: PPC maintainership. Is there an 
active maintainer for PPC currently? The one who is listed in MAINTAINERS 
does not seem to be active and nobody seems to review and merge patches I 
submit for PPC which already resulted in missing one release and the next 
one may be the second release my series miss because of this. Is the 
project aware of this and somebody is taking care of it?

Regards,
BALATON Zoltan

