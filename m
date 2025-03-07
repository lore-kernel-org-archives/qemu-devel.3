Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF2B5C19F32
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 12:27:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqWnG-0003tU-4N; Fri, 07 Mar 2025 07:27:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tqWnA-0003n0-E6
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 07:27:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tqWn8-00057E-9M
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 07:27:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741350420;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Kz/JiUe8l5UtjZuhOkSpr4hx0iERffY+WeQrs7365UY=;
 b=CySyD+7mTCINpBjZ8Q0zdgxQG+Q+0nbs4psZ6bge+7ZlfsFq3gyxeuu6lbBiGQcXW6u/bW
 LecXZNM9gtO2rapW77wHZDm6YldOb/YIoKT2x//hfa/rpm0a61kB2/9dZH2qUEVPwiIeD1
 f3fBjzZBN6Y5LMbEPB+AABMN2KTEoho=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-201-Em9QzrUUMeqHhFHXUMA2nQ-1; Fri,
 07 Mar 2025 07:26:56 -0500
X-MC-Unique: Em9QzrUUMeqHhFHXUMA2nQ-1
X-Mimecast-MFC-AGG-ID: Em9QzrUUMeqHhFHXUMA2nQ_1741350415
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C8ACC1956053; Fri,  7 Mar 2025 12:26:54 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.15])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7EDD61801752; Fri,  7 Mar 2025 12:26:54 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1515C21E675E; Fri, 07 Mar 2025 13:26:52 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Michael Roth <michael.roth@amd.com>,  Alex
 =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,  Philippe =?utf-8?Q?Mat?=
 =?utf-8?Q?hieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Peter Maydell <peter.maydell@linaro.org>,  Thomas
 Huth <thuth@redhat.com>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH 51/57] docs/qapidoc: add visit_entity()
In-Reply-To: <20250305034610.960147-52-jsnow@redhat.com> (John Snow's message
 of "Tue, 4 Mar 2025 22:46:00 -0500")
References: <20250305034610.960147-1-jsnow@redhat.com>
 <20250305034610.960147-52-jsnow@redhat.com>
Date: Fri, 07 Mar 2025 13:26:52 +0100
Message-ID: <87senphvqr.fsf@pond.sub.org>
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

> Finally, the core entry method for a qapi entity.
>
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  docs/sphinx/qapidoc.py | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>
> diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py
> index 7308fa0a767..fb2ad7492ae 100644
> --- a/docs/sphinx/qapidoc.py
> +++ b/docs/sphinx/qapidoc.py
> @@ -78,6 +78,8 @@
>  
>  
>  class Transmogrifier:
> +    # pylint: disable=too-many-public-methods
> +

Tsk, tsk, tsk ...  ;-P

>      # Field names used for different entity types:
>      field_types = {
>          "enum": "value",
> @@ -368,6 +370,25 @@ def visit_freeform(self, doc: QAPIDoc) -> None:
>          self.add_lines(text, info)
>          self.ensure_blank_line()
>  
> +    def visit_entity(self, ent: QAPISchemaDefinition) -> None:
> +        assert ent.info
> +
> +        try:
> +            self._curr_ent = ent
> +
> +            # Squish structs and unions together into an "object" directive.
> +            meta = ent.meta
> +            if meta in ("struct", "union"):
> +                meta = "object"
> +
> +            # This line gets credited to the start of the /definition/.
> +            self.add_line(f".. qapi:{meta}:: {ent.name}", ent.info)
> +            with self.indented():
> +                self.preamble(ent)
> +                self.visit_sections(ent)
> +        finally:
> +            self._curr_ent = None
> +
>  
>  class QAPISchemaGenDepVisitor(QAPISchemaVisitor):
>      """A QAPI schema visitor which adds Sphinx dependencies each module


