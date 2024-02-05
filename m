Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC769C48291
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Feb 2024 10:46:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWwU4-0000Dw-8M; Mon, 05 Feb 2024 05:45:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rWwTr-0000D3-Mc
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 05:45:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rWwTp-0008Fa-1V
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 05:45:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707129936;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Pn3BS2AYbJZfQIhbGBDXJAZpss/OXkRfwtr7btZHrPY=;
 b=ABp0KpHzDvvEk+Qq0b5M2Rh9D9ETWPyJD7ZZhj7FXoHAJjg2HCvQqNY/7NoTWXkwbQwLFC
 WdiDWoIXEpNm35FsIiLxZm9JiysfM1EYvM2wVINlTH+dovln9TouLzi/2fVv6C+x6IM4Bw
 TD/hA3jOB2PEBC0lHjvpuaYEeBGF+vA=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-nhcA6WPoNMG3gtgpoQlpvg-1; Mon, 05 Feb 2024 05:45:34 -0500
X-MC-Unique: nhcA6WPoNMG3gtgpoQlpvg-1
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-2961d20fe78so1133892a91.1
 for <qemu-devel@nongnu.org>; Mon, 05 Feb 2024 02:45:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707129933; x=1707734733;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Pn3BS2AYbJZfQIhbGBDXJAZpss/OXkRfwtr7btZHrPY=;
 b=Y4wpjUhZwtF5wQdrUaubym+kXS9gVy+blZ5h2Z10WkcJQ/d+Zlkkz0L7ilx50CllSf
 Yfxvd8h/ruAaLP0PpkB5oUoYLDNg6FWfgJiyF0uxfFnb7pHVQW65Z/JH+xa+Cm1tYSUD
 mfr9g5kQSTlqZpjnzlFesVAaSt8lh88fcRR4p+0eAybkkJkWpFV4aZFZr8eYU6At5sAz
 V8anzjhYPFSLOOcstGMQcAy9XEV7VNuE7Ccbls8a/f3EmFpkhBTNp1IetSrRNptQ+a4g
 vLwvnAAnOTwYpsswsAYvp6088ZexLFqc0HVV3zDOqJ6hUg2heaYT1CWaMr3AlHfQ7PaK
 eA6Q==
X-Forwarded-Encrypted: i=0;
 AJvYcCVW9qmZZqbScpLlzgc6hAD6R+hV/NrMfB3cLiaBq836w5oEbC8OfX44Fpl55k8CAdWmorP5cKhwkAab+TGRvriDxx2CHtU=
X-Gm-Message-State: AOJu0YyDDztcHEM/p/ucDwDV8nFva+h/9MwWfJVPK27loMDljds7XPd+
 nL/RziUs6FrHeUdUADM7R/s5TL7+lTGlZtK4szF6zKU0G/QAph9+iYiUuh/k7r0tt2pLZxKdlfu
 WvbQ7uWH/D5yJoyv4AIxymFHn20jKQtnRRKzuhiddMUpm5V3jbp9koFrSXsKUtpM=
X-Received: by 2002:a17:90b:4a01:b0:296:a64c:b665 with SMTP id
 kk1-20020a17090b4a0100b00296a64cb665mr1176969pjb.1.1707129932971; 
 Mon, 05 Feb 2024 02:45:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH/Uvdp4nwFfnE1syShzN2p9K9vN+SN/b/e7wj6khnoH6CjRMyDlLXdrZ+Dyfpf8Ud6UmYpaQ==
X-Received: by 2002:a17:90b:4a01:b0:296:a64c:b665 with SMTP id
 kk1-20020a17090b4a0100b00296a64cb665mr1176960pjb.1.1707129932566; 
 Mon, 05 Feb 2024 02:45:32 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCWL+9SP5FMhkoLkvnP8/dYyH8axDVY+kn+YyIuEwI7Lj3dKhYH5MAYUuGY18t6nzNhYPzrTOho4vVzZCblcERSByV0+vjA8EKkIxfp46xynpa+rl6O8RxpFN0FsTA7mLQ==
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 in4-20020a17090b438400b002964dca34fasm4888202pjb.4.2024.02.05.02.45.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Feb 2024 02:45:32 -0800 (PST)
Date: Mon, 5 Feb 2024 18:45:23 +0800
From: Peter Xu <peterx@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Subject: Re: [PULL 06/14] ci: Add a migration compatibility test job
Message-ID: <ZcC8Q_Dt0S2axc7t@x1n>
References: <20240129030405.177100-1-peterx@redhat.com>
 <20240129030405.177100-7-peterx@redhat.com>
 <CAFEAcA9=7NzEFLQxAxEWUzTRAZm87caC1ZhxeZkKyiP9Kb4k2w@mail.gmail.com>
 <87eddvhtba.fsf@suse.de> <ZcBVGbRXlXPRom14@x1n>
 <ZcC262Tl4j3ryx-8@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZcC262Tl4j3ryx-8@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.361,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Mon, Feb 05, 2024 at 10:22:35AM +0000, Daniel P. Berrangé wrote:
> On Mon, Feb 05, 2024 at 11:25:13AM +0800, Peter Xu wrote:
> > On Fri, Feb 02, 2024 at 10:47:05AM -0300, Fabiano Rosas wrote:
> > > Peter Maydell <peter.maydell@linaro.org> writes:
> > > 
> > > > On Mon, 29 Jan 2024 at 03:04, <peterx@redhat.com> wrote:
> > > >>
> > > >> From: Fabiano Rosas <farosas@suse.de>
> > > >>
> > > >> The migration tests have support for being passed two QEMU binaries to
> > > >> test migration compatibility.
> > > >>
> > > >> Add a CI job that builds the lastest release of QEMU and another job
> > > >> that uses that version plus an already present build of the current
> > > >> version and run the migration tests with the two, both as source and
> > > >> destination. I.e.:
> > > >>
> > > >>  old QEMU (n-1) -> current QEMU (development tree)
> > > >>  current QEMU (development tree) -> old QEMU (n-1)
> > > >>
> > > >> The purpose of this CI job is to ensure the code we're about to merge
> > > >> will not cause a migration compatibility problem when migrating the
> > > >> next release (which will contain that code) to/from the previous
> > > >> release.
> > > >>
> > > >> The version of migration-test used will be the one matching the older
> > > >> QEMU. That way we can avoid special-casing new tests that wouldn't be
> > > >> compatible with the older QEMU.
> > > >>
> > > >> Note: for user forks, the version tags need to be pushed to gitlab
> > > >> otherwise it won't be able to checkout a different version.
> > > >>
> > > >> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> > > >> Link: https://lore.kernel.org/r/20240118164951.30350-3-farosas@suse.de
> > > >> Signed-off-by: Peter Xu <peterx@redhat.com>
> > > >> ---
> > > >>  .gitlab-ci.d/buildtest.yml | 60 ++++++++++++++++++++++++++++++++++++++
> > > >>  1 file changed, 60 insertions(+)
> > > >>
> > > >> diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
> > > >> index e1c7801598..f0b0edc634 100644
> > > >> --- a/.gitlab-ci.d/buildtest.yml
> > > >> +++ b/.gitlab-ci.d/buildtest.yml
> > > >> @@ -167,6 +167,66 @@ build-system-centos:
> > > >>        x86_64-softmmu rx-softmmu sh4-softmmu nios2-softmmu
> > > >>      MAKE_CHECK_ARGS: check-build
> > > >>
> > > >> +# Previous QEMU release. Used for cross-version migration tests.
> > > >> +build-previous-qemu:
> > > >> +  extends: .native_build_job_template
> > > >> +  artifacts:
> > > >> +    when: on_success
> > > >> +    expire_in: 2 days
> > > >> +    paths:
> > > >> +      - build-previous
> > > >> +    exclude:
> > > >> +      - build-previous/**/*.p
> > > >> +      - build-previous/**/*.a.p
> > > >> +      - build-previous/**/*.fa.p
> > > >> +      - build-previous/**/*.c.o
> > > >> +      - build-previous/**/*.c.o.d
> > > >> +      - build-previous/**/*.fa
> > > >> +  needs:
> > > >> +    job: amd64-opensuse-leap-container
> > > >> +  variables:
> > > >> +    IMAGE: opensuse-leap
> > > >> +    TARGETS: x86_64-softmmu aarch64-softmmu
> > > >> +  before_script:
> > > >> +    - export QEMU_PREV_VERSION="$(sed 's/\([0-9.]*\)\.[0-9]*/v\1.0/' VERSION)"
> > > >> +    - git checkout $QEMU_PREV_VERSION
> > > >> +  after_script:
> > > >> +    - mv build build-previous
> > > >
> > > > There seems to be a problem with this new CI job. Running a CI
> > > > run in my local repository it fails:
> > > >
> > > > https://gitlab.com/pm215/qemu/-/jobs/6075873685
> > > >
> > > > $ export QEMU_PREV_VERSION="$(sed 's/\([0-9.]*\)\.[0-9]*/v .0/' VERSION)"
> > > > $ git checkout $QEMU_PREV_VERSION
> > > > error: pathspec 'v8.2.0' did not match any file(s) known to git
> > > > Running after_script
> > > > Running after script...
> > > > $ mv build build-previous
> > > > mv: cannot stat 'build': No such file or directory
> > > > WARNING: after_script failed, but job will continue unaffected: exit code 1
> > > > Saving cache for failed job
> > > >
> > > >
> > > > I don't think you can assume that private forks doing submaintainer CI
> > > > runs necessarily have the full set of tags that the main repo does.
> > > 
> > > Yes, I thought this would be rare enough not to be an issue, but it
> > > seems it's not. I don't know what could be done here, if there's no tag,
> > > then there's no way to resolve the actual commit hash I think.
> > > 
> > > > I suspect the sed run will also do the wrong thing when run on the
> > > > commit that updates the version, because then it will replace
> > > > "9.0.0" with "9.0.0".
> > > 
> > > I just ignored this completly because my initial idea was to leave this
> > > job disabled and only run it for migration patchsets and pull requests,
> > > so it wouldn't make sense to run at that commit.
> > > 
> > > This job is also not entirely fail proof by design because we could
> > > always be hitting bugs in the older QEMU version that were already fixed
> > > in the new version.
> > > 
> > > I think the simplest fix here is to leave the test disabled, possibly
> > > with an env variable to enable it.
> > 
> > However if so that'll be unfortunate.. because the goal of the "n-1" test
> > is to fail the exact commit that will break compatibility and make it
> > enforced, IMHO.
> > 
> > Failing for some migration guy pushing CI can be better than nothing
> > indeed, but it is just less ideal..  we want the developer / module
> > maintainer notice this issue, fix it instead of merging something wrong
> > already, then we try to find what is broken and ask for a fix (where there
> > will still be a window it's broken; and if unlucky across major releases).
> > 
> > Currently the coverage of n-1 test is indeed still more focused on
> > migration framework, but it'll also cover quite some default configs of the
> > system layout (even if only x86 is covered), and some default devices IIRC.
> > We can already attach a few more standard devices in the cmdline so more
> > things can get covered.
> > 
> > A pretty dumb (but might be working?) solution is we keep commit ID rather
> > than tags to avoid all kinds of tag hassles:
> > 
> >   PREVIOUS_VERSION_COMMIT_ID=1600b9f46b1bd08b00fe86c46ef6dbb48cbe10d6
> > 
> > Then we boost it after a release.  I think it'll also work for the release
> > commit then.
> 
> Please don't go for hardcoding stuff. AFAICS, the solution is very easy
> and only requires adding two git commands to the test job:
> 
>   export QEMU_PREV_VERSION="$(sed 's/\([0-9.]*\)\.[0-9]*/v\1.0/' VERSION)"
>   git remote add upstream https://gitlab.com/qemu-project/qemu
>   git fetch upstream $QEMU_PRRV_VERSION
>   git checkout $QEMU_PREV_VERSION

True...  I'm as stupid as I could have. :)  Thanks.

For the CI test when at exactly the commit to release QEMU: I assume it's
fine to simply run it with 9.0 <-> 9.0 for example, which is one more time
of current migration qtest. IIUC that shouldn't be a big deal.

-- 
Peter Xu


