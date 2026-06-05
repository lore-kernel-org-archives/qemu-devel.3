Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DBE6CD6E79
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2026 13:02:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVUAh-0003NG-1Q; Fri, 05 Jun 2026 09:01:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wVUAQ-0003Md-IZ
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 09:01:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wVUAN-0006TK-7M
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 09:00:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780664448;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bKcRELIpYtZXmG7aVo+6fJk9EuPv5MrPrZkMwVg3U7E=;
 b=M6jBEKACi9pvLxYtrdFnuHKOl7lFaoyu2kb3SklcrFnBKpQXieqm9h4qGi5Ybzb9HzB188
 MJus84ANatTwK/W2r6GFxhEnCK9G/4mBRCUH9JMSae+Nqp+3pIOhMv6mMlYL7YoyHGhiyv
 krvQ2Cn6s1JUzGM+01FFh6D5lvE/iks=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-617-E6rdiGr-Nwq3gL9121_J5A-1; Fri,
 05 Jun 2026 09:00:45 -0400
X-MC-Unique: E6rdiGr-Nwq3gL9121_J5A-1
X-Mimecast-MFC-AGG-ID: E6rdiGr-Nwq3gL9121_J5A_1780664443
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9CEC719560A1; Fri,  5 Jun 2026 13:00:42 +0000 (UTC)
Received: from redhat.com (unknown [10.44.50.34])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C09A93000210; Fri,  5 Jun 2026 13:00:38 +0000 (UTC)
Date: Fri, 5 Jun 2026 14:00:35 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Fabiano Rosas <farosas@suse.de>, Kevin Wolf <kwolf@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Warner Losh <imp@bsdimp.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v2] docs/devel: relax policy on AI-generated contributions
Message-ID: <aiLIc6C7S_bVtlN_@redhat.com>
References: <aiBBV48wyDF57vUi@redhat.com>
 <CABgObfZNX2rLnB=FosVopFmLB_S_5V48UPLjNTTtn543d9RfHg@mail.gmail.com>
 <aiBqT1KfI-qowr4L@redhat.com>
 <CAHFMJ7veDE+i89Kh-SaQOL3019W2YC9_o7DeQtDL-YKGxGGHVQ@mail.gmail.com>
 <aiKUHBiQNqvhqxr8@redhat.com>
 <20260605051949-mutt-send-email-mst@kernel.org>
 <aiKZQ2VVnERuUKt0@redhat.com>
 <20260605054212-mutt-send-email-mst@kernel.org>
 <aiKjupJNo5wLB4Du@redhat.com>
 <1cb908e1-2d9a-3333-240e-1f7023c5c09e@eik.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1cb908e1-2d9a-3333-240e-1f7023c5c09e@eik.bme.hu>
User-Agent: Mutt/2.3.2 (2026-04-26)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Fri, Jun 05, 2026 at 02:39:35PM +0200, BALATON Zoltan wrote:
> On Fri, 5 Jun 2026, Daniel P. Berrangé wrote:
> > On Fri, Jun 05, 2026 at 05:48:37AM -0400, Michael S. Tsirkin wrote:
> > > On Fri, Jun 05, 2026 at 10:39:15AM +0100, Daniel P. Berrangé wrote:
> > > > On Fri, Jun 05, 2026 at 05:25:36AM -0400, Michael S. Tsirkin wrote:
> > > > > On Fri, Jun 05, 2026 at 10:17:16AM +0100, Daniel P. Berrangé wrote:
> > > > > > IMHO need unconditional disclosure, because the use of the LLM impacts
> > > > > > the license of the code. QEMU is traditionally expected to be GPLv2+
> > > > > > licensed for all new code, but there's the train of thought that LLM
> > > > > > code is public domain.
> > > > > > If it gets human editting afterwards we can
> > > > > > consider that the human edits are GPLv2+ licensed, but IMHO we still
> > > > > > want to know the origins.
> > > > > 
> > > > > Wait that's a big ask.
> > > > > 
> > > > > DOC explicitly does not ask if code might be available anywhere else
> > > > > under any other license. Just that contributor can contribute under GPL.
> > > > > If it's public domain then the human can license is under GPL.
> > > > 
> > > > For new files, in checkpatch we validate that SPDX-License-Identifier
> > > > is explicitly set as GPL-2.0-or-later. Contributors are expected to
> > > > justify any divergence in the commit message.
> > > > 
> > > > I've seen guidance that SPDX-License-Identifier for AI output code
> > > > should NOT state a license, under the theory it is public domain.
> > > 
> > > Not state a license? Recommended by a lawyer? Seen where? Why?
> > 
> > https://www.redhat.com/en/blog/ai-assisted-development-and-open-source-navigating-legal-issues
> > 
> >  "The harder case is when an entire source file, or even
> >   an entire repository, is generated by AI. Here, adding
> >   a copyright and license notice may be inappropriate
> >   unless and until human contributions transform the file
> >   into a copyrightable work. "
> > 
> > I interpret that to suggest we should not automatically use
> > SPDX-License-Identifier: GPL-2.0-or-later on LLM generated
> > code, unless subsequent human editting was non-trivial.
> 
> The presumtion that LLM generated code is public domain is dubious. If you
> tell it to regenerate part of QEMU source after it has seen the GPL sources
> and it comes up with something equivalent does that make the generated
> version public domain? If so people could just rewrite GPL code and make it
> proprietary. This can't be right as the generated code will likely contain
> parts copied from the original so still fall under GPL. What if I just tell
> LLM to rewrite QEMU in C++? Will that make a public domain version that I
> can then make closed source even though it still contains large parts of GPL
> code? I don't think so. The code generated by LLM comes from somewhere but
> nobody can tell where from so also nobody knows what licence it is. If
> you're lucky it comes from examples or other sources with a free licence but
> could be anything even some open source code not compatible with GPL or
> proprietary code. The idea of public domain probably comes from that there's
> no human to hold the copyright but what about cases of copying copyleft code
> by LLM that should not make it public domain. This is similar to the case
> when somebody who worked on a proprietary code before then writes some open
> source code that does similar things or vice versa. What is the legal status
> of those cases? Can the other party claim copyright for the code? Probably
> only if the person recalls whole parts that resemble each other closely
> which could happen. The risk is probably the same with LLMs and thus the
> handling of this should be similar probably. This seems more complex than
> assuming anthing from an LLM is public domain.

Yes, I should have clarified my comments better. I did not mean to
imply that everything/anything from an LLM is public domain.

The "public domain" argument does indeed come from the idea that
only humans can own copyright, and IMHO can apply *only* in the
case where you can credibly consider it to NOT be a direct derived
work of an existing licensed work.

If you're instructing an AI to clone QEMU into a different language
there's a strong argument the result would be a derived work.

If you're instructing an AI to write a non-trivial feature with
creative work and that is following a non-trivial design pattern
that is common in other areas of QEMU, there's also a decent
argument that the result would be a derived work and thus also
liable to be GPL.

This is not the kind of usage that's being proposed for QEMU though.
The kind of scenarios being considered are borderline for creativity
and thus questionable whether they would meet the threshold for
copyrightability even for a human author. 

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


