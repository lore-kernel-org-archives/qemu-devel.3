Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37E83CA5FF1
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 08:19:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEMrg-0005yP-QO; Wed, 07 Oct 2026 04:19:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xEFac-0003rz-B1
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 20:34:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xEFaS-0004FM-5z
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 20:32:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791332947;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5e9gUT72Fz6z92KNgLz+ie+oO3Wwbm9Gv7XUONkx+fc=;
 b=gzgoopNDZ4UeX8b0AoCIhQGI5uNITZXioBQ/G+zQMEcheEOrGTWmfEmS0uoCuySNco4FEo
 KF2AquUkXWbfKhaIdJcPINVjWbcJT012EYKKjGgOau57eW+C/j4OWEZyGNH6fOOdYWC0xF
 vsYWqMHjXBOBQYOWzRvPvzNxrSeaq38=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-443-npllWovqPoa8qe7a_cfggw-1; Tue,
 06 Oct 2026 04:03:01 -0400
X-MC-Unique: npllWovqPoa8qe7a_cfggw-1
X-Mimecast-MFC-AGG-ID: npllWovqPoa8qe7a_cfggw_1791273780
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 51893180059A; Tue,  6 Oct 2026 08:03:00 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E10F7195604D; Tue,  6 Oct 2026 08:02:59 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 886CC21E6A04; Tue, 06 Oct 2026 10:02:57 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Pierrick Bouvier
 <pierrick.bouvier@oss.qualcomm.com>,  Michael Roth <michael.roth@amd.com>
Subject: Re: [PATCH 03/11] docs/qapi-code-gen: add "TODO" subsection
In-Reply-To: <20261001172239.2825745-4-jsnow@redhat.com> (John Snow's message
 of "Thu, 1 Oct 2026 13:22:30 -0400")
References: <20261001172239.2825745-1-jsnow@redhat.com>
 <20261001172239.2825745-4-jsnow@redhat.com>
Date: Tue, 06 Oct 2026 10:02:57 +0200
Message-ID: <87ik3fdzny.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

John Snow <jsnow@redhat.com> writes:

> Split the "TODO" section description into its own little section, and
> add a dedicated example for it.
>
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  docs/devel/qapi-code-gen.rst | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
>
> diff --git a/docs/devel/qapi-code-gen.rst b/docs/devel/qapi-code-gen.rst
> index 0f66f012be1..977ed1aa3bd 100644
> --- a/docs/devel/qapi-code-gen.rst
> +++ b/docs/devel/qapi-code-gen.rst
> @@ -1037,8 +1037,7 @@ detailing a relevant error condition.  For example::
>  A "Since: x.y" tagged section lists the release that introduced the
>  definition.
>  
> -"TODO" sections are not rendered (they are for developers, not users of
> -QMP).  In other sections, the text is formatted, and rST markup can be
> +In other sections, the text is formatted, and rST markup can be
>  used.
>  
>  QMP Examples can be added by using the ``.. qmp-example::`` directive.
> @@ -1089,6 +1088,17 @@ Highlighting in non-QMP languages can be accomplished by using the
>  achieved by omitting the language argument.
>  
>  
> +TODO
> +^^^^
> +
> +"TODO" tagged sections are not rendered (they are for developers, not users of

Wrap lines at colum 70, please.

> +QMP). They can appear anywhere after the introductory section::

Two spaces between sentences for consistency, please.

> +
> +  #
> +  ## TODO: This is not rendered in the documentation.

Why the second '#'?

> +  #
> +
> +
>  Putting it all together
>  ^^^^^^^^^^^^^^^^^^^^^^^


