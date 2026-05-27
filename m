Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0623ACD5BD0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 12:50:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSDhX-00019n-86; Wed, 27 May 2026 08:49:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wSDhV-00019c-Rg
 for qemu-devel@nongnu.org; Wed, 27 May 2026 08:49:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wSDhT-0001xG-Rv
 for qemu-devel@nongnu.org; Wed, 27 May 2026 08:49:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779886170;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rRxI59yf8c2yI7aczQ6fG3y2IJWLx8lyX4utpFk+JOc=;
 b=F0a/bh8OQ9/oAUcQXEgkApq6eyz8z7D7B3mB5/mEPgYDUBgMOt8OkTpe54e/TwSYDmeG7b
 s3yxSp5tkft9wvik5YLZjtNN7rSJOLUip7+YIfJLbSHyclpKnXVm36Q8aOAEyUPSfmI0yj
 WTb8qwiBbxLwZdkWaPW/e6sUQYgr320=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-300-WqoZdu0NMGmkaco4CxqSIA-1; Wed,
 27 May 2026 08:49:27 -0400
X-MC-Unique: WqoZdu0NMGmkaco4CxqSIA-1
X-Mimecast-MFC-AGG-ID: WqoZdu0NMGmkaco4CxqSIA_1779886166
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3C6751956080; Wed, 27 May 2026 12:49:26 +0000 (UTC)
Received: from redhat.com (unknown [10.44.48.98])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EAAB61684; Wed, 27 May 2026 12:49:23 +0000 (UTC)
Date: Wed, 27 May 2026 14:49:21 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Warner Losh <imp@bsdimp.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 stefanha@redhat.com
Subject: Re: on ai generated and code provenance
Message-ID: <ahboUSAiArue3tTF@redhat.com>
References: <20260524083329-mutt-send-email-mst@kernel.org>
 <ahXbxzB4C_lr6b0N@redhat.com>
 <20260526140231-mutt-send-email-mst@kernel.org>
 <ahXtqyuIa4XqkMHb@redhat.com>
 <20260526152526-mutt-send-email-mst@kernel.org>
 <CANCZdfonroZmdRRpPdHzTKR_m8qyVdSG14gXB-K3BTuv=Qgw9g@mail.gmail.com>
 <ahauQKLOU1tzDtbb@redhat.com>
 <f8791a2d-257b-4233-aafb-ccd45e695542@redhat.com>
 <87se7dxhd4.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87se7dxhd4.fsf@draig.linaro.org>
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Am 27.05.2026 um 12:43 hat Alex Bennée geschrieben:
> Paolo Bonzini <pbonzini@redhat.com> writes:
> 
> > On 5/27/26 10:41, Kevin Wolf wrote:
> >> Am 26.05.2026 um 21:52 hat Warner Losh geschrieben:
> >>> The QEMU Project currently may accept limited uses of AI that produce
> >>> high quality patches that are limited in the creative content added.
> >>> While maintainers will ultimately decide, changes like the following
> >>> fall within this policy
> >>> 1. Fixing obvious warnings in the obvious ways suggested by the tool
> >>> 2. Tree wide API changes, and other similar mechanical changes done
> >>>     today with perl/python/sed/coccinelle
> >> As I said in the paragraph you quoted below, I don't think we should
> >> encourage using AI for tasks that a deterministic tool could do.
> >
> > In some cases such a tool does not exist.  Much to my surprise, there
> > is no tool to do static type inference on Python code, but AI is very
> > good at doing it.
> >
> >> Letting AI perform the change directly instead may be an acceptable
> >> shortcut for a one-man hobby project that nobody else will ever look at,
> >> but in the context of a community project like QEMU in which your
> >> changes have to be reviewed and understood by others, it matters a lot
> >> that the output of the tool is reproducible. Otherwise, you're creating
> >> unnecessary work for others, and that isn't acceptable.
> >
> > When applicable, going through coccinelle (with the aid of AI if
> > needed! is indeed a good middle ground as it helps reviewers for large
> > changes. If you have many slightly different but easily separated
> > changes (e.g. you can split the patch by struct field), it may make
> > things worse.
> >
> > Its also worth noting that in other cases even sed or coccinelle,
> > while deterministic, cannot produce 100% of the patch.
> >
> >> So maybe we should even explicitly mention a recommendation like the
> >> following:
> >>      If you can use a deterministic tool, don't use AI instead. If
> >> you
> >>      don't know how to use the deterministic tool, use the AI to tell you
> >>      how to use it instead of trying to replace it.
> >
> > I like it.
> >
> >>> 3. Limited, small changes to fix bugs or add a small new feature whose
> >>>     scope is less than about 100 lines and the originator can explain
> >>>     them all or the meta issues about the patch.
> >> Not sure if mentioning a number of lines is wise. 100 lines can be
> >> mostly boilerplate and simple sequential code or they can be a deeply
> >> nested complex algorithm.
> >
> > I'd put the threshold at 20-50 at most.
> >
> >> I think I would see more use in a tag like (better name welcome):
> >>     AI-used-for: [code|tests|docs|commit message]...
> >
> > I like this *a lot*.  No need for free advertisement, but some
> > traceability is useful.
> >
> > For tools such as sed or coccinelle, having the exact script in the
> > patch or commit message useful.  Plus, the execution of the script
> > more or lesss delimits the commit by itself (or 90%+ of it).  For LLMs
> > it's a bit less clear cut because separating docs makes little sense.
> > And the exact model is pointless, it will be obsolete in 6 months and
> > provide no useful information.
> >
> > So, something like:
> >
> > ------------------- 8< -------------------
> > Use of AI-generated content
> > ~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >
> > The QEMU project currently allows using AI/LLM tools to produce
> > patches in scenarios with limited creative content:
> >
> > Mechanical changes
> >   If you can use a deterministic tool or a script, don't use AI instead.
> >   If you don't know how to do the change deterministically, you may
> >   ask the AI for help, rather than having it stand in for the tools.
> 
> I like the idea of pointing people towards tools but I wouldn't be quite
> so prescriptive. The series MST referred to was easily eyeball-able and
> I suspect the extra steps would generate friction for contributions.
> That said the wider the change to the code base the more likely a random
> hallucination can get lost in the noise.
> 
> Maybe:
> 
>   Mechanical changes
>     Using AI tools to make simple mechanical changes is allowed. For larger
>     tree-wide changes it is strongly recommended to use a deterministic
>     tool like `sed` or `coccinelle`. You can use AI to help you craft the
>     invocation for you.

I think we do want to discourage the direct use of AI in such cases,
while not outright banning it. So maybe just a minor tweak to Paolo's
wording?

    Mechanical changes
      If you can use a deterministic tool or a script, it is preferred
      that you use it and not replace it with AI. If you don't know how
      to do the change deterministically, you can ask the AI for help,
      rather than having it stand in for the tools.

Kevin


