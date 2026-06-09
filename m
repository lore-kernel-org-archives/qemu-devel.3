Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46D60CD8CAA
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 10:59:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWuAz-0001ES-P9; Tue, 09 Jun 2026 06:59:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wWuAp-0001E3-9N
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 06:59:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wWuAk-0004ts-AS
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 06:59:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781002744;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=O2uWd1OSRuv/AisuD6Qc+yfYpvy0KTABFXqDhRLF8tc=;
 b=YZRCXtzulh+BbnMPl3NN73rcSs2k8T/y6CJolMO5gBMPLZxvwsqoF31DTzEaFYS2rJRBIB
 bDRthqrSNVsXzpg/dmgyIZHk4YjSGjH/J242nKy8/i7D5tTI4kh1B+pOYAe7zKUchMoWpa
 mmdLELI2BPJzhf/ZHFdwT4gA4GvkzqQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-499-c6nZMEQDM-StBjojnwVpMQ-1; Tue,
 09 Jun 2026 06:59:01 -0400
X-MC-Unique: c6nZMEQDM-StBjojnwVpMQ-1
X-Mimecast-MFC-AGG-ID: c6nZMEQDM-StBjojnwVpMQ_1781002739
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 35E9A19560BB; Tue,  9 Jun 2026 10:58:59 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.28])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 79FA43008B38; Tue,  9 Jun 2026 10:58:58 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 145E921E6A01; Tue, 09 Jun 2026 12:58:56 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Ani Sinha <anisinha@redhat.com>,  Michael Roth
 <michael.roth@amd.com>,  Igor Mammedov <imammedo@redhat.com>,  Peter
 Maydell <peter.maydell@linaro.org>,  Eric Blake <eblake@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>,  Mauro
 Carvalho Chehab
 <mchehab+huawei@kernel.org>,  "Michael S. Tsirkin" <mst@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,  Paolo
 Bonzini <pbonzini@redhat.com>,  Pierrick Bouvier
 <pierrick.bouvier@oss.qualcomm.com>,  Richard Henderson
 <richard.henderson@linaro.org>,  Gerd Hoffmann <kraxel@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 linux-edac@vger.kernel.org, Cleber Rosa <crosa@redhat.com>
Subject: Re: [PATCH v3 07/16] qapi/docs: add "Intro" section
In-Reply-To: <20260603032201.993015-8-jsnow@redhat.com> (John Snow's message
 of "Tue, 2 Jun 2026 23:21:52 -0400")
References: <20260603032201.993015-1-jsnow@redhat.com>
 <20260603032201.993015-8-jsnow@redhat.com>
Date: Tue, 09 Jun 2026 12:58:56 +0200
Message-ID: <87tsrcou8f.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

> This patch adds an "Intro" doc section, intended to eventually replace
> the "Plain" doc section alongside a forthcoming "Details" section.
>
> For now, this section is not actually instantiated or used, but
> subsequent patches will slowly convert the leading introductory sections
> of QAPIDoc documentation to use this new section.
>
> A main motivation of this series of changes is to more explicitly
> delineate the "Introductory" documentation for each QAPI definition for
> the sake of the inliner. When inlining members, examples, and details
> from multiple QAPIDoc sections, we will want to omit the "Introductory"
> text from inlined definitions while keeping notes, caution boxes,
> examples, and so on. This new section facilitates that.
>
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  docs/sphinx/qapidoc.py | 2 +-
>  scripts/qapi/parser.py | 3 ++-
>  2 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py
> index c2f09bac16c..1f7c15b7075 100644
> --- a/docs/sphinx/qapidoc.py
> +++ b/docs/sphinx/qapidoc.py
> @@ -368,7 +368,7 @@ def visit_sections(self, ent: QAPISchemaDefinition) -> None:
>          for i, section in enumerate(sections):
>              section.text = self.reformat_arobase(section.text)
>  
> -            if section.kind == QAPIDoc.Kind.PLAIN:
> +            if section.kind.name in ("PLAIN", "INTRO"):

Is the change from QAPIDoc.Kind.FOO to "FOO" just for brevity, or is
something going on I don't understand?

>                  self.visit_paragraph(section)
>              elif section.kind == QAPIDoc.Kind.MEMBER:
>                  assert isinstance(section, QAPIDoc.ArgSection)
> diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
> index d8068bb1bf6..97e7dacb0fd 100644
> --- a/scripts/qapi/parser.py
> +++ b/scripts/qapi/parser.py
> @@ -681,6 +681,7 @@ class Kind(enum.Enum):
>          ERRORS = 4
>          SINCE = 5
>          TODO = 6
> +        INTRO = 7
>  
>          @staticmethod
>          def from_string(kind: str) -> 'QAPIDoc.Kind':
> @@ -748,7 +749,7 @@ def has_features(self) -> bool:
>      def end(self) -> None:
>          for section in self.all_sections:
>              section.text = section.text.strip('\n')
> -            if section.kind != QAPIDoc.Kind.PLAIN and section.text == '':
> +            if not (section.kind.name in ("INTRO", "PLAIN") or section.text):
>                  raise QAPISemError(
>                      section.info, "text required after '%s:'" % section.kind)


