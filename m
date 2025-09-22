Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09D45CAC592
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 13:25:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0gXK-0005my-Mf; Mon, 22 Sep 2025 09:24:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v0gXH-0005l9-Rz
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 09:24:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v0gXC-0005SJ-HI
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 09:24:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758547487;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=okNeSa+d8C6foROpHgu1ke0gMYdV5jiqfKkoGfNQjPY=;
 b=OU9dRqkj0NELSawFZxVgD8CROaZ0zP5BbE3CTGhxiM6h3nKIFE1Q67TRIkUKy22dxcrZvu
 WgKWFb9YfnXiq0vcjtlBtBFtzdQxCUctYVYOtA4SsyFrDE5DBGZ03xa5krizU4OymqoNsc
 jPNsoYPrGocy2E3ob7av22HY5ds0szk=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-183-k8fn_st-MLunGAWL86R4kg-1; Mon,
 22 Sep 2025 09:24:45 -0400
X-MC-Unique: k8fn_st-MLunGAWL86R4kg-1
X-Mimecast-MFC-AGG-ID: k8fn_st-MLunGAWL86R4kg_1758547484
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4964119560AD; Mon, 22 Sep 2025 13:24:44 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.69])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 08AB81800452; Mon, 22 Sep 2025 13:24:41 +0000 (UTC)
Date: Mon, 22 Sep 2025 14:24:38 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [RFC PATCH 2/4] docs/code-provenance: make the exception process
 more prominent
Message-ID: <aNFOFq_H8KjWM-oy@redhat.com>
References: <20250922113219.32122-1-pbonzini@redhat.com>
 <20250922113219.32122-3-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250922113219.32122-3-pbonzini@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Sep 22, 2025 at 01:32:17PM +0200, Paolo Bonzini wrote:
> The exception process is a second thought in QEMU's policy for AI-generated
> content.  It is not really possible to understand how people want to use
> these tools without formalizing it a bit more and encouraging people to
> request exceptions if they see a good use for AI-generated content.
> 
> Note that right now, in my opinion, the exception process remains
> infeasible, because there is no agreement on how to "demonstrate
> clarity of the license and copyright status for the tool's output".
> This will be sorted out separately.

FWIW, I considered that the "exception process" would end up
being something like...

 * someone wants to use a particular tool for something they
   believe is compelling
 * they complain on qemu-devel that our policy blocks their
   valid use
 * we debate it
 * if agreed, we add a note to this code-proveance.rst doc to
   allow it


I would imagine that exceptions might fall into two buckets

 * Descriptions of techniques/scenarios for using tools
   that limit the licensing risk
 * Details of specific tools (or more likely models) that
   are judged to have limited licensing risk

it is hard to predict the future though, so this might be
too simplistic. Time will tell when someone starts the
debate...


IOW, my suggestion would be that the document simply tells
people to raise a thread on qemu-devel if they would like
to discuss need for a particular exception, and mention
that any exceptions will be documented in this doc if they
are aggreed upon.

> What is missing: do we want a formal way to identify commits for which an
> exception to the AI policy was granted?  The common way to do so seems to
> be "Generated-by" or "Assisted-by" but I don't want to turn commit message
> into an ad space.  I would lean more towards something like
> 
>   AI-exception-granted-by: Mary Maintainer <mary.maintainer@mycorp.test>

IMHO the code-provenance.rst doc is what grants the exception, not
any individual person, nor any individual commit.

Whether we want to reference that a given commit is relying on an
exception or not is hard to say at this point as we don't know what
any exception would be like.

Ideally the applicability of an exception could be self-evident
from the commit. Realiyt might be more fuzzy. So if self-evident,
then it likely warrants a sentence two of english text in the
commit to justify its applicability.

IOW, a tag like AI-exception-granted-by doesn't feel like it is
particularly useful.

> 
> but at the same time I don't want to invent something just for QEMU.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  docs/devel/code-provenance.rst | 22 ++++++++++++----------
>  1 file changed, 12 insertions(+), 10 deletions(-)
> 
> diff --git a/docs/devel/code-provenance.rst b/docs/devel/code-provenance.rst
> index dba99a26f64..d435ab145cf 100644
> --- a/docs/devel/code-provenance.rst
> +++ b/docs/devel/code-provenance.rst
> @@ -292,7 +292,8 @@ TL;DR:
>  
>    **Current QEMU project policy is to DECLINE any contributions which are
>    believed to include or derive from AI generated content. This includes
> -  ChatGPT, Claude, Copilot, Llama and similar tools.**
> +  ChatGPT, Claude, Copilot, Llama and similar tools.  Exceptions may be
> +  requested on a case-by-case basis.**

I'm not sure what you mean by 'case-by-case basis' ? I certainly don't
think we should entertain debating use of AI in individual patch series,
as that'll be a never ending burden on reviewer/maintainer resources.

Exceptions should be things that can be applied somewhat generically to
tools, or models or usage scenarios IMHO.

>  
>    **This policy does not apply to other uses of AI, such as researching APIs
>    or algorithms, static analysis, or debugging, provided their output is not
> @@ -322,18 +323,19 @@ How contributors could comply with DCO terms (b) or (c) for the output of AI
>  content generators commonly available today is unclear.  The QEMU project is
>  not willing or able to accept the legal risks of non-compliance.
>  
> -The QEMU project thus requires that contributors refrain from using AI content
> -generators on patches intended to be submitted to the project, and will
> -decline any contribution if use of AI is either known or suspected.
> +The QEMU project requires contributors to refrain from using AI content
> +generators without going through an exception request process.
> +AI-generated code will only be included in the project after the
> +exception request has been evaluated by the QEMU project.  To be
> +granted an exception, a contributor will need to demonstrate clarity of
> +the license and copyright status for the tool's output in relation to its
> +training model and code, to the satisfaction of the project maintainers.
>  
> +Maintainers are not allow to grant an exception on their own patch
> +submissions.
>  
>  Examples of tools impacted by this policy includes GitHub's CoPilot, OpenAI's
>  ChatGPT, Anthropic's Claude, and Meta's Code Llama, and code/content
>  generation agents which are built on top of such tools.
> -
>  This policy may evolve as AI tools mature and the legal situation is
> -clarifed. In the meanwhile, requests for exceptions to this policy will be
> -evaluated by the QEMU project on a case by case basis. To be granted an
> -exception, a contributor will need to demonstrate clarity of the license and
> -copyright status for the tool's output in relation to its training model and
> -code, to the satisfaction of the project maintainers.
> +clarified.

I would suggest only this last paragraph be changed


  This policy may evolve as AI tools mature and the legal situation is
  clarifed.

  Exceptions
  ----------

  The QEMU project welcomes discussion on any exceptions to this policy,
  or more general revisions. This can be done by contacting the qemu-devel
  mailing list with details of a proposed tool / model / usage scenario /
  etc that is beneficial to QEMU, while still mitigating the legal risks
  to the project.

  After discussion, any exceptions that can be relied upon in contributions
  will be listed below. The listing of an exception does not remove the
  need for contributors to comply with all other pre-existing contribution
  requirements, including DCO signoff.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


