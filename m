Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CC86C369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 05:56:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u76bc-0008F7-6f; Tue, 22 Apr 2025 01:55:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1u76bb-0008Ex-1m
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 01:55:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1u76bY-0002cL-BE
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 01:55:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745301333;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cTafbxJg7gX2PgTxz4B6WM7mGAortUBwjXGoLWqwtC0=;
 b=BUTuxfQQGizdS9XUvd50puPm7obb2c6AsBJFjTvIVeCr5DcmMsGrIXbb3whnUcyuEglYW0
 UKwWlchQ+NwOn2uD4IWT/LQWQQRQRmrBbRhRd0tc5euSOn7W6l52RJtIN8fjG/qELk3smN
 qdUgQtaA1iQl16PFNkpEPkfxJLtm4tc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-643-1h_CNd8xOcCHPFJt2gHcJg-1; Tue,
 22 Apr 2025 01:55:29 -0400
X-MC-Unique: 1h_CNd8xOcCHPFJt2gHcJg-1
X-Mimecast-MFC-AGG-ID: 1h_CNd8xOcCHPFJt2gHcJg_1745301328
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 56D131800264; Tue, 22 Apr 2025 05:55:27 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.5])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C8D331800947; Tue, 22 Apr 2025 05:55:25 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 743B021E6768; Tue, 22 Apr 2025 07:55:23 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,  Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,  Anton Johansson
 <anjo@rev.ng>
Subject: Re: [RFC PATCH v3 01/14] qapi: Rename TargetInfo structure as
 BinaryTargetInfo
In-Reply-To: <20250418172908.25147-2-philmd@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Fri, 18 Apr 2025 19:28:55
 +0200")
References: <20250418172908.25147-1-philmd@linaro.org>
 <20250418172908.25147-2-philmd@linaro.org>
Date: Tue, 22 Apr 2025 07:55:23 +0200
Message-ID: <878qnsagfo.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.692,
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> The QAPI-generated 'TargetInfo' structure name is only used
> in a single file. We want to heavily use another structure
> similarly named. Rename the QAPI one, since structure names
> are not part of the public API.
>
> Suggested-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>  qapi/machine.json          | 12 ++++++------
>  hw/core/machine-qmp-cmds.c |  4 ++--
>  2 files changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/qapi/machine.json b/qapi/machine.json
> index a6b8795b09e..3246212f048 100644
> --- a/qapi/machine.json
> +++ b/qapi/machine.json
> @@ -275,15 +275,15 @@
>  { 'command': 'query-current-machine', 'returns': 'CurrentMachineParams' }
>=20=20
>  ##
> -# @TargetInfo:
> +# @BinaryTargetInfo:
>  #
> -# Information describing the QEMU target.
> +# Information describing the QEMU binary target.

What's "the QEMU binary target"?  The QEMU binary's target?

From the QMP user's point of view, perhaps "the QEMU process's target"
would make more sense.

>  #
> -# @arch: the target architecture
> +# @arch: the binary target architecture

Are there non-binary target architectures?

>  #
>  # Since: 1.2
>  ##
> -{ 'struct': 'TargetInfo',
> +{ 'struct': 'BinaryTargetInfo',
>    'data': { 'arch': 'SysEmuTarget' } }
>=20=20
>  ##
> @@ -291,11 +291,11 @@
>  #
>  # Return information about the target for this QEMU
>  #
> -# Returns: TargetInfo
> +# Returns: BinaryTargetInfo
>  #
>  # Since: 1.2
>  ##
> -{ 'command': 'query-target', 'returns': 'TargetInfo' }
> +{ 'command': 'query-target', 'returns': 'BinaryTargetInfo' }
>=20=20
>  ##
>  # @UuidInfo:
> diff --git a/hw/core/machine-qmp-cmds.c b/hw/core/machine-qmp-cmds.c
> index 3130c5cd456..408994b67d7 100644
> --- a/hw/core/machine-qmp-cmds.c
> +++ b/hw/core/machine-qmp-cmds.c
> @@ -132,9 +132,9 @@ CurrentMachineParams *qmp_query_current_machine(Error=
 **errp)
>      return params;
>  }
>=20=20
> -TargetInfo *qmp_query_target(Error **errp)
> +BinaryTargetInfo *qmp_query_target(Error **errp)
>  {
> -    TargetInfo *info =3D g_malloc0(sizeof(*info));
> +    BinaryTargetInfo *info =3D g_malloc0(sizeof(*info));
>=20=20
>      info->arch =3D qapi_enum_parse(&SysEmuTarget_lookup, target_name(), =
-1,
>                                   &error_abort);


