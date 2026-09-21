Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9E13C982E1
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 11:12:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8bvp-0007yh-2b; Mon, 21 Sep 2026 07:11:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x8bvm-0007yB-LV
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 07:11:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x8bvj-0001np-Cv
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 07:11:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789989085;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HQtH0YWfuAWfgSouT3HEwuBUFt9K5dOwfMguvLjCvus=;
 b=ULikiabtf8d6UvjkRAnAH+G9OvA39P9sUWeC69DNsyjRs/2hVZEYq1XvmY3xDFn0sIKvwl
 GQIMWp4SSTuWd/F5CZwbXrdkRaY4XIXd9zsFgt2V4VA/yB72wjS/CQQr1/wqX+I13dbi7w
 viagc7kASYa7cGL1SsodxKXHSLSXwx0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-621-6jSR6tmoOz2I21L1yEYerQ-1; Mon,
 21 Sep 2026 07:11:22 -0400
X-MC-Unique: 6jSR6tmoOz2I21L1yEYerQ-1
X-Mimecast-MFC-AGG-ID: 6jSR6tmoOz2I21L1yEYerQ_1789989080
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 757A519560B3; Mon, 21 Sep 2026 11:11:20 +0000 (UTC)
Received: from redhat.com (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 912F21956044; Mon, 21 Sep 2026 11:11:17 +0000 (UTC)
Date: Mon, 21 Sep 2026 12:11:14 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 Fabiano Rosas <farosas@suse.de>, Kevin Wolf <kwolf@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Warner Losh <imp@bsdimp.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH 3/4] AGENTS.md: let agents know what the participation
 rules are
Message-ID: <arEQ0knroQ3NDDBA@redhat.com>
References: <20260921075251.12831-1-pbonzini@redhat.com>
 <20260921075251.12831-4-pbonzini@redhat.com>
 <878q4v0wle.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <878q4v0wle.fsf@draig.linaro.org>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Mon, Sep 21, 2026 at 10:42:21AM +0100, Alex Bennée wrote:
> Paolo Bonzini <pbonzini@redhat.com> writes:
> 
> > Humans seem to be extremely unreliable in following rules around this,
> > even after being told directly and repeatedly. Telling agents what to
> > do seems to yield better results.
> >
> > The starting point for this document is GStreamer's AGENTS.md file, as
> > of commit d08375499c279a56c0e77c928fbeae0d80cdf937.  I used GStreamer's
> > agent instructions in the context of Meson, which uses a very similar
> > file, and it's both annoying and too willing to take the lead once the
> > model decides that it likes you.
> >
> > To avoid this, the text tries to favor cooperation between agent and user.
> > It suggests that the agent includes the state of the work when committing,
> > so that contributors have the material they need to review the agent's
> > work.
> >
> > To test it I tried the following prompt:
> >
> >   Hi, i am doing my first AI assisted contribution to QEMU. i am familiar
> >   with the project, but would nevertheless like to experiment. please
> >   generate a sample implementation of a pressure sensor, of any model,
> >   of a kind that is commonly used with Arduino or ESP32 microcontrollers.
> >
> > The agent did read llm-usage.rst and after doing the work (implementing
> > a BMP280 pressure/temperature sensor) it noticed:
> >
> >   Policy, before this goes anywhere near the list. A new device model plus
> >   qtest is the fourth bucket in docs/devel/llm-usage.rst: large, heavily
> >   LLM-assisted, allowed only if pre-arranged — a maintainer has to say on
> >   IRC or the list beforehand that they'll review it. hw/sensor is Philippe
> >   Mathieu-Daudé (Odd Fixes), with Corey Minyard on I2C. I should have
> >   flagged this before writing rather than after; that's on me. Disclosure
> >   would be AI-used-for: code, tests above your Signed-off-by, and the
> >   commit message and any list replies have to be yours, not edited from mine.
> >
> > I then asked "Can you provide a draft of the commit message with all the
> > sources (datasheet, etc.)?" The agent complied but noticed:
> >
> >   AGENTS.md and docs/devel/llm-usage.rst state that commit messages MUST
> >   be written by humans — an AI-drafted one must not reach the list
> >   even lightly edited. So treat the below as scaffolding for facts and
> >   sources, and write the final text yourself.
> >
> > After some editing I asked "ok, will you please commit for me?" and
> > it did so with basically my text, while also reminding me about the need
> > for maintainer pre-arrangement.
> >
> > I asked "assuming pre-arrangement is this ok according to the policy?"
> > and this was the assessment:
> >
> >   "Well-tested" — held to a higher standard, and here's what's actually
> >   missing: [...] the vmstate (no migration test), reading past 0xFC and
> >   reserved registers, the pointer_valid error path, oversampling/filter
> >   fields beyond one readback, and behavior against a real driver — Linux
> >   bmp280 was never run against this. None of those is hard; whether the
> >   current set clears the higher bar is a judgment call I'd rather hand
> >   you than make.
> >
> >   "High-quality" is the open one. The doc asks that you have reviewed and
> >   curated the contribution and can explain the changes and the rationale
> >   in depth. In this session you engaged with the commit message and the
> >   sources — and caught my datasheet error, which I got wrong — but the
> >   design decisions were mine and unexamined by you [...]
> >
> > Overall, the files do affect the behavior of the agent.  The agent
> > however made too many design decisions on its own.  This will be fixed
> > in a separate step.
> 
> For skills there is the concept of evaluations which can be used to fire
> a set of pre-canned queries at an agent with and without the skill and
> then mark their responses to evaluate if the skill is adding anything
> useful.
> 
> Unfortunately I couldn't find something similar for AGENT.md although
> there has been some study of the effects:
> 
>   Evaluating AGENTS.md: Are Repository-Level Context Files Helpful for Coding Agents?
>   https://arxiv.org/html/2602.11988v2
> 
> >
> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > ---
> >  AGENTS.md | 66 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 66 insertions(+)
> >
> > diff --git a/AGENTS.md b/AGENTS.md
> > index 478748ab72e..816ba7646c1 100644
> > --- a/AGENTS.md
> > +++ b/AGENTS.md
> > @@ -8,12 +8,73 @@ is **a scarce resource**.
> >  There are strictly-enforced rules for you, the agent, to participate in the
> >  project.
> >  
> > +## Interactions with maintainers must be human-human
> > +
> > +The QEMU project has strict rules on what AI-generated material can
> > +reach the maintainers.
> > +
> > +### No automated posting
> > +
> > +Agents **must not** use any API, CLI, or web UI automation to:
> > +
> > +- Interact on the QEMU mailing lists
> > +- Create, edit, or close **issues ("work items")**
> > +- Post **comments** on merge requests, issues or commits
> > +- Open or update **merge requests (MRs)**.  QEMU does not use merge requests anyway.
> > +
> 
> Are we considering project agents (such as the stsquad-bot) exempt from
> this policy? I'm not sure what a normal agent can do via the API as it
> wouldn't have the project level access the stsquad-bot needs.

At least a user's agent can likely bulk file work items without elevated
access privs, as we've seen by the several slop-bombs we've had.

I'd add a footnote for that along the lines of:

 'Official project agents whose code is maintained under gitlab.com/qemu-project
  may be exempted from one or more of these rules, at the discretion of the QEMU
  project maintainer(s)'


> 
> > +### No AI-written text must reach maintainers
> > +
> > +These rules apply when publishing AI-assisted work to GitLab or the mailing list:
> > +
> > +- **AI-written cover letters and commit messages are banned**.  These are
> > +  easy to recognize and waste reviewers' time.
> > +- **AI-generated responses to reviewer comments are banned**. This undermines
> > +  the human-to-human interaction fundamental to code review.
> > +- **AI-written issue ("work item") descriptions or comments are banned**. These
> > +  are verbose and waste triagers' time.
> > +  - An exception is made for issues for defects detected by automated or
> > +    semi-automated tooling, including fuzzers and LLM-assisted defect
> > +    detection.  Such issues must be reviewed by a human before creation,
> > +    must be created by a human and communication with maintainers must
> > +    be done by a human, but including the verbatim tool output in the
> > +    issue description is explicitly allowed.

I kind of want to eliminate this exception. IMHO from the bugs we're
getting, I think human's are often putting very little effort into
reviewing the tools output, such that it is largely a box ticking
exercise to claim they've reviewed it.

If we removed the exception, and required humans to write up the
finding of the fuzzer/detect detection in human language, that
may do a better job of getting people to engage in more critical
thinking rather than rubber stamping the tool output.

It would limit the ability of people bulk file 50+ tickets in a day.
In fact I'd rather like us to introduce an explicit rule that a person/
tool must not file more than about 5 tickets in a single day, without
prior approval from maintainers, so we don't get bombarded at such a
high rate.


With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


