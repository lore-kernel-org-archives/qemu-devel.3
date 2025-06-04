Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DD2BC5B543
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Jun 2025 06:46:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMhs8-00086e-Og; Wed, 04 Jun 2025 02:45:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uMhs6-00086V-Fo
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 02:45:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uMhs3-0003aK-RY
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 02:45:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749019504;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4SszYzQHPBw9DekVUed6b53aI3Ic9A8xyNS670fyf0s=;
 b=KEvmMwuJdUIGWPTrk5JviGOLZY8iidCgJUCoBFI4JHLRODQyv/4pVBPvT0pL5G0qygEuEE
 Y3goiFHL/5IaVuXpMZtpCkH4KBlnbPsG2i3ZnAjJc1xbhgMS+ZV2smmTICWHgO7B1tYEY8
 GpCD8XOFwaUlxliL/vOLzHO7nvsVce0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-12-ZDUwPDj5PXamhUifQcyi2Q-1; Wed,
 04 Jun 2025 02:45:01 -0400
X-MC-Unique: ZDUwPDj5PXamhUifQcyi2Q-1
X-Mimecast-MFC-AGG-ID: ZDUwPDj5PXamhUifQcyi2Q_1749019500
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8E9061956087; Wed,  4 Jun 2025 06:44:59 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.38])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BEA9419560A3; Wed,  4 Jun 2025 06:44:58 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id AD90521E6766; Wed, 04 Jun 2025 08:44:55 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org,  Daniel P . =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,  "Michael S . Tsirkin" <mst@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,  Mark Cave-Ayland
 <mark.cave-ayland@ilande.co.uk>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Kevin Wolf <kwolf@redhat.com>,  Stefan Hajnoczi
 <stefanha@redhat.com>,  Alexander Graf <agraf@csgraf.de>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v3 1/3] docs: introduce dedicated page about code
 provenance / sign-off
In-Reply-To: <87a56o3gxc.fsf@draig.linaro.org> ("Alex =?utf-8?Q?Benn=C3=A9?=
 =?utf-8?Q?e=22's?= message of "Tue, 03 Jun 2025 17:53:35 +0100")
References: <20250603142524.4043193-1-armbru@redhat.com>
 <20250603142524.4043193-2-armbru@redhat.com>
 <87a56o3gxc.fsf@draig.linaro.org>
Date: Wed, 04 Jun 2025 08:44:55 +0200
Message-ID: <87r000ypi0.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.128,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_FILL_THIS_FORM_SHORT=0.01 autolearn=ham autolearn_force=no
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

Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> Markus Armbruster <armbru@redhat.com> writes:
>
>> From: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>>
>> Currently we have a short paragraph saying that patches must include
>> a Signed-off-by line, and merely link to the kernel documentation.
>> The linked kernel docs have a lot of content beyond the part about
>> sign-off an thus are misleading/distracting to QEMU contributors.
>>
>> This introduces a dedicated 'code-provenance' page in QEMU talking
>> about why we require sign-off, explaining the other tags we commonly
>> use, and what to do in some edge cases.
>>
>> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  docs/devel/code-provenance.rst    | 218 ++++++++++++++++++++++++++++++
>>  docs/devel/index-process.rst      |   1 +
>>  docs/devel/submitting-a-patch.rst |  18 +--
>>  3 files changed, 221 insertions(+), 16 deletions(-)
>>  create mode 100644 docs/devel/code-provenance.rst
>>
>> diff --git a/docs/devel/code-provenance.rst b/docs/devel/code-provenance=
.rst
>> new file mode 100644
>> index 0000000000..4fc12061b5
>> --- /dev/null
>> +++ b/docs/devel/code-provenance.rst
>> @@ -0,0 +1,218 @@
>> +.. _code-provenance:
>> +
>> +Code provenance
>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> +
>> +Certifying patch submissions
>> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> +
>> +The QEMU community **mandates** all contributors to certify provenance =
of
>> +patch submissions they make to the project. To put it another way,
>> +contributors must indicate that they are legally permitted to contribut=
e to
>> +the project.
>> +
>> +Certification is achieved with a low overhead by adding a single line t=
o the
>> +bottom of every git commit::
>
> s/git commit/commit/ throughout?

Yes.

>> +
>> +   Signed-off-by: YOUR NAME <YOUR@EMAIL>
>> +
>> +using a known identity (sorry, no anonymous contributions.)
>> +
>
> maybe "(contributions cannot be anonymous)" is more direct?

If we're deviating from the kernel's text (which is *fine*), let's get
rid of the parenthesis:

    using a known identity.  Contributions cannot be anonymous.

or in active voice:

    using a known identity.  We cannot accept anonymous contributions.

I like this one the best.

>> +The addition of this line asserts that the author of the patch is contr=
ibuting
>> +in accordance with the clauses specified in the
>> +`Developer's Certificate of Origin <https://developercertificate.org>`_=
_:
>> +
>> +.. _dco:
>> +
>> +  Developer's Certificate of Origin 1.1
>> +
>> +  By making a contribution to this project, I certify that:
>> +
>> +  (a) The contribution was created in whole or in part by me and I
>> +      have the right to submit it under the open source license
>> +      indicated in the file; or
>> +
>> +  (b) The contribution is based upon previous work that, to the best
>> +      of my knowledge, is covered under an appropriate open source
>> +      license and I have the right under that license to submit that
>> +      work with modifications, whether created in whole or in part
>> +      by me, under the same open source license (unless I am
>> +      permitted to submit under a different license), as indicated
>> +      in the file; or
>> +
>> +  (c) The contribution was provided directly to me by some other
>> +      person who certified (a), (b) or (c) and I have not modified
>> +      it.
>> +
>> +  (d) I understand and agree that this project and the contribution
>> +      are public and that a record of the contribution (including all
>> +      personal information I submit with it, including my sign-off) is
>> +      maintained indefinitely and may be redistributed consistent with
>> +      this project or the open source license(s) involved.
>> +
>> +It is generally expected that the name and email addresses used in one =
of the
>> +``Signed-off-by`` lines, matches that of the git commit ``Author`` fiel=
d.
>> +It's okay if you subscribe or contribute to the list via more than one
>> +address, but using multiple addresses in one commit just confuses
>> +things.
>> +
>> +If the person sending the mail is not one of the patch authors, they are
>> +nonetheless expected to add their own ``Signed-off-by`` to comply with =
the
>> +DCO clause (c).
>
> We should probably mention that sometimes the committer may update the
> patch after they have pulled it into the tree. In those cases we preface
> the S-o-B tag with a comment:
>
>   Signed-off-by: Original Hacker <hacker@domain>
>   [MH: tweaked the commit message for clarity]
>   Signed-off-by: Maintainer Hacker <hacker@another.com>

Good idea.  Should this go here or under "Subsystem maintainer
requirements"?

>> +
>> +Multiple authorship
>> +~~~~~~~~~~~~~~~~~~~
>> +
>> +It is not uncommon for a patch to have contributions from multiple auth=
ors. In
>> +this scenario, git commits will usually be expected to have a ``Signed-=
off-by``
>> +line for each contributor involved in creation of the patch. Some edge =
cases:
>> +
>> +  * The non-primary author's contributions were so trivial that they ca=
n be
>> +    considered not subject to copyright. In this case the secondary aut=
hors
>> +    need not include a ``Signed-off-by``.
>> +
>> +    This case most commonly applies where QEMU reviewers give short sni=
ppets
>> +    of code as suggested fixes to a patch. The reviewers don't need to =
have
>> +    their own ``Signed-off-by`` added unless their code suggestion was
>> +    unusually large, but it is common to add ``Suggested-by`` as a cred=
it
>> +    for non-trivial code.
>> +
>> +  * Both contributors work for the same employer and the employer requi=
res
>> +    copyright assignment.
>> +
>> +    It can be said that in this case a ``Signed-off-by`` is indicating =
that
>> +    the person has permission to contribute from their employer who is =
the
>> +    copyright holder. It is nonetheless still preferable to include a
>> +    ``Signed-off-by`` for each contributor, as in some countries employ=
ees are
>> +    not able to assign copyright to their employer, and it also covers =
any
>> +    time invested outside working hours.
>> +
>> +When multiple ``Signed-off-by`` tags are present, they should be strict=
ly kept
>> +in order of authorship, from oldest to newest.
>> +
>> +Other commit tags
>> +~~~~~~~~~~~~~~~~~
>> +
>> +While the ``Signed-off-by`` tag is mandatory, there are a number of oth=
er tags
>> +that are commonly used during QEMU development:
>> +
>> + * **``Reviewed-by``**: when a QEMU community member reviews a patch on=
 the
>> +   mailing list, if they consider the patch acceptable, they should sen=
d an
>> +   email reply containing a ``Reviewed-by`` tag. Subsystem maintainers =
who
>> +   review a patch should add this even if they are also adding their
>> +   ``Signed-off-by`` to the same commit.
>> +
>> + * **``Acked-by``**: when a QEMU subsystem maintainer approves a patch =
that
>> +   touches their subsystem, but intends to allow a different maintainer=
 to
>> +   queue it and send a pull request, they would send a mail containing a
>> +   ``Acked-by`` tag. Where a patch touches multiple subsystems, ``Acked=
-by``
>> +   only implies review of the maintainers' own areas of responsibility.=
 If a
>> +   maintainer wants to indicate they have done a full review they shoul=
d use
>> +   a ``Reviewed-by`` tag.
>> +
>> + * **``Tested-by``**: when a QEMU community member has functionally tes=
ted the
>> +   behaviour of the patch in some manner, they should send an email rep=
ly
>> +   containing a ``Tested-by`` tag.
>> +
>> + * **``Reported-by``**: when a QEMU community member reports a problem =
via the
>> +   mailing list, or some other informal channel that is not the issue t=
racker,
>> +   it is good practice to credit them by including a ``Reported-by`` ta=
g on
>> +   any patch fixing the issue. When the problem is reported via the Git=
Lab
>> +   issue tracker, however, it is sufficient to just include a link to t=
he
>> +   issue.
>
> We don't mention the Link: or Message-Id: tags.

Yes, but should it go into code-provenance.rst or
submitting-a-patch.rst?

You asked for guidance on use of "Message-Id:" in your review of v2.  I
understand the practice, and can write guidance, but I wanted to get
this out before my vacation next week, so I left it for later, as
mentioned in the cover letter.

How do we use "Link:"?  What about "Closes:"?

Here's what the kernel's submitting-patches.rst has to say:

    Describe your changes
    ---------------------

    [...]

    If related discussions or any other background information behind the c=
hange
    can be found on the web, add 'Link:' tags pointing to it. If the patch =
is a
    result of some earlier mailing list discussions or something documented=
 on the
    web, point to it.

    When linking to mailing list archives, preferably use the lore.kernel.o=
rg
    message archiver service. To create the link URL, use the contents of t=
he
    ``Message-ID`` header of the message without the surrounding angle brac=
kets.
    For example::

        Link: https://lore.kernel.org/30th.anniversary.repost@klaava.Helsin=
ki.FI

    Please check the link to make sure that it is actually working and poin=
ts
    to the relevant message.

    However, try to make your explanation understandable without external
    resources. In addition to giving a URL to a mailing list archive or bug,
    summarize the relevant points of the discussion that led to the
    patch as submitted.

    In case your patch fixes a bug, use the 'Closes:' tag with a URL refere=
ncing
    the report in the mailing list archives or a public bug tracker. For ex=
ample::

            Closes: https://example.com/issues/1234

    Some bug trackers have the ability to close issues automatically when a
    commit with such a tag is applied. Some bots monitoring mailing lists c=
an
    also track such tags and take certain actions. Private bug trackers and
    invalid URLs are forbidden.

and

    Using Reported-by:, Tested-by:, Reviewed-by:, Suggested-by: and Fixes:
    ----------------------------------------------------------------------

    The Reported-by tag gives credit to people who find bugs and report the=
m and it
    hopefully inspires them to help us again in the future. The tag is inte=
nded for
    bugs; please do not use it to credit feature requests. The tag should be
    followed by a Closes: tag pointing to the report, unless the report is =
not
    available on the web. The Link: tag can be used instead of Closes: if t=
he patch
    fixes a part of the issue(s) being reported. Note, the Reported-by tag =
is one
    of only three tags you might be able to use without explicit permission=
 of the
    person named (see 'Tagging people requires permission' below for detail=
s).


>> +
>> + * **``Suggested-by``**: when a reviewer or other 3rd party makes non-t=
rivial
>> +   suggestions for how to change a patch, it is good practice to credit=
 them
>> +   by including a ``Suggested-by`` tag.
>> +
>> +Subsystem maintainer requirements
>> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> +
>> +When a subsystem maintainer accepts a patch from a contributor, in addi=
tion to
>> +the normal code review points, they are expected to validate the presen=
ce of
>> +suitable ``Signed-off-by`` tags.
>> +
>> +At the time they queue the patch in their subsystem tree, the maintainer
>> +**must** also then add their own ``Signed-off-by`` to indicate that the=
y have
>> +done the aforementioned validation. This is in addition to any of their=
 own
>> +``Reviewed-by`` tags the subsystem maintainer may wish to include.
>> +
>> +Tools for adding ``Signed-off-by``
>> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> +
>> +There are a variety of ways tools can support adding ``Signed-off-by`` =
tags
>> +for patches, avoiding the need for contributors to manually type in this
>> +repetitive text each time.
>> +
>> +git commands
>> +^^^^^^^^^^^^
>> +
>> +When creating, or amending, a commit the ``-s`` flag to ``git commit`` =
will
>> +append a suitable line matching the configured git author details.
>> +
>> +If preparing patches using the ``git format-patch`` tool, the ``-s`` fl=
ag can
>> +be used to append a suitable line in the emails it creates, without mod=
ifying
>> +the local commits. Alternatively to modify all the local commits on a b=
ranch::
>> +
>> +  git rebase master -x 'git commit --amend --no-edit -s'
>> +
>
> Much as I love Emacs I wonder if this next section is worth it given the
> multiple ways you can solve this (I use yas-snippet expansions for
> example).

Showing one of them could still be useful for less experienced Emacs
users.  We could mention it's just of many ways.

> If we do want to mention the editors we should probably also mention b4.

Can do if somebody contributes a suitable configuration snippet.

Thanks!

[...]


