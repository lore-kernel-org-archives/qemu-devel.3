Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B300CCAC5B5
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 09:54:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3AYO-0006pY-33; Mon, 29 Sep 2025 05:52:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v3AYJ-0006pE-IR
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 05:52:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v3AY5-0007bz-JF
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 05:52:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759139509;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=1ynyuqYZ+F56Ke23JayKbXCooJxnM8O0BFkJEXj3v5s=;
 b=YSH14O0Grh0xwzOh8LQNad/RrgndJWZfOwBLPFaqixulVa+Tuc5R6m2ApqYOcOymg4sZkp
 2u3WzJHustALp252naL906YZYDb+dWyIdbTNSLacacfkWFIb0YU8tizPRbO4fPCYeEyawa
 oUXcUVp6Y35eoGIBCxo8HQywpaWVFzI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-474-zUwIqacrOUibWp_lrTrlwQ-1; Mon,
 29 Sep 2025 05:51:45 -0400
X-MC-Unique: zUwIqacrOUibWp_lrTrlwQ-1
X-Mimecast-MFC-AGG-ID: zUwIqacrOUibWp_lrTrlwQ_1759139504
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 09E67195608C; Mon, 29 Sep 2025 09:51:44 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.51])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9CC7519560B4; Mon, 29 Sep 2025 09:51:41 +0000 (UTC)
Date: Mon, 29 Sep 2025 10:51:37 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>,
 "Hajnoczi, Stefan" <stefanha@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH] docs/code-provenance: add an exception for non-creative
 AI changes
Message-ID: <aNpWqRyp0E-68z1Q@redhat.com>
References: <20250925075630.352720-1-pbonzini@redhat.com>
 <CAFEAcA_6nf6zAK9=VZE9kCXUvYcZhxAgPUN=0gxtun7ip6b7ig@mail.gmail.com>
 <CABgObfYauCBr7YVUvGURRy0qGS8NaeLn=r23WFuq2hhzgWmJng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABgObfYauCBr7YVUvGURRy0qGS8NaeLn=r23WFuq2hhzgWmJng@mail.gmail.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.539,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Sep 26, 2025 at 09:26:47PM +0200, Paolo Bonzini wrote:
> On Fri, Sep 26, 2025, 16:39 Peter Maydell <peter.maydell@linaro.org> wrote:
> 
> > I figure I'll state my personal opinion on this one. This isn't
> > intended to be any kind of 'veto' on the question: I don't
> > feel that strongly about it (and I don't think I ought to
> > have a personal veto in any case).
> >
> > I'm not enthusiastic. The current policy is essentially
> > "the legal risks are unclear and the project isn't willing
> > to accept them". That's a straightforward rule to follow
> > that doesn't require either the contributor or the reviewer
> > or the project to make a possibly difficult judgement call on
> > what counts as not in fact risky. As soon as we start adding
> > exceptions then either we the project are making those
> > judgement calls, or else we're pushing them on contributors
> > or reviewers. I prefer the simple "'no' until the legal
> > picture becomes less murky" rule we have currently.
> >
> 
> In principle I agree. I am not enthusiastic either. There are however two
> problems in the current policy.
> 
> First, the policy is based on a honor code; in some cases the use of AI can
> be easily spotted, but in general it's anything but trivial especially in
> capable hands where, for example, code is generated by AI but commit
> messages are not. As such, the policy cannot prevent inclusion of AI
> generated code, it only tells you who is to blame.

The policy is intentionally based on an honour code, because trust in
contributors intention is a fundamental foundation of a well functioning
OSS project. When projects start to view contributors as untrustworthy,
then IME they end up with burdensome processes (often pushed by corporate
demands), such as copyright assignment / CLA, instead of the lightweight
DCO (self-certification, honour based) process we have today.

The policy never intended for the project or our maintainers to take any
active steps to identify and block AI contributions from contributors
with ill-intent. That would be a sisyphean task IMHO.

We're in a situation where many organizations are strongly pushing their
employees to use AI tools where possible. In the absence of any written
policy, a project has effectively created an implicit policy that they
are willing to accept AI contributions.

Contributors have few sources of information on implications of AI in the
context of OSS projects, which are not written by companies with a vested
(biased) interest in maximising use of AI.

So the QEMU policy serves several purposes IMHO:

  * Provides an interpretation of the DCO wrt LLM generated content
    that reflects community rather than corporate viewpoint

  * Provide cover to the project itself by stating our intent wrt
    what we are willing to accept, pushing liability to the
    contributor (as is the case with DCO in general)

  * Gives contributors clear guidance on whether or not they can
    submit AI generated content to QEMU

  * Gives contributors a policy to point their employer to when
    asked why they didn't use any AI tools in context of QEMU


> Second, for this specific kind of change it is, pretty much, impossible to
> tell whether it's generated with AI or by a specialized tool or by hand. If
> you provide a way for people to be honest about their tool usage, and allow
> it at least in some cases, there's a nonzero chance they will be; if you
> just tell them a hard no, and lying by omission has more than plausible
> deniability, there's a relatively high chance that they will just stay
> silent on the matter while still using the tool.

I find this to be a somewhat distastful view of our contributors, as it
is giving a strong implication that they are likely to act dishonestly
wrt our contribution policies. I don't think that is a fair reflection
of our contributors in general.

I'll never say never, as it is quite possible for any community to have
a malicious contributor, and someone may well do this just out of spite
to try and prove our policy "wrong" because of the high profile of this
policy.

I don't think we should design our contribution policies around the worst
of people though. Policies are a social contract and there is little we
can do to force compliance against a motivated person with ill-intent.

If we ever did identify someone willfully ignoring the policies (whether
on AI, or any other aspect), our main recourse is limited to no longer
accepting their work / participation in the project.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


