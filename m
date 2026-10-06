Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16F6ACA6009
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 08:53:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xENMD-0006bZ-8N; Wed, 07 Oct 2026 04:50:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xEKFd-0005bq-Tr
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 01:31:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xEKFX-0007SL-C8
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 01:31:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791351088;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8xPBHDehM1ipBBRrSutjcKbHPfvM9Cw86MjR68gqREw=;
 b=Yf/FUmasxKqms95CkQLHa0HcJRnlxAHEmb9Hu3hOH+7+6SO5g8PInI7nKioXB+OdH10ter
 NLl+O362iOieIdt8qcDHQhvRW9NlZYgY+Y0Wub8YengSAaMMJKvWcV/5hCfA+oEz9MbBhM
 FhFP1tal8vOJakqzqeFEUwNEZiZ6nHc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-435-SAMHwLmNMfyxWwxvaXEIkg-1; Tue,
 06 Oct 2026 05:08:46 -0400
X-MC-Unique: SAMHwLmNMfyxWwxvaXEIkg-1
X-Mimecast-MFC-AGG-ID: SAMHwLmNMfyxWwxvaXEIkg_1791277725
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AC7AC1955DD7; Tue,  6 Oct 2026 09:08:45 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3089830000E3; Tue,  6 Oct 2026 09:08:45 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id DF98C21E6A04; Tue, 06 Oct 2026 11:08:42 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Pierrick Bouvier
 <pierrick.bouvier@oss.qualcomm.com>,  Michael Roth <michael.roth@amd.com>
Subject: Re: [PATCH 08/11] docs/qapi-code-gen: add "Descriptions" subsection
In-Reply-To: <20261001172239.2825745-9-jsnow@redhat.com> (John Snow's message
 of "Thu, 1 Oct 2026 13:22:35 -0400")
References: <20261001172239.2825745-1-jsnow@redhat.com>
 <20261001172239.2825745-9-jsnow@redhat.com>
Date: Tue, 06 Oct 2026 11:08:42 +0200
Message-ID: <878q4bdwmd.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

> Section off the part of the spec that describes descriptions.
>
> Similarly to "Tagged sections", the concept of naming "Descriptions"
> as a proper noun might also be something we'd like to sunset, but for
> now I have retained the section. I believe the documentation itself is
> entirely valid and useful, but we may want to come up with a term for
> "arguments, members, branches, or values" as a group of concepts
> instead - excising only "Features" as something that is different.
>
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  docs/devel/qapi-code-gen.rst | 22 ++++++++++++++++------
>  1 file changed, 16 insertions(+), 6 deletions(-)
>
> diff --git a/docs/devel/qapi-code-gen.rst b/docs/devel/qapi-code-gen.rst
> index 1897cde39cf..7e7b11d01df 100644
> --- a/docs/devel/qapi-code-gen.rst
> +++ b/docs/devel/qapi-code-gen.rst
> @@ -985,13 +985,23 @@ When documentation is required (see pragma_ 'doc-required'), every
>  definition must have documentation.
>  
>  Definition documentation starts with a description naming the
> -definition with an optional indented overview, a description of each
> -argument (for commands and events), member (for structs and unions),
> -branch (for alternates), or value (for enums), a description of each
> -feature (if any), and finally optional tagged sections.
> +definition with an optional indented overview, :ref:`descriptions
> +<doc-descrip>` of each argument (for commands and events), member (for
> +structs and unions), branch (for alternates), or value (for enums), a
> +description of each feature (if any), and finally optional tagged
> +sections.

Not this patch's fault: this isn't quite right.  The order of tagged
sections is left unspecified, which is fine now, but becomes a gap when
your "qapi: enforce section ordering" series lands.  "Details" sections
aren't mentioned at all.

>  
> -Descriptions start with '\@name:'.  The description text must be
> -indented like this::
> +
> +.. _doc-descrip:
> +
> +Descriptions
> +^^^^^^^^^^^^
> +
> +Descriptions start with '\@name:'.  These are used to document
> +arguments (for commands and events), members (for structs and unions),
> +branches (for alternates), or values (for enums).
> +
> +The description text must be indented like this::
>  
>   # @name: Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed
>   #     do eiusmod tempor incididunt ut labore et dolore magna aliqua.


