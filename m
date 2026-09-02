Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24F17C61DD6
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 10:08:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1htN-0003A8-Bc; Wed, 02 Sep 2026 06:08:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x1htM-00039z-6J
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 06:08:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x1htK-0003h5-8Q
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 06:08:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788343705;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=DnZ1QATdjTkXhByT1aUPJuyZT9NEbZOe6CJhCKrR3PM=;
 b=ei1NhPQhmuVtwczAB+Xdl9Z9FcbzPgXlxX/eEVychT3uEsBcXrPZ79viWgr508hXdteQp0
 Na1rICFl4JTrT2vsiP0ajXM6Z+me2ND9drUpLsM0AvKL6lYaiPvdOkWkX+OgwFczSnpoV2
 3KZK5Tn9FmTW5uTIkIvS456RHr0GD+k=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-279-Btvh4IoEPcyjp_5Cv4qy2Q-1; Wed,
 02 Sept 2026 06:08:21 -0400
X-MC-Unique: Btvh4IoEPcyjp_5Cv4qy2Q-1
X-Mimecast-MFC-AGG-ID: Btvh4IoEPcyjp_5Cv4qy2Q_1788343700
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 763551800A3F; Wed,  2 Sep 2026 10:08:19 +0000 (UTC)
Received: from redhat.com (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B4C1B1800598; Wed,  2 Sep 2026 10:08:15 +0000 (UTC)
Date: Wed, 2 Sep 2026 11:08:12 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Paolo Bonzini <bonzini@gnu.org>
Cc: Alistair Francis <Alistair.Francis@wdc.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "alex.bennee@linaro.org" <alex.bennee@linaro.org>,
 "philmd@linaro.org" <philmd@linaro.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "kwolf@redhat.com" <kwolf@redhat.com>,
 "balaton@eik.bme.hu" <balaton@eik.bme.hu>,
 "mst@redhat.com" <mst@redhat.com>, "farosas@suse.de" <farosas@suse.de>,
 "imp@bsdimp.com" <imp@bsdimp.com>
Subject: Re: [PATCH 1/4] docs/devel: introduce a new policy on AI-generated
 contributions
Message-ID: <apf1jOASUaHFEca9@redhat.com>
References: <20260901161422.314581-1-pbonzini@redhat.com>
 <20260901161422.314581-2-pbonzini@redhat.com>
 <e6ff364982ad264e0ea608458eaaa5aaa292913c.camel@wdc.com>
 <e0a10f28-9b6e-4555-b31b-ec3ea111f536@gnu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e0a10f28-9b6e-4555-b31b-ec3ea111f536@gnu.org>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
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

On Wed, Sep 02, 2026 at 09:09:59AM +0200, Paolo Bonzini wrote:
> Thanks for the review!
> 
> On 9/2/26 03:38, Alistair Francis wrote:
> > > +Prohibited use of AI
> > > +''''''''''''''''''''
> > > +
> > > +The following items **MUST** be written by humans:
> > > +
> > > +- cover letters and commit messages
> > > +
> > > +- responses to reviewer comments
> > > +
> > > +- issue descriptions or comments
> > > +
> > > +Light copy editing of human-written text with an AI is allowed.
> > 
> > What about translations? Not everyone can write English well and I see
> > translations being useful.
> 
> Difficult choice.  I can see that it's useful, but we've never been
> hardliners for English grammar, and translation may cause agent-ese to slip
> in.  I am not a native speaker but I wouldn't use this possibility, so I'm
> not the best person to decide.

Yep, my view is that we generally accept patches written with whatever
level of English a contributor has. Perfection is an explicit non-goal.


Having a machine (AI or not) rewrite text to "polish" the English will
always have the danger of changing the meaning/intet. For reviewers it
is valuable to see the contributors original "thinking", such that if
something is unclear/unpolished a human-to-human discussion & decision
can clarify & improve that text. 


This all, however, assumes the contributor has some basic level of
English skill. That is not a given. There are doubtless contributors
who will have heavily used automated machine translation, even before
AI, when interacting with projects.

Communication may be more challenging for both sides in this scenario,
but these contributors can still be valuable to the project so should
be accommodated. IOW, I would not want to exclude them by having a hard
rule against use of AI translation, as it can be better than pre-AI
translation tools they might have otherwise used in the past.


TL;DR: we do not want AI to be the original author of the cover letters
and commit messages. If the contributor can only author a cover letter /
commit message in their native language, however, IMHO it is acceptable
to use any translation tool to covert that to English (whether that
tool is AI based or not). We should accept the imperfection / risk
of changes in semantics here.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


