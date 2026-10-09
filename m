Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17AF1CA601E
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2026 12:59:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xFABs-0000dZ-2F; Fri, 09 Oct 2026 08:59:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xFABq-0000dQ-Un
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 08:59:10 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xFABo-0000Pw-SQ
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 08:59:10 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D153921B82;
 Fri,  9 Oct 2026 12:59:05 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 53D161326D;
 Fri,  9 Oct 2026 12:59:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id I/GMOhjlyGoDQQAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 09 Oct 2026 12:59:05 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, Pierrick Bouvier
 <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, mjt@tls.msk.ru
Subject: Re: [RFC] container images for migration-test
In-Reply-To: <asgp6ld6Loz1xmJg@zhexu-thinkpadt14gen5.rmtcaon.csb>
References: <8733vbtmge.fsf@suse.de>
 <asgp6ld6Loz1xmJg@zhexu-thinkpadt14gen5.rmtcaon.csb>
Date: Fri, 09 Oct 2026 09:58:54 -0300
Message-ID: <87tsmv6ne9.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Pre-Result: action=no action;
	module=Unknown lua;
	unknown reason
X-Rspamd-Pre-Result: action=no action;
	module=Unknown lua;
	unknown reason
X-Spamd-Result: default: False [0.00 / 50.00]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
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

Peter Xu <peterx@redhat.com> writes:

> On Mon, Sep 14, 2026 at 08:58:09PM -0300, Fabiano Rosas wrote:
>> Hi, I just wanted to share and ask for feedback on some container images
>> I've been building as part of my testing of migration pull-requests.
>> 
>> From a Dockerfile from ./tests/docker/dockerfiles/ I'm producing the
>> following:
>> 
>> $ docker images
>> qemu-build-base:11.0.0                        b6efa198e93a        5.8GB
>> qemu-rootfs-base:11.0.0                       72bcb5418f4d       4.08GB
>> qemu:11.0.0                                   018a3f0f4dcc          2GB
>> 
>> This last image is stripped (for size) of everything but a few libs and
>> binaries (qemu, gdb, migration-test, sh) and has an entrypoint of:
>> 
>>  CMD ["qemu-system-x86_64"]
>> 
>> The point is that I can wrap it in a script called qemu-system-x86_64
>> and run it interchangeably with any other qemu binary during
>> migration-test:
>> 
>>  QTEST_QEMU_BINARY_SRC=./build-11.0.0/qemu-system-x86_64 \
>>  QTEST_QEMU_BINARY=./build-master/qemu-system-x86_64 \
>>  ./tests/qtest/migration-test
>> 
>> (note that migration-test spawns the qemu binaries itself)
>> 
>> I run tests against the previous 3 QEMU releases. At every release I
>> build the container for the new release and at every PR I build the
>> container for that git hash using the latest tag as a base.
>
> I'm not a container person,

Me neither, lol. Last container work I did was back when multiarch
manifests were being added to docker. Maybe 2016? I (clearly) haven't
kept up with the progress in the area.

> e.g. I did test my recent channel fix on
> qemu-7.2 by simply building it with build-7.2/.. but after learning it the
> idea using a link to kickoff the container is very interesting on its own
> already.
>

Yeah, the issue is that `git checkout <old version>` and try to build it
is pretty hit or miss.

>> 
>> The reasons that lead me to this solution are:
>> 
>> 1) Migration compat testing is special, the two migration peers can run
>> in different OS versions, so their QEMU builds can be quite different. I
>> cannot test using *just* my dev machine, neither using *just* a
>> container. I need two hosts. Or two containers running different OSes
>> that can both be reachable by the migration-test binary running in
>> either of the OSes.
>
> True..  One thing I want to make us on the same page is, this is about
> distro, not OS?  Say, the kernel is still the same.
>

Yes, it's about what it takes to get a working QEMU binary. I'm not
trying to cover a realistic migration scenario, I'm simply trying to
test across QEMU versions *somehow*.

> So we have three things (1) QEMU (2) distro (3) kernel/OS.  Here the extra
> coverage is (2) only.
>

It's not really about extra coverage, it's about (what I think should
be) the minimum migration testing done by upstream, i.e. ensuring one
binary we release is migration-compatible with another binary we
release. Today we test n vs. n-1 in the CI and I think that's not
enough.

> My gut feeling is distro specific thing causing migration failure is
> extremely rare; I can't even think of any in my work history.  Meanwhile,
> it's still not the "real migration", because kernel is shared.  Anything
> real will need to happen on two real and different hosts, ultimately, to
> make it cover all things.  It's more likely to me that the kernel
> difference may fail a migration than distro difference.
>

You right, but that feels like another problem for another day. It
starts to get away from what the QEMU community can do. I've seen a lot
of cpu-specific issues in the field actually, so even swapping kernels
would miss a few bugs.

> So I still agree having such variance is better, though the hope is what we
> currently do e.g. with compat migration test is good enough.
>
> Said that, if part of this RFC is to see if we want to introduce that too
> for the compat test, no objections either.  Really, it's a matter of if it
> will help us find more bugs.
>

Right, I'm not sure yet. Just sharing because I feel like keeping this
stuff private is a bad approach. In general, if a maintainer relies on
something to do their work, it should be under the community
umbrella. Of course there are matters of _workflow_, and every person
has a preference, but maybe the tooling could be shared.

>> 
>> 2) Neither the QEMU build nor the distro repos are reliable enough to
>> allow me to just "go back in time" and rebuild at any moment, I need to
>> keep the artifacts cached to avoid rebuilding. Otherwise it comes time
>> to send a PR and I discover that some python piece has changed or the
>> distro messed up the older repository.
>
> This is definitely true.  While studying your test approach, I also noticed
> that there's a "toolbox" tool that should have done many of what your
> script did: "enter" the toolbox will transparently map many things (files
> under /dev/, or $HOME) automatically.  At least when thinking this as
> something I use personally, toolbox seems working.  But again I'm not
> container person, maybe there's some difference, just FYI.
>

I had no idea this existed, I'll take a look, thanks!

>> 
>> Any thoughts on this? Could it be useful to anyone? Maybe the stable
>> branch has some similar issues?
>
> I'd be surprised if Michael would need to test stable branch migrations!
> That's IMHO too much work for him.. if it needs to be more than what CI
> covers.  After all, migration is only a submodule in stable maint pov.
>

Oh, not migration, but the idea of building an older codebase. I know
he's dealt with distro repos being broken as well.

>
> That's a good approach.
>
> If you want to go further, you could directly host it on dockerhub, for
> debian or fedora hosts, so other don't need to rebuild anything.
> And everytime there is a new release, we would just add the new image.
>

It would save storage as well. I'm currently keeping a 7.2 build just
because Peter found a bug in it.

> $ ./scripts/qemu-time-machine.sh qemu-system-aarch64 11.1.2 "$@"
> podman run -it --rm \
> -w $(pwd) -v $(pwd):$(pwd) \
> docker.io/qemu-releases/qemu-system-aarch64:11.1.2 \
> /usr/bin/qemu-system-aarch64 "$@"
>
> You can drastically optimize size by using multi-stage builds.
> All images can be based on a common deps image, which contain all
> libraries qemu depend on (~140MB from what I can see on my debian
> system), and then all qemu-* images would be FROM:deps, and they only
> add a single binary inside.
>

Ah true, so I probably don't need the full distro build. And keeping the
build around is also kinda pointless if it can just be rebuilt. I
haven't yet encountered a scenario where a rebuild was necessary
actually.

> Final result would be 140MB for base deps + binary size per image on
> top, (from 3MB to 40MB) per binary. And we could have the whole
> collection of qemu binaries available for everyone with a single script.
>

Good to know, I haven't put too much effort in reducing the size of the
images. Now I'm thinking that if they get quite small, we could also
host a image just with the (non-unit) tests and maybe use it for some
bisecting once a test fails.

> Regards,
> Pierrick

