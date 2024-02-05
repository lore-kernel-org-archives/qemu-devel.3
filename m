Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED5D1C4828D
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Feb 2024 10:50:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWwY1-0001vl-MR; Mon, 05 Feb 2024 05:49:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rWwXx-0001vW-Mv
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 05:49:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rWwXv-0000U6-Jr
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 05:49:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707130190;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=86YIctJPofPnNQiSJ34CfzjgkFUhssq8/5mMBP7HebM=;
 b=aagzGxGoiYdvfzWh9cyCftqhy80vocEnAVJdKsgsWfwe7CJ1XlosY6PWD/XMVjaph3WXyq
 1m4BJzqgsFz5umXaeyhSVNh3T+/iD18sx6t4VOvxF3gd11mDvw82/0EReUJJvNj+M19wwj
 BySTk61HYxr00r7MkGjoVh36YM+SKJs=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-339-_MW6__eyN1OEM8cD9RtVTA-1; Mon,
 05 Feb 2024 05:49:48 -0500
X-MC-Unique: _MW6__eyN1OEM8cD9RtVTA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 768681C06908;
 Mon,  5 Feb 2024 10:49:48 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.69])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 894FE1121313;
 Mon,  5 Feb 2024 10:49:47 +0000 (UTC)
Date: Mon, 5 Feb 2024 10:49:45 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Subject: Re: [PULL 06/14] ci: Add a migration compatibility test job
Message-ID: <ZcC9ScKJ7VvqektA@redhat.com>
References: <20240129030405.177100-1-peterx@redhat.com>
 <20240129030405.177100-7-peterx@redhat.com>
 <CAFEAcA9=7NzEFLQxAxEWUzTRAZm87caC1ZhxeZkKyiP9Kb4k2w@mail.gmail.com>
 <87eddvhtba.fsf@suse.de> <ZcBVGbRXlXPRom14@x1n>
 <ZcC262Tl4j3ryx-8@redhat.com> <ZcC8Q_Dt0S2axc7t@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZcC8Q_Dt0S2axc7t@x1n>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.361,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Feb 05, 2024 at 06:45:23PM +0800, Peter Xu wrote:
> On Mon, Feb 05, 2024 at 10:22:35AM +0000, Daniel P. Berrangé wrote:
> > On Mon, Feb 05, 2024 at 11:25:13AM +0800, Peter Xu wrote:
> > > On Fri, Feb 02, 2024 at 10:47:05AM -0300, Fabiano Rosas wrote:
> > > > Peter Maydell <peter.maydell@linaro.org> writes:
> > > > 
> > > > > On Mon, 29 Jan 2024 at 03:04, <peterx@redhat.com> wrote:
> > > > >>
> > > > >> From: Fabiano Rosas <farosas@suse.de>
> > > > >>
> > > > >> The migration tests have support for being passed two QEMU binaries to
> > > > >> test migration compatibility.
> > > > >>
> > > > >> Add a CI job that builds the lastest release of QEMU and another job
> > > > >> that uses that version plus an already present build of the current
> > > > >> version and run the migration tests with the two, both as source and
> > > > >> destination. I.e.:
> > > > >>
> > > > >>  old QEMU (n-1) -> current QEMU (development tree)
> > > > >>  current QEMU (development tree) -> old QEMU (n-1)
> > > > >>
> > > > >> The purpose of this CI job is to ensure the code we're about to merge
> > > > >> will not cause a migration compatibility problem when migrating the
> > > > >> next release (which will contain that code) to/from the previous
> > > > >> release.
> > > > >>
> > > > >> The version of migration-test used will be the one matching the older
> > > > >> QEMU. That way we can avoid special-casing new tests that wouldn't be
> > > > >> compatible with the older QEMU.
> > > > >>
> > > > >> Note: for user forks, the version tags need to be pushed to gitlab
> > > > >> otherwise it won't be able to checkout a different version.
> > > > >>
> > > > >> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> > > > >> Link: https://lore.kernel.org/r/20240118164951.30350-3-farosas@suse.de
> > > > >> Signed-off-by: Peter Xu <peterx@redhat.com>
> > > > >> ---
> > > > >>  .gitlab-ci.d/buildtest.yml | 60 ++++++++++++++++++++++++++++++++++++++
> > > > >>  1 file changed, 60 insertions(+)
> > > > >>
> > > > >> diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
> > > > >> index e1c7801598..f0b0edc634 100644
> > > > >> --- a/.gitlab-ci.d/buildtest.yml
> > > > >> +++ b/.gitlab-ci.d/buildtest.yml
> > > > >> @@ -167,6 +167,66 @@ build-system-centos:
> > > > >>        x86_64-softmmu rx-softmmu sh4-softmmu nios2-softmmu
> > > > >>      MAKE_CHECK_ARGS: check-build
> > > > >>
> > > > >> +# Previous QEMU release. Used for cross-version migration tests.
> > > > >> +build-previous-qemu:
> > > > >> +  extends: .native_build_job_template
> > > > >> +  artifacts:
> > > > >> +    when: on_success
> > > > >> +    expire_in: 2 days
> > > > >> +    paths:
> > > > >> +      - build-previous
> > > > >> +    exclude:
> > > > >> +      - build-previous/**/*.p
> > > > >> +      - build-previous/**/*.a.p
> > > > >> +      - build-previous/**/*.fa.p
> > > > >> +      - build-previous/**/*.c.o
> > > > >> +      - build-previous/**/*.c.o.d
> > > > >> +      - build-previous/**/*.fa
> > > > >> +  needs:
> > > > >> +    job: amd64-opensuse-leap-container
> > > > >> +  variables:
> > > > >> +    IMAGE: opensuse-leap
> > > > >> +    TARGETS: x86_64-softmmu aarch64-softmmu
> > > > >> +  before_script:
> > > > >> +    - export QEMU_PREV_VERSION="$(sed 's/\([0-9.]*\)\.[0-9]*/v\1.0/' VERSION)"
> > > > >> +    - git checkout $QEMU_PREV_VERSION
> > > > >> +  after_script:
> > > > >> +    - mv build build-previous
> > > > >
> > > > > There seems to be a problem with this new CI job. Running a CI
> > > > > run in my local repository it fails:
> > > > >
> > > > > https://gitlab.com/pm215/qemu/-/jobs/6075873685
> > > > >
> > > > > $ export QEMU_PREV_VERSION="$(sed 's/\([0-9.]*\)\.[0-9]*/v .0/' VERSION)"
> > > > > $ git checkout $QEMU_PREV_VERSION
> > > > > error: pathspec 'v8.2.0' did not match any file(s) known to git
> > > > > Running after_script
> > > > > Running after script...
> > > > > $ mv build build-previous
> > > > > mv: cannot stat 'build': No such file or directory
> > > > > WARNING: after_script failed, but job will continue unaffected: exit code 1
> > > > > Saving cache for failed job
> > > > >
> > > > >
> > > > > I don't think you can assume that private forks doing submaintainer CI
> > > > > runs necessarily have the full set of tags that the main repo does.
> > > > 
> > > > Yes, I thought this would be rare enough not to be an issue, but it
> > > > seems it's not. I don't know what could be done here, if there's no tag,
> > > > then there's no way to resolve the actual commit hash I think.
> > > > 
> > > > > I suspect the sed run will also do the wrong thing when run on the
> > > > > commit that updates the version, because then it will replace
> > > > > "9.0.0" with "9.0.0".
> > > > 
> > > > I just ignored this completly because my initial idea was to leave this
> > > > job disabled and only run it for migration patchsets and pull requests,
> > > > so it wouldn't make sense to run at that commit.
> > > > 
> > > > This job is also not entirely fail proof by design because we could
> > > > always be hitting bugs in the older QEMU version that were already fixed
> > > > in the new version.
> > > > 
> > > > I think the simplest fix here is to leave the test disabled, possibly
> > > > with an env variable to enable it.
> > > 
> > > However if so that'll be unfortunate.. because the goal of the "n-1" test
> > > is to fail the exact commit that will break compatibility and make it
> > > enforced, IMHO.
> > > 
> > > Failing for some migration guy pushing CI can be better than nothing
> > > indeed, but it is just less ideal..  we want the developer / module
> > > maintainer notice this issue, fix it instead of merging something wrong
> > > already, then we try to find what is broken and ask for a fix (where there
> > > will still be a window it's broken; and if unlucky across major releases).
> > > 
> > > Currently the coverage of n-1 test is indeed still more focused on
> > > migration framework, but it'll also cover quite some default configs of the
> > > system layout (even if only x86 is covered), and some default devices IIRC.
> > > We can already attach a few more standard devices in the cmdline so more
> > > things can get covered.
> > > 
> > > A pretty dumb (but might be working?) solution is we keep commit ID rather
> > > than tags to avoid all kinds of tag hassles:
> > > 
> > >   PREVIOUS_VERSION_COMMIT_ID=1600b9f46b1bd08b00fe86c46ef6dbb48cbe10d6
> > > 
> > > Then we boost it after a release.  I think it'll also work for the release
> > > commit then.
> > 
> > Please don't go for hardcoding stuff. AFAICS, the solution is very easy
> > and only requires adding two git commands to the test job:
> > 
> >   export QEMU_PREV_VERSION="$(sed 's/\([0-9.]*\)\.[0-9]*/v\1.0/' VERSION)"
> >   git remote add upstream https://gitlab.com/qemu-project/qemu
> >   git fetch upstream $QEMU_PRRV_VERSION
> >   git checkout $QEMU_PREV_VERSION
> 
> True...  I'm as stupid as I could have. :)  Thanks.
> 
> For the CI test when at exactly the commit to release QEMU: I assume it's
> fine to simply run it with 9.0 <-> 9.0 for example, which is one more time
> of current migration qtest. IIUC that shouldn't be a big deal.

Yes, that should be harmless, and by the time we hit the 9.0 tag,
then it is too late to fix any problem with 8.2 -> 9.0 migration
anyway.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


