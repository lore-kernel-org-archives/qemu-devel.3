Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 349E160A2602
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 12:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=N0xq8mT4
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xU0zr-0002ca-S9; Thu, 19 Nov 2026 07:12:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xU0zq-0002cP-IS
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 07:12:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xU0zo-0001l3-6z
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 07:12:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795090326;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=SwtfLMzI5vwUTdJ+RjOEZN3MQ5qCuewYAHBHYsTbi9A=;
 b=N0xq8mT4J8JWNRW7VfFYcfSjf1NvSGlOLBaDaWYjRjrYCyj4Gd/ib0CUyPDi4TjmGNZXis
 zw5YF3L11PK+uUHti544/wEh5f83xseDZTIx/KBHTO026zT2wCm/4JTfygv7jNNVokfkST
 YiIMxeA/DIyx1rRqbB2m1u4u7waMPBQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-450-oHCN_1LmOLyj-1jmUSqRAw-1; Thu,
 19 Nov 2026 07:12:03 -0500
X-MC-Unique: oHCN_1LmOLyj-1jmUSqRAw-1
X-Mimecast-MFC-AGG-ID: oHCN_1LmOLyj-1jmUSqRAw_1795090321
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0DD301955F61; Thu, 19 Nov 2026 12:12:01 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 117591956041; Thu, 19 Nov 2026 12:11:56 +0000 (UTC)
Date: Thu, 19 Nov 2026 12:11:54 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Eric Blake <eblake@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 Fabiano Rosas <farosas@suse.de>, Kevin Wolf <kwolf@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Warner Losh <imp@bsdimp.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH 1/4] docs/devel: relax policy on AI-generated contributions
Message-ID: <av7nikqiy3m-sLPS@redhat.com>
References: <20261118104150.599535-1-pbonzini@redhat.com>
 <20261118104150.599535-2-pbonzini@redhat.com>
 <av3D7Z8UYQBOI2Cp@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <av3D7Z8UYQBOI2Cp@redhat.com>
User-Agent: Mutt/2.4.3 (2026-10-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 18, 2026 at 09:30:04AM -0600, Eric Blake wrote:
> On Wed, Nov 18, 2026 at 11:41:47AM +0100, Paolo Bonzini wrote:
> > Until now QEMU's code provenance policy declined any contribution
> > believed to include or derive from AI-generated content.  A blanket ban
> > was easy to maintain while LLM output was rarely usable on its own, but
> > as the tools improved an absolute prohibition has become harder to
> > justify and enforce.
> > 
> 
> > +LLM-assisted and LLM-created contributions
> > +''''''''''''''''''''''''''''''''''''''''''
> > +
> > +Use of generative AI can be classified in the following four buckets:
> 
> This calls out four buckets...

This is a classic trap with itemized lists. Just remove the word 'four',
since there's no need to tell people upfront how many list items to expect.

> 
> > +
> > +- "background" assistance, such as completion and code review.  This does
> > +  not need disclosure.
> > +
> > +- small LLM-assisted bugfixes (as a rule of thumb, below 10 lines of code)
> > +  are allowed with disclosure.
> > +
> > +- use of LLMs to help generating parts of a larger patch---test cases,
> > +  adaptations of existing code, boilerplate code for a new API, a tool to
> > +  help performing mechanical changes, etc.  These are generally allowed;
> > +  disclosure is required for non-trivial, functional code changes.
> > +
> > +Large, heavily LLM-assisted contributions where LLMs write large parts
> > +of functional code are currently not allowed.
> 
> ...but only three bullet points, until the later patches add in a
> fourth bucket. If the entire series goes in, I don't know if it is
> worth the churn of respinning (a slight docs inconsistency when
> bisecting is different than non-working code); but if the consensus is
> to delay the patch for the fourth bucket to a later date, then this
> may need another round of word-smithing.
> 
> Reviewed-by: Eric Blake <eblake@redhat.com>
> 
> -- 
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.
> Virtualization:  qemu.org | libguestfs.org
> 

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


