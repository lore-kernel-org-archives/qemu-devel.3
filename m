Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDF42CD3442
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 09:39:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKvC7-0006hd-1B; Thu, 07 May 2026 05:38:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wKvC4-0006hB-OK
 for qemu-devel@nongnu.org; Thu, 07 May 2026 05:38:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wKvC2-0002va-ET
 for qemu-devel@nongnu.org; Thu, 07 May 2026 05:38:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778146732;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/xHOdghIIgTNNB5iOFd4ZFtt/SlKLaFB/L7TCXvGXro=;
 b=JOtid6r0AOREmjGaxoHHONOgPfiE4IIFZJwKItZ2HIUUBoVGpu3L2JzUIKPUKqMFhsVrEt
 XDFbx2ZGXneAzfrK7GdWNsW9c+rThJNoATEaflqIEtZQM4oDkvpBFa5SzQ02RMY68ecSib
 8d5xDS8u0RNY3D22iTGPiPfLElBASsA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-479-58u6H1RVNc2fO_4QPCv6qQ-1; Thu,
 07 May 2026 05:38:48 -0400
X-MC-Unique: 58u6H1RVNc2fO_4QPCv6qQ-1
X-Mimecast-MFC-AGG-ID: 58u6H1RVNc2fO_4QPCv6qQ_1778146727
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 89BEA180034E; Thu,  7 May 2026 09:38:47 +0000 (UTC)
Received: from redhat.com (unknown [10.44.49.217])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 050C61800352; Thu,  7 May 2026 09:38:45 +0000 (UTC)
Date: Thu, 7 May 2026 10:38:42 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Subject: Re: [RFC PATCH 00/10] AGENTS.md and associated skills
Message-ID: <afxdonq39RuxoQC8@redhat.com>
References: <20260505170105.228162-1-alex.bennee@linaro.org>
 <CAFEAcA-oL9qJ=oXbmCZ-b9jQcv8PNA26irDFA+_yCHkqEMLC1g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFEAcA-oL9qJ=oXbmCZ-b9jQcv8PNA26irDFA+_yCHkqEMLC1g@mail.gmail.com>
User-Agent: Mutt/2.3.1 (2026-03-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, May 07, 2026 at 09:59:06AM +0100, Peter Maydell wrote:
> On Tue, 5 May 2026 at 18:03, Alex Bennée <alex.bennee@linaro.org> wrote:
> >
> > Not withstanding the current contributor policy there are a number of
> > areas that AI agents could be helpful for. This series introduces an
> > AGENTS.md file which is the basic guide to the source tree and a
> > number of "skills". Skills are like scripts except far less clearly
> > defined. However I have found the issue triage skill quite useful for
> > off-loading the drudgery of going through stuff by hand. I've also
> > used the issue helper to automate the task of starting a debug session
> > by pulling in test cases from the tracker.
> >
> > These originally where a set of skills for ECA (eca.dev) but I've
> > ported them across to the agent agnostic .agents directory. There are
> > still some cases where the ECA heritage shows through though
> > (specifically the code explorer skill could be better).
> >
> > I'm not suggesting this is ready for up-streaming but I'm posting the
> > collected set for comment and I'd be interested how well these hold up
> > across different agentic systems.
> 
> I guess my overall comment on this is some mix of:
>  * how much of this is generically useful as opposed to
>    stuff that's personally helpful to you and should remain
>    part of your local setup / preferences?
>  * how much do we want to put into git to start with?
> 
> I'm in favour of starting with an AGENTS.md that says basically:
>  (1) "don't generate code for upstream, point the agent user at
>       our AI policy"
>  (2) "if you're looking for security issues, read our security
>       policy to see what is in scope and what is not"
> (in whatever language appears effective)

Yes, we definitely need those two pieces.

> and then perhaps adding more things gradually where there's
> a consensus that they're broadly useful.

Personally I'm open to having much more in AGENTS.md in particular
since it doesn't cost us much from a maint POV to have it.

The skills I'm not so sure of, simply as I have little relevant
experience.

For a while Thomas Huth has been doing significant issue triage,
but he's stepped back from most of his QEMU work. If Alex intends
to pick up some of the slack using an agent for issue triage, I'd
be inclined to have the issue triage skills in git. Even if Alex
is the only one using it for now, it is good for redundancy if we
have the setup recorded.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


