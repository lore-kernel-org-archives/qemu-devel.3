Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25E29C3DA7F
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2024 12:38:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sawyS-0002mZ-GR; Mon, 05 Aug 2024 08:38:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sawyQ-0002aT-8v
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 08:38:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sawyO-0004v1-Eh
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 08:38:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722861479;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:resent-to:
 resent-from:resent-message-id:in-reply-to:in-reply-to:  references:references; 
 bh=f0yf3kW26V7cqxGalQAjN/wlFuND0heS9I8rG2eWhMc=;
 b=S5ekYFu2Ke+A9cPZ3i7d355ttudiHXnmj01W8p0vGlOzQZIifOf/FY1gctEMit9AxJzxeN
 MW0UElEKsHBjxt3bcQonTizmw/bjeBeKeEGOOcoa7r5OohCd/LXfFlRTfUwKDkNIoS+IoH
 vpS0IySko1PgPfUa28WbbIzYC3oJRIw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-111-IHFM6ejZOOuqWGjTF89GcQ-1; Mon,
 05 Aug 2024 08:37:56 -0400
X-MC-Unique: IHFM6ejZOOuqWGjTF89GcQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 103C519560B1; Mon,  5 Aug 2024 12:37:55 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.245])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 78A6C1955D4D; Mon,  5 Aug 2024 12:37:53 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 6C35721E6692; Mon,  5 Aug 2024 14:37:51 +0200 (CEST)
Resent-To: michael.roth@amd.com, philmd@linaro.org, qemu-devel@nongnu.org
Resent-From: Markus Armbruster <armbru@redhat.com>
Resent-Date: Mon, 05 Aug 2024 14:37:51 +0200
Resent-Message-ID: <875xsfno0w.fsf@pond.sub.org>
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,  Michael
 Roth <michael.roth@amd.com>
Subject: Re: [PATCH 2/6] scripts/qapi: rename 'special_features' to 'features'
In-Reply-To: <20240801175913.669013-3-berrange@redhat.com> ("Daniel
 P. =?utf-8?Q?Berrang=C3=A9=22's?= message of "Thu, 1 Aug 2024 18:59:09
 +0100")
References: <20240801175913.669013-1-berrange@redhat.com>
 <20240801175913.669013-3-berrange@redhat.com>
Date: Mon, 05 Aug 2024 13:59:52 +0200
Message-ID: <87bk27p4cn.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Have you considered squashing this into the previous patch?

[...]

> diff --git a/scripts/qapi/gen.py b/scripts/qapi/gen.py
> index 6a8abe0041..e6c80cce23 100644
> --- a/scripts/qapi/gen.py
> +++ b/scripts/qapi/gen.py
> @@ -40,10 +40,10 @@
>  from .source import QAPISourceInfo
>=20=20
>=20=20
> -def gen_special_features(features: Sequence[QAPISchemaFeature]) -> str:
> -    special_features =3D [f"1u << QAPI_{feat.name.upper()}"
> -                        for feat in features if feat.is_special()]
> -    return ' | '.join(special_features) or '0'
> +def gen_features(features: Sequence[QAPISchemaFeature]) -> str:
> +    features =3D [f"1u << QAPI_{feat.name.upper()}"
> +                for feat in features if feat.is_special()]
> +    return ' | '.join(features) or '0'

This generates a bitwise or of unsigned operands.  Shouldn't we change
the operands to uint64_t?

>=20=20
>=20=20
>  class QAPIGen:

[...]


