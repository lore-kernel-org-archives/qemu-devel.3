Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4625DFED3F5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 18:10:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGKyw-0005B3-8h; Fri, 24 Apr 2026 14:10:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wGKyt-0005Aj-3s; Fri, 24 Apr 2026 14:10:23 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wGKyq-0008GR-Ck; Fri, 24 Apr 2026 14:10:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1777054134; bh=f9Br/dFeYAaJtXAC3RCcyItlMfuddAKPSuvwpg4SUDM=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=dkHlhVw/MPWPufQZJonO0Kb1dCFBFHrheBnOBAYs6qzA23uT/oLlNMjssPOJlJxE6
 QkLyJFsMDimpiGER/lsTwji6UyQXRTnZk9u+D9IvGbQDz+DJwtTSA7CJgYqbrll7Qu
 B+FCvVC4nsNivJvqu/pboY2YP2mqyXrsuA0TGcF3cxGgpFUKs0LEvitHxTaGMRSqiG
 Ajb7/5B4GkJocHZfMDBRrBcqDQb41jEHvnlSMjox+TYURdTGk3sCfGziNRQaPdeBbx
 +2wxZwyGW7F+gccqcX3t5J1cpMy1CsxuV7jQKPpgsocQs1SWxleFn0EQUvaJGPgUCL
 NKjrD7Y/wAwxA==
Received: from [192.168.177.146] (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by isrv.corpit.ru (Postfix) with ESMTP id 6C0F71A2F65;
 Fri, 24 Apr 2026 21:08:54 +0300 (MSK)
Message-ID: <0be3bac3-5aa9-416f-849f-ef7da3015dec@tls.msk.ru>
Date: Fri, 24 Apr 2026 21:10:13 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: qemu stable process questions
To: "Chaney, Ben" <bchaney@akamai.com>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "qemu-stable@nongnu.org" <qemu-stable@nongnu.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "Zhivich, Michael" <mzhivich@akamai.com>, "Hunt, Joshua" <johunt@akamai.com>
References: <9C918929-E60B-4298-84A3-0B9C2F7E399F@akamai.com>
Content-Language: en-US, ru-RU
From: Michael Tokarev <mjt@tls.msk.ru>
Autocrypt: addr=mjt@tls.msk.ru; keydata=
 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
In-Reply-To: <9C918929-E60B-4298-84A3-0B9C2F7E399F@akamai.com>
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

On 24.04.2026 20:02, Chaney, Ben wrote:
> Hello,
>          I'm trying to better understand the lifecycle of the qemu stable branches.
> 
>          Is there an official schedule for when each release goes EOL? Currently the only indication I can find that a stable branch is EOL is on the planning page for that release, but this only shows up after the fact.
> 
>          Do all stable branches have the same length of support? In the past, qemu-7.2 had a longer support cycle. Will any current or future branches have that longer cycle now that 7.2 has been retired?

Hi!

Thank you for the questions.

Strictly speaking, there's no rules here.

Before I started, there were stable series (minor point releases)
up until the next major release.  With the next major release, the
previous "stable" branch were end-of-lined.   It was simple but not
really helpful for the rest of the world.

When I stepped in, the first thing I thought was to continue previous
stable series for a bit longer - maybe to have one or two more point
releases, until the next major release stabilizes "enough" so it's
possible to switch to it.  This is a main "rule" I'm trying to follow:
to support N.x series until (N+1).1 or even (N+1).2.  This rule is not
exactly strict, - this is "at least until next .1 or .2".

An LTS series, like 7.2 has been, was an experiment.  I think the
results it shows are.. mixed.  On one hand, 7.2.x was good for the
users, or so I'd hope, anyway.  On another, supporting it was more
and more difficult for the whole set of developers, because I weren't
able to do it on my own and needed help back-porting changes to an
older branch.  I didn't feel good about it, and I didn't felt good
about making changes by my own without as good understanding of the
things as the subsystem maintainers.

The version chosen wasn't exactly random - it is the qemu version
which was used in debian stable at the time (bookworm).  Current
long-term support series, 10.0.x, is also in debian stable (it is
debian trixie now), so it is also not random - if anything, it helps
me to ensure good version is provided in debian, and I have some
additional testing ground there too.

I had request from ubuntu guys to keep another series as an LTS, -
8.2.x.  So I added that one too, for some time, - until I realized
they don't use it, instead, they pick some selected changes only,
once their users file bugs.  So it turned out to be a waste of time
of everyone, so I dropped this series.

Speaking of the stable release schedule - I'm trying to keep the
next series in about one month after the previous one.  It doesn't
always works, usually because one or another issue here or there,
which makes us unable to make the release within one month and it
has to be moved a bit.  By "we" I mean Michael Roth who is making
the actual releases and signing them with his gpg key, and me who
is tagging them.  Also I still can't figure out the best timing
when the next major release happen - aligning stable point releases
with the next major release date is fun, I can't get it to work.
It isn't good to make next stable together with the next major one,
it isn't good to do it a bit earlier, and it isn't good to do it
a bit later either, all due to their own reasons.  I'm experimenting
here still.

So, we're back to the square one: there's no rules, I go as I feel
would be good, that's all.  I'm trying to be useful, but given no
feedback about what actually is useful, I'm resorting to guessing :)
And by "feedback", I mean not the "thank you" type things, but about
if some series would be good to be LTS or not, or if some series can
have "a bit" more support time, etc - that sort of things.  I just
don't know if any of the series I run are useful or not, that's all.

Supporting several recent series isn't a big deal, since usually, the
changes between them aren't very large, and most patches applies and
works fine.  Supporting some series for longer require much more
efforts, especially across some big changes, - for example, currently
we're observing quite a big move towards single-binary qemu-system,
and there, I'm afraid most future changes will be more and more
difficult, and sometimes even picking up a simple change to an older
version will mean it wont work correctly (due to wrong endianness
for example).

That's what the current situation is, with all fairness I'm able to
provide.  The process is definitely not perfect, but this is what it
currently is :)

And I don't know yet how to improve it.

Thanks,

/mjt

