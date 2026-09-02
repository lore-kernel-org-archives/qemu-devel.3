Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4875C624D6
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 13:48:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1lK3-00049t-Ku; Wed, 02 Sep 2026 09:48:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x1lK0-00049Q-BM
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 09:48:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x1lJy-0001vm-2d
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 09:48:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788356888;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qAExWt2I8sD7adcsOgPtqFn5uEzHnZ+TOASXKM/HyoY=;
 b=A0hrXk3O+MCP64DyE0/H2YoAegICCc1g0TxzYK+GCvbP3JTp6xAEU22b+qvUp3zLIM3gVN
 BmmpcomlWP9RUNEehB0gg4NpDDeH2aynKpFcUOoDOyNzegCIh0eRjuqH4DhL0m0OwIRsz5
 OBGXmgn3ZJjYhliYK35AYnG04Ayd3Xs=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-371-efLutWmdP2y3cMi235MNJQ-1; Wed,
 02 Sep 2026 09:48:05 -0400
X-MC-Unique: efLutWmdP2y3cMi235MNJQ-1
X-Mimecast-MFC-AGG-ID: efLutWmdP2y3cMi235MNJQ_1788356884
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C05AD1953985; Wed,  2 Sep 2026 13:48:03 +0000 (UTC)
Received: from redhat.com (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5CA9418005B7; Wed,  2 Sep 2026 13:48:00 +0000 (UTC)
Date: Wed, 2 Sep 2026 14:47:57 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 Fabiano Rosas <farosas@suse.de>, Kevin Wolf <kwolf@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Warner Losh <imp@bsdimp.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH 2/4] AGENTS.md: Let agents know what the participation
 rules are
Message-ID: <apgpDaBqCaVPqmLH@redhat.com>
References: <20260901161422.314581-1-pbonzini@redhat.com>
 <20260901161422.314581-3-pbonzini@redhat.com>
 <87a4pzrcqw.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87a4pzrcqw.fsf@draig.linaro.org>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
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

On Wed, Sep 02, 2026 at 02:42:15PM +0100, Alex Bennée wrote:
> Paolo Bonzini <pbonzini@redhat.com> writes:
> 
> > Humans seem to be extremely unreliable in following rules around this,
> > even after being told directly and repeatedly. Telling agents what to
> > do seems to yield better results.
> >
> > This document is based on GStreamer's AGENTS.md file, as of its commit
> > d08375499c279a56c0e77c928fbeae0d80cdf937.  However, GStreamer's agent
> > instructions are "effective" enough to require an explicit carve-out
> > for maintainers.  I actually believe that such a carve-out is a sign of
> > going too far, especially given the good quality of some suspected-AI
> > contributions we've received.
> >
> <snip>
> > diff --git a/AGENTS.md b/AGENTS.md
> > new file mode 100644
> > index 00000000000..8fb96ebfc38
> > --- /dev/null
> > +++ b/AGENTS.md
> > @@ -0,0 +1,100 @@
> > +# Agent Guidelines for the QEMU Project
> > +
> > +QEMU is a cross-platform emulator and virtualizer. Due to the complexity
> > +of the domain and codebase, and the interactions therein, the QEMU
> > +project relies extensively on the effort of **human reviewers**, which
> > +is **a scarce resource**.
> > +
> > +There are strictly-enforced rules for you, the agent, to participate in the
> > +project.
> > +
> > +## Interactions with maintainers must be human-human
> > +
> > +The QEMU project has strict rules on what AI-generated material can
> > +reach the maintainers.
> > +
> > +### No automated posting
> > +
> > +- Agents **must not** use any API, CLI, or web UI automation to:
> > +  - Interact with the QEMU mailing lists
> > +  - Create, edit, or close **issues ("work items")**
> 
> The others I'm fine with but I currently use an agent to do triage on
> un-tagged issues. It only updates labels and occasionally posts a
> comment when more information or a human input is required.

While this is technically something you're doing via your personal
gitlab account, I none the less view the agent triage bot as something
run as an "official" project service.

IMHO the AGENTS.md policy primarily applies to actions done in an
individual capacity (whether contributor or maintainer).

If the project wants to deploy project level services that utilize
AI in some manner and that conflicts with AGENTS.md that's acceptable,
provided we discuss & agree that the project service in question is
desirable.

Perhaps this is me saying that the issue triage bot should be made
more official as a service, committed to git, etc

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


