Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 959D5C25B78
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 15:48:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBz3c-0007jY-Ln; Tue, 28 May 2024 11:48:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sBz3a-0007iu-U6
 for qemu-devel@nongnu.org; Tue, 28 May 2024 11:48:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sBz3Z-0005im-0w
 for qemu-devel@nongnu.org; Tue, 28 May 2024 11:48:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716911288;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zP3rLZTs+bxjyn5oR3Wz1Pnu0rPmr1FHc5pdiRy24DY=;
 b=VmPjzEeyA08lAcHTiANjflJYebFCR68hkeWoiRBGdj9P2XHUfODldiuEq76SHwlZWQZIja
 iYJDW5w5hRwuhPfBJomTiIUDEuHbJ3JOWVLlla1TPJ5xLgHxtXoizv+cX6Vjn9c4sH2yA1
 8twT4MYEWAg2AU6F4/7nIuKKUNUWOI4=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-6aD7AfA-ND-H8KKoxIDeIw-1; Tue, 28 May 2024 11:48:04 -0400
X-MC-Unique: 6aD7AfA-ND-H8KKoxIDeIw-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-6ab8ca6df0bso2552926d6.3
 for <qemu-devel@nongnu.org>; Tue, 28 May 2024 08:48:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716911284; x=1717516084;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zP3rLZTs+bxjyn5oR3Wz1Pnu0rPmr1FHc5pdiRy24DY=;
 b=QR9i/WuQtAOT+/dJ4UHjp6n6Ej2ffRNi11FwJPusrXQTd/me6f+oZFYm9S8Lfh3pnH
 KbKTfcx7COsvYGRkEKE3KzvVsjzzw/g1oiju2FosNAfvRB7B/ZfdvWy8fuwirx+MbDDg
 +JQ8mWFsNFrGS/6aADDmu4cTbqa8v3CVuspBcIUvF56wy8mOvXv2KHT5a5GY4DdZkVoT
 qc9nxW/CL8eJjcObywTPgXETY3E9dHGNz6kxD33bQLRqNNya4DpalQAU0o7rFkh0EpaQ
 DGMdBdpqYwdxFKYHXniUuljwhON3wi533pICMnmIciEIBASsv0oCIYVPb5W032JcQjcs
 QwWg==
X-Gm-Message-State: AOJu0YwJqcmRrHYO9ah3AazmOwyn3pwGmnydGZ412GzghqYvgES1vXO8
 6SqctskYyNNe4mreQH3gamWQyhLbwyfu/T+hTaPKdOzmMoWP2pecbFFhHRli9iAAyArs1F5sHrQ
 pFzjyU5VnZ5RqtIbDur3QY36VEiEF5LWaG1Est90EBRhjFrKvaART
X-Received: by 2002:a05:6214:c68:b0:699:2d88:744f with SMTP id
 6a1803df08f44-6abcd139763mr136034006d6.4.1716911283639; 
 Tue, 28 May 2024 08:48:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHmgfMY7f6JIsYYHkxN6afEpN8jM0fAlJpArezZs3ouQUbfMrOc7Rug3dcJCnIQ4YMQZgMdng==
X-Received: by 2002:a05:6214:c68:b0:699:2d88:744f with SMTP id
 6a1803df08f44-6abcd139763mr136033686d6.4.1716911283009; 
 Tue, 28 May 2024 08:48:03 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6ac1632099csm45251146d6.127.2024.05.28.08.48.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 May 2024 08:48:02 -0700 (PDT)
Date: Tue, 28 May 2024 11:48:00 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Fiona Ebner <f.ebner@proxmox.com>, Het Gala <het.gala@nutanix.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Subject: Re: [RFC PATCH 4/4] ci: Add the new migration device tests
Message-ID: <ZlX8sNDh2gIFa2Kp@x1n>
References: <20240523201922.28007-1-farosas@suse.de>
 <20240523201922.28007-5-farosas@suse.de> <ZlT4f368xO8fXsUY@x1n>
 <87ttiig62j.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87ttiig62j.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.034,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, May 27, 2024 at 08:59:00PM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > On Thu, May 23, 2024 at 05:19:22PM -0300, Fabiano Rosas wrote:
> >> We have two new migration tests that check cross version
> >> compatibility. One uses the vmstate-static-checker.py script to
> >> compare the vmstate structures from two different QEMU versions. The
> >> other runs a simple migration with a few devices present in the VM, to
> >> catch obvious breakages.
> >> 
> >> Add both tests to the migration-compat-common job.
> >> 
> >> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> >> ---
> >>  .gitlab-ci.d/buildtest.yml | 43 +++++++++++++++++++++++++++++++-------
> >>  1 file changed, 36 insertions(+), 7 deletions(-)
> >> 
> >> diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
> >> index 91c57efded..bc7ac35983 100644
> >> --- a/.gitlab-ci.d/buildtest.yml
> >> +++ b/.gitlab-ci.d/buildtest.yml
> >> @@ -202,18 +202,47 @@ build-previous-qemu:
> >>    needs:
> >>      - job: build-previous-qemu
> >>      - job: build-system-opensuse
> >> -  # The old QEMU could have bugs unrelated to migration that are
> >> -  # already fixed in the current development branch, so this test
> >> -  # might fail.
> >> +  # This test is allowed to fail because:
> >> +  #
> >> +  # - The old QEMU could have bugs unrelated to migration that are
> >> +  #   already fixed in the current development branch.
> >
> > Did you ever hit a real failure with this?  I'm wondering whether we can
> > remove this allow_failure thing.
> >
> 
> I haven't. But when it fails we'll go through an entire release cycle
> with this thing showing red for every person that runs the CI. Remember,
> this is a CI failure to which there's no fix aside from waiting for the
> release to happen. Even if we're quick to react and disable the job, I
> feel it might create some confusion already.

My imagination was if needed we'll get complains and we add that until
then for that broken release only, and remove in the next release again.

> 
> >> +  #
> >> +  # - The vmstate-static-checker script trips on renames and other
> >> +  #   backward-compatible changes to the vmstate structs.
> >
> > I think I keep my preference per last time we talked on this. :)
> 
> Sorry, I'm not trying to force this in any way, I just wrote these to
> use in the pull-request and thought I'd put it out there. At the very
> least we can have your concerns documented. =)

Yep that's fine.  I think we should keep such discussion on the list,
especially we have different opinions, while none of us got convinced yet
so far. :)

> 
> > I still think it's too early to involve a test that can report false
> > negative.
> 
> (1)
> Well, we haven't seen any false negatives, we've seen fields being
> renamed. If that happens, then we'll ask the person to update the
> script. Is that not acceptable to you? Or are you thinking about other
> sorts of issues?

Then question is how to update the script. So far it's treated as failure
on rename, even if it's benign. Right now we have this:

            print("Section \"" + sec + "\",", end=' ')
            print("Description \"" + desc + "\":", end=' ')
            print("expected field \"" + s_item["field"] + "\",", end=' ')
            print("got \"" + d_item["field"] + "\"; skipping rest")
            bump_taint()
            break

Do you want to introduce a list of renamed vmsd fields in this script and
maintain that?  IMHO it's an overkill and unnecessary burden to other
developers.

> 
> > I'd still keep running this before soft-freeze like I used to
> > do, throw issues to others and urge them to fix before release.
> 
> Having hidden procedures that maintainers run before a release is bad
> IMHO, it just delays the catching of bugs and frustrates
> contributors. Imagine working on a series, everything goes well with
> reviews, CI passes, patch gets queued and merged and a month later you
> get a ping about something you should have done to avoid breaking
> migration. Right during freeze.

I understand your point, however I don't yet see a way CI could cover
everything.  CI won't cover performance test, and I still ran multifd tests
at least smoke it too before soft-freeze.

If there's something done wrong, we notify the sooner the better.  Now it
looks to me the best trade-off is like that - we notify at soft-freeze once
per release considering that's pretty rare too, e.g. 9.0 has no such outlier.

Again I'm happy if we have a solution to not report false negatives; that's
the only concern I have.

> 
> > Per my
> > previous experience that doesn't consume me a lot of time, and it's not
> > common to see issues either.
> >
> > So I want people to really pay attention when someone sees a migration CI
> > test failed, rather than we help people form the habit in "oh migration CI
> > failed again?  I think that's fine, it allows failing anyway".
> 
> That's a good point. I don't think it applies here though. See my point
> in (1).

Yes, if you have an answer to (1) I'm ok too.  Maybe I misunderstood your
plan there.

Thanks,

> 
> > So far I still don't see as much benefit to adding this if we need to pay
> > for the other false negative issue.  I'll fully support it if e.g. we can
> > fix the tool to avoid reporting false negatives, but that may take effort
> > that I didn't check.
> >
> 

-- 
Peter Xu


