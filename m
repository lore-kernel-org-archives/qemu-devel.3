Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EC12CD342C
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2026 09:55:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJq11-00082T-SP; Mon, 04 May 2026 05:55:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wJq10-000826-Ec
 for qemu-devel@nongnu.org; Mon, 04 May 2026 05:55:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wJq0y-0002yH-MN
 for qemu-devel@nongnu.org; Mon, 04 May 2026 05:55:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777888500;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zttrWRX3pf4/UiKJU44HWTNbRz6+DdBAaaxnavlqN5M=;
 b=Q5zq3rkZ8kHM+IxeIYSK6Mac6wIL/y0w9dohTHZaaJIUTWWa3zjWZfnd3XUDmy/IzyKg98
 sT49wzdBpB1t3zLZxfSKRHrCjoVoZ99aySCOXrJ6LynKm4gPQG9PdtUdgnLE52GZVl+K32
 g8rke2kJb4cRFm6z8ANFQkv2TDhHGRY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-318-yFTrSrgAOoWBMJwZWNYeVg-1; Mon,
 04 May 2026 05:54:56 -0400
X-MC-Unique: yFTrSrgAOoWBMJwZWNYeVg-1
X-Mimecast-MFC-AGG-ID: yFTrSrgAOoWBMJwZWNYeVg_1777888495
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 42E3E1956063; Mon,  4 May 2026 09:54:55 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8B07D19560A6; Mon,  4 May 2026 09:54:54 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2AD8921E6A01; Mon, 04 May 2026 11:54:52 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Michael Roth <michael.roth@amd.com>,  Eric Blake
 <eblake@redhat.com>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,  Peter Maydell
 <peter.maydell@linaro.org>,  Pierrick Bouvier
 <pierrick.bouvier@oss.qualcomm.com>,  Igor Mammedov <imammedo@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,  Ani Sinha <anisinha@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v2 03/13] qapi/docs: make remaining subsection members
 "private"
In-Reply-To: <20260429192611.1581223-4-jsnow@redhat.com> (John Snow's message
 of "Wed, 29 Apr 2026 15:26:01 -0400")
References: <20260429192611.1581223-1-jsnow@redhat.com>
 <20260429192611.1581223-4-jsnow@redhat.com>
Date: Mon, 04 May 2026 11:54:52 +0200
Message-ID: <87cxzbbitv.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

> These fields are used to provide error checking and internal logistics
> and should not be used by a user of the library to directly access
> documentation sections, so make them private.
>
> The "since" field alone is left public, as the qapidoc generator does
> use this field to pull that section out of the regular flow of the
> document.
>
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  scripts/qapi/parser.py | 54 +++++++++++++++++++++++-------------------
>  1 file changed, 29 insertions(+), 25 deletions(-)
>
> diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
> index b33edbba74f..da4756a7424 100644
> --- a/scripts/qapi/parser.py
> +++ b/scripts/qapi/parser.py
> @@ -555,7 +555,7 @@ def get_doc(self) -> 'QAPIDoc':
>                      break
>                  # Non-blank line, first of a section
>                  if line == 'Features:':
> -                    if doc.features:
> +                    if doc.has_features:
>                          raise QAPIParseError(
>                              self, "duplicated 'Features:' line")
>                      self.accept(False)
> @@ -570,7 +570,7 @@ def get_doc(self) -> 'QAPIDoc':
>                          if text:
>                              doc.append_line(text)
>                          line = self.get_doc_indented(doc)
> -                    if not doc.features:
> +                    if not doc.has_features:
>                          raise QAPIParseError(
>                              self, 'feature descriptions expected')
>                      no_more_args = True

These two hunks along with the one adding .has_features() below make the
patch not purely mechanical.  Separate patch, please.

Have you considered using a local bool variable instead?

> @@ -733,14 +733,18 @@ def __init__(self, info: QAPISourceInfo, symbol: Optional[str] = None):
>              QAPIDoc.Section(info, QAPIDoc.Kind.PLAIN)
>          ]
>          # dicts mapping parameter/feature names to their description
> -        self.args: Dict[str, QAPIDoc.ArgSection] = {}
> -        self.features: Dict[str, QAPIDoc.ArgSection] = {}
> +        self._args: Dict[str, QAPIDoc.ArgSection] = {}
> +        self._features: Dict[str, QAPIDoc.ArgSection] = {}
>          # a command's "Returns" and "Errors" section
> -        self.returns: Optional[QAPIDoc.Section] = None
> -        self.errors: Optional[QAPIDoc.Section] = None
> +        self._returns: Optional[QAPIDoc.Section] = None
> +        self._errors: Optional[QAPIDoc.Section] = None
>          # "Since" section
>          self.since: Optional[QAPIDoc.Section] = None
>  
> +    @property
> +    def has_features(self) -> bool:
> +        return bool(self._features)
> +
>      def end(self) -> None:
>          for section in self.all_sections:
>              section.text = section.text.strip('\n')
> @@ -771,15 +775,15 @@ def new_tagged_section(
>      ) -> None:
>          section = self.Section(info, kind)
>          if kind == QAPIDoc.Kind.RETURNS:
> -            if self.returns:
> +            if self._returns:
>                  raise QAPISemError(
>                      info, "duplicated '%s' section" % kind)
> -            self.returns = section
> +            self._returns = section
>          elif kind == QAPIDoc.Kind.ERRORS:
> -            if self.errors:
> +            if self._errors:
>                  raise QAPISemError(
>                      info, "duplicated '%s' section" % kind)
> -            self.errors = section
> +            self._errors = section
>          elif kind == QAPIDoc.Kind.SINCE:
>              if self.since:
>                  raise QAPISemError(
> @@ -803,16 +807,16 @@ def _new_description(
>          desc[name] = section
>  
>      def new_argument(self, info: QAPISourceInfo, name: str) -> None:
> -        self._new_description(info, name, QAPIDoc.Kind.MEMBER, self.args)
> +        self._new_description(info, name, QAPIDoc.Kind.MEMBER, self._args)
>  
>      def new_feature(self, info: QAPISourceInfo, name: str) -> None:
> -        self._new_description(info, name, QAPIDoc.Kind.FEATURE, self.features)
> +        self._new_description(info, name, QAPIDoc.Kind.FEATURE, self._features)
>  
>      def append_line(self, line: str) -> None:
>          self.all_sections[-1].append_line(line)
>  
>      def connect_member(self, member: 'QAPISchemaMember') -> None:
> -        if member.name not in self.args:
> +        if member.name not in self._args:
>              assert member.info
>              if self.symbol not in member.info.pragma.documentation_exceptions:
>                  raise QAPISemError(member.info,
> @@ -823,7 +827,7 @@ def connect_member(self, member: 'QAPISchemaMember') -> None:
>  
>              section = QAPIDoc.ArgSection(
>                  self.info, QAPIDoc.Kind.MEMBER, member.name)
> -            self.args[member.name] = section
> +            self._args[member.name] = section
>  
>              # Determine where to insert stub doc - it should go at the
>              # end of the members section(s), if any. Note that index 0
> @@ -835,14 +839,14 @@ def connect_member(self, member: 'QAPISchemaMember') -> None:
>                      index += 1
>              self.all_sections.insert(index, section)
>  
> -        self.args[member.name].connect(member)
> +        self._args[member.name].connect(member)
>  
>      def connect_feature(self, feature: 'QAPISchemaFeature') -> None:
> -        if feature.name not in self.features:
> +        if feature.name not in self._features:
>              raise QAPISemError(feature.info,
>                                 "feature '%s' lacks documentation"
>                                 % feature.name)
> -        self.features[feature.name].connect(feature)
> +        self._features[feature.name].connect(feature)
>  
>      def ensure_returns(self, info: QAPISourceInfo) -> None:
>  
> @@ -883,18 +887,18 @@ def _insert_near_kind(
>  
>      def check_expr(self, expr: QAPIExpression) -> None:
>          if 'command' in expr:
> -            if self.returns and 'returns' not in expr:
> +            if self._returns and 'returns' not in expr:
>                  raise QAPISemError(
> -                    self.returns.info,
> +                    self._returns.info,
>                      "'Returns' section, but command doesn't return anything")
>          else:
> -            if self.returns:
> +            if self._returns:
>                  raise QAPISemError(
> -                    self.returns.info,
> +                    self._returns.info,
>                      "'Returns' section is only valid for commands")
> -            if self.errors:
> +            if self._errors:
>                  raise QAPISemError(
> -                    self.errors.info,
> +                    self._errors.info,
>                      "'Errors' section is only valid for commands")
>  
>      def check(self) -> None:
> @@ -914,5 +918,5 @@ def check_args_section(
>                          "do" if len(bogus) > 1 else "does"
>                      ))
>  
> -        check_args_section(self.args, 'member')
> -        check_args_section(self.features, 'feature')
> +        check_args_section(self._args, 'member')
> +        check_args_section(self._features, 'feature')


