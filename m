Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A90BE77188
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 14:24:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOduw-0003E0-P7; Fri, 20 Dec 2024 09:23:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tOduv-0003Ds-V4
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 09:23:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tOduu-000367-DW
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 09:23:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734704627;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZGud1x59X421iY6SwgvWDJdvyCyeJyN2HumcKOAdsBg=;
 b=InMJWwhPVXWO5mO2ntM+npDNAEyZYRY4ZdjrgUm+fBd4XFVBj2si3b3YviG00E9Vswe5X9
 cSdN5Jy33rGWBvV4RlHLFGDGupljYGfycA+rpyyySryCqHnInakJQgxrbaWImy4FUUOJuv
 aK9q7sTrMjvC4boWHWuhbF/tTlnEctw=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-661-u31RN_eyMfivjEeAEBRzCQ-1; Fri,
 20 Dec 2024 09:23:43 -0500
X-MC-Unique: u31RN_eyMfivjEeAEBRzCQ-1
X-Mimecast-MFC-AGG-ID: u31RN_eyMfivjEeAEBRzCQ
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A33B91956052; Fri, 20 Dec 2024 14:23:42 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.27])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 635E0195605F; Fri, 20 Dec 2024 14:23:42 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0C3CC21E6740; Fri, 20 Dec 2024 15:23:40 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Peter Maydell <peter.maydell@linaro.org>,
 Michael Roth <michael.roth@amd.com>
Subject: Re: [PATCH 17/23] docs/qapidoc: record current documented entity in
 transmogrifier
In-Reply-To: <20241213021827.2956769-18-jsnow@redhat.com> (John Snow's message
 of "Thu, 12 Dec 2024 21:18:20 -0500")
References: <20241213021827.2956769-1-jsnow@redhat.com>
 <20241213021827.2956769-18-jsnow@redhat.com>
Date: Fri, 20 Dec 2024 15:23:40 +0100
Message-ID: <878qsa302b.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.129,
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

> Keep a record of which entity we're working on documenting for the
> purposes of being able to change certain generative features
> conditionally and create stronger assertions.
>
> If you find yourself asking: "Wait, but where does the current entity
> actually get recorded?!", you're right! That part comes with the
> visit_entity() implementation, which gets added later.

That's fine, except your title promises "record current documented
entity".  Perhaps "Prepare to record entity being transmogrified".

> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  docs/sphinx/qapidoc.py | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py
> index 02f434c09ab..c731c597daf 100644
> --- a/docs/sphinx/qapidoc.py
> +++ b/docs/sphinx/qapidoc.py
> @@ -74,9 +74,15 @@ def dedent(text: str) -> str:
>  
>  class Transmogrifier:
>      def __init__(self, schema):
> +        self._curr_ent = None
>          self._result = StringList()
>          self.indent = 0
>  
> +    @property
> +    def entity(self) -> QAPISchemaEntity:
> +        assert self._curr_ent is not None
> +        return self._curr_ent
> +
>      # General-purpose rST generation functions
>  
>      def get_indent(self) -> str:


