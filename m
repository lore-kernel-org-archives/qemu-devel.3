Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E230C5B543
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Jun 2025 08:41:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMjfj-00051X-Bd; Wed, 04 Jun 2025 04:40:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uMjfg-000515-Ic
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 04:40:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uMjfe-0000nv-4f
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 04:40:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749026424;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bbLMzLUNuiAAl2lCzowt+QCq+sNKBAMVqYXJdqCSKAg=;
 b=NEq+x9X6WdtIEWbfZSL+dBHabjBfXdiRcVxDzVoQhZG6+Tjgd2qe22RL3OAhjq3WzP/myh
 Dsz3Z71SA/fY9JUE6uTL8f5KyAGHDymGdQYOe2NZQI7LEqBnBKlK0oqxZUnH2YozbqrFk3
 3Seq5ezNDG5hsUocZHK2Q12VnT5VDDM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-100-JWozWwfwMQmmXbOyCn7GAg-1; Wed,
 04 Jun 2025 04:40:21 -0400
X-MC-Unique: JWozWwfwMQmmXbOyCn7GAg-1
X-Mimecast-MFC-AGG-ID: JWozWwfwMQmmXbOyCn7GAg_1749026418
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 85AE81956080; Wed,  4 Jun 2025 08:40:18 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.60])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C786C18002A5; Wed,  4 Jun 2025 08:40:12 +0000 (UTC)
Date: Wed, 4 Jun 2025 09:40:09 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Markus Armbruster <armbru@redhat.com>,
 Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org,
 Thomas Huth <thuth@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Alexander Graf <agraf@csgraf.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: Re: [PATCH v3 3/3] docs: define policy forbidding use of AI code
 generators
Message-ID: <aEAGadbMexZ9mm4a@redhat.com>
References: <20250603142524.4043193-1-armbru@redhat.com>
 <20250603142524.4043193-4-armbru@redhat.com>
 <CAJSP0QUGaQEwhVh_w6Wbdm-Nqo_2kHcb+eS2Simq-x9J=-7qkg@mail.gmail.com>
 <87a56o1154.fsf@pond.sub.org> <aD_yhelX-w4Vdm8Z@redhat.com>
 <3df2ae5d-c1c6-45ee-8119-ca42e17a0d98@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3df2ae5d-c1c6-45ee-8119-ca42e17a0d98@linaro.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.128,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Jun 04, 2025 at 09:54:33AM +0200, Philippe Mathieu-Daudé wrote:
> On 4/6/25 09:15, Daniel P. Berrangé wrote:
> > On Wed, Jun 04, 2025 at 08:17:27AM +0200, Markus Armbruster wrote:
> > > Stefan Hajnoczi <stefanha@gmail.com> writes:
> > > 
> > > > On Tue, Jun 3, 2025 at 10:25 AM Markus Armbruster <armbru@redhat.com> wrote:
> > > > > 
> > > > > From: Daniel P. Berrangé <berrange@redhat.com>
> >   >> +
> > > > > +The increasing prevalence of AI code generators, most notably but not limited
> > > > 
> > > > More detail is needed on what an "AI code generator" is. Coding
> > > > assistant tools range from autocompletion to linters to automatic code
> > > > generators. In addition there are other AI-related tools like ChatGPT
> > > > or Gemini as a chatbot that can people use like Stackoverflow or an
> > > > API documentation summarizer.
> > > > 
> > > > I think the intent is to say: do not put code that comes from _any_ AI
> > > > tool into QEMU.
> > > > 
> > > > It would be okay to use AI to research APIs, algorithms, brainstorm
> > > > ideas, debug the code, analyze the code, etc but the actual code
> > > > changes must not be generated by AI.
> > 
> > The scope of the policy is around contributions we receive as
> > patches with SoB. Researching / brainstorming / analysis etc
> > are not contribution activities, so not covered by the policy
> > IMHO.
> > 
> > > 
> > > The existing text is about "AI code generators".  However, the "most
> > > notably LLMs" that follows it could lead readers to believe it's about
> > > more than just code generation, because LLMs are in fact used for more.
> > > I figure this is your concern.
> > > 
> > > We could instead start wide, then narrow the focus to code generation.
> > > Here's my try:
> > > 
> > >    The increasing prevalence of AI-assisted software development results
> > >    in a number of difficult legal questions and risks for software
> > >    projects, including QEMU.  Of particular concern is code generated by
> > >    `Large Language Models
> > >    <https://en.wikipedia.org/wiki/Large_language_model>`__ (LLMs).
> > 
> > Documentation we maintain has the same concerns as code.
> > So I'd suggest to substitute 'code' with 'code / content'.
> 
> Why couldn't we accept documentation patches improved using LLM?

I would flip it around and ask why would documentation not be held
to the same standard as code, when it comes to licensing and legal
compliance ?

This is all copyright content that we merge & distribute under the
same QEMU licensing terms, and we have the same legal obligations
whether it is "source code" or "documentation" or other content
that is not traditional "source code" (images for example).


> As a non-native English speaker being often stuck trying to describe
> function APIs, I'm very tempted to use a LLM to review my sentences
> and make them better understandable.

I can understand that desire, and it is an admittedly tricky situation
and tradeoff for which I don't have a great answer.

As a starting point we (as reviewers/maintainers) must be broadly
very tolerant & accepting of content that is not perfect English,
because we know many (probably even the majority of) contributors
won't have English as their first language.

As a reviewer I don't mind imperfect language in submissions. Even
if language is not perfect it is at least a direct expression of
the author's understanding and thus we can have a level of trust
in the docs based on our community experience with the contributor.

If docs have been altered in any significant manner by an LLM,
even if they are linguistically improved, IMHO, knowing that use
of LLM would reduce my personal trust in the technically accuracy
of the contribution.

This is straying into the debate around the accuracy of LLMs though,
which is interesting, but tangential from the purpose of this policy
which aims to focus on the code provenance / legal side. 



So, back on track, a important point is that this policy (& the
legal concerns/risks it attempts to address) are implicitly
around contributions that can be considered copyrightable.

Some so called "trivial" work can be so simplistic as to not meet
the threshold for copyright protection, and it is thus easy for the
DCO requirements to be satisfied.


As a person, when you write the API documentation from scratch,
your output would generally be considered to be copyrightable
contribution by the author.

When a reviewer then suggests changes to your docs, most of the
time those changes are so trivial, that the reviewer wouldn't be
claiming copyright over the resulting work.

If the reviewer completely rewrites entire sentences in the
docs though, though would be able to claim copyright over part
of the resulting work.


The tippping point between copyrightable/non-copyrightable is
hard to define in a policy. It is inherantly fuzzy, and somewhat
of a "you'll know it when you see it" or "lets debate it in court"
situation...


So back to LLMs.


If you ask the LLM (or an agent using an LLM) to entirely write
the API docs from scratch, I think that should be expected to
fall under this proposed contribution policy in general.


If you write the API docs yourself and ask the LLM to review and
suggest improvements, that MAY or MAY NOT fall under this policy.

If the LLM suggested tweaks were minor enough to be considered
not to meet the threshold to be copyrightable it would be fine,
this is little different to a human reviewer suggesting tweaks.


If the LLM suggested large scale rewriting that would be harder
to draw the line, but would tend towards falling under this
contribution policy.

So it depends on the scope of what the LLM suggested as a change
to your docs.

IOW, LLM-as-sparkling-auto-correct is probably OK, but
LLM-as-book-editor / LLM-as-ghost-writer is probably NOT OK

This is a scenario where the QEMU contributor has to use their
personal judgement as to whether their use of LLM in a docs context
is compliant with this policy, or not. I don't think we should try
to describe this in the policy given how fuzzy the situation is.

NB, this copyrightable/non-copyrightable situation applies to source
code too, not just docs.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


