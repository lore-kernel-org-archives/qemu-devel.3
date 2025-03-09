Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A3CDC282D1
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Mar 2025 07:44:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trBJy-0006nG-Sl; Sun, 09 Mar 2025 03:43:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1trBJu-0006ms-1c
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 03:43:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1trBJs-0004nN-9e
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 03:43:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741506210;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 resent-to:resent-from:resent-message-id:in-reply-to:in-reply-to:
 references:references; bh=vrNiHLR+7zW6umgSU2SAjHT+wSjRmv2SalXsR3Smytg=;
 b=POvxr0S26GrD8uaWwecUPVNhLBurvOrCuiBceIZwTh/092DHafxWZ+9I1DMLHqYK9mZWp1
 c6/u/iVKaOUYi0mGyJRLL7talzgR7SJHUzJXrRU2Juld/tWnRxfGWCApPsXOTB0qkpU5z0
 LB8xT77eu0RI7VgboQtcU1H0vXZdErU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-207-onjy7b1uPjCK8lZWzmnIDA-1; Sun,
 09 Mar 2025 03:43:27 -0400
X-MC-Unique: onjy7b1uPjCK8lZWzmnIDA-1
X-Mimecast-MFC-AGG-ID: onjy7b1uPjCK8lZWzmnIDA_1741506206
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1EAB419560B0; Sun,  9 Mar 2025 07:43:25 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.4])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B16B51801747; Sun,  9 Mar 2025 07:43:24 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2C32621E675F; Sun, 09 Mar 2025 08:43:22 +0100 (CET)
Resent-To: michael.roth@amd.com, alex.bennee@linaro.org,
 peter.maydell@linaro.org, philmd@linaro.org, qemu-devel@nongnu.org
Resent-From: Markus Armbruster <armbru@redhat.com>
Resent-Date: Sun, 09 Mar 2025 08:43:22 +0100
Resent-Message-ID: <87o6ya3azp.fsf@pond.sub.org>
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Michael Roth <michael.roth@amd.com>,  Alex
 =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,  Philippe =?utf-8?Q?Mat?=
 =?utf-8?Q?hieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Peter Maydell <peter.maydell@linaro.org>,  Thomas
 Huth <thuth@redhat.com>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>
Subject: Re: [PATCH 54/57] docs/qapidoc: add transmogrifier test document
In-Reply-To: <20250305034610.960147-55-jsnow@redhat.com> (John Snow's message
 of "Tue, 4 Mar 2025 22:46:03 -0500")
References: <20250305034610.960147-1-jsnow@redhat.com>
 <20250305034610.960147-55-jsnow@redhat.com>
Date: Sun, 09 Mar 2025 08:19:53 +0100
Message-ID: <87bjua657q.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
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

John Snow <jsnow@redhat.com> writes:

> This is just a test document that demonstrates the new qapi-domain doc
> generator. Note that this test document uses a nesting depth of 2 for
> the TOC unlike the existing QMP's reference nesting depth of 3. It's
> arbitrary and can be changed to suit taste, it has nothing to do with
> the new domain itself.
>
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  docs/index.rst      |  1 +
>  docs/qapi/index.rst | 53 +++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 54 insertions(+)
>  create mode 100644 docs/qapi/index.rst
>
> diff --git a/docs/index.rst b/docs/index.rst
> index 5665de85cab..4364f9f1618 100644
> --- a/docs/index.rst
> +++ b/docs/index.rst
> @@ -21,3 +21,4 @@ Welcome to QEMU's documentation!
>     specs/index
>     devel/index
>     glossary
> +   qapi/index
> diff --git a/docs/qapi/index.rst b/docs/qapi/index.rst
> new file mode 100644
> index 00000000000..e40dce09119
> --- /dev/null
> +++ b/docs/qapi/index.rst
> @@ -0,0 +1,53 @@
> +########################
> +QAPI Transmogrifier Test
> +########################
> +
> +This is a test render of the QEMU QMP reference manual using the new
> +"transmogrifier" generator in qapidoc.py in conjunction with the
> +qapi-domain.py sphinx extension.
> +
> +Some notable features:
> +
> + * Every QAPI definition visible below is available to be
> +   cross-referenced from anywhere else in the Sphinx docs; for example
> +   ```blockdev-add``` will render to `blockdev-add`.
> +
> + * There are type-specific cross-referencing roles available for
> +   alternates, commands, events, enums, structs, unions and modules. for
> +   example, ``:qapi:cmd:`block-dirty-bitmap-add``` resolves to
> +   :qapi:cmd:`block-dirty-bitmap-add`, and only works for commands. The
> +   roles available are ``cmd``, ``alt``, ``event``, ``enum``,
> +   ``struct``, ``union``, and ``mod``; with two meta-roles available:
> +   ``obj`` for absolutely any QAPI definition, and ``type`` for
> +   everything except commands, events, and modules.
> +
> + * There is a new `qapi-index` page which can be linked to with
> +   ```qapi-index```. There, you can browse a list of all QAPI
> +   definitions by type or alphabetically.

```qapi-index``` becomes a link in HTML.  The link takes me to an index
page.  Two observations:

* The index page appears not to be linked from the navigation thingie on
  the left.  Searching for "QAPI Index" there doesn't find it, either.

* The index is structured into sections titled Alternates, Commands |
  Enums, Events, Modules, Objects, A, ... Z.  As I scrolled down
  quickly, the transition from Objects to A confused me briefly: I
  didn't immediately understand that A, ... Z contains the union of
  everything above sorted into letter buckets.

> +
> + * QAPI definitions are also added to the existing `genindex` page.
> +
> + * All member/argument/return types are now cross-references to that
> +   type's definition. `chardev-add` is a good example.
> +
> + * This work-in-progress version does not perform any inlining.
> +
> + * This work-in-progress version actually also ignores branches entirely
> +   right now!
> +
> + * This version currently does not "prune" unnecessary docs.
> +
> + * This version does not add undocumented members or return values.
> +
> + * This version does not handle ifcond for anything other than top-level
> +   entity definitions.
> +
> + * This version renders sections in precisely the order they appear in
> +   source, even if that winds up looking silly.
> +
> +
> +.. contents::
> +   :depth: 2
> +
> +.. qapi-doc:: qapi/qapi-schema.json
> +   :transmogrify:


