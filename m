Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C9C0FF885C
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Apr 2026 07:34:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGXW7-0003n8-Gq; Sat, 25 Apr 2026 03:33:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wGXW1-0003mZ-0s; Sat, 25 Apr 2026 03:33:28 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wGXVx-0000e5-ER; Sat, 25 Apr 2026 03:33:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1777102315; bh=sHOEKSX5xeHzptUfRaW17B1vz1SqXlIBFKgIsyGNeps=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=dyVacpFaLfSVgaEDbN25HT6dR5ktqp2v3rQDOsaPCIi1soSTug/Xj4FJYofXaBzk9
 pwNptXaqepgpk5lPdXjyJzTAq4gOW6c88MW4Yo76i//eXSCFCebUmR21htJpcWuPZX
 fs/w2uRrPZoarAKWrhDiimpRWzZfgWnhtu0XTVPUJBz5lrsHhoZfN/ZZH2kA6wnomK
 PGYyDiGcVAGkC1OkpPV6DT5c1iu1ZdbAeYCglqYWrT4Qsf/CA8Z0Zt0n/I3ZqjOxvi
 p+tXC2ewPKNXxQ2xsB4sXlZONmtTJACOXX24yV1lF3VKbZrf/Vejfh79zcGkcux+M2
 3Qxh9GtylJ2qg==
Received: from [192.168.177.146] (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by isrv.corpit.ru (Postfix) with ESMTP id 8B7C41A30C9;
 Sat, 25 Apr 2026 10:31:55 +0300 (MSK)
Message-ID: <41ac9d5f-167b-46cb-b635-3b50ad75792e@tls.msk.ru>
Date: Sat, 25 Apr 2026 10:33:15 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: qemu stable process questions
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 "Chaney, Ben" <bchaney@akamai.com>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "qemu-stable@nongnu.org" <qemu-stable@nongnu.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "Zhivich, Michael" <mzhivich@akamai.com>, "Hunt, Joshua" <johunt@akamai.com>
References: <9C918929-E60B-4298-84A3-0B9C2F7E399F@akamai.com>
 <0be3bac3-5aa9-416f-849f-ef7da3015dec@tls.msk.ru>
 <48e492a8-4641-47b9-ac57-e5477085b1ef@yandex-team.ru>
Content-Language: en-US, ru-RU
From: Michael Tokarev <mjt@tls.msk.ru>
Autocrypt: addr=mjt@tls.msk.ru; keydata=
 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
In-Reply-To: <48e492a8-4641-47b9-ac57-e5477085b1ef@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

On 25.04.2026 02:42, Vladimir Sementsov-Ogievskiy wrote:

> 2. Which versions are taken for LTS releases of big vendors (I look
> at RHEL and Ubuntu). For example, Ubuntu 26.04 takes 10.2, and
> that's a sign for me, that many people will work on making 10.2 more
> stable, they will fix bugs and (hopefully) send fixes upstream, and
> we'll be able to backport them, if face into same bugs

It looks like ubuntu people don't have much interest in this area
recently (they had several changes in qemu maintenance team).  The
bugs they backport fixes for are few and quite specific to their
use of qemu.  From the qemu bug tracker on gitlab, I'd say archlinux
(and archlinux users) is much more active and user-focused than ubuntu.
Also, proxmox people face and fix more actual user-facing bugs.

[..]
> Then, to be honest, sitting on some originally chosen stable 
> version, I don't monitor updates for stable branch and don't take
> them.. Instead we backport patches from master, when we face some
> known bug, or when some CVE becomes known.
> 
> Probably, I should start to monitor stable branches, for proactive
> bugs fixing.

I think it was the intention with ubuntu too, initially, when they
asked me to support 8.2 for longer.  But they changed maintainer and
the new maintainer never used upstream 8.2.x series.  Even more:
ubuntu people asked *me* multiple times if I can help with bugs in
ubuntu qemu, - to which I replied that the bug they're facing is
fixed in qemu 8.2.x branch a few months ago.  It was rather disappointing

> ---
> 
> So.. You try to support stable branch until next release + one 
> month. Not more than half a year. But actually, vendors have to 
> support their packages in LTS versions during the whole LTS period, 
> which is usually a lot longer. Same for us: we can't move to new 
> upstream release often, so we have to support chosen version for a
> long time.

I just extended the previous formula "up to the next major release",
arbitrary.  There's no particular reason for the time, it just felt to
me that it will be "better" that way.  I never received any feedback
about any timings or LTS branches (besides that request from ubuntu
which was rather negative).

There's no problem at all to support a few recent branches for longer.
But not *much* longer, because of increasing support costs and
decreasing usefulness of the branches which becomes older.

Most fixes are easily back-portable (if the target branch isn't very
old), - so it isn't that difficult to do a direct backport most of the
time.  Some, on the other hand, require more work, and either back-
porting some other changes, or modifying the original change to work
in an older branch.  So maybe looking at the stable branches might
actually help at times.

BTW, for the upstream stable series I try to do more work than is
necessary for a downstream distribution, but with the same result.
Namely, I try to keep every change traceable to a later commit from
the master branch, even if the resulting commit in previous branch
becomes a no-op, or some other weird thing.  For example, there were
several weirdness in 10.0:

2de769fe0b i386/cpu: Fix cpu number overflow in CPUID.01H.EBX[23:16]
53f100eeec i386/cpu: Fix number of addressable IDs field for
CPUID.01H.EBX[23:16]
3d26cb65c2 i386/cpu: Move adjustment of CPUID_EXT_PDCM before
feature_dependencies[] check
d973766e10 Revert "i386/cpu: Fix cpu number overflow in
CPUID.01H.EBX[23:16]"
82517381c5 i386/cpu: Honor maximum value for CPUID.8000001DH.EAX[25:14]
1822478999 i386/cpu: Fix overflow of cache topology fields in CPUID.04H
d097553158 i386/cpu: Fix cpu number overflow in CPUID.01H.EBX[23:16]

I picked up a patch for 10.0.x, but I had to tweak it to work in 10.0.
Next it turned out another patch in this area is needed, and yet another.
So in the end I reverted the first pick-up, and applied them in the
correct order.

At the same time, see this pair of commits (from the above list):

53f100eeec i386/cpu: Fix number of addressable IDs field for 
CPUID.01H.EBX[23:16]
e08986228b target/i386/cpu: Move addressable ID encoding out of compat 
property in CPUID[0x1]

I could've fold all this to a single change made especially for 10.0.x
branch.  But I really wanted each change to trace back to corresponding
commit in later master branch.

All this weirdness can be omitted in a downstream, going right to the
final state without all the intermediate steps.

Also, upstream stable series - so far anyway, but this has been mentioned
in the list a few times already, with no principal disagreement - did
not change machine types.  Which a downstream can do.  There's a bug
in 10.0.x which can't be fixed without introducing a new machine type
(see comments at https://wiki.qemu.org/Planning/10.0).

Maybe the next time this happens, we'll finally introduce a new machine
type within stable series (introducing it in master too at the same time,
and for all active stable series too).

> Finally, can we cooperate somehow? If all vendors, who support their 
> packages based on QEMU a.b.* will send fixes they do in downstream 
> (already done in context of a.b branch, so you don't need to
> rebase!) to the mailing list with "for-stable-a.b" mark, would it
> work?

Cooperation would be definitely the best thing here.  I tried to ask
downstreams a few times for the feedback in this area, if they're
interested in having a "more central" place for the fixes, etc.  In
the return I had one or two patches which would've be good to include
in the next stable version, and that's about it.

BTW, one more thing I'm "requiring" here is some expertise from the
subsystem maintainer of the change in question, - if some non-trivial
change is about to be applied.  Or, put it another way, some openess,
so to say, - so the subsystem maintainers at least know what's going
in here.  A few times I faced a change which looks good to have in a
stable branch, which fixed a real bug in qemu gitlab bug tracker (so
it's a user-facing bug), and the patch applied cleanly too, but due
to changes in other parts of the subsystem in question, that change
can not be applied, as it introduced bugs in other parts.  Most of
the time, qemu testsuite catches this, but not always.  I expect this
to happen more with the move towards single-binary qemu-system and
due to other similar changes.

Thanks,

/mjt

