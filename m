Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD6B606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 10:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Ta5KH14l
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVRlo-000725-0X; Mon, 23 Nov 2026 05:59:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xVRli-00070C-34
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 05:59:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xVRlg-0007BB-4n
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 05:59:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795431566;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QZIwWSkXsD9SsvAAAoxpS0VU52RyiIRu6p//FTEdDnE=;
 b=Ta5KH14lpjIdZNNTerRITNJ8+AbqXZ8npSKH5E924MpYJkfZRb5ByRzNVXiL6CTXb6/eoK
 DvlyqVQlD6F9ZWXTU7W2EiIojhwhdjv1dNZ3fcBqF5hGIhtV9Vv8A2Cjiu1/Kb7iFikINM
 L8GS0eSpxdjqcrW+1Xm/A5YkVQe8ePg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-257-KQV46LIjMUKSYg5vZf3ZRA-1; Mon,
 23 Nov 2026 10:59:22 +0000
X-MC-Unique: KQV46LIjMUKSYg5vZf3ZRA-1
X-Mimecast-MFC-AGG-ID: KQV46LIjMUKSYg5vZf3ZRA_1795431560
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D199919560AD; Mon, 23 Nov 2026 10:59:19 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 07D78195608B; Mon, 23 Nov 2026 10:59:15 +0000 (UTC)
Date: Mon, 23 Nov 2026 10:59:13 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 Fabiano Rosas <farosas@suse.de>, Kevin Wolf <kwolf@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Warner Losh <imp@bsdimp.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH 4/4] docs/devel: allow larger contributions with
 pre-arrangement
Message-ID: <awQcgRggbub1D0dc@redhat.com>
References: <20261118104150.599535-1-pbonzini@redhat.com>
 <20261118104150.599535-5-pbonzini@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261118104150.599535-5-pbonzini@redhat.com>
User-Agent: Mutt/2.4.3 (2026-10-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 18, 2026 at 11:41:50AM +0100, Paolo Bonzini wrote:
> The current policy does not include a path to formalize the submission
> of a larger body of AI-assisted work.  In particular, contributors have
> expressed the interest in using LLMs for new accelerators or for the
> userspace side of new hypervisor features; and some past contributions
> suspected to use AI still fall outside what the policy allows.
> 
> From the maintainer side, the policy does not handle well the submission
> of multiple small patches; it encourages splitting the work into small
> pieces, which hides the design context and does not allow maintainers
> to delegate infrastructure improvements to contributors that are willing
> (or could be required) to do them.
> 
> Constant streams of changes were forbidden in previous drafts, but since
> pre-arrangement of large changes was dropped they were implicitly allowed,
> except possibly when they end up being a code of conduct issue.  Therefore,
> the policy as written risks being unbalanced and shifting the effort
> from developers towards maintainers, which is the opposite of what it
> wanted to achieve.
> 
> In order to avoid this, take inspiration from the Rust project's policy
> and combine two ideas to make the policy both tighter (for example by
> closing the gap for repeated, frequent posting of small bugfixes), and
> more balanced towards maintainers.
> 
> One is to hold larger contributions to a higher standard, in the spirit
> of using AI to work "better, not faster"; the other is to require
> "pre-arrangement" for "changes that are originally created by an LLM".
> AI lowers the cost of producing a patch but does nothing to lower the
> cost of understanding and reviewing one; if anything it raises it, since a
> reviewer can no longer assume that the submitter has reasoned through every
> line.  Pre-arrangement has always been customary for major changes to QEMU
> as it guides contributors towards an early relationship with maintainers;
> it is particularly beneficial when contributors use LLMs because (possibly
> via agent suggestion) it encourages human-to-human discussion, and
> is therefore made a requirement.
> 
> A possible alternative includes exceptions initiated by the maintainer
> only, for example upon seeing an opportunity for infrastructure work or
> a constant stream of small changes from the same contributor.  I have
> chosen to allow contributors to initiate the process as well, because
> they were after all already encouraged to contact maintainers early.
> Maintainers of course can still pre-arrange yak shaving just by asking
> to do it.
> 
> A question raised in previous discussions is what to do with changes
> affecting multiple subsystems.  It seems to me that the common cases
> can be handled in the same way as non-LLM-based contributions or through
> the existing buckets:
> 
> - if there is one main affected subsystem (for example, a new accelerator
>   will only require small changes to QMP in order to expose it in
>   AcceleratorInfo), the maintainer of other trees should treat it as
>   "use of LLMs to help generating parts of a larger patch", i.e. as
>   a separate bucket that does not require pre-arrangement;
> 
> - if there is a genuine split between multiple subsystems (for example,
>   SCSI and USB, or an accelerator and an architecture), the agreement of
>   both maintainers is required to proceed;
> 
> - for tree-wide changes, one maintainer will probably act as the steward
>   and seek consensus from the project as a whole.
> 
> Because this is effectively a corollary of project customs and written
> policies, it is not mentioned explicitly.
> 
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> Acked-by: Warner Losh <imp@bsdimp.com>
> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  docs/devel/llm-usage.rst | 37 +++++++++++++++++++++++++++----------
>  AGENTS.md                |  9 +++++++--
>  2 files changed, 34 insertions(+), 12 deletions(-)
> 
> diff --git a/docs/devel/llm-usage.rst b/docs/devel/llm-usage.rst
> index 5f6d64de52f..dc6f36f1bd1 100644
> --- a/docs/devel/llm-usage.rst
> +++ b/docs/devel/llm-usage.rst
> @@ -84,26 +84,41 @@ Use of generative AI can be classified in the following four buckets:
>    not need disclosure.
>  
>  - small LLM-assisted bugfixes (as a rule of thumb, below 10 lines of code)
> -  are allowed with disclosure.
> +  are allowed with disclosure.  Splitting a submission in multiple parts
> +  is **not** a valid way to bypass this rule; repeated, frequent posting
> +  of such fixes must follow the rule for large contributions.

The first sentence in this addition belongs in the earlier patch, since
the "no bypass" statement is important even without this patch 4.


With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


