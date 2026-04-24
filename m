Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3EACFF8850
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 23:43:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGQAe-0001sI-5w; Fri, 24 Apr 2026 19:42:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wGQAc-0001rp-4k; Fri, 24 Apr 2026 19:42:50 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wGQAZ-0000vu-E3; Fri, 24 Apr 2026 19:42:49 -0400
Received: from mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:c00c:0:640:e0de:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id C362A806F5;
 Sat, 25 Apr 2026 02:42:39 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:537::1:26] (unknown
 [2a02:6bf:8080:537::1:26])
 by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id bgfFkL0LDa60-3og3OjjL; Sat, 25 Apr 2026 02:42:39 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1777074159;
 bh=VVO3QU2diYnoMjHJk57wTwW8koUqSma3ZXWhVwArVGk=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=mLdK6vBbmKBvNYQa5MVpDugG3wZoMHYlcwDq6kppoc9lNhsUPfvad2cZGFpNQga4W
 aBfulb4MdBxsjDiSvbODARQjltZOseUgebrJg/2+WrxWhUNOSyZW0XVGlwyKoPP4c+
 2x6QdXzeV/OMtBONScinoqk14Ze0F3hEYj9dIU84=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <48e492a8-4641-47b9-ac57-e5477085b1ef@yandex-team.ru>
Date: Sat, 25 Apr 2026 02:42:37 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: qemu stable process questions
To: Michael Tokarev <mjt@tls.msk.ru>, "Chaney, Ben" <bchaney@akamai.com>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "qemu-stable@nongnu.org" <qemu-stable@nongnu.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "Zhivich, Michael" <mzhivich@akamai.com>, "Hunt, Joshua" <johunt@akamai.com>
References: <9C918929-E60B-4298-84A3-0B9C2F7E399F@akamai.com>
 <0be3bac3-5aa9-416f-849f-ef7da3015dec@tls.msk.ru>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <0be3bac3-5aa9-416f-849f-ef7da3015dec@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c02:900:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 24.04.26 21:10, Michael Tokarev wrote:
> On 24.04.2026 20:02, Chaney, Ben wrote:
>> Hello,
>>          I'm trying to better understand the lifecycle of the qemu stable branches.
>>
>>          Is there an official schedule for when each release goes EOL? Currently the only indication I can find that a stable branch is EOL is on the planning page for that release, but this only shows up after the fact.
>>
>>          Do all stable branches have the same length of support? In the past, qemu-7.2 had a longer support cycle. Will any current or future branches have that longer cycle now that 7.2 has been retired?
> 
> Hi!
> 
> Thank you for the questions.

+1

I was thinking about it recently. When choosing a next version
to base downstream branch on, I consider following things:

1. Of course, what features we want.

2. Which versions are taken for LTS releases of big vendors
    (I look at RHEL and Ubuntu). For example, Ubuntu 26.04 takes
    10.2, and that's a sign for me, that many people will work
    on making 10.2 more stable, they will fix bugs and (hopefully)
    send fixes upstream, and we'll be able to backport them, if
    face into same bugs

3. And I check, what's going on with qemu stable process at the moment,
    this way:

git tag | grep '^v10.[0-9]\+.[0-9]\+$' | while read tag; do echo $(git log -1 --date=format:%Y-%m-%d --format=%cd $tag) $tag; done | sort
2025-04-22 v10.0.0
2025-05-26 v10.0.1
2025-05-28 v10.0.2
...
2026-02-12 v10.2.1
2026-03-17 v10.0.9
2026-03-17 v10.1.5
2026-03-17 v10.2.2

- looks good for any of 10.*

---

Then, to be honest, sitting on some originally chosen stable
version, I don't monitor updates for stable branch and don't
take them.. Instead we backport patches from master, when we
face some known bug, or when some CVE becomes known.

Probably, I should start to monitor stable branches,
for proactive bugs fixing.

---

So.. You try to support stable branch until next release + one
month. Not more than half a year. But actually, vendors have to
support their packages in LTS versions during the whole LTS period,
which is usually a lot longer. Same for us: we can't move to new
upstream release often, so we have to support chosen version for
a long time.

Finally, can we cooperate somehow? If all vendors, who support their
packages based on QEMU a.b.* will send fixes they do in downstream
(already done in context of a.b branch, so you don't need to rebase!)
to the mailing list with "for-stable-a.b" mark, would it work?


> 
> Strictly speaking, there's no rules here.
> 
> Before I started, there were stable series (minor point releases)
> up until the next major release.  With the next major release, the
> previous "stable" branch were end-of-lined.   It was simple but not
> really helpful for the rest of the world.
> 
> When I stepped in, the first thing I thought was to continue previous
> stable series for a bit longer - maybe to have one or two more point
> releases, until the next major release stabilizes "enough" so it's
> possible to switch to it.  This is a main "rule" I'm trying to follow:
> to support N.x series until (N+1).1 or even (N+1).2.  This rule is not
> exactly strict, - this is "at least until next .1 or .2".
> 
> An LTS series, like 7.2 has been, was an experiment.  I think the
> results it shows are.. mixed.  On one hand, 7.2.x was good for the
> users, or so I'd hope, anyway.  On another, supporting it was more
> and more difficult for the whole set of developers, because I weren't
> able to do it on my own and needed help back-porting changes to an
> older branch.  I didn't feel good about it, and I didn't felt good
> about making changes by my own without as good understanding of the
> things as the subsystem maintainers.
> 
> The version chosen wasn't exactly random - it is the qemu version
> which was used in debian stable at the time (bookworm).  Current
> long-term support series, 10.0.x, is also in debian stable (it is
> debian trixie now), so it is also not random - if anything, it helps
> me to ensure good version is provided in debian, and I have some
> additional testing ground there too.
> 
> I had request from ubuntu guys to keep another series as an LTS, -
> 8.2.x.  So I added that one too, for some time, - until I realized
> they don't use it, instead, they pick some selected changes only,
> once their users file bugs.  So it turned out to be a waste of time
> of everyone, so I dropped this series.
> 
> Speaking of the stable release schedule - I'm trying to keep the
> next series in about one month after the previous one.  It doesn't
> always works, usually because one or another issue here or there,
> which makes us unable to make the release within one month and it
> has to be moved a bit.  By "we" I mean Michael Roth who is making
> the actual releases and signing them with his gpg key, and me who
> is tagging them.  Also I still can't figure out the best timing
> when the next major release happen - aligning stable point releases
> with the next major release date is fun, I can't get it to work.
> It isn't good to make next stable together with the next major one,
> it isn't good to do it a bit earlier, and it isn't good to do it
> a bit later either, all due to their own reasons.  I'm experimenting
> here still.
> 
> So, we're back to the square one: there's no rules, I go as I feel
> would be good, that's all.  I'm trying to be useful, but given no
> feedback about what actually is useful, I'm resorting to guessing :)
> And by "feedback", I mean not the "thank you" type things, but about
> if some series would be good to be LTS or not, or if some series can
> have "a bit" more support time, etc - that sort of things.  I just
> don't know if any of the series I run are useful or not, that's all.
> 
> Supporting several recent series isn't a big deal, since usually, the
> changes between them aren't very large, and most patches applies and
> works fine.  Supporting some series for longer require much more
> efforts, especially across some big changes, - for example, currently
> we're observing quite a big move towards single-binary qemu-system,
> and there, I'm afraid most future changes will be more and more
> difficult, and sometimes even picking up a simple change to an older
> version will mean it wont work correctly (due to wrong endianness
> for example).
> 
> That's what the current situation is, with all fairness I'm able to
> provide.  The process is definitely not perfect, but this is what it
> currently is :)
> 
> And I don't know yet how to improve it.
> 
> Thanks,
> 
> /mjt
> 


-- 
Best regards,
Vladimir

