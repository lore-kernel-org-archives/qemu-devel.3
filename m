Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16801CD3445
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 07:12:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKsuB-0007Ay-Dr; Thu, 07 May 2026 03:12:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wKsu9-0007Ai-9h
 for qemu-devel@nongnu.org; Thu, 07 May 2026 03:12:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wKsu5-0001XN-BZ
 for qemu-devel@nongnu.org; Thu, 07 May 2026 03:12:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778137931;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZVdglFCO01gfH0EYc5JWpZi9d1V2V3RUlTQBE1Gp1vw=;
 b=AWMuP4rXujhe5eI+VF4JRO7taVq3NE9DYelHKEPuKrNuJrVFdC5sRDnBjSwZjtZI1jCRm1
 /kF9hHMQKCXxIWuRK3c6u20BM9uq3vspoSyA/3cZcqm+5sm4eqG275+q8aRVM62Dsq1XCZ
 M+T47/Yo/hlL525rKIGnTLWR+9J/xT0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-672-mzrFE9H9OXKqoQomlRN21Q-1; Thu,
 07 May 2026 03:12:07 -0400
X-MC-Unique: mzrFE9H9OXKqoQomlRN21Q-1
X-Mimecast-MFC-AGG-ID: mzrFE9H9OXKqoQomlRN21Q_1778137926
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 59B3A18005BF; Thu,  7 May 2026 07:12:06 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AF87219560A2; Thu,  7 May 2026 07:12:05 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4E12A21E6A01; Thu, 07 May 2026 09:12:03 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Tyler Vo <vo068@csusm.edu>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: Implementation of AI policy listed in code provenance
In-Reply-To: <BYAPR05MB629521B4B070F968020109D1FC3E2@BYAPR05MB6295.namprd05.prod.outlook.com>
 (Tyler Vo's message of "Tue, 5 May 2026 06:27:31 +0000")
References: <BYAPR05MB629521B4B070F968020109D1FC3E2@BYAPR05MB6295.namprd05.prod.outlook.com>
Date: Thu, 07 May 2026 09:12:03 +0200
Message-ID: <871pfng0cc.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Tyler Vo <vo068@csusm.edu> writes:

> To whom it may concern,
>
> My name is Tyler Vo, a master's student at California State
> University, San Marcos. As part of my thesis, I am researching the
> effects of AI/LLM usage on open-source software on
> racial/social/gender bias. I came across the Qemu project as I was
> trying to find an open-source repository that rejects AI-generated
> contributions.

Thanks for your interest.

Another one is Zig.  I think you should read Loris Cro's "Contributor
Poker and Zig's AI Ban":
https://kristoff.it/blog/contributor-poker-and-ai/

>                However, although the code provenance section of the
> documentation does state that AI-generated content is not allowed in
> contributions to Qemu, I would like to know how AI-generated content
> is detected in pull requests and the like.

I participated in the discussions around QEMU's AI policy.  I'll try to
answer your question based on that.  All quotations are from
docs/devel/code-provenance.rst.

Let's start with the general provenance rule:

    The QEMU community **mandates** all contributors to certify provenance of
    patch submissions they make to the project. To put it another way,
    contributors must indicate that they are legally permitted to contribute to
    the project.

    Certification is achieved with a low overhead by adding a single line to the
    bottom of every git commit::

       Signed-off-by: YOUR NAME <YOUR@EMAIL>

    The addition of this line asserts that the author of the patch is contributing
    in accordance with the clauses specified in the
    `Developer's Certificate of Origin <https://developercertificate.org>`__:

    .. _dco:

      Developer's Certificate of Origin 1.1

      By making a contribution to this project, I certify that:

      (a) The contribution was created in whole or in part by me and I
          have the right to submit it under the open source license
          indicated in the file; or

      (b) The contribution is based upon previous work that, to the best
          of my knowledge, is covered under an appropriate open source
          license and I have the right under that license to submit that
          work with modifications, whether created in whole or in part
          by me, under the same open source license (unless I am
          permitted to submit under a different license), as indicated
          in the file; or

      (c) The contribution was provided directly to me by some other
          person who certified (a), (b) or (c) and I have not modified
          it.

      (d) I understand and agree that this project and the contribution
          are public and that a record of the contribution (including all
          personal information I submit with it, including my sign-off) is
          maintained indefinitely and may be redistributed consistent with
          this project or the open source license(s) involved.

How do we detect violations of this rule?  There are two kinds:

1. People fail to provide a Signed-off-by line.

   We require everyone involved in making and merging the patch to
   provide one.  We reject contributions that lack required sign-offs.

2. People provide a Signed-off-by line without actually complying with
   (a) to (d).

   We trust people not to lie to us, and to exercise appropriate care.

   Note that lying / carelessness about such things can have unpleasant
   legal consequences for the liar / careless person.

Now consider AI generated content:

    The QEMU community requires that contributors certify their patch submissions
    are made in accordance with the rules of the `Developer's Certificate of
    Origin (DCO) <dco>`.

    To satisfy the DCO, the patch contributor has to fully understand the
    copyright and license status of content they are contributing to QEMU. With AI
    content generators, the copyright and license status of the output is
    ill-defined with no generally accepted, settled legal foundation.

    Where the training material is known, it is common for it to include large
    volumes of material under restrictive licensing/copyright terms. Even where
    the training material is all known to be under open source licenses, it is
    likely to be under a variety of terms, not all of which will be compatible
    with QEMU's licensing requirements.

This connects the special case of AI generated content to the general
provenance problem.

    How contributors could comply with DCO terms (b) or (c) for the output of AI
    content generators commonly available today is unclear.  The QEMU project is
    not willing or able to accept the legal risks of non-compliance.

This states that the QEMU project assumes non-compliance with (b) and
(c), rendering a Signed-off-by *invalid* as far as we're concerned.  In
other words, it's kind 2. above.  The answer to your question "how
AI-generated content is detected in pull requests and the like" is given
right there:

   We trust people not to lie to us, and to exercise appropriate care.

   Note that lying / carelessness about such things can have unpleasant
   legal consequences for the liar / careless person.

Further questions?


