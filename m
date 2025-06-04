Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83A78C5B552
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Jun 2025 07:19:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMiOn-0002Bc-FX; Wed, 04 Jun 2025 03:18:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uMiOj-0002B7-E4
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 03:18:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uMiOh-0007c3-Ao
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 03:18:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749021529;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M8P6WiHru1fMUVwZCZRBDEYyu2xzDB1zXTXIJ/J/ElY=;
 b=IEPwZbYYZT5dfHqfFFIzJ7mmH1C+oKySMKMVJCgY+/ykq3e22p7lxgqmyp/thvPQtYIn1F
 pV109hRN3RTECHHq8VNIp+tjFZx72mx0HecC812htIcyOT3bfv+GdWPKvOVnT44flVcPYJ
 /XUMswvO8ejh6uifSUz9aNPPDcPELSY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-594-MfRaPlrNOKGRERb-hz-gBw-1; Wed,
 04 Jun 2025 03:18:46 -0400
X-MC-Unique: MfRaPlrNOKGRERb-hz-gBw-1
X-Mimecast-MFC-AGG-ID: MfRaPlrNOKGRERb-hz-gBw_1749021524
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9BCA3195609F; Wed,  4 Jun 2025 07:18:44 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.60])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5E86A1955DDA; Wed,  4 Jun 2025 07:18:39 +0000 (UTC)
Date: Wed, 4 Jun 2025 08:18:35 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Alexander Graf <agraf@csgraf.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v3 1/3] docs: introduce dedicated page about code
 provenance / sign-off
Message-ID: <aD_zSx6qRnwKulR7@redhat.com>
References: <20250603142524.4043193-1-armbru@redhat.com>
 <20250603142524.4043193-2-armbru@redhat.com>
 <87a56o3gxc.fsf@draig.linaro.org> <87r000ypi0.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87r000ypi0.fsf@pond.sub.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.128,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Jun 04, 2025 at 08:44:55AM +0200, Markus Armbruster wrote:
> Alex Bennée <alex.bennee@linaro.org> writes:
> 
> > Markus Armbruster <armbru@redhat.com> writes:
> >
> >> From: Daniel P. Berrangé <berrange@redhat.com>
> >>
> >> Currently we have a short paragraph saying that patches must include
> >> a Signed-off-by line, and merely link to the kernel documentation.
> >> The linked kernel docs have a lot of content beyond the part about
> >> sign-off an thus are misleading/distracting to QEMU contributors.
> >>
> >> This introduces a dedicated 'code-provenance' page in QEMU talking
> >> about why we require sign-off, explaining the other tags we commonly
> >> use, and what to do in some edge cases.
> >>
> >> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> >> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> >> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> >> ---
> >>  docs/devel/code-provenance.rst    | 218 ++++++++++++++++++++++++++++++
> >>  docs/devel/index-process.rst      |   1 +
> >>  docs/devel/submitting-a-patch.rst |  18 +--
> >>  3 files changed, 221 insertions(+), 16 deletions(-)
> >>  create mode 100644 docs/devel/code-provenance.rst
> >>
> >> diff --git a/docs/devel/code-provenance.rst b/docs/devel/code-provenance.rst
> >> new file mode 100644
> >> index 0000000000..4fc12061b5
> >> --- /dev/null
> >> +++ b/docs/devel/code-provenance.rst

> >> +Other commit tags
> >> +~~~~~~~~~~~~~~~~~
> >> +
> >> +While the ``Signed-off-by`` tag is mandatory, there are a number of other tags
> >> +that are commonly used during QEMU development:
> >> +
> >> + * **``Reviewed-by``**: when a QEMU community member reviews a patch on the
> >> +   mailing list, if they consider the patch acceptable, they should send an
> >> +   email reply containing a ``Reviewed-by`` tag. Subsystem maintainers who
> >> +   review a patch should add this even if they are also adding their
> >> +   ``Signed-off-by`` to the same commit.
> >> +
> >> + * **``Acked-by``**: when a QEMU subsystem maintainer approves a patch that
> >> +   touches their subsystem, but intends to allow a different maintainer to
> >> +   queue it and send a pull request, they would send a mail containing a
> >> +   ``Acked-by`` tag. Where a patch touches multiple subsystems, ``Acked-by``
> >> +   only implies review of the maintainers' own areas of responsibility. If a
> >> +   maintainer wants to indicate they have done a full review they should use
> >> +   a ``Reviewed-by`` tag.
> >> +
> >> + * **``Tested-by``**: when a QEMU community member has functionally tested the
> >> +   behaviour of the patch in some manner, they should send an email reply
> >> +   containing a ``Tested-by`` tag.
> >> +
> >> + * **``Reported-by``**: when a QEMU community member reports a problem via the
> >> +   mailing list, or some other informal channel that is not the issue tracker,
> >> +   it is good practice to credit them by including a ``Reported-by`` tag on
> >> +   any patch fixing the issue. When the problem is reported via the GitLab
> >> +   issue tracker, however, it is sufficient to just include a link to the
> >> +   issue.
> >
> > We don't mention the Link: or Message-Id: tags.
> 
> Yes, but should it go into code-provenance.rst or
> submitting-a-patch.rst?

I considered those other general tags to be under the scope
of submitting-a-patch.rst, as they're not directly related
to the legal code provenance.

> 
> You asked for guidance on use of "Message-Id:" in your review of v2.  I
> understand the practice, and can write guidance, but I wanted to get
> this out before my vacation next week, so I left it for later, as
> mentioned in the cover letter.
> 
> How do we use "Link:"?  What about "Closes:"?
> 
> Here's what the kernel's submitting-patches.rst has to say:
> 
>     Describe your changes
>     ---------------------
> 
>     [...]
> 
>     If related discussions or any other background information behind the change
>     can be found on the web, add 'Link:' tags pointing to it. If the patch is a
>     result of some earlier mailing list discussions or something documented on the
>     web, point to it.
> 
>     When linking to mailing list archives, preferably use the lore.kernel.org
>     message archiver service. To create the link URL, use the contents of the
>     ``Message-ID`` header of the message without the surrounding angle brackets.
>     For example::
> 
>         Link: https://lore.kernel.org/30th.anniversary.repost@klaava.Helsinki.FI
> 
>     Please check the link to make sure that it is actually working and points
>     to the relevant message.
> 
>     However, try to make your explanation understandable without external
>     resources. In addition to giving a URL to a mailing list archive or bug,
>     summarize the relevant points of the discussion that led to the
>     patch as submitted.
> 
>     In case your patch fixes a bug, use the 'Closes:' tag with a URL referencing
>     the report in the mailing list archives or a public bug tracker. For example::
> 
>             Closes: https://example.com/issues/1234
> 
>     Some bug trackers have the ability to close issues automatically when a
>     commit with such a tag is applied. Some bots monitoring mailing lists can
>     also track such tags and take certain actions. Private bug trackers and
>     invalid URLs are forbidden.
> 
> and
> 
>     Using Reported-by:, Tested-by:, Reviewed-by:, Suggested-by: and Fixes:
>     ----------------------------------------------------------------------
> 
>     The Reported-by tag gives credit to people who find bugs and report them and it
>     hopefully inspires them to help us again in the future. The tag is intended for
>     bugs; please do not use it to credit feature requests. The tag should be
>     followed by a Closes: tag pointing to the report, unless the report is not
>     available on the web. The Link: tag can be used instead of Closes: if the patch
>     fixes a part of the issue(s) being reported. Note, the Reported-by tag is one
>     of only three tags you might be able to use without explicit permission of the
>     person named (see 'Tagging people requires permission' below for details).
> 

> >> +git commands
> >> +^^^^^^^^^^^^
> >> +
> >> +When creating, or amending, a commit the ``-s`` flag to ``git commit`` will
> >> +append a suitable line matching the configured git author details.
> >> +
> >> +If preparing patches using the ``git format-patch`` tool, the ``-s`` flag can
> >> +be used to append a suitable line in the emails it creates, without modifying
> >> +the local commits. Alternatively to modify all the local commits on a branch::
> >> +
> >> +  git rebase master -x 'git commit --amend --no-edit -s'
> >> +
> >
> > Much as I love Emacs I wonder if this next section is worth it given the
> > multiple ways you can solve this (I use yas-snippet expansions for
> > example).
> 
> Showing one of them could still be useful for less experienced Emacs
> users.  We could mention it's just of many ways.

Yep, IMHO it is worth guiding users to a simple example that works.
If they are advanced users of emacs or other editors wanting to figure
out other options they can ignore this guidance.

> 
> > If we do want to mention the editors we should probably also mention b4.
> 
> Can do if somebody contributes a suitable configuration snippet.
> 
> Thanks!
> 
> [...]
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


