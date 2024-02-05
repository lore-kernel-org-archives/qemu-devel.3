Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F5BCC4828F
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Feb 2024 03:26:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWpc3-0000Tm-1F; Sun, 04 Feb 2024 22:25:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rWpbv-0000Ry-9G
 for qemu-devel@nongnu.org; Sun, 04 Feb 2024 22:25:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rWpbs-0002V6-OW
 for qemu-devel@nongnu.org; Sun, 04 Feb 2024 22:25:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707103527;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JI8RQeH8jy759XhrZj+ImgDYZUpARX8XTT0mBTgLaPk=;
 b=D6UM7ssOY9z17++phN1RbKOtEtSjkgMqjNhgppKs05Bl7FYJ8uGEFaNp+0gSyY7mJVGwUW
 5iv3v8+b/KkJ3Vx+tslMgvjQZayjaE2Z3OqpEvby7TJEJQ9VicAmfbrZZrHMCOlYM66BSY
 XRPxlB++APBlHhbU/d/MiHE2xwyz3YY=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-673-5PvEImBtM3uRXqjaXsgZwg-1; Sun, 04 Feb 2024 22:25:25 -0500
X-MC-Unique: 5PvEImBtM3uRXqjaXsgZwg-1
Received: by mail-oo1-f71.google.com with SMTP id
 006d021491bc7-59a5911a619so1060857eaf.0
 for <qemu-devel@nongnu.org>; Sun, 04 Feb 2024 19:25:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707103524; x=1707708324;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JI8RQeH8jy759XhrZj+ImgDYZUpARX8XTT0mBTgLaPk=;
 b=F3NbNCmXTFl4NePXPuLGA648K4oTGFP8NzeFOlvFzzXEmIVIUTH6Teup/3Uuh+mS9S
 /kyJY2ogyBVuwKRfF7eF1eefSxdXxXrxqCKQSeb5JpbVi02+oQiLbxQHAA4wApA60wCn
 2K3jX7mwe7udENfxbi2yqKJ5AhPve+vtLBYFBMoDWv4OrjaHDsD/CEF7aKPoM2Smqob5
 wk2JuEqCF+yNMzjGxnZrpQnLsNxMS+Tra5GjcVVO+RaCujZnrvx9RQ/N7OL4z4K8v3QF
 3q06/QC6I9tnO04Us5RNJN6B261sf+YCVvVpe8Mh0GGn8INB5ZlbxhR+WO+hVzNV1JzH
 PJXQ==
X-Gm-Message-State: AOJu0YysoT/bm9pyx5kz4mGdt3PIOiDgYu30mPT0Eqt9BQbce8nx4uFz
 RTiYo6M0DAw7Pf8YAnK/+awOHRiTkGIaSSCY48736D2dSCU5sxXsIS0wNXKrQF6/iAVfCUpLrlo
 79jQlcDto2Cs1hA5HjFPX6FGvTPCLnhED7Ru9tbOJIAhDH0t9dHkt
X-Received: by 2002:a05:6358:9044:b0:176:c7aa:a764 with SMTP id
 f4-20020a056358904400b00176c7aaa764mr9471040rwf.1.1707103523962; 
 Sun, 04 Feb 2024 19:25:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGPWbR1itKU+yU9Xv7dS3ZGG99RHuVkOWn0r3nSTafkEZ2kvqNbJ/rBPNbBcnxIV6LgwYmYzQ==
X-Received: by 2002:a05:6358:9044:b0:176:c7aa:a764 with SMTP id
 f4-20020a056358904400b00176c7aaa764mr9471030rwf.1.1707103523531; 
 Sun, 04 Feb 2024 19:25:23 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCXPrWw7c9EW0B4Br5zR1tKIqVeYeO4O+4o8LHAPj6vjS83yNMMpERpITTd5DGXRsRYcqosoB572v5u6yr0SWa+zL7HZG4E=
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 n13-20020a65450d000000b005b458aa0541sm4970265pgq.15.2024.02.04.19.25.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Feb 2024 19:25:23 -0800 (PST)
Date: Mon, 5 Feb 2024 11:25:13 +0800
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Subject: Re: [PULL 06/14] ci: Add a migration compatibility test job
Message-ID: <ZcBVGbRXlXPRom14@x1n>
References: <20240129030405.177100-1-peterx@redhat.com>
 <20240129030405.177100-7-peterx@redhat.com>
 <CAFEAcA9=7NzEFLQxAxEWUzTRAZm87caC1ZhxeZkKyiP9Kb4k2w@mail.gmail.com>
 <87eddvhtba.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87eddvhtba.fsf@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Feb 02, 2024 at 10:47:05AM -0300, Fabiano Rosas wrote:
> Peter Maydell <peter.maydell@linaro.org> writes:
> 
> > On Mon, 29 Jan 2024 at 03:04, <peterx@redhat.com> wrote:
> >>
> >> From: Fabiano Rosas <farosas@suse.de>
> >>
> >> The migration tests have support for being passed two QEMU binaries to
> >> test migration compatibility.
> >>
> >> Add a CI job that builds the lastest release of QEMU and another job
> >> that uses that version plus an already present build of the current
> >> version and run the migration tests with the two, both as source and
> >> destination. I.e.:
> >>
> >>  old QEMU (n-1) -> current QEMU (development tree)
> >>  current QEMU (development tree) -> old QEMU (n-1)
> >>
> >> The purpose of this CI job is to ensure the code we're about to merge
> >> will not cause a migration compatibility problem when migrating the
> >> next release (which will contain that code) to/from the previous
> >> release.
> >>
> >> The version of migration-test used will be the one matching the older
> >> QEMU. That way we can avoid special-casing new tests that wouldn't be
> >> compatible with the older QEMU.
> >>
> >> Note: for user forks, the version tags need to be pushed to gitlab
> >> otherwise it won't be able to checkout a different version.
> >>
> >> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> >> Link: https://lore.kernel.org/r/20240118164951.30350-3-farosas@suse.de
> >> Signed-off-by: Peter Xu <peterx@redhat.com>
> >> ---
> >>  .gitlab-ci.d/buildtest.yml | 60 ++++++++++++++++++++++++++++++++++++++
> >>  1 file changed, 60 insertions(+)
> >>
> >> diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
> >> index e1c7801598..f0b0edc634 100644
> >> --- a/.gitlab-ci.d/buildtest.yml
> >> +++ b/.gitlab-ci.d/buildtest.yml
> >> @@ -167,6 +167,66 @@ build-system-centos:
> >>        x86_64-softmmu rx-softmmu sh4-softmmu nios2-softmmu
> >>      MAKE_CHECK_ARGS: check-build
> >>
> >> +# Previous QEMU release. Used for cross-version migration tests.
> >> +build-previous-qemu:
> >> +  extends: .native_build_job_template
> >> +  artifacts:
> >> +    when: on_success
> >> +    expire_in: 2 days
> >> +    paths:
> >> +      - build-previous
> >> +    exclude:
> >> +      - build-previous/**/*.p
> >> +      - build-previous/**/*.a.p
> >> +      - build-previous/**/*.fa.p
> >> +      - build-previous/**/*.c.o
> >> +      - build-previous/**/*.c.o.d
> >> +      - build-previous/**/*.fa
> >> +  needs:
> >> +    job: amd64-opensuse-leap-container
> >> +  variables:
> >> +    IMAGE: opensuse-leap
> >> +    TARGETS: x86_64-softmmu aarch64-softmmu
> >> +  before_script:
> >> +    - export QEMU_PREV_VERSION="$(sed 's/\([0-9.]*\)\.[0-9]*/v\1.0/' VERSION)"
> >> +    - git checkout $QEMU_PREV_VERSION
> >> +  after_script:
> >> +    - mv build build-previous
> >
> > There seems to be a problem with this new CI job. Running a CI
> > run in my local repository it fails:
> >
> > https://gitlab.com/pm215/qemu/-/jobs/6075873685
> >
> > $ export QEMU_PREV_VERSION="$(sed 's/\([0-9.]*\)\.[0-9]*/v .0/' VERSION)"
> > $ git checkout $QEMU_PREV_VERSION
> > error: pathspec 'v8.2.0' did not match any file(s) known to git
> > Running after_script
> > Running after script...
> > $ mv build build-previous
> > mv: cannot stat 'build': No such file or directory
> > WARNING: after_script failed, but job will continue unaffected: exit code 1
> > Saving cache for failed job
> >
> >
> > I don't think you can assume that private forks doing submaintainer CI
> > runs necessarily have the full set of tags that the main repo does.
> 
> Yes, I thought this would be rare enough not to be an issue, but it
> seems it's not. I don't know what could be done here, if there's no tag,
> then there's no way to resolve the actual commit hash I think.
> 
> > I suspect the sed run will also do the wrong thing when run on the
> > commit that updates the version, because then it will replace
> > "9.0.0" with "9.0.0".
> 
> I just ignored this completly because my initial idea was to leave this
> job disabled and only run it for migration patchsets and pull requests,
> so it wouldn't make sense to run at that commit.
> 
> This job is also not entirely fail proof by design because we could
> always be hitting bugs in the older QEMU version that were already fixed
> in the new version.
> 
> I think the simplest fix here is to leave the test disabled, possibly
> with an env variable to enable it.

However if so that'll be unfortunate.. because the goal of the "n-1" test
is to fail the exact commit that will break compatibility and make it
enforced, IMHO.

Failing for some migration guy pushing CI can be better than nothing
indeed, but it is just less ideal..  we want the developer / module
maintainer notice this issue, fix it instead of merging something wrong
already, then we try to find what is broken and ask for a fix (where there
will still be a window it's broken; and if unlucky across major releases).

Currently the coverage of n-1 test is indeed still more focused on
migration framework, but it'll also cover quite some default configs of the
system layout (even if only x86 is covered), and some default devices IIRC.
We can already attach a few more standard devices in the cmdline so more
things can get covered.

A pretty dumb (but might be working?) solution is we keep commit ID rather
than tags to avoid all kinds of tag hassles:

  PREVIOUS_VERSION_COMMIT_ID=1600b9f46b1bd08b00fe86c46ef6dbb48cbe10d6

Then we boost it after a release.  I think it'll also work for the release
commit then.

Note that there can be a small window we run n-2 -> n test at the start,
but that's fine IMHO, as we should still allow that to work.  Fabiano's
"auto choose latest shared machine type" would be useful here, and I
assume it should just work.

With that, we try to figure something that can be smarter.  Would that
work for us?

-- 
Peter Xu


