Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5823CA5FF1
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 09:10:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xENL7-0003Ue-5s; Wed, 07 Oct 2026 04:49:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xEJoA-0000sY-SX
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 01:03:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xEJo9-0004m1-70
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 01:03:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791349392;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dJmy/26wtIG5PBMzxzq6pUIv+M+jbJJbV13LYhoOPD0=;
 b=eDVQl0+3vOy4cUUxyx+2kS5N2Od0MNWR0vW8/yzxS3fhKL+6v+sBCw/rX4AWBmLMYhrHc5
 VU9DP4XfdOZlO2vt2YhzotYMNsTKarLVN5qRdxK+H8bJ6grv1bRtTE34JIN7VHUZ1q3rKS
 z8p8loKL00I2oQx9TTKYsAaFU1eOcVY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-269-RjL8D_stOhanitfnRVzj8A-1; Tue,
 06 Oct 2026 04:36:32 -0400
X-MC-Unique: RjL8D_stOhanitfnRVzj8A-1
X-Mimecast-MFC-AGG-ID: RjL8D_stOhanitfnRVzj8A_1791275791
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4F4CA1805A22; Tue,  6 Oct 2026 08:36:31 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 07DCA1800579; Tue,  6 Oct 2026 08:36:31 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A0E2721E6A04; Tue, 06 Oct 2026 10:36:28 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Pierrick Bouvier
 <pierrick.bouvier@oss.qualcomm.com>,  Michael Roth <michael.roth@amd.com>
Subject: Re: [PATCH 05/11] docs/qapi-code-gen: add "Details" docs subsection
In-Reply-To: <20261001172239.2825745-6-jsnow@redhat.com> (John Snow's message
 of "Thu, 1 Oct 2026 13:22:32 -0400")
References: <20261001172239.2825745-1-jsnow@redhat.com>
 <20261001172239.2825745-6-jsnow@redhat.com>
Date: Tue, 06 Oct 2026 10:36:28 +0200
Message-ID: <87cxtndy43.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
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

> Mostly, this is just adding a heading and explaining that arbitrary
> rST formatting is allowed in this section.
>
> Note: The QAPI parser still refers to these sections internally as
> "PLAIN",

Really?

>          but I wanted to name this documentation section after the
> eventual, true name for the section. It is effectively only an
> implementation detail at this point.
>
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  docs/devel/qapi-code-gen.rst | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/docs/devel/qapi-code-gen.rst b/docs/devel/qapi-code-gen.rst
> index fcb52ce157e..8fc75488019 100644
> --- a/docs/devel/qapi-code-gen.rst
> +++ b/docs/devel/qapi-code-gen.rst
> @@ -1035,8 +1035,15 @@ detailing a relevant error condition.  For example::
>   #     - Any other error returns a GenericError.
>  
>  
> -In other sections, the text is formatted, and rST markup can be
> -used.
> +Details
> +^^^^^^^
> +
> +Details sections are comprised of one or more paragraphs of rST
> +formatted text, but otherwise are not marked up with any QAPI-specific
> +syntax.

Feels awkward.  You're trying to define you're talking about, but what
you're talking about is distinguished by absence of syntax, which makes
it harder to nail down.

I can't see how to do this better right now.  I'll come back to it.

>          In general, this text contains in-depth explanations of the
> +definition being documented and may include various rST admonitions
> +like ``.. seealso::``, ``.. note::``, etc. This is also the section
> +where QMP usage examples should be placed.
>  
>  QMP Examples can be added by using the ``.. qmp-example::`` directive.
>  In its simplest form, this can be used to contain a single QMP code


