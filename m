Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED93CC87FCA
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Jul 2025 06:55:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufCJe-0007OA-1q; Fri, 25 Jul 2025 02:54:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ufCE5-0000Tm-Iw
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 02:48:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ufCE3-0005oM-9Y
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 02:48:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753426093;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LIfDhRqpXZrpG6fqQ4BFFEM9PB9g0QWd+6CV0fT5Zus=;
 b=FNltTt0l6v6O1Z+T36DmOxllJzXnX9YxxXlLYnrJVnrEeamWKk2VT5KqPE7UJju7OpJpyQ
 X6r8DiyNxrDwTSHfXspNBb+hHZkEv29Usz6G1TTOOck10PS0OYgrUvEtI0dFFt4DBx3qBy
 CKZE4o6SEdtCbWdr+f1AoPdM7x3nz8I=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-138-BOEmVTWFMiCHo_PO62T3iA-1; Fri,
 25 Jul 2025 02:48:09 -0400
X-MC-Unique: BOEmVTWFMiCHo_PO62T3iA-1
X-Mimecast-MFC-AGG-ID: BOEmVTWFMiCHo_PO62T3iA_1753426088
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 54B97195609F; Fri, 25 Jul 2025 06:48:08 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.14])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ED5F31800B68; Fri, 25 Jul 2025 06:48:07 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 805BF21E6A27; Fri, 25 Jul 2025 08:48:05 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Michael Roth <michael.roth@amd.com>
Subject: Re: [PATCH] docs/qapi-code-gen: change recommendations for
 cross-reference syntax
In-Reply-To: <20250724231646.390181-1-jsnow@redhat.com> (John Snow's message
 of "Thu, 24 Jul 2025 19:16:46 -0400")
References: <20250724231646.390181-1-jsnow@redhat.com>
Date: Fri, 25 Jul 2025 08:48:05 +0200
Message-ID: <877bzwg40q.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.45,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

John Snow <jsnow@redhat.com> writes:

> The blurb about @foo style references in qapi-code-gen.rst is out of
> date now, update it.
>
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  docs/devel/qapi-code-gen.rst | 11 ++++++++---
>  docs/devel/qapi-domain.rst   |  1 +
>  2 files changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/docs/devel/qapi-code-gen.rst b/docs/devel/qapi-code-gen.rst
> index dfdbeac5a5a..51993a6eb0c 100644
> --- a/docs/devel/qapi-code-gen.rst
> +++ b/docs/devel/qapi-code-gen.rst
> @@ -943,9 +943,14 @@ The usual ****strong****, *\*emphasized\** and ````literal```` markup
>  should be used.  If you need a single literal ``*``, you will need to
>  backslash-escape it.
>  
> -Use ``@foo`` to reference a name in the schema.  This is an rST
> -extension.  It is rendered the same way as ````foo````, but carries
> -additional meaning.
> +Use ```foo``` to reference a name in the schema and generate a
> +cross-reference link. In the event that a cross-reference is ambiguous
> +and the manual compilation fails, `QAPI cross-reference roles
> +<QAPI-XREF>` can be used to narrow the cross-reference results.

Two spaces between sentences for consistency, please.

Scratch "manual".

The old text is about @foo, which could legitimately be used for any
name.  "A name in the schema" was fine.  "Was", because we now want
`foo` instead for certain names.

The new text is about `foo`, which can be used only for certain names:
modules and definitions.  So the new text needs to be more precise than
"a name in the schema".

The module feature is basically redundant and should not be used.
Instead of referencing the beginning of audio.json with `audio`
(shorthand for :qapi:mod:`audio`), you can (and should) reference its
heading with `Audio`_.  Plain reST instead of QAPI-specific extension
(strike 1), section structure instead of module structure (strike 2).
Let's not to advertize the module feature here.

This leaves definition names.

> +
> +Use ``@foo`` to reference members, which do not currently have a
> +cross-reference target. This is an rST extension.  It is rendered the
> +same way as ````foo````, but carries additional meaning.

I think the main point to make is that for members you need to use @foo.
`foo` doesn't work there.

Here's my try:

  Use ```foo``` to reference a definition in the schema.  This generates
  a link to the definition.  In the event that such a cross-reference is
  ambiguous, you can use `QAPI cross-reference roles <QAPI-XREF>` to
  disambiguate.

  Use @foo to reference a member description within the current
  definition.  This is an rST extension.  It is currently rendered the
  same way as ````foo````, but carries additional meaning.

>  
>  Example::
>  
> diff --git a/docs/devel/qapi-domain.rst b/docs/devel/qapi-domain.rst
> index b71890f6609..8d9fc866bc3 100644
> --- a/docs/devel/qapi-domain.rst
> +++ b/docs/devel/qapi-domain.rst
> @@ -375,6 +375,7 @@ Will allow you to add arbitrary field lists in QAPI directives::
>  
>        :see also: Lorem ipsum, dolor sit amet ...
>  
> +.. _QAPI-XREF:
>  
>  Cross-references
>  ================


