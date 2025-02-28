Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEAA2C19776
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2025 14:13:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1to15n-0002ux-Jv; Fri, 28 Feb 2025 09:11:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.granados@kernel.org>)
 id 1to15l-0002uh-PT
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 09:11:53 -0500
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.granados@kernel.org>)
 id 1to15k-0008AA-0Z
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 09:11:53 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 213156113C;
 Fri, 28 Feb 2025 14:11:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 122DFC4CEE2;
 Fri, 28 Feb 2025 14:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1740751903;
 bh=ZS4A5HGL5Q7BKKq8nM1+4zDW0SconcnIPdWXAIaV6SY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=aFKmrtjn4QYHDIXKWmjXUGVz26YcsQaEV48D8NxPimSWaBuApLA9jz1qIcfT8Bmxn
 7e2DAOhf9BaLlGLNvh6JuUICYU6OkghSq1zY2vt9LeJxA1epEP6iM8RJkx1PyoBURo
 UTA3JxtV0znOX0nrB2t1kQfmxgVMxK0haMdVkhfEdmJkEHVw6YGCKrNVxmJjqpjfLj
 hDM0cEl+txeyyt2MIdQeZ51X7UtQ/Hul4bKkYQBb3hz1ibJphVt4i44jjMCcyHV9IG
 JkS/fiZLqjziAjTnJe1i/V/+k0JRVV1MNnmh7u6l2Q1bgbrOiLKP7vg0lkFIz/LyGZ
 5735eXwZK9E+w==
Date: Fri, 28 Feb 2025 15:11:35 +0100
From: Joel Granados <joel.granados@kernel.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, 
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH] build: Replace meson introspection argument with a
 builddir
Message-ID: <gsypszed7pcgzhtjfjx7ewvulssrwr3uuvgc3tdrcaesnuhket@tvzhmoehna4j>
References: <20250204-jag-fix_meson-v1-1-ecb6bdb1db51@kernel.org>
 <5ea3a240-1805-40f8-9c5d-af12794ea34c@redhat.com>
 <opabljxycyh2huu4yicopg5dkur56pntyehozkrp2tai5orgnz@frubtj4drvma>
 <d788bb12-0d69-43eb-bf09-a94ead71c9e4@redhat.com>
 <CAFEAcA-zfLLwT206J7WFXW_ft-OJARv=UPgY7K54zTgDSPcK8A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA-zfLLwT206J7WFXW_ft-OJARv=UPgY7K54zTgDSPcK8A@mail.gmail.com>
Received-SPF: pass client-ip=172.105.4.254;
 envelope-from=joel.granados@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Thu, Feb 27, 2025 at 10:38:11AM +0000, Peter Maydell wrote:
> On Thu, 27 Feb 2025 at 10:20, Paolo Bonzini <pbonzini@redhat.com> wrote:
> >
> > On 2/27/25 11:07, Joel Granados wrote:
> > > Here is the error I see:
> > > cmd:
> > >    meson introspect --buildoptions /home/joel/src/qemu/meson.build
> > >
> > > output:
> > >    meson.build:88:12: ERROR: Unknown compiler(s): [['rustc']]
> > >    The following exception(s) were encountered:
> > >    Running `rustc --version` gave "[Errno 2] No such file or directory: 'rustc'"
> >
> > Thanks, this helps.
> >
> > > When I pass it a builddir it actually gives me all the buildoptions
> > > (which is what I expect)
> > > cmd:
> > >    meson introspect --buildoptions /home/joel/src/qemu/bdir
> >
> > Yes, the difference is that the builddir version uses the results of
> > actually executing meson.build, whereas the srcdir version only does
> > some cursory parsing and always looks at both branches of "if" statements.
> >
> > This is actually not a bug, and in fact now I remember why it is using
> > the srcdir version...  Looking at the required languages is needed in
> > order to figure out language-dependent build options, and the srcdir
> > version includes the options for all languages that QEMU could use.
> >
> > None of the language-dependent options (for example c_std) are surfaced
> > in meson-buildoptions.sh, which is why your patch works in the first
> > place.  But I think it's a better fix for you to install rustc, since it
> > will anyway become mandatory sooner or later.
> 
> It's not mandatory *now*, though. So I think it would be better
> to fix whatever this problem is rather than papering over it...

Would my fix work even though there is no BUILD_DIR? If I understand
Paolo's point (and please correct me if I don't) this is supposed to run
with and without a builddir. My point being that I would also get an
error if the update-buildoptions target is called with BUILD_DIR =
CURDIR (default value).

cmd:
    meson introspect --buildoptions /home/joel/src/qemu

output:
    Current directory is not a meson build directory.
    Please specify a valid build dir or change the working directory to it.

It is a pity that not finding rustc results in an error and exit instead
of just trimming that if branch but continuing to see what options are
available

Best

-- 

Joel Granados

