Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 579E8C5B543
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Jun 2025 09:10:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMk90-0006EA-FF; Wed, 04 Jun 2025 05:10:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uMk8x-0006De-5b
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 05:10:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uMk8u-0004fo-BF
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 05:10:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749028237;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WdtEaTsyaYFzUUKB0nSyuu9CmQZ0eO3Oi7AjctjlgCc=;
 b=h3Te6hqyl2h1sL/0EWpGG31vC+jG3kg6Ej9bvefbSXSzwp22tgm0EyhGDpwxQgxRGiEZ6+
 C40UNqm/E5X+xXWeVrbl/m9s+MjeIDWTeU+PGweK5keNN8G/nmyzAWFnjrl4Bsmox+McSO
 B0jBLrCBU6CcfLNCViTVetg/rgRaPaY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-645-aycPajiMP7GAuz6LtrkmBQ-1; Wed,
 04 Jun 2025 05:10:33 -0400
X-MC-Unique: aycPajiMP7GAuz6LtrkmBQ-1
X-Mimecast-MFC-AGG-ID: aycPajiMP7GAuz6LtrkmBQ_1749028232
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8AC4E180047F; Wed,  4 Jun 2025 09:10:32 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.60])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DD58219560A3; Wed,  4 Jun 2025 09:10:26 +0000 (UTC)
Date: Wed, 4 Jun 2025 10:10:23 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 Thomas Huth <thuth@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Alexander Graf <agraf@csgraf.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v3 3/3] docs: define policy forbidding use of AI code
 generators
Message-ID: <aEANf4HkZTXn9KXN@redhat.com>
References: <20250603142524.4043193-1-armbru@redhat.com>
 <20250603142524.4043193-4-armbru@redhat.com>
 <CAJSP0QUGaQEwhVh_w6Wbdm-Nqo_2kHcb+eS2Simq-x9J=-7qkg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJSP0QUGaQEwhVh_w6Wbdm-Nqo_2kHcb+eS2Simq-x9J=-7qkg@mail.gmail.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
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

On Tue, Jun 03, 2025 at 02:25:42PM -0400, Stefan Hajnoczi wrote:
> On Tue, Jun 3, 2025 at 10:25 AM Markus Armbruster <armbru@redhat.com> wrote:
> >
> > From: Daniel P. Berrangé <berrange@redhat.com>
> >
> > There has been an explosion of interest in so called AI code
> > generators. Thus far though, this is has not been matched by a broadly
> > accepted legal interpretation of the licensing implications for code
> > generator outputs. While the vendors may claim there is no problem and
> > a free choice of license is possible, they have an inherent conflict
> > of interest in promoting this interpretation. More broadly there is,
> > as yet, no broad consensus on the licensing implications of code
> > generators trained on inputs under a wide variety of licenses
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
> > These are early days of AI-assisted software development. The legal
> > questions will be resolved eventually. The tools will mature, and we
> > can expect some to become safely usable in free software projects.
> > The policy we set now must be for today, and be open to revision. It's
> > best to start strict and safe, then relax.
> >
> > Meanwhile requests for exceptions can also be considered on a case by
> > case basis.
> >
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > Acked-by: Stefan Hajnoczi <stefanha@gmail.com>
> > Reviewed-by: Kevin Wolf <kwolf@redhat.com>
> > Signed-off-by: Markus Armbruster <armbru@redhat.com>
> > ---
> >  docs/devel/code-provenance.rst | 50 +++++++++++++++++++++++++++++++++-
> >  1 file changed, 49 insertions(+), 1 deletion(-)
> >
> > diff --git a/docs/devel/code-provenance.rst b/docs/devel/code-provenance.rst
> > index c27d8fe649..261263cfba 100644
> > --- a/docs/devel/code-provenance.rst
> > +++ b/docs/devel/code-provenance.rst
> > @@ -270,4 +270,52 @@ boilerplate code template which is then filled in to produce the final patch.
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
> 
> GitHub spells it "Copilot".
> 
> Claude is very popular for coding at the moment and probably worth mentioning.
> 
> > +
> > +The increasing prevalence of AI code generators, most notably but not limited
> 
> More detail is needed on what an "AI code generator" is. Coding
> assistant tools range from autocompletion to linters to automatic code
> generators. In addition there are other AI-related tools like ChatGPT
> or Gemini as a chatbot that can people use like Stackoverflow or an
> API documentation summarizer.
> 
> I think the intent is to say: do not put code that comes from _any_ AI
> tool into QEMU.

Right, the intent is that any copyrightable portion of a commit must
not have come directly from an AI/LLM tool, or from an agent which
indirectly/internally uses an AI/LLM tool.

"code generator" is possibly a little overly specific, as this is really
about any type of tool which emits content that will make its way into
qemu.git, whether code or non-code content (docs, images, etc).

> It would be okay to use AI to research APIs, algorithms, brainstorm
> ideas, debug the code, analyze the code, etc but the actual code
> changes must not be generated by AI.

Mostly yes - there's a fuzzy boundary in the debug/analyze use cases,
if the tool is also suggesting code changes to fix issues.

If the scope of the suggested changes meets the threshold for being
(likely) copyrightable code, that would fall under the policy.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


