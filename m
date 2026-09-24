Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46909C98318
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2026 15:30:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9lOs-0000rg-C1; Thu, 24 Sep 2026 11:30:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x9lOg-0000iE-JX
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 11:30:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x9lOc-0000ki-Rw
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 11:30:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790263800;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4gKffk2elZ47MOVCbWGFzsCKuMDIbS6ivEEo3Q0zzNs=;
 b=FpZG//BjElCCXdnPio1LJHLldBIrwNoOsCEYwQFcW62nISljoyh4O8SVNBS+uV9o6ZbD1h
 LBSqdMDKLzMfE6Tzmn3PR5eNCNXsQMtx/wJFdDKU8QgilTRQZTz+YxmyWONROsnB4sBFzJ
 S9t9rzyij5gBuBE6qi/t/+MnXPNTjuQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-271-L216EO6HOXegDgfHnVY3Yw-1; Thu,
 24 Sep 2026 11:29:59 -0400
X-MC-Unique: L216EO6HOXegDgfHnVY3Yw-1
X-Mimecast-MFC-AGG-ID: L216EO6HOXegDgfHnVY3Yw_1790263797
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3DF02180256C; Thu, 24 Sep 2026 15:29:57 +0000 (UTC)
Received: from redhat.com (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0C98941D; Thu, 24 Sep 2026 15:29:55 +0000 (UTC)
Date: Thu, 24 Sep 2026 16:29:53 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Subject: Re: [qemu-web PATCH] contribute: define clear limits on bug report
 volume
Message-ID: <arVB8e0Rzuiu6ZT7@redhat.com>
References: <20260924135634.2626603-1-berrange@redhat.com>
 <877bkaznst.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <877bkaznst.fsf@draig.linaro.org>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Sep 24, 2026 at 04:12:02PM +0100, Alex Bennée wrote:
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
> > Recently QEMU has received a denial of service attack on
> > its bug tracker in the form of 120 reports in 10 minutes,
> > and now repeated by another reporter in the form of 50
> > reports in the same day.
> >
> > Prior to switching security disclosures to the bug tracker,
> > single reporters have submited 18, 22, and 114 bug reports.
> >
> > None of this is sustainable. It is an effective denial of
> > service attack on the project maintainers' time. Every bug
> > report is a TODO item added to someone's workload.
> >
> > It is time to put hard limits on how many bugs, discovered
> > with assitance of automated tools, we are willing to accept
> > in a givenm time frame.
> >
> > This patch proposal suggests
> >
> >  * No more than 5 bugs per week, per reporter
> >  * No more than 10 bugs are permitted to be open at any
> >    time, per reporter.
> >
> > This is explicitly scoped to bugs discovered with the assistance
> > of automated tools. Bugs where a human puts in exclusively
> > personal time / effort to discover a problem are not limited.
> >
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > ---
> >  contribute/report-a-bug.md | 37 +++++++++++++++++++++++++++++++++++++
> >  1 file changed, 37 insertions(+)
> >
> > diff --git a/contribute/report-a-bug.md b/contribute/report-a-bug.md
> > index b506f9f..8fb7b0b 100644
> > --- a/contribute/report-a-bug.md
> > +++ b/contribute/report-a-bug.md
> > @@ -32,6 +32,43 @@ on GitLab, taking into account the following guidance.
> >    triage of their output to validate all findings and reproducer
> >    scenarios prior to submitting a bug report.
> >  
> > +* QEMU policy forbids the bulk filing of large numbers of
> > +  bug disclosures that were generated with automated tools
> > +  (AI/LLM, static analysis, fuzers). Such actions are not
> > +  a benefit to the project, placing an unsustainable burden
> > +  on maintainers.
> > +
> > +  * **No more than 5 bug/security reports, discovered
> > +    with assistance of automated tools, are permitted
> > +    to be filed per week, per reporter.**
> > +  * **No more than 10 bug/security reports, discovered
> > +    with assistance of automated tools are permitted
> > +    to be open at any time, per reporter.**
> > +  * Reporters must refrain from filing any reports
> > +    that would cause these thresholds to be exceeded
> > +    without first obtaining explicit prior permission
> > +    from project maintainers.
> > +  * Reporters are **required** to respond to triage
> > +    comments from maintainers on bugs related to
> > +    automated tools on a timely basis.
> > +  * If at any time, the project maintainers request
> > +    the reporter to stop filing bug reports discovered
> > +    with assistance of automated tools, this must be
> > +    honoured.
> > +
> > +  Ignoring any of the above rules may lead to the bugs being
> > +  mass closed without further triage, even if valid reports.
> > +  In cases where the filing limits are grossly exceeded,
> > +  the reporter's GitLab account may be reported for abuse
> > +  (spam), potentially leading to termination.
> > +
> > +  If intending to file large numbers of bug disclosures
> > +  in aggregate, reporters are expected to invest their
> > +  time in writing patches, providing the patches for
> > +  review, and then further responding to feedback and
> > +  iterating on the patches until a maintainer accepts
> > +  them for it.
> > +
> >  * Reproduce the problem directly with a QEMU command-line. Avoid
> >    frontends and management stacks, to ensure that the bug is in
> >    QEMU itself and not in a frontend and make it easier for
> 
> It comes across as quite a draconian limit but to be honest after a 6
> months of dealing with this flood I'm less inclined to be polite about
> it:

Yes it is draconian.  Aside from the periodic "mass filing"
incidents, what prompted me is seeing the graph you produced
at:

https://www.qemu.org/screenshots/2026-09-culm-issues.svg

We see the increasing gap between open & closed bugs from
March, where we failed to keep up with the flow arriving
on qemu-security@nongnu.org

In July we bulk imported the mails to gitlab, and between
many maintainers we resolved alot over a month. After that
first month though, we reverted to the widening gap, at
the same rate we saw when triage was limited to just
qemu-security@nongnu.org

My reading of that is that even opening up triage to all
QEMU maintainers has not fixed our scaling problem. We
already burnt people out from dealing with these reports
from automated tools.


Ideally I would like reporters to put in more personal effort
beyond the initial bug filing. If they do that then bugs might
get through triage and patch review more effectively and get
closed quicker, allowing filing of more reports.

If reporters put in that more sustained patch curation effort
instead of fire-and-forget, then I expect they wouldn't have
time for filing so many bugs to begin with, making the limit
less of a problem.

Also if they're putting in greater effort, I'd be amenable to
granting them an exception to exceed the limits on bug filing.
IMHO any regular maintainers are implicitly exempt from the
limits given their ongoing beneficial work for the project.

IOW, the bug limit should be a problem primarily for people
working on a "file-and-forget" basis.


Still, I welcome suggestions for other ideas, or if we should
have different limits in some level ? 


With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


