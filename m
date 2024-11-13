Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A21F4D12D66
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2024 13:21:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBDIk-0003EY-JT; Wed, 13 Nov 2024 08:20:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tBDIi-0003Cq-5M
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 08:20:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tBDIg-000156-JX
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 08:20:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731504047;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ld03RyfgVazRTd3mQZE59c8b+aZ8T2R23LXH/EpQXRs=;
 b=GtL/Z7H5jh1uT4EIQ2ZV6HWkBjqxx4N/qs/lfz9lHyS9auPhAdXQX5VKr+AHm2Zbfwo79Y
 qyPm63jFqWrxWc6ClIHMK7ZtigxK+BsRZZ5uPnZCVfTDjsES1ZcvROeHYeaWBuabnO9E9Q
 g38rTBZV2h5L04URX0wCKa8wyeXVsA4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-199-E-KYKIH5Nkqj7B0VyHXQAg-1; Wed,
 13 Nov 2024 08:20:43 -0500
X-MC-Unique: E-KYKIH5Nkqj7B0VyHXQAg-1
X-Mimecast-MFC-AGG-ID: E-KYKIH5Nkqj7B0VyHXQAg
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EFC191955E84; Wed, 13 Nov 2024 13:20:42 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.194.95])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 965571955F43; Wed, 13 Nov 2024 13:20:42 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 697BA21E6A28; Wed, 13 Nov 2024 14:20:40 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  Paolo Bonzini <pbonzini@redhat.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Michael Roth
 <michael.roth@amd.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PATCH v2 3/4] qapi: rename 'special_features' to 'features'
In-Reply-To: <20241018101724.1221152-4-berrange@redhat.com> ("Daniel
 P. =?utf-8?Q?Berrang=C3=A9=22's?= message of "Fri, 18 Oct 2024 11:17:23
 +0100")
References: <20241018101724.1221152-1-berrange@redhat.com>
 <20241018101724.1221152-4-berrange@redhat.com>
Date: Wed, 13 Nov 2024 14:20:40 +0100
Message-ID: <87ed3fgthz.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.119,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.738,
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> This updates the QAPI code generation to refer to 'features' instead
> of 'special_features', in preparation for generalizing their exposure.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  scripts/qapi/commands.py |  4 ++--
>  scripts/qapi/gen.py      |  6 +++---
>  scripts/qapi/types.py    | 10 +++++-----
>  scripts/qapi/visit.py    | 14 +++++++-------
>  4 files changed, 17 insertions(+), 17 deletions(-)
>
> diff --git a/scripts/qapi/commands.py b/scripts/qapi/commands.py
> index 79951a841f..d629d2d97e 100644
> --- a/scripts/qapi/commands.py
> +++ b/scripts/qapi/commands.py
> @@ -25,7 +25,7 @@
>      QAPIGenC,
>      QAPISchemaModularCVisitor,
>      build_params,
> -    gen_special_features,
> +    gen_features,
>      ifcontext,
>  )
>  from .schema import (
> @@ -298,7 +298,7 @@ def gen_register_command(name: str,
>  ''',
>                  name=3Dname, c_name=3Dc_name(name),
>                  opts=3D' | '.join(options) or 0,
> -                feats=3Dgen_special_features(features))
> +                feats=3Dgen_features(features))
>      return ret
>=20=20
>=20=20
> diff --git a/scripts/qapi/gen.py b/scripts/qapi/gen.py
> index c53ca72950..aba1a982f6 100644
> --- a/scripts/qapi/gen.py
> +++ b/scripts/qapi/gen.py
> @@ -41,10 +41,10 @@
>  from .source import QAPISourceInfo
>=20=20
>=20=20
> -def gen_special_features(features: Sequence[QAPISchemaFeature]) -> str:
> -    special_features =3D [f"1u << {c_enum_const('qapi', feat.name)}"
> +def gen_features(features: Sequence[QAPISchemaFeature]) -> str:
> +    features =3D [f"1u << {c_enum_const('qapi', feat.name)}"
>                          for feat in features if feat.is_special()]

pycodestyle gripes

    scripts/qapi/gen.py:46:25: E127 continuation line over-indented for vis=
ual indent

More seriously, mypy gripes

    scripts/qapi/gen.py:45: error: List comprehension has incompatible type=
 List[str]; expected List[QAPISchemaFeature]  [misc]

here, and ...

> -    return ' | '.join(special_features) or '0'
> +    return ' | '.join(features) or '0'

    scripts/qapi/gen.py:47: error: Argument 1 to "join" of "str" has incomp=
atible type "List[QAPISchemaFeature]"; expected "Iterable[str]"  [arg-type]

This is due to your assignment to parameter @feature.  Use a new
variable instead.

>=20=20
>=20=20
>  class QAPIGen:

[...]


