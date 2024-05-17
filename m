Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 493A2C04FFE
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2024 10:59:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7vHu-0008E6-2t; Fri, 17 May 2024 06:58:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1s7vHr-0008Af-Ig
 for qemu-devel@nongnu.org; Fri, 17 May 2024 06:58:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1s7vHp-0003AD-Gd
 for qemu-devel@nongnu.org; Fri, 17 May 2024 06:58:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715943483;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hwXzpTCh/kGZnUPu8WVw3Ys06WHAXqXQspKsZWeW+Ek=;
 b=h7j4fs6odqhd8CeA5AYGU0lv9qS9EK3/XATS73dVejFEMedH4inh9pHMzZCKlWQvF8eJHN
 Q0cmATKBucqsmq6Zx+ZGgT5QW9Z0Ln05iDZ4I16SXY2iAS7vkwR/Y22mi2hYWFn4JAek1n
 ANhIsyyabdZ3o/3jO72pUK2nZlMrKYg=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-298-ZnNkkWblPniea5W2nULUbQ-1; Fri,
 17 May 2024 06:57:59 -0400
X-MC-Unique: ZnNkkWblPniea5W2nULUbQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 67DE91C0513E;
 Fri, 17 May 2024 10:57:59 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.65])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F0C86100046D;
 Fri, 17 May 2024 10:57:56 +0000 (UTC)
Date: Fri, 17 May 2024 11:57:54 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Alexander Graf <agraf@csgraf.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v2 3/3] docs: define policy forbidding use of AI code
 generators
Message-ID: <Zkc4MkH9l0R7Mama@redhat.com>
References: <20240516162230.937047-1-berrange@redhat.com>
 <20240516162230.937047-4-berrange@redhat.com>
 <20240516130458-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240516130458-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.022,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, May 16, 2024 at 01:11:26PM -0400, Michael S. Tsirkin wrote:
> On Thu, May 16, 2024 at 05:22:30PM +0100, Daniel P. Berrangé wrote:
> > There has been an explosion of interest in so called AI code generators
> > in the past year or two. Thus far though, this is has not been matched
> > by a broadly accepted legal interpretation of the licensing implications
> > for code generator outputs. While the vendors may claim there is no
> > problem and a free choice of license is possible, they have an inherent
> > conflict of interest in promoting this interpretation. More broadly
> > there is, as yet, no broad consensus on the licensing implications of
> > code generators trained on inputs under a wide variety of licenses
> > 
> > The DCO requires contributors to assert they have the right to
> > contribute under the designated project license. Given the lack of
> > consensus on the licensing of AI code generator output, it is not
> > considered credible to assert compliance with the DCO clause (b) or (c)
> > where a patch includes such generated code.
> > 
> > This patch thus defines a policy that the QEMU project will currently
> > not accept contributions where use of AI code generators is either
> > known, or suspected.
> > 
> > This merely reflects the current uncertainty of the field, and should
> > this situation change, the policy is of course subject to future
> > relaxation. Meanwhile requests for exceptions can also be considered on
> > a case by case basis.
> > 
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > ---
> >  docs/devel/code-provenance.rst | 50 +++++++++++++++++++++++++++++++++-
> >  1 file changed, 49 insertions(+), 1 deletion(-)
> > 
> > diff --git a/docs/devel/code-provenance.rst b/docs/devel/code-provenance.rst
> > index eabb3e7c08..846dda9a35 100644
> > --- a/docs/devel/code-provenance.rst
> > +++ b/docs/devel/code-provenance.rst
> > @@ -264,4 +264,52 @@ boilerplate code template which is then filled in to produce the final patch.
> >  The output of such a tool would still be considered the "preferred format",
> >  since it is intended to be a foundation for further human authored changes.
> >  Such tools are acceptable to use, provided they follow a deterministic process
> > -and there is clearly defined copyright and licensing for their output.
> > +and there is clearly defined copyright and licensing for their output. Note
> > +in particular the caveats applying to AI code generators below.
> > +
> > +Use of AI code generators
> > +~~~~~~~~~~~~~~~~~~~~~~~~~
> > +
> > +TL;DR:
> > +
> > +  **Current QEMU project policy is to DECLINE any contributions which are
> > +  believed to include or derive from AI generated code. This includes ChatGPT,
> > +  CoPilot, Llama and similar tools**
> > +
> > +The increasing prevalence of AI code generators, most notably but not limited
> > +to, `Large Language Models <https://en.wikipedia.org/wiki/Large_language_model>`__
> > +(LLMs) results in a number of difficult legal questions and risks for software
> > +projects, including QEMU.
> > +
> > +The QEMU community requires that contributors certify their patch submissions
> > +are made in accordance with the rules of the :ref:`dco` (DCO).
> > +
> > +To satisfy the DCO, the patch contributor has to fully understand the
> > +copyright and license status of code they are contributing to QEMU. With AI
> > +code generators, the copyright and license status of the output is ill-defined
> > +with no generally accepted, settled legal foundation.
> > +
> > +Where the training material is known, it is common for it to include large
> > +volumes of material under restrictive licensing/copyright terms. Even where
> > +the training material is all known to be under open source licenses, it is
> > +likely to be under a variety of terms, not all of which will be compatible
> > +with QEMU's licensing requirements.
> > +
> > +With this in mind, the QEMU project does not consider it is currently possible
> > +for contributors to comply with DCO terms (b) or (c) for the output of commonly
> > +available AI code generators.
> > +
> > +The QEMU maintainers thus require that contributors refrain from using AI code
> > +generators on patches intended to be submitted to the project, and will
> > +decline any contribution if use of AI is either known or suspected.
> > +
> > +Examples of tools impacted by this policy includes both GitHub's CoPilot,
> > +OpenAI's ChatGPT, and Meta's Code Llama, amongst many others which are less
> > +well known.
> > +
> > +This policy may evolve as the legal situation is clarifed. In the meanwhile,
> > +requests for exceptions to this policy will be evaluated by the QEMU project
> > +on a case by case basis. To be granted an exception, a contributor will need
> > +to demonstrate clarity of the license and copyright status for the tool's
> > +output in relation to its training model and code, to the satisfaction of the
> > +project maintainers.
> 
> I would definitely want more contributors to pass their
> comments and commit logs though a grammar checker.

Its a double edged sword. If someone's grammer is sufficiently bad to
need correcting, will a machine actually suggest an alternative phrasing
that accurately represents the author's intent, or will it result in
something more misleading, and will they realize the difference ?

Each to their own, but I'd prefer to see the author's own original words,
and query them myself if unclear.

> It's unclear to me whether the contributors would
> be required to know whether the checker in question is
> considered "AI" or not.

I don't think we're expecting users to go searching out fine details of
the internals of tools. Just use their best judgement based on easily
identifiable information.

IOW, if something openly advertizes itself as being "AI" driven, that's
a bad choice to use for QEMU, but if something is secretly using AI
internally without being advertized, we wouldn't/shouldn't blame users
if they aren't aware of this fact.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


