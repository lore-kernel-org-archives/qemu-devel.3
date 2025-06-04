Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0C04C5B552
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Jun 2025 09:23:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMkKt-0001ur-O6; Wed, 04 Jun 2025 05:23:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uMkKr-0001uM-Fc
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 05:23:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uMkKo-0006oS-VG
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 05:23:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749028977;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Abrm8wcvgxbUGyVMKZrIjFJtmgMz9WDTDMfk0DoH+HU=;
 b=MJajhM3YpjTtBA8pphA9It9rnf0bBQQWT+V5RzDFu0+7lLuS/LJVI82fHmBAk2lV85ARSo
 j1m/B4sNOI+lApVsOkzicRS1tlIL/vinViwV4L3YbIeETqnRMmH7R4ZlRt+rmNwRVdbdH4
 unVofIDhYStHqY6hs3BNS/ms6HpSWEA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-2-VhL44rfjObC4av1vVa4NNg-1; Wed,
 04 Jun 2025 05:22:54 -0400
X-MC-Unique: VhL44rfjObC4av1vVa4NNg-1
X-Mimecast-MFC-AGG-ID: VhL44rfjObC4av1vVa4NNg_1749028973
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 51FF319560B7; Wed,  4 Jun 2025 09:22:53 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.60])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 44C681955DDA; Wed,  4 Jun 2025 09:22:47 +0000 (UTC)
Date: Wed, 4 Jun 2025 10:22:44 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org,
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
Message-ID: <aEAQZLOrJvF5rdz4@redhat.com>
References: <20250603142524.4043193-1-armbru@redhat.com>
 <20250603142524.4043193-4-armbru@redhat.com>
 <CAJSP0QUGaQEwhVh_w6Wbdm-Nqo_2kHcb+eS2Simq-x9J=-7qkg@mail.gmail.com>
 <87a56o1154.fsf@pond.sub.org> <aD_yhelX-w4Vdm8Z@redhat.com>
 <87frgfyjb5.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87frgfyjb5.fsf@pond.sub.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
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

On Wed, Jun 04, 2025 at 10:58:38AM +0200, Markus Armbruster wrote:
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
> > On Wed, Jun 04, 2025 at 08:17:27AM +0200, Markus Armbruster wrote:
> >> Stefan Hajnoczi <stefanha@gmail.com> writes:
> >> 
> >> > On Tue, Jun 3, 2025 at 10:25 AM Markus Armbruster <armbru@redhat.com> wrote:
> >> >>
> >> >> From: Daniel P. Berrangé <berrange@redhat.com>
> >  >> +
> >> >> +The increasing prevalence of AI code generators, most notably but not limited
> >> >
> >> > More detail is needed on what an "AI code generator" is. Coding
> >> > assistant tools range from autocompletion to linters to automatic code
> >> > generators. In addition there are other AI-related tools like ChatGPT
> >> > or Gemini as a chatbot that can people use like Stackoverflow or an
> >> > API documentation summarizer.
> >> >
> >> > I think the intent is to say: do not put code that comes from _any_ AI
> >> > tool into QEMU.
> >> >
> >> > It would be okay to use AI to research APIs, algorithms, brainstorm
> >> > ideas, debug the code, analyze the code, etc but the actual code
> >> > changes must not be generated by AI.
> >
> > The scope of the policy is around contributions we receive as
> > patches with SoB. Researching / brainstorming / analysis etc
> > are not contribution activities, so not covered by the policy
> > IMHO.
> 
> Yes.  More below.
> 
> >> The existing text is about "AI code generators".  However, the "most
> >> notably LLMs" that follows it could lead readers to believe it's about
> >> more than just code generation, because LLMs are in fact used for more.
> >> I figure this is your concern.
> >> 
> >> We could instead start wide, then narrow the focus to code generation.
> >> Here's my try:
> >> 
> >>   The increasing prevalence of AI-assisted software development results
> >>   in a number of difficult legal questions and risks for software
> >>   projects, including QEMU.  Of particular concern is code generated by
> >>   `Large Language Models
> >>   <https://en.wikipedia.org/wiki/Large_language_model>`__ (LLMs).
> >
> > Documentation we maintain has the same concerns as code.
> > So I'd suggest to substitute 'code' with 'code / content'.
> 
> Makes sense, thanks!
> 
> >> If we want to mention uses of AI we consider okay, I'd do so further
> >> down, to not distract from the main point here.  Perhaps:
> >> 
> >>   The QEMU project thus requires that contributors refrain from using AI code
> >>   generators on patches intended to be submitted to the project, and will
> >>   decline any contribution if use of AI is either known or suspected.
> >> 
> >>   This policy does not apply to other uses of AI, such as researching APIs or
> >>   algorithms, static analysis, or debugging.
> >> 
> >>   Examples of tools impacted by this policy includes both GitHub's CoPilot,
> >>   OpenAI's ChatGPT, and Meta's Code Llama, amongst many others which are less
> >>   well known.
> >> 
> >> The paragraph in the middle is new, the other two are unchanged.
> >> 
> >> Thoughts?
> >
> > IMHO its redundant, as the policy is expressly around contribution of
> > code/content, and those activities as not contribution related, so
> > outside the scope already.
> 
> The very first paragraph in this file already set the scope: "provenance
> of patch submissions [...] to the project", so you have a point here.
> But does repeating the scope here hurt or help?

I guess it probably doesn't hurt to have it. Perhaps tweak to

 This policy does not apply to other uses of AI, such as researching APIs or
 algorithms, static analysis, or debugging, provided their output is not
 to be included in contributions.

and for the last paragraph remove 'both' and add a tailer

   Examples of tools impacted by this policy include GitHub's CoPilot,
   OpenAI's ChatGPT, and Meta's Code Llama (amongst many others which are less
   well known), and code/content generation agents which are built on top of
   such tools.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


