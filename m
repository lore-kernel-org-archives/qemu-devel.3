Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A2F606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 11:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cT9y1PHf
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMOjU-0007Ic-28; Thu, 29 Oct 2026 07:55:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1xMOjM-0007Hc-I4
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 07:55:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1xMOjJ-0006F5-Oa
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 07:55:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793274936;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NHdIpqvMMAsA80YZfJe72DfDYFD5zb5YjVD+x3Q9yCY=;
 b=cT9y1PHfT4ty/QqO3/+7A7UC9RJDaX4I0T3yu0yc9SZV02HeT4En83/PIuqNmy7J+MNELG
 h3WkSuwjd9DpLF6DWaFMdvpEl4ubTwHD1rjDaSr4KdhQXcB080+jmnzDsBVmzqDj76OysK
 1iOaKm8uv7wNM33tDryb4jB4yj+QAAw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-411-kMa1NsCoMRCsX4wWKVOdrQ-1; Thu,
 29 Oct 2026 07:55:34 -0400
X-MC-Unique: kMa1NsCoMRCsX4wWKVOdrQ-1
X-Mimecast-MFC-AGG-ID: kMa1NsCoMRCsX4wWKVOdrQ_1793274933
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6D6411956061; Thu, 29 Oct 2026 11:55:32 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7EA1C472; Thu, 29 Oct 2026 11:55:31 +0000 (UTC)
Date: Thu, 29 Oct 2026 07:55:30 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Kevin Wolf <kwolf@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Warner Losh <imp@bsdimp.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH v4 0/4] docs/devel, AGENTS.md: a completely new policy on
 AI-generated contributions
Message-ID: <20261029115530.GA1505075@shajnocz.csb>
References: <20260930085433.830743-1-pbonzini@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260930085433.830743-1-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
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
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Sep 30, 2026 at 10:54:29AM +0200, Paolo Bonzini wrote:
> Based on the previous discussions, I am finally attempting a non-RFC
> version of the new AI policy.  Discussion on v3 introduced interesting
> points on attestation and I think a consensus is forming.
> 
> Why review the policy?  The blanket ban no longer reflects reality, since
> contributors have been posting AI-generated patches or even larger series.
> This was done most likely in good faith, as these submissions predated
> the introduction of an AGENTS.md file, and it shows that AI can be used
> for useful and creative work on QEMU.
> 
> Rather than expecting maintainers to police these contributors, the new
> policy seeks to ensure that AI usage helps us produce better code rather
> than simply move faster and flood us with dubious work.  In the words
> of Warner Losh, we want to avoid "free as in puppy" contributions[1]
> that increase the load of present and future maintainers by adding
> technical debt.
> 
> This is not a free-for-all.  To avoid maintainer burnout, AI
> contributions must be grounded in respect for maintainers and in the
> existing contribution process.  Large, heavily AI-assisted contributions
> require pre-arrangement with the relevant subsystem maintainers, and
> will be held to a higher standard.
> 
> One of the reasons for the old policy was the issue of code provenance
> and the impossibility to certify the originality of code created by
> AI/LLM tools.  The new policy tries to adopt a "Swiss cheese"
> approach to mitigating the risks implicit in accepting AI-generated code
> in three ways:
> 
> 1) by requiring pre-arrangement for larger contributions, and making
> maintainers free to apply their own considerations (see [2] for a good
> list).  Maintainers' preferences bring experience and creative thought
> into the process, and contributors must take them into account.
> 
> 2) by introducing agent instructions that help the contributor drive
> the design and understand the code produced by the LLM;
> 
> 3) by introducing an "AI-used-for" trailer that scopes areas where
> Signed-off-by cannot guarantee full control of provenance.
> 
> This series reflects feedback from earlier requests for comments, and
> even earlier discussions with members of the QEMU community.  Thanks to
> everyone who provided feedback on earlier drafts.
> 
> Paolo
> 
> v3->v4:
> - rework opening text [Daniel]
> - exempt "official project agents" from not being able to post to
>   GitLab [Alex]
> - explicitly forbid clean room reimplementation [Kevin/Daniel]
> - remove "The DCO still certifies that the contributor has the legal
>   right to submit code in general" paragraph, replace with a note
>   that "AI-used-for" attests respecting the policies and is considered
>   enough for DCO [Daniel, Kevin]
> - make the requirement to "understand and explain your changes"
>   more prominent
> - small edits for grammar and clarity
> 
> v2->v3:
> - remove parser example, replace with "adaptations of existing code"
> - when LLMs are used for boilerplate, "highly recommend" disclosure
>   for "non-trivial, functional code".  The idea here is to avoid
>   having to disclose using AI to apply e.g. changes related to
>   automatic code review, and leaving people some leeway.
> - clarify split between DCO (legal right to submit code in general)
>   and AI-used-for acknowledging that the submitter cannot audit LLM
>   output against e.g. the training data.
> - clarify the defense-in-depth/swiss-cheese approach to limit the
>   risk of copyright violations from LLM output
> - mention that pre-arrangement is not an entirely new concept
> - mention that maintainers can demand larger changes than for human-written code
> - do not mention inclusion of the prompt
> - add checkpatch.pl hunk, changing the phrasing of "no AI" lint
> - rebase AGENTS.md on top of existing file, split
> - drop CLAUDE.md/GEMINI.md symlinks, already done via .claude/.gemini
> 
> [1] https://lore.kernel.org/qemu-devel/CANCZdfrTwfrK0wnuL2cPVF_9W2-8PXtJeHkgkTP+Uv2sT8s0Ng@mail.gmail.com/
> [2] https://lore.kernel.org/qemu-devel/CAFEAcA860fF_+ffk=cXiYyFoQo0wCSUJ6b=7nVLLCwKhP6Nwxw@mail.gmail.com/
> 
> Paolo Bonzini (4):
>   docs/devel: relax policy on AI-generated contributions
>   AGENTS.md: add final instructions
>   AGENTS.md: let agents know what the participation rules are
>   AGENTS.md: make the human part of the design process
> 
>  docs/devel/code-provenance.rst |  71 +----------
>  docs/devel/index-process.rst   |   1 +
>  docs/devel/llm-usage.rst       | 213 +++++++++++++++++++++++++++++++++
>  AGENTS.md                      | 137 +++++++++++++++++++--
>  scripts/checkpatch.pl          |   5 +-
>  5 files changed, 347 insertions(+), 80 deletions(-)
>  create mode 100644 docs/devel/llm-usage.rst
> 
> -- 
> 2.55.0
> 
> 

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>


