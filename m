Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 635F6C282DE
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 10:08:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tra3X-00013G-7E; Mon, 10 Mar 2025 06:08:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tra3R-00012k-Kl
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 06:08:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tra3P-0006HN-QD
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 06:08:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741601290;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gFs5bMKzOC+WVAMUH3Ub5dHheCYtdBYCnq/p3ne39CY=;
 b=DhY7wU0+LfSejbP+d3hPLMvKjHbEzmgOx5ylU1A0EhOlYox0C2P4/T89ykBzP75BDwtRdN
 lpVvVHBPCr86Pz9I2nBCow8Ue8dvQnk+ckdEBveSbOqd1wN0LYpCYkSzE4Fr80El0KNy7S
 R8g9VaoilgRKxyyIVpxWr4xdoP8TLUY=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-519-qBYCFWY3Mcq5PVUp-SkW0w-1; Mon,
 10 Mar 2025 06:08:07 -0400
X-MC-Unique: qBYCFWY3Mcq5PVUp-SkW0w-1
X-Mimecast-MFC-AGG-ID: qBYCFWY3Mcq5PVUp-SkW0w_1741601286
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 855CD19560B0; Mon, 10 Mar 2025 10:08:05 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.4])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 12FF418009AE; Mon, 10 Mar 2025 10:08:05 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id AEB9221E66C4; Mon, 10 Mar 2025 11:08:02 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,
 Michael Roth <michael.roth@amd.com>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Eric Blake <eblake@redhat.com>,  Thomas Huth
 <thuth@redhat.com>,  Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v2 58/62] docs/qapidoc: generate entries for
 undocumented members
In-Reply-To: <20250309083550.5155-59-jsnow@redhat.com> (John Snow's message of
 "Sun, 9 Mar 2025 04:35:45 -0400")
References: <20250309083550.5155-1-jsnow@redhat.com>
 <20250309083550.5155-59-jsnow@redhat.com>
Date: Mon, 10 Mar 2025 11:08:02 +0100
Message-ID: <87ecz52o71.fsf@pond.sub.org>
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

> Presently, we never have any empty text entries for members. The next
> patch will explicitly generate such sections, so enable support for it
> in advance.
>
> The parser will generate placeholder sections to indicate undocumented
> members, but it's the qapidoc generator that's responsible for deciding
> what to do with that stub section.
>
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  docs/sphinx/qapidoc.py | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py
> index 96ac9f8620e..fec48fd01e1 100644
> --- a/docs/sphinx/qapidoc.py
> +++ b/docs/sphinx/qapidoc.py
> @@ -235,11 +235,11 @@ def visit_member(self, section: QAPIDoc.ArgSection) -> None:
>          # TODO?: features for members (documented at entity-level,
>          # but sometimes defined per-member. Should we add such
>          # information to member descriptions when we can?)
> -        assert section.text and section.member
> +        assert section.member
>          self.generate_field(
>              self.member_field_type,
>              section.member,
> -            section.text,
> +            section.text if section.text else "(Not Documented.)",

The old generator uses just "Not documented".  I don't mind the period,
but the parenthesis looks awkward:

   Members:
      * limits ("ThrottleLimits", optional) -- limits to apply
        for this throttle group

      * x-iops-total ("int", optional) -- (Not Documented.)

The old generator has a comment

            # TODO drop fallbacks when undocumented members are outlawed

Let's have it here as well.

>              section.info,
>          )


