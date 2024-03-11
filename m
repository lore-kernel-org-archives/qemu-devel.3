Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B370C5475B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 13:29:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjfig-0004ym-Uv; Mon, 11 Mar 2024 09:29:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rjfie-0004wR-5I
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 09:29:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rjfic-0005y8-LS
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 09:29:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710163770;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NvsPLZxLOo0hDGdoMNhwDVp1snudMwZWU0E3lxulGjc=;
 b=MqMxd6kjPz+FVv6x6f1iqGKv2/aFx360M+MKXTS96sAtu/1UAHGY/bdn01Bb+rmtOV4ZJA
 hfSe54jdm8WiYlUkbY/pQ21GUi1LR0DYszS0r+zNicrqvna0hIRLCEV6W7UPPFmZAb95P8
 alNwykGu/RU5DXrKvifoinaRHYdKHUQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-144-K30M33plP2WPSzDjWl4-Ew-1; Mon, 11 Mar 2024 09:29:27 -0400
X-MC-Unique: K30M33plP2WPSzDjWl4-Ew-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A9074101CC6D;
 Mon, 11 Mar 2024 13:29:26 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.138])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 516761C060A4;
 Mon, 11 Mar 2024 13:29:26 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4798721E6A24; Mon, 11 Mar 2024 14:29:25 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Daniel P.
 =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Kashyap Chamarthy <kchamart@redhat.com>,
 qemu-devel@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Hanna Czenczek <hreitz@redhat.com>
Subject: Re: [PATCH v3 1/3] docs/interop/firmware.json: add new enum
 FirmwareFormat
In-Reply-To: <20240311-qapi-firmware-json-v3-1-ceea6e35eb4a@linutronix.de>
 ("Thomas =?utf-8?Q?Wei=C3=9Fschuh=22's?= message of "Mon, 11 Mar 2024
 12:46:58 +0100")
References: <20240311-qapi-firmware-json-v3-0-ceea6e35eb4a@linutronix.de>
 <20240311-qapi-firmware-json-v3-1-ceea6e35eb4a@linutronix.de>
Date: Mon, 11 Mar 2024 14:29:25 +0100
Message-ID: <87wmq8sxqi.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.029,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

> Only a small subset of all blockdev drivers make sense for firmware
> images. Introduce and use a new enum to represent this.
>
> This also reduces the dependency of firmware.json on the global qapi
> definitions.
>
> Suggested-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
> ---
>  docs/interop/firmware.json | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
>
> diff --git a/docs/interop/firmware.json b/docs/interop/firmware.json
> index 54a1fc6c1041..0e619e8780e7 100644
> --- a/docs/interop/firmware.json
> +++ b/docs/interop/firmware.json
> @@ -15,7 +15,11 @@
>  ##
>=20=20
>  { 'include' : 'machine.json' }
> -{ 'include' : 'block-core.json' }
> +
> +{ 'pragma': {
> +    'documentation-exceptions': [
> +        'FirmwareFormat'
> +    ] } }

Necessary because ...
>=20=20
>  ##
>  # @FirmwareOSInterface:
> @@ -200,6 +204,16 @@
>               'enrolled-keys', 'requires-smm', 'secure-boot',
>               'verbose-dynamic', 'verbose-static' ] }
>=20=20
> +##
> +# @FirmwareFormat:
> +#
> +# Formats that are supported for firmware images.
> +#

... we don't document the members here.  Documenting them would be
nicer.  We'd do that if we could steal it from BlockdevDriver, but
there's nothing to steal there.

Mere observation; I'm not asking you to come up with documentation
BlockdevDriver doesn't have.

> +# Since: 8.3
> +##
> +{ 'enum': 'FirmwareFormat',
> +  'data': [ 'raw', 'qcow2' ] }

@raw or @file?  Kevin or Hanna, thoughts?

> +
>  ##
>  # @FirmwareFlashFile:
>  #
> @@ -219,7 +233,7 @@
>  ##
>  { 'struct' : 'FirmwareFlashFile',
>    'data'   : { 'filename' : 'str',
> -               'format'   : 'BlockdevDriver' } }
> +               'format'   : 'FirmwareFormat' } }
>=20=20
>=20=20
>  ##


