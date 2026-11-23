Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54DB606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 13:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pond.sub.org header.i=@pond.sub.org header.a=rsa-sha256 header.s=mail header.b=D+aOXwR8
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVTxH-0004mf-FK; Mon, 23 Nov 2026 08:19:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@pond.sub.org>)
 id 1xVTxF-0004ly-I4
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 08:19:33 -0500
Received: from oxygen.pond.sub.org ([94.130.129.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@pond.sub.org>)
 id 1xVTxC-0007eB-U9
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 08:19:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=pond.sub.org; s=mail;
 t=1795439959; bh=dwyPXjMWccBlVtp5q9emcB0h4elN+/djqQMaMd8UFC8=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=D+aOXwR8Z+tnmCs80+EjmrmX7txK85YwkXOR60IH6FyoAqM+xJxoqNAdzhSYmjTa6
 hYERXsmTDF+wtDJQ2uz59bCrIxKcPIZE55IspggAqAcqxVQPrDXsjfqaCnBRPnI8kM
 Wsml+azpKFaeFc/MnzU5PKFFgLqrwHIV0tx6D0K4=
Received: from blackfin.pond.sub.org (p4fd045cf.dip0.t-ipconnect.de
 [79.208.69.207])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (Client did not present a certificate)
 by oxygen.pond.sub.org (Postfix) with ESMTPSA id 69E1520082;
 Mon, 23 Nov 2026 14:19:18 +0100 (CET)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8148321E6A04; Mon, 23 Nov 2026 14:19:26 +0100 (CET)
From: Markus Armbruster <armbru@pond.sub.org>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,  Peter Maydell
 <peter.maydell@linaro.org>,  qemu-devel@nongnu.org,  "Michael S . Tsirkin"
 <mst@redhat.com>,  Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alistair Francis
 <alistair.francis@wdc.com>,  BALATON Zoltan <balaton@eik.bme.hu>,  Fabiano
 Rosas <farosas@suse.de>,  Kevin Wolf <kwolf@redhat.com>,  Warner Losh
 <imp@bsdimp.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
Subject: Re: [PATCH 1/4] docs/devel: relax policy on AI-generated contributions
In-Reply-To: <awQisiKRYpQSTmVy@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Mon, 23 Nov 2026 11:25:38 +0000")
References: <20260930085433.830743-1-pbonzini@redhat.com>
 <20260930085433.830743-2-pbonzini@redhat.com>
 <CAFEAcA91XU=_hS3iB+0p7hXQ_nvf0YpgNZaKsd=b=fSVaTJDxw@mail.gmail.com>
 <ar_FXE5rzVqKcTc4@redhat.com> <87ik21vy11.fsf@pond.sub.org>
 <CABgObfagz=EvmYtNFBo2xyDdXNkFPK8k0-YGDs7aVS6xRKEJTw@mail.gmail.com>
 <awQisiKRYpQSTmVy@redhat.com>
Date: Mon, 23 Nov 2026 14:19:26 +0100
Message-ID: <87a4mzwuqp.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=94.130.129.15; envelope-from=armbru@pond.sub.org;
 helo=oxygen.pond.sub.org
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Wed, Nov 18, 2026 at 01:22:41PM +0100, Paolo Bonzini wrote:
>> On Fri, Nov 13, 2026 at 11:14=E2=80=AFAM Markus Armbruster <armbru@redha=
t.com> wrote:
>> > David wants to do the same but with AI.  He "pre-arranges", and Bob
>> > agrees to review.  Does Charlie get a vote?  What about me?
>>=20
>> Charlie the co-maintainer does "get a vote" on merging, yes, and she
>> is free to leave the review to Bob as well. Well, technically we do
>> not operate by voting, but co-maintainers are supposed to operate by
>> consensus and this is no exception.
>>=20
>> You the QMP maintainer... it depends. Probably not if the only change
>> is along the lines of:
>>=20
>> -{ 'enum': 'Accelerator', 'data': ['hvf', 'kvm', 'nvmm', 'qtest',
>> 'tcg', 'whpx', 'xen'] }
>> +{ 'enum': 'Accelerator', 'data': ['hvf', 'kvm', 'mshv', 'nvmm',
>> 'qtest', 'tcg', 'whpx', 'xen'] }
>>=20
>> Even larger QMP interfaces may fall under bullet #3 - parts of large
>> code changes - but you definitely get a vote if there are substantial
>> changes to code you maintain. No doubt about that! This is just normal
>> interaction between maintainers; I think we do well in that respect
>> and I see no reason for LLMs to change that.
>
> This is a new situation with LLMs though, and it ties back to the
> SFC's (IMHO impossible) guidance that is included in this patch:
>
>   "the project seeks to both support those contributors who outright reje=
ct
>    generative AI systems, and to not shun those who choose to use them;"
>
> If the contributor wants to use LLM, and some but not all maintainers
> do not, then we've got an impossible situation where someone is going
> to come away quite unhappy.
>
> I don't think the proposal to allow pre-arrangement between contributor
> and /a/ maintainer is workable, unless we accept that manitainers of
> common code are just going to have to accept the result.
>
> There are plenty of examples of series which start off self-contained,
> but grow into changes in common library code maintained by other
> people. Often the maintainer of the common code won't get looped in
> until v5 or v10 posting of a series.

Matches my experience.

Such growth is commonly due to reviewers demanding improvements.  The
reviewers are commonly right.

>                                      By that point the LLM usage will
> be present throughout the patch series.  There will be way too much
> pressure to accept the LLM usage in the common code, for the other
> maintainers to be able to say no.=20

Oh yes.

>> We may have to become more accustomed to saying no to contributors and
>> even co-maintainers, but I think we're good at building/accepting
>> consensus. I'm sure that stuff like the Meson migration was seen with
>> skepticism by some members of the community, but it was accepted
>> nevertheless. (I hope it has proven itself; and I was also on the
>> other side of the fence with Pierrick's recent tests/tcg overhaul,
>> btw).
>
> The meson migration was still ultimately a technically driven design
> debate, where it was not entirely certain upfront that the proposal
> would give the benefits over 'make' that we hoped it would. The proof
> is in the end result of the implementation, if the end result is good,
> we merge it, if not we re-evaluate.
>
> The difference with the LLM agent situation is that it is not merely
> the end result that matters. The process that everyone lives through
> to get to that end result is just as important and where alot of the
> harmful impact on maintainers can come in.

This.

We don't just risk LLMs producing bad patches.  They can certainly do
that, but so can humans.  We risk overloading reviewers and maintainers,
deskilling and loss of theory building among developers, disagreements
over ethics, and more.

It's temping for technical people like us to focus on just the technical
problems.  That's wrong.  The social problems matter at least as much.

