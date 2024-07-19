Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2765C3DA5D
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2024 12:33:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUmnJ-0002eU-8Y; Fri, 19 Jul 2024 08:33:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sUmnH-0002do-Nf
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 08:33:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sUmnF-0006c4-OX
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 08:33:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721392380;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VScXzdsHXLQdUHdJzn9COIity7kk1bE64nGkQW+ewkE=;
 b=FZnoAm73tWakL715EvqVRWEsRiPuwHoa38wqOJ+Tsh0vfBAPjEIMZ7s7OaNHZdIsQaL/0s
 mPiH/ulBleQrSEjyPXu7AzGs0NIAdoZTy1UNNLy3gbal79bDkg01rESFLCSIg/uOWnbmX5
 NiIeLvmYV63Ubg5jEUAP1YPq/u5ZkcE=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-256-JKFYiAl1PLCEL-ED8txpMg-1; Fri,
 19 Jul 2024 08:32:56 -0400
X-MC-Unique: JKFYiAl1PLCEL-ED8txpMg-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1ECCD1955BF2; Fri, 19 Jul 2024 12:32:54 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.65])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C612E1955F40; Fri, 19 Jul 2024 12:32:53 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7DD6F21E6757; Fri, 19 Jul 2024 14:32:51 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Daniel P.
 =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Kashyap Chamarthy <kchamart@redhat.com>,  Markus
 Armbruster <armbru@redhat.com>,  qemu-devel@nongnu.org,  Kevin Wolf
 <kwolf@redhat.com>,  Hanna Czenczek <hreitz@redhat.com>
Subject: Re: [PATCH v6 2/4] docs/interop/firmware.json: add new enum
 FirmwareArchitecture
In-Reply-To: <20240719-qapi-firmware-json-v6-2-c2e3de390b58@linutronix.de>
 ("Thomas =?utf-8?Q?Wei=C3=9Fschuh=22's?= message of "Fri, 19 Jul 2024
 09:37:23 +0200")
References: <20240719-qapi-firmware-json-v6-0-c2e3de390b58@linutronix.de>
 <20240719-qapi-firmware-json-v6-2-c2e3de390b58@linutronix.de>
Date: Fri, 19 Jul 2024 14:32:51 +0200
Message-ID: <87o76ttvd8.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de> writes:

> Only a small subset of all architectures supported by qemu make use of
> firmware files. Introduce and use a new enum to represent this.
>
> This also removes the dependency to machine.json from the global qapi
> definitions.
>
> Claim "Since: 3.0" for the new enum, because that's correct for most of
> its members, and the members are what matters in the interface.
>
> Suggested-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
> ---
>  docs/interop/firmware.json | 28 ++++++++++++++++++++++++++--
>  1 file changed, 26 insertions(+), 2 deletions(-)
>
> diff --git a/docs/interop/firmware.json b/docs/interop/firmware.json
> index d5d4c17f230b..ae4179994479 100644
> --- a/docs/interop/firmware.json
> +++ b/docs/interop/firmware.json
> @@ -14,7 +14,10 @@
>  # =3D Firmware
>  ##
>=20=20
> -{ 'include' : 'machine.json' }
> +{ 'pragma': {
> +    'member-name-exceptions': [
> +        'FirmwareArchitecture' # x86_64
> +    ] } }
>=20=20
>  ##
>  # @FirmwareOSInterface:
> @@ -59,6 +62,27 @@
>  { 'enum' : 'FirmwareDevice',
>    'data' : [ 'flash', 'kernel', 'memory' ] }
>=20=20
> +##
> +# @FirmwareArchitecture:
> +#
> +# Enumeration of architectures for which Qemu uses additional

QEMU

> +# firmware files.
> +#
> +# @aarch64: 64-bit Arm.
> +#
> +# @arm: 32-bit Arm.
> +#
> +# @i386: 32-bit x86.
> +#
> +# @loongarch64: 64-bit LoongArch. (since: 7.1)
> +#
> +# @x86_64: 64-bit x86.
> +#
> +# Since: 3.0
> +##
> +{ 'enum' : 'FirmwareArchitecture',
> +  'data' : [ 'aarch64', 'arm', 'i386', 'loongarch64', 'x86_64' ] }
> +
>  ##
>  # @FirmwareTarget:
>  #
> @@ -80,7 +104,7 @@
>  # Since: 3.0
>  ##
>  { 'struct' : 'FirmwareTarget',
> -  'data'   : { 'architecture' : 'SysEmuTarget',
> +  'data'   : { 'architecture' : 'FirmwareArchitecture',
>                 'machines'     : [ 'str' ] } }
>=20=20
>  ##

Reviewed-by: Markus Armbruster <armbru@redhat.com>


