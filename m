Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3A37C77B7C
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Jun 2025 17:36:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uU7Ya-0005Mr-Hx; Tue, 24 Jun 2025 13:35:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uU7YR-0005M4-K2
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 13:35:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uU7YP-0000T6-IW
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 13:35:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750786528;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6dNc/7qMQtevFpjeDgJqTje2Pb3+2eTRh8+wg1imkdc=;
 b=bsZ2AXfbQ7TjmPenfn2BD9dUZ1cTdd4DEyvsxOPBv8eaQnaxTKchvDvzQhCGV5tKrxBqsB
 4qJQHrNLjbFNZNJPjZ1dj1WrixodC4CTzSPVdFWw6qpy0DJBnzYyfyQbxuELLWWFKsqrJa
 zLx4c/NtGyVXjheKj+XeHOOus4ad7W4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-393-KGZeuE9AMC24jxIdBodOoA-1; Tue,
 24 Jun 2025 13:35:24 -0400
X-MC-Unique: KGZeuE9AMC24jxIdBodOoA-1
X-Mimecast-MFC-AGG-ID: KGZeuE9AMC24jxIdBodOoA_1750786522
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4D9DE180029F; Tue, 24 Jun 2025 17:35:21 +0000 (UTC)
Received: from localhost (unknown [10.2.16.196])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B81D919560A3; Tue, 24 Jun 2025 17:35:19 +0000 (UTC)
Date: Tue, 24 Jun 2025 13:33:33 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Alexander Graf <agraf@csgraf.de>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v5 0/3] docs: define policy forbidding use of "AI" / LLM
 code generators
Message-ID: <20250624173333.GA16178@fedora>
References: <20250616092241.212898-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="6p454iRL5vagrg5m"
Content-Disposition: inline
In-Reply-To: <20250616092241.212898-1-armbru@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


--6p454iRL5vagrg5m
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 16, 2025 at 11:22:38AM +0200, Markus Armbruster wrote:
> More than a year ago, Daniel posted patches to put an AI policy in
> writing.  Reception was mostly positive.  A v2 to address feedback
> followed with some delay.  But no pull request.
>=20
> I asked Daniel why, and he told me he was concerned it might go too
> far in its interpretation of the DCO requirements.  After a bit of
> discussion, I think Daniel's text is basically fine.  The policy it
> describes is simple and strict.  Relaxing policy is easier than
> tightening it.  I softened the phrasing slightly, addressed open
> review comments, and fixed a few minor things I found myself.
>=20
> Here's Daniel's cover letter for v2:
>=20
> This patch kicks the hornet's nest of AI / LLM code generators.
>=20
> With the increasing interest in code generators in recent times,
> it is inevitable that QEMU contributions will include AI generated
> code. Thus far we have remained silent on the matter. Given that
> everyone knows these tools exist, our current position has to be
> considered tacit acceptance of the use of AI generated code in QEMU.
>=20
> The question for the project is whether that is a good position for
> QEMU to take or not ?
>=20
> IANAL, but I like to think I'm reasonably proficient at understanding
> open source licensing. I am not inherantly against the use of AI tools,
> rather I am anti-risk. I also want to see OSS licenses respected and
> complied with.
>=20
> AFAICT at its current state of (im)maturity the question of licensing
> of AI code generator output does not have a broadly accepted / settled
> legal position. This is an inherant bias/self-interest from the vendors
> promoting their usage, who tend to minimize/dismiss the legal questions.
> >From my POV, this puts such tools in a position of elevated legal risk.
>=20
> Given the fuzziness over the legal position of generated code from
> such tools, I don't consider it credible (today) for a contributor
> to assert compliance with the DCO terms (b) or (c) (which is a stated
> pre-requisite for QEMU accepting patches) when a patch includes (or is
> derived from) AI generated code.
>=20
> By implication, I think that QEMU must (for now) explicitly decline
> to (knowingly) accept AI generated code.
>=20
> Perhaps a few years down the line the legal uncertainty will have
> reduced and we can re-evaluate this policy.
>=20
> Discuss...
>=20
> Changes in v4 [Markus Armbruster]:
>  * PATCH 2:
>    - Drop "follow a deterministic process" clause [Peter]
>=20
> Changes in v4 [Markus Armbruster]:
>  * PATCH 1:
>    - Revert v3's "known identity", and instead move existing paragraph
>      from submitting-a-patch.rst to code-provenance.rst [Philippe]
>    - Add a paragraph on recording maintainer modifications [Alex]
>  * PATCH 3:
>    - Talk about "AI-assisted software development", "AI content
>      generators", and "content", not just "AI code generators" and
>      "code" [Stefan, Daniel]
>    - Fix spelling of Copilot, and mention Claude [Stefan]
>    - Fix link text for reference to the DCO
>    - Reiterate the policy does not apply to other uses of AI [Stefan,
>      Daniel]
>    - Add agents to the examples of tools impacted by the policy
>      [Daniel]
>=20
> Changes in v3 [Markus Armbruster]:
>=20
>  * PATCH 1:
>    - Require "known identity" (phrasing stolen from Linux kernel docs)
>      [Peter]
>    - Clarify use of multiple addresses [Michael]
>    - Improve markup
>    - Fix a few misspellings
>    - Left for later: explain our use of Message-Id: [Alex]
>  * PATCH 2:
>    - Minor phrasing tweaks and spelling fixes
>  * PATCH 3:
>    - Don't claim DCO compliance is currently impossible, do point out
>      it's unclear how, and that we consider the legal risk not
>      acceptable.
>    - Stress that the policy is open to revision some more by adding
>      "as AI tools mature".  Also rephrase the commit message.
>    - Improve markup
>=20
> Changes in v2 [Daniel Berrang=E9]:
>=20
>  * Fix a huge number of typos in docs
>  * Clarify that maintainers should still add R-b where relevant, even
>    if they are already adding their own S-oB.
>  * Clarify situation when contributor re-starts previously abandoned
>    work from another contributor.
>  * Add info about Suggested-by tag
>  * Add new docs section dealing with the broad topic of "generated
>    files" (whether code generators or compilers)
>  * Simplify the section related to prohibition of AI generated files
>    and give further examples of tools considered covered
>  * Remove repeated references to "LLM" as a specific technology, just
>    use the broad "AI" term, except for one use of LLM as an example.
>  * Add note that the policy may evolve if the legal clarity improves
>  * Add note that exceptions can be requested on case-by-case basis
>    if contributor thinks they can demonstrate a credible copyright
>    and licensing status
>=20
> Daniel P. Berrang=E9 (3):
>   docs: introduce dedicated page about code provenance / sign-off
>   docs: define policy limiting the inclusion of generated files
>   docs: define policy forbidding use of AI code generators
>=20
>  docs/devel/code-provenance.rst    | 338 ++++++++++++++++++++++++++++++
>  docs/devel/index-process.rst      |   1 +
>  docs/devel/submitting-a-patch.rst |  23 +-
>  3 files changed, 341 insertions(+), 21 deletions(-)
>  create mode 100644 docs/devel/code-provenance.rst
>=20
> --=20
> 2.49.0
>=20

Thanks, applied:
https://gitlab.com/qemu-project/qemu/-/commits/master

Stefan

--6p454iRL5vagrg5m
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmha4W0ACgkQnKSrs4Gr
c8hMGAgAiWSPl4GovF1ZWC6FeaTIcJMZp4Qvvx722ZLTgBzzqKzTfffBJp8C6vGm
IiG9vXA0WlxjjzRL43g0/ltL71+DxmL+uJls7RqkS9LrU8nclXv5blKXyAECol61
ErpMmvxPVKNoTlky6uY3S36CSgFwUhAD5naSvzWgoM0Cw8PIQSLttl84zkrkFpsh
MBq1hQktXXfipc1l+zlTYl2J12AAZ4Db68fkb5IrzKw8oybyA4Hssj5VsSW+T1YC
Rw2AhkBGj80HCs7onEd+3PVMs+PaTNnePfLsllPiIhY+8HAd+krhNvhD2xa2QuPL
XJyZIm0sgkamXfn4bmPyvF/mnwu7QA==
=d1FU
-----END PGP SIGNATURE-----

--6p454iRL5vagrg5m--


