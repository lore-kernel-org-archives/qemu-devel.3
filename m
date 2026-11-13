Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82337606A321
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 07:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bbP9ESkz
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRm4g-0005HL-BU; Fri, 13 Nov 2026 02:51:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xRm4K-0005Ff-PD
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 02:51:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xRm4J-0003fE-9I
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 02:51:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794556289;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VmasLtkyrC+9Hd6K4Kv36hfjMv7rXRDDOzXQJIW277Y=;
 b=bbP9ESkzqBlsGhVGw2DdXYX7nwT/V/ZQND+EqtfwGmlHN++B4nssaolbveJqgYEhSGARSa
 sRsHJ1jBpfMFH+Q8xU/Wu0twZ2ToHpzPDdjwIVyszqVOMBeqSGVvrLyBhUxqvuMycMVA4z
 iJMWI0Aghvc055rL3XtYWNpsVOMX4rU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-628-ldYvYRoAOgGM3gd2YkFEIA-1; Fri,
 13 Nov 2026 02:51:23 -0500
X-MC-Unique: ldYvYRoAOgGM3gd2YkFEIA-1
X-Mimecast-MFC-AGG-ID: ldYvYRoAOgGM3gd2YkFEIA_1794556282
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B77AA195609E; Fri, 13 Nov 2026 07:51:21 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.7])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5DB9B195608D; Fri, 13 Nov 2026 07:51:21 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0798521E6A04; Fri, 13 Nov 2026 08:51:19 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@oss.qualcomm.com>,  Pierrick Bouvier
 <pierrick.bouvier@oss.qualcomm.com>,  Yonggang Luo <luoyonggang@gmail.com>
Subject: Re: [PATCH 11/48] qapi: deprecate 'alias' field in MachineInfo
In-Reply-To: <20261112133054.1977618-12-berrange@redhat.com> ("Daniel
 P. =?utf-8?Q?Berrang=C3=A9=22's?= message of "Thu, 12 Nov 2026 13:30:17
 +0000")
References: <20261112133054.1977618-1-berrange@redhat.com>
 <20261112133054.1977618-12-berrange@redhat.com>
Date: Fri, 13 Nov 2026 08:51:18 +0100
Message-ID: <87jymhxj7t.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> It is replaced by the new 'aliases' field.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  docs/about/deprecated.rst | 7 +++++++
>  qapi/machine.json         | 4 +++-
>  2 files changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> index 0891bbc44de..88b21a018f9 100644
> --- a/docs/about/deprecated.rst
> +++ b/docs/about/deprecated.rst
> @@ -182,6 +182,13 @@ execution.  This special treatment of ``"no"`` is de=
precated.  Use an
>  empty string instead.  In a future version, ``"no"`` will be treated as
>  a plain file name.
>=20=20
> +``alias`` field of ``MachineInfo`` (since 12.0)
> +'''''''''''''''''''''''''''''''''''''''''''''''

I prefer to talk about commands and events instead of types here.
Commands and events are what the user cares about.  Types are detail.

Existing notes nearby use "member", not "field".

Together:

   ``query-machines`` return value member ``alias`` (since 12.0)

> +
> +The ``MachineInfo`` struct now has an ``aliases`` field which
> +can report multiple aliases per machine, thus the ``alias``
> +field is now redundant.
> +

We commonly phrase these notes like "don't use this, use that".  Your
note conveys this, but it's not explicit.  Maybe

   Use member ``aliases`` instead.

would suffice.

We should've used a list of aliases from day one.

>  Human Machine Protocol (HMP) commands
>  -------------------------------------
>=20=20
> diff --git a/qapi/machine.json b/qapi/machine.json
> index c25a492a4e8..40fda705462 100644
> --- a/qapi/machine.json
> +++ b/qapi/machine.json
> @@ -199,11 +199,13 @@
>  # Features:
>  #
>  # @unstable: Member @compat-props is experimental.

Blank line, please.

> +# @deprecated: Member @alias is replaced by @aliases.

We commonly phrase this as

   # @deprecated: Member @alias is deprecated.  Use @aliases instead.

>  #
>  # Since: 1.2
>  ##
>  { 'struct': 'MachineInfo',
> -  'data': { 'name': 'str', '*alias': 'str',
> +  'data': { 'name': 'str',
> +            '*alias': { 'type': 'str', 'features': ['deprecated'] },
>              '*aliases': ['str'],
>              '*is-default': 'bool', 'cpu-max': 'int',
>              'hotpluggable-cpus': 'bool',  'numa-mem-supported': 'bool',


