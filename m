Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6403DC982ED
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 13:21:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8dxE-0007nz-8k; Mon, 21 Sep 2026 09:21:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x8dx8-0007nY-PM
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 09:21:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x8dx4-0000Qq-AB
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 09:21:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789996856;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=935egiBLEmhDZiieeLQWlTb/wjdHMnSmj80dpiU6lcc=;
 b=Yv9KPIGnqtb88A8/TuTP3WMLIr+Zs7vw+6YlTaMr3kkDrDfNO2BxctFphvrshORDluwuGB
 CXAcyVBqCOLaZEWCp9OqBIo8kZrQi44GOrsT1tFkKQikLMB2ADu7900lqbrZrNCCQfTgG6
 ORk+G12dTUTD2GK+uNAS9I4Ynsn7dBg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-563-puaBT5c8OB-soL857HZjKw-1; Mon,
 21 Sep 2026 09:20:53 -0400
X-MC-Unique: puaBT5c8OB-soL857HZjKw-1
X-Mimecast-MFC-AGG-ID: puaBT5c8OB-soL857HZjKw_1789996851
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CF081195398D; Mon, 21 Sep 2026 13:20:50 +0000 (UTC)
Received: from redhat.com (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C7A5D1953941; Mon, 21 Sep 2026 13:20:47 +0000 (UTC)
Date: Mon, 21 Sep 2026 14:20:44 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 Fabiano Rosas <farosas@suse.de>, Kevin Wolf <kwolf@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Warner Losh <imp@bsdimp.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH 1/4] docs/devel: relax policy on AI-generated contributions
Message-ID: <arEvLLYK9A5MKNdE@redhat.com>
References: <20260921075251.12831-1-pbonzini@redhat.com>
 <20260921075251.12831-2-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260921075251.12831-2-pbonzini@redhat.com>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
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

On Mon, Sep 21, 2026 at 09:52:48AM +0200, Paolo Bonzini wrote:

> diff --git a/docs/devel/llm-usage.rst b/docs/devel/llm-usage.rst
> new file mode 100644
> index 00000000000..972436828a6
> --- /dev/null
> +++ b/docs/devel/llm-usage.rst
> @@ -0,0 +1,202 @@
> +.. _llm-usage:
> +
> +Use of AI-generated content
> +===========================
> +
> +.. warning::
> +
> +   Please read the below policy before using AI to contribute code or
> +   documentation to QEMU.  This applies to ChatGPT, Claude, Copilot,
> +   Llama, and similar tools.
> +
> +The QEMU project does not want to introduce restrictions on the tools
> +that contributors use for their work on the project.  However,
> +the increasing prevalence of AI-assisted software development,
> +and especially the use of content generated by `Large Language Models
> +<https://en.wikipedia.org/wiki/Large_language_model>`__ (LLMs),
> +poses a number of difficult questions.

It is a bit odd saying we don't want to restrict tools, since that is
exactly what we do want todo in this document. 

Perhaps

 The QEMU project does not want to dictate what tools contributors use
 for their work on the project. The increasing prevalence of AI-assisted
 software development, and especially the use of content generated by
 `Large Language Models <https://en.wikipedia.org/wiki/Large_language_model>`__
 (LLMs), poses a number of difficult questions, requiring some guidance
 around acceptable contribution practices involving LLMS.


> +
> +Risks to open source projects include maintainer burnout from an
> +increased number of contributions, as well as the risk to the project
> +from unintentional inclusion of copyrighted material in the LLM's output.
> +In order to mitigate these risks, the QEMU project limits the way
> +in which use of the output of generative AI can be included
> +in contributions to QEMU.
> +
> +The main guidelines for use of generative AI tools are roughly
> +as follows:
> +
> +- It's fine to use LLMs to answer questions, analyze, distill,
> +  refine, check, suggest, review. Use of LLMs to *create* is limited.
> +
> +- If in doubt, disclose any use of AI tools other than simple code
> +  completion and code review.
> +
> +- LLMs are allowed as a tool to write *better*, not *faster*.
> +
> +.. note:: **Use of AI does not remove the need for authors to comply
> +          with all other requirements for contribution.**  In particular,
> +          the ``Signed-off-by`` label in a patch submission is a statement
> +          that the author takes responsibility for the entire contents of
> +          the patch, certifying that their patch submission is made in
> +          accordance with the rules of the :ref:`Developer's Certificate of
> +          Origin (DCO) <dco>`.
> +
> +          Since a submitter cannot audit LLM output against its training
> +          data, the DCO is paired with :ref:`metadata in the commit message
> +          <ai-used-for>` about AI-generated parts.  The DCO still certifies
> +          that the contributor has the legal right to submit code in general.

I'm not a fan of this second paragraph, as that feels like it is undermining
the DCO. That first sentence in particular is somewhat saying that the
contributor does not have to think about plagarism and thed project is ok
with that, and also implying that the DCO doesn't apply to the LLM output.
This is both not OK in its implication of the project accepting some
liability, and then also contradicted by the next sentence.

IMHO this paragraph should just be removed.  The first paragraph clearly
states the DCO applies to the submission as a whole, and leaves all liability
for infringement on the contributor.


> +LLM-assisted and LLM-created contributions
> +''''''''''''''''''''''''''''''''''''''''''
> +
> +Use of generative AI tools for code contributions generally falls into
> +four buckets:

> +- use of LLMs to help generating parts of a larger patch---test cases,
> +  adaptations of existing code, boilerplate code for a new API, a tool to
> +  help performing mechanical changes, etc.  These are generally allowed;
> +  disclosure is highly recommended for non-trivial, functional code.
> +
> +- large, heavily LLM-assisted contributions where LLMs write large parts
> +  of functional code.  These are only allowed if *pre-arranged*,
> +  *high-quality* and *well-tested*.


In *both* of these cases, I think we should state a expectation that
the human contributor *must* be able to explain the *reasons* for
all key design choices in the code.

If a tool generates a qtest  test case with a bunch of device accesses,
the contributor needs to know what those are doing and why they are
appropriate usage in the real world

When a reviewer asks questions about the patch, they don't want to get
an answer "that's just the way the LLM did it", as then we've just back
to arguing with a bot again, even if the human wrote the mail.

Even for minor design choices that an LLM might make on its own, the
contributors needs to be able to explain and justify why they are
desirable.



> +
> +- "High-quality" means that the contributor must apply the same judgment
> +  that would be applied to other code changes.  Contributors must invest
> +  substantial time reviewing their contributions, curating them, and
> +  understanding them in depth; in particular, you are still expected to
> +  :ref:`understand and explain your changes
> +  <write_a_meaningful_commit_message>` and the rationale behind them.


This needs to apply to all cases, not merely the 'pre-arranged' large
contribution.

> +
> +- "Well-tested" means the LLM-created contributions will be held to a
> +  higher standard than human-created ones, because LLMs make it easier
> +  to write tests.  There are no exceptions for "writing the tests seems
> +  hard" or for `yak shaving <https://en.wiktionary.org/wiki/yak_shaving>`__.
> +
> +.. note::
> +    Pre-arrangement ensures maintainers have bandwidth for review before a
> +    contributor invests effort in creating a large change.  This is not
> +    a new concept in QEMU: maintainers have always encouraged early
> +    alignment on mailing lists or IRC prior to major architecture or
> +    subsystem refactoring.
> +
> +    Maintainers have freedom to determine what constitutes "high quality".
> +    Because LLMs lower the cost of patch generation, maintainers may demand
> +    significantly larger changes than for purely human-written code.
> +
> +.. _ai-used-for:


With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


