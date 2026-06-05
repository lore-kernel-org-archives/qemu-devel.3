Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B36A0CD6E5D
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2026 09:40:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVR1b-0000ej-Vp; Fri, 05 Jun 2026 05:39:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wVR1a-0000eM-6u
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 05:39:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wVR1Y-0003zD-AD
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 05:39:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780652370;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hVJCtJa3qbtHMmnKXtfLPqPKtacZNnz8hDQ8XiQQBjY=;
 b=iCWHMfJ2NeZ0u8I0YtRic6aB7L2eVGDrBNo5omZsGjo5BMRUep90pkHpKeH7BVf4Go0XfQ
 2cu+YXjZRXRQYmcw52Dhuzb8aarK86LJ4JZwrOiFAL/+aYokPZt2bMvxzG8cz+OaCAewRQ
 6xBt4hwnfTN2CyHytZV/h+Rr3wQnSS8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-593-6p-1vf1WPL2WTT_aa1Nl2w-1; Fri,
 05 Jun 2026 05:39:25 -0400
X-MC-Unique: 6p-1vf1WPL2WTT_aa1Nl2w-1
X-Mimecast-MFC-AGG-ID: 6p-1vf1WPL2WTT_aa1Nl2w_1780652364
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 633151800366; Fri,  5 Jun 2026 09:39:23 +0000 (UTC)
Received: from redhat.com (unknown [10.44.50.34])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9F18A1771; Fri,  5 Jun 2026 09:39:19 +0000 (UTC)
Date: Fri, 5 Jun 2026 10:39:15 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 Fabiano Rosas <farosas@suse.de>, Kevin Wolf <kwolf@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Warner Losh <imp@bsdimp.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v2] docs/devel: relax policy on AI-generated contributions
Message-ID: <aiKZQ2VVnERuUKt0@redhat.com>
References: <20260529094619.1034458-1-pbonzini@redhat.com>
 <aiBBV48wyDF57vUi@redhat.com>
 <CABgObfZNX2rLnB=FosVopFmLB_S_5V48UPLjNTTtn543d9RfHg@mail.gmail.com>
 <aiBqT1KfI-qowr4L@redhat.com>
 <CAHFMJ7veDE+i89Kh-SaQOL3019W2YC9_o7DeQtDL-YKGxGGHVQ@mail.gmail.com>
 <aiKUHBiQNqvhqxr8@redhat.com>
 <20260605051949-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260605051949-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/2.3.2 (2026-04-26)
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Jun 05, 2026 at 05:25:36AM -0400, Michael S. Tsirkin wrote:
> On Fri, Jun 05, 2026 at 10:17:16AM +0100, Daniel P. Berrangé wrote:
> > On Thu, Jun 04, 2026 at 12:37:58PM +0200, Paolo Bonzini wrote:
> > > Il mer 3 giu 2026, 19:54 Daniel P. Berrangé <berrange@redhat.com> ha
> > > scritto:
> > > 
> > > > The AI policy should just
> > > > make a point that we expect to be communicating with people not
> > > > bots pretending to be people.
> > > >
> > > 
> > > Yes, it's better to have that stated clearly.
> > > 
> > > > True but we also need a rule. The spirit is better explained elsewhere
> > > > > (and also, building consensus on spirit vs. a rule are two different
> > > > > things).
> > > >
> > > > Do we have a better elsewhere in this case ?  It is a point specifically
> > > > about intent of the AI policy rule.
> > > 
> > > 
> > > The rule in this draft says 20 lines, tests, mechanical changes and docs.
> > > The spirit is what is in the commit message, basically to maximize the
> > > benefit and limit the possible damage?
> > 
> > Putting "the spirit" in the commit message is essentially /dev/null to
> > anyone reading the policy later.
> > 
> > > > See my reply to Peter elsewhere in the thread. I agree with your
> > > > > concerns for both docs and discretion, but I had specific uses in mind
> > > > > that I'd like to allow.
> > > > >
> > > > > For docs:
> > > > > - create tutorials and/or feature documentation based on functional tests
> > > >
> > > > That doesn't sound too appealing to me. Reverse engineering docs or
> > > > tutorials from our functional tests is exactly the kind of thing that feels
> > > > likely to result in volumous text of marginal value which will have a large
> > > > burden on reviewers.
> > > >
> > > 
> > > At the same time this can be helpful for maintainers themselves? Let's also
> > > look at this from the point of view of producing better output, not just
> > > from that of being on the receiving end of slop. Especially for docs I have
> > > a hard time imagining people sending out whole new "manuals"... The
> > > bugfixes rule ironically seems the most dangerous to me from the
> > > Dunning-Krueger point of view.
> > > 
> > > My question is: do we want disclosure for anything is created with the help
> > > of LLMs, even if only small parts survive untouched? I think so, because a
> > > lot more, even if edited, would still be originally from AI. But then it's
> > > important to have rules allowing it and a way to track it.
> > 
> > IMHO need unconditional disclosure, because the use of the LLM impacts
> > the license of the code. QEMU is traditionally expected to be GPLv2+
> > licensed for all new code, but there's the train of thought that LLM
> > code is public domain.
> > If it gets human editting afterwards we can
> > consider that the human edits are GPLv2+ licensed, but IMHO we still
> > want to know the origins.
> 
> Wait that's a big ask.
> 
> DOC explicitly does not ask if code might be available anywhere else
> under any other license. Just that contributor can contribute under GPL.
> If it's public domain then the human can license is under GPL.

For new files, in checkpatch we validate that SPDX-License-Identifier
is explicitly set as GPL-2.0-or-later. Contributors are expected to
justify any divergence in the commit message.

I've seen guidance that SPDX-License-Identifier for AI output code
should NOT state a license, under the theory it is public domain.

If it is human editted though, I would expect it to overrule this
guidance and explicitly state GPL-2.0-or-later in the SPDX tag
unless the contributor wants to explicitly put their own edits
under public domain too.

Ultimately QEMU is a copyleft project as a whole and IMHO we should
prioritize retaining that for as large a portion of the codebase is
is practical.

> > > It would definitely be intended for merge. There's a lot of boilerplate
> > > code in the Rust bindings, for example, that is voluminous but *mostly*
> > > lacks creativity---the creative part basically can be described by the
> > > spec/docs and should already clear the low bar required for originality,
> > > even if the code is automatically generated. I included a couple examples
> > > in my reply to Peter.
> > 
> > So we know there are examples which are probably low risk from a license
> > POV, but which are massively larger than 20 lines of code. This just
> > makes me more uncomfortable with the 20 line rule as the definition of
> > the policy - we know that rule is wrong / undesirable from the start and
> > needs this exception to make it viable.
> 
> So 20 lines or mechanical changes? what is considered mechanical will be
> decided by maintainers, contributor should check with them up front.

If we are wanting to allow mechanical changes / boilerplate, then we
should express that in the policy such that the policy can be reasonably
understood without having to ask permission / questions ahead of time. 

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


