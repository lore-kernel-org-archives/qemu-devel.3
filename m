Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9E9BC54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 13:33:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjfmG-0007uu-Em; Mon, 11 Mar 2024 09:33:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rjfmE-0007sm-7C
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 09:33:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rjfmC-0006mp-NG
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 09:33:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710163991;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cM0gfda+phwi2PSa5XTJzzw5XEsDpRpS3DGdBeFMcs0=;
 b=UPXPc00VOVIIpeyWMsa95qklM/F63RThov1b1I9CGilBzoLnecZBKFA9z0/NkWDcYCgKiN
 +NTe5Fi/bhANgsa0jDXWytZ/fD78y7+xc0pgGh9khmY7IhnAzci4y1QaFApsYtUoqJRH0Z
 jLxX/uBmi8zF+obxYo18frR7Zpq25jQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-491-clU72nVoPQC5OFecxblvEA-1; Mon, 11 Mar 2024 09:33:10 -0400
X-MC-Unique: clU72nVoPQC5OFecxblvEA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8CDCB101A552;
 Mon, 11 Mar 2024 13:33:09 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.138])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6A29E492BC8;
 Mon, 11 Mar 2024 13:33:09 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5CE7621E6A24; Mon, 11 Mar 2024 14:33:08 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Daniel P.
 =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Kashyap Chamarthy <kchamart@redhat.com>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v3 2/3] docs/interop/firmware.json: add new enum
 FirmwareArchitecture
In-Reply-To: <20240311-qapi-firmware-json-v3-2-ceea6e35eb4a@linutronix.de>
 ("Thomas =?utf-8?Q?Wei=C3=9Fschuh=22's?= message of "Mon, 11 Mar 2024
 12:46:59 +0100")
References: <20240311-qapi-firmware-json-v3-0-ceea6e35eb4a@linutronix.de>
 <20240311-qapi-firmware-json-v3-2-ceea6e35eb4a@linutronix.de>
Date: Mon, 11 Mar 2024 14:33:08 +0100
Message-ID: <87sf0wsxkb.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.029,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de> writes:

> Only a small subset of all architectures supported by qemu make use of
> firmware files. Introduce and use a new enum to represent this.
>
> This also removes the dependency of firmware.json on the global qapi
> definitions.
>
> Suggested-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
> ---
>  docs/interop/firmware.json | 20 +++++++++++++++++---
>  1 file changed, 17 insertions(+), 3 deletions(-)
>
> diff --git a/docs/interop/firmware.json b/docs/interop/firmware.json
> index 0e619e8780e7..54cae6a51b43 100644
> --- a/docs/interop/firmware.json
> +++ b/docs/interop/firmware.json
> @@ -14,11 +14,13 @@
>  # =3D Firmware
>  ##
>=20=20
> -{ 'include' : 'machine.json' }
> -
>  { 'pragma': {
>      'documentation-exceptions': [
> +        'FirmwareArchitecture',

Comment on the previous patch applies.

>          'FirmwareFormat'
> +    ],
> +    'member-name-exceptions': [
> +        'FirmwareArchitecture'

Needed for x86_64.  Fine.

>      ] } }
>=20=20
>  ##
> @@ -64,6 +66,18 @@
>  { 'enum' : 'FirmwareDevice',
>    'data' : [ 'flash', 'kernel', 'memory' ] }
>=20=20
> +##
> +# @FirmwareArchitecture:
> +#
> +# Enumerations of architectures for which Qemu uses additional firmware =
files.
> +# The values are a subset of the enum SysEmuTarget.
> +#
> +# Since: 8.3
> +##
> +{ 'enum' : 'FirmwareArchitecture',
> +  'data' : [ 'aarch64', 'arm', 'i386', 'loongarch64', 'x86_64' ] }
> +
> +
>  ##
>  # @FirmwareTarget:
>  #
> @@ -85,7 +99,7 @@
>  # Since: 3.0
>  ##
>  { 'struct' : 'FirmwareTarget',
> -  'data'   : { 'architecture' : 'SysEmuTarget',
> +  'data'   : { 'architecture' : 'FirmwareArchitecture',
>                 'machines'     : [ 'str' ] } }
>=20=20
>  ##


