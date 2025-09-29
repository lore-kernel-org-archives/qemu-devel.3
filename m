Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22ED7CAC5B9
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 18:30:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3IcL-0003Q4-Vf; Mon, 29 Sep 2025 14:28:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v3IcH-0003Pn-IP
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 14:28:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v3IcA-0001CB-Bm
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 14:28:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759170521;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=R7naFlgNm5V9aYQfbw7FhGYN9Ym4gtd5a42eYqzm/30=;
 b=K83vohc1XTcHF1Unbl6+lMI03iC/fJkw22kNldlkEcuiWeaUvvgwfob9sUaYc8O55YmaIF
 LH5oXx52o6qaMolL5nMTiehqVXuwD1QGBzllxNy8izP56HpJSicgFLeNP+h4PhpyHIWRPs
 ze4pDdR8gNgvxK+zTLxqw/GlBzoAJQM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-683-52Vi_Bp2NbiUFfAf5Psr3Q-1; Mon,
 29 Sep 2025 14:28:38 -0400
X-MC-Unique: 52Vi_Bp2NbiUFfAf5Psr3Q-1
X-Mimecast-MFC-AGG-ID: 52Vi_Bp2NbiUFfAf5Psr3Q_1759170516
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9FF081800451; Mon, 29 Sep 2025 18:28:36 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.51])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 227C1195608E; Mon, 29 Sep 2025 18:28:33 +0000 (UTC)
Date: Mon, 29 Sep 2025 19:28:30 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, stefanha@redhat.com,
 alex.bennee@linaro.org
Subject: Re: [PATCH] docs/code-provenance: add an exception for non-creative
 AI changes
Message-ID: <aNrPzuOI_izZvPVx@redhat.com>
References: <20250925075630.352720-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250925075630.352720-1-pbonzini@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.513,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Thu, Sep 25, 2025 at 09:56:30AM +0200, Paolo Bonzini wrote:
> AI tools can be used as a natural language refactoring engine for simple
> tasks such as modifying all callers of a given function or all accesses
> to a variable.  These tasks are interesting for an exception because:
> 
> * it is credible for a contributor to claim DCO compliance.  If the
> contributor can reasonably make the same change with different tools or
> with just an editor, which tool is used (including an LLM) should have
> no bearing on compliance. This also applies to less simple tasks such
> as adding Python type annotations.

When I read refactoring, I consider

  * No functional change
  * The change is a logical transformation of text

The creative act is defining the rule for what the transformation will
do. The resulting patch is a derivative work of the existing code,
along with the rules for the transformation.

In traditional cases, the rules are an awk prompt, or a semantic
patch (coccinelle), but in this case, the rules are the AI agent
prompt

The AI training material will guide the tool on how to interpret
your natural language rules, but overall it looks implausible to
claim the resulting patch would be a derivative work of any
training material.

The only exception seems to be if some QEMU fork had made exactly
the same refactoring already, which seems unlikely in general,
when we disregard malicious contributors.


Type annotations gets more complex to rationalize, because that is
about writing net new functional code. As an analogy though, if
there was a clean room dev team, whom were fed the commit message,
their output would likely be identical. The defining characteristic
is the lack of plausible (&correct) alternative approaches. All
tools, whether AI or not, should converge on the same result.

It again looks implausible to suggest the resulting patch could
be a derivative work of any particular agent training material,
unless some QEMU fork had made exactly the same functional change
already. This feels unlikely.

TL:DR: even in today's world where the laundering of training
material licenses, vs AI output licenses is murky, there is
likely sufficient confidence in these particular scenarios to
claim the training material imposes negligible risk to QEMU.

> * they are relatively easy to test and review, and can provide noticeable
> time savings;
> 
> * this kind of change is easily separated from more complex non-AI-generated
> ones, which we encourage people to do anyway.  It is therefore natural
> to highlight them as AI-generated.
> 
> Make an exception for patches that have "limited creative content" - that
> is, mechanical transformations where the creativity lies in deciding what
> to change rather than in how to implement the change.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  docs/devel/code-provenance.rst | 27 +++++++++++++++++++++++----
>  1 file changed, 23 insertions(+), 4 deletions(-)
> 
> diff --git a/docs/devel/code-provenance.rst b/docs/devel/code-provenance.rst
> index 8cdc56f6649..d6e86636964 100644
> --- a/docs/devel/code-provenance.rst
> +++ b/docs/devel/code-provenance.rst
> @@ -290,9 +290,11 @@ Use of AI-generated content
>  
>  TL;DR:
>  
> -  **Current QEMU project policy is to DECLINE any contributions which are
> +  **The general QEMU project policy is to DECLINE any contributions which are
>    believed to include or derive from AI generated content. This includes
> -  ChatGPT, Claude, Copilot, Llama and similar tools.**
> +  ChatGPT, Claude, Copilot, Llama and similar tools.** The following exceptions
> +  are acceptable:
> +  * **Limited creative content** (e.g., mechanical transformations)

Ought to link to the detailed description further down.

>  
>    **This policy does not apply to other uses of AI, such as researching APIs
>    or algorithms, static analysis, or debugging, provided their output is not
> @@ -323,8 +325,9 @@ content generators commonly available today is unclear.  The QEMU project is
>  not willing or able to accept the legal risks of non-compliance.
>  
>  The QEMU project thus requires that contributors refrain from using AI content
> -generators on patches intended to be submitted to the project, and will
> -decline any contribution if use of AI is either known or suspected.
> +generators on patches intended to be submitted to the project, with exceptions
> +outlined below.  If use of AI is known or suspected to go beyond the exceptions,
> +QEMU will decline a contribution.
>  
>  Examples of tools impacted by this policy includes GitHub's CoPilot, OpenAI's
>  ChatGPT, Anthropic's Claude, and Meta's Code Llama, and code/content
> @@ -347,3 +350,19 @@ requirements for contribution.  In particular, the "Signed-off-by"
>  label in a patch submission is a statement that the author takes
>  responsibility for the entire contents of the patch, including any parts
>  that were generated or assisted by AI tools or other tools.
> +
> +The following exceptions are currently in place:
> +
> +**Limited creative content**
> +  Mechanical transformations where there is reasonably only one way to
> +  implement the change.  Any tool, as well as a manual change, would
> +  produce substantially the same modifications to the code.  Examples
> +  include adjustments to data structures, mechanical API migrations,
> +  or applying non-functional changes uniformly across a codebase.

I can rationalize in my mind what I would be willing to accept under
this description, but at the same time this is (intentionally) fairly
fuzzy and open to interpretation.



> +It is highly encouraged to provide background information such as the
> +prompts that were used, and to not mix AI- and human-written code in the
> +same commit, as much as possible.

It would be nice to require full separation, but if an AI gets you
95% of the way there, and the remaining 5% is just stupid typos/
mistakes, it is better for a human to just fix it immediately, than
to continue re-prompting the agent to try again and hoping you win.

> +Maintainers should ask for a second opinion and avoid applying the
> +exception to their own patch submissions.

Could it be simpler as:

 Sign off is mandatory from a maintainer whom is not the author.

Or where you implying that we need SoB from two maintainers ?

In theory non-author S-o-B is best practice already, but analyzing
git shows we have about 10% of our commits with no independent
S-o-B at all. Often such commits are precisely the NFC refactorings,
or the simple mechanical additions.

So perhaps going from zero-or-one independent SoBs, to at least
one SoB is sufficiently strong ?

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


