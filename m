Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C92D606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 11:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=C0jprQKr
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVSBQ-00022m-Cx; Mon, 23 Nov 2026 06:26:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xVSBI-00021N-Iv
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 06:25:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xVSBF-0000SG-CK
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 06:25:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795433150;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O7Sm6hEZ9QwWuD2xWdnfBGn07dnCAXzEbs9jC/59si0=;
 b=C0jprQKrQYocveQ8kleBx6K1rUw26BOMsOC5htqkgNY8SUAlchjxZzXXSc+Di4p7ov/yFZ
 xQr+pmv0sOQCX+KUsfHr9Js7JSq6GixHVGjshN5tdxPF/ToFs7mG0vvxOuqiUiYt3Getpx
 EyGdWDg3epqO1dvk+MWi1a79LvtLIh0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-413-xKz7PsMiNQ-p_Vapoexd7w-1; Mon,
 23 Nov 2026 11:25:46 +0000
X-MC-Unique: xKz7PsMiNQ-p_Vapoexd7w-1
X-Mimecast-MFC-AGG-ID: xKz7PsMiNQ-p_Vapoexd7w_1795433144
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9A0231956054; Mon, 23 Nov 2026 11:25:44 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 68FBC1956087; Mon, 23 Nov 2026 11:25:41 +0000 (UTC)
Date: Mon, 23 Nov 2026 11:25:38 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 Fabiano Rosas <farosas@suse.de>, Kevin Wolf <kwolf@redhat.com>,
 Warner Losh <imp@bsdimp.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH 1/4] docs/devel: relax policy on AI-generated contributions
Message-ID: <awQisiKRYpQSTmVy@redhat.com>
References: <20260930085433.830743-1-pbonzini@redhat.com>
 <20260930085433.830743-2-pbonzini@redhat.com>
 <CAFEAcA91XU=_hS3iB+0p7hXQ_nvf0YpgNZaKsd=b=fSVaTJDxw@mail.gmail.com>
 <ar_FXE5rzVqKcTc4@redhat.com> <87ik21vy11.fsf@pond.sub.org>
 <CABgObfagz=EvmYtNFBo2xyDdXNkFPK8k0-YGDs7aVS6xRKEJTw@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABgObfagz=EvmYtNFBo2xyDdXNkFPK8k0-YGDs7aVS6xRKEJTw@mail.gmail.com>
User-Agent: Mutt/2.4.3 (2026-10-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
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
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 18, 2026 at 01:22:41PM +0100, Paolo Bonzini wrote:
> On Fri, Nov 13, 2026 at 11:14 AM Markus Armbruster <armbru@redhat.com> wrote:
> > David wants to do the same but with AI.  He "pre-arranges", and Bob
> > agrees to review.  Does Charlie get a vote?  What about me?
> 
> Charlie the co-maintainer does "get a vote" on merging, yes, and she
> is free to leave the review to Bob as well. Well, technically we do
> not operate by voting, but co-maintainers are supposed to operate by
> consensus and this is no exception.
> 
> You the QMP maintainer... it depends. Probably not if the only change
> is along the lines of:
> 
> -{ 'enum': 'Accelerator', 'data': ['hvf', 'kvm', 'nvmm', 'qtest',
> 'tcg', 'whpx', 'xen'] }
> +{ 'enum': 'Accelerator', 'data': ['hvf', 'kvm', 'mshv', 'nvmm',
> 'qtest', 'tcg', 'whpx', 'xen'] }
> 
> Even larger QMP interfaces may fall under bullet #3 - parts of large
> code changes - but you definitely get a vote if there are substantial
> changes to code you maintain. No doubt about that! This is just normal
> interaction between maintainers; I think we do well in that respect
> and I see no reason for LLMs to change that.

This is a new situation with LLMs though, and it ties back to the
SFC's (IMHO impossible) guidance that is included in this patch:

  "the project seeks to both support those contributors who outright reject
   generative AI systems, and to not shun those who choose to use them;"

If the contributor wants to use LLM, and some but not all maintainers
do not, then we've got an impossible situation where someone is going
to come away quite unhappy.

I don't think the proposal to allow pre-arrangement between contributor
and /a/ maintainer is workable, unless we accept that manitainers of
common code are just going to have to accept the result.

There are plenty of examples of series which start off self-contained,
but grow into changes in common library code maintained by other
people. Often the maintainer of the common code won't get looped in
until v5 or v10 posting of a series. By that point the LLM usage will
be present throughout the patch series.  There will be way too much
pressure to accept the LLM usage in the common code, for the other
maintainers to be able to say no. 

> We may have to become more accustomed to saying no to contributors and
> even co-maintainers, but I think we're good at building/accepting
> consensus. I'm sure that stuff like the Meson migration was seen with
> skepticism by some members of the community, but it was accepted
> nevertheless. (I hope it has proven itself; and I was also on the
> other side of the fence with Pierrick's recent tests/tcg overhaul,
> btw).

The meson migration was still ultimately a technically driven design
debate, where it was not entirely certain upfront that the proposal
would give the benefits over 'make' that we hoped it would. The proof
is in the end result of the implementation, if the end result is good,
we merge it, if not we re-evaluate.

The difference with the LLM agent situation is that it is not merely
the end result that matters. The process that everyone lives through
to get to that end result is just as important and where alot of the
harmful impact on maintainers can come in.



With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


