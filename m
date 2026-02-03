Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AD46E83070
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 09:44:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnCwN-0000nD-IF; Tue, 03 Feb 2026 04:43:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vnCwL-0000mz-Q4
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 04:43:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vnCwJ-0002dV-Uc
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 04:43:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770111798;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=G4Q8ycdDkxhNWpw3u318TtemxBsyO0c5xv2s0gLP1uM=;
 b=EjwJ0FWjkOiKLKr5Ai3ai+dN73dmcWqIWkvki//d7zTtwqN0AqqekQLaWXX4jGXiqVEX2s
 FADfy4Xkm4Zrvsra6jm0Y8M/llT2S2NQ5QPYP+uw/V6opKxV0OkqD9RXy1TwkoDZMr/YXh
 o6CtuUz46akZfZw6D3vyp/W4bbvCK5w=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-600-nTwZbPgDPd6pqfJM9Mix9w-1; Tue,
 03 Feb 2026 04:43:15 -0500
X-MC-Unique: nTwZbPgDPd6pqfJM9Mix9w-1
X-Mimecast-MFC-AGG-ID: nTwZbPgDPd6pqfJM9Mix9w_1770111794
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B798619560B2; Tue,  3 Feb 2026 09:43:13 +0000 (UTC)
Received: from redhat.com (unknown [10.45.226.45])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A7C7619560B4; Tue,  3 Feb 2026 09:43:09 +0000 (UTC)
Date: Tue, 3 Feb 2026 09:43:05 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Warner Losh <imp@bsdimp.com>
Cc: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Joe Perches <joe@perches.com>, John Snow <jsnow@redhat.com>
Subject: Re: [RFC PATCH v2 08/16] MAINTAINERS: be realistic about *-user
Message-ID: <aYHDKafOxzPL8DhL@redhat.com>
References: <20260123145750.1200879-1-alex.bennee@linaro.org>
 <20260123145750.1200879-9-alex.bennee@linaro.org>
 <CANCZdfo3yz=aC-EOxd2LYBX=tf=RQTY6ibCpj-fCfGHZtH6WTw@mail.gmail.com>
 <aXOok4KRTvgwx7GJ@redhat.com>
 <CANCZdfoXfeBh5For_Cag+191GkjDtsqBNZ4LU1g2DYepkYoaBw@mail.gmail.com>
 <CANCZdfqBKMt5qxfrEhudTbrkMzKRzVATuTWXnRnPttVj6UZ5HA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANCZdfqBKMt5qxfrEhudTbrkMzKRzVATuTWXnRnPttVj6UZ5HA@mail.gmail.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Feb 02, 2026 at 02:57:57PM -0700, Warner Losh wrote:
> Just to follow up....
> 
> On Fri, Jan 23, 2026 at 3:14 PM Warner Losh <imp@bsdimp.com> wrote:
> 
> >
> >
> > On Fri, Jan 23, 2026 at 9:58 AM Daniel P. Berrangé <berrange@redhat.com>
> > wrote:
> >
> >> On Fri, Jan 23, 2026 at 08:12:33AM -0700, Warner Losh wrote:
> >> > On Fri, Jan 23, 2026 at 8:00 AM Alex Bennée <alex.bennee@linaro.org>
> >> wrote:
> >> >
> >> > > We should reflect the current status so users don't have unrealistic
> >> > > expectations of how quickly things can get reviewed and merged.
> >> > >
> >> > > Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> >> > >
> >> >
> >> > Reviewed-by: Warner Losh <imp@bsdimp.com>
> >>
> >> snip
> >>
> >> > A lot of the upstreaming work that's stalled would be ideal to tell
> >> claude
> >> > to do,
> >> > but I'm unsure the project's stance on using claude to move code, and
> >> git
> >> > log
> >> > 5 different trees to get the original author(s) of the code and make
> >> > trivial compile
> >> > tweaks.
> >>
> >> The critical thing we don't want is such tools making changes to the
> >> contents of source files.
> >>
> >> Automating the moving around of files is a non-issue.
> >>
> >> The use of AI for writing commit messages is arguably in scope of QEMU's
> >> AI policy given that is part of "the contribution", but it is less serious
> >> there, since commit messages don't have a copyright implication on what we
> >> host & distribute.
> >>
> >> More important is that the commit messages are accurate and well written.
> >> LLMs have a tendancy to be overly verbose about irrelevant stuff, and of
> >> course the well known danger of hallucinating nonsense. IME that makes it
> >> challenging to benefit from an LLM, due to review & re-writing overheads
> >> you then incurr to validate and fix their output.
> >>
> >
> > Yea, the commit messages llm would generate is 'do function X' and I'd then
> > fill it in from there, changing everything except X.
> >
> >
> >> I'd be wary of relying on an AI to extract and report on authorship of
> >> code. Accuracy is important there since it implies copyright ownership
> >> associations. Likewise a Signed-off-by tag should be added by humans
> >> only since it is a statement they are complying with the DCO policy.
> >>
> >
> > I'd be verifying everything done. Verification is relatively easy,
> > extraction is
> > the hard part. And the range of people it could be is tiny, so I'd know if
> > it
> > was making stuff up, or had gone off the rails...  And I'd have it add
> > something
> > like 'Supposed-author: ' that I'd change once I verified it. That's ugly
> > grunt work,
> > but ugly grunt work I can do in an hour or two rather than the dozens of
> > hours
> > it usually takes me to do the extraction...
> >
> 
> So, claude looks likeit's doing a passing fair job at this work. I plan on
> submitting
> a patch series for one of the minor files in the coming weeks (depending on
> how much time I can find to work on it). Any guidance you can give me up
> front?
> 
> Before I submit, I plan on auditing every single change to make sure claude
> didn't introduce anything that's not in bsd-user's blitz branch. Make sure
> the authors
> are correct to the same level that I've been doing so far. And make sure
> I've rewritten
> all the commit messages.
> 
> One question I have, should include these lines
>     🤖 Generated with [Claude Code](https://claude.com/claude-code)
>     Co-Authored-By: Claude <noreply@anthropic.com>

Commit message tags like this are considered to be referring to the
code in the commit body, so that would be potentially misleading.

Personally, I also don't like the concept of providing free advertizing
for commercial tools in commit messages.

If you've exclusively used it for commit metadata, then IMHO it would
be sufficient to just mention this in the cover letter description,
and explicitly say it had no part in writing the code, etc.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


